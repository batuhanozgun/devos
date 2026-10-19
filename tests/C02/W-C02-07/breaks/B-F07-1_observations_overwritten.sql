-- w07-break: test=w07_f07_observation_history.sql; expect-red=F07-a1,F07-a2,F07-b1,F07-b2,F07-c1,F07-c2
-- Rule removed: observations are appended, never updated or deleted (Appendix C F07, "Break": "When updates are
-- allowed on the observation table, (a) must fail"; B 3.12). Specification:
-- tests/C02/W-C02-07/T-W07-F07_observation_history.md. How: the observation table's user triggers are disabled
-- (whatever refuses updates there), and record_observation(jsonb) is renamed and a wrapper takes its name that, after
-- the build's function records the new observation, overwrites every earlier observation of the same operation with
-- the new one's effect, source and time (the "latest state in place" form). It holds none of the build's logic.
-- Column names are Appendix B 3.12's (operation_ref, source, observed_at, observed_effect). Synthetic (plan Section 8
-- item 13): no data. Throwaway database only (README 5.2), never under supabase/migrations/. No psql meta-command.
-- The whole change runs inside the guard's block.
do $b$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  execute 'alter table devos_private.observation disable trigger user';
  execute 'alter function devos_api.record_observation(jsonb) rename to record_observation_w07_orig';
  execute $p$
    create function devos_api.record_observation(p jsonb) returns jsonb language plpgsql security definer
    set search_path = pg_catalog as $f$
    declare r jsonb;
    begin
      r := devos_api.record_observation_w07_orig(p);
      if r->>'status' = 'ok' then
        -- Revised under ledger rule 3, 2026-10-19 (N-297 (c)): the values are the new row's own, as stored, so each keeps
        -- its column's type (the first version assigned the payload's text to the enum column observed_effect: 42804).
        update devos_private.observation o set observed_effect = n.observed_effect, source = n.source, observed_at = n.observed_at
          from devos_private.observation n
         where n.id = (r->>'id')::uuid and o.operation_ref = n.operation_ref and o.id <> n.id;
      end if;
      return r;
    end $f$ $p$;
  execute 'grant execute on function devos_api.record_observation(jsonb) to anon';
end $b$;
