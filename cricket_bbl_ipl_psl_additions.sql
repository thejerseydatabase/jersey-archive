-- Adds teams to the BBL, IPL and PSL competitions that already exist in
-- the schema, plus two new competitions: the Australia domestic
-- first-class/one-day sides (Sheffield Shield/WNCL era teams, kept
-- separate from the BBL franchises), and India's WPL (split out from the
-- IPL list since two entries were explicitly marked "(WPL)"). Safe to
-- re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('australia-domestic','cricket','Australia Domestic','more'),
  ('wpl','cricket','Women''s Premier League','more')
on conflict (slug) do nothing;

-- BBL (existing competition)
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adelaide-strikers','bbl','Adelaide Strikers','#003DA5','#FFD200'),
  ('brisbane-heat','bbl','Brisbane Heat','#00A99D','#EC008C'),
  ('hobart-hurricanes','bbl','Hobart Hurricanes','#4B2E83','#00AEEF'),
  ('melbourne-renegades','bbl','Melbourne Renegades','#C6007E','#000000'),
  ('melbourne-stars','bbl','Melbourne Stars','#00843D','#FFD200'),
  ('perth-scorchers','bbl','Perth Scorchers','#F57F17','#000000'),
  ('sydney-sixers','bbl','Sydney Sixers','#EC008C','#000000'),
  ('sydney-thunder','bbl','Sydney Thunder','#9ACD32','#5C2D91')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

-- Australia domestic (Sheffield Shield / WNCL era state sides)
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('act-meteors','australia-domestic','ACT Meteors','#003DA5','#FFD200'),
  ('new-south-wales-blues','australia-domestic','New South Wales Blues','#001E62','#FFFFFF'),
  ('queensland-bulls-fire','australia-domestic','Queensland Bulls/Fire','#6A0032','#FFD700'),
  ('south-australia-redbacks-scorpions','australia-domestic','South Australia Redbacks/Scorpions','#C8102E','#001E62'),
  ('tasmanian-tigers','australia-domestic','Tasmanian Tigers','#002664','#00843D'),
  ('victoria','australia-domestic','Victoria','#002664','#FFFFFF'),
  ('western-australia','australia-domestic','Western Australia','#000000','#FFD700')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

-- IPL (existing competition) — the two WPL-marked entries go to the new
-- wpl competition instead, below
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('chennai-super-kings','ipl','Chennai Super Kings','#FFD700','#0033A0'),
  ('delhi-capitals','ipl','Delhi Capitals','#17479E','#EC1C24'),
  ('gujarat-titans','ipl','Gujarat Titans','#1B2133','#B3A369'),
  ('kolkata-knight-riders','ipl','Kolkata Knight Riders','#2E0854','#FFD700'),
  ('lucknow-super-giants','ipl','Lucknow Super Giants','#00B2A9','#EC5C29'),
  ('mumbai-indians','ipl','Mumbai Indians','#045093','#FFD700'),
  ('punjab-kings','ipl','Punjab Kings','#ED1C24','#C0C0C0'),
  ('rajasthan-royals','ipl','Rajasthan Royals','#FF1493','#254AA5'),
  ('royal-challengers-bangalore','ipl','Royal Challengers Bangalore','#EC1C24','#FFD700'),
  ('sunrises-hyderabad','ipl','Sunrises Hyderabad','#F26522','#000000')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

-- WPL (new competition)
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('gujarat-giants-wpl','wpl','Gujarat Giants (WPL)','#6A0DAD','#FFD700'),
  ('up-warriorz-wpl','wpl','UP Warriorz (WPL)','#EC008C','#003893')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

-- PSL (existing competition) — included exactly as given; a few of these
-- (Hyderabad Kingsmen, Pindiz, Sialkot Stallionz) I don't have confident
-- brand-colour knowledge of, so those three use generic placeholders.
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('hyderabad-kingsmen','psl','Hyderabad Kingsmen','#002664','#FFD700'),
  ('islamabad-united','psl','Islamabad United','#ED1C24','#000000'),
  ('karachi-kings','psl','Karachi Kings','#00AEEF','#ED1C24'),
  ('lahore-qalandars','psl','Lahore Qalandars','#00843D','#000000'),
  ('multan-sultans','psl','Multan Sultans','#ED1C24','#FFD700'),
  ('peshawar-zalmi','psl','Peshawar Zalmi','#FFD700','#000000'),
  ('pindiz','psl','Pindiz','#C0C0C0','#003893'),
  ('quetta-gladiators','psl','Quetta Gladiators','#6A0032','#FFD700'),
  ('sialkot-stallionz','psl','Sialkot Stallionz','#000000','#C0C0C0')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
