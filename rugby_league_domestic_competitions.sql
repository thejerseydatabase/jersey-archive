-- ============================================================
-- 0. Merge Women's State of Origin into State of Origin
-- ============================================================
-- Both competitions already have identically-slugged/named/coloured teams
-- (new-south-wales-blues, queensland-maroons), so this is a straight
-- move + delete, same pattern used for the earlier basketball/football/
-- rugby-league-international/baseball/ice-hockey gender merges. The
-- moved women's teams get " Women" appended so the site's existing
-- gender-split-grid UI (any competition with a team name containing
-- "Women") picks it up automatically as a filter/split — no app.js
-- change needed. Safe to re-run (no-ops once already merged).

update teams set slug = slug || '-women', name = name || ' Women'
  where competition_slug = 'state-of-origin-women';

update teams set competition_slug = 'state-of-origin'
  where competition_slug = 'state-of-origin-women';

delete from competitions where slug = 'state-of-origin-women';

-- ============================================================
-- Rugby league domestic/amateur/representative competitions from your
-- Wikipedia lists (24 competitions). All new, all tier 'more'. Safe to
-- re-run (on conflict do nothing throughout).
--
-- Colour notes:
-- - Where a club's exact name already exists elsewhere on the site
--   (Super League / Championship England, mostly), I reused its real
--   colours: Bradford Bulls, Castleford Tigers, Hull FC, Hull KR,
--   London Broncos, Salford, Sheffield Eagles, Warrington Wolves,
--   Widnes Vikings, Midlands Hurricanes, Dewsbury Rams, Barrow (Raiders),
--   Goole Vikings, Hunslet, Keighley, North Wales Crusaders, Oldham,
--   Rochdale Hornets, Swinton (Lions), Whitehaven, Workington (Town),
--   York Knights, Toulouse Olympique, Newcastle Thunder, Doncaster.
-- - Everything else (the huge majority of clubs in this batch — French,
--   Irish, English amateur, Dutch, Norwegian, Serbian, Australian
--   suburban, Fijian, NZ, PNG, Philippine, Nigerian, South African and
--   US semi-pro/amateur clubs) has NO real brand colour I know of. I've
--   given them generic placeholder swatches cycled from a small palette
--   just so cards aren't blank — treat every one of these as a
--   low-confidence guess to be replaced whenever a real kit photo turns up.
-- - Slug note: rugby league's own "League One" competition is called
--   'rfl-league-one' here since 'league-one' is already taken by
--   football's League One.
-- - BSDRL (Brisbane Second Division Rugby League) runs 6 parallel
--   grade divisions with heavy club overlap; since the schema has no
--   division field, I've flattened it to one list of unique clubs.
--   "Pine Rivers Bears" is listed with two different nicknames
--   (Panthers/Bears) across divisions in your source — likely a
--   Wikipedia copy artifact — I went with "Pine Rivers Bears" as the
--   name and dropped the conflicting nickname.
-- - USARL: the 13 current teams already appear twice in your source
--   (grouped by coast, then again by conference) — inserted once.
--   Utah Rugby League is listed as a separate "unaffiliated" league, so
--   it's its own competition. "916ers Rugby" appeared in the "Former
--   teams" table with years "2026" (likely a brand new/incoming side
--   your source hadn't re-categorised yet) — added as inactive per the
--   table it was actually listed under; flag if that's wrong.
-- ============================================================

insert into competitions (slug, sport_slug, name, tier) values
  ('super-xiii','rugby-league','Super XIII','more'),
  ('elite-2','rugby-league','Elite 2','more'),
  ('rfl-league-one','rugby-league','League One (RFL, 2003–2025)','more'),
  ('rli-premiership','rugby-league','RLI Premiership','more'),
  ('national-premier-league','rugby-league','National Premier League','more'),
  ('national-league-one','rugby-league','National League One','more'),
  ('nrlb-championship','rugby-league','NRLB Championship','more'),
  ('rugby-league-norway','rugby-league','Norway National Competition','more'),
  ('serbian-rugby-league-championship','rugby-league','Serbian Rugby League Championship','more'),
  ('warl-first-grade','rugby-league','WARL First Grade','more'),
  ('newcastle-rugby-league','rugby-league','Newcastle Rugby League','more'),
  ('nrl-northern-territory','rugby-league','NRL Northern Territory','more'),
  ('ron-massey-cup','rugby-league','Ron Massey Cup','more'),
  ('qld-south-east-division','rugby-league','QLD South East Division','more'),
  ('bsdrl','rugby-league','Brisbane Second Division Rugby League','more'),
  ('fiji-vodafone-cup','rugby-league','Fiji National Rugby League (Vodafone Cup)','more'),
  ('nzrl-national-competition','rugby-league','NZRL Men''s National Competition','more'),
  ('png-digicel-cup','rugby-league','PNG Digicel Cup','more'),
  ('philippines-champions-shield','rugby-league','Philippine National Rugby League Champions Shield','more'),
  ('nigeria-rugby-league','rugby-league','Nigeria Rugby League','more'),
  ('rhino-cup','rugby-league','Rhino Cup','more'),
  ('super-league-women','rugby-league','Women''s Super League','more'),
  ('championship-women','rugby-league','RFL Women''s Championship','more'),
  ('usarl','rugby-league','USARL','more'),
  ('utah-rugby-league','rugby-league','Utah Rugby League','more')
on conflict (slug) do nothing;

