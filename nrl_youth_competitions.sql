-- Adds the four NRL-affiliated youth/feeder competitions and their
-- clubs: Holden Cup (NRL's old Under-20s, 2008-2017, same 16 clubs as
-- the NRL itself at the time), Jersey Flegg Cup (current U21),
-- S.G. Ball Cup (current U19) and Harold Matthews Cup (current U17).
--
-- S.G. Ball and Harold Matthews run on old district boundaries, not
-- today's joint-venture NRL clubs - Balmain, North Sydney, Western
-- Suburbs, Illawarra and a standalone "St George" are each their own
-- separate identity here, distinct from Wests Tigers/St George
-- Illawarra Dragons. Colors for those (and a couple of others) are
-- reasonable, not verified anywhere - double check if you know the
-- real ones: Balmain Tigers, Central Coast Roosters, Illawarra
-- Steelers, North Sydney Bears, St George Dragons, Western Suburbs
-- Magpies, Kaiviti Silktails.
--
-- New Zealand Warriors entries get teams.country = 'New Zealand',
-- same override pattern as NRL/NRLW.
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier, region_group) values
  ('holden-cup', 'rugby-league', 'Holden Cup', 'more', 'Australia'),
  ('jersey-flegg-cup', 'rugby-league', 'Jersey Flegg Cup', 'more', 'Australia'),
  ('sg-ball-cup', 'rugby-league', 'S.G. Ball Cup', 'more', 'Australia'),
  ('harold-matthews-cup', 'rugby-league', 'Harold Matthews Cup', 'more', 'Australia')
on conflict (slug) do nothing;

-- ============ Holden Cup (2008-2017, same 16 clubs as the NRL) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('brisbane-broncos', 'holden-cup', 'Brisbane Broncos', '#6F263D', '#FDB91E'),
  ('canterbury-bankstown-bulldogs', 'holden-cup', 'Canterbury-Bankstown Bulldogs', '#00529B', '#FFFFFF'),
  ('canberra-raiders', 'holden-cup', 'Canberra Raiders', '#00843D', '#FFD200'),
  ('cronulla-sutherland-sharks', 'holden-cup', 'Cronulla-Sutherland Sharks', '#00549F', '#000000'),
  ('gold-coast-titans', 'holden-cup', 'Gold Coast Titans', '#002B5C', '#FFB81C'),
  ('manly-warringah-sea-eagles', 'holden-cup', 'Manly Warringah Sea Eagles', '#7B1032', '#FFFFFF'),
  ('melbourne-storm', 'holden-cup', 'Melbourne Storm', '#4B2E83', '#FFB81C'),
  ('newcastle-knights', 'holden-cup', 'Newcastle Knights', '#EE3124', '#002F6C'),
  ('new-zealand-warriors', 'holden-cup', 'New Zealand Warriors', '#00843D', '#000000'),
  ('north-queensland-cowboys', 'holden-cup', 'North Queensland Cowboys', '#002D62', '#FFD200'),
  ('parramatta-eels', 'holden-cup', 'Parramatta Eels', '#0047AB', '#FFD200'),
  ('penrith-panthers', 'holden-cup', 'Penrith Panthers', '#000000', '#6CADDF'),
  ('south-sydney-rabbitohs', 'holden-cup', 'South Sydney Rabbitohs', '#7B1032', '#00573F'),
  ('st-george-illawarra-dragons', 'holden-cup', 'St. George Illawarra Dragons', '#C8102E', '#FFFFFF'),
  ('sydney-roosters', 'holden-cup', 'Sydney Roosters', '#EE3124', '#002F6C'),
  ('wests-tigers', 'holden-cup', 'Wests Tigers', '#000000', '#F57F17')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

update teams set country = 'New Zealand' where competition_slug = 'holden-cup' and slug = 'new-zealand-warriors';

-- ============ Jersey Flegg Cup ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('canberra-raiders', 'jersey-flegg-cup', 'Canberra Raiders', '#00843D', '#FFD200'),
  ('canterbury-bankstown-bulldogs', 'jersey-flegg-cup', 'Canterbury-Bankstown Bulldogs', '#00529B', '#FFFFFF'),
  ('cronulla-sutherland-sharks', 'jersey-flegg-cup', 'Cronulla-Sutherland Sharks', '#00549F', '#000000'),
  ('kaiviti-silktails', 'jersey-flegg-cup', 'Kaiviti Silktails', '#6CADDF', '#FFFFFF'),
  ('manly-warringah-sea-eagles', 'jersey-flegg-cup', 'Manly-Warringah Sea Eagles', '#7B1032', '#FFFFFF'),
  ('melbourne-storm', 'jersey-flegg-cup', 'Melbourne Storm', '#4B2E83', '#FFB81C'),
  ('newcastle-knights', 'jersey-flegg-cup', 'Newcastle Knights', '#EE3124', '#002F6C'),
  ('new-zealand-warriors', 'jersey-flegg-cup', 'New Zealand Warriors', '#00843D', '#000000'),
  ('parramatta-eels', 'jersey-flegg-cup', 'Parramatta Eels', '#0047AB', '#FFD200'),
  ('penrith-panthers', 'jersey-flegg-cup', 'Penrith Panthers', '#000000', '#6CADDF'),
  ('south-sydney-rabbitohs', 'jersey-flegg-cup', 'South Sydney Rabbitohs', '#7B1032', '#00573F'),
  ('st-george-illawarra-dragons', 'jersey-flegg-cup', 'St George Illawarra Dragons', '#C8102E', '#FFFFFF'),
  ('sydney-roosters', 'jersey-flegg-cup', 'Sydney Roosters', '#EE3124', '#002F6C'),
  ('wests-tigers', 'jersey-flegg-cup', 'Wests Tigers', '#000000', '#F57F17')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

