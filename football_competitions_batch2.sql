-- ============================================================
-- Football additions from your latest lists: NWSL, WSL (England),
-- Bundesliga 2, National League + National League North/South
-- (England tiers 5/6), Serie B, Brasileirão, Ligue 1, Ligue 2, Liga
-- Profesional Argentina, Süper Lig, Liga MX, Eredivisie, La Liga 2, and
-- Liga Portugal. Safe to re-run (on conflict do nothing throughout).
--
-- Notes on your lists that needed a judgment call:
-- - Bundesliga and Serie A: your new lists match what's already on the
--   site exactly (same 18 and 20 clubs) — nothing to change there.
-- - Bundesliga 2: SV Elversberg, SC Paderborn and Schalke 04 appear in
--   both your Bundesliga and Bundesliga 2 lists. Since they're already
--   placed in the top-flight competition, I've left them out of
--   Bundesliga 2 (a club can't play in both) — flag me if that's wrong
--   and one of them actually belongs in the second tier instead.
-- - Liga Profesional Argentina: "Alfredo Terrera" in your list is
--   Central Córdoba (SdE)'s home stadium (Estadio Alfredo Terrera), not
--   a separate club — left out.
-- - Campeonato Brasileiro: "Mangueirão" is Remo's home stadium
--   (Estádio Olímpico do Pará), not a separate club — left out.
-- - Ligue 2 / Liga Portugal promotion arrows (Dijon↑, Metz↓, Sochaux↑,
--   Académico de Viseu↑, Marítimo↑) are just this-season movement
--   markers — stripped from the names.
-- - Serie B lists Frosinone, Monza and Venezia, which are also in your
--   (already-live) Serie A list. Added them to Serie B anyway since
--   they're a different competition_slug so there's no conflict, but
--   flagging the overlap in case one list is a season out of date.
-- - NWSL: Atlanta and Columbus are 2028 expansion sides, not yet
--   playing — added as is_upcoming (same treatment as the NRL's Perth
--   Bears/PNG Hunters), and the three defunct pre-2018 teams as
--   inactive rather than deleted.
-- - WSL: reused real colours for the clubs that already exist as
--   Premier League/Championship men's teams on the site (Arsenal,
--   Aston Villa, Birmingham City, Brighton, Charlton Athletic, Chelsea,
--   Crystal Palace, Everton, Liverpool, Man City, Man United, Tottenham,
--   West Ham). London City Lionesses has no men's-side colours to
--   borrow — best-guess placeholder.
-- - National League North/South (English tier 6): genuinely low
--   confidence on real club colours at this level for most clubs — used
--   generic placeholder swatches throughout both, flag anything you
--   know to be wrong.
-- ============================================================

alter table teams add column if not exists is_upcoming boolean not null default false;
alter table teams add column if not exists history_note text;

insert into competitions (slug, sport_slug, name, tier) values
  ('nwsl','football','NWSL','top'),
  ('wsl','football','Women''s Super League','more'),
  ('bundesliga-2','football','Bundesliga 2','more'),
  ('national-league','football','National League','more'),
  ('national-league-north','football','National League North','more'),
  ('national-league-south','football','National League South','more'),
  ('serie-b','football','Serie B','more'),
  ('brasileirao','football','Brasileirão','more'),
  ('ligue-1','football','Ligue 1','more'),
  ('ligue-2','football','Ligue 2','more'),
  ('liga-profesional-argentina','football','Liga Profesional Argentina','more'),
  ('super-lig','football','Süper Lig','more'),
  ('liga-mx','football','Liga MX','more'),
  ('eredivisie','football','Eredivisie','more'),
  ('la-liga-2','football','La Liga 2','more'),
  ('liga-portugal','football','Liga Portugal','more')
on conflict (slug) do nothing;

