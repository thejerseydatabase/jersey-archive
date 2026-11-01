-- Merges the 5 genuine accidental duplicates your find_duplicate_teams.sql
-- run turned up - each pair is the SAME real-world club entered twice:
-- an empty seed row from mid-September, and a second row auto-created
-- later (via ensureTeam, when someone uploaded a jersey and the slug
-- didn't happen to match the seeded one) that actually has the jerseys
-- on it. Keeps whichever row has the real content, reassigns anything
-- pointing at the empty one, then deletes it.
--
--   Adelaide City      (npl-south-australia): keep adelaide-city, drop adelaide-city-npl
--   South Melbourne    (npl-victoria):        keep south-melbourne, drop south-melbourne-npl
--   Chelsea FC         (premier-league):      keep chelsea-fc, drop chelsea
--   Hull City AFC      (premier-league):      keep hull-city-afc, drop hull-city
--   Hull Kingston Rovers (super-league):      keep hull-kingston-rovers, drop hull-kr
--
-- NOT included: the ~13 NTFA pairs (Bridgenorth, Deloraine, etc.) - those
-- aren't duplicates, they're the men's AND women's team sharing the exact
-- same name ("Bridgenorth" for both), which is a different, separate
-- naming problem - see ntfa_women_naming.sql.
--
-- Safe to re-run (each merge is a no-op once the old row is already gone).

do $$
declare
  pairs uuid[][] := array[
    array['dcc2ad15-1b86-4d35-a239-1dbfeb800db1'::uuid, 'a4ddcd0a-edf1-40d3-a88f-9a85d40b9dce'::uuid], -- Hull City AFC
    array['ae28c744-8496-496e-b651-ff624aafe2f5'::uuid, '382e1b38-119a-427c-aee8-dab0dac7b0dc'::uuid], -- Chelsea FC
    array['ace7e6b8-ac64-4adb-8879-99a3c9f6f7d0'::uuid, '9168ff2e-bfd6-42c8-a8bb-cc20d9980bfd'::uuid], -- Hull Kingston Rovers
    array['bbfb5aee-3513-4ca5-921a-7a1adce4e012'::uuid, '5d2f0e85-91c3-4888-9c92-aaf934d7b894'::uuid], -- Adelaide City
    array['5d63aa3f-d88b-40f8-9c3b-856ddfa422bd'::uuid, 'f0ac8364-5683-4cf4-b6d9-f31246f57218'::uuid]  -- South Melbourne
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
