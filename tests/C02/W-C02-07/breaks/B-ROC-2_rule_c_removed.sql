-- w07-break: test=w07_roc_ownership_and_claim_class.sql; expect-red=ROC-c-revise_work,ROC-c-cancel_work,ROC-c-relate,ROC-c-retract_relation,ROC-x-c-claims-partial
-- Break patch for T-W07-ROC (tests/C02/W-C02-07/T-W07-ROC_ownership_and_claim_class.md, "Break attempt"; phase C4a). Rule
-- removed: Rule C (EV-C02-008 1.7.1: refused while an active claim of a role class other than the caller's is on the work
-- item). revise_work, cancel_work, relate and retract_relation are wrapped so that, for the call, every claim on the work
-- item is shown under the caller's own class, and is put back after it: another class's claim then never stops the call.
-- The caller's class is read through devos_api.token_role_class() (README 8.1); B 3.5's Assignment fields work_ref and
-- role_class, and B 3.4's Relation field from_ref, are the names it uses.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8).
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
-- Shows every claim on p_work under the caller's class; returns what to put back.
create function devos_private.w07_break_mask(p_work text) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare saved jsonb; cls text := (devos_api.token_role_class())->>'role_class';
begin
  select coalesce(jsonb_object_agg(a.id::text, a.role_class::text), '{}') into saved
    from devos_private.assignment a where a.work_ref::text = p_work;
  if cls is not null then
    execute format('update devos_private.assignment set role_class = %L where work_ref::text = %L', cls, p_work);
  end if;
  return saved;
end $f$;
create function devos_private.w07_break_unmask(p_saved jsonb) returns void language plpgsql security definer
set search_path = pg_catalog as $f$
declare k text;
begin
  for k in select jsonb_object_keys(p_saved) loop
    execute format('update devos_private.assignment set role_class = %L where id::text = %L', p_saved->>k, k);
  end loop;
end $f$;
alter function devos_api.cancel_work(uuid, text) rename to cancel_work_w07_orig;
create function devos_api.cancel_work(work_id uuid, reason text) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare s jsonb := devos_private.w07_break_mask(work_id::text); r jsonb;
begin
  r := devos_api.cancel_work_w07_orig(work_id, reason);
  perform devos_private.w07_break_unmask(s);
  return r;
end $f$;
alter function devos_api.revise_work(jsonb) rename to revise_work_w07_orig;
create function devos_api.revise_work(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare s jsonb := devos_private.w07_break_mask(p->>'id'); r jsonb;
begin
  r := devos_api.revise_work_w07_orig(p);
  perform devos_private.w07_break_unmask(s);
  return r;
end $f$;
alter function devos_api.relate(jsonb) rename to relate_w07_orig;
create function devos_api.relate(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare s jsonb := devos_private.w07_break_mask(p->>'from_ref'); r jsonb;
begin
  r := devos_api.relate_w07_orig(p);
  perform devos_private.w07_break_unmask(s);
  return r;
end $f$;
alter function devos_api.retract_relation(uuid, text) rename to retract_relation_w07_orig;
create function devos_api.retract_relation(relation_id uuid, reason text) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare s jsonb; r jsonb;
begin
  s := devos_private.w07_break_mask((select x.from_ref::text from devos_private.relation x where x.id = retract_relation.relation_id));
  r := devos_api.retract_relation_w07_orig(relation_id, reason);
  perform devos_private.w07_break_unmask(s);
  return r;
end $f$;
revoke all on function devos_private.w07_break_mask(text), devos_private.w07_break_unmask(jsonb) from public;
grant execute on function devos_api.cancel_work(uuid, text), devos_api.revise_work(jsonb), devos_api.relate(jsonb),
  devos_api.retract_relation(uuid, text) to anon, authenticated;
commit;
