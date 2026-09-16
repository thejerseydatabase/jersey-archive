-- Adds League One and its current 24 clubs. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('league-one','football','League One','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('afc-wimbledon','league-one','AFC Wimbledon','#1B458F','#FFD100'),
  ('barnsley-fc','league-one','Barnsley FC','#D2122E','#FFFFFF'),
  ('blackpool-fc','league-one','Blackpool FC','#F68712','#FFFFFF'),
  ('bradford-city','league-one','Bradford City','#8A1538','#FFB81C'),
  ('bromley-fc','league-one','Bromley FC','#FFFFFF','#000000'),
  ('burton-albion','league-one','Burton Albion','#FFD200','#000000'),
  ('cambridge-united','league-one','Cambridge United','#FDB913','#000000'),
  ('doncaster-rovers','league-one','Doncaster Rovers','#E4032E','#FFFFFF'),
  ('huddersfield-town','league-one','Huddersfield Town','#0072CE','#FFFFFF'),
  ('leicester-city','league-one','Leicester City','#003090','#FFFFFF'),
  ('leyton-orient','league-one','Leyton Orient','#D2122E','#FFFFFF'),
  ('luton-town','league-one','Luton Town','#F78F1E','#00285E'),
  ('mansfield-town','league-one','Mansfield Town','#FDB913','#003C71'),
  ('mk-dons','league-one','MK Dons','#FFFFFF','#000000'),
  ('notts-county','league-one','Notts County','#000000','#FFFFFF'),
  ('oxford-united','league-one','Oxford United','#FFF200','#00205B'),
  ('peterborough-united','league-one','Peterborough United','#1B458F','#FFFFFF'),
  ('plymouth-argyle','league-one','Plymouth Argyle','#005940','#FFFFFF'),
  ('reading-fc','league-one','Reading FC','#004494','#FFFFFF'),
  ('sheffield-wednesday','league-one','Sheffield Wednesday','#0E63AD','#FFFFFF'),
  ('stevenage-fc','league-one','Stevenage FC','#C8102E','#FFFFFF'),
  ('stockport-county','league-one','Stockport County','#0055A4','#FFFFFF'),
  ('wigan-athletic','league-one','Wigan Athletic','#1B458F','#FFFFFF'),
  ('wycombe-wanderers','league-one','Wycombe Wanderers','#7FB8E0','#002F6C')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
