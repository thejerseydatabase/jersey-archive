-- Lets a signed-in user mark a jersey as one they personally own,
-- separate from uploading/rating it. One row per user+jersey, shown as
-- a "Collection" section on that user's public profile page - public
-- the same way uploads, ratings and points already are, so a visitor
-- can see what someone actually owns, not just what they've logged.
--
-- Uses (select auth.uid()) rather than bare auth.uid()) per
-- rls_performance_fixes.sql's convention for new policies.
--
-- Safe to re-run.

create table if not exists collection_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  jersey_id uuid not null references jerseys(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (user_id, jersey_id)
);

alter table collection_items enable row level security;

drop policy if exists "collections are publicly readable" on collection_items;
create policy "collections are publicly readable"
  on collection_items for select using (true);

drop policy if exists "users can add to their own collection" on collection_items;
create policy "users can add to their own collection"
  on collection_items for insert to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "users can remove from their own collection" on collection_items;
create policy "users can remove from their own collection"
  on collection_items for delete
  using ((select auth.uid()) = user_id);

create index if not exists collection_items_user_idx on collection_items(user_id);
create index if not exists collection_items_jersey_idx on collection_items(jersey_id);

-- Same ban enforcement every other user-contributed table gets
-- (user_ban_system.sql's enforce_not_banned() trigger) - the UI already
-- hides the toggle for a banned account, but this is what actually
-- stops it regardless of how the request is made.
drop trigger if exists block_banned_collection_items on collection_items;
create trigger block_banned_collection_items
  before insert on collection_items
  for each row execute function enforce_not_banned('user_id');
