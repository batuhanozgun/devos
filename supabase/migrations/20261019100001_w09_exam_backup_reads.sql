-- DevOS schema (W-C02-09), not a fixture. M09-09: exam, backup and reads.
-- Sources: plan/work/W-C02-09.md points 1, 2, 3, 5, 7 and 8; Appendix B principles 1, 2 and 8, section 2, 3.13
-- (Event, RejectedAttempt), 3.15 (EvalRun), 3.23 (LeakFingerprint), 3.27 and section 4 (rows "Learning and exam",
-- "Backup"); Appendix C N06, N08, N26; evidence/C02/EV-C02-013_w09_interface.md sections 1 (items 1 to 14), 2.8, 4 (the
-- row of w07_fn_cfg), 10 and 24 (C-M09); EV-C02-008 1.4 (rows R10r, R12, R13, R15) and 5.1 (a) to (c); EV-C02-002
-- DM-17, DM-19, DM-24, DM-31, DM-35, DM-36. Record: evidence/C02/EV-C02-014_w09_build.md section 11.
-- It holds exactly section 10's row M09-09, the six functions of EV-C02-013 section 2.8: devos_api.record_eval_run,
-- read_eval_run, mark_exported, read_rejected_attempts, authority_epoch and fingerprint_matches. It adds no table, type
-- or private function, and changes nothing of M09-01 to M09-08 or of the rule corrections (20261019080001), whose
-- helpers it calls: caller_role_class, write_event and reject. No token, hash or key value is written here.
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12).
--
-- The common form is M09-03's to M09-08's (EV-C02-013 section 1 items 6, 7, 9 and 10, R1-1): (a) the derivation,
-- before any other check; then a read block holding (b) the role list, a literal of the function's own text (B:48),
-- (c) the input's form and (f) the family's rules, writing nothing (its row locks stay with the transaction); then, for
-- the two state-changing functions, a write block holding (g) the writes and their event through
-- devos_private.write_event, with the caller's role class. A check that decides a refusal sets v_code and v_reason and
-- raises P0D01; any other error in the read block is could_not_check, "<v_check>: its input could not be read (SQLSTATE
-- <code>)"; any error in the write block is write_failed, but P0D02, which is could_not_check with its fixed reason.
-- After either block's refusal one per-call RejectedAttempt row is written by devos_private.reject. A reason holds
-- fixed text and an SQLSTATE only. Keys a function does not read are ignored (item 4); declared_session_id goes to the
-- event and the refusal rows only (item 5). Parameters keep the names of EV-C02-013 2.8 and README 8.1 (named calls),
-- and the bodies read them through ALIAS FOR $n (N-288). None of the six takes a claim token, and no claim token or
-- anything derived from one reaches an event, a record or a refusal row.
--
-- The exam records (B 3.15; EV-C02-008 5.1 (a)): EvalRun is written only with devos_sinav (record_eval_run) and read
-- only with it (read_eval_run, row R10r of EV-C02-008 1.4). These two are the only functions of this file whose text
-- names EvalRun's table; the other four never read it. record_eval_run writes nothing on the Work it names: no field,
-- no revision and no event (EV-C02-008 5.1 (c) bound 2; DM-24), and its own event carries no EvalRun field, so the exam
-- link stays in EvalRun alone (B 3.15: "the link lives only here"; EV-C02-013 24 (2)).

