-- Adds the ECHL as a more-tier ice-hockey competition, with its 26
-- teams for the 2026-27 season split into the four groups Wikipedia
-- lists them under (https://en.wikipedia.org/wiki/2026%E2%80%9327_ECHL_season),
-- stored in teams.conference: Eastern, South, Western, Mountain.
--
-- Colors: none of the 26 teams' Wikipedia infoboxes give hex codes,
-- only named colors (e.g. Cincinnati Cyclones: "Red, black, gray,
-- white"). These hex values are reasonable approximations of the two
-- most prominent named colors per team, not pulled from an official
-- brand guide - double-check/replace with exact hex if you have it.
-- Norfolk Admirals' infobox had no colors listed at all, so its colors
-- below are an unconfirmed navy/red placeholder only.
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('echl','ice-hockey','ECHL','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, conference) values
  -- Eastern
  ('greensboro-gargoyles','echl','Greensboro Gargoyles','#4B2E63','#C9A961','Eastern'),
  ('maine-mariners','echl','Maine Mariners','#003DA5','#006241','Eastern'),
  ('norfolk-admirals','echl','Norfolk Admirals','#002147','#C8102E','Eastern'),
  ('reading-royals','echl','Reading Royals','#702082','#F58025','Eastern'),
  ('trenton-ironhawks','echl','Trenton Ironhawks','#1C3F6E','#8A8D8F','Eastern'),
  ('trois-rivieres-lions','echl','Trois-Rivières Lions','#71797E','#003DA5','Eastern'),
  ('worcester-railers','echl','Worcester Railers','#4682B4','#8A8D8F','Eastern'),
  -- South
  ('florida-everblades','echl','Florida Everblades','#4CBB17','#8A8D8F','South'),
  ('greenville-swamp-rabbits','echl','Greenville Swamp Rabbits','#002147','#F58025','South'),
  ('jacksonville-icemen','echl','Jacksonville Icemen','#002147','#C4D8E2','South'),
  ('orlando-solar-bears','echl','Orlando Solar Bears','#5B2A86','#71EEB8','South'),
  ('savannah-ghost-pirates','echl','Savannah Ghost Pirates','#0B0B0B','#00843D','South'),
  ('south-carolina-stingrays','echl','South Carolina Stingrays','#002147','#C8102E','South'),
  -- Western
  ('cincinnati-cyclones','echl','Cincinnati Cyclones','#C8102E','#000000','Western'),
  ('fort-wayne-komets','echl','Fort Wayne Komets','#F58025','#000000','Western'),
  ('indy-fuel','echl','Indy Fuel','#C8102E','#FFC72C','Western'),
  ('kalamazoo-wings','echl','Kalamazoo Wings','#C8102E','#002868','Western'),
  ('toledo-walleye','echl','Toledo Walleye','#A7D8E8','#002868','Western'),
  ('wheeling-nailers','echl','Wheeling Nailers','#000000','#FFC72C','Western'),
  -- Mountain
  ('idaho-steelheads','echl','Idaho Steelheads','#002868','#A7A9AC','Mountain'),
  ('kansas-city-mavericks','echl','Kansas City Mavericks','#000000','#F58025','Mountain'),
  ('rapid-city-rush','echl','Rapid City Rush','#C8102E','#000000','Mountain'),
  ('new-mexico-goatheads','echl','New Mexico Goatheads','#B7410E','#D8C3A5','Mountain'),
  ('tahoe-knight-monsters','echl','Tahoe Knight Monsters','#4FC3E8','#FFC72C','Mountain'),
  ('tulsa-oilers','echl','Tulsa Oilers','#002868','#6F263D','Mountain'),
  ('wichita-thunder','echl','Wichita Thunder','#003DA5','#000000','Mountain')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, conference = excluded.conference;
