-- w07-break: test=w07_f05_scope_both_sides.sql; expect-red=F05-a,F05-d
-- Rule removed: the target scope check, on both function paths that write or prepare against a target:
-- register_artifact and prepare_operation (Appendix C F05, "Break": "When the target scope check is removed, (a) must
-- pass"; B principle 4; EV-C02-002 DM-34). The source and revision checks stay, so F05-b and F05-c must stay green.
-- Specification: tests/C02/W-C02-07/T-W07-F05_scope_both_sides.md. How: both functions are renamed and wrappers take
-- their names. register_artifact's wrapper calls the build's function with the work item's own scope as the target's,
-- then writes the requested scope onto the new artifact. prepare_operation's wrapper gives the target artifact the work
-- item's scope for the call and restores it. They hold none of the build's logic. Synthetic (plan Section 8 item 13):
-- no data. Throwaway database only (README 5.2), never under supabase/migrations/. No psql meta-command. The whole
-- change runs inside the guard's block.
-- Revised under ledger rule 3, 2026-10-19 (N-290 (1); CHK-C02-090 finding 12), before any run of this patch: work_ref
-- and target_ref are read in the flat form EV-C02-013 2.6 and 2.7 give them (uuids, with work_revision and
-- target_revision beside them), where the first version read p->'work_ref'->>'id' and p->'target_ref'->>'id'; and the
-- work item's scope is read from devos_private.work_current, the work item's current revision (W-C02-08's migration
-- 20261014170205), where the first version read devos_private.work.scope, a column that does not exist (42703). The
-- red list is unchanged. T-W07-F05's "Revision under ledger rule 3 (N-290, 2026-10-19)".
do $b$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  execute 'alter function devos_api.register_artifact(text, jsonb) rename to register_artifact_w07_orig';
  execute $p$
    create function devos_api.register_artifact(p_claim_token text, p jsonb) returns jsonb language plpgsql
    security definer set search_path = pg_catalog as $f$
    declare ws text; r jsonb;
    begin
      select w.scope into ws from devos_private.work_current w where w.id = (p->>'work_ref')::uuid;
      r := devos_api.register_artifact_w07_orig(p_claim_token, case when ws is null then p else p || jsonb_build_object('scope', ws) end);
      if r->>'status' = 'ok' and ws is not null then
        update devos_private.artifact set scope = p->>'scope' where id = (r->>'id')::uuid;
      end if;
      return r;
    end $f$ $p$;
  execute 'grant execute on function devos_api.register_artifact(text, jsonb) to anon';
  execute 'alter function devos_api.prepare_operation(text, jsonb) rename to prepare_operation_w07_orig';
  execute $p$
    create function devos_api.prepare_operation(p_claim_token text, p jsonb) returns jsonb language plpgsql
    security definer set search_path = pg_catalog as $f$
    declare ws text; old text; tid uuid := (p->>'target_ref')::uuid; r jsonb;
    begin
      select w.scope into ws from devos_private.work_current w where w.id = (p->>'work_ref')::uuid;
      select scope into old from devos_private.artifact where id = tid;
      if tid is not null and ws is not null then update devos_private.artifact set scope = ws where id = tid; end if;
      r := devos_api.prepare_operation_w07_orig(p_claim_token, p);
      if tid is not null and ws is not null then update devos_private.artifact set scope = old where id = tid; end if;
      return r;
    end $f$ $p$;
  execute 'grant execute on function devos_api.prepare_operation(text, jsonb) to anon';
end $b$;
