-- Two things, both needed for the new "Moderators" panel in the
-- moderation queue (search a username, toggle is_admin):
--
-- 1. Admins currently can't update anyone else's profile row at all —
--    the only existing policy is "users can update their own profile".
--    Merges that with a new admin case into one UPDATE policy (rather
--    than two separate permissive ones, avoiding the same
--    multiple_permissive_policies performance warning fixed earlier).
--
-- 2. While in here: closes a real gap that predates this change and
--    isn't specific to the new feature — the existing self-update
--    policy only checks ROW ownership, not which COLUMNS are being
--    changed, so any signed-in user could currently call the Supabase
--    client directly and set their own is_admin or points to anything.
--    RLS can't express "these columns only if you're an admin" on its
--    own, so this adds a BEFORE UPDATE trigger that silently resets
--    is_admin/points back to their previous value whenever the
--    person making the change isn't an admin. Doesn't affect the
--    legitimate paths that change these columns (the "Make/Remove
--    moderator" button, and the existing award_upload_point() /
--    award_logo_point() / award_comp_logo_point() triggers) since
--    those only ever run as a result of an admin action.
--
-- Safe to re-run.

drop policy if exists "users can update their own profile" on profiles;
create policy "users can update their own profile, admins can update any"
  on profiles for update
  using (
    id = (select auth.uid())
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  )
  with check (
    id = (select auth.uid())
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  );

create function protect_profile_privileged_columns()
returns trigger as $$
begin
  if not exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin) then
    new.is_admin := old.is_admin;
    new.points := old.points;
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;

drop trigger if exists protect_profile_privileged_columns on profiles;
create trigger protect_profile_privileged_columns
  before update on profiles
  for each row execute function protect_profile_privileged_columns();
