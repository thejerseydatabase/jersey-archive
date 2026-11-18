-- Adds World Club Challenge as a tag-only rugby league competition -
-- same pattern as Rugby League World Cup / Six Nations: a one-off
-- annual fixture between the NRL and Super League champions, not a
-- competition either team is actually "in", so it exists purely to be
-- tagged onto a jersey whose real home is the team's own NRL/Super
-- League entry.

insert into competitions (slug, sport_slug, name, tier, tag_only)
select 'world-club-challenge', 'rugby-league', 'World Club Challenge', 'top', true
where not exists (select 1 from competitions where slug = 'world-club-challenge');
