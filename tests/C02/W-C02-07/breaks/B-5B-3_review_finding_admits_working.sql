-- w07-break: test=w07_5b_authorization_matrix.sql; expect-red=5B-R25-review_finding-cal
-- Break patch of tests/C02/W-C02-07/T-W07-5B_authorization_matrix.md, "Break attempt" (README 5.2; phase C4a). Removed: one
-- cell of a row EV-C02-008 section 1.2 adds (review_finding: devos_denetim only; B:36 "Cannot: Binding verdicts,
-- acceptance"): devos_calisma is added beside devos_denetim in devos_api.review_finding's own text. If the build keeps
-- role lists outside the function, this patch refuses to apply and the prober writes the same one-cell change for that
-- place (specification, "Break attempt").
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
           where s.nspname = 'devos_api' and p.proname = 'review_finding' loop
    def := pg_get_functiondef(f.oid);
    src := regexp_replace(def, '''devos_denetim''', '''devos_denetim'', ''devos_calisma''', 'g');
    -- An array literal ('{devos_denetim}' or '{devos_denetim,...}'), without a regular-expression back-reference.
    src := replace(replace(src, 'devos_denetim,', 'devos_denetim,devos_calisma,'), 'devos_denetim}', 'devos_denetim,devos_calisma}');
    if src <> def then execute src; n := n + 1; end if;
  end loop;
  if n = 0 then
    raise exception 'w07 break not applied: no role list naming devos_denetim found in devos_api.review_finding; not a break shown (W-C02-13 point 3)';
  end if;
end $b$;
commit;
