-- w07-break: test=w07_f06_state_change_event.sql; expect-red=F06-role-declared:record_eval_run,F06-role-declared:mark_exported
-- Break patch for T-W07-F06 (N-301, 2026-10-19: CHK-C02-101 C2, the rule its break X1 showed no merged case reached). Rule
-- removed: the events of record_eval_run and mark_exported take their role_class from the token, never from the call
-- (W-C02-09 point 3, fifth bullet; point 5). Each function is wrapped: after the build's call, every event it wrote is
-- given the role_class the payload declares, when it declares one (the event table's user triggers off for that update).
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds none of the build's logic: it wraps the build's functions and keeps their parameter types
-- and order (README 5.2, "Wrappers"); a call that declares no role_class is passed through unchanged. Each build function
-- moves to devos_private under a new name, so that F06's list of devos_api functions, read from the catalogue, is the
-- same as without the patch.
-- Synthetic (plan Section 8 item 13): no data, no token. No psql meta-command is used.
begin;  -- the guard and the change in one transaction: a refused guard aborts the whole patch
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
do $p$
declare fn text;
begin
  foreach fn in array array['record_eval_run', 'mark_exported'] loop
    execute format('alter function devos_api.%I(jsonb) rename to %I', fn, fn || '_w07_orig');
    execute format('alter function devos_api.%I(jsonb) set schema devos_private', fn || '_w07_orig');
    execute format($w$create function devos_api.%I(p jsonb) returns jsonb language plpgsql security definer
      set search_path = pg_catalog as $f$
      declare r jsonb; e0 bigint;
      begin
        select coalesce(max(e.id), 0) into e0 from devos_private.event e;
        r := devos_private.%I(p);
        if jsonb_typeof(p -> 'role_class') = 'string' then
          alter table devos_private.event disable trigger user;
          update devos_private.event set role_class = p ->> 'role_class'
           where id > e0 and aggregate_type is distinct from 'env_token';
          alter table devos_private.event enable trigger user;
        end if;
        return r;
      end $f$$w$, fn, fn || '_w07_orig');
    execute format('revoke all on function devos_api.%I(jsonb) from public', fn);
    execute format('grant execute on function devos_api.%I(jsonb) to anon', fn);
  end loop;
end $p$;
commit;
