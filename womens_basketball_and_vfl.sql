-- 1. Women's international basketball: tops up the list (Belgium already
--    existed) into whichever competition currently holds the women's
--    side — the still-separate "International (Women)" if you haven't
--    run the earlier merge migration, or the merged "International" if
--    you have — resolved automatically, same approach as ice hockey.
-- 2. Adds the VFL (Aussie Rules) as a new competition. A few notes:
--    - Names combine the club with its moniker (e.g. "Box Hill Hawks")
--      since several clubs share a bare name otherwise; the (A)/(R)
--      tags in your list were left off since they're status labels, not
--      part of the name.
--    - "Tasmania Devils" appeared in both your current and former lists
--      with the exact same name — added once, under current teams.
--    - A handful of former entries (old "(S)" seconds-era Carlton,
--      Collingwood, Essendon... wait, see below) share an identical
--      name with a current club and were skipped for the same reason —
--      noted per-club below where the moniker differed enough to add
--      both eras as distinct teams.
--
-- Colors: reused from elsewhere on the site where the same country/club
-- already exists; everything else (especially the VFL former teams) is a
-- generic placeholder — I have no real color knowledge for most of these
-- clubs. Safe to re-run.

-- ============ Women's international basketball ============
with target as (
  select coalesce(
    (select slug from competitions where slug = 'international-basketball-women'),
    'international-basketball-men'
  ) as slug
)
insert into teams (slug, competition_slug, name, primary_color, secondary_color)
select
  t.slug || case when target.slug = 'international-basketball-men' then '-women' else '' end,
  target.slug,
  t.name || case when target.slug = 'international-basketball-men' then ' Women' else '' end,
  t.primary_color, t.secondary_color
from (values
  ('united-states','United States','#002868','#BF0D3E'),
  ('france','France','#002654','#FFFFFF'),
  ('australia','Australia','#FFD700','#00843D'),
  ('china','China','#DE2910','#FFDE00'),
  ('spain','Spain','#C60B1E','#FFC400'),
  ('canada','Canada','#FF0000','#FFFFFF'),
  ('nigeria','Nigeria','#008751','#FFFFFF'),
  ('brazil','Brazil','#009739','#FEDD00'),
  ('japan','Japan','#BC002D','#FFFFFF'),
  ('germany','Germany','#DD0000','#000000'),
  ('serbia','Serbia','#C6363C','#0C4076'),
  ('puerto-rico','Puerto Rico','#0044FF','#CE1126'),
  ('italy','Italy','#0F4C81','#FFFFFF'),
  ('south-korea','South Korea','#C60C30','#0047A0'),
  ('turkey','Turkey','#E30A17','#FFFFFF'),
  ('czech-republic','Czech Republic','#D7141A','#11457E'),
  ('mali','Mali','#14B53A','#FCD116'),
  ('hungary','Hungary','#CD2A3E','#436F4D'),
  ('colombia','Colombia','#FCD116','#003893')
) as t(slug, name, primary_color, secondary_color)
cross join target
on conflict (competition_slug, slug) do nothing;

