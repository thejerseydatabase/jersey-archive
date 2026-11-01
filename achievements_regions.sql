-- Adds the Regions achievement badges (Oceania Wanderer, Asia Explorer,
-- etc.) - the "each team already IS a country" idea from the
-- achievements mock-up. Fully buildable now because of the country
-- data backfilled earlier this session (teams.country /
-- competitions.region_group) - this was never blocked on anything,
-- unlike the separate (and much bigger, still just a mock-up) Levels
-- idea.
--
-- A jersey's "effective country" is coalesce(team.country,
-- competitions.region_group) - the same rule used throughout this
-- session's region/country work. country_region below maps that
-- country to one of 6 continents (~217 country-name variants, since
-- different sports spell some countries differently - Czechia/Czech
-- Republic, Türkiye/Turkey, etc. all map to the right one).
--
-- Safe to re-run.

create table if not exists country_region (
  country text primary key,
  region text not null
);

alter table country_region enable row level security;
drop policy if exists "country_region is publicly readable" on country_region;
create policy "country_region is publicly readable" on country_region for select using (true);

insert into country_region (country, region) values
  ('Australia', 'Oceania'),
  ('New Zealand', 'Oceania'),
  ('Fiji', 'Oceania'),
  ('Papua New Guinea', 'Oceania'),
  ('Samoa', 'Oceania'),
  ('Tonga', 'Oceania'),
  ('Vanuatu', 'Oceania'),
  ('Solomon Islands', 'Oceania'),
  ('Cook Islands', 'Oceania'),
  ('Niue', 'Oceania'),
  ('Guam', 'Oceania'),
  ('China', 'Asia'),
  ('Japan', 'Asia'),
  ('South Korea', 'Asia'),
  ('Korea', 'Asia'),
  ('North Korea', 'Asia'),
  ('DPR Korea', 'Asia'),
  ('India', 'Asia'),
  ('Pakistan', 'Asia'),
  ('Bangladesh', 'Asia'),
  ('Sri Lanka', 'Asia'),
  ('Nepal', 'Asia'),
  ('Bhutan', 'Asia'),
  ('Maldives', 'Asia'),
  ('Afghanistan', 'Asia'),
  ('Myanmar', 'Asia'),
  ('Thailand', 'Asia'),
  ('Vietnam', 'Asia'),
  ('Laos', 'Asia'),
  ('Cambodia', 'Asia'),
  ('Malaysia', 'Asia'),
  ('Singapore', 'Asia'),
  ('Indonesia', 'Asia'),
  ('Philippines', 'Asia'),
  ('Brunei', 'Asia'),
  ('Timor-Leste', 'Asia'),
  ('Hong Kong', 'Asia'),
  ('Macau', 'Asia'),
  ('Chinese Taipei', 'Asia'),
  ('Mongolia', 'Asia'),
  ('Kazakhstan', 'Asia'),
  ('Uzbekistan', 'Asia'),
  ('Turkmenistan', 'Asia'),
  ('Kyrgyzstan', 'Asia'),
  ('Tajikistan', 'Asia'),
  ('Türkiye', 'Asia'),
  ('Israel', 'Asia'),
  ('Palestine', 'Asia'),
  ('Lebanon', 'Asia'),
  ('Syria', 'Asia'),
  ('Jordan', 'Asia'),
  ('Iraq', 'Asia'),
  ('Iran', 'Asia'),
  ('Saudi Arabia', 'Asia'),
  ('United Arab Emirates', 'Asia'),
  ('Qatar', 'Asia'),
  ('Kuwait', 'Asia'),
  ('Bahrain', 'Asia'),
  ('Oman', 'Asia'),
  ('Yemen', 'Asia'),
  ('Armenia', 'Asia'),
  ('Georgia', 'Asia'),
  ('Azerbaijan', 'Asia'),
  ('England', 'Europe'),
  ('England C', 'Europe'),
  ('Scotland', 'Europe'),
  ('Wales', 'Europe'),
  ('Northern Ireland', 'Europe'),
  ('Ireland', 'Europe'),
  ('Great Britain', 'Europe'),
  ('France', 'Europe'),
  ('Germany', 'Europe'),
  ('Spain', 'Europe'),
  ('Italy', 'Europe'),
  ('Portugal', 'Europe'),
  ('Netherlands', 'Europe'),
  ('Belgium', 'Europe'),
  ('Luxembourg', 'Europe'),
  ('Switzerland', 'Europe'),
  ('Austria', 'Europe'),
  ('Denmark', 'Europe'),
  ('Norway', 'Europe'),
  ('Sweden', 'Europe'),
  ('Finland', 'Europe'),
  ('Iceland', 'Europe'),
  ('Poland', 'Europe'),
  ('Czechia', 'Europe'),
  ('Slovakia', 'Europe'),
  ('Hungary', 'Europe'),
  ('Romania', 'Europe'),
  ('Bulgaria', 'Europe'),
  ('Greece', 'Europe'),
  ('Croatia', 'Europe'),
  ('Slovenia', 'Europe'),
  ('Serbia', 'Europe'),
  ('Bosnia and Herzegovina', 'Europe'),
  ('Bosnia & Herzegovina', 'Europe'),
  ('Montenegro', 'Europe'),
  ('North Macedonia', 'Europe'),
  ('Macedonia', 'Europe'),
  ('Albania', 'Europe'),
  ('Kosovo', 'Europe'),
  ('Moldova', 'Europe'),
  ('Ukraine', 'Europe'),
  ('Belarus', 'Europe'),
  ('Russia', 'Europe'),
  ('Estonia', 'Europe'),
  ('Latvia', 'Europe'),
  ('Lithuania', 'Europe'),
  ('Malta', 'Europe'),
  ('Cyprus', 'Europe'),
  ('Monaco', 'Europe'),
  ('San Marino', 'Europe'),
  ('Liechtenstein', 'Europe'),
  ('Andorra', 'Europe'),
  ('Faroe Islands', 'Europe'),
  ('Gibraltar', 'Europe'),
  ('Jersey', 'Europe'),
  ('Guernsey', 'Europe'),
  ('Isle of Man', 'Europe'),
  ('St Helena', 'Europe'),
  ('South Africa', 'Africa'),
  ('Namibia', 'Africa'),
  ('Botswana', 'Africa'),
  ('Zimbabwe', 'Africa'),
  ('Zambia', 'Africa'),
  ('Malawi', 'Africa'),
  ('Mozambique', 'Africa'),
  ('Eswatini', 'Africa'),
  ('Lesotho', 'Africa'),
  ('Tanzania', 'Africa'),
  ('Kenya', 'Africa'),
  ('Uganda', 'Africa'),
  ('Rwanda', 'Africa'),
  ('Burundi', 'Africa'),
  ('Ethiopia', 'Africa'),
  ('Somalia', 'Africa'),
  ('Sudan', 'Africa'),
  ('South Sudan', 'Africa'),
  ('Egypt', 'Africa'),
  ('Libya', 'Africa'),
  ('Tunisia', 'Africa'),
  ('Algeria', 'Africa'),
  ('Morocco', 'Africa'),
  ('Nigeria', 'Africa'),
  ('Ghana', 'Africa'),
  ('Ivory Coast', 'Africa'),
  ('Cote D''Ivoire', 'Africa'),
  ('Senegal', 'Africa'),
  ('Mali', 'Africa'),
  ('Cameroon', 'Africa'),
  ('Gabon', 'Africa'),
  ('Chad', 'Africa'),
  ('Niger', 'Africa'),
  ('Guinea', 'Africa'),
  ('Sierra Leone', 'Africa'),
  ('Liberia', 'Africa'),
  ('Burkina Faso', 'Africa'),
  ('Togo', 'Africa'),
  ('Benin', 'Africa'),
  ('Angola', 'Africa'),
  ('Madagascar', 'Africa'),
  ('Mauritius', 'Africa'),
  ('Seychelles', 'Africa'),
  ('Central African Republic', 'Africa'),
  ('Equatorial Guinea', 'Africa'),
  ('Gambia', 'Africa'),
  ('Mauritania', 'Africa'),
  ('Djibouti', 'Africa'),
  ('United States', 'North America'),
  ('USA', 'North America'),
  ('Canada', 'North America'),
  ('Mexico', 'North America'),
  ('Bermuda', 'North America'),
  ('Jamaica', 'North America'),
  ('Cuba', 'North America'),
  ('Haiti', 'North America'),
  ('Dominican Republic', 'North America'),
  ('Puerto Rico', 'North America'),
  ('Bahamas', 'North America'),
  ('Barbados', 'North America'),
  ('Trinidad and Tobago', 'North America'),
  ('Belize', 'North America'),
  ('Costa Rica', 'North America'),
  ('Panama', 'North America'),
  ('Guatemala', 'North America'),
  ('Honduras', 'North America'),
  ('Nicaragua', 'North America'),
  ('El Salvador', 'North America'),
  ('Cayman Islands', 'North America'),
  ('British Virgin Islands', 'North America'),
  ('Turks and Caicos Islands', 'North America'),
  ('Antigua and Barbuda', 'North America'),
  ('Antigua & Barbuda', 'North America'),
  ('Dominica', 'North America'),
  ('Grenada', 'North America'),
  ('St Kitts & Nevis', 'North America'),
  ('Saint Vincent and the Grenadines', 'North America'),
  ('Montserrat', 'North America'),
  ('Guadeloupe', 'North America'),
  ('Sint Maarten', 'North America'),
  ('St Maarten', 'North America'),
  ('St Eustatius', 'North America'),
  ('São Tomé and Príncipe', 'Africa'),
  ('Brazil', 'South America'),
  ('Argentina', 'South America'),
  ('Chile', 'South America'),
  ('Uruguay', 'South America'),
  ('Paraguay', 'South America'),
  ('Bolivia', 'South America'),
  ('Peru', 'South America'),
  ('Ecuador', 'South America'),
  ('Colombia', 'South America'),
  ('Venezuela', 'South America'),
  ('Guyana', 'South America'),
  ('Suriname', 'South America'),
  ('French Guiana', 'South America')
