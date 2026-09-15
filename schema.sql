-- Jersey Archive database schema (v2 — safe to re-run)
-- Run this in Supabase: Project → SQL Editor → New snippet → paste → Run
--
-- v2 change: teams are now identified by (competition_slug, slug) instead of
-- a single globally-unique slug. A globally-unique team slug would let two
-- unrelated clubs in different sports/competitions that happen to share a
-- name (e.g. a lower-league "Tigers" or "United" in two different countries)
-- silently collide into one row. This version drops and recreates the
-- affected tables — safe right now because only demo/seed data exists.

drop view if exists jersey_ratings;
drop trigger if exists on_jersey_uploaded on jerseys;
drop trigger if exists on_auth_user_created on auth.users;
drop table if exists ratings, jersey_images, jerseys, teams, competitions, sports, profiles cascade;
drop function if exists award_upload_point() cascade;
drop function if exists handle_new_user() cascade;


-- ============ profiles ============
-- One row per signed-up user. Created automatically on signup (trigger below).
create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique,
  points integer not null default 0,
  created_at timestamptz not null default now()
);

alter table profiles enable row level security;

create policy "profiles are publicly readable"
  on profiles for select using (true);

create policy "users can update their own profile"
  on profiles for update using (auth.uid() = id);

-- auto-create a profile row whenever someone signs up
create function handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, username)
  values (new.id, split_part(new.email, '@', 1));
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function handle_new_user();


-- ============ sports ============
create table sports (
  slug text primary key,
  name text not null,
  sort_order integer not null default 0
);

alter table sports enable row level security;
create policy "sports are publicly readable" on sports for select using (true);


-- ============ competitions ============
create table competitions (
  slug text primary key,
  sport_slug text not null references sports(slug) on delete cascade,
  name text not null,
  tier text not null default 'more' check (tier in ('top','more')),
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now()
);

alter table competitions enable row level security;
create policy "competitions are publicly readable" on competitions for select using (true);
create policy "authenticated users can add competitions"
  on competitions for insert to authenticated with check (true);


-- ============ teams ============
-- id is the real identity; slug is only unique WITHIN a competition, so the
-- same short name can exist in different sports/competitions without colliding.
create table teams (
  id uuid primary key default gen_random_uuid(),
  slug text not null,
  competition_slug text not null references competitions(slug) on delete cascade,
  name text not null,
  primary_color text not null default '#3FA88C',
  secondary_color text not null default '#F2F6EF',
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now(),
  unique (competition_slug, slug)
);
create index teams_slug_idx on teams(slug);

alter table teams enable row level security;
create policy "teams are publicly readable" on teams for select using (true);
create policy "authenticated users can add teams"
  on teams for insert to authenticated with check (true);


-- ============ jerseys ============
create table jerseys (
  id uuid primary key default gen_random_uuid(),
  team_id uuid not null references teams(id) on delete cascade,
  season integer not null check (season between 1850 and 2100),
  type text not null,               -- Home / Away / Alternate / Indigenous / Heritage / Training / user-typed
  manufacturer text,
  format text,                      -- cricket only: Test / T20 / T20I / ODI / One Day / First Class
  notes text,
  uploaded_by uuid references auth.users(id),
  views integer not null default 0,
  created_at timestamptz not null default now()
);

create index jerseys_team_idx on jerseys(team_id);
create index jerseys_season_idx on jerseys(season);
create index jerseys_manufacturer_idx on jerseys(manufacturer);
create index jerseys_type_idx on jerseys(type);
create index jerseys_format_idx on jerseys(format);

alter table jerseys enable row level security;
create policy "jerseys are publicly readable" on jerseys for select using (true);
create policy "authenticated users can upload jerseys"
  on jerseys for insert to authenticated with check (auth.uid() = uploaded_by);
create policy "users can edit their own jerseys"
  on jerseys for update using (auth.uid() = uploaded_by);

-- award an upload point automatically
create function award_upload_point()
returns trigger as $$
begin
  if new.uploaded_by is not null then
    update profiles set points = points + 1 where id = new.uploaded_by;
  end if;
  return new;
end;
$$ language plpgsql security definer;

create trigger on_jersey_uploaded
  after insert on jerseys
  for each row execute function award_upload_point();


-- ============ jersey_images ============
-- storage_path points into the "jersey-photos" Storage bucket (created separately in the dashboard)
create table jersey_images (
  id uuid primary key default gen_random_uuid(),
  jersey_id uuid not null references jerseys(id) on delete cascade,
  storage_path text not null,
  label text not null default 'Front',   -- Front / Back / Other
  sort_order integer not null default 0
);

alter table jersey_images enable row level security;
create policy "jersey images are publicly readable" on jersey_images for select using (true);
create policy "authenticated users can add images to their own jerseys"
  on jersey_images for insert to authenticated with check (
    exists (select 1 from jerseys where jerseys.id = jersey_id and jerseys.uploaded_by = auth.uid())
  );


-- ============ ratings ============
create table ratings (
  jersey_id uuid not null references jerseys(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  value integer not null check (value between 1 and 5),
  created_at timestamptz not null default now(),
  primary key (jersey_id, user_id)
);

alter table ratings enable row level security;
create policy "ratings are publicly readable" on ratings for select using (true);
create policy "authenticated users can rate"
  on ratings for insert to authenticated with check (auth.uid() = user_id);
create policy "users can change their own rating"
  on ratings for update using (auth.uid() = user_id);

-- a view that does the average-rating math so the app never has to
create view jersey_ratings as
  select jersey_id, round(avg(value)::numeric, 1) as avg_rating, count(*) as rating_count
  from ratings
  group by jersey_id;


-- ============ seed data ============
insert into sports (slug, name, sort_order) values
  ('rugby-league','Rugby League',1),
  ('cricket','Cricket',2),
  ('football','Football',3),
  ('rugby-union','Rugby Union',4),
  ('afl','AFL',5),
  ('basketball','Basketball',6),
  ('ice-hockey','Ice Hockey',7);

insert into competitions (slug, sport_slug, name, tier) values
  ('nrl','rugby-league','NRL','top'),
  ('nrlw','rugby-league','NRLW','top'),
  ('super-league','rugby-league','Super League','top'),
  ('championship','rugby-league','Championship','more'),
  ('nsw-cup','rugby-league','NSW Cup','more'),
  ('qld-cup','rugby-league','QLD Cup','more'),
  ('bbl','cricket','BBL','top'),
  ('ipl','cricket','IPL','top'),
  ('international','cricket','International','top'),
  ('psl','cricket','PSL','more');
