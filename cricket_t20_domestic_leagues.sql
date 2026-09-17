-- Big batch of T20 domestic cricket: fixes a few names already on the
-- site (a typo, an official rename, a competition that had the wrong
-- generic name), adds teams to competitions that already exist, and adds
-- several new competitions entirely. BBL/WBBL untouched, as requested.
--
-- Where a franchise has genuinely rebranded over time (BPL, CPL, LPL
-- teams especially — these leagues rename sponsors/franchises often),
-- the old name is kept and the new one added alongside it, rather than
-- overwritten, so jerseys from that team's earlier era still have a
-- home — same approach used for every other renamed/relocated club on
-- this site. Plain typos and official one-time renames (Bangalore ->
-- Bengaluru, "Sunrises" -> "Sunrisers", "Pindiz" -> "Rawalpindiz") are
-- fixed in place instead, since there's no earlier "correct" era to lose.
--
-- Safe to re-run throughout.

-- ============ IPL: fix a typo + an official rename, add defunct teams ============
update teams set name = 'Sunrisers Hyderabad' where competition_slug = 'ipl' and slug = 'sunrises-hyderabad';
update teams set name = 'Royal Challengers Bengaluru' where competition_slug = 'ipl' and slug = 'royal-challengers-bangalore';

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('deccan-chargers','ipl','Deccan Chargers','#5C2D91','#FFD700',false),
  ('kochi-tuskers-kerala','ipl','Kochi Tuskers Kerala','#FF8200','#000000',false),
  ('pune-warriors-india','ipl','Pune Warriors India','#5C2D91','#FFFFFF',false),
  ('rising-pune-supergiant','ipl','Rising Pune Supergiant','#CE1126','#5C2D91',false),
  ('gujarat-lions','ipl','Gujarat Lions','#FF8200','#003893',false)
on conflict (competition_slug, slug) do nothing;

-- ============ PSL: fix a typo ============
update teams set name = 'Rawalpindiz' where competition_slug = 'psl' and slug = 'pindiz';

