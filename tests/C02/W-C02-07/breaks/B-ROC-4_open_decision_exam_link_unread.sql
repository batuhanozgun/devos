-- w07-break: test=w07_roc_ownership_and_claim_class.sql; expect-red=ROC-o-open_decision-sin-exam
-- Break patch for T-W07-ROC (N-300 (1), 2026-10-19). Rule removed: open_decision's devos_sinav branch of Rule O reads the
-- exam link of the work item work_ref names (EV-C02-008 1.7.1's sin limit; EV-C02-013 2.2, R1-6: it makes relate's
-- checks; EV-C02-008 5.1, its tenth exempt function). open_decision is wrapped: for the call, every EvalRun naming that
-- work item is taken away and put back after, so the branch finds no exam link and the exam environment is refused on
-- its own exam task. The other classes' branches do not read the exam link, so their answers stay as they are.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds none of the build's logic: it wraps the build's function and keeps its parameter types
-- and order (README 5.2, "Wrappers"); the build's function moves to devos_private, so that no reader finder sees a copy.
-- Synthetic (plan Section 8 item 13): no data; the rows it takes away are the test's own and are put back. No psql meta-command.
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
declare r jsonb; kept jsonb;
begin
  if jsonb_typeof(p -> 'work_ref') <> 'string' then
    return devos_private.open_decision_w07_orig(p);
  end if;
  alter table devos_private.eval_run disable trigger user;
  select coalesce(jsonb_agg(to_jsonb(x)), '[]') into kept from devos_private.eval_run x where x.work_ref::text = p ->> 'work_ref';
  delete from devos_private.eval_run x where x.work_ref::text = p ->> 'work_ref';
  alter table devos_private.eval_run enable trigger user;
  r := devos_private.open_decision_w07_orig(p);
  insert into devos_private.eval_run select (jsonb_populate_record(null::devos_private.eval_run, k)).* from jsonb_array_elements(kept) k;
  return r;
end $f$;
grant execute on function devos_api.open_decision(jsonb) to anon, authenticated;
commit;
