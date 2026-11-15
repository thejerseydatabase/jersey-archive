-- London Welsh's 2003-04 season was actually National Division One (now
-- called RFU Championship on this site), not National Division 5 -
-- confirmed on https://en.wikipedia.org/wiki/2003%E2%80%9304_National_Division_One
--
-- Creates a separate London Welsh team row under RFU Championship (same
-- pattern used everywhere else on the site - one team row per
-- competition, not one shared across every division a club has ever
-- played in) and moves just the 2003-04 jerseys onto it, leaving the
-- National Division 5 team/row untouched for whichever other season(s)
-- actually belong there.
--
-- Safe to re-run.

insert into teams (slug, competition_slug, name)
select 'london-welsh', 'rfu-championship', 'London Welsh'
where not exists (select 1 from teams where slug = 'london-welsh' and competition_slug = 'rfu-championship');

update jerseys
set team_id = (select id from teams where slug = 'london-welsh' and competition_slug = 'rfu-championship'),
    competition_slug = 'rfu-championship'
where season = '2003-04'
  and competition_slug = 'national-division-5'
  and team_id = (select id from teams where slug = 'london-welsh' and competition_slug = 'national-division-5');
