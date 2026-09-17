-- 1. Splits the old generic "Australia Domestic" into its two real
--    competitions — Sheffield Shield (first-class) keeps the existing
--    competition slug/history, and a new Dean Jones Cup (List A one-day)
--    is added alongside it with the same six states. A few team names
--    get corrected to the Shield's actual naming (no ODC-era nicknames).
--    "ACT Meteors" was included here from an earlier migration by
--    mistake — it's a women's WNCL team, already correctly under WNCL —
--    left in place rather than deleted in case jerseys are attached to
--    it, but it doesn't belong in Sheffield Shield; let me know and I'll
--    move or remove it once you confirm nothing's logged against it.
-- 2. Adds the County Championship (first-class) and One-Day Cup (List A)
--    as two new competitions, same 18 counties in each (kept separate,
--    like BBL/WBBL, since they're each their own recognised trophy).
--
-- Colors: Australian state colors reuse what's already on the site.
-- English county colors are lower-confidence placeholders — I don't have
-- solid brand-color knowledge for several of these, easy to fix later.
-- Safe to re-run.

-- ============ Sheffield Shield (renamed from the old placeholder) ============
update competitions set name = 'Sheffield Shield' where slug = 'australia-domestic';

update teams set name = 'New South Wales' where competition_slug = 'australia-domestic' and slug = 'new-south-wales-blues';
update teams set name = 'South Australia' where competition_slug = 'australia-domestic' and slug = 'south-australia-redbacks';
update teams set name = 'Tasmania Tigers' where competition_slug = 'australia-domestic' and slug = 'tasmanian-tigers';

-- ============ Dean Jones Cup (new competition, same states) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('dean-jones-cup','cricket','Dean Jones Cup','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('new-south-wales','dean-jones-cup','New South Wales','#001E62','#FFFFFF'),
  ('queensland','dean-jones-cup','Queensland','#6A0032','#FFD700'),
  ('south-australia','dean-jones-cup','South Australia','#C8102E','#001E62'),
  ('tasmania','dean-jones-cup','Tasmania','#002664','#00843D'),
  ('western-australia','dean-jones-cup','Western Australia','#000000','#FFD700'),
  ('victoria','dean-jones-cup','Victoria','#002664','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ County Championship (new competition) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('county-championship','cricket','County Championship','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('derbyshire','county-championship','Derbyshire','#6F4E37','#FFBF00'),
  ('durham','county-championship','Durham','#002664','#FFD700'),
  ('essex','county-championship','Essex','#0033A0','#FFD700'),
  ('glamorgan','county-championship','Glamorgan','#002664','#CE1126'),
  ('gloucestershire','county-championship','Gloucestershire','#6A0032','#FFD700'),
  ('hampshire','county-championship','Hampshire','#041E42','#FFD700'),
  ('kent','county-championship','Kent','#6A0032','#FFFFFF'),
  ('lancashire','county-championship','Lancashire','#CE1126','#FFFFFF'),
  ('leicestershire','county-championship','Leicestershire','#002664','#6A0032'),
  ('middlesex','county-championship','Middlesex','#002664','#FFD700'),
  ('northamptonshire','county-championship','Northamptonshire','#6A0032','#FFD700'),
  ('nottinghamshire','county-championship','Nottinghamshire','#00693E','#FFD700'),
  ('somerset','county-championship','Somerset','#000000','#CE1126'),
  ('surrey','county-championship','Surrey','#4A2C2A','#FFFFFF'),
  ('sussex','county-championship','Sussex','#002664','#FFD700'),
  ('warwickshire','county-championship','Warwickshire','#002B5C','#FFD700'),
  ('worcestershire','county-championship','Worcestershire','#00693E','#000000'),
  ('yorkshire','county-championship','Yorkshire','#002664','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ One-Day Cup (new competition, same 18 counties) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('one-day-cup','cricket','One-Day Cup','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('derbyshire','one-day-cup','Derbyshire','#6F4E37','#FFBF00'),
  ('durham','one-day-cup','Durham','#002664','#FFD700'),
  ('essex','one-day-cup','Essex','#0033A0','#FFD700'),
  ('glamorgan','one-day-cup','Glamorgan','#002664','#CE1126'),
  ('gloucestershire','one-day-cup','Gloucestershire','#6A0032','#FFD700'),
  ('hampshire','one-day-cup','Hampshire','#041E42','#FFD700'),
  ('kent','one-day-cup','Kent','#6A0032','#FFFFFF'),
  ('lancashire','one-day-cup','Lancashire','#CE1126','#FFFFFF'),
  ('leicestershire','one-day-cup','Leicestershire','#002664','#6A0032'),
  ('middlesex','one-day-cup','Middlesex','#002664','#FFD700'),
  ('northamptonshire','one-day-cup','Northamptonshire','#6A0032','#FFD700'),
  ('nottinghamshire','one-day-cup','Nottinghamshire','#00693E','#FFD700'),
  ('somerset','one-day-cup','Somerset','#000000','#CE1126'),
  ('surrey','one-day-cup','Surrey','#4A2C2A','#FFFFFF'),
  ('sussex','one-day-cup','Sussex','#002664','#FFD700'),
  ('warwickshire','one-day-cup','Warwickshire','#002B5C','#FFD700'),
  ('worcestershire','one-day-cup','Worcestershire','#00693E','#000000'),
  ('yorkshire','one-day-cup','Yorkshire','#002664','#FFFFFF')
on conflict (competition_slug, slug) do nothing;
