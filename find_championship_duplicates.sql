-- Read-only check, not a migration - run this and send me the results.
-- Same duplicate-name check as find_duplicate_teams.sql, but I want to
-- confirm the full extent of it - renaming a team's name via SQL without
-- also updating its slug means the next upload that types/picks the new
-- full name (e.g. "Hunslet RLFC") generates a different slug
-- ("hunslet-rlfc") than the existing row ("hunslet"), so the team search
-- doesn't find a match and silently creates a brand new team instead of
-- reusing the real one. This is what caused the Barrow Raiders and
-- Hunslet RLFC duplicates you spotted - checking whether it's happened
-- anywhere else too, this session's other renames included.

select
  t.id, t.slug, t.name, t.competition_slug, t.primary_color, t.secondary_color,
  (select count(*) from jerseys j where j.team_id = t.id) as jersey_count,
  (select count(*) from team_logos l where l.team_id = t.id) as logo_count,
  t.created_at
from teams t
where (t.competition_slug, lower(t.name)) in (
  select competition_slug, lower(name) from teams group by competition_slug, lower(name) having count(*) > 1
)
order by t.competition_slug, lower(t.name), t.created_at;
