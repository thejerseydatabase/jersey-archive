-- Adds the PWHL (Professional Women's Hockey League) as a top-tier
-- ice-hockey competition, with its 11 current teams split into the
-- Eastern/Western conferences (per
-- https://en.wikipedia.org/wiki/Professional_Women%27s_Hockey_League#Current_teams).
--
-- A 12th team, Detroit Clutch, was announced May 2026 for the 2026-27
-- season (Western Conference) but wasn't in the requested list, so it's
-- left out here - add it later the same way if/when it should go in.
--
-- Colors: each team's own Wikipedia infobox lists named colors (e.g.
-- "Forest green, aqua, navy, teal") but none give hex codes - these hex
-- values are reasonable approximations of the two most prominent named
-- colors, not pulled from an official brand guide. Double-check/replace
-- with exact hex if you have it, especially for the five newest
-- expansion teams (Hamilton, San Jose, Seattle, Vancouver, Vegas) whose
-- kits are very recent.
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('pwhl','ice-hockey','PWHL','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, conference) values
  ('boston-fleet','pwhl','Boston Fleet','#014421','#3EB6A0','Eastern'),
  ('hamilton-havoc','pwhl','Hamilton Havoc','#C9A961','#6F1D32','Eastern'),
  ('montreal-victoire','pwhl','Montreal Victoire','#7D1935','#D8C3A5','Eastern'),
  ('new-york-sirens','pwhl','New York Sirens','#30D5C8','#002147','Eastern'),
  ('ottawa-charge','pwhl','Ottawa Charge','#E4002B','#FFC72C','Eastern'),
  ('toronto-sceptres','pwhl','Toronto Sceptres','#004C97','#FFC72C','Eastern'),
  ('minnesota-frost','pwhl','Minnesota Frost','#5B2A86','#B57EDC','Western'),
  ('san-jose-sea-lions','pwhl','San Jose Sea Lions','#FF6B35','#1B6CA8','Western'),
  ('seattle-torrent','pwhl','Seattle Torrent','#4A5D52','#3E7CA6','Western'),
  ('vancouver-goldeneyes','pwhl','Vancouver Goldeneyes','#1C6E8C','#D4A017','Western'),
  ('vegas-vanguards','pwhl','Vegas Vanguards','#0B5D34','#C9A961','Western')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, conference = excluded.conference;
