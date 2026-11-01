-- Fixes the FOREACH error from achievements_regions.sql ("FOREACH loop
-- variable must not be of an array type") - iterating over a 2-D array
-- row-by-row needs an explicit SLICE 1, otherwise Postgres tries to
-- hand you individual scalar values instead of each row. The table,
-- badges, and function all got created fine before this broke - this
-- just re-creates the function with the fix and re-runs the backfill.
--
-- Safe to re-run.

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
  foreach rs slice 1 in array region_slugs loop
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
