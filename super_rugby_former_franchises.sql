-- Two things for Super Rugby Pacific:
-- 1. Adds Moana Pasifika, a CURRENT team since 2022 that was missing
--    from the site entirely (not a former-franchise issue, just a gap).
-- 2. Adds 11 former Super Rugby franchises as defunct entries under the
--    existing 'super-rugby-pacific' competition (kept as one
--    competition throughout its Super 12 -> Super 14 -> Super Rugby ->
--    Super Rugby Pacific rebrands, rather than splitting into separate
--    era competitions like the rugby league ARL/NRL situation — Wikipedia
--    and everyone else treats this as one continuous competition, just
--    renamed, not parallel competing competitions).
--
-- Wikipedia's Super Rugby page says twelve former franchises; I could
-- only confidently account for eleven below — flag me if you know the
-- twelfth (possibly an earlier South African side, or a second Kings
-- stint counted separately).
--
-- Colours: the South African sides reuse their real, well-known club
-- colours; Jaguares/Sunwolves/Melbourne Rebels are reasonable
-- best-guesses. Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('moana-pasifika','super-rugby-pacific','Moana Pasifika','#CE1126','#FFD700')
on conflict (competition_slug, slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('jaguares','super-rugby-pacific','Jaguares','#75AADB','#FFFFFF', false,
   'Argentina''s Super Rugby franchise, 2016-2020; did not return after the competition split during the COVID-19 pandemic.'),
  ('sunwolves','super-rugby-pacific','Sunwolves','#CE1126','#000000', false,
   'Japan''s Super Rugby franchise, 2016-2020; left before the 2020 season finished.'),
  ('cheetahs','super-rugby-pacific','Cheetahs','#FFD700','#000000', false,
   'South African franchise, on and off from 1997, most recently 2020, before departing for South Africa''s domestic/European competitions.'),
  ('southern-kings','super-rugby-pacific','Southern Kings','#000000','#FFD700', false,
   'South African franchise, 2013 and 2016-2017.'),
  ('bulls','super-rugby-pacific','Bulls','#002664','#FFFFFF', false,
   'South African franchise until 2020, then departed with the other South African sides for the United Rugby Championship.'),
  ('lions-south-africa','super-rugby-pacific','Lions (South Africa)','#FFD700','#000000', false,
   'South African franchise, 1996-2012 and 2014-2020, then departed for the United Rugby Championship.'),
  ('sharks','super-rugby-pacific','Sharks','#000000','#FFD700', false,
   'South African franchise until 2020, then departed for the United Rugby Championship.'),
  ('stormers','super-rugby-pacific','Stormers','#002664','#FFFFFF', false,
   'South African franchise until 2020, then departed for the United Rugby Championship.'),
  ('griquas','super-rugby-pacific','Griquas','#000000','#FFD700', false,
   'Played only in the 2020 Super Rugby Unlocked season.'),
  ('pumas-south-africa','super-rugby-pacific','Pumas (South Africa)','#FFD700','#00843D', false,
   'Played only in the 2020 Super Rugby Unlocked season.'),
  ('melbourne-rebels','super-rugby-pacific','Melbourne Rebels','#002664','#FFD700', false,
   'Played 2011-2024; went into administration and was not retained for the 2025 season.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;