on conflict (country) do update set region = excluded.region;

insert into badges (slug, label, description, sort_order) values
  ('oceania-wanderer',        'Oceania Wanderer',  'Uploaded a jersey from a team or country in Oceania.', 160),
  ('asia-explorer',           'Asia Explorer',      'Uploaded a jersey from a team or country in Asia.', 170),
  ('european-tour',           'European Tour',      'Uploaded a jersey from a team or country in Europe.', 180),
  ('african-expedition',      'African Expedition', 'Uploaded a jersey from a team or country in Africa.', 190),
  ('north-america-explorer',  'North America',      'Uploaded a jersey from a team or country in North America.', 200),
  ('south-america-explorer',  'South America',      'Uploaded a jersey from a team or country in South America.', 210),
  ('grand-tour',               'Grand Tour',         'Uploaded a jersey from every region - all 6.', 220)
on conflict (slug) do update set label = excluded.label, description = excluded.description, sort_order = excluded.sort_order;

create or replace function check_and_award_badges(p_user_id uuid)
returns void as $$
declare
  jersey_count integer;
  logo_count integer;
  collection_count integer;
  sport_count integer;
  user_sport_count integer;
  comp_count integer;
  mfr_count integer;
  has_home boolean;
  has_away boolean;
  has_alt boolean;
  v_label text;
  region_slugs text[][] := array[
    array['Oceania','oceania-wanderer'],
    array['Asia','asia-explorer'],
    array['Europe','european-tour'],
    array['Africa','african-expedition'],
    array['North America','north-america-explorer'],
    array['South America','south-america-explorer']
  ];
  rs text[];
  region_count integer := 0;
