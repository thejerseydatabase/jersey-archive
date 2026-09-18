-- Brisbane Bears and Fitzroy — the two clubs that merged in 1996 to
-- form the Brisbane Lions, who already exist on the site as a current
-- AFL team and aren't touched by this. Colours: Fitzroy's maroon-and-
-- blue are well known; Brisbane Bears' are a reasonable best guess
-- (maroon/gold), correct if wrong. Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('brisbane-bears','afl','Brisbane Bears','#7A263A','#FFD700', false,
   'Formed in 1986 as the VFL''s first privately-owned club, debuting in 1987; played on the Gold Coast before moving to the Gabba in Brisbane in 1993. Merged with the Fitzroy Football Club at the end of the 1996 season to form the Brisbane Lions.'),
  ('fitzroy-lions','afl','Fitzroy Lions','#7A263A','#002664', false,
   'One of the VFL''s founding clubs. Its AFL assets and operations were taken over by the Brisbane Bears at the end of the 1996 season, and the combined club was renamed the Brisbane Lions.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;
