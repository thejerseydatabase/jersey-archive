-- Normalizes the country-name spelling variants the International/Sevens
-- backfill left behind, since it just copied each team's own name as-is
-- and different sports spell the same country differently. Only touches
-- the `country` column (the cross-sport grouping value) - each team's
-- own display `name` is untouched, so a football page still reads
-- "Czech Republic" etc. exactly as before.
--
-- Safe to re-run.

update teams set country = 'Czechia' where country = 'Czech Republic';
update teams set country = 'Türkiye' where country = 'Turkey';
update teams set country = 'Hong Kong' where country in ('Hong Kong, China', 'Hong Kong China');

-- verify
select distinct country from teams where country in ('Czechia','Czech Republic','Türkiye','Turkey','Hong Kong','Hong Kong, China','Hong Kong China') order by country;
