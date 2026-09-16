-- Adds the 15 current QLD Cup (Hostplus Cup) teams. Safe to re-run.

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('brisbane-tigers','qld-cup','Brisbane Tigers','#000000','#FFD700'),
  ('burleigh-bears','qld-cup','Burleigh Bears','#6A0032','#FFD700'),
  ('central-queensland-capras','qld-cup','Central Queensland Capras','#F57F17','#000000'),
  ('ipswich-jets','qld-cup','Ipswich Jets','#003893','#FFD700'),
  ('mackay-cutters','qld-cup','Mackay Cutters','#002664','#FFD700'),
  ('northern-pride','qld-cup','Northern Pride','#5C2D91','#FFD700'),
  ('norths-devils','qld-cup','Norths Devils','#CE1126','#000000'),
  ('papua-new-guinea-hunters','qld-cup','Papua New Guinea Hunters','#CE1126','#000000'),
  ('redcliffe-dolphins','qld-cup','Redcliffe Dolphins','#CE1126','#FFFFFF'),
  ('souths-logan-magpies','qld-cup','Souths Logan Magpies','#000000','#FFFFFF'),
  ('sunshine-coast-falcons','qld-cup','Sunshine Coast Falcons','#003893','#FFD700'),
  ('townsville-blackhawks','qld-cup','Townsville Blackhawks','#000000','#CE1126'),
  ('tweed-seagulls','qld-cup','Tweed Seagulls','#003893','#FFFFFF'),
  ('western-clydesdales','qld-cup','Western Clydesdales','#6A0032','#FFD700'),
  ('wynnum-manly-seagulls','qld-cup','Wynnum Manly Seagulls','#002664','#FFFFFF')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
