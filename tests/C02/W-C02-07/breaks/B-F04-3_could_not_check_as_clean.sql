-- w07-break: test=supabase/migrations/tests/w07_f04_affected_records.sql; expect-red=F04-m1,F04-m2,F04-u1,F04-u2
-- Removes the "could not check" answer of affected_entities and explain_paths (W-C02-09 point 7; plan Section 8 item
-- 14; README section 3 (i)): both are renamed and wrapped; when the build answers could_not_check, the wrapper answers
-- the clean result instead (status ok, no records, complete), "nothing else is affected". Phase C3 (G10).
-- Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness (tests/C02/W-C02-07/harness/) on a throwaway
-- PostgreSQL built from supabase/migrations/, never on devos-test or devos; it sits outside supabase/migrations/, so the
-- migration job never applies it. Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
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
alter function devos_api.affected_entities(uuid, jsonb) rename to affected_entities_w07_orig;
create function devos_api.affected_entities(root uuid, limits jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb;
begin
  r := devos_api.affected_entities_w07_orig(root, limits);
  if jsonb_typeof(r) = 'object' and r->>'status' = 'refused' and r->>'reason_code' = 'could_not_check' then
    return jsonb_build_object('status', 'ok', 'records', '[]'::jsonb, 'paths', '[]'::jsonb, 'complete', true);
  end if;
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
alter function devos_api.explain_paths(uuid, uuid, jsonb) rename to explain_paths_w07_orig;
create function devos_api.explain_paths(root uuid, target uuid, limits jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb;
begin
  r := devos_api.explain_paths_w07_orig(root, target, limits);
  if jsonb_typeof(r) = 'object' and r->>'status' = 'refused' and r->>'reason_code' = 'could_not_check' then
    return jsonb_build_object('status', 'ok', 'records', '[]'::jsonb, 'paths', '[]'::jsonb, 'complete', true);
  end if;
  return r;
end $f$;
do $p$
declare g record;
begin
  revoke all on function devos_api.explain_paths(uuid, uuid, jsonb) from public;
  for g in select a.grantee from pg_proc pr, aclexplode(pr.proacl) a
            where pr.oid = 'devos_api.explain_paths_w07_orig(uuid, uuid, jsonb)'::regprocedure loop
    execute format('grant execute on function devos_api.explain_paths(uuid, uuid, jsonb) to %s',
                   case when g.grantee = 0 then 'public' else quote_ident(pg_get_userbyid(g.grantee)) end);
  end loop;
end $p$;
commit;
