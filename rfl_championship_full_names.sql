-- Renames the Championship clubs that were still on their short name to
-- their full official name. Checked against your list - these 7 were
-- short; the rest (Batley Bulldogs, Dewsbury Rams, Doncaster RLFC, Goole
-- Vikings, London Broncos, Newcastle Thunder, North Wales Crusaders,
-- Rochdale Hornets, Salford RLFC, Sheffield Eagles, Whitehaven RLFC,
-- Widnes Vikings) already had their full name.
--
-- "Birmingham Hurricanes" isn't a thing - the club's official name is
-- "Midlands Hurricanes" (Birmingham is just the city they're based in/
-- play at), already correct in the database, so left alone here.
--
-- Safe to re-run.

update teams set name = 'Barrow Raiders' where competition_slug = 'championship' and slug = 'barrow';
update teams set name = 'Halifax Panthers' where competition_slug = 'championship' and slug = 'halifax';
update teams set name = 'Hunslet RLFC' where competition_slug = 'championship' and slug = 'hunslet';
update teams set name = 'Keighley Cougars' where competition_slug = 'championship' and slug = 'keighley';
update teams set name = 'Oldham RLFC' where competition_slug = 'championship' and slug = 'oldham';
update teams set name = 'Swinton Lions' where competition_slug = 'championship' and slug = 'swinton';
update teams set name = 'Workington Town' where competition_slug = 'championship' and slug = 'workington';
