-- Fixes the Supabase Security Advisor warning "View public.jersey_ratings
-- is defined with the SECURITY DEFINER property".
--
-- A plain `create view` runs with the view owner's permissions (typically
-- a privileged role, since that's whoever ran the SQL editor), not the
-- querying user's — which can silently bypass RLS. This flips it to
-- security_invoker, so it runs with the actual querying user's RLS
-- instead. Doesn't change what the view returns here, since the
-- underlying `ratings` table is already fully public to read either way
-- — it just closes the warning and removes the theoretical risk if that
-- table's policy is ever tightened later. Requires Postgres 15+ (Supabase
-- projects already are). Safe to re-run.

alter view jersey_ratings set (security_invoker = true);
