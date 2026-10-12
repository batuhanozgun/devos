-- w07-break: test=w07_idc_identity_chain.sql; expect-red=IDC-n-acl,IDC-n-issue-as-anon,IDC-n-issue-token-devos_backup,IDC-n-issue-token-devos_calisma,IDC-n-issue-token-devos_ci,IDC-n-issue-token-devos_denetim,IDC-n-issue-token-devos_kurulum,IDC-n-issue-token-devos_sinav
-- Break patch of tests/C02/W-C02-07/T-W07-IDC_identity_chain.md, "Break attempt" (README 5.2). Removed: the privilege rule of B:46 (only the project owner runs issue_env_token): EXECUTE on it,
-- and USAGE on devos_private, granted to anon.

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
declare f record; n int := 0;
begin
  execute 'grant usage on schema devos_private to anon';
  for f in select p.oid::regprocedure sig from pg_proc p join pg_namespace s on s.oid = p.pronamespace
           where s.nspname = 'devos_private' and p.proname = 'issue_env_token' loop
    execute format('grant execute on function %s to anon', f.sig); n := n + 1;
  end loop;
  if n = 0 then raise exception 'w07 break not applied: devos_private.issue_env_token not found'; end if;
end $b$;
