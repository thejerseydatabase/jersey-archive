-- Read-only check, not a migration - run this and send me the results.
-- Lists every team under a competition whose name suggests each team IS
-- a country (International, Sevens, World Cup-style) so I can see the
-- actual naming pattern used (e.g. "Australia", "Australia Sevens",
-- "Australia Rugby Sevens") before writing the real country-backfill
-- migration - rather than guessing and getting it wrong across however
-- many teams this covers.

select c.sport_slug, c.slug as competition_slug, c.name as competition_name, t.name as team_name
from teams t
join competitions c on c.slug = t.competition_slug
where c.name ilike '%international%' or c.name ilike '%sevens%' or c.slug ilike '%sevens%'
order by c.sport_slug, c.slug, t.name;
