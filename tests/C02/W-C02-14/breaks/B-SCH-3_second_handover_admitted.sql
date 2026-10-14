-- w07-break: test=tests/C02/W-C02-14/job/w14_sch_transfer_schema.sql; expect-red=SCH-S1-handover-two
-- Removes S1's "at most one" ledger_handed_over event: every unique index on devos_private.event whose predicate
-- names ledger_handed_over is dropped (assumed form).
-- Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness (tests/C02/W-C02-07/harness/) on a throwaway
-- PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the
-- migration job never applies it. Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
-- If the build carries the rule in another form than the one assumed here, this patch raises and the harness reports
-- the break "not shown"; the test designer then revises the patch before its first result (W-C02-07's README 8).
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
declare r record; n int := 0;
begin
  for r in select i.indexrelid::regclass::text as idx from pg_index i
            where i.indrelid = 'devos_private.event'::regclass and i.indisunique and i.indpred is not null
              and pg_get_expr(i.indpred, i.indrelid) like '%ledger_handed_over%' loop
    execute format('drop index %s', r.idx);
    n := n + 1;
  end loop;
  if n = 0 then
    raise exception 'w14 break: no unique index on devos_private.event with a predicate naming ledger_handed_over (assumed form)';
  end if;
end $p$;
commit;
