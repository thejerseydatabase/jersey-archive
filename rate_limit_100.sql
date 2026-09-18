-- Resets the hourly upload cap to 100/hour across the board, including
-- extra photos added to an already-uploaded jersey (previously a lower
-- 20/hour on its own). The limit is a literal argument baked into each
-- trigger, so it has to be dropped and recreated rather than just
-- updated. Safe to re-run.

drop trigger if exists rate_limit_jerseys on jerseys;
create trigger rate_limit_jerseys
  before insert on jerseys
  for each row execute function enforce_upload_rate_limit('uploaded_by', 100, 60);

drop trigger if exists rate_limit_jersey_images on jersey_images;
create trigger rate_limit_jersey_images
  before insert on jersey_images
  for each row execute function enforce_upload_rate_limit('uploaded_by', 100, 60);

drop trigger if exists rate_limit_logo_proposals on team_logo_proposals;
create trigger rate_limit_logo_proposals
  before insert on team_logo_proposals
  for each row execute function enforce_upload_rate_limit('proposed_by', 100, 60);

drop trigger if exists rate_limit_comp_logo_proposals on competition_logo_proposals;
create trigger rate_limit_comp_logo_proposals
  before insert on competition_logo_proposals
  for each row execute function enforce_upload_rate_limit('proposed_by', 100, 60);
