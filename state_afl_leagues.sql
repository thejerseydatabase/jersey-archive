-- Adds nine state/territory-level Australian football competitions under
-- the existing AFL sport, each "more"-tier and tagged region_group =
-- 'Australia' (matching VFL's existing tag — with every "more" AFL comp
-- being Australian anyway, that one bucket is really just "everything
-- below the AFL/AFLW top tier", same as VFL already sits in).
--
-- Team colors are left at the default swatch throughout — this is ~140
-- clubs across nine leagues and I don't have confident official colors
-- for the large majority of them (a lot are suburban/country clubs with
-- no strong web presence). Happy to fill specific ones in on request.
--
-- Two scope notes:
--   1. AFL Sydney's "Former clubs" list (~40 entries, mostly long-defunct
--      suburban/military sides from many decades ago) is NOT included
--      here — its current 22 clubs are. Say the word if you want the
--      former list added too.
--   2. NTFA and AFL Canberra each run multiple grades/divisions (and, for
--      NTFA, separate men's and women's competitions) under one overall
--      competition name — these use the same `conference` grouping
--      NBL1 uses for its regional conferences, just repurposed here for
--      division/grade instead of geography. Where a men's and women's
--      side share a club name (NTFA), the women's entry gets a distinct
--      slug (suffixed -w) so both can exist side by side; the display
--      name is left the same since the conference label already says
--      "Women's ...".
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier, region_group) values
  ('sanfl','afl','SANFL','more','Australia'),
  ('wafl','afl','WAFL','more','Australia'),
  ('sfl-tas','afl','Southern Football League (Tasmania)','more','Australia'),
  ('ntfa','afl','Northern Tasmanian Football Association','more','Australia'),
  ('nwfl-tas','afl','North West Football League (Tasmania)','more','Australia'),
  ('ntfl','afl','Northern Territory Football League','more','Australia'),
  ('qafl','afl','QAFL','more','Australia'),
  ('afl-sydney','afl','AFL Sydney','more','Australia'),
  ('afl-canberra','afl','AFL Canberra','more','Australia')
on conflict (slug) do nothing;

-- ============ SANFL (South Australia) ============
insert into teams (slug, competition_slug, name, history_note) values
  ('adelaide','sanfl','Adelaide',null),
  ('central-district','sanfl','Central District',null),
  ('glenelg','sanfl','Glenelg',null),
  ('north-adelaide','sanfl','North Adelaide',null),
  ('norwood','sanfl','Norwood',null),
  ('port-adelaide','sanfl','Port Adelaide',null),
  ('south-adelaide','sanfl','South Adelaide',null),
  ('sturt','sanfl','Sturt',null),
  ('west-adelaide','sanfl','West Adelaide',null),
  ('woodville-west-torrens','sanfl','Woodville-West Torrens',null)
on conflict (competition_slug, slug) do nothing;
update teams set history_note = 'AFL reserves affiliate of Adelaide Football Club.' where competition_slug = 'sanfl' and slug = 'adelaide';
update teams set history_note = 'AFL reserves affiliate of Port Adelaide Football Club.' where competition_slug = 'sanfl' and slug = 'port-adelaide';

-- ============ WAFL (Western Australia) ============
insert into teams (slug, competition_slug, name) values
  ('claremont','wafl','Claremont'),
  ('east-fremantle','wafl','East Fremantle'),
  ('east-perth','wafl','East Perth'),
  ('peel','wafl','Peel'),
  ('perth','wafl','Perth'),
  ('south-fremantle','wafl','South Fremantle'),
  ('subiaco','wafl','Subiaco'),
  ('swan-districts','wafl','Swan Districts'),
  ('west-coast','wafl','West Coast'),
  ('west-perth','wafl','West Perth')
on conflict (competition_slug, slug) do nothing;
update teams set history_note = 'AFL affiliate of Fremantle.' where competition_slug = 'wafl' and slug = 'peel';
update teams set history_note = 'AFL reserves affiliate of West Coast Eagles.' where competition_slug = 'wafl' and slug = 'west-coast';

-- ============ Southern Football League (Tasmania) ============
insert into teams (slug, competition_slug, name, history_note) values
  ('brighton','sfl-tas','Brighton',null),
  ('clarence','sfl-tas','Clarence',null),
  ('glenorchy','sfl-tas','Glenorchy',null),
  ('kingborough','sfl-tas','Kingborough',null),
  ('lauderdale','sfl-tas','Lauderdale',null),
  ('north-hobart','sfl-tas','North Hobart','Known as Hobart Demons from 1996 to 2003.')
