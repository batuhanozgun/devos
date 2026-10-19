-- w07-break: test=w07_locks_key_and_handover_locks.py; expect-red=LOCKS-po-repeat
-- Rule removed: the transaction-level advisory lock 9006 on the idempotency key in devos_api.prepare_operation (EV-C02-018 16
-- decision 2; EV-C02-013 28 (3)), taken before the key read, so that a second first use of one new key waits for the
-- first and answers its exact repeat (B 3.12; B:257).
-- How: the function's definition is read from the catalogue (pg_get_functiondef) and replaced (create or replace, so
-- its signature, owner, grants, security definer and search_path stay) with the one lock statement turned into the
-- no-op null; nothing else of its text changes. The statement is found by the pattern below, which must occur exactly
-- once in the function, or the patch raises and applies nothing (the break is then not shown). The pattern reads only
-- the lock's id and its function's name (EV-C02-013 28 (2) to (5) give the statements' form), not the rest of its
-- arguments, so it fits the corrective migration's text as section 28 states it.
-- Must turn red: LOCKS-po-repeat (the second first use reads no key, waits at the Operation table
-- unique key and answers write_failed, EV-C02-018 2 (a)). The other cases stay as in the positive control.
-- Specification: tests/C02/W-C02-07/T-W07-LOCKS_key_and_handover_locks.md ("Break attempt").
-- Synthetic (plan Section 8 item 13): no data. Throwaway database only (README 5.2), never under supabase/migrations/.
-- No psql meta-command. The whole change runs inside the guard's block.
do $b$
declare
  d text;
  n int;
  pat text := 'perform[[:space:]]+pg_catalog[.]pg_advisory_xact_lock[(][[:space:]]*9006[[:space:]]*,[^;]*;';
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  d := pg_catalog.pg_get_functiondef('devos_api.prepare_operation(text,jsonb)'::regprocedure);
  select count(*) into n from regexp_matches(d, pat, 'g');
  if n <> 1 then
    raise exception 'w07 break patch refused: the lock statement occurs % times in devos_api.prepare_operation, not once', n;
  end if;
  execute regexp_replace(d, pat, 'null;');
end
$b$;
