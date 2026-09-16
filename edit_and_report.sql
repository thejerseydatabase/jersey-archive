-- Two features: admin inline text-editing, and a "Report a problem" button.
-- Additive only — safe to run without affecting existing data.

-- ============ admin editing ============
-- teams and competitions had no UPDATE policy at all yet (only insert),
-- so even you couldn't fix a typo'd team/competition name until now.
create policy "admins can edit teams"
  on teams for update
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

create policy "admins can edit competitions"
  on competitions for update
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

-- jerseys already has "admins can moderate jerseys" (update, no column
-- restriction), so season/type/manufacturer/notes/format editing needs no
-- new policy — it already works for admins.


-- ============ reports ============
-- "page_type" + "page_ref" is a light generic pointer (a jersey id, a team
-- id, or a competition slug) so one table covers reports from any page
-- without a separate reports table per page type. page_label is a plain-text
-- snapshot of what the report was about, so the moderation queue can show
-- it without extra joins.
create table reports (
  id uuid primary key default gen_random_uuid(),
  page_type text not null check (page_type in ('jersey','team','competition')),
  page_ref text not null,
  page_label text,
  message text not null,
  reported_by uuid references auth.users(id),
  status text not null default 'open' check (status in ('open','resolved')),
  created_at timestamptz not null default now()
);

alter table reports enable row level security;

-- anyone can report something, signed in or not — low friction on purpose
create policy "anyone can submit a report"
  on reports for insert with check (true);

create policy "admins can read reports"
  on reports for select
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

create policy "admins can resolve reports"
  on reports for update
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));
