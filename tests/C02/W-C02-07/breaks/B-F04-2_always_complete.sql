-- w07-break: test=supabase/migrations/tests/w07_f04_affected_records.sql; expect-red=F04-c-flag,F04-d1,F04-d2
-- Removes the completeness flag (Appendix C F04 (d): "nothing else is affected" is not said): devos_api.affected_entities(uuid, jsonb) is renamed and wrapped; the wrapper returns the build's answer with complete set to true.
-- Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness (tests/C02/W-C02-07/harness/) on a throwaway
-- PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the
-- migration job never applies it. Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
alter function devos_api.affected_entities(uuid, jsonb) rename to affected_entities_w07_orig;
create function devos_api.affected_entities(root uuid, limits jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb;
begin
  r := devos_api.affected_entities_w07_orig(root, limits);
  if jsonb_typeof(r) is distinct from 'object' then return r; end if;
  r := r || '{"complete": true}'::jsonb;
  if r ? 'completeness' then r := r || '{"completeness": "complete"}'::jsonb; end if;
  return r;
end $f$;
do $p$
declare g record;
begin
  revoke all on function devos_api.affected_entities(uuid, jsonb) from public;
  for g in select a.grantee from pg_proc pr, aclexplode(pr.proacl) a
            where pr.oid = 'devos_api.affected_entities_w07_orig(uuid, jsonb)'::regprocedure loop
    execute format('grant execute on function devos_api.affected_entities(uuid, jsonb) to %s',
                   case when g.grantee = 0 then 'public' else quote_ident(pg_get_userbyid(g.grantee)) end);
  end loop;
end $p$;
