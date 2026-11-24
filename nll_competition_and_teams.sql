-- Adds the National Lacrosse League as a top-tier lacrosse competition,
-- with its 12 current teams plus its defunct/relocated franchises from
-- https://en.wikipedia.org/wiki/National_Lacrosse_League (both tables
-- on that page).
--
-- Two names appear twice on the Wikipedia page (an earlier franchise
-- folded/relocated, then the name was reused later) - in both cases
-- Wikipedia itself covers the whole history as ONE article/infobox, so
-- each gets a single row here rather than two colliding "same name,
-- same competition" rows:
--   - Rochester Knighthawks: the 1995-2019 team relocated to become
--     Halifax Thunderbirds, then the name was reused for a fresh
--     expansion team from 2024 on (now playing as Rochester
--     Knighthawks again, with new colors per a July 2026 rebrand) -
--     is_active = true, current colors, with a history_note on the gap.
--   - Philadelphia Wings: 1987-2014 (relocated to become New England
--     Black Wolves), then a 2018-2026 revival that folded - one
--     is_active = false row, since neither era is active today and
--     Wikipedia's own infobox colors cover the franchise as a whole.
--
-- Colors: none of these teams' Wikipedia infoboxes give hex codes,
-- only named colors - these hex values are reasonable approximations,
-- not from an official brand guide. Three teams (Las Vegas Desert
-- Dogs, Washington Wave, Edmonton Rush) had no colors listed on
-- Wikipedia at all, so theirs are unconfirmed placeholders - flagged
-- individually below. Double-check/replace any of these if you know
-- the real ones.
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('nll','lacrosse','National Lacrosse League','top')
on conflict (slug) do nothing;

-- Current teams
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('buffalo-bandits','nll','Buffalo Bandits','#F58025','#582C83', true, null),
  ('calgary-roughnecks','nll','Calgary Roughnecks','#000000','#C8102E', true, null),
  ('colorado-mammoth','nll','Colorado Mammoth','#862633','#000000', true, null),
  ('georgia-swarm','nll','Georgia Swarm','#FFC72C','#002868', true, null),
  ('halifax-thunderbirds','nll','Halifax Thunderbirds','#582C83','#F58025', true, null),
  -- Colors unconfirmed - no Colors field on Wikipedia at all.
  ('las-vegas-desert-dogs','nll','Las Vegas Desert Dogs','#000000','#C9A961', true, null),
  ('oshawa-firewolves','nll','Oshawa FireWolves','#6F1D32','#C9A961', true, null),
  ('rochester-knighthawks','nll','Rochester Knighthawks','#582C83','#00838A', true,
    'Original franchise played 1995-2019 before relocating to become the Halifax Thunderbirds. The Knighthawks name returned as a new expansion team from the 2024-25 season; colors above are the current (July 2026 rebrand) ones.'),
  ('san-diego-seals','nll','San Diego Seals','#5B2A86','#FFC72C', true, null),
  ('saskatchewan-rush','nll','Saskatchewan Rush','#00843D','#000000', true, null),
  ('toronto-rock','nll','Toronto Rock','#002868','#C8102E', true, null),
  ('vancouver-warriors','nll','Vancouver Warriors','#FFC72C','#000000', true, null)
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

