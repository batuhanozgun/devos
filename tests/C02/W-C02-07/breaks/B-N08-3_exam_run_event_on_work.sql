-- w07-break: test=w07_n08_exam_fact.sql; expect-red=EXF-pair-state,N08-s3
-- Break patch for T-W07-N08 part X (tests/C02/W-C02-07/T-W07-N08_exam_records.md, "Break attempt"; phase C4b, EV-C02-008
-- 5.1's table, B-N08-3). Rule removed: 5.1 (c) bound 2 ("record_eval_run writes no field, revision or event on the Work it
-- names"). record_eval_run is wrapped so that an accepted run also writes an event whose aggregate is the Work it names.
-- The insert names Event's fields as B 3.13 gives them (README 8.1: devos_private.event); the prober adapts it to the
-- build's columns before the run.
-- Revised under ledger rule 3, 2026-10-19 (N-301 (3); EV-C02-014 section 11.4): the insert wrote p->>'work_ref', a text,
-- into event.aggregate_id, a uuid (W-C02-08's migration 20261014170202), which PostgreSQL refuses (42804), so every
-- accepted run raised and no break was shown; the value is now cast to uuid. Nothing else changes.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8). The caller's class is
-- read through devos_api.token_role_class() (README 8.1: it carries role_class).
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
alter function devos_api.record_eval_run(jsonb) rename to record_eval_run_w07_orig;
create function devos_api.record_eval_run(p jsonb) returns jsonb language plpgsql security definer set search_path = pg_catalog as $f$
declare r jsonb;
begin
  r := devos_api.record_eval_run_w07_orig(p);
  if jsonb_typeof(r) = 'object' and r->>'status' = 'ok' then
    insert into devos_private.event (aggregate_type, aggregate_id, event_type, role_class, origin)
      values ('work', (p->>'work_ref')::uuid, 'w07_break_exam_run_on_work', 'devos_sinav', 'call');
  end if;
  return r;
end $f$;
grant execute on function devos_api.record_eval_run(jsonb) to anon, authenticated;
commit;
