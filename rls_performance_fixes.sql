-- Fixes the two Performance Advisor warning types (both purely about
-- speed, not security — nothing here changes who can see or do what).
--
-- 1. auth_rls_initplan: every policy below called auth.uid() (or an
--    admin-check built on it) directly. Postgres has to re-run that
--    call for EVERY ROW a query touches. Wrapping it as
--    "(select auth.uid())" makes Postgres evaluate it ONCE per query
--    and reuse the result — same answer, much less work as the tables
--    (jerseys, teams, etc.) keep growing. This is Supabase's own
--    documented fix for this warning.
--
-- 2. multiple_permissive_policies: two pairs of policies were separately
--    granting permission for the same table+action+role, which makes
--    Postgres evaluate and OR both together on every row. Merged each
--    pair into a single policy with the same OR'd logic — identical
--    permissions, half the policy evaluations:
--      - jerseys UPDATE: "users can edit their own pending jerseys" +
--        "admins can moderate jerseys" -> one policy.
--      - jersey_images INSERT: "authenticated users can add images to
--        their own jerseys" + "authenticated users can propose extra
--        photos" -> one policy.
--
-- Every drop/create pair below is safe to re-run and changes nothing
-- about who can do what — only how cheaply Postgres checks it.

-- ============ profiles ============
drop policy if exists "users can update their own profile" on profiles;
create policy "users can update their own profile"
  on profiles for update using ((select auth.uid()) = id);


-- ============ competitions ============
drop policy if exists "admins can edit competitions" on competitions;
create policy "admins can edit competitions"
  on competitions for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


-- ============ teams ============
drop policy if exists "admins can edit teams" on teams;
create policy "admins can edit teams"
  on teams for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


-- ============ jerseys ============
drop policy if exists "visible jerseys are readable" on jerseys;
create policy "visible jerseys are readable"
  on jerseys for select using (
    status = 'approved'
    or uploaded_by = (select auth.uid())
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  );

drop policy if exists "authenticated users can upload jerseys" on jerseys;
create policy "authenticated users can upload jerseys"
  on jerseys for insert to authenticated with check ((select auth.uid()) = uploaded_by);

-- merges "users can edit their own pending jerseys" + "admins can
-- moderate jerseys" (both were permissive UPDATE policies) into one.
drop policy if exists "users can edit their own pending jerseys" on jerseys;
drop policy if exists "admins can moderate jerseys" on jerseys;
create policy "users can edit their own jerseys, admins can moderate any"
  on jerseys for update
  using (
    uploaded_by = (select auth.uid())
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  )
  with check (
    (uploaded_by = (select auth.uid()) and status = 'pending')
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  );

drop policy if exists "admins can delete jerseys" on jerseys;
create policy "admins can delete jerseys"
  on jerseys for delete
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


-- ============ jersey_images ============
drop policy if exists "images of visible jerseys are readable" on jersey_images;
create policy "images of visible jerseys are readable"
  on jersey_images for select using (
    (status = 'approved' or uploaded_by = (select auth.uid()) or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
    and exists (select 1 from jerseys j where j.id = jersey_id and (
      j.status = 'approved' or j.uploaded_by = (select auth.uid())
      or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
    ))
  );

-- merges "authenticated users can add images to their own jerseys" +
-- "authenticated users can propose extra photos" (both were permissive
-- INSERT policies for the authenticated role) into one.
drop policy if exists "authenticated users can add images to their own jerseys" on jersey_images;
drop policy if exists "authenticated users can propose extra photos" on jersey_images;
create policy "authenticated users can add or propose jersey photos"
  on jersey_images for insert to authenticated with check (
    exists (select 1 from jerseys where jerseys.id = jersey_id and jerseys.uploaded_by = (select auth.uid()))
    or (
      uploaded_by = (select auth.uid()) and status = 'pending'
      and exists (select 1 from jerseys j where j.id = jersey_id and j.status = 'approved')
    )
  );

drop policy if exists "admins can moderate jersey photos" on jersey_images;
create policy "admins can moderate jersey photos"
  on jersey_images for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));

