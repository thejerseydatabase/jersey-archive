-- Lets the uploader say up front whether a proposed logo should replace the
-- current one on approval, or just be added to history alongside it (e.g.
-- a one-off/backdated logo like a 2017 special edition that shouldn't
-- bump the actual current logo). Defaults to true so existing behavior
-- (every approved proposal becomes current) is unchanged unless someone
-- unticks it.

alter table team_logo_proposals add column if not exists make_current boolean not null default true;
alter table competition_logo_proposals add column if not exists make_current boolean not null default true;
