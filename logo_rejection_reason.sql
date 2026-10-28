-- Rejecting a logo proposal used to delete the row outright, so there
-- was nowhere to record why and nothing to show the proposer. Same fix
-- as jerseys got earlier: the row is kept with status='rejected' and an
-- optional reason instead of being deleted - only the image FILE is
-- removed from storage, same as a rejected jersey's photos. The status
-- column on both tables already allows 'rejected' (see schema.sql), so
-- this just adds somewhere to put the explanation.
--
-- Safe to re-run.

alter table team_logo_proposals add column if not exists rejection_reason text;
alter table competition_logo_proposals add column if not exists rejection_reason text;
