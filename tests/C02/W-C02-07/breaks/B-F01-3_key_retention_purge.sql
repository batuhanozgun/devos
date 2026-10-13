-- w07-break: test=w07_f01_whole_intent.sql; expect-red=F01-d1,F01-d2,F01-d3
-- Rule removed: "An idempotency key's record is never deleted" (B 3.12 as PC-42 place 17 words it; EV-C02-002 DM-28;
-- Appendix C F01 (d)). Specification: tests/C02/W-C02-07/T-W07-F01_whole_intent.md. How: the build's
-- prepare_operation(text, jsonb) is renamed and a wrapper takes its name that first purges Operation records older
-- than 30 days (the retention DM-28 rejected), then calls the build's function. It holds none of the build's logic.
-- The age is read from the first timestamp column of the operation table, found in the catalogue.
-- Synthetic (plan Section 8 item 13): no data. Applied only by the break harness on its throwaway database
-- (README 5.2), never under supabase/migrations/. No psql meta-command. The whole change runs inside the guard's block.
do $b$
declare col text;
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  select attname into col from pg_attribute where attrelid = 'devos_private.operation'::regclass and attnum > 0
     and not attisdropped and format_type(atttypid, atttypmod) like 'timestamp%' order by attnum limit 1;
  if col is null then raise exception 'w07 break patch: the operation table has no timestamp column'; end if;
  execute 'alter function devos_api.prepare_operation(text, jsonb) rename to prepare_operation_w07_orig';
  execute format($p$
    create function devos_api.prepare_operation(p_claim_token text, p_operation jsonb) returns jsonb
    language plpgsql security definer set search_path = pg_catalog as $f$
    begin
      delete from devos_private.operation where %I < now() - interval '30 days';
      return devos_api.prepare_operation_w07_orig(p_claim_token, p_operation);
    end $f$ $p$, col);
  execute 'grant execute on function devos_api.prepare_operation(text, jsonb) to anon';
end $b$;
