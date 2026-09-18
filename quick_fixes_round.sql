-- Several small fixes:
-- 1. Removes IFAF World Championship entirely (not relevant to Gridiron).
-- 2. Moves every "International..." competition (any sport) and ABL to
--    the top tier, out from under "More competitions".
-- 3. Adds Sydney Sirens (joining Suncorp Super Netball in 2027,
--    replacing Giants Netball) and marks Giants Netball as former.
-- Safe to re-run.

delete from competitions where slug = 'ifaf-world-championship';

update competitions set tier = 'top' where name ilike 'International%';
update competitions set tier = 'top' where slug = 'abl';

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_upcoming, history_note) values
  ('sydney-sirens','super-netball','Sydney Sirens','#000000','#FFD700', true,
   'Joining the Suncorp Super Netball in 2027, replacing Giants Netball.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_upcoming = excluded.is_upcoming, history_note = excluded.history_note;

update teams set is_active = false,
  history_note = 'Played in the Suncorp Super Netball from 2017 until 2026; replaced by the Sydney Sirens from 2027.'
where competition_slug = 'super-netball' and slug = 'giants-netball';
