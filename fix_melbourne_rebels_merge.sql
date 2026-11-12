-- The men's Melbourne Rebels folded after the 2023 season without ever
-- getting its own team row under the men's Super Rugby Pacific
-- competition. A bug in the team-matching logic (now fixed in app.js)
-- then silently merged a newly-uploaded men's jersey into the
-- separate, already-existing women's Melbourne Rebels team instead of
-- creating one, since all it had to go on was the matching club name
-- and sport - nothing distinguished "same club, different era" from
-- "same club, different (simultaneous) team" once it fell through to
-- its sport-wide fallback.
--
-- This creates the missing men's team and moves every jersey that was
-- actually tagged for the men's competition (but ended up attached to
-- the shared/women's team row) onto it - the women's jersey(s) are
-- untouched, since their own competition_slug is already correctly
-- 'super-rugby-pacific-women'.
--
-- Safe to re-run - the insert only fires if the men's row doesn't
-- already exist, and the update only moves rows still pointing at the
-- old (women's) team id.

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note)
select slug, 'super-rugby-pacific', name, primary_color, secondary_color, false, 'Folded after the 2023 season'
from teams
where id = '6b88a329-e22a-47ea-b943-730eb3eca5dc'
and not exists (
  select 1 from teams where slug = 'melbourne-rebels' and competition_slug = 'super-rugby-pacific'
);

update jerseys
set team_id = (select id from teams where slug = 'melbourne-rebels' and competition_slug = 'super-rugby-pacific')
where team_id = '6b88a329-e22a-47ea-b943-730eb3eca5dc'
  and competition_slug = 'super-rugby-pacific';