on conflict (competition_slug, slug) do nothing;

-- ============ Northern Tasmanian Football Association ============
-- Men's grades
insert into teams (slug, competition_slug, name, conference) values
  ('ntfa-deloraine','ntfa','Deloraine','Men''s Premier Division'),
  ('ntfa-launceston','ntfa','Launceston','Men''s Premier Division'),
  ('ntfa-longford','ntfa','Longford','Men''s Premier Division'),
  ('ntfa-north-launceston','ntfa','North Launceston','Men''s Premier Division'),
  ('ntfa-scottsdale','ntfa','Scottsdale','Men''s Premier Division'),
  ('ntfa-south-launceston','ntfa','South Launceston','Men''s Premier Division'),
  ('ntfa-bracknell','ntfa','Bracknell','Men''s Division 1'),
  ('ntfa-bridgenorth','ntfa','Bridgenorth','Men''s Division 1'),
  ('ntfa-george-town','ntfa','George Town','Men''s Division 1'),
  ('ntfa-hillwood','ntfa','Hillwood','Men''s Division 1'),
  ('ntfa-lilydale','ntfa','Lilydale','Men''s Division 1'),
  ('ntfa-old-launcestonians','ntfa','Old Launcestonians','Men''s Division 1'),
  ('ntfa-old-scotch-collegians','ntfa','Old Scotch Collegians','Men''s Division 1'),
  ('ntfa-rocherlea','ntfa','Rocherlea','Men''s Division 1'),
  ('ntfa-st-patricks-old-collegians','ntfa','St Patrick''s Old Collegians','Men''s Division 1'),
  ('ntfa-bridport','ntfa','Bridport','Men''s Division 2'),
  ('ntfa-campbell-town','ntfa','Campbell Town','Men''s Division 2'),
  ('ntfa-east-coast-swans','ntfa','East Coast Swans','Men''s Division 2'),
  ('ntfa-evandale','ntfa','Evandale','Men''s Division 2'),
  ('ntfa-meander-valley','ntfa','Meander Valley','Men''s Division 2'),
  ('ntfa-perth','ntfa','Perth','Men''s Division 2'),
  ('ntfa-university-of-tasmania','ntfa','University of Tasmania','Men''s Division 2')
on conflict (competition_slug, slug) do nothing;
-- Women's grades — distinct slugs (suffixed -w) so a club with both a
-- men's and women's side can have both rows; display name stays plain
-- since the conference label already says "Women's ...".
insert into teams (slug, competition_slug, name, conference) values
  ('ntfa-deloraine-w','ntfa','Deloraine','Women''s Premier Division'),
  ('ntfa-launceston-w','ntfa','Launceston','Women''s Premier Division'),
  ('ntfa-longford-w','ntfa','Longford','Women''s Premier Division'),
  ('ntfa-north-launceston-w','ntfa','North Launceston','Women''s Premier Division'),
  ('ntfa-scottsdale-w','ntfa','Scottsdale','Women''s Premier Division'),
  ('ntfa-south-launceston-w','ntfa','South Launceston','Women''s Premier Division'),
  ('ntfa-bridgenorth-w','ntfa','Bridgenorth','Women''s Division 1'),
  ('ntfa-george-town-w','ntfa','George Town','Women''s Division 1'),
  ('ntfa-hillwood-w','ntfa','Hillwood','Women''s Division 1'),
  ('ntfa-meander-valley-w','ntfa','Meander Valley','Women''s Division 1'),
  ('ntfa-old-launcestonians-w','ntfa','Old Launcestonians','Women''s Division 1'),
  ('ntfa-old-scotch-collegians-w','ntfa','Old Scotch Collegians','Women''s Division 1'),
  ('ntfa-st-patricks-old-collegians-w','ntfa','St Patrick''s Old Collegians','Women''s Division 1')
