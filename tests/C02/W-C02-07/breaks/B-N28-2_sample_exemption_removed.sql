-- w07-break: test=w07_n28_sample_exemption.sql; expect-red=S-pos-gate-need,S-pos-gate-decision,S-pos-gate-effort_policy,S-pos-gate-finding,S-pos-routine-work,S-pos-routine-decision
-- Break patch for T-W07-N28 (tests/C02/W-C02-07/T-W07-N28_verifier_does_not_repair.md, "Break attempt"; phase C4a). EV-C02-008
-- 2.5's B-S1: the exemption removed. A trigger that fires before every other on devos_private.review gives each new
-- Review of kind sample a reviewer (reviewer_role_class), so that its condition 4 ("Opened without a reviewer") never
-- holds and DM-41's trigger counts the database's own sample as a review record, as DM-41 did before EV-C02-008 section 2.
-- It does not edit the build's trigger, so it holds none of its logic.
-- Applied ONLY by the break harness on its throwaway PostgreSQL built from supabase/migrations/ (README 5.2; plan Section 8
-- item 3 as PC-42 place 3 writes it), never on devos-test or devos; it sits outside supabase/migrations/, so no job applies it.
-- The names it uses are the interface the specification assumes (revised before a first result if the build differs,
-- README section 8). Synthetic (plan Section 8 item 13): the only value it writes is labelled w07 break. No psql
-- meta-command is used.
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
create function devos_private.w07_break_sample_reviewer() returns trigger language plpgsql as $f$
begin
  if new.kind::text = 'sample' then
    new.reviewer_role_class := 'devos_denetim';  -- the w07 break: the sample is opened with a reviewer
  end if;
  return new;
end $f$;
-- Named to fire first among the table's BEFORE triggers (they fire in name order).
create trigger aaaa_w07_break_sample_reviewer before insert on devos_private.review
  for each row execute function devos_private.w07_break_sample_reviewer();
commit;
