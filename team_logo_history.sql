-- Keeps every past logo instead of losing it when a new one is approved,
-- and lets an admin label each one with the years it was used (e.g.
-- "1990–1999") via a pencil icon in the Logo history panel.
-- Safe to run even if you already ran an earlier version of this file.

create table if not exists team_logos (
  id uuid primary key default gen_random_uuid(),
  team_id uuid not null references teams(id) on delete cascade,
  storage_path text not null,
  is_current boolean not null default false,
  approved_at timestamptz not null default now()
);

alter table team_logos add column if not exists years_used text;

alter table team_logos enable row level security;

drop policy if exists "team logo history is publicly readable" on team_logos;
create policy "team logo history is publicly readable" on team_logos for select using (true);

drop policy if exists "admins can add to team logo history" on team_logos;
create policy "admins can add to team logo history"
  on team_logos for insert to authenticated
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

drop policy if exists "admins can update team logo history" on team_logos;
create policy "admins can update team logo history"
  on team_logos for update
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

-- backfill: whatever logo a team already has becomes its first history entry
-- (skipped if it's already there, e.g. from an earlier run of this file)
insert into team_logos (team_id, storage_path, is_current, approved_at)
select t.id, t.logo_path, true, now()
from teams t
where t.logo_path is not null
  and not exists (select 1 from team_logos tl where tl.team_id = t.id and tl.storage_path = t.logo_path);
