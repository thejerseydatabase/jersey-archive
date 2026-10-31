-- Restores the Premier League competition's name - it was accidentally
-- overwritten to "Championship" via a jersey page's "Competition" pencil
-- edit, which renames the shared competitions row (every team under it),
-- not just that one jersey. No team's competition_slug actually changed -
-- Man City, Man United etc. were never moved, they just inherited the
-- wrong display name - so this one update fixes every team at once.
--
-- Safe to re-run.

update competitions set name = 'Premier League' where slug = 'premier-league';
