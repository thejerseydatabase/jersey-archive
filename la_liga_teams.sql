-- Adds La Liga (Spain) and its current 20 clubs. Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('la-liga','football','La Liga','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('athletic-club','la-liga','Athletic Club','#EE2523','#FFFFFF'),
  ('atletico-madrid','la-liga','Atlético Madrid','#CB3524','#272E61'),
  ('ca-osasuna','la-liga','CA Osasuna','#D2122E','#001A4B'),
  ('deportivo-alaves','la-liga','Deportivo Alavés','#1F3F8B','#FFFFFF'),
  ('deportivo-de-a-coruna','la-liga','Deportivo de A Coruña','#0055A4','#FFFFFF'),
  ('elche-cf','la-liga','Elche CF','#00843D','#FFFFFF'),
  ('fc-barcelona','la-liga','FC Barcelona','#A50044','#004D98'),
  ('getafe-cf','la-liga','Getafe CF','#005BAA','#FFFFFF'),
  ('levante-ud','la-liga','Levante UD','#003DA5','#C8102E'),
  ('malaga-cf','la-liga','Málaga CF','#0055A4','#FFFFFF'),
  ('racing-de-santander','la-liga','Racing de Santander','#00A65E','#FFFFFF'),
  ('rayo-vallecano','la-liga','Rayo Vallecano','#FFFFFF','#C8102E'),
  ('rc-celta-de-vigo','la-liga','RC Celta de Vigo','#8AC6E8','#FFFFFF'),
  ('rcd-espanyol','la-liga','RCD Espanyol','#003DA5','#FFFFFF'),
  ('real-betis','la-liga','Real Betis','#00954C','#FFFFFF'),
  ('real-madrid','la-liga','Real Madrid','#FFFFFF','#00396F'),
  ('real-sociedad','la-liga','Real Sociedad','#0F3F7C','#FFFFFF'),
  ('sevilla-fc','la-liga','Sevilla FC','#FFFFFF','#D2122E'),
  ('valencia-cf','la-liga','Valencia CF','#FFFFFF','#F7941D'),
  ('villarreal-cf','la-liga','Villarreal CF','#FFE667','#005187')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
