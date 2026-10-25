-- rugby_union_domestic_competitions.sql never set region_group on any of
-- its competitions, so every one of them (not just Élite 1 Féminine,
-- which is what got spotted) falls into the "More competitions" page's
-- catch-all "Other" bucket instead of being grouped under their actual
-- country - Top 14 and Pro D2 (France men's) have the exact same gap.
--
-- Safe to re-run.

update competitions set region_group = 'France'
where sport_slug = 'rugby-union' and slug in ('top-14','pro-d2','elite-1-feminine');
