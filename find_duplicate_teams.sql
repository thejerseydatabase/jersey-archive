-- Read-only check, not a migration - run this and send me the results.
-- Lists teams that share the same name within the same competition (the
-- Hull City AFC / Chelsea FC situation) - a genuine duplicate, not two
-- different clubs that happen to share a name across different
-- competitions. Shows each duplicate's id, colors, and jersey/logo
-- counts so I can tell which copy is the "real" one to keep (normally
-- whichever has jerseys/logos already on it) before writing a merge
-- migration - don't want to guess and merge the wrong way round.

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
