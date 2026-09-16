-- Expands men's and women's international ice hockey from just Australia
-- to the full team lists supplied. Women's teams insert into whichever
-- competition currently holds them — the still-separate
-- "international-ice-hockey-women" if that migration hasn't been run
-- yet, or the merged "International" (international-ice-hockey-men) if
-- it has — resolved automatically below, so this works either way.
-- Colors reuse this site's existing choice for that country wherever one
-- already exists elsewhere; smaller/less common hockey nations are
-- flag-based best guesses. Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('switzerland','international-ice-hockey-men','Switzerland','#D52B1E','#FFFFFF'),
  ('canada','international-ice-hockey-men','Canada','#FF0000','#FFFFFF'),
  ('united-states','international-ice-hockey-men','United States','#002868','#BF0D3E'),
  ('finland','international-ice-hockey-men','Finland','#002F6C','#FFFFFF'),
  ('sweden','international-ice-hockey-men','Sweden','#006AA7','#FECC02'),
  ('czechia','international-ice-hockey-men','Czechia','#D7141A','#11457E'),
  ('germany','international-ice-hockey-men','Germany','#000000','#DD0000'),
  ('slovakia','international-ice-hockey-men','Slovakia','#0B4EA2','#EE1C25'),
  ('latvia','international-ice-hockey-men','Latvia','#9E3039','#FFFFFF'),
  ('denmark','international-ice-hockey-men','Denmark','#C60C30','#FFFFFF'),
  ('norway','international-ice-hockey-men','Norway','#BA0C2F','#00205B'),
  ('austria','international-ice-hockey-men','Austria','#ED2939','#FFFFFF'),
  ('slovenia','international-ice-hockey-men','Slovenia','#005DA4','#FFFFFF'),
  ('kazakhstan','international-ice-hockey-men','Kazakhstan','#00AFCA','#FEC50C'),
  ('france','international-ice-hockey-men','France','#002654','#ED2939'),
  ('italy','international-ice-hockey-men','Italy','#0F4C81','#FFFFFF'),
  ('hungary','international-ice-hockey-men','Hungary','#CD2A3E','#436F4D'),
  ('great-britain','international-ice-hockey-men','Great Britain','#CE1126','#00247B'),
  ('ukraine','international-ice-hockey-men','Ukraine','#005BBB','#FFD500'),
  ('poland','international-ice-hockey-men','Poland','#DC143C','#FFFFFF'),
  ('japan','international-ice-hockey-men','Japan','#BC002D','#FFFFFF'),
  ('romania','international-ice-hockey-men','Romania','#FCD116','#002B7F'),
  ('lithuania','international-ice-hockey-men','Lithuania','#FDB913','#006A44'),
  ('south-korea','international-ice-hockey-men','South Korea','#003478','#CD2E3A'),
  ('estonia','international-ice-hockey-men','Estonia','#0072CE','#000000'),
  ('china','international-ice-hockey-men','China','#DE2910','#FFDE00'),
  ('spain','international-ice-hockey-men','Spain','#C60B1E','#FFC400'),
  ('netherlands','international-ice-hockey-men','Netherlands','#FF6C00','#FFFFFF'),
  ('croatia','international-ice-hockey-men','Croatia','#FF0000','#FFFFFF'),
  ('serbia','international-ice-hockey-men','Serbia','#C6363C','#0C4076'),
  ('iceland','international-ice-hockey-men','Iceland','#02529C','#DC1E35'),
  ('georgia','international-ice-hockey-men','Georgia','#FFFFFF','#FF0000'),
  ('bulgaria','international-ice-hockey-men','Bulgaria','#FFFFFF','#00966E'),
  ('chinese-taipei','international-ice-hockey-men','Chinese Taipei','#003DA5','#FFFFFF'),
  ('turkiye','international-ice-hockey-men','Türkiye','#E30A17','#FFFFFF'),
  ('thailand','international-ice-hockey-men','Thailand','#A51931','#2D2A4A'),
  ('south-africa','international-ice-hockey-men','South Africa','#007A4D','#FFB612'),
  ('united-arab-emirates','international-ice-hockey-men','United Arab Emirates','#FF0000','#00732F'),
  ('belgium','international-ice-hockey-men','Belgium','#000000','#FDDA24'),
  ('israel','international-ice-hockey-men','Israel','#0038B8','#FFFFFF'),
  ('new-zealand','international-ice-hockey-men','New Zealand','#000000','#C0C0C0'),
  ('kyrgyzstan','international-ice-hockey-men','Kyrgyzstan','#E8112D','#FFD700'),
  ('turkmenistan','international-ice-hockey-men','Turkmenistan','#00843D','#CE1126'),
  ('mexico','international-ice-hockey-men','Mexico','#006847','#CE1126'),
  ('bosnia-and-herzegovina','international-ice-hockey-men','Bosnia & Herzegovina','#002395','#FECB00'),
  ('luxembourg','international-ice-hockey-men','Luxembourg','#ED2939','#00A1DE'),
  ('hong-kong-china','international-ice-hockey-men','Hong Kong, China','#DE2910','#FFFFFF'),
  ('dpr-korea','international-ice-hockey-men','DPR Korea','#024FA2','#ED1C27'),
  ('mongolia','international-ice-hockey-men','Mongolia','#C4272F','#015197'),
  ('philippines','international-ice-hockey-men','Philippines','#0038A8','#CE1126'),
  ('singapore','international-ice-hockey-men','Singapore','#EF3340','#FFFFFF'),
  ('kuwait','international-ice-hockey-men','Kuwait','#007A3D','#CE1126'),
  ('iran','international-ice-hockey-men','Iran','#239F40','#DA0000'),
  ('indonesia','international-ice-hockey-men','Indonesia','#CE1126','#FFFFFF'),
  ('malaysia','international-ice-hockey-men','Malaysia','#002664','#FFD700'),
  ('uzbekistan','international-ice-hockey-men','Uzbekistan','#1EB53A','#0099B5'),
  ('armenia','international-ice-hockey-men','Armenia','#D90012','#0033A0'),
  ('russia','international-ice-hockey-men','Russia','#0033A0','#D52B1E'),
  ('belarus','international-ice-hockey-men','Belarus','#D22730','#007A3D')
