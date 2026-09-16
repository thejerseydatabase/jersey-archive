-- Part 1 (safe, run this): renames every team whose name ends in "WFC"
-- (Melbourne City WFC -> Melbourne City Women, etc.) so it matches the
-- "<Team> Women" convention already used elsewhere (A-League Women,
-- AFLW, Super Rugby Pacific Women...). Only touches the display name,
-- never the slug, so no links break. Safe to re-run.

update teams
set name = regexp_replace(name, '\s+WFC$', ' Women', 'i')
where name ~* '\s+WFC$';


-- Part 2 (read-only — just for review): lists every team in a competition
-- whose name suggests it's a women's team (its competition name contains
-- "Women") but doesn't already end in "Women". Run this and send me the
-- results — I'll turn it into an exact rename migration rather than
-- guessing team-by-team blind.

select t.name as team_name, c.name as competition_name, c.slug as competition_slug
from teams t
join competitions c on c.slug = t.competition_slug
where c.name ilike '%women%'
  and t.name !~* '\bwomen\b'
order by c.name, t.name;


-- Part 3 (read-only — just for review): lists every sport that currently
-- has separate men's/open and women's *international* competitions, so
-- we can confirm before merging them into one "International" competition
-- with women's teams suffixed "Women" (as discussed) — this one's
-- structural (moves teams, deletes the now-empty competition) so I want
-- your go-ahead on the exact list before writing that migration. Send me
-- the results.

select s.name as sport, c.slug, c.name, c.tier,
  (select count(*) from teams t where t.competition_slug = c.slug) as team_count
from competitions c
join sports s on s.slug = c.sport_slug
where c.name ilike '%international%'
order by s.name, c.name;
