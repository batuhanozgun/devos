-- w07-break: test=w07_n08_exam_records.sql; expect-red=N08-s5
-- Break patch for T-W07-N08 part A (N-301, 2026-10-19; k06 of EV-C02-014 section 11). Rule removed: B 3.15's "the link
-- lives only here" (in EvalRun), as EV-C02-013 24 (2) builds it: the eval_run_recorded event holds no EvalRun field.
-- record_eval_run is wrapped so that, after an accepted run, its own event (aggregate eval_run, the new run's id) also
-- holds the work item's id in its payload, the exam link outside EvalRun. The event's aggregate stays the EvalRun, so
-- N08-s3's and EXF-pair-state's view of the Work's events does not see it; part A's N08-s5 must.
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
  if jsonb_typeof(r) = 'object' and r->>'status' = 'ok' then
    update devos_private.event e set payload = e.payload || jsonb_build_object('work_ref', p->'work_ref')
     where e.aggregate_type = 'eval_run' and e.aggregate_id::text = r->>'id';
  end if;
  return r;
end $f$;
grant execute on function devos_api.record_eval_run(jsonb) to anon, authenticated;
commit;
