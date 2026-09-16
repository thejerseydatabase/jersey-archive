-- Adds the WNBL (Australia) and its 10 teams, under the existing
-- basketball sport. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('wnbl','basketball','WNBL','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adelaide-lightning','wnbl','Adelaide Lightning','#002664','#FFD700'),
  ('bendigo-spirit','wnbl','Bendigo Spirit','#CE1126','#000000'),
  ('geelong-venom','wnbl','Geelong Venom','#00843D','#000000'),
  ('melbourne-boomers','wnbl','Melbourne Boomers','#002664','#CE1126'),
  ('perth-lynx','wnbl','Perth Lynx','#5C2D91','#000000'),
  ('southside-flyers','wnbl','Southside Flyers','#002664','#00AEEF'),
  ('sydney-flames','wnbl','Sydney Flames','#F57F17','#000000'),
  ('tasmania-jewels','wnbl','Tasmania Jewels','#00843D','#FFD700'),
  ('townsville-fire','wnbl','Townsville Fire','#CE1126','#000000'),
  ('uc-capitals','wnbl','UC Capitals','#002664','#CE1126')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
