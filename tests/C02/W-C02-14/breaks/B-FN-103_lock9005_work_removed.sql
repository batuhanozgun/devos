-- w07-break: test=tests/C02/W-C02-14/job/w14_fn_transfer_functions.sql; expect-red=FN-LK-9005-transfer_work
-- T-W14-FN break B-FN-103 (tests/C02/W-C02-14/T-W14-FN_transfer_functions.md, "Break attempt"). Rule removed: transfer_work's shared hand-over lock 9005 (EV-C02-018 16 decision 5; EV-C02-013 28 (4)); the lock call is replaced by pg_sleep(0). Fragment: this designer's, from the decided form (EV-C02-013 section 28).
-- Added 2026-10-19 under ledger rule 3 (EV-C02-018 section 16; EV-C02-013 section 28; test round 2, part TC-B), before the
-- corrective migration exists. Plan Section 8 item 3 (PC-42): applied ONLY by W-C02-07's break harness
-- (tests/C02/W-C02-07/harness/) on a throwaway PostgreSQL built from supabase/migrations/, never on devos-test or devos; it
-- sits outside supabase/migrations/, so the migration job never applies it. Synthetic (plan Section 8 item 13): no data, no
-- token in the file. No psql meta-command. It changes the build's own function text: pg_get_functiondef's text, with the
-- fragment below replaced (it must occur exactly once, else the patch raises and the break is not applied), is executed
-- again. The fragment is that of the decided form EV-C02-013 section 28 states, as this round's labelled stand-in writes
-- it; if the corrective migration's function does not have this form, the harness reports the break "not shown", and the
-- test designer revises the patch before that migration's first result (W-C02-07's README section 8).
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
  src := pg_get_functiondef('devos_api.transfer_work(jsonb)'::regprocedure);
  o := $o$pg_catalog.pg_advisory_xact_lock_shared(9005, 0)$o$;
  nw := $n$pg_catalog.pg_sleep(0)$n$;
  k := (length(src) - length(replace(src, o, ''))) / length(o);
  if k <> 1 then
    raise exception 'w14 break not applied: fragment 1 of devos_api.transfer_work(jsonb) found % times, not once; not a break shown (W-C02-13 point 3)', k;
  end if;
  src := replace(src, o, nw);
  execute src;
end $b$;
commit;
