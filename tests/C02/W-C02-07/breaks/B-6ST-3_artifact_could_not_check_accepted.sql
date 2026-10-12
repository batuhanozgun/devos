-- w07-break: test=w07_6st_settings_could_not_check.sql; expect-red=6ST-path-missing,6ST-path-unreadable,6ST-path-partial
-- Break patch for T-W07-6ST (tests/C02/W-C02-07/T-W07-6ST_*.md, "Break attempt"). Rule removed: could not check kept apart, for the path list's copy on an Artifact.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8).
-- Synthetic (plan Section 8 item 13): no data; any value it writes is labelled w07 break. No psql meta-command is used.
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
alter function devos_api.register_artifact(jsonb) rename to register_artifact_w07_orig;
create function devos_api.register_artifact(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare r jsonb; nid uuid;
begin
  r := devos_api.register_artifact_w07_orig(p);
  if r->>'reason_code' = 'could_not_check' or r->>'status' = 'could_not_check' then
    nid := gen_random_uuid();
    insert into devos_private.artifact select * from jsonb_populate_record(null::devos_private.artifact, p || jsonb_build_object('id', nid));
    return jsonb_build_object('status', 'accepted', 'id', nid);
  end if;
  return r;
end $f$;
grant execute on function devos_api.register_artifact(jsonb) to anon, authenticated;
