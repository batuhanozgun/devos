-- w07-break: test=w07_f04_affected_records.sql; expect-red=F04-dir-supports,F04-dir-supports-paths,F04-dir-challenges,F04-dir-challenges-paths,F04-dir-part_of,F04-dir-part_of-paths
-- Rule removed: the walks' direction per relation type (N-292 option B; EV-C02-017 4 (e); EV-C02-013 22 (4)): one
-- direction, the built one (to_ref changed, from_ref affected), is restored for every type. Specification:
-- tests/C02/W-C02-07/T-W07-F04_affected_records.md, "Revision under ledger rule 3 (N-292, 2026-10-19)". How: the
-- build's affected_entities(uuid, jsonb) and explain_paths(uuid, uuid, jsonb) are renamed and wrappers take their
-- names; for the call each wrapper relabels every relation of type supports, challenges or part_of as derived_from
-- (the type whose direction the build always had), calls the build's function and puts each type back. A relation
-- whose type is NULL is left as it is, so the NULL-type rule stays. It holds none of the build's logic.
-- Synthetic (plan Section 8 item 13): no data. Applied only by the break harness on its throwaway database
-- (README 5.2), never under supabase/migrations/. No psql meta-command. The whole change runs inside the guard's
-- block, so a refused guard changes nothing, whatever the client does after the error.
-- Written under ledger rule 3, 2026-10-19 (N-292).
do $b$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  execute 'create table devos_private.w07_brk_types (id uuid primary key, type devos_private.relation_type not null)';
  execute 'alter function devos_api.affected_entities(uuid, jsonb) rename to affected_entities_w07_orig';
  execute 'alter function devos_api.explain_paths(uuid, uuid, jsonb) rename to explain_paths_w07_orig';
  execute $p$
    create function devos_private.w07_brk_relabel(p_back boolean) returns void language plpgsql security definer
    set search_path = pg_catalog as $f$
    begin
      -- A relation table that cannot be read (F04-u1, -u2 rename it) is left to the build's function to answer.
      if to_regclass('devos_private.relation') is null then return; end if;
      if not p_back then
        insert into devos_private.w07_brk_types select r.id, r.type from devos_private.relation r
         where r.type in ('supports', 'challenges', 'part_of') on conflict (id) do nothing;
        update devos_private.relation r set type = 'derived_from' from devos_private.w07_brk_types t where t.id = r.id;
      else
        update devos_private.relation r set type = t.type from devos_private.w07_brk_types t where t.id = r.id;
        delete from devos_private.w07_brk_types;
      end if;
    end $f$ $p$;
  execute $p$
    create function devos_api.affected_entities(root uuid, limits jsonb) returns jsonb language plpgsql security definer
    set search_path = pg_catalog as $f$
    declare r jsonb;
    begin
      perform devos_private.w07_brk_relabel(false);
      r := devos_api.affected_entities_w07_orig(root, limits);
      perform devos_private.w07_brk_relabel(true);
      return r;
    end $f$ $p$;
  execute $p$
    create function devos_api.explain_paths(root uuid, target uuid, limits jsonb) returns jsonb language plpgsql security definer
    set search_path = pg_catalog as $f$
    declare r jsonb;
    begin
      perform devos_private.w07_brk_relabel(false);
      r := devos_api.explain_paths_w07_orig(root, target, limits);
      perform devos_private.w07_brk_relabel(true);
      return r;
    end $f$ $p$;
  execute 'revoke all on function devos_private.w07_brk_relabel(boolean) from public';
  execute 'revoke all on function devos_api.affected_entities(uuid, jsonb) from public';
  execute 'revoke all on function devos_api.explain_paths(uuid, uuid, jsonb) from public';
  execute 'grant execute on function devos_api.affected_entities(uuid, jsonb) to anon';
  execute 'grant execute on function devos_api.explain_paths(uuid, uuid, jsonb) to anon';
end $b$;
