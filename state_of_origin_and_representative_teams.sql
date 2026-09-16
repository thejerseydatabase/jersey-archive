-- Adds two new rugby league competitions: State of Origin (NSW Blues vs
-- QLD Maroons) and Representative (all-star/exhibition sides — Indigenous
-- All Stars, NRL All Stars, Great Britain, the various city/country
-- origin sides, etc). Safe to re-run.
--
-- Colours for the representative sides especially are lower-confidence
-- placeholders — these are niche exhibition teams I don't have solid
-- brand-colour knowledge of, flag anything off.

insert into competitions (slug, sport_slug, name, tier) values
  ('state-of-origin','rugby-league','State of Origin','top'),
  ('representative','rugby-league','Representative','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('new-south-wales-blues','state-of-origin','New South Wales Blues','#003DA5','#FFFFFF'),
  ('queensland-maroons','state-of-origin','Queensland Maroons','#6A0032','#FFD700')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('africa-united','representative','Africa United','#009739','#FCD116'),
  ('asean','representative','ASEAN','#003399','#FFCC00'),
  ('australian-defence-force','representative','Australian Defence Force','#4B5320','#002664'),
  ('combined-all-stars','representative','Combined All Stars','#000000','#FFD700'),
  ('great-britain','representative','Great Britain','#00247D','#CF142B'),
  ('indigenous-all-stars','representative','Indigenous All Stars','#000000','#FFD700'),
  ('indigenous-dreamtime','representative','Indigenous Dreamtime','#CE1126','#000000'),
  ('latin-heat','representative','Latin Heat','#CE1126','#FFD700'),
  ('mediterranean','representative','Mediterranean','#0033A0','#FFFFFF'),
  ('nasca-aboriginal','representative','NASCA Aboriginal','#000000','#FFD700'),
  ('new-zealand-maori','representative','New Zealand Maori','#000000','#CE1126'),
  ('nrl-all-stars','representative','NRL All Stars','#002664','#FFD700'),
  ('nsw-city-origin','representative','NSW City Origin','#00AEEF','#002664'),
  ('nsw-country-origin','representative','NSW Country Origin','#00843D','#FFD700'),
  ('qld-city-origin','representative','QLD City Origin','#6A0032','#FFD700'),
  ('qld-country-origin','representative','QLD Country Origin','#6A0032','#FFFFFF'),
  ('qld-sapphires','representative','QLD Sapphires','#0033A0','#6A0032'),
  ('rest-of-the-world','representative','Rest of the World','#4B5563','#000000'),
  ('victoria','representative','Victoria','#002664','#FFD700'),
  ('western-australia','representative','Western Australia','#000000','#FFD700'),
  ('world-all-stars','representative','World All Stars','#002664','#FFD700')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
