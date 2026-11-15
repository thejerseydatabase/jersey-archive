-- Adds National Division 5 (English rugby union, 1993-94 season
-- lineup) under Rugby Union, with its 26 founding clubs - North and
-- South, via teams.conference - plus repoints the London Welsh team
-- already uploaded under a placeholder "Championship" competition
-- (created before this one existed) onto the real one, and removes
-- that now-empty placeholder.
--
-- Source: https://en.wikipedia.org/wiki/National_Division_5
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier, region_group)
select 'national-division-5', 'rugby-union', 'National Division 5', 'more', 'England'
where not exists (select 1 from competitions where slug = 'national-division-5');

-- London Welsh already exists (under the placeholder competition) -
-- repoint it rather than creating a duplicate, so its 2 existing
-- jerseys move with it automatically (they reference this team's id,
-- not its competition_slug).
update teams
set competition_slug = 'national-division-5', conference = 'South'
where slug = 'london-welsh' and competition_slug = 'championship-rugby-union';

update jerseys
set competition_slug = 'national-division-5'
where team_id = (select id from teams where slug = 'london-welsh' and competition_slug = 'national-division-5')
  and competition_slug = 'championship-rugby-union';

-- The placeholder is empty now that London Welsh has moved off it -
-- remove it rather than leaving a bogus "Championship" option
-- cluttering the competition picker.
delete from competitions
where slug = 'championship-rugby-union'
  and not exists (select 1 from teams where competition_slug = 'championship-rugby-union');

insert into teams (slug, competition_slug, name, conference)
select * from (values
  ('birmingham-solihull', 'national-division-5', 'Birmingham & Solihull', 'North'),
  ('bradford-bingley', 'national-division-5', 'Bradford & Bingley', 'North'),
  ('durham-city', 'national-division-5', 'Durham City', 'North'),
  ('hereford', 'national-division-5', 'Hereford', 'North'),
  ('kendal', 'national-division-5', 'Kendal', 'North'),
  ('lichfield', 'national-division-5', 'Lichfield', 'North'),
  ('nuneaton', 'national-division-5', 'Nuneaton', 'North'),
  ('preston-grasshoppers', 'national-division-5', 'Preston Grasshoppers', 'North'),
  ('rotherham', 'national-division-5', 'Rotherham', 'North'),
  ('stoke-on-trent', 'national-division-5', 'Stoke-on-Trent', 'North'),
  ('stourbridge', 'national-division-5', 'Stourbridge', 'North'),
  ('walsall', 'national-division-5', 'Walsall', 'North'),
  ('winnington-park', 'national-division-5', 'Winnington Park', 'North'),
  ('basingstoke', 'national-division-5', 'Basingstoke', 'South'),
  ('berry-hill', 'national-division-5', 'Berry Hill', 'South'),
  ('camborne', 'national-division-5', 'Camborne', 'South'),
  ('high-wycombe', 'national-division-5', 'High Wycombe', 'South'),
  ('lydney', 'national-division-5', 'Lydney', 'South'),
  ('maidstone', 'national-division-5', 'Maidstone', 'South'),
  ('metropolitan-police', 'national-division-5', 'Metropolitan Police', 'South'),
  ('north-walsham', 'national-division-5', 'North Walsham', 'South'),
  ('reading', 'national-division-5', 'Reading', 'South'),
  ('southend', 'national-division-5', 'Southend', 'South'),
  ('tabard', 'national-division-5', 'Tabard', 'South'),
  ('weston-super-mare', 'national-division-5', 'Weston-super-Mare', 'South')
) as v(slug, competition_slug, name, conference)
where not exists (select 1 from teams t where t.slug = v.slug and t.competition_slug = v.competition_slug);