on conflict (competition_slug, slug) do nothing;

with target as (
  select coalesce(
    (select slug from competitions where slug = 'international-ice-hockey-women'),
    'international-ice-hockey-men'
  ) as slug
)
insert into teams (slug, competition_slug, name, primary_color, secondary_color)
select
  t.slug || case when target.slug = 'international-ice-hockey-men' then '-women' else '' end,
  target.slug,
  t.name || case when target.slug = 'international-ice-hockey-men' then ' Women' else '' end,
  t.primary_color, t.secondary_color
from (values
  ('united-states','United States','#002868','#BF0D3E'),
  ('canada','Canada','#FF0000','#FFFFFF'),
  ('czechia','Czechia','#D7141A','#11457E'),
  ('switzerland','Switzerland','#D52B1E','#FFFFFF'),
  ('finland','Finland','#002F6C','#FFFFFF'),
  ('sweden','Sweden','#006AA7','#FECC02'),
  ('germany','Germany','#000000','#DD0000'),
  ('japan','Japan','#BC002D','#FFFFFF'),
  ('hungary','Hungary','#CD2A3E','#436F4D'),
  ('denmark','Denmark','#C60C30','#FFFFFF'),
  ('france','France','#002654','#ED2939'),
  ('norway','Norway','#BA0C2F','#00205B'),
  ('austria','Austria','#ED2939','#FFFFFF'),
  ('china','China','#DE2910','#FFDE00'),
  ('italy','Italy','#0F4C81','#FFFFFF'),
  ('netherlands','Netherlands','#FF6C00','#FFFFFF'),
  ('slovakia','Slovakia','#0B4EA2','#EE1C25'),
  ('south-korea','South Korea','#003478','#CD2E3A'),
  ('great-britain','Great Britain','#CE1126','#00247B'),
  ('poland','Poland','#DC143C','#FFFFFF'),
  ('latvia','Latvia','#9E3039','#FFFFFF'),
  ('kazakhstan','Kazakhstan','#00AFCA','#FEC50C'),
  ('slovenia','Slovenia','#005DA4','#FFFFFF'),
  ('spain','Spain','#C60B1E','#FFC400'),
  ('mexico','Mexico','#006847','#CE1126'),
  ('chinese-taipei','Chinese Taipei','#003DA5','#FFFFFF'),
  ('iceland','Iceland','#02529C','#DC1E35'),
  ('belgium','Belgium','#000000','#FDDA24'),
  ('new-zealand','New Zealand','#000000','#C0C0C0'),
  ('turkiye','Türkiye','#E30A17','#FFFFFF'),
  ('hong-kong-china','Hong Kong, China','#DE2910','#FFFFFF'),
  ('ukraine','Ukraine','#005BBB','#FFD500'),
  ('south-africa','South Africa','#007A4D','#FFB612'),
  ('lithuania','Lithuania','#FDB913','#006A44'),
  ('croatia','Croatia','#FF0000','#FFFFFF'),
  ('romania','Romania','#FCD116','#002B7F'),
  ('dpr-korea','DPR Korea','#024FA2','#ED1C27'),
  ('serbia','Serbia','#C6363C','#0C4076'),
  ('bulgaria','Bulgaria','#FFFFFF','#00966E'),
  ('estonia','Estonia','#0072CE','#000000'),
  ('israel','Israel','#0038B8','#FFFFFF'),
  ('bosnia-and-herzegovina','Bosnia & Herzegovina','#002395','#FECB00'),
  ('thailand','Thailand','#A51931','#2D2A4A'),
  ('singapore','Singapore','#EF3340','#FFFFFF')
) as t(slug, name, primary_color, secondary_color)
cross join target
on conflict (competition_slug, slug) do nothing;
