-- w07-break: test=w07_n29_impact_class.sql; expect-red=N29-dec-routine-on-high
-- Break patch for T-W07-N29 (tests/C02/W-C02-07/T-W07-N29_*.md, "Break attempt"). Rule removed: the refusal of a routine decision tied to a high item (B 3.17): the item reads as routine for the call.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8).
-- Synthetic (plan Section 8 item 13): no data; any value it writes is labelled w07 break. No psql meta-command is used.
-- Revised under ledger rule 3, 2026-10-18 (N-283; CHK-C02-086 C4), before any result of this break: the first version
-- updated devos_private.work.impact_class, a column the work table does not have (it is work_revision's, migration
-- 20261014170203), so the wrapper raised 42703 and the case became could_not_check, the break not shown. work_revision is
-- append-only (trigger work_revision_append_only, migration 20261014170205), so the wrapper turns that one trigger off
-- only for its own update of the work item's current revision, turns it on again before the build's call, and puts the
-- impact class back the same way after it. The build's call runs with every rule in place but the one removed: the item
-- reads as routine. A call without work_ref is passed through unchanged.
begin;  -- the guard and the change in one transaction: a refused guard aborts the whole patch
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  if not exists (select 1 from pg_trigger where tgrelid = to_regclass('devos_private.work_revision')
                 and tgname = 'work_revision_append_only') then
    raise exception 'w07 break patch refused: trigger work_revision_append_only on devos_private.work_revision not found (revise the patch)';
  end if;
end $g$;
alter function devos_api.open_decision(jsonb) rename to open_decision_w07_orig;
create function devos_api.open_decision(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare rid uuid; old text; r jsonb;
begin
  select x.id, x.impact_class::text into rid, old from devos_private.work_revision x
   where x.work_id::text = p->>'work_ref' order by x.revision desc limit 1;
  if rid is not null then
    alter table devos_private.work_revision disable trigger work_revision_append_only;
    update devos_private.work_revision set impact_class = 'routine' where id = rid;
    alter table devos_private.work_revision enable trigger work_revision_append_only;
  end if;
  r := devos_api.open_decision_w07_orig(p);
  if rid is not null then
    alter table devos_private.work_revision disable trigger work_revision_append_only;
    update devos_private.work_revision set impact_class = old::devos_private.impact_class where id = rid;
    alter table devos_private.work_revision enable trigger work_revision_append_only;
  end if;
  return r;
end $f$;
grant execute on function devos_api.open_decision(jsonb) to anon, authenticated;
commit;
