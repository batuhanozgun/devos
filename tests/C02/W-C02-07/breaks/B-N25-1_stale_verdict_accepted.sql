-- w07-break: test=supabase/migrations/tests/w07_n25_verdict_staleness.sql; expect-red=N25-a,N25-b,N25-c,N25-d
-- Removes the staleness rule (B 3.11: a verdict whose basis_refs, criterion or use changed cannot be used for acceptance): devos_api.accept(uuid, text) is wrapped so that a refused acceptance is written anyway, as a plain Acceptance row, with nothing else of the function kept.
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
create schema if not exists w07_break;
-- A plain row writer (no build logic): the given columns, every other NOT NULL column by its type.
create function w07_break.put(p_table regclass, p_vals jsonb) returns void language plpgsql as $f$
declare a record; j jsonb := p_vals; cols text;
begin
  for a in select att.attname, t.typname, t.typcategory from pg_attribute att join pg_type t on t.oid = att.atttypid
            where att.attrelid = p_table and att.attnum > 0 and not att.attisdropped and att.attnotnull and not att.atthasdef
              and att.attidentity = '' and att.attgenerated = '' loop
    continue when j ? a.attname;
    j := j || jsonb_build_object(a.attname, case when a.typname = 'uuid' then to_jsonb(gen_random_uuid())
      when a.typcategory = 'N' then to_jsonb(1) when a.typname = 'bool' then to_jsonb(false)
      when a.typname in ('json', 'jsonb') then '[]'::jsonb when a.typname like 'timestamp%' then to_jsonb(now())
      when a.typcategory = 'A' then '[]'::jsonb else to_jsonb('w07_break SYNTHETIC'::text) end);
  end loop;
  select string_agg(quote_ident(x), ', ') into cols from jsonb_object_keys(j) x;
  execute format('insert into %s (%s) select %s from jsonb_populate_record(null::%s, $1)', p_table, cols, cols, p_table) using j;
end $f$;
-- The build's function is copied under a new name, with its own-name qualifiers (accept.x) rewritten, so the
-- copy works unchanged; the public name then gets the wrapper (create or replace keeps its privileges).
do $c$
declare src text;
begin
  src := pg_get_functiondef('devos_api.accept(uuid, text)'::regprocedure);
  src := regexp_replace(src, 'FUNCTION devos_api\.accept\(', 'FUNCTION devos_api.accept_w07_orig(');
  src := regexp_replace(src, '\maccept\.', 'accept_w07_orig.', 'g');
  execute src;
end $c$;
create or replace function devos_api.accept(verdict_ref uuid, accepted_use text) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb;
begin
  r := to_jsonb(devos_api.accept_w07_orig(verdict_ref, accepted_use));
  if r->>'status' = 'refused' then
    perform w07_break.put('devos_private.acceptance', jsonb_build_object('accepted_use', accepted_use,
      'current_evidence', jsonb_build_array(verdict_ref)));
    return jsonb_build_object('status', 'ok');
  end if;
  return r;
end $f$;
grant execute on function devos_api.accept(uuid, text) to anon, authenticated;
commit;
