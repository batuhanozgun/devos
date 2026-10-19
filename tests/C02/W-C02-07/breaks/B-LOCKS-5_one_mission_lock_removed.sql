-- w07-break: test=w07_locks_key_and_handover_locks.py; expect-red=LOCKS-mi-one
-- Rule removed: the transaction-level advisory lock 9004 in devos_api.transfer_mission (M09-11:291; EV-C02-013 3.2's
-- one-Mission row and 28 (2)'s order; EV-C02-005 2.1), taken after the key read and before the one-Mission check, so
-- that a second first transfer of another source ID waits for the first and then reads its Mission (S2's index holds
-- one key only, so nothing else orders two first calls of different source IDs).
-- How: the function's definition is read from the catalogue (pg_get_functiondef) and replaced (create or replace, so
-- its signature, owner, grants, security definer and search_path stay) with the one lock statement turned into the
-- no-op null; nothing else of its text changes. The statement is found by the pattern below, which must occur exactly
-- once in the function, or the patch raises and applies nothing (the break is then not shown). The pattern reads only
-- the lock's id and its function's name, not the rest of its arguments, so it fits today's text (M09-11:291) and the
-- corrective migration's, which keeps 9004 where it is (EV-C02-013 28 (2), "9004 and 9001 stay after the key read").
-- Must turn red: LOCKS-mi-one (the second call, made while the first is uncommitted, reads no transferred Mission and
-- is accepted, and inside its transaction two Missions are seen). The other cases stay as in the positive control: the
-- second call is rolled back, so the hand-over cases still find one Mission.
-- Specification: tests/C02/W-C02-07/T-W07-LOCKS_key_and_handover_locks.md ("Break attempt"; part TC-C, 2026-10-19).
-- Synthetic (plan Section 8 item 13): no data. Throwaway database only (README 5.2), never under supabase/migrations/.
-- No psql meta-command. The whole change runs inside the guard's block.
do $b$
declare
  d text;
  n int;
  pat text := 'perform[[:space:]]+pg_catalog[.]pg_advisory_xact_lock[(][[:space:]]*9004[[:space:]]*,[^;]*;';
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
  d := pg_catalog.pg_get_functiondef('devos_api.transfer_mission(jsonb)'::regprocedure);
  select count(*) into n from regexp_matches(d, pat, 'g');
  if n <> 1 then
    raise exception 'w07 break patch refused: the lock statement occurs % times in devos_api.transfer_mission, not once', n;
  end if;
  execute regexp_replace(d, pat, 'null;');
end
$b$;
