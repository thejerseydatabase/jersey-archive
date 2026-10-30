-- Achievement badges - separate from the points/tier system, these are
-- one-off unlocks for specific milestones (uploads, logos, breadth of
-- sports/competitions/manufacturers covered, etc.), shown as a public
-- "trophy case" on a member's profile. First batch of 15; add more
-- later just by inserting into `badges` and adding the matching check
-- in check_and_award_badges() below.
--
-- Same shape as tier_up_notices.sql: a trigger evaluates and awards
-- after the event that could unlock something (a jersey getting
-- approved, a logo being added, a collection item being added), and
-- app.js surfaces unseen ones through the same unread-envelope badge.
--
-- Safe to re-run.

create table if not exists badges (
  slug text primary key,
  label text not null,
  description text not null,
  sort_order integer not null default 0
);

alter table badges enable row level security;
drop policy if exists "badge catalog is public" on badges;
create policy "badge catalog is public" on badges for select using (true);

create table if not exists user_badges (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  badge_slug text not null references badges(slug) on delete cascade,
  earned_at timestamptz not null default now(),
  seen boolean not null default false,
  unique (user_id, badge_slug)
);

alter table user_badges enable row level security;

-- Public, same as points/tier - earned badges are part of a member's
-- public profile (the "trophy case"), not private.
drop policy if exists "earned badges are public" on user_badges;
create policy "earned badges are public" on user_badges for select using (true);

-- Lets a member flip seen on their own rows once the congratulations
-- banner's been shown - no insert/delete policy, only the
-- security-definer function below ever creates these.
drop policy if exists "users can mark their own badges seen" on user_badges;
create policy "users can mark their own badges seen"
  on user_badges for update
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create index if not exists user_badges_user_idx on user_badges(user_id);

insert into badges (slug, label, description, sort_order) values
  ('first-upload',             'First Kit',            'Uploaded your first approved jersey.', 10),
  ('ten-uploads',               'Getting Started',      'Uploaded 10 approved jerseys.', 20),
  ('fifty-uploads',             'Serious Collector',    'Uploaded 50 approved jerseys.', 30),
  ('hundred-uploads',           'Century',              'Uploaded 100 approved jerseys.', 40),
  ('five-hundred-uploads',      'Archivist',            'Uploaded 500 approved jerseys.', 50),
  ('first-logo',                'Crest Keeper',         'Had your first team or competition logo approved.', 60),
  ('five-logos',                'Logo Hunter',          'Had 5 logos approved.', 70),
  ('twenty-five-logos',         'Logo Archivist',       'Had 25 logos approved.', 80),
  ('collector-ten',             'Super Fan',            'Added 10 jerseys to your personal collection.', 90),
  ('all-sports',                'Code Breaker',         'Uploaded at least one jersey in every sport on the site.', 100),
  ('ten-competitions',          'Well Travelled',       'Uploaded jerseys across 10 different competitions.', 110),
  ('twenty-five-competitions',  'Globe Trotter',        'Uploaded jerseys across 25 different competitions.', 120),
  ('ten-manufacturers',         'Brand Collector',      'Uploaded jerseys from 10 different manufacturers.', 130),
  ('full-range',                'The Full Range',       'Uploaded a Home, Away, and Alternate jersey.', 140),
  ('trailblazer',               'Trailblazer',          'The first person to upload an approved jersey for a team that had none before.', 150)
on conflict (slug) do update set label = excluded.label, description = excluded.description, sort_order = excluded.sort_order;

-- Re-checks every badge condition for one user and awards any newly
-- qualifying ones (on conflict do nothing - already-earned badges are
-- just skipped, so this is safe to call as often as needed). Called
-- from the triggers below, not directly by the app.
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
  is_trailblazer boolean;
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

  if jersey_count >= 1 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'first-upload') on conflict do nothing; end if;
  if jersey_count >= 10 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'ten-uploads') on conflict do nothing; end if;
  if jersey_count >= 50 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'fifty-uploads') on conflict do nothing; end if;
  if jersey_count >= 100 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'hundred-uploads') on conflict do nothing; end if;
  if jersey_count >= 500 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'five-hundred-uploads') on conflict do nothing; end if;

  if logo_count >= 1 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'first-logo') on conflict do nothing; end if;
  if logo_count >= 5 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'five-logos') on conflict do nothing; end if;
  if logo_count >= 25 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'twenty-five-logos') on conflict do nothing; end if;

  if collection_count >= 10 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'collector-ten') on conflict do nothing; end if;

  if sport_count > 0 and user_sport_count >= sport_count then insert into user_badges(user_id, badge_slug) values (p_user_id, 'all-sports') on conflict do nothing; end if;
  if comp_count >= 10 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'ten-competitions') on conflict do nothing; end if;
  if comp_count >= 25 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'twenty-five-competitions') on conflict do nothing; end if;
  if mfr_count >= 10 then insert into user_badges(user_id, badge_slug) values (p_user_id, 'ten-manufacturers') on conflict do nothing; end if;
  if has_home and has_away and has_alt then insert into user_badges(user_id, badge_slug) values (p_user_id, 'full-range') on conflict do nothing; end if;

  -- True if at least one of this user's approved jerseys was the
  -- earliest-approved jersey for its team (nobody else's approval on
  -- that team has an earlier approved_at). A stable historical fact
  -- once approved_at is set, so this is safe to recompute from current
  -- data rather than needing to be decided only at the moment of
  -- approval.
  select exists(
    select 1 from jerseys j
    where j.uploaded_by = p_user_id and j.status = 'approved'
    and not exists (
      select 1 from jerseys j2
      where j2.team_id = j.team_id and j2.status = 'approved' and j2.id <> j.id
      and (j2.approved_at < j.approved_at or (j2.approved_at = j.approved_at and j2.id < j.id))
    )
  ) into is_trailblazer;
  if is_trailblazer then insert into user_badges(user_id, badge_slug) values (p_user_id, 'trailblazer') on conflict do nothing; end if;
end;
$$ language plpgsql security definer set search_path = public;

create or replace function badges_on_jersey_approved()
returns trigger as $$
begin
  if new.status = 'approved' and (old.status is distinct from 'approved') and new.uploaded_by is not null then
    perform check_and_award_badges(new.uploaded_by);
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;

drop trigger if exists on_jersey_approved_badges on jerseys;
create trigger on_jersey_approved_badges
  after update of status on jerseys
  for each row execute function badges_on_jersey_approved();

create or replace function badges_on_logo_added()
returns trigger as $$
begin
  if new.proposed_by is not null then
    perform check_and_award_badges(new.proposed_by);
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;

drop trigger if exists on_team_logo_added_badges on team_logos;
create trigger on_team_logo_added_badges
  after insert on team_logos
  for each row execute function badges_on_logo_added();

drop trigger if exists on_comp_logo_added_badges on competition_logos;
create trigger on_comp_logo_added_badges
  after insert on competition_logos
  for each row execute function badges_on_logo_added();

create or replace function badges_on_collection_add()
returns trigger as $$
begin
  perform check_and_award_badges(new.user_id);
  return new;
end;
$$ language plpgsql security definer set search_path = public;

drop trigger if exists on_collection_item_added_badges on collection_items;
create trigger on_collection_item_added_badges
  after insert on collection_items
  for each row execute function badges_on_collection_add();
