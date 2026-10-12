-- w07-break: test=tests/C02/W-C02-07/harness/scenarios/n01_open_block.sql; expect-red=N01-unseen-cal,N01-unseen-kur,N01-unseen-routine-decision,N01-unseen-routine-work,N01-unseen-sin
-- Break patch for T-W07-N01 part B (phase C4b; EV-C02-008 5.2's table, B-N01-6, CHK-C02-028 C1: "a relation that names the
-- open sample (the sampling path writes a reviews relation between the sample and its target ...)"). Rule removed: 5.2
-- (b) ("No other function writes such a relation either: not the sampling path"). A trigger on the Review table writes,
-- for each row of kind sample, a reviews relation from the sample to its target. The insert names Relation's columns as
-- README 8.1 assumes them; the prober adapts it. devos_ci is refused the walks at the gate, so its case stays green.
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
create function devos_private.w07_break_sample_relation() returns trigger language plpgsql security definer
set search_path = pg_catalog as $f$
begin
  if new.kind::text = 'sample' then
    insert into devos_private.relation (type, from_ref, to_ref, hard) values ('reviews', new.id, new.target_ref::uuid, false);
  end if;
  return new;
end $f$;
create trigger w07_break_sample_relation after insert on devos_private.review for each row
  execute function devos_private.w07_break_sample_relation();
commit;
