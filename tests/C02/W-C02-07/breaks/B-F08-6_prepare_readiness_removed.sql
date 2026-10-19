-- w07-break: test=w07_f08_recheck_at_effect.sql; expect-red=F08-r-prepare
-- Rule removed: prepare_operation's readiness re-check at the effect (F08 (a) at the prepare: not_ready, EV-C02-013
-- 21 (C-M08); N-297 (4), CHK-C02-096 finding 8 (k5)). Specification: tests/C02/W-C02-07/T-W07-F08_recheck_at_effect.md,
-- "Revision under ledger rule 3 (N-289, N-297 (4), 2026-10-19)". How: prepare_operation(text, jsonb) is renamed and a
-- wrapper takes its name that sets a transaction-local mark for the call; devos_private.ready_value(uuid, uuid) is
-- renamed and a function with its name and signature answers true while the mark is set and the build's answer
-- otherwise. So only the readiness that prepare_operation reads is removed; claim's, ready_works', register_artifact's
-- and record_attempt's are the build's. It holds none of the build's logic.
-- Synthetic (plan Section 8 item 13): no data. Applied only by the break harness on its throwaway database
-- (README 5.2), never under supabase/migrations/. No psql meta-command. The whole change runs inside the guard's
-- block, so a refused guard changes nothing, whatever the client does after the error.
-- Written under ledger rule 3, 2026-10-19 (N-297 (4)).
do $b$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  execute 'alter function devos_private.ready_value(uuid, uuid) rename to ready_value_w07_orig';
  execute $p$
    create function devos_private.ready_value(p_work_id uuid, p_own_claim uuid default null) returns boolean
    language plpgsql volatile security definer set search_path = pg_catalog as $f$
    begin
      if coalesce(current_setting('w07.brk_at_prepare', true), '') = 'on' then return true; end if;
      return devos_private.ready_value_w07_orig(p_work_id, p_own_claim);
    end $f$ $p$;
  execute 'revoke all on function devos_private.ready_value(uuid, uuid) from public';
  execute 'alter function devos_api.prepare_operation(text, jsonb) rename to prepare_operation_w07_orig';
  execute $p$
    create function devos_api.prepare_operation(p_claim_token text, p_operation jsonb) returns jsonb
    language plpgsql security definer set search_path = pg_catalog as $f$
    declare r jsonb;
    begin
      perform set_config('w07.brk_at_prepare', 'on', true);
      r := devos_api.prepare_operation_w07_orig(p_claim_token, p_operation);
      perform set_config('w07.brk_at_prepare', '', true);
      return r;
    end $f$ $p$;
  execute 'grant execute on function devos_api.prepare_operation(text, jsonb) to anon';
end $b$;