update teams set country = 'New Zealand' where competition_slug = 'jersey-flegg-cup' and slug = 'new-zealand-warriors';

-- ============ S.G. Ball Cup (old district identities) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('balmain-tigers', 'sg-ball-cup', 'Balmain Tigers', '#000000', '#FFD200'),
  ('canberra-raiders', 'sg-ball-cup', 'Canberra Raiders', '#00843D', '#FFD200'),
  ('canterbury-bankstown-bulldogs', 'sg-ball-cup', 'Canterbury-Bankstown Bulldogs', '#00529B', '#FFFFFF'),
  ('central-coast-roosters', 'sg-ball-cup', 'Central Coast Roosters', '#EE3124', '#002F6C'),
  ('cronulla-sutherland-sharks', 'sg-ball-cup', 'Cronulla-Sutherland Sharks', '#00549F', '#000000'),
  ('illawarra-steelers', 'sg-ball-cup', 'Illawarra Steelers', '#000000', '#FFFFFF'),
  ('manly-warringah-sea-eagles', 'sg-ball-cup', 'Manly-Warringah Sea Eagles', '#7B1032', '#FFFFFF'),
  ('melbourne-storm', 'sg-ball-cup', 'Melbourne Storm', '#4B2E83', '#FFB81C'),
  ('newcastle-knights', 'sg-ball-cup', 'Newcastle Knights', '#EE3124', '#002F6C'),
  ('new-zealand-warriors', 'sg-ball-cup', 'New Zealand Warriors', '#00843D', '#000000'),
  ('north-sydney-bears', 'sg-ball-cup', 'North Sydney Bears', '#C8102E', '#000000'),
  ('parramatta-eels', 'sg-ball-cup', 'Parramatta Eels', '#0047AB', '#FFD200'),
  ('penrith-panthers', 'sg-ball-cup', 'Penrith Panthers', '#000000', '#6CADDF'),
  ('south-sydney-rabbitohs', 'sg-ball-cup', 'South Sydney Rabbitohs', '#7B1032', '#00573F'),
  ('st-george-dragons', 'sg-ball-cup', 'St George Dragons', '#C8102E', '#FFFFFF'),
  ('sydney-roosters', 'sg-ball-cup', 'Sydney Roosters', '#EE3124', '#002F6C'),
  ('western-suburbs-magpies', 'sg-ball-cup', 'Western Suburbs Magpies', '#000000', '#FFFFFF')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

update teams set country = 'New Zealand' where competition_slug = 'sg-ball-cup' and slug = 'new-zealand-warriors';

-- ============ Harold Matthews Cup (old district identities) ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('balmain-tigers', 'harold-matthews-cup', 'Balmain Tigers', '#000000', '#FFD200'),
  ('canberra-raiders', 'harold-matthews-cup', 'Canberra Raiders', '#00843D', '#FFD200'),
  ('canterbury-bankstown-bulldogs', 'harold-matthews-cup', 'Canterbury-Bankstown Bulldogs', '#00529B', '#FFFFFF'),
  ('central-coast-roosters', 'harold-matthews-cup', 'Central Coast Roosters', '#EE3124', '#002F6C'),
  ('cronulla-sutherland-sharks', 'harold-matthews-cup', 'Cronulla-Sutherland Sharks', '#00549F', '#000000'),
  ('illawarra-steelers', 'harold-matthews-cup', 'Illawarra Steelers', '#000000', '#FFFFFF'),
  ('manly-warringah-sea-eagles', 'harold-matthews-cup', 'Manly-Warringah Sea Eagles', '#7B1032', '#FFFFFF'),
  ('melbourne-storm', 'harold-matthews-cup', 'Melbourne Storm', '#4B2E83', '#FFB81C'),
  ('newcastle-knights', 'harold-matthews-cup', 'Newcastle Knights', '#EE3124', '#002F6C'),
  ('new-zealand-warriors', 'harold-matthews-cup', 'New Zealand Warriors', '#00843D', '#000000'),
  ('north-sydney-bears', 'harold-matthews-cup', 'North Sydney Bears', '#C8102E', '#000000'),
  ('parramatta-eels', 'harold-matthews-cup', 'Parramatta Eels', '#0047AB', '#FFD200'),
  ('penrith-panthers', 'harold-matthews-cup', 'Penrith Panthers', '#000000', '#6CADDF'),
  ('south-sydney-rabbitohs', 'harold-matthews-cup', 'South Sydney Rabbitohs', '#7B1032', '#00573F'),
  ('st-george-dragons', 'harold-matthews-cup', 'St George Dragons', '#C8102E', '#FFFFFF'),
  ('sydney-roosters', 'harold-matthews-cup', 'Sydney Roosters', '#EE3124', '#002F6C'),
  ('western-suburbs-magpies', 'harold-matthews-cup', 'Western Suburbs Magpies', '#000000', '#FFFFFF')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

update teams set country = 'New Zealand' where competition_slug = 'harold-matthews-cup' and slug = 'new-zealand-warriors';
