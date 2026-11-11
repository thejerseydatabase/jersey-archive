-- Three small fixes for the newly-uploaded North Ipswich Tigers jersey:
--
-- 1. The uploader typed "A-Grade" into Jersey type, which isn't a valid
--    type (Home/Away/Third/Alternate/Heritage/Training) - that's the
--    grade/division, not the kit variant, and this is their main strip.
-- 2. The competition they created, "IRL Ipswich Rugby League", only has
--    this one team/jersey in it so far - renaming it now to spell out
--    the grade (matching the site's existing "WARL First Grade" naming)
--    avoids ambiguity once Reserve Grade/C-Grade jerseys get added later
--    as their own separate competitions.
-- 3. Renaming the team to match the club's own branding/Facebook page
--    ("Norths Tigers") rather than the uploader's "North Ipswich Tigers".
--
-- Safe to re-run - each update is scoped tightly enough that running it
-- twice just does nothing the second time.

update jerseys
set type = 'Home'
where team_id = '005d43b0-41c5-4f5b-8831-9c00a3ac832f'
  and season = '2026'
  and type = 'A-Grade';

update competitions
set name = 'IRL Ipswich Rugby League A-Grade'
where slug = 'irl-ipswich-rugby-league';

update teams
set name = 'Norths Tigers'
where slug = 'north-ipswich-tigers'
  and competition_slug = 'irl-ipswich-rugby-league';
