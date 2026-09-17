-- Adds Australia's men's (Socceroos) and women's (Matildas) national
-- football teams — they were simply never in either of the original
-- international_men_teams.sql / international_women_teams.sql lists, so
-- this isn't a merge-bug fix, just a missing country. Football's
-- International competition is already fully merged (confirmed via a
-- diagnostic query — Brazil's men's and women's rows already sit
-- together under 'international-men'), so both go straight in there.
-- Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('australia','international-men','Australia','#FFD700','#00843D'),
  ('australia-women','international-men','Australia Women','#FFD700','#00843D')
on conflict (competition_slug, slug) do nothing;