-- ============ NWSL ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('angel-city-fc','nwsl','Angel City FC','#C6007E','#000000'),
  ('bay-fc','nwsl','Bay FC','#F2611D','#041E42'),
  ('boston-legacy-fc','nwsl','Boston Legacy FC','#002868','#00843D'),
  ('chicago-stars-fc','nwsl','Chicago Stars FC','#C8102E','#002664'),
  ('denver-summit-fc','nwsl','Denver Summit FC','#862633','#003087'),
  ('gotham-fc','nwsl','Gotham FC','#00A9E0','#000000'),
  ('houston-dash','nwsl','Houston Dash','#F7941E','#101820'),
  ('kansas-city-current','nwsl','Kansas City Current','#6F2C91','#00B2A9'),
  ('north-carolina-courage','nwsl','North Carolina Courage','#001E62','#00B2A9'),
  ('orlando-pride','nwsl','Orlando Pride','#5F259F','#FFFFFF'),
  ('portland-thorns-fc','nwsl','Portland Thorns FC','#E31B23','#000000'),
  ('racing-louisville-fc','nwsl','Racing Louisville FC','#5B2A86','#FDB927'),
  ('san-diego-wave-fc','nwsl','San Diego Wave FC','#0C2340','#F58426'),
  ('seattle-reign-fc','nwsl','Seattle Reign FC','#4B2E83','#FFFFFF'),
  ('utah-royals','nwsl','Utah Royals','#002664','#FFD200'),
  ('washington-spirit','nwsl','Washington Spirit','#A6192E','#002868')
on conflict (competition_slug, slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_upcoming, history_note) values
  ('atlanta-nwsl','nwsl','Atlanta NWSL Team','#A6192E','#000000', true, 'Joining the NWSL in 2028, affiliated with Atlanta United FC.'),
  ('columbus-nwsl','nwsl','Columbus NWSL Team','#FFF110','#000000', true, 'Joining the NWSL in 2028, affiliated with Columbus Crew.')
on conflict (competition_slug, slug) do update
  set is_upcoming = excluded.is_upcoming, history_note = excluded.history_note;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('boston-breakers','nwsl','Boston Breakers','#00205B','#FFFFFF',false),
  ('fc-kansas-city','nwsl','FC Kansas City','#6F2C91','#FFFFFF',false),
  ('western-new-york-flash','nwsl','Western New York Flash','#FFD700','#000000',false)
on conflict (competition_slug, slug) do nothing;

-- ============ WSL (England) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('arsenal-wsl','wsl','Arsenal','#EF0107','#FFFFFF'),
  ('aston-villa-wsl','wsl','Aston Villa','#670E36','#95BFE5'),
  ('birmingham-city-wsl','wsl','Birmingham City','#0044A9','#FFFFFF'),
  ('brighton-hove-albion-wsl','wsl','Brighton & Hove Albion','#0057B8','#FFFFFF'),
  ('charlton-athletic-wsl','wsl','Charlton Athletic','#D2122E','#FFFFFF'),
  ('chelsea-wsl','wsl','Chelsea','#034694','#FFFFFF'),
  ('crystal-palace-wsl','wsl','Crystal Palace','#1B458F','#C4122E'),
  ('everton-wsl','wsl','Everton','#003399','#FFFFFF'),
  ('liverpool-wsl','wsl','Liverpool','#C8102E','#FFFFFF'),
  ('london-city-lionesses','wsl','London City Lionesses','#6A0DAD','#FFFFFF'),
  ('manchester-city-wsl','wsl','Manchester City','#6CABDD','#FFFFFF'),
  ('manchester-united-wsl','wsl','Manchester United','#DA291C','#FFFFFF'),
  ('tottenham-hotspur-wsl','wsl','Tottenham Hotspur','#FFFFFF','#132257'),
  ('west-ham-united-wsl','wsl','West Ham United','#7A263A','#1BB1E7')
on conflict (competition_slug, slug) do nothing;

