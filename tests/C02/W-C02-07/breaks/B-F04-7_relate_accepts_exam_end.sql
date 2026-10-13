-- w07-break: test=w07_f04_affected_records.sql; expect-red=F04-m4-cal,F04-m4-kur,F04-m4-sin
-- Break patch for T-W07-F04 (phase C4b, EV-C02-008 5.1's table, B-F04-7; CHK-C02-032 condition 3). Rule removed: 5.1 (b)
-- ("relate refuses, for every class, a relation that names an exam record at either end"). relate is wrapped so that a
-- relation with an EvalRun's id at either end is written, so that a function can make F04-c-noleak's planted graph. The
-- insert names Relation's columns as README 8.1 assumes them (B 3.4); the prober adapts it to the build's before the run.
-- F04-m4-kur turns red only with the hook installation_mission filled (TABLES G21).
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
alter function devos_api.relate(jsonb) rename to relate_w07_orig;
create function devos_api.relate(p jsonb) returns jsonb language plpgsql security definer set search_path = pg_catalog as $f$
declare id uuid;
begin
  if exists (select 1 from devos_private.eval_run e where e.id::text = p->>'from_ref') or exists (select 1 from devos_private.eval_run e where e.id::text = p->>'to_ref') then
    insert into devos_private.relation (type, from_ref, from_revision, to_ref, to_revision, scope, hard, method, epistemic_status)
      values (p->>'type', (p->>'from_ref')::uuid, (p->>'from_revision')::int, (p->>'to_ref')::uuid, (p->>'to_revision')::int,
              p->>'scope', coalesce((p->>'hard')::boolean, false), p->>'method', p->>'epistemic_status')
      returning relation.id into id;
    return jsonb_build_object('status', 'ok', 'id', id);
  end if;
  return devos_api.relate_w07_orig(p);
end $f$;
grant execute on function devos_api.relate(jsonb) to anon, authenticated;
commit;
