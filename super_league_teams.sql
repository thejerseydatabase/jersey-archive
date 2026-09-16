-- Adds the current 14 Super League teams, and an is_active flag on teams
-- so a promotion/relegation competition like this one can show "Former
-- teams" underneath the current lineup without moving or deleting a
-- relegated club's jersey history — its team page and every jersey stay
-- exactly where they are, it just gets flagged is_active = false and moves
-- into that section instead. When a club comes back up, flip it back to
-- true. Safe to re-run.
--
-- Colours here are lower-confidence than the NRL/NRLW ones (UK club
-- branding I'm less sure of at this level of detail) — flag anything that
-- looks off, same as before, and it's an easy fix since it's only a
-- fallback swatch until a real logo is uploaded.

alter table teams add column if not exists is_active boolean not null default true;

insert into teams (slug, competition_slug, name, primary_color, secondary_color) values
  ('bradford-bulls','super-league','Bradford Bulls','#8A1538','#FFB81C'),
  ('castleford-tigers','super-league','Castleford Tigers','#000000','#FDB913'),
  ('catalans-dragons','super-league','Catalans Dragons','#D2202B','#FFD100'),
  ('huddersfield-giants','super-league','Huddersfield Giants','#6C1D45','#FFD200'),
  ('hull-fc','super-league','Hull FC','#000000','#FFFFFF'),
  ('hull-kr','super-league','Hull KR','#D2202B','#FFFFFF'),
  ('leeds-rhinos','super-league','Leeds Rhinos','#003087','#FDB913'),
  ('leigh-leopards','super-league','Leigh Leopards','#C8102E','#FFD200'),
  ('st-helens','super-league','St Helens','#D2202B','#FFFFFF'),
  ('toulouse-olympique','super-league','Toulouse Olympique','#8C1D2D','#000000'),
  ('wakefield-trinity','super-league','Wakefield Trinity','#003DA5','#FFFFFF'),
  ('warrington-wolves','super-league','Warrington Wolves','#FFF200','#00205B'),
  ('wigan-warriors','super-league','Wigan Warriors','#8C1D40','#FFFFFF'),
  ('york-knights','super-league','York Knights','#7A1F2B','#FFD200')
on conflict (competition_slug, slug) do update
  set primary_color = excluded.primary_color, secondary_color = excluded.secondary_color;