-- record_eval_run (EV-C02-013 2.8 and 24 (1) to (3); B 3.15; EV-C02-008 5.1 (c) bounds 2 and 3; README 8.1): one
-- EvalRun and its event eval_run_recorded on aggregate eval_run. Payload: eval_set_id, eval_set_version, subject_role,
-- runner_session (strings), work_ref (a uuid) with work_revision, results (an object) required; subject_release (a
-- string), run_at (a time with its zone; default now()). Order after the gate: the form (work_revision absent or JSON
-- null: could_not_check, a reference sent without its revision, R2-1); the work item, locked for share (none:
-- could_not_check, a reference); the revision named (none: could_not_check; an earlier revision is accepted: an exam
-- task's run names the revision it was opened as, B:284); the work item's claims: one without its status or role
-- class is could_not_check; one of the caller's class (the gate admits devos_sinav alone) whose status is active,
-- whatever its lease or epoch, is invalid_field (EV-C02-008 5.1 (c) bound 3's second layer; R:424). devos_sinav only.
-- No exact repeat: each call writes a new run (a creating call with no idempotency key). Answer {"status": "ok", "id"}.
create function devos_api.record_eval_run(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'record_eval_run';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_set_id text;
  v_set_version text;
  v_subject_role text;
  v_subject_release text;
  v_runner text;
  v_work uuid;
  v_wrev integer;
  v_results jsonb;
  v_run_at timestamptz;
  v_found boolean;
  v_partial bigint;
  v_active bigint;
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
    if not (v_class = any (array['devos_sinav']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'record_eval_run admits only the role class devos_sinav (B 3.15)';
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
    foreach v_key in array array['eval_set_id', 'eval_set_version', 'subject_role', 'runner_session'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    v_set_id := p_in ->> 'eval_set_id';
    v_set_version := p_in ->> 'eval_set_version';
    v_subject_role := p_in ->> 'subject_role';
    v_runner := p_in ->> 'runner_session';
    if coalesce(jsonb_typeof(p_in -> 'work_ref'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'work_ref: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'work_ref') <> 'string'
       or (p_in ->> 'work_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'work_ref: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_work := (p_in ->> 'work_ref')::uuid;
    -- R2-1's rule: a reference sent without its revision is partial input.
    if coalesce(jsonb_typeof(p_in -> 'work_revision'), 'null') = 'null' then
      v_code := 'could_not_check'; v_reason := 'work_revision: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'work_revision') <> 'number' or (p_in ->> 'work_revision') !~ '^[1-9][0-9]{0,8}$' then
      v_code := 'invalid_field'; v_reason := 'work_revision: not an integer of at least 1';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_wrev := (p_in ->> 'work_revision')::integer;
    if coalesce(jsonb_typeof(p_in -> 'results'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'results: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'results') <> 'object' then
      v_code := 'invalid_field'; v_reason := 'results: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_results := p_in -> 'results';
    if coalesce(jsonb_typeof(p_in -> 'subject_release'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'subject_release') <> 'string' then
        v_code := 'invalid_field'; v_reason := 'subject_release: not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_subject_release := p_in ->> 'subject_release';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'run_at'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'run_at') <> 'string' then
        v_code := 'invalid_field'; v_reason := 'run_at: not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      begin
        v_run_at := (p_in ->> 'run_at')::timestamptz;
      exception when others then
        v_code := 'invalid_field'; v_reason := 'run_at: not a time';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end;
    end if;

    -- (f) The work item the run names, locked for share (DM-01: the work item first). A reference: one that names no
    -- Work is could_not_check (EV-C02-013 section 1 item 14 with R1-2). The row is read, never written.
    v_check := 'work';
    perform 1 from devos_private.work w where w.id = v_work for share;
    if not found then
      v_code := 'could_not_check'; v_reason := 'work_ref: the record could not be read';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select exists (select 1 from devos_private.work_revision r where r.work_id = v_work and r.revision = v_wrev)
      into v_found;
    if not v_found then
      v_code := 'could_not_check'; v_reason := 'work_revision: names no revision of the work item';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    -- The second layer of EV-C02-008 5.1 (c) bound 3: no claim of the exam class may be active on the work item. The
    -- caller's class is the one the gate admits, so a claim of v_class is a claim of that class. A claim's status
    -- active is judged as recorded, not through claim_live: the rule refuses the trace of a fault (only a fault makes
    -- such a claim), and a lapsed one is that trace too (EV-C02-013 24 (3)).
    v_check := 'claims';
    select count(*) filter (where a.status is null or a.role_class is null),
           count(*) filter (where a.status = 'active' and a.role_class = v_class)
      into v_partial, v_active
      from devos_private.assignment a where a.work_ref = v_work;
    if v_partial > 0 then
      v_code := 'could_not_check'; v_reason := 'claims: a claim on the work item lacks its status or role class (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_active > 0 then
      v_code := 'invalid_field';
      v_reason := 'work_ref: a claim of the exam environment''s class is active on the work item (EV-C02-008 5.1 (c))';
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

  -- The write block: step (g). The EvalRun, then its event, whose payload holds no EvalRun field (EV-C02-013 24 (2)).
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    insert into devos_private.eval_run (id, eval_set_id, eval_set_version, subject_role, subject_release, runner_session,
                                        work_ref, work_revision, results, run_at)
    values (v_id, v_set_id, v_set_version, v_subject_role, v_subject_release, v_runner, v_work, v_wrev, v_results,
            coalesce(v_run_at, now()));
    perform devos_private.write_event('eval_run', v_id, null, 'eval_run_recorded', '{}'::jsonb, v_class::text, 'call',
                                      v_decl);
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

-- read_eval_run (EV-C02-013 2.8; EV-C02-008 1.4, row R10r; B 3.15: "EvalRun is read only with it"): one EvalRun with
-- its fields, the exam link among them, to devos_sinav only. eval_run_id NULL: missing_field; an id that names no
-- EvalRun: not_found. A read: it changes no table but rejected_attempt, it is VOLATILE because it records its refusals
-- (DM-36), and its comment begins devos:read. It has no write block. Answer {"status": "ok", "eval_run": {id,
-- eval_set_id, eval_set_version, subject_role, subject_release, runner_session, work_ref, work_revision, results,
-- run_at}}.
create function devos_api.read_eval_run(eval_run_id uuid)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_id alias for $1;
  v_fn constant text := 'read_eval_run';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_row jsonb;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_sinav']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'read_eval_run admits only the role class devos_sinav (B 3.15)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if p_id is null then
      v_code := 'missing_field'; v_reason := 'eval_run_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'eval_run';
    select jsonb_build_object('id', e.id, 'eval_set_id', e.eval_set_id, 'eval_set_version', e.eval_set_version,
                              'subject_role', e.subject_role, 'subject_release', e.subject_release,
                              'runner_session', e.runner_session, 'work_ref', e.work_ref,
                              'work_revision', e.work_revision, 'results', e.results, 'run_at', e.run_at)
      into v_row
      from devos_private.eval_run e where e.id = p_id;
    if v_row is null then
      v_code := 'not_found'; v_reason := 'eval_run_id: names no EvalRun';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_id);
  end if;
  return jsonb_build_object('status', 'ok', 'eval_run', v_row);
end
$fn$;
comment on function devos_api.read_eval_run(uuid) is
  'devos:read One EvalRun with its fields, to devos_sinav only (B 3.15; EV-C02-008 1.4, row R10r; EV-C02-013 section 2.8)';

-- mark_exported (EV-C02-013 2.8 and 24 (4); B 3.13: "mark_exported writes one event per call, for the range it marks";
-- B:270: a counted row "changes only during its hour and is exported after it"; B section 2, devos_backup: "only the
-- mark_exported function"): sets exported_at on the rows of one table whose id lies in [from_id, to_id] and that are
-- not yet marked. Payload: table (event or rejected_attempt), from_id and to_id (JSON integers of at least 1, inclusive)
-- required. from_id greater than to_id: invalid_field. A counted RejectedAttempt row is marked only once its hour has
-- ended; a row already marked keeps its time. Every row of the range is marked, open samples' rows included (EV-C02-008
-- 5.2: the backup's read for the export). The read block lists and locks the rows to mark, for update; the write block
-- marks them by id and writes one exported event on aggregate export, a new uuid, payload {table, from_id, to_id,
-- marked}. A call that marks no row writes no event: when the range holds rows and every one is marked, it is the exact
-- repeat ("repeat": true); otherwise (no row, or only counted rows of the current hour) it answers marked 0. devos_backup
-- only. Answer {"status": "ok", "id", "marked"}; id is the export event's aggregate, JSON null when no row was marked.
create function devos_api.mark_exported(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'mark_exported';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_table text;
  v_from bigint;
  v_to bigint;
  v_ids bigint[];
  v_in_range bigint;
  v_unmarked bigint;
  v_marked bigint;
  v_eid uuid;
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
    if not (v_class = any (array['devos_backup']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'mark_exported admits only the role class devos_backup (B section 2)';
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
    if coalesce(jsonb_typeof(p_in -> 'table'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'table: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'table') <> 'string' or (p_in ->> 'table') not in ('event', 'rejected_attempt') then
      v_code := 'invalid_field'; v_reason := 'table: not event or rejected_attempt';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_table := p_in ->> 'table';
    foreach v_key in array array['from_id', 'to_id'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'number' or (p_in ->> v_key) !~ '^[1-9][0-9]{0,17}$' then
        v_code := 'invalid_field'; v_reason := v_key || ': not an integer of at least 1';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    v_from := (p_in ->> 'from_id')::bigint;
    v_to := (p_in ->> 'to_id')::bigint;
    if v_from > v_to then
      v_code := 'invalid_field'; v_reason := 'from_id: greater than to_id';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The rows of the range: how many there are, how many are not yet marked, and the ones to mark now, locked.
    v_check := v_table;
    if v_table = 'event' then
      select count(*), count(*) filter (where e.exported_at is null) into v_in_range, v_unmarked
        from devos_private.event e where e.id between v_from and v_to;
      select coalesce(array_agg(x.id order by x.id), '{}'::bigint[]) into v_ids
        from (select e.id from devos_private.event e
               where e.id between v_from and v_to and e.exported_at is null
               order by e.id for update) x;
    else
      select count(*), count(*) filter (where r.exported_at is null) into v_in_range, v_unmarked
        from devos_private.rejected_attempt r where r.id between v_from and v_to;
      select coalesce(array_agg(x.id order by x.id), '{}'::bigint[]) into v_ids
        from (select r.id from devos_private.rejected_attempt r
               where r.id between v_from and v_to and r.exported_at is null
                 and (r.counted_hour is null or r.counted_hour + interval '1 hour' <= now())
               order by r.id for update) x;
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
  if cardinality(v_ids) = 0 then
    if v_in_range > 0 and v_unmarked = 0 then
      return jsonb_build_object('status', 'ok', 'id', null, 'marked', 0, 'repeat', true);
    end if;
    return jsonb_build_object('status', 'ok', 'id', null, 'marked', 0);
  end if;

  -- The write block: step (g). The rows listed, by id, then the one event of the call.
  begin
    v_check := 'write';
    if v_table = 'event' then
      update devos_private.event e set exported_at = now() where e.id = any (v_ids);
    else
      update devos_private.rejected_attempt r set exported_at = now() where r.id = any (v_ids);
    end if;
    get diagnostics v_marked = row_count;
    v_eid := pg_catalog.gen_random_uuid();
    perform devos_private.write_event('export', v_eid, null, 'exported',
      jsonb_build_object('table', v_table, 'from_id', v_from, 'to_id', v_to, 'marked', v_marked),
      v_class::text, 'call', v_decl);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_eid, 'marked', v_marked);
end
$fn$;

-- read_rejected_attempts (EV-C02-013 2.8 and 24 (5); EV-C02-008 1.4, row R15; B:270: "Only the functions write it;
-- devos_denetim reads it"; README 8.1): the RejectedAttempt rows since a time, with the record's fields only (id,
-- function_name, role_class, reason_code, counted_hour, count, declared_session_id, reason, target_ref,
-- target_revision, created_at, exported_at), ordered by id. A row is returned when it was created at or after since,
-- or when it is a counted row whose hour ends after since (a counted row changes during its hour, B:270). since NULL:
-- missing_field. devos_denetim only. A read: it changes no table but rejected_attempt, it is VOLATILE because it records
-- its refusals (DM-36), and its comment begins devos:read. Answer {"status": "ok", "rows": [...]}.
create function devos_api.read_rejected_attempts(since timestamptz)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_since alias for $1;
  v_fn constant text := 'read_rejected_attempts';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_rows jsonb;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_denetim']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'read_rejected_attempts admits only the role class devos_denetim (B 3.13)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if p_since is null then
      v_code := 'missing_field'; v_reason := 'since: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'rejected_attempt';
    select coalesce(jsonb_agg(jsonb_build_object('id', r.id, 'function_name', r.function_name,
                                                 'role_class', r.role_class, 'reason_code', r.reason_code,
                                                 'counted_hour', r.counted_hour, 'count', r.count,
                                                 'declared_session_id', r.declared_session_id, 'reason', r.reason,
                                                 'target_ref', r.target_ref, 'target_revision', r.target_revision,
                                                 'created_at', r.created_at, 'exported_at', r.exported_at)
                              order by r.id), '[]'::jsonb)
      into v_rows
      from devos_private.rejected_attempt r
     where r.created_at >= p_since
        or (r.counted_hour is not null and r.counted_hour + interval '1 hour' > p_since);
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason);
  end if;
  return jsonb_build_object('status', 'ok', 'rows', v_rows);
end
$fn$;
comment on function devos_api.read_rejected_attempts(timestamptz) is
  'devos:read The RejectedAttempt rows since a time, with the record''s fields only, to devos_denetim (B 3.13; EV-C02-008 1.4, row R15; EV-C02-013 section 2.8)';

-- authority_epoch (EV-C02-013 2.8 and 4, row R12; EV-C02-008 1.4, row R12; B principle 9; B section 2, devos_ci's
-- reads): the global authority epoch. Its row missing, or its value NULL: could_not_check. Read without a lock (a read
-- changes nothing; an increment that commits after it is seen by the next call). All six role classes, as a literal. A
-- read: VOLATILE, devos:read, no write block. Answer {"status": "ok", "epoch"}.
create function devos_api.authority_epoch()
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'authority_epoch';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_epoch bigint;
  v_found boolean;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum', 'devos_ci',
                                 'devos_backup']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'authority_epoch admits only the six role classes of B section 2';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'epoch';
    select g.epoch, true into v_epoch, v_found from devos_private.global_authority_epoch g where g.singleton;
    if v_found is null then
      v_code := 'could_not_check'; v_reason := 'epoch: the global authority epoch is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_epoch is null then
      v_code := 'could_not_check'; v_reason := 'epoch: the global authority epoch has no value (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason);
  end if;
  return jsonb_build_object('status', 'ok', 'epoch', v_epoch);
end
$fn$;
comment on function devos_api.authority_epoch() is
  'devos:read The global authority epoch, to every role class (B principle 9; EV-C02-008 1.4, row R12; EV-C02-013 section 2.8)';

-- fingerprint_matches (EV-C02-013 2.8 and 24 (6); EV-C02-008 1.4, row R13; B 3.23: "devos_ci reads"; Appendix C N06:
-- "the matching text is not written", and with the store absent "could not check", not clean): which of the hashes a
-- check sends are in LeakFingerprint, each with its origin, never source_ref or any content. hashes NULL:
-- missing_field; an empty array: invalid_field; an element NULL or empty: invalid_field. The store unreadable or absent:
-- could_not_check (section 1 item 7 (iii)). devos_ci only. A read: VOLATILE, devos:read, no write block. Answer
-- {"status": "ok", "matches": [{"hash", "origin"}, ...]}, one entry per distinct hash and origin, ordered by them.
create function devos_api.fingerprint_matches(hashes text[])
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_hashes alias for $1;
  v_fn constant text := 'fingerprint_matches';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_matches jsonb;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_ci']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'fingerprint_matches admits only the role class devos_ci (B 3.23)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if p_hashes is null then
      v_code := 'missing_field'; v_reason := 'hashes: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if cardinality(p_hashes) = 0 then
      v_code := 'invalid_field'; v_reason := 'hashes: empty';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if exists (select 1 from pg_catalog.unnest(p_hashes) h where h is null or h = '') then
      v_code := 'invalid_field'; v_reason := 'hashes: an element is empty';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'leak_fingerprint';
    select coalesce(jsonb_agg(jsonb_build_object('hash', m.hash, 'origin', m.origin) order by m.hash, m.origin),
                    '[]'::jsonb)
      into v_matches
      from (select distinct f.hash, f.origin::text as origin
              from devos_private.leak_fingerprint f where f.hash = any (p_hashes)) m;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason);
  end if;
  return jsonb_build_object('status', 'ok', 'matches', v_matches);
end
$fn$;
comment on function devos_api.fingerprint_matches(text[]) is
  'devos:read Which hashes are leak fingerprints, each with its origin and nothing else, to devos_ci (B 3.23; EV-C02-008 1.4, row R13; EV-C02-013 section 2.8)';

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)). PUBLIC's default EXECUTE is revoked from
-- the six functions, and so is any privilege of the four API roles; then EXECUTE is granted to anon, the role a Data
-- API request with the publishable key runs as. Each function checks the token itself. This file adds no type and no
-- devos_private function.
revoke all on function devos_api.record_eval_run(jsonb) from public;
revoke all on function devos_api.read_eval_run(uuid) from public;
revoke all on function devos_api.mark_exported(jsonb) from public;
revoke all on function devos_api.read_rejected_attempts(timestamptz) from public;
revoke all on function devos_api.authority_epoch() from public;
revoke all on function devos_api.fingerprint_matches(text[]) from public;
do $$
declare r text; f text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      foreach f in array array['devos_api.record_eval_run(jsonb)', 'devos_api.read_eval_run(uuid)',
                               'devos_api.mark_exported(jsonb)', 'devos_api.read_rejected_attempts(timestamptz)',
                               'devos_api.authority_epoch()', 'devos_api.fingerprint_matches(text[])'] loop
        execute format('revoke all on function %s from %I', f, r);
      end loop;
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.record_eval_run(jsonb) to anon;
    grant execute on function devos_api.read_eval_run(uuid) to anon;
    grant execute on function devos_api.mark_exported(jsonb) to anon;
    grant execute on function devos_api.read_rejected_attempts(timestamptz) to anon;
    grant execute on function devos_api.authority_epoch() to anon;
    grant execute on function devos_api.fingerprint_matches(text[]) to anon;
  end if;
end
$$;
