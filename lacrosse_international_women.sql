-- Adds the Women's Lacrosse international teams as their own competition,
-- 'international-lacrosse-women', same pattern baseball already uses for
-- splitting men's/women's international competitions under one sport
-- (international-baseball-men / international-baseball-women). Also
-- renames the existing men's competition to match that naming.
--
-- Teams: World Lacrosse Women's Championship entrants, from
-- https://en.wikipedia.org/wiki/World_Lacrosse_Women%27s_Championship
-- Colors reuse the same national colors as the men's competition for
-- countries in both; the four women's-only entries (Chinese Taipei,
-- Uganda, United States, Wales) use their own standard colors.
--
-- Safe to re-run.

update competitions set name = 'International (Men)' where slug = 'international-lacrosse';

insert into competitions (slug, sport_slug, name, tier) values
  ('international-lacrosse-women','lacrosse','International (Women)','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('argentina','international-lacrosse-women','Argentina','#75AADB','#FFFFFF'),
  ('australia','international-lacrosse-women','Australia','#00843D','#FFD700'),
  ('austria','international-lacrosse-women','Austria','#ED2939','#FFFFFF'),
  ('belgium','international-lacrosse-women','Belgium','#000000','#ED2939'),
  ('canada','international-lacrosse-women','Canada','#FF0000','#FFFFFF'),
  ('colombia','international-lacrosse-women','Colombia','#FCD116','#003893'),
  ('china','international-lacrosse-women','China','#DE2910','#FFDE00'),
  ('chinese-taipei','international-lacrosse-women','Chinese Taipei','#004C97','#FFFFFF'),
  ('czech-republic','international-lacrosse-women','Czech Republic','#D7141A','#FFFFFF'),
  ('denmark','international-lacrosse-women','Denmark','#C8102E','#FFFFFF'),
  ('england','international-lacrosse-women','England','#FFFFFF','#CE1124'),
  ('finland','international-lacrosse-women','Finland','#002F6C','#FFFFFF'),
  ('germany','international-lacrosse-women','Germany','#000000','#FFFFFF'),
  ('haudenosaunee','international-lacrosse-women','Haudenosaunee','#4B0082','#FFFFFF'),
  ('hong-kong','international-lacrosse-women','Hong Kong','#DE2910','#FFFFFF'),
  ('ireland','international-lacrosse-women','Ireland','#169B62','#FFFFFF'),
  ('israel','international-lacrosse-women','Israel','#0038B8','#FFFFFF'),
  ('italy','international-lacrosse-women','Italy','#0066CC','#FFFFFF'),
  ('jamaica','international-lacrosse-women','Jamaica','#000000','#FED100'),
  ('japan','international-lacrosse-women','Japan','#BC002D','#FFFFFF'),
  ('latvia','international-lacrosse-women','Latvia','#9E3039','#FFFFFF'),
  ('mexico','international-lacrosse-women','Mexico','#006341','#FFFFFF'),
  ('netherlands','international-lacrosse-women','Netherlands','#FF6C00','#21468B'),
  ('norway','international-lacrosse-women','Norway','#BA0C2F','#FFFFFF'),
  ('new-zealand','international-lacrosse-women','New Zealand','#000000','#FFFFFF'),
  ('philippines','international-lacrosse-women','Philippines','#0038A8','#FCD116'),
  ('puerto-rico','international-lacrosse-women','Puerto Rico','#ED1C24','#0050A0'),
  ('scotland','international-lacrosse-women','Scotland','#0065BD','#FFFFFF'),
  ('south-korea','international-lacrosse-women','South Korea','#CD2E3A','#0047A0'),
  ('spain','international-lacrosse-women','Spain','#AA151B','#F1BF00'),
  ('sweden','international-lacrosse-women','Sweden','#006AA7','#FECC02'),
  ('switzerland','international-lacrosse-women','Switzerland','#FF0000','#FFFFFF'),
  ('uganda','international-lacrosse-women','Uganda','#000000','#FCD116'),
  ('united-states','international-lacrosse-women','United States','#B22234','#002868'),
  ('wales','international-lacrosse-women','Wales','#C8102E','#FFFFFF')
on conflict (competition_slug, slug) do nothing;
