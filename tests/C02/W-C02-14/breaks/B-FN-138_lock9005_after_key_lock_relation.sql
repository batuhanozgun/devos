-- w07-break: test=tests/C02/W-C02-14/job/w14_fn_transfer_functions.sql; expect-red=FN-LO-9005-transfer_relation
-- T-W14-FN break B-FN-138 (tests/C02/W-C02-14/T-W14-FN_transfer_functions.md, "Break attempt"). Rule removed: transfer_relation's shared hand-over lock 9005 taken first, before its read of the ledger_handed_over event and before its key lock 9007 (EV-C02-018 16 decision 5; EV-C02-013 28 (2), (4)); the statement is moved after the 9007 statement, so the hand-over read is outside 9005 (the form of CHK-C02-112's x3, there in transfer_review). Fragment: this designer's, from the corrective migration's own text (supabase/migrations/20261019180001_w09_transfer_corrections.sql), each checked to occur once in its function there.
-- Added 2026-10-19 under ledger rule 3 (note N-308 on plan/work/C02.md; CHK-C02-112 finding 9), after the corrective
-- migration was merged. Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness
-- (tests/C02/W-C02-07/harness/) on a throwaway PostgreSQL built from supabase/migrations/, never on devos-test or devos; it
-- sits outside supabase/migrations/, so the migration job never applies it. Synthetic (plan Section 8 item 13): no data, no
-- token in the file. No psql meta-command. It changes the build's own function text: pg_get_functiondef's text, with each
-- fragment below replaced in turn (each must occur exactly once, else the patch raises and the break is not applied), is
-- executed again. The lock statement is moved, not removed: in one session the function answers as before, so only the
-- case that reads where the lock stands turns red. If the migration's function no longer has this text, the harness
-- reports the break "not shown", and the test designer revises the patch before a result (W-C02-07's README section 8).
begin;  -- the guard and the change in one transaction: a refused guard aborts the whole patch
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w14 break patch refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w14 break patch refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
do $b$
declare src text; o text; nw text; k int;
begin
  src := pg_get_functiondef('devos_api.transfer_relation(jsonb)'::regprocedure);
  o := $o$perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);$o$;
  nw := $n$null;  -- w14 break: the hand-over lock is moved below$n$;
  k := (length(src) - length(replace(src, o, ''))) / length(o);
  if k <> 1 then
    raise exception 'w14 break not applied: fragment 1 of devos_api.transfer_relation(jsonb) found % times, not once; not a break shown (W-C02-13 point 3)', k;
  end if;
  src := replace(src, o, nw);
  o := $o$perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext('relation' || ':' || v_sid));$o$;
  nw := $n$perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext('relation' || ':' || v_sid)); perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);$n$;
  k := (length(src) - length(replace(src, o, ''))) / length(o);
  if k <> 1 then
    raise exception 'w14 break not applied: fragment 2 of devos_api.transfer_relation(jsonb) found % times, not once; not a break shown (W-C02-13 point 3)', k;
  end if;
  src := replace(src, o, nw);
  execute src;
end $b$;
commit;