on conflict (competition_slug, slug) do nothing;
-- Former clubs
insert into teams (slug, competition_slug, name, is_active) values
  ('ntfa-cressy','ntfa','Cressy',false),
  ('ntfa-fingal-valley','ntfa','Fingal Valley',false),
  ('ntfa-hagley','ntfa','Hagley',false),
  ('ntfa-northern-districts','ntfa','Northern Districts',false),
  ('ntfa-prospect-hawks','ntfa','Prospect Hawks',false),
  ('ntfa-st-marys','ntfa','St Marys',false),
  ('ntfa-tamar-cats','ntfa','Tamar Cats',false)
on conflict (competition_slug, slug) do update set is_active = excluded.is_active;

-- ============ North West Football League (Tasmania) ============
insert into teams (slug, competition_slug, name) values
  ('burnie','nwfl-tas','Burnie'),
  ('circular-head','nwfl-tas','Circular Head'),
  ('devonport','nwfl-tas','Devonport'),
  ('east-devonport','nwfl-tas','East Devonport'),
  ('latrobe','nwfl-tas','Latrobe'),
  ('penguin','nwfl-tas','Penguin'),
  ('ulverstone','nwfl-tas','Ulverstone'),
  ('wynyard','nwfl-tas','Wynyard')
on conflict (competition_slug, slug) do nothing;
insert into teams (slug, competition_slug, name, history_note) values
  ('east-ulverstone','nwfl-tas','East Ulverstone','Juniors competition only.'),
  ('somerset','nwfl-tas','Somerset','Juniors competition only.')
on conflict (competition_slug, slug) do nothing;
insert into teams (slug, competition_slug, name, is_active) values
  ('nwfl-deloraine','nwfl-tas','Deloraine',false),
  ('nwfl-george-town','nwfl-tas','George Town',false),
  ('nwfl-launceston','nwfl-tas','Launceston',false),
  ('nwfl-longford','nwfl-tas','Longford',false),
  ('nwfl-north-launceston','nwfl-tas','North Launceston',false),
  ('nwfl-scottsdale','nwfl-tas','Scottsdale',false),
  ('south-burnie','nwfl-tas','South Burnie',false),
  ('nwfl-south-launceston','nwfl-tas','South Launceston',false)
on conflict (competition_slug, slug) do update set is_active = excluded.is_active;

-- ============ Northern Territory Football League ============
insert into teams (slug, competition_slug, name) values
  ('banks','ntfl','Banks'),
  ('darwin','ntfl','Darwin'),
  ('jabiru','ntfl','Jabiru'),
  ('nightcliff','ntfl','Nightcliff'),
  ('palmerston','ntfl','Palmerston'),
  ('pint','ntfl','PINT'),
  ('southern-districts','ntfl','Southern Districts'),
  ('st-marys-ntfl','ntfl','St Mary''s'),
  ('tiwi','ntfl','Tiwi'),
  ('tracy-village','ntfl','Tracy Village'),
  ('wanderers','ntfl','Wanderers'),
  ('waratah','ntfl','Waratah')
on conflict (competition_slug, slug) do nothing;
insert into teams (slug, competition_slug, name, is_active) values
  ('aif-regiment-artillery','ntfl','AIF Regiment-Artillery',false),
  ('air-force','ntfl','Air Force',false),
  ('army-navy','ntfl','Army/Navy',false),
  ('army-air-force','ntfl','Army/Air Force',false),
  ('garrison','ntfl','Garrison',false),
  ('katherine','ntfl','Katherine',false),
  ('machine-gunners','ntfl','Machine Gunners',false),
  ('mobile-force','ntfl','Mobile Force',false),
  ('navy','ntfl','Navy',false),
  ('rovers-magpies','ntfl','Rovers/Magpies',false),
  ('services','ntfl','Services',false),
  ('wallabies-ntfl','ntfl','Wallabies',false),
  ('winnellie','ntfl','Winnellie',false)
on conflict (competition_slug, slug) do update set is_active = excluded.is_active;

-- ============ QAFL (Queensland) ============
insert into teams (slug, competition_slug, name) values
  ('aspley','qafl','Aspley'),
  ('broadbeach','qafl','Broadbeach'),
  ('coorparoo','qafl','Coorparoo'),
  ('labrador','qafl','Labrador'),
  ('maroochydore','qafl','Maroochydore'),
  ('morningside','qafl','Morningside'),
  ('mount-gravatt','qafl','Mount Gravatt'),
  ('noosa','qafl','Noosa'),
  ('palm-beach-currumbin','qafl','Palm Beach Currumbin'),
  ('redland-victoria-point','qafl','Redland-Victoria Point'),
  ('sherwood-districts','qafl','Sherwood Districts'),
  ('surfers-paradise','qafl','Surfers Paradise'),
  ('wilston-grange','qafl','Wilston Grange')
