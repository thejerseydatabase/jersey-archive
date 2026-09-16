-- Adds International (Netball) with its 20 current top teams. Safe to
-- re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('international-netball','netball','International','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('australia','international-netball','Australia','#FFD700','#00843D'),
  ('new-zealand','international-netball','New Zealand','#000000','#C0C0C0'),
  ('england','international-netball','England','#CE1126','#002664'),
  ('jamaica','international-netball','Jamaica','#FED100','#009B3A'),
  ('south-africa','international-netball','South Africa','#007A4D','#FFB612'),
  ('uganda','international-netball','Uganda','#000000','#FCDD09'),
  ('tonga','international-netball','Tonga','#C10000','#FFFFFF'),
  ('malawi','international-netball','Malawi','#000000','#CE1126'),
  ('wales','international-netball','Wales','#C8102E','#FFFFFF'),
  ('scotland','international-netball','Scotland','#00205B','#FFFFFF'),
  ('zimbabwe','international-netball','Zimbabwe','#006400','#FFD700'),
  ('trinidad-and-tobago','international-netball','Trinidad and Tobago','#CE1126','#000000'),
  ('samoa','international-netball','Samoa','#002B7F','#CE1126'),
  ('namibia','international-netball','Namibia','#003580','#D21034'),
  ('northern-ireland','international-netball','Northern Ireland','#009A44','#FFFFFF'),
  ('fiji','international-netball','Fiji','#71C5E8','#FFFFFF'),
  ('zambia','international-netball','Zambia','#198A00','#EF7D00'),
  ('saint-vincent-and-the-grenadines','international-netball','Saint Vincent and the Grenadines','#0033A0','#FFD700'),
  ('barbados','international-netball','Barbados','#00267F','#FFC726'),
  ('gibraltar','international-netball','Gibraltar','#E8112D','#FFFFFF')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
