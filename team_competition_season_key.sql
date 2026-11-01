-- Follow-up to jersey_competition_slug.sql. The auto-sync trigger it added
-- always recomputes a team's current competition from whichever APPROVED
-- jersey on file has the most recent season - which breaks down when the
-- real world has moved on faster than anyone's uploaded kits for.
--
-- Case that surfaced this: Aston Villa are back in the Premier League
-- right now, but the most recent jersey actually logged for them is their
-- 2018-19 Championship kit (nothing from 2019-20 onward has been uploaded
-- yet). Correcting THAT jersey's own competition tag triggered an
-- auto-sync that - correctly, by the only logic it had - flipped Villa's
-- current competition to Championship, since that was genuinely the most
-- recent season on file.
--
-- Fix: a team's own competition page (the existing "Admin: team settings"
-- -> Competition control) can now set it with intent, stamping a sentinel
-- competition_season_key no real jersey season will ever out-rank. The
-- auto-sync trigger then only overwrites a team's competition when the
-- jersey driving it has a season at or above whatever key is already
-- stored - so a manual correction like Villa's sticks until it's
-- deliberately changed again, instead of getting silently reverted the
-- next time an older jersey for that team gets approved or re-tagged.
--
-- Teams nobody's ever manually corrected keep working exactly as before
-- (null just means "nothing's out-ranked yet, auto-sync freely").
--
-- Safe to re-run.

alter table teams add column if not exists competition_season_key numeric;

create or replace function sync_team_current_competition()
returns trigger language plpgsql as $$
declare
  latest record;
  team_key numeric;
begin
  if NEW.status = 'approved' and NEW.competition_slug is not null then
    select j.competition_slug, jersey_season_sort_key(j.season) as sort_key into latest
    from jerseys j
    where j.team_id = NEW.team_id and j.status = 'approved' and j.competition_slug is not null
    order by jersey_season_sort_key(j.season) desc, j.created_at desc
    limit 1;
    if latest.competition_slug is not null then
      select competition_season_key into team_key from teams where id = NEW.team_id;
      if team_key is null or latest.sort_key >= team_key then
        update teams set competition_slug = latest.competition_slug, competition_season_key = latest.sort_key
        where id = NEW.team_id and (competition_slug is distinct from latest.competition_slug or competition_season_key is distinct from latest.sort_key);
      end if;
    end if;
  end if;
  return NEW;
end;
$$;
