-- Adds Detroit Clutch, the PWHL's 12th team (Western Conference),
-- announced May 2026 for the 2026-27 season - left out of
-- pwhl_competition_and_teams.sql originally since it wasn't in the
-- requested team list.
--
-- Colors per its Wikipedia infobox: "Black, silver, white and red" (no
-- hex given) - black/silver are the two main colors per the expansion
-- announcement (white tertiary, red an accent), same approximate-hex
-- caveat as the other 11 teams.
--
-- Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color, conference) values
  ('detroit-clutch','pwhl','Detroit Clutch','#111111','#A7A9AC','Western')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color, conference = excluded.conference;
