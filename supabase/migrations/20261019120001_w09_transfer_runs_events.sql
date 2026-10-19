-- DevOS schema (W-C02-09), not a fixture. M09-10: the ledger transfer's runs and events.
-- Sources: plan/work/W-C02-09.md points 1, 2, 3, 5, 7 and 10; Appendix B principles 1, 2, 3 and 8, section 2 (the
-- devos_kurulum row), 3.10, 3.13 ("The ledger transfer's events") and section 4 (the row "Ledger transfer");
-- evidence/C02/EV-C02-005_ledger_transfer.md sections 2.5, 3.1, 3.2, 3.4, 12 and 15 (S1, S2, S5);
-- evidence/C02/EV-C02-008_design_addendum_roles_and_samples.md 1.7.1 and 1.7.3; evidence/C02/EV-C02-013_w09_interface.md
-- sections 1 (items 1 to 14), 3.1, 3.2, 10, 14 (R2-9) and 25 (C-M10). Record: evidence/C02/EV-C02-014_w09_build.md
-- section 12.
-- It holds exactly section 10's row M09-10, six of the ledger transfer's fourteen functions: devos_api.begin_transfer_run,
-- end_transfer_run, record_handover, transfer_event, record_ledger_entry and transfer_artifact. It adds no table, type
-- or private function, and changes nothing of M09-01 to M09-09 or of the rule corrections (20261019080001), whose
-- helpers it calls: caller_role_class, write_event, reject and is_installation_mission. No token, hash or key value is
-- written here. None of the six takes a claim token or counts a claim.
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12).
--
-- The common form is M09-03's to M09-09's (EV-C02-013 section 1 items 6, 7, 9 and 10, R1-1): (a) the derivation,
-- before any other check; then a read block holding (b) the role list, the literal array['devos_kurulum'] of the
-- function's own text (B:48; B section 4: "Only devos_kurulum"), (c) the input's form, (d) ownership where the group
-- has it (record_ledger_entry) and (f) the group's rules, writing nothing (its row locks and its transaction-level
-- advisory locks stay with the transaction); then a write block holding (g) the writes and their events through
-- devos_private.write_event, with the caller's role class and origin call. A check that decides a refusal sets v_code
-- and v_reason and raises P0D01; any other error in the read block is could_not_check, "<v_check>: its input could not
-- be read (SQLSTATE <code>)"; any error in the write block is write_failed (S2's index event_transferred_key and S1's
-- one-hand-over index among them), but P0D02, which is could_not_check with its fixed reason. After either block's
-- refusal one per-call RejectedAttempt row is written by devos_private.reject. A reason holds fixed text and an SQLSTATE
-- only. Keys a function does not read are ignored (item 4); declared_session_id goes to the events and the refusal
-- rows only (item 5). Each function takes p jsonb (EV-C02-013 section 3) and reads it through ALIAS FOR $1 (N-288).
--
-- The group's rules built here (EV-C02-013 3.1 and 3.2):
-- * Closing (B:397): with a ledger_handed_over event present, begin_transfer_run, end_transfer_run, record_handover and
--   transfer_event refuse handed_over; transfer_artifact refuses it but for a git_tree or a git_file whose path is a
--   check's verdict file; record_ledger_entry is not closed. The closing check comes before the exact repeat: B:397
--   refuses every call of a closed function after the event, which is why record_handover's second call is refused
--   (R2-9, section 1 item 10).
-- * The key (S2; 3.1): a transferred event of the same transfer_source kind and source_id with the same sha256 is the
--   exact repeat, answered ok with the existing id and "repeat": true, nothing written; another sha256 is conflict.
--   It is read in the read block, before the run rule (R2-9: the repeat comes before a check the first call's own
--   write would now fail); S2's index is the backstop in the write block.
-- * The run (3.1, R1-8): before the hand-over transfer_event and transfer_artifact name an open run (a transfer_run
--   event of phase begun and none of phase completed for its run_id), else run_not_open; after it, transfer_artifact
--   names no run, and a run_id present is run_not_open whatever the run's state. Its transferred event then records
--   "run_id": null and "after_handover": true.
-- * Order (3.1; EV-C02-005 3.2): a record a call references that is not written is reference_missing (transfer_event's
--   aggregate; record_handover's run and the installation's Mission).
-- * A run's own key: begin_transfer_run and end_transfer_run take one transaction-level advisory lock on the run_id
--   (key 9002, hashtext), so that two calls of one run cannot both write; record_ledger_entry takes one on the entry ID
--   (key 9003; 3.2's row). M09-02's hard-dependency lock is 9001.

-- begin_transfer_run (EV-C02-013 3.2; README 8.1; EV-C02-005 3.2 and S1): one transfer_run event, phase begun, on
-- aggregate transfer_run with a new uuid, its payload the six keys as sent. Payload: run_id (a non-empty string),
-- input_commit (40 lower-case hexadecimal characters), manifest_sha256 (64), counts (an object of non-negative
-- integers), phase (begun), mode (ahead, full or verdict_copies), all required. Order after the gate: the form; the
-- closing rule (handed_over); the run's advisory lock; a run of the same run_id already begun: the same input commit,
-- manifest, counts and mode is the exact repeat (a resume, EV-C02-005 3.2), anything else conflict; a transfer_run event
-- of the run without its phase, or a begun one without one of the four, is could_not_check. Answer {"status": "ok",
-- "id"}, the run's aggregate.
create function devos_api.begin_transfer_run(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'begin_transfer_run';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_run text;
  v_input text;
  v_manifest text;
  v_counts jsonb;
  v_mode text;
  v_payload jsonb;
  v_partial bigint;
  v_prev_agg uuid;
  v_prev jsonb;
  v_id uuid;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;
  if jsonb_typeof(p_in -> 'declared_session_id') = 'string' then
    v_decl := p_in ->> 'declared_session_id';
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'begin_transfer_run admits only the role class devos_kurulum (B section 4, the ledger transfer)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (c) The form.
    v_check := 'input';
    if p_in is null then
      v_code := 'missing_field'; v_reason := 'p: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in) <> 'object' then
      v_code := 'invalid_field'; v_reason := 'p: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'run_id'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'run_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'run_id') <> 'string' or btrim(p_in ->> 'run_id') = '' then
      v_code := 'invalid_field'; v_reason := 'run_id: not a non-empty string';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_run := p_in ->> 'run_id';
    if coalesce(jsonb_typeof(p_in -> 'input_commit'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'input_commit: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'input_commit') <> 'string' or (p_in ->> 'input_commit') !~ '^[0-9a-f]{40}$' then
      v_code := 'invalid_field'; v_reason := 'input_commit: not 40 lower-case hexadecimal characters';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_input := p_in ->> 'input_commit';
    if coalesce(jsonb_typeof(p_in -> 'manifest_sha256'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'manifest_sha256: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'manifest_sha256') <> 'string' or (p_in ->> 'manifest_sha256') !~ '^[0-9a-f]{64}$' then
      v_code := 'invalid_field'; v_reason := 'manifest_sha256: not 64 lower-case hexadecimal characters';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_manifest := p_in ->> 'manifest_sha256';
    if coalesce(jsonb_typeof(p_in -> 'counts'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'counts: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'counts') <> 'object'
       or exists (select 1 from pg_catalog.jsonb_each(p_in -> 'counts') c
                   where jsonb_typeof(c.value) <> 'number' or c.value::text !~ '^[0-9]{1,18}$') then
      v_code := 'invalid_field'; v_reason := 'counts: not an object of non-negative integers';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_counts := p_in -> 'counts';
    if coalesce(jsonb_typeof(p_in -> 'phase'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'phase: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'phase') <> 'string' or (p_in ->> 'phase') <> 'begun' then
      v_code := 'invalid_field'; v_reason := 'phase: not begun';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'mode'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'mode: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'mode') <> 'string' or (p_in ->> 'mode') not in ('ahead', 'full', 'verdict_copies') then
      v_code := 'invalid_field'; v_reason := 'mode: not ahead, full or verdict_copies';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_mode := p_in ->> 'mode';
    v_payload := jsonb_build_object('run_id', v_run, 'input_commit', v_input, 'manifest_sha256', v_manifest,
                                    'counts', v_counts, 'phase', 'begun', 'mode', v_mode);

    -- (f) The closing rule (B:397: begin_transfer_run refuses after the hand-over).
    v_check := 'handover';
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'begin_transfer_run: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The run's own key: the same run_id with the same manifest is the resume, another is conflict (3.2's row).
    v_check := 'run';
    perform pg_catalog.pg_advisory_xact_lock(9002, pg_catalog.hashtext(v_run));
    select count(*) filter (where coalesce(e.payload ->> 'phase', '') not in ('begun', 'completed')) into v_partial
      from devos_private.event e where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run;
    if v_partial > 0 then
      v_code := 'could_not_check'; v_reason := 'run: a transfer_run event of the run lacks its phase (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select e.aggregate_id, e.payload into v_prev_agg, v_prev
      from devos_private.event e
     where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
     order by e.id limit 1;
    if v_prev_agg is not null then
      if v_prev ->> 'input_commit' is null or v_prev ->> 'manifest_sha256' is null or v_prev -> 'counts' is null
         or v_prev ->> 'mode' is null then
        v_code := 'could_not_check';
        v_reason := 'run: the begun event of the run lacks its input commit, manifest, counts or mode (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if not (v_prev ->> 'input_commit' = v_input and v_prev ->> 'manifest_sha256' = v_manifest
              and v_prev -> 'counts' = v_counts and v_prev ->> 'mode' = v_mode) then
        v_code := 'conflict';
        v_reason := 'run_id: a run of this id is begun with another input commit, manifest, counts or mode';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl);
  end if;
  if v_prev_agg is not null then
    return jsonb_build_object('status', 'ok', 'id', v_prev_agg, 'repeat', true);
  end if;

  -- The write block: step (g). The run's begun event on its own new aggregate.
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    perform devos_private.write_event('transfer_run', v_id, null, 'transfer_run', v_payload, v_class::text, 'call', v_decl);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id);
end
$fn$;

-- end_transfer_run (EV-C02-013 3.2 with R2-9; EV-C02-005 3.2): one transfer_run event, phase completed, on the run's
-- aggregate (the begun event's). Payload: run_id, counts (an object of non-negative integers, per kind written), phase
-- (completed), all required. Order after the gate: the form; the closing rule (handed_over); the run's advisory lock;
-- the run's events (one without its phase: could_not_check); the exact repeat first (R2-9): the run already completed
-- with the same counts is ok with its id and "repeat": true; completed with other counts, or never begun: run_not_open.
-- Answer {"status": "ok", "id"}, the run's aggregate.
create function devos_api.end_transfer_run(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'end_transfer_run';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_run text;
  v_counts jsonb;
  v_partial bigint;
  v_agg uuid;
  v_done bigint;
  v_same bigint;
  v_repeat boolean := false;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;
  if jsonb_typeof(p_in -> 'declared_session_id') = 'string' then
    v_decl := p_in ->> 'declared_session_id';
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'end_transfer_run admits only the role class devos_kurulum (B section 4, the ledger transfer)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (c) The form.
    v_check := 'input';
    if p_in is null then
      v_code := 'missing_field'; v_reason := 'p: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in) <> 'object' then
      v_code := 'invalid_field'; v_reason := 'p: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'run_id'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'run_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'run_id') <> 'string' or btrim(p_in ->> 'run_id') = '' then
      v_code := 'invalid_field'; v_reason := 'run_id: not a non-empty string';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_run := p_in ->> 'run_id';
    if coalesce(jsonb_typeof(p_in -> 'counts'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'counts: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'counts') <> 'object'
       or exists (select 1 from pg_catalog.jsonb_each(p_in -> 'counts') c
                   where jsonb_typeof(c.value) <> 'number' or c.value::text !~ '^[0-9]{1,18}$') then
      v_code := 'invalid_field'; v_reason := 'counts: not an object of non-negative integers';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_counts := p_in -> 'counts';
    if coalesce(jsonb_typeof(p_in -> 'phase'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'phase: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'phase') <> 'string' or (p_in ->> 'phase') <> 'completed' then
      v_code := 'invalid_field'; v_reason := 'phase: not completed';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The closing rule (B:397).
    v_check := 'handover';
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'end_transfer_run: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The run: begun, not completed. The exact repeat is judged first (R2-9).
    v_check := 'run';
    perform pg_catalog.pg_advisory_xact_lock(9002, pg_catalog.hashtext(v_run));
    select count(*) filter (where coalesce(e.payload ->> 'phase', '') not in ('begun', 'completed')),
           count(*) filter (where e.payload ->> 'phase' = 'completed'),
           count(*) filter (where e.payload ->> 'phase' = 'completed' and e.payload -> 'counts' = v_counts)
      into v_partial, v_done, v_same
      from devos_private.event e where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run;
    if v_partial > 0 then
      v_code := 'could_not_check'; v_reason := 'run: a transfer_run event of the run lacks its phase (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select e.aggregate_id into v_agg
      from devos_private.event e
     where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
     order by e.id limit 1;
    if v_agg is null then
      v_code := 'run_not_open'; v_reason := 'run_id: names no run begun (EV-C02-013 3.1)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_done > 0 then
      if v_same > 0 then
        v_repeat := true;
      else
        v_code := 'run_not_open'; v_reason := 'run_id: the run is completed, with other counts (EV-C02-013 3.1)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl);
  end if;
  if v_repeat then
    return jsonb_build_object('status', 'ok', 'id', v_agg, 'repeat', true);
  end if;

  -- The write block: step (g). The run's completed event on its aggregate.
  begin
    v_check := 'write';
    perform devos_private.write_event('transfer_run', v_agg, null, 'transfer_run',
      jsonb_build_object('run_id', v_run, 'counts', v_counts, 'phase', 'completed'), v_class::text, 'call', v_decl);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_agg);
end
$fn$;

-- record_handover (EV-C02-013 3.2 with R1-8 and R2-9; EV-C02-005 3.4 and S1): the one ledger_handed_over event, on the
-- installation's Mission at its current revision, payload {run_id, input_commit, mark_commit, handed_over_sha256}.
-- Payload: run_id (a run begun), input_commit and mark_commit (40 lower-case hexadecimal characters), handed_over_sha256
-- (64), all required. Order after the gate: the form; the closing rule (handed_over: S1's index allows one, and a second
-- identical call comes after the hand-over its first recorded, so no exact repeat answers ok); the run (a transfer_run
-- event of the run without its phase: could_not_check; none begun: reference_missing; begun is enough, completed or
-- not, R1-8); the installation's Mission, the one Mission whose creation event is transferred (EV-C02-013 section 4):
-- none, reference_missing; two, or a Mission's creation event whose type is NULL, could_not_check (as M09-02's
-- is_installation_mission reads it); its row and current revision, locked for share (missing: could_not_check). Answer
-- {"status": "ok", "id"}, the Mission.
create function devos_api.record_handover(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'record_handover';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_run text;
  v_partial bigint;
  v_begun bigint;
  v_tr bigint;
  v_null bigint;
  v_mission uuid;
  v_mrev integer;
  v_inst boolean;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;
  if jsonb_typeof(p_in -> 'declared_session_id') = 'string' then
    v_decl := p_in ->> 'declared_session_id';
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'record_handover admits only the role class devos_kurulum (B section 4, the ledger transfer)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (c) The form.
    v_check := 'input';
    if p_in is null then
      v_code := 'missing_field'; v_reason := 'p: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in) <> 'object' then
      v_code := 'invalid_field'; v_reason := 'p: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'run_id'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'run_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'run_id') <> 'string' or btrim(p_in ->> 'run_id') = '' then
      v_code := 'invalid_field'; v_reason := 'run_id: not a non-empty string';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_run := p_in ->> 'run_id';
    foreach v_key in array array['input_commit', 'mark_commit', 'handed_over_sha256'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string'
         or (p_in ->> v_key) !~ (case when v_key = 'handed_over_sha256' then '^[0-9a-f]{64}$' else '^[0-9a-f]{40}$' end) then
        v_code := 'invalid_field';
        v_reason := v_key || ': not ' || case when v_key = 'handed_over_sha256' then '64' else '40' end
                    || ' lower-case hexadecimal characters';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;

    -- (f) The closing rule: one hand-over (S1), and after it B:397 refuses this function too.
    v_check := 'handover';
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'record_handover: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The run: begun (R1-8: record_handover needs only a begun run).
    v_check := 'run';
    select count(*) filter (where coalesce(e.payload ->> 'phase', '') not in ('begun', 'completed')),
           count(*) filter (where e.payload ->> 'phase' = 'begun')
      into v_partial, v_begun
      from devos_private.event e where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run;
    if v_partial > 0 then
      v_code := 'could_not_check'; v_reason := 'run: a transfer_run event of the run lacks its phase (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_begun = 0 then
      v_code := 'reference_missing'; v_reason := 'run_id: names no run begun (EV-C02-013 3.2)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The installation's Mission: the one Mission whose creation event (its first event) is transferred.
    v_check := 'installation_mission';
    select count(*) filter (where f.event_type = 'transferred'), count(*) filter (where f.event_type is null)
      into v_tr, v_null
      from (select distinct on (e.aggregate_id) e.aggregate_id, e.event_type
              from devos_private.event e where e.aggregate_type = 'mission'
             order by e.aggregate_id, e.id) f;
    if v_null > 0 or v_tr > 1 then
      v_code := 'could_not_check';
      v_reason := 'installation_mission: which Mission is the installation''s cannot be told (missing or partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_tr = 0 then
      v_code := 'reference_missing';
      v_reason := 'installation_mission: no Mission''s creation event is transferred (EV-C02-013 3.2)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select f.aggregate_id into v_mission
      from (select distinct on (e.aggregate_id) e.aggregate_id, e.event_type
              from devos_private.event e where e.aggregate_type = 'mission'
             order by e.aggregate_id, e.id) f
     where f.event_type = 'transferred';
    v_inst := devos_private.is_installation_mission(v_mission);
    if v_inst is null or not v_inst then
      v_code := 'could_not_check';
      v_reason := 'installation_mission: which Mission is the installation''s cannot be told (missing or partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    perform 1 from devos_private.mission m where m.id = v_mission for share;
    if not found then
      v_code := 'could_not_check'; v_reason := 'installation_mission: the Mission''s record is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select max(r.revision) into v_mrev from devos_private.mission_revision r where r.mission_id = v_mission;
    if v_mrev is null then
      v_code := 'could_not_check'; v_reason := 'installation_mission: the Mission''s current revision is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl);
  end if;

  -- The write block: step (g). The hand-over; S1's index event_one_ledger_handover is its backstop.
  begin
    v_check := 'write';
    perform devos_private.write_event('mission', v_mission, v_mrev, 'ledger_handed_over',
      jsonb_build_object('run_id', v_run, 'input_commit', p_in ->> 'input_commit', 'mark_commit', p_in ->> 'mark_commit',
                         'handed_over_sha256', p_in ->> 'handed_over_sha256'),
      v_class::text, 'call', v_decl);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_mission, v_mrev);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_mission);
end
$fn$;

-- transfer_event (EV-C02-013 3.1 and 3.2; EV-C02-005 2.3, 2.5 and 3.1; B 3.13): the event of one of the six event
-- kinds on the record it concerns, payload {text} (and, for ledger_entry, entry_id, entry_date and the parsed lines
-- disciplines, guard, record_changes and wait, each when sent), and on the same aggregate its transferred event, payload
-- {transfer_source, run_id, lacks: [], event_id: the written event's id} (and declared, source_fields when sent).
-- Payload: run_id (an open run), transfer_source (S1's six strings; kind one of ledger_entry, note_line, record_line,
-- usage_reading, batu_step, ledger_state_row), event_type (equal to the kind), aggregate_type (need for note_line,
-- mission for ledger_state_row, work for the other four), aggregate_id (a uuid), text (a string), all required;
-- aggregate_revision (an integer of at least 1, a revision the record has; a Need has none); for ledger_entry entry_id
-- (a non-empty string) and entry_date (a date, YYYY-MM-DD) required; declared and source_fields (objects). Order after
-- the gate: the form; the closing rule (handed_over); the key (repeat or conflict); the run (run_not_open); the
-- aggregate, locked for share: one that names no record of its family, or a revision it does not have, is
-- reference_missing (3.1, "Order"); for ledger_state_row a Mission that is not the installation's is invalid_field,
-- one that cannot be told could_not_check. Answer {"status": "ok", "id"}, the written event's id.
create function devos_api.transfer_event(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'transfer_event';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_src jsonb;
  v_kind text;
  v_sid text;
  v_sha text;
  v_run text;
  v_agg_type text;
  v_agg uuid;
  v_agg_rev integer;
  v_declared jsonb;
  v_fields jsonb;
  v_body jsonb;
  v_found boolean;
  v_prev_sha text;
  v_prev_ev jsonb;
  v_partial bigint;
  v_begun bigint;
  v_done bigint;
  v_inst boolean;
  v_date date;
  v_ev bigint;
  v_mark jsonb;
  v_repeat boolean := false;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;
  if jsonb_typeof(p_in -> 'declared_session_id') = 'string' then
    v_decl := p_in ->> 'declared_session_id';
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'transfer_event admits only the role class devos_kurulum (B section 4, the ledger transfer)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (c) The form.
    v_check := 'input';
    if p_in is null then
      v_code := 'missing_field'; v_reason := 'p: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in) <> 'object' then
      v_code := 'invalid_field'; v_reason := 'p: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'run_id'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'run_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'run_id') <> 'string' or btrim(p_in ->> 'run_id') = '' then
      v_code := 'invalid_field'; v_reason := 'run_id: not a non-empty string';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_run := p_in ->> 'run_id';
    -- S1's transfer_source.
    if coalesce(jsonb_typeof(p_in -> 'transfer_source'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'transfer_source: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'transfer_source') <> 'object' then
      v_code := 'invalid_field'; v_reason := 'transfer_source: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    foreach v_key in array array['kind', 'source_id', 'path', 'input_commit', 'last_commit', 'sha256'] loop
      if coalesce(jsonb_typeof(p_in -> 'transfer_source' -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := 'transfer_source.' || v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> 'transfer_source' -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := 'transfer_source.' || v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    v_kind := p_in -> 'transfer_source' ->> 'kind';
    v_sid := p_in -> 'transfer_source' ->> 'source_id';
    v_sha := p_in -> 'transfer_source' ->> 'sha256';
    if v_kind not in ('ledger_entry', 'note_line', 'record_line', 'usage_reading', 'batu_step', 'ledger_state_row') then
      v_code := 'invalid_field'; v_reason := 'transfer_source.kind: not one of the six event kinds (EV-C02-013 3.1)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if btrim(v_sid) = '' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.source_id: empty';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p_in -> 'transfer_source' ->> 'input_commit') !~ '^[0-9a-f]{40}$'
       or (p_in -> 'transfer_source' ->> 'last_commit') !~ '^[0-9a-f]{40}$' then
      v_code := 'invalid_field';
      v_reason := 'transfer_source: input_commit or last_commit not 40 lower-case hexadecimal characters';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_sha !~ '^[0-9a-f]{64}$' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.sha256: not 64 lower-case hexadecimal characters';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_src := jsonb_build_object('kind', v_kind, 'source_id', v_sid, 'path', p_in -> 'transfer_source' ->> 'path',
                                'input_commit', p_in -> 'transfer_source' ->> 'input_commit',
                                'last_commit', p_in -> 'transfer_source' ->> 'last_commit', 'sha256', v_sha);
    -- The event's type, and the record it concerns.
    if coalesce(jsonb_typeof(p_in -> 'event_type'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'event_type: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'event_type') <> 'string'
       or (p_in ->> 'event_type') not in ('ledger_entry', 'note_line', 'record_line', 'usage_reading', 'batu_step',
                                          'ledger_state_row') then
      v_code := 'invalid_field'; v_reason := 'event_type: not one of the six event kinds (EV-C02-013 3.2)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p_in ->> 'event_type') <> v_kind then
      v_code := 'invalid_field'; v_reason := 'event_type: not the kind of transfer_source (EV-C02-013 3.2)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'aggregate_type'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'aggregate_type: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_agg_type := case v_kind when 'note_line' then 'need' when 'ledger_state_row' then 'mission' else 'work' end;
    if jsonb_typeof(p_in -> 'aggregate_type') <> 'string' or (p_in ->> 'aggregate_type') <> v_agg_type then
      v_code := 'invalid_field';
      v_reason := 'aggregate_type: not the family a ' || v_kind || ' event concerns (' || v_agg_type || '; EV-C02-013 3.2)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'aggregate_id'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'aggregate_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'aggregate_id') <> 'string'
       or (p_in ->> 'aggregate_id') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'aggregate_id: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_agg := (p_in ->> 'aggregate_id')::uuid;
    if coalesce(jsonb_typeof(p_in -> 'aggregate_revision'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'aggregate_revision') <> 'number' or (p_in ->> 'aggregate_revision') !~ '^[1-9][0-9]{0,8}$' then
        v_code := 'invalid_field'; v_reason := 'aggregate_revision: not an integer of at least 1';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_agg_type = 'need' then
        v_code := 'invalid_field'; v_reason := 'aggregate_revision: a Need has no revisions';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_agg_rev := (p_in ->> 'aggregate_revision')::integer;
    end if;
    if coalesce(jsonb_typeof(p_in -> 'text'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'text: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'text') <> 'string' then
      v_code := 'invalid_field'; v_reason := 'text: not a string';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_body := jsonb_build_object('text', p_in ->> 'text');
    if v_kind = 'ledger_entry' then
      if coalesce(jsonb_typeof(p_in -> 'entry_id'), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := 'entry_id: missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> 'entry_id') <> 'string' or btrim(p_in ->> 'entry_id') = '' then
        v_code := 'invalid_field'; v_reason := 'entry_id: not a non-empty string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if coalesce(jsonb_typeof(p_in -> 'entry_date'), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := 'entry_date: missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> 'entry_date') <> 'string' or (p_in ->> 'entry_date') !~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' then
        v_code := 'invalid_field'; v_reason := 'entry_date: not a date (YYYY-MM-DD)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      begin
        v_date := (p_in ->> 'entry_date')::date;
      exception when others then
        v_code := 'invalid_field'; v_reason := 'entry_date: not a date (YYYY-MM-DD)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end;
      v_body := v_body || jsonb_build_object('entry_id', p_in ->> 'entry_id', 'entry_date', p_in ->> 'entry_date');
      foreach v_key in array array['disciplines', 'guard', 'record_changes', 'wait'] loop
        if coalesce(jsonb_typeof(p_in -> v_key), 'null') <> 'null' then
          v_body := v_body || jsonb_build_object(v_key, p_in -> v_key);
        end if;
      end loop;
    end if;
    if coalesce(jsonb_typeof(p_in -> 'declared'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'declared') <> 'object' then
        v_code := 'invalid_field'; v_reason := 'declared: not a JSON object';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_declared := p_in -> 'declared';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'source_fields'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'source_fields') <> 'object' then
        v_code := 'invalid_field'; v_reason := 'source_fields: not a JSON object';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_fields := p_in -> 'source_fields';
    end if;

    -- (f) The closing rule (B:397).
    v_check := 'handover';
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_event: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
    select e.payload -> 'transfer_source' ->> 'sha256', e.payload -> 'event_id' into v_prev_sha, v_prev_ev
      from devos_private.event e
     where e.event_type = 'transferred' and (e.payload -> 'transfer_source' ->> 'kind') = v_kind
       and (e.payload -> 'transfer_source' ->> 'source_id') = v_sid
     order by e.id limit 1;
    v_repeat := found;
    if v_repeat then
      if v_prev_sha is null or jsonb_typeof(v_prev_ev) is distinct from 'number' then
        v_code := 'could_not_check'; v_reason := 'key: the earlier transferred event lacks its sha256 or event_id (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_prev_sha <> v_sha then
        v_code := 'conflict';
        v_reason := 'transfer_source: this source is already transferred with another sha256 (EV-C02-013 3.1)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end if;

    if not v_repeat then
      -- The run (3.1): open.
      v_check := 'run';
      select count(*) filter (where coalesce(e.payload ->> 'phase', '') not in ('begun', 'completed')),
             count(*) filter (where e.payload ->> 'phase' = 'begun'),
             count(*) filter (where e.payload ->> 'phase' = 'completed')
        into v_partial, v_begun, v_done
        from devos_private.event e where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run;
      if v_partial > 0 then
        v_code := 'could_not_check'; v_reason := 'run: a transfer_run event of the run lacks its phase (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_begun = 0 or v_done > 0 then
        v_code := 'run_not_open';
        v_reason := 'run_id: names no open run (' || case when v_begun = 0 then 'never begun' else 'completed' end
                    || '; EV-C02-013 3.1)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- The record the event concerns (3.1, "Order"), locked for share.
      v_check := 'aggregate';
      if v_agg_type = 'need' then
        perform 1 from devos_private.need n where n.id = v_agg for share;
        v_found := found;
      elsif v_agg_type = 'work' then
        perform 1 from devos_private.work w where w.id = v_agg for share;
        v_found := found;
        if v_found and v_agg_rev is not null then
          select exists (select 1 from devos_private.work_revision r where r.work_id = v_agg and r.revision = v_agg_rev)
            into v_found;
        end if;
      else
        perform 1 from devos_private.mission m where m.id = v_agg for share;
        v_found := found;
        if v_found and v_agg_rev is not null then
          select exists (select 1 from devos_private.mission_revision r where r.mission_id = v_agg and r.revision = v_agg_rev)
            into v_found;
        end if;
      end if;
      if not v_found then
        v_code := 'reference_missing';
        v_reason := 'aggregate_id: names no ' || v_agg_type || ' (or no such revision) written yet (EV-C02-013 3.1)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_kind = 'ledger_state_row' then
        v_check := 'installation_mission';
        v_inst := devos_private.is_installation_mission(v_agg);
        if v_inst is null then
          v_code := 'could_not_check';
          v_reason := 'installation_mission: whether the Mission is the installation''s is missing or partial';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if not v_inst then
          v_code := 'invalid_field';
          v_reason := 'aggregate_id: a ledger_state_row is an event of the installation''s Mission (EV-C02-013 3.2)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl);
  end if;
  if v_repeat then
    return jsonb_build_object('status', 'ok', 'id', v_prev_ev, 'repeat', true);
  end if;

  -- The write block: step (g). The event, then its transferred mark, which names it (S2's index is the backstop).
  begin
    v_check := 'write';
    v_ev := devos_private.write_event(v_agg_type, v_agg, v_agg_rev, v_kind, v_body, v_class::text, 'call', v_decl);
    v_mark := jsonb_build_object('transfer_source', v_src, 'run_id', v_run, 'lacks', '[]'::jsonb, 'event_id', v_ev);
    if v_declared is not null then
      v_mark := v_mark || jsonb_build_object('declared', v_declared);
    end if;
    if v_fields is not null then
      v_mark := v_mark || jsonb_build_object('source_fields', v_fields);
    end if;
    perform devos_private.write_event(v_agg_type, v_agg, v_agg_rev, 'transferred', v_mark, v_class::text, 'call', v_decl);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_ev);
end
$fn$;

-- record_ledger_entry (EV-C02-013 3.2; EV-C02-005 2.5 and S1; B 3.13): one ledger_entry event on the stage's Work at
-- its current revision, and no transferred event (a new entry, not a transfer). Allowed before and after the hand-over.
-- Payload: stage_work_id (a uuid), entry_id (a non-empty string), entry_date (a date, YYYY-MM-DD), text (a string), all
-- required; disciplines, guard, record_changes, wait, summary_tr, usage_reading, answers and batu_steps, each kept as
-- sent when not JSON null. Order after the gate: the form; the Work, locked for share (none: could_not_check, a
-- reference the check reads); its current revision and Mission (missing: could_not_check); ownership, Rule O's
-- devos_kurulum clause (EV-C02-008 1.7.1): a Work outside the installation's Mission is not_owner, one whose Mission
-- cannot be told could_not_check; then, under a transaction-level advisory lock on the entry ID, the ledger_entry
-- events of that entry ID: one on the same Work with the same payload is the exact repeat (ok, its id, "repeat":
-- true), any other conflict. Answer {"status": "ok", "id"}, the event's id.
create function devos_api.record_ledger_entry(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'record_ledger_entry';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_stage uuid;
  v_entry text;
  v_date date;
  v_body jsonb;
  v_wrev integer;
  v_mission uuid;
  v_inst boolean;
  v_prev_id bigint;
  v_prev_agg uuid;
  v_prev_body jsonb;
  v_ev bigint;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;
  if jsonb_typeof(p_in -> 'declared_session_id') = 'string' then
    v_decl := p_in ->> 'declared_session_id';
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'record_ledger_entry admits only the role class devos_kurulum (B section 4, the ledger transfer)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (c) The form.
    v_check := 'input';
    if p_in is null then
      v_code := 'missing_field'; v_reason := 'p: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in) <> 'object' then
      v_code := 'invalid_field'; v_reason := 'p: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'stage_work_id'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'stage_work_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'stage_work_id') <> 'string'
       or (p_in ->> 'stage_work_id') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'stage_work_id: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_stage := (p_in ->> 'stage_work_id')::uuid;
    if coalesce(jsonb_typeof(p_in -> 'entry_id'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'entry_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'entry_id') <> 'string' or btrim(p_in ->> 'entry_id') = '' then
      v_code := 'invalid_field'; v_reason := 'entry_id: not a non-empty string';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_entry := p_in ->> 'entry_id';
    if coalesce(jsonb_typeof(p_in -> 'entry_date'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'entry_date: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'entry_date') <> 'string' or (p_in ->> 'entry_date') !~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' then
      v_code := 'invalid_field'; v_reason := 'entry_date: not a date (YYYY-MM-DD)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    begin
      v_date := (p_in ->> 'entry_date')::date;
    exception when others then
      v_code := 'invalid_field'; v_reason := 'entry_date: not a date (YYYY-MM-DD)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end;
    if coalesce(jsonb_typeof(p_in -> 'text'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'text: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'text') <> 'string' then
      v_code := 'invalid_field'; v_reason := 'text: not a string';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_body := jsonb_build_object('entry_id', v_entry, 'entry_date', p_in ->> 'entry_date', 'text', p_in ->> 'text');
    foreach v_key in array array['disciplines', 'guard', 'record_changes', 'wait', 'summary_tr', 'usage_reading',
                                 'answers', 'batu_steps'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') <> 'null' then
        v_body := v_body || jsonb_build_object(v_key, p_in -> v_key);
      end if;
    end loop;

    -- (d) The stage's Work and its ownership (Rule O's devos_kurulum clause, read as EV-C02-013 2.3 says).
    v_check := 'work';
    perform 1 from devos_private.work w where w.id = v_stage for share;
    if not found then
      v_code := 'could_not_check'; v_reason := 'stage_work_id: the record could not be read';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select r.revision, mr.mission_id into v_wrev, v_mission
      from devos_private.work_revision r
      left join devos_private.mission_revision mr on mr.id = r.mission_revision_id
     where r.work_id = v_stage
     order by r.revision desc limit 1;
    if v_wrev is null then
      v_code := 'could_not_check'; v_reason := 'stage_work_id: the work item''s current revision is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_mission is null then
      v_code := 'could_not_check'; v_reason := 'ownership: the work item''s Mission is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'rule_o';
    v_inst := devos_private.is_installation_mission(v_mission);
    if v_inst is null then
      v_code := 'could_not_check';
      v_reason := 'ownership: whether the work item lies under the installation''s Mission is missing or partial';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if not v_inst then
      v_code := 'not_owner';
      v_reason := 'Rule O: devos_kurulum writes ledger entries only on a work item under the installation''s Mission (EV-C02-008 1.7.1)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The entry ID's key, under its advisory lock (3.2's row).
    v_check := 'entry';
    perform pg_catalog.pg_advisory_xact_lock(9003, pg_catalog.hashtext(v_entry));
    select e.id, e.aggregate_id, e.payload into v_prev_id, v_prev_agg, v_prev_body
      from devos_private.event e
     where e.event_type = 'ledger_entry' and e.payload ->> 'entry_id' = v_entry
     order by e.id limit 1;
    if v_prev_id is not null then
      if not (v_prev_agg = v_stage and v_prev_body = v_body) then
        v_code := 'conflict';
        v_reason := 'entry_id: a ledger entry of this ID is recorded with another text, work item or field';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_stage, v_wrev);
  end if;
  if v_prev_id is not null then
    return jsonb_build_object('status', 'ok', 'id', v_prev_id, 'repeat', true);
  end if;

  -- The write block: step (g). The one ledger_entry event.
  begin
    v_check := 'write';
    v_ev := devos_private.write_event('work', v_stage, v_wrev, 'ledger_entry', v_body, v_class::text, 'call', v_decl);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_stage, v_wrev);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_ev);
end
$fn$;

-- transfer_artifact (EV-C02-013 3.1 and 3.2; EV-C02-005 1.2 row 19, 2.4 and 12; B 3.10): an Artifact, its revision 1
-- and its transferred event, payload {transfer_source, run_id, lacks: []} (and declared, source_fields when sent; after
-- the hand-over "run_id": null and "after_handover": true). Payload: transfer_source (S1's six strings, kind artifact),
-- path (a non-empty string), commit (40 lower-case hexadecimal characters), kind (git_file or git_tree), scope
-- (installation, EV-C02-005 1.2 row 19), all required; status (candidate, current or superseded; default current);
-- run_id (before the hand-over an open run; after it none); declared and source_fields (objects). Order after the gate:
-- the form; the closing rule: after the hand-over only a git_tree, or a git_file whose path is a check's verdict file
-- (evidence/C<nn>/checks/CHK-C<nn>-<n>.md), else handed_over; the key (repeat or conflict); the run: after the
-- hand-over a run_id present is run_not_open, before it an open run is needed (run_not_open). Answer {"status": "ok",
-- "id", "revision"}.
create function devos_api.transfer_artifact(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'transfer_artifact';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_src jsonb;
  v_sid text;
  v_sha text;
  v_run text;
  v_path text;
  v_commit text;
  v_kind text;
  v_scope text;
  v_status devos_private.artifact_status := 'current';
  v_declared jsonb;
  v_fields jsonb;
  v_after boolean;
  v_found boolean := false;
  v_prev_sha text;
  v_prev_agg uuid;
  v_prev_rev integer;
  v_partial bigint;
  v_begun bigint;
  v_done bigint;
  v_id uuid;
  v_mark jsonb;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;
  if jsonb_typeof(p_in -> 'declared_session_id') = 'string' then
    v_decl := p_in ->> 'declared_session_id';
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'transfer_artifact admits only the role class devos_kurulum (B section 4, the ledger transfer)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (c) The form.
    v_check := 'input';
    if p_in is null then
      v_code := 'missing_field'; v_reason := 'p: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in) <> 'object' then
      v_code := 'invalid_field'; v_reason := 'p: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'run_id'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'run_id') <> 'string' or btrim(p_in ->> 'run_id') = '' then
        v_code := 'invalid_field'; v_reason := 'run_id: not a non-empty string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_run := p_in ->> 'run_id';
    end if;
    -- S1's transfer_source.
    if coalesce(jsonb_typeof(p_in -> 'transfer_source'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'transfer_source: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'transfer_source') <> 'object' then
      v_code := 'invalid_field'; v_reason := 'transfer_source: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    foreach v_key in array array['kind', 'source_id', 'path', 'input_commit', 'last_commit', 'sha256'] loop
      if coalesce(jsonb_typeof(p_in -> 'transfer_source' -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := 'transfer_source.' || v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> 'transfer_source' -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := 'transfer_source.' || v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    v_sid := p_in -> 'transfer_source' ->> 'source_id';
    v_sha := p_in -> 'transfer_source' ->> 'sha256';
    if (p_in -> 'transfer_source' ->> 'kind') <> 'artifact' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.kind: not artifact (EV-C02-013 3.1)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if btrim(v_sid) = '' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.source_id: empty';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p_in -> 'transfer_source' ->> 'input_commit') !~ '^[0-9a-f]{40}$'
       or (p_in -> 'transfer_source' ->> 'last_commit') !~ '^[0-9a-f]{40}$' then
      v_code := 'invalid_field';
      v_reason := 'transfer_source: input_commit or last_commit not 40 lower-case hexadecimal characters';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_sha !~ '^[0-9a-f]{64}$' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.sha256: not 64 lower-case hexadecimal characters';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_src := jsonb_build_object('kind', 'artifact', 'source_id', v_sid, 'path', p_in -> 'transfer_source' ->> 'path',
                                'input_commit', p_in -> 'transfer_source' ->> 'input_commit',
                                'last_commit', p_in -> 'transfer_source' ->> 'last_commit', 'sha256', v_sha);
    -- The Artifact's fields (B 3.10).
    if coalesce(jsonb_typeof(p_in -> 'path'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'path: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'path') <> 'string' or btrim(p_in ->> 'path') = '' then
      v_code := 'invalid_field'; v_reason := 'path: not a non-empty string';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_path := p_in ->> 'path';
    if coalesce(jsonb_typeof(p_in -> 'commit'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'commit: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'commit') <> 'string' or (p_in ->> 'commit') !~ '^[0-9a-f]{40}$' then
      v_code := 'invalid_field'; v_reason := 'commit: not 40 lower-case hexadecimal characters';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_commit := p_in ->> 'commit';
    if coalesce(jsonb_typeof(p_in -> 'kind'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'kind: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'kind') <> 'string' or (p_in ->> 'kind') not in ('git_file', 'git_tree') then
      v_code := 'invalid_field'; v_reason := 'kind: not git_file or git_tree';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_kind := p_in ->> 'kind';
    if coalesce(jsonb_typeof(p_in -> 'scope'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'scope: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'scope') <> 'string' or (p_in ->> 'scope') <> 'installation' then
      v_code := 'invalid_field';
      v_reason := 'scope: not installation (the transfer copies installation records; EV-C02-005 1.2 row 19)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_scope := p_in ->> 'scope';
    if coalesce(jsonb_typeof(p_in -> 'status'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'status') <> 'string' or (p_in ->> 'status') not in ('candidate', 'current', 'superseded') then
        v_code := 'invalid_field'; v_reason := 'status: not candidate, current or superseded';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_status := (p_in ->> 'status')::devos_private.artifact_status;
    end if;
    if coalesce(jsonb_typeof(p_in -> 'declared'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'declared') <> 'object' then
        v_code := 'invalid_field'; v_reason := 'declared: not a JSON object';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_declared := p_in -> 'declared';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'source_fields'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'source_fields') <> 'object' then
        v_code := 'invalid_field'; v_reason := 'source_fields: not a JSON object';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_fields := p_in -> 'source_fields';
    end if;

    -- (f) The closing rule (B:397): after the hand-over, a verdict file and its tree only.
    v_check := 'handover';
    v_after := exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over');
    if v_after and not (v_kind = 'git_tree'
                        or (v_kind = 'git_file' and v_path ~ '^evidence/C[0-9]{2}/checks/CHK-C[0-9]{2}-[0-9]+[.]md$')) then
      v_code := 'handed_over';
      v_reason := 'transfer_artifact: the ledger is handed over, and this is neither a verdict file nor a tree (B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
    select e.payload -> 'transfer_source' ->> 'sha256', e.aggregate_id into v_prev_sha, v_prev_agg
      from devos_private.event e
     where e.event_type = 'transferred' and (e.payload -> 'transfer_source' ->> 'kind') = 'artifact'
       and (e.payload -> 'transfer_source' ->> 'source_id') = v_sid
     order by e.id limit 1;
    v_found := found;
    if v_found then
      if v_prev_sha is null then
        v_code := 'could_not_check'; v_reason := 'key: the earlier transferred event lacks its sha256 (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_prev_sha <> v_sha then
        v_code := 'conflict';
        v_reason := 'transfer_source: this source is already transferred with another sha256 (EV-C02-013 3.1)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      select max(r.revision) into v_prev_rev from devos_private.artifact_revision r where r.artifact_id = v_prev_agg;
      if v_prev_rev is null then
        v_code := 'could_not_check'; v_reason := 'key: the transferred Artifact''s revision is missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    else
      -- The run (3.1 with R1-8).
      v_check := 'run';
      if v_after then
        if v_run is not null then
          v_code := 'run_not_open';
          v_reason := 'run_id: after the hand-over a copy names no run (EV-C02-013 3.1)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      else
        if v_run is null then
          v_code := 'run_not_open'; v_reason := 'run_id: none named, and the ledger is not handed over (EV-C02-013 3.1)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        select count(*) filter (where coalesce(e.payload ->> 'phase', '') not in ('begun', 'completed')),
               count(*) filter (where e.payload ->> 'phase' = 'begun'),
               count(*) filter (where e.payload ->> 'phase' = 'completed')
          into v_partial, v_begun, v_done
          from devos_private.event e where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run;
        if v_partial > 0 then
          v_code := 'could_not_check'; v_reason := 'run: a transfer_run event of the run lacks its phase (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_begun = 0 or v_done > 0 then
          v_code := 'run_not_open';
          v_reason := 'run_id: names no open run (' || case when v_begun = 0 then 'never begun' else 'completed' end
                      || '; EV-C02-013 3.1)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl);
  end if;
  if v_found then
    return jsonb_build_object('status', 'ok', 'id', v_prev_agg, 'revision', v_prev_rev, 'repeat', true);
  end if;

  -- The write block: step (g). The Artifact, its revision 1 and its transferred mark (S2's index is the backstop).
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    insert into devos_private.artifact (id, status, scope) values (v_id, v_status, v_scope);
    insert into devos_private.artifact_revision (artifact_id, revision, path, commit, kind)
    values (v_id, 1, v_path, v_commit, v_kind);
    v_mark := jsonb_build_object('transfer_source', v_src, 'run_id', v_run, 'lacks', '[]'::jsonb);
    if v_after then
      v_mark := v_mark || jsonb_build_object('after_handover', true);
    end if;
    if v_declared is not null then
      v_mark := v_mark || jsonb_build_object('declared', v_declared);
    end if;
    if v_fields is not null then
      v_mark := v_mark || jsonb_build_object('source_fields', v_fields);
    end if;
    perform devos_private.write_event('artifact', v_id, 1, 'transferred', v_mark, v_class::text, 'call', v_decl);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id, 'revision', 1);
end
$fn$;

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)). PUBLIC's default EXECUTE is revoked from
-- the six functions, and so is any privilege of the four API roles; then EXECUTE is granted to anon, the role a Data
-- API request with the publishable key runs as. Each function checks the token itself. This file adds no type and no
-- devos_private function. None of the six is a read, so none carries the devos:read comment (F06).
revoke all on function devos_api.begin_transfer_run(jsonb) from public;
revoke all on function devos_api.end_transfer_run(jsonb) from public;
revoke all on function devos_api.record_handover(jsonb) from public;
revoke all on function devos_api.transfer_event(jsonb) from public;
revoke all on function devos_api.record_ledger_entry(jsonb) from public;
revoke all on function devos_api.transfer_artifact(jsonb) from public;
do $$
declare r text; f text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      foreach f in array array['devos_api.begin_transfer_run(jsonb)', 'devos_api.end_transfer_run(jsonb)',
                               'devos_api.record_handover(jsonb)', 'devos_api.transfer_event(jsonb)',
                               'devos_api.record_ledger_entry(jsonb)', 'devos_api.transfer_artifact(jsonb)'] loop
        execute format('revoke all on function %s from %I', f, r);
      end loop;
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.begin_transfer_run(jsonb) to anon;
    grant execute on function devos_api.end_transfer_run(jsonb) to anon;
    grant execute on function devos_api.record_handover(jsonb) to anon;
    grant execute on function devos_api.transfer_event(jsonb) to anon;
    grant execute on function devos_api.record_ledger_entry(jsonb) to anon;
    grant execute on function devos_api.transfer_artifact(jsonb) to anon;
  end if;
end
$$;
