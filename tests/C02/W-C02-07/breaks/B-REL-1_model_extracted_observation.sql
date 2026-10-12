-- w07-break: test=supabase/migrations/tests/w07_rel_relation_status.sql; expect-red=REL-a,REL-b
-- Removes Relation's rule (B 3.4; PC-16 place 13: model_extracted with observation refused) wherever it sits: check constraints and triggers on devos_private.relation that name model_extracted are dropped or disabled, and devos_api.relate(text, uuid, integer, uuid, integer, text, boolean, text, text) is wrapped so that the pair is written as inference and then set to observation.
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
do $p$
declare r record;
begin
  for r in select conname from pg_constraint where conrelid = 'devos_private.relation'::regclass and contype = 'c'
              and pg_get_constraintdef(oid) ~* 'model_extracted' loop
    execute format('alter table devos_private.relation drop constraint %I', r.conname);
  end loop;
  for r in select t.tgname from pg_trigger t join pg_proc p on p.oid = t.tgfoid
            where t.tgrelid = 'devos_private.relation'::regclass and not t.tgisinternal and p.prosrc ~* 'model_extracted' loop
    execute format('alter table devos_private.relation disable trigger %I', r.tgname);
  end loop;
end $p$;
-- The build's function is copied under a new name, with its own-name qualifiers (relate.x) rewritten, so the
-- copy works unchanged; the public name then gets the wrapper (create or replace keeps its privileges).
do $c$
declare src text;
begin
  src := pg_get_functiondef('devos_api.relate(text, uuid, integer, uuid, integer, text, boolean, text, text)'::regprocedure);
  src := regexp_replace(src, 'FUNCTION devos_api\.relate\(', 'FUNCTION devos_api.relate_w07_orig(');
  src := regexp_replace(src, '\mrelate\.', 'relate_w07_orig.', 'g');
  execute src;
end $c$;
create or replace function devos_api.relate(type text, from_ref uuid, from_revision integer, to_ref uuid, to_revision integer,
  scope text, hard boolean, method text, epistemic_status text) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb; flip boolean := method = 'model_extracted' and epistemic_status = 'observation';
begin
  r := to_jsonb(devos_api.relate_w07_orig(type, from_ref, from_revision, to_ref, to_revision, scope, hard, method,
                case when flip then 'inference' else epistemic_status end));
  if flip and not (r->>'ok' = 'false' or r ? 'reason_code') then
    update devos_private.relation x set epistemic_status = 'observation'
     where x.from_ref = relate.from_ref and x.to_ref = relate.to_ref and x.method = 'model_extracted';
  end if;
  return r;
end $f$;
grant execute on function devos_api.relate(text, uuid, integer, uuid, integer, text, boolean, text, text) to anon, authenticated;
