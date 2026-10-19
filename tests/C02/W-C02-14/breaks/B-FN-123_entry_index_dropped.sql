-- w07-break: test=tests/C02/W-C02-14/job/w14_fn_transfer_functions.sql; expect-red=FN-IX-entry
-- T-W14-FN break B-FN-123 (tests/C02/W-C02-14/T-W14-FN_transfer_functions.md, "Break attempt"). Rule removed: the partial index of record_ledger_entry's entry lookup, payload ->> 'entry_id' where event_type = 'ledger_entry' (EV-C02-018 16 decision 8); the index is dropped.
-- Added 2026-10-19 under ledger rule 3 (EV-C02-018 section 16 decision 8 and section 8; EV-C02-013 28 (9); test round 2,
-- part TC-B), before the corrective migration exists. Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break
-- harness on a throwaway PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside
-- supabase/migrations/. Synthetic: no data, no token. No psql meta-command. It drops the one index found by its form (an
-- index on devos_private.event of the expression and predicate below, whatever its name); if none or more than one is
-- found, it raises and the break is not applied.
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
do $b$
declare nm text[];
begin
  select array_agg(format('%I.%I', ns.nspname, ci.relname)) into nm
    from pg_index x join pg_class ci on ci.oid = x.indexrelid join pg_namespace ns on ns.oid = ci.relnamespace
   where x.indrelid = 'devos_private.event'::regclass
     and regexp_replace(regexp_replace(coalesce(pg_get_expr(x.indexprs, x.indrelid), ''), '::[a-z_."]+', '', 'g'), '[[:space:]()]', '', 'g') = 'payload->>''entry_id'''
     and regexp_replace(regexp_replace(coalesce(pg_get_expr(x.indpred, x.indrelid), ''), '::[a-z_."]+', '', 'g'), '[[:space:]()]', '', 'g') = 'event_type=''ledger_entry''';
  if coalesce(cardinality(nm), 0) <> 1 then
    raise exception 'w14 break not applied: % such indexes, not one; not a break shown (W-C02-13 point 3)', coalesce(cardinality(nm), 0);
  end if;
  execute 'drop index ' || nm[1];
end $b$;
commit;
