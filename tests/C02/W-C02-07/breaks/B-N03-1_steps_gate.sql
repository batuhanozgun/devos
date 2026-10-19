-- w07-break: test=w07_n03_effort_policy.sql; expect-red=N03-neg-step-verification,N03-neg-step-alternatives_research,N03-neg-step-external_source_research,N03-neg-step-with-audit-token
-- Break patch for T-W07-N03 (tests/C02/W-C02-07/T-W07-N03_*.md, "Break attempt"). Rule removed: the non-removable steps (B 3.18): the steps the gate requires are added back before the build's function sees the policy.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8).
-- Synthetic (plan Section 8 item 13): no data; any value it writes is labelled w07 break. No psql meta-command is used.
-- Revised under ledger rule 3 (N-294 (1), 2026-10-19; no result of this break had been counted): the wrapper read
-- devos_private.work.impact_class, a column the work table does not have (it is work_revision's, migration
-- 20261014170203), so every wrapped call raised 42703. It now reads the item's current revision's impact_class through
-- the view devos_private.work_current (migration 20261014170205), a read only, so work_revision's append-only trigger
-- is not touched. The rule removed and the red list are unchanged (T-W07-N03, "Revision under ledger rule 3 (N-294 (1),
-- 2026-10-19)").
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
alter function devos_api.set_effort_policy(jsonb) rename to set_effort_policy_w07_orig;
create function devos_api.set_effort_policy(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare ic text; s text;
begin
  select impact_class::text into ic from devos_private.work_current where id::text = p->>'work_ref';
  if jsonb_typeof(p->'non_removable_steps') = 'array' then
    foreach s in array case when ic = 'high' or p->>'work_ref' is null
                            then array['verification', 'alternatives_research', 'external_source_research']
                            else array['verification', 'alternatives_research'] end loop
      if not (p->'non_removable_steps') ? s then
        p := p || jsonb_build_object('non_removable_steps', (p->'non_removable_steps') || to_jsonb(s)); end if;
    end loop;
  end if;
  return devos_api.set_effort_policy_w07_orig(p);
end $f$;
grant execute on function devos_api.set_effort_policy(jsonb) to anon, authenticated;
commit;
