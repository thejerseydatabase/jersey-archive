-- The European T20 Premier League's clubs never got a team-level
-- country set, so the map/region logic fell back to the competition's
-- own generic "Europe" region_group - showing up as an unresolvable
-- "Europe" bucket on the new Coverage Map instead of their real
-- countries.
--
-- Safe to re-run.

update teams set country = 'Northern Ireland' where competition_slug = 'etpl' and slug = 'belfast-wolves';
update teams set country = 'Netherlands' where competition_slug = 'etpl' and slug = 'rotterdam-dockers';
