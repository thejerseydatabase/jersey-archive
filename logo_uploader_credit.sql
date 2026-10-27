-- team_logos/competition_logos never recorded who proposed a logo - the
-- proposal itself (team_logo_proposals/competition_logo_proposals) has
-- proposed_by, but setLogo()/addLogoToHistory() never carried it over
-- into the permanent history row on approval, so that credit was lost
-- the moment a proposal got approved. Nothing to backfill for logos
-- already approved before this (that attribution is genuinely gone),
-- but every new one from here on keeps it.
--
-- Safe to re-run.

alter table team_logos add column if not exists proposed_by uuid references auth.users(id) on delete set null;
alter table competition_logos add column if not exists proposed_by uuid references auth.users(id) on delete set null;
