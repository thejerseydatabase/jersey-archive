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
drop trigger if exists on_jersey_approved on jerseys;
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
  is_admin boolean not null default false,
  created_at timestamptz not null default now()
);

alter table profiles enable row level security;

create policy "profiles are publicly readable"
  on profiles for select using (true);

create policy "users can update their own profile"
  on profiles for update using ((select auth.uid()) = id);

-- Every security definer function below pins search_path = public.
-- Without it, a security definer function resolves unqualified table
-- names using whatever search_path the CALLING session has set, not a
-- fixed one — so a caller who can create an object earlier in their own
-- search_path (e.g. a same-named table in a schema they control) could
-- get the function to operate on that instead of the real table. Costs
-- nothing to pin and closes off that entire class of attack.

-- auto-create a profile row whenever someone signs up, with a guaranteed-
-- unique starting username (the email prefix alone can collide across two
-- different email providers, e.g. john@gmail.com and john@yahoo.com — that
-- would otherwise break the second person's signup outright).
create function handle_new_user()
returns trigger as $$
declare
  base_username text := regexp_replace(split_part(new.email, '@', 1), '[^a-zA-Z0-9_]', '', 'g');
  candidate text;
  suffix int := 0;
begin
  if base_username = '' then base_username := 'fan'; end if;
  candidate := base_username;
  while exists (select 1 from public.profiles where username = candidate) loop
    suffix := suffix + 1;
    candidate := base_username || suffix::text;
  end loop;
  insert into public.profiles (id, username) values (new.id, candidate);
  return new;
end;
$$ language plpgsql security definer set search_path = public;

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
  -- lower sorts first, ties broken alphabetically by name; default puts a
  -- competition at the back unless it's been explicitly pinned earlier
  -- (e.g. cricket's International/IPL/BBL/Australia Domestic ordering).
  sort_order integer not null default 999,
  logo_path text,
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now()
);

alter table competitions enable row level security;
create policy "competitions are publicly readable" on competitions for select using (true);
create policy "authenticated users can add competitions"
  on competitions for insert to authenticated with check (true);
create policy "admins can edit competitions"
  on competitions for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


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
  logo_path text,
  -- false = no longer competing in this competition (e.g. relegated out of
  -- Super League) but its jersey history stays exactly where it is; the
  -- competition page just lists it under "Former teams" instead.
  is_active boolean not null default true,
  -- true for an announced-but-not-yet-playing expansion club (Perth
  -- Bears, Tasmania Devils) — shown in its own section on the
  -- competition page regardless of is_active.
  is_upcoming boolean not null default false,
  -- free-text context for a gap in the timeline: folded, merged, or
  -- promoted away and back (e.g. "Merged with Balmain Tigers in 1999 to
  -- form the Wests Tigers").
  history_note text,
  -- which real-world formats this team competes in (used by international
  -- cricket to split the team grid into Test/ODI/T20I sections) — null
  -- for a team where that split doesn't apply.
  formats text[],
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now(),
  unique (competition_slug, slug)
);
create index teams_slug_idx on teams(slug);

alter table teams enable row level security;
create policy "teams are publicly readable" on teams for select using (true);
create policy "authenticated users can add teams"
  on teams for insert to authenticated with check (true);
create policy "admins can edit teams"
  on teams for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


-- ============ jerseys ============
create table jerseys (
  id uuid primary key default gen_random_uuid(),
  team_id uuid not null references teams(id) on delete cascade,
  -- text, not integer — many competitions (NBA, NBL, EPL, Bundesliga...)
  -- span two calendar years, e.g. "2026-27", not just a single year.
  season text not null check (season ~ '^[0-9]{4}(-[0-9]{2})?$'),
  type text not null,               -- Home / Away / Alternate / Indigenous / Heritage / Training / user-typed
  manufacturer text,
  format text,                      -- cricket only: Test / T20 / T20I / ODI / One Day / First Class
  notes text,
  uploaded_by uuid references auth.users(id),
  views integer not null default 0,
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  -- shown back to the uploader on a rejected submission's own page
  rejection_reason text,
  created_at timestamptz not null default now()
);

create index jerseys_team_idx on jerseys(team_id);
create index jerseys_season_idx on jerseys(season);
create index jerseys_manufacturer_idx on jerseys(manufacturer);
create index jerseys_type_idx on jerseys(type);
create index jerseys_format_idx on jerseys(format);
create index jerseys_status_idx on jerseys(status);

alter table jerseys enable row level security;

-- public sees only approved jerseys; you always see your own; admins see everything
create policy "visible jerseys are readable"
  on jerseys for select using (
    status = 'approved'
    or uploaded_by = (select auth.uid())
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  );
create policy "authenticated users can upload jerseys"
  on jerseys for insert to authenticated with check ((select auth.uid()) = uploaded_by);
-- you can edit your own jersey while it's pending (but can't approve
-- yourself), or an admin can moderate any jersey — combined into one
-- policy (rather than two separate permissive UPDATE policies) so
-- Postgres only has to evaluate one OR'd check per row instead of two.
create policy "users can edit their own jerseys, admins can moderate any"
  on jerseys for update
  using (
    uploaded_by = (select auth.uid())
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  )
  with check (
    (uploaded_by = (select auth.uid()) and status = 'pending')
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  );
create policy "admins can delete jerseys"
  on jerseys for delete
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));

