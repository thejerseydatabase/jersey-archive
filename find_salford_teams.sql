-- Read-only check, not a migration - run this and send me the results.
-- Looking for every team with "salford" in the name/slug, across every
-- competition, so I can correctly rename the old Super League club to
-- "Salford Red Devils" and add/confirm the new post-administration
-- "Salford RLFC" Championship club without guessing or duplicating.

select t.id, t.slug, t.name, t.competition_slug, c.name as competition_name,
  (select count(*) from jerseys j where j.team_id = t.id) as jersey_count
from teams t
join competitions c on c.slug = t.competition_slug
where t.slug ilike '%salford%' or t.name ilike '%salford%'
order by c.name, t.name;
