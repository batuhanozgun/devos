-- w07-break: test=w07_f08_recheck_at_effect.sql; expect-red=F08-w
-- Rule removed: the re-check of the current work item at the moment of effect (Appendix C F08's class rule, "the
-- current work item ... checked again"; B 3.12). Specification: tests/C02/W-C02-07/T-W07-F08_recheck_at_effect.md.
-- How: register_artifact(text, jsonb) is renamed and a wrapper takes its name; it replaces the revision the call
-- names for its work item with the work item's newest revision in devos_private.work_revision (the foreign key to
-- devos_private.work found in the catalogue), then calls the build's function, so the build never sees that the
-- work item changed after the claim. It holds none of the build's logic. If the build ends a claim when its work item
-- is revised, F08-w's refusal comes from the claim and this patch also has to present the claim as current: the
-- prober revises it before the run (README 5.2).
-- Synthetic (plan Section 8 item 13): no data. Throwaway database only (README 5.2), never under
-- supabase/migrations/. No psql meta-command. The whole change runs inside the guard's block. Phase C3.
-- Revised under ledger rule 3, 2026-10-19 (N-290 (1); CHK-C02-090 finding 12), before any run of this patch: the call's
-- work item and the revision it names are read and written in the flat form EV-C02-013 2.6 gives them (work_ref a
-- uuid, work_revision beside it); the first version read p->'work_ref'->>'id' and set work_ref.revision, so it never
-- found the work item and passed every call through. The red list is unchanged. T-W07-F08's "Revision under ledger
-- rule 3 (N-290, 2026-10-19)".
do $b$
declare fk text;
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  select a.attname into fk from pg_constraint k join pg_attribute a on a.attrelid = k.conrelid and a.attnum = k.conkey[1]
   where k.conrelid = to_regclass('devos_private.work_revision') and k.contype = 'f'
     and k.confrelid = to_regclass('devos_private.work') limit 1;
  if fk is null then
    raise exception 'w07 break patch: no foreign key from devos_private.work_revision to devos_private.work';
  end if;
  execute 'alter function devos_api.register_artifact(text, jsonb) rename to register_artifact_w07_orig';
  execute format($p$
    create function devos_api.register_artifact(p_claim_token text, p jsonb) returns jsonb language plpgsql
    security definer set search_path = pg_catalog as $f$
    declare cur int;
    begin
      select max(revision) into cur from devos_private.work_revision where %1$I = (p->>'work_ref')::uuid;
      if cur is not null then p := jsonb_set(p, '{work_revision}', to_jsonb(cur)); end if;
      return devos_api.register_artifact_w07_orig(p_claim_token, p);
    end $f$ $p$, fk);
  execute 'grant execute on function devos_api.register_artifact(text, jsonb) to anon';
end $b$;
