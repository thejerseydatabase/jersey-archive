-- Adds two more netball leagues: Netball Super League (England) and
-- the ANZ Premiership (New Zealand), current teams for each. Colours
-- are best-guess/lower-confidence across the board here — correct any
-- you know via the admin pencil-edit. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('netball-super-league','netball','Netball Super League','top'),
  ('anz-premiership','netball','ANZ Premiership','top')
on conflict (slug) do nothing;

-- ============ Netball Super League (England) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('birmingham-panthers','netball-super-league','Birmingham Panthers','#000000','#FFD700'),
  ('dragons-netball','netball-super-league','Dragons','#CE1126','#00843D'),
  ('leeds-rhinos-netball','netball-super-league','Leeds Rhinos','#002664','#FFB81C'),
  ('london-mavericks','netball-super-league','London Mavericks','#000000','#FFFFFF'),
  ('london-pulse','netball-super-league','London Pulse','#5C2D91','#000000'),
  ('loughborough-lightning','netball-super-league','Loughborough Lightning','#5C2D91','#FFD700'),
  ('manchester-thunder','netball-super-league','Manchester Thunder','#002664','#FFD700'),
  ('nottingham-forest-netball','netball-super-league','Nottingham Forest Netball','#DD0000','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ ANZ Premiership (New Zealand) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('northern-mystics','anz-premiership','Northern Mystics','#5C2D91','#000000'),
  ('northern-stars','anz-premiership','Northern Stars','#FFD700','#000000'),
  ('waikato-bay-of-plenty-magic','anz-premiership','Waikato Bay of Plenty Magic','#5C2D91','#FFD700'),
  ('central-pulse','anz-premiership','Central Pulse','#FFD700','#000000'),
  ('mainland-tactix','anz-premiership','Mainland Tactix','#CE1126','#000000'),
  ('southern-steel','anz-premiership','Southern Steel','#4A4A4A','#00843D')
on conflict (competition_slug, slug) do nothing;
