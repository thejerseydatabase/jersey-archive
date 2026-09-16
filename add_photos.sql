-- Lets any signed-in user propose extra photos on an ALREADY-APPROVED
-- jersey, without duplicating the whole entry. New photos start pending
-- and need their own approval before anyone else can see them — the
-- jersey itself and its existing photos are untouched either way.
-- Additive only — safe to run without affecting existing data.

alter table jersey_images add column if not exists status text not null default 'approved'
  check (status in ('pending','approved','rejected'));
alter table jersey_images add column if not exists uploaded_by uuid references auth.users(id);

-- a photo is visible if both it and its parent jersey are visible
drop policy if exists "images of visible jerseys are readable" on jersey_images;
create policy "images of visible jerseys are readable"
  on jersey_images for select using (
    (status = 'approved' or uploaded_by = auth.uid() or exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin))
    and exists (select 1 from jerseys j where j.id = jersey_id and (
      j.status = 'approved' or j.uploaded_by = auth.uid() or exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin)
    ))
  );

-- anyone signed in can propose photos on an already-approved jersey
create policy "authenticated users can propose extra photos"
  on jersey_images for insert to authenticated with check (
    uploaded_by = auth.uid() and status = 'pending'
    and exists (select 1 from jerseys j where j.id = jersey_id and j.status = 'approved')
  );

-- admins can approve/reject proposed photos
create policy "admins can moderate jersey photos"
  on jersey_images for update
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

create policy "admins can delete jersey image rows"
  on jersey_images for delete
  using (exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));
