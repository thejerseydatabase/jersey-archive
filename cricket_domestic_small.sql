-- Adds smaller domestic cricket competitions: Afghanistan provincial
-- league, Bangladesh Premier League, Ireland interprovincial, Nepal
-- Premier League, and Canada's T10 and T20 club competitions (kept
-- separate since a few club names repeat between the two but they're
-- different competitions — no conflict either way, teams are scoped
-- per competition).
--
-- Colours here are lower-confidence placeholders (smaller/newer
-- franchises I don't have solid brand-colour knowledge of) — flag
-- anything off, easy fix later.

insert into competitions (slug, sport_slug, name, tier) values
  ('afghanistan-domestic','cricket','Afghanistan Provincial','more'),
  ('bpl','cricket','Bangladesh Premier League','more'),
  ('ireland-domestic','cricket','Ireland Interprovincial','more'),
  ('nepal-domestic','cricket','Nepal Premier League','more'),
  ('canada-t10','cricket','Canada T10','more'),
  ('canada-t20','cricket','Canada T20','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('balkh-legends','afghanistan-domestic','Balkh Legends','#0033A0','#FFD700'),
  ('kabul-zwanan','afghanistan-domestic','Kabul Zwanan','#FFD700','#000000'),
  ('kandahar-knights','afghanistan-domestic','Kandahar Knights','#C0C0C0','#00205B'),
  ('nangarhar-leopards','afghanistan-domestic','Nangarhar Leopards','#F57F17','#000000'),
  ('paktia-panthers','afghanistan-domestic','Paktia Panthers','#000000','#00843D'),

  ('chittagong-kings','bpl','Chittagong Kings','#5C2D91','#FFD700'),
  ('comilla-victorians','bpl','Comilla Victorians','#6A0032','#FFD700'),
  ('dhaka-capitals','bpl','Dhaka Capitals','#CE1126','#003893'),
  ('durbar-rajshahi','bpl','Durbar Rajshahi','#006A4E','#FFFFFF'),
  ('fortune-barishal','bpl','Fortune Barishal','#002664','#FFD700'),
  ('khulna-tigers','bpl','Khulna Tigers','#F57F17','#000000'),
  ('rangpur-riders','bpl','Rangpur Riders','#CE1126','#000000'),
  ('sylhet-strikers','bpl','Sylhet Strikers','#00843D','#003893'),

  ('leinster-lightning','ireland-domestic','Leinster Lightning','#003893','#FFFFFF'),
  ('north-west-warriors','ireland-domestic','North West Warriors','#002664','#CE1126'),
  ('northern-knights','ireland-domestic','Northern Knights','#CE1126','#000000'),
  ('munster-reds','ireland-domestic','Munster Reds','#CE1126','#FFFFFF'),

  ('biratnagar-kings','nepal-domestic','Biratnagar Kings','#5C2D91','#FFD700'),
  ('chitwan-rhinos','nepal-domestic','Chitwan Rhinos','#808080','#006A4E'),
  ('janakpur-bolts','nepal-domestic','Janakpur Bolts','#FFD700','#000000'),
  ('karnali-yaks','nepal-domestic','Karnali Yaks','#FFFFFF','#003893'),
  ('kathmandu-gorkhas','nepal-domestic','Kathmandu Gorkhas','#CE1126','#000000'),
  ('lumbini-lions','nepal-domestic','Lumbini Lions','#F57F17','#000000'),
  ('pokhara-avengers','nepal-domestic','Pokhara Avengers','#003893','#FFFFFF'),
  ('sudurpaschim-royals','nepal-domestic','Sudurpaschim Royals','#5C2D91','#FFD700'),

  ('brampton-blitz','canada-t10','Brampton Blitz','#F57F17','#000000'),
  ('brampton-wolves','canada-t10','Brampton Wolves','#808080','#000000'),
  ('mississauga-masters','canada-t10','Mississauga Masters','#002664','#FFD700'),
  ('montreal-royal-tigers','canada-t10','Montreal Royal Tigers','#F57F17','#000000'),
  ('toronto-sixers','canada-t10','Toronto Sixers','#003893','#EC008C'),
  ('vancouver-kings','canada-t10','Vancouver Kings','#5C2D91','#FFD700'),
  ('white-rock-warriors','canada-t10','White Rock Warriors','#CE1126','#000000'),

  ('brampton-wolves','canada-t20','Brampton Wolves','#808080','#000000'),
  ('montreal-tigers','canada-t20','Montreal Tigers','#F57F17','#000000'),
  ('toronto-nationals','canada-t20','Toronto Nationals','#002664','#CE1126'),
  ('vancouver-knights','canada-t20','Vancouver Knights','#C0C0C0','#00205B'),
  ('surrey-jaguars','canada-t20','Surrey Jaguars','#006A4E','#000000'),
  ('bangla-tigers-mississauga','canada-t20','Bangla Tigers Mississauga','#006A4E','#CE1126')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
