-- Changes jerseys.season from integer to text, so a season can be
-- entered as a single year ("2024") or a year-spanning one ("2026-27") —
-- needed for competitions like the NBA, NBL, EPL, and Bundesliga that
-- don't run on a single calendar year. Existing rows are converted
-- automatically (e.g. 2024 -> "2024"), nothing is lost. Safe to re-run.

alter table jerseys drop constraint if exists jerseys_season_check;
alter table jerseys alter column season type text using season::text;
alter table jerseys add constraint jerseys_season_check check (season ~ '^[0-9]{4}(-[0-9]{2})?$');
