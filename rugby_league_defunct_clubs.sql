-- Defunct/historical Australian rugby league clubs, from the Wikipedia
-- list you linked. Scope decisions made on your behalf:
--   - Omitted the England (1895-era), New Zealand, and USA sections
--     entirely — you only asked to keep the Australian ones, and those
--     other competitions don't otherwise exist on the site.
--   - Skipped a handful of Wikipedia's "defunct" QLD Cup entries that
--     look like earlier names/relocations of teams ALREADY on the site
--     under the current QLD Cup (Central Capras, Sunshine Coast Falcons,
--     Souths Magpies, Toowoomba Clydesdales) rather than risk a
--     duplicate row for the same club.
--   - Colours are best-effort: confident/well-known ones are real
--     (Balmain black/gold, St George red/white, etc.), everything else
--     is a generic placeholder swatch — correct any of them any time via
--     the admin pencil-edit.
--   - Exact fold/merger years for the more obscure ARL/Super League-era
--     clubs are approximate; flag anything you know to be wrong.
--
-- How the competition renames (NSWRL -> ARL -> Super League (Aus,
-- 1997) -> NRL) are handled: four new historical competitions below,
-- one per era. A club that's genuinely gone gets ONE row in whichever
-- era it actually folded in. A club that continued under the SAME name
-- (North Sydney Bears, Western Suburbs Magpies — both already on the
-- site as current NSW Cup teams) gets an extra row here in its old
-- top-flight era too; the site's existing "Also see" feature (see
-- nrl_expansion_teams.sql) automatically cross-links same-named teams
-- across competitions, so their page will show both eras without any
-- extra work. A club that changed name via merger (Balmain -> Wests
-- Tigers, Illawarra Steelers + St George Dragons -> St George
-- Illawarra) gets one row with a history_note explaining what it became
-- — same pattern already used for Western Suburbs Magpies.
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('nswrl','rugby-league','NSWRL (1908-1994)','more'),
  ('arl','rugby-league','ARL (1995-1997)','more'),
  ('super-league-1997','rugby-league','Super League (Australia, 1997)','more'),
  ('brisbane-rugby-league','rugby-league','Brisbane Rugby League (1909-1997)','more')
on conflict (slug) do nothing;

-- ============ NSWRL (1908-1994) — genuinely folded, not on the site elsewhere ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('annandale','nswrl','Annandale','#002664','#FFFFFF', false),
  ('cumberland','nswrl','Cumberland','#6A0032','#FFD700', false),
  ('glebe-dirty-reds','nswrl','Glebe Dirty Reds','#CE1126','#000000', false),
  ('newcastle-rebels','nswrl','Newcastle Rebels','#003893','#FFFFFF', false),
  ('sydney-university','nswrl','Sydney University','#00205B','#FFFFFF', false)
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, is_active = excluded.is_active;

-- St George Dragons: NSWRL founding club (1921), continued into the ARL
-- and Super League before the 1999 merger. One row here covers its
-- whole pre-merger history rather than splitting it across three
-- competitions.
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('st-george-dragons','nswrl','St. George Dragons','#C8102E','#FFFFFF', false,
   'Continued into the ARL and Super League (Australia) before merging with the Illawarra Steelers in 1999 to form the NRL''s St George Illawarra Dragons.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- ============ ARL (1995-1997) ============
-- Genuinely folded, not on the site anywhere else.
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('south-queensland-crushers','arl','South Queensland Crushers','#5C2D91','#FFD700', false,
   'Played in the ARL from 1995 until folding after the 1997 season.'),
  ('western-reds','arl','Western Reds','#CE1126','#000000', false,
   'Played in the ARL in 1995-1996 before joining the Super League (Australia) breakaway competition in 1997, then folded.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- Changed name via merger.
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('balmain-tigers','arl','Balmain Tigers','#000000','#FFC72C', false,
   'Merged with the Western Suburbs Magpies in 1999 to form the NRL''s Wests Tigers.'),
  ('illawarra-steelers','arl','Illawarra Steelers','#7A263A','#000000', false,
   'Merged with the St. George Dragons in 1999 to form the NRL''s St George Illawarra Dragons.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- Still exist today under the same name (already on the site as current
-- NSW Cup teams) — this just adds their ARL-era row so "Also see" links
-- the two eras together on the team page.
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('north-sydney-bears','arl','North Sydney Bears','#CE1126','#000000', false,
   'Merged with Manly Sea Eagles in 2000 to form the Northern Eagles; continues today in the NSW Cup under its own name.'),
  ('western-suburbs-magpies','arl','Western Suburbs Magpies','#000000','#FFFFFF', false,
   'Merged with Balmain Tigers in 1999 to form the NRL''s Wests Tigers, but continued playing on in the lower grades under its own name.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- ============ Super League (Australia, 1997) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('adelaide-rams','super-league-1997','Adelaide Rams','#CE1126','#000000', false,
   'Played in the 1997 Super League (Australia) season and continued into the NRL in 1998 before folding.'),
  ('hunter-mariners','super-league-1997','Hunter Mariners','#002664','#FFD700', false,
   'Played only in the 1997 Super League (Australia) season before folding.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- ============ NRL (1998-) — defunct, NRL-era-only entities ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('northern-eagles','nrl','Northern Eagles','#7A1F3D','#FFFFFF', false,
   'A 2000 merger of North Sydney Bears and Manly Sea Eagles; split back into standalone clubs after the 2002 season.'),
  ('gold-coast-chargers','nrl','Gold Coast Chargers','#008C8C','#FFFFFF', false,
   'Rebranded from the Gold Coast Seagulls for the 1998 NRL season; folded at the end of that season.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- ============ Queensland Cup (existing 'qld-cup' competition) — defunct ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('brothers-valleys','qld-cup','Brothers-Valleys','#5C2D91','#FFD700', false),
  ('bundaberg-grizzlies','qld-cup','Bundaberg Grizzlies','#6A0032','#FFFFFF', false),
  ('cairns-cyclones','qld-cup','Cairns Cyclones','#003DA5','#FFFFFF', false),
  ('gold-coast-vikings','qld-cup','Gold Coast Vikings','#FFD700','#003DA5', false),
  ('logan-scorpions','qld-cup','Logan Scorpions','#000000','#FFD700', false),
  ('mackay-sea-eagles','qld-cup','Mackay Sea Eagles','#7A1F3D','#FFFFFF', false),
  ('past-brothers','qld-cup','Past Brothers','#5C2D91','#FFFFFF', false),
  ('port-moresby-vipers','qld-cup','Port Moresby Vipers','#00843D','#000000', false),
  ('townsville-stingers','qld-cup','Townsville Stingers','#FFD700','#000000', false),
  ('wests-panthers','qld-cup','Wests Panthers','#000000','#CE1126', false)
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, is_active = excluded.is_active;

-- ============ Brisbane Rugby League (1909-1997) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('fortitude-valley-diehards','brisbane-rugby-league','Fortitude Valley Diehards','#CE1126','#FFD700', false),
  ('milton','brisbane-rugby-league','Milton','#003DA5','#FFFFFF', false),
  ('toombul','brisbane-rugby-league','Toombul','#00843D','#FFFFFF', false),
  ('university-brisbane','brisbane-rugby-league','University (Brisbane)','#00205B','#FFFFFF', false)
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, is_active = excluded.is_active;
