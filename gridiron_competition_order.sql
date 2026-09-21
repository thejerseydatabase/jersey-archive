-- Puts NFL before CFL on the Gridiron sport page (currently falls back to
-- plain alphabetical since neither has a sort_order set, putting CFL
-- first). IFAF World Championship is left unset so it sorts after both,
-- via NULLS LAST — it's the tag-only international tournament, not one of
-- the two main competitions. Safe to re-run.

update competitions set sort_order = 1 where slug = 'nfl' and sport_slug = 'american-football';
update competitions set sort_order = 2 where slug = 'cfl' and sport_slug = 'american-football';
