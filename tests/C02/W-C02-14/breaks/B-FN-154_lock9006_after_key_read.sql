-- w07-break: test=tests/C02/W-C02-14/job/w14_fn_transfer_functions.sql; expect-red=FN-LO-9006-prepare_operation
-- T-W14-FN break B-FN-154 (tests/C02/W-C02-14/T-W14-FN_transfer_functions.md, "Break attempt"). Rule removed: prepare_operation's key lock 9006 taken before its read of the key's Operation row (EV-C02-018 16 decision 2; EV-C02-013 28 (3)); the statement is moved after that read, so the key read is unlocked. Fragment: this designer's, from the corrective migration's own text (supabase/migrations/20261019180001_w09_transfer_corrections.sql), each checked to occur once in its function there.
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
  src := pg_get_functiondef('devos_api.prepare_operation(text,jsonb)'::regprocedure);
  o := $o$perform pg_catalog.pg_advisory_xact_lock(9006, pg_catalog.hashtext(v_ns || ':' || v_ikey));
    select o.id, o.status::text, o.effect_class, o.target, o.expected_base, o.payload_hash, o.work_ref, o.assignment_ref,
           o.generation, o.authority_epoch, o.read_set
      into v_old_id, v_old_status, v_old_class, v_old_target, v_old_base, v_old_hash, v_old_work, v_old_asg,
           v_old_gen, v_old_epoch, v_old_read
      from devos_private.operation o
     where o.idempotency_namespace = v_ns and o.idempotency_key = v_ikey
       for share;$o$;
  nw := $n$null;  -- w14 break: the key lock is moved below
    select o.id, o.status::text, o.effect_class, o.target, o.expected_base, o.payload_hash, o.work_ref, o.assignment_ref,
           o.generation, o.authority_epoch, o.read_set
      into v_old_id, v_old_status, v_old_class, v_old_target, v_old_base, v_old_hash, v_old_work, v_old_asg,
           v_old_gen, v_old_epoch, v_old_read
      from devos_private.operation o
     where o.idempotency_namespace = v_ns and o.idempotency_key = v_ikey
       for share; perform pg_catalog.pg_advisory_xact_lock(9006, pg_catalog.hashtext(v_ns || ':' || v_ikey));$n$;
  k := (length(src) - length(replace(src, o, ''))) / length(o);
  if k <> 1 then
    raise exception 'w14 break not applied: fragment 1 of devos_api.prepare_operation(text,jsonb) found % times, not once; not a break shown (W-C02-13 point 3)', k;
  end if;
  src := replace(src, o, nw);
  execute src;
end $b$;
commit;
