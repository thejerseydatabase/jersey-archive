-- Adds Super Rugby Pacific (Women) with its 5 current teams. Safe to
-- re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('super-rugby-pacific-women','rugby-union','Super Rugby Pacific (Women)','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('act-brumbies','super-rugby-pacific-women','ACT Brumbies','#FFD700','#002664'),
  ('fijian-drua','super-rugby-pacific-women','Fijian Drua','#002664','#00AEEF'),
  ('nsw-waratahs','super-rugby-pacific-women','NSW Waratahs','#00AEEF','#002664'),
  ('qld-reds','super-rugby-pacific-women','QLD Reds','#CE1126','#FFFFFF'),
  ('western-force','super-rugby-pacific-women','Western Force','#002664','#B87333')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
