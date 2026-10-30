-- Adds the remaining AWIHL teams (ice_hockey_australia_and_international.sql
-- already had Melbourne Ducks, Perth Inferno, Sydney Sirens) and the
-- New Zealand Women's Ice Hockey League as a new competition, with its
-- current roster and one former team.
--
-- Brisbane Lightning and Melbourne Ice already exist as men's AIHL
-- teams - these are separate rows under awihl instead (same club,
-- same colors, different competition), not a conflict with the
-- existing men's entries.
--
-- Colors: Adelaide Rush, Wakatipu Wild and Auckland Steel confirmed via
-- Wikipedia/Elite Prospects. Canterbury Inferno, Dunedin Thunder and
-- the former Southern Storm had no confirmed official colors
-- findable - these are reasonable name-themed placeholders only
-- (Inferno red/orange, Thunder/Storm grey-blue), not verified, so
-- double-check/replace if you know the real ones.
--
-- Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adelaide-rush','awihl','Adelaide Rush','#002664','#CE1126'),
  ('brisbane-lightning','awihl','Brisbane Lightning','#5C2D91','#FFD700'),
  ('melbourne-ice','awihl','Melbourne Ice','#003893','#FFFFFF')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into competitions (slug, sport_slug, name, tier, region_group) values
  ('nzwihl','ice-hockey','NZWIHL','more','New Zealand')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('auckland-steel','nzwihl','Auckland Steel','#003893','#FFFFFF'),
  ('canterbury-inferno','nzwihl','Canterbury Inferno','#CE1126','#F57F17'),
  ('dunedin-thunder','nzwihl','Dunedin Thunder','#002664','#808080'),
  ('wakatipu-wild','nzwihl','Wakatipu Wild','#FFD700','#003893')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

-- Former team - shows under "Former teams" on the competition page (see
-- teams.is_active in schema.sql), not deleted from the site entirely.
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('southern-storm','nzwihl','Southern Storm','#536971','#002664',false)
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, is_active = excluded.is_active;
