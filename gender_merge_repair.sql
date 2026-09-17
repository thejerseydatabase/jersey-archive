-- Repairs two problems from the original international gender-merge
-- (international_gender_merge.sql):
--
-- 1. "Women Women" duplicate names/slugs. The original merge did one bulk
--    UPDATE per sport to move every women's-competition team across and
--    rename it. A bulk UPDATE is all-or-nothing in Postgres — if even one
--    row in that batch hit a problem, the whole statement (that whole
--    sport's batch) would fail. If that happened after an earlier partial
--    attempt had already renamed some rows, a later successful run could
--    rename an already-"X Women" row a second time, producing "X Women
--    Women". This pass collapses any such repeat back to a single
--    "Women", for name and slug, across every sport (not just football) —
--    scoped only to rows that actually have the duplicate.
--
-- 2. Teams left stranded. Because teams.competition_slug is
--    "on delete cascade", if a women's competition's teams didn't all
--    finish moving before its competitions row got deleted, any team
--    still pointing at it would be cascade-deleted along with the
--    competition — which would explain a team (e.g. Brazil's women's
--    side) simply vanishing rather than ending up misnamed. This
--    re-runs a safer version of the merge for all 5 sports pairs
--    (baseball, basketball, football, ice hockey, rugby league): each
--    women's team is moved with its own INSERT ... ON CONFLICT DO
--    NOTHING (so one problem row can only skip itself, never abort the
--    rest), then anything left over under the old competition is
--    cleared out. Safe to re-run — every step is a no-op once done.

-- ============ 1. Collapse duplicate "Women Women" name/slug ============
update teams
set name = regexp_replace(name, '(\s+Women)+$', ' Women', 'i'),
    slug = regexp_replace(slug, '(-women)+$', '-women', 'i')
where name ~* 'Women\s+Women'
  and not exists (
    select 1 from teams t2
    where t2.competition_slug = teams.competition_slug
      and t2.slug = regexp_replace(teams.slug, '(-women)+$', '-women', 'i')
      and t2.id <> teams.id
  );

-- ============ 2. Re-run a safer version of the merge, all 5 sports ============
do $$
declare
  pair record;
begin
  for pair in select * from (values
    ('international-baseball-women', 'international-baseball-men'),
    ('international-basketball-women', 'international-basketball-men'),
    ('international-women', 'international-men'),
    ('international-ice-hockey-women', 'international-ice-hockey-men'),
    ('international-rugby-league-women', 'international-rugby-league-men')
  ) as p(women_slug, men_slug)
  loop
    if exists (select 1 from competitions where slug = pair.women_slug) then
      insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, is_upcoming, history_note, formats)
      select
        case when name !~* '\bwomen\b' then slug || '-women' else slug end,
        pair.men_slug,
        case when name !~* '\bwomen\b' then name || ' Women' else name end,
        primary_color, secondary_color, is_active, is_upcoming, history_note, formats
      from teams
      where competition_slug = pair.women_slug
      on conflict (competition_slug, slug) do nothing;

      delete from teams where competition_slug = pair.women_slug;
      delete from competitions where slug = pair.women_slug;
      update competitions set name = 'International' where slug = pair.men_slug;
    end if;
  end loop;
end $$;
