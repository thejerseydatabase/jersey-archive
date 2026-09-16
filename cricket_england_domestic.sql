-- Adds England's domestic cricket clubs — the 18 first-class counties and
-- The Hundred's 8 franchises together under one competition, matching how
-- they were given (several counties, like Warwickshire/Birmingham Bears
-- and Yorkshire/Sunrisers Leeds, play under a different trading name in
-- the Hundred — both are included as separate teams). Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('england-domestic','cricket','England Domestic','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('birmingham-bears','england-domestic','Birmingham Bears','#002664','#CE1126'),
  ('birmingham-phoenix','england-domestic','Birmingham Phoenix','#F57F17','#5C2D91'),
  ('derbyshire','england-domestic','Derbyshire','#002664','#FFD700'),
  ('durham','england-domestic','Durham','#003893','#FFFFFF'),
  ('essex','england-domestic','Essex','#002664','#FFD700'),
  ('glamorgan','england-domestic','Glamorgan','#002664','#6A0032'),
  ('gloucestershire','england-domestic','Gloucestershire','#6A0032','#FFD700'),
  ('hampshire','england-domestic','Hampshire','#003893','#FFD700'),
  ('kent','england-domestic','Kent','#CE1126','#FFFFFF'),
  ('lancashire','england-domestic','Lancashire','#CE1126','#002664'),
  ('leicestershire','england-domestic','Leicestershire','#00693E','#CE1126'),
  ('london-spirit','england-domestic','London Spirit','#002664','#CE1126'),
  ('manchester-originals','england-domestic','Manchester Originals','#00A9A5','#5C2D91'),
  ('middlesex','england-domestic','Middlesex','#003893','#FFFFFF'),
  ('northamptonshire','england-domestic','Northamptonshire','#6A0032','#FFD700'),
  ('nottinghamshire','england-domestic','Nottinghamshire','#00693E','#FFD700'),
  ('oval-invincibles','england-domestic','Oval Invincibles','#14213D','#5C2D91'),
  ('somerset','england-domestic','Somerset','#000000','#FFFFFF'),
  ('southern-brave','england-domestic','Southern Brave','#002664','#B87333'),
  ('sunrisers-leeds','england-domestic','Sunrisers Leeds','#F26522','#000000'),
  ('surrey','england-domestic','Surrey','#5B3A29','#FFD700'),
  ('sussex','england-domestic','Sussex','#003893','#FFD700'),
  ('trent-rockets','england-domestic','Trent Rockets','#5C2D91','#87CEEB'),
  ('warwickshire','england-domestic','Warwickshire','#002664','#FFD700'),
  ('welsh-fire','england-domestic','Welsh Fire','#CE1126','#000000'),
  ('worcestershire','england-domestic','Worcestershire','#00693E','#000000'),
  ('yorkshire','england-domestic','Yorkshire','#002664','#FFD700')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
