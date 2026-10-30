-- Read-only check, not a migration - run this in the Supabase SQL
-- Editor and send me the results. Lists every competition that still
-- has no region_group set, ordered so the flagship "top" tier ones
-- (the easy, obvious ones - NRL, AFL, Premier League, etc.) sort to
-- the top of each sport, with the more obscure "more" tier ones below.
-- tag_only competitions (World Cups etc.) are excluded - those aren't
-- a real "home" a team/jersey belongs to, so they don't need a country.

select sport_slug, tier, name, slug
from competitions
where region_group is null
  and tag_only = false
order by sport_slug, (tier = 'top') desc, name;
