-- Merges the 5 duplicate pairs find_championship_duplicates.sql turned
-- up. All 5 are the same underlying bug (see the ensureTeam fix just
-- shipped): a team's slug and its current display name drifted apart -
-- either from a one-off SQL rename (Hunslet RLFC, today) or from an
-- earlier upload that typed the full name before the row existed under
-- that name at all (Barrow Raiders, back in September; the 3 A-League
-- Women ones look like the same story, pre-dating this session).
--
-- In each pair, keeps whichever row's slug already matches slugify() of
-- the team's current name - the row any future upload will actually
-- find - migrates jerseys from the other one onto it, and copies across
-- the real brand colors where the surviving row had the generic
-- auto-generated (hsl(...)) placeholder ones. Barrow Raiders needed no
-- color fix - the surviving row already had the real colors.
--
--   Newcastle Jets Women        (a-league-women): keep newcastle-jets-women,        drop newcastle-jets-fc-women,        colors -> #E4032E/#002554
--   Perth Glory Women           (a-league-women): keep perth-glory-women,           drop perth-glory-fc-women,           colors -> #7B2D8E/#F7941D
--   Western Sydney Wanderers Women (a-league-women): keep western-sydney-wanderers-women, drop western-sydney-wanderers-wfc, colors -> #E4032E/#000000
--   Barrow Raiders               (championship):    keep barrow-raiders,            drop barrow
--   Hunslet RLFC                 (championship):    keep hunslet-rlfc,              drop hunslet,  colors -> #00693E/#FFD700
--
-- Safe to re-run (each merge is a no-op once the old row is already gone).

do $$
declare
  pairs uuid[][] := array[
    array['7bfe84e7-0299-469b-9eec-970bfa6e6553'::uuid, 'db7da541-0e46-4ead-9b97-0c7b1c5cbf71'::uuid], -- Newcastle Jets Women
    array['43069daf-dea5-4efd-bc51-878fa478df56'::uuid, '332f6f14-8a29-4e8b-9ce7-b6d840515675'::uuid], -- Perth Glory Women
    array['0106cebb-3839-4899-bcb7-56be26f271a2'::uuid, '6c0f80f1-8a5a-48ad-a3a4-96088dca1755'::uuid], -- Western Sydney Wanderers Women
    array['b16d58de-f650-42a4-9aec-38f5f3a028a4'::uuid, '8ebfd5be-e379-4791-843d-50bcbaac83b2'::uuid], -- Barrow Raiders
    array['1acd38ad-3eff-47a6-a219-007b8df8dc90'::uuid, '53cde690-2cb0-468b-b8f9-b274e6430a1b'::uuid]  -- Hunslet RLFC
  ];
  pair uuid[];
  old_id uuid;
  keep_id uuid;
begin
  foreach pair slice 1 in array pairs loop
    old_id := pair[1];
    keep_id := pair[2];
    update jerseys set team_id = keep_id where team_id = old_id;
    update team_logo_proposals set team_id = keep_id where team_id = old_id;
    update team_logos set team_id = keep_id where team_id = old_id;
    delete from teams where id = old_id;
  end loop;
end $$;

update teams set primary_color = '#E4032E', secondary_color = '#002554' where id = 'db7da541-0e46-4ead-9b97-0c7b1c5cbf71';
update teams set primary_color = '#7B2D8E', secondary_color = '#F7941D' where id = '332f6f14-8a29-4e8b-9ce7-b6d840515675';
update teams set primary_color = '#E4032E', secondary_color = '#000000' where id = '6c0f80f1-8a5a-48ad-a3a4-96088dca1755';
update teams set primary_color = '#00693E', secondary_color = '#FFD700' where id = '53cde690-2cb0-468b-b8f9-b274e6430a1b';

-- verify - should return no rows
select t.id, t.slug, t.name, t.competition_slug
from teams t
where (t.competition_slug, lower(t.name)) in (
  select competition_slug, lower(name) from teams group by competition_slug, lower(name) having count(*) > 1
)
and t.id not in (
  select id from teams t2 where t2.slug like '%-w' or t2.slug like 'ntfa-%'
)
order by t.competition_slug, lower(t.name);