-- award an upload point once a submission is actually approved, not on raw submission
create function award_upload_point()
returns trigger as $$
begin
  if new.status = 'approved' and (old.status is distinct from 'approved') and new.uploaded_by is not null then
    update profiles set points = points + 1 where id = new.uploaded_by;
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;

create trigger on_jersey_approved
  after update of status on jerseys
  for each row execute function award_upload_point();


-- ============ jersey_images ============
-- storage_path points into the "jersey-photos" Storage bucket (created separately in the dashboard)
create table jersey_images (
  id uuid primary key default gen_random_uuid(),
  jersey_id uuid not null references jerseys(id) on delete cascade,
  storage_path text not null,
  label text not null default 'Front',   -- Front / Back / Other
  sort_order integer not null default 0,
  -- status covers photos proposed onto an ALREADY-approved jersey by someone
  -- other than the original uploader; photos submitted with a brand-new
  -- jersey default to 'approved' since the parent jersey's own pending
  -- status already hides them until the jersey itself is approved.
  status text not null default 'approved' check (status in ('pending','approved','rejected')),
  uploaded_by uuid references auth.users(id),
  created_at timestamptz not null default now()
);

alter table jersey_images enable row level security;
create policy "images of visible jerseys are readable"
  on jersey_images for select using (
    (status = 'approved' or uploaded_by = (select auth.uid()) or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
    and exists (select 1 from jerseys j where j.id = jersey_id and (
      j.status = 'approved' or j.uploaded_by = (select auth.uid())
      or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
    ))
  );
-- covers both a fresh jersey's own photos and a later-proposed extra
-- photo on an already-approved jersey — combined into one policy
-- (rather than two separate permissive INSERT policies for the same
-- role) so Postgres only evaluates one OR'd check per row.
create policy "authenticated users can add or propose jersey photos"
  on jersey_images for insert to authenticated with check (
    exists (select 1 from jerseys where jerseys.id = jersey_id and jerseys.uploaded_by = (select auth.uid()))
    or (
      uploaded_by = (select auth.uid()) and status = 'pending'
      and exists (select 1 from jerseys j where j.id = jersey_id and j.status = 'approved')
    )
  );
create policy "admins can moderate jersey photos"
  on jersey_images for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));
create policy "admins can delete jersey image rows"
  on jersey_images for delete
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


-- ============ jersey_competitions ============
-- A jersey's "home" competition is still whatever its team belongs to
-- (jerseys.team_id -> teams.competition_slug) — this table is only for
-- an EXTRA competition the same physical jersey was also worn in, e.g.
-- a club's league kit also worn in a continental cup, or a country's
-- regular kit also worn at a World Cup. One row per extra tag; no row
-- here at all is the normal case.
create table jersey_competitions (
  jersey_id uuid not null references jerseys(id) on delete cascade,
  competition_slug text not null references competitions(slug) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (jersey_id, competition_slug)
);
create index jersey_competitions_comp_idx on jersey_competitions(competition_slug);

alter table jersey_competitions enable row level security;
create policy "jersey_competitions are publicly readable"
  on jersey_competitions for select using (true);
