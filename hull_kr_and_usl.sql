-- 1. Renames Super League's "Hull KR" to "Hull Kingston Rovers" (slug
--    stays 'hull-kr' so nothing else breaks). Searching "hull kr" still
--    finds it — that's handled in code via a search alias, not data.
-- 2. Adds USL Championship (25 teams) and USL League One (17 teams) as
--    new football competitions.
--
-- Colours: real ones used where I'm confident (Tampa Bay Rowdies,
-- Louisville City, Sacramento Republic, New York Cosmos and others with
-- well-known identities); several of the newest expansion clubs
-- (Brooklyn FC, Lexington SC, Corpus Christi FC, Fort Wayne FC, FC
-- Naples, Sarasota Paradise, Westchester SC, Athletic Club Boise, AV
-- Alta FC) don't have an established brand I know of yet, so those are
-- generic placeholders. Safe to re-run.

update teams set name = 'Hull Kingston Rovers' where competition_slug = 'super-league' and slug = 'hull-kr';

insert into competitions (slug, sport_slug, name, tier) values
  ('usl-championship','football','USL Championship','more'),
  ('usl-league-one','football','USL League One','more')
on conflict (slug) do nothing;

-- ============ USL Championship ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('birmingham-legion-fc','usl-championship','Birmingham Legion FC','#000000','#FFC72C'),
  ('brooklyn-fc','usl-championship','Brooklyn FC','#000000','#FFFFFF'),
  ('charleston-battery','usl-championship','Charleston Battery','#002B5C','#FFD200'),
  ('colorado-springs-switchbacks-fc','usl-championship','Colorado Springs Switchbacks FC','#00843D','#000000'),
  ('detroit-city-fc','usl-championship','Detroit City FC','#BA0C2F','#000000'),
  ('el-paso-locomotive-fc','usl-championship','El Paso Locomotive FC','#F26522','#000000'),
  ('fc-tulsa','usl-championship','FC Tulsa','#003DA5','#FFD200'),
  ('hartford-athletic','usl-championship','Hartford Athletic','#00A3AD','#000000'),
  ('indy-eleven','usl-championship','Indy Eleven','#002F6C','#FFD200'),
  ('las-vegas-lights-fc','usl-championship','Las Vegas Lights FC','#EC008C','#000000'),
  ('lexington-sc','usl-championship','Lexington SC','#003DA5','#FFFFFF'),
  ('loudoun-united-fc','usl-championship','Loudoun United FC','#041E42','#CE1126'),
  ('louisville-city-fc','usl-championship','Louisville City FC','#6A1B9A','#FFD200'),
  ('miami-fc','usl-championship','Miami FC','#000000','#F58426'),
  ('monterey-bay-fc','usl-championship','Monterey Bay FC','#00843D','#0C2340'),
  ('new-mexico-united','usl-championship','New Mexico United','#000000','#00A6A6'),
  ('oakland-roots-sc','usl-championship','Oakland Roots SC','#00843D','#FFD200'),
  ('orange-county-sc','usl-championship','Orange County SC','#002F6C','#F58426'),
  ('phoenix-rising-fc','usl-championship','Phoenix Rising FC','#CE1126','#000000'),
  ('pittsburgh-riverhounds-sc','usl-championship','Pittsburgh Riverhounds SC','#FFC72C','#000000'),
  ('rhode-island-fc','usl-championship','Rhode Island FC','#002F6C','#00A3AD'),
  ('sacramento-republic-fc','usl-championship','Sacramento Republic FC','#4B2E83','#FFD200'),
  ('san-antonio-fc','usl-championship','San Antonio FC','#CE1126','#000000'),
  ('sporting-club-jacksonville','usl-championship','Sporting Club Jacksonville','#003DA5','#FFFFFF'),
  ('tampa-bay-rowdies','usl-championship','Tampa Bay Rowdies','#FFD200','#00843D')
on conflict (competition_slug, slug) do nothing;

-- ============ USL League One ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('athletic-club-boise','usl-league-one','Athletic Club Boise','#003DA5','#FFFFFF'),
  ('av-alta-fc','usl-league-one','AV Alta FC','#000000','#FFFFFF'),
  ('charlotte-independence','usl-league-one','Charlotte Independence','#002F6C','#FFD200'),
  ('chattanooga-red-wolves-sc','usl-league-one','Chattanooga Red Wolves SC','#CE1126','#000000'),
  ('corpus-christi-fc','usl-league-one','Corpus Christi FC','#003DA5','#FFFFFF'),
  ('fort-wayne-fc','usl-league-one','Fort Wayne FC','#000000','#FFFFFF'),
  ('forward-madison-fc','usl-league-one','Forward Madison FC','#F72585','#000000'),
  ('greenville-triumph-sc','usl-league-one','Greenville Triumph SC','#002F6C','#FFD200'),
  ('fc-naples','usl-league-one','FC Naples','#003DA5','#FFFFFF'),
  ('new-york-cosmos','usl-league-one','New York Cosmos','#00843D','#FFFFFF'),
  ('one-knoxville-sc','usl-league-one','One Knoxville SC','#F58426','#000000'),
  ('portland-hearts-of-pine','usl-league-one','Portland Hearts of Pine','#002F6C','#CE1126'),
  ('richmond-kickers','usl-league-one','Richmond Kickers','#002F6C','#FFD200'),
  ('sarasota-paradise','usl-league-one','Sarasota Paradise','#003DA5','#FFFFFF'),
  ('spokane-velocity-fc','usl-league-one','Spokane Velocity FC','#FFD200','#000000'),
  ('union-omaha','usl-league-one','Union Omaha','#FFD200','#000000'),
  ('westchester-sc','usl-league-one','Westchester SC','#003DA5','#FFFFFF')
on conflict (competition_slug, slug) do nothing;
