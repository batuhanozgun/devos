-- w07-break: test=w07_n03_effort_policy.sql; expect-red=N03-neg-own-approval,N03-neg-own-approval-declared,N03-neg-own-approval-kurulum,N03-neg-standing-calisma,N03-neg-standing-kurulum,N03-neg-retire-by-calisma,N03-neg-own-approval-sinav,N03-neg-standing-sinav,N03-neg-retire-by-sinav
-- Break patch for T-W07-N03 (tests/C02/W-C02-07/T-W07-N03_*.md, "Break attempt"). Rule removed: the audit environment's approval (B 3.18; EV-C02-003 4.1 and 4.2; EV-C02-008 1.7.4, kinds (b) and (c)): every reduction without a standing policy, and every standing policy written or retired, runs with a devos_denetim token.
-- Phase C4a (before any result): the patch no longer swaps kind (a) calls (an item's own policy at the default), which
-- EV-C02-008 1.7.4 refuses to devos_denetim, so that it removes the approval rule and no other; its red list gains the
-- devos_sinav cases of CHK-C02-025 condition C2 (a).
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
declare h text; tok text; r jsonb;
begin
  -- Kinds (b) and (c): a reduction with no standing policy (a level below high), a standing policy (no work_ref), or a
  -- retirement. Kind (a) (an item's own policy at the default, or within its standing policy) is passed on unchanged.
  if p->>'standing_policy_ref' is null
     and (p->>'work_ref' is null or coalesce(p->>'level', 'high') <> 'high' or p->>'status' = 'retired') then
    h := current_setting('request.headers', true);
    execute 'select devos_private.issue_env_token($1)::text' into tok using 'devos_denetim';
    perform set_config('request.headers', json_build_object('x-devos-env-token', tok)::text, true);
    tok := null;
    r := devos_api.set_effort_policy_w07_orig(p);
    perform set_config('request.headers', h, true);
    return r;
  end if;
  return devos_api.set_effort_policy_w07_orig(p);
end $f$;
grant execute on function devos_api.set_effort_policy(jsonb) to anon, authenticated;
commit;