create policy "jersey owner can tag extra competitions while pending"
  on jersey_competitions for insert to authenticated with check (
    exists (select 1 from jerseys j where j.id = jersey_id and j.uploaded_by = (select auth.uid()) and j.status = 'pending')
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  );
create policy "jersey owner can untag extra competitions while pending"
  on jersey_competitions for delete using (
    exists (select 1 from jerseys j where j.id = jersey_id and j.uploaded_by = (select auth.uid()) and j.status = 'pending')
    or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
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
  on ratings for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "users can change their own rating"
  on ratings for update using ((select auth.uid()) = user_id);

-- a view that does the average-rating math so the app never has to
-- security_invoker: runs with the querying user's own RLS/permissions
-- instead of the view owner's — the owner is typically the privileged
-- role that ran this SQL, so without this a view can silently bypass RLS.
-- Doesn't change what this view returns (ratings is fully public anyway).
create view jersey_ratings with (security_invoker = true) as
  select jersey_id, round(avg(value)::numeric, 1) as avg_rating, count(*) as rating_count
  from ratings
  group by jersey_id;


-- ============ reports ============
-- "page_type" + "page_ref" is a light generic pointer (a jersey id, a team
-- id, or a competition slug) so one table covers reports from any page.
-- page_label is a plain-text snapshot for the moderation queue to display
-- without extra joins.
create table reports (
  id uuid primary key default gen_random_uuid(),
  page_type text not null check (page_type in ('jersey','team','competition')),
  page_ref text not null,
  page_label text,
  message text not null,
  attachment_path text,
  reported_by uuid references auth.users(id),
  client_token text,
  status text not null default 'open' check (status in ('open','resolved')),
  created_at timestamptz not null default now()
);

alter table reports enable row level security;
create policy "anyone can submit a report" on reports for insert with check (true);
create policy "admins can read reports"
  on reports for select using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));
create policy "admins can resolve reports"
  on reports for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));

-- reports allow anonymous submission by design; attachments follow the same
-- rule. Needs a "report-attachments" Storage bucket (Public bucket ON).
create policy "anyone can view report attachments"
  on storage.objects for select using (bucket_id = 'report-attachments');
create policy "anyone can upload a report attachment"
  on storage.objects for insert with check (bucket_id = 'report-attachments');
create policy "admins can delete report attachments"
  on storage.objects for delete to authenticated
  using (bucket_id = 'report-attachments' and exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));


-- ============ storage (jersey-photos bucket) ============
-- Marking a bucket "Public" in the dashboard only controls whether reading
-- a file requires no auth — uploading is a separate permission, governed by
-- RLS on Storage's own storage.objects table, same as any other table.
create policy "anyone can view jersey photos"
  on storage.objects for select
  using (bucket_id = 'jersey-photos');

create policy "authenticated users can upload jersey photos"
  on storage.objects for insert to authenticated
  with check (bucket_id = 'jersey-photos');

create policy "admins can delete jersey photos"
  on storage.objects for delete to authenticated
  using (bucket_id = 'jersey-photos' and exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));


-- ============ team logos ============
-- Proposable by any signed-in user, only live once approved — same
-- pattern as extra jersey photos. Needs a "team-logos" Storage bucket
-- (Public bucket ON), created separately in the dashboard.
create table team_logo_proposals (
  id uuid primary key default gen_random_uuid(),
  team_id uuid not null references teams(id) on delete cascade,
  storage_path text not null,
  proposed_by uuid references auth.users(id),
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  -- guards against ever awarding the upload point twice for the same row
  point_awarded boolean not null default false,
  created_at timestamptz not null default now()
);

alter table team_logo_proposals enable row level security;
-- public once approved (so it can show on a contributor's profile page,
-- same as an approved jersey), otherwise only the proposer and admins
create policy "logo proposals are readable once approved, or by proposer/admins"
  on team_logo_proposals for select using (
    status = 'approved' or proposed_by = (select auth.uid()) or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  );
create policy "authenticated users can propose a team logo"
  on team_logo_proposals for insert to authenticated with check (proposed_by = (select auth.uid()));
create policy "admins can moderate logo proposals"
  on team_logo_proposals for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));
create policy "admins can delete logo proposals"
  on team_logo_proposals for delete
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));

-- award an upload point once a proposed logo is actually approved, same as
-- jerseys — before-update so it can flip point_awarded on the same row and
-- guarantee the point is never handed out twice for one proposal.
create function award_logo_point()
returns trigger as $$
begin
  if new.status = 'approved' and (old.status is distinct from 'approved') and new.proposed_by is not null and not new.point_awarded then
    update profiles set points = points + 1 where id = new.proposed_by;
    new.point_awarded := true;
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;

create trigger on_logo_approved
  before update of status on team_logo_proposals
  for each row execute function award_logo_point();

create policy "anyone can view team logos"
  on storage.objects for select using (bucket_id = 'team-logos');
create policy "authenticated users can upload team logos"
  on storage.objects for insert to authenticated with check (bucket_id = 'team-logos');
create policy "admins can delete team logo files"
  on storage.objects for delete to authenticated
  using (bucket_id = 'team-logos' and exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin));

-- a full history of past logos, never overwritten when a new one is approved
create table team_logos (
  id uuid primary key default gen_random_uuid(),
  team_id uuid not null references teams(id) on delete cascade,
  storage_path text not null,
  is_current boolean not null default false,
  approved_at timestamptz not null default now(),
  years_used text
);
alter table team_logos enable row level security;
create policy "team logo history is publicly readable" on team_logos for select using (true);
create policy "admins can add to team logo history"
  on team_logos for insert to authenticated
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));
create policy "admins can update team logo history"
  on team_logos for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


