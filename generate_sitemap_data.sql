-- Read-only - run this and send me the results (or export as CSV) and
-- I'll build the full sitemap.xml from it and commit it.
--
-- One row per real page that should go in the sitemap: every sport,
-- competition, and team that has at least one approved jersey - same
-- "actually has content" rule refreshFooterStats() already uses
-- elsewhere (a competition counts if a jersey is tagged with it
-- directly, even if the team's own current competition has since
-- moved on - the promoted/relegated case). Deliberately leaves out
-- season pages and individual jersey pages - the team page above them
-- already covers that content for a crawler, and that many extra URLs
-- would bloat the sitemap for very little real benefit.

with content as (
  select
    coalesce(jc.sport_slug, tc.sport_slug) as sport_slug,
    coalesce(j.competition_slug, t.competition_slug) as comp_slug,
    t.slug as team_slug,
    t.competition_slug as team_comp_slug,
    tc.sport_slug as team_sport_slug
  from jerseys j
  join teams t on t.id = j.team_id
  left join competitions jc on jc.slug = j.competition_slug
  left join competitions tc on tc.slug = t.competition_slug
  where j.status = 'approved'
)
select distinct '/sport/' || sport_slug as path, 1 as sort_order
from content where sport_slug is not null
union all
select distinct '/sport/' || sport_slug || '/' || comp_slug, 2
from content where sport_slug is not null and comp_slug is not null
union all
select distinct '/sport/' || team_sport_slug || '/' || team_comp_slug || '/team/' || team_slug, 3
from content where team_sport_slug is not null and team_comp_slug is not null and team_slug is not null
order by sort_order, path;
