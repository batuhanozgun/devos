-- w07-break: test=w07_f01_whole_intent.sql; expect-red=F01-t2
-- Rule removed: the idempotency namespace in the key's lookup of devos_api.prepare_operation (Appendix C F01's
-- "type"; B 3.12): a key is matched on its own, whatever its namespace. Specification:
-- tests/C02/W-C02-07/T-W07-F01_whole_intent.md. How: the build's prepare_operation(text, jsonb) is renamed and a
-- wrapper takes its name; when no record has the call's namespace and key but a record has the key in another
-- namespace, the wrapper replaces the call's namespace with that record's, then calls the build's function, which then
-- answers from the existing record. It holds none of the build's logic.
-- Synthetic (plan Section 8 item 13): no data. Applied only by the break harness on its throwaway database
-- (README 5.2), never under supabase/migrations/. No psql meta-command. The whole change runs inside the guard's
-- block, so a refused guard changes nothing, whatever the client does after the error. Phase C3.
do $b$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  execute 'alter function devos_api.prepare_operation(text, jsonb) rename to prepare_operation_w07_orig';
  execute $p$
    create function devos_api.prepare_operation(p_claim_token text, p_operation jsonb) returns jsonb
    language plpgsql security definer set search_path = pg_catalog as $f$
    declare stored text;
    begin
      if not exists (select 1 from devos_private.operation o
                      where o.idempotency_namespace = p_operation->>'idempotency_namespace'
                        and o.idempotency_key = p_operation->>'idempotency_key') then
        select o.idempotency_namespace::text into stored from devos_private.operation o
         where o.idempotency_key = p_operation->>'idempotency_key' order by o.idempotency_namespace limit 1;
        if found then p_operation := p_operation || jsonb_build_object('idempotency_namespace', stored); end if;
      end if;
      return devos_api.prepare_operation_w07_orig(p_claim_token, p_operation);
    end $f$ $p$;
  execute 'grant execute on function devos_api.prepare_operation(text, jsonb) to anon';
end $b$;
