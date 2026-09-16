-- Adds an International competition to rugby league (it only had
-- NRL/NRLW/Super League/Championship/NSW Cup/QLD Cup so far), split into
-- men's and women's the same way NRL/NRLW already are. Slugs are
-- "international-rugby-league-men/women" rather than plain "international"
-- since that slug is already used by cricket. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('international-rugby-league-men','rugby-league','International (Men)','top'),
  ('international-rugby-league-women','rugby-league','International (Women)','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('australia','international-rugby-league-men','Australia','#00843D','#FFD700'),
  ('new-zealand','international-rugby-league-men','New Zealand','#000000','#FFFFFF'),
  ('england','international-rugby-league-men','England','#FFFFFF','#CF081F'),
  ('france','international-rugby-league-men','France','#002654','#FFFFFF'),
  ('papua-new-guinea','international-rugby-league-men','Papua New Guinea','#CE1126','#000000'),
  ('cook-islands','international-rugby-league-men','Cook Islands','#00247D','#FFFFFF'),
  ('canada','international-rugby-league-men','Canada','#FF0000','#FFFFFF'),
  ('ireland','international-rugby-league-men','Ireland','#169B62','#FFFFFF'),
  ('wales','international-rugby-league-men','Wales','#C8102E','#FFFFFF'),
  ('brazil','international-rugby-league-men','Brazil','#FFDF00','#009739'),
  ('greece','international-rugby-league-men','Greece','#0D5EAF','#FFFFFF'),
  ('serbia','international-rugby-league-men','Serbia','#C6363C','#0C4076'),
  ('italy','international-rugby-league-men','Italy','#0F4C81','#FFFFFF'),
  ('philippines','international-rugby-league-men','Philippines','#0038A8','#CE1126'),
  ('turkey','international-rugby-league-men','Turkey','#E30A17','#FFFFFF'),
  ('tonga','international-rugby-league-men','Tonga','#C10000','#FFFFFF'),
  ('malta','international-rugby-league-men','Malta','#CE1126','#FFFFFF'),
  ('usa','international-rugby-league-men','USA','#002868','#BF0D3E'),
  ('fiji','international-rugby-league-men','Fiji','#71C5E8','#FFFFFF'),
  ('samoa','international-rugby-league-men','Samoa','#002B7F','#CE1126'),
  ('lebanon','international-rugby-league-men','Lebanon','#ED1C24','#00A651'),
  ('argentina','international-rugby-league-men','Argentina','#75AADB','#FFFFFF')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('australia','international-rugby-league-women','Australia','#00843D','#FFD700'),
  ('new-zealand','international-rugby-league-women','New Zealand','#000000','#FFFFFF'),
  ('england','international-rugby-league-women','England','#FFFFFF','#CF081F'),
  ('france','international-rugby-league-women','France','#002654','#FFFFFF'),
  ('samoa','international-rugby-league-women','Samoa','#002B7F','#CE1126'),
  ('papua-new-guinea','international-rugby-league-women','Papua New Guinea','#CE1126','#000000'),
  ('canada','international-rugby-league-women','Canada','#FF0000','#FFFFFF'),
  ('ireland','international-rugby-league-women','Ireland','#169B62','#FFFFFF'),
  ('wales','international-rugby-league-women','Wales','#C8102E','#FFFFFF'),
  ('nigeria','international-rugby-league-women','Nigeria','#008751','#FFFFFF'),
  ('cook-islands','international-rugby-league-women','Cook Islands','#00247D','#FFFFFF'),
  ('fiji','international-rugby-league-women','Fiji','#71C5E8','#FFFFFF'),
  ('tonga','international-rugby-league-women','Tonga','#C10000','#FFFFFF'),
  ('united-states','international-rugby-league-women','United States','#002868','#BF0D3E'),
  ('greece','international-rugby-league-women','Greece','#0D5EAF','#FFFFFF'),
  ('netherlands','international-rugby-league-women','Netherlands','#FF6C00','#FFFFFF'),
  ('scotland','international-rugby-league-women','Scotland','#00205B','#FFFFFF'),
  ('serbia','international-rugby-league-women','Serbia','#C6363C','#0C4076'),
  ('kenya','international-rugby-league-women','Kenya','#006400','#CE1126'),
  ('ghana','international-rugby-league-women','Ghana','#FCD116','#006B3F'),
  ('brazil','international-rugby-league-women','Brazil','#FFDF00','#009739'),
  ('jamaica','international-rugby-league-women','Jamaica','#FED100','#009B3A'),
  ('italy','international-rugby-league-women','Italy','#0F4C81','#FFFFFF'),
  ('philippines','international-rugby-league-women','Philippines','#0038A8','#CE1126'),
  ('lebanon','international-rugby-league-women','Lebanon','#ED1C24','#00A651'),
  ('uganda','international-rugby-league-women','Uganda','#000000','#FCDD09'),
  ('malta','international-rugby-league-women','Malta','#CE1126','#FFFFFF'),
  ('t-rkiye','international-rugby-league-women','Türkiye','#E30A17','#FFFFFF')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
