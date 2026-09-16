-- Team logos: a real logo image instead of the colored placeholder swatch,
-- proposable by any signed-in user but only live once approved — same
-- pattern as the extra-photos feature. Additive only.
--
-- Before running this, create a Storage bucket named exactly "team-logos"
-- (Storage → New bucket → Public bucket ON), same as jersey-photos.

alter table teams add column if not exists logo_path text;

create table team_logo_proposals (
  id uuid primary key default gen_random_uuid(),
  team_id uuid not null references teams(id) on delete cascade,
  storage_path text not null,
  proposed_by uuid references auth.users(id),
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  created_at timestamptz not null default now()
);

alter table team_logo_proposals enable row level security;

create policy "logo proposals are readable by proposer and admins"
  on team_logo_proposals for select using (
    proposed_by = auth.uid() or exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin)
  );

create policy "authenticated users can propose a team logo"
  on team_logo_proposals for insert to authenticated with check (proposed_by = auth.uid());

create policy "admins can moderate logo proposals"
  on team_logo_proposals for update
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

create policy "admins can delete logo proposals"
  on team_logo_proposals for delete
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

-- storage.objects policies for the new bucket (same pattern as jersey-photos)
create policy "anyone can view team logos"
  on storage.objects for select
  using (bucket_id = 'team-logos');

create policy "authenticated users can upload team logos"
  on storage.objects for insert to authenticated
  with check (bucket_id = 'team-logos');

create policy "admins can delete team logo files"
  on storage.objects for delete to authenticated
  using (bucket_id = 'team-logos' and exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));
