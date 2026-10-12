-- w07-break: test=w07_6st_settings_could_not_check.sql; expect-red=6ST-share-finding-missing,6ST-share-finding-unreadable,6ST-share-finding-partial,6ST-pos-missing,6ST-pos-unreadable,6ST-pos-partial
-- Break patch for T-W07-6ST (tests/C02/W-C02-07/T-W07-6ST_*.md, "Break attempt"). Rule removed: could not check kept apart, for a finding (the share and the hidden position).
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
declare r jsonb; nid uuid;
begin
  r := devos_api.record_finding_w07_orig(p);
  if r->>'reason_code' = 'could_not_check' then
    nid := gen_random_uuid();
    insert into devos_private.finding select * from jsonb_populate_record(null::devos_private.finding, p || jsonb_build_object('id', nid));
    return jsonb_build_object('status', 'ok', 'id', nid);
  end if;
  return r;
end $f$;
grant execute on function devos_api.record_finding(jsonb) to anon, authenticated;
commit;
