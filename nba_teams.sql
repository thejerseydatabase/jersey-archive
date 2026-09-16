-- Adds the NBA and its 30 teams. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('nba','basketball','NBA','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('boston-celtics','nba','Boston Celtics','#007A33','#FFFFFF'),
  ('los-angeles-lakers','nba','Los Angeles Lakers','#552583','#FDB927'),
  ('golden-state-warriors','nba','Golden State Warriors','#1D428A','#FFC72C'),
  ('chicago-bulls','nba','Chicago Bulls','#CE1141','#000000'),
  ('atlanta-hawks','nba','Atlanta Hawks','#E13A3E','#FDB927'),
  ('miami-heat','nba','Miami Heat','#98002E','#000000'),
  ('cleveland-cavaliers','nba','Cleveland Cavaliers','#6F263D','#FFB81C'),
  ('brooklyn-nets','nba','Brooklyn Nets','#000000','#FFFFFF'),
  ('denver-nuggets','nba','Denver Nuggets','#0E2240','#FEC524'),
  ('philadelphia-76ers','nba','Philadelphia 76ers','#006BB6','#ED174C'),
  ('san-antonio-spurs','nba','San Antonio Spurs','#C4CED4','#000000'),
  ('phoenix-suns','nba','Phoenix Suns','#1D1160','#E56020'),
  ('houston-rockets','nba','Houston Rockets','#CE1141','#000000'),
  ('new-york-knicks','nba','New York Knicks','#006BB6','#F58426'),
  ('charlotte-hornets','nba','Charlotte Hornets','#1D1160','#00788C'),
  ('indiana-pacers','nba','Indiana Pacers','#002D62','#FDBB30'),
  ('sacramento-kings','nba','Sacramento Kings','#5A2D81','#63727A'),
  ('washington-wizards','nba','Washington Wizards','#002B5C','#E31837'),
  ('los-angeles-clippers','nba','Los Angeles Clippers','#C8102E','#1D428A'),
  ('detroit-pistons','nba','Detroit Pistons','#1D42BA','#C8102E'),
  ('dallas-mavericks','nba','Dallas Mavericks','#00538C','#002B5E'),
  ('utah-jazz','nba','Utah Jazz','#002B5C','#F9A01B'),
  ('toronto-raptors','nba','Toronto Raptors','#CE1141','#000000'),
  ('minnesota-timberwolves','nba','Minnesota Timberwolves','#0C2340','#236192'),
  ('portland-trail-blazers','nba','Portland Trail Blazers','#E03A3E','#000000'),
  ('orlando-magic','nba','Orlando Magic','#0077C0','#000000'),
  ('milwaukee-bucks','nba','Milwaukee Bucks','#00471B','#EEE1C6'),
  ('oklahoma-city-thunder','nba','Oklahoma City Thunder','#007AC1','#EF3B24'),
  ('memphis-grizzlies','nba','Memphis Grizzlies','#5D76A9','#12173F'),
  ('new-orleans-pelicans','nba','New Orleans Pelicans','#0C2340','#B4975A')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
