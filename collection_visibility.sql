-- Lets a user make their collection private - not everyone wants what
-- they personally own visible to any visitor. Defaults to public (true)
-- so nothing changes for existing collection_items until someone
-- actually flips it off; the toggle lives on the profile page itself,
-- only shown to the profile's own owner.
--
-- No new RLS needed: "users can update their own profile" already lets
-- a user update any of their own profile row's columns (checked against
-- protect_profile_privileged_columns() - that trigger only locks down
-- is_owner/is_admin/points/username/is_banned specifically, nothing
-- else), so this column is covered by what's already there.
--
-- Safe to re-run.

alter table profiles add column if not exists collection_public boolean not null default true;
