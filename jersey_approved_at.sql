-- "Latest Updates" (and the home/sport-page "Recently added" preview)
-- sorted jerseys by created_at - when they were UPLOADED - so approving
-- out of upload order made the feed jump around instead of reading as
-- "what's actually just gone live". This adds a proper approved_at
-- timestamp, set once by a trigger the moment a jersey's status actually
-- flips to 'approved' (same condition award_upload_point already uses),
-- so app.js can sort and date-label those pages by approval time instead.
--
-- Existing approved jerseys get approved_at backfilled from created_at
-- as a reasonable one-time approximation (their real approval time was
-- never recorded) - everything approved from here on gets the real
-- timestamp.
--
-- Safe to re-run.

alter table jerseys add column if not exists approved_at timestamptz;

create or replace function set_jersey_approved_at()
returns trigger as $$
begin
  if new.status = 'approved' and (old.status is distinct from 'approved') then
    new.approved_at := now();
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;

drop trigger if exists on_jersey_approved_at on jerseys;
create trigger on_jersey_approved_at
  before update of status on jerseys
  for each row execute function set_jersey_approved_at();

update jerseys set approved_at = created_at where status = 'approved' and approved_at is null;