-- ============ BPL: add current franchise names alongside earlier ones ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('chattogram-royals','bpl','Chattogram Royals','#5C2D91','#FFD700'),
  ('sylhet-titans','bpl','Sylhet Titans','#00843D','#003893'),
  ('rajshahi-warriors','bpl','Rajshahi Warriors','#006A4E','#FFFFFF'),
  ('noakhali-express','bpl','Noakhali Express','#F57F17','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ CPL: add a couple of missing current/former teams ============
update teams set name = 'Saint Lucia Kings' where competition_slug = 'cpl' and slug = 'st-lucia-kings';

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('jamaica-kingsmen','cpl','Jamaica Kingsmen','#FED100','#009B3A',true),
  ('barbados-tridents','cpl','Barbados Tridents','#003893','#FFD700',false),
  ('antigua-hawksbills','cpl','Antigua Hawksbills','#CE1126','#FFFFFF',false),
  ('jamaica-tallawahs','cpl','Jamaica Tallawahs','#5C2D91','#FED100',false)
on conflict (competition_slug, slug) do nothing;

-- ============ LPL: add current franchise names alongside earlier ones ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('galle-gallants','lpl','Galle Gallants','#5C2D91','#FFD700'),
  ('kandy-royals','lpl','Kandy Royals','#6A0032','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ Global T20 Canada: this is "canada-t20" under its real name ============
update competitions set name = 'Global T20 Canada' where slug = 'canada-t20';

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('edmonton-royals','canada-t20','Edmonton Royals','#5C2D91','#FFD700'),
  ('winnipeg-hawks','canada-t20','Winnipeg Hawks','#002664','#CE1126'),
  ('mississauga-panthers','canada-t20','Mississauga Panthers','#000000','#FFD700'),
  ('west-indies-b','canada-t20','West Indies B','#7B1113','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ Afghanistan Premier League: rename + add current squad ============
update competitions set name = 'Afghanistan Premier League' where slug = 'afghanistan-domestic';

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('akcel-united-kabul','afghanistan-domestic','Akcel United Kabul','#FFD700','#000000'),
  ('balkh-zwanan','afghanistan-domestic','Balkh Zwanan','#0033A0','#FFD700'),
  ('kandahar-warriors','afghanistan-domestic','Kandahar Warriors','#C0C0C0','#00205B'),
  ('paktia','afghanistan-domestic','Paktia','#000000','#00843D'),
  ('nangarhar','afghanistan-domestic','Nangarhar','#F57F17','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ Super Smash (NZ): rename the men's comp, merge women's in ============
update competitions set name = 'Super Smash' where slug = 'new-zealand-domestic';

update teams set name = replace(name, ' (W)', ' Women')
  where competition_slug = 'new-zealand-domestic-women';
update teams set competition_slug = 'new-zealand-domestic'
  where competition_slug = 'new-zealand-domestic-women';
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('northern-brave-women','new-zealand-domestic','Northern Brave Women','#F57F17','#000000')
on conflict (competition_slug, slug) do nothing;
delete from competitions where slug = 'new-zealand-domestic-women';

-- ============ WPL (India): fix naming, add the rest of the current squad ============
update teams set name = 'Gujarat Giants Women' where competition_slug = 'wpl' and slug = 'gujarat-giants-wpl';
update teams set name = 'UP Warriorz Women' where competition_slug = 'wpl' and slug = 'up-warriorz-wpl';

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('delhi-capitals-women','wpl','Delhi Capitals Women','#17479E','#EC1C24'),
  ('mumbai-indians-women','wpl','Mumbai Indians Women','#045093','#FFD700'),
  ('royal-challengers-bengaluru-women','wpl','Royal Challengers Bengaluru Women','#EC1C24','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ The Hundred (England): new, mixed men's/women's competition ============
insert into competitions (slug, sport_slug, name, tier) values
  ('the-hundred','cricket','The Hundred','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('birmingham-phoenix','the-hundred','Birmingham Phoenix','#6A0DAD','#000000'),
  ('london-spirit','the-hundred','London Spirit','#002664','#CE1126'),
  ('manchester-super-giants','the-hundred','Manchester Super Giants','#00B2A9','#EC5C29'),
  ('mi-london','the-hundred','MI London','#045093','#FFD700'),
  ('southern-brave','the-hundred','Southern Brave','#002664','#FFD700'),
  ('sunrisers-leeds','the-hundred','Sunrisers Leeds','#F26522','#000000'),
  ('trent-rockets','the-hundred','Trent Rockets','#5C2D91','#FFD700'),
  ('welsh-fire','the-hundred','Welsh Fire','#CE1126','#000000'),
  ('birmingham-phoenix-women','the-hundred','Birmingham Phoenix Women','#6A0DAD','#000000'),
  ('london-spirit-women','the-hundred','London Spirit Women','#002664','#CE1126'),
  ('manchester-super-giants-women','the-hundred','Manchester Super Giants Women','#00B2A9','#EC5C29'),
  ('mi-london-women','the-hundred','MI London Women','#045093','#FFD700'),
  ('southern-brave-women','the-hundred','Southern Brave Women','#002664','#FFD700'),
  ('sunrisers-leeds-women','the-hundred','Sunrisers Leeds Women','#F26522','#000000'),
  ('trent-rockets-women','the-hundred','Trent Rockets Women','#5C2D91','#FFD700'),
  ('welsh-fire-women','the-hundred','Welsh Fire Women','#CE1126','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ EUT20 Belgium: new competition ============
insert into competitions (slug, sport_slug, name, tier) values
  ('eut20-belgium','cricket','EUT20 Belgium','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('akcel-united-brussels','eut20-belgium','Akcel United Brussels','#FFD700','#000000'),
  ('antwerp-anchors','eut20-belgium','Antwerp Anchors','#002664','#FFD700'),
  ('ghent-gladiators','eut20-belgium','Ghent Gladiators','#000000','#FFD700'),
  ('jb-bruges','eut20-belgium','JB Bruges','#00843D','#FFFFFF'),
  ('liege-red-lions','eut20-belgium','Liège Red Lions','#CE1126','#000000'),
  ('royal-belge-waterloo','eut20-belgium','Royal Belge Waterloo','#5C2D91','#FFD700')
on conflict (competition_slug, slug) do nothing;

-- ============ European T20 Premier League (ETPL): new competition ============
insert into competitions (slug, sport_slug, name, tier) values
  ('etpl','cricket','European T20 Premier League','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('amsterdam-flames','etpl','Amsterdam Flames','#FF6C00','#000000'),
  ('belfast-wolves','etpl','Belfast Wolves','#002664','#CE1126'),
  ('dublin-guardians','etpl','Dublin Guardians','#169B62','#FFFFFF'),
  ('edinburgh-castle-rockers','etpl','Edinburgh Castle Rockers','#00205B','#FFFFFF'),
  ('glasgow-cosmic','etpl','Glasgow Cosmic','#5C2D91','#00AEEF'),
  ('rotterdam-dockers','etpl','Rotterdam Dockers','#CE1126','#000000')
on conflict (competition_slug, slug) do nothing;

-- ============ WCPL (Women's Caribbean Premier League): new competition ============
insert into competitions (slug, sport_slug, name, tier) values
  ('wcpl','cricket','Women''s Caribbean Premier League','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('barbados-tridents-women','wcpl','Barbados Tridents Women','#003893','#FFD700'),
  ('guyana-amazon-warriors-women','wcpl','Guyana Amazon Warriors Women','#00843D','#FFD700'),
  ('jamaica-empress','wcpl','Jamaica Empress','#5C2D91','#FED100'),
  ('trinbago-knight-riders-women','wcpl','Trinbago Knight Riders Women','#7B1113','#2E0854')
on conflict (competition_slug, slug) do nothing;
