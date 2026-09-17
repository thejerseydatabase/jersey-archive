-- Merges Volleyball's and Field Hockey's separate International (Men) /
-- International (Women) competitions into one "International" each, same
-- pattern as football/basketball/rugby league/baseball/ice hockey.
--
-- Uses a per-row INSERT ... ON CONFLICT DO NOTHING rather than a bulk
-- UPDATE — a bulk UPDATE is all-or-nothing, and that's exactly what
-- caused the "Brazil Women Women" mess earlier when a partial run
-- collided with a later one. This way, one problem row can only skip
-- itself; it can't take out the whole competition's teams or leave any
-- stranded (teams.competition_slug cascades on delete, so a team left
-- behind when its old competition is removed would just vanish).
-- Safe to re-run — every step is a no-op once done.

-- ============ Volleyball ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, is_upcoming, history_note, formats)
select
  case when name !~* '\bwomen\b' then slug || '-women' else slug end,
  'international-volleyball-men',
  case when name !~* '\bwomen\b' then name || ' Women' else name end,
  primary_color, secondary_color, is_active, is_upcoming, history_note, formats
from teams
where competition_slug = 'international-volleyball-women'
on conflict (competition_slug, slug) do nothing;

delete from teams where competition_slug = 'international-volleyball-women';
delete from competitions where slug = 'international-volleyball-women';
update competitions set name = 'International' where slug = 'international-volleyball-men';

-- ============ Field Hockey ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, is_upcoming, history_note, formats)
select
  case when name !~* '\bwomen\b' then slug || '-women' else slug end,
  'international-field-hockey-men',
  case when name !~* '\bwomen\b' then name || ' Women' else name end,
  primary_color, secondary_color, is_active, is_upcoming, history_note, formats
from teams
where competition_slug = 'international-field-hockey-women'
on conflict (competition_slug, slug) do nothing;

delete from teams where competition_slug = 'international-field-hockey-women';
delete from competitions where slug = 'international-field-hockey-women';
update competitions set name = 'International' where slug = 'international-field-hockey-men';
