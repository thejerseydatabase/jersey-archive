-- Same issue as Bundesliga: NPC (rugby union) and Serie A (football)
-- were written into the same original file as Bundesliga
-- (npc_bundesliga_seriea_teams.sql) but never actually got run. This
-- file stands alone and re-creates both, using the final team
-- names/slugs from the later rename fix so it converges to the right
-- state whether or not any part of the original ever ran. Safe to
-- re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('npc','rugby-union','NPC','top'),
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
  ('ac-milan','serie-a','AC Milan','#FB090B','#000000'),
  ('juventus','serie-a','Juventus','#000000','#FFFFFF'),
  ('inter-milan','serie-a','Inter Milan','#0068A8','#000000'),
  ('roma','serie-a','Roma','#8E1F2F','#F0BC42'),
  ('lazio','serie-a','Lazio','#87D8F7','#FFFFFF'),
  ('napoli','serie-a','Napoli','#12A0D7','#FFFFFF'),
  ('fiorentina','serie-a','Fiorentina','#482E92','#FFFFFF'),
  ('parma','serie-a','Parma','#FFE500','#001489'),
  ('torino','serie-a','Torino','#7A263A','#FFFFFF'),
  ('venezia','serie-a','Venezia','#000000','#FF6600'),
  ('bologna','serie-a','Bologna','#B41E33','#1A3E8C'),
  ('udinese','serie-a','Udinese','#000000','#FFFFFF'),
  ('atalanta','serie-a','Atalanta','#1C4A9C','#000000'),
  ('como','serie-a','Como','#005BAA','#FFFFFF'),
  ('genoa','serie-a','Genoa','#C8102E','#00205B'),
  ('cagliari','serie-a','Cagliari','#8B1E3F','#002664'),
  ('lecce','serie-a','Lecce','#FFD700','#CE1126'),
  ('sassuolo','serie-a','Sassuolo','#00843D','#000000'),
  ('monza','serie-a','Monza','#C8102E','#FFFFFF'),
  ('frosinone','serie-a','Frosinone','#FFD700','#002664')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
