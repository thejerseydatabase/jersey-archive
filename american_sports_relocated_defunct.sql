-- Historical relocated/defunct identities for the 5 US/Canada leagues
-- already on the site, from your Wikipedia lists. Same approach as
-- everywhere else this session: where the OLD name is different from
-- today's team, it gets its own defunct row (is_active = false) with a
-- history_note saying what it became — so a vintage "Seattle
-- SuperSonics" or "Houston Oilers" jersey files correctly instead of
-- getting mislabeled as the modern team. Where a franchise reused the
-- exact same name after a gap (Los Angeles Rams, Oakland Raiders), no
-- new row is added — the current team's row already covers every era of
-- that name.
--
-- NFL: skipped the pre-1950s relocations (Decatur Staleys, Toledo
-- Maroons, Cleveland Bulldogs, Pottsville Maroons, Dayton Triangles,
-- Portsmouth Spartans) — same reasoning as the old England rugby league
-- clubs, nobody realistically has jersey photos from a 1920s barnstorming
-- team. Kept everything from the merger/expansion era onward.
--
-- Colours are well-known/confident for nearly all of these (they're
-- major US pro sports franchises with well-documented history).
-- Safe to re-run.

-- ============ NBA (relocated franchises) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('new-york-nets','nba','New York Nets','#00754A','#FFFFFF', false,
   'Relocated and renamed the New Jersey Nets in 1977.'),
  ('new-jersey-nets','nba','New Jersey Nets','#002A60','#FFFFFF', false,
   'Relocated to Brooklyn in 2012, becoming the Brooklyn Nets.'),
  ('buffalo-braves','nba','Buffalo Braves','#F58426','#000000', false,
   'Relocated and renamed the San Diego Clippers in 1978.'),
  ('san-diego-clippers','nba','San Diego Clippers','#FFC72C','#000080', false,
   'Relocated to Los Angeles in 1984, becoming the Los Angeles Clippers.'),
  ('new-orleans-jazz','nba','New Orleans Jazz','#8B008B','#FFC72C', false,
   'Relocated to Utah in 1979, keeping the Jazz name.'),
  ('kansas-city-kings','nba','Kansas City Kings','#4A2C7F','#B3995D', false,
   'Relocated to Sacramento in 1985, keeping the Kings name.'),
  ('vancouver-grizzlies','nba','Vancouver Grizzlies','#00205B','#A7A8AA', false,
   'Relocated to Memphis in 2001, keeping the Grizzlies name.'),
  ('charlotte-hornets-1988','nba','Charlotte Hornets (1988-2002)','#00788C','#1D1160', false,
   'Relocated to New Orleans in 2002 (New Orleans Hornets), later renamed the New Orleans Pelicans in 2013. A separate, unrelated expansion franchise later took the Charlotte Hornets name from 2014.'),
  ('seattle-supersonics','nba','Seattle SuperSonics','#00653A','#FFC200', false,
   'Relocated to Oklahoma City in 2008, becoming the Thunder.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- ============ NFL (relocated franchises) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('chicago-cardinals','nfl','Chicago Cardinals','#97233F','#000000', false,
   'Relocated to St. Louis in 1960.'),
  ('st-louis-cardinals-nfl','nfl','St. Louis Cardinals (NFL)','#97233F','#FFFFFF', false,
   'Relocated to Phoenix in 1988 (Phoenix Cardinals), later renamed the Arizona Cardinals in 1994.'),
  ('phoenix-cardinals','nfl','Phoenix Cardinals','#97233F','#FFFFFF', false,
   'Renamed the Arizona Cardinals in 1994.'),
  ('cleveland-rams','nfl','Cleveland Rams','#004C54','#FFA300', false,
   'Relocated to Los Angeles in 1946.'),
  ('st-louis-rams','nfl','St. Louis Rams','#003594','#FFD100', false,
   'Relocated back to Los Angeles in 2016.'),
  ('san-diego-chargers','nfl','San Diego Chargers','#0073CF','#FFC20E', false,
   'Relocated back to Los Angeles in 2017.'),
  ('dallas-texans-afl','nfl','Dallas Texans (AFL)','#E31837','#FFB81C', false,
   'Relocated to Kansas City in 1963, becoming the Chiefs.'),
  ('oakland-raiders','nfl','Oakland Raiders','#000000','#A5ACAF', false,
   'Relocated to Las Vegas in 2020.'),
  ('baltimore-colts','nfl','Baltimore Colts','#002C5F','#FFFFFF', false,
   'Relocated to Indianapolis in 1984.'),
  ('boston-redskins','nfl','Boston Redskins','#5A1414','#FFB612', false,
   'Relocated to Washington, D.C. in 1937; the franchise was renamed the Washington Commanders in 2022.'),
  ('houston-oilers','nfl','Houston Oilers','#00143F','#C41230', false,
   'Relocated to Tennessee in 1997 (briefly as the Tennessee Oilers), renamed the Titans in 1999.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- ============ MLB (defunct/relocated franchises) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('boston-braves','mlb','Boston Braves','#0C2340','#BD3039', false,
   'Relocated to Milwaukee in 1953, then Atlanta in 1966.'),
  ('milwaukee-braves','mlb','Milwaukee Braves','#0C2340','#BD3039', false,
   'Relocated to Atlanta in 1966.'),
  ('st-louis-browns','mlb','St. Louis Browns','#003831','#FF6600', false,
   'Relocated to Baltimore in 1954, becoming the Orioles.'),
  ('philadelphia-athletics','mlb','Philadelphia Athletics','#003831','#EFB21E', false,
   'Relocated to Kansas City in 1955, then Oakland in 1968.'),
  ('kansas-city-athletics','mlb','Kansas City Athletics','#003831','#EFB21E', false,
   'Relocated to Oakland in 1968.'),
  ('new-york-giants-mlb','mlb','New York Giants','#FD5A1E','#000000', false,
   'Relocated to San Francisco in 1958.'),
  ('brooklyn-dodgers','mlb','Brooklyn Dodgers','#005A9C','#FFFFFF', false,
   'Relocated to Los Angeles in 1958.'),
  ('washington-senators-1','mlb','Washington Senators (1901-1960)','#BF0D3E','#14225A', false,
   'Relocated to Minnesota in 1961, becoming the Twins.'),
  ('washington-senators-2','mlb','Washington Senators (1961-1971)','#BF0D3E','#14225A', false,
   'Relocated to Texas in 1972, becoming the Rangers.'),
  ('seattle-pilots','mlb','Seattle Pilots','#044B31','#FFC425', false,
   'Relocated to Milwaukee after a single 1969 season, becoming the Brewers.'),
  ('montreal-expos','mlb','Montreal Expos','#003087','#E4002B', false,
   'Relocated to Washington, D.C. in 2005, becoming the Nationals.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- ============ MLS (former clubs) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('tampa-bay-mutiny','mls','Tampa Bay Mutiny','#8B0000','#FFC72C', false,
   'One of MLS''s ten inaugural (1996) clubs; folded after the 2001 season.'),
  ('miami-fusion','mls','Miami Fusion','#00843D','#FFC72C', false,
   'Joined MLS in 1998; folded after the 2001 season.'),
  ('chivas-usa','mls','Chivas USA','#A4343A','#000000', false,
   'Played 2005-2014 before folding, with the LA Galaxy''s market absorbing its slot.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- ============ NHL (defunct/relocated franchises) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('atlanta-flames','nhl','Atlanta Flames','#B22222','#FFC425', false,
   'Relocated to Calgary in 1980, keeping the Flames name.'),
  ('colorado-rockies-nhl','nhl','Colorado Rockies (NHL)','#8C1D40','#000000', false,
   'Relocated to New Jersey in 1982, becoming the Devils.'),
  ('minnesota-north-stars','nhl','Minnesota North Stars','#154734','#FFC425', false,
   'Relocated to Dallas in 1993, becoming the Stars.'),
  ('quebec-nordiques','nhl','Quebec Nordiques','#7B93A6','#AE2029', false,
   'Relocated to Denver in 1995, becoming the Avalanche.'),
  ('winnipeg-jets-1979','nhl','Winnipeg Jets (1979-1996)','#041E42','#AB0E2E', false,
   'Relocated to Phoenix in 1996, becoming the Coyotes. A new, unrelated Winnipeg Jets franchise (formerly the Atlanta Thrashers) has played since 2011.'),
  ('hartford-whalers','nhl','Hartford Whalers','#154734','#A4A9AD', false,
   'Relocated to North Carolina in 1997, becoming the Hurricanes.'),
  ('atlanta-thrashers','nhl','Atlanta Thrashers','#4A2183','#A6192E', false,
   'Relocated to Winnipeg in 2011, reviving the Jets name.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;
