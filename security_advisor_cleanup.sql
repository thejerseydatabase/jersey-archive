-- Addresses the two real findings from the Security Advisor batch (the
-- "always true" INSERT policies on competitions/teams/reports are left
-- alone — those are intentional; see chat).
--
-- 1. Drops the "anyone can view X" SELECT policies on the three public
--    storage buckets. These buckets are marked Public, so direct image
--    URLs (what the app actually uses) don't need any RLS policy at all
--    to keep working — the only thing this policy was doing was also
--    letting anyone LIST every file in the bucket via the API, which for
--    report-attachments specifically defeats the "nothing here is public
--    until an admin acts on it" intent from when that bucket was set up.
--
-- 2. Revokes direct EXECUTE on the six trigger functions from
--    anon/authenticated/public. These only ever run automatically as
--    triggers — Postgres refuses to let anyone invoke a `returns
--    trigger` function directly regardless of this grant, so nothing
--    breaks — but Supabase exposes every function as an API route by
--    default unless EXECUTE is revoked, which is what the Advisor is
--    flagging. This just closes that unused door.
--
-- Safe to re-run.

drop policy if exists "anyone can view jersey photos" on storage.objects;
drop policy if exists "anyone can view report attachments" on storage.objects;
drop policy if exists "anyone can view team logos" on storage.objects;

revoke execute on function handle_new_user() from public, anon, authenticated;
revoke execute on function award_upload_point() from public, anon, authenticated;
revoke execute on function award_logo_point() from public, anon, authenticated;
revoke execute on function award_comp_logo_point() from public, anon, authenticated;
revoke execute on function enforce_upload_rate_limit() from public, anon, authenticated;
revoke execute on function enforce_report_rate_limit() from public, anon, authenticated;
