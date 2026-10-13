-- w07-break: test=w07_6tk_token_reasons.sql,w07_idc_identity_chain.sql; expect-red=6TK-rv1-a,6TK-rv1-b,6TK-h3,IDC-r2
-- Break patch of tests/C02/W-C02-07/T-W07-6TK_token_reasons.md, "Break attempt" (README 5.2). Removed: the revocation check of the derivation (B 3.27: a revoked token is not verified): in
-- devos_private.caller_role_class's own text, 'revoked_at is not null' becomes false and 'revoked_at is null' becomes true.
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
           where s.nspname = 'devos_private' and p.proname = 'caller_role_class' loop
    def := pg_get_functiondef(f.oid);
    src := regexp_replace(def, '([A-Za-z_][A-Za-z0-9_]*\.)?revoked_at\s+is\s+not\s+null', 'false', 'gi');
    src := regexp_replace(src, '([A-Za-z_][A-Za-z0-9_]*\.)?revoked_at\s+is\s+null', 'true', 'gi');
    if src <> def then execute src; n := n + 1; end if;
  end loop;
  if n = 0 then raise exception 'w07 break not applied: no revoked_at test found in caller_role_class (not a break shown)'; end if;
end $b$;
commit;
