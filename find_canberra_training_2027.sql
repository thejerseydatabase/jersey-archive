-- Read-only check, not a migration - run this and send me the results.
-- Shows every 2027 jersey logged against any team called "Canberra
-- Raiders" (there are now 5, one per rugby league competition added
-- this session - NRL, Holden Cup, Jersey Flegg Cup, S.G. Ball Cup,
-- Harold Matthews Cup), what competition each jersey is actually
-- tagged with, and its status - to see exactly where the training
-- jerseys ended up instead of NRL.

select j.id, j.season, j.type, j.status, j.competition_slug as jersey_tagged_as,
  t.slug as team_slug, t.competition_slug as team_home_competition
from jerseys j
join teams t on t.id = j.team_id
where t.name = 'Canberra Raiders' and j.season = '2027'
order by j.created_at;
