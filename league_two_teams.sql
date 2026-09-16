-- Adds League Two and its current 24 clubs. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('league-two','football','League Two','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('accrington-stanley','league-two','Accrington Stanley','#C8102E','#FFFFFF'),
  ('barnet','league-two','Barnet','#FDB913','#000000'),
  ('bristol-rovers','league-two','Bristol Rovers','#0E4C92','#FFFFFF'),
  ('cheltenham-town','league-two','Cheltenham Town','#E4032E','#FFFFFF'),
  ('chesterfield-fc','league-two','Chesterfield FC','#0033A0','#FFFFFF'),
  ('colchester-united','league-two','Colchester United','#0033A0','#FFFFFF'),
  ('crawley-town','league-two','Crawley Town','#C8102E','#FFFFFF'),
  ('crewe-alexandra','league-two','Crewe Alexandra','#D2122E','#FFFFFF'),
  ('exeter-city','league-two','Exeter City','#D2122E','#FFFFFF'),
  ('fleetwood-town','league-two','Fleetwood Town','#C8102E','#FFFFFF'),
  ('gillingham-fc','league-two','Gillingham FC','#002B5C','#FFFFFF'),
  ('grimsby-town','league-two','Grimsby Town','#000000','#FFFFFF'),
  ('newport-county-afc','league-two','Newport County AFC','#FDB913','#000000'),
  ('northampton-town','league-two','Northampton Town','#7A1F3D','#FFFFFF'),
  ('oldham-athletic','league-two','Oldham Athletic','#1B458F','#FFFFFF'),
  ('port-vale','league-two','Port Vale','#FDB913','#000000'),
  ('rochdale-afc','league-two','Rochdale AFC','#0033A0','#000000'),
  ('rotherham-united','league-two','Rotherham United','#D2122E','#FFFFFF'),
  ('salford-city','league-two','Salford City','#C8102E','#FFFFFF'),
  ('shrewsbury-town','league-two','Shrewsbury Town','#003C71','#FDB913'),
  ('swindon-town','league-two','Swindon Town','#D2122E','#FFFFFF'),
  ('tranmere-rovers','league-two','Tranmere Rovers','#FFFFFF','#00205B'),
  ('walsall-fc','league-two','Walsall FC','#D2122E','#FFFFFF'),
  ('york-city-fc','league-two','York City FC','#D2122E','#002D62')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
