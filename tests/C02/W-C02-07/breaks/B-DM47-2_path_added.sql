-- w07-break: test=w07_dm47_merge_gate_list.py; expect-red=DM47-cmp,DM47-gate
-- Break patch for T-W07-DM47 (tests/C02/W-C02-07/T-W07-DM47_*.md, "Break attempt"). Rule removed: the copy's equality with plan 6.7's list (DM-47): a path not on the list is added (the merge gate classes it normal, so DM47-gate turns red too).
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
insert into devos_private.high_impact_path (path) values ('docs/');
commit;
