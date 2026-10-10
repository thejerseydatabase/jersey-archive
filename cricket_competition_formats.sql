-- Adds a formats column to competitions (same text[] pattern already used
-- for teams.formats) so the upload form can filter the Competition picker
-- by the Format just chosen - picking ODI was offering every T20 league
-- in the list, which it shouldn't.
--
-- Only cricket gets anything tagged here, since FORMATS_BY_SPORT in
-- app.js is cricket-only today; every other sport's competitions stay
-- untagged (NULL), and the app treats an untagged competition as always
-- shown regardless of format, so this can't affect any other sport.
--
-- 'international' keeps all three international formats (bilateral
-- series are Test, ODI or T20I) rather than being restricted to one.
-- 'england-domestic' bundles the 18 first-class counties AND The
-- Hundred's franchises under one competition, so it gets both First
-- Class and T20. 'ireland-domestic' is left untagged on purpose - the
-- Interprovincial Championship/Cup/Trophy covers all three formats
-- across the same four teams and isn't split into separate competitions
-- here the way Australia's and England's domestic cricket is, so there's
-- no single correct format to restrict it to.
--
-- Safe to re-run.

alter table competitions add column if not exists formats text[];

update competitions set formats = array['Test','ODI','T20I'] where slug = 'international' and sport_slug = 'cricket';

update competitions set formats = array['T20'] where slug in (
  'ipl','bbl','wbbl','psl','sa20','cpl','wcpl','lpl','ilt20','bpl','wpl','mlc',
  'nepal-domestic','etpl','eut20-belgium','the-hundred','canada-t20',
  'new-zealand-domestic','new-zealand-domestic-women','afghanistan-domestic'
) and sport_slug = 'cricket';

update competitions set formats = array['T10'] where slug = 'canada-t10' and sport_slug = 'cricket';

update competitions set formats = array['T20I'] where slug in ('t20-world-cup','olympics-cricket') and sport_slug = 'cricket';

update competitions set formats = array['ODI'] where slug = 'cricket-world-cup' and sport_slug = 'cricket';

update competitions set formats = array['One Day'] where slug in ('dean-jones-cup','one-day-cup','australia-domestic-women') and sport_slug = 'cricket';

update competitions set formats = array['First Class'] where slug in ('county-championship','australia-domestic') and sport_slug = 'cricket';

update competitions set formats = array['First Class','T20'] where slug = 'england-domestic' and sport_slug = 'cricket';