-- ============ competition logos ============
-- Same proposable/history pattern as team logos, for the competition's own
-- badge (e.g. an NRL or Super Rugby Pacific logo) rather than a team's.
-- Reuses the "team-logos" Storage bucket under a "comp-<slug>/" prefix so
-- no extra bucket needs creating.
create table competition_logo_proposals (
  id uuid primary key default gen_random_uuid(),
  competition_slug text not null references competitions(slug) on delete cascade,
  storage_path text not null,
  proposed_by uuid references auth.users(id),
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  point_awarded boolean not null default false,
  created_at timestamptz not null default now()
);

alter table competition_logo_proposals enable row level security;
create policy "comp logo proposals are readable once approved, or by proposer/admins"
  on competition_logo_proposals for select using (
    status = 'approved' or proposed_by = (select auth.uid()) or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
  );
create policy "authenticated users can propose a competition logo"
  on competition_logo_proposals for insert to authenticated with check (proposed_by = (select auth.uid()));
create policy "admins can moderate comp logo proposals"
  on competition_logo_proposals for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));
create policy "admins can delete comp logo proposals"
  on competition_logo_proposals for delete
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));

create function award_comp_logo_point()
returns trigger as $$
begin
  if new.status = 'approved' and (old.status is distinct from 'approved') and new.proposed_by is not null and not new.point_awarded then
    update profiles set points = points + 1 where id = new.proposed_by;
    new.point_awarded := true;
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;

create trigger on_comp_logo_approved
  before update of status on competition_logo_proposals
  for each row execute function award_comp_logo_point();

-- rate_limit_comp_logo_proposals is created further down, once
-- enforce_upload_rate_limit() itself is defined (see "basic spam protection").

create table competition_logos (
  id uuid primary key default gen_random_uuid(),
  competition_slug text not null references competitions(slug) on delete cascade,
  storage_path text not null,
  is_current boolean not null default false,
  approved_at timestamptz not null default now(),
  years_used text
);
alter table competition_logos enable row level security;
create policy "competition logo history is publicly readable" on competition_logos for select using (true);
create policy "admins can add to competition logo history"
  on competition_logos for insert to authenticated
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));
create policy "admins can update competition logo history"
  on competition_logos for update
  using (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin))
  with check (exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin));


-- ============ basic spam protection ============
-- Per-user hourly caps on signed-in submissions (uploads/photos/logo
-- proposals), plus a lighter per-browser-token cap on anonymous reports.
create function enforce_upload_rate_limit()
returns trigger as $$
declare
  user_col text := TG_ARGV[0];
  max_count int := TG_ARGV[1]::int;
  window_minutes int := TG_ARGV[2]::int;
  uid uuid;
  recent_count int;
begin
  uid := (to_jsonb(new)->>user_col)::uuid;
  if uid is null then
    return new;
  end if;
  execute format(
    'select count(*) from %I where %I = $1 and created_at > now() - interval ''%s minutes''',
    TG_TABLE_NAME, user_col, window_minutes
  ) into recent_count using uid;
  if recent_count >= max_count then
    raise exception 'You are submitting too quickly — max % per % minutes. Please wait a bit and try again.', max_count, window_minutes;
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;

create trigger rate_limit_jerseys
  before insert on jerseys
  for each row execute function enforce_upload_rate_limit('uploaded_by', 120, 60);

create trigger rate_limit_jersey_images
  before insert on jersey_images
  for each row execute function enforce_upload_rate_limit('uploaded_by', 20, 60);

create trigger rate_limit_logo_proposals
  before insert on team_logo_proposals
  for each row execute function enforce_upload_rate_limit('proposed_by', 120, 60);

create trigger rate_limit_comp_logo_proposals
  before insert on competition_logo_proposals
  for each row execute function enforce_upload_rate_limit('proposed_by', 120, 60);

create function enforce_report_rate_limit()
returns trigger as $$
declare
  recent_count int;
begin
  if new.reported_by is not null then
    select count(*) into recent_count from reports
      where reported_by = new.reported_by and created_at > now() - interval '60 minutes';
  elsif new.client_token is not null then
    select count(*) into recent_count from reports
      where client_token = new.client_token and created_at > now() - interval '60 minutes';
  else
    recent_count := 0;
  end if;
  if recent_count >= 5 then
    raise exception 'Too many reports submitted recently. Please wait a while and try again.';
  end if;
  return new;
end;
$$ language plpgsql security definer set search_path = public;

create trigger rate_limit_reports
  before insert on reports
  for each row execute function enforce_report_rate_limit();


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
