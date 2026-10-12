-- w07-break: test=supabase/migrations/tests/w07_n09_finding_gate.sql; expect-red=N09-a,N09-b,N09-c,N09-d
-- Removes N09's rule (a changeable finding needs a dated primary span before accepted_for_use, B 3.8; DM-26): triggers on devos_private.finding that read the spans are disabled, and devos_api.review_finding(uuid, integer, text) is wrapped so that a refused move to accepted_for_use is made anyway, with nothing else of the function kept.
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
  for r in select t.tgname from pg_trigger t join pg_proc p on p.oid = t.tgfoid
            where t.tgrelid = 'devos_private.finding'::regclass and not t.tgisinternal
              and p.prosrc ~* '(primary|changeable|read_at|source_spans)' loop
    execute format('alter table devos_private.finding disable trigger %I', r.tgname);
  end loop;
end $p$;
-- The build's function is copied under a new name, with its own-name qualifiers (review_finding.x) rewritten, so the
-- copy works unchanged; the public name then gets the wrapper (create or replace keeps its privileges).
do $c$
declare src text;
begin
  src := pg_get_functiondef('devos_api.review_finding(uuid, integer, text)'::regprocedure);
  src := regexp_replace(src, 'FUNCTION devos_api\.review_finding\(', 'FUNCTION devos_api.review_finding_w07_orig(');
  src := regexp_replace(src, '\mreview_finding\.', 'review_finding_w07_orig.', 'g');
  execute src;
end $c$;
create or replace function devos_api.review_finding(finding_id uuid, revision integer, status text) returns jsonb language plpgsql
security definer set search_path = pg_catalog as $f$
declare r jsonb;
begin
  r := to_jsonb(devos_api.review_finding_w07_orig(finding_id, revision, status));
  if status = 'accepted_for_use' and (r->>'ok' = 'false' or r ? 'reason_code') then
    update devos_private.finding f set status = 'accepted_for_use' where f.id = finding_id;
    return jsonb_build_object('ok', true, 'status', 'accepted_for_use');
  end if;
  return r;
end $f$;
grant execute on function devos_api.review_finding(uuid, integer, text) to anon, authenticated;
