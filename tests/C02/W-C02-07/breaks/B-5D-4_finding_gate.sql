-- w07-break: test=w07_5d_format_gates_empty.sql; expect-red=5D-find-counter_evidence_searched-absent,5D-find-counter_evidence_searched-null,5D-find-counter_evidence_searched-empty,5D-find-counter_evidence_searched-whitespace
-- Break patch for T-W07-5D (tests/C02/W-C02-07/T-W07-5D_*.md, "Break attempt"). Rule removed: Finding's counter_evidence_searched gate (B 3.8; DM-30).
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
alter function devos_api.record_finding(jsonb) rename to record_finding_w07_orig;
create function devos_api.record_finding(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
begin
  if (p->'counter_evidence_searched' is null or jsonb_typeof(p->'counter_evidence_searched') = 'null' or (jsonb_typeof(p->'counter_evidence_searched') = 'string' and btrim(p->>'counter_evidence_searched', E' \t\r\n') = '') or (jsonb_typeof(p->'counter_evidence_searched') = 'array' and jsonb_array_length(p->'counter_evidence_searched') = 0)) then p := p || jsonb_build_object('counter_evidence_searched', 'w07 break: filled by the patch'); end if;
  return devos_api.record_finding_w07_orig(p);
end $f$;
grant execute on function devos_api.record_finding(jsonb) to anon, authenticated;
commit;
