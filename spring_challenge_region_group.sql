-- Spring Challenge landed in the "Other" bucket on the cricket page since
-- it was created with no region_group set. Groups it under "Australia"
-- alongside the rest of Australian domestic cricket. Safe to re-run.

update competitions
set region_group = 'Australia'
where sport_slug = 'cricket' and name ilike 'Spring Challenge';
