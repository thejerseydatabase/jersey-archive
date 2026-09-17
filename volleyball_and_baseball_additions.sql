-- 1. Adds Volleyball as a new sport, with International (Men) and
--    International (Women) competitions and your team lists.
-- 2. Adds Field Hockey as a new sport (empty for now — teams to follow).
-- 3. Tops up International (Men) baseball with your list. Australia is
--    left out since Australia's men's team is already on the site under
--    its real nickname, "Southern Thunder (Men)" — same team, not a
--    separate entry.
-- 4. Adds NPB (Nippon Professional Baseball) as a new competition, both
--    leagues' teams together (no divisions in the schema, so Central
--    and Pacific League just become one flat team list).
-- 5. Reorders baseball's competition page: MLB, then International
--    (men's and women's together), then ABL and NPB.
-- Safe to re-run.

insert into sports (slug, name, sort_order) values
  ('volleyball','Volleyball',11),
  ('field-hockey','Field Hockey',12)
on conflict (slug) do nothing;

insert into competitions (slug, sport_slug, name, tier) values
  ('international-volleyball-men','volleyball','International (Men)','top'),
  ('international-volleyball-women','volleyball','International (Women)','top')
on conflict (slug) do nothing;

-- ============ Volleyball — International (Men) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('australia','international-volleyball-men','Australia','#FFD700','#00843D'),
  ('poland','international-volleyball-men','Poland','#DC143C','#FFFFFF'),
  ('italy','international-volleyball-men','Italy','#0F4C81','#FFFFFF'),
  ('russia','international-volleyball-men','Russia','#0033A0','#D52B1E'),
  ('slovenia','international-volleyball-men','Slovenia','#FFFFFF','#005DA4'),
  ('united-states','international-volleyball-men','United States','#002868','#BF0D3E'),
  ('japan','international-volleyball-men','Japan','#BC002D','#FFFFFF'),
  ('brazil','international-volleyball-men','Brazil','#FFDF00','#009739'),
  ('france','international-volleyball-men','France','#002654','#FFFFFF'),
  ('bulgaria','international-volleyball-men','Bulgaria','#00966E','#D62612'),
  ('turkey','international-volleyball-men','Turkey','#E30A17','#FFFFFF'),
  ('ukraine','international-volleyball-men','Ukraine','#005BBB','#FFD500'),
  ('germany','international-volleyball-men','Germany','#000000','#DD0000'),
  ('serbia','international-volleyball-men','Serbia','#C6363C','#0C4076'),
  ('argentina','international-volleyball-men','Argentina','#75AADB','#FFFFFF'),
  ('cuba','international-volleyball-men','Cuba','#002A8F','#CF142B'),
  ('finland','international-volleyball-men','Finland','#003580','#FFFFFF'),
  ('belgium','international-volleyball-men','Belgium','#000000','#FDDA24'),
  ('canada','international-volleyball-men','Canada','#FF0000','#FFFFFF'),
  ('iran','international-volleyball-men','Iran','#239F40','#DA0000'),
  ('czech-republic','international-volleyball-men','Czech Republic','#D7141A','#11457E'),
  ('netherlands','international-volleyball-men','Netherlands','#FF6C00','#FFFFFF'),
  ('puerto-rico','international-volleyball-men','Puerto Rico','#0044FF','#CE1126'),
  ('greece','international-volleyball-men','Greece','#0D5EAF','#FFFFFF'),
  ('qatar','international-volleyball-men','Qatar','#8A1538','#FFFFFF'),
  ('portugal','international-volleyball-men','Portugal','#FF0000','#046A38'),
  ('south-korea','international-volleyball-men','South Korea','#C60C30','#003478'),
  ('egypt','international-volleyball-men','Egypt','#CE1126','#000000'),
  ('switzerland','international-volleyball-men','Switzerland','#FF0000','#FFFFFF'),
  ('israel','international-volleyball-men','Israel','#0038B8','#FFFFFF'),
  ('estonia','international-volleyball-men','Estonia','#0072CE','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Volleyball — International (Women) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('australia','international-volleyball-women','Australia','#FFD700','#00843D'),
  ('italy','international-volleyball-women','Italy','#0F4C81','#FFFFFF'),
  ('brazil','international-volleyball-women','Brazil','#FFDF00','#009739'),
  ('turkey','international-volleyball-women','Turkey','#E30A17','#FFFFFF'),
  ('poland','international-volleyball-women','Poland','#DC143C','#FFFFFF'),
  ('japan','international-volleyball-women','Japan','#BC002D','#FFFFFF'),
  ('china','international-volleyball-women','China','#DE2910','#FFDE00'),
  ('united-states','international-volleyball-women','United States','#002868','#BF0D3E'),
  ('netherlands','international-volleyball-women','Netherlands','#FF6C00','#FFFFFF'),
  ('serbia','international-volleyball-women','Serbia','#C6363C','#0C4076'),
  ('germany','international-volleyball-women','Germany','#000000','#DD0000'),
  ('dominican-republic','international-volleyball-women','Dominican Republic','#002D62','#CE1126'),
  ('canada','international-volleyball-women','Canada','#FF0000','#FFFFFF'),
  ('france','international-volleyball-women','France','#002654','#FFFFFF'),
  ('belgium','international-volleyball-women','Belgium','#000000','#FDDA24'),
  ('czech-republic','international-volleyball-women','Czech Republic','#D7141A','#11457E'),
  ('ukraine','international-volleyball-women','Ukraine','#005BBB','#FFD500'),
  ('argentina','international-volleyball-women','Argentina','#75AADB','#FFFFFF'),
  ('thailand','international-volleyball-women','Thailand','#A51931','#2D2A4A'),
  ('mexico','international-volleyball-women','Mexico','#006847','#CE1126'),
  ('slovenia','international-volleyball-women','Slovenia','#FFFFFF','#005DA4'),
  ('kenya','international-volleyball-women','Kenya','#006400','#CE1126'),
  ('colombia','international-volleyball-women','Colombia','#FCD116','#003893'),
  ('puerto-rico','international-volleyball-women','Puerto Rico','#0044FF','#CE1126'),
  ('romania','international-volleyball-women','Romania','#002B7F','#FCD116'),
  ('bulgaria','international-volleyball-women','Bulgaria','#00966E','#D62612'),
  ('sweden','international-volleyball-women','Sweden','#006AA7','#FECC02'),
  ('cuba','international-volleyball-women','Cuba','#002A8F','#CF142B'),
  ('vietnam','international-volleyball-women','Vietnam','#DA251D','#FFFF00'),
  ('hungary','international-volleyball-women','Hungary','#CD2A3E','#436F4D'),
  ('greece','international-volleyball-women','Greece','#0D5EAF','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Baseball — International (Men) top-up ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('japan','international-baseball-men','Japan','#BC002D','#FFFFFF'),
  ('chinese-taipei','international-baseball-men','Chinese Taipei','#000095','#FE0000'),
  ('united-states','international-baseball-men','United States','#002868','#BF0D3E'),
  ('south-korea','international-baseball-men','South Korea','#C60C30','#003478'),
  ('venezuela','international-baseball-men','Venezuela','#FCD116','#00247D'),
  ('puerto-rico','international-baseball-men','Puerto Rico','#0044FF','#CE1126'),
  ('mexico','international-baseball-men','Mexico','#006847','#CE1126'),
  ('panama','international-baseball-men','Panama','#DA121A','#072357'),
  ('netherlands','international-baseball-men','Netherlands','#FF6C00','#FFFFFF'),
  ('dominican-republic','international-baseball-men','Dominican Republic','#002D62','#CE1126'),
  ('cuba','international-baseball-men','Cuba','#002A8F','#CF142B'),
  ('colombia','international-baseball-men','Colombia','#FCD116','#003893'),
  ('italy','international-baseball-men','Italy','#0F4C81','#FFFFFF'),
  ('nicaragua','international-baseball-men','Nicaragua','#0067C6','#FFFFFF'),
  ('czech-republic','international-baseball-men','Czech Republic','#D7141A','#11457E'),
  ('germany','international-baseball-men','Germany','#000000','#DD0000'),
  ('china','international-baseball-men','China','#DE2910','#FFDE00'),
  ('canada','international-baseball-men','Canada','#FF0000','#FFFFFF'),
  ('great-britain','international-baseball-men','Great Britain','#00247D','#CF142B')
on conflict (competition_slug, slug) do nothing;

-- ============ NPB (Nippon Professional Baseball) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('npb','baseball','NPB','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('chunichi-dragons','npb','Chunichi Dragons','#002B5C','#FFFFFF'),
  ('hanshin-tigers','npb','Hanshin Tigers','#FFE201','#000000'),
  ('hiroshima-toyo-carp','npb','Hiroshima Toyo Carp','#CC0033','#FFFFFF'),
  ('tokyo-yakult-swallows','npb','Tokyo Yakult Swallows','#003C71','#00A651'),
  ('yokohama-dena-baystars','npb','Yokohama DeNA BayStars','#005BAC','#FFFFFF'),
  ('yomiuri-giants','npb','Yomiuri Giants','#F97709','#000000'),
  ('chiba-lotte-marines','npb','Chiba Lotte Marines','#000000','#C4161C'),
  ('fukuoka-softbank-hawks','npb','Fukuoka SoftBank Hawks','#FFD400','#000000'),
  ('hokkaido-nippon-ham-fighters','npb','Hokkaido Nippon-Ham Fighters','#002B5C','#FFFFFF'),
  ('orix-buffaloes','npb','Orix Buffaloes','#001E62','#FFD700'),
  ('saitama-seibu-lions','npb','Saitama Seibu Lions','#0C2340','#FFFFFF'),
  ('tohoku-rakuten-golden-eagles','npb','Tohoku Rakuten Golden Eagles','#A6192E','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ Baseball competition ordering ============
update competitions set sort_order = 1 where slug = 'mlb';
update competitions set sort_order = 2 where slug in ('international-baseball-men', 'international-baseball-women');
update competitions set sort_order = 3 where slug = 'abl';
update competitions set sort_order = 4 where slug = 'npb';
