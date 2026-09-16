-- Supports two moderation-queue changes:
--  1. Admins can now edit a pending jersey's season/type/manufacturer/notes
--     before approving it (no schema change needed — the existing "admins
--     can moderate jerseys" update policy already covers any column).
--  2. Rejecting a jersey now keeps the row (status='rejected') instead of
--     deleting it, with an optional reason visible to the uploader on
--     their own submission's page. This column stores that reason.
-- Safe to re-run.

alter table jerseys add column if not exists rejection_reason text;
