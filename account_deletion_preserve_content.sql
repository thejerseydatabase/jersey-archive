-- Right now, deleting a user from Supabase Auth (Authentication → Users →
-- delete) would FAIL for anyone who has ever uploaded a jersey, added a
-- photo, created a team/competition, filed a report, or proposed a logo —
-- those tables all reference auth.users(id) with no ON DELETE rule, which
-- defaults to blocking the delete outright rather than losing the row.
--
-- This switches those references to ON DELETE SET NULL: deleting the
-- account still deletes their profile (name/points/login all gone), but
-- every jersey, photo, team, competition, report and logo proposal they
-- contributed stays exactly where it is — it just no longer shows a
-- byline/uploader for that row. Nothing here removes any content.
--
-- Looks up each FK's current constraint name dynamically rather than
-- assuming Postgres's default auto-generated name, so this is safe to
-- re-run even after it's already been applied once.

do $$
declare
  cname text;
  targets text[][] := array[
    array['jerseys', 'uploaded_by'],
    array['jersey_images', 'uploaded_by'],
    array['competitions', 'created_by'],
    array['teams', 'created_by'],
    array['reports', 'reported_by'],
    array['team_logo_proposals', 'proposed_by'],
    array['competition_logo_proposals', 'proposed_by']
  ];
  t text[];
begin
  foreach t slice 1 in array targets loop
    select tc.constraint_name into cname
    from information_schema.table_constraints tc
    join information_schema.key_column_usage kcu
      on tc.constraint_name = kcu.constraint_name and tc.table_schema = kcu.table_schema
    where tc.table_schema = 'public' and tc.table_name = t[1]
      and tc.constraint_type = 'FOREIGN KEY' and kcu.column_name = t[2];
    if cname is not null then
      execute format('alter table %I drop constraint %I', t[1], cname);
    end if;
    execute format(
      'alter table %I add constraint %I foreign key (%I) references auth.users(id) on delete set null',
      t[1], t[1] || '_' || t[2] || '_fkey', t[2]
    );
  end loop;
end $$;
