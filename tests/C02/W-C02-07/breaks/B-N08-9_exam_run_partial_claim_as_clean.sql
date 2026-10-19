-- w07-break: test=w07_n08_exam_records.sql; expect-red=N08-s6
-- Break patch for T-W07-N08 part A (N-301, 2026-10-19; k21 of EV-C02-014 section 11). Rule removed: EV-C02-008 5.1 (c)
-- bound 3's second layer read with plan Section 8 item 14: a claim on the work item that lacks its role class or its
-- status is partial input, never clean. record_eval_run is wrapped so that, for the length of the call, such a claim
-- shows the working class and the status released (an ordinary claim the second layer passes), and is put back after.
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
declare r jsonb; nc uuid[]; ns uuid[];
begin
  select array_agg(a.id) filter (where a.role_class is null), array_agg(a.id) filter (where a.status is null)
    into nc, ns from devos_private.assignment a where a.work_ref::text = p->>'work_ref';
  update devos_private.assignment set role_class = 'devos_calisma' where id = any(coalesce(nc, '{}'));
  update devos_private.assignment set status = 'released' where id = any(coalesce(ns, '{}'));
  r := devos_private.record_eval_run_w07_orig(p);
  update devos_private.assignment set role_class = null where id = any(coalesce(nc, '{}'));
  update devos_private.assignment set status = null where id = any(coalesce(ns, '{}'));
  return r;
end $f$;
grant execute on function devos_api.record_eval_run(jsonb) to anon, authenticated;
commit;
