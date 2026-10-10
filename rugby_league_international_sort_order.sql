-- manufacturer_and_competition_cleanup.sql hand-ordered rugby league's
-- domestic ladder (NRL 1, Super League 2, NRLW 3, State of Origin 4, RFL
-- Championship 5, QLD Cup 6, NSW Cup 7) but never gave International (Men)/
-- (Women) a slot, so it was still sitting at the schema default (999) -
-- tied with "Representative" (the State of Origin-adjacent grab-bag of
-- teams like Australian Defence Force, Western Australia, that only got
-- tier='top' so it shows on the sport page without a "more" click, not
-- because it's prominent). The search suggestion dropdown now uses this
-- same sort_order as a ranking signal, so that tie meant national team
-- jerseys (Australia) and a once-a-year novelty representative side could
-- show up in arbitrary order relative to each other.
-- Safe to re-run.

update competitions set sort_order = 8
  where name ilike 'International%' and sport_slug = 'rugby-league';
