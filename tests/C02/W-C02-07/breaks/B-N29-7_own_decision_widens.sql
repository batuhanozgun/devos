-- w07-break: test=w07_n29_mission_widening.sql; expect-red=N29-w-same,N29-w-earlier,N29-w-current
-- Break patch for T-W07-N29 (tests/C02/W-C02-07/T-W07-N29_impact_class.md, "Revision under ledger rule 3 (N-284,
-- 2026-10-19)"). Rule removed: revise_mission's condition 1 of EV-C02-013 22 (1), "the Decision named may not be the
-- owner_authority of any mission_revision of this Mission" (N-284 option C). How: revise_mission(jsonb) is renamed and a
-- wrapper takes its name; when the call names a Decision that is the owner authority of a revision of the Mission it
-- names, the wrapper writes a copy of that Decision (the same class, status, answered revision and answered_at, and a
-- copy of its revision 1, labelled w07 break) and calls the build's function with the copy's id instead, so condition 1
-- never sees the Mission's own Decision; condition 2 (the order of answers) still reads the same answered_at. It holds
-- none of the build's logic.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- Synthetic (plan Section 8 item 13): no data; the copies it writes are labelled w07 break. No psql meta-command is used.
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
declare cp uuid;
begin
  if exists (select 1 from devos_private.mission_revision mr
              where mr.mission_id::text = p->>'id' and mr.owner_authority::text = p->>'owner_authority') then
    insert into devos_private.decision (class, status, answered_revision, answered_at, answered_by, answer_original_tr,
                                        answer_interpretation_en)
    select d.class, d.status, d.answered_revision, d.answered_at, 'w07 break', 'w07 break', 'w07 break'
      from devos_private.decision d where d.id::text = p->>'owner_authority'
    returning id into cp;
    insert into devos_private.decision_revision (decision_id, revision, question)
    values (cp, 1, 'w07 break: a copy of a Mission''s own Decision');
    return devos_api.revise_mission_w07_orig(p || jsonb_build_object('owner_authority', cp));
  end if;
  return devos_api.revise_mission_w07_orig(p);
end $f$;
revoke all on function devos_api.revise_mission(jsonb) from public;
grant execute on function devos_api.revise_mission(jsonb) to anon;
commit;