-- Former/defunct teams (see teams.is_active - shows under "Former teams" on the competition page)
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('washington-wave','nll','Washington Wave','#002868','#A7A9AC', false, '1987-1989. Colors unconfirmed - no Colors field on Wikipedia.'),
  ('baltimore-thunder','nll','Baltimore Thunder','#C8102E','#FFC72C', false, '1987-1999. Relocated to Pittsburgh as the Pittsburgh CrosseFire.'),
  ('new-york-saints','nll','New York Saints','#002868','#6F1D32', false, '1987-2003 (as New Jersey Saints 1987-1988, then Uniondale, NY).'),
  ('philadelphia-wings','nll','Philadelphia Wings','#000000','#C8102E', false,
    '1987-2014 (relocated to Uncasville, CT as the New England Black Wolves), then revived 2018-2026 before folding. One Wikipedia article/infobox covers both eras.'),
  ('detroit-turbos','nll','Detroit Turbos','#582C83','#A7A9AC', false, '1989-1994.'),
  ('boston-blazers','nll','Boston Blazers','#00843D','#F58025', false, '1989-1997 (as New England Blazers 1989-1991). A separate, later Boston Blazers (2009-2011) is a different franchise, not added here.'),
  ('pittsburgh-bulls','nll','Pittsburgh Bulls','#000000','#FFC72C', false, '1990-1993.'),
  ('charlotte-cobras','nll','Charlotte Cobras','#C8102E','#000000', false, '1996 only.'),
  ('ontario-raiders','nll','Ontario Raiders','#000000','#FFC72C', false, '1998 (Hamilton, Ontario). Relocated to become the Toronto Rock.'),
  ('syracuse-smash','nll','Syracuse Smash','#000000','#002868', false, '1998-2000. Relocated to become the Ottawa Rebel.'),
  ('pittsburgh-crossefire','nll','Pittsburgh CrosseFire','#C8102E','#FFC72C', false, '2000 only. The Baltimore Thunder relocated here before moving on to Washington as the Washington Power.'),
  ('albany-attack','nll','Albany Attack','#002147','#C4D8E2', false, '2000-2003. Relocated to become the San Jose Stealth.'),
  ('ottawa-rebel','nll','Ottawa Rebel','#000000','#C8102E', false, '2001-2003. Relocated to become the Edmonton Rush.'),
  ('washington-power','nll','Washington Power','#002868','#C8102E', false, '2001-2002. Relocated to become the Colorado Mammoth.'),
  ('arizona-sting','nll','Arizona Sting','#9E3A26','#000000', false, '2001-2007 (as Columbus Landsharks 2001-2003, moved to Glendale, AZ as the Sting from 2004).'),
  ('montreal-express','nll','Montreal Express','#000000','#002868', false, '2002 only. Relocated to become the Minnesota Swarm (2004).'),
  ('anaheim-storm','nll','Anaheim Storm','#002868','#8A8D8F', false, '2002-2005 (as New Jersey Storm, East Rutherford, before moving to Anaheim).'),
  ('vancouver-ravens','nll','Vancouver Ravens','#C8102E','#000000', false, '2002-2004.'),
  ('san-jose-stealth','nll','San Jose Stealth','#C8102E','#000000', false, '2004-2009. Relocated to become the Washington Stealth (Everett, WA).'),
  ('minnesota-swarm','nll','Minnesota Swarm','#FFC72C','#002868', false, '2004-2015 (Saint Paul, MN). Relocated to become the Georgia Swarm.'),
  ('edmonton-rush','nll','Edmonton Rush','#C8102E','#000000', false, '2005-2015. Relocated to become the Saskatchewan Rush. Colors unconfirmed - no Colors field on Wikipedia.'),
  ('portland-lumberjax','nll','Portland LumberJax','#000000','#FFC72C', false, '2006-2009.'),
  ('orlando-titans','nll','Orlando Titans','#F58025','#002868', false, '2007-2010 (as New York Titans 2007-2009, moved to Orlando for 2010).'),
  ('chicago-shamrox','nll','Chicago Shamrox','#000000','#00843D', false, '2007-2008 (Hoffman Estates, IL).'),
  ('washington-stealth','nll','Washington Stealth','#C8102E','#000000', false, '2010-2013 (Everett, WA). Relocated to become the Vancouver Warriors.'),
  ('new-england-black-wolves','nll','New England Black Wolves','#000000','#F58025', false, '2015-2020 (Uncasville, CT). Relocated to become the Albany FireWolves.'),
  ('new-york-riptide','nll','New York Riptide','#002147','#00838A', false, '2018-2024 (Uniondale, NY). Relocated to become the Ottawa Black Bears for 2024-25.'),
  ('panther-city-lacrosse-club','nll','Panther City Lacrosse Club','#582C83','#C8102E', false, '2021-2024 (Fort Worth, TX).'),
  ('albany-firewolves','nll','Albany FireWolves','#6F1D32','#C9A961', false, '2021-2025. Relocated to become the Oshawa FireWolves.'),
  ('ottawa-black-bears','nll','Ottawa Black Bears','#000000','#C8102E', false, '2024-2026 (relocated from New York/Uniondale as the Riptide). Folded in 2026 due to no ownership group.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;
