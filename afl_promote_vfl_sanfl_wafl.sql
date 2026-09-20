-- Promotes VFL, SANFL and WAFL from the "more competitions" fold-out to the
-- AFL sport's top-level competition list, in the order requested:
-- AFL, AFLW, VFL, SANFL, WAFL.
--
-- AFLW's sort_order=2 was supposed to already be set by
-- manufacturer_and_competition_cleanup.sql, but it's showing up last on the
-- live site (defaulting to 999), meaning that update never actually landed -
-- so this version sets AFL and AFLW's order explicitly too, rather than
-- assuming they're already right.
--
-- Safe to re-run.

update competitions set sort_order = 1 where slug = 'afl' and sport_slug = 'afl';
update competitions set tier = 'top', sort_order = 2 where slug = 'aflw' and sport_slug = 'afl';
update competitions set tier = 'top', sort_order = 3 where slug = 'vfl' and sport_slug = 'afl';
update competitions set tier = 'top', sort_order = 4 where slug = 'sanfl' and sport_slug = 'afl';
update competitions set tier = 'top', sort_order = 5 where slug = 'wafl' and sport_slug = 'afl';
