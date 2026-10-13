-- w07-break: test=w07_dm34_mission_scope.sql; expect-red=DM34-n1,DM34-n2,DM34-n3,DM34-n4,DM34-n5,DM34-n6
-- Rule removed: admit_work's check that the work item's scope lies within its Mission's (EV-C02-002 DM-34 and
-- section 6; B principle 4; B 3.1). revise_work's check stays, so DM34-n7 must stay green.
-- Specification: tests/C02/W-C02-07/T-W07-DM34_mission_scope.md. How: admit_work(jsonb) is renamed and a wrapper
-- takes its name; it calls the build's function with the Mission's own scope in place of the requested one, then
-- writes the requested scope onto the admitted work item. It holds none of the build's logic. Synthetic
-- (plan Section 8 item 13): no data. Throwaway database only (README 5.2), never under supabase/migrations/.
-- No psql meta-command. The whole change runs inside the guard's block.
do $b$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  execute 'alter function devos_api.admit_work(jsonb) rename to admit_work_w07_orig';
  execute $p$
    create function devos_api.admit_work(p jsonb) returns jsonb language plpgsql security definer
    set search_path = pg_catalog as $f$
    declare ms text; r jsonb;
    begin
      select scope into ms from devos_private.mission where id = (p->'mission_ref'->>'id')::uuid;
      r := devos_api.admit_work_w07_orig(case when ms is null then p else p || jsonb_build_object('scope', ms) end);
      if r->>'status' = 'ok' and ms is not null then
        update devos_private.work set scope = p->>'scope' where id = (r->>'id')::uuid;
      end if;
      return r;
    end $f$ $p$;
  execute 'grant execute on function devos_api.admit_work(jsonb) to anon';
end $b$;
