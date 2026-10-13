-- w07-break: test=w07_n08_exam_fact.sql; expect-red=N08-s4-run
-- Break patch for T-W07-N08 part X (phase C4b, EV-C02-008 5.1's table, B-N08-5). Rule removed: 5.1 (c) bound 3's second
-- layer ("record_eval_run also refuses to name a work item on which an active claim of class sin exists"). record_eval_run
-- is wrapped so that, for the length of the call, an active claim of class devos_sinav on the named work item shows as
-- released, and is active again after it. The update names Assignment's fields as B 3.5 gives them; the prober adapts it.
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
declare r jsonb; ids uuid[];
begin
  select array_agg(a.id) into ids from devos_private.assignment a
   where a.work_ref::text = p->>'work_ref' and a.status = 'active' and a.role_class = 'devos_sinav';
  update devos_private.assignment set status = 'released' where id = any(coalesce(ids, '{}'));
  r := devos_api.record_eval_run_w07_orig(p);
  update devos_private.assignment set status = 'active' where id = any(coalesce(ids, '{}'));
  return r;
end $f$;
grant execute on function devos_api.record_eval_run(jsonb) to anon, authenticated;
commit;
