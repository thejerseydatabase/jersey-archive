-- Fills in region_group for the top-tier competitions check_missing_region_group.sql
-- found still unset - the obvious single-country ones, plus a small
-- set that need a default country PLUS named per-team overrides for
-- the handful of teams from a different country.
--
-- Left alone on purpose (see achievements.sql follow-up discussion):
--   - super-rugby-pacific / super-rugby-pacific-women: no majority
--     country (Australian/NZ/Fijian/Pacific Islands teams in close to
--     even numbers) - better resolved entirely at team level than
--     given a misleading competition-level default.
--   - rugby-league's "representative" competition: not sure yet what
--     this actually covers, so no guess made.
--   - every "International"/Sevens competition: these need no
--     competition-level country at all, since each team already IS a
--     country - that gets set on the team row instead, in a follow-up
--     once the actual team names are confirmed.
--
-- Safe to re-run.

-- ============ single-country, no overrides needed ============
update competitions set region_group = 'Australia' where slug in (
  'afl','aflw','nbl','wnbl','nbl1','bbl','wbbl','hockey-one',
  'australia-cup','australian-championship','super-netball','state-of-origin','avl'
);
update competitions set region_group = 'USA' where slug in (
  'nfl','mlb','nba','wnba','nwsl','ncaa-division-i-lacrosse'
);
update competitions set region_group = 'England' where slug in (
  'the-hundred','premier-league','netball-super-league','premiership-rugby'
);
update competitions set region_group = 'Germany' where slug = 'bundesliga';
update competitions set region_group = 'Spain' where slug = 'la-liga';
update competitions set region_group = 'India' where slug = 'ipl';
update competitions set region_group = 'Ireland' where slug = 'all-ireland-senior-football-championship';
update competitions set region_group = 'New Zealand' where slug = 'anz-premiership';

-- ============ default country + named team-level overrides ============
-- teams.country overrides the competition's own region_group when set -
-- resolve a jersey's effective country as coalesce(team.country, that
-- team's competition's region_group).
alter table teams add column if not exists country text;

update competitions set region_group = 'Australia' where slug in ('a-league','a-league-women');
update teams set country = 'New Zealand'
  where competition_slug in ('a-league','a-league-women') and name ilike '%phoenix%';

update competitions set region_group = 'USA' where slug = 'mls';
update teams set country = 'Canada'
  where competition_slug = 'mls'
  and (name ilike '%toronto%' or name ilike '%montr%' or name ilike '%vancouver%whitecaps%');

update competitions set region_group = 'Australia' where slug in ('nrl','nrlw');
update teams set country = 'New Zealand'
  where competition_slug in ('nrl','nrlw') and name ilike '%warriors%';

update competitions set region_group = 'England' where slug = 'super-league';
update teams set country = 'France'
  where competition_slug = 'super-league' and name ilike '%catalans%';

update competitions set region_group = 'USA' where slug = 'nhl';
update teams set country = 'Canada'
  where competition_slug = 'nhl' and (
    name ilike '%maple leafs%' or name ilike '%canadiens%' or name ilike '%senators%'
    or name ilike '%jets%' or name ilike '%flames%' or name ilike '%oilers%' or name ilike '%canucks%'
  );

-- ============ verify ============
-- Check the overrides actually matched something (a 0 here means the
-- stored team name doesn't match the pattern guessed above - rename
-- the ilike pattern to the real name and re-run that one line).
select competition_slug, name, country from teams where country is not null order by competition_slug, name;
