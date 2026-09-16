-- Adds the NHL and its 33 teams (32 + Utah Mammoth). Arizona Coyotes are
-- marked is_active = false since the franchise relocated to Utah in 2024
-- — its jersey history stays right where it is under "Former teams" on
-- the NHL page. Utah Mammoth gets a history_note (shown on its team page,
-- same admin-editable field used for merged/relegated clubs elsewhere)
-- explaining it played its first season as "Utah Hockey Club" before the
-- rebrand. Safe to re-run.
--
-- Utah Mammoth's colours are a lower-confidence placeholder — it's a very
-- recent rebrand and I'm not fully certain of the exact palette.

insert into competitions (slug, sport_slug, name, tier) values
  ('nhl','ice-hockey','NHL','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('anaheim-ducks','nhl','Anaheim Ducks','#000000','#F47A38', true),
  ('arizona-coyotes','nhl','Arizona Coyotes','#8C2633','#000000', false),
  ('boston-bruins','nhl','Boston Bruins','#000000','#FFB81C', true),
  ('buffalo-sabres','nhl','Buffalo Sabres','#002654','#FCB514', true),
  ('calgary-flames','nhl','Calgary Flames','#C8102E','#F1BE48', true),
  ('carolina-hurricanes','nhl','Carolina Hurricanes','#CC0000','#000000', true),
  ('chicago-blackhawks','nhl','Chicago Blackhawks','#CF0A2C','#000000', true),
  ('colorado-avalanche','nhl','Colorado Avalanche','#6F263D','#236192', true),
  ('columbus-blue-jackets','nhl','Columbus Blue Jackets','#002654','#CE1126', true),
  ('dallas-stars','nhl','Dallas Stars','#006847','#000000', true),
  ('detroit-red-wings','nhl','Detroit Red Wings','#CE1126','#FFFFFF', true),
  ('edmonton-oilers','nhl','Edmonton Oilers','#FF4C00','#041E42', true),
  ('florida-panthers','nhl','Florida Panthers','#C8102E','#041E42', true),
  ('los-angeles-kings','nhl','Los Angeles Kings','#111111','#A2AAAD', true),
  ('minnesota-wild','nhl','Minnesota Wild','#154734','#A6192E', true),
  ('montreal-canadiens','nhl','Montreal Canadiens','#AF1E2D','#192168', true),
  ('nashville-predators','nhl','Nashville Predators','#FFB81C','#041E42', true),
  ('new-jersey-devils','nhl','New Jersey Devils','#CE1126','#000000', true),
  ('new-york-islanders','nhl','New York Islanders','#00539B','#F47D30', true),
  ('new-york-rangers','nhl','New York Rangers','#0038A8','#CE1126', true),
  ('ottawa-senators','nhl','Ottawa Senators','#C52032','#000000', true),
  ('philadelphia-flyers','nhl','Philadelphia Flyers','#F74902','#000000', true),
  ('pittsburgh-penguins','nhl','Pittsburgh Penguins','#000000','#FCB514', true),
  ('san-jose-sharks','nhl','San Jose Sharks','#006D75','#000000', true),
  ('seattle-kraken','nhl','Seattle Kraken','#001628','#99D9D9', true),
  ('st-louis-blues','nhl','St. Louis Blues','#002F87','#FCB514', true),
  ('tampa-bay-lightning','nhl','Tampa Bay Lightning','#002868','#FFFFFF', true),
  ('toronto-maple-leafs','nhl','Toronto Maple Leafs','#00205B','#FFFFFF', true),
  ('vancouver-canucks','nhl','Vancouver Canucks','#00205B','#00843D', true),
  ('vegas-golden-knights','nhl','Vegas Golden Knights','#B4975A','#333F42', true),
  ('washington-capitals','nhl','Washington Capitals','#C8102E','#041E42', true),
  ('winnipeg-jets','nhl','Winnipeg Jets','#041E42','#004C97', true)
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, is_active = excluded.is_active;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, history_note) values
  ('utah-mammoth','nhl','Utah Mammoth','#010101','#EFE9E0','Utah Hockey Club (2024-2025)')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, history_note = excluded.history_note;
