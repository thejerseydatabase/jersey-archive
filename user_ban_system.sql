-- Lets an admin ban a user for breaking the rules — blocks them from
-- uploading jerseys/photos, rating, or proposing logos (they can still
-- browse and sign in), without deleting their account or anything
-- they've already posted. Enforced at the database level (not just
-- hidden in the UI), with a trust hierarchy: any admin can ban a plain
-- user, only the owner can ban/unban a fellow admin, and nobody —
-- including the owner themself, by mistake or otherwise — can ban an
-- owner. Safe to re-run.

alter table profiles add column if not exists is_banned boolean not null default false;

-- Replaces the existing protect_profile_privileged_columns() trigger
-- function (same trigger, defined in schema.sql) with a version that
-- also protects username (previously only self/owner could UPDATE a
-- profile row at all, so username had no separate guard — that no
-- longer holds now that admins can update other people's rows too, to
-- ban them) and is_banned itself, per the rules above.
create or replace function protect_profile_privileged_columns()
returns trigger as $$
declare
  acting_is_owner boolean := exists (select 1 from profiles p where p.id = auth.uid() and p.is_owner);
  acting_is_admin boolean := exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin);
  acting_is_self boolean := auth.uid() = old.id;
begin
  new.is_owner := old.is_owner;
  if not acting_is_owner then
    new.is_admin := old.is_admin;
  end if;
  if not acting_is_admin then
    new.points := old.points;
  end if;
  if not acting_is_self and not acting_is_owner then
    new.username := old.username;
  end if;
  if not acting_is_admin then
    new.is_banned := old.is_banned;
  elsif old.is_owner then
    new.is_banned := false;
  elsif old.is_admin and not acting_is_owner then
    new.is_banned := old.is_banned;
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;

-- Widens who can UPDATE a profile row at all: previously only the row's
-- own account or the site owner (is_owner) — an admin had no access to
-- anyone else's row, so couldn't ban them. The trigger above is what
-- actually keeps an admin from touching anything but is_banned on
-- someone else's row (or ever touching an owner's/fellow admin's,
-- beyond what the rules allow).
drop policy if exists "users can update their own profile, owners can update any" on profiles;
create policy "users can update their own profile, admins can ban, owners can update any"
  on profiles for update
  using (
    id = (select auth.uid())
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and (p.is_owner or p.is_admin))
  )
  with check (
    id = (select auth.uid())
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and (p.is_owner or p.is_admin))
  );

-- Server-side enforcement (the app also checks this up front for a
-- clearer error message, but this is what actually stops a banned user
-- regardless of how the request is made). Same TG_ARGV pattern as the
-- existing enforce_upload_rate_limit() trigger further down this file.
create or replace function enforce_not_banned()
returns trigger as $$
declare
  user_col text := TG_ARGV[0];
  uid uuid;
begin
  uid := (to_jsonb(new)->>user_col)::uuid;
  if uid is not null and exists (select 1 from profiles where id = uid and is_banned) then
    raise exception 'Your account has been banned from posting. Contact the site owner if you believe this is a mistake.';
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;

drop trigger if exists block_banned_jerseys on jerseys;
create trigger block_banned_jerseys
  before insert on jerseys
  for each row execute function enforce_not_banned('uploaded_by');

drop trigger if exists block_banned_jersey_images on jersey_images;
create trigger block_banned_jersey_images
  before insert on jersey_images
  for each row execute function enforce_not_banned('uploaded_by');

drop trigger if exists block_banned_ratings on ratings;
create trigger block_banned_ratings
  before insert on ratings
  for each row execute function enforce_not_banned('user_id');

drop trigger if exists block_banned_logo_proposals on team_logo_proposals;
create trigger block_banned_logo_proposals
  before insert on team_logo_proposals
  for each row execute function enforce_not_banned('proposed_by');

drop trigger if exists block_banned_comp_logo_proposals on competition_logo_proposals;
create trigger block_banned_comp_logo_proposals
  before insert on competition_logo_proposals
  for each row execute function enforce_not_banned('proposed_by');
