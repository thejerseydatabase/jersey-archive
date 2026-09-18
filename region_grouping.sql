-- Adds a region_group column to competitions, used to sort the "More
-- competitions" section by country (alphabetised, competitions within
-- each country alphabetised too) instead of one flat A-Z list — so
-- "ARL" no longer sits at the top and "Super League" at the bottom
-- with a dozen unrelated countries' competitions in between. Anything
-- left untagged just falls into an "Other" group at the end, so this
-- is safe for every other sport too (no visual change there until you
-- ask me to tag them).
--
-- Populated here for rugby league and football's "more" tier
-- competitions (everything currently in that section for both sports).
--
-- Also moves "Representative" (State of Origin etc. representative
-- teams) up into the main competitions row — it's a group of teams,
-- not a real competition, so it doesn't belong hidden under "More".
-- Safe to re-run.

alter table competitions add column if not exists region_group text;

update competitions set tier = 'top' where slug = 'representative';

-- ============ Rugby league ============
update competitions set region_group = 'Australia' where slug in (
  'nswrl','arl','super-league-1997','brisbane-rugby-league',
  'warl-first-grade','newcastle-rugby-league','nrl-northern-territory',
  'ron-massey-cup','qld-south-east-division','bsdrl',
  'championship','nsw-cup','qld-cup'
);
update competitions set region_group = 'France' where slug in ('super-xiii','elite-2');
update competitions set region_group = 'England' where slug in (
  'rfl-league-one','national-premier-league','national-league-one',
  'super-league-women','championship-women'
);
update competitions set region_group = 'Ireland' where slug = 'rli-premiership';
update competitions set region_group = 'Netherlands' where slug = 'nrlb-championship';
update competitions set region_group = 'Norway' where slug = 'rugby-league-norway';
update competitions set region_group = 'Serbia' where slug = 'serbian-rugby-league-championship';
update competitions set region_group = 'Fiji' where slug = 'fiji-vodafone-cup';
update competitions set region_group = 'New Zealand' where slug = 'nzrl-national-competition';
update competitions set region_group = 'Papua New Guinea' where slug = 'png-digicel-cup';
update competitions set region_group = 'Philippines' where slug = 'philippines-champions-shield';
update competitions set region_group = 'Nigeria' where slug = 'nigeria-rugby-league';
update competitions set region_group = 'South Africa' where slug = 'rhino-cup';
update competitions set region_group = 'USA' where slug in ('usarl','utah-rugby-league');

-- ============ Football ============
update competitions set region_group = 'England' where slug in (
  'efl-championship','wsl','national-league','national-league-north',
  'national-league-south','league-one','league-two'
);
update competitions set region_group = 'Germany' where slug = 'bundesliga-2';
update competitions set region_group = 'Italy' where slug = 'serie-b';
update competitions set region_group = 'Brazil' where slug = 'brasileirao';
update competitions set region_group = 'France' where slug in ('ligue-1','ligue-2');
update competitions set region_group = 'Argentina' where slug = 'liga-profesional-argentina';
update competitions set region_group = 'Turkey' where slug = 'super-lig';
update competitions set region_group = 'Mexico' where slug = 'liga-mx';
update competitions set region_group = 'Netherlands' where slug = 'eredivisie';
update competitions set region_group = 'Spain' where slug = 'la-liga-2';
update competitions set region_group = 'Portugal' where slug = 'liga-portugal';
update competitions set region_group = 'Belgium' where slug = 'belgian-pro-league';
update competitions set region_group = 'Denmark' where slug = 'danish-superliga';
update competitions set region_group = 'Greece' where slug = 'super-league-greece';
update competitions set region_group = 'Ireland' where slug = 'league-of-ireland-first-division';
update competitions set region_group = 'Scotland' where slug = 'scottish-premiership';
update competitions set region_group = 'Switzerland' where slug = 'swiss-super-league';
update competitions set region_group = 'China' where slug = 'chinese-super-league';
update competitions set region_group = 'Japan' where slug in ('j1-league','j2-league');
update competitions set region_group = 'India' where slug = 'indian-super-league';
update competitions set region_group = 'USA' where slug in ('usl-championship','usl-league-one');
update competitions set region_group = 'Australia' where slug in (
  'nsl','npl-act','npl-nsw','npl-northern-nsw','npl-queensland',
  'npl-south-australia','npl-tasmania','npl-victoria','npl-western-australia'
);
