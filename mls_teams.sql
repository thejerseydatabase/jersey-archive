-- Adds MLS and its current 30 clubs. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('mls','football','MLS','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('new-york-red-bulls','mls','New York Red Bulls','#ED1C24','#000000'),
  ('la-galaxy','mls','LA Galaxy','#00245D','#FFD200'),
  ('portland-timbers','mls','Portland Timbers','#00572D','#FFD200'),
  ('columbus-crew','mls','Columbus Crew','#FFF110','#000000'),
  ('atlanta-united-fc','mls','Atlanta United FC','#A6192E','#000000'),
  ('colorado-rapids','mls','Colorado Rapids','#862633','#003087'),
  ('philadelphia-union','mls','Philadelphia Union','#002B5C','#FFD200'),
  ('houston-dynamo-fc','mls','Houston Dynamo FC','#F7941E','#000000'),
  ('seattle-sounders-fc','mls','Seattle Sounders FC','#5D9741','#00539A'),
  ('dc-united','mls','D.C. United','#000000','#DC143C'),
  ('fc-dallas','mls','FC Dallas','#E01F3D','#00543D'),
  ('toronto-fc','mls','Toronto FC','#B81137','#000000'),
  ('sporting-kansas-city','mls','Sporting Kansas City','#93B1E2','#002145'),
  ('real-salt-lake','mls','Real Salt Lake','#B30838','#FFD200'),
  ('san-jose-earthquakes','mls','San Jose Earthquakes','#0A2240','#000000'),
  ('vancouver-whitecaps-fc','mls','Vancouver Whitecaps FC','#00245D','#FFFFFF'),
  ('new-england-revolution','mls','New England Revolution','#002868','#CE1126'),
  ('inter-miami-cf','mls','Inter Miami CF','#F7B5CD','#231F20'),
  ('chicago-fire-fc','mls','Chicago Fire FC','#A6192E','#0033A0'),
  ('orlando-city-sc','mls','Orlando City SC','#612A78','#FFD200'),
  ('new-york-city-fc','mls','New York City FC','#6CADDF','#041E42'),
  ('nashville-sc','mls','Nashville SC','#FFD200','#1B1F3B'),
  ('minnesota-united-fc','mls','Minnesota United FC','#8CD2F4','#000000'),
  ('austin-fc','mls','Austin FC','#00B140','#000000'),
  ('cf-montreal','mls','CF Montréal','#001E62','#000000'),
  ('charlotte-fc','mls','Charlotte FC','#1A85C8','#000000'),
  ('fc-cincinnati','mls','FC Cincinnati','#F05023','#003087'),
  ('los-angeles-fc','mls','Los Angeles FC','#000000','#FFD200'),
  ('st-louis-city-sc','mls','St. Louis City SC','#C4122E','#101F3C'),
  ('san-diego-fc','mls','San Diego FC','#041E42','#FFD200')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
