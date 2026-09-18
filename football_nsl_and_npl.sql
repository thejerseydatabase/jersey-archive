-- Australian football (soccer) additions from your Wikipedia lists:
-- 1. The 3 still-missing A-League former clubs (Western United was
--    already on the site, already marked defunct).
-- 2. A new "NSL" competition (National Soccer League, 1977-2004, the
--    A-League's predecessor) with its ~40 clubs.
-- 3. Eight new state-based National Premier Leagues (NPL) competitions
--    with their current (2026 season) clubs.
--
-- Same "Also see" approach as the rugby league defunct clubs: where an
-- NSL club continued under the exact same name into the current
-- A-League or an NPL state competition (Adelaide United, Perth Glory,
-- Sydney Olympic, West Adelaide, Heidelberg United, Green Gully,
-- Preston Lions, South Melbourne, and a few others), it gets a row in
-- both competitions and the site's existing "Also see" feature links
-- them automatically. Where the club changed name or has a genuinely
-- disputed/split lineage (Brisbane Lions, Newcastle United -> Newcastle
-- Jets, Sunshine George Cross -> Caroline Springs George Cross), that's
-- called out in a history_note instead of forcing a name match.
--
-- Colours: a small handful of well-known heritage clubs use their real
-- colours; the large majority of these are semi-pro/amateur clubs whose
-- exact colours I genuinely don't know, so those get a generic
-- placeholder swatch (cycled through a handful of combinations just for
-- visual variety, not because it's the right one) — please correct any
-- of them you know via the admin pencil-edit. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('nsl','football','NSL (1977-2004)','more'),
  ('npl-act','football','NPL ACT','more'),
  ('npl-nsw','football','NPL NSW','more'),
  ('npl-northern-nsw','football','NPL Northern NSW','more'),
  ('npl-queensland','football','NPL Queensland','more'),
  ('npl-south-australia','football','NPL South Australia','more'),
  ('npl-tasmania','football','NPL Tasmania','more'),
  ('npl-victoria','football','NPL Victoria','more'),
  ('npl-western-australia','football','NPL Western Australia','more')
on conflict (slug) do nothing;

-- ============ A-League — the 3 still-missing former clubs ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('gold-coast-united','a-league','Gold Coast United','#FFD700','#003DA5', false),
  ('new-zealand-knights','a-league','New Zealand Knights','#000000','#FFFFFF', false),
  ('north-queensland-fury','a-league','North Queensland Fury','#FFD700','#000000', false)
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, is_active = excluded.is_active;

-- ============ NSL (1977-2004) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('adelaide-city','nsl','Adelaide City','#00205B','#FFFFFF', false),
  ('adelaide-united','nsl','Adelaide United','#DA291C','#002554', false),
  ('apia-leichhardt','nsl','APIA Leichhardt','#87CEEB','#FFFFFF', false),
  ('blacktown-city','nsl','Blacktown City','#003DA5','#FFFFFF', false),
  ('brisbane-city','nsl','Brisbane City','#003DA5','#FFFFFF', false),
  ('brisbane-strikers','nsl','Brisbane Strikers','#FFD700','#000000', false),
  ('brunswick-juventus','nsl','Brunswick Juventus','#000000','#FFFFFF', false),
  ('canberra-city','nsl','Canberra City','#5C2D91','#FFD700', false),
  ('canberra-cosmos','nsl','Canberra Cosmos','#003DA5','#FFFFFF', false),
  ('canterbury-marrickville','nsl','Canterbury-Marrickville','#CE1126','#000000', false),
  ('carlton','nsl','Carlton','#000000','#003DA5', false),
  ('collingwood-warriors','nsl','Collingwood Warriors','#000000','#FFFFFF', false),
  ('football-kingz','nsl','Football Kingz','#5C2D91','#000000', false),
  ('footscray-just','nsl','Footscray JUST','#CE1126','#FFFFFF', false),
  ('green-gully','nsl','Green Gully','#003DA5','#FFFFFF', false),
  ('heidelberg-united','nsl','Heidelberg United','#003DA5','#FFFFFF', false),
  ('inter-monaro','nsl','Inter Monaro','#00843D','#FFFFFF', false),
  ('marconi-stallions','nsl','Marconi Stallions','#00843D','#FFFFFF', false),
  ('melbourne-knights','nsl','Melbourne Knights','#CE1126','#FFFFFF', false),
  ('mooroolbark','nsl','Mooroolbark','#FFD700','#000000', false),
  ('morwell-falcons','nsl','Morwell Falcons','#7A263A','#FFFFFF', false),
  ('newcastle-breakers','nsl','Newcastle Breakers','#003893','#FFD700', false),
  ('newcastle-kb-united','nsl','Newcastle KB United','#CE1126','#000000', false),
  ('newcastle-rosebud-united','nsl','Newcastle Rosebud United','#00205B','#FFFFFF', false),
  ('northern-spirit','nsl','Northern Spirit','#000000','#FFFFFF', false),
  ('parramatta-eagles','nsl','Parramatta Eagles','#5C2D91','#FFD700', false),
  ('parramatta-power','nsl','Parramatta Power','#003DA5','#FFD700', false),
  ('penrith-city','nsl','Penrith City','#CE1126','#000000', false),
  ('perth-glory','nsl','Perth Glory','#7B2D8E','#F7941D', false),
  ('preston-lions','nsl','Preston Lions','#7A263A','#FFFFFF', false),
  ('south-melbourne','nsl','South Melbourne','#00205B','#FFFFFF', false),
  ('st-george','nsl','St George','#CE1126','#FFFFFF', false),
  ('sydney-city','nsl','Sydney City','#003DA5','#FFD700', false),
  ('sydney-olympic','nsl','Sydney Olympic','#003DA5','#FFFFFF', false),
  ('sydney-united','nsl','Sydney United','#CE1126','#FFFFFF', false),
  ('west-adelaide','nsl','West Adelaide','#003DA5','#FFFFFF', false),
  ('wollongong-macedonia','nsl','Wollongong Macedonia','#CE1126','#FFD700', false),
  ('wollongong-wolves','nsl','Wollongong Wolves','#000000','#FFD700', false)
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, is_active = excluded.is_active;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('brisbane-lions-nsl','nsl','Brisbane Lions','#00843D','#FFFFFF', false,
   'Lineage later split: part became the A-League''s Brisbane Roar, part continues as Queensland Lions in the NPL Queensland.'),
  ('newcastle-united-nsl','nsl','Newcastle United','#003893','#FFFFFF', false,
   'Became the A-League''s Newcastle Jets.'),
  ('sunshine-george-cross','nsl','Sunshine George Cross','#5C2D91','#FFFFFF', false,
   'Continues today as Caroline Springs George Cross in the NPL Victoria.'),
  ('western-suburbs-sydney','nsl','Western Suburbs','#CE1126','#000000', false,
   'Amalgamated with APIA Leichhardt in 1979.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- ============ NPL ACT ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('belconnen-united','npl-act','Belconnen United','#003DA5','#FFD700'),
  ('brindabella-blues','npl-act','Brindabella Blues','#003DA5','#FFFFFF'),
  ('canberra-croatia','npl-act','Canberra Croatia','#CE1126','#FFFFFF'),
  ('canberra-juventus','npl-act','Canberra Juventus','#000000','#FFFFFF'),
  ('canberra-olympic','npl-act','Canberra Olympic','#003DA5','#FFFFFF'),
  ('canberra-white-eagles','npl-act','Canberra White Eagles','#CE1126','#FFFFFF'),
  ('monaro-panthers','npl-act','Monaro Panthers','#00843D','#FFFFFF'),
  ('oconnor-knights','npl-act','O''Connor Knights','#5C2D91','#FFD700'),
  ('queanbeyan-city','npl-act','Queanbeyan City','#003DA5','#FFD700'),
  ('tigers-fc','npl-act','Tigers FC','#FFD700','#000000'),
  ('tuggeranong-united','npl-act','Tuggeranong United','#CE1126','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ NPL NSW ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('apia-leichhardt-npl','npl-nsw','APIA Leichhardt','#87CEEB','#FFFFFF'),
  ('blacktown-city-npl','npl-nsw','Blacktown City','#003DA5','#FFFFFF'),
  ('manly-united','npl-nsw','Manly United','#7A1F3D','#FFFFFF'),
  ('marconi-stallions-npl','npl-nsw','Marconi Stallions','#00843D','#FFFFFF'),
  ('north-west-sydney-spirit','npl-nsw','North West Sydney Spirit','#000000','#FFFFFF'),
  ('rockdale-ilinden','npl-nsw','Rockdale Ilinden','#CE1126','#FFD700'),
  ('sd-raiders','npl-nsw','SD Raiders','#003DA5','#000000'),
  ('st-george-city','npl-nsw','St George City','#CE1126','#FFFFFF'),
  ('st-george-fc','npl-nsw','St George FC','#003DA5','#FFFFFF'),
  ('sutherland-sharks','npl-nsw','Sutherland Sharks','#003DA5','#FFD700'),
  ('sydney-fc-youth','npl-nsw','Sydney FC Youth','#4EC3E0','#002B5C'),
  ('sydney-olympic-npl','npl-nsw','Sydney Olympic','#003DA5','#FFFFFF'),
  ('sydney-united-58','npl-nsw','Sydney United 58','#CE1126','#FFFFFF'),
  ('unsw-fc','npl-nsw','UNSW FC','#FFD700','#000000'),
  ('western-sydney-wanderers-youth','npl-nsw','Western Sydney Wanderers Youth','#E4032E','#000000'),
  ('wollongong-wolves-npl','npl-nsw','Wollongong Wolves','#000000','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ NPL Northern NSW ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adamstown-rosebud','npl-northern-nsw','Adamstown Rosebud','#00205B','#FFFFFF'),
  ('belmont-swansea','npl-northern-nsw','Belmont Swansea','#003DA5','#FFD700'),
  ('broadmeadow-magic','npl-northern-nsw','Broadmeadow Magic','#5C2D91','#FFFFFF'),
  ('charlestown-azzurri','npl-northern-nsw','Charlestown Azzurri','#87CEEB','#FFFFFF'),
  ('cooks-hill-united','npl-northern-nsw','Cooks Hill United','#CE1126','#000000'),
  ('edgeworth-eagles','npl-northern-nsw','Edgeworth Eagles','#000000','#FFD700'),
  ('kahibah-fc','npl-northern-nsw','Kahibah FC','#003DA5','#FFFFFF'),
  ('lambton-jaffas','npl-northern-nsw','Lambton Jaffas','#FF6600','#000000'),
  ('maitland-fc','npl-northern-nsw','Maitland FC','#CE1126','#FFFFFF'),
  ('newcastle-olympic','npl-northern-nsw','Newcastle Olympic','#003DA5','#FFFFFF'),
  ('valentine-fc','npl-northern-nsw','Valentine FC','#00843D','#FFFFFF'),
  ('weston-bears','npl-northern-nsw','Weston Bears','#CE1126','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ NPL Queensland ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('brisbane-city-npl','npl-queensland','Brisbane City','#003DA5','#FFFFFF'),
  ('brisbane-roar-youth','npl-queensland','Brisbane Roar Youth','#F7941D','#000000'),
  ('eastern-suburbs','npl-queensland','Eastern Suburbs','#5C2D91','#FFFFFF'),
  ('gold-coast-knights','npl-queensland','Gold Coast Knights','#003DA5','#FFD700'),
  ('gold-coast-united-npl','npl-queensland','Gold Coast United','#FFD700','#003DA5'),
  ('lions-fc','npl-queensland','Lions FC','#CE1126','#FFD700'),
  ('magic-united','npl-queensland','Magic United','#000000','#FFFFFF'),
  ('moreton-city-excelsior','npl-queensland','Moreton City Excelsior','#003DA5','#FFFFFF'),
  ('olympic-fc','npl-queensland','Olympic FC','#003DA5','#FFFFFF'),
  ('peninsula-power','npl-queensland','Peninsula Power','#5C2D91','#FFD700'),
  ('rochedale-rovers','npl-queensland','Rochedale Rovers','#003DA5','#FFD700'),
  ('wynnum-wolves','npl-queensland','Wynnum Wolves','#000000','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ NPL South Australia ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adelaide-city-npl','npl-south-australia','Adelaide City','#00205B','#FFFFFF'),
  ('adelaide-comets','npl-south-australia','Adelaide Comets','#5C2D91','#FFFFFF'),
  ('adelaide-croatia-raiders','npl-south-australia','Adelaide Croatia Raiders','#CE1126','#FFFFFF'),
  ('adelaide-united-youth','npl-south-australia','Adelaide United Youth','#DA291C','#002554'),
  ('campbelltown-city','npl-south-australia','Campbelltown City','#003DA5','#FFD700'),
  ('croydon-fc','npl-south-australia','Croydon FC','#000000','#FFFFFF'),
  ('modbury-jets','npl-south-australia','Modbury Jets','#003DA5','#FFFFFF'),
  ('fk-beograd','npl-south-australia','FK Beograd','#CE1126','#000000'),
  ('north-eastern-metrostars','npl-south-australia','North Eastern MetroStars','#003DA5','#FFD700'),
  ('para-hills-knights','npl-south-australia','Para Hills Knights','#000000','#FFD700'),
  ('playford-city','npl-south-australia','Playford City','#00843D','#FFFFFF'),
  ('sturt-lions','npl-south-australia','Sturt Lions','#CE1126','#FFD700'),
  ('west-adelaide-npl','npl-south-australia','West Adelaide','#003DA5','#FFFFFF'),
  ('west-torrens-birkalla','npl-south-australia','West Torrens Birkalla','#5C2D91','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ NPL Tasmania ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('clarence-zebras','npl-tasmania','Clarence Zebras','#000000','#FFFFFF'),
  ('devonport-city','npl-tasmania','Devonport City','#003DA5','#FFD700'),
  ('glenorchy-knights','npl-tasmania','Glenorchy Knights','#5C2D91','#FFFFFF'),
  ('kingborough-lions-united','npl-tasmania','Kingborough Lions United','#CE1126','#FFD700'),
  ('launceston-city','npl-tasmania','Launceston City','#003DA5','#FFFFFF'),
  ('launceston-united','npl-tasmania','Launceston United','#CE1126','#000000'),
  ('riverside-olympic','npl-tasmania','Riverside Olympic','#003DA5','#FFFFFF'),
  ('south-hobart','npl-tasmania','South Hobart','#00843D','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ NPL Victoria ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('altona-magic','npl-victoria','Altona Magic','#000000','#FFFFFF'),
  ('avondale','npl-victoria','Avondale','#5C2D91','#FFD700'),
  ('bentleigh-greens','npl-victoria','Bentleigh Greens','#00843D','#FFFFFF'),
  ('caroline-springs-george-cross','npl-victoria','Caroline Springs George Cross','#5C2D91','#FFFFFF'),
  ('dandenong-city','npl-victoria','Dandenong City','#003DA5','#FFD700'),
  ('dandenong-thunder','npl-victoria','Dandenong Thunder','#CE1126','#000000'),
  ('green-gully-npl','npl-victoria','Green Gully','#003DA5','#FFFFFF'),
  ('heidelberg-united-npl','npl-victoria','Heidelberg United','#003DA5','#FFFFFF'),
  ('hume-city','npl-victoria','Hume City','#000000','#FFD700'),
  ('melbourne-city-youth','npl-victoria','Melbourne City Youth','#6CADDF','#00285E'),
  ('oakleigh-cannons','npl-victoria','Oakleigh Cannons','#003DA5','#FFFFFF'),
  ('preston-lions-npl','npl-victoria','Preston Lions','#7A263A','#FFFFFF'),
  ('south-melbourne-npl','npl-victoria','South Melbourne','#00205B','#FFFFFF'),
  ('st-albans-saints','npl-victoria','St Albans Saints','#CE1126','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

-- ============ NPL Western Australia ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('armadale-sc','npl-western-australia','Armadale SC','#003DA5','#FFD700'),
  ('balcatta-fc','npl-western-australia','Balcatta FC','#CE1126','#000000'),
  ('bayswater-city','npl-western-australia','Bayswater City','#5C2D91','#FFFFFF'),
  ('dianella-white-eagles','npl-western-australia','Dianella White Eagles','#CE1126','#FFFFFF'),
  ('floreat-athena','npl-western-australia','Floreat Athena','#003DA5','#FFFFFF'),
  ('fremantle-city','npl-western-australia','Fremantle City','#00843D','#FFFFFF'),
  ('olympic-kingsway','npl-western-australia','Olympic Kingsway','#003DA5','#FFD700'),
  ('perth-azzurri','npl-western-australia','Perth Azzurri','#87CEEB','#FFFFFF'),
  ('perth-glory-youth','npl-western-australia','Perth Glory Youth','#7B2D8E','#F7941D'),
  ('perth-redstar','npl-western-australia','Perth RedStar','#CE1126','#000000'),
  ('sorrento-fc','npl-western-australia','Sorrento FC','#000000','#FFD700'),
  ('stirling-macedonia','npl-western-australia','Stirling Macedonia','#CE1126','#FFD700'),
  ('western-knights','npl-western-australia','Western Knights','#003DA5','#FFFFFF')
on conflict (competition_slug, slug) do nothing;
