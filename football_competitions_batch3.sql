-- ============================================================
-- 10 more football competitions: Belgian Pro League, Danish Superliga,
-- Super League Greece, League of Ireland First Division, Scottish
-- Premiership, Swiss Super League, Chinese Super League, J1 League,
-- J2 League, Indian Super League. All new, tier 'more'. Safe to re-run.
--
-- Slug note: football's Scottish Premiership is 'scottish-premiership'
-- — rugby union's competition of the same name is already
-- 'scottish-premiership-rugby', so no clash.
--
-- Judgment calls:
-- - Scottish Premiership: "Horizon Reinforcing & Crane Hire (Away)" in
--   your list isn't a real club — it reads like a shirt-sponsor/kit
--   name that got picked up by mistake (none of the 12 real Scottish
--   Premiership sides are called that) — left out. Flag me if there's
--   actually a 12th club I'm missing here.
-- - Chinese Super League: "Liaoning Tieren P" and "Chongqing
--   Tonglianglong P" — dropped the trailing "P" as a footnote marker,
--   not part of the club name.
-- - J2 League: promotion/relegation arrows (Albirex Niigata↓, Shonan
--   Bellmare↓, Tegevajaro Miyazaki↑, Tochigi City↑, Vanraure
--   Hachinohe↑, Yokohama FC↓) stripped from the names.
-- - Indian Super League: footnote markers on "Inter Kashi[a]" and
--   "Punjab[b]" stripped.
-- - Colours: used well-known real club colours where I'm confident
--   (Celtic, Rangers, Aberdeen, Hearts, Hibernian in Scotland; Club
--   Brugge, Anderlecht, Standard Liège in Belgium; Basel, Young Boys in
--   Switzerland; the biggest Greek/Danish/Japanese/Indian clubs).
--   Chinese Super League and most of the League of Ireland First
--   Division are genuinely low-confidence generic placeholders — I
--   don't have reliable brand-colour knowledge for most of these clubs.
-- ============================================================

insert into competitions (slug, sport_slug, name, tier) values
  ('belgian-pro-league','football','Belgian Pro League','more'),
  ('danish-superliga','football','Danish Superliga','more'),
  ('super-league-greece','football','Super League Greece','more'),
  ('league-of-ireland-first-division','football','League of Ireland First Division','more'),
  ('scottish-premiership','football','Scottish Premiership','more'),
  ('swiss-super-league','football','Swiss Super League','more'),
  ('chinese-super-league','football','Chinese Super League','more'),
  ('j1-league','football','J1 League','more'),
  ('j2-league','football','J2 League','more'),
  ('indian-super-league','football','Indian Super League','more')
on conflict (slug) do nothing;

-- ============ Belgian Pro League ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('anderlecht','belgian-pro-league','Anderlecht','#582C83','#FFFFFF'),
  ('antwerp','belgian-pro-league','Antwerp','#ED1C24','#FFFFFF'),
  ('beveren','belgian-pro-league','Beveren','#FFD700','#003DA5'),
  ('cercle-brugge','belgian-pro-league','Cercle Brugge','#00843D','#000000'),
  ('charleroi','belgian-pro-league','Charleroi','#5C2D91','#000000'),
  ('club-brugge','belgian-pro-league','Club Brugge','#005CA9','#000000'),
  ('genk','belgian-pro-league','Genk','#0033A0','#FFFFFF'),
  ('gent','belgian-pro-league','Gent','#003DA5','#FFFFFF'),
  ('kortrijk','belgian-pro-league','Kortrijk','#CE1126','#FFFFFF'),
  ('la-louviere','belgian-pro-league','La Louvière','#CE1126','#000000'),
  ('lommel-sk','belgian-pro-league','Lommel SK','#00843D','#FFFFFF'),
  ('mechelen','belgian-pro-league','Mechelen','#FFD700','#CE1126'),
  ('oh-leuven','belgian-pro-league','OH Leuven','#FFD700','#003DA5'),
  ('sint-truiden','belgian-pro-league','Sint-Truiden','#CE1126','#FFFFFF'),
  ('standard-liege','belgian-pro-league','Standard Liège','#E2001A','#FFFFFF'),
  ('union-sg','belgian-pro-league','Union SG','#FFD700','#003DA5'),
  ('westerlo','belgian-pro-league','Westerlo','#FFD700','#000000'),
  ('zulte-waregem','belgian-pro-league','Zulte Waregem','#FFD700','#003DA5')
