-- 1. Rugby union competition ordering: International first, then Super
--    Rugby Pacific, everything else falls back to alphabetical (resets
--    any earlier manual ordering on the rest so "whatever else" applies
--    cleanly).
-- 2. Renames "Dean Jones Cup" to "Dean Jones Trophy" (its real name).
-- Safe to re-run.

update competitions set sort_order = 999 where sport_slug = 'rugby-union';
update competitions set sort_order = 1 where sport_slug = 'rugby-union' and slug = 'international-rugby-union-men';
update competitions set sort_order = 2 where sport_slug = 'rugby-union' and slug = 'super-rugby-pacific';

update competitions set name = 'Dean Jones Trophy' where slug = 'dean-jones-cup';
