-- Adds the current 20 RFL Championship (rugby league) teams to the
-- existing Championship competition. Safe to re-run.
--
-- Lower-confidence colours than the Super League ones — several of these
-- clubs I'm less certain of exact brand colours, flag anything off.

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('london-broncos','championship','London Broncos','#CE1126','#FFFFFF'),
  ('newcastle-thunder','championship','Newcastle Thunder','#F57F17','#000000'),
  ('oldham','championship','Oldham','#CE1126','#FFFFFF'),
  ('doncaster-rlfc','championship','Doncaster RLFC','#CE1126','#000000'),
  ('widnes-vikings','championship','Widnes Vikings','#000000','#FFD700'),
  ('barrow','championship','Barrow','#CE1126','#002664'),
  ('sheffield-eagles','championship','Sheffield Eagles','#6A0032','#FFD700'),
  ('midlands-hurricanes','championship','Midlands Hurricanes','#5C2D91','#000000'),
  ('whitehaven-rlfc','championship','Whitehaven RLFC','#FFD700','#000000'),
  ('batley-bulldogs','championship','Batley Bulldogs','#6A0032','#FFD700'),
  ('dewsbury-rams','championship','Dewsbury Rams','#003893','#FFFFFF'),
  ('salford-rlfc','championship','Salford RLFC','#CE1126','#000000'),
  ('hunslet','championship','Hunslet','#00693E','#FFD700'),
  ('goole-vikings','championship','Goole Vikings','#000000','#FFD700'),
  ('rochdale-hornets','championship','Rochdale Hornets','#000000','#FFD700'),
  ('keighley','championship','Keighley','#FFD700','#000000'),
  ('swinton','championship','Swinton','#003893','#FFFFFF'),
  ('workington','championship','Workington','#002664','#CE1126'),
  ('halifax','championship','Halifax','#003893','#FFFFFF'),
  ('north-wales-crusaders','championship','North Wales Crusaders','#CE1126','#00843D')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
