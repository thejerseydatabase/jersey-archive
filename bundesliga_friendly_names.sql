-- Shortens a batch of Bundesliga / 2. Bundesliga team names to the form
-- people actually search for (dropping "FC"/"1."/"SV"/founding-year
-- prefixes — e.g. "FC Bayern Munich" -> "Bayern Munich"), with the full
-- official name kept as a note on the team's own page so it's not lost,
-- just no longer the headline. Slugs are untouched, so nothing else
-- (URLs, existing jerseys) is affected.
--
-- Made findable by both names — searching the official name (e.g. "FC
-- Bayern Munchen") still resolves to the shortened team — via a matching
-- app.js change (SEARCH_PHRASE_ALIASES), not anything in this file.
--
-- A few names in your list matched what's already in the database
-- (Borussia Mönchengladbach, Greuther Fürth, SC Freiburg, Borussia
-- Dortmund, FC Augsburg, RB Leipzig, Bayer Leverkusen, Eintracht
-- Frankfurt, VfB Stuttgart, SC Paderborn 07, Hamburger SV, Dynamo
-- Dresden, Hannover 96, Karlsruher SC, Holstein Kiel) or just dropped an
-- umlaut you can't easily type — search already handles missing accents
-- on its own, so those are left as-is rather than changed for no reason.
--
-- Safe to re-run.

-- ============ Bundesliga ============
update teams set name = 'Bayern Munich',
  history_note = 'Official name: FC Bayern München.'
  where competition_slug = 'bundesliga' and slug = 'fc-bayern-munich';
update teams set name = 'SV 07 Elversberg'
  where competition_slug = 'bundesliga' and slug = 'sv-elversberg';
update teams set name = 'FSV Mainz',
  history_note = 'Official name: 1. FSV Mainz 05.'
  where competition_slug = 'bundesliga' and slug = '1-fsv-mainz-05';
update teams set name = 'Werder Bremen',
  history_note = 'Official name: SV Werder Bremen.'
  where competition_slug = 'bundesliga' and slug = 'sv-werder-bremen';
update teams set name = 'Schalke 04',
  history_note = 'Official name: FC Schalke 04.'
  where competition_slug = 'bundesliga' and slug = 'fc-schalke-04';
update teams set name = '1. FC Cologne',
  history_note = 'Official (German) name: 1. FC Köln — "Cologne" is the English name for the city of Köln.'
  where competition_slug = 'bundesliga' and slug = '1-fc-koln';
update teams set name = 'TSG Hoffenheim',
  history_note = 'Official name: TSG 1899 Hoffenheim.'
  where competition_slug = 'bundesliga' and slug = 'tsg-1899-hoffenheim';
update teams set name = 'Union Berlin',
  history_note = 'Official name: 1. FC Union Berlin.'
  where competition_slug = 'bundesliga' and slug = '1-fc-union-berlin';

-- ============ 2. Bundesliga ============
update teams set name = 'Hertha Berlin',
  history_note = 'Official name: Hertha BSC (Berliner Sport-Club).'
  where competition_slug = 'bundesliga-2' and slug = 'hertha-bsc';
update teams set name = 'Bielefeld',
  history_note = 'Official name: DSC Arminia Bielefeld.'
  where competition_slug = 'bundesliga-2' and slug = 'arminia-bielefeld';
update teams set name = 'Bochum',
  history_note = 'Official name: VfL Bochum 1848.'
  where competition_slug = 'bundesliga-2' and slug = 'vfl-bochum';
update teams set name = 'Braunschweig',
  history_note = 'Official name: Eintracht Braunschweig.'
  where competition_slug = 'bundesliga-2' and slug = 'eintracht-braunschweig';
update teams set name = 'Darmstadt',
  history_note = 'Official name: SV Darmstadt 98.'
  where competition_slug = 'bundesliga-2' and slug = 'darmstadt-98';
update teams set name = 'Kaiserslautern',
  history_note = 'Official name: 1. FC Kaiserslautern.'
  where competition_slug = 'bundesliga-2' and slug = '1-fc-kaiserslautern';
update teams set name = 'Magdeburg',
  history_note = 'Official name: 1. FC Magdeburg.'
  where competition_slug = 'bundesliga-2' and slug = '1-fc-magdeburg';
update teams set name = 'FC Nürnberg',
  history_note = 'Official name: 1. FC Nürnberg.'
  where competition_slug = 'bundesliga-2' and slug = '1-fc-nurnberg';
