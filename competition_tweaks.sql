-- A batch of naming/structure fixes:
-- 1. sort_order column on competitions, so a sport can pin specific
--    competitions to the front instead of pure alphabetical.
-- 2. Women's State of Origin (new competition).
-- 3. Rename "Premiership" -> "Gallagher Premiership" (rugby union).
-- 4. Rename the AFL *sport* to "Aussie Rules" (the AFL *competition*
--    keeps its name, since VFL and others also play under this sport).
-- 5. Rename ice hockey's Mighty Roos/Mighty Jills to Australia.
-- 6. Cricket ordering: International, IPL, BBL, Australia Domestic
--    pinned first (in that order); everything else falls back to
--    alphabetical.
-- 7. Split Queensland Bulls/Fire and South Australia Redbacks/Scorpions
--    into real separate men's and women's teams, and add a new
--    Australia Domestic (Women) competition.
-- Safe to re-run.

alter table competitions add column if not exists sort_order integer not null default 999;

-- 2. Women's State of Origin
insert into competitions (slug, sport_slug, name, tier) values
  ('state-of-origin-women','rugby-league','Women''s State of Origin','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('new-south-wales-blues','state-of-origin-women','New South Wales Blues','#003DA5','#FFFFFF'),
  ('queensland-maroons','state-of-origin-women','Queensland Maroons','#6A0032','#FFD700')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

-- 3. Premiership rename
update competitions set name = 'Gallagher Premiership' where slug = 'premiership-rugby';

-- 4. AFL sport rename (competition name untouched)
update sports set name = 'Aussie Rules' where slug = 'afl';

-- 5. Ice hockey representative team renames
update teams set slug = 'australia', name = 'Australia' where competition_slug = 'international-ice-hockey-men' and slug = 'mighty-roos';
update teams set slug = 'australia', name = 'Australia' where competition_slug = 'international-ice-hockey-women' and slug = 'mighty-jills';

-- 6. Cricket competition ordering
update competitions set sort_order = 1 where slug = 'international' and sport_slug = 'cricket';
update competitions set sort_order = 2 where slug = 'ipl';
update competitions set sort_order = 3 where slug = 'bbl';
update competitions set sort_order = 4 where slug = 'australia-domestic';

-- 7. Split Queensland/South Australia men's and women's cricket teams
update teams set slug = 'queensland-bulls', name = 'Queensland Bulls'
  where competition_slug = 'australia-domestic' and slug = 'queensland-bulls-fire';
update teams set slug = 'south-australia-redbacks', name = 'South Australia Redbacks'
  where competition_slug = 'australia-domestic' and slug = 'south-australia-redbacks-scorpions';

insert into competitions (slug, sport_slug, name, tier) values
  ('australia-domestic-women','cricket','Australia Domestic (Women)','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('act-meteors','australia-domestic-women','ACT Meteors','#003DA5','#FFD200'),
  ('new-south-wales-blues','australia-domestic-women','New South Wales Blues','#001E62','#FFFFFF'),
  ('queensland-fire','australia-domestic-women','Queensland Fire','#6A0032','#FFD700'),
  ('south-australia-scorpions','australia-domestic-women','South Australia Scorpions','#C8102E','#001E62'),
  ('tasmanian-tigers','australia-domestic-women','Tasmanian Tigers','#002664','#00843D'),
  ('victoria','australia-domestic-women','Victoria','#002664','#FFFFFF'),
  ('western-australia','australia-domestic-women','Western Australia','#000000','#FFD700')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
