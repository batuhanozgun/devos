-- w07-break: test=w07_f08_recheck_at_effect.sql; expect-red=F08-c1,F08-g1,F08-g2
-- Rule removed: the re-check at the moment of effect that the presented claim is the work item's current one (active
-- and of the current generation; Appendix C F08 (c), "claim (active, current generation, valid epoch)"; B 3.5 and
-- 3.12). Specification: tests/C02/W-C02-07/T-W07-F08_recheck_at_effect.md. How: register_artifact(text, jsonb) is
-- renamed and a wrapper takes its name; when the build's function refuses, the wrapper tries each of the work item's
-- claims that is not active, newest first, in a subtransaction: it releases the active claim, makes that claim active,
-- of a generation above every other, of the current global authority epoch and unexpired, and calls the build's
-- function again; the first accepted call is kept, every other try is rolled back, and with none the first refusal is
-- returned; after an accepted try the claims are put back as they were. So any claim the work item ever had counts
-- as current. It holds none of the build's checks. If the build
-- keeps the current generation elsewhere than in the claims' generation column, the prober revises this patch before
-- the run (README 5.2).
-- Synthetic (plan Section 8 item 13): no data. Throwaway database only (README 5.2), never under
-- supabase/migrations/. No psql meta-command. The whole change runs inside the guard's block. Phase C3.
-- Revised under ledger rule 3, 2026-10-19 (N-290 (1); CHK-C02-090 finding 12), before any run of this patch: work_ref
-- is read in the flat form EV-C02-013 2.6 gives it (a uuid, with work_revision beside it), where the first version read
-- p->'work_ref'->>'id', null on every call, so the wrapper passed every call through. The red list is unchanged.
-- T-W07-F08's "Revision under ledger rule 3 (N-290, 2026-10-19)".
do $b$
declare ept text; epc text;
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  select min(c.oid::regclass::text) into ept from pg_class c join pg_namespace n on n.oid = c.relnamespace
   where n.nspname = 'devos_private' and c.relkind = 'r' and c.relname like '%epoch%';
  select min(attname) into epc from pg_attribute where attrelid = ept::regclass and attnum > 0 and not attisdropped
     and attname like '%epoch%';
  execute 'alter function devos_api.register_artifact(text, jsonb) rename to register_artifact_w07_orig';
  execute format($p$
    create function devos_api.register_artifact(p_claim_token text, p jsonb) returns jsonb language plpgsql
    security definer set search_path = pg_catalog as $f$
    declare r jsonb; r2 jsonb; c record; top int; wid uuid := (p->>'work_ref')::uuid;
            act uuid; old record;
    begin
      r := devos_api.register_artifact_w07_orig(p_claim_token, p);
      if r->>'status' = 'ok' then return r; end if;
      select max(generation) into top from devos_private.assignment where work_ref = wid;
      for c in select id from devos_private.assignment where work_ref = wid and status::text <> 'active'
               order by generation desc loop
        begin
          select id into act from devos_private.assignment where work_ref = wid and status::text = 'active';
          select status, generation, lease_expires_at, authority_epoch into old from devos_private.assignment where id = c.id;
          update devos_private.assignment set status = 'released' where id = act;
          update devos_private.assignment set status = 'active', generation = top + 1,
                 lease_expires_at = now() + interval '1 minute', authority_epoch = (select %2$I from %1$s)
           where id = c.id;
          r2 := devos_api.register_artifact_w07_orig(p_claim_token, p);
          if r2->>'status' = 'ok' then  -- keep the effect, put the claims back as they were
            update devos_private.assignment set status = old.status, generation = old.generation,
                   lease_expires_at = old.lease_expires_at, authority_epoch = old.authority_epoch where id = c.id;
            update devos_private.assignment set status = 'active' where id = act;
            return r2;
          end if;
          raise exception using errcode = 'P0W07', message = 'w07: undo this try';
        exception when others then null;
        end;
      end loop;
      return r;
    end $f$ $p$, ept, epc);
  execute 'grant execute on function devos_api.register_artifact(text, jsonb) to anon';
end $b$;
