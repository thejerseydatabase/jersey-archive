-- Merges the separate men's/women's "International" competitions into one
-- per sport, for the 5 sports where both actually exist (from the review
-- query results): baseball, basketball, football, ice hockey, rugby
-- league. Cricket, netball, and rugby union only have one international
-- competition each (no pair), so nothing to do there.
--
-- For each pair: every team in the women's competition gets " Women"
-- appended to its name (skipped if it already has "Women" in the name)
-- and re-slugged the same way, so it doesn't collide with a same-country
-- team already in the men's/open competition once moved across. The
-- women's competition is then deleted once empty, and the surviving
-- competition is renamed from "International (Men)" to plain
-- "International".
--
-- One real side effect: a bookmarked link to an individual women's
-- international team's page (under the old international-*-women slug)
-- will stop resolving, since that team now lives under the merged
-- competition's slug instead. Nothing links to it from elsewhere in the
-- site, so this only matters for a link saved outside the site itself.
--
-- Not run automatically twice-safe in the usual sense (re-running after
-- the women's competition is already deleted is a no-op, since the
-- update/delete statements below simply match zero rows).

-- Baseball
update teams set slug = slug || '-women', name = name || ' Women'
  where competition_slug = 'international-baseball-women' and name !~* '\bwomen\b';
update teams set competition_slug = 'international-baseball-men'
  where competition_slug = 'international-baseball-women';
delete from competitions where slug = 'international-baseball-women';
update competitions set name = 'International' where slug = 'international-baseball-men';

-- Basketball
update teams set slug = slug || '-women', name = name || ' Women'
  where competition_slug = 'international-basketball-women' and name !~* '\bwomen\b';
update teams set competition_slug = 'international-basketball-men'
  where competition_slug = 'international-basketball-women';
delete from competitions where slug = 'international-basketball-women';
update competitions set name = 'International' where slug = 'international-basketball-men';

-- Football
update teams set slug = slug || '-women', name = name || ' Women'
  where competition_slug = 'international-women' and name !~* '\bwomen\b';
update teams set competition_slug = 'international-men'
  where competition_slug = 'international-women';
delete from competitions where slug = 'international-women';
update competitions set name = 'International' where slug = 'international-men';

-- Ice hockey
update teams set slug = slug || '-women', name = name || ' Women'
  where competition_slug = 'international-ice-hockey-women' and name !~* '\bwomen\b';
update teams set competition_slug = 'international-ice-hockey-men'
  where competition_slug = 'international-ice-hockey-women';
delete from competitions where slug = 'international-ice-hockey-women';
update competitions set name = 'International' where slug = 'international-ice-hockey-men';

-- Rugby league
update teams set slug = slug || '-women', name = name || ' Women'
  where competition_slug = 'international-rugby-league-women' and name !~* '\bwomen\b';
update teams set competition_slug = 'international-rugby-league-men'
  where competition_slug = 'international-rugby-league-women';
delete from competitions where slug = 'international-rugby-league-women';
update competitions set name = 'International' where slug = 'international-rugby-league-men';
