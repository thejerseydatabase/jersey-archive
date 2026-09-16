-- Adds the EFL Championship competition and its current 24 clubs.
-- Slug is "efl-championship" (not "championship") since that slug is
-- already used by rugby league's Championship. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('efl-championship','football','Championship','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('birmingham-city','efl-championship','Birmingham City','#0044A9','#FFFFFF'),
  ('blackburn-rovers','efl-championship','Blackburn Rovers','#009EE0','#FFFFFF'),
  ('bolton-wanderers','efl-championship','Bolton Wanderers','#FFFFFF','#00174F'),
  ('bristol-city','efl-championship','Bristol City','#E21A23','#FFFFFF'),
  ('burnley-fc','efl-championship','Burnley FC','#6C1D45','#99D6EA'),
  ('cardiff-city','efl-championship','Cardiff City','#0070B5','#FFFFFF'),
  ('charlton-athletic','efl-championship','Charlton Athletic','#D2122E','#FFFFFF'),
  ('derby-county','efl-championship','Derby County','#FFFFFF','#000000'),
  ('lincoln-city','efl-championship','Lincoln City','#C8102E','#FFFFFF'),
  ('middlesbrough-fc','efl-championship','Middlesbrough FC','#E2231A','#FFFFFF'),
  ('millwall-fc','efl-championship','Millwall FC','#001C58','#FFFFFF'),
  ('norwich-city','efl-championship','Norwich City','#FFF200','#00A650'),
  ('portsmouth-fc','efl-championship','Portsmouth FC','#001489','#FFFFFF'),
  ('preston-north-end','efl-championship','Preston North End','#FFFFFF','#00285E'),
  ('queens-park-rangers','efl-championship','Queens Park Rangers','#1D5BA4','#FFFFFF'),
  ('sheffield-united','efl-championship','Sheffield United','#EE2737','#000000'),
  ('southampton-fc','efl-championship','Southampton FC','#D71920','#FFFFFF'),
  ('stoke-city','efl-championship','Stoke City','#E03A3E','#FFFFFF'),
  ('swansea-city','efl-championship','Swansea City','#FFFFFF','#000000'),
  ('watford-fc','efl-championship','Watford FC','#FBEE23','#000000'),
  ('west-bromwich-albion','efl-championship','West Bromwich Albion','#122F67','#FFFFFF'),
  ('west-ham-united','efl-championship','West Ham United','#7A263A','#1BB1E7'),
  ('wolverhampton-wanderers','efl-championship','Wolverhampton Wanderers','#FDB913','#231F20'),
  ('wrexham-afc','efl-championship','Wrexham AFC','#C8102E','#FFFFFF')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
