-- Lets a moderator credit someone for a contribution that doesn't fit
-- the normal uploaded_by/proposed_by slots - e.g. merging a duplicate
-- submission's back photo into the original jersey (admin re-uploads
-- it as themself, so the photo row's own uploaded_by says admin, not
-- whoever actually found/took the photo). Public credit, shown on the
-- jersey's own page next to "uploaded by" - a courtesy attribution,
-- not tied to the points system (points stay a deliberate separate
-- choice the admin makes per credit, not automatic - photo
-- contributions have never earned points on their own regardless).
--
-- Safe to re-run.

create table if not exists jersey_additional_credits (
  id uuid primary key default gen_random_uuid(),
  jersey_id uuid not null references jerseys(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  note text,
  added_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now()
);

alter table jersey_additional_credits enable row level security;

drop policy if exists "additional credits are publicly readable" on jersey_additional_credits;
create policy "additional credits are publicly readable"
  on jersey_additional_credits for select using (true);

drop policy if exists "admins can add additional credits" on jersey_additional_credits;
create policy "admins can add additional credits"
  on jersey_additional_credits for insert to authenticated
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));

drop policy if exists "admins can remove additional credits" on jersey_additional_credits;
create policy "admins can remove additional credits"
  on jersey_additional_credits for delete
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));

create index if not exists jersey_additional_credits_jersey_idx on jersey_additional_credits(jersey_id);
