-- team_logos and competition_logos have select/insert/update policies for
-- admins but no delete policy, so a non-current history row (e.g. a
-- duplicate) couldn't be removed at all - RLS defaults to deny with no
-- matching policy. Lets an admin delete any history row; the app itself
-- only ever offers this for a non-current one, but that's an app-level
-- choice, not something enforced here.

create policy "admins can delete team logo history"
  on team_logos for delete
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

create policy "admins can delete competition logo history"
  on competition_logos for delete
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));
