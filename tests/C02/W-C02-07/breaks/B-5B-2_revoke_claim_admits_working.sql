-- w07-break: test=w07_5b_authorization_matrix.sql,w07_6tk_token_reasons.sql; expect-red=5B-R05-revoke_claim-cal,6TK-ka1
-- Break patch of tests/C02/W-C02-07/T-W07-5B_authorization_matrix.md, "Break attempt" (README 5.2). Removed: DM-29's rule (revoke_claim only with devos_denetim): devos_calisma is added beside devos_denetim in
-- devos_api.revoke_claim's own text.

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
           where s.nspname = 'devos_api' and p.proname = 'revoke_claim' loop
    def := pg_get_functiondef(f.oid);
    src := regexp_replace(def, '''devos_denetim''', '''devos_denetim'', ''devos_calisma''', 'g');
    src := regexp_replace(src, 'devos_denetim([,}])', 'devos_denetim,devos_calisma\1', 'g');
    if src <> def then execute src; n := n + 1; end if;
  end loop;
  if n = 0 then
    raise exception 'w07 break not applied: no role list naming devos_denetim found in devos_api.revoke_claim; not a break shown (W-C02-13 point 3)';
  end if;
end $b$;
