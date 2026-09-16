-- Demo/test data only — safe to delete these rows once real uploads exist.
-- Run in Supabase SQL Editor after schema.sql (v2).

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('brisbane-broncos','nrl','Brisbane Broncos','#7A1927','#F5B324'),
  ('sydney-roosters','nrl','Sydney Roosters','#12284B','#E4032E'),
  ('melbourne-storm','nrl','Melbourne Storm','#4B2E83','#FDB714'),
  ('parramatta-eels','nrl','Parramatta Eels','#005DAA','#FFD100'),
  ('penrith-panthers','nrl','Penrith Panthers','#1A1A1A','#00A19A'),
  ('south-sydney-rabbitohs','nrl','South Sydney Rabbitohs','#8C1F28','#00442B'),
  ('canterbury-bulldogs','nrl','Canterbury Bulldogs','#0D3B8C','#FFFFFF'),
  ('north-queensland-cowboys','nrl','North Queensland Cowboys','#002B5C','#F5C518');

insert into jerseys (team_id, season, type, manufacturer, status)
select t.id, s.season, ty.type, 'ISC', 'approved'
from teams t
cross join (values (2022),(2023),(2024)) as s(season)
cross join (values ('Home'),('Away')) as ty(type)
where t.competition_slug = 'nrl';
