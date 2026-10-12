-- w07-break: test=w07_f08_recheck_at_effect.sql; expect-red=F08-c1,F08-c2,F08-c3
-- Rule removed: the re-check of the claim at the moment of effect: active, lease not run out, epoch valid (Appendix C
-- F08 (c); B 3.5 and 3.12; EV-C02-002 DM-06). The dependency and read-set re-checks stay.
-- Specification: tests/C02/W-C02-07/T-W07-F08_recheck_at_effect.md. How: register_artifact(text, jsonb) is renamed
-- and a wrapper takes its name; for the call it makes the named work item's latest Assignment look active, unexpired
-- and of the current global authority epoch (the epoch's table and column found in the catalogue, as the test does),
-- calls the build's function, and restores the Assignment. It holds none of the build's logic. Synthetic (plan
-- Section 8 item 13): no data. Throwaway database only (README 5.2), never under supabase/migrations/.
-- No psql meta-command. The whole change runs inside the guard's block.
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
    declare a record; r jsonb;
    begin
      select id, status, lease_expires_at, authority_epoch into a from devos_private.assignment
       where work_ref = (p->'work_ref'->>'id')::uuid order by generation desc limit 1;
      if a.id is not null and not exists (select 1 from devos_private.assignment
             where work_ref = (p->'work_ref'->>'id')::uuid and status = 'active' and id <> a.id) then
        update devos_private.assignment set status = 'active', lease_expires_at = now() + interval '1 minute',
               authority_epoch = (select %2$I from %1$s) where id = a.id;
      end if;
      r := devos_api.register_artifact_w07_orig(p_claim_token, p);
      if a.id is not null then
        update devos_private.assignment set status = a.status, lease_expires_at = a.lease_expires_at,
               authority_epoch = a.authority_epoch where id = a.id;
      end if;
      return r;
    end $f$ $p$, ept, epc);
  execute 'grant execute on function devos_api.register_artifact(text, jsonb) to anon';
end $b$;
