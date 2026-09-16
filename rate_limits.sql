-- Basic spam protection before opening the site up more widely.
-- Additive only, safe to re-run.
--
-- Two layers:
-- 1. Signed-in actions (jersey uploads, added photos, logo proposals) are
--    capped per-user per-hour at the database level, so no amount of
--    client-side tampering can bypass it.
-- 2. Anonymous reports (no sign-in required, by design) are capped using a
--    random id the browser generates for itself (client_token) — not a
--    real security boundary since clearing site data resets it, but enough
--    to stop casual spam-clicking or a simple script.
-- A honeypot field on the report form (handled in the app, not here) also
-- silently drops obvious bots before they ever reach this API.

create or replace function enforce_upload_rate_limit()
returns trigger as $$
declare
  user_col text := TG_ARGV[0];
  max_count int := TG_ARGV[1]::int;
  window_minutes int := TG_ARGV[2]::int;
  uid uuid;
  recent_count int;
begin
  uid := (to_jsonb(new)->>user_col)::uuid;
  if uid is null then
    return new;
  end if;
  execute format(
    'select count(*) from %I where %I = $1 and created_at > now() - interval ''%s minutes''',
    TG_TABLE_NAME, user_col, window_minutes
  ) into recent_count using uid;
  if recent_count >= max_count then
    raise exception 'You are submitting too quickly — max % per % minutes. Please wait a bit and try again.', max_count, window_minutes;
  end if;
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists rate_limit_jerseys on jerseys;
create trigger rate_limit_jerseys
  before insert on jerseys
  for each row execute function enforce_upload_rate_limit('uploaded_by', 8, 60);

-- jersey_images was never given a created_at column (photos submitted with
-- a brand-new jersey didn't need one) — add it so the rate limit below has
-- something to measure against. Existing rows just get "now" as a default.
alter table jersey_images add column if not exists created_at timestamptz not null default now();

drop trigger if exists rate_limit_jersey_images on jersey_images;
create trigger rate_limit_jersey_images
  before insert on jersey_images
  for each row execute function enforce_upload_rate_limit('uploaded_by', 20, 60);

drop trigger if exists rate_limit_logo_proposals on team_logo_proposals;
create trigger rate_limit_logo_proposals
  before insert on team_logo_proposals
  for each row execute function enforce_upload_rate_limit('proposed_by', 5, 60);

-- ============ reports (can be anonymous, so rate-limited differently) ============
alter table reports add column if not exists client_token text;

create or replace function enforce_report_rate_limit()
returns trigger as $$
declare
  recent_count int;
begin
  if new.reported_by is not null then
    select count(*) into recent_count from reports
      where reported_by = new.reported_by and created_at > now() - interval '60 minutes';
  elsif new.client_token is not null then
    select count(*) into recent_count from reports
      where client_token = new.client_token and created_at > now() - interval '60 minutes';
  else
    recent_count := 0;
  end if;
  if recent_count >= 5 then
    raise exception 'Too many reports submitted recently. Please wait a while and try again.';
  end if;
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists rate_limit_reports on reports;
create trigger rate_limit_reports
  before insert on reports
  for each row execute function enforce_report_rate_limit();
