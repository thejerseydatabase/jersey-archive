-- Follow-up to achievements_live.sql. Adds a context_label to each
-- earned badge naming the specific jersey/logo that actually tipped it
-- over - "2026 Melbourne Storm Home" for an upload milestone, "North
-- Queensland Cowboys crest" for a logo one - shown in the hover tooltip.
--
-- Captured once, at the moment a badge is first earned (on conflict do
-- nothing means a later re-run never overwrites it) - computed from
-- whichever approved jersey/logo/collection item was the Nth one by
-- approval order, since that's a stable historical fact.
--
-- Not populated for the 4 breadth badges (Code Breaker, Well Travelled,
-- Globe Trotter, Brand Collector) - "which jersey pushed you over 10
-- different competitions" doesn't have one obvious answer the way a
-- simple count does, so those just show their description as before.
-- Full Range DOES get one (whichever of Home/Away/Alternate came last).
--
-- Safe to re-run (this replaces check_and_award_badges's definition;
-- your own already-earned badges get re-backfilled with labels at the
-- bottom, since they were earned before this existed).

alter table user_badges add column if not exists context_label text;

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

  -- Upload milestones - the jersey that was the Nth one approved, by
  -- approval order.
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

  -- Logo milestones - names the team/competition the Nth logo belonged
  -- to, since a logo isn't a jersey.
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

  -- Collection - the 10th jersey added, by when it was added.
  if collection_count >= 10 then
    select j.season || ' ' || t.name || ' ' || j.type into v_label
    from collection_items ci join jerseys j on j.id = ci.jersey_id join teams t on t.id = j.team_id
    where ci.user_id = p_user_id
    order by ci.created_at asc, ci.id asc limit 1 offset 9;
    insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'collector-ten', v_label) on conflict do nothing;
  end if;

  -- Breadth badges - no single triggering item, so no label (see note
  -- at the top of this file).
  if sport_count > 0 and user_sport_count >= sport_count then insert into user_badges(user_id, badge_slug) values (p_user_id, 'all-sports') on conflict do nothing; end if;
  if comp_count >= 10 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'ten-competitions') on conflict do nothing; end if;
  if comp_count >= 25 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'twenty-five-competitions') on conflict do nothing; end if;
  if mfr_count >= 10 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'ten-manufacturers') on conflict do nothing; end if;

  -- Full Range - whichever of Home/Away/Alternate was the LAST of the
  -- three first-uploaded (the one that actually completed the set).
  if has_home and has_away and has_alt then
    select label into v_label from (
      select (j.season || ' ' || t.name || ' ' || j.type) as label, j.approved_at,
        row_number() over (partition by j.type order by j.approved_at asc, j.id asc) as rn
      from jerseys j join teams t on t.id = j.team_id
      where j.uploaded_by = p_user_id and j.status = 'approved' and j.type in ('Home','Away','Alternate')
    ) x where rn = 1 order by approved_at desc limit 1;
    insert into user_badges(user_id, badge_slug, context_label) values (p_user_id, 'full-range', v_label) on conflict do nothing;
  end if;

  -- Trailblazer - the specific jersey that was the earliest-approved
  -- for its team (nobody else's approval on that team beat it).
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
end;
$$ language plpgsql security definer set search_path = public;

-- Re-derives your own already-earned badges so they pick up a
-- context_label too (on conflict do nothing meant the function alone
-- wouldn't touch rows earned before this existed). Scoped to your
-- account only, same as achievements_live.sql - change the username if
-- rljerseys isn't the right one. Resets "seen" on your own badges, so
-- you'll see the unlocked banner again once on your next profile visit
-- - harmless, not worth avoiding for a one-time backfill.
delete from user_badges where user_id = (select id from profiles where username = 'rljerseys');
select check_and_award_badges(id) from profiles where username = 'rljerseys';
