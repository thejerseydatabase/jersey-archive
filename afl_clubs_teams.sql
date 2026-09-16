-- Adds the AFL competition and its 18 clubs (sport "afl" already exists).
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('afl','afl','AFL','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('adelaide-crows','afl','Adelaide Crows','#002B5C','#FDB913'),
  ('brisbane-lions','afl','Brisbane Lions','#6A0032','#F5B324'),
  ('carlton-blues','afl','Carlton Blues','#051094','#FFFFFF'),
  ('collingwood-magpies','afl','Collingwood Magpies','#000000','#FFFFFF'),
  ('essendon-bombers','afl','Essendon Bombers','#CC2031','#000000'),
  ('fremantle-dockers','afl','Fremantle Dockers','#2E0A54','#FFFFFF'),
  ('geelong-cats','afl','Geelong Cats','#002B5C','#FFFFFF'),
  ('gold-coast-suns','afl','Gold Coast Suns','#E2231A','#FFD200'),
  ('greater-western-sydney-giants','afl','Greater Western Sydney Giants','#F57F17','#333333'),
  ('hawthorn-hawks','afl','Hawthorn Hawks','#4D2004','#FFC72C'),
  ('melbourne-demons','afl','Melbourne Demons','#061A2E','#C8102E'),
  ('north-melbourne-kangaroos','afl','North Melbourne Kangaroos','#013B9F','#FFFFFF'),
  ('port-adelaide-power','afl','Port Adelaide Power','#008E9B','#000000'),
  ('richmond-tigers','afl','Richmond Tigers','#FFD200','#000000'),
  ('st-kilda-saints','afl','St Kilda Saints','#ED1B34','#000000'),
  ('sydney-swans','afl','Sydney Swans','#E2231A','#FFFFFF'),
  ('west-coast-eagles','afl','West Coast Eagles','#0A2351','#FFC72C'),
  ('western-bulldogs','afl','Western Bulldogs','#E2231A','#002B5C')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
