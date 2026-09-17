-- Big batch of domestic rugby union: NPC already matched exactly (no
-- changes), so it's skipped. Everything else here is genuinely new,
-- except PREM Rugby (the real current name/branding for what's on the
-- site as "Gallagher Premiership") and Newcastle's real 2025 rebrand to
-- Newcastle Red Bulls, added alongside Newcastle Falcons rather than
-- overwriting it, same reasoning as every other renamed club here.
--
-- Colors: well-known clubs reuse real kit colors where I'm confident;
-- most of this batch (French/Italian/Scottish/Japanese/South American/
-- Australian club rugby especially) I don't have solid brand-color
-- knowledge of, so treat those as generic placeholders to fix up later.
-- Safe to re-run.

-- ============ PREM Rugby rename + Newcastle's 2025 rebrand ============
update competitions set name = 'PREM Rugby' where slug = 'premiership-rugby';

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('newcastle-red-bulls','premiership-rugby','Newcastle Red Bulls','#DB0A40','#1B1F3B')
on conflict (competition_slug, slug) do nothing;

-- ============ Currie Cup (South Africa) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('currie-cup','rugby-union','Currie Cup','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('boland-cavaliers','currie-cup','Boland Cavaliers','#002664','#FFD700'),
  ('border-bulldogs','currie-cup','Border Bulldogs','#CE1126','#FFFFFF'),
  ('bulls-xv','currie-cup','Bulls XV','#002664','#FFD700'),
  ('cheetahs','currie-cup','Cheetahs','#F57F17','#000000'),
  ('eastern-province-elephants','currie-cup','Eastern Province Elephants','#000000','#CE1126'),
  ('griffons','currie-cup','Griffons','#FFD700','#002664'),
  ('griquas','currie-cup','Griquas','#CE1126','#FFFFFF'),
  ('leopards','currie-cup','Leopards','#F57F17','#000000'),
  ('lions','currie-cup','Lions','#CE1126','#000000'),
  ('pumas','currie-cup','Pumas','#00843D','#FFD700'),
  ('sharks-xv','currie-cup','Sharks XV','#000000','#00AEEF'),
  ('stormers-xxiii','currie-cup','Stormers XXIII','#002664','#FFFFFF'),
  ('swd-eagles','currie-cup','SWD Eagles','#00843D','#FFFFFF'),
  ('valke','currie-cup','Valke','#CE1126','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ Súper Rugby Américas (SRA) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('super-rugby-americas','rugby-union','Súper Rugby Américas','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('capibaras','super-rugby-americas','Capibaras','#009739','#FEDD00',true),
  ('cobras','super-rugby-americas','Cobras','#000000','#00843D',true),
  ('dogos','super-rugby-americas','Dogos','#75AADB','#FFFFFF',true),
  ('pampas','super-rugby-americas','Pampas','#75AADB','#FFFFFF',true),
  ('penarol','super-rugby-americas','Peñarol','#FFD700','#000000',true),
  ('selknam','super-rugby-americas','Selknam','#D52B1E','#FFFFFF',true),
  ('tarucas','super-rugby-americas','Tarucas','#D52B1E','#FFD700',true),
  ('yacare','super-rugby-americas','Yacaré','#009739','#FFD700',true),
  ('ceibos','super-rugby-americas','Ceibos','#75AADB','#FFFFFF',false),
  ('jaguares-xv','super-rugby-americas','Jaguares XV','#75AADB','#000000',false),
  ('corinthians','super-rugby-americas','Corinthians','#000000','#FFFFFF',false),
  ('cafeteros-pro','super-rugby-americas','Cafeteros Pro','#FCD116','#003893',false),
  ('olimpia-lions','super-rugby-americas','Olímpia Lions','#009739','#FFFFFF',false),
  ('american-raptors','super-rugby-americas','American Raptors','#002868','#BF0D3E',false)
on conflict (competition_slug, slug) do nothing;

-- ============ Major League Rugby (MLR, USA) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('mlr','rugby-union','Major League Rugby','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('california-legion','mlr','California Legion','#002868','#FFD700',true),
  ('chicago-hounds','mlr','Chicago Hounds','#002664','#CE1126',true),
  ('new-england-free-jacks','mlr','New England Free Jacks','#002664','#CE1126',true),
  ('old-glory-dc','mlr','Old Glory DC','#002868','#CE1126',true),
  ('seattle-seawolves','mlr','Seattle Seawolves','#00205B','#8CC63F',true),
  ('colorado-raptors','mlr','Colorado Raptors','#6A0032','#FFD700',false),
  ('la-giltinis','mlr','LA Giltinis','#000000','#FFD700',false),
  ('austin-gilgronis','mlr','Austin Gilgronis','#000000','#CE1126',false),
  ('toronto-arrows','mlr','Toronto Arrows','#CE1126','#000000',false),
  ('rugby-new-york','mlr','Rugby New York','#002868','#CE1126',false),
  ('dallas-jackals','mlr','Dallas Jackals','#000000','#FFD700',false),
  ('new-orleans-gold','mlr','New Orleans Gold','#FFD700','#5C2D91',false),
  ('san-diego-legion','mlr','San Diego Legion','#002868','#FFD700',false),
  ('rfc-los-angeles','mlr','RFC Los Angeles','#000000','#CE1126',false),
  ('miami-sharks','mlr','Miami Sharks','#00AEEF','#000000',false),
  ('houston-sabercats','mlr','Houston SaberCats','#CE1126','#000000',false),
  ('utah-warriors','mlr','Utah Warriors','#CE1126','#000000',false),
  ('anthem-rc','mlr','Anthem RC','#002868','#CE1126',false)
on conflict (competition_slug, slug) do nothing;

-- ============ Women's Elite Rugby (WER, USA) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('wer','rugby-union','Women''s Elite Rugby','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('bay-breakers','wer','Bay Breakers','#00AEEF','#002868'),
  ('boston-banshees','wer','Boston Banshees','#000000','#CE1126'),
  ('chicago-tempest','wer','Chicago Tempest','#00AEEF','#000000'),
  ('denver-onyx','wer','Denver Onyx','#000000','#FFD700'),
  ('new-york-exiles','wer','New York Exiles','#002868','#CE1126'),
  ('twin-cities-gemini','wer','Twin Cities Gemini','#5C2D91','#00AEEF')
on conflict (competition_slug, slug) do nothing;

-- ============ Japan Rugby League One ============
insert into competitions (slug, sport_slug, name, tier) values
  ('japan-rugby-league-one','rugby-union','Japan Rugby League One','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('urayasu-d-rocks','japan-rugby-league-one','Urayasu D-Rocks','#000000','#FFD700'),
  ('kubota-spears','japan-rugby-league-one','Kubota Spears Funabashi Tokyo-Bay','#00843D','#FFFFFF'),
  ('kobelco-kobe-steelers','japan-rugby-league-one','Kobelco Kobe Steelers','#CE1126','#000000'),
  ('saitama-panasonic-wild-knights','japan-rugby-league-one','Saitama Panasonic Wild Knights','#002664','#FFD700'),
  ('shizuoka-bluerevs','japan-rugby-league-one','Shizuoka BlueRevs','#00AEEF','#002664'),
  ('tokyo-suntory-sungoliath','japan-rugby-league-one','Tokyo Suntory Sungoliath','#CE1126','#FFD700'),
  ('toshiba-brave-lupus-tokyo','japan-rugby-league-one','Toshiba Brave Lupus Tokyo','#5C2D91','#FFFFFF'),
  ('tochigi-honda-heat','japan-rugby-league-one','Tochigi Honda Heat','#CE1126','#000000'),
  ('toyota-verblitz','japan-rugby-league-one','Toyota Verblitz','#CE1126','#000000'),
  ('mitsubishi-dynaboars','japan-rugby-league-one','Mitsubishi Heavy Industries Sagamihara Dynaboars','#002664','#FFD700'),
  ('yokohama-canon-eagles','japan-rugby-league-one','Yokohama Canon Eagles','#00843D','#FFFFFF'),
  ('ricoh-blackrams-tokyo','japan-rugby-league-one','Ricoh BlackRams Tokyo','#000000','#CE1126'),
  ('kyuden-voltex','japan-rugby-league-one','Kyushu Electric Power Kyuden Voltex','#F57F17','#000000'),
  ('sayama-secom-rugguts','japan-rugby-league-one','Sayama Secom Rugguts','#002664','#FFFFFF'),
  ('koto-blue-sharks','japan-rugby-league-one','Shimizu Corporation Koto Blue Sharks','#00AEEF','#000000'),
  ('jr-east-green-warriors-tokatsu','japan-rugby-league-one','JR East Green Warriors Tokatsu','#00693E','#FFFFFF'),
  ('toyota-industries-shuttles-aichi','japan-rugby-league-one','Toyota Industries Corporation Shuttles Aichi','#CE1126','#FFFFFF'),
  ('hanazono-kintetsu-liners','japan-rugby-league-one','Hanazono Kintetsu Liners','#002664','#FFD700'),
  ('mazda-skyactivs-hiroshima','japan-rugby-league-one','Mazda SkyActivs Hiroshima','#CE1126','#000000'),
  ('redhurricanes-osaka','japan-rugby-league-one','RedHurricanes Osaka','#CE1126','#000000'),
  ('az-com-maruwa-momotaros','japan-rugby-league-one','AZ-COM Maruwa Momotaro''s','#FFD700','#CE1126'),
  ('kurita-water-gush-akishima','japan-rugby-league-one','Kurita Water Gush Akishima','#00AEEF','#FFFFFF'),
  ('chugoku-red-regulions','japan-rugby-league-one','Chugoku Electric Power Red Regulions','#CE1126','#000000'),
  ('nippon-steel-kamaishi-seawaves','japan-rugby-league-one','Nippon Steel Kamaishi Seawaves','#002664','#00AEEF'),
  ('hino-red-dolphins','japan-rugby-league-one','Hino Red Dolphins','#CE1126','#FFFFFF'),
  ('yakult-levins-toda','japan-rugby-league-one','Yakult Levins Toda','#002664','#FFD700'),
  ('leriro-fukuoka','japan-rugby-league-one','LeRIRO Fukuoka','#5C2D91','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Premiership Women's Rugby (PWR, England) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('pwr','rugby-union','Premiership Women''s Rugby','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('bristol-bears-women','pwr','Bristol Bears Women','#002664','#00AEEF'),
  ('exeter-chiefs-women','pwr','Exeter Chiefs Women','#000000','#FFFFFF'),
  ('gloucester-hartpury','pwr','Gloucester-Hartpury','#CE1126','#FFFFFF'),
  ('hartpury','pwr','Hartpury','#00693E','#FFFFFF'),
  ('harlequins-women','pwr','Harlequins Women','#000000','#EC008C'),
  ('leicester-tigers-women','pwr','Leicester Tigers Women','#00693E','#CE1126'),
  ('loughborough-lightning','pwr','Loughborough Lightning','#5C2D91','#FFD700'),
  ('sale-sharks-women','pwr','Sale Sharks Women','#002664','#0033A0'),
  ('saracens-women','pwr','Saracens Women','#000000','#CE1126'),
  ('trailfinders-women','pwr','Trailfinders Women','#003893','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ Top 14 (France) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('top-14','rugby-union','Top 14','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('bayonne','top-14','Bayonne','#CE1126','#FFFFFF'),
  ('bordeaux-begles','top-14','Bordeaux Bègles','#002664','#FFFFFF'),
  ('castres','top-14','Castres','#002664','#FFFFFF'),
  ('clermont','top-14','Clermont','#FFD700','#002664'),
  ('la-rochelle','top-14','La Rochelle','#FFD700','#000000'),
  ('lyon','top-14','Lyon','#CE1126','#000000'),
  ('montauban','top-14','Montauban','#CE1126','#000000'),
  ('montpellier','top-14','Montpellier','#F57F17','#002664'),
  ('pau','top-14','Pau','#002664','#00AEEF'),
  ('perpignan','top-14','Perpignan','#CE1126','#FFD700'),
  ('racing','top-14','Racing','#87CEEB','#FFFFFF'),
  ('stade-francais','top-14','Stade Français','#EC008C','#000000'),
  ('toulon','top-14','Toulon','#CE1126','#000000'),
  ('toulouse','top-14','Toulouse','#CE1126','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ Pro D2 (France) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('pro-d2','rugby-union','Pro D2','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('agen','pro-d2','Agen','#002664','#FFD700'),
  ('aurillac','pro-d2','Aurillac','#CE1126','#000000'),
  ('beziers','pro-d2','Béziers','#5C2D91','#FFD700'),
  ('biarritz','pro-d2','Biarritz','#CE1126','#FFFFFF'),
  ('brive','pro-d2','Brive','#000000','#CE1126'),
  ('carcassonne','pro-d2','Carcassonne','#5C2D91','#FFD700'),
  ('colomiers','pro-d2','Colomiers','#00843D','#FFFFFF'),
  ('dax','pro-d2','Dax','#002664','#FFD700'),
  ('grenoble','pro-d2','Grenoble','#CE1126','#000000'),
  ('mont-de-marsan','pro-d2','Mont-de-Marsan','#002664','#FFD700'),
  ('nevers','pro-d2','Nevers','#5C2D91','#FFFFFF'),
  ('oyonnax','pro-d2','Oyonnax','#CE1126','#000000'),
  ('provence','pro-d2','Provence','#002664','#FFFFFF'),
  ('soyaux-angouleme','pro-d2','Soyaux Angoulême','#002664','#FFD700'),
  ('valence-romans','pro-d2','Valence Romans','#CE1126','#FFFFFF'),
  ('vannes','pro-d2','Vannes','#000000','#CE1126')
on conflict (competition_slug, slug) do nothing;

-- ============ Élite 1 Féminine (France women's) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('elite-1-feminine','rugby-union','Élite 1 Féminine','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('blagnac-scr','elite-1-feminine','Blagnac SCR','#002664','#FFFFFF'),
  ('ac-bobigny-93','elite-1-feminine','AC Bobigny 93','#CE1126','#000000'),
  ('stade-bordelais','elite-1-feminine','Stade Bordelais','#002664','#FFFFFF'),
  ('fc-grenoble-amazones','elite-1-feminine','FC Grenoble Amazones','#CE1126','#000000'),
  ('lyon-our','elite-1-feminine','Lyon OUR','#CE1126','#000000'),
  ('asm-romagnat','elite-1-feminine','ASM Romagnat','#FFD700','#002664'),
  ('montpellier-hr','elite-1-feminine','Montpellier HR','#F57F17','#002664'),
  ('rc-toulon-pm','elite-1-feminine','RC Toulon PM','#CE1126','#000000'),
  ('stade-toulousain','elite-1-feminine','Stade Toulousain','#CE1126','#000000'),
  ('stade-villeneuvois-lm','elite-1-feminine','Stade Villeneuvois LM','#002664','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ Serie A Elite (Italy) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('serie-a-elite','rugby-union','Serie A Elite','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('calvisano','serie-a-elite','Calvisano','#002664','#FFD700'),
  ('colorno','serie-a-elite','Colorno','#CE1126','#000000'),
  ('fiamme-oro','serie-a-elite','Fiamme Oro','#CE1126','#FFD700'),
  ('lazio','serie-a-elite','S.S. Lazio','#87CEEB','#FFFFFF'),
  ('lyons-piacenza','serie-a-elite','Lyons Piacenza','#5C2D91','#FFD700'),
  ('mogliano','serie-a-elite','Mogliano','#002664','#FFFFFF'),
  ('petrarca','serie-a-elite','Petrarca','#5C2D91','#FFFFFF'),
  ('rovigo-delta','serie-a-elite','Rovigo Delta','#CE1126','#FFD700'),
  ('valorugby-emilia','serie-a-elite','Valorugby Emilia','#002664','#FFD700'),
  ('viadana','serie-a-elite','Viadana','#000000','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ Scottish Premiership ============
insert into competitions (slug, sport_slug, name, tier) values
  ('scottish-premiership-rugby','rugby-union','Scottish Premiership','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('ayr','scottish-premiership-rugby','Ayr','#000000','#FFD700'),
  ('currie-chieftains','scottish-premiership-rugby','Currie Chieftains','#00205B','#FFFFFF'),
  ('edinburgh-academical','scottish-premiership-rugby','Edinburgh Academical','#00205B','#FFD700'),
  ('glasgow-hawks','scottish-premiership-rugby','Glasgow Hawks','#000000','#FFD700'),
  ('gha','scottish-premiership-rugby','GHA','#5C2D91','#FFFFFF'),
  ('hawick','scottish-premiership-rugby','Hawick','#006A4E','#FFD700'),
  ('heriots','scottish-premiership-rugby','Heriot''s','#000000','#FFD700'),
  ('kelso','scottish-premiership-rugby','Kelso','#CE1126','#000000'),
  ('melrose','scottish-premiership-rugby','Melrose','#00205B','#FFD700'),
  ('watsonian','scottish-premiership-rugby','Watsonian','#5C2D91','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ Shute Shield (Sydney) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('shute-shield','rugby-union','Shute Shield','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('eastern-suburbs','shute-shield','Eastern Suburbs','#5C2D91','#FFD700',true),
  ('eastwood','shute-shield','Eastwood','#5C2D91','#FFFFFF',true),
  ('gordon','shute-shield','Gordon','#CE1126','#000000',true),
  ('hunter','shute-shield','Hunter','#000000','#FFD700',true),
  ('manly','shute-shield','Manly','#00843D','#FFD700',true),
  ('northern-suburbs','shute-shield','Northern Suburbs','#5C2D91','#00AEEF',true),
  ('randwick','shute-shield','Randwick','#5C2D91','#000000',true),
  ('southern-districts','shute-shield','Southern Districts','#00843D','#FFFFFF',true),
  ('sydney-university','shute-shield','Sydney University','#002664','#FFD700',true),
  ('warringah','shute-shield','Warringah','#5C2D91','#FFFFFF',true),
  ('west-harbour','shute-shield','West Harbour','#000000','#FFD700',true),
  ('western-sydney','shute-shield','Western Sydney','#CE1126','#000000',true),
  ('balmain','shute-shield','Balmain','#CE1126','#000000',false),
  ('balmain-district','shute-shield','Balmain District','#CE1126','#FFFFFF',false),
  ('burwood','shute-shield','Burwood','#002664','#FFD700',false),
  ('cambridge','shute-shield','Cambridge','#00205B','#87CEEB',false),
  ('canberra','shute-shield','Canberra','#002664','#FFD700',false),
  ('drummoyne','shute-shield','Drummoyne','#5C2D91','#FFFFFF',false),
  ('glebe','shute-shield','Glebe','#000000','#FFD700',false),
  ('gps-old-boys','shute-shield','GPS Old Boys','#002664','#FFFFFF',false),
  ('hornsby','shute-shield','Hornsby','#00843D','#FFD700',false),
  ('illawarriors','shute-shield','Illawarriors','#5C2D91','#000000',false),
  ('macquarie-university','shute-shield','Macquarie University','#5C2D91','#FFD700',false),
  ('mosman','shute-shield','Mosman','#000000','#87CEEB',false),
  ('newtown','shute-shield','Newtown','#5C2D91','#FFFFFF',false),
  ('penrith','shute-shield','Penrith','#CE1126','#000000',false),
  ('petersham','shute-shield','Petersham','#5C2D91','#FFFFFF',false),
  ('the-pirates','shute-shield','The Pirates','#000000','#CE1126',false),
  ('police','shute-shield','Police','#00205B','#FFFFFF',false),
  ('port-hacking','shute-shield','Port Hacking','#00AEEF','#000000',false),
  ('redfern','shute-shield','Redfern','#CE1126','#000000',false),
  ('south-sydney','shute-shield','South Sydney','#CE1126','#00843D',false),
  ('st-george','shute-shield','St George','#CE1126','#FFFFFF',false),
  ('sydney-district','shute-shield','Sydney District','#002664','#FFD700',false),
  ('university-of-new-south-wales','shute-shield','University of New South Wales','#5C2D91','#FFD700',false),
  ('wallaroo','shute-shield','Wallaroo','#00843D','#FFFFFF',false),
  ('waratah','shute-shield','Waratah','#00AEEF','#002664',false),
  ('ymca','shute-shield','YMCA','#CE1126','#000000',false)
on conflict (competition_slug, slug) do nothing;

-- ============ Queensland Premier Rugby (Hospital Cup) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('queensland-premier-rugby','rugby-union','Queensland Premier Rugby','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('brothers-brisbane','queensland-premier-rugby','Brothers Brisbane','#5C2D91','#FFFFFF',true),
  ('university-of-queensland','queensland-premier-rugby','University of Queensland','#002664','#FFD700',true),
  ('gps-brisbane','queensland-premier-rugby','GPS (Great Public Schools)','#000000','#FFD700',true),
  ('south-brisbane','queensland-premier-rugby','South Brisbane','#CE1126','#000000',true),
  ('east-brisbane','queensland-premier-rugby','East Brisbane','#00843D','#FFFFFF',true),
  ('west-brisbane','queensland-premier-rugby','West Brisbane','#5C2D91','#FFD700',true),
  ('sunnybank','queensland-premier-rugby','Sunnybank','#000000','#CE1126',true),
  ('north-brisbane','queensland-premier-rugby','North Brisbane','#00AEEF','#000000',true),
  ('bond-university','queensland-premier-rugby','Bond University','#5C2D91','#FFD700',true),
  ('gold-coast','queensland-premier-rugby','Gold Coast','#00AEEF','#FFD700',false),
  ('sunshine-coast','queensland-premier-rugby','Sunshine Coast','#F57F17','#00843D',false),
  ('canberra-qpr','queensland-premier-rugby','Canberra','#002664','#FFD700',false)
on conflict (competition_slug, slug) do nothing;

-- ============ Super Rugby Aupiki (NZ women's) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('super-rugby-aupiki','rugby-union','Super Rugby Aupiki','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('blues-women','super-rugby-aupiki','Blues Women','#002664','#FFFFFF'),
  ('chiefs-manawa','super-rugby-aupiki','Chiefs Manawa','#CE1126','#000000'),
  ('hurricanes-poua','super-rugby-aupiki','Hurricanes Poua','#FFD700','#000000'),
  ('matatu','super-rugby-aupiki','Matatū','#00843D','#FFD700')
on conflict (competition_slug, slug) do nothing;
