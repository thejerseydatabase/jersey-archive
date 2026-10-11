-- Two small, unrelated fixes found after rolling out cricket's format
-- filter and the sport-wide team search:
--
-- 1. Ireland Interprovincial (cricket) was deliberately left untagged by
--    cricket_competition_formats.sql, since it covers all three formats
--    across the same four teams with no split into separate competitions
--    here. But an untagged competition is always shown regardless of
--    format, which meant it showed up under Test/ODI even though it's a
--    domestic interprovincial competition, not an international team.
--    Tags it with its real formats instead of leaving it an unscoped
--    wildcard - it'll still correctly show under First Class/One Day/T20,
--    just no longer under Test/ODI/T20I.
--
-- 2. Baseball's international competition (merged into one "International",
--    slug international-baseball-men, by international_gender_merge.sql)
--    never actually had an Australia team on the open/men's side (only a
--    placeholder "Southern Thunder (Men)"), and the one team on the
--    women's side ("Emeralds (Women)") had picked up a duplicate "Women"
--    suffix from an earlier gender-merge re-run and used a nickname
--    instead of the country name every other team in this competition
--    uses. Renames it to "Australia Women" (colors matched to the
--    Australia entries already used elsewhere on the site - gold primary,
--    green secondary), adds a proper "Australia" team for the open/men's
--    side, and adds the United States and Japan on the women's side too.
--
-- Safe to re-run.

update competitions set formats = array['First Class','One Day','T20']
  where slug = 'ireland-domestic' and sport_slug = 'cricket';

update teams set name = 'Australia Women', slug = 'australia-women',
  primary_color = '#FFD700', secondary_color = '#00843D'
  where competition_slug = 'international-baseball-men' and slug like 'emeralds-women%';

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('australia','international-baseball-men','Australia','#FFD700','#00843D'),
  ('united-states-women','international-baseball-men','United States Women','#002868','#BF0D3E'),
  ('japan-women','international-baseball-men','Japan Women','#BC002D','#FFFFFF')
on conflict (competition_slug, slug) do nothing;
