-- Adds the United Rugby Championship as a top-tier rugby-union
-- competition, with its 16 current clubs, as new team rows (not
-- touching any existing row under a different competition - e.g.
-- Bulls/Sharks are still under super-rugby-pacific, Stormers under
-- super-rugby, Lions under currie-cup, Ospreys/Ulster under
-- celtic-league - same one-row-per-competition pattern used
-- everywhere else on the site).
--
-- Colors: none of these 16 clubs' Wikipedia pages had a usable
-- infobox "Colours" field this time (several were truncated/missing
-- it entirely), so these are each club's well-known, widely
-- recognised kit colors rather than a specific cited hex source -
-- double-check against current kit photos before treating as exact,
-- since pro rugby kits/sponsors change yearly.
--
-- No conference grouping - URC has run as a single table since the
-- 2024-25 season, same as e.g. Top 14/Premiership Rugby here.
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('urc','rugby-union','United Rugby Championship','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('glasgow-warriors','urc','Glasgow Warriors','#0C2340','#000000'),
  ('bulls','urc','Bulls','#0033A0','#FFFFFF'),
  ('stormers','urc','Stormers','#1B3F8B','#000000'),
  ('sharks','urc','Sharks','#000000','#00A79D'),
  ('edinburgh','urc','Edinburgh','#7A1F3D','#C9A961'),
  ('leinster','urc','Leinster','#0073CF','#FFFFFF'),
  ('cardiff','urc','Cardiff','#A3C1AD','#000000'),
  ('dragons','urc','Dragons','#000000','#FFBF00'),
  ('ospreys','urc','Ospreys','#000000','#A7A9AC'),
  ('benetton','urc','Benetton','#00843D','#000000'),
  ('connacht','urc','Connacht','#00843D','#000000'),
  ('munster','urc','Munster','#9E1B32','#FFFFFF'),
  ('lions','urc','Lions','#C8102E','#000000'),
  ('scarlets','urc','Scarlets','#D21034','#002868'),
  ('ulster','urc','Ulster','#FFFFFF','#C8102E'),
  ('zebre','urc','Zebre','#003DA5','#FFFFFF')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