-- ============ Bundesliga 2 (Germany) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('hertha-bsc','bundesliga-2','Hertha BSC','#004C9E','#FFFFFF'),
  ('arminia-bielefeld','bundesliga-2','Arminia Bielefeld','#000000','#0057A8'),
  ('vfl-bochum','bundesliga-2','VfL Bochum','#1961B5','#FFFFFF'),
  ('eintracht-braunschweig','bundesliga-2','Eintracht Braunschweig','#FCD200','#00205B'),
  ('darmstadt-98','bundesliga-2','Darmstadt 98','#003DA5','#FFFFFF'),
  ('dynamo-dresden','bundesliga-2','Dynamo Dresden','#FFD200','#000000'),
  ('fortuna-dusseldorf','bundesliga-2','Fortuna Düsseldorf','#E2001A','#FFFFFF'),
  ('greuther-furth','bundesliga-2','Greuther Fürth','#00843D','#FFFFFF'),
  ('hannover-96','bundesliga-2','Hannover 96','#009B3A','#000000'),
  ('1-fc-kaiserslautern','bundesliga-2','1. FC Kaiserslautern','#E2001A','#000000'),
  ('karlsruher-sc','bundesliga-2','Karlsruher SC','#0057A8','#FFFFFF'),
  ('holstein-kiel','bundesliga-2','Holstein Kiel','#003DA5','#FFFFFF'),
  ('1-fc-magdeburg','bundesliga-2','1. FC Magdeburg','#003DA5','#FFFFFF'),
  ('preussen-munster','bundesliga-2','Preußen Münster','#000000','#FFFFFF'),
  ('1-fc-nurnberg','bundesliga-2','1. FC Nürnberg','#C8102E','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ National League (England, tier 5) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('afc-fylde','national-league','AFC Fylde','#00843D','#FFFFFF'),
  ('aldershot-town','national-league','Aldershot Town','#EE2523','#003DA5'),
  ('altrincham','national-league','Altrincham','#EE2523','#FFFFFF'),
  ('barrow-fc','national-league','Barrow','#003DA5','#FFFFFF'),
  ('boreham-wood','national-league','Boreham Wood','#000000','#FFFFFF'),
  ('boston-united','national-league','Boston United','#FFC72C','#000000'),
  ('carlisle-united','national-league','Carlisle United','#003DA5','#FFFFFF'),
  ('eastleigh','national-league','Eastleigh','#003DA5','#FFFFFF'),
  ('fc-halifax-town','national-league','FC Halifax Town','#003DA5','#FFFFFF'),
  ('forest-green-rovers','national-league','Forest Green Rovers','#00843D','#FFFFFF'),
  ('gateshead-fc','national-league','Gateshead','#000000','#FFFFFF'),
  ('harrogate-town','national-league','Harrogate Town','#FFD200','#003DA5'),
  ('hartlepool-united','national-league','Hartlepool United','#003DA5','#FFFFFF'),
  ('hornchurch','national-league','Hornchurch','#003DA5','#FFFFFF'),
  ('kidderminster-harriers','national-league','Kidderminster Harriers','#EE2523','#FFFFFF'),
  ('scunthorpe-united','national-league','Scunthorpe United','#7A263A','#87CEEB'),
  ('solihull-moors','national-league','Solihull Moors','#003DA5','#FFFFFF'),
  ('southend-united','national-league','Southend United','#003DA5','#FFFFFF'),
  ('sutton-united','national-league','Sutton United','#FFC72C','#000000'),
  ('tamworth-fc','national-league','Tamworth','#EE2523','#FFFFFF'),
  ('wealdstone','national-league','Wealdstone','#FFC72C','#000000'),
  ('woking-fc','national-league','Woking','#EE2523','#FFFFFF'),
  ('worthing-fc','national-league','Worthing','#EE2523','#FFFFFF'),
  ('yeovil-town','national-league','Yeovil Town','#00843D','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ National League North (England, tier 6) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('afc-telford-united','national-league-north','AFC Telford United','#003DA5','#FFFFFF'),
  ('bedford-town','national-league-north','Bedford Town','#CE1126','#FFD700'),
  ('brackley-town','national-league-north','Brackley Town','#5C2D91','#FFD700'),
  ('buxton-fc','national-league-north','Buxton','#5C2D91','#FFFFFF'),
  ('chester-fc','national-league-north','Chester','#003DA5','#FFFFFF'),
  ('chorley-fc','national-league-north','Chorley','#5C2D91','#FFD700'),
  ('darlington-fc','national-league-north','Darlington','#000000','#FFFFFF'),
  ('harborough-town','national-league-north','Harborough Town','#00843D','#FFFFFF'),
  ('hebburn-town','national-league-north','Hebburn Town','#003DA5','#FFD700'),
  ('hednesford-town','national-league-north','Hednesford Town','#CE1126','#FFD700'),
  ('hereford-fc','national-league-north','Hereford','#000000','#FFFFFF'),
  ('kings-lynn-town','national-league-north','King''s Lynn Town','#FFD700','#00843D'),
  ('macclesfield-fc','national-league-north','Macclesfield','#003DA5','#FFFFFF'),
  ('marine-afc','national-league-north','Marine','#00205B','#FFFFFF'),
  ('merthyr-town','national-league-north','Merthyr Town','#CE1126','#FFFFFF'),
  ('morecambe-fc','national-league-north','Morecambe','#CE1126','#FFFFFF'),
  ('oxford-city','national-league-north','Oxford City','#5C2D91','#FFD700'),
  ('radcliffe-fc','national-league-north','Radcliffe','#003DA5','#FFFFFF'),
  ('scarborough-athletic','national-league-north','Scarborough Athletic','#CE1126','#000000'),
  ('south-shields','national-league-north','South Shields','#003DA5','#FFFFFF'),
  ('southport-fc','national-league-north','Southport','#FFD700','#000000'),
  ('spalding-united','national-league-north','Spalding United','#CE1126','#FFFFFF'),
  ('spennymoor-town','national-league-north','Spennymoor Town','#000000','#FFFFFF'),
  ('worksop-town','national-league-north','Worksop Town','#FFD700','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ National League South (England, tier 6) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('afc-totton','national-league-south','AFC Totton','#5C2D91','#FFFFFF'),
  ('billericay-town','national-league-south','Billericay Town','#003DA5','#FFD700'),
  ('braintree-town','national-league-south','Braintree Town','#CE1126','#FFFFFF'),
  ('chelmsford-city','national-league-south','Chelmsford City','#003DA5','#FFFFFF'),
  ('chesham-united','national-league-south','Chesham United','#00843D','#FFFFFF'),
  ('dagenham-redbridge','national-league-south','Dagenham & Redbridge','#CE1126','#003DA5'),
  ('dorking-wanderers','national-league-south','Dorking Wanderers','#5C2D91','#FFD700'),
  ('dover-athletic','national-league-south','Dover Athletic','#CE1126','#FFFFFF'),
  ('ebbsfleet-united','national-league-south','Ebbsfleet United','#CE1126','#FFFFFF'),
  ('farnborough-fc','national-league-south','Farnborough','#000000','#FFD700'),
  ('farnham-town','national-league-south','Farnham Town','#003DA5','#FFFFFF'),
  ('folkestone-invicta','national-league-south','Folkestone Invicta','#CE1126','#FFFFFF'),
  ('hampton-richmond-borough','national-league-south','Hampton & Richmond Borough','#5C2D91','#FFD700'),
  ('hemel-hempstead-town','national-league-south','Hemel Hempstead Town','#CE1126','#FFFFFF'),
  ('horsham-fc','national-league-south','Horsham','#00843D','#FFFFFF'),
  ('maidenhead-united','national-league-south','Maidenhead United','#CE1126','#000000'),
  ('maidstone-united','national-league-south','Maidstone United','#FFD700','#000000'),
  ('salisbury-fc','national-league-south','Salisbury','#5C2D91','#FFFFFF'),
  ('slough-town','national-league-south','Slough Town','#CE1126','#FFFFFF'),
  ('tonbridge-angels','national-league-south','Tonbridge Angels','#003DA5','#FFD700'),
  ('torquay-united','national-league-south','Torquay United','#FFD700','#CE1126'),
  ('truro-city','national-league-south','Truro City','#5C2D91','#FFFFFF'),
  ('walton-hersham','national-league-south','Walton & Hersham','#00843D','#FFFFFF'),
  ('weston-super-mare','national-league-south','Weston-super-Mare','#CE1126','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ Serie B (Italy) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('avellino','serie-b','Avellino','#00843D','#FFFFFF'),
  ('bari','serie-b','Bari','#CE1126','#FFFFFF'),
  ('carrarese','serie-b','Carrarese','#003DA5','#FFD700'),
  ('catanzaro','serie-b','Catanzaro','#FFD700','#CE1126'),
  ('cesena','serie-b','Cesena','#FFFFFF','#000000'),
  ('empoli','serie-b','Empoli','#003DA5','#FFFFFF'),
  ('frosinone','serie-b','Frosinone','#FFD700','#002664'),
  ('juve-stabia','serie-b','Juve Stabia','#5C2D91','#FFD700'),
  ('mantova','serie-b','Mantova','#5C2D91','#FFFFFF'),
  ('modena','serie-b','Modena','#FFD700','#000000'),
  ('monza','serie-b','Monza','#C8102E','#FFFFFF'),
  ('padova','serie-b','Padova','#5C2D91','#FFFFFF'),
  ('palermo','serie-b','Palermo','#FF69B4','#000000'),
  ('pescara','serie-b','Pescara','#003DA5','#FFFFFF'),
  ('reggiana','serie-b','Reggiana','#7A263A','#FFFFFF'),
  ('sampdoria','serie-b','Sampdoria','#003DA5','#CE1126'),
  ('spezia','serie-b','Spezia','#FFFFFF','#000000'),
  ('sudtirol','serie-b','Südtirol','#CE1126','#FFFFFF'),
  ('venezia','serie-b','Venezia','#000000','#FF6600'),
  ('virtus-entella','serie-b','Virtus Entella','#5C2D91','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Brasileirão (Brazil) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('athletico-paranaense','brasileirao','Athletico Paranaense','#CE1126','#000000'),
  ('atletico-mineiro','brasileirao','Atlético Mineiro','#000000','#FFFFFF'),
  ('bahia','brasileirao','Bahia','#003DA5','#CE1126'),
  ('botafogo','brasileirao','Botafogo','#000000','#FFFFFF'),
  ('chapecoense','brasileirao','Chapecoense','#00843D','#FFFFFF'),
  ('corinthians','brasileirao','Corinthians','#000000','#FFFFFF'),
  ('coritiba','brasileirao','Coritiba','#00843D','#FFFFFF'),
  ('cruzeiro','brasileirao','Cruzeiro','#003DA5','#FFFFFF'),
  ('flamengo','brasileirao','Flamengo','#CE1126','#000000'),
  ('fluminense','brasileirao','Fluminense','#7A263A','#00843D'),
  ('gremio','brasileirao','Grêmio','#003DA5','#000000'),
  ('internacional','brasileirao','Internacional','#CE1126','#FFFFFF'),
  ('mirassol','brasileirao','Mirassol','#FFD700','#00843D'),
  ('palmeiras','brasileirao','Palmeiras','#00843D','#FFFFFF'),
  ('red-bull-bragantino','brasileirao','Red Bull Bragantino','#FFD700','#CE1126'),
  ('remo','brasileirao','Remo','#003DA5','#FFFFFF'),
  ('santos','brasileirao','Santos','#FFFFFF','#000000'),
  ('sao-paulo','brasileirao','São Paulo','#CE1126','#000000'),
  ('vasco-da-gama','brasileirao','Vasco da Gama','#000000','#FFFFFF'),
  ('vitoria','brasileirao','Vitória','#CE1126','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ Ligue 1 (France) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('angers-sco','ligue-1','Angers','#000000','#FFFFFF'),
  ('auxerre','ligue-1','Auxerre','#003DA5','#FFFFFF'),
  ('stade-brestois','ligue-1','Brest','#CE1126','#FFFFFF'),
  ('le-havre-ac','ligue-1','Le Havre','#003DA5','#87CEEB'),
  ('le-mans-fc','ligue-1','Le Mans','#003DA5','#FFFFFF'),
  ('rc-lens','ligue-1','Lens','#FFD700','#CE1126'),
  ('lille-osc','ligue-1','Lille','#CE1126','#003DA5'),
  ('fc-lorient','ligue-1','Lorient','#FF6600','#000000'),
  ('olympique-lyonnais','ligue-1','Lyon','#003DA5','#CE1126'),
  ('olympique-marseille','ligue-1','Marseille','#00AEEF','#FFFFFF'),
  ('as-monaco','ligue-1','Monaco','#CE1126','#FFFFFF'),
  ('ogc-nice','ligue-1','Nice','#CE1126','#000000'),
  ('paris-fc','ligue-1','Paris FC','#003DA5','#CE1126'),
  ('paris-saint-germain','ligue-1','Paris Saint-Germain','#004170','#DA291C'),
  ('stade-rennais','ligue-1','Rennes','#CE1126','#000000'),
  ('rc-strasbourg','ligue-1','Strasbourg','#003DA5','#FFFFFF'),
  ('toulouse-fc','ligue-1','Toulouse','#762066','#FFFFFF'),
  ('es-troyes-ac','ligue-1','Troyes','#003DA5','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Ligue 2 (France) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('fc-annecy','ligue-2','Annecy','#CE1126','#FFFFFF'),
  ('us-boulogne','ligue-2','Boulogne','#003DA5','#FFFFFF'),
  ('clermont-foot','ligue-2','Clermont','#7A263A','#FFD700'),
  ('dijon-fco','ligue-2','Dijon','#CE1126','#FFFFFF'),
  ('usl-dunkerque','ligue-2','Dunkerque','#FF6600','#000000'),
  ('grenoble-foot','ligue-2','Grenoble','#CE1126','#003DA5'),
  ('ea-guingamp','ligue-2','Guingamp','#CE1126','#000000'),
  ('stade-lavallois','ligue-2','Laval','#5C2D91','#FFFFFF'),
  ('fc-metz','ligue-2','Metz','#7A263A','#FFD700'),
  ('montpellier-hsc','ligue-2','Montpellier','#FF6600','#003DA5'),
  ('as-nancy-lorraine','ligue-2','Nancy','#CE1126','#FFFFFF'),
  ('fc-nantes','ligue-2','Nantes','#FFD700','#003DA5'),
  ('pau-fc','ligue-2','Pau','#5C2D91','#FFD700'),
  ('red-star-fc','ligue-2','Red Star','#003DA5','#CE1126'),
  ('stade-de-reims','ligue-2','Reims','#CE1126','#FFFFFF'),
  ('rodez-af','ligue-2','Rodez','#CE1126','#000000'),
  ('as-saint-etienne','ligue-2','Saint-Étienne','#00843D','#FFFFFF'),
  ('fc-sochaux','ligue-2','Sochaux','#FFD700','#003DA5')
on conflict (competition_slug, slug) do nothing;

-- ============ Liga Profesional Argentina ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('aldosivi','liga-profesional-argentina','Aldosivi','#FFD700','#00843D'),
  ('argentinos-juniors','liga-profesional-argentina','Argentinos Juniors','#CE1126','#FFFFFF'),
  ('atletico-tucuman','liga-profesional-argentina','Atlético Tucumán','#5C2D91','#FFFFFF'),
  ('banfield','liga-profesional-argentina','Banfield','#00843D','#FFFFFF'),
  ('barracas-central','liga-profesional-argentina','Barracas Central','#CE1126','#000000'),
  ('belgrano','liga-profesional-argentina','Belgrano','#87CEEB','#000000'),
  ('boca-juniors','liga-profesional-argentina','Boca Juniors','#003DA5','#FFD700'),
  ('central-cordoba-sde','liga-profesional-argentina','Central Córdoba (SdE)','#000000','#FFFFFF'),
  ('defensa-y-justicia','liga-profesional-argentina','Defensa y Justicia','#5C2D91','#00843D'),
  ('deportivo-riestra','liga-profesional-argentina','Deportivo Riestra','#000000','#FFD700'),
  ('estudiantes-lp','liga-profesional-argentina','Estudiantes (LP)','#CE1126','#FFFFFF'),
  ('estudiantes-rc','liga-profesional-argentina','Estudiantes (RC)','#CE1126','#000000'),
  ('gimnasia-lp','liga-profesional-argentina','Gimnasia y Esgrima (LP)','#003DA5','#FFFFFF'),
  ('gimnasia-m','liga-profesional-argentina','Gimnasia y Esgrima (M)','#000000','#FFFFFF'),
  ('huracan','liga-profesional-argentina','Huracán','#FFFFFF','#CE1126'),
  ('independiente','liga-profesional-argentina','Independiente','#CE1126','#FFFFFF'),
  ('independiente-rivadavia','liga-profesional-argentina','Independiente Rivadavia','#003DA5','#FFFFFF'),
  ('instituto','liga-profesional-argentina','Instituto','#CE1126','#FFFFFF'),
  ('lanus','liga-profesional-argentina','Lanús','#7A263A','#FFD700'),
  ('newells-old-boys','liga-profesional-argentina','Newell''s Old Boys','#CE1126','#000000'),
  ('platense','liga-profesional-argentina','Platense','#7A263A','#FFFFFF'),
  ('racing-club','liga-profesional-argentina','Racing','#87CEEB','#FFFFFF'),
  ('river-plate','liga-profesional-argentina','River Plate','#FFFFFF','#CE1126'),
  ('rosario-central','liga-profesional-argentina','Rosario Central','#003DA5','#FFD700'),
  ('san-lorenzo','liga-profesional-argentina','San Lorenzo','#003DA5','#CE1126'),
  ('sarmiento-j','liga-profesional-argentina','Sarmiento (J)','#00843D','#FFFFFF'),
  ('talleres-c','liga-profesional-argentina','Talleres (C)','#003DA5','#FFFFFF'),
  ('tigre','liga-profesional-argentina','Tigre','#003DA5','#FFD700'),
  ('union','liga-profesional-argentina','Unión','#CE1126','#FFFFFF'),
  ('velez-sarsfield','liga-profesional-argentina','Vélez Sarsfield','#003DA5','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Süper Lig (Turkey) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('alanyaspor','super-lig','Alanyaspor','#FF6600','#00843D'),
  ('amedspor','super-lig','Amedspor','#00843D','#FFD700'),
  ('istanbul-basaksehir','super-lig','Başakşehir','#FF6600','#003DA5'),
  ('besiktas','super-lig','Beşiktaş','#000000','#FFFFFF'),
  ('corum-fk','super-lig','Çorum','#CE1126','#FFFFFF'),
  ('erzurumspor','super-lig','Erzurumspor','#003DA5','#FFFFFF'),
  ('eyupspor','super-lig','Eyüpspor','#5C2D91','#FFD700'),
  ('fenerbahce','super-lig','Fenerbahçe','#FFD700','#003DA5'),
  ('galatasaray','super-lig','Galatasaray','#CE1126','#FFD700'),
  ('gaziantep-fk','super-lig','Gaziantep','#CE1126','#000000'),
  ('genclerbirligi','super-lig','Gençlerbirliği','#CE1126','#000000'),
  ('goztepe','super-lig','Göztepe','#CE1126','#FFD700'),
  ('kasimpasa','super-lig','Kasımpaşa','#003DA5','#FFFFFF'),
  ('kocaelispor','super-lig','Kocaelispor','#003DA5','#FFD700'),
  ('konyaspor','super-lig','Konyaspor','#00843D','#FFFFFF'),
  ('caykur-rizespor','super-lig','Rizespor','#00843D','#003DA5'),
  ('samsunspor','super-lig','Samsunspor','#CE1126','#FFFFFF'),
  ('trabzonspor','super-lig','Trabzonspor','#87CEEB','#CE1126')
on conflict (competition_slug, slug) do nothing;

-- ============ Liga MX (Mexico) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('america','liga-mx','América','#FFD700','#003DA5'),
  ('atlante','liga-mx','Atlante','#003DA5','#FFD700'),
  ('atlas','liga-mx','Atlas','#CE1126','#000000'),
  ('atletico-san-luis','liga-mx','Atlético San Luis','#CE1126','#FFFFFF'),
  ('cruz-azul','liga-mx','Cruz Azul','#003DA5','#FFFFFF'),
  ('guadalajara','liga-mx','Guadalajara','#CE1126','#003DA5'),
  ('juarez','liga-mx','Juárez','#003DA5','#FFFFFF'),
  ('leon','liga-mx','León','#00843D','#FFFFFF'),
  ('monterrey','liga-mx','Monterrey','#003DA5','#FFFFFF'),
  ('necaxa','liga-mx','Necaxa','#CE1126','#FFFFFF'),
  ('pachuca','liga-mx','Pachuca','#003DA5','#FFD700'),
  ('puebla','liga-mx','Puebla','#003DA5','#FFFFFF'),
  ('pumas-unam','liga-mx','Pumas UNAM','#003DA5','#FFD700'),
  ('queretaro','liga-mx','Querétaro','#000000','#FFD700'),
  ('santos-laguna','liga-mx','Santos Laguna','#00843D','#FFFFFF'),
  ('tigres-uanl','liga-mx','Tigres UANL','#FF6600','#003DA5'),
  ('tijuana','liga-mx','Tijuana','#CE1126','#000000'),
  ('toluca','liga-mx','Toluca','#CE1126','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Eredivisie (Netherlands) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('ado-den-haag','eredivisie','ADO Den Haag','#FFD700','#00843D'),
  ('ajax','eredivisie','Ajax','#D2122E','#FFFFFF'),
  ('az-alkmaar','eredivisie','AZ','#CE1126','#FFFFFF'),
  ('sc-cambuur','eredivisie','Cambuur','#FFD700','#003DA5'),
  ('excelsior','eredivisie','Excelsior','#CE1126','#000000'),
  ('feyenoord','eredivisie','Feyenoord','#CE1126','#FFFFFF'),
  ('fortuna-sittard','eredivisie','Fortuna Sittard','#FFD700','#00843D'),
  ('go-ahead-eagles','eredivisie','Go Ahead Eagles','#CE1126','#FFD700'),
  ('fc-groningen','eredivisie','Groningen','#003DA5','#FFFFFF'),
  ('sc-heerenveen','eredivisie','Heerenveen','#003DA5','#FFFFFF'),
  ('nec-nijmegen','eredivisie','N.E.C.','#CE1126','#000000'),
  ('pec-zwolle','eredivisie','PEC Zwolle','#003DA5','#FFFFFF'),
  ('psv-eindhoven','eredivisie','PSV','#CE1126','#FFFFFF'),
  ('sparta-rotterdam','eredivisie','Sparta Rotterdam','#CE1126','#FFFFFF'),
  ('telstar','eredivisie','Telstar','#FF6600','#000000'),
  ('fc-twente','eredivisie','Twente','#CE1126','#FFFFFF'),
  ('fc-utrecht','eredivisie','Utrecht','#CE1126','#FFFFFF'),
  ('willem-ii','eredivisie','Willem II','#003DA5','#CE1126')
on conflict (competition_slug, slug) do nothing;

-- ============ La Liga 2 (Spain) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('albacete','la-liga-2','Albacete','#003DA5','#FFFFFF'),
  ('almeria','la-liga-2','Almería','#CE1126','#FFFFFF'),
  ('andorra-fc','la-liga-2','Andorra','#003DA5','#FFD700'),
  ('burgos-cf','la-liga-2','Burgos','#000000','#FFFFFF'),
  ('cadiz-cf','la-liga-2','Cádiz','#FFD700','#003DA5'),
  ('cd-castellon','la-liga-2','Castellón','#5C2D91','#FFFFFF'),
  ('celta-fortuna','la-liga-2','Celta Fortuna','#8AC6E8','#FFFFFF'),
  ('ad-ceuta','la-liga-2','Ceuta','#CE1126','#FFD700'),
  ('cordoba-cf','la-liga-2','Córdoba','#FFFFFF','#003DA5'),
  ('sd-eibar','la-liga-2','Eibar','#003DA5','#FFFFFF'),
  ('cd-eldense','la-liga-2','Eldense','#CE1126','#000000'),
  ('girona-fc','la-liga-2','Girona','#CE1126','#FFFFFF'),
  ('granada-cf','la-liga-2','Granada','#CE1126','#FFFFFF'),
  ('las-palmas','la-liga-2','Las Palmas','#FFD700','#003DA5'),
  ('cd-leganes','la-liga-2','Leganés','#003DA5','#FFFFFF'),
  ('rcd-mallorca','la-liga-2','Mallorca','#CE1126','#FFD700'),
  ('real-oviedo','la-liga-2','Oviedo','#003DA5','#FFFFFF'),
  ('real-sociedad-b','la-liga-2','Real Sociedad B','#0F3F7C','#FFFFFF'),
  ('ce-sabadell','la-liga-2','Sabadell','#003DA5','#FFFFFF'),
  ('sporting-gijon','la-liga-2','Sporting Gijón','#CE1126','#FFFFFF'),
  ('cd-tenerife','la-liga-2','Tenerife','#003DA5','#FFFFFF'),
  ('real-valladolid','la-liga-2','Valladolid','#5C2D91','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ Liga Portugal (Portugal) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('academico-de-viseu','liga-portugal','Académico de Viseu','#003DA5','#FFFFFF'),
  ('fc-alverca','liga-portugal','Alverca','#CE1126','#FFFFFF'),
  ('fc-arouca','liga-portugal','Arouca','#FFD700','#000000'),
  ('sl-benfica','liga-portugal','Benfica','#CE1126','#FFFFFF'),
  ('sc-braga','liga-portugal','Braga','#CE1126','#FFFFFF'),
  ('casa-pia-ac','liga-portugal','Casa Pia','#000000','#FFFFFF'),
  ('estoril-praia','liga-portugal','Estoril Praia','#FFD700','#003DA5'),
  ('estrela-da-amadora','liga-portugal','Estrela da Amadora','#00843D','#FFFFFF'),
  ('fc-famalicao','liga-portugal','Famalicão','#CE1126','#FFFFFF'),
  ('gil-vicente-fc','liga-portugal','Gil Vicente','#5C2D91','#FFFFFF'),
  ('cd-maritimo','liga-portugal','Marítimo','#00843D','#FFFFFF'),
  ('moreirense-fc','liga-portugal','Moreirense','#00843D','#FFFFFF'),
  ('cd-nacional','liga-portugal','Nacional','#000000','#FFFFFF'),
  ('fc-porto','liga-portugal','Porto','#003DA5','#FFFFFF'),
  ('rio-ave-fc','liga-portugal','Rio Ave','#00843D','#FFFFFF'),
  ('santa-clara','liga-portugal','Santa Clara','#003DA5','#FFFFFF'),
  ('sporting-cp','liga-portugal','Sporting CP','#00843D','#FFFFFF'),
  ('vitoria-de-guimaraes','liga-portugal','Vitória de Guimarães','#FFFFFF','#000000')
on conflict (competition_slug, slug) do nothing;
