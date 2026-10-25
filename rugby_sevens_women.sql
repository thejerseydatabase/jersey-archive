-- Adds a Sevens competition under rugby-union, separate from the
-- Wallabies/XVs "International" competition — the Sevens program is a
-- genuinely different national side (different honour, different player
-- pool, different circuit: the SVNS/World Rugby Sevens Series rather
-- than Test rugby), not a different jersey design for the same team, so
-- per the "a team is scoped to one competition" rule it needs its own
-- competition and its own team rows, not a jersey `type` of "Sevens"
-- under the existing Australia/International team.
--
-- 'olympics-rugby-sevens' (added in olympics_competitions.sql) is a
-- separate, tag_only competition for "this jersey was also worn at the
-- Olympics" tagging on top of a team's regular competition — it isn't
-- the right home for a full, permanent sevens roster, so this is a new
-- normal (non tag_only) competition instead.
--
-- Women's international sevens teams, from
-- https://www.sport-ranking.com/rankings?varianta=314 (per the user).
-- Colors are each country's standard national sporting/flag colors,
-- reused from existing international rosters on the site (lacrosse,
-- field hockey, etc.) where the same country already appears there.
--
-- Men's teams are a separate follow-up migration — the men's Wikipedia
-- table the request was sourced from lost its actual core-team rows in
-- copy/paste (the current 2025–26 men's core 8 — Argentina, Australia,
-- Fiji, France, Great Britain, New Zealand, South Africa, Spain — never
-- made it into the pasted list at all), so that one needs confirming
-- before it's added.
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('rugby-sevens-women','rugby-union','Sevens Series (Women)','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('new-zealand','rugby-sevens-women','New Zealand','#000000','#FFFFFF'),
  ('australia','rugby-sevens-women','Australia','#00843D','#FFD700'),
  ('canada','rugby-sevens-women','Canada','#FF0000','#FFFFFF'),
  ('france','rugby-sevens-women','France','#0055A4','#FFFFFF'),
  ('united-states','rugby-sevens-women','United States','#002868','#BF0D3E'),
  ('fiji','rugby-sevens-women','Fiji','#68C3F0','#FFFFFF'),
  ('great-britain','rugby-sevens-women','Great Britain','#C8102E','#012169'),
  ('china','rugby-sevens-women','China','#DE2910','#FFDE00'),
  ('england','rugby-sevens-women','England','#FFFFFF','#CE1124'),
  ('russia','rugby-sevens-women','Russia','#0039A6','#D52B1E'),
  ('japan','rugby-sevens-women','Japan','#BC002D','#FFFFFF'),
  ('spain','rugby-sevens-women','Spain','#AA151B','#F1BF00'),
  ('ireland','rugby-sevens-women','Ireland','#169B62','#FFFFFF'),
  ('kazakhstan','rugby-sevens-women','Kazakhstan','#00AFCA','#FEC50C'),
  ('poland','rugby-sevens-women','Poland','#DC143C','#FFFFFF'),
  ('uganda','rugby-sevens-women','Uganda','#000000','#FCDC04'),
  ('madagascar','rugby-sevens-women','Madagascar','#FC3D32','#FFFFFF'),
  ('papua-new-guinea','rugby-sevens-women','Papua New Guinea','#000000','#FFC72C'),
  ('samoa','rugby-sevens-women','Samoa','#0033A0','#FFFFFF'),
  ('south-africa','rugby-sevens-women','South Africa','#007749','#FFB81C'),
  ('wales','rugby-sevens-women','Wales','#C8102E','#FFFFFF')
on conflict (competition_slug, slug) do nothing;
