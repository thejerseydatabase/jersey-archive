-- Adds three new competitions: NPC (New Zealand provincial rugby union,
-- 14 teams — "Wellington" appeared twice in the list, added once),
-- Bundesliga (German football, 18 clubs as given), and Serie A (Italian
-- football, 20 clubs as given). Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('npc','rugby-union','NPC','top'),
  ('bundesliga','football','Bundesliga','top'),
  ('serie-a','football','Serie A','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('auckland','npc','Auckland','#002664','#FFFFFF'),
  ('bay-of-plenty','npc','Bay of Plenty','#CE1126','#000000'),
  ('canterbury','npc','Canterbury','#CE1126','#000000'),
  ('counties-manukau','npc','Counties Manukau','#002664','#CE1126'),
  ('hawke-s-bay','npc','Hawke''s Bay','#CE1126','#000000'),
  ('manawat','npc','Manawatū','#002664','#FFD700'),
  ('north-harbour','npc','North Harbour','#6A0032','#00843D'),
  ('northland','npc','Northland','#00693E','#FFD700'),
  ('otago','npc','Otago','#002664','#FFD700'),
  ('southland','npc','Southland','#6A0032','#FFFFFF'),
  ('taranaki','npc','Taranaki','#FFC72C','#000000'),
  ('tasman','npc','Tasman','#6A0032','#FFD700'),
  ('waikato','npc','Waikato','#CE1126','#FFD700'),
  ('wellington','npc','Wellington','#FFD700','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('bayern-munchen','bundesliga','Bayern München','#DC052D','#0066B2'),
  ('borussia-dortmund','bundesliga','Borussia Dortmund','#FDE100','#000000'),
  ('bayer-04-leverkusen','bundesliga','Bayer 04 Leverkusen','#E32219','#000000'),
  ('schalke-04','bundesliga','Schalke 04','#004D9D','#FFFFFF'),
  ('hamburger-sv','bundesliga','Hamburger SV','#003087','#000000'),
  ('werder-bremen','bundesliga','Werder Bremen','#00963A','#FFFFFF'),
  ('1-fc-koln','bundesliga','1. FC Köln','#ED1C24','#FFFFFF'),
  ('eintracht-frankfurt','bundesliga','Eintracht Frankfurt','#000000','#E1000F'),
  ('borussia-monchengladbach','bundesliga','Borussia Mönchengladbach','#000000','#FFFFFF'),
  ('vfb-stuttgart','bundesliga','VfB Stuttgart','#E32219','#FFFFFF'),
  ('1-fsv-mainz-05','bundesliga','1. FSV Mainz 05','#C3141E','#FFFFFF'),
  ('sc-freiburg','bundesliga','SC Freiburg','#E2001A','#000000'),
  ('rb-leipzig','bundesliga','RB Leipzig','#DD0741','#FFFFFF'),
  ('union-berlin','bundesliga','Union Berlin','#EB1923','#FFCE00'),
  ('fc-augsburg','bundesliga','FC Augsburg','#BA3733','#00843D'),
  ('tsg-hoffenheim','bundesliga','TSG Hoffenheim','#1961B5','#FFFFFF'),
  ('sc-paderborn','bundesliga','SC Paderborn','#0057A8','#000000'),
  ('sv-elversberg','bundesliga','SV Elversberg','#003DA5','#FFFFFF')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('ac-milan','serie-a','AC Milan','#FB090B','#000000'),
  ('juventus-fc','serie-a','Juventus FC','#000000','#FFFFFF'),
  ('inter-milan','serie-a','Inter Milan','#0068A8','#000000'),
  ('as-roma','serie-a','AS Roma','#8E1F2F','#F0BC42'),
  ('ss-lazio','serie-a','SS Lazio','#87D8F7','#FFFFFF'),
  ('ssc-napoli','serie-a','SSC Napoli','#12A0D7','#FFFFFF'),
  ('acf-fiorentina','serie-a','ACF Fiorentina','#482E92','#FFFFFF'),
  ('parma-calcio','serie-a','Parma Calcio','#FFE500','#001489'),
  ('torino-fc','serie-a','Torino FC','#7A263A','#FFFFFF'),
  ('venezia-fc','serie-a','Venezia FC','#000000','#FF6600'),
  ('bologna-fc','serie-a','Bologna FC','#B41E33','#1A3E8C'),
  ('udinese-calcio','serie-a','Udinese Calcio','#000000','#FFFFFF'),
  ('atalanta-bc','serie-a','Atalanta BC','#1C4A9C','#000000'),
  ('como-1907','serie-a','Como 1907','#005BAA','#FFFFFF'),
  ('genoa-cfc','serie-a','Genoa CFC','#C8102E','#00205B'),
  ('cagliari-calcio','serie-a','Cagliari Calcio','#8B1E3F','#002664'),
  ('us-lecce','serie-a','US Lecce','#FFD700','#CE1126'),
  ('us-sassuolo-calcio','serie-a','US Sassuolo Calcio','#00843D','#000000'),
  ('ac-monza','serie-a','AC Monza','#C8102E','#FFFFFF'),
  ('frosinone-calcio','serie-a','Frosinone Calcio','#FFD700','#002664')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
