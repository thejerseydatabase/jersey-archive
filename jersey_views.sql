-- Powers the new "Most Viewed" home page section. One row per
-- (jersey, viewer) - viewer_key is either a signed-in user's own id or
-- the same anonymous per-browser token (jd_client_token) already used
-- for report rate-limiting, so visiting the same jersey again later
-- from the same account/browser is a no-op (the unique constraint +
-- ignoreDuplicates on the app side), not a second view. A different
-- browser/device is a separate, genuine view - same as any such
-- system. Logged only for approved jerseys, and only on the jersey's
-- own page - see viewerKey()/the upsert in viewJerseyDetail.
--
-- Mirrors jersey_ratings' own shape: a plain table, publicly readable/
-- insertable (same policy style as `reports`, which already allows
-- anonymous inserts), plus a security_invoker view that does the
-- counting so the app never has to.
--
-- Safe to re-run.

create table if not exists jersey_views (
  id uuid primary key default gen_random_uuid(),
  jersey_id uuid not null references jerseys(id) on delete cascade,
  viewer_key text not null,
  viewed_at timestamptz not null default now(),
  unique (jersey_id, viewer_key)
);

alter table jersey_views enable row level security;
drop policy if exists "jersey views are publicly readable" on jersey_views;
create policy "jersey views are publicly readable" on jersey_views for select using (true);
drop policy if exists "anyone can log a jersey view" on jersey_views;
create policy "anyone can log a jersey view" on jersey_views for insert with check (true);

create index if not exists jersey_views_jersey_idx on jersey_views(jersey_id);

create or replace view jersey_view_counts with (security_invoker = true) as
  select jersey_id, count(*) as view_count
  from jersey_views
  group by jersey_id;
