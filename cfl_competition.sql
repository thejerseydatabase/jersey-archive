-- Adds the CFL (Canadian Football League) as a new competition under
-- the existing Gridiron sport (same sport as the NFL, since it's the
-- same style of jersey/game — happy to split it into its own sport
-- instead if you'd rather, just say so), with its 9 current teams plus
-- defunct/relocated ones from your Wikipedia list.
--
-- The current Montreal Alouettes and Ottawa Redblacks are separate rows
-- from their same-named-ish historical predecessors below, since the
-- CFL itself treats them as discontinuous franchises (each folded
-- before the current one started), not a single continuous team.
-- Safe to re-run.

insert into competitions (slug, sport_slug, name, tier) values
  ('cfl','american-football','CFL','more')
on conflict (slug) do nothing;

-- ============ Current CFL teams ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('hamilton-tiger-cats','cfl','Hamilton Tiger-Cats','#FFC72C','#000000'),
  ('montreal-alouettes','cfl','Montreal Alouettes','#A6192E','#000000'),
  ('ottawa-redblacks','cfl','Ottawa Redblacks','#000000','#C8102E'),
  ('toronto-argonauts','cfl','Toronto Argonauts','#002D62','#8FBCE6'),
  ('bc-lions','cfl','BC Lions','#FF7900','#000000'),
  ('calgary-stampeders','cfl','Calgary Stampeders','#C8102E','#000000'),
  ('edmonton-elks','cfl','Edmonton Elks','#00843D','#FFC72C'),
  ('saskatchewan-roughriders','cfl','Saskatchewan Roughriders','#00843D','#FFFFFF'),
  ('winnipeg-blue-bombers','cfl','Winnipeg Blue Bombers','#00245D','#FFC72C')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;

-- ============ Defunct/relocated CFL teams ============
insert into teams (slug, competition_slug, name, primary_color, secondary_color, is_active, history_note) values
  ('baltimore-stallions','cfl','Baltimore Stallions','#241773','#000000', false,
   'Played 1994-1995 as part of the CFL''s brief US expansion; relocated to Montreal in 1996, forming the current Montreal Alouettes.'),
  ('birmingham-barracudas','cfl','Birmingham Barracudas','#00843D','#000000', false,
   'Played only the 1995 season.'),
  ('las-vegas-posse','cfl','Las Vegas Posse','#C8102E','#000000', false,
   'Played only the 1994 season.'),
  ('memphis-mad-dogs','cfl','Memphis Mad Dogs','#002664','#FFC72C', false,
   'Played only the 1995 season.'),
  ('montreal-alouettes-1946','cfl','Montreal Alouettes (1946-1981)','#A6192E','#000000', false,
   'Folded in 1981; a separate franchise from the current Montreal Alouettes (est. 1996).'),
  ('montreal-concordes','cfl','Montreal Concordes','#000000','#FFC72C', false,
   'Played 1982-1987 (renamed from/to Alouettes at points); folded before the current Montreal Alouettes started in 1996.'),
  ('ottawa-rough-riders','cfl','Ottawa Rough Riders','#C8102E','#000000', false,
   'Played 1876-1996 before folding; a separate franchise from the current Ottawa Redblacks (est. 2014).'),
  ('ottawa-renegades','cfl','Ottawa Renegades','#C8102E','#000000', false,
   'Played 2002-2005 before folding; a separate franchise from the current Ottawa Redblacks (est. 2014).'),
  ('sacramento-gold-miners','cfl','Sacramento Gold Miners','#FFC72C','#000000', false,
   'Played 1993-1994 as part of the CFL''s brief US expansion.'),
  ('san-antonio-texans-cfl','cfl','San Antonio Texans','#002664','#C8102E', false,
   'Played only the 1995 season.'),
  ('shreveport-pirates','cfl','Shreveport Pirates','#000000','#C8102E', false,
   'Played 1994-1995.')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color,
      is_active = excluded.is_active, history_note = excluded.history_note;
