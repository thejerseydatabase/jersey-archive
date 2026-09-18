-- Same treatment as the ARL batch, now for NSWRL (1908-1994) and Super
-- League (Australia, 1997) — clubs that played there under the same
-- identity they still use today get a row for that era too, cross-linked
-- via "Also see". Built directly off the admission-date/seasons-
-- participated table you pasted, so the NSWRL list below should be
-- solid.
--
-- One flag before you run this: the 1997 Super League vs ARL split
-- (which of the 22 clubs played in the rival Super League competition
-- that one season, vs stayed in the ARL) is from my general knowledge,
-- not the table you sent (which doesn't break 1997 out by competition)
-- — I'm reasonably confident but not certain of every club. If any of
-- the Super League ones below look wrong, tell me and I'll move them
-- back to ARL-only (they're already covered there either way, so
-- nothing's lost by double-checking).
--
-- Colours reuse each club's current NRL palette. Safe to re-run.

-- ============ NSWRL (1908-1994) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('newtown-jets','nswrl','Newtown Jets','#003893','#CE1126', false,
   'One of the NSWRL''s nine 1908 foundation clubs; excluded from the top flight after 1983, continues today in the NSW Cup.'),
  ('south-sydney-rabbitohs','nswrl','South Sydney Rabbitohs','#8C1F28','#00442B', false,
   'One of the NSWRL''s nine 1908 foundation clubs; continues today in the NRL.'),
  ('balmain-tigers','nswrl','Balmain Tigers','#000000','#FFC72C', false,
   'One of the NSWRL''s nine 1908 foundation clubs; merged with Western Suburbs Magpies in 1999 to form the NRL''s Wests Tigers.'),
  ('sydney-roosters','nswrl','Sydney Roosters','#12284B','#E4032E', false,
   'One of the NSWRL''s nine 1908 foundation clubs (as Eastern Suburbs); continues today in the NRL.'),
  ('western-suburbs-magpies','nswrl','Western Suburbs Magpies','#000000','#FFFFFF', false,
   'One of the NSWRL''s nine 1908 foundation clubs; merged with Balmain Tigers in 1999 to form the NRL''s Wests Tigers, but continued playing on in the lower grades under its own name.'),
  ('north-sydney-bears','nswrl','North Sydney Bears','#CE1126','#000000', false,
   'One of the NSWRL''s nine 1908 foundation clubs; excluded from the top flight after 1999, continues today in the NSW Cup.'),
  ('canterbury-bulldogs','nswrl','Canterbury Bulldogs','#0D3B8C','#FFFFFF', false,
   'Joined the premiership in 1935; continues today in the NRL.'),
  ('parramatta-eels','nswrl','Parramatta Eels','#005DAA','#FFD100', false,
   'Joined the premiership in 1947; continues today in the NRL.'),
  ('manly-sea-eagles','nswrl','Manly Sea Eagles','#7A1F3D','#FFFFFF', false,
   'Joined the premiership in 1947 as Manly-Warringah; continues today in the NRL.'),
  ('cronulla-sharks','nswrl','Cronulla Sharks','#6EC1E4','#000000', false,
   'Joined the premiership in 1967; continues today in the NRL.'),
  ('penrith-panthers','nswrl','Penrith Panthers','#1A1A1A','#00A19A', false,
   'Joined the premiership in 1967; continues today in the NRL.'),
  ('illawarra-steelers','nswrl','Illawarra Steelers','#7A263A','#000000', false,
   'Joined the premiership in 1982; merged with the St. George Dragons in 1999 to form the NRL''s St George Illawarra Dragons.'),
  ('canberra-raiders','nswrl','Canberra Raiders','#00843D','#FFD200', false,
   'Joined the premiership in 1982; continues today in the NRL.'),
  ('brisbane-broncos','nswrl','Brisbane Broncos','#7A1927','#F5B324', false,
   'Joined the premiership in 1988; continues today in the NRL.'),
  ('newcastle-knights','nswrl','Newcastle Knights','#EE3524','#002D62', false,
   'Joined the premiership in 1988; continues today in the NRL. Not related to the earlier, short-lived Newcastle Rebels (1908-1909).'),
  ('gold-coast-seagulls','nswrl','Gold Coast Seagulls','#008C8C','#FFFFFF', false,
   'Joined the premiership in 1988 (as the Gold Coast-Tweed Giants); rebranded the Gold Coast Chargers for the 1998 NRL season, then folded.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- ============ Super League (Australia, 1997) — clubs I believe defected from the ARL for that one season ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('brisbane-broncos','super-league-1997','Brisbane Broncos','#7A1927','#F5B324', false,
   'Played the 1997 season in the rival Super League competition; continues today in the NRL.'),
  ('canterbury-bulldogs','super-league-1997','Canterbury Bulldogs','#0D3B8C','#FFFFFF', false,
   'Played the 1997 season in the rival Super League competition; continues today in the NRL.'),
  ('cronulla-sharks','super-league-1997','Cronulla Sharks','#6EC1E4','#000000', false,
   'Played the 1997 season in the rival Super League competition; continues today in the NRL.'),
  ('north-queensland-cowboys','super-league-1997','North Queensland Cowboys','#002B5C','#F5C518', false,
   'Played the 1997 season in the rival Super League competition; continues today in the NRL.'),
  ('penrith-panthers','super-league-1997','Penrith Panthers','#1A1A1A','#00A19A', false,
   'Played the 1997 season in the rival Super League competition; continues today in the NRL.'),
  ('new-zealand-warriors','super-league-1997','New Zealand Warriors','#1B1B1B','#00843D', false,
   'Played as the Auckland Warriors in the rival Super League competition; continues today in the NRL.'),
  ('south-queensland-crushers','super-league-1997','South Queensland Crushers','#5C2D91','#FFD700', false,
   'Played the ARL in 1995-1996, then the rival Super League competition in 1997, before folding.'),
  ('western-reds','super-league-1997','Western Reds','#CE1126','#000000', false,
   'Played the ARL in 1995-1996, then the rival Super League competition in 1997, before folding.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;
