-- w07-break: test=w07_n08_exam_records.sql; expect-red=N08-wp4
-- Break patch for T-W07-N08 part A (N-301, 2026-10-19: CHK-C02-102 C2, the rule its break X5 showed no merged case
-- reached). Rule removed: the EvalRun records the revision of the work item the call names (B 3.15's work_ref
-- "+revision: the work item an exam task was opened as"; B principle 3). record_eval_run is wrapped so that, after the
-- build's accepted call, the EvalRun it wrote names the work item's latest revision instead (the table's user triggers
-- off for that update only).
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can: it wraps the build's function and keeps its
-- parameter types and order (README 5.2, "Wrappers").
-- Synthetic (plan Section 8 item 13): no data; any value it writes is labelled w07 break. No psql meta-command is used.
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
-- The build's function moves out of devos_api, so that part A's finder (the devos_api functions whose text names
-- EvalRun's table) does not hold the renamed copy to the read rule, which says nothing about the rule removed.
alter function devos_api.record_eval_run(jsonb) rename to record_eval_run_w07_orig;
alter function devos_api.record_eval_run_w07_orig(jsonb) set schema devos_private;
create function devos_api.record_eval_run(p jsonb) returns jsonb language plpgsql security definer set search_path = pg_catalog as $f$
declare r jsonb;
begin
  r := devos_private.record_eval_run_w07_orig(p);
  if r ->> 'status' = 'ok' and r ->> 'id' is not null then
    alter table devos_private.eval_run disable trigger user;
    update devos_private.eval_run x set work_revision = (select max(v.revision) from devos_private.work_revision v
                                                          where v.work_id = x.work_ref)
     where x.id::text = r ->> 'id';
    alter table devos_private.eval_run enable trigger user;
  end if;
  return r;
end $f$;
grant execute on function devos_api.record_eval_run(jsonb) to anon, authenticated;
commit;
