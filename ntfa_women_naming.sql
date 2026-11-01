-- The find_duplicate_teams.sql results showed ~13 NTFA (Northern
-- Tasmanian Football Association) teams each with TWO rows sharing the
-- exact same name - e.g. two rows both just called "Bridgenorth". These
-- aren't duplicates: the slugs show one of each pair is the men's team
-- and the other (slug ending "-w") is the women's team, just inserted
-- without "Women" in the display name - so right now they're
-- indistinguishable in the team grid and neither would be picked up by
-- the site's own men's/women's split logic, which keys off the word
-- "Women" actually being in the name (see viewCompetition's
-- compIsWomensOnly/womenTeams).
--
-- This just appends " Women" to the display name of every "-w" team
-- under ntfa, matching the site's existing convention (A-League Women's
-- clubs, etc.) - doesn't touch slugs, colors, or any of the ones with no
-- "-w" suffix. None of these have any jerseys/logos yet, so there's
-- nothing else to reconcile.
--
-- Safe to re-run (idempotent - skips any row already ending in "Women").

update teams
set name = name || ' Women'
where competition_slug = 'ntfa' and slug like '%-w' and name not ilike '%women%';
