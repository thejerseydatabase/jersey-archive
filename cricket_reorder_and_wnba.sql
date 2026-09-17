-- 1. Cricket competition-page reordering: WNCL moves into "More
--    competitions", while PSL, SA20, Dean Jones Trophy, and BPL move up
--    into the always-visible top section.
-- 2. Adds the WNBA as a new competition under basketball, with its 12
--    current teams.
-- Safe to re-run.

update competitions set tier = 'more' where slug = 'australia-domestic-women';

update competitions set tier = 'top', sort_order = 6 where slug = 'psl';
update competitions set tier = 'top', sort_order = 7 where slug = 'sa20';
update competitions set tier = 'top', sort_order = 8 where slug = 'dean-jones-cup';
update competitions set tier = 'top', sort_order = 9 where slug = 'bpl';

insert into competitions (slug, sport_slug, name, tier, sort_order) values
  ('wnba','basketball','WNBA','top',2)
on conflict (slug) do nothing;

update competitions set sort_order = 3 where slug = 'nbl';
update competitions set sort_order = 4 where slug = 'wnbl';

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('atlanta-dream','wnba','Atlanta Dream','#C8102E','#5091CD'),
  ('chicago-sky','wnba','Chicago Sky','#418FDE','#FFD520'),
  ('connecticut-sun','wnba','Connecticut Sun','#E2231A','#F58426'),
  ('dallas-wings','wnba','Dallas Wings','#0C2340','#C4D600'),
  ('indiana-fever','wnba','Indiana Fever','#E03A3E','#FDBB30'),
  ('las-vegas-aces','wnba','Las Vegas Aces','#000000','#C8102E'),
  ('los-angeles-sparks','wnba','Los Angeles Sparks','#552583','#FFC72C'),
  ('minnesota-lynx','wnba','Minnesota Lynx','#236192','#78BE21'),
  ('new-york-liberty','wnba','New York Liberty','#6ECEB2','#000000'),
  ('phoenix-mercury','wnba','Phoenix Mercury','#201747','#E56020'),
  ('seattle-storm','wnba','Seattle Storm','#2C5234','#FE5000'),
  ('washington-mystics','wnba','Washington Mystics','#002B5C','#E03A3E')
on conflict (competition_slug, slug) do nothing;
