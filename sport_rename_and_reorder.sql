-- 1. Renames the "American Football" sport to "Gridiron" (slug stays
--    'american-football' — same approach already used for the AFL sport
--    being renamed to "Aussie Rules" without touching its slug, so no
--    existing team/competition/link breaks).
-- 2. Reorders the homepage sport grid to: Rugby League, Cricket,
--    Football, Rugby Union, Aussie Rules, Gridiron, Basketball,
--    Baseball, Ice Hockey, Netball, Field Hockey, Volleyball.
-- Safe to re-run.

update sports set name = 'Gridiron' where slug = 'american-football';

update sports set sort_order = 1 where slug = 'rugby-league';
update sports set sort_order = 2 where slug = 'cricket';
update sports set sort_order = 3 where slug = 'football';
update sports set sort_order = 4 where slug = 'rugby-union';
update sports set sort_order = 5 where slug = 'afl';
update sports set sort_order = 6 where slug = 'american-football';
update sports set sort_order = 7 where slug = 'basketball';
update sports set sort_order = 8 where slug = 'baseball';
update sports set sort_order = 9 where slug = 'ice-hockey';
update sports set sort_order = 10 where slug = 'netball';
update sports set sort_order = 11 where slug = 'field-hockey';
update sports set sort_order = 12 where slug = 'volleyball';
