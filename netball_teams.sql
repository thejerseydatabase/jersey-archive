-- Adds Netball as a new sport, plus Suncorp Super Netball and its 9 teams.
-- Safe to re-run.

insert into sports (slug, name, sort_order) values
  ('netball','Netball',10)
on conflict (slug) do nothing;

insert into competitions (slug, sport_slug, name, tier) values
  ('super-netball','netball','Suncorp Super Netball','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adelaide-thunderbirds','super-netball','Adelaide Thunderbirds','#5C2D91','#FFD200'),
  ('collingwood-magpies','super-netball','Collingwood Magpies','#000000','#FFFFFF'),
  ('giants-netball','super-netball','Giants Netball','#F57F17','#333333'),
  ('melbourne-mavericks','super-netball','Melbourne Mavericks','#002664','#CE1126'),
  ('melbourne-vixens','super-netball','Melbourne Vixens','#002664','#00AEEF'),
  ('nsw-swifts','super-netball','NSW Swifts','#002664','#87CEEB'),
  ('queensland-firebirds','super-netball','Queensland Firebirds','#6A0032','#5C2D91'),
  ('sunshine-coast-lightning','super-netball','Sunshine Coast Lightning','#002664','#EC008C'),
  ('west-coast-fever','super-netball','West Coast Fever','#002664','#FFD200')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
