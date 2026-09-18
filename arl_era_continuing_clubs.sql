-- Answers your question directly: yes, this adds the clubs that played
-- in the ARL (1995-1997) under the same identity they still play under
-- today — Newcastle, Manly, Cronulla, and the rest — the ones the first
-- file left out because they never folded or changed name. It's not
-- "creating more teams" in the sense of new, separate clubs; it's the
-- same club getting a second row for its ARL-era history, exactly like
-- North Sydney Bears and Western Suburbs Magpies already got. Their
-- current NRL row and this ARL row share the same name, so the site's
-- "Also see" feature links the two on the team page automatically —
-- click into either era and you'll see a link across to the other.
--
-- Names/dates cross-checked against the club-history table you pasted:
-- - Manly played as "Manly-Warringah Sea Eagles" during this era —
--   noted, but the row itself is still named "Manly Sea Eagles" (matching
--   today's name) so the auto-link works; same call for the Warriors.
-- - New Zealand Warriors joined the competition in 1995 as the "Auckland
--   Warriors" — same reasoning, named to match today's team.
-- - Added the Gold Coast's ARL-era name too (Seagulls, before the 1998
--   Chargers rebrand already on the site as its own NRL-era row).
--
-- Colours reuse each club's current NRL palette rather than researching
-- separate 1990s-specific colourways. Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('south-sydney-rabbitohs','arl','South Sydney Rabbitohs','#8C1F28','#00442B', false,
   'One of the NSWRL''s nine 1908 foundation clubs; continues today in the NRL.'),
  ('sydney-roosters','arl','Sydney Roosters','#12284B','#E4032E', false,
   'One of the NSWRL''s nine 1908 foundation clubs (as Eastern Suburbs); continues today in the NRL.'),
  ('canterbury-bulldogs','arl','Canterbury Bulldogs','#0D3B8C','#FFFFFF', false,
   'Joined the premiership in 1935; continues today in the NRL.'),
  ('parramatta-eels','arl','Parramatta Eels','#005DAA','#FFD100', false,
   'Joined the premiership in 1947; continues today in the NRL.'),
  ('manly-sea-eagles','arl','Manly Sea Eagles','#7A1F3D','#FFFFFF', false,
   'Played as Manly-Warringah Sea Eagles during this era; continues today in the NRL.'),
  ('cronulla-sharks','arl','Cronulla Sharks','#6EC1E4','#000000', false,
   'Joined the premiership in 1967; continues today in the NRL.'),
  ('penrith-panthers','arl','Penrith Panthers','#1A1A1A','#00A19A', false,
   'Joined the premiership in 1967; continues today in the NRL.'),
  ('canberra-raiders','arl','Canberra Raiders','#00843D','#FFD200', false,
   'Joined the premiership in 1982; continues today in the NRL.'),
  ('brisbane-broncos','arl','Brisbane Broncos','#7A1927','#F5B324', false,
   'Joined the premiership in 1988; continues today in the NRL.'),
  ('newcastle-knights','arl','Newcastle Knights','#EE3524','#002D62', false,
   'Joined the premiership in 1988; continues today in the NRL.'),
  ('new-zealand-warriors','arl','New Zealand Warriors','#1B1B1B','#00843D', false,
   'Joined the ARL in 1995 as the Auckland Warriors; continues today in the NRL.'),
  ('north-queensland-cowboys','arl','North Queensland Cowboys','#002B5C','#F5C518', false,
   'Joined the ARL in 1995; continues today in the NRL.'),
  ('gold-coast-seagulls','arl','Gold Coast Seagulls','#008C8C','#FFFFFF', false,
   'Played in the ARL as the Seagulls before rebranding as the Gold Coast Chargers for the 1998 NRL season, then folding.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;
