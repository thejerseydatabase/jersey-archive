-- Raises the jersey upload rate limit from 8/hour to 100/hour — 8 was
-- too easy to hit by accident when uploading several kits for the same
-- team back to back, and getting locked out for an hour is exactly the
-- kind of thing that discourages a new contributor. Trigger arguments
-- can't be changed in place in Postgres, so this drops and recreates it.
-- Safe to re-run.

drop trigger if exists rate_limit_jerseys on jerseys;
create trigger rate_limit_jerseys
  before insert on jerseys
  for each row execute function enforce_upload_rate_limit('uploaded_by', 100, 60);
