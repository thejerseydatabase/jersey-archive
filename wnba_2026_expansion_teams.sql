-- Adds the 3 newest WNBA expansion franchises that were missing from the
-- existing 12-team roster: Golden State Valkyries, Portland Fire, and
-- Toronto Tempo (all joining as part of the league's expansion to 15 teams
-- by the 2026 season).
--
-- Colors are left at the default swatch - these are very recently launched
-- franchises and I don't have confident official hex codes for their kits.
-- Happy to fill them in if you can supply or confirm the exact values.
--
-- Safe to re-run.

insert into teams (slug, competition_slug, name) values
  ('golden-state-valkyries','wnba','Golden State Valkyries'),
  ('portland-fire','wnba','Portland Fire'),
  ('toronto-tempo','wnba','Toronto Tempo')
on conflict (competition_slug, slug) do nothing;
