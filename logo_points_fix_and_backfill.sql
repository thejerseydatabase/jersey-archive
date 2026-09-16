-- Fixes team-logo points not being awarded, and backfills the ones that
-- were already approved before this was wired up correctly.
--
-- What went wrong: the earlier award_logo_point trigger fired AFTER an
-- update, but the app's moderation "approve" action was still calling
-- .delete() on the proposal row — so the trigger's UPDATE never ran, and
-- no point was ever given. That was fixed on the app side, but this
-- migration (the actual trigger) was never run, so the fix had no effect.
--
-- Safe to re-run: a point_awarded flag on each proposal makes sure no one
-- is ever credited twice, whether this runs once, twice, or after the
-- trigger below has already handled newer approvals.

alter table team_logo_proposals add column if not exists point_awarded boolean not null default false;

-- Backfill: give credit for every already-approved proposal that hasn't
-- been paid out yet.
update profiles p
set points = points + sub.cnt
from (
  select proposed_by, count(*) as cnt
  from team_logo_proposals
  where status = 'approved' and point_awarded = false and proposed_by is not null
  group by proposed_by
) sub
where p.id = sub.proposed_by;

update team_logo_proposals
set point_awarded = true
where status = 'approved' and point_awarded = false;

-- Recreate the trigger as BEFORE update so it can flip point_awarded on
-- the same row it's crediting, guaranteeing it only ever fires once per
-- proposal even if something updates the row again later.
create or replace function award_logo_point()
returns trigger as $$
begin
  if new.status = 'approved' and (old.status is distinct from 'approved') and new.proposed_by is not null and not new.point_awarded then
    update profiles set points = points + 1 where id = new.proposed_by;
    new.point_awarded := true;
  end if;
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_logo_approved on team_logo_proposals;
create trigger on_logo_approved
  before update of status on team_logo_proposals
  for each row execute function award_logo_point();
