-- w07-break: test=w07_roc_ownership_and_claim_class.sql; expect-red=ROC-o-cancel_work-cal-exam,ROC-leak-cancel_work
-- Break patch for T-W07-ROC (tests/C02/W-C02-07/T-W07-ROC_ownership_and_claim_class.md, "Break attempt"; phase C4a). Rule
-- changed: Rule O's reading for devos_calisma (EV-C02-008 1.7.1: "The check reads nothing about exams"): cancel_work is
-- wrapped so that it reads the exam link and refuses devos_calisma on a work item an exam run names, the leak the rule
-- forbids. The caller's class is read through devos_api.token_role_class() (README 8.1: it carries role_class).
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
alter function devos_api.cancel_work(uuid, text) rename to cancel_work_w07_orig;
create function devos_api.cancel_work(work_id uuid, reason text) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
begin
  if (devos_api.token_role_class())->>'role_class' = 'devos_calisma'
     and exists (select 1 from devos_private.eval_run e where e.work_ref::text = cancel_work.work_id::text) then
    return jsonb_build_object('status', 'refused', 'reason_code', 'w07_break_exam_task',
                              'reason', 'w07 break: Rule O reads the exam link for devos_calisma');
  end if;
  return devos_api.cancel_work_w07_orig(work_id, reason);
end $f$;
grant execute on function devos_api.cancel_work(uuid, text) to anon, authenticated;
commit;
