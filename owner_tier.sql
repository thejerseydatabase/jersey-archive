-- Splits "moderator" (is_admin — approves jerseys, moderates reports,
-- edits teams/comps) from "owner" (is_owner — the only account that can
-- grant or revoke moderator status). Without this, any moderator could
-- promote/demote other moderators via the new Moderators panel, since
-- is_admin was the only role that existed. Safe to re-run.

alter table profiles add column if not exists is_owner boolean not null default false;

-- Makes rugbyleaguejerseys@gmail.com's account the (initial) owner.
-- Re-running this is harmless — it just re-confirms the same account.
update profiles set is_owner = true
where id = (select id from auth.users where email = 'rugbyleaguejerseys@gmail.com');

-- Only self-edit, or an OWNER editing someone else's row, gets through
-- RLS now — a plain moderator (is_admin but not is_owner) can no longer
-- touch another user's profile row at all, which is what actually backs
-- the Moderators panel being owner-only (the UI hiding it is just the
-- visible half of this).
drop policy if exists "users can update their own profile, admins can update any" on profiles;
create policy "users can update their own profile, owners can update any"
  on profiles for update
  using (
    id = (select auth.uid())
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_owner)
  )
  with check (
    id = (select auth.uid())
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_owner)
  );

-- is_owner itself is never settable through the app at all — reserved
-- for direct SQL, same as this migration's own UPDATE above. is_admin
-- now requires the acting session to be an owner (not just any admin)
-- to change; points keeps its existing rule (any admin, since that's
-- how the approval-point triggers legitimately update it).
create or replace function protect_profile_privileged_columns()
returns trigger as $$
begin
  new.is_owner := old.is_owner;
  if not exists (select 1 from profiles p where p.id = auth.uid() and p.is_owner) then
    new.is_admin := old.is_admin;
  end if;
  if not exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin) then
    new.points := old.points;
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;
