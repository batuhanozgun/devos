-- w07-break: test=supabase/migrations/tests/w07_k05_many_paths.sql; expect-red=K05-rows
-- Removes the affected-records query's deduplication (Appendix C F04, "Break"): devos_api.affected_entities(uuid, jsonb) is renamed and wrapped; the wrapper keeps the build's own answer for visibility and completeness and lists each visible record once per path to it (paths up to 25 steps), as a query without deduplication would.
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
create schema if not exists w07_break;
alter function devos_api.affected_entities(uuid, jsonb) rename to affected_entities_w07_orig;
create function devos_api.affected_entities(root uuid, limits jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb; vis text[]; multi jsonb;
begin
  r := devos_api.affected_entities_w07_orig(root, limits);
  if jsonb_typeof(r->'records') is distinct from 'array' then return r; end if;
  vis := array(select case when jsonb_typeof(e) = 'string' then e #>> '{}' else coalesce(e->>'ref', e->>'entity_ref', e->>'id') end from jsonb_array_elements(r->'records') e);
  with recursive p(node, depth) as (
    select x.from_ref, 1 from devos_private.relation x where x.to_ref = root
    union all
    select x.from_ref, p.depth + 1 from devos_private.relation x join p on x.to_ref = p.node where p.depth < 25)
  select coalesce(jsonb_agg(jsonb_build_object('ref', node)), '[]') into multi from p where node::text = any(vis);
  -- every visible record still appears (at least once), so only the duplicates differ from the build's answer
  multi := multi || coalesce((select jsonb_agg(jsonb_build_object('ref', v)) from unnest(vis) v
    where not exists (select 1 from jsonb_array_elements(multi) m where m->>'ref' = v)), '[]');
  return jsonb_set(r, '{records}', multi);
end $f$;
do $p$
declare g record;
begin
  revoke all on function devos_api.affected_entities(uuid, jsonb) from public;
  for g in select coalesce(nullif(pg_get_userbyid(a.grantee), ''), 'public') as who, a.grantee from pg_proc pr,
           aclexplode(pr.proacl) a where pr.oid = 'devos_api.affected_entities_w07_orig(uuid, jsonb)'::regprocedure loop
    execute format('grant execute on function devos_api.affected_entities(uuid, jsonb) to %s',
                   case when g.grantee = 0 then 'public' else quote_ident(g.who) end);
  end loop;
end $p$;
