-- Lets a logo proposal carry a short label beyond just the year(s) used -
-- e.g. "90th Anniversary" on a one-off special-edition crest, so it's
-- clear at a glance why that entry looks different from the regular
-- logo either side of it in history, not just when it was used.
--
-- Safe to re-run.

alter table team_logo_proposals add column if not exists note text;
alter table competition_logo_proposals add column if not exists note text;
alter table team_logos add column if not exists note text;
alter table competition_logos add column if not exists note text;
