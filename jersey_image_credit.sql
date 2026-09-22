-- Lets an uploader (or an admin editing later) note where a jersey's
-- photos came from — an eBay listing, a team store, an Instagram handle,
-- their own collection, etc. Purely informational, shown on the jersey's
-- detail page next to its notes. Safe to re-run.

alter table jerseys add column if not exists image_credit text;
