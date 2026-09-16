-- Adds the current international cricket teams to the existing
-- "International" cricket competition. Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('afghanistan','international','Afghanistan','#0033A0','#FFFFFF'),
  ('australia','international','Australia','#FFD100','#00843D'),
  ('bangladesh','international','Bangladesh','#006A4E','#F42A41'),
  ('bermuda','international','Bermuda','#C8102E','#00247D'),
  ('canada','international','Canada','#FF0000','#FFFFFF'),
  ('cyprus','international','Cyprus','#FFFFFF','#D57800'),
  ('england','international','England','#041E42','#7EA8E0'),
  ('hong-kong','international','Hong Kong','#DE2910','#FFFFFF'),
  ('india','international','India','#1B3F8B','#FF9933'),
  ('ireland','international','Ireland','#169B62','#FFFFFF'),
  ('italy','international','Italy','#0F4C81','#FFFFFF'),
  ('japan','international','Japan','#BC002D','#FFFFFF'),
  ('kenya','international','Kenya','#006400','#CE1126'),
  ('namibia','international','Namibia','#003580','#D21034'),
  ('nepal','international','Nepal','#DC143C','#003893'),
  ('netherlands','international','Netherlands','#FF6C00','#FFFFFF'),
  ('new-zealand','international','New Zealand','#000000','#C0C0C0'),
  ('norway','international','Norway','#BA0C2F','#00205B'),
  ('oman','international','Oman','#DB161B','#008751'),
  ('pakistan','international','Pakistan','#01411C','#FFFFFF'),
  ('papua-new-guinea','international','Papua New Guinea','#CE1126','#000000'),
  ('samoa','international','Samoa','#002B7F','#CE1126'),
  ('scotland','international','Scotland','#00205B','#FFFFFF'),
  ('south-africa','international','South Africa','#007A4D','#FFB612'),
  ('sri-lanka','international','Sri Lanka','#003893','#FFB612'),
  ('tanzania','international','Tanzania','#1EB53A','#00A3DD'),
  ('thailand','international','Thailand','#A51931','#2D2A4A'),
  ('united-arab-emirates','international','United Arab Emirates','#FF0000','#00732F'),
  ('uganda','international','Uganda','#000000','#FCDD09'),
  ('united-states','international','United States','#002868','#BF0D3E'),
  ('west-indies','international','West Indies','#7B1113','#FFD700'),
  ('zimbabwe','international','Zimbabwe','#CE1126','#006400')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
