-- Adds the NBL (Australia) and International basketball (men + a
-- women's competition, currently just Belgium since that's the only
-- women's team on the list — easy to add more later). Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('nbl','basketball','NBL','top'),
  ('international-basketball-men','basketball','International (Men)','top'),
  ('international-basketball-women','basketball','International (Women)','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('sydney-kings','nbl','Sydney Kings','#0C2340','#E4032E'),
  ('perth-wildcats','nbl','Perth Wildcats','#E4032E','#000000'),
  ('melbourne-united','nbl','Melbourne United','#00285E','#E4032E'),
  ('cairns-taipans','nbl','Cairns Taipans','#00843D','#FFD200'),
  ('illawarra-hawks','nbl','Illawarra Hawks','#E4032E','#000000'),
  ('new-zealand-breakers','nbl','New Zealand Breakers','#000000','#FFD200'),
  ('brisbane-bullets','nbl','Brisbane Bullets','#E4032E','#000000'),
  ('tasmania-jackjumpers','nbl','Tasmania JackJumpers','#2E8B57','#5C2D91'),
  ('s-e-melbourne-phoenix','nbl','S.E. Melbourne Phoenix','#C8102E','#000000'),
  ('adelaide-36ers','nbl','Adelaide 36ers','#E4032E','#002D62')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('spain','international-basketball-men','Spain','#C60B1E','#FFC400'),
  ('netherlands','international-basketball-men','Netherlands','#FF6C00','#FFFFFF'),
  ('france','international-basketball-men','France','#002654','#FFFFFF'),
  ('serbia','international-basketball-men','Serbia','#C6363C','#0C4076'),
  ('greece','international-basketball-men','Greece','#0D5EAF','#FFFFFF'),
  ('belgium','international-basketball-men','Belgium','#ED2939','#000000'),
  ('argentina','international-basketball-men','Argentina','#75AADB','#FFFFFF'),
  ('croatia','international-basketball-men','Croatia','#FF0000','#FFFFFF'),
  ('italy','international-basketball-men','Italy','#0F4C81','#FFFFFF'),
  ('turkey','international-basketball-men','Turkey','#E30A17','#FFFFFF'),
  ('slovenia','international-basketball-men','Slovenia','#78BE20','#FFFFFF'),
  ('germany','international-basketball-men','Germany','#DD0000','#000000'),
  ('lithuania','international-basketball-men','Lithuania','#FDB913','#006A44'),
  ('great-britain','international-basketball-men','Great Britain','#00247D','#CF142B'),
  ('israel','international-basketball-men','Israel','#0038B8','#FFFFFF'),
  ('latvia','international-basketball-men','Latvia','#9E3039','#FFFFFF'),
  ('bosnia-and-herzegovina','international-basketball-men','Bosnia and Herzegovina','#002395','#FECB00'),
  ('montenegro','international-basketball-men','Montenegro','#C40308','#D4AF37'),
  ('czech-republic','international-basketball-men','Czech Republic','#D7141A','#11457E'),
  ('georgia','international-basketball-men','Georgia','#FFFFFF','#FF0000'),
  ('finland','international-basketball-men','Finland','#002F6C','#FFFFFF'),
  ('poland','international-basketball-men','Poland','#DC143C','#FFFFFF'),
  ('venezuela','international-basketball-men','Venezuela','#7B1113','#FFCC00'),
  ('iceland','international-basketball-men','Iceland','#003897','#D72828'),
  ('estonia','international-basketball-men','Estonia','#0072CE','#000000'),
  ('cyprus','international-basketball-men','Cyprus','#FFFFFF','#D57800'),
  ('south-korea','international-basketball-men','South Korea','#C60C30','#0047A0'),
  ('portugal','international-basketball-men','Portugal','#FF0000','#046A38'),
  ('sweden','international-basketball-men','Sweden','#006AA7','#FECC02'),
  ('colombia','international-basketball-men','Colombia','#FCD116','#003893'),
  ('slovakia','international-basketball-men','Slovakia','#0B4EA2','#EE1C25'),
  ('north-macedonia','international-basketball-men','North Macedonia','#D20000','#FFE600')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('belgium-women','international-basketball-women','Belgium Women','#ED2939','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
