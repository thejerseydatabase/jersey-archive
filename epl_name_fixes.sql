-- Renames Premier League clubs to match the exact names on your reference
-- list (some carry "FC"/"AFC" where I'd shortened them). Safe to re-run.

update teams set name = 'Arsenal FC' where competition_slug='premier-league' and slug='arsenal';
update teams set name = 'Brentford FC' where competition_slug='premier-league' and slug='brentford';
update teams set name = 'Chelsea FC' where competition_slug='premier-league' and slug='chelsea';
update teams set name = 'Everton FC' where competition_slug='premier-league' and slug='everton';
update teams set name = 'Fulham FC' where competition_slug='premier-league' and slug='fulham';
update teams set name = 'Hull City AFC' where competition_slug='premier-league' and slug='hull-city';
update teams set name = 'Liverpool FC' where competition_slug='premier-league' and slug='liverpool';
update teams set name = 'Sunderland AFC' where competition_slug='premier-league' and slug='sunderland';
