-- Adds Baseball as a sport plus MLB and its 30 teams. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('mlb','baseball','MLB','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('arizona-diamondbacks','mlb','Arizona Diamondbacks','#A71930','#000000'),
  ('atlanta-braves','mlb','Atlanta Braves','#13274F','#CE1141'),
  ('baltimore-orioles','mlb','Baltimore Orioles','#DF4601','#000000'),
  ('boston-red-sox','mlb','Boston Red Sox','#BD3039','#0C2340'),
  ('chicago-cubs','mlb','Chicago Cubs','#0E3386','#CC3433'),
  ('chicago-white-sox','mlb','Chicago White Sox','#27251F','#C4CED4'),
  ('cincinnati-reds','mlb','Cincinnati Reds','#C6011F','#000000'),
  ('cleveland-guardians','mlb','Cleveland Guardians','#0C2340','#E31937'),
  ('colorado-rockies','mlb','Colorado Rockies','#333366','#000000'),
  ('detroit-tigers','mlb','Detroit Tigers','#0C2340','#FA4616'),
  ('houston-astros','mlb','Houston Astros','#002D62','#EB6E1F'),
  ('kansas-city-royals','mlb','Kansas City Royals','#004687','#BD9B60'),
  ('los-angeles-angels','mlb','Los Angeles Angels','#BA0021','#003263'),
  ('los-angeles-dodgers','mlb','Los Angeles Dodgers','#005A9C','#FFFFFF'),
  ('miami-marlins','mlb','Miami Marlins','#00A3E0','#EF3340'),
  ('milwaukee-brewers','mlb','Milwaukee Brewers','#12284B','#FFC52F'),
  ('minnesota-twins','mlb','Minnesota Twins','#002B5C','#D31145'),
  ('new-york-mets','mlb','New York Mets','#002D72','#FF5910'),
  ('new-york-yankees','mlb','New York Yankees','#003087','#FFFFFF'),
  ('oakland-athletics','mlb','Oakland Athletics','#003831','#EFB21E'),
  ('philadelphia-phillies','mlb','Philadelphia Phillies','#E81828','#002D72'),
  ('pittsburgh-pirates','mlb','Pittsburgh Pirates','#27251F','#FDB827'),
  ('san-diego-padres','mlb','San Diego Padres','#2F241D','#FFC425'),
  ('san-francisco-giants','mlb','San Francisco Giants','#FD5A1E','#27251F'),
  ('seattle-mariners','mlb','Seattle Mariners','#0C2C56','#005C5C'),
  ('st-louis-cardinals','mlb','St. Louis Cardinals','#C41E3A','#0C2340'),
  ('tampa-bay-rays','mlb','Tampa Bay Rays','#092C5C','#8FBCE6'),
  ('texas-rangers','mlb','Texas Rangers','#003278','#C0111F'),
  ('toronto-blue-jays','mlb','Toronto Blue Jays','#134A8E','#E8291C'),
  ('washington-nationals','mlb','Washington Nationals','#AB0003','#14225A')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
