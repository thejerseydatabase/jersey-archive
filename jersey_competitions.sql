-- Lets one jersey be tagged with an EXTRA competition on top of its home
-- one — e.g. a club's league kit that's also the same kit worn in a cup
-- competition, or a country's regular kit that's also what they wore at
-- a World Cup. One upload, one set of photos; no need to duplicate the
-- team/jersey into a second competition just to show it there too.
--
-- Also adds a global tournament competition per sport to tag onto —
-- named for whatever that sport's actual real event is called, not
-- forced into "World Cup" where that's not the real name (ice hockey,
-- baseball and volleyball's global events aren't branded "World Cup").
-- These start with zero teams of their own on purpose — every team stays
-- exactly where it already lives (its domestic league/International
-- competition); jerseys only reach these pages via the new tag.
-- Safe to re-run.

create table if not exists jersey_competitions (
  jersey_id uuid not null references jerseys(id) on delete cascade,
  competition_slug text not null references competitions(slug) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (jersey_id, competition_slug)
);
create index if not exists jersey_competitions_comp_idx on jersey_competitions(competition_slug);

alter table jersey_competitions enable row level security;

drop policy if exists "jersey_competitions are publicly readable" on jersey_competitions;
create policy "jersey_competitions are publicly readable"
  on jersey_competitions for select using (true);

drop policy if exists "jersey owner can tag extra competitions while pending" on jersey_competitions;
create policy "jersey owner can tag extra competitions while pending"
  on jersey_competitions for insert to authenticated with check (
    exists (select 1 from jerseys j where j.id = jersey_id and j.uploaded_by = auth.uid() and j.status = 'pending')
    or exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin)
  );

drop policy if exists "jersey owner can untag extra competitions while pending" on jersey_competitions;
create policy "jersey owner can untag extra competitions while pending"
  on jersey_competitions for delete using (
    exists (select 1 from jerseys j where j.id = jersey_id and j.uploaded_by = auth.uid() and j.status = 'pending')
    or exists (select 1 from profiles p where p.id = auth.uid() and p.is_admin)
  );

insert into competitions (slug, sport_slug, name, tier) values
  ('fifa-world-cup','football','FIFA World Cup','top'),
  ('rugby-league-world-cup','rugby-league','Rugby League World Cup','top'),
  ('rugby-world-cup','rugby-union','Rugby World Cup','top'),
  ('cricket-world-cup','cricket','Cricket World Cup','top'),
  ('t20-world-cup','cricket','T20 World Cup','top'),
  ('fiba-basketball-world-cup','basketball','FIBA Basketball World Cup','top'),
  ('netball-world-cup','netball','Netball World Cup','top'),
  ('hockey-world-cup','field-hockey','Hockey World Cup','top'),
  ('iihf-world-championship','ice-hockey','IIHF World Championship','top'),
  ('world-baseball-classic','baseball','World Baseball Classic','top'),
  ('volleyball-world-championship','volleyball','Volleyball World Championship','top'),
  ('afl-international-cup','afl','AFL International Cup','top'),
  ('ifaf-world-championship','american-football','IFAF World Championship','top')
on conflict (slug) do nothing;
