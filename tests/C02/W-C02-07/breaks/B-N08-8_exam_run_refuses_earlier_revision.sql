-- w07-break: test=w07_n08_exam_records.sql; expect-red=N08-wp3
-- Break patch for T-W07-N08 part A (N-301, 2026-10-19; EV-C02-014 section 11's "the earlier revision accepted"). Rule
-- removed: B 3.15's work_ref "+revision: the work item an exam task was opened as", which EV-C02-013 24 (1) builds as
-- "an earlier revision is accepted". record_eval_run is wrapped so that a run naming a revision older than the work
-- item's latest is refused as stale before the build's function is called, as an effect's revision check would.
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
begin
  if jsonb_typeof(p -> 'work_revision') = 'number' and (p->>'work_revision')::numeric
       < (select max(r.revision) from devos_private.work_revision r where r.work_id::text = p->>'work_ref') then
    return jsonb_build_object('status', 'refused', 'reason_code', 'stale_revision',
                              'reason', 'w07 break: an earlier revision of the work item');
  end if;
  return devos_private.record_eval_run_w07_orig(p);
end $f$;
grant execute on function devos_api.record_eval_run(jsonb) to anon, authenticated;
commit;