-- ============ 1. Super XIII (France) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('albi-rl','super-xiii','Albi RL','#CE1126','#FFFFFF'),
  ('so-avignon','super-xiii','SO Avignon','#002664','#FFD700'),
  ('as-carcassonne','super-xiii','AS Carcassonne','#000000','#FFD700'),
  ('fc-lezignan','super-xiii','FC Lézignan','#00843D','#FFFFFF'),
  ('limoux-grizzlies','super-xiii','Limoux Grizzlies','#5C2D91','#FFD700'),
  ('pia-xiii','super-xiii','Pia XIII','#003893','#FFFFFF'),
  ('saint-esteve-catalan','super-xiii','Saint-Estève Catalan','#CE1126','#FFD700'),
  ('saint-gaudens-bears','super-xiii','Saint-Gaudens Bears','#6A0032','#FFD700'),
  ('toulouse-olympique-broncos','super-xiii','Toulouse Olympique Broncos','#8C1D2D','#000000'),
  ('villefranche-xiii-aveyron','super-xiii','Villefranche XIII Aveyron','#002664','#FFFFFF'),
  ('villeneuve-leopards','super-xiii','Villeneuve Leopards','#FFD700','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ 2. Elite 2 (France) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('rc-carpentras-xiii','elite-2','RC Carpentras XIII','#CE1126','#FFFFFF'),
  ('ille-sur-tet-xiii','elite-2','Ille-sur-Tet XIII','#002664','#FFD700'),
  ('rc-lescure-arthes-xiii','elite-2','RC Lescure-Arthes XIII','#000000','#FFD700'),
  ('palau-xiii-broncos','elite-2','Palau XIII Broncos','#8C1D2D','#000000'),
  ('pamiers-xiii','elite-2','Pamiers XIII','#00843D','#FFFFFF'),
  ('realmont-xiii','elite-2','Realmont XIII','#5C2D91','#FFD700'),
  ('rc-salon-xiii','elite-2','RC Salon XIII','#003893','#FFFFFF'),
  ('tonneins-xiii','elite-2','Tonneins XIII','#6A0032','#FFD700'),
  ('villegailhenc-aragon-xiii','elite-2','Villegailhenc-Aragon XIII','#CE1126','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ 3. RFL League One (disbanded 2025) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('barrow-raiders','rfl-league-one','Barrow Raiders','#CE1126','#002664'),
  ('blackpool-panthers','rfl-league-one','Blackpool Panthers','#FF7F00','#000000'),
  ('bradford-bulls','rfl-league-one','Bradford Bulls','#8A1538','#FFB81C'),
  ('celtic-crusaders','rfl-league-one','Celtic Crusaders','#CE1126','#00843D'),
  ('chorley-lynx','rfl-league-one','Chorley Lynx','#5C2D91','#FFD700'),
  ('cornwall-rl','rfl-league-one','Cornwall','#000000','#FFD700'),
  ('dewsbury-rams','rfl-league-one','Dewsbury Rams','#003893','#FFFFFF'),
  ('doncaster-rl','rfl-league-one','Doncaster','#CE1126','#000000'),
  ('featherstone-rovers','rfl-league-one','Featherstone Rovers','#003893','#FFD700'),
  ('gloucestershire-all-golds','rfl-league-one','Gloucestershire All Golds','#FFD700','#000000'),
  ('goole-vikings','rfl-league-one','Goole Vikings','#000000','#FFD700'),
  ('hemel-stags','rfl-league-one','Hemel Stags','#00AEEF','#000000'),
  ('hunslet','rfl-league-one','Hunslet','#00693E','#FFD700'),
  ('keighley-cougars','rfl-league-one','Keighley Cougars','#FFD700','#000000'),
  ('london-skolars','rfl-league-one','London Skolars','#5C2D91','#FFD700'),
  ('midlands-hurricanes','rfl-league-one','Midlands Hurricanes','#5C2D91','#000000'),
  ('newcastle-thunder','rfl-league-one','Newcastle Thunder','#F57F17','#000000'),
  ('north-wales-crusaders','rfl-league-one','North Wales Crusaders','#CE1126','#00843D'),
  ('oldham-rl','rfl-league-one','Oldham','#CE1126','#FFFFFF'),
  ('oxford-rl','rfl-league-one','Oxford','#00205B','#FFFFFF'),
  ('rochdale-hornets','rfl-league-one','Rochdale Hornets','#000000','#FFD700'),
  ('sheffield-eagles','rfl-league-one','Sheffield Eagles','#6A0032','#FFD700'),
  ('swinton-lions','rfl-league-one','Swinton Lions','#003893','#FFFFFF'),
  ('toronto-wolfpack','rfl-league-one','Toronto Wolfpack','#000000','#FFD700'),
  ('toulouse-olympique','rfl-league-one','Toulouse Olympique','#8C1D2D','#000000'),
  ('west-wales-raiders','rfl-league-one','West Wales Raiders','#CE1126','#00843D'),
  ('whitehaven-rl','rfl-league-one','Whitehaven','#FFD700','#000000'),
  ('workington-town','rfl-league-one','Workington Town','#002664','#CE1126'),
  ('york-knights','rfl-league-one','York Knights','#7A1F2B','#FFD200')
on conflict (competition_slug, slug) do nothing;

-- ============ 4. RLI Premiership (Ireland) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('dublin-city-exiles','rli-premiership','Dublin City Exiles','#003893','#FFFFFF'),
  ('banbridge-broncos','rli-premiership','Banbridge Broncos','#CE1126','#FFD700'),
  ('galway-tribesmen','rli-premiership','Galway Tribesmen','#00843D','#FFFFFF'),
  ('longhorns-rl','rli-premiership','Longhorns RL','#5C2D91','#FFD700'),
  ('cork-bulls','rli-premiership','Cork Bulls','#CE1126','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ 5. National Premier League (England amateur) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('heworth','national-premier-league','Heworth','#003893','#FFFFFF'),
  ('hunslet-arlfc','national-premier-league','Hunslet ARLFC','#00693E','#FFD700'),
  ('castleford-lock-lane','national-premier-league','Castleford Lock Lane','#000000','#FDB913'),
  ('rochdale-mayfield','national-premier-league','Rochdale Mayfield','#000000','#FFD700'),
  ('siddal','national-premier-league','Siddal','#CE1126','#000000'),
  ('thatto-heath-crusaders','national-premier-league','Thatto Heath Crusaders','#D2202B','#FFFFFF'),
  ('waterhead-warriors','national-premier-league','Waterhead Warriors','#5C2D91','#FFD700'),
  ('wath-brow-hornets','national-premier-league','Wath Brow Hornets','#FFD700','#000000'),
  ('west-bowling','national-premier-league','West Bowling','#8A1538','#FFB81C'),
  ('west-hull','national-premier-league','West Hull','#000000','#FFFFFF'),
  ('wigan-st-judes','national-premier-league','Wigan St Judes','#8C1D40','#FFFFFF'),
  ('york-acorn','national-premier-league','York Acorn','#7A1F2B','#FFD200')
on conflict (competition_slug, slug) do nothing;

-- ============ 6. National League One (England amateur) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('dewsbury-celtic','national-league-one','Dewsbury Celtic','#003893','#FFFFFF'),
  ('dewsbury-moor-maroons','national-league-one','Dewsbury Moor Maroons','#6A0032','#FFD700'),
  ('east-leeds','national-league-one','East Leeds','#003087','#FDB913'),
  ('egremont-rangers','national-league-one','Egremont Rangers','#00843D','#FFFFFF'),
  ('kells','national-league-one','Kells','#CE1126','#000000'),
  ('leigh-miners-rangers','national-league-one','Leigh Miners Rangers','#C8102E','#FFD200'),
  ('oldham-st-annes','national-league-one','Oldham St Annes','#CE1126','#FFFFFF'),
  ('oulton-raiders','national-league-one','Oulton Raiders','#5C2D91','#FFD700'),
  ('pilkington-recs','national-league-one','Pilkington Recs','#000000','#FFD700'),
  ('shaw-cross-sharks','national-league-one','Shaw Cross Sharks','#00AEEF','#000000'),
  ('stanningley','national-league-one','Stanningley','#003893','#FFFFFF'),
  ('wigan-st-patricks','national-league-one','Wigan St Patricks','#8C1D40','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ 7. NRLB Championship (Netherlands) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('den-haag-knights','nrlb-championship','Den Haag Knights','#FF6C00','#000000'),
  ('harderwijk-dolphins','nrlb-championship','Harderwijk Dolphins','#00AEEF','#FFFFFF'),
  ('rotterdam-pitbulls','nrlb-championship','Rotterdam Pitbulls','#000000','#FF6C00'),
  ('zwolle-wolves','nrlb-championship','Zwolle Wolves','#5C2D91','#FFFFFF'),
  ('amsterdam-cobras','nrlb-championship','Amsterdam Cobras','#FF6C00','#FFFFFF'),
  ('brabant-bears','nrlb-championship','Brabant Bears','#CE1126','#FF6C00')
on conflict (competition_slug, slug) do nothing;

-- ============ 8. Norway National Competition ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('lillestrom-lions','rugby-league-norway','Lillestrøm Lions','#BA0C2F','#00205B'),
  ('farsund-bobcats','rugby-league-norway','Farsund Bobcats','#000000','#FFD700'),
  ('sandnes-raiders','rugby-league-norway','Sandnes Raiders','#CE1126','#FFFFFF'),
  ('midgard-marauders','rugby-league-norway','Midgard Marauders','#5C2D91','#FFD700')
on conflict (competition_slug, slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('porsgrunn-pirates','rugby-league-norway','Porsgrunn Pirates','#000000','#FFD700',false),
  ('tromso-polar-bears','rugby-league-norway','Tromsø Polar Bears','#00AEEF','#FFFFFF',false),
  ('bodo-barbarians','rugby-league-norway','Bodø Barbarians','#CE1126','#000000',false),
  ('haugesund-sea-eagles','rugby-league-norway','Haugesund Sea Eagles','#003893','#FFFFFF',false),
  ('trondheim-rugbyklubb','rugby-league-norway','Trondheim Rugbyklubb','#BA0C2F','#00205B',false),
  ('indre-vestland','rugby-league-norway','Indre Vestland','#00843D','#FFFFFF',false),
  ('oslo-capitols','rugby-league-norway','Oslo Capitols','#000000','#FFD700',false),
  ('stavanger-storm','rugby-league-norway','Stavanger Storm','#CE1126','#FFFFFF',false),
  ('aker-seagulls','rugby-league-norway','Aker Seagulls','#00AEEF','#000000',false)
on conflict (competition_slug, slug) do nothing;

-- ============ 9. Serbian Rugby League Championship ============
-- Collapsed to each club's latest/current name where your source noted a
-- rename chain (e.g. Radnički Niš formerly Palilulac Hammers; Heroj
-- Polet formerly Voždovac Dragons; Red and Whites formerly Podbara).
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('belgrade-university','serbian-rugby-league-championship','Belgrade University','#003893','#FFFFFF'),
  ('white-eagle-krusevac','serbian-rugby-league-championship','White Eagle - Kruševac','#FFFFFF','#000000'),
  ('fighter-rakovica','serbian-rugby-league-championship','Fighter - Rakovica','#CE1126','#000000'),
  ('tsar-lazar-krusevac','serbian-rugby-league-championship','Tsar Lazar - Kruševac','#5C2D91','#FFD700'),
  ('dorcol-spiders','serbian-rugby-league-championship','Dorćol Spiders Belgrade','#000000','#FFD700'),
  ('fpn-xiii-belgrade','serbian-rugby-league-championship','FPN XIII - Belgrade','#00843D','#FFFFFF'),
  ('kolubara-lazarevac','serbian-rugby-league-championship','Kolubara - Lazarevac','#CE1126','#FFD700'),
  ('new-belgrade','serbian-rugby-league-championship','New Belgrade','#003893','#FFFFFF'),
  ('morava-eels','serbian-rugby-league-championship','Morava Eels - Belgrade','#00AEEF','#000000'),
  ('morava-cheetahs','serbian-rugby-league-championship','Morava Cheetahs - Leskovac','#FFD700','#000000'),
  ('mosquitos-belgrade','serbian-rugby-league-championship','Mosquitos Belgrade','#CE1126','#FFFFFF'),
  ('novi-sad','serbian-rugby-league-championship','Novi Sad','#003893','#FFD700'),
  ('pancevo','serbian-rugby-league-championship','Pančevo','#5C2D91','#FFFFFF'),
  ('radnicki-nis','serbian-rugby-league-championship','Radnički Niš','#000000','#CE1126'),
  ('red-and-whites-novi-sad','serbian-rugby-league-championship','Red and Whites - Novi Sad','#CE1126','#FFFFFF'),
  ('radnicki-nova-pazova','serbian-rugby-league-championship','Radnički - Nova Pazova','#003893','#FFFFFF'),
  ('red-star-belgrade','serbian-rugby-league-championship','Red Star - Belgrade','#CE1126','#FFFFFF'),
  ('red-kangaroo-belgrade','serbian-rugby-league-championship','Red Kangaroo - Belgrade','#CE1126','#000000'),
  ('falcon-vranje','serbian-rugby-league-championship','Falcon - Vranje','#5C2D91','#FFD700'),
  ('old-town-belgrade','serbian-rugby-league-championship','Old Town - Belgrade','#000000','#FFFFFF'),
  ('vojvodina-novi-sad','serbian-rugby-league-championship','Vojvodina - Novi Sad','#CE1126','#FFD700'),
  ('heroj-polet','serbian-rugby-league-championship','Heroj Polet - Belgrade','#00843D','#FFFFFF'),
  ('radnicki-new-belgrade','serbian-rugby-league-championship','Radnički New Belgrade','#003893','#CE1126'),
  ('dorcol-tigers','serbian-rugby-league-championship','Dorćol Tigers','#FFD700','#000000'),
  ('military-academy','serbian-rugby-league-championship','Military Academy','#4B5320','#000000'),
  ('rlc-zemun','serbian-rugby-league-championship','RLC Zemun','#5C2D91','#FFFFFF'),
  ('policeman-belgrade','serbian-rugby-league-championship','Policeman - Belgrade','#00205B','#FFFFFF'),
  ('duke-unity-pancevo','serbian-rugby-league-championship','Duke/Unity - Pančevo','#CE1126','#FFD700'),
  ('partizan-belgrade','serbian-rugby-league-championship','Partizan - Belgrade','#000000','#FFFFFF'),
  ('tzar-dusan-paracin','serbian-rugby-league-championship','Tzar Dušan Paraćin','#6A0032','#FFD700'),
  ('belgrade-youth-rl','serbian-rugby-league-championship','Belgrade Youth Rugby League Club','#003893','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ 10. WARL First Grade (Western Australia) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('ellenbrook-rabbitohs','warl-first-grade','Ellenbrook Rabbitohs','#00843D','#FFD700'),
  ('fremantle-roosters','warl-first-grade','Fremantle Roosters','#FFFFFF','#000000'),
  ('joondalup-giants','warl-first-grade','Joondalup Giants','#003893','#FFFFFF'),
  ('kalamunda-bulldogs','warl-first-grade','Kalamunda Bulldogs','#000000','#FFFFFF'),
  ('kwinana-titans','warl-first-grade','Kwinana Titans','#00AEEF','#000000'),
  ('north-beach-sea-eagles','warl-first-grade','North Beach Sea Eagles','#00205B','#FFFFFF'),
  ('rockingham-coastal-sharks','warl-first-grade','Rockingham Coastal Sharks','#00AEEF','#FFFFFF'),
  ('south-perth-lions','warl-first-grade','South Perth Lions','#FFD700','#000000'),
  ('willagee-bears','warl-first-grade','Willagee Bears','#5C2D91','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ 11. Newcastle Rugby League (Australia) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('central-newcastle-butcher-boys','newcastle-rugby-league','Central Newcastle Butcher Boys','#CE1126','#000000'),
  ('cessnock-goannas','newcastle-rugby-league','Cessnock Goannas','#00843D','#FFD700'),
  ('kurri-kurri-bulldogs','newcastle-rugby-league','Kurri Kurri Bulldogs','#000000','#FFFFFF'),
  ('lakes-united-seagulls','newcastle-rugby-league','Lakes United Seagulls','#00AEEF','#FFFFFF'),
  ('macquarie-scorpions','newcastle-rugby-league','Macquarie Scorpions','#5C2D91','#FFD700'),
  ('maitland-pickers','newcastle-rugby-league','Maitland Pickers','#CE1126','#FFD700'),
  ('northern-hawks','newcastle-rugby-league','Northern Hawks','#003893','#FFFFFF'),
  ('south-newcastle-lions','newcastle-rugby-league','South Newcastle Lions','#FFD700','#000000'),
  ('the-entrance-tigers','newcastle-rugby-league','The Entrance Tigers','#FF7F00','#000000'),
  ('western-suburbs-rosellas','newcastle-rugby-league','Western Suburbs Rosellas','#00843D','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('central-south-newcastle','newcastle-rugby-league','Central-South Newcastle','#CE1126','#000000',false),
  ('eastern-suburbs-newcastle','newcastle-rugby-league','Eastern Suburbs','#003893','#FFFFFF',false),
  ('maitland-united-pumpkin-pickers','newcastle-rugby-league','Maitland United Pumpkin Pickers','#CE1126','#FFD700',false),
  ('morpeth','newcastle-rugby-league','Morpeth','#5C2D91','#FFFFFF',false),
  ('north-nelson-bay-marlins','newcastle-rugby-league','North-Nelson Bay Marlins','#00AEEF','#000000',false),
  ('northern-blues','newcastle-rugby-league','Northern Blues','#003893','#FFD700',false),
  ('north-newcastle-bluebags','newcastle-rugby-league','North Newcastle Bluebags','#00205B','#FFFFFF',false),
  ('port-stephens-sharks','newcastle-rugby-league','Port Stephens Sharks','#00AEEF','#FFFFFF',false),
  ('raymond-terrace-magpies','newcastle-rugby-league','Raymond Terrace Magpies','#000000','#FFFFFF',false),
  ('wyong-roos','newcastle-rugby-league','Wyong Roos','#FFD700','#000000',false),
  ('waratah-mayfield-cheetahs','newcastle-rugby-league','Waratah-Mayfield Cheetahs','#CE1126','#FFD700',false)
on conflict (competition_slug, slug) do nothing;

-- ============ 12. NRL Northern Territory ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('darwin-brothers-leprechauns','nrl-northern-territory','Darwin Brothers Leprechauns','#00843D','#FFD700'),
  ('litchfield-bears','nrl-northern-territory','Litchfield Bears','#5C2D91','#FFD700'),
  ('mackillop-sharks','nrl-northern-territory','Mackillop Sharks','#00AEEF','#000000'),
  ('nightcliff-dragons','nrl-northern-territory','Nightcliff Dragons','#CE1126','#FFD700'),
  ('palmerston-raiders','nrl-northern-territory','Palmerston Raiders','#003893','#FFFFFF'),
  ('south-darwin-rabbitohs','nrl-northern-territory','South Darwin Rabbitohs','#00843D','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ 13. Ron Massey Cup (NSW) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('blacktown-workers','ron-massey-cup','Blacktown Workers','#CE1126','#000000'),
  ('canterbury-bankstown-bulldogs','ron-massey-cup','Canterbury-Bankstown Bulldogs','#00205B','#FFFFFF'),
  ('glebe-dirty-reds','ron-massey-cup','Glebe Dirty Reds','#CE1126','#FFFFFF'),
  ('hills-district-bulls','ron-massey-cup','Hills District Bulls','#000000','#FFD700'),
  ('manly-leagues','ron-massey-cup','Manly Leagues','#7B0041','#FFFFFF'),
  ('mounties-rlfc','ron-massey-cup','Mounties RLFC','#5C2D91','#FFD700'),
  ('penrith-brothers','ron-massey-cup','Penrith Brothers','#00843D','#FFD700'),
  ('ryde-eastwood-hawks','ron-massey-cup','Ryde-Eastwood Hawks','#003893','#FFFFFF'),
  ('st-marys-saints','ron-massey-cup','St Marys Saints','#CE1126','#000000'),
  ('wentworthville-magpies','ron-massey-cup','Wentworthville Magpies','#000000','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ 14. QLD South East Division ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('beenleigh-pride','qld-south-east-division','Beenleigh Pride','#5C2D91','#FFD700'),
  ('brighton-roosters','qld-south-east-division','Brighton Roosters','#FFFFFF','#000000'),
  ('bulimba-bulldogs','qld-south-east-division','Bulimba Bulldogs','#000000','#FFFFFF'),
  ('carina-tigers','qld-south-east-division','Carina Tigers','#FF7F00','#000000'),
  ('fortitude-valley-diehards','qld-south-east-division','Fortitude Valley Diehards','#CE1126','#FFD700'),
  ('normanby-hounds','qld-south-east-division','Normanby Hounds','#003893','#FFFFFF'),
  ('pine-rivers-bears','qld-south-east-division','Pine Rivers Bears','#00843D','#FFD700'),
  ('souths-juniors-magpies','qld-south-east-division','Souths Juniors Magpies','#000000','#FFFFFF'),
  ('wests-panthers','qld-south-east-division','Wests Panthers','#5C2D91','#000000'),
  ('wynnum-manly-juniors-seagulls','qld-south-east-division','Wynnum-Manly Juniors Seagulls','#00AEEF','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ 15. BSDRL (Brisbane Second Division Rugby League) ============
-- Flattened from the 6 parallel Northside/Southside grade divisions in
-- your source into one list of unique clubs (see header note).
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('aspley-devils','bsdrl','Aspley Devils','#000000','#FFD700'),
  ('brisbane-natives-rlfc','bsdrl','Brisbane Natives RLFC','#CE1126','#FFFFFF'),
  ('brisbane-brothers-rl','bsdrl','Brisbane Brothers','#00843D','#FFD700'),
  ('dayboro-cowboys','bsdrl','Dayboro Cowboys','#003893','#FFFFFF'),
  ('gators-rlfc','bsdrl','Gators RLFC','#00AEEF','#000000'),
  ('north-lakes-kangaroos','bsdrl','North Lakes Kangaroos','#5C2D91','#FFD700'),
  ('pine-central-holy-spirit','bsdrl','Pine Central Holy Spirit','#FFD700','#000000'),
  ('wests-arana-hills','bsdrl','Wests Arana Hills','#000000','#FFFFFF'),
  ('wests-mitchelton','bsdrl','Wests Mitchelton','#000000','#00AEEF'),
  ('valleys-bsdrl','bsdrl','Valleys','#CE1126','#FFD700'),
  ('banyo-devils','bsdrl','Banyo Devils','#000000','#FFD700'),
  ('narangba-rangers','bsdrl','Narangba Rangers','#003893','#FFFFFF'),
  ('burpengary-jets','bsdrl','Burpengary Jets','#00AEEF','#000000'),
  ('samford-stags','bsdrl','Samford Stags','#5C2D91','#FFD700'),
  ('bulimba-valleys','bsdrl','Bulimba Valleys','#000000','#FFFFFF'),
  ('carina-bsdrl','bsdrl','Carina','#FF7F00','#000000'),
  ('easts-bsdrl','bsdrl','Easts','#FF7F00','#FFFFFF'),
  ('logan-brothers','bsdrl','Logan Brothers','#00843D','#FFD700'),
  ('redlands-parrots','bsdrl','Redlands Parrots','#00AEEF','#FFFFFF'),
  ('souths-sunnybank','bsdrl','Souths Sunnybank','#000000','#FFFFFF'),
  ('waterford-demons','bsdrl','Waterford Demons','#CE1126','#000000'),
  ('browns-plains-bears','bsdrl','Browns Plains Bears','#5C2D91','#FFD700'),
  ('eagleby-giants','bsdrl','Eagleby Giants','#003893','#FFFFFF'),
  ('souths-acacia-ridge','bsdrl','Souths Acacia Ridge','#000000','#FFFFFF'),
  ('wynnum-manly-bsdrl','bsdrl','Wynnum-Manly','#00AEEF','#FFFFFF'),
  ('beaudesert-kingfishers','bsdrl','Beaudesert Kingfishers','#00843D','#FFD700'),
  ('brothers-st-brendans','bsdrl','Brothers St. Brendans RLFC','#00843D','#FFFFFF'),
  ('capalaba-warriors','bsdrl','Capalaba Warriors','#003893','#FFD700'),
  ('logan-wanderers','bsdrl','Logan Wanderers','#5C2D91','#000000'),
  ('mt-gravatt-eagles','bsdrl','Mt. Gravatt Eagles','#CE1126','#FFD700'),
  ('mustangs-rlfc','bsdrl','Mustangs RLFC','#000000','#FFD700'),
  ('north-stradbroke-island-sharks','bsdrl','North Stradbroke Island Sharks','#00AEEF','#000000'),
  ('rochedale-tigers','bsdrl','Rochedale Tigers','#FF7F00','#000000'),
  ('souths-inala-warriors','bsdrl','Souths Inala Warriors','#000000','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ 16. Fiji National Rugby League (Vodafone Cup) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('cunningham-titans','fiji-vodafone-cup','Cunningham Titans','#71C5E8','#FFFFFF'),
  ('davuilevu-knights','fiji-vodafone-cup','Davuilevu Knights','#000000','#FFD700'),
  ('kinoya-sea-eagles','fiji-vodafone-cup','Kinoya Sea Eagles','#00AEEF','#000000'),
  ('kolimakawa-bulldogs','fiji-vodafone-cup','Kolimakawa Bulldogs','#5C2D91','#FFD700'),
  ('makoi-bulldogs','fiji-vodafone-cup','Makoi Bulldogs','#000000','#FFFFFF'),
  ('mataivalu','fiji-vodafone-cup','Mataivalu','#71C5E8','#000000'),
  ('nadera-panthers','fiji-vodafone-cup','Nadera Panthers','#000000','#FFD700'),
  ('veiyasana-knights','fiji-vodafone-cup','Veiyasana Knights','#003893','#FFFFFF'),
  ('usp-raiders','fiji-vodafone-cup','USP Raiders','#71C5E8','#FFFFFF'),
  ('fiji-navy-albatross','fiji-vodafone-cup','Fiji Navy Albatross','#71C5E8','#000000'),
  ('lami-steelers','fiji-vodafone-cup','Lami Steelers','#000000','#FFD700'),
  ('lovoni-titans','fiji-vodafone-cup','Lovoni Titans','#00AEEF','#FFFFFF'),
  ('nabua-broncos','fiji-vodafone-cup','Nabua Broncos','#8C1D2D','#000000'),
  ('police-sharks','fiji-vodafone-cup','Police Sharks','#003893','#FFFFFF'),
  ('serua-dragons','fiji-vodafone-cup','Serua Dragons','#CE1126','#FFD700'),
  ('suva-city-storm','fiji-vodafone-cup','Suva City Storm','#71C5E8','#FFFFFF'),
  ('topline-warriors','fiji-vodafone-cup','Topline Warriors','#000000','#FFD700'),
  ('vusu-raiders','fiji-vodafone-cup','Vusu Raiders','#003893','#FFFFFF'),
  ('kainiyahawa-tigers','fiji-vodafone-cup','Kainiyahawa Tigers','#FF7F00','#000000'),
  ('laselese-cowboys','fiji-vodafone-cup','Laselese Cowboys','#71C5E8','#FFD700'),
  ('nadi-eels','fiji-vodafone-cup','Nadi Eels','#00843D','#FFFFFF'),
  ('navatulevu-warriors','fiji-vodafone-cup','Navatulevu Warriors','#000000','#FFD700'),
  ('ravoravo-rabbitohs','fiji-vodafone-cup','Ravoravo Rabbitohs','#00843D','#FFD700'),
  ('sabeto-roosters','fiji-vodafone-cup','Sabeto Roosters','#FFFFFF','#000000'),
  ('west-coast-storms','fiji-vodafone-cup','West Coast Storms','#71C5E8','#000000'),
  ('ba-eagles','fiji-vodafone-cup','BA Eagles','#CE1126','#FFFFFF'),
  ('burenitu-cowboys','fiji-vodafone-cup','Burenitu Cowboys','#71C5E8','#FFD700'),
  ('police-sharks-white','fiji-vodafone-cup','Police Sharks White','#003893','#FFFFFF'),
  ('namuaniwaqa-sea-eagles','fiji-vodafone-cup','Namuaniwaqa Sea Eagles','#00AEEF','#000000'),
  ('namoli-west-tigers','fiji-vodafone-cup','Namoli West Tigers','#FF7F00','#000000'),
  ('saru-dragons','fiji-vodafone-cup','Saru Dragons','#CE1126','#FFD700'),
  ('yasawa-saints','fiji-vodafone-cup','Yasawa Saints','#003893','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ 17. NZRL Men's National Competition ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('akarana-falcons','nzrl-national-competition','Akarana Falcons','#000000','#FFD700'),
  ('canterbury-bulls','nzrl-national-competition','Canterbury Bulls','#CE1126','#000000'),
  ('counties-manukau-stingrays','nzrl-national-competition','Counties Manukau Stingrays','#00AEEF','#000000'),
  ('waikato-mana','nzrl-national-competition','Waikato Mana','#5C2D91','#FFD700'),
  ('auckland-vulcans','nzrl-national-competition','Auckland Vulcans','#000000','#FFFFFF'),
  ('mid-central-vipers','nzrl-national-competition','Mid-Central Vipers','#00843D','#FFFFFF'),
  ('upper-central-stallions','nzrl-national-competition','Upper Central Stallions','#FFD700','#000000'),
  ('wellington-orcas','nzrl-national-competition','Wellington Orcas','#003893','#FFFFFF'),
  ('aoraki-eels','nzrl-national-competition','Aoraki Eels','#00AEEF','#FFFFFF'),
  ('otago-rugby-league','nzrl-national-competition','Otago Rugby League','#003893','#FFD700'),
  ('southland-rams','nzrl-national-competition','Southland Rams','#5C2D91','#FFFFFF'),
  ('west-coast-chargers','nzrl-national-competition','West Coast Chargers','#CE1126','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ 18. PNG Digicel Cup ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('central-dabaris','png-digicel-cup','Central Dabaris','#CE1126','#000000'),
  ('enga-mioks','png-digicel-cup','Enga Mioks','#000000','#FFD700'),
  ('goroka-lahanis','png-digicel-cup','Goroka Lahanis','#00843D','#FFFFFF'),
  ('gulf-isou','png-digicel-cup','Gulf Isou','#003893','#FFFFFF'),
  ('hela-wigmen','png-digicel-cup','Hela Wigmen','#5C2D91','#FFD700'),
  ('kimbe-cutters','png-digicel-cup','Kimbe Cutters','#00AEEF','#000000'),
  ('lae-snax-tigers','png-digicel-cup','Lae Snax Tigers','#FF7F00','#000000'),
  ('mendi-muruks','png-digicel-cup','Mendi Muruks','#CE1126','#FFD700'),
  ('mt-hagen-eagles','png-digicel-cup','Mt. Hagen Eagles','#000000','#FFFFFF'),
  ('port-moresby-vipers','png-digicel-cup','Port Moresby Vipers','#00843D','#FFD700'),
  ('rabaul-gurias','png-digicel-cup','Rabaul Gurias','#003893','#FFFFFF'),
  ('waghi-tumbe','png-digicel-cup','Waghi Tumbe','#5C2D91','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ 19. Philippine National Rugby League Champions Shield ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('gorillas-rugby','philippines-champions-shield','Gorillas Rugby','#0038A8','#CE1126'),
  ('pacific-kumuls','philippines-champions-shield','Pacific Kumuls','#000000','#FFD700'),
  ('pampanga-panthers','philippines-champions-shield','Pampanga Panthers','#000000','#FFD700'),
  ('manila-storm','philippines-champions-shield','Manila Storm','#0038A8','#FFFFFF'),
  ('braves-rfc','philippines-champions-shield','Braves RFC','#CE1126','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('albay-vulcans','philippines-champions-shield','Albay Vulcans','#CE1126','#000000',false),
  ('batangas-eels','philippines-champions-shield','Batangas Eels','#00AEEF','#FFFFFF',false),
  ('caloocan-bulldogs','philippines-champions-shield','Caloocan Bulldogs','#000000','#FFD700',false),
  ('cavite-tigers','philippines-champions-shield','Cavite Tigers','#FF7F00','#000000',false),
  ('clark-brothers','philippines-champions-shield','Clark Brothers','#0038A8','#FFFFFF',false),
  ('clark-jets','philippines-champions-shield','Clark Jets','#0038A8','#CE1126',false),
  ('central-luzon-crusaders','philippines-champions-shield','Central Luzon Crusaders','#CE1126','#00843D',false),
  ('university-of-batangas-toro','philippines-champions-shield','University of Batangas Toro','#000000','#FFD700',false),
  ('north-luzon-hunters','philippines-champions-shield','North Luzon Hunters','#0038A8','#FFD700',false)
on conflict (competition_slug, slug) do nothing;

-- ============ 20. Nigeria Rugby League ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('jos-miner','nigeria-rugby-league','Jos Miner','#008751','#FFFFFF'),
  ('kano-gazelles','nigeria-rugby-league','Kano Gazelles','#008751','#FFD700'),
  ('kano-lions','nigeria-rugby-league','Kano Lions','#000000','#FFD700'),
  ('kano-redstar','nigeria-rugby-league','Kano Redstar','#CE1126','#FFFFFF'),
  ('zazzau-bulls','nigeria-rugby-league','Zazzau Bulls','#008751','#000000'),
  ('eko-trinity','nigeria-rugby-league','Eko Trinity','#5C2D91','#FFD700'),
  ('lagos-broncos','nigeria-rugby-league','Lagos Broncos','#8C1D2D','#000000'),
  ('lagos-haven','nigeria-rugby-league','Lagos Haven','#008751','#FFFFFF'),
  ('lagos-kings','nigeria-rugby-league','Lagos Kings','#FFD700','#000000'),
  ('lagos-rhinos','nigeria-rugby-league','Lagos Rhinos','#CE1126','#008751')
on conflict (competition_slug, slug) do nothing;

-- ============ 21. Rhino Cup (South Africa) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('brits-bulldogs','rhino-cup','Brits Bulldogs','#000000','#FFD700'),
  ('centurian-lions','rhino-cup','Centurian Lions','#5C2D91','#FFD700'),
  ('grizzlies-rl','rhino-cup','Grizzlies','#8C1D2D','#000000'),
  ('harlequins-rl-sa','rhino-cup','Harlequins','#003893','#CE1126'),
  ('nigel-rabbitohs','rhino-cup','Nigel Rabbitohs','#00843D','#FFD700'),
  ('pretoria-rlc','rhino-cup','Pretoria RLC','#003893','#FFFFFF'),
  ('st-helens-vultures','rhino-cup','St Helens Vultures','#D2202B','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ 22. Women's Super League (England) ============
-- Reuses the same men's-club colours where the club also exists in
-- Super League/Championship (same identical team names as NRL/NRLW
-- already do elsewhere on the site).
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('barrow-raiders','super-league-women','Barrow Raiders','#CE1126','#002664'),
  ('featherstone-rovers','super-league-women','Featherstone Rovers','#003893','#FFD700'),
  ('huddersfield-giants','super-league-women','Huddersfield Giants','#6C1D45','#FFD200'),
  ('leeds-rhinos','super-league-women','Leeds Rhinos','#003087','#FDB913'),
  ('leigh-leopards','super-league-women','Leigh Leopards','#C8102E','#FFD200'),
  ('st-helens','super-league-women','St Helens','#D2202B','#FFFFFF'),
  ('wigan-warriors','super-league-women','Wigan Warriors','#8C1D40','#FFFFFF'),
  ('york-valkyrie','super-league-women','York Valkyrie','#7A1F2B','#FFD200')
on conflict (competition_slug, slug) do nothing;

-- ============ 23. RFL Women's Championship (England) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('bradford-bulls','championship-women','Bradford Bulls','#8A1538','#FFB81C'),
  ('cardiff-demons','championship-women','Cardiff Demons','#CE1126','#000000'),
  ('castleford-tigers','championship-women','Castleford Tigers','#000000','#FDB913'),
  ('hull-fc','championship-women','Hull FC','#000000','#FFFFFF'),
  ('hull-kingston-rovers','championship-women','Hull Kingston Rovers','#D2202B','#FFFFFF'),
  ('london-broncos','championship-women','London Broncos','#CE1126','#FFFFFF'),
  ('manchester-swinton-lionesses','championship-women','Manchester Swinton Lionesses','#003893','#FFFFFF'),
  ('oulton-raidettes','championship-women','Oulton Raidettes','#5C2D91','#FFD700'),
  ('salford','championship-women','Salford','#CE1126','#000000'),
  ('sheffield-eagles','championship-women','Sheffield Eagles','#6A0032','#FFD700'),
  ('warrington-wolves','championship-women','Warrington Wolves','#FFF200','#00205B'),
  ('widnes-vikings','championship-women','Widnes Vikings','#000000','#FFD700'),
  ('aston-warriors','championship-women','Aston Warriors','#000000','#FFD700'),
  ('coventry-bears','championship-women','Coventry Bears','#8C1D2D','#000000'),
  ('leamington-royals','championship-women','Leamington Royals','#5C2D91','#FFD700'),
  ('midlands-hurricanes','championship-women','Midlands Hurricanes','#5C2D91','#000000'),
  ('nottingham-outlaws','championship-women','Nottingham Outlaws','#000000','#FFFFFF'),
  ('telford-raiders','championship-women','Telford Raiders','#CE1126','#000000'),
  ('anglian-vipers','championship-women','Anglian Vipers','#00843D','#FFFFFF'),
  ('army-rl-women','championship-women','Army','#4B5320','#000000'),
  ('bedford-tigers','championship-women','Bedford Tigers','#FF7F00','#000000'),
  ('brentwood-eels','championship-women','Brentwood Eels','#00AEEF','#000000'),
  ('bristol-golden-ferns','championship-women','Bristol Golden Ferns','#FFD700','#000000'),
  ('north-herts-crusaders','championship-women','North Herts Crusaders','#CE1126','#00843D')
on conflict (competition_slug, slug) do nothing;

-- ============ 24. USARL + Utah Rugby League (USA) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('boston-bears','usarl','Boston Bears','#002868','#BF0D3E'),
  ('brooklyn-kings-rlfc','usarl','Brooklyn Kings RLFC','#000000','#FFD700'),
  ('dc-cavalry','usarl','DC Cavalry','#002868','#CE1126'),
  ('delaware-black-foxes','usarl','Delaware Black Foxes','#000000','#FFFFFF'),
  ('new-york-knights','usarl','New York Knights','#002868','#FFFFFF'),
  ('atlanta-copperheads','usarl','Atlanta Copperheads','#B87333','#000000'),
  ('jacksonville-axemen','usarl','Jacksonville Axemen','#000000','#FFD700'),
  ('sarasota-bull-sharks','usarl','Sarasota Bull Sharks','#00AEEF','#000000'),
  ('tampa-mayhem','usarl','Tampa Mayhem','#CE1126','#000000'),
  ('los-angeles-roosters','usarl','Los Angeles Roosters','#FFFFFF','#000000'),
  ('sacramento-immortals','usarl','Sacramento Immortals','#5C2D91','#FFD700'),
  ('san-diego-barracudas','usarl','San Diego Barracudas','#00AEEF','#FFFFFF'),
  ('santa-rosa-dead-pelicans','usarl','Santa Rosa Dead Pelicans','#000000','#FFD700')
on conflict (competition_slug, slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('atlanta-rhinos','usarl','Atlanta Rhinos','#CE1126','#000000',false),
  ('baltimore-blues','usarl','Baltimore Blues','#002868','#FFFFFF',false),
  ('bucks-county-sharks','usarl','Bucks County Sharks','#00AEEF','#000000',false),
  ('central-florida-warriors','usarl','Central Florida Warriors','#CE1126','#FFD700',false),
  ('connecticut-wildcats','usarl','Connecticut Wildcats','#000000','#FFD700',false),
  ('dc-slayers','usarl','D.C. Slayers','#000000','#CE1126',false),
  ('northern-virginia-eagles','usarl','Northern Virginia Eagles','#002868','#FFFFFF',false),
  ('los-angeles-mongrel','usarl','Los Angeles Mongrel','#000000','#FFFFFF',false),
  ('lakeland-renegades','usarl','Lakeland Renegades','#CE1126','#000000',false),
  ('new-haven-warriors','usarl','New Haven Warriors','#002868','#FFD700',false),
  ('new-jersey-turnpike-titans','usarl','New Jersey Turnpike Titans','#000000','#FFFFFF',false),
  ('oneida-fc','usarl','Oneida FC','#5C2D91','#FFD700',false),
  ('philadelphia-fight','usarl','Philadelphia Fight','#000000','#CE1126',false),
  ('rhode-island-rebellion','usarl','Rhode Island Rebellion','#002868','#FFFFFF',false),
  ('south-florida-speed','usarl','South Florida Speed','#00AEEF','#000000',false),
  ('west-la-jackrabbits','usarl','West LA Jackrabbits','#FFFFFF','#000000',false),
  ('white-plains-wombats','usarl','White Plains Wombats','#5C2D91','#FFFFFF',false),
  ('916ers-rugby','usarl','916ers Rugby','#5C2D91','#FFD700',false)
on conflict (competition_slug, slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('glendale-storm','utah-rugby-league','Glendale Storm','#00AEEF','#000000'),
  ('herriman-roosters','utah-rugby-league','Herriman Roosters','#FFFFFF','#000000'),
  ('provo-broncos','utah-rugby-league','Provo Broncos','#8C1D2D','#000000'),
  ('riverton-seagulls','utah-rugby-league','Riverton Seagulls','#00AEEF','#FFFFFF'),
  ('south-jordan-rabbitahz','utah-rugby-league','South Jordan Rabbitahz','#00843D','#FFD700'),
  ('lehi-raiders','utah-rugby-league','Lehi Raiders','#CE1126','#000000')
on conflict (competition_slug, slug) do nothing;
