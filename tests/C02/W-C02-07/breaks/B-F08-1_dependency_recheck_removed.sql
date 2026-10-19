-- w07-break: test=w07_f08_recheck_at_effect.sql; expect-red=F08-a
-- Rule removed: the re-check of the work item's hard dependencies at the moment of effect (Appendix C F08, "Break":
-- "When the re-check at the moment of effect is removed, (a) must pass"; B 3.12). The claim and read-set re-checks
-- stay. Specification: tests/C02/W-C02-07/T-W07-F08_recheck_at_effect.md. How: register_artifact(text, jsonb) is
-- renamed and a wrapper takes its name; for the call it marks the named work item's hard relations not hard (Appendix
-- B 3.4's from_ref and hard), calls the build's function, and restores them. It holds none of the build's logic.
-- Synthetic (plan Section 8 item 13): no data. Throwaway database only (README 5.2), never under
-- supabase/migrations/. No psql meta-command. The whole change runs inside the guard's block.
-- Revised under ledger rule 3, 2026-10-19 (N-290 (1); CHK-C02-090 finding 12), before any run of this patch: work_ref
-- is read in the flat form EV-C02-013 2.6 gives it (a uuid, with work_revision beside it), where the first version read
-- p->'work_ref'->>'id', null on every call, so the wrapper passed every call through. The red list is unchanged.
-- T-W07-F08's "Revision under ledger rule 3 (N-290, 2026-10-19)".
do $b$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  execute 'alter table devos_private.relation disable trigger user';
  execute 'alter function devos_api.register_artifact(text, jsonb) rename to register_artifact_w07_orig';
  execute $p$
    create function devos_api.register_artifact(p_claim_token text, p jsonb) returns jsonb language plpgsql
    security definer set search_path = pg_catalog as $f$
    declare hidden uuid[]; r jsonb;
    begin
      select array_agg(id) into hidden from devos_private.relation
       where from_ref = (p->>'work_ref')::uuid and hard;
      update devos_private.relation set hard = false where id = any(hidden);
      r := devos_api.register_artifact_w07_orig(p_claim_token, p);
      update devos_private.relation set hard = true where id = any(hidden);
      return r;
    end $f$ $p$;
  execute 'grant execute on function devos_api.register_artifact(text, jsonb) to anon';
end $b$;
