-- w07-break: test=w07_idc_identity_chain.sql; expect-red=IDC-v1
-- Break patch of tests/C02/W-C02-07/T-W07-IDC_identity_chain.md, "Break attempt" (README 5.2). Removed: B 3.27's rule "the token itself is kept in no table": issue_env_token is renamed and wrapped, and the
-- wrapper also writes the token it returns into a new table, devos_private.w07_break_kept.
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
declare f record;
begin
  select p.oid, p.proargtypes[0]::regtype t, p.pronargs into f from pg_proc p join pg_namespace s on s.oid = p.pronamespace
  where s.nspname = 'devos_private' and p.proname = 'issue_env_token';
  if f.oid is null or f.pronargs <> 1 then raise exception 'w07 break not applied: issue_env_token with one argument not found'; end if;
  execute 'create table devos_private.w07_break_kept (v text)';
  execute format('alter function devos_private.issue_env_token(%s) rename to issue_env_token_w07_orig', f.t);
  execute format($w$create function devos_private.issue_env_token(p1 %s) returns text language plpgsql security definer
    set search_path = pg_catalog as $x$ declare t text; begin t := devos_private.issue_env_token_w07_orig(p1);
    insert into devos_private.w07_break_kept values (t); return t; end $x$$w$, f.t);
  execute format('revoke execute on function devos_private.issue_env_token(%s) from public', f.t);
end $b$;
commit;
