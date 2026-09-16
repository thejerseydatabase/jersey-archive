-- Populates the NRLW with its current 12 teams. Colours match each club's
-- NRL counterpart since NRLW teams generally share the same branding.
-- Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('brisbane-broncos','nrlw','Brisbane Broncos','#7A1927','#F5B324'),
  ('canberra-raiders','nrlw','Canberra Raiders','#00843D','#FFD200'),
  ('canterbury-bulldogs','nrlw','Canterbury Bulldogs','#0D3B8C','#FFFFFF'),
  ('cronulla-sharks','nrlw','Cronulla Sharks','#6EC1E4','#000000'),
  ('gold-coast-titans','nrlw','Gold Coast Titans','#002B5C','#FFC72C'),
  ('new-zealand-warriors','nrlw','New Zealand Warriors','#1B1B1B','#00843D'),
  ('newcastle-knights','nrlw','Newcastle Knights','#EE3524','#002D62'),
  ('north-queensland-cowboys','nrlw','North Queensland Cowboys','#002B5C','#F5C518'),
  ('parramatta-eels','nrlw','Parramatta Eels','#005DAA','#FFD100'),
  ('st-george-illawarra-dragons','nrlw','St George Illawarra Dragons','#C8102E','#FFFFFF'),
  ('sydney-roosters','nrlw','Sydney Roosters','#12284B','#E4032E'),
  ('wests-tigers','nrlw','Wests Tigers','#F58220','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
