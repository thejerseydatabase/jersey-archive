-- Adds is_upcoming (announced-but-not-yet-playing expansion clubs get
-- their own "New expansion teams" section on a competition page instead
-- of being mixed into current teams) and the two upcoming NRL clubs:
-- Perth Bears (joining 2027) and Papua New Guinea Hunters (joining 2028).
--
-- The PNG Hunters already exist as a QLD Cup team (see qld_cup_teams.sql)
-- — that row and its jersey history stay exactly as QLD Cup. This adds a
-- SEPARATE new team row under NRL for their NRL era from 2028, rather
-- than moving the QLD Cup team, so their QLD Cup-era jerseys don't get
-- relabeled as NRL history. The "Also see" link on each team page will
-- connect the two automatically once both exist (same name, same sport).
--
-- Once each club actually starts playing, flip is_upcoming back to false
-- for that row (a quick Table Editor edit or one-line SQL update) — no
-- admin button for this yet since it only happens once per club.
-- Safe to re-run.

alter table teams add column if not exists is_upcoming boolean not null default false;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_upcoming, history_note) values
  ('perth-bears','nrl','Perth Bears','#000000','#FFD700', true, 'Joining the NRL in 2027.'),
  ('papua-new-guinea-hunters','nrl','Papua New Guinea Hunters','#CE1126','#000000', true, 'Joining the NRL in 2028.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_upcoming = excluded.is_upcoming, history_note = excluded.history_note;
