-- w07-break: test=w07_roc_ownership_and_claim_class.sql; expect-red=ROC-o-open_decision-sin-cal,ROC-o-open_decision-sin-inst
-- Break patch for T-W07-ROC (N-300 (1), 2026-10-19). Rule removed: Rule O's sin limit in open_decision (EV-C02-008 1.7.1:
-- devos_sinav changes only the work items its exam link names; EV-C02-013 2.2, R1-6). open_decision is wrapped: for a
-- call with the devos_sinav token naming a work item that no EvalRun names, a synthetic EvalRun naming it is written
-- for the call and removed after, so the branch admits the exam environment on any work item. Calls of the other classes
-- are passed through unchanged.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds none of the build's logic: it wraps the build's function and keeps its parameter types
-- and order (README 5.2, "Wrappers"); the build's function moves to devos_private, so that no reader finder sees a copy.
-- The class is read with the build's own derivation (devos_private.caller_role_class), never by reading the token.
-- Synthetic (plan Section 8 item 13): the row it writes is labelled w07 break and removed in the same call. No psql meta-command.
begin;  -- the guard and the change in one transaction: a refused guard aborts the whole patch
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
alter function devos_api.open_decision(jsonb) rename to open_decision_w07_orig;
alter function devos_api.open_decision_w07_orig(jsonb) set schema devos_private;
create function devos_api.open_decision(p jsonb) returns jsonb language plpgsql security definer set search_path = pg_catalog as $f$
declare r jsonb; planted uuid; rev int;
begin
  if jsonb_typeof(p -> 'work_ref') = 'string'
     and devos_private.caller_role_class('open_decision')::text = 'devos_sinav'
     and not exists (select 1 from devos_private.eval_run x where x.work_ref::text = p ->> 'work_ref') then
    select max(v.revision) into rev from devos_private.work_revision v where v.work_id::text = p ->> 'work_ref';
    if rev is not null then
      insert into devos_private.eval_run (eval_set_id, eval_set_version, subject_role, runner_session, work_ref, work_revision, results)
      values ('w07 break', 'w07 break', 'w07 break', 'w07 break', (p ->> 'work_ref')::uuid, rev, '{"w07": "break"}')
      returning id into planted;
    end if;
  end if;
  r := devos_private.open_decision_w07_orig(p);
  if planted is not null then
    alter table devos_private.eval_run disable trigger user;
    delete from devos_private.eval_run where id = planted;
    alter table devos_private.eval_run enable trigger user;
  end if;
  return r;
end $f$;
grant execute on function devos_api.open_decision(jsonb) to anon, authenticated;
commit;
