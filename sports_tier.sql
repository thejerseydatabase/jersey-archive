-- Adds a top/more tier to sports, the same idea already used for
-- competitions.tier, so the homepage's main sport grid can stay exactly
-- as curated and symmetrical as it is today while still letting niche
-- sports be added and found through a "More sports" toggle underneath,
-- instead of crowding the main grid or needing their own hidden page.
-- Every existing sport defaults to 'top' so nothing on the homepage
-- changes until a sport is explicitly inserted as 'more'.
-- Safe to re-run.

alter table sports add column if not exists tier text not null default 'top' check (tier in ('top','more'));

insert into sports (slug, name, sort_order, tier) values
  ('lacrosse','Lacrosse',13,'more'),
  ('gaelic-football','Gaelic Football',14,'more')
on conflict (slug) do nothing;
