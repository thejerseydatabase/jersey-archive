-- Adds SA20 (South Africa), LPL (Sri Lanka), ILT20 (UAE), MLC (USA),
-- CPL (West Indies), and New Zealand's domestic men's and women's
-- competitions (split since the source list explicitly marked the
-- women's sides with "(W)", same as the India/WPL split). Safe to re-run.
--
-- Several SA20/ILT20/MLC franchises share ownership groups with IPL
-- teams and use closely related colours — noted where that's the case.

insert into competitions (slug, sport_slug, name, tier) values
  ('sa20','cricket','SA20','more'),
  ('lpl','cricket','Lanka Premier League','more'),
  ('ilt20','cricket','ILT20','more'),
  ('mlc','cricket','Major League Cricket','more'),
  ('cpl','cricket','Caribbean Premier League','more'),
  ('new-zealand-domestic','cricket','New Zealand Domestic','more'),
  ('new-zealand-domestic-women','cricket','New Zealand Domestic (Women)','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('durbans-super-giants','sa20','Durban''s Super Giants','#00B2A9','#EC5C29'),
  ('joburg-super-kings','sa20','Joburg Super Kings','#FFD700','#0033A0'),
  ('mi-cape-town','sa20','MI Cape Town','#045093','#FFD700'),
  ('paarl-royals','sa20','Paarl Royals','#FF1493','#254AA5'),
  ('pretoria-capitals','sa20','Pretoria Capitals','#17479E','#EC1C24'),
  ('sunrisers-eastern-cape','sa20','Sunrisers Eastern Cape','#F26522','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('colombo-kaps','lpl','Colombo Kaps','#003893','#FFFFFF'),
  ('dambulla-sixers','lpl','Dambulla Sixers','#00843D','#FFFFFF'),
  ('galle-marvels','lpl','Galle Marvels','#5C2D91','#FFD700'),
  ('jaffna-kings','lpl','Jaffna Kings','#00693E','#FFD700'),
  ('kandy-falcons','lpl','Kandy Falcons','#003893','#CE1126')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('abu-dhabi-knight-riders','ilt20','Abu Dhabi Knight Riders','#2E0854','#FFD700'),
  ('chennai-brave-jaguars','ilt20','Chennai Brave Jaguars','#FFD700','#000000'),
  ('desert-vipers','ilt20','Desert Vipers','#00843D','#000000'),
  ('dubai-capitals','ilt20','Dubai Capitals','#17479E','#EC1C24'),
  ('gulf-giants','ilt20','Gulf Giants','#1B2133','#B3A369'),
  ('mi-emirates','ilt20','MI Emirates','#045093','#FFD700'),
  ('sharjah-warriorz','ilt20','Sharjah Warriorz','#00A9A5','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('los-angeles-knight-riders','mlc','Los Angeles Knight Riders','#2E0854','#FFD700'),
  ('mi-new-york','mlc','MI New York','#045093','#FFD700'),
  ('san-francisco-unicorns','mlc','San Francisco Unicorns','#EC008C','#5C2D91'),
  ('seattle-orcas','mlc','Seattle Orcas','#002664','#00A9A5'),
  ('texas-super-kings','mlc','Texas Super Kings','#FFD700','#0033A0'),
  ('washington-freedom','mlc','Washington Freedom','#002664','#CE1126')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('antigua-and-barbuda-falcons','cpl','Antigua and Barbuda Falcons','#CE1126','#FFFFFF'),
  ('barbados-royals','cpl','Barbados Royals','#003893','#FFD700'),
  ('guyana-amazon-warriors','cpl','Guyana Amazon Warriors','#00843D','#FFD700'),
  ('st-lucia-kings','cpl','St Lucia Kings','#FFD700','#000000'),
  ('trinbago-knight-riders','cpl','Trinbago Knight Riders','#7B1113','#2E0854'),
  ('st-kitts-and-nevis-patriots','cpl','St Kitts and Nevis Patriots','#CE1126','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('auckland-aces','new-zealand-domestic','Auckland Aces','#003893','#000000'),
  ('canterbury-kings','new-zealand-domestic','Canterbury Kings','#CE1126','#000000'),
  ('central-stags','new-zealand-domestic','Central Stags','#6A0032','#FFD700'),
  ('northern-brave','new-zealand-domestic','Northern Brave','#F57F17','#000000'),
  ('otago-volts','new-zealand-domestic','Otago Volts','#FFD700','#003893'),
  ('wellington-firebirds','new-zealand-domestic','Wellington Firebirds','#FFD700','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('auckland-hearts-w','new-zealand-domestic-women','Auckland Hearts (W)','#003893','#000000'),
  ('canterbury-magicians-w','new-zealand-domestic-women','Canterbury Magicians (W)','#CE1126','#000000'),
  ('central-hinds-w','new-zealand-domestic-women','Central Hinds (W)','#6A0032','#FFD700'),
  ('otago-sparks-w','new-zealand-domestic-women','Otago Sparks (W)','#FFD700','#003893'),
  ('wellington-blaze-w','new-zealand-domestic-women','Wellington Blaze (W)','#FFD700','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
