-- Adds the Bundesliga (German football) competition and its 18 clubs.
-- This looks like it never actually got run — a competition called
-- "Bundesliga" was written into an earlier file (npc_bundesliga_seriea_teams.sql,
-- alongside NPC and Serie A) but a later file's notes wrongly assumed it
-- was already live, so nothing since has re-created it. This file
-- stands alone and is safe to re-run — if some of these rows already
-- exist under the older slugs from that original file, this just
-- upserts colours onto them rather than duplicating.
--
-- Your new list matches the 18 clubs already planned, just with slightly
-- different display names in a couple of spots (e.g. "Mainz 05" here vs
-- "1. FSV Mainz 05", "Bayern Munich" vs "FC Bayern Munich") — kept the
-- fuller official names since that's what the rest of the site uses for
-- German clubs' official/legal names elsewhere (VfB Stuttgart, TSG 1899
-- Hoffenheim, etc.) — flag me if you'd rather match your shorter list
-- exactly.

insert into competitions (slug, sport_slug, name, tier) values
  ('bundesliga','football','Bundesliga','top')
on conflict (slug) do nothing;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('fc-bayern-munich','bundesliga','FC Bayern Munich','#DC052D','#0066B2'),
  ('borussia-dortmund','bundesliga','Borussia Dortmund','#FDE100','#000000'),
  ('bayer-leverkusen','bundesliga','Bayer Leverkusen','#E32219','#000000'),
  ('fc-schalke-04','bundesliga','FC Schalke 04','#004D9D','#FFFFFF'),
  ('hamburger-sv','bundesliga','Hamburger SV','#003087','#000000'),
  ('sv-werder-bremen','bundesliga','SV Werder Bremen','#00963A','#FFFFFF'),
  ('1-fc-koln','bundesliga','1. FC Köln','#ED1C24','#FFFFFF'),
  ('eintracht-frankfurt','bundesliga','Eintracht Frankfurt','#000000','#E1000F'),
  ('borussia-monchengladbach','bundesliga','Borussia Mönchengladbach','#000000','#FFFFFF'),
  ('vfb-stuttgart','bundesliga','VfB Stuttgart','#E32219','#FFFFFF'),
  ('1-fsv-mainz-05','bundesliga','1. FSV Mainz 05','#C3141E','#FFFFFF'),
  ('sc-freiburg','bundesliga','SC Freiburg','#E2001A','#000000'),
  ('rb-leipzig','bundesliga','RB Leipzig','#DD0741','#FFFFFF'),
  ('1-fc-union-berlin','bundesliga','1. FC Union Berlin','#EB1923','#FFCE00'),
  ('fc-augsburg','bundesliga','FC Augsburg','#BA3733','#00843D'),
  ('tsg-1899-hoffenheim','bundesliga','TSG 1899 Hoffenheim','#1961B5','#FFFFFF'),
  ('sc-paderborn-07','bundesliga','SC Paderborn 07','#0057A8','#000000'),
  ('sv-elversberg','bundesliga','SV Elversberg','#003DA5','#FFFFFF')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
