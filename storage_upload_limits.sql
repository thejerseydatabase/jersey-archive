-- storage_policies.sql only restricts uploads to the jersey-photos bucket
-- by bucket_id — it never set a file size cap or MIME type allowlist, so
-- while the app's own UI only accepts images, that check only lives in
-- the browser. Anyone calling the Storage API directly with the (public,
-- by design) anon key could upload a file of any size or type straight
-- into the bucket, which is publicly readable. On the free tier's 1GB
-- storage cap, a single oversized upload could burn a real chunk of the
-- quota, and an arbitrary file type turns the bucket into free hosting
-- for whatever was uploaded. This enforces both at the bucket level, so
-- it holds regardless of how the upload request is made.
--
-- Already applied once via the Supabase dashboard — this file just
-- captures that change in the migration history. Safe to re-run.

update storage.buckets
set file_size_limit = 10485760,  -- 10MB per file
    allowed_mime_types = array['image/jpeg','image/png','image/webp']
where id = 'jersey-photos';