begin
  if p_user_id is null then return; end if;

  select count(*) into jersey_count from jerseys where uploaded_by = p_user_id and status = 'approved';

  select count(*) into logo_count from (
    select id from team_logos where proposed_by = p_user_id
    union all
    select id from competition_logos where proposed_by = p_user_id
  ) l;

  select count(*) into collection_count from collection_items where user_id = p_user_id;

  select count(*) into sport_count from sports;
  select count(distinct c.sport_slug) into user_sport_count
  from jerseys j
  join teams t on t.id = j.team_id
  join competitions c on c.slug = t.competition_slug
  where j.uploaded_by = p_user_id and j.status = 'approved';

  select count(distinct t.competition_slug) into comp_count
  from jerseys j join teams t on t.id = j.team_id
  where j.uploaded_by = p_user_id and j.status = 'approved';

  select count(distinct lower(trim(j.manufacturer))) into mfr_count
  from jerseys j
  where j.uploaded_by = p_user_id and j.status = 'approved' and coalesce(trim(j.manufacturer), '') <> '';

  select exists(select 1 from jerseys where uploaded_by = p_user_id and status = 'approved' and type = 'Home') into has_home;
  select exists(select 1 from jerseys where uploaded_by = p_user_id and status = 'approved' and type = 'Away') into has_away;
  select exists(select 1 from jerseys where uploaded_by = p_user_id and status = 'approved' and type = 'Alternate') into has_alt;

  if jersey_count >= 1 then
    select j.season || ' ' || t.name || ' ' || j.type into v_label
    from jerseys j join teams t on t.id = j.team_id
    where j.uploaded_by = p_user_id and j.status = 'approved'
    order by j.approved_at asc, j.id asc limit 1 offset 0;
    insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'first-upload', v_label) on conflict do nothing;
  end if;
  if jersey_count >= 10 then
    select j.season || ' ' || t.name || ' ' || j.type into v_label
    from jerseys j join teams t on t.id = j.team_id
    where j.uploaded_by = p_user_id and j.status = 'approved'
    order by j.approved_at asc, j.id asc limit 1 offset 9;
    insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'ten-uploads', v_label) on conflict do nothing;
  end if;
  if jersey_count >= 50 then
    select j.season || ' ' || t.name || ' ' || j.type into v_label
    from jerseys j join teams t on t.id = j.team_id
    where j.uploaded_by = p_user_id and j.status = 'approved'
    order by j.approved_at asc, j.id asc limit 1 offset 49;
    insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'fifty-uploads', v_label) on conflict do nothing;
  end if;
  if jersey_count >= 100 then
    select j.season || ' ' || t.name || ' ' || j.type into v_label
    from jerseys j join teams t on t.id = j.team_id
    where j.uploaded_by = p_user_id and j.status = 'approved'
    order by j.approved_at asc, j.id asc limit 1 offset 99;
    insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'hundred-uploads', v_label) on conflict do nothing;
  end if;
  if jersey_count >= 500 then
    select j.season || ' ' || t.name || ' ' || j.type into v_label
    from jerseys j join teams t on t.id = j.team_id
    where j.uploaded_by = p_user_id and j.status = 'approved'
    order by j.approved_at asc, j.id asc limit 1 offset 499;
    insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'five-hundred-uploads', v_label) on conflict do nothing;
  end if;

  if logo_count >= 1 then
    select label into v_label from (
      select t.name || ' crest' as label, tl.approved_at as approved_at, tl.id as id
      from team_logos tl join teams t on t.id = tl.team_id where tl.proposed_by = p_user_id
      union all
      select c.name || ' crest' as label, cl.approved_at as approved_at, cl.id as id
      from competition_logos cl join competitions c on c.slug = cl.competition_slug where cl.proposed_by = p_user_id
    ) x order by approved_at asc, id asc limit 1 offset 0;
    insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'first-logo', v_label) on conflict do nothing;
  end if;
  if logo_count >= 5 then
    select label into v_label from (
      select t.name || ' crest' as label, tl.approved_at as approved_at, tl.id as id
      from team_logos tl join teams t on t.id = tl.team_id where tl.proposed_by = p_user_id
      union all
      select c.name || ' crest' as label, cl.approved_at as approved_at, cl.id as id
      from competition_logos cl join competitions c on c.slug = cl.competition_slug where cl.proposed_by = p_user_id
    ) x order by approved_at asc, id asc limit 1 offset 4;
    insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'five-logos', v_label) on conflict do nothing;
  end if;
  if logo_count >= 25 then
    select label into v_label from (
      select t.name || ' crest' as label, tl.approved_at as approved_at, tl.id as id
      from team_logos tl join teams t on t.id = tl.team_id where tl.proposed_by = p_user_id
      union all
      select c.name || ' crest' as label, cl.approved_at as approved_at, cl.id as id
      from competition_logos cl join competitions c on c.slug = cl.competition_slug where cl.proposed_by = p_user_id
    ) x order by approved_at asc, id asc limit 1 offset 24;
    insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'twenty-five-logos', v_label) on conflict do nothing;
  end if;

  if collection_count >= 10 then
    select j.season || ' ' || t.name || ' ' || j.type into v_label
    from collection_items ci join jerseys j on j.id = ci.jersey_id join teams t on t.id = j.team_id
    where ci.user_id = p_user_id
    order by ci.created_at asc, ci.id asc limit 1 offset 9;
    insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'collector-ten', v_label) on conflict do nothing;
  end if;

  if sport_count > 0 and user_sport_count >= sport_count then insert into user_badges(user_id, badge_slug) values (p_user_id, 'all-sports') on conflict do nothing; end if;
  if comp_count >= 10 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'ten-competitions') on conflict do nothing; end if;
  if comp_count >= 25 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'twenty-five-competitions') on conflict do nothing; end if;
  if mfr_count >= 10 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'ten-manufacturers') on conflict do nothing; end if;

  if has_home and has_away and has_alt then
    select label into v_label from (
      select (j.season || ' ' || t.name || ' ' || j.type) as label, j.approved_at,
        row_number() over (partition by j.type order by j.approved_at asc, j.id asc) as rn
      from jerseys j join teams t on t.id = j.team_id
      where j.uploaded_by = p_user_id and j.status = 'approved' and j.type in ('Home','Away','Alternate')
    ) x where rn = 1 order by approved_at desc limit 1;
    insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'full-range', v_label) on conflict do nothing;
  end if;

  select (j.season || ' ' || t.name || ' ' || j.type) into v_label
  from jerseys j join teams t on t.id = j.team_id
  where j.uploaded_by = p_user_id and j.status = 'approved'
  and not exists (
    select 1 from jerseys j2
    where j2.team_id = j.team_id and j2.status = 'approved' and j2.id <> j.id
    and (j2.approved_at < j.approved_at or (j2.approved_at = j.approved_at and j2.id < j.id))
  )
  order by j.approved_at asc limit 1;
  if v_label is not null then insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'trailblazer', v_label) on conflict do nothing; end if;

  -- Regions - a jersey's "effective country" (team.country, falling
  -- back to its competition's region_group) mapped through
  -- country_region. Binary per region (any 1 jersey qualifies, not a
  -- count), Grand Tour once all 6 are covered.
  region_count := 0;
  foreach rs in array region_slugs loop
    if exists (
      select 1 from jerseys j
      join teams t on t.id = j.team_id
      join competitions c on c.slug = t.competition_slug
      join country_region cr on cr.country = coalesce(t.country, c.region_group)
      where j.uploaded_by = p_user_id and j.status = 'approved' and cr.region = rs[1]
    ) then
      select (j.season || ' ' || t.name || ' ' || j.type) into v_label
      from jerseys j
      join teams t on t.id = j.team_id
      join competitions c on c.slug = t.competition_slug
      join country_region cr on cr.country = coalesce(t.country, c.region_group)
      where j.uploaded_by = p_user_id and j.status = 'approved' and cr.region = rs[1]
      order by j.approved_at asc, j.id asc limit 1;
      insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, rs[2], v_label) on conflict do nothing;
      region_count := region_count + 1;
    end if;
  end loop;
  if region_count = 6 then
    insert into user_badges(user_id, badge_slug) values (p_user_id, 'grand-tour') on conflict do nothing;
  end if;
end;
$$ language plpgsql security definer set search_path = public;

-- Re-derives your own account only, same scoping as the earlier
-- achievements_*.sql follow-ups - change the username if rljerseys
-- isn't the right one. Not deleting existing rows this time (unlike
-- achievements_context.sql) - this only ADDS new badge types, it
-- doesn't change how any existing one is computed, so there's nothing
-- to re-derive for badges you already have.
select check_and_award_badges(id) from profiles where username = 'rljerseys';