on conflict (competition_slug, slug) do nothing;

-- ============ AFL Sydney (current clubs only — see note above) ============
insert into teams (slug, competition_slug, name, history_note) values
  ('balmain','afl-sydney','Balmain',null),
  ('camden','afl-sydney','Camden',null),
  ('east-coast','afl-sydney','East Coast','Known as Baulkham Hills from 1976 to 1999, and Sydney Hills from 2012 to 2014.'),
  ('hawkesbury-jets','afl-sydney','Hawkesbury Jets','Known as Norwest Jets from 2001 to 2021.'),
  ('inner-west','afl-sydney','Inner West','Known as Western Suburbs from 1926 to 2016.'),
  ('manly-warringah','afl-sydney','Manly-Warringah',null),
  ('macquarie-university','afl-sydney','Macquarie University',null),
  ('newtown-afl-sydney','afl-sydney','Newtown',null),
  ('north-shore','afl-sydney','North Shore',null),
  ('parramatta-afl-sydney','afl-sydney','Parramatta','Known as Holroyd-Parramatta from 1983 to 2019.'),
  ('pennant-hills','afl-sydney','Pennant Hills',null),
  ('penrith-afl-sydney','afl-sydney','Penrith',null),
  ('randwick-city','afl-sydney','Randwick City','Known as Saints AFC from 2010 to 2011.'),
  ('south-west-sydney','afl-sydney','South West Sydney',null),
  ('southern-dingoes','afl-sydney','Southern Dingoes',null),
  ('southern-power','afl-sydney','Southern Power','Known as Sutherland from 1972 to 1993, Cronulla-Sutherland from 1994 to 1999, and Southern Sharks from 2000 to 2008.'),
  ('st-george-afl-sydney','afl-sydney','St George',null),
  ('sydney-university','afl-sydney','Sydney University',null),
  ('unsw-eastern-suburbs','afl-sydney','UNSW-Eastern Suburbs',null),
  ('uts','afl-sydney','UTS',null),
  ('western-magic','afl-sydney','Western Magic','Known as Blacktown from 2012 to 2015.'),
  ('wollondilly','afl-sydney','Wollondilly',null)
on conflict (competition_slug, slug) do nothing;

-- ============ AFL Canberra ============
insert into teams (slug, competition_slug, name, conference, history_note) values
  ('ainslie','afl-canberra','Ainslie','First Grade & Second Grade',null),
  ('batemans-bay','afl-canberra','Batemans Bay','First Grade & Second Grade',null),
  ('belconnen','afl-canberra','Belconnen','First Grade & Second Grade',null),
  ('eastlake','afl-canberra','Eastlake','First Grade & Second Grade','Known as Southern District from 1991 to 1995.'),
  ('gungahlin','afl-canberra','Gungahlin','First Grade & Second Grade',null),
  ('queanbeyan','afl-canberra','Queanbeyan','First Grade & Second Grade',null),
  ('tuggeranong-valley','afl-canberra','Tuggeranong Valley','First Grade & Second Grade','Known as Sutherland from 1977 to 1982.'),
  ('adfa','afl-canberra','ADFA','Community Division 1','Known as Defence Academy from 1987 to 1997.'),
  ('anu','afl-canberra','ANU','Community Division 1',null),
  ('googong','afl-canberra','Googong','Community Division 1','Known as Harman from 1976 to 2015.'),
  ('goulburn','afl-canberra','Goulburn','Community Division 1',null),
  ('woden','afl-canberra','Woden','Community Division 1',null),
  ('yass','afl-canberra','Yass','Community Division 1',null),
  ('cootamundra','afl-canberra','Cootamundra','Community Division 2',null),
  ('molonglo','afl-canberra','Molonglo','Community Division 2','Known as Murrumbidgee from 1994 to 2013.'),
  ('murrumbateman','afl-canberra','Murrumbateman','Community Division 2',null),
  ('southern-cats','afl-canberra','Southern Cats','Community Division 2','Known as Cooma from 1976 to 2015.')
on conflict (competition_slug, slug) do nothing;
