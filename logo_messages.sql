-- Same idea as jersey_messages, but logo proposals have no page of
-- their own the way a jersey does (there's no #/jersey/<id>-equivalent
-- for a logo submission), so this needs its own small detail page
-- (added in app.js as #/logo-proposal/<kind>/<id>) for the thread to
-- live on. One row set references team_logo_proposals, the other
-- competition_logo_proposals - exactly one is set per row, enforced by
-- the check constraint. Rejecting a proposal deletes its row (and so,
-- via cascade, its messages too) - same as rejecting a jersey already
-- strips its photos; the conversation only needs to survive as long as
-- the thing it's about does.
--
-- Safe to re-run.

create table if not exists logo_messages (
  id uuid primary key default gen_random_uuid(),
  kind text not null check (kind in ('team','competition')),
  team_logo_proposal_id uuid references team_logo_proposals(id) on delete cascade,
  competition_logo_proposal_id uuid references competition_logo_proposals(id) on delete cascade,
  sender_id uuid not null references auth.users(id) on delete cascade,
  message text not null,
  created_at timestamptz not null default now(),
  check (
    (kind = 'team' and team_logo_proposal_id is not null and competition_logo_proposal_id is null)
    or (kind = 'competition' and competition_logo_proposal_id is not null and team_logo_proposal_id is null)
  )
);

alter table logo_messages enable row level security;

drop policy if exists "thread participants can read logo messages" on logo_messages;
create policy "thread participants can read logo messages"
  on logo_messages for select using (
    exists (select 1 from team_logo_proposals p where p.id = team_logo_proposal_id and p.proposed_by = (select auth.uid()))
    or exists (select 1 from competition_logo_proposals p where p.id = competition_logo_proposal_id and p.proposed_by = (select auth.uid()))
    or exists (select 1 from profiles pr where pr.id = (select auth.uid()) and pr.is_admin)
  );

drop policy if exists "thread participants can send logo messages" on logo_messages;
create policy "thread participants can send logo messages"
  on logo_messages for insert to authenticated
  with check (
    sender_id = (select auth.uid())
    and (
      exists (select 1 from team_logo_proposals p where p.id = team_logo_proposal_id and p.proposed_by = (select auth.uid()))
      or exists (select 1 from competition_logo_proposals p where p.id = competition_logo_proposal_id and p.proposed_by = (select auth.uid()))
      or exists (select 1 from profiles pr where pr.id = (select auth.uid()) and pr.is_admin)
    )
  );

create index if not exists logo_messages_team_proposal_idx on logo_messages(team_logo_proposal_id);
create index if not exists logo_messages_comp_proposal_idx on logo_messages(competition_logo_proposal_id);

drop trigger if exists block_banned_logo_messages on logo_messages;
create trigger block_banned_logo_messages
  before insert on logo_messages
  for each row execute function enforce_not_banned('sender_id');

-- Same unread-tracking idea as jersey_message_unread.sql, so the
-- topbar's red envelope badge covers a reply on either kind of thread,
-- not just jersey ones. proposal_id deliberately has no FK (a logo
-- proposal can be either table depending on kind, and Postgres has no
-- single-column FK that can point at two different tables) - this is
-- just a read marker, not data that needs referential integrity, and
-- (kind, proposal_id, user_id) being a plain (non-partial) unique
-- constraint is what lets a normal upsert target it directly.
create table if not exists logo_message_reads (
  kind text not null check (kind in ('team','competition')),
  proposal_id uuid not null,
  user_id uuid not null references auth.users(id) on delete cascade,
  last_read_at timestamptz not null default now(),
  unique (kind, proposal_id, user_id)
);

alter table logo_message_reads enable row level security;

drop policy if exists "users can manage their own logo read markers" on logo_message_reads;
create policy "users can manage their own logo read markers"
  on logo_message_reads for all
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop view if exists my_unread_logo_messages;
create view my_unread_logo_messages with (security_invoker = true) as
select 'team'::text as kind, lm.team_logo_proposal_id as proposal_id, max(lm.created_at) as latest_at
from logo_messages lm
where lm.kind = 'team' and lm.sender_id <> (select auth.uid())
  and lm.created_at > coalesce(
    (select r.last_read_at from logo_message_reads r where r.kind = 'team' and r.proposal_id = lm.team_logo_proposal_id and r.user_id = (select auth.uid())),
    'epoch'::timestamptz
  )
group by lm.team_logo_proposal_id
union all
select 'competition'::text as kind, lm.competition_logo_proposal_id as proposal_id, max(lm.created_at) as latest_at
from logo_messages lm
where lm.kind = 'competition' and lm.sender_id <> (select auth.uid())
  and lm.created_at > coalesce(
    (select r.last_read_at from logo_message_reads r where r.kind = 'competition' and r.proposal_id = lm.competition_logo_proposal_id and r.user_id = (select auth.uid())),
    'epoch'::timestamptz
  )
group by lm.competition_logo_proposal_id;

-- Carries the proposal's own id through to the permanent history row on
-- approval, same as proposed_by/note already do (logo_uploader_credit.sql,
-- logo_occasion_note.sql) - without it there's no way back to
-- #/logo-proposal/<kind>/<id> (and its Messages thread) once a logo's
-- off the Moderate queue. Older history predates this and has none;
-- the Logo History link just doesn't show for those.
alter table team_logos add column if not exists proposal_id uuid references team_logo_proposals(id) on delete set null;
alter table competition_logos add column if not exists proposal_id uuid references competition_logo_proposals(id) on delete set null;
