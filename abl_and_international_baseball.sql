-- Adds the Australian Baseball League (ABL) and Australia's international
-- representative teams (Southern Thunder men, Emeralds women), under the
-- existing baseball sport, separate from MLB. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('abl','baseball','ABL','more'),
  ('international-baseball-men','baseball','International (Men)','more'),
  ('international-baseball-women','baseball','International (Women)','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adelaide-giants','abl','Adelaide Giants','#F57F17','#000000'),
  ('auckland-tuatara','abl','Auckland Tuatara','#00843D','#000000'),
  ('brisbane-bandits','abl','Brisbane Bandits','#002664','#F57F17'),
  ('canberra-cavalry','abl','Canberra Cavalry','#CE1126','#000000'),
  ('geelong-korea','abl','Geelong Korea','#003893','#FFFFFF'),
  ('melbourne-aces','abl','Melbourne Aces','#002664','#CE1126'),
  ('perth-heat','abl','Perth Heat','#CE1126','#000000'),
  ('sydney-blue-sox','abl','Sydney Blue Sox','#002664','#F57F17')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('southern-thunder-men','international-baseball-men','Southern Thunder (Men)','#00843D','#FFD700')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('emeralds-women','international-baseball-women','Emeralds (Women)','#00843D','#FFD700')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
