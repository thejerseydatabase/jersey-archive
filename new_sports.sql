-- Adds American Football and Baseball as sports (NFL/MLB need a home;
-- basketball, ice-hockey, afl and cricket already exist). Safe to re-run.

insert into sports (slug, name, sort_order) values
  ('american-football','American Football',8),
  ('baseball','Baseball',9)
on conflict (slug) do nothing;
