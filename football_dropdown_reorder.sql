-- Fixes competition ordering for football's "top"-tier list (used by the
-- upload form's competition dropdown and the sport page's competition
-- cards, both of which now sort by sort_order before name):
--
--   1. Pins International (Men), International (Women) and Premier
--      League to the very front. The old ranking from
--      manufacturer_and_competition_cleanup.sql (Premier League=1,
--      A-League=2, MLS=3, Bundesliga=4, Serie A=5, International=6,
--      A-League Women=7) is cleared back to the table's default so
--      everything else - including newer additions like NWSL and WSL
--      that never got a rank at all - falls back to plain alphabetical
--      order instead of being stuck after the old manually-ranked set.
--
--   2. Gives Bundesliga 2 and 3. Liga adjacent sort_order values so
--      3. Liga (whose name starts with a digit) sits right after
--      Bundesliga 2 within Germany's "more competitions" region group,
--      instead of sorting to the front of that group on a plain string
--      comparison.
--
-- Safe to re-run.

update competitions set sort_order = 999 where sport_slug = 'football' and tier = 'top';

update competitions set sort_order = 1 where slug = 'international-men' and sport_slug = 'football';
update competitions set sort_order = 2 where slug = 'international-women' and sport_slug = 'football';
update competitions set sort_order = 3 where slug = 'premier-league' and sport_slug = 'football';

update competitions set sort_order = 1 where slug = 'bundesliga-2' and sport_slug = 'football';
update competitions set sort_order = 2 where slug = '3-liga' and sport_slug = 'football';
