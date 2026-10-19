-- w07-break: test=w07_n08_exam_fact.sql; expect-red=N08-x-open_decision-cal
-- Break patch for T-W07-N08 part X (tests/C02/W-C02-07/T-W07-N08_exam_records.md, "Break attempt"; added under ledger
-- rule 3, 2026-10-19, before any result: N-286, EV-C02-017 section 2 (e) and section 9 item 2, EV-C02-008 5.1's dated
-- list item). Rule changed: Rule O's reading for devos_calisma (EV-C02-008 1.7.1: "The check reads nothing about
-- exams"), as open_decision makes it for the work item work_ref names (EV-C02-013 2.2, R1-6). open_decision is wrapped
-- so that it reads the exam link and refuses devos_calisma when work_ref names a work item an exam run names: 1.7.1's
-- break ("Rule O reading the exam link for cal"), applied to open_decision, as B-ROC-1 applies it to cancel_work. The
-- caller's class is read through devos_api.token_role_class() (README 8.1: it carries role_class).
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8).
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
alter function devos_api.open_decision(jsonb) rename to open_decision_w07_orig;
create function devos_api.open_decision(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
begin
  if (devos_api.token_role_class())->>'role_class' = 'devos_calisma'
     and jsonb_typeof(open_decision.p -> 'work_ref') = 'string'
     and exists (select 1 from devos_private.eval_run e where e.work_ref::text = open_decision.p ->> 'work_ref') then
    return jsonb_build_object('status', 'refused', 'reason_code', 'w07_break_exam_task',
                              'reason', 'w07 break: Rule O reads the exam link for devos_calisma');
  end if;
  return devos_api.open_decision_w07_orig(p);
end $f$;
grant execute on function devos_api.open_decision(jsonb) to anon, authenticated;
commit;
