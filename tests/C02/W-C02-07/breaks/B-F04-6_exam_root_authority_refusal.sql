-- w07-break: test=w07_f04_affected_records.sql; expect-red=F04-m3,F04-m4-paths
-- Break patch for T-W07-F04 (phase C4b, EV-C02-008 5.1's table, B-F04-6). Rule removed: 5.1 (b)'s last bullet ("A root or
-- target that names an exam record gets, for a class other than sin, the answer and the recorded reason code of a root
-- that names no record"). The two walks are wrapped so that, for a class other than devos_sinav, a root or target that is
-- an EvalRun's id is answered with an authority refusal of its own, recorded, which tells such a record apart from none.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- It removes one rule and holds as little of the build's logic as it can; the names it uses are the interface the
-- specification assumes (revised before a first result if the build differs, README section 8). The caller's class is
-- read through devos_api.token_role_class() (README 8.1: it carries role_class).
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
alter function devos_api.affected_entities(uuid, jsonb) rename to affected_entities_w07_orig;
create function devos_api.affected_entities(root uuid, limits jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
begin
  if coalesce((devos_api.token_role_class())->>'role_class', '') <> 'devos_sinav' and exists (select 1 from devos_private.eval_run e where e.id::text = root::text) then
    insert into devos_private.rejected_attempt (function_name, role_class, reason_code)
      values ('affected_entities', coalesce(nullif(coalesce((devos_api.token_role_class())->>'role_class', ''), ''), 'none'), 'w07_break_not_permitted');
    return jsonb_build_object('status', 'refused', 'reason_code', 'w07_break_not_permitted',
                              'reason', 'w07 break: an exam record answered with an authority refusal');
  end if;
  return devos_api.affected_entities_w07_orig(root, limits);
end $f$;
grant execute on function devos_api.affected_entities(uuid, jsonb) to anon, authenticated;
alter function devos_api.explain_paths(uuid, uuid, jsonb) rename to explain_paths_w07_orig;
create function devos_api.explain_paths(root uuid, target uuid, limits jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
begin
  if coalesce((devos_api.token_role_class())->>'role_class', '') <> 'devos_sinav' and (exists (select 1 from devos_private.eval_run e where e.id::text = root::text) or exists (select 1 from devos_private.eval_run e where e.id::text = target::text)) then
    insert into devos_private.rejected_attempt (function_name, role_class, reason_code)
      values ('explain_paths', coalesce(nullif(coalesce((devos_api.token_role_class())->>'role_class', ''), ''), 'none'), 'w07_break_not_permitted');
    return jsonb_build_object('status', 'refused', 'reason_code', 'w07_break_not_permitted',
                              'reason', 'w07 break: an exam record answered with an authority refusal');
  end if;
  return devos_api.explain_paths_w07_orig(root, target, limits);
end $f$;
grant execute on function devos_api.explain_paths(uuid, uuid, jsonb) to anon, authenticated;
commit;
