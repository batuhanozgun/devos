-- w07-break: test=w07_5c_other_session_fake_id.sql,w07_n17_claim_token.sql; expect-red=5C-n1,5C-n2,5C-n4,N17-n1
-- Rule removed: an effect is made only with the claim of its own work item, so another session's claim does not act
-- on it (B 3.5: "Another session in the same environment cannot carry out an operation with someone else's claim";
-- C02 Acceptance's claim line). Specification: tests/C02/W-C02-07/T-W07-5C_other_session_fake_id.md and
-- T-W07-N17_claim_token.md. How: register_artifact and prepare_operation are renamed and wrappers take their names;
-- when the presented claim token's Assignment (found by the hash rule of EV-C02-003 §1.7: SHA-256 of the whole token,
-- hex) belongs to another work item, the wrapper moves it to the named work item for the call (setting that work
-- item's own active claim aside), calls the build's function, and restores both. It holds none of the build's logic.
-- Synthetic (plan Section 8 item 13): no data. Throwaway database only (README 5.2), never under supabase/migrations/.
-- No psql meta-command. The whole change runs inside the guard's block.
do $b$
declare f record;
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  for f in select * from (values ('register_artifact'), ('prepare_operation')) v(fn) loop
    execute format('alter function devos_api.%I(text, jsonb) rename to %I', f.fn, f.fn || '_w07_orig');
    execute format($p$
      create function devos_api.%1$I(p_claim_token text, p jsonb) returns jsonb language plpgsql security definer
      set search_path = pg_catalog as $f$
      declare aid uuid; old_work uuid; own uuid; target uuid := (p->'work_ref'->>'id')::uuid; r jsonb;
      begin
        select id, work_ref into aid, old_work from devos_private.assignment
         where claim_token_hash = encode(sha256(convert_to(coalesce(p_claim_token, ''), 'UTF8')), 'hex');
        if aid is not null and old_work <> target then
          select id into own from devos_private.assignment where work_ref = target and status = 'active';
          if own is not null then update devos_private.assignment set status = 'w07_set_aside' where id = own; end if;
          update devos_private.assignment set work_ref = target where id = aid;
        end if;
        r := devos_api.%2$I(p_claim_token, p);
        if aid is not null and old_work <> target then
          update devos_private.assignment set work_ref = old_work where id = aid;
          if own is not null then update devos_private.assignment set status = 'active' where id = own; end if;
        end if;
        return r;
      end $f$ $p$, f.fn, f.fn || '_w07_orig');
    execute format('grant execute on function devos_api.%I(text, jsonb) to anon', f.fn);
  end loop;
end $b$;
