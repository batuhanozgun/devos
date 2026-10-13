-- w07-break: test=w07_f04_affected_records.sql; expect-red=F04-c-sin
-- Break patch for T-W07-F04 (phase C4b, EV-C02-008 5.1's table: "A break that drops exam records for every class"; its ID
-- is the test designer's). Rule changed: 5.1 (a) and (b) give devos_sinav the exam records (it "reads the link through
-- R10r's reader" and the hidden-node filter goes by class). affected_entities is wrapped so that an exam record is
-- dropped, and the result marked limited, for every class, devos_sinav's included.
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
  if jsonb_typeof(r) is distinct from 'object' or jsonb_typeof(r->'records') is distinct from 'array' then return r; end if;
  for k in select * from jsonb_array_elements(r->'records') loop
    if exists (select 1 from devos_private.eval_run e where e.id::text = coalesce(k->>'ref', k->>'entity_ref', k->>'id', k #>> '{}')) then dropped := true; else kept := kept || jsonb_build_array(k); end if;
  end loop;
  if dropped then r := r || jsonb_build_object('records', kept, 'complete', false); end if;
  return r;
end $f$;
grant execute on function devos_api.affected_entities(uuid, jsonb) to anon, authenticated;
commit;
