-- A handful of rugby-league sport-page organization fixes:
--
-- 1. "Championship" was filed under region_group Australia - it's the
--    English second-tier competition (alongside League One, National
--    League One etc.), so it moves to England. Pinned to sort_order 1
--    there too (it'd already sort first alphabetically, but pinning it
--    explicitly is safer against future additions).
-- 2. World Club Challenge demoted from tier 'top' (featured) to
--    'more' - it's a one-off NRL-vs-Super League exhibition, not a
--    whole-season competition, so it doesn't need permanent featured
--    placement. Left with no region_group (falls into the "Other"
--    bucket, same as International/Representative/Rugby League World
--    Cup already sit in while featured).
-- 3. QLD Cup and NSWRL (1908-1994) pinned to the top of the Australia
--    list (sort_order 1 and 2). NSW Cup's previous pin (sort_order 7)
--    is removed - it goes back to the alphabetical default with
--    everything else not explicitly pinned.
-- 4. CRL and IRL Ipswich Rugby League A-Grade were sitting in the
--    "Other" bucket (no region_group) - both are Australian
--    competitions, so they move into Australia.
-- 5. NSWRL (1908-1994)'s teams: 22 of 23 were marked is_active = false
--    ("Former teams"), with only Gold Coast - Tweed Giants showing as
--    current - looks like it tracked "has a jersey uploaded" rather
--    than any real current/former distinction, which doesn't mean
--    anything for a competition that ceased in 1994 anyway. All 23 set
--    to is_active = true.
--
-- Safe to re-run.

update competitions set region_group = 'England', sort_order = 1 where slug = 'championship';
update competitions set tier = 'more' where slug = 'world-club-challenge';
update competitions set sort_order = 1 where slug = 'qld-cup';
update competitions set sort_order = 2 where slug = 'nswrl';
update competitions set sort_order = 999 where slug = 'nsw-cup';
update competitions set region_group = 'Australia' where slug in ('crl', 'irl-ipswich-rugby-league');

update teams set is_active = true where competition_slug = 'nswrl';
