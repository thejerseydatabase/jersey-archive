-- Lets a logo proposal carry its "years used" label from the moment it's
-- submitted, instead of only being settable after the fact via the pencil
-- edit on an already-approved logo in Logo History. The history tables
-- (team_logos / competition_logos) already have years_used (see
-- team_logo_history.sql and competition_logos.sql) - this just adds the
-- same column to the two proposal tables so the value can travel with the
-- proposal through to approval.

alter table team_logo_proposals add column if not exists years_used text;
alter table competition_logo_proposals add column if not exists years_used text;
