-- Follow-up to the Super Rugby Pacific country backfill. In every
-- International/Sevens competition (confirmed via
-- find_international_sevens_teams.sql), the team's own name already IS
-- the country - with a trailing " Women" on the women's side - so this
-- is one general rule, not a guess per country.
--
-- Two deliberate exceptions, left blank just like Moana Pasifika and the
-- rugby league "representative" competitions: West Indies (cricket,
-- rugby league) and Haudenosaunee (lacrosse's Six Nations/Iroquois
-- Confederacy team) both represent several nations/peoples at once, not
-- a single country.
--
-- "England C" (football's semi-pro representative side) is still
-- England, so that one's normalized rather than left as its own
-- "country".
--
-- Doesn't try to unify spelling variants of the same real country across
-- different sports (Czech Republic vs Czechia, Turkey vs Türkiye, Hong
-- Kong vs "Hong Kong, China", etc.) - harmless for now since nothing
-- live reads this column yet, but worth a proper lookup table instead of
-- a regex fix whenever the Countries/Regions feature actually gets
-- built on top of this.
--
-- Safe to re-run (only touches rows that are still null).

update teams
set country = regexp_replace(name, '\s+Women$', '')
where competition_slug in (
  'international-baseball-men','international-basketball-men','international',
  'international-field-hockey-men','international-men','international-ice-hockey-men',
  'international-lacrosse','international-lacrosse-women','international-netball',
  'international-rugby-league-men','international-rugby-union-men',
  'rugby-sevens-men','rugby-sevens-women','international-volleyball-men'
)
and country is null
and name not in ('West Indies', 'West Indies Women', 'Haudenosaunee');

update teams set country = 'England' where name = 'England C';

-- verify - anything still null here (besides West Indies/Haudenosaunee,
-- which are expected) is worth a look.
select competition_slug, name from teams
where competition_slug in (
  'international-baseball-men','international-basketball-men','international',
  'international-field-hockey-men','international-men','international-ice-hockey-men',
  'international-lacrosse','international-lacrosse-women','international-netball',
  'international-rugby-league-men','international-rugby-union-men',
  'rugby-sevens-men','rugby-sevens-women','international-volleyball-men'
)
and country is null
order by competition_slug, name;
