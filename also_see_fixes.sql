-- 1. Fixes Australia Domestic (cricket) still hiding under "More
--    competitions" — it had a sort_order set but was still tier='more',
--    which is what actually controls visibility.
-- 2. Renames a handful of men's/women's team pairs whose names didn't
--    quite match so the "Also see" link (just made smarter — it now also
--    recognises a trailing "Women"/"WFC"/"(Women)" as the same club, not
--    only byte-identical names) can actually connect them.
-- Safe to re-run.

update competitions set tier = 'top' where slug = 'australia-domestic';

-- AFLW naming to match the men's AFL club names exactly
update teams set name = 'Carlton Blues' where competition_slug = 'aflw' and slug = 'carlton-fc';
update teams set name = 'Greater Western Sydney Giants' where competition_slug = 'aflw' and slug = 'gws-giants';
update teams set name = 'St Kilda Saints' where competition_slug = 'aflw' and slug = 'st-kilda';

-- Super Rugby Pacific (Women) naming to match the men's competition
update teams set name = 'New South Wales Waratahs' where competition_slug = 'super-rugby-pacific-women' and slug = 'nsw-waratahs';
update teams set name = 'Queensland Reds' where competition_slug = 'super-rugby-pacific-women' and slug = 'qld-reds';

-- A-League Women: drop a redundant "FC" that isn't in the men's club name
update teams set name = 'Newcastle Jets Women' where competition_slug = 'a-league-women' and slug = 'newcastle-jets-fc-women';
update teams set name = 'Perth Glory Women' where competition_slug = 'a-league-women' and slug = 'perth-glory-fc-women';

-- Rugby league International (Women): match the "USA" spelling already
-- used everywhere else on the site instead of "United States"
update teams set slug = 'usa', name = 'USA' where competition_slug = 'international-rugby-league-women' and slug = 'united-states';
