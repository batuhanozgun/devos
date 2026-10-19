-- w07-break: test=w07_conc_claim_and_cycle.py; expect-red=CONC-claim
-- Rule removed: one active claim per work item under concurrency: claim's row lock (SELECT ... FOR UPDATE, EV-C02-002
-- DM-01) and the unique index of one active claim per work item (B 3.5, the backstop). Specification:
-- tests/C02/W-C02-07/T-W07-CONC_claim_and_cycle.md. How: every partial unique index on devos_private.assignment is
-- dropped, and devos_api.claim and every devos_private function whose name contains "claim" are re-created from the
-- build's own source (pg_get_functiondef) with "for update" and "for no key update" removed. It holds none of the
-- build's logic; it shows the race only if the build's check-then-insert window is reached in at least one of the
-- runs the specification fixes (W-C02-13 point 4: "at least one of the same number of runs").
-- Synthetic (plan Section 8 item 13): no data. Throwaway database only (README 5.2), never under supabase/migrations/.
-- No psql meta-command. The whole change runs inside the guard's block.
-- Revised under ledger rule 3, 2026-10-19 (N-287 (2); CHK-C02-091 findings 6 and 8; EV-C02-013 section 18 (5)), before
-- any run of this patch. The rule "one active claim per work item under concurrency" has three carriers in the merged
-- schema and build, each of which stops the race alone (CHK-C02-091 finding 6, on the real M09-05: the row locks alone
-- serialized 8 of 8 runs; with the locks removed and both schema backstops kept, 6 of 6 runs still ended with one
-- Assignment; with all three removed, 6 of 6 runs ended with 2 to 8 active claims): claim's row locks, the partial
-- unique index of one active claim per work item, and W-C02-08's unique constraint on (work_ref, generation) (migration
-- 20261014170203), which makes two concurrent claims that read the same newest generation collide. The first version
-- removed the first two only, so the race could not show (8 connections, 20 runs). The patch now also drops that unique
-- constraint, found in the catalogue as the unique constraint of devos_private.assignment over exactly work_ref and
-- generation. It is still one rule removed, with every carrier of it. The red list is unchanged. T-W07-CONC's
-- "Revision under ledger rule 3 (N-287, 2026-10-19)".
do $b$
declare r record; def text;
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  for r in select i.indexrelid::regclass::text as idx from pg_index i
           where i.indrelid = 'devos_private.assignment'::regclass and i.indisunique and i.indpred is not null loop
    execute 'drop index ' || r.idx;
  end loop;
  for r in select c.conname from pg_constraint c
           where c.conrelid = 'devos_private.assignment'::regclass and c.contype = 'u'
             and (select array_agg(a.attname::text order by a.attname::text) from pg_attribute a
                   where a.attrelid = c.conrelid and a.attnum = any (c.conkey)) = array['generation', 'work_ref'] loop
    execute format('alter table devos_private.assignment drop constraint %I', r.conname);
  end loop;
  for r in select p.oid from pg_proc p join pg_namespace n on n.oid = p.pronamespace
           where (n.nspname = 'devos_api' and p.proname = 'claim') or (n.nspname = 'devos_private' and p.proname like '%claim%') loop
    def := pg_get_functiondef(r.oid);
    def := regexp_replace(def, '\s+for\s+(no\s+key\s+)?update(\s+of\s+[a-z_.]+)?', ' ', 'gi');
    execute def;
  end loop;
end $b$;
