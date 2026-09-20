-- Promotes VFL, SANFL and WAFL from the "more competitions" fold-out to the
-- AFL sport's top-level competition list, in the order requested:
-- AFL, AFLW, VFL, SANFL, WAFL (AFL=1 and AFLW=2 already set by
-- manufacturer_and_competition_cleanup.sql).
--
-- Safe to re-run.

update competitions set tier = 'top', sort_order = 3 where slug = 'vfl' and sport_slug = 'afl';
update competitions set tier = 'top', sort_order = 4 where slug = 'sanfl' and sport_slug = 'afl';
update competitions set tier = 'top', sort_order = 5 where slug = 'wafl' and sport_slug = 'afl';
