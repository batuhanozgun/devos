-- w07-break: test=w07_6rg_rule_gate_could_not_check.sql; expect-red=6RG-g1,6RG-g2,6RG-l5
-- Rule removed: readiness's three-valued logic and the computed expiry in ready_works(): an unknown member, or a claim
-- whose lease cannot be read, no longer keeps a work item from being offered (B principle 6; B 3.5; EV-C02-002 DM-06;
-- W-C02-09 point 7). Specification: tests/C02/W-C02-07/T-W07-6RG_rule_gate_could_not_check.md. How: ready_works() is
-- renamed and a wrapper takes its name that answers ok and adds to the build's list every work item without an
-- Assignment that is active with a lease known to be in the future. It holds none of the build's logic.
-- Synthetic (plan Section 8 item 13): no data. Throwaway database only (README 5.2), never under
-- supabase/migrations/. No psql meta-command. The whole change runs inside the guard's block.
do $b$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  execute 'alter function devos_api.ready_works() rename to ready_works_w07_orig';
  execute $p$
    create function devos_api.ready_works() returns jsonb language plpgsql security definer
    set search_path = pg_catalog as $f$
    declare r jsonb := devos_api.ready_works_w07_orig();
    begin
      return jsonb_build_object('status', 'ok', 'works',
        coalesce(case when r->>'status' = 'ok' then r->'works' end, '[]'::jsonb)
        || coalesce((select jsonb_agg(jsonb_build_object('id', w.id)) from devos_private.work w
                     where not exists (select 1 from devos_private.assignment a where a.work_ref = w.id
                                        and a.status = 'active' and a.lease_expires_at > now())), '[]'::jsonb));
    end $f$ $p$;
  execute 'grant execute on function devos_api.ready_works() to anon';
end $b$;
