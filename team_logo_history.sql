-- Keeps every past logo instead of losing it when a new one is approved.
-- Nothing was actually being deleted before this — the old file just had
-- nothing pointing at it anymore — this makes that history visible and
-- browsable on the team page. Additive only.

create table team_logos (
  id uuid primary key default gen_random_uuid(),
  team_id uuid not null references teams(id) on delete cascade,
  storage_path text not null,
  is_current boolean not null default false,
  approved_at timestamptz not null default now()
);

alter table team_logos enable row level security;
create policy "team logo history is publicly readable" on team_logos for select using (true);
create policy "admins can add to team logo history"
  on team_logos for insert to authenticated
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));
create policy "admins can update team logo history"
  on team_logos for update
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

-- backfill: whatever logo a team already has becomes its first history entry
insert into team_logos (team_id, storage_path, is_current, approved_at)
select id, logo_path, true, now() from teams where logo_path is not null;
