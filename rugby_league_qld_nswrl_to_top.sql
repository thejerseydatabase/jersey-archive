-- QLD Cup and NSWRL (1908-1994) promoted into the featured
-- "Competitions" row (tier = 'top'), not just pinned to the top of
-- the Australia list below it.
--
-- Their sort_order pins from rugby_league_page_fixes.sql (1 and 2)
-- would have put them ahead of/tied with NRL and Super League in the
-- featured row, which isn't the point here - reset to the default so
-- they just fall in after the explicitly-ranked NRL/Super League/
-- NRLW/State of Origin, alongside International/Representative/
-- Rugby League World Cup.
--
-- Safe to re-run.

update competitions set tier = 'top', sort_order = 999 where slug in ('qld-cup', 'nswrl');
