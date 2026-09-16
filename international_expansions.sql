-- Covers everything from this round:
--  1. Re-sends Suncorp Super Netball (competition + 9 teams) in case it
--     was lost somehow — harmless if it's already there, since both the
--     competition and team inserts are on-conflict-safe.
--  2. Tops up International Netball with the fuller squad list (existing
--     20 teams untouched — new inserts only, via on conflict do nothing).
--  3. Tops up International cricket (men's) the same way, and adds
--     women's international cricket into that SAME "International"
--     competition (not a separate one), each name suffixed " Women" so
--     it doesn't collide with the men's team of the same country.
--  4. Tops up International rugby union (men's) the same way, renames
--     that competition from "International (Men)" to plain
--     "International", and adds women's international rugby union into
--     it the same "Women"-suffixed way.
--
-- Colors reuse whatever this site already uses for that country elsewhere
-- (cricket/rugby league/football) for consistency; countries appearing for
-- the first time get a flag-based guess — smaller/less common nations
-- especially are lower-confidence placeholders, easy to touch up later.
-- Safe to re-run throughout.

-- ============ 1. Suncorp Super Netball (re-send, in case it's missing) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('super-netball','netball','Suncorp Super Netball','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adelaide-thunderbirds','super-netball','Adelaide Thunderbirds','#5C2D91','#FFD200'),
  ('collingwood-magpies','super-netball','Collingwood Magpies','#000000','#FFFFFF'),
  ('giants-netball','super-netball','Giants Netball','#F57F17','#333333'),
  ('melbourne-mavericks','super-netball','Melbourne Mavericks','#002664','#CE1126'),
  ('melbourne-vixens','super-netball','Melbourne Vixens','#002664','#00AEEF'),
  ('nsw-swifts','super-netball','NSW Swifts','#002664','#87CEEB'),
  ('queensland-firebirds','super-netball','Queensland Firebirds','#6A0032','#5C2D91'),
  ('sunshine-coast-lightning','super-netball','Sunshine Coast Lightning','#002664','#EC008C'),
  ('west-coast-fever','super-netball','West Coast Fever','#002664','#FFD200')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

-- ============ 2. International Netball top-up (new teams only) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('kenya','international-netball','Kenya','#006400','#CE1126'),
  ('singapore','international-netball','Singapore','#EF3340','#FFFFFF'),
  ('bermuda','international-netball','Bermuda','#C8102E','#00247D'),
  ('grenada','international-netball','Grenada','#CE1126','#FCD116'),
  ('botswana','international-netball','Botswana','#75AADB','#000000'),
  ('ireland','international-netball','Ireland','#169B62','#FFFFFF'),
  ('sri-lanka','international-netball','Sri Lanka','#003893','#FFB612'),
  ('canada','international-netball','Canada','#FF0000','#FFFFFF'),
  ('papua-new-guinea','international-netball','Papua New Guinea','#CE1126','#000000'),
  ('st-maarten','international-netball','St Maarten','#003DA5','#FFFFFF'),
  ('hong-kong-china','international-netball','Hong Kong, China','#DE2910','#FFFFFF'),
  ('malaysia','international-netball','Malaysia','#002664','#FFD700'),
  ('cayman-islands','international-netball','Cayman Islands','#002664','#CE1126'),
  ('isle-of-man','international-netball','Isle of Man','#CE1126','#FFFFFF'),
  ('st-kitts-nevis','international-netball','St Kitts & Nevis','#006400','#FCD116'),
  ('france','international-netball','France','#002654','#ED2939'),
  ('philippines','international-netball','Philippines','#0038A8','#CE1126'),
  ('united-states','international-netball','USA','#002868','#BF0D3E'),
  ('st-eustatius','international-netball','St Eustatius','#FF6C00','#002664'),
  ('antigua-barbuda','international-netball','Antigua & Barbuda','#CE1126','#002664'),
  ('maldives','international-netball','Maldives','#D21034','#007E3A'),
  ('switzerland','international-netball','Switzerland','#D52B1E','#FFFFFF'),
  ('malta','international-netball','Malta','#CE1126','#FFFFFF'),
  ('british-virgin-islands','international-netball','British Virgin Islands','#002664','#FFFFFF'),
  ('dominica','international-netball','Dominica','#006B3F','#FCD116'),
  ('eswatini','international-netball','Eswatini','#0018A8','#FFD200'),
  ('guadeloupe','international-netball','Guadeloupe','#002654','#FCD116'),
  ('india','international-netball','India','#1B3F8B','#FF9933')
on conflict (competition_slug, slug) do nothing;

-- ============ 3a. International cricket (men's) top-up ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('malaysia','international','Malaysia','#002664','#FFD700'),
  ('kuwait','international','Kuwait','#007A3D','#CE1126'),
  ('spain','international','Spain','#C60B1E','#FFC400'),
  ('qatar','international','Qatar','#8D1B3D','#FFFFFF'),
  ('jersey','international','Jersey','#CE1126','#FFFFFF'),
  ('bahrain','international','Bahrain','#CE1126','#FFFFFF'),
  ('saudi-arabia','international','Saudi Arabia','#006C35','#FFFFFF'),
  ('portugal','international','Portugal','#FF0000','#046A38'),
  ('guernsey','international','Guernsey','#CE1126','#FFFFFF'),
  ('denmark','international','Denmark','#C60C30','#FFFFFF'),
  ('germany','international','Germany','#000000','#DD0000'),
  ('cayman-islands','international','Cayman Islands','#002664','#CE1126'),
  ('nigeria','international','Nigeria','#008751','#FFFFFF'),
  ('singapore','international','Singapore','#EF3340','#FFFFFF'),
  ('austria','international','Austria','#ED2939','#FFFFFF'),
  ('sweden','international','Sweden','#006AA7','#FECC02'),
  ('belgium','international','Belgium','#000000','#FDDA24'),
  ('finland','international','Finland','#002F6C','#FFFFFF'),
  ('argentina','international','Argentina','#75AADB','#FFFFFF'),
  ('france','international','France','#002654','#ED2939'),
  ('romania','international','Romania','#FCD116','#002B7F')
on conflict (competition_slug, slug) do nothing;

-- ============ 3b. Women's international cricket (merged into "International") ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('australia-women','international','Australia Women','#FFD100','#00843D'),
  ('england-women','international','England Women','#041E42','#7EA8E0'),
  ('india-women','international','India Women','#1B3F8B','#FF9933'),
  ('new-zealand-women','international','New Zealand Women','#000000','#C0C0C0'),
  ('south-africa-women','international','South Africa Women','#007A4D','#FFB612'),
  ('sri-lanka-women','international','Sri Lanka Women','#003893','#FFB612'),
  ('west-indies-women','international','West Indies Women','#7B1113','#FFD700'),
  ('pakistan-women','international','Pakistan Women','#01411C','#FFFFFF'),
  ('ireland-women','international','Ireland Women','#169B62','#FFFFFF'),
  ('bangladesh-women','international','Bangladesh Women','#006A4E','#F42A41'),
  ('scotland-women','international','Scotland Women','#00205B','#FFFFFF'),
  ('thailand-women','international','Thailand Women','#A51931','#2D2A4A'),
  ('papua-new-guinea-women','international','Papua New Guinea Women','#CE1126','#000000'),
  ('netherlands-women','international','Netherlands Women','#FF6C00','#FFFFFF'),
  ('united-arab-emirates-women','international','United Arab Emirates Women','#FF0000','#00732F'),
  ('zimbabwe-women','international','Zimbabwe Women','#CE1126','#006400'),
  ('uganda-women','international','Uganda Women','#000000','#FCDD09'),
  ('namibia-women','international','Namibia Women','#003580','#D21034'),
  ('usa-women','international','USA Women','#002868','#BF0D3E'),
  ('tanzania-women','international','Tanzania Women','#1EB53A','#00A3DD'),
  ('nepal-women','international','Nepal Women','#DC143C','#003893'),
  ('hong-kong-women','international','Hong Kong Women','#DE2910','#FFFFFF'),
  ('indonesia-women','international','Indonesia Women','#CE1126','#FFFFFF'),
  ('rwanda-women','international','Rwanda Women','#20603D','#FAD201'),
  ('italy-women','international','Italy Women','#0F4C81','#FFFFFF'),
  ('nigeria-women','international','Nigeria Women','#008751','#FFFFFF'),
  ('brazil-women','international','Brazil Women','#009739','#FEDD00'),
  ('malaysia-women','international','Malaysia Women','#002664','#FFD700'),
  ('vanuatu-women','international','Vanuatu Women','#D21034','#FDCE12'),
  ('germany-women','international','Germany Women','#000000','#DD0000')
on conflict (competition_slug, slug) do nothing;

-- ============ 4a. International rugby union (men's) top-up ============
update teams set name = 'Czechia' where competition_slug = 'international-rugby-union-men' and slug = 'czech-republic';

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('united-states','international-rugby-union-men','USA','#002868','#BF0D3E'),
  ('uruguay','international-rugby-union-men','Uruguay','#0038A8','#FFFFFF'),
  ('tonga','international-rugby-union-men','Tonga','#C10000','#FFFFFF'),
  ('belgium','international-rugby-union-men','Belgium','#000000','#FDDA24'),
  ('hong-kong-china','international-rugby-union-men','Hong Kong China','#DE2910','#FFFFFF'),
  ('zimbabwe','international-rugby-union-men','Zimbabwe','#CE1126','#006400'),
  ('netherlands','international-rugby-union-men','Netherlands','#FF6C00','#FFFFFF'),
  ('paraguay','international-rugby-union-men','Paraguay','#0038A8','#CE1126'),
  ('russia','international-rugby-union-men','Russia','#0033A0','#D52B1E'),
  ('brazil','international-rugby-union-men','Brazil','#009739','#FEDD00'),
  ('germany','international-rugby-union-men','Germany','#000000','#DD0000'),
  ('kenya','international-rugby-union-men','Kenya','#006400','#CE1126'),
  ('mexico','international-rugby-union-men','Mexico','#006847','#CE1126'),
  ('korea','international-rugby-union-men','Korea','#003478','#CD2E3A'),
  ('morocco','international-rugby-union-men','Morocco','#C1272D','#006233'),
  ('united-arab-emirates','international-rugby-union-men','United Arab Emirates','#FF0000','#00732F'),
  ('colombia','international-rugby-union-men','Colombia','#FCD116','#003893'),
  ('cayman-islands','international-rugby-union-men','Cayman Islands','#002664','#CE1126'),
  ('philippines','international-rugby-union-men','Philippines','#0038A8','#CE1126'),
  ('algeria','international-rugby-union-men','Algeria','#006233','#D21034'),
  ('madagascar','international-rugby-union-men','Madagascar','#FC3D32','#007E3A'),
  ('senegal','international-rugby-union-men','Senegal','#00853F','#FDEF42'),
  ('tunisia','international-rugby-union-men','Tunisia','#E70013','#FFFFFF'),
  ('sri-lanka','international-rugby-union-men','Sri Lanka','#003893','#FFB612'),
  ('uganda','international-rugby-union-men','Uganda','#000000','#FCDD09'),
  ('trinidad-tobago','international-rugby-union-men','Trinidad & Tobago','#CE1126','#000000'),
  ('malaysia','international-rugby-union-men','Malaysia','#002664','#FFD700'),
  ('kazakhstan','international-rugby-union-men','Kazakhstan','#00AFCA','#FEC50C'),
  ('barbados','international-rugby-union-men','Barbados','#00267F','#FFC726'),
  ('chinese-taipei','international-rugby-union-men','Chinese Taipei','#003DA5','#FFFFFF'),
  ('jamaica','international-rugby-union-men','Jamaica','#FED100','#009B3A'),
  ('israel','international-rugby-union-men','Israel','#0038B8','#FFFFFF'),
  ('zambia','international-rugby-union-men','Zambia','#198A00','#EF7D00'),
  ('cook-islands','international-rugby-union-men','Cook Islands','#00247D','#CE1126'),
  ('cote-d-ivoire','international-rugby-union-men','Cote D''Ivoire','#F77F00','#009E60'),
  ('bermuda','international-rugby-union-men','Bermuda','#C8102E','#00247D'),
  ('thailand','international-rugby-union-men','Thailand','#A51931','#2D2A4A'),
  ('singapore','international-rugby-union-men','Singapore','#EF3340','#FFFFFF'),
  ('guyana','international-rugby-union-men','Guyana','#009E49','#FCD116'),
  ('nigeria','international-rugby-union-men','Nigeria','#008751','#FFFFFF'),
  ('venezuela','international-rugby-union-men','Venezuela','#FCD116','#00247D'),
  ('botswana','international-rugby-union-men','Botswana','#75AADB','#000000'),
  ('peru','international-rugby-union-men','Peru','#D91023','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

update competitions set name = 'International' where slug = 'international-rugby-union-men';

-- ============ 4b. Women's international rugby union (merged into that same competition) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('england-women','international-rugby-union-men','England Women','#FFFFFF','#CF081F'),
  ('new-zealand-women','international-rugby-union-men','New Zealand Women','#000000','#FFFFFF'),
  ('canada-women','international-rugby-union-men','Canada Women','#FF0000','#FFFFFF'),
  ('france-women','international-rugby-union-men','France Women','#002654','#FFFFFF'),
  ('ireland-women','international-rugby-union-men','Ireland Women','#169B62','#FFFFFF'),
  ('italy-women','international-rugby-union-men','Italy Women','#0F4C81','#FFFFFF'),
  ('scotland-women','international-rugby-union-men','Scotland Women','#00205B','#FFFFFF'),
  ('usa-women','international-rugby-union-men','USA Women','#002868','#BF0D3E'),
  ('australia-women','international-rugby-union-men','Australia Women','#FFD700','#00843D'),
  ('south-africa-women','international-rugby-union-men','South Africa Women','#007A4D','#FFB612'),
  ('japan-women','international-rugby-union-men','Japan Women','#BC002D','#FFFFFF'),
  ('fiji-women','international-rugby-union-men','Fiji Women','#71C5E8','#FFFFFF'),
  ('wales-women','international-rugby-union-men','Wales Women','#C8102E','#FFFFFF'),
  ('spain-women','international-rugby-union-men','Spain Women','#C60B1E','#FFC400'),
  ('netherlands-women','international-rugby-union-men','Netherlands Women','#FF6C00','#FFFFFF'),
  ('hong-kong-china-women','international-rugby-union-men','Hong Kong China Women','#DE2910','#FFFFFF'),
  ('samoa-women','international-rugby-union-men','Samoa Women','#002B7F','#CE1126'),
  ('russia-women','international-rugby-union-men','Russia Women','#0033A0','#D52B1E'),
  ('kazakhstan-women','international-rugby-union-men','Kazakhstan Women','#00AFCA','#FEC50C'),
  ('germany-women','international-rugby-union-men','Germany Women','#000000','#DD0000'),
  ('kenya-women','international-rugby-union-men','Kenya Women','#006400','#CE1126'),
  ('sweden-women','international-rugby-union-men','Sweden Women','#006AA7','#FECC02'),
  ('belgium-women','international-rugby-union-men','Belgium Women','#000000','#FDDA24'),
  ('portugal-women','international-rugby-union-men','Portugal Women','#FF0000','#046A38'),
  ('brazil-women','international-rugby-union-men','Brazil Women','#009739','#FEDD00'),
  ('uganda-women','international-rugby-union-men','Uganda Women','#000000','#FCDD09'),
  ('georgia-women','international-rugby-union-men','Georgia Women','#FFFFFF','#FF0000'),
  ('tonga-women','international-rugby-union-men','Tonga Women','#C10000','#FFFFFF'),
  ('mexico-women','international-rugby-union-men','Mexico Women','#006847','#CE1126'),
  ('china-women','international-rugby-union-men','China Women','#DE2910','#FFDE00'),
  ('colombia-women','international-rugby-union-men','Colombia Women','#FCD116','#003893'),
  ('andorra-women','international-rugby-union-men','Andorra Women','#0018A8','#FEDF00'),
  ('trinidad-tobago-women','international-rugby-union-men','Trinidad & Tobago Women','#CE1126','#000000'),
  ('tunisia-women','international-rugby-union-men','Tunisia Women','#E70013','#FFFFFF'),
  ('finland-women','international-rugby-union-men','Finland Women','#002F6C','#FFFFFF'),
  ('madagascar-women','international-rugby-union-men','Madagascar Women','#FC3D32','#007E3A'),
  ('cameroon-women','international-rugby-union-men','Cameroon Women','#007A5E','#CE1126'),
  ('austria-women','international-rugby-union-men','Austria Women','#ED2939','#FFFFFF'),
  ('latvia-women','international-rugby-union-men','Latvia Women','#9E3039','#FFFFFF'),
  ('malaysia-women','international-rugby-union-men','Malaysia Women','#002664','#FFD700'),
  ('morocco-women','international-rugby-union-men','Morocco Women','#C1272D','#006233'),
  ('jamaica-women','international-rugby-union-men','Jamaica Women','#FED100','#009B3A'),
  ('croatia-women','international-rugby-union-men','Croatia Women','#FF0000','#FFFFFF'),
  ('czechia-women','international-rugby-union-men','Czechia Women','#D7141A','#11457E'),
  ('romania-women','international-rugby-union-men','Romania Women','#FCD116','#002B7F'),
  ('denmark-women','international-rugby-union-men','Denmark Women','#C60C30','#FFFFFF'),
  ('bulgaria-women','international-rugby-union-men','Bulgaria Women','#FFFFFF','#00966E'),
  ('papua-new-guinea-women','international-rugby-union-men','Papua New Guinea Women','#CE1126','#000000'),
  ('singapore-women','international-rugby-union-men','Singapore Women','#EF3340','#FFFFFF'),
  ('norway-women','international-rugby-union-men','Norway Women','#BA0C2F','#00205B')
on conflict (competition_slug, slug) do nothing;
