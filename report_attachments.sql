-- Lets a report optionally carry one image — mainly for "this logo is
-- wrong, here's the correct one" without needing a permanent always-visible
-- "propose a different logo" button (logos rarely change once set).
-- Additive only.
--
-- Before running this, create a Storage bucket named exactly
-- "report-attachments" (Storage → New bucket → Public bucket ON).

alter table reports add column if not exists attachment_path text;

-- reports allow anonymous submission by design, so attachments do too —
-- nothing here is ever public until an admin acts on it.
create policy "anyone can view report attachments"
  on storage.objects for select
  using (bucket_id = 'report-attachments');

create policy "anyone can upload a report attachment"
  on storage.objects for insert
  with check (bucket_id = 'report-attachments');

create policy "admins can delete report attachments"
  on storage.objects for delete to authenticated
  using (bucket_id = 'report-attachments' and exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));
