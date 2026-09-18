-- Adds a `conference` column to teams (nullable — only used where a
-- competition is itself split into regional conferences; nothing else
-- currently uses it) and adds NBL1, Australia's semi-pro second-tier
-- basketball league, as a new "more"-tier competition under the existing
-- basketball sport, with its current clubs tagged into their real
-- conference (North = Queensland, Central = South Australia & Northern
-- Territory, South = Victoria & Tasmania, West = Western Australia).
--
-- Team colors are left at the default swatch rather than guessed — there
-- are 63 clubs here and I don't have reliable official colors for most
-- of them; happy to fill any of them in on request.
--
-- Safe to re-run.

alter table teams add column if not exists conference text;

insert into competitions (slug, sport_slug, name, tier) values
  ('nbl1','basketball','NBL1','more')
on conflict (slug) do nothing;

-- ============ North Conference (Queensland) ============
insert into teams (slug, competition_slug, name, conference) values
  ('brisbane-capitals','nbl1','Brisbane Capitals','North'),
  ('cairns-dolphins','nbl1','Cairns Dolphins','North'),
  ('cairns-marlins','nbl1','Cairns Marlins','North'),
  ('gold-coast-rollers','nbl1','Gold Coast Rollers','North'),
  ('ipswich-force','nbl1','Ipswich Force','North'),
  ('logan-thunder','nbl1','Logan Thunder','North'),
  ('mackay-meteorettes','nbl1','Mackay Meteorettes','North'),
  ('mackay-meteors','nbl1','Mackay Meteors','North'),
  ('northside-wizards','nbl1','Northside Wizards','North'),
  ('rockhampton-cyclones','nbl1','Rockhampton Cyclones','North'),
  ('rockhampton-rockets','nbl1','Rockhampton Rockets','North'),
  ('southern-districts-spartans','nbl1','Southern Districts Spartans','North'),
  ('south-west-metro-pirates','nbl1','South West Metro Pirates','North'),
  ('sunshine-coast-phoenix','nbl1','Sunshine Coast Phoenix','North'),
  ('townsville-flames','nbl1','Townsville Flames','North'),
  ('townsville-heat','nbl1','Townsville Heat','North'),
  ('usc-rip-city','nbl1','USC Rip City','North')
on conflict (competition_slug, slug) do update set conference = excluded.conference;

-- ============ Central Conference (South Australia & Northern Territory) ============
insert into teams (slug, competition_slug, name, conference) values
  ('central-districts-lions','nbl1','Central Districts Lions','Central'),
  ('darwin-salties','nbl1','Darwin Salties','Central'),
  ('eastern-mavericks','nbl1','Eastern Mavericks','Central'),
  ('forestville-eagles','nbl1','Forestville Eagles','Central'),
  ('mount-gambier-pioneers','nbl1','Mount Gambier Pioneers','Central'),
  ('north-adelaide-rockets','nbl1','North Adelaide Rockets','Central'),
  ('norwood-flames','nbl1','Norwood Flames','Central'),
  ('south-adelaide-panthers','nbl1','South Adelaide Panthers','Central'),
  ('southern-tigers','nbl1','Southern Tigers','Central'),
  ('sturt-sabres','nbl1','Sturt Sabres','Central'),
  ('west-adelaide-bearcats','nbl1','West Adelaide Bearcats','Central'),
  ('woodville-warriors','nbl1','Woodville Warriors','Central')
on conflict (competition_slug, slug) do update set conference = excluded.conference;

-- ============ South Conference (Victoria & Tasmania) ============
insert into teams (slug, competition_slug, name, conference) values
  ('albury-wodonga-bandits','nbl1','Albury Wodonga Bandits','South'),
  ('ballarat-rush','nbl1','Ballarat Rush','South'),
  ('ballarat-miners','nbl1','Ballarat Miners','South'),
  ('bendigo-braves','nbl1','Bendigo Braves','South'),
  ('dandenong-rangers','nbl1','Dandenong Rangers','South'),
  ('diamond-valley-eagles','nbl1','Diamond Valley Eagles','South'),
  ('eltham-wildcats','nbl1','Eltham Wildcats','South'),
  ('frankston-blues','nbl1','Frankston Blues','South'),
  ('geelong-supercats','nbl1','Geelong Supercats','South'),
  ('hobart-chargers','nbl1','Hobart Chargers','South'),
  ('kilsyth-cobras','nbl1','Kilsyth Cobras','South'),
  ('knox-raiders','nbl1','Knox Raiders','South'),
  ('launceston-tornadoes','nbl1','Launceston Tornadoes','South'),
  ('melbourne-tigers','nbl1','Melbourne Tigers','South'),
  ('north-west-tasmania-thunder','nbl1','North-West Tasmania Thunder','South'),
  ('nunawading-spectres','nbl1','Nunawading Spectres','South'),
  ('redcity-roar','nbl1','RedCity Roar','South'),
  ('ringwood-hawks','nbl1','Ringwood Hawks','South'),
  ('sandringham-sabres','nbl1','Sandringham Sabres','South'),
  ('waverley-falcons','nbl1','Waverley Falcons','South')
on conflict (competition_slug, slug) do update set conference = excluded.conference;

-- ============ West Conference (Western Australia) ============
insert into teams (slug, competition_slug, name, conference) values
  ('cockburn-cougars','nbl1','Cockburn Cougars','West'),
  ('east-perth-eagles','nbl1','East Perth Eagles','West'),
  ('geraldton-buccaneers','nbl1','Geraldton Buccaneers','West'),
  ('goldfields-giants','nbl1','Goldfields Giants','West'),
  ('joondalup-wolves','nbl1','Joondalup Wolves','West'),
  ('kalamunda-eastern-suns','nbl1','Kalamunda Eastern Suns','West'),
  ('lakeside-lightning','nbl1','Lakeside Lightning','West'),
  ('mandurah-magic','nbl1','Mandurah Magic','West'),
  ('perry-lakes-hawks','nbl1','Perry Lakes Hawks','West'),
  ('perth-redbacks','nbl1','Perth Redbacks','West'),
  ('rockingham-flames','nbl1','Rockingham Flames','West'),
  ('south-west-slammers','nbl1','South West Slammers','West'),
  ('warwick-senators','nbl1','Warwick Senators','West'),
  ('willetton-tigers','nbl1','Willetton Tigers','West')
on conflict (competition_slug, slug) do update set conference = excluded.conference;
