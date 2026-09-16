-- Adds Australia's domestic ice hockey leagues (AIHL, AWIHL) and its
-- international representative teams (Mighty Roos men, Mighty Jills
-- women) — all under the existing ice-hockey sport, separate from the
-- NHL. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('aihl','ice-hockey','AIHL','more'),
  ('awihl','ice-hockey','AWIHL','more'),
  ('international-ice-hockey-men','ice-hockey','International (Men)','more'),
  ('international-ice-hockey-women','ice-hockey','International (Women)','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adelaide-adrenaline','aihl','Adelaide Adrenaline','#F57F17','#000000'),
  ('brisbane-lightning','aihl','Brisbane Lightning','#5C2D91','#FFD700'),
  ('canberra-brave','aihl','Canberra Brave','#002664','#CE1126'),
  ('central-coast-rhinos','aihl','Central Coast Rhinos','#808080','#003893'),
  ('melbourne-ice','aihl','Melbourne Ice','#003893','#FFFFFF'),
  ('melbourne-mustangs','aihl','Melbourne Mustangs','#CE1126','#000000'),
  ('newcastle-north-stars','aihl','Newcastle North Stars','#002664','#FFD700'),
  ('perth-thunder','aihl','Perth Thunder','#000000','#FFD700'),
  ('sydney-bears','aihl','Sydney Bears','#6A0032','#FFD700'),
  ('sydney-ice-dogs','aihl','Sydney Ice Dogs','#CE1126','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('melbourne-ducks','awihl','Melbourne Ducks','#00843D','#FFD700'),
  ('perth-inferno','awihl','Perth Inferno','#CE1126','#F57F17'),
  ('sydney-sirens','awihl','Sydney Sirens','#5C2D91','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('mighty-roos','international-ice-hockey-men','Mighty Roos','#00843D','#FFD700')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('mighty-jills','international-ice-hockey-women','Mighty Jills','#00843D','#FFD700')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
