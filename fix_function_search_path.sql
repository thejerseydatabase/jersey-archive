-- Fixes the "Function Search Path Mutable" warning Supabase's Security
-- Advisor flagged (you saw it on award_logo_point, but the same issue
-- applies to every security definer function on the site — this fixes
-- all six).
--
-- Why it matters: a security definer function runs with the function
-- OWNER's privileges, but without a pinned search_path it still resolves
-- unqualified table/function names using whatever search_path the
-- CALLING session happens to have. That means a caller who can create an
-- object earlier in their own search_path (e.g. a same-named table in a
-- schema they control) could get the function to silently operate on
-- their object instead of the real one. Pinning search_path closes that
-- off entirely, at no cost — these functions only ever touch tables in
-- "public" anyway.
--
-- Not something that's actively been exploited here — none of these
-- functions were reachable in a way that made it a live problem — but
-- it's the correct fix and Supabase is right to flag it. Safe to re-run.

alter function handle_new_user() set search_path = public;
alter function award_upload_point() set search_path = public;
alter function award_logo_point() set search_path = public;
alter function award_comp_logo_point() set search_path = public;
alter function enforce_upload_rate_limit() set search_path = public;
alter function enforce_report_rate_limit() set search_path = public;
