-- Adds the A-League (Australia) and its 13 clubs, including Western
-- United which folded — added as is_active = false so it still shows
-- under "Former teams" on the competition page. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('a-league','football','A-League','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('adelaide-united','a-league','Adelaide United','#DA291C','#002554', true),
  ('auckland-fc','a-league','Auckland FC','#5C2D91','#000000', true),
  ('brisbane-roar','a-league','Brisbane Roar','#F7941D','#000000', true),
  ('central-coast-mariners','a-league','Central Coast Mariners','#FFD200','#002B5C', true),
  ('macarthur-fc','a-league','Macarthur FC','#002D5C','#00A99D', true),
  ('melbourne-city','a-league','Melbourne City','#6CADDF','#00285E', true),
  ('melbourne-victory','a-league','Melbourne Victory','#002B5C','#7EBFE8', true),
  ('newcastle-jets','a-league','Newcastle Jets','#E4032E','#002554', true),
  ('perth-glory','a-league','Perth Glory','#7B2D8E','#F7941D', true),
  ('sydney-fc','a-league','Sydney FC','#4EC3E0','#002B5C', true),
  ('wellington-phoenix','a-league','Wellington Phoenix','#FFD200','#000000', true),
  ('western-sydney-wanderers','a-league','Western Sydney Wanderers','#E4032E','#000000', true),
  ('western-united','a-league','Western United','#1B5E3A','#000000', false)
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, is_active = excluded.is_active;
