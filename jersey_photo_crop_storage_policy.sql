-- The new in-browser crop tool saves a cropped photo by re-uploading to
-- the exact same storage_path with upsert:true, so every page that
-- already links to that path (jersey detail, moderation queue) picks up
-- the cropped version with no DB change. An upsert overwrite of an
-- existing object is an UPDATE on storage.objects under the hood, not an
-- INSERT - and storage_policies.sql/schema.sql only ever granted INSERT
-- (new uploads) and, for admins, DELETE (rejecting a submission). Without
-- this, the crop save would fail with a permission error the moment the
-- object already exists (i.e. every time - there's always an existing
-- photo being cropped). Same admin-only pattern as the existing
-- "admins can delete jersey photos" policy.

create policy "admins can update jersey photos"
  on storage.objects for update to authenticated
  using (bucket_id = 'jersey-photos' and exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin))
  with check (bucket_id = 'jersey-photos' and exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));
