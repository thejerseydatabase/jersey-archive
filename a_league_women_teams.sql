-- Adds the A-League Women (Australia) and its 12 clubs, including Western
-- United Women which folded alongside the men's side — added as
-- is_active = false so it shows under "Former teams". Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('a-league-women','football','A-League Women','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('canberra-united-fc','a-league-women','Canberra United FC','#00A99D','#FFFFFF', true),
  ('sydney-fc-women','a-league-women','Sydney FC Women','#4EC3E0','#002B5C', true),
  ('newcastle-jets-fc-women','a-league-women','Newcastle Jets FC Women','#E4032E','#002554', true),
  ('western-sydney-wanderers-wfc','a-league-women','Western Sydney Wanderers WFC','#E4032E','#000000', true),
  ('wellington-phoenix-women','a-league-women','Wellington Phoenix Women','#FFD200','#000000', true),
  ('adelaide-united-women','a-league-women','Adelaide United Women','#DA291C','#002554', true),
  ('melbourne-city-wfc','a-league-women','Melbourne City WFC','#6CADDF','#00285E', true),
  ('brisbane-roar-wfc','a-league-women','Brisbane Roar WFC','#F7941D','#000000', true),
  ('melbourne-victory-women','a-league-women','Melbourne Victory Women','#002B5C','#7EBFE8', true),
  ('perth-glory-fc-women','a-league-women','Perth Glory FC Women','#7B2D8E','#F7941D', true),
  ('central-coast-mariners-women','a-league-women','Central Coast Mariners Women','#FFD200','#002B5C', true),
  ('western-united-women','a-league-women','Western United Women','#1B5E3A','#000000', false)
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, is_active = excluded.is_active;