drop policy if exists "admins can delete jersey image rows" on jersey_images;
create policy "admins can delete jersey image rows"
  on jersey_images for delete
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


-- ============ jersey_competitions ============
drop policy if exists "jersey owner can tag extra competitions while pending" on jersey_competitions;
create policy "jersey owner can tag extra competitions while pending"
  on jersey_competitions for insert to authenticated with check (
    exists (select 1 from jerseys j where j.id = jersey_id and j.uploaded_by = (select auth.uid()) and j.status = 'pending')
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  );

drop policy if exists "jersey owner can untag extra competitions while pending" on jersey_competitions;
create policy "jersey owner can untag extra competitions while pending"
  on jersey_competitions for delete using (
    exists (select 1 from jerseys j where j.id = jersey_id and j.uploaded_by = (select auth.uid()) and j.status = 'pending')
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  );


-- ============ ratings ============
drop policy if exists "authenticated users can rate" on ratings;
create policy "authenticated users can rate"
  on ratings for insert to authenticated with check ((select auth.uid()) = user_id);

drop policy if exists "users can change their own rating" on ratings;
create policy "users can change their own rating"
  on ratings for update using ((select auth.uid()) = user_id);


-- ============ reports ============
drop policy if exists "admins can read reports" on reports;
create policy "admins can read reports"
  on reports for select using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));

drop policy if exists "admins can resolve reports" on reports;
create policy "admins can resolve reports"
  on reports for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


-- ============ team_logo_proposals ============
drop policy if exists "logo proposals are readable once approved, or by proposer/admins" on team_logo_proposals;
create policy "logo proposals are readable once approved, or by proposer/admins"
  on team_logo_proposals for select using (
    status = 'approved' or proposed_by = (select auth.uid()) or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  );

drop policy if exists "authenticated users can propose a team logo" on team_logo_proposals;
create policy "authenticated users can propose a team logo"
  on team_logo_proposals for insert to authenticated with check (proposed_by = (select auth.uid()));

drop policy if exists "admins can moderate logo proposals" on team_logo_proposals;
create policy "admins can moderate logo proposals"
  on team_logo_proposals for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));

drop policy if exists "admins can delete logo proposals" on team_logo_proposals;
create policy "admins can delete logo proposals"
  on team_logo_proposals for delete
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


-- ============ team_logos ============
drop policy if exists "admins can add to team logo history" on team_logos;
create policy "admins can add to team logo history"
  on team_logos for insert to authenticated
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));

drop policy if exists "admins can update team logo history" on team_logos;
create policy "admins can update team logo history"
  on team_logos for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


-- ============ competition_logo_proposals ============
drop policy if exists "comp logo proposals are readable once approved, or by proposer/admins" on competition_logo_proposals;
create policy "comp logo proposals are readable once approved, or by proposer/admins"
  on competition_logo_proposals for select using (
    status = 'approved' or proposed_by = (select auth.uid()) or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  );

drop policy if exists "authenticated users can propose a competition logo" on competition_logo_proposals;
create policy "authenticated users can propose a competition logo"
  on competition_logo_proposals for insert to authenticated with check (proposed_by = (select auth.uid()));

drop policy if exists "admins can moderate comp logo proposals" on competition_logo_proposals;
create policy "admins can moderate comp logo proposals"
  on competition_logo_proposals for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));

drop policy if exists "admins can delete comp logo proposals" on competition_logo_proposals;
create policy "admins can delete comp logo proposals"
  on competition_logo_proposals for delete
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


-- ============ competition_logos ============
drop policy if exists "admins can add to competition logo history" on competition_logos;
create policy "admins can add to competition logo history"
  on competition_logos for insert to authenticated
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));

drop policy if exists "admins can update competition logo history" on competition_logos;
create policy "admins can update competition logo history"
  on competition_logos for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));
