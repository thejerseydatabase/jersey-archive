-- Two corrections from cross-checking against Wikipedia's actual
-- 2026-27 rosters:
--
-- 1. Wolfsburg, Heidenheim, and St. Pauli are 2. Bundesliga this season,
--    not Bundesliga — I had guessed Bundesliga based on outdated
--    knowledge in the previous file. Moves them if that file already
--    ran (so no jersey history is lost — same row, just a different
--    competition_slug), otherwise creates them fresh directly under
--    2. Bundesliga. Either way ends up in the right place.
--
-- 2. Reverts "1. FC Köln" back from "1. FC Cologne" — anglicizing the
--    city name wasn't actually part of what you asked for (dropping
--    FC/1./founding-year prefixes was), that was me overreaching, and
--    "1. FC Köln" is already about as short as that name gets anyway.
--
-- (SV 07 Elversberg, FSV Mainz, SC Paderborn 07, and Darmstadt were
-- deliberately kept as you originally typed them, even though the
-- Wikipedia pages you just sent format a couple of those slightly
-- differently — those pages aren't fully consistent with each other on
-- which clubs keep a founding-year suffix, so your own list is treated
-- as the deciding one for wording; this file only fixes the actual
-- tier-placement and translation mistakes.)
--
-- Safe to re-run.

update teams set competition_slug = 'bundesliga-2'
  where competition_slug = 'bundesliga' and slug in ('wolfsburg','heidenheim','st-pauli');

insert into teams (slug, competition_slug, name, history_note) values
  ('wolfsburg','bundesliga-2','Wolfsburg','Official name: VfL Wolfsburg.'),
  ('heidenheim','bundesliga-2','Heidenheim','Official name: 1. FC Heidenheim 1846.'),
  ('st-pauli','bundesliga-2','St. Pauli','Official name: FC St. Pauli.')
on conflict (competition_slug, slug) do nothing;

update teams set name = '1. FC Köln', history_note = null
  where competition_slug = 'bundesliga' and slug = '1-fc-koln';
