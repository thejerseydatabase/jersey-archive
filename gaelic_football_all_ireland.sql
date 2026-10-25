-- Adds the All-Ireland Senior Football Championship (the flagship Gaelic
-- football competition) and its current teams: the 32 Irish counties
-- plus London and New York, who also compete in it.
--
-- Source: https://iomanaiocht.fandom.com/wiki/Teams_in_the_All-Ireland_Senior_Football_Championship
-- That page's "Colours of X" labels don't match the rows they're in (a
-- template bug on the wiki itself - e.g. Cavan's row is labelled
-- "Colours of Laois"), but the actual color text after the label checks
-- out against each county's real GAA colors, so that's what's used here.
-- Also drops a stray "Kieran O'Leary / 2014" row from the source table -
-- a footnote reference, not a team.
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('all-ireland-senior-football-championship','gaelic-football','All-Ireland Senior Football Championship','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('antrim','all-ireland-senior-football-championship','Antrim','#F4C430','#FFFFFF'),
  ('armagh','all-ireland-senior-football-championship','Armagh','#FF7900','#FFFFFF'),
  ('carlow','all-ireland-senior-football-championship','Carlow','#C8102E','#006341'),
  ('cavan','all-ireland-senior-football-championship','Cavan','#0033A0','#FFFFFF'),
  ('clare','all-ireland-senior-football-championship','Clare','#F4C430','#004C97'),
  ('cork','all-ireland-senior-football-championship','Cork','#C8102E','#FFFFFF'),
  ('derry','all-ireland-senior-football-championship','Derry','#C8102E','#FFFFFF'),
  ('donegal','all-ireland-senior-football-championship','Donegal','#FFD700','#006341'),
  ('down','all-ireland-senior-football-championship','Down','#C8102E','#000000'),
  ('dublin','all-ireland-senior-football-championship','Dublin','#0F7FC2','#002D72'),
  ('fermanagh','all-ireland-senior-football-championship','Fermanagh','#00703C','#FFFFFF'),
  ('galway','all-ireland-senior-football-championship','Galway','#7B0828','#FFFFFF'),
  ('kerry','all-ireland-senior-football-championship','Kerry','#00703C','#FFD700'),
  ('kildare','all-ireland-senior-football-championship','Kildare','#FFFFFF','#C8102E'),
  ('laois','all-ireland-senior-football-championship','Laois','#004C97','#FFFFFF'),
  ('leitrim','all-ireland-senior-football-championship','Leitrim','#00703C','#FFD700'),
  ('london','all-ireland-senior-football-championship','London','#00703C','#FFFFFF'),
  ('limerick','all-ireland-senior-football-championship','Limerick','#00703C','#FFFFFF'),
  ('longford','all-ireland-senior-football-championship','Longford','#0033A0','#FFD700'),
  ('louth','all-ireland-senior-football-championship','Louth','#C8102E','#FFFFFF'),
  ('mayo','all-ireland-senior-football-championship','Mayo','#00703C','#C8102E'),
  ('meath','all-ireland-senior-football-championship','Meath','#00703C','#FFD700'),
  ('monaghan','all-ireland-senior-football-championship','Monaghan','#FFFFFF','#004C97'),
  ('new-york','all-ireland-senior-football-championship','New York','#C8102E','#004C97'),
  ('offaly','all-ireland-senior-football-championship','Offaly','#FFFFFF','#00703C'),
  ('roscommon','all-ireland-senior-football-championship','Roscommon','#F6E27A','#004C97'),
  ('sligo','all-ireland-senior-football-championship','Sligo','#000000','#FFFFFF'),
  ('tipperary','all-ireland-senior-football-championship','Tipperary','#004C97','#FFD700'),
  ('tyrone','all-ireland-senior-football-championship','Tyrone','#FFFFFF','#C8102E'),
  ('waterford','all-ireland-senior-football-championship','Waterford','#FFFFFF','#004C97'),
  ('westmeath','all-ireland-senior-football-championship','Westmeath','#7B0828','#FFFFFF'),
  ('wexford','all-ireland-senior-football-championship','Wexford','#6A1B9A','#FFD700'),
  ('wicklow','all-ireland-senior-football-championship','Wicklow','#004C97','#FFD700')
on conflict (competition_slug, slug) do nothing;
