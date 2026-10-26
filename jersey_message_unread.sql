-- Nothing currently tells either side of a jersey_messages thread that
-- a reply came in - the uploader (or admin) would only find out by
-- revisiting that exact jersey's page. Adds per-user read tracking and
-- a view that surfaces "threads with something new since I last looked",
-- which the topbar uses for a small unread badge next to your username.
--
-- Safe to re-run.

create table if not exists jersey_message_reads (
  jersey_id uuid not null references jerseys(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  last_read_at timestamptz not null default now(),
  primary key (jersey_id, user_id)
);

alter table jersey_message_reads enable row level security;

drop policy if exists "users can manage their own read markers" on jersey_message_reads;
create policy "users can manage their own read markers"
  on jersey_message_reads for all
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

-- security_invoker so this runs under the querying user's own RLS, same
-- convention as the jersey_ratings view in schema.sql - the WHERE
-- clause's own auth.uid() checks mean each caller only ever sees their
-- own unread threads regardless, but this keeps it consistent anyway.
-- Relies on jersey_messages' own RLS to only ever expose rows from
-- threads the current user is actually a participant in.
drop view if exists my_unread_jersey_messages;
create view my_unread_jersey_messages with (security_invoker = true) as
select jm.jersey_id, max(jm.created_at) as latest_at
from jersey_messages jm
where jm.sender_id <> (select auth.uid())
  and jm.created_at > coalesce(
    (select r.last_read_at from jersey_message_reads r where r.jersey_id = jm.jersey_id and r.user_id = (select auth.uid())),
    'epoch'::timestamptz
  )
group by jm.jersey_id;
