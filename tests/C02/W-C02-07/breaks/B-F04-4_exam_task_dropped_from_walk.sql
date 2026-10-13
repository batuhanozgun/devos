-- w07-break: test=w07_f04_affected_records.sql,w07_n08_exam_fact.sql; expect-red=F04-e-exam,EXF-pair-reads-affected_entities,EXF-pair-reads-explain_paths,N08-x-affected_entities-cal,N08-x-affected_entities-den,N08-x-affected_entities-kur,N08-x-explain_paths-cal,N08-x-explain_paths-den,N08-x-explain_paths-kur
-- Break patch for T-W07-F04 (tests/C02/W-C02-07/T-W07-F04_affected_records.md, "Break attempt"; phase C4b, EV-C02-008 5.1's
-- table, B-F04-4). Rule changed: EV-C02-008 5.1 (a) ("What DM-35 hides: the exam's own records, never the Work"). The two
-- walks are wrapped so that, for a class other than devos_sinav, they drop a work item an EvalRun names and mark the result
-- limited (DM-35's old reading). Red: F04-e-exam, and the pair cases that compare the two walks on an exam task.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8). The caller's class is
-- read through devos_api.token_role_class() (README 8.1: it carries role_class).
-- Synthetic (plan Section 8 item 13): no data; any value it writes is labelled w07 break. No psql meta-command is used.
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
declare r jsonb; k jsonb; kept jsonb := '[]'; dropped boolean := false;
begin
  r := devos_api.affected_entities_w07_orig(root, limits);
  if jsonb_typeof(r) is distinct from 'object' or jsonb_typeof(r->'records') is distinct from 'array'
     or coalesce((devos_api.token_role_class())->>'role_class', '') = 'devos_sinav' then return r; end if;
  for k in select * from jsonb_array_elements(r->'records') loop
    if exists (select 1 from devos_private.eval_run e where e.work_ref::text = coalesce(k->>'ref', k->>'entity_ref', k->>'id', k #>> '{}')) then dropped := true; else kept := kept || jsonb_build_array(k); end if;
  end loop;
  if dropped then r := r || jsonb_build_object('records', kept, 'complete', false); end if;
  return r;
end $f$;
grant execute on function devos_api.affected_entities(uuid, jsonb) to anon, authenticated;
alter function devos_api.explain_paths(uuid, uuid, jsonb) rename to explain_paths_w07_orig;
create function devos_api.explain_paths(root uuid, target uuid, limits jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb; p jsonb; kept jsonb := '[]'; dropped boolean := false;
begin
  r := devos_api.explain_paths_w07_orig(root, target, limits);
  if jsonb_typeof(r) is distinct from 'object' or jsonb_typeof(r->'paths') is distinct from 'array'
     or coalesce((devos_api.token_role_class())->>'role_class', '') = 'devos_sinav' then return r; end if;
  for p in select * from jsonb_array_elements(r->'paths') loop
    if exists (select 1 from jsonb_array_elements(case when jsonb_typeof(p) = 'array' then p else coalesce(p->'nodes', p->'refs', '[]') end) n where exists (select 1 from devos_private.eval_run e where e.work_ref::text = coalesce(n->>'ref', n->>'entity_ref', n->>'id', n #>> '{}'))) then dropped := true;
    else kept := kept || jsonb_build_array(p); end if;
  end loop;
  if dropped then r := r || jsonb_build_object('paths', kept, 'complete', false); end if;
  return r;
end $f$;
grant execute on function devos_api.explain_paths(uuid, uuid, jsonb) to anon, authenticated;
commit;
