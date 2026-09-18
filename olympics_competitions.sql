-- Adds an "Olympics" tag_only competition (same pattern as the World
-- Cup ones — never a primary competition, only ever tagged on via the
-- upload form's "also used in another competition" field) for every
-- sport currently on the site that's actually a current Olympic sport:
-- football, basketball, rugby union (sevens format), field hockey,
-- volleyball, baseball, ice hockey, and cricket (debuting at LA 2028).
-- Left out: netball, AFL, rugby league, gridiron — none of those are
-- Olympic sports.
--
-- Rugby union's entry is named "Olympics (Rugby Sevens)" since Olympic
-- rugby is the 7s format, a different competition/roster to the site's
-- existing 15-a-side "International (Men)" — worth keeping that
-- distinction visible rather than implying it's the same team/jerseys.
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier, tag_only) values
  ('olympics-football','football','Olympics','top',true),
  ('olympics-basketball','basketball','Olympics','top',true),
  ('olympics-rugby-sevens','rugby-union','Olympics (Rugby Sevens)','top',true),
  ('olympics-field-hockey','field-hockey','Olympics','top',true),
  ('olympics-volleyball','volleyball','Olympics','top',true),
  ('olympics-baseball','baseball','Olympics','top',true),
  ('olympics-ice-hockey','ice-hockey','Olympics','top',true),
  ('olympics-cricket','cricket','Olympics','top',true)
on conflict (slug) do nothing;
