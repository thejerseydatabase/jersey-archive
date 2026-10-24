-- Adds the rest of the WNCL teams (ACT Meteors already added manually)
-- into the new Spring Challenge competition, since a team is scoped to
-- one specific competition in this schema — same real-world clubs, but
-- Spring Challenge needs its own team rows, separate from their WNCL
-- ones, so each competition keeps a clean, independent jersey history.
--
-- Looks the competition up by (sport, name) rather than a hardcoded
-- slug, matching how the app itself resolves a competition picked from
-- "+ Add a new competition…" (see ensureCompetition() in app.js) — so
-- this doesn't depend on guessing exactly what slug got generated.
-- Colors are copied from the real WNCL teams in competition_tweaks.sql.
-- Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color)
select v.slug, c.slug, v.name, v.primary_color, v.secondary_color
from (values
  ('new-south-wales-blues','New South Wales Blues','#001E62','#FFFFFF'),
  ('queensland-fire','Queensland Fire','#6A0032','#FFD700'),
  ('south-australia-scorpions','South Australia Scorpions','#C8102E','#001E62'),
  ('tasmanian-tigers','Tasmanian Tigers','#002664','#00843D'),
  ('victoria','Victoria','#002664','#FFFFFF'),
  ('western-australia','Western Australia','#000000','#FFD700')
) as v(slug, name, primary_color, secondary_color)
cross join (
  select slug from competitions where sport_slug = 'cricket' and name ilike 'Spring Challenge'
) as c
on conflict (competition_slug, slug) do nothing;
