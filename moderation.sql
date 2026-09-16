-- Adds a moderation queue. Additive only — safe to run without losing any
-- existing data (your Newcastle Knights upload and the seed data included;
-- both get marked 'approved' so they stay visible exactly as they are now).

alter table profiles add column if not exists is_admin boolean not null default false;

alter table jerseys add column if not exists status text not null default 'pending'
  check (status in ('pending','approved','rejected'));

-- everything that already exists (seed data + your test upload) stays visible
update jerseys set status = 'approved' where status = 'pending';

-- public can only see approved jerseys; you can always see your own (pending
-- included); admins can see everything
drop policy if exists "jerseys are publicly readable" on jerseys;
create policy "visible jerseys are readable"
  on jerseys for select using (
    status = 'approved'
    or uploaded_by = auth.uid()
    or exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin)
  );

-- you can still edit your own jersey while it's pending, but can't approve
-- yourself by editing the status field directly
drop policy if exists "users can edit their own jerseys" on jerseys;
create policy "users can edit their own pending jerseys"
  on jerseys for update
  using (auth.uid() = uploaded_by)
  with check (auth.uid() = uploaded_by and status = 'pending');

-- only admins can approve/reject or delete
create policy "admins can moderate jerseys"
  on jerseys for update
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

create policy "admins can delete jerseys"
  on jerseys for delete
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

-- photos follow the same visibility as their jersey
drop policy if exists "jersey images are publicly readable" on jersey_images;
create policy "images of visible jerseys are readable"
  on jersey_images for select using (
    exists (select 1 from jerseys j where j.id = jersey_id and (
      j.status = 'approved' or j.uploaded_by = auth.uid()
      or exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin)
    ))
  );

-- admins can delete the actual photo files when rejecting a submission
create policy "admins can delete jersey photos"
  on storage.objects for delete to authenticated
  using (bucket_id = 'jersey-photos' and exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

-- points are now awarded on approval, not on raw submission
drop trigger if exists on_jersey_uploaded on jerseys;
drop function if exists award_upload_point() cascade;
create function award_upload_point()
returns trigger as $$
begin
  if new.status = 'approved' and (old.status is distinct from 'approved') and new.uploaded_by is not null then
    update profiles set points = points + 1 where id = new.uploaded_by;
  end if;
  return new;
end;
$$ language plpgsql security definer;

create trigger on_jersey_approved
  after update of status on jerseys
  for each row execute function award_upload_point();

-- Last step (do this yourself, separately): make your own account an admin.
-- update profiles set is_admin = true where username = 'YOUR-USERNAME-HERE';
