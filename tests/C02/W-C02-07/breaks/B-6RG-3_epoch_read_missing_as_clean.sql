-- w07-break: test=w07_6rg_rule_gate_could_not_check.sql; expect-red=6RG-a1,6RG-a2
-- Break patch for T-W07-6RG (N-301, 2026-10-19; k17 of EV-C02-014 section 11). Rule removed: the global authority
-- epoch's read answers its missing or partial row "could not check", never clean (B principle 9: a single global
-- counter; plan Section 8 item 14; EV-C02-013 24 (7)). authority_epoch is wrapped so that a could_not_check answer
-- becomes clean, {"status": "ok", "epoch": null}.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can: it wraps the build's function and keeps its
-- parameter types and order (README 5.2, "Wrappers").
-- Synthetic (plan Section 8 item 13): no data; any value it writes is labelled w07 break. No psql meta-command is used.
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
alter function devos_api.authority_epoch() rename to authority_epoch_w07_orig;
create function devos_api.authority_epoch() returns jsonb language plpgsql security definer set search_path = pg_catalog as $f$
declare r jsonb;
begin
  r := devos_api.authority_epoch_w07_orig();
  if r->>'status' = 'refused' and r->>'reason_code' = 'could_not_check' then
    return jsonb_build_object('status', 'ok', 'epoch', null);
  end if;
  return r;
end $f$;
grant execute on function devos_api.authority_epoch() to anon, authenticated;
commit;
