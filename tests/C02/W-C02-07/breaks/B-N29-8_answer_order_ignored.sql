-- w07-break: test=w07_n29_mission_widening.sql; expect-red=N29-w-before,N29-w-null
-- Break patch for T-W07-N29 (tests/C02/W-C02-07/T-W07-N29_impact_class.md, "Revision under ledger rule 3 (N-284,
-- 2026-10-19)"). Rule removed: revise_mission's condition 2 of EV-C02-013 22 (1), the order of answers (answered_at
-- NULL: could_not_check; earlier than the current revision's created_at: mission_authority). How: revise_mission(jsonb)
-- is renamed and a wrapper takes its name; for the call it sets the named Decision's answered_at to 'infinity', which
-- is never NULL and never earlier than any revision, calls the build's function, and puts the stored value back. It
-- holds none of the build's logic.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- Synthetic (plan Section 8 item 13): no data. No psql meta-command is used.
-- Written under ledger rule 3, 2026-10-19 (N-284; EV-C02-017 1 (e)).
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
alter function devos_api.revise_mission(jsonb) rename to revise_mission_w07_orig;
create function devos_api.revise_mission(p jsonb) returns jsonb language plpgsql security definer
set search_path = pg_catalog as $f$
declare old timestamptz; r jsonb;
begin
  select d.answered_at into old from devos_private.decision d where d.id::text = p->>'owner_authority';
  update devos_private.decision set answered_at = 'infinity' where id::text = p->>'owner_authority';
  r := devos_api.revise_mission_w07_orig(p);
  update devos_private.decision set answered_at = old where id::text = p->>'owner_authority';
  return r;
end $f$;
revoke all on function devos_api.revise_mission(jsonb) from public;
grant execute on function devos_api.revise_mission(jsonb) to anon;
commit;
