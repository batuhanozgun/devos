-- w07-break: test=tests/C02/W-C02-08/job/w08_priv_types_functions.sql; expect-red=PRIV-tacl:decision_status,PRIV-tuse:anon
-- Break patch of tests/C02/W-C02-08/T-W08-PRIV_type_function_privileges.md, "Break attempt" (W-C02-07's README 5.2).
-- Removes one part of the closing of devos_private's types (migration 20261014190402_w08_type_privileges.sql, which
-- revokes USAGE on every such type from PUBLIC and from anon, authenticated, authenticator and service_role): USAGE on
-- devos_private.decision_status granted to anon. Nothing else changes.
-- Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness (tests/C02/W-C02-07/harness/) on a throwaway
-- PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the
-- migration job never applies it. Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
-- If the type is absent, this patch raises and the harness reports the break "not shown"; the test designer then
-- revises the patch before its first result (W-C02-07's README 8).
begin;  -- the guard and the change in one transaction: a refused guard aborts the whole patch
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w08 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w08 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
do $p$
begin
  if to_regtype('devos_private.decision_status') is null then
    raise exception 'w08 break not applied: devos_private.decision_status not found';
  end if;
  if not exists (select 1 from pg_roles where rolname = 'anon') then
    raise exception 'w08 break not applied: role anon not found';
  end if;
  execute 'grant usage on type devos_private.decision_status to anon';
end $p$;
commit;
