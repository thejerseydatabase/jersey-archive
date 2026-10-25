-- Companion to rugby_sevens_women.sql - same reasoning (a separate
-- national side from the Wallabies/XVs squad, so its own competition
-- and team rows rather than a jersey `type` of "Sevens").
--
-- Men's international sevens teams, from
-- https://en.wikipedia.org/wiki/SVNS#Promotion_and_relegation
-- Current (2025-26) core 8: Argentina, Fiji, Spain, South Africa,
-- France, Australia, New Zealand, United States.
-- Former core teams: Great Britain, Kenya, Uruguay, Ireland, Samoa,
-- Canada, Japan, England, Scotland, Wales, Russia, Portugal.
-- Invited teams with a Top-15 Series finish: Chile, China, Cook
-- Islands, Georgia, Germany, Hong Kong, Italy, Jamaica, South Korea,
-- Morocco, Mexico, Namibia, Papua New Guinea, Tonga, Tunisia, Zimbabwe.
--
-- Colors are each country's standard national sporting/flag colors,
-- reused from rugby_sevens_women.sql and other international rosters on
-- the site where the same country already appears there.
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('rugby-sevens-men','rugby-union','Sevens Series (Men)','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  -- current core 8
  ('argentina','rugby-sevens-men','Argentina','#75AADB','#FFFFFF'),
  ('fiji','rugby-sevens-men','Fiji','#68C3F0','#FFFFFF'),
  ('spain','rugby-sevens-men','Spain','#AA151B','#F1BF00'),
  ('south-africa','rugby-sevens-men','South Africa','#007749','#FFB81C'),
  ('france','rugby-sevens-men','France','#0055A4','#FFFFFF'),
  ('australia','rugby-sevens-men','Australia','#00843D','#FFD700'),
  ('new-zealand','rugby-sevens-men','New Zealand','#000000','#FFFFFF'),
  ('united-states','rugby-sevens-men','United States','#002868','#BF0D3E'),
  -- former core teams
  ('great-britain','rugby-sevens-men','Great Britain','#C8102E','#012169'),
  ('kenya','rugby-sevens-men','Kenya','#006600','#BB0000'),
  ('uruguay','rugby-sevens-men','Uruguay','#65C0E8','#000000'),
  ('ireland','rugby-sevens-men','Ireland','#169B62','#FFFFFF'),
  ('samoa','rugby-sevens-men','Samoa','#0033A0','#FFFFFF'),
  ('canada','rugby-sevens-men','Canada','#FF0000','#FFFFFF'),
  ('japan','rugby-sevens-men','Japan','#BC002D','#FFFFFF'),
  ('england','rugby-sevens-men','England','#FFFFFF','#CE1124'),
  ('scotland','rugby-sevens-men','Scotland','#0065BD','#FFFFFF'),
  ('wales','rugby-sevens-men','Wales','#C8102E','#FFFFFF'),
  ('russia','rugby-sevens-men','Russia','#0039A6','#D52B1E'),
  ('portugal','rugby-sevens-men','Portugal','#006600','#FF0000'),
  -- invited teams with a top-15 series finish
  ('chile','rugby-sevens-men','Chile','#D52B1E','#FFFFFF'),
  ('china','rugby-sevens-men','China','#DE2910','#FFDE00'),
  ('cook-islands','rugby-sevens-men','Cook Islands','#006A4E','#FFFFFF'),
  ('georgia','rugby-sevens-men','Georgia','#9E1B32','#FFFFFF'),
  ('germany','rugby-sevens-men','Germany','#000000','#DD0000'),
  ('hong-kong','rugby-sevens-men','Hong Kong','#DE2910','#FFFFFF'),
  ('italy','rugby-sevens-men','Italy','#0066CC','#FFFFFF'),
  ('jamaica','rugby-sevens-men','Jamaica','#000000','#FED100'),
  ('south-korea','rugby-sevens-men','South Korea','#002868','#CD2E3A'),
  ('morocco','rugby-sevens-men','Morocco','#C1272D','#006233'),
  ('mexico','rugby-sevens-men','Mexico','#006847','#CE1126'),
  ('namibia','rugby-sevens-men','Namibia','#003580','#D21034'),
  ('papua-new-guinea','rugby-sevens-men','Papua New Guinea','#000000','#FFC72C'),
  ('tonga','rugby-sevens-men','Tonga','#C10000','#FFFFFF'),
  ('tunisia','rugby-sevens-men','Tunisia','#E70013','#FFFFFF'),
  ('zimbabwe','rugby-sevens-men','Zimbabwe','#006400','#FFD200')
on conflict (competition_slug, slug) do nothing;
