-- Fills out the NRL to its full 17-club competition and cleans up the old
-- placeholder demo jerseys (fake "ISC" Home/Away entries with no photos —
-- seed_demo.sql always said these were safe to delete). Real uploads
-- (Brisbane Broncos' logo, the Newcastle Knights jersey you submitted) are
-- untouched either way.
--
-- Colours here are just the fallback swatch shown until a real logo is
-- uploaded for a team — easy to correct later via the admin pencil-edit if
-- any look off. Safe to re-run.

-- 1. remove the old placeholder jerseys (identifiable as: manufacturer
--    'ISC', no uploader, and no photos attached — that's exactly and only
--    what seed_demo.sql created)
delete from jerseys
where manufacturer = 'ISC'
  and uploaded_by is null
  and not exists (select 1 from jersey_images where jersey_images.jersey_id = jerseys.id);

-- 2. add the 9 NRL clubs missing from the original 8-team demo list
--    (Newcastle Knights already exists — you created it by typing it into
--    the upload form — so it's just getting its colours corrected here
--    instead of the auto-generated placeholder ones)
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('canberra-raiders','nrl','Canberra Raiders','#00843D','#FFD200'),
  ('cronulla-sharks','nrl','Cronulla Sharks','#6EC1E4','#000000'),
  ('dolphins','nrl','Dolphins','#E2231A','#000000'),
  ('gold-coast-titans','nrl','Gold Coast Titans','#002B5C','#FFC72C'),
  ('manly-sea-eagles','nrl','Manly Sea Eagles','#7A1F3D','#FFFFFF'),
  ('new-zealand-warriors','nrl','New Zealand Warriors','#1B1B1B','#00843D'),
  ('newcastle-knights','nrl','Newcastle Knights','#EE3524','#002D62'),
  ('st-george-illawarra-dragons','nrl','St George Illawarra Dragons','#C8102E','#FFFFFF'),
  ('wests-tigers','nrl','Wests Tigers','#F58220','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
