-- Adds the current NSW Cup teams. Most share the exact same name and
-- colours as their NRL club (so the "Also see" link on each team page
-- connects them automatically) — written out in full here rather than
-- the shorthand you gave (e.g. "Canberra Raiders" not just "Canberra")
-- so that name-match actually works. Newtown Jets, North Sydney Bears,
-- and Western Suburbs Magpies are the standalone outliers with no
-- current NRL club of their own.
--
-- Western Suburbs Magpies gets a history_note about the 1999 Balmain
-- merger, since it's still playing on in the lower grades under its own
-- name rather than having folded. Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('canberra-raiders','nsw-cup','Canberra Raiders','#00843D','#FFD200'),
  ('canterbury-bulldogs','nsw-cup','Canterbury Bulldogs','#0D3B8C','#FFFFFF'),
  ('manly-sea-eagles','nsw-cup','Manly Sea Eagles','#7A1F3D','#FFFFFF'),
  ('melbourne-storm','nsw-cup','Melbourne Storm','#3E1F55','#FDB714'),
  ('new-zealand-warriors','nsw-cup','New Zealand Warriors','#00457C','#D0202F'),
  ('newcastle-knights','nsw-cup','Newcastle Knights','#EE3524','#002D62'),
  ('parramatta-eels','nsw-cup','Parramatta Eels','#005DAA','#FFD100'),
  ('penrith-panthers','nsw-cup','Penrith Panthers','#000000','#E4007C'),
  ('south-sydney-rabbitohs','nsw-cup','South Sydney Rabbitohs','#8C1F28','#00442B'),
  ('st-george-illawarra-dragons','nsw-cup','St George Illawarra Dragons','#C8102E','#FFFFFF'),
  ('sydney-roosters','nsw-cup','Sydney Roosters','#12284B','#E4032E')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('newtown-jets','nsw-cup','Newtown Jets','#003893','#CE1126'),
  ('north-sydney-bears','nsw-cup','North Sydney Bears','#CE1126','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, history_note) values
  ('western-suburbs-magpies','nsw-cup','Western Suburbs Magpies','#000000','#FFFFFF',
   'Merged with Balmain Tigers in 1999 to form the NRL''s Wests Tigers, but continued playing on in the lower grades under its own name.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, history_note = excluded.history_note;
