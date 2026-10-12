-- w07-break: test=w07_n03_effort_policy.sql; expect-red=N03-neg-retired
-- Break patch for T-W07-N03 (tests/C02/W-C02-07/T-W07-N03_*.md, "Break attempt"). Rule removed: the refusal of a retired standing policy (B 3.18).
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
alter function devos_api.set_effort_policy(jsonb) rename to set_effort_policy_w07_orig;
create function devos_api.set_effort_policy(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare st text; r jsonb;
begin
  select status::text into st from devos_private.effort_policy where id::text = p->>'standing_policy_ref';
  if st = 'retired' then
    update devos_private.effort_policy set status = 'active' where id::text = p->>'standing_policy_ref';
    r := devos_api.set_effort_policy_w07_orig(p);
    update devos_private.effort_policy set status = 'retired' where id::text = p->>'standing_policy_ref';
    return r;
  end if;
  return devos_api.set_effort_policy_w07_orig(p);
end $f$;
grant execute on function devos_api.set_effort_policy(jsonb) to anon, authenticated;
