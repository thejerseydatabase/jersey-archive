-- sports_tier.sql's "on conflict (slug) do nothing" silently skipped
-- lacrosse because the row already existed, leaving it on the 'top'
-- default from the alter table instead of picking up tier='more' -
-- gaelic-football was a genuinely new row so it worked correctly.
-- Explicit fix, independent of root cause. Safe to re-run.

update sports set tier = 'more', sort_order = 13 where slug = 'lacrosse';
