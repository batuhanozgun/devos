-- w07-break: test=w07_n02_decision_alternatives.sql; expect-red=N02-oe-answer-hi,N02-oe-accept-hi,N02-oe-answer-batu,N02-oe-accept-batu,N02-oe-transfer-decision,N02-oe-transfer-accept
-- Break patch for T-W07-N02 (tests/C02/W-C02-07/T-W07-N02_*.md, "Break attempt"). Rule removed: the rule that a decision in open_exploration cannot be answered or accepted (B 3.17; DM-46): its trigger or check is disabled.
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
do $d$
declare t record; c record; n int := 0;
begin
  for t in select tg.tgname from pg_trigger tg join pg_proc p on p.oid = tg.tgfoid
            where tg.tgrelid = 'devos_private.decision'::regclass and not tg.tgisinternal and p.prosrc ilike '%open_exploration%' loop
    execute format('alter table devos_private.decision disable trigger %I', t.tgname); n := n + 1;
  end loop;
  for c in select conname from pg_constraint where conrelid = 'devos_private.decision'::regclass and contype = 'c'
            and pg_get_constraintdef(oid) ilike '%open_exploration%' loop
    execute format('alter table devos_private.decision drop constraint %I', c.conname); n := n + 1;
  end loop;
  if n = 0 then raise exception 'w07 break: no trigger or constraint on devos_private.decision holds the rule (revise the patch)'; end if;
end $d$;
commit;
