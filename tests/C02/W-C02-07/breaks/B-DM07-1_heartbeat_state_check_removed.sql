-- w07-break: test=w07_dm07_heartbeat.sql; expect-red=DM07-lapsed,DM07-revoked,DM07-released,DM07-oldgen
-- Rule removed: heartbeat's check that the claim is active, of the current generation and its lease not run out
-- (EV-C02-002 DM-07 and section 6; B 3.5 as PC-42 place 13 words it). The epoch and role-class checks stay.
-- Specification: tests/C02/W-C02-07/T-W07-DM07_heartbeat.md. How: heartbeat(text) is renamed and a wrapper takes its
-- name; it finds the presented claim token's Assignment (hash rule of EV-C02-003 §1.7: SHA-256 of the whole token,
-- hex), makes it look active, current and unexpired for the call (setting aside its work item's other active claim
-- and lifting its generation above the others), calls the build's heartbeat, and restores status and generation.
-- It holds none of the build's logic. Synthetic (plan Section 8 item 13): no data. Throwaway database only
-- (README 5.2), never under supabase/migrations/. No psql meta-command. The whole change runs inside the guard's block.
-- Revised under ledger rule 3, 2026-10-19 (N-287 (1); CHK-C02-091 finding 8), before any run of this patch: the other
-- active claim is set aside with the status released, a value devos_private.assignment_status holds ({active,
-- released, expired, revoked}, W-C02-08's migration 20261014170203), and set active again after the call; the first
-- version wrote w07_set_aside, which the enum does not hold, so DM07-oldgen raised 22P02 instead of turning red. The
-- red list is unchanged. T-W07-DM07's "Revision under ledger rule 3 (N-287, 2026-10-19)".
do $b$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  execute 'alter function devos_api.heartbeat(text) rename to heartbeat_w07_orig';
  execute $p$
    create function devos_api.heartbeat(p_claim_token text) returns jsonb language plpgsql security definer
    set search_path = pg_catalog as $f$
    declare a record; other uuid; r jsonb;
    begin
      select id, work_ref, status, generation into a from devos_private.assignment
       where claim_token_hash = encode(sha256(convert_to(coalesce(p_claim_token, ''), 'UTF8')), 'hex');
      if a.id is not null then
        select id into other from devos_private.assignment where work_ref = a.work_ref and status = 'active' and id <> a.id;
        if other is not null then update devos_private.assignment set status = 'released' where id = other; end if;
        update devos_private.assignment set status = 'active',
               generation = (select max(generation) + 1 from devos_private.assignment where work_ref = a.work_ref),
               lease_expires_at = greatest(lease_expires_at, now() + interval '1 minute')
         where id = a.id;
      end if;
      r := devos_api.heartbeat_w07_orig(p_claim_token);
      if a.id is not null then
        update devos_private.assignment set status = a.status, generation = a.generation where id = a.id;
        if other is not null then update devos_private.assignment set status = 'active' where id = other; end if;
      end if;
      return r;
    end $f$ $p$;
  execute 'grant execute on function devos_api.heartbeat(text) to anon';
end $b$;
