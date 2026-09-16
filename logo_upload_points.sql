-- Awards +1 point when a proposed team logo is approved, the same way a
-- jersey upload already does — logo proposals take real effort too and
-- weren't earning anything before. Safe to re-run.

create or replace function award_logo_point()
returns trigger as $$
begin
  if new.status = 'approved' and (old.status is distinct from 'approved') and new.proposed_by is not null then
    update profiles set points = points + 1 where id = new.proposed_by;
  end if;
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_logo_approved on team_logo_proposals;
create trigger on_logo_approved
  after update of status on team_logo_proposals
  for each row execute function award_logo_point();
