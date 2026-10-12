-- w07-break: test=w07_n29_impact_class.sql; expect-red=N29-art-.claude/,N29-art-.github/CODEOWNERS,N29-art-.github/workflows/,N29-art-CLAUDE.md,N29-art-methods/,N29-art-pipelines/,N29-art-supabase/functions/,N29-art-supabase/migrations/
-- Break patch for T-W07-N29 (tests/C02/W-C02-07/T-W07-N29_*.md, "Break attempt"). Rule removed: the refusal of an Artifact whose target is on the path table under a routine item (B 3.3; DM-48): the item reads as high for the call.
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
declare old text; r jsonb;
begin
  execute format('select %I::text from devos_private.work where id::text = $1', 'impact_class') into old using p->>'work_ref';
  execute format('update devos_private.work set %I = %L where id::text = %L', 'impact_class', 'high', p->>'work_ref');
  r := devos_api.register_artifact_w07_orig(p);
  execute format('update devos_private.work set %I = %L where id::text = %L', 'impact_class', old, p->>'work_ref');
  return r;
end $f$;
grant execute on function devos_api.register_artifact(jsonb) to anon, authenticated;
