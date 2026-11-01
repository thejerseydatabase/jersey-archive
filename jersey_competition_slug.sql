-- Makes competition a property of each JERSEY instead of only the team.
-- This is the fix for the whole "Aston Villa got renamed to Championship"
-- class of bug: a jersey's competition pencil-edit used to rename the
-- shared competitions row (every team under it), because there was no
-- per-jersey place to record "this one was Championship" separately from
-- "this team's current competition is Premier League". Now there is.
--
-- What this does:
--   1. Adds jerseys.competition_slug - the competition actually picked at
--      upload time (or corrected afterward), owned by that one jersey.
--   2. Backfills it from each jersey's current team, so nothing existing
--      becomes ambiguous.
--   3. Adds a trigger that keeps a team's own competition_slug (its
--      "current"/default competition, shown on its own page URL etc.) in
--      sync automatically - whenever a jersey is approved or its
--      competition is corrected, if that jersey's season is the most
--      recent one the team has among its approved jerseys, the team's
--      own competition_slug updates to match. No manual upkeep needed -
--      promote Hull City to the Premier League for the first time in
--      years, approve this season's kit tagged Premier League, done.
--
-- Safe to re-run.

alter table jerseys add column if not exists competition_slug text references competitions(slug);

update jerseys j
set competition_slug = t.competition_slug
from teams t
where j.team_id = t.id and j.competition_slug is null;

-- Sort key for "most recent season" - same shape as the site's own JS
-- seasonSortKey, except "Unknown" sorts LOWEST here (-1), not highest.
-- seasonSortKey treats Unknown as effectively "most recent" for display-
-- ordering reasons that don't apply here - an Unknown-season jersey is
-- almost always an old/vintage one with no recorded year, and letting it
-- win "most recent" would wrongly drag a team's current competition back
-- to whatever that old jersey happened to be tagged with.
create or replace function jersey_season_sort_key(season text)
returns numeric language sql immutable as $$
  select case
    when season ~ '^[0-9]{4}' then
      (substring(season from '^[0-9]{4}'))::numeric + (case when season ~ '-' then 0.5 else 0 end)
    else -1
  end;
$$;

create or replace function sync_team_current_competition()
returns trigger language plpgsql as $$
declare
  latest record;
begin
  if NEW.status = 'approved' and NEW.competition_slug is not null then
    select j.competition_slug into latest
    from jerseys j
    where j.team_id = NEW.team_id and j.status = 'approved' and j.competition_slug is not null
    order by jersey_season_sort_key(j.season) desc, j.created_at desc
    limit 1;
    if latest.competition_slug is not null then
      update teams set competition_slug = latest.competition_slug
      where id = NEW.team_id and competition_slug is distinct from latest.competition_slug;
    end if;
  end if;
  return NEW;
end;
$$;

drop trigger if exists trg_sync_team_current_competition on jerseys;
create trigger trg_sync_team_current_competition
  after insert or update of competition_slug, season, status, team_id on jerseys
  for each row
  execute function sync_team_current_competition();
