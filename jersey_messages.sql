-- A small private back-and-forth on a single jersey - lets a moderator
-- ask "can you find a better photo?" or "are you sure that's the right
-- year?" instead of either approving as-is or flat-out rejecting over
-- something fixable. Not a general messaging system: each thread is
-- scoped to one jersey, and only that jersey's own uploader and admins
-- can see or post in it (enforced by RLS below, not just hidden in the
-- UI) - the same two groups who can already see a pending/rejected
-- jersey at all, per "visible jerseys are readable" in moderation.sql.
--
-- Safe to re-run.

create table if not exists jersey_messages (
  id uuid primary key default gen_random_uuid(),
  jersey_id uuid not null references jerseys(id) on delete cascade,
  sender_id uuid not null references auth.users(id) on delete cascade,
  message text not null,
  created_at timestamptz not null default now()
);

alter table jersey_messages enable row level security;

drop policy if exists "thread participants can read jersey messages" on jersey_messages;
create policy "thread participants can read jersey messages"
  on jersey_messages for select using (
    exists (select 1 from jerseys j where j.id = jersey_id and (
      j.uploaded_by = (select auth.uid())
      or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
    ))
  );

drop policy if exists "thread participants can send jersey messages" on jersey_messages;
create policy "thread participants can send jersey messages"
  on jersey_messages for insert to authenticated
  with check (
    sender_id = (select auth.uid())
    and exists (select 1 from jerseys j where j.id = jersey_id and (
      j.uploaded_by = (select auth.uid())
      or exists (select 1 from profiles p where p.id = (select auth.uid()) and p.is_admin)
    ))
  );

create index if not exists jersey_messages_jersey_idx on jersey_messages(jersey_id);

-- Same ban enforcement every other user-contributed table gets.
drop trigger if exists block_banned_jersey_messages on jersey_messages;
create trigger block_banned_jersey_messages
  before insert on jersey_messages
  for each row execute function enforce_not_banned('sender_id');