-- ============ VFL (Aussie Rules) ============
insert into competitions (slug, sport_slug, name, tier) values
  ('vfl','afl','VFL','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('box-hill-hawks','vfl','Box Hill Hawks','#5C2D91','#FFD700'),
  ('brisbane-lions-vfl','vfl','Brisbane Lions','#6A0032','#FFD700'),
  ('carlton-blues','vfl','Carlton Blues','#002664','#FFFFFF'),
  ('casey-demons','vfl','Casey Demons','#CE1126','#002664'),
  ('coburg-lions','vfl','Coburg Lions','#5C2D91','#FFD700'),
  ('collingwood-magpies','vfl','Collingwood Magpies','#000000','#FFFFFF'),
  ('essendon-bombers','vfl','Essendon Bombers','#CE1126','#000000'),
  ('footscray-bulldogs','vfl','Footscray Bulldogs','#002664','#CE1126'),
  ('frankston-dolphins','vfl','Frankston Dolphins','#5C2D91','#FFD700'),
  ('geelong-cats','vfl','Geelong Cats','#002664','#FFFFFF'),
  ('gold-coast-suns-vfl','vfl','Gold Coast Suns','#FF0000','#FFD700'),
  ('gws-giants-vfl','vfl','Greater Western Sydney Giants','#F57F17','#000000'),
  ('north-melbourne-kangaroos','vfl','North Melbourne Kangaroos','#002664','#FFFFFF'),
  ('port-melbourne-borough','vfl','Port Melbourne Borough','#5C2D91','#FFD700'),
  ('richmond-tigers','vfl','Richmond Tigers','#FFD700','#000000'),
  ('sandringham-zebras','vfl','Sandringham Zebras','#000000','#FFFFFF'),
  ('st-kilda-saints','vfl','St Kilda Saints','#CE1126','#000000'),
  ('southport-sharks','vfl','Southport Sharks','#002664','#00AEEF'),
  ('sydney-swans-vfl','vfl','Sydney Swans','#CE1126','#FFFFFF'),
  ('tasmania-devils','vfl','Tasmania Devils','#5C2D91','#00843D'),
  ('werribee-tigers','vfl','Werribee Tigers','#FFD700','#000000'),
  ('williamstown-seagulls','vfl','Williamstown Seagulls','#00205B','#FFFFFF')
on conflict (competition_slug, slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active) values
  ('albert-park-parkites','vfl','Albert Park Parkites','#000000','#FFFFFF',false),
  ('aspley-hornets','vfl','Aspley Hornets','#FFD700','#000000',false),
  ('ballarat-swans','vfl','Ballarat Swans','#CE1126','#FFFFFF',false),
  ('ballarat-imperial-imps','vfl','Ballarat Imperial Imps','#5C2D91','#FFD700',false),
  ('bendigo-gold','vfl','Bendigo Gold','#FFD700','#000000',false),
  ('berwick-gippslanders','vfl','Berwick Gippslanders','#00843D','#FFFFFF',false),
  ('brighton-penguins','vfl','Brighton Penguins','#000000','#FFFFFF',false),
  ('brighton-caulfield-penguins','vfl','Brighton-Caulfield Penguins','#000000','#87CEEB',false),
  ('brunswick-magpies','vfl','Brunswick Magpies','#000000','#FFFFFF',false),
  ('camberwell-cobras','vfl','Camberwell Cobras','#5C2D91','#000000',false),
  ('caulfield-bears','vfl','Caulfield Bears','#000000','#FFD700',false),
  ('dandenong-dandies','vfl','Dandenong Dandies','#CE1126','#000000',false),
  ('east-melbourne','vfl','East Melbourne','#002664','#FFFFFF',false),
  ('essendon-dons','vfl','Essendon Dons','#CE1126','#000000',false),
  ('essendon-dreadnoughts','vfl','Essendon Dreadnoughts','#CE1126','#FFD700',false),
  ('fitzroy-maroons','vfl','Fitzroy Maroons','#6A0032','#FFD700',false),
  ('footscray-tricolours','vfl','Footscray Tricolours','#002664','#CE1126',false),
  ('geelong-pivotonians','vfl','Geelong Pivotonians','#002664','#FFD700',false),
  ('geelong','vfl','Geelong','#002664','#FFFFFF',false),
  ('geelong-west-roosters','vfl','Geelong West Roosters','#000000','#FFD700',false),
  ('hawthorn-mayblooms','vfl','Hawthorn Mayblooms','#5C2D91','#FFD700',false),
  ('kilsyth-cougars','vfl','Kilsyth Cougars','#000000','#00843D',false),
  ('melbourne-redlegs','vfl','Melbourne Redlegs','#CE1126','#002664',false),
  ('melbourne-city-vfl','vfl','Melbourne City','#002664','#FFFFFF',false),
  ('moorabbin-kangaroos-i','vfl','Moorabbin Kangaroos (I)','#002664','#FFD700',false),
  ('moorabbin-kangas-ii','vfl','Moorabbin Kangas (II)','#002664','#87CEEB',false),
  ('mordialloc-bloodhounds','vfl','Mordialloc Bloodhounds','#000000','#FFFFFF',false),
  ('murray-kangaroos','vfl','Murray Kangaroos','#5C2D91','#FFD700',false),
  ('north-ballarat-roosters','vfl','North Ballarat Roosters','#CE1126','#000000',false),
  ('north-melbourne-northerners','vfl','North Melbourne Northerners','#002664','#87CEEB',false),
  ('northcote-dragons','vfl','Northcote Dragons','#CE1126','#FFD700',false),
  ('oakleigh-oaks','vfl','Oakleigh Oaks','#5C2D91','#000000',false),
  ('prahran','vfl','Prahran','#87CEEB','#FFFFFF',false),
  ('prahran-two-blues','vfl','Prahran Two Blues','#002664','#FFFFFF',false),
  ('preston-bullants','vfl','Preston Bullants','#CE1126','#000000',false),
  ('south-ballarat','vfl','South Ballarat','#5C2D91','#FFD700',false),
  ('south-melbourne-southerners','vfl','South Melbourne Southerners','#CE1126','#000000',false),
  ('south-williamstown','vfl','South Williamstown','#00205B','#FFFFFF',false),
  ('sunshine-crows','vfl','Sunshine Crows','#000000','#00843D',false),
  ('traralgon-maroons','vfl','Traralgon Maroons','#6A0032','#FFD700',false),
  ('university-students','vfl','University Students','#002664','#FFFFFF',false),
  ('waverley-panthers','vfl','Waverley Panthers','#000000','#FFD700',false),
  ('west-melbourne-wests','vfl','West Melbourne Wests','#CE1126','#FFFFFF',false),
  ('yarraville-eagles','vfl','Yarraville Eagles','#5C2D91','#FFD700',false)
on conflict (competition_slug, slug) do nothing;
