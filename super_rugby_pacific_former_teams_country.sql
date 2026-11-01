-- Fills in the remaining Super Rugby Pacific teams your verify query
-- showed as still null - these are the former teams from before the
-- competition split in 2021 (South Africa moved to the URC; Japan's
-- Sunwolves and Argentina's Jaguares left the competition entirely
-- around the same time). All single-country, unlike Moana Pasifika, so
-- no reason to leave these unset.
--
-- Safe to re-run.

update teams set country = 'South Africa'
where competition_slug = 'super-rugby-pacific'
  and (name ilike '%bulls%' or name ilike '%cheetahs%' or name ilike '%griquas%'
    or name ilike '%lions%' or name ilike '%sharks%' or name ilike '%southern kings%'
    or name ilike '%stormers%' or name ilike '%pumas%');

update teams set country = 'Argentina'
where competition_slug = 'super-rugby-pacific' and name ilike '%jaguares%';

update teams set country = 'Japan'
where competition_slug = 'super-rugby-pacific' and name ilike '%sunwolves%';

-- verify - should be empty except Moana Pasifika
select competition_slug, name, country from teams
where competition_slug in ('super-rugby-pacific','super-rugby-pacific-women') and country is null
order by name;
