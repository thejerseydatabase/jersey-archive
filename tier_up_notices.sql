-- Congratulates a member when their points cross into a new reputation
-- tier (Reserve, Squad Player, Starter, Specialist, ... - see TIERS in
-- app.js). A trigger on profiles.points fires the moment an award
-- actually crosses a threshold, writes one row here, and app.js folds
-- it into the same unread-envelope badge jersey/logo message replies
-- already use - clicking it takes the member to their own profile page,
-- where the congratulations shows as a one-off banner and is marked
-- seen.
--
-- tier_label_for_points() duplicates the thresholds from the TIERS
-- array in app.js - if that array's cutoffs or labels ever change,
-- update this function to match (a plain SQL trigger can't read a JS
-- array). Only fires going forward: nothing here backfills a notice
-- for a tier a member already reached before this was added.
--
-- Safe to re-run.

create table if not exists tier_up_notices (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  tier_label text not null,
  points_at_time integer not null,
  seen boolean not null default false,
  created_at timestamptz not null default now()
);

alter table tier_up_notices enable row level security;

drop policy if exists "users can read their own tier notices" on tier_up_notices;
create policy "users can read their own tier notices"
  on tier_up_notices for select using ((select auth.uid()) = user_id);

-- Only lets a member flip seen on their own rows (what viewUserProfile
-- does once it's shown the banner) - no insert/delete policy, since
-- only the security-definer trigger below ever creates or removes these.
drop policy if exists "users can mark their own tier notices seen" on tier_up_notices;
create policy "users can mark their own tier notices seen"
  on tier_up_notices for update
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create index if not exists tier_up_notices_user_unseen_idx on tier_up_notices(user_id) where not seen;

create or replace function tier_label_for_points(pts integer)
returns text as $$
begin
  if pts >= 5000 then return 'G.O.A.T.';
  elsif pts >= 4000 then return 'Hall of Famer';
  elsif pts >= 3000 then return 'Legend';
  elsif pts >= 2000 then return 'Veteran';
  elsif pts >= 1000 then return 'All-Star';
  elsif pts >= 500 then return 'Captain';
  elsif pts >= 250 then return 'Specialist';
  elsif pts >= 100 then return 'Starter';
  elsif pts >= 50 then return 'Squad Player';
  elsif pts >= 25 then return 'Reserve';
  else return 'Rookie';
  end if;
end;
$$ language plpgsql immutable set search_path = public;

create or replace function notify_tier_up()
returns trigger as $$
begin
  if new.points > coalesce(old.points, 0)
     and tier_label_for_points(new.points) <> tier_label_for_points(coalesce(old.points, 0)) then
    insert into tier_up_notices (user_id, tier_label, points_at_time)
    values (new.id, tier_label_for_points(new.points), new.points);
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;

drop trigger if exists on_profile_tier_up on profiles;
create trigger on_profile_tier_up
  after update of points on profiles
  for each row execute function notify_tier_up();