on conflict (competition_slug, slug) do nothing;

-- ============ Danish Superliga ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('agf','danish-superliga','AGF','#FFFFFF','#000000'),
  ('brondby','danish-superliga','Brøndby','#FFD700','#003DA5'),
  ('copenhagen','danish-superliga','Copenhagen','#FFFFFF','#003DA5'),
  ('horsens','danish-superliga','Horsens','#FFD700','#000000'),
  ('lyngby','danish-superliga','Lyngby','#003DA5','#FFFFFF'),
  ('midtjylland','danish-superliga','Midtjylland','#CE1126','#FFFFFF'),
  ('nordsjaelland','danish-superliga','Nordsjælland','#CE1126','#FFFFFF'),
  ('ob','danish-superliga','OB','#FFFFFF','#000000'),
  ('randers','danish-superliga','Randers','#000000','#CE1126'),
  ('silkeborg','danish-superliga','Silkeborg','#CE1126','#FFFFFF'),
  ('sonderjyske','danish-superliga','Sønderjyske','#CE1126','#FFFFFF'),
  ('viborg','danish-superliga','Viborg','#000000','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Super League Greece ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('aek-athens','super-league-greece','AEK Athens','#FFD700','#000000'),
  ('ae-kifisia','super-league-greece','A.E. Kifisia','#00843D','#FFFFFF'),
  ('aris','super-league-greece','Aris','#FFD700','#000000'),
  ('asteras-tripolis','super-league-greece','Asteras Tripolis','#7A263A','#000000'),
  ('atromitos','super-league-greece','Atromitos','#00843D','#FFFFFF'),
  ('iraklis','super-league-greece','Iraklis','#003DA5','#000000'),
  ('kalamata','super-league-greece','Kalamata','#003DA5','#FFFFFF'),
  ('levadiakos','super-league-greece','Levadiakos','#CE1126','#FFFFFF'),
  ('ofi','super-league-greece','OFI','#87CEEB','#FFFFFF'),
  ('olympiacos','super-league-greece','Olympiacos','#CE1126','#FFFFFF'),
  ('panathinaikos','super-league-greece','Panathinaikos','#00843D','#FFFFFF'),
  ('panetolikos','super-league-greece','Panetolikos','#CE1126','#000000'),
  ('paok','super-league-greece','PAOK','#000000','#FFFFFF'),
  ('volos','super-league-greece','Volos','#003DA5','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ League of Ireland First Division ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('athlone-town','league-of-ireland-first-division','Athlone Town','#FFD700','#000000'),
  ('bray-wanderers','league-of-ireland-first-division','Bray Wanderers','#7A263A','#FFFFFF'),
  ('cobh-ramblers','league-of-ireland-first-division','Cobh Ramblers','#00843D','#FFFFFF'),
  ('cork-city','league-of-ireland-first-division','Cork City','#CE1126','#FFFFFF'),
  ('finn-harps','league-of-ireland-first-division','Finn Harps','#5C2D91','#FFFFFF'),
  ('kerry-fc','league-of-ireland-first-division','Kerry','#00843D','#FFD700'),
  ('longford-town','league-of-ireland-first-division','Longford Town','#003DA5','#FFFFFF'),
  ('treaty-united','league-of-ireland-first-division','Treaty United','#003DA5','#FFFFFF'),
  ('ucd','league-of-ireland-first-division','UCD','#003DA5','#FFD700'),
  ('wexford-fc','league-of-ireland-first-division','Wexford','#7A263A','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Scottish Premiership (football) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('aberdeen','scottish-premiership','Aberdeen','#CE1126','#000000'),
  ('celtic','scottish-premiership','Celtic','#00843D','#FFFFFF'),
  ('dundee-fc','scottish-premiership','Dundee','#00205B','#FFFFFF'),
  ('dundee-united','scottish-premiership','Dundee United','#FF6600','#000000'),
  ('falkirk','scottish-premiership','Falkirk','#00205B','#FFFFFF'),
  ('heart-of-midlothian','scottish-premiership','Heart of Midlothian','#7A263A','#FFFFFF'),
  ('hibernian','scottish-premiership','Hibernian','#00843D','#FFFFFF'),
  ('kilmarnock','scottish-premiership','Kilmarnock','#003DA5','#FFFFFF'),
  ('motherwell','scottish-premiership','Motherwell','#FFC72C','#7A263A'),
  ('rangers','scottish-premiership','Rangers','#003DA5','#FFFFFF'),
  ('st-johnstone','scottish-premiership','St Johnstone','#003DA5','#FFFFFF'),
  ('st-mirren','scottish-premiership','St Mirren','#000000','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Swiss Super League ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('lugano','swiss-super-league','Lugano','#000000','#FFFFFF'),
  ('sion','swiss-super-league','Sion','#CE1126','#FFFFFF'),
  ('young-boys','swiss-super-league','Young Boys','#FFD700','#000000'),
  ('basel','swiss-super-league','Basel','#003DA5','#CE1126'),
  ('st-gallen','swiss-super-league','St. Gallen','#00843D','#FFFFFF'),
  ('zurich','swiss-super-league','Zürich','#87CEEB','#FFFFFF'),
  ('luzern','swiss-super-league','Luzern','#003DA5','#FFFFFF'),
  ('grasshopper','swiss-super-league','Grasshopper','#003DA5','#FFFFFF'),
  ('servette','swiss-super-league','Servette','#7A263A','#FFFFFF'),
  ('thun','swiss-super-league','Thun','#CE1126','#000000'),
  ('vaduz','swiss-super-league','Vaduz','#003DA5','#000000'),
  ('lausanne-sport','swiss-super-league','Lausanne-Sport','#003DA5','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Chinese Super League ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('shanghai-port','chinese-super-league','Shanghai Port','#CE1126','#003DA5'),
  ('shanghai-shenhua','chinese-super-league','Shanghai Shenhua','#003DA5','#FFFFFF'),
  ('chengdu-rongcheng','chinese-super-league','Chengdu Rongcheng','#CE1126','#000000'),
  ('beijing-guoan','chinese-super-league','Beijing Guoan','#00843D','#FFFFFF'),
  ('shandong-taishan','chinese-super-league','Shandong Taishan','#CE1126','#FFFFFF'),
  ('tianjin-jinmen-tiger','chinese-super-league','Tianjin Jinmen Tiger','#FF6600','#000000'),
  ('tianjin-olympic-centre','chinese-super-league','Tianjin Olympic Centre','#003DA5','#FFFFFF'),
  ('zhejiang-fc','chinese-super-league','Zhejiang','#CE1126','#FFD700'),
  ('yunnan-yukun','chinese-super-league','Yunnan Yukun','#00843D','#FFFFFF'),
  ('qingdao-west-coast','chinese-super-league','Qingdao West Coast','#003DA5','#FFFFFF'),
  ('henan-fc','chinese-super-league','Henan','#CE1126','#FFD700'),
  ('dalian-yingbo','chinese-super-league','Dalian Yingbo','#003DA5','#FFFFFF'),
  ('shenzhen-peng-city','chinese-super-league','Shenzhen Peng City','#CE1126','#000000'),
  ('wuhan-three-towns','chinese-super-league','Wuhan Three Towns','#FFD700','#003DA5'),
  ('qingdao-hainiu','chinese-super-league','Qingdao Hainiu','#003DA5','#FFFFFF'),
  ('liaoning-tieren','chinese-super-league','Liaoning Tieren','#000000','#FFD700'),
  ('chongqing-tonglianglong','chinese-super-league','Chongqing Tonglianglong','#CE1126','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ J1 League ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('kashima-antlers','j1-league','Kashima Antlers','#CE1126','#000000'),
  ('mito-hollyhock','j1-league','Mito HollyHock','#00AEEF','#00205B'),
  ('urawa-red-diamonds','j1-league','Urawa Red Diamonds','#CE1126','#000000'),
  ('jef-united-chiba','j1-league','JEF United Chiba','#FFD700','#003DA5'),
  ('kashiwa-reysol','j1-league','Kashiwa Reysol','#FFD700','#000000'),
  ('fc-tokyo','j1-league','FC Tokyo','#005BAC','#CE1126'),
  ('tokyo-verdy','j1-league','Tokyo Verdy','#00843D','#FFFFFF'),
  ('machida-zelvia','j1-league','Machida Zelvia','#003DA5','#FFD700'),
  ('kawasaki-frontale','j1-league','Kawasaki Frontale','#00AEEF','#000000'),
  ('yokohama-f-marinos','j1-league','Yokohama F. Marinos','#003DA5','#FFFFFF'),
  ('shimizu-s-pulse','j1-league','Shimizu S-Pulse','#FF6600','#003DA5'),
  ('nagoya-grampus','j1-league','Nagoya Grampus','#CE1126','#FF6600'),
  ('kyoto-sanga','j1-league','Kyoto Sanga','#5C2D91','#FFFFFF'),
  ('gamba-osaka','j1-league','Gamba Osaka','#003DA5','#000000'),
  ('cerezo-osaka','j1-league','Cerezo Osaka','#FF69B4','#000000'),
  ('vissel-kobe','j1-league','Vissel Kobe','#CE1126','#FFFFFF'),
  ('fagiano-okayama','j1-league','Fagiano Okayama','#5C2D91','#FFFFFF'),
  ('sanfrecce-hiroshima','j1-league','Sanfrecce Hiroshima','#5C2D91','#FFFFFF'),
  ('avispa-fukuoka','j1-league','Avispa Fukuoka','#003DA5','#FFD700'),
  ('v-varen-nagasaki','j1-league','V-Varen Nagasaki','#003DA5','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ J2 League ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('albirex-niigata','j2-league','Albirex Niigata','#FF6600','#000000'),
  ('blaublitz-akita','j2-league','Blaublitz Akita','#003DA5','#FFFFFF'),
  ('fc-imabari','j2-league','FC Imabari','#003DA5','#FFD700'),
  ('fujieda-myfc','j2-league','Fujieda MYFC','#FFD700','#000000'),
  ('hokkaido-consadole-sapporo','j2-league','Hokkaido Consadole Sapporo','#CE1126','#000000'),
  ('iwaki-fc','j2-league','Iwaki FC','#00843D','#FFFFFF'),
  ('jubilo-iwata','j2-league','Júbilo Iwata','#00AEEF','#000000'),
  ('kataller-toyama','j2-league','Kataller Toyama','#003DA5','#FFFFFF'),
  ('montedio-yamagata','j2-league','Montedio Yamagata','#003DA5','#FFD700'),
  ('oita-trinita','j2-league','Oita Trinita','#003DA5','#FFD700'),
  ('rb-omiya-ardija','j2-league','RB Omiya Ardija','#FF6600','#00205B'),
  ('sagan-tosu','j2-league','Sagan Tosu','#003DA5','#FFFFFF'),
  ('shonan-bellmare','j2-league','Shonan Bellmare','#003DA5','#FFD700'),
  ('tegevajaro-miyazaki','j2-league','Tegevajaro Miyazaki','#00843D','#FFFFFF'),
  ('tochigi-city','j2-league','Tochigi City','#FFD700','#003DA5'),
  ('tokushima-vortis','j2-league','Tokushima Vortis','#003DA5','#FFFFFF'),
  ('vanraure-hachinohe','j2-league','Vanraure Hachinohe','#5C2D91','#FFFFFF'),
  ('vegalta-sendai','j2-league','Vegalta Sendai','#FFD700','#00205B'),
  ('ventforet-kofu','j2-league','Ventforet Kofu','#7A263A','#000000'),
  ('yokohama-fc','j2-league','Yokohama FC','#003DA5','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Indian Super League ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('bengaluru-fc','indian-super-league','Bengaluru','#003DA5','#FFD700'),
  ('chennaiyin-fc','indian-super-league','Chennaiyin','#00AEEF','#FFD700'),
  ('churchill-brothers','indian-super-league','Churchill Brothers','#CE1126','#000000'),
  ('delhi-fc','indian-super-league','Delhi','#003DA5','#FFFFFF'),
  ('east-bengal','indian-super-league','East Bengal','#CE1126','#FFD700'),
  ('goa-fc','indian-super-league','Goa','#FF6600','#FFFFFF'),
  ('inter-kashi','indian-super-league','Inter Kashi','#003DA5','#FFFFFF'),
  ('kerala-blasters','indian-super-league','Kerala Blasters','#FFD700','#003DA5'),
  ('mohun-bagan-sg','indian-super-league','Mohun Bagan SG','#00843D','#7A263A'),
  ('mumbai-city','indian-super-league','Mumbai City','#00AEEF','#0A2240'),
  ('northeast-united','indian-super-league','NorthEast United','#FF6600','#003DA5'),
  ('odisha-fc','indian-super-league','Odisha','#CE1126','#FFD700'),
  ('punjab-fc','indian-super-league','Punjab','#003DA5','#FFFFFF'),
  ('diamond-harbour-fc','indian-super-league','Diamond Harbour','#00843D','#FFD700')
on conflict (competition_slug, slug) do nothing;
