-- w07-break: test=tests/C02/W-C02-14/job/w14_fn_transfer_functions.sql; expect-red=FN-TA-scope
-- T-W14-FN break B-FN-21 (tests/C02/W-C02-14/T-W14-FN_transfer_functions.md, "Break attempt"). Rule removed: transfer_artifact's rule that scope is installation (invalid_field; EV-C02-013 25 (7)); any dotted scope is admitted.
-- Added 2026-10-19 under ledger rule 3 (note N-302 (c) with its L-396 annotation; CHK-C02-103 C1 (c); EV-C02-014 12.4).
-- Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness (tests/C02/W-C02-07/harness/) on a throwaway
-- PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the
-- migration job never applies it. Synthetic (plan Section 8 item 13): no data, no token in the file. No psql meta-command.
-- It changes the build's own function text in one place: pg_get_functiondef's text, with the fragment below replaced
-- (each fragment must occur exactly once, else the patch raises and the break is not applied), is executed again. It
-- holds none of the build's logic beyond that fragment. If the build's function does not have this form, the harness
-- reports the break "not shown"; the test designer then revises the patch before its first result (W-C02-07's README
-- section 8).
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
do $b$
declare src text; o text; nw text; k int;
begin
  src := pg_get_functiondef('devos_api.transfer_artifact(jsonb)'::regprocedure);
  o := $o$or (p_in ->> 'scope') <> 'installation' then$o$;
  nw := $n$or (p_in ->> 'scope') !~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$' then$n$;
  k := (length(src) - length(replace(src, o, ''))) / length(o);
  if k <> 1 then
    raise exception 'w14 break not applied: fragment 1 of devos_api.transfer_artifact found % times, not once; not a break shown (W-C02-13 point 3)', k;
  end if;
  src := replace(src, o, nw);
  execute src;
end $b$;
commit;
