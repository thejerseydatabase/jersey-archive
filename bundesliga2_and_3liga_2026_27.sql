-- Adds 3. Liga (Germany's 3rd tier) as a new "more"-tier football
-- competition with its 2026-27 roster, and realigns 2. Bundesliga for
-- the same promotion/relegation (source: en.wikipedia.org/wiki/2026%E2%80%9327_3._Liga):
--   - Fortuna Düsseldorf and Preußen Münster relegated OUT of 2.
--     Bundesliga into 3. Liga — marked former (is_active=false) on their
--     existing 2. Bundesliga row rather than deleted, so their
--     Bundesliga-2 jersey history stays exactly where it is, and get a
--     fresh row in 3. Liga for this season's kit. Same name on both
--     rows, so the "Also see" link between them is automatic.
--   - Energie Cottbus and VfL Osnabrück promoted INTO 2. Bundesliga
--     from 3. Liga — added as new 2. Bundesliga teams. They're not on
--     the 2026-27 3. Liga roster below since they've moved up out of it.
--
-- Three names from your 2. Bundesliga list — Wolfsburg, Heidenheim, and
-- St. Pauli — are added under BUNDESLIGA (tier 1) instead, not 2. Bundesliga:
-- to my knowledge VfL Wolfsburg has been an established Bundesliga club
-- for years, and both 1. FC Heidenheim and FC St. Pauli have been playing
-- Bundesliga football since being promoted in 2023 and 2024 respectively.
-- If any of the three has actually since dropped down to 2. Bundesliga,
-- let me know and I'll move it.
--
-- Team colors left at the default swatch for the new 3. Liga roster —
-- happy to fill specific ones in on request.
--
-- Safe to re-run.

-- ============ 3. Liga ============
insert into competitions (slug, sport_slug, name, tier, region_group) values
  ('3-liga','football','3. Liga','more','Germany')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name) values
  ('alemannia-aachen','3-liga','Alemannia Aachen'),
  ('msv-duisburg','3-liga','MSV Duisburg'),
  ('fortuna-dusseldorf','3-liga','Fortuna Düsseldorf'),
  ('rot-weiss-essen','3-liga','Rot-Weiss Essen'),
  ('sonnenhof-grossaspach','3-liga','Sonnenhof Großaspach'),
  ('tsv-havelse','3-liga','TSV Havelse'),
  ('tsg-hoffenheim-ii','3-liga','TSG Hoffenheim II'),
  ('fc-ingolstadt','3-liga','FC Ingolstadt'),
  ('fortuna-koln','3-liga','Fortuna Köln'),
  ('viktoria-koln','3-liga','Viktoria Köln'),
  ('waldhof-mannheim','3-liga','Waldhof Mannheim'),
  ('sv-meppen','3-liga','SV Meppen'),
  ('preussen-munster','3-liga','Preußen Münster'),
  ('jahn-regensburg','3-liga','Jahn Regensburg'),
  ('hansa-rostock','3-liga','Hansa Rostock'),
  ('1-fc-saarbrucken','3-liga','1. FC Saarbrücken'),
  ('vfb-stuttgart-ii','3-liga','VfB Stuttgart II'),
  ('sc-verl','3-liga','SC Verl'),
  ('wehen-wiesbaden','3-liga','Wehen Wiesbaden'),
  ('wurzburger-kickers','3-liga','Würzburger Kickers')
on conflict (competition_slug, slug) do nothing;

-- ============ 2. Bundesliga realignment ============
update teams set is_active = false,
  history_note = 'Relegated to 3. Liga for the 2026–27 season — see the 3. Liga team page for this season''s kits.'
  where competition_slug = 'bundesliga-2' and slug in ('fortuna-dusseldorf','preussen-munster');

insert into teams (slug, competition_slug, name, history_note) values
  ('energie-cottbus','bundesliga-2','Energie Cottbus','Official name: FC Energie Cottbus. Promoted from 3. Liga for the 2026–27 season.'),
  ('osnabruck','bundesliga-2','Osnabrück','Official name: VfL Osnabrück. Promoted from 3. Liga for the 2026–27 season.')
on conflict (competition_slug, slug) do update
  set history_note = excluded.history_note;

-- ============ Bundesliga (not 2. Bundesliga — see note above) ============
insert into teams (slug, competition_slug, name, history_note) values
  ('wolfsburg','bundesliga','Wolfsburg','Official name: VfL Wolfsburg.'),
  ('heidenheim','bundesliga','Heidenheim','Official name: 1. FC Heidenheim 1846.'),
  ('st-pauli','bundesliga','St. Pauli','Official name: FC St. Pauli.')
on conflict (competition_slug, slug) do nothing;
