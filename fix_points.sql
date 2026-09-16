-- One-time fix: before the moderation queue existed, points were awarded on
-- every raw upload attempt (including ones later deleted), not just
-- approved ones. This recalculates everyone's points from what's actually
-- true today — their real approved-upload count — so it's correct
-- regardless of exactly how it drifted. Safe to run any time.

update profiles p
set points = (
  select count(*) from jerseys j where j.uploaded_by = p.id and j.status = 'approved'
);
