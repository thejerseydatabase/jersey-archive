-- Adds Hockey One, Australia's domestic field hockey league, with its 8
-- clubs fielding both a men's and women's team each (16 team rows total) -
-- same "X Women" suffix convention already used for field hockey's
-- International competition after its own gender-merge, rather than a
-- separate competition per gender like some other sports use.
--
-- Colors: from Wikipedia/club sourcing where available - HC Melbourne
-- (black/white with gold), NSW Pride (gold/red), Brisbane Blaze (burnt
-- orange/yellow) and Perth Thundersticks (WA's traditional black/gold/
-- white) are solid. Adelaide Fire, Canberra Chill, Tassie Tigers and
-- Melbourne Cobras (the newest club, joining for the 2026 season) are
-- lower-confidence placeholders - no official palette turned up in
-- searching, so these are reasonable guesses based on club
-- name/branding themes. Flag any of these that are off and I'll fix
-- them.
--
-- tier/sort_order: set as the clear flagship domestic competition for
-- this sport, same treatment as NRL/NBA/BBL/etc. get elsewhere.
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier, sort_order) values
  ('hockey-one','field-hockey','Hockey One','top',1)
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adelaide-fire','hockey-one','Adelaide Fire','#C8102E','#FFFFFF'),
  ('brisbane-blaze','hockey-one','Brisbane Blaze','#CC5500','#FFD700'),
  ('canberra-chill','hockey-one','Canberra Chill','#00AEEF','#FFFFFF'),
  ('hc-melbourne','hockey-one','HC Melbourne','#000000','#FFD700'),
  ('melbourne-cobras','hockey-one','Melbourne Cobras','#00843D','#FFFFFF'),
  ('nsw-pride','hockey-one','NSW Pride','#FFD700','#CE1126'),
  ('perth-thundersticks','hockey-one','Perth Thundersticks','#000000','#FFD700'),
  ('tassie-tigers','hockey-one','Tassie Tigers','#F57F17','#000000'),
  ('adelaide-fire-women','hockey-one','Adelaide Fire Women','#C8102E','#FFFFFF'),
  ('brisbane-blaze-women','hockey-one','Brisbane Blaze Women','#CC5500','#FFD700'),
  ('canberra-chill-women','hockey-one','Canberra Chill Women','#00AEEF','#FFFFFF'),
  ('hc-melbourne-women','hockey-one','HC Melbourne Women','#000000','#FFD700'),
  ('melbourne-cobras-women','hockey-one','Melbourne Cobras Women','#00843D','#FFFFFF'),
  ('nsw-pride-women','hockey-one','NSW Pride Women','#FFD700','#CE1126'),
  ('perth-thundersticks-women','hockey-one','Perth Thundersticks Women','#000000','#FFD700'),
  ('tassie-tigers-women','hockey-one','Tassie Tigers Women','#F57F17','#000000')
on conflict (competition_slug, slug) do nothing;
