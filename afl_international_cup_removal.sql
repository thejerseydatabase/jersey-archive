-- Removes the AFL International Cup competition (not wanted). It's a
-- tag_only competition with no teams of its own, so this is just the one
-- row — any jersey_competitions tag pointing at it cascades away too
-- (jersey_competitions.competition_slug references competitions(slug)
-- on delete cascade), same as the IFAF World Championship removal.
-- Safe to re-run.

delete from competitions where slug = 'afl-international-cup';
