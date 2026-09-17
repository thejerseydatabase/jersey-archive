-- Stops the 13 global-tournament competitions (FIFA World Cup, Rugby
-- League World Cup, etc.) from being pickable as a jersey's PRIMARY
-- competition on the upload form or in the admin "wrong competition" /
-- "wrong team or sport" reassignment tools. They were only ever meant
-- to be tagged on as an EXTRA competition (the "was this jersey also
-- worn in another competition?" checkbox) — a country's regular kit
-- stays filed under its real International team, and gets tagged onto
-- the World Cup competition on top of that, the same way Aston Villa's
-- home kit is tagged Premier League AND Champions League on
-- footballkitarchive. Picking one of these as the PRIMARY competition
-- would instead create a brand new, disconnected team under it (since
-- they deliberately have zero teams of their own), splitting a
-- country's jersey history across two separate pages.
--
-- The competitions themselves, and their jerseys/pages, aren't touched
-- — this only changes which list they're offered in. They're still
-- fully browsable and still the correct place to tag a World Cup
-- jersey via the extra-competition field. Safe to re-run.

alter table competitions add column if not exists tag_only boolean not null default false;

update competitions set tag_only = true where slug in (
  'fifa-world-cup',
  'rugby-league-world-cup',
  'rugby-world-cup',
  'cricket-world-cup',
  't20-world-cup',
  'fiba-basketball-world-cup',
  'netball-world-cup',
  'hockey-world-cup',
  'iihf-world-championship',
  'world-baseball-classic',
  'volleyball-world-championship',
  'afl-international-cup',
  'ifaf-world-championship'
);
