-- w07-break: test=tests/C02/W-C02-14/job/w14_fn_transfer_functions.sql; expect-red=FN-R-declared-begin_transfer_run,FN-R-declared-end_transfer_run,FN-R-declared-record_handover,FN-R-declared-transfer_event,FN-R-declared-record_ledger_entry,FN-R-declared-transfer_artifact
-- T-W14-FN break B-FN-7 (tests/C02/W-C02-14/T-W14-FN_transfer_functions.md, "Break attempt"). Rule removed: the events of
-- M09-10's six functions take their role_class from the token, never from the call (W-C02-09 point 3, fifth bullet;
-- EV-C02-005 S1; CHK-C02-103's X4). Each of the six is wrapped: after the build's call, every event it wrote is given the
-- role_class the payload declares, when it declares one (the table's user triggers off for that update only).
-- Added 2026-10-19 under ledger rule 3 (note N-302 (c) with its L-396 annotation; CHK-C02-103 C1 (c)).
-- Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness (tests/C02/W-C02-07/harness/) on a throwaway
-- PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the
-- migration job never applies it. Synthetic (plan Section 8 item 13): no data, no token in the file. No psql meta-command.
-- It wraps the build's functions and holds none of their logic; a call that declares no role_class is passed through
-- unchanged. If a function does not have the form assumed here, the patch raises or the harness reports the break "not
-- shown"; the test designer then revises the patch before its first result (W-C02-07's README section 8).
begin;  -- the guard and the change in one transaction: a refused guard aborts the whole patch
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w14 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w14 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
do $p$
declare fn text; g record;
begin
  foreach fn in array array['begin_transfer_run', 'end_transfer_run', 'record_handover', 'transfer_event', 'record_ledger_entry',
                            'transfer_artifact'] loop
    execute format('alter function devos_api.%I(jsonb) rename to %I', fn, fn || '_w14_orig');
    execute format($w$create function devos_api.%I(p jsonb) returns jsonb language plpgsql security definer
      set search_path = pg_catalog as $f$
      declare r jsonb; e0 bigint;
      begin
        select coalesce(max(e.id), 0) into e0 from devos_private.event e;
        r := devos_api.%I(p);
        if jsonb_typeof(p -> 'role_class') = 'string' then
          alter table devos_private.event disable trigger user;
          update devos_private.event set role_class = p ->> 'role_class'
           where id > e0 and aggregate_type is distinct from 'env_token';
          alter table devos_private.event enable trigger user;
        end if;
        return r;
      end $f$$w$, fn, fn || '_w14_orig');
    execute format('revoke all on function devos_api.%I(jsonb) from public', fn);
    for g in select a.grantee from pg_proc pr, aclexplode(pr.proacl) a
              where pr.oid = to_regprocedure('devos_api.' || fn || '_w14_orig(jsonb)') and a.privilege_type = 'EXECUTE' loop
      execute format('grant execute on function devos_api.%I(jsonb) to %s', fn,
                     case when g.grantee = 0 then 'public' else quote_ident(pg_get_userbyid(g.grantee)) end);
    end loop;
  end loop;
end $p$;
commit;
