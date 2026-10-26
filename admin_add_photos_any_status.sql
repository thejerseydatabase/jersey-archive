-- The jersey_images INSERT policy only ever let the jersey's own
-- uploader add a photo regardless of status, or a third party propose
-- an extra photo once the jersey was already approved - there was no
-- path at all for an admin to add a photo (e.g. swapping in their own
-- HQ version) to a jersey still pending under someone ELSE's account.
-- Adds that as a third allowed case, same admin check already used for
-- jersey_images UPDATE/DELETE.
--
-- Safe to re-run.

drop policy if exists "authenticated users can add or propose jersey photos" on jersey_images;
create policy "authenticated users can add or propose jersey photos"
  on jersey_images for insert to authenticated with check (
    exists (select 1 from jerseys where jerseys.id = jersey_id and jerseys.uploaded_by = (select auth.uid()))
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
    or (
      uploaded_by = (select auth.uid()) and status = 'pending'
      and exists (select 1 from jerseys j where j.id = jersey_id and j.status = 'approved')
    )
  );
