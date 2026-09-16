-- Corrects a mistake in nrl_expansion_teams.sql: the new 2028 NRL
-- expansion club is the Papua New Guinea CHIEFS, not the Hunters — the
-- Hunters are the existing QLD Cup team and aren't moving anywhere.
-- Safe to run whether or not you'd already run the earlier (wrong)
-- version — this removes that row if it's there and adds the correct one.

delete from teams
where competition_slug = 'nrl' and slug = 'papua-new-guinea-hunters' and is_upcoming = true;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_upcoming, history_note) values
  ('papua-new-guinea-chiefs','nrl','Papua New Guinea Chiefs','#CE1126','#000000', true, 'Joining the NRL in 2028.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_upcoming = excluded.is_upcoming, history_note = excluded.history_note;
