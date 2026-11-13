-- Adds the Six Nations Championship under Rugby Union, as a tag-only
-- competition - same pattern as the existing "Rugby World Cup" entry.
-- This is why it never showed up in the upload form's own competition
-- picker or had an "add new" option in the "also used in" tag field:
-- a tag-only competition exists purely to be tagged onto a jersey
-- whose real home is the team's own International entry, and
-- deliberately has no teams of its own - so it has to be added this
-- way (once), not created ad hoc the way a normal competition can be.
-- Once this runs, "Six Nations Championship" will show up as a pickable
-- option in that same "also used in" dropdown for England/France/
-- Ireland/Italy/Scotland/Wales's International rugby union jerseys.
--
-- Source: https://en.wikipedia.org/wiki/Six_Nations_Championship
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier, tag_only)
select 'six-nations-championship', 'rugby-union', 'Six Nations Championship', 'top', true
where not exists (select 1 from competitions where slug = 'six-nations-championship');
