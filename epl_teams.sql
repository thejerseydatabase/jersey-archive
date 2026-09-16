-- Adds the Premier League competition and its confirmed current 20 clubs
-- (2026-27 season). Colours are well-known club colours, used as the
-- fallback swatch until a real logo is uploaded. Safe to re-run.
--
-- Note: I could not reach footballkitarchive.com or Wikipedia directly to
-- read the Championship/League One/League Two lists (both are blocked from
-- this environment's web access) — those still need your team lists pasted
-- in before I can build their migrations confidently.

insert into competitions (slug, sport_slug, name, tier) values
  ('premier-league','football','Premier League','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('arsenal','premier-league','Arsenal','#EF0107','#FFFFFF'),
  ('aston-villa','premier-league','Aston Villa','#670E36','#95BFE5'),
  ('bournemouth','premier-league','AFC Bournemouth','#DA291C','#000000'),
  ('brentford','premier-league','Brentford','#E30613','#FFFFFF'),
  ('brighton-hove-albion','premier-league','Brighton & Hove Albion','#0057B8','#FFFFFF'),
  ('chelsea','premier-league','Chelsea','#034694','#FFFFFF'),
  ('coventry-city','premier-league','Coventry City','#78D0F1','#000000'),
  ('crystal-palace','premier-league','Crystal Palace','#1B458F','#C4122E'),
  ('everton','premier-league','Everton','#003399','#FFFFFF'),
  ('fulham','premier-league','Fulham','#FFFFFF','#000000'),
  ('hull-city','premier-league','Hull City','#F5A50A','#000000'),
  ('ipswich-town','premier-league','Ipswich Town','#0044A9','#FFFFFF'),
  ('leeds-united','premier-league','Leeds United','#FFFFFF','#1D428A'),
  ('liverpool','premier-league','Liverpool','#C8102E','#FFFFFF'),
  ('manchester-city','premier-league','Manchester City','#6CABDD','#FFFFFF'),
  ('manchester-united','premier-league','Manchester United','#DA291C','#FFFFFF'),
  ('newcastle-united','premier-league','Newcastle United','#241F20','#FFFFFF'),
  ('nottingham-forest','premier-league','Nottingham Forest','#E53233','#FFFFFF'),
  ('sunderland','premier-league','Sunderland','#EB172B','#FFFFFF'),
  ('tottenham-hotspur','premier-league','Tottenham Hotspur','#FFFFFF','#132257')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
