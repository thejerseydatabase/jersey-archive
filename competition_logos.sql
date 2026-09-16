-- Adds competition logos (e.g. an NRL or Super Rugby Pacific badge) as a
-- full parallel to team logos: proposable by any signed-in user, only
-- live once an admin approves it, with the same history-table pattern.
-- Reuses the existing "team-logos" Storage bucket under a "comp-<slug>/"
-- prefix, so no new bucket needs creating. Safe to re-run.

alter table competitions add column if not exists logo_path text;

create table if not exists competition_logo_proposals (
  id uuid primary key default gen_random_uuid(),
  competition_slug text not null references competitions(slug) on delete cascade,
  storage_path text not null,
  proposed_by uuid references auth.users(id),
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  point_awarded boolean not null default false,
  created_at timestamptz not null default now()
);

alter table competition_logo_proposals enable row level security;
drop policy if exists "comp logo proposals are readable once approved, or by proposer/admins" on competition_logo_proposals;
create policy "comp logo proposals are readable once approved, or by proposer/admins"
  on competition_logo_proposals for select using (
    status = 'approved' or proposed_by = auth.uid() or exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin)
  );
drop policy if exists "authenticated users can propose a competition logo" on competition_logo_proposals;
create policy "authenticated users can propose a competition logo"
  on competition_logo_proposals for insert to authenticated with check (proposed_by = auth.uid());
drop policy if exists "admins can moderate comp logo proposals" on competition_logo_proposals;
create policy "admins can moderate comp logo proposals"
  on competition_logo_proposals for update
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));
drop policy if exists "admins can delete comp logo proposals" on competition_logo_proposals;
create policy "admins can delete comp logo proposals"
  on competition_logo_proposals for delete
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

create or replace function award_comp_logo_point()
returns trigger as $$
begin
  if new.status = 'approved' and (old.status is distinct from 'approved') and new.proposed_by is not null and not new.point_awarded then
    update profiles set points = points + 1 where id = new.proposed_by;
    new.point_awarded := true;
  end if;
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_comp_logo_approved on competition_logo_proposals;
create trigger on_comp_logo_approved
  before update of status on competition_logo_proposals
  for each row execute function award_comp_logo_point();

drop trigger if exists rate_limit_comp_logo_proposals on competition_logo_proposals;
create trigger rate_limit_comp_logo_proposals
  before insert on competition_logo_proposals
  for each row execute function enforce_upload_rate_limit('proposed_by', 120, 60);

create table if not exists competition_logos (
  id uuid primary key default gen_random_uuid(),
  competition_slug text not null references competitions(slug) on delete cascade,
  storage_path text not null,
  is_current boolean not null default false,
  approved_at timestamptz not null default now(),
  years_used text
);
alter table competition_logos enable row level security;
drop policy if exists "competition logo history is publicly readable" on competition_logos;
create policy "competition logo history is publicly readable" on competition_logos for select using (true);
drop policy if exists "admins can add to competition logo history" on competition_logos;
create policy "admins can add to competition logo history"
  on competition_logos for insert to authenticated
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));
drop policy if exists "admins can update competition logo history" on competition_logos;
create policy "admins can update competition logo history"
  on competition_logos for update
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

-- Bonus fix while we're in here: approved team-logo proposals were never
-- publicly readable (only the proposer and admins could see them), so a
-- contributor's profile page couldn't show off logos other people had
-- approved for them. Now approved rows are public, same as jerseys.
drop policy if exists "logo proposals are readable by proposer and admins" on team_logo_proposals;
drop policy if exists "logo proposals are readable once approved, or by proposer/admins" on team_logo_proposals;
create policy "logo proposals are readable once approved, or by proposer/admins"
  on team_logo_proposals for select using (
    status = 'approved' or proposed_by = auth.uid() or exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin)
  );
