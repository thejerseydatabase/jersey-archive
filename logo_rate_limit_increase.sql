-- Raises the team-logo-proposal rate limit from 5/hour to 120/hour — 5 was
-- far too easy to hit while proposing logos for several teams in one
-- session. Trigger arguments can't be changed in place in Postgres, so
-- this drops and recreates it. Safe to re-run.

drop trigger if exists rate_limit_logo_proposals on team_logo_proposals;
create trigger rate_limit_logo_proposals
  before insert on team_logo_proposals
  for each row execute function enforce_upload_rate_limit('proposed_by', 120, 60);
