-- Read-only check, not a migration - run this and send me the results.
-- Broader than the last one: any jersey of a "Training"-ish type for
-- any team with "canberra" in the name, regardless of season or exact
-- team name match - in case the season was entered slightly
-- differently than "2027", or it landed under a different team.

select j.id, j.season, j.type, j.status, j.competition_slug as jersey_tagged_as,
  t.name as team_name, t.slug as team_slug, t.competition_slug as team_home_competition,
  j.created_at
from jerseys j
join teams t on t.id = j.team_id
where t.name ilike '%canberra%' and j.type ilike '%training%'
order by j.created_at desc;
