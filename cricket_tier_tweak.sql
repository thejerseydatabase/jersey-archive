-- Moves Sheffield Shield and Dean Jones Trophy into "More competitions"
-- in cricket. Safe to re-run.

update competitions set tier = 'more' where slug in ('australia-domestic', 'dean-jones-cup');
