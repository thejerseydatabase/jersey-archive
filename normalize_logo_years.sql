-- Fixes "years used" entries stored with a shortened two-digit end year
-- (e.g. "1978-90") so they read the same as properly four-digit ones
-- (e.g. "2014-2018") in Logo History. These came from the old free-text
-- years_used field before the propose-logo form was rebuilt into two
-- separate first/last-year number inputs (which always produces a full
-- four-digit string) - this is a one-time cleanup of what's already
-- stored; app.js's own normalizeYearsUsed() now catches it going forward
-- on the Logo History inline edit too.
--
-- The end year is expanded using the start year's own century, rolling
-- over to the next century if the short year is earlier than the start
-- year's last two digits (so "1999-02" becomes "1999-2002", not
-- "1999-1902"). Safe to re-run - rows already in "YYYY-YYYY" or
-- single-year form don't match the pattern and are left untouched.

update team_logos
set years_used = sub.start_year::text || '-' || sub.end_year::text
from (
  select id,
    start_year,
    case when end_year < start_year then end_year + 100 else end_year end as end_year
  from (
    select id,
      (substring(years_used from '^(\d{4})'))::int as start_year,
      (floor((substring(years_used from '^(\d{4})'))::int / 100) * 100
        + (substring(years_used from '-(\d{1,2})$'))::int)::int as end_year
    from team_logos
    where years_used ~ '^\d{4}-\d{1,2}$'
  ) raw
) sub
where team_logos.id = sub.id;

update competition_logos
set years_used = sub.start_year::text || '-' || sub.end_year::text
from (
  select id,
    start_year,
    case when end_year < start_year then end_year + 100 else end_year end as end_year
  from (
    select id,
      (substring(years_used from '^(\d{4})'))::int as start_year,
      (floor((substring(years_used from '^(\d{4})'))::int / 100) * 100
        + (substring(years_used from '-(\d{1,2})$'))::int)::int as end_year
    from competition_logos
    where years_used ~ '^\d{4}-\d{1,2}$'
  ) raw
) sub
where competition_logos.id = sub.id;

update team_logo_proposals
set years_used = sub.start_year::text || '-' || sub.end_year::text
from (
  select id,
    start_year,
    case when end_year < start_year then end_year + 100 else end_year end as end_year
  from (
    select id,
      (substring(years_used from '^(\d{4})'))::int as start_year,
      (floor((substring(years_used from '^(\d{4})'))::int / 100) * 100
        + (substring(years_used from '-(\d{1,2})$'))::int)::int as end_year
    from team_logo_proposals
    where years_used ~ '^\d{4}-\d{1,2}$'
  ) raw
) sub
where team_logo_proposals.id = sub.id;

update competition_logo_proposals
set years_used = sub.start_year::text || '-' || sub.end_year::text
from (
  select id,
    start_year,
    case when end_year < start_year then end_year + 100 else end_year end as end_year
  from (
    select id,
      (substring(years_used from '^(\d{4})'))::int as start_year,
      (floor((substring(years_used from '^(\d{4})'))::int / 100) * 100
        + (substring(years_used from '-(\d{1,2})$'))::int)::int as end_year
    from competition_logo_proposals
    where years_used ~ '^\d{4}-\d{1,2}$'
  ) raw
) sub
where competition_logo_proposals.id = sub.id;
