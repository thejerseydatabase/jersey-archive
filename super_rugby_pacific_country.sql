-- Follow-up to region_group_top_tier.sql's one deliberately-skipped item:
-- Super Rugby Pacific has no majority country (NZ and Australia each
-- have 5 teams, Fiji 1, and Moana Pasifika represents several Pacific
-- nations at once, not one), so there's no sensible single region_group
-- for the competition itself - this sets country per TEAM instead, same
-- mechanism as the A-League/MLS/NRL/NHL overrides already in place.
--
-- Moana Pasifika is deliberately left with no country, same as the
-- "representative" competitions - it represents Samoa, Tonga, the Cook
-- Islands, Niue and Tokelau all at once (based in Auckland, but not
-- itself a New Zealand team), so no single country fits.
--
-- Covers both super-rugby-pacific and super-rugby-pacific-women, in
-- case the women's competition reuses the same club names.
--
-- Safe to re-run.

update teams set country = 'New Zealand'
where competition_slug in ('super-rugby-pacific','super-rugby-pacific-women')
  and (name ilike '%blues%' or name ilike '%chiefs%' or name ilike '%crusaders%'
    or name ilike '%highlanders%' or name ilike '%hurricanes%');

update teams set country = 'Australia'
where competition_slug in ('super-rugby-pacific','super-rugby-pacific-women')
  and (name ilike '%brumbies%' or name ilike '%reds%' or name ilike '%waratahs%'
    or name ilike '%force%' or name ilike '%rebels%');

update teams set country = 'Fiji'
where competition_slug in ('super-rugby-pacific','super-rugby-pacific-women')
  and name ilike '%drua%';

-- verify - every Super Rugby Pacific team except Moana Pasifika should
-- now have a country; Moana Pasifika showing up here (null) is expected.
select competition_slug, name, country from teams
where competition_slug in ('super-rugby-pacific','super-rugby-pacific-women')
order by competition_slug, name;
