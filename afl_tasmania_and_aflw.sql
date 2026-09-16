-- Adds Tasmania Devils to the AFL as an upcoming expansion team (joining
-- 2028), and creates AFLW as its own competition (same clubs as the AFL,
-- since AFLW fields its own separate teams) with Tasmania Devils marked
-- upcoming there too. Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_upcoming, history_note) values
  ('tasmania-devils','afl','Tasmania Devils','#6A0032','#002664', true, 'Joining the AFL in 2028.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_upcoming = excluded.is_upcoming, history_note = excluded.history_note;

insert into competitions (slug, sport_slug, name, tier) values
  ('aflw','afl','AFLW','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adelaide-crows','aflw','Adelaide Crows','#002B5C','#FDB913'),
  ('brisbane-lions','aflw','Brisbane Lions','#6A0032','#F5B324'),
  ('carlton-fc','aflw','Carlton FC','#051094','#FFFFFF'),
  ('collingwood-magpies','aflw','Collingwood Magpies','#000000','#FFFFFF'),
  ('essendon-bombers','aflw','Essendon Bombers','#CC2031','#000000'),
  ('fremantle-dockers','aflw','Fremantle Dockers','#2E0A54','#FFFFFF'),
  ('geelong-cats','aflw','Geelong Cats','#002B5C','#FFFFFF'),
  ('gold-coast-suns','aflw','Gold Coast Suns','#E2231A','#FFD200'),
  ('gws-giants','aflw','GWS Giants','#F57F17','#333333'),
  ('hawthorn-hawks','aflw','Hawthorn Hawks','#4D2004','#FFC72C'),
  ('melbourne-demons','aflw','Melbourne Demons','#061A2E','#C8102E'),
  ('north-melbourne-kangaroos','aflw','North Melbourne Kangaroos','#013B9F','#FFFFFF'),
  ('port-adelaide-power','aflw','Port Adelaide Power','#008E9B','#000000'),
  ('richmond-tigers','aflw','Richmond Tigers','#FFD200','#000000'),
  ('st-kilda','aflw','St Kilda','#ED1B34','#000000'),
  ('sydney-swans','aflw','Sydney Swans','#E2231A','#FFFFFF'),
  ('west-coast-eagles','aflw','West Coast Eagles','#0A2351','#FFC72C'),
  ('western-bulldogs','aflw','Western Bulldogs','#E2231A','#002B5C')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_upcoming, history_note) values
  ('tasmania-devils','aflw','Tasmania Devils','#6A0032','#002664', true, 'Joining the AFLW in 2028.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_upcoming = excluded.is_upcoming, history_note = excluded.history_note;
