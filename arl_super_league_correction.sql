-- Correction from your more detailed source: exactly 8 clubs left the
-- ARL for the rival Super League after the 1996 season — Auckland
-- (NZ) Warriors, Brisbane Broncos, Canberra Raiders, Canterbury
-- Bulldogs, Cronulla Sharks, North Queensland Cowboys, Penrith
-- Panthers, and Western Reds (Perth Reds). South Queensland Crushers
-- were NOT one of them — they stayed in the ARL all three years and
-- folded there at the end of 1997, so the earlier super-league-1997
-- row for them was wrong. Canberra Raiders should have been in the
-- Super League list and wasn't.
--
-- Also tightens the ARL-era history_notes for the 8 departing clubs to
-- say 1995-1996 specifically, rather than implying they were in the
-- ARL for its full 1995-1997 run. Safe to re-run.

delete from teams where competition_slug = 'super-league-1997' and slug = 'south-queensland-crushers';

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('canberra-raiders','super-league-1997','Canberra Raiders','#00843D','#FFD200', false,
   'Played the ARL in 1995-1996, then the rival Super League competition in 1997; continues today in the NRL.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;

update teams set history_note = 'Played the ARL in 1995-1996, then departed for the rival Super League competition in 1997; continues today in the NRL.'
where competition_slug = 'arl' and slug in (
  'brisbane-broncos','canterbury-bulldogs','cronulla-sharks',
  'north-queensland-cowboys','penrith-panthers','new-zealand-warriors','canberra-raiders'
);

update teams set history_note = 'Played the ARL in 1995-1996 before joining the rival Super League competition in 1997, then folded.'
where competition_slug = 'arl' and slug = 'western-reds';
