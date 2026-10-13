-- w07-break: test=w07_n08_exam_records.sql; expect-red=N08-r-read_eval_runs-devos_calisma
-- Break patch of tests/C02/W-C02-07/T-W07-N08_exam_records.md, "Break attempt" (README 5.2). Removed: B 3.15's read rule (EvalRun read only with devos_sinav): devos_calisma is added beside
-- devos_sinav in every devos_api function, other than record_eval_run, whose text names the exam records' table
-- (devos_private.eval_run, w07_cfg evalrun_table). The expect-red list names the stand-in's read function; with the
-- build's, the prober lists that function's N08-r-<function>-devos_calisma case instead, before the run.
begin;  -- the guard and the change in one transaction: a refused guard aborts the whole patch

-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/, never on
-- devos-test or devos; it sits outside supabase/migrations/, so no job applies it. It holds none of the build's
-- logic. Synthetic (plan Section 8 item 13): no data, no token. No psql meta-command.
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
do $b$
declare f record; def text; src text; n int := 0;
begin
  for f in select p.oid from pg_proc p join pg_namespace s on s.oid = p.pronamespace
           where s.nspname = 'devos_api' and p.proname <> 'record_eval_run' and p.prosrc ~* '\meval_runs\M' loop
    def := pg_get_functiondef(f.oid);
    src := regexp_replace(def, '''devos_sinav''', '''devos_sinav'', ''devos_calisma''', 'g');
    src := regexp_replace(src, 'devos_sinav([,}])', 'devos_sinav,devos_calisma\1', 'g');
    if src <> def then execute src; n := n + 1; end if;
  end loop;
  if n = 0 then
    raise exception 'w07 break not applied: no role list naming devos_sinav found in a devos_api function reading the exam records; not a break shown (W-C02-13 point 3)';
  end if;
end $b$;
commit;
