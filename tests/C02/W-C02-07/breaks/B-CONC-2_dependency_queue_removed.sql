-- w07-break: test=bin/conc_claim_and_cycle.py; expect-red=CONC-cyc2,CONC-cyc4
-- Rule removed: the one queue for hard-dependency writes (EV-C02-002 DM-01: "A write of a hard dependency first takes
-- one transaction-level advisory lock, then checks for a cycle, then writes"), and the row locks on the relation path.
-- Specification: tests/C02/W-C02-07/T-W07-CONC_claim_and_cycle.md. How: devos_api.relate and every devos_private
-- function whose name contains "relat", "depend" or "cycle" are re-created from the build's own source
-- (pg_get_functiondef) with pg_advisory_xact_lock( turned into pg_advisory_xact_lock_shared( and "for update" or
-- "for share" removed, so concurrent cycle checks no longer queue. It holds none of the build's logic; the cycle shows
-- only if two checks overlap in at least one of the fixed runs.
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
  for r in select p.oid from pg_proc p join pg_namespace n on n.oid = p.pronamespace
           where (n.nspname = 'devos_api' and p.proname = 'relate')
              or (n.nspname = 'devos_private' and (p.proname like '%relat%' or p.proname like '%depend%' or p.proname like '%cycle%')) loop
    def := pg_get_functiondef(r.oid);
    def := regexp_replace(def, 'pg_advisory_xact_lock\(', 'pg_advisory_xact_lock_shared(', 'gi');
    def := regexp_replace(def, '\s+for\s+(no\s+key\s+)?(update|share)(\s+of\s+[a-z_.]+)?', ' ', 'gi');
    execute def;
  end loop;
end $b$;
