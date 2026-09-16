-- Adds American Football as a sport plus the NFL and its 32 teams.
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('nfl','american-football','NFL','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('arizona-cardinals','nfl','Arizona Cardinals','#97233F','#FFFFFF'),
  ('atlanta-falcons','nfl','Atlanta Falcons','#A71930','#000000'),
  ('baltimore-ravens','nfl','Baltimore Ravens','#241773','#000000'),
  ('buffalo-bills','nfl','Buffalo Bills','#00338D','#C60C30'),
  ('carolina-panthers','nfl','Carolina Panthers','#0085CA','#000000'),
  ('chicago-bears','nfl','Chicago Bears','#0B162A','#C83803'),
  ('cincinnati-bengals','nfl','Cincinnati Bengals','#FB4F14','#000000'),
  ('cleveland-browns','nfl','Cleveland Browns','#311D00','#FF3C00'),
  ('dallas-cowboys','nfl','Dallas Cowboys','#041E42','#869397'),
  ('denver-broncos','nfl','Denver Broncos','#FB4F14','#002244'),
  ('detroit-lions','nfl','Detroit Lions','#0076B6','#B0B7BC'),
  ('green-bay-packers','nfl','Green Bay Packers','#203731','#FFB612'),
  ('houston-texans','nfl','Houston Texans','#03202F','#A71930'),
  ('indianapolis-colts','nfl','Indianapolis Colts','#002C5F','#FFFFFF'),
  ('jacksonville-jaguars','nfl','Jacksonville Jaguars','#006778','#000000'),
  ('kansas-city-chiefs','nfl','Kansas City Chiefs','#E31837','#FFB81C'),
  ('las-vegas-raiders','nfl','Las Vegas Raiders','#000000','#A5ACAF'),
  ('los-angeles-chargers','nfl','Los Angeles Chargers','#0080C6','#FFC20E'),
  ('los-angeles-rams','nfl','Los Angeles Rams','#003594','#FFA300'),
  ('miami-dolphins','nfl','Miami Dolphins','#008E97','#FC4C02'),
  ('minnesota-vikings','nfl','Minnesota Vikings','#4F2683','#FFC62F'),
  ('new-england-patriots','nfl','New England Patriots','#002244','#C60C30'),
  ('new-orleans-saints','nfl','New Orleans Saints','#101820','#D3BC8D'),
  ('new-york-giants','nfl','New York Giants','#0B2265','#A71930'),
  ('new-york-jets','nfl','New York Jets','#125740','#FFFFFF'),
  ('philadelphia-eagles','nfl','Philadelphia Eagles','#004C54','#A5ACAF'),
  ('pittsburgh-steelers','nfl','Pittsburgh Steelers','#FFB612','#101820'),
  ('san-francisco-49ers','nfl','San Francisco 49ers','#AA0000','#B3995D'),
  ('seattle-seahawks','nfl','Seattle Seahawks','#002244','#69BE28'),
  ('tampa-bay-buccaneers','nfl','Tampa Bay Buccaneers','#D50A0A','#34302B'),
  ('tennessee-titans','nfl','Tennessee Titans','#0C2340','#4B92DB'),
  ('washington-commanders','nfl','Washington Commanders','#5A1414','#FFB612')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
