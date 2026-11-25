-- Adds the League of Ireland Premier Division as a top-tier football
-- competition, with its 10 teams for the 2026 season
-- (https://en.wikipedia.org/wiki/2026_League_of_Ireland_Premier_Division).
-- The League of Ireland First Division (the tier below) already
-- existed with its own, separate team list - none of these 10 clashed
-- with it.
--
-- Colors: none of these 10 clubs' Wikipedia infoboxes have a
-- Colours/Colors field - these are drawn from each page's body text/
-- nickname instead (e.g. Dundalk's "Lilywhites" nickname -> white/
-- black, Galway's "Maroon Army" -> maroon/sky blue, Drogheda's
-- "Claret and Blue Army" -> claret/blue). Waterford's blue/white
-- comes from an unverified page summary rather than confirmed body
-- text - double-check/replace any of these if you know the real kit
-- colors.
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('league-of-ireland-premier-division','football','League of Ireland Premier Division','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('shamrock-rovers','league-of-ireland-premier-division','Shamrock Rovers','#00843D','#FFFFFF'),
  ('bohemians','league-of-ireland-premier-division','Bohemians','#C8102E','#000000'),
  ('st-patricks-athletic','league-of-ireland-premier-division','St Patrick''s Athletic','#C8102E','#FFFFFF'),
  ('shelbourne','league-of-ireland-premier-division','Shelbourne','#C8102E','#FFFFFF'),
  ('derry-city','league-of-ireland-premier-division','Derry City','#C8102E','#FFFFFF'),
  ('dundalk','league-of-ireland-premier-division','Dundalk','#FFFFFF','#000000'),
  ('waterford','league-of-ireland-premier-division','Waterford','#002868','#FFFFFF'),
  ('galway-united','league-of-ireland-premier-division','Galway United','#6F1D32','#4FC3E8'),
  ('drogheda-united','league-of-ireland-premier-division','Drogheda United','#7A1F3D','#002868'),
  ('sligo-rovers','league-of-ireland-premier-division','Sligo Rovers','#C8102E','#FFFFFF')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
