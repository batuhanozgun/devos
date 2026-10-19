-- w07-break: test=w07_dm34_mission_scope.sql; expect-red=DM34-n1,DM34-n2,DM34-n3,DM34-n4,DM34-n5,DM34-n6
-- Rule removed: admit_work's check that the work item's scope lies within its Mission's (EV-C02-002 DM-34 and
-- section 6; B principle 4; B 3.1). revise_work's check stays, so DM34-n7 must stay green.
-- Specification: tests/C02/W-C02-07/T-W07-DM34_mission_scope.md. How: admit_work(jsonb) is renamed and a wrapper
-- takes its name; it calls the build's function with the Mission's own scope in place of the requested one, then
-- writes the requested scope onto the admitted work item. It holds none of the build's logic. Synthetic
-- (plan Section 8 item 13): no data. Throwaway database only (README 5.2), never under supabase/migrations/.
-- No psql meta-command.
-- Revised under ledger rule 3, 2026-10-18 (N-285 (3); CHK-C02-089 C2 (a)), before any result of this break: the first
-- version read devos_private.mission.scope, a column the mission table does not have (the scope is in
-- mission_revision, migration 20261014170203), and mission_ref as an object ({id}, D-1's old form; EV-C02-013 section 1
-- item 3 makes it the uuid itself, with mission_revision beside it), so applied the wrapper raised 42703 on every call
-- and DM34 ended COULD NOT CHECK, the break not shown. Now the wrapper reads the scope of the Mission revision the call
-- names (mission_ref, mission_revision) from devos_private.mission_revision. A call that names no such revision, or
-- sends no string scope, is passed through unchanged, so the build's own refusal answers it. The requested scope is
-- written onto the admitted item's revision 1 in the form the N-283 revision gave B-N29-4: work_revision is
-- append-only (trigger work_revision_append_only, migration 20261014170205), so the wrapper turns that one trigger off
-- only for its own update and on again after it. Where work_revision's own CHECK on the scope's form (migration
-- 20261014170203, a second layer this break does not remove) refuses the requested scope (DM34-n4 to -n6), the update
-- is undone and the item keeps the Mission's scope; the answer stays the build's ok, which is what those cases judge.
-- The work_admitted event's payload names the Mission's scope, not the requested one; DM34 reads no event. The whole
-- change runs as one transaction with the guard, so a refused guard aborts everything after it.
begin;  -- the guard and the change in one transaction: a refused guard aborts the whole patch
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  if not exists (select 1 from pg_trigger where tgrelid = to_regclass('devos_private.work_revision')
                 and tgname = 'work_revision_append_only') then
    raise exception 'w07 break patch refused: trigger work_revision_append_only on devos_private.work_revision not found (revise the patch)';
  end if;
end $g$;
alter function devos_api.admit_work(jsonb) rename to admit_work_w07_orig;
create function devos_api.admit_work(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare ms text; r jsonb; rid uuid;
begin
  select x.scope into ms from devos_private.mission_revision x
   where x.mission_id::text = p->>'mission_ref' and x.revision::text = p->>'mission_revision';
  if ms is null or jsonb_typeof(p->'scope') is distinct from 'string' then
    return devos_api.admit_work_w07_orig(p);
  end if;
  r := devos_api.admit_work_w07_orig(p || jsonb_build_object('scope', ms));
  if r->>'status' = 'ok' and p->>'scope' <> ms then
    select x.id into rid from devos_private.work_revision x where x.work_id::text = r->>'id' order by x.revision desc limit 1;
    begin
      alter table devos_private.work_revision disable trigger work_revision_append_only;
      update devos_private.work_revision set scope = p->>'scope' where id = rid;
      alter table devos_private.work_revision enable trigger work_revision_append_only;
    exception when check_violation then
      null;  -- the table's own form check refused the scope: the block (the trigger's switch included) is undone
    end;
  end if;
  return r;
end $f$;
grant execute on function devos_api.admit_work(jsonb) to anon;
commit;
