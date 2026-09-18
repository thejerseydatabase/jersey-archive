-- Perth Bears (joining 2027) and Papua New Guinea Chiefs (joining
-- 2028) as upcoming NRL expansion teams. The PNG Chiefs are a
-- SEPARATE team from the Papua New Guinea Hunters, who already exist
-- on the site as a current QLD Cup team and aren't moving anywhere —
-- this adds a new, distinct NRL row for the Chiefs rather than
-- touching the Hunters' row or its jersey history at all.
--
-- This replaces/supersedes nrl_expansion_teams.sql and
-- nrl_expansion_fix.sql (an earlier version of this wrongly called the
-- new 2028 club the "PNG Hunters" too) — just run this one file, it's
-- safe to re-run regardless of whether either of those ran before.
--
-- Once a club actually starts playing, open its team page while signed
-- in as admin and use "Admin: team settings" -> "Move to active
-- roster" to move it off the expansion section permanently — no SQL
-- needed at that point.

alter table teams add column if not exists is_upcoming boolean not null default false;

delete from teams
where competition_slug = 'nrl' and slug = 'papua-new-guinea-hunters' and is_upcoming = true;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_upcoming, history_note) values
  ('perth-bears','nrl','Perth Bears','#000000','#FFD700', true, 'Joining the NRL in 2027.'),
  ('papua-new-guinea-chiefs','nrl','Papua New Guinea Chiefs','#CE1126','#000000', true, 'Joining the NRL in 2028. A separate club from the Papua New Guinea Hunters, who continue playing in the QLD Cup.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_upcoming = excluded.is_upcoming, history_note = excluded.history_note;
