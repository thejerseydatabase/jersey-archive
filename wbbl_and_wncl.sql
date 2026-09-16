-- Adds the WBBL (same 8 clubs/colors as the men's BBL) and turns the
-- earlier placeholder "Australia Domestic (Women)" competition into the
-- real WNCL, correcting the three team names that were guessed when it
-- was first added (NSW Blues -> NSW Breakers, SA Scorpions -> South
-- Australia, Tasmanian Tigers -> Tasmania Tigers). Slugs are left alone
-- so nothing that already links to these teams breaks. Safe to re-run.

-- WBBL
insert into competitions (slug, sport_slug, name, tier) values
  ('wbbl','cricket','WBBL','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adelaide-strikers','wbbl','Adelaide Strikers','#003DA5','#FFD200'),
  ('brisbane-heat','wbbl','Brisbane Heat','#00A99D','#EC008C'),
  ('hobart-hurricanes','wbbl','Hobart Hurricanes','#4B2E83','#00AEEF'),
  ('melbourne-renegades','wbbl','Melbourne Renegades','#C6007E','#000000'),
  ('melbourne-stars','wbbl','Melbourne Stars','#00843D','#FFD200'),
  ('perth-scorchers','wbbl','Perth Scorchers','#F57F17','#000000'),
  ('sydney-sixers','wbbl','Sydney Sixers','#EC008C','#000000'),
  ('sydney-thunder','wbbl','Sydney Thunder','#9ACD32','#5C2D91')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

-- WNCL: rename the placeholder competition and fix its team names
update competitions set name = 'WNCL', tier = 'top' where slug = 'australia-domestic-women';

update teams set name = 'New South Wales Breakers'
  where competition_slug = 'australia-domestic-women' and slug = 'new-south-wales-blues';
update teams set name = 'South Australia'
  where competition_slug = 'australia-domestic-women' and slug = 'south-australia-scorpions';
update teams set name = 'Tasmania Tigers'
  where competition_slug = 'australia-domestic-women' and slug = 'tasmanian-tigers';

-- Re-pin cricket's ordering now that WBBL and WNCL both need a spot
update competitions set sort_order = 1 where slug = 'international' and sport_slug = 'cricket';
update competitions set sort_order = 2 where slug = 'ipl';
update competitions set sort_order = 3 where slug = 'bbl';
update competitions set sort_order = 4 where slug = 'wbbl';
update competitions set sort_order = 5 where slug = 'australia-domestic';
update competitions set sort_order = 6 where slug = 'australia-domestic-women';
