-- Goes live sitewide - runs the full check_and_award_badges backfill
-- for every account, not just yours. The function already covers
-- everything (original 15 badges + context labels + the 7 Regions
-- badges), so this one call catches every existing member up on
-- whatever they already qualify for.
--
-- Safe to re-run.

select check_and_award_badges(id) from profiles;
