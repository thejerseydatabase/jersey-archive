-- Raises the jersey upload rate limit from 100/hour to 120/hour, so
-- jerseys and logo proposals share the same round number and the help
-- page can state one limit that actually applies to both. Safe to re-run.

drop trigger if exists rate_limit_jerseys on jerseys;
create trigger rate_limit_jerseys
  before insert on jerseys
  for each row execute function enforce_upload_rate_limit('uploaded_by', 120, 60);
