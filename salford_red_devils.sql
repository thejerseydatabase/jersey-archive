-- Adds "Salford Red Devils" as its own (defunct) team under Super League
-- for any pre-2025 jersey. The club was liquidated/ceased in 2025 - the
-- phoenix club "Salford RLFC" (already in the database under
-- Championship, see rfl_championship_full_names.sql) is the one to use
-- for 2025-26 onward.
--
-- Confirmed this team was never actually seeded - super_league_teams.sql
-- only has the current 14-club 2025-26+ lineup, which never included
-- Salford to begin with since they'd already dropped out by the time
-- that file was written. The earlier concern that jerseys might wrongly
-- match the unrelated "Salford" women's team (RFL Women's Championship)
-- via the sport-wide team lookup no longer applies once this exists,
-- since an exact competition match always wins first.
--
-- Colour sources disagree on the third colour (black vs. blue) - red and
-- white are solid, secondary colour here is a guess, flag if you know
-- the real one.
--
-- Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('salford-red-devils', 'super-league', 'Salford Red Devils', '#D2202B', '#FFFFFF')
on conflict (competition_slug, slug) do update
  set name = excluded.name;
