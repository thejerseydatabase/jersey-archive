-- Adds history_note: a free-text field an admin can set on any team page
-- (same pencil-edit pattern as everything else) to explain a gap in its
-- timeline — folded, merged into another club, or promoted away and back.
-- No new table needed: a defunct or merged-away club (e.g. Annandale, or
-- Western Suburbs Magpies before merging into the Wests Tigers) is just a
-- normal team row with is_active = false and, optionally, a note here.
-- Existing "admins can edit teams" policy already covers this new column.
-- Additive only.

alter table teams add column if not exists history_note text;
