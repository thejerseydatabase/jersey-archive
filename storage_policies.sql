-- Run this on its own — no need to re-run schema.sql or seed_demo.sql.
-- Adds the missing permission for uploading to the jersey-photos bucket.
-- (Marking a bucket "Public" only controls reading; uploading is a
-- separate RLS rule on Storage's own storage.objects table.)

create policy "anyone can view jersey photos"
  on storage.objects for select
  using (bucket_id = 'jersey-photos');

create policy "authenticated users can upload jersey photos"
  on storage.objects for insert to authenticated
  with check (bucket_id = 'jersey-photos');
