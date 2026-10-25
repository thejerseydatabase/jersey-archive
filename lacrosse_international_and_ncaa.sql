-- Adds two Lacrosse competitions and their teams.
--
-- 'international' is already taken by cricket (competitions.slug has no
-- per-sport scoping - see ensureCompetition() in app.js), so this uses
-- 'international-lacrosse' instead, same pattern baseball used
-- ('international-baseball-men') to avoid the same collision.
--
-- International teams: World Lacrosse Men's Championship entrants, from
-- https://en.wikipedia.org/wiki/World_Lacrosse_Men%27s_Championship
-- Colors are each country's standard national sporting colors.
--
-- NCAA Division I teams: the 18 schools in the 2026 tournament field,
-- from https://en.wikipedia.org/wiki/2026_NCAA_Division_I_men%27s_lacrosse_tournament
-- (the tournament's own participants, not the full list of D1 programs).
-- Colors are each school's own official athletics colors.
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('international-lacrosse','lacrosse','International','top'),
  ('ncaa-division-i-lacrosse','lacrosse','NCAA Division I','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('argentina','international-lacrosse','Argentina','#75AADB','#FFFFFF'),
  ('australia','international-lacrosse','Australia','#00843D','#FFD700'),
  ('austria','international-lacrosse','Austria','#ED2939','#FFFFFF'),
  ('belgium','international-lacrosse','Belgium','#000000','#ED2939'),
  ('bermuda','international-lacrosse','Bermuda','#ED2939','#00247D'),
  ('bulgaria','international-lacrosse','Bulgaria','#FFFFFF','#00966E'),
  ('canada','international-lacrosse','Canada','#FF0000','#FFFFFF'),
  ('china','international-lacrosse','China','#DE2910','#FFDE00'),
  ('colombia','international-lacrosse','Colombia','#FCD116','#003893'),
  ('costa-rica','international-lacrosse','Costa Rica','#002B7F','#CE1126'),
  ('croatia','international-lacrosse','Croatia','#ED1C24','#FFFFFF'),
  ('czech-republic','international-lacrosse','Czech Republic','#D7141A','#FFFFFF'),
  ('denmark','international-lacrosse','Denmark','#C8102E','#FFFFFF'),
  ('england','international-lacrosse','England','#FFFFFF','#CE1124'),
  ('finland','international-lacrosse','Finland','#002F6C','#FFFFFF'),
  ('france','international-lacrosse','France','#0055A4','#FFFFFF'),
  ('germany','international-lacrosse','Germany','#000000','#FFFFFF'),
  ('greece','international-lacrosse','Greece','#0D5EAF','#FFFFFF'),
  ('haiti','international-lacrosse','Haiti','#00209F','#D21034'),
  ('haudenosaunee','international-lacrosse','Haudenosaunee','#4B0082','#FFFFFF'),
  ('hong-kong','international-lacrosse','Hong Kong','#DE2910','#FFFFFF'),
  ('hungary','international-lacrosse','Hungary','#CE2939','#FFFFFF'),
  ('ireland','international-lacrosse','Ireland','#169B62','#FFFFFF'),
  ('israel','international-lacrosse','Israel','#0038B8','#FFFFFF'),
  ('italy','international-lacrosse','Italy','#0066CC','#FFFFFF'),
  ('jamaica','international-lacrosse','Jamaica','#000000','#FED100'),
  ('japan','international-lacrosse','Japan','#BC002D','#FFFFFF'),
  ('latvia','international-lacrosse','Latvia','#9E3039','#FFFFFF'),
  ('luxembourg','international-lacrosse','Luxembourg','#00A1DE','#ED2939'),
  ('kenya','international-lacrosse','Kenya','#000000','#BB0000'),
  ('mexico','international-lacrosse','Mexico','#006341','#FFFFFF'),
  ('netherlands','international-lacrosse','Netherlands','#FF6C00','#21468B'),
  ('new-zealand','international-lacrosse','New Zealand','#000000','#FFFFFF'),
  ('norway','international-lacrosse','Norway','#BA0C2F','#FFFFFF'),
  ('peru','international-lacrosse','Peru','#D91023','#FFFFFF'),
  ('philippines','international-lacrosse','Philippines','#0038A8','#FCD116'),
  ('poland','international-lacrosse','Poland','#FFFFFF','#DC143C'),
  ('portugal','international-lacrosse','Portugal','#006600','#FF0000'),
  ('puerto-rico','international-lacrosse','Puerto Rico','#ED1C24','#0050A0'),
  ('russia','international-lacrosse','Russia','#0039A6','#D52B1E'),
  ('scotland','international-lacrosse','Scotland','#0065BD','#FFFFFF'),
  ('slovakia','international-lacrosse','Slovakia','#0B4EA2','#FFFFFF'),
  ('slovenia','international-lacrosse','Slovenia','#0000FF','#FFFFFF'),
  ('south-korea','international-lacrosse','South Korea','#CD2E3A','#0047A0'),
  ('spain','international-lacrosse','Spain','#AA151B','#F1BF00'),
  ('sweden','international-lacrosse','Sweden','#006AA7','#FECC02'),
  ('switzerland','international-lacrosse','Switzerland','#FF0000','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('princeton','ncaa-division-i-lacrosse','Princeton','#FF8F00','#000000'),
  ('notre-dame','ncaa-division-i-lacrosse','Notre Dame','#0C2340','#C99700'),
  ('north-carolina','ncaa-division-i-lacrosse','North Carolina','#7BAFD4','#FFFFFF'),
  ('richmond','ncaa-division-i-lacrosse','Richmond','#990000','#003087'),
  ('virginia','ncaa-division-i-lacrosse','Virginia','#232D4B','#E57200'),
  ('syracuse','ncaa-division-i-lacrosse','Syracuse','#F76900','#000E54'),
  ('cornell','ncaa-division-i-lacrosse','Cornell','#B31B1B','#FFFFFF'),
  ('penn-state','ncaa-division-i-lacrosse','Penn State','#041E42','#FFFFFF'),
  ('army','ncaa-division-i-lacrosse','Army','#000000','#D4BF91'),
  ('johns-hopkins','ncaa-division-i-lacrosse','Johns Hopkins','#002D72','#000000'),
  ('yale','ncaa-division-i-lacrosse','Yale','#00356B','#FFFFFF'),
  ('georgetown','ncaa-division-i-lacrosse','Georgetown','#063962','#A1A1A4'),
  ('duke','ncaa-division-i-lacrosse','Duke','#00539B','#FFFFFF'),
  ('albany','ncaa-division-i-lacrosse','Albany','#4B0082','#FFC72C'),
  ('robert-morris','ncaa-division-i-lacrosse','Robert Morris','#002D72','#FFFFFF'),
  ('jacksonville','ncaa-division-i-lacrosse','Jacksonville','#00573F','#FFFFFF'),
  ('marist','ncaa-division-i-lacrosse','Marist','#A6192E','#FFFFFF'),
  ('stony-brook','ncaa-division-i-lacrosse','Stony Brook','#990000','#808080')
on conflict (competition_slug, slug) do nothing;
