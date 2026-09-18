-- Adds the AVL (Australian Volleyball League) as a new "more"-tier
-- competition under the existing Volleyball sport, with its 6 clubs.
-- Each club fields both a men's and women's team, so — same pattern as
-- the International Volleyball merge — each gets two team rows: the
-- plain name for men's, "<Name> Women" for women's, which is what the
-- team grid's men's/women's split already keys off.
--
-- Team colors left at the default swatch rather than guessed; happy to
-- fill them in on request.
--
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('avl','volleyball','AVL','more')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name) values
  ('adelaide-storm','avl','Adelaide Storm'),
  ('adelaide-storm-women','avl','Adelaide Storm Women'),
  ('canberra-heat','avl','Canberra Heat'),
  ('canberra-heat-women','avl','Canberra Heat Women'),
  ('melbourne-vipers','avl','Melbourne Vipers'),
  ('melbourne-vipers-women','avl','Melbourne Vipers Women'),
  ('nsw-phoenix','avl','NSW Phoenix'),
  ('nsw-phoenix-women','avl','NSW Phoenix Women'),
  ('perth-steel','avl','Perth Steel'),
  ('perth-steel-women','avl','Perth Steel Women'),
  ('queensland-pirates','avl','Queensland Pirates'),
  ('queensland-pirates-women','avl','Queensland Pirates Women')
on conflict (competition_slug, slug) do nothing;
