-- w07-break: test=bin/conc_claim_and_cycle.py; expect-red=CONC-claim
-- Rule removed: one active claim per work item under concurrency: claim's row lock (SELECT ... FOR UPDATE, EV-C02-002
-- DM-01) and the unique index of one active claim per work item (B 3.5, the backstop). Specification:
-- tests/C02/W-C02-07/T-W07-CONC_claim_and_cycle.md. How: every partial unique index on devos_private.assignment is
-- dropped, and devos_api.claim and every devos_private function whose name contains "claim" are re-created from the
-- build's own source (pg_get_functiondef) with "for update" and "for no key update" removed. It holds none of the
-- build's logic; it shows the race only if the build's check-then-insert window is reached in at least one of the
-- runs the specification fixes (W-C02-13 point 4: "at least one of the same number of runs").
-- Synthetic (plan Section 8 item 13): no data. Throwaway database only (README 5.2), never under supabase/migrations/.
-- No psql meta-command. The whole change runs inside the guard's block.
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
  for r in select p.oid from pg_proc p join pg_namespace n on n.oid = p.pronamespace
           where (n.nspname = 'devos_api' and p.proname = 'claim') or (n.nspname = 'devos_private' and p.proname like '%claim%') loop
    def := pg_get_functiondef(r.oid);
    def := regexp_replace(def, '\s+for\s+(no\s+key\s+)?update(\s+of\s+[a-z_.]+)?', ' ', 'gi');
    execute def;
  end loop;
end $b$;
