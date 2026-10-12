-- w07-break: test=w07_n03_effort_policy.sql; expect-red=N03-neg-default-denetim
-- Break patch for T-W07-N03 (tests/C02/W-C02-07/T-W07-N03_*.md, "Break attempt"; phase C4a, CHK-C02-025 condition C2 (b)).
-- Rule removed: devos_denetim's refusal of kind (a), an item's own policy at the default (EV-C02-008 1.7.4: "devos_denetim
-- is refused this kind"): a kind (a) call with the devos_denetim token that the build refuses is made again with a
-- devos_calisma token, so the audit environment's call is accepted. A call the build accepts is returned unchanged.
-- The caller's class is read through devos_api.token_role_class() (README 8.1).
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
alter function devos_api.set_effort_policy(jsonb) rename to set_effort_policy_w07_orig;
create function devos_api.set_effort_policy(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare h text; tok text; r jsonb; cls text := (devos_api.token_role_class())->>'role_class';
begin
  r := devos_api.set_effort_policy_w07_orig(p);
  if cls = 'devos_denetim' and r->>'status' = 'refused'
     and p->>'work_ref' is not null and p->>'standing_policy_ref' is null
     and coalesce(p->>'level', 'high') = 'high' and coalesce(p->>'status', 'active') <> 'retired' then
    h := current_setting('request.headers', true);
    execute 'select devos_private.issue_env_token($1)::text' into tok using 'devos_calisma';
    perform set_config('request.headers', json_build_object('x-devos-env-token', tok)::text, true);
    tok := null;
    r := devos_api.set_effort_policy_w07_orig(p);
    perform set_config('request.headers', h, true);
  end if;
  return r;
end $f$;
grant execute on function devos_api.set_effort_policy(jsonb) to anon, authenticated;
commit;
