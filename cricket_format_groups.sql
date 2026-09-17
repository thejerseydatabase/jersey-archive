-- Tags every team in international cricket with which formats it plays,
-- so the competition page can split the team grid into Test/ODI/T20I
-- sections instead of one long alphabetical list (where something like
-- the USA gets buried a long scroll away from Australia). Every team
-- defaults to T20I (virtually every cricket nation has that status now),
-- then the smaller Test and ODI nations get upgraded. Safe to re-run.

alter table teams add column if not exists formats text[];

-- Men's
update teams set formats = array['T20I']
  where competition_slug = 'international' and slug not like '%-women';

update teams set formats = array['Test','ODI','T20I']
  where competition_slug = 'international' and slug in (
    'australia','south-africa','new-zealand','india','england',
    'bangladesh','sri-lanka','west-indies','pakistan','zimbabwe'
  );

update teams set formats = array['ODI','T20I']
  where competition_slug = 'international' and slug in (
    'afghanistan','ireland','scotland','netherlands','united-states',
    'namibia','nepal','oman','united-arab-emirates','canada'
  );

-- Women's
update teams set formats = array['T20I']
  where competition_slug = 'international' and slug like '%-women';

update teams set formats = array['Test','ODI','T20I']
  where competition_slug = 'international' and slug in (
    'australia-women','england-women','new-zealand-women','south-africa-women',
    'west-indies-women','india-women','pakistan-women','sri-lanka-women',
    'ireland-women','netherlands-women'
  );

update teams set formats = array['ODI','T20I']
  where competition_slug = 'international' and slug in (
    'bangladesh-women','scotland-women','thailand-women','zimbabwe-women',
    'united-arab-emirates-women','papua-new-guinea-women'
  );
