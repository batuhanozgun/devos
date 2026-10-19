-- DevOS schema (W-C02-09), not a fixture. The transfer corrections: the corrective migration of EV-C02-018 section 16
-- (decision 12), holding decisions 2, 5, 6, 7 and 8 in the forms EV-C02-013 section 28 (C-TC) states.
-- Sources: plan/work/W-C02-09.md points 1, 2, 3, 5, 7 and 10; Appendix B principles 2 and 3, section 2, 3.12, 3.13
-- and section 8 (concurrency control, B:472); evidence/C02/EV-C02-005_ledger_transfer.md 2.1, 3.2 and 3.4;
-- evidence/C02/EV-C02-013_w09_interface.md sections 1 (items 6, 7, 10, 12 and 13), 2.7, 3.1, 3.2, 25 to 27 and 28;
-- evidence/C02/EV-C02-018_w09_residuals.md sections 2, 5 to 8, 13 and 16 (L-406, with L-407's dated line);
-- evidence/C02/checks/CHK-C02-110.md; plan/work/C02.md notes N-298, N-302, N-303, N-306 and N-307.
-- Record: evidence/C02/EV-C02-014_w09_build.md section 15.
-- It holds exactly what section 28 (1) names, and nothing else:
--  - fourteen functions replaced, each its merged text with only the changes its comment names (the build record gives
--    each function's difference): devos_api.prepare_operation (M09-08); begin_transfer_run, end_transfer_run,
--    record_handover, transfer_event and transfer_artifact (M09-10); transfer_mission, transfer_work, transfer_relation,
--    transfer_decision, transfer_need and transfer_finding (M09-11); transfer_review and transfer_acceptance (M09-12);
--  - the two partial indexes of decision 8 (28 (9)).
-- devos_api.record_ledger_entry is not replaced, and no table, type, view, private function or reason code is added.
-- Each replaced function keeps its signature and parameter names, its role literal, the ALIAS FOR $n form, security
-- definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and every other check, code,
-- reason, read, write and event; its grants are written again (section 1 item 13).
-- The locks (28 (2)), all transaction-level advisory locks, each taken in its function's read block, so a refusal
-- decided there undoes them with the block and a block that ends normally keeps them to the end of the transaction:
--  - 9005, the hand-over: shared in the twelve functions that read the ledger_handed_over event, exclusive in
--    record_handover, each immediately before that read (after the gate and the form, before every other lock);
--  - 9007, the transfer key (kind and source ID), immediately before the key read of the ten functions keyed by S2;
--  - 9006, the Operation key (namespace and key), immediately before prepare_operation's key read;
--  - 9001 to 9004 stay where they are (after the key read). No function waits on a lock of an earlier step of 28 (2)'s
--    order while it holds one of a later step.
-- No token, hash or key value is written here, and no statement runs an owner-only function.

-- prepare_operation: its merged text (20261019050001_w09_external_effect.sql) with decision 2: lock 9006 on the idempotency key, the first statement of the idempotency step, before the key read (28 (3)).
create or replace function devos_api.prepare_operation(claim_token text, p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_token alias for $1;
  p_in alias for $2;
  v_fn constant text := 'prepare_operation';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_ns text;
  v_ikey text;
  v_eclass text;
  v_target text;
  v_base text;
  v_phash text;
  v_work uuid;
  v_wrev integer;
  v_tref uuid;
  v_trev integer;
  v_entries jsonb := '[]'::jsonb;
  v_entry jsonb;
  v_i integer;
  v_claim jsonb;
  v_assignment uuid;
  v_generation integer;
  v_epoch bigint;
  v_old_id uuid;
  v_old_status text;
  v_old_class text;
  v_old_target text;
  v_old_base text;
  v_old_hash text;
  v_old_work uuid;
  v_old_asg uuid;
  v_old_gen integer;
  v_old_epoch bigint;
  v_old_read jsonb;
  v_old_wrev integer;
  v_old_nt bigint;
  v_old_tref uuid;
  v_old_trev integer;
  v_answer jsonb;
  v_irrev boolean;
  v_mandatory text[];
  v_el text;
  v_cur integer;
  v_wscope text;
  v_ready boolean;
  v_ref uuid;
  v_rev integer;
  v_fam text;
  v_ok boolean;
  v_rcur integer;
  v_escope text;
  v_inputs jsonb;
  v_input jsonb;
  v_is_input boolean;
  v_set jsonb := '[]'::jsonb;
  v_deps jsonb;
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
    if not (v_class = any (array['devos_calisma', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'prepare_operation admits only the role classes devos_calisma and devos_kurulum';
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
    foreach v_key in array array['idempotency_namespace', 'idempotency_key', 'effect_class', 'target', 'payload_hash'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    v_ns := p_in ->> 'idempotency_namespace';
    v_ikey := p_in ->> 'idempotency_key';
    v_eclass := p_in ->> 'effect_class';
    v_target := p_in ->> 'target';
    v_phash := p_in ->> 'payload_hash';
    if coalesce(jsonb_typeof(p_in -> 'expected_base'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'expected_base') <> 'string' then
        v_code := 'invalid_field'; v_reason := 'expected_base: not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_base := p_in ->> 'expected_base';
    end if;
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
    -- R2-1: the effect names the revision of its work item; a reference sent without its revision is partial input.
    if coalesce(jsonb_typeof(p_in -> 'work_revision'), 'null') = 'null' then
      v_code := 'could_not_check'; v_reason := 'work_revision: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'work_revision') <> 'number' or (p_in ->> 'work_revision') !~ '^[1-9][0-9]{0,8}$' then
      v_code := 'invalid_field'; v_reason := 'work_revision: not an integer of at least 1';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_wrev := (p_in ->> 'work_revision')::integer;
    -- R2-3: target_ref with target_revision, optional (absent or JSON null: no target record).
    if coalesce(jsonb_typeof(p_in -> 'target_ref'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'target_ref') <> 'string'
         or (p_in ->> 'target_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
        v_code := 'invalid_field'; v_reason := 'target_ref: not a uuid';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_tref := (p_in ->> 'target_ref')::uuid;
      if coalesce(jsonb_typeof(p_in -> 'target_revision'), 'null') = 'null' then
        v_code := 'could_not_check'; v_reason := 'target_revision: missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> 'target_revision') <> 'number' or (p_in ->> 'target_revision') !~ '^[1-9][0-9]{0,8}$' then
        v_code := 'invalid_field'; v_reason := 'target_revision: not an integer of at least 1';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_trev := (p_in ->> 'target_revision')::integer;
    elsif coalesce(jsonb_typeof(p_in -> 'target_revision'), 'null') <> 'null' then
      v_code := 'invalid_field'; v_reason := 'target_revision: sent without target_ref';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    -- R2-4: each read-set entry is {"ref": <uuid>, "revision": <integer>}; the server fills every element itself.
    if coalesce(jsonb_typeof(p_in -> 'read_set'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'read_set') <> 'array' then
        v_code := 'invalid_field'; v_reason := 'read_set: not an array';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_entries := p_in -> 'read_set';
    end if;
    for v_i in 0 .. jsonb_array_length(v_entries) - 1 loop
      v_entry := v_entries -> v_i;
      if jsonb_typeof(v_entry) <> 'object' or coalesce(jsonb_typeof(v_entry -> 'ref'), 'null') <> 'string'
         or (v_entry ->> 'ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
        v_code := 'invalid_field';
        v_reason := 'read_set: each entry is {"ref": <uuid>, "revision": <integer>}';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if coalesce(jsonb_typeof(v_entry -> 'revision'), 'null') = 'null' then
        v_code := 'could_not_check'; v_reason := 'read_set: an entry was sent without its revision';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(v_entry -> 'revision') <> 'number' or (v_entry ->> 'revision') !~ '^[1-9][0-9]{0,8}$' then
        v_code := 'invalid_field'; v_reason := 'read_set: an entry''s revision is not an integer of at least 1';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;

    -- (e) The claim check of an effect (EV-C02-013 2.4; B 3.5; S8 line 2), on the work item the call names.
    v_check := 'claim';
    v_claim := devos_private.check_claim(p_token, v_work, v_class, false);
    if v_claim is null or (v_claim ->> 'status') is distinct from 'ok' then
      v_code := coalesce(v_claim ->> 'reason_code', 'could_not_check');
      v_reason := coalesce(v_claim ->> 'reason', 'claim: the claim check gave no answer');
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_assignment := (v_claim ->> 'assignment_id')::uuid;
    v_generation := (v_claim ->> 'generation')::integer;
    v_epoch := (v_claim ->> 'authority_epoch')::bigint;
    v_claim := null;
    if v_assignment is null or v_generation is null or v_epoch is null then
      v_code := 'could_not_check'; v_reason := 'claim: the claim check''s answer is partial';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The idempotency key (B 3.12; F01): the same key and the same full intent is the exact repeat, answered from
    -- the record before any check its first call's write would now fail (EV-C02-013 section 1 item 10, R2-9); the same
    -- key with another intent is conflict.
    v_check := 'idempotency';
    perform pg_catalog.pg_advisory_xact_lock(9006, pg_catalog.hashtext(v_ns || ':' || v_ikey));
    select o.id, o.status::text, o.effect_class, o.target, o.expected_base, o.payload_hash, o.work_ref, o.assignment_ref,
           o.generation, o.authority_epoch, o.read_set
      into v_old_id, v_old_status, v_old_class, v_old_target, v_old_base, v_old_hash, v_old_work, v_old_asg,
           v_old_gen, v_old_epoch, v_old_read
      from devos_private.operation o
     where o.idempotency_namespace = v_ns and o.idempotency_key = v_ikey
       for share;
    if v_old_id is not null then
      if v_old_status is null or v_old_class is null or v_old_target is null or v_old_hash is null or v_old_work is null
         or v_old_asg is null or v_old_gen is null or v_old_epoch is null or v_old_read is null then
        v_code := 'could_not_check'; v_reason := 'idempotency_key: the key''s record is partial';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      select (e ->> 'revision')::integer into v_old_wrev
        from jsonb_array_elements(v_old_read) e
       where e ->> 'element' = 'work'
       limit 1;
      select count(*), min(e ->> 'ref')::uuid, min((e ->> 'revision')::integer) into v_old_nt, v_old_tref, v_old_trev
        from jsonb_array_elements(v_old_read) e
       where e ->> 'element' = 'target';
      if v_old_wrev is null or v_old_nt > 1 or (v_old_nt = 1 and (v_old_tref is null or v_old_trev is null)) then
        v_code := 'could_not_check'; v_reason := 'idempotency_key: the key''s record has a partial read set';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_old_class = v_eclass and v_old_target = v_target and v_old_base is not distinct from v_base
         and v_old_hash = v_phash and v_old_work = v_work and v_old_wrev = v_wrev
         and v_old_asg = v_assignment and v_old_gen = v_generation and v_old_epoch = v_epoch
         and ((v_old_nt = 0 and v_tref is null) or (v_old_nt = 1 and v_old_tref = v_tref and v_old_trev = v_trev)) then
        v_answer := jsonb_build_object('status', 'ok', 'id', v_old_id, 'operation_status', v_old_status, 'repeat', true);
      else
        v_code := 'conflict';
        v_reason := 'idempotency_key: its record holds another intent (F01: the key is bound to the operation''s whole intent)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end if;

    if v_answer is null then
      -- (f) The effect class (B 3.12; DM-37; C-17): the server's table, never the agent.
      v_check := 'effect_class';
      select c.irreversible, c.mandatory_read_set into v_irrev, v_mandatory
        from devos_private.effect_class c where c.effect_class = v_eclass;
      if not found then
        v_code := 'could_not_check'; v_reason := 'effect_class: names no class of the effect-class table';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_irrev is null or v_mandatory is null then
        v_code := 'could_not_check'; v_reason := 'effect_class: its row is partial (irreversible or mandatory_read_set missing)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      foreach v_el in array v_mandatory loop
        if v_el is null or v_el not in ('work', 'hard_dependencies', 'claim', 'authority_epoch', 'expected_base', 'inputs') then
          v_code := 'could_not_check';
          v_reason := 'effect_class: its mandatory read set names an element this function cannot fill';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end loop;

      -- (f) The work item's revision at the effect (R2-1; F05 (c)), read under check_claim's lock on the work item.
      v_check := 'work_revision';
      select max(r.revision) into v_cur from devos_private.work_revision r where r.work_id = v_work;
      perform 1 from devos_private.work_revision r where r.work_id = v_work and r.revision = v_wrev;
      if not found or v_cur is null then
        v_code := 'could_not_check'; v_reason := 'work_revision: names no revision of the work item';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_wrev <> v_cur then
        v_code := 'stale_revision'; v_reason := 'work_revision: not the work item''s current revision';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      select r.scope, r.input_refs into v_wscope, v_inputs
        from devos_private.work_revision r where r.work_id = v_work and r.revision = v_cur;
      if v_wscope is null or v_inputs is null or jsonb_typeof(v_inputs) <> 'array' then
        v_code := 'could_not_check'; v_reason := 'work_revision: the work item''s current revision is partial';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- (f) The work item still ready (F08 (a)), the caller's own claim left out.
      v_check := 'readiness';
      v_ready := devos_private.ready_value(v_work, v_assignment);
      if v_ready is null then
        v_code := 'could_not_check'; v_reason := 'readiness: whether the work item is ready at the effect is missing or partial';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if not v_ready then
        v_code := 'not_ready';
        v_reason := 'F08: the work item is not ready at the moment of the effect (a dependency, its Mission or its execution)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- (f) The target record (R2-3; B principle 4; F05 (d)): a Work or an Artifact, at its current revision, within the
      -- work item's scope.
      if v_tref is not null then
        v_check := 'target';
        v_fam := null;
        select f.fam into v_fam
          from (select 'work'::text as fam from devos_private.work x where x.id = v_tref
                union all select 'mission' from devos_private.mission x where x.id = v_tref
                union all select 'decision' from devos_private.decision x where x.id = v_tref
                union all select 'finding' from devos_private.finding x where x.id = v_tref
                union all select 'artifact' from devos_private.artifact x where x.id = v_tref
                union all select 'need' from devos_private.need x where x.id = v_tref
                union all select 'relation' from devos_private.relation x where x.id = v_tref
                union all select 'effort_policy' from devos_private.effort_policy x where x.id = v_tref
                union all select 'assignment' from devos_private.assignment x where x.id = v_tref
                union all select 'review' from devos_private.review x where x.id = v_tref
                union all select 'verdict' from devos_private.verdict x where x.id = v_tref
                union all select 'acceptance' from devos_private.acceptance x where x.id = v_tref
                union all select 'operation' from devos_private.operation x where x.id = v_tref
                union all select 'observation' from devos_private.observation x where x.id = v_tref) f
         limit 1;
        if v_fam is null then
          v_code := 'could_not_check'; v_reason := 'target_ref: the record could not be read';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_fam not in ('work', 'artifact') then
          v_code := 'invalid_field'; v_reason := 'target_ref: names neither a Work nor an Artifact';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_fam = 'work' then
          select max(x.revision) into v_rcur from devos_private.work_revision x where x.work_id = v_tref;
          select x.scope into v_escope from devos_private.work_revision x where x.work_id = v_tref and x.revision = v_rcur;
          v_ok := exists (select 1 from devos_private.work_revision x where x.work_id = v_tref and x.revision = v_trev);
        else
          select max(x.revision) into v_rcur from devos_private.artifact_revision x where x.artifact_id = v_tref;
          select x.scope into v_escope from devos_private.artifact x where x.id = v_tref;
          v_ok := exists (select 1 from devos_private.artifact_revision x where x.artifact_id = v_tref and x.revision = v_trev);
        end if;
        if not coalesce(v_ok, false) or v_rcur is null then
          v_code := 'could_not_check'; v_reason := 'target_ref: the record could not be read';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_trev <> v_rcur then
          v_code := 'stale_revision'; v_reason := 'target_revision: not the target''s current revision';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_escope is null then
          v_code := 'could_not_check'; v_reason := 'target_ref: the target''s scope is missing (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if not coalesce(devos_private.scope_within(v_escope, v_wscope), false) then
          v_code := 'scope_outside';
          v_reason := 'target_ref: the target''s scope does not lie within the work item''s (B principle 4; F05)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;

      -- (f) The caller's read-set entries (R2-4; B principle 4; F05 (b)): each a revision of a Work, Mission, Decision,
      -- Finding or Artifact, its current revision, and (Work, Artifact, Finding) within the work item's scope.
      v_check := 'read_set';
      for v_i in 0 .. jsonb_array_length(v_entries) - 1 loop
        v_entry := v_entries -> v_i;
        v_ref := (v_entry ->> 'ref')::uuid;
        v_rev := (v_entry ->> 'revision')::integer;
        v_fam := null;
        select f.fam into v_fam
          from (select 'work'::text as fam from devos_private.work x where x.id = v_ref
                union all select 'mission' from devos_private.mission x where x.id = v_ref
                union all select 'decision' from devos_private.decision x where x.id = v_ref
                union all select 'finding' from devos_private.finding x where x.id = v_ref
                union all select 'artifact' from devos_private.artifact x where x.id = v_ref
                union all select 'need' from devos_private.need x where x.id = v_ref
                union all select 'relation' from devos_private.relation x where x.id = v_ref
                union all select 'effort_policy' from devos_private.effort_policy x where x.id = v_ref
                union all select 'assignment' from devos_private.assignment x where x.id = v_ref
                union all select 'review' from devos_private.review x where x.id = v_ref
                union all select 'verdict' from devos_private.verdict x where x.id = v_ref
                union all select 'acceptance' from devos_private.acceptance x where x.id = v_ref
                union all select 'operation' from devos_private.operation x where x.id = v_ref
                union all select 'observation' from devos_private.observation x where x.id = v_ref) f
         limit 1;
        v_rcur := null;
        v_escope := null;
        v_ok := false;
        if v_fam = 'work' then
          select max(x.revision) into v_rcur from devos_private.work_revision x where x.work_id = v_ref;
          select x.scope into v_escope from devos_private.work_revision x where x.work_id = v_ref and x.revision = v_rcur;
          v_ok := exists (select 1 from devos_private.work_revision x where x.work_id = v_ref and x.revision = v_rev);
        elsif v_fam = 'mission' then
          select max(x.revision) into v_rcur from devos_private.mission_revision x where x.mission_id = v_ref;
          v_ok := exists (select 1 from devos_private.mission_revision x where x.mission_id = v_ref and x.revision = v_rev);
        elsif v_fam = 'decision' then
          select max(x.revision) into v_rcur from devos_private.decision_revision x where x.decision_id = v_ref;
          v_ok := exists (select 1 from devos_private.decision_revision x where x.decision_id = v_ref and x.revision = v_rev);
        elsif v_fam = 'finding' then
          select max(x.revision) into v_rcur from devos_private.finding_revision x where x.finding_id = v_ref;
          select x.scope into v_escope from devos_private.finding x where x.id = v_ref;
          v_ok := exists (select 1 from devos_private.finding_revision x where x.finding_id = v_ref and x.revision = v_rev);
        elsif v_fam = 'artifact' then
          select max(x.revision) into v_rcur from devos_private.artifact_revision x where x.artifact_id = v_ref;
          select x.scope into v_escope from devos_private.artifact x where x.id = v_ref;
          v_ok := exists (select 1 from devos_private.artifact_revision x where x.artifact_id = v_ref and x.revision = v_rev);
        end if;
        if not coalesce(v_ok, false) or v_rcur is null then
          v_code := 'could_not_check'; v_reason := 'read_set: an entry''s record or revision could not be read';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_rev <> v_rcur then
          v_code := 'stale_revision'; v_reason := 'read_set: an entry names an earlier revision of its record';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_fam in ('work', 'artifact', 'finding') then
          if v_escope is null then
            v_code := 'could_not_check'; v_reason := 'read_set: an entry''s scope is missing (partial)';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if not coalesce(devos_private.scope_within(v_escope, v_wscope), false) then
            v_code := 'scope_outside';
            v_reason := 'read_set: a source''s scope does not lie within the work item''s (B principle 4; F05)';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        end if;
      end loop;

      -- (f) The class's mandatory elements the server cannot fill (B 3.12: "the agent's read set can add to the
      -- mandatory elements, never remove one"; F08 (d)).
      v_check := 'inputs';
      for v_i in 0 .. jsonb_array_length(v_inputs) - 1 loop
        v_input := v_inputs -> v_i;
        if jsonb_typeof(v_input) <> 'object' or coalesce(jsonb_typeof(v_input -> 'ref'), 'null') <> 'string'
           or (v_input ->> 'ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
          v_code := 'could_not_check'; v_reason := 'inputs: the work item''s input_refs are partial';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if 'inputs' = any (v_mandatory)
           and not exists (select 1 from jsonb_array_elements(v_entries) e where (e ->> 'ref')::uuid = (v_input ->> 'ref')::uuid) then
          v_code := 'read_set_short';
          v_reason := 'inputs: the read set has no entry for one of the work item''s inputs (F08 (d); B 3.12)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end loop;
      v_check := 'expected_base';
      if 'expected_base' = any (v_mandatory) and v_base is null then
        v_code := 'read_set_short'; v_reason := 'expected_base: the effect class''s read set needs it and the call gives none';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- (f) The elements the server fills: the work item and its revision, its current hard dependencies, the claim
      -- with its generation, the global authority epoch (read by check_claim), the expected base.
      v_check := 'hard_dependencies';
      select coalesce(jsonb_agg(jsonb_strip_nulls(jsonb_build_object('element', 'hard_dependencies', 'ref', r.id,
                                                                     'to_ref', r.to_ref, 'to_revision', r.to_revision))
                                order by r.id), '[]'::jsonb)
        into v_deps
        from devos_private.relation r
       where r.from_ref = v_work and r.type = 'depends_on' and r.hard and r.validity = 'current';
      v_set := jsonb_build_array(jsonb_build_object('element', 'work', 'ref', v_work, 'revision', v_wrev))
               || v_deps
               || jsonb_build_array(jsonb_build_object('element', 'claim', 'ref', v_assignment, 'generation', v_generation),
                                    jsonb_build_object('element', 'authority_epoch', 'epoch', v_epoch));
      if v_base is not null then
        v_set := v_set || jsonb_build_array(jsonb_build_object('element', 'expected_base', 'value', v_base));
      end if;
      if v_tref is not null then
        v_set := v_set || jsonb_build_array(jsonb_build_object('element', 'target', 'ref', v_tref, 'revision', v_trev));
      end if;
      for v_i in 0 .. jsonb_array_length(v_entries) - 1 loop
        v_entry := v_entries -> v_i;
        v_is_input := exists (select 1 from jsonb_array_elements(v_inputs) e
                               where (e ->> 'ref')::uuid = (v_entry ->> 'ref')::uuid);
        v_set := v_set || jsonb_build_array(jsonb_build_object('element', case when v_is_input then 'inputs' else 'agent' end,
                                                               'ref', (v_entry ->> 'ref')::uuid,
                                                               'revision', (v_entry ->> 'revision')::integer));
      end loop;
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  v_claim := null;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_work, v_wrev);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    insert into devos_private.operation (id, idempotency_namespace, idempotency_key, effect_class, target, expected_base,
                                         payload_hash, work_ref, assignment_ref, generation, authority_epoch, read_set,
                                         status, attempts)
    values (v_id, v_ns, v_ikey, v_eclass, v_target, v_base, v_phash, v_work, v_assignment, v_generation, v_epoch, v_set,
            'prepared', 0);
    perform devos_private.write_event('operation', v_id, null, 'operation_prepared',
      jsonb_strip_nulls(jsonb_build_object('idempotency_namespace', v_ns, 'idempotency_key', v_ikey,
        'effect_class', v_eclass, 'irreversible', v_irrev, 'target', v_target, 'expected_base', v_base,
        'payload_hash', v_phash, 'work_ref', v_work, 'work_revision', v_wrev, 'target_ref', v_tref,
        'target_revision', v_trev, 'assignment_id', v_assignment, 'generation', v_generation,
        'authority_epoch', v_epoch, 'read_set', v_set, 'status', 'prepared')),
      v_class::text, 'call', v_decl);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_work, v_wrev);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id, 'operation_status', 'prepared');
end
$fn$;

-- begin_transfer_run: its merged text (20261019120001_w09_transfer_runs_events.sql) with decision 5: lock 9005 shared, before the hand-over read (28 (4)).
create or replace function devos_api.begin_transfer_run(p jsonb)
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
    perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);
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

-- end_transfer_run: its merged text (20261019120001_w09_transfer_runs_events.sql) with decision 5: lock 9005 shared, before the hand-over read (28 (4)).
create or replace function devos_api.end_transfer_run(p jsonb)
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
    perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);
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

-- record_handover: its merged text (20261019120001_w09_transfer_runs_events.sql) with decision 5: lock 9005 exclusive, before the hand-over read (28 (4)); decision 6: the input commit compared with the run's, after the run check and before the installation's Mission (28 (6)).
create or replace function devos_api.record_handover(p jsonb)
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
  v_run_commit text;
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
    perform pg_catalog.pg_advisory_xact_lock(9005, 0);
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

    -- The run's input commit (EV-C02-013 28 (6); EV-C02-005 3.2): the input_commit of the run's first begun event.
    select e.payload ->> 'input_commit' into v_run_commit
      from devos_private.event e
     where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
     order by e.id limit 1;
    if v_run_commit is null then
      v_code := 'could_not_check'; v_reason := 'run: the begun event of the run lacks its input commit (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p_in ->> 'input_commit') <> v_run_commit then
      v_code := 'invalid_field';
      v_reason := 'input_commit: not the run''s input commit (EV-C02-005 3.2)';
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

-- transfer_event: its merged text (20261019120001_w09_transfer_runs_events.sql) with decisions 5, 2 and 6: lock 9005 shared before the hand-over read, lock 9007 on (transfer_source.kind, source ID) before the key read, the input commit compared in the run check (28 (4) to (6)); decision 7: ownership of a Work's or a Need's event, after the aggregate is found and before the ledger_state_row check (28 (7)).
create or replace function devos_api.transfer_event(p jsonb)
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
  v_run_commit text;
  v_own boolean;
  v_own_fam text;
  v_own_mission uuid;
  v_own_rev integer;
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
    perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_event: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
    perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext(v_kind || ':' || v_sid));
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

      -- The run's input commit (EV-C02-013 28 (6); EV-C02-005 3.2): the input_commit of the run's first begun event.
      select e.payload ->> 'input_commit' into v_run_commit
        from devos_private.event e
       where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
       order by e.id limit 1;
      if v_run_commit is null then
        v_code := 'could_not_check'; v_reason := 'run: the begun event of the run lacks its input commit (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if (p_in -> 'transfer_source' ->> 'input_commit') <> v_run_commit then
        v_code := 'invalid_field';
        v_reason := 'transfer_source: input_commit is not the run''s input commit (EV-C02-005 3.2)';
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

      -- Ownership (EV-C02-013 28 (7); EV-C02-018 16 decision 7, R2-2's form): a Work's or a Need's record lies under
      -- the installation's Mission (Rule O's devos_kurulum clause, as record_ledger_entry reads it). A Mission's event
      -- (ledger_state_row) is judged by the check below, as built.
      if v_agg_type in ('work', 'need') then
        v_check := 'rule_o';
        v_own_fam := v_agg_type;
        v_own_mission := null; v_own_rev := null;
        if v_own_fam = 'work' then
          select r.revision, mr.mission_id into v_own_rev, v_own_mission
            from devos_private.work_revision r
            left join devos_private.mission_revision mr on mr.id = r.mission_revision_id
           where r.work_id = v_agg
           order by r.revision desc limit 1;
          if v_own_rev is null then
            v_code := 'could_not_check'; v_reason := 'aggregate_id: the work item''s current revision is missing';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if v_own_mission is null then
            v_code := 'could_not_check'; v_reason := 'ownership: the work item''s Mission is missing';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        elsif v_own_fam = 'need' then
          select n.mission_ref into v_own_mission from devos_private.need n where n.id = v_agg;
          if v_own_mission is null then
            v_code := 'could_not_check'; v_reason := 'ownership: the need''s Mission is missing';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        end if;
        if v_own_fam in ('work', 'need') then
          v_own := devos_private.is_installation_mission(v_own_mission);
          if v_own is null then
            v_code := 'could_not_check';
            v_reason := 'ownership: whether the record lies under the installation''s Mission is missing or partial';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if not v_own then
            v_code := 'not_owner';
            v_reason := 'aggregate_id: not a record of the installation''s Mission (B section 2; R2-2''s reading)';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        end if;
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

-- transfer_artifact: its merged text (20261019120001_w09_transfer_runs_events.sql) with decisions 5, 2 and 6: lock 9005 shared before the hand-over read, lock 9007 on the function's kind and the source ID before the key read, the input commit compared in the run check (28 (4) to (6)).
create or replace function devos_api.transfer_artifact(p jsonb)
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
  v_run_commit text;
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
    perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);
    v_after := exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over');
    if v_after and not (v_kind = 'git_tree'
                        or (v_kind = 'git_file' and v_path ~ '^evidence/C[0-9]{2}/checks/CHK-C[0-9]{2}-[0-9]+[.]md$')) then
      v_code := 'handed_over';
      v_reason := 'transfer_artifact: the ledger is handed over, and this is neither a verdict file nor a tree (B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
    perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext('artifact' || ':' || v_sid));
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

        -- The run's input commit (EV-C02-013 28 (6); EV-C02-005 3.2): the input_commit of the run's first begun event.
        select e.payload ->> 'input_commit' into v_run_commit
          from devos_private.event e
         where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
         order by e.id limit 1;
        if v_run_commit is null then
          v_code := 'could_not_check'; v_reason := 'run: the begun event of the run lacks its input commit (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if (p_in -> 'transfer_source' ->> 'input_commit') <> v_run_commit then
          v_code := 'invalid_field';
          v_reason := 'transfer_source: input_commit is not the run''s input commit (EV-C02-005 3.2)';
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

-- transfer_mission: its merged text (20261019140001_w09_transfer_records.sql) with decisions 5, 2 and 6: lock 9005 shared before the hand-over read, lock 9007 on the function's kind and the source ID before the key read, the input commit compared in the run check (28 (4) to (6)); the input commit and 9007 come before 9004, which stays where it is (28 (2)).
create or replace function devos_api.transfer_mission(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'transfer_mission';
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
  v_authority uuid;
  v_authority_rev integer;
  v_constraints jsonb;
  v_status devos_private.mission_status := 'active';
  v_declared jsonb;
  v_fields jsonb;
  v_found boolean := false;
  v_prev_sha text;
  v_prev_agg uuid;
  v_prev_rev integer;
  v_partial bigint;
  v_begun bigint;
  v_done bigint;
  v_tr bigint;
  v_null bigint;
  v_dclass devos_private.decision_class;
  v_dstatus devos_private.decision_status;
  v_danswered integer;
  v_ftype text;
  v_fsrc jsonb;
  v_id uuid;
  v_mark jsonb;
  v_run_commit text;
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
      v_reason := 'transfer_mission admits only the role class devos_kurulum (B section 4, the ledger transfer)';
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
    v_sid := p_in -> 'transfer_source' ->> 'source_id';
    v_sha := p_in -> 'transfer_source' ->> 'sha256';
    if (p_in -> 'transfer_source' ->> 'kind') <> 'mission' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.kind: not mission (EV-C02-013 3.1)';
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
    v_src := jsonb_build_object('kind', 'mission', 'source_id', v_sid, 'path', p_in -> 'transfer_source' ->> 'path',
                                'input_commit', p_in -> 'transfer_source' ->> 'input_commit',
                                'last_commit', p_in -> 'transfer_source' ->> 'last_commit', 'sha256', v_sha);
    -- The Mission's fields (B 3.1).
    foreach v_key in array array['purpose', 'scope', 'acceptance', 'owner_authority'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p_in ->> 'scope') <> 'installation' then
      v_code := 'invalid_field';
      v_reason := 'scope: not installation (the installation''s Mission; EV-C02-005 1.2 row 1)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p_in ->> 'owner_authority') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'owner_authority: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_authority := (p_in ->> 'owner_authority')::uuid;
    if coalesce(jsonb_typeof(p_in -> 'owner_authority_revision'), 'null') = 'null' then
      v_code := 'could_not_check'; v_reason := 'owner_authority_revision: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'owner_authority_revision') <> 'number'
       or (p_in ->> 'owner_authority_revision') !~ '^[1-9][0-9]{0,8}$' then
      v_code := 'invalid_field'; v_reason := 'owner_authority_revision: not an integer of at least 1';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_authority_rev := (p_in ->> 'owner_authority_revision')::integer;
    v_constraints := coalesce(nullif(p_in -> 'constraints', 'null'::jsonb), '[]'::jsonb);
    if jsonb_typeof(v_constraints) <> 'array' then
      v_code := 'invalid_field'; v_reason := 'constraints: not an array';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'status'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'status') <> 'string' or (p_in ->> 'status') not in ('active', 'paused', 'closed') then
        v_code := 'invalid_field'; v_reason := 'status: not active, paused or closed';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_status := (p_in ->> 'status')::devos_private.mission_status;
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
    perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_mission: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
    perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext('mission' || ':' || v_sid));
    select e.payload -> 'transfer_source' ->> 'sha256', e.aggregate_id into v_prev_sha, v_prev_agg
      from devos_private.event e
     where e.event_type = 'transferred' and (e.payload -> 'transfer_source' ->> 'kind') = 'mission'
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
      select max(r.revision) into v_prev_rev from devos_private.mission_revision r where r.mission_id = v_prev_agg;
      if v_prev_rev is null then
        v_code := 'could_not_check'; v_reason := 'key: the transferred Mission''s revision is missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    else
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

      -- The run's input commit (EV-C02-013 28 (6); EV-C02-005 3.2): the input_commit of the run's first begun event.
      select e.payload ->> 'input_commit' into v_run_commit
        from devos_private.event e
       where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
       order by e.id limit 1;
      if v_run_commit is null then
        v_code := 'could_not_check'; v_reason := 'run: the begun event of the run lacks its input commit (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if (p_in -> 'transfer_source' ->> 'input_commit') <> v_run_commit then
        v_code := 'invalid_field';
        v_reason := 'transfer_source: input_commit is not the run''s input commit (EV-C02-005 3.2)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- One Mission (EV-C02-005 2.1): no other Mission's creation event (its first event) is transferred. Two first calls
      -- of different source IDs are ordered by one transaction-level advisory lock (key 9004), since S2's index holds one
      -- key only.
      v_check := 'installation_mission';
      perform pg_catalog.pg_advisory_xact_lock(9004, 1);
      select count(*) filter (where f.event_type = 'transferred'), count(*) filter (where f.event_type is null)
        into v_tr, v_null
        from (select distinct on (e.aggregate_id) e.aggregate_id, e.event_type
                from devos_private.event e where e.aggregate_type = 'mission'
               order by e.aggregate_id, e.id) f;
      if v_null > 0 then
        v_code := 'could_not_check';
        v_reason := 'installation_mission: a Mission''s creation event lacks its type (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_tr > 0 then
        v_code := 'conflict';
        v_reason := 'transfer_mission: a transferred Mission exists; the installation has one Mission (EV-C02-005 2.1)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- The owner authority (B 3.1; DM-23; EV-C02-013 2.2's order, R2-7 and C-20).
      v_check := 'owner_authority';
      select d.class, d.status, d.answered_revision into v_dclass, v_dstatus, v_danswered
        from devos_private.decision d where d.id = v_authority for share;
      if not found then
        v_code := 'reference_missing';
        v_reason := 'owner_authority: names no Decision written yet (EV-C02-013 3.1, "Order")';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_dclass is null or v_dstatus is null then
        v_code := 'could_not_check'; v_reason := 'owner_authority: its class or status is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_dclass <> 'batu' or v_dstatus not in ('answered', 'accepted') then
        v_code := 'mission_authority';
        v_reason := 'owner_authority: not an answered or accepted Decision of class batu (B 3.1; B:397; DM-23)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_danswered is null then
        v_code := 'could_not_check'; v_reason := 'owner_authority: answered_revision missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_danswered <> v_authority_rev then
        v_code := 'mission_authority';
        v_reason := 'owner_authority_revision: not the revision the Decision''s answer is bound to (DM-11)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      -- D-010 (R1-9; B:138): the Decision whose transferred creation event has source ID D-010.
      select e.event_type, e.payload -> 'transfer_source' into v_ftype, v_fsrc
        from devos_private.event e
       where e.aggregate_type = 'decision' and e.aggregate_id = v_authority
       order by e.id limit 1;
      if not found or v_ftype is null then
        v_code := 'could_not_check'; v_reason := 'owner_authority: the Decision''s creation event is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_ftype <> 'transferred' or (v_fsrc ->> 'kind') is distinct from 'decision'
         or (v_fsrc ->> 'source_id') is distinct from 'D-010' then
        v_code := 'mission_authority';
        v_reason := 'owner_authority: not D-010''s transferred Decision, which the installation''s Mission rests on (B:138)';
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
  if v_found then
    return jsonb_build_object('status', 'ok', 'id', v_prev_agg, 'revision', v_prev_rev, 'repeat', true);
  end if;

  -- The write block: step (g). The Mission, its revision 1 and its transferred mark (S2's index is the backstop).
  begin
    v_check := 'write';
    insert into devos_private.mission (status) values (v_status) returning id into v_id;
    insert into devos_private.mission_revision (mission_id, revision, purpose, scope, constraints, acceptance,
                                                owner_authority)
    values (v_id, 1, p_in ->> 'purpose', p_in ->> 'scope', v_constraints, p_in ->> 'acceptance', v_authority);
    v_mark := jsonb_build_object('transfer_source', v_src, 'run_id', v_run, 'lacks', '[]'::jsonb);
    if v_declared is not null then
      v_mark := v_mark || jsonb_build_object('declared', v_declared);
    end if;
    if v_fields is not null then
      v_mark := v_mark || jsonb_build_object('source_fields', v_fields);
    end if;
    perform devos_private.write_event('mission', v_id, 1, 'transferred', v_mark, v_class::text, 'call', v_decl);
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

-- transfer_work: its merged text (20261019140001_w09_transfer_records.sql) with decisions 5, 2 and 6: lock 9005 shared before the hand-over read, lock 9007 on the function's kind and the source ID before the key read, the input commit compared in the run check (28 (4) to (6)).
create or replace function devos_api.transfer_work(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'transfer_work';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_src jsonb;
  v_psrc jsonb;
  v_sid text;
  v_sha text;
  v_run text;
  v_mission uuid;
  v_mrev_n integer;
  v_mrev_id uuid;
  v_mrev_max integer;
  v_mscope text;
  v_inst boolean;
  v_within boolean;
  v_scope text;
  v_exec devos_private.work_execution;
  v_acc devos_private.work_acceptance;
  v_pol jsonb;
  v_steps jsonb;
  v_lists jsonb := '{}'::jsonb;
  v_el jsonb;
  v_ref uuid;
  v_rev integer;
  v_fam text;
  v_ok boolean;
  v_declared jsonb;
  v_fields jsonb;
  v_found boolean := false;
  v_prev_sha text;
  v_prev_agg uuid;
  v_prev_rev integer;
  v_prev_pol uuid;
  v_partial bigint;
  v_begun bigint;
  v_done bigint;
  v_id uuid;
  v_pid uuid;
  v_mark jsonb;
  v_run_commit text;
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
      v_reason := 'transfer_work admits only the role class devos_kurulum (B section 4, the ledger transfer)';
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
    v_sid := p_in -> 'transfer_source' ->> 'source_id';
    v_sha := p_in -> 'transfer_source' ->> 'sha256';
    if (p_in -> 'transfer_source' ->> 'kind') <> 'work' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.kind: not work (EV-C02-013 3.1)';
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
    v_src := jsonb_build_object('kind', 'work', 'source_id', v_sid, 'path', p_in -> 'transfer_source' ->> 'path',
                                'input_commit', p_in -> 'transfer_source' ->> 'input_commit',
                                'last_commit', p_in -> 'transfer_source' ->> 'last_commit', 'sha256', v_sha);
    v_psrc := v_src || jsonb_build_object('kind', 'effort_policy');
    -- The Work's fields (B 3.3; EV-C02-005 1.2 rows 2 and 3, 1.4).
    if coalesce(jsonb_typeof(p_in -> 'mission_ref'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'mission_ref: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'mission_ref') <> 'string'
       or (p_in ->> 'mission_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'mission_ref: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_mission := (p_in ->> 'mission_ref')::uuid;
    if coalesce(jsonb_typeof(p_in -> 'mission_revision'), 'null') = 'null' then
      v_code := 'could_not_check'; v_reason := 'mission_revision: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'mission_revision') <> 'number' or (p_in ->> 'mission_revision') !~ '^[1-9][0-9]{0,8}$' then
      v_code := 'invalid_field'; v_reason := 'mission_revision: not an integer of at least 1';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_mrev_n := (p_in ->> 'mission_revision')::integer;
    foreach v_key in array array['scope', 'purpose', 'impact_class', 'execution', 'acceptance'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p_in ->> 'scope') <> 'installation' then
      v_code := 'invalid_field';
      v_reason := 'scope: not installation (a transferred stage or item; EV-C02-005 1.2 rows 2 and 3)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_scope := p_in ->> 'scope';
    if (p_in ->> 'impact_class') <> 'high' then
      v_code := 'invalid_field';
      v_reason := 'impact_class: not high (every transferred Work is high; EV-C02-005 1.4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p_in ->> 'execution') not in ('planned', 'ready', 'running', 'waiting', 'finished', 'cancelled') then
      v_code := 'invalid_field'; v_reason := 'execution: not one of B 3.3''s values';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_exec := (p_in ->> 'execution')::devos_private.work_execution;
    if (p_in ->> 'acceptance') not in ('proposed', 'accepted', 'rejected') then
      v_code := 'invalid_field'; v_reason := 'acceptance: not proposed, accepted or rejected';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_acc := (p_in ->> 'acceptance')::devos_private.work_acceptance;
    foreach v_key in array array['acceptance_ref', 'consumer', 'return_to', 'stop_rule'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    foreach v_key in array array['input_refs', 'target_refs', 'method_refs', 'mandatory_needs'] loop
      v_el := coalesce(nullif(p_in -> v_key, 'null'::jsonb), '[]'::jsonb);
      if jsonb_typeof(v_el) <> 'array' then
        v_code := 'invalid_field'; v_reason := v_key || ': not an array';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_lists := v_lists || jsonb_build_object(v_key, v_el);
    end loop;
    -- R2-4: each element of input_refs and target_refs is {"ref": <uuid>, "revision": <integer>}.
    foreach v_key in array array['input_refs', 'target_refs'] loop
      for v_el in select x from pg_catalog.jsonb_array_elements(v_lists -> v_key) x loop
        if jsonb_typeof(v_el) <> 'object' or jsonb_typeof(v_el -> 'ref') is distinct from 'string'
           or (v_el ->> 'ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
           or jsonb_typeof(v_el -> 'revision') is distinct from 'number'
           or (v_el ->> 'revision') !~ '^[1-9][0-9]{0,8}$' then
          v_code := 'invalid_field'; v_reason := v_key || ': each element is {ref: a uuid, revision: an integer of at least 1}';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end loop;
    end loop;
    -- The item's own EffortPolicy (B 3.18's transferred bullet; EV-C02-005 2.1).
    if coalesce(jsonb_typeof(p_in -> 'effort_policy'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'effort_policy: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'effort_policy') <> 'object' then
      v_code := 'invalid_field'; v_reason := 'effort_policy: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_pol := p_in -> 'effort_policy';
    foreach v_key in array array['level', 'expert_assessment_ref', 'non_removable_steps'] loop
      if coalesce(jsonb_typeof(v_pol -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := 'effort_policy.' || v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if jsonb_typeof(v_pol -> 'level') <> 'string' or (v_pol ->> 'level') <> 'high' then
      v_code := 'invalid_field';
      v_reason := 'effort_policy.level: not high (a transferred policy has no reduction; EV-C02-005 2.1; B 3.18)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(v_pol -> 'expert_assessment_ref') <> 'string' then
      v_code := 'invalid_field'; v_reason := 'effort_policy.expert_assessment_ref: not a string';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(v_pol -> 'non_removable_steps') <> 'array' then
      v_code := 'invalid_field'; v_reason := 'effort_policy.non_removable_steps: not an array';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_steps := v_pol -> 'non_removable_steps';
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
    perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_work: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the Work's mark; the exact repeat answers the Work and its policy.
    v_check := 'key';
    perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext('work' || ':' || v_sid));
    select e.payload -> 'transfer_source' ->> 'sha256', e.aggregate_id into v_prev_sha, v_prev_agg
      from devos_private.event e
     where e.event_type = 'transferred' and (e.payload -> 'transfer_source' ->> 'kind') = 'work'
       and (e.payload -> 'transfer_source' ->> 'source_id') = v_sid
     order by e.id limit 1;
    v_found := found;
    select e.aggregate_id into v_prev_pol
      from devos_private.event e
     where e.event_type = 'transferred' and (e.payload -> 'transfer_source' ->> 'kind') = 'effort_policy'
       and (e.payload -> 'transfer_source' ->> 'source_id') = v_sid
     order by e.id limit 1;
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
      select max(r.revision) into v_prev_rev from devos_private.work_revision r where r.work_id = v_prev_agg;
      if v_prev_rev is null or v_prev_pol is null then
        v_code := 'could_not_check';
        v_reason := 'key: the transferred Work''s revision or its EffortPolicy''s mark is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    else
      if v_prev_pol is not null then
        v_code := 'could_not_check';
        v_reason := 'key: the source''s EffortPolicy mark exists without its Work''s (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
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

      -- The run's input commit (EV-C02-013 28 (6); EV-C02-005 3.2): the input_commit of the run's first begun event.
      select e.payload ->> 'input_commit' into v_run_commit
        from devos_private.event e
       where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
       order by e.id limit 1;
      if v_run_commit is null then
        v_code := 'could_not_check'; v_reason := 'run: the begun event of the run lacks its input commit (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if (p_in -> 'transfer_source' ->> 'input_commit') <> v_run_commit then
        v_code := 'invalid_field';
        v_reason := 'transfer_source: input_commit is not the run''s input commit (EV-C02-005 3.2)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- The installation's Mission (3.2; B 3.3) and the revision named, locked for share.
      v_check := 'mission_ref';
      perform 1 from devos_private.mission m where m.id = v_mission for share;
      if not found then
        v_code := 'reference_missing';
        v_reason := 'mission_ref: names no Mission written yet (EV-C02-013 3.1, "Order")';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_check := 'installation_mission';
      v_inst := devos_private.is_installation_mission(v_mission);
      if v_inst is null then
        v_code := 'could_not_check';
        v_reason := 'installation_mission: whether the Mission is the installation''s is missing or partial';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if not v_inst then
        v_code := 'invalid_field';
        v_reason := 'mission_ref: not the installation''s Mission (EV-C02-013 3.2; B 3.3)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_check := 'mission_revision';
      select r.id, r.scope into v_mrev_id, v_mscope
        from devos_private.mission_revision r where r.mission_id = v_mission and r.revision = v_mrev_n;
      if v_mrev_id is null then
        v_code := 'reference_missing';
        v_reason := 'mission_revision: names no revision of the Mission written yet (EV-C02-013 3.1, "Order")';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      select max(r.revision) into v_mrev_max from devos_private.mission_revision r where r.mission_id = v_mission;
      if v_mrev_n < v_mrev_max then
        v_code := 'stale_revision'; v_reason := 'mission_revision: not the Mission''s current revision';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_within := devos_private.scope_within(v_scope, v_mscope);
      if v_within is null then
        v_code := 'could_not_check'; v_reason := 'mission_revision: its scope is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if not v_within then
        v_code := 'scope_outside'; v_reason := 'scope: not within the Mission''s scope (B principle 4)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- The records input_refs and target_refs name (R2-4): a Work, an Artifact, a Finding or a Decision, at a
      -- revision it has.
      foreach v_key in array array['input_refs', 'target_refs'] loop
        v_check := v_key;
        for v_el in select x from pg_catalog.jsonb_array_elements(v_lists -> v_key) x loop
          v_ref := (v_el ->> 'ref')::uuid;
          v_rev := (v_el ->> 'revision')::integer;
          v_fam := null;
          select f.fam into v_fam
            from (select 'work'::text as fam from devos_private.work x where x.id = v_ref
                  union all select 'mission' from devos_private.mission x where x.id = v_ref
                  union all select 'decision' from devos_private.decision x where x.id = v_ref
                  union all select 'finding' from devos_private.finding x where x.id = v_ref
                  union all select 'artifact' from devos_private.artifact x where x.id = v_ref
                  union all select 'need' from devos_private.need x where x.id = v_ref
                  union all select 'relation' from devos_private.relation x where x.id = v_ref
                  union all select 'effort_policy' from devos_private.effort_policy x where x.id = v_ref
                  union all select 'assignment' from devos_private.assignment x where x.id = v_ref
                  union all select 'review' from devos_private.review x where x.id = v_ref
                  union all select 'verdict' from devos_private.verdict x where x.id = v_ref
                  union all select 'acceptance' from devos_private.acceptance x where x.id = v_ref
                  union all select 'operation' from devos_private.operation x where x.id = v_ref
                  union all select 'observation' from devos_private.observation x where x.id = v_ref) f
           limit 1;
          if v_fam is null then
            v_code := 'reference_missing';
            v_reason := v_key || ': an element names no record written yet (EV-C02-013 3.1, "Order")';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if v_fam not in ('work', 'artifact', 'finding', 'decision') then
            v_code := 'invalid_field';
            v_reason := v_key || ': an element names a record that is not a Work, an Artifact, a Finding or a Decision';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          v_ok := case v_fam
            when 'work' then
              exists (select 1 from devos_private.work_revision x where x.work_id = v_ref and x.revision = v_rev)
            when 'decision' then
              exists (select 1 from devos_private.decision_revision x where x.decision_id = v_ref and x.revision = v_rev)
            when 'finding' then
              exists (select 1 from devos_private.finding_revision x where x.finding_id = v_ref and x.revision = v_rev)
            else
              exists (select 1 from devos_private.artifact_revision x where x.artifact_id = v_ref and x.revision = v_rev)
          end;
          if not coalesce(v_ok, false) then
            v_code := 'reference_missing';
            v_reason := v_key || ': an element names a revision not written yet (EV-C02-013 3.1, "Order")';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        end loop;
      end loop;
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
    return jsonb_build_object('status', 'ok', 'id', v_prev_agg, 'revision', v_prev_rev, 'effort_policy_id', v_prev_pol,
                              'repeat', true);
  end if;

  -- The write block: step (g). The Work, its EffortPolicy, its revision 1, and the two transferred marks.
  begin
    v_check := 'write';
    insert into devos_private.work (execution, acceptance) values (v_exec, v_acc) returning id into v_id;
    insert into devos_private.effort_policy (work_ref, level, expert_assessment_ref, non_removable_steps)
    values (v_id, 'high', v_pol ->> 'expert_assessment_ref', v_steps) returning id into v_pid;
    insert into devos_private.work_revision (work_id, revision, mission_revision_id, scope, purpose, input_refs,
                                             target_refs, consumer, return_to, stop_rule, acceptance_ref, impact_class,
                                             method_refs, mandatory_needs)
    values (v_id, 1, v_mrev_id, v_scope, p_in ->> 'purpose', v_lists -> 'input_refs', v_lists -> 'target_refs',
            p_in ->> 'consumer', p_in ->> 'return_to', p_in ->> 'stop_rule', p_in ->> 'acceptance_ref', 'high',
            v_lists -> 'method_refs', v_lists -> 'mandatory_needs');
    v_mark := jsonb_build_object('transfer_source', v_src, 'run_id', v_run, 'lacks', '[]'::jsonb);
    if v_declared is not null then
      v_mark := v_mark || jsonb_build_object('declared', v_declared);
    end if;
    if v_fields is not null then
      v_mark := v_mark || jsonb_build_object('source_fields', v_fields);
    end if;
    perform devos_private.write_event('work', v_id, 1, 'transferred', v_mark, v_class::text, 'call', v_decl);
    perform devos_private.write_event('effort_policy', v_pid, null, 'transferred',
      jsonb_build_object('transfer_source', v_psrc, 'run_id', v_run,
                         'lacks', '["alternatives_research", "external_source_research"]'::jsonb),
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
  return jsonb_build_object('status', 'ok', 'id', v_id, 'revision', 1, 'effort_policy_id', v_pid);
end
$fn$;

-- transfer_relation: its merged text (20261019140001_w09_transfer_records.sql) with decisions 5, 2 and 6 as transfer_event's, with the kind relation (28 (4) to (6)); the input commit comes before 9001; decision 7: ownership of both ends after the ends loop and before the group (28 (8)).
create or replace function devos_api.transfer_relation(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'transfer_relation';
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
  v_type devos_private.relation_type;
  v_from uuid;
  v_to uuid;
  v_from_rev integer;
  v_to_rev integer;
  v_scope text;
  v_hard boolean := false;
  v_gid uuid;
  v_gmode devos_private.group_mode;
  v_use text;
  v_method devos_private.relation_method;
  v_estatus devos_private.epistemic_status;
  v_validity devos_private.relation_validity := 'current';
  v_dep boolean := false;
  v_cycle boolean;
  v_end text;
  v_ref uuid;
  v_rev integer;
  v_fam text;
  v_ok boolean;
  v_n bigint;
  v_same uuid;
  v_declared jsonb;
  v_fields jsonb;
  v_found boolean := false;
  v_prev_sha text;
  v_prev_agg uuid;
  v_partial bigint;
  v_begun bigint;
  v_done bigint;
  v_id uuid;
  v_mark jsonb;
  v_run_commit text;
  v_own boolean;
  v_own_fam text;
  v_own_mission uuid;
  v_own_rev integer;
  v_ctype text;
  v_cclass text;
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
      v_reason := 'transfer_relation admits only the role class devos_kurulum (B section 4, the ledger transfer)';
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
    v_sid := p_in -> 'transfer_source' ->> 'source_id';
    v_sha := p_in -> 'transfer_source' ->> 'sha256';
    if (p_in -> 'transfer_source' ->> 'kind') <> 'relation' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.kind: not relation (EV-C02-013 3.1)';
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
    v_src := jsonb_build_object('kind', 'relation', 'source_id', v_sid, 'path', p_in -> 'transfer_source' ->> 'path',
                                'input_commit', p_in -> 'transfer_source' ->> 'input_commit',
                                'last_commit', p_in -> 'transfer_source' ->> 'last_commit', 'sha256', v_sha);
    -- The Relation's fields (B 3.4), as relate reads them (EV-C02-013 2.5, 19 (1)).
    foreach v_key in array array['type', 'from_ref', 'to_ref', 'scope', 'method', 'epistemic_status'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_key in ('from_ref', 'to_ref') and jsonb_typeof(p_in -> v_key) in ('number', 'object') then
        v_code := 'invalid_field';
        v_reason := v_key || ': not a uuid (an end that is an Event is not built; EV-C02-013 section 12)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p_in ->> 'type') not in ('depends_on', 'supports', 'challenges', 'derived_from', 'supersedes', 'uses', 'part_of',
                                 'reviews', 'blocks_effect', 'about') then
      v_code := 'invalid_field';
      v_reason := 'type: not a relation type of Appendix B 3.4 (informed_of comes with its own fields in C06)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_type := (p_in ->> 'type')::devos_private.relation_type;
    foreach v_key in array array['from_ref', 'to_ref'] loop
      if (p_in ->> v_key) !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a uuid';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    v_from := (p_in ->> 'from_ref')::uuid;
    v_to := (p_in ->> 'to_ref')::uuid;
    foreach v_key in array array['from_revision', 'to_revision'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') <> 'null'
         and (jsonb_typeof(p_in -> v_key) <> 'number' or (p_in ->> v_key) !~ '^[1-9][0-9]{0,8}$') then
        v_code := 'invalid_field'; v_reason := v_key || ': not an integer of at least 1';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if jsonb_typeof(p_in -> 'from_revision') = 'number' then
      v_from_rev := (p_in ->> 'from_revision')::integer;
    end if;
    if jsonb_typeof(p_in -> 'to_revision') = 'number' then
      v_to_rev := (p_in ->> 'to_revision')::integer;
    end if;
    if (p_in ->> 'scope') <> 'installation' then
      v_code := 'invalid_field';
      v_reason := 'scope: not installation (a transferred link; EV-C02-005 3.3)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_scope := p_in ->> 'scope';
    if coalesce(jsonb_typeof(p_in -> 'hard'), 'null') not in ('null', 'boolean') then
      v_code := 'invalid_field'; v_reason := 'hard: not a boolean';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_hard := coalesce((p_in ->> 'hard')::boolean, false);
    if coalesce(jsonb_typeof(p_in -> 'use'), 'null') not in ('null', 'string') then
      v_code := 'invalid_field'; v_reason := 'use: not a string';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_use := p_in ->> 'use';
    if (p_in ->> 'method') not in ('mechanical', 'model_extracted', 'recorded') then
      v_code := 'invalid_field'; v_reason := 'method: not mechanical, model_extracted or recorded';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_method := (p_in ->> 'method')::devos_private.relation_method;
    if (p_in ->> 'epistemic_status') not in ('observation', 'user_decision', 'inference', 'hypothesis', 'proposal') then
      v_code := 'invalid_field';
      v_reason := 'epistemic_status: not observation, user_decision, inference, hypothesis or proposal';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_estatus := (p_in ->> 'epistemic_status')::devos_private.epistemic_status;
    if coalesce(jsonb_typeof(p_in -> 'validity'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'validity') <> 'string' or (p_in ->> 'validity') not in ('current', 'stale', 'retracted') then
        v_code := 'invalid_field'; v_reason := 'validity: not current, stale or retracted';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_validity := (p_in ->> 'validity')::devos_private.relation_validity;
    end if;
    -- The group keys (R2-5): group_mode alone makes a group of its own; group_id needs group_mode.
    if coalesce(jsonb_typeof(p_in -> 'group_mode'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'group_mode') <> 'string' or (p_in ->> 'group_mode') not in ('ALL', 'ANY') then
        v_code := 'invalid_field'; v_reason := 'group_mode: not ALL or ANY';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_gmode := (p_in ->> 'group_mode')::devos_private.group_mode;
    end if;
    if coalesce(jsonb_typeof(p_in -> 'group_id'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'group_id') <> 'string'
         or (p_in ->> 'group_id') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
        v_code := 'invalid_field'; v_reason := 'group_id: not a uuid';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_gmode is null then
        v_code := 'missing_field'; v_reason := 'group_mode: missing (group_id is sent without it)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_gid := (p_in ->> 'group_id')::uuid;
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
    -- Relation's rule (B 3.4, PC-16 place 13; W-C02-09 point 6); the table's check is the backstop.
    if v_method = 'model_extracted' and v_estatus = 'observation' then
      v_code := 'relation_rule';
      v_reason := 'B 3.4: a relation with method model_extracted cannot have epistemic_status observation';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The closing rule (B:397).
    v_check := 'handover';
    perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_relation: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
    perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext('relation' || ':' || v_sid));
    select e.payload -> 'transfer_source' ->> 'sha256', e.aggregate_id into v_prev_sha, v_prev_agg
      from devos_private.event e
     where e.event_type = 'transferred' and (e.payload -> 'transfer_source' ->> 'kind') = 'relation'
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
    else
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

      -- The run's input commit (EV-C02-013 28 (6); EV-C02-005 3.2): the input_commit of the run's first begun event.
      select e.payload ->> 'input_commit' into v_run_commit
        from devos_private.event e
       where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
       order by e.id limit 1;
      if v_run_commit is null then
        v_code := 'could_not_check'; v_reason := 'run: the begun event of the run lacks its input commit (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if (p_in -> 'transfer_source' ->> 'input_commit') <> v_run_commit then
        v_code := 'invalid_field';
        v_reason := 'transfer_source: input_commit is not the run''s input commit (EV-C02-005 3.2)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- DM-01: a hard dependency's write first takes the one advisory lock (in the helper), then checks for a cycle,
      -- before any row lock. The answer is used after the ends, the group and the repeat.
      v_dep := v_type = 'depends_on' and v_hard;
      if v_dep then
        v_check := 'cycle';
        v_cycle := devos_private.hard_dependency_cycle(v_from, v_to);
      end if;

      -- (f) The two ends (3.1, "Order"): each a record written, with the revision it needs.
      foreach v_end in array array['from_ref', 'to_ref'] loop
        v_check := v_end;
        if v_end = 'from_ref' then
          v_ref := v_from; v_rev := v_from_rev;
        else
          v_ref := v_to; v_rev := v_to_rev;
        end if;
        v_fam := null;
        select f.fam into v_fam
          from (select 'work'::text as fam from devos_private.work x where x.id = v_ref
                union all select 'mission' from devos_private.mission x where x.id = v_ref
                union all select 'decision' from devos_private.decision x where x.id = v_ref
                union all select 'finding' from devos_private.finding x where x.id = v_ref
                union all select 'artifact' from devos_private.artifact x where x.id = v_ref
                union all select 'need' from devos_private.need x where x.id = v_ref
                union all select 'relation' from devos_private.relation x where x.id = v_ref
                union all select 'effort_policy' from devos_private.effort_policy x where x.id = v_ref
                union all select 'assignment' from devos_private.assignment x where x.id = v_ref
                union all select 'review' from devos_private.review x where x.id = v_ref
                union all select 'verdict' from devos_private.verdict x where x.id = v_ref
                union all select 'acceptance' from devos_private.acceptance x where x.id = v_ref
                union all select 'operation' from devos_private.operation x where x.id = v_ref
                union all select 'observation' from devos_private.observation x where x.id = v_ref) f
         limit 1;
        if v_fam is null then
          v_code := 'reference_missing';
          v_reason := v_end || ': names no record written yet (EV-C02-013 3.1, "Order")';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_fam not in ('work', 'mission', 'decision', 'finding', 'artifact') then
          if v_rev is not null then
            v_code := 'invalid_field'; v_reason := v_end || ': a revision is sent for a record that has no revisions';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        else
          if v_rev is null then
            v_code := 'could_not_check'; v_reason := v_end || ': the record''s revision is missing (partial)';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          v_ok := case v_fam
            when 'work' then
              exists (select 1 from devos_private.work_revision x where x.work_id = v_ref and x.revision = v_rev)
            when 'mission' then
              exists (select 1 from devos_private.mission_revision x where x.mission_id = v_ref and x.revision = v_rev)
            when 'decision' then
              exists (select 1 from devos_private.decision_revision x where x.decision_id = v_ref and x.revision = v_rev)
            when 'finding' then
              exists (select 1 from devos_private.finding_revision x where x.finding_id = v_ref and x.revision = v_rev)
            else
              exists (select 1 from devos_private.artifact_revision x where x.artifact_id = v_ref and x.revision = v_rev)
          end;
          if not coalesce(v_ok, false) then
            v_code := 'reference_missing';
            v_reason := v_end || ': names a revision not written yet (EV-C02-013 3.1, "Order")';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        end if;
        if v_end = 'from_ref' then
          -- The row of from_ref's record, locked for update, as relate locks it (EV-C02-013 19 (1)).
          if v_fam = 'work' then perform 1 from devos_private.work x where x.id = v_ref for update;
          elsif v_fam = 'mission' then perform 1 from devos_private.mission x where x.id = v_ref for update;
          elsif v_fam = 'decision' then perform 1 from devos_private.decision x where x.id = v_ref for update;
          elsif v_fam = 'finding' then perform 1 from devos_private.finding x where x.id = v_ref for update;
          elsif v_fam = 'artifact' then perform 1 from devos_private.artifact x where x.id = v_ref for update;
          elsif v_fam = 'need' then perform 1 from devos_private.need x where x.id = v_ref for update;
          elsif v_fam = 'relation' then perform 1 from devos_private.relation x where x.id = v_ref for update;
          elsif v_fam = 'effort_policy' then perform 1 from devos_private.effort_policy x where x.id = v_ref for update;
          elsif v_fam = 'assignment' then perform 1 from devos_private.assignment x where x.id = v_ref for update;
          elsif v_fam = 'review' then perform 1 from devos_private.review x where x.id = v_ref for update;
          elsif v_fam = 'verdict' then perform 1 from devos_private.verdict x where x.id = v_ref for update;
          elsif v_fam = 'acceptance' then perform 1 from devos_private.acceptance x where x.id = v_ref for update;
          elsif v_fam = 'operation' then perform 1 from devos_private.operation x where x.id = v_ref for update;
          else perform 1 from devos_private.observation x where x.id = v_ref for update;
          end if;
        end if;
      end loop;

      -- Ownership (EV-C02-013 28 (8); EV-C02-018 16 decision 7, R2-2's form), after both ends are found: from_ref
      -- first, then to_ref. A Work, a Need or a Mission lies under the installation's Mission; a Decision was opened
      -- or transferred by devos_kurulum (its creation event, its first event). Other families are not judged.
      v_check := 'rule_o';
      foreach v_end in array array['from_ref', 'to_ref'] loop
        if v_end = 'from_ref' then
          v_ref := v_from;
        else
          v_ref := v_to;
        end if;
        v_own_fam := case
          when exists (select 1 from devos_private.work x where x.id = v_ref) then 'work'
          when exists (select 1 from devos_private.need x where x.id = v_ref) then 'need'
          when exists (select 1 from devos_private.mission x where x.id = v_ref) then 'mission'
          when exists (select 1 from devos_private.decision x where x.id = v_ref) then 'decision'
        end;
        v_own_mission := null; v_own_rev := null;
        if v_own_fam = 'work' then
          select r.revision, mr.mission_id into v_own_rev, v_own_mission
            from devos_private.work_revision r
            left join devos_private.mission_revision mr on mr.id = r.mission_revision_id
           where r.work_id = v_ref
           order by r.revision desc limit 1;
          if v_own_rev is null then
            v_code := 'could_not_check'; v_reason := v_end || ': the work item''s current revision is missing';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if v_own_mission is null then
            v_code := 'could_not_check'; v_reason := v_end || ': the work item''s Mission is missing';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        elsif v_own_fam = 'need' then
          select n.mission_ref into v_own_mission from devos_private.need n where n.id = v_ref;
          if v_own_mission is null then
            v_code := 'could_not_check'; v_reason := v_end || ': the need''s Mission is missing';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        elsif v_own_fam = 'mission' then
          v_own_mission := v_ref;
        end if;
        if v_own_fam in ('work', 'need', 'mission') then
          v_own := devos_private.is_installation_mission(v_own_mission);
          if v_own is null then
            v_code := 'could_not_check';
            v_reason := v_end || ': whether the record lies under the installation''s Mission is missing or partial';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if not v_own then
            v_code := 'not_owner';
            v_reason := v_end || ': not a record of the installation''s Mission (B section 2; R2-2''s reading)';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        elsif v_own_fam = 'decision' then
          v_ctype := null; v_cclass := null;
          select e.event_type, e.role_class into v_ctype, v_cclass from devos_private.event e
           where e.aggregate_type = 'decision' and e.aggregate_id = v_ref order by e.id limit 1;
          if v_ctype is null or v_cclass is null or v_ctype not in ('decision_opened', 'transferred') then
            v_code := 'could_not_check'; v_reason := v_end || ': the Decision''s creation event is missing (partial)';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if v_cclass <> 'devos_kurulum' then
            v_code := 'not_owner';
            v_reason := v_end || ': a decision the installation did not open or transfer (B section 2; R2-2''s reading)';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        end if;
      end loop;

      -- (f) The group: one from_ref and one mode (B principle 6).
      if v_gid is not null then
        v_check := 'group';
        select count(*) into v_n
          from devos_private.relation r
         where r.group_id = v_gid and r.validity = 'current'
           and (r.from_ref is distinct from v_from or r.group_mode is distinct from v_gmode);
        if v_n > 0 then
          v_code := 'invalid_field';
          v_reason := 'group_id: held by a current relation with another from_ref or the other group_mode';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;

      -- B 3.4: an exact repeat of the same relation makes no new record. One already current, not written under this
      -- key, is refused rather than doubled or marked a second time.
      v_check := 'repeat';
      select r.id into v_same
        from devos_private.relation r
       where r.from_ref = v_from and r.to_ref = v_to and r.type = v_type and r.validity = 'current'
         and r.from_revision is not distinct from v_from_rev and r.to_revision is not distinct from v_to_rev
         and r.hard = v_hard and r.use is not distinct from v_use
         and ((v_gid is not null and r.group_id = v_gid and r.group_mode = v_gmode)
              or (v_gid is null and v_gmode is not null and r.group_id = r.id and r.group_mode = v_gmode)
              or (v_gid is null and v_gmode is null and r.group_id is null))
       limit 1;
      if v_same is not null then
        v_code := 'conflict';
        v_reason := 'a current relation with the same type, ends, revisions, hard, group and use exists (B 3.4)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- (f) The cycle (B 3.4: "In hard dependencies a cycle is rejected"), read above under the lock.
      if v_dep then
        v_check := 'cycle';
        if v_cycle is null then
          v_code := 'could_not_check';
          v_reason := 'cycle: whether the hard dependency closes a cycle is missing or partial';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_cycle then
          v_code := 'cycle'; v_reason := 'B 3.4: the hard dependency would close a cycle';
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
    return jsonb_build_object('status', 'ok', 'id', v_prev_agg, 'repeat', true);
  end if;

  -- The write block: step (g). The Relation and its transferred mark (S2's index is the backstop).
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    if v_gid is null and v_gmode is not null then
      v_gid := v_id;
    end if;
    insert into devos_private.relation (id, type, from_ref, from_revision, to_ref, to_revision, scope, hard, group_id,
                                        group_mode, validity, use, method, epistemic_status)
    values (v_id, v_type, v_from, v_from_rev, v_to, v_to_rev, v_scope, v_hard, v_gid, v_gmode, v_validity, v_use,
            v_method, v_estatus);
    v_mark := jsonb_build_object('transfer_source', v_src, 'run_id', v_run, 'lacks', '[]'::jsonb);
    if v_declared is not null then
      v_mark := v_mark || jsonb_build_object('declared', v_declared);
    end if;
    if v_fields is not null then
      v_mark := v_mark || jsonb_build_object('source_fields', v_fields);
    end if;
    perform devos_private.write_event('relation', v_id, null, 'transferred', v_mark, v_class::text, 'call', v_decl);
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

-- transfer_decision: its merged text (20261019140001_w09_transfer_records.sql) with decisions 5, 2 and 6: lock 9005 shared before the hand-over read, lock 9007 on the function's kind and the source ID before the key read, the input commit compared in the run check (28 (4) to (6)).
create or replace function devos_api.transfer_decision(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'transfer_decision';
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
  v_dclass devos_private.decision_class;
  v_status devos_private.decision_status;
  v_alt devos_private.alternatives_state;
  v_answered_at timestamptz;
  v_answered_rev integer;
  v_lacks jsonb;
  v_declared jsonb;
  v_fields jsonb;
  v_found boolean := false;
  v_prev_sha text;
  v_prev_agg uuid;
  v_prev_rev integer;
  v_partial bigint;
  v_begun bigint;
  v_done bigint;
  v_id uuid;
  v_mark jsonb;
  v_run_commit text;
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
      v_reason := 'transfer_decision admits only the role class devos_kurulum (B section 4, the ledger transfer)';
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
    v_sid := p_in -> 'transfer_source' ->> 'source_id';
    v_sha := p_in -> 'transfer_source' ->> 'sha256';
    if (p_in -> 'transfer_source' ->> 'kind') <> 'decision' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.kind: not decision (EV-C02-013 3.1)';
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
    v_src := jsonb_build_object('kind', 'decision', 'source_id', v_sid, 'path', p_in -> 'transfer_source' ->> 'path',
                                'input_commit', p_in -> 'transfer_source' ->> 'input_commit',
                                'last_commit', p_in -> 'transfer_source' ->> 'last_commit', 'sha256', v_sha);
    -- The Decision's fields (B 3.17; EV-C02-005 2.2).
    foreach v_key in array array['class', 'question', 'status'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p_in ->> 'class') = 'routine' then
      v_code := 'invalid_field';
      v_reason := 'class: routine (a transferred decision is high_impact or batu; EV-C02-005 2.2)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p_in ->> 'class') not in ('high_impact', 'batu') then
      v_code := 'invalid_field'; v_reason := 'class: not high_impact or batu';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_dclass := (p_in ->> 'class')::devos_private.decision_class;
    if (p_in ->> 'status') not in ('answered', 'accepted', 'declined', 'superseded', 'withdrawn', 'open') then
      v_code := 'invalid_field';
      v_reason := 'status: not answered, accepted, declined, superseded, withdrawn or open (the recorded status)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_status := (p_in ->> 'status')::devos_private.decision_status;
    foreach v_key in array array['presented_text_tr', 'why_this_owner', 'single_viable_path_reason', 'reversibility',
                                 'recommendation', 'recommendation_rationale', 'if_unanswered', 'alternatives_state',
                                 'answer_original_tr', 'answer_interpretation_en', 'answered_by', 'answer_channel_ref',
                                 'answered_at'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if jsonb_typeof(p_in -> 'alternatives_state') = 'string' then
      if (p_in ->> 'alternatives_state') not in ('compared', 'single_viable_path', 'open_exploration') then
        v_code := 'invalid_field'; v_reason := 'alternatives_state: not compared, single_viable_path or open_exploration';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_alt := (p_in ->> 'alternatives_state')::devos_private.alternatives_state;
    end if;
    -- answered_at (CHK-C02-104 C1; EV-C02-013 26 (5)): the text is matched before any cast, so that PostgreSQL's
    -- special inputs (now, today, tomorrow, yesterday, infinity, -infinity, epoch) and a date-time without an offset
    -- are refused. A date-time carries Z or an explicit offset; a bare date is read as 00:00 UTC. Neither reading
    -- depends on the session's TimeZone or DateStyle. The value cast must be finite.
    if jsonb_typeof(p_in -> 'answered_at') = 'string' then
      begin
        if (p_in ->> 'answered_at') ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' then
          v_answered_at := ((p_in ->> 'answered_at') || 'T00:00:00Z')::timestamptz;
        elsif (p_in ->> 'answered_at')
              ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}[T ][0-9]{2}:[0-9]{2}(:[0-9]{2}([.][0-9]{1,6})?)?(Z|[+-][0-9]{2}(:?[0-9]{2})?)$' then
          v_answered_at := (p_in ->> 'answered_at')::timestamptz;
        end if;
      exception when others then
        v_answered_at := null;
      end;
      if v_answered_at is null or not isfinite(v_answered_at) then
        v_code := 'invalid_field';
        v_reason := 'answered_at: not a finite date (YYYY-MM-DD, read as 00:00 UTC) or date-time with Z or an offset';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
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
    -- B 3.17 (plan K-3 item 2): a decision in open_exploration cannot be answered or accepted until the compared
    -- options or single_viable_path_reason are entered.
    if v_alt = 'open_exploration' and v_status in ('answered', 'accepted')
       and (coalesce(jsonb_typeof(p_in -> 'options'), 'null') = 'null'
            or p_in -> 'options' in ('[]'::jsonb, '{}'::jsonb, '""'::jsonb))
       and coalesce(btrim(p_in ->> 'single_viable_path_reason'), '') = '' then
      v_code := 'open_exploration';
      v_reason := 'B 3.17: a decision in open_exploration is not answered or accepted before its options or '
                  || 'single_viable_path_reason are entered';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    -- DM-11; EV-C02-005 2.6: the answer is bound to the one revision the transfer writes.
    if v_status in ('answered', 'accepted', 'declined') or v_answered_at is not null then
      v_answered_rev := 1;
    end if;
    -- The fields the record leaves empty (B:308; EV-C02-005 2.2), and answer, which the transfer never fills.
    select coalesce(jsonb_agg(u.k order by u.o), '[]'::jsonb) into v_lacks
      from unnest(array['presented_text_tr', 'why_this_owner', 'options', 'alternatives_considered',
                        'single_viable_path_reason', 'premises', 'criteria', 'evidence_refs', 'assumptions',
                        'reversibility', 'reopen_triggers', 'recommendation', 'recommendation_rationale',
                        'if_unanswered', 'alternatives_state']) with ordinality u(k, o)
     where coalesce(jsonb_typeof(p_in -> u.k), 'null') = 'null'
        or p_in -> u.k in ('[]'::jsonb, '{}'::jsonb)
        or (jsonb_typeof(p_in -> u.k) = 'string' and btrim(p_in ->> u.k) = '');
    v_lacks := v_lacks || '["answer"]'::jsonb;

    -- (f) The closing rule (B:397).
    v_check := 'handover';
    perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_decision: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
    perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext('decision' || ':' || v_sid));
    select e.payload -> 'transfer_source' ->> 'sha256', e.aggregate_id into v_prev_sha, v_prev_agg
      from devos_private.event e
     where e.event_type = 'transferred' and (e.payload -> 'transfer_source' ->> 'kind') = 'decision'
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
      select max(r.revision) into v_prev_rev from devos_private.decision_revision r where r.decision_id = v_prev_agg;
      if v_prev_rev is null then
        v_code := 'could_not_check'; v_reason := 'key: the transferred Decision''s revision is missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    else
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

      -- The run's input commit (EV-C02-013 28 (6); EV-C02-005 3.2): the input_commit of the run's first begun event.
      select e.payload ->> 'input_commit' into v_run_commit
        from devos_private.event e
       where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
       order by e.id limit 1;
      if v_run_commit is null then
        v_code := 'could_not_check'; v_reason := 'run: the begun event of the run lacks its input commit (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if (p_in -> 'transfer_source' ->> 'input_commit') <> v_run_commit then
        v_code := 'invalid_field';
        v_reason := 'transfer_source: input_commit is not the run''s input commit (EV-C02-005 3.2)';
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
  if v_found then
    return jsonb_build_object('status', 'ok', 'id', v_prev_agg, 'revision', v_prev_rev, 'repeat', true);
  end if;

  -- The write block: step (g). The Decision, its revision 1 and its transferred mark (S2's index is the backstop).
  begin
    v_check := 'write';
    insert into devos_private.decision (class, status, answer_original_tr, answer_interpretation_en, answered_by,
                                        answer_channel_ref, answered_revision, answered_at)
    values (v_dclass, v_status, p_in ->> 'answer_original_tr', p_in ->> 'answer_interpretation_en',
            p_in ->> 'answered_by', p_in ->> 'answer_channel_ref', v_answered_rev, v_answered_at)
    returning id into v_id;
    insert into devos_private.decision_revision (decision_id, revision, question, presented_text_tr, why_this_owner,
                                                 options, alternatives_considered, single_viable_path_reason, premises,
                                                 criteria, evidence_refs, assumptions, reversibility, reopen_triggers,
                                                 recommendation, recommendation_rationale, if_unanswered,
                                                 alternatives_state)
    values (v_id, 1, p_in ->> 'question', p_in ->> 'presented_text_tr', p_in ->> 'why_this_owner',
            nullif(p_in -> 'options', 'null'::jsonb), nullif(p_in -> 'alternatives_considered', 'null'::jsonb),
            p_in ->> 'single_viable_path_reason', nullif(p_in -> 'premises', 'null'::jsonb),
            nullif(p_in -> 'criteria', 'null'::jsonb), nullif(p_in -> 'evidence_refs', 'null'::jsonb),
            nullif(p_in -> 'assumptions', 'null'::jsonb), p_in ->> 'reversibility',
            nullif(p_in -> 'reopen_triggers', 'null'::jsonb), p_in ->> 'recommendation',
            p_in ->> 'recommendation_rationale', p_in ->> 'if_unanswered', v_alt);
    v_mark := jsonb_build_object('transfer_source', v_src, 'run_id', v_run, 'lacks', v_lacks);
    if v_declared is not null then
      v_mark := v_mark || jsonb_build_object('declared', v_declared);
    end if;
    if v_fields is not null then
      v_mark := v_mark || jsonb_build_object('source_fields', v_fields);
    end if;
    perform devos_private.write_event('decision', v_id, 1, 'transferred', v_mark, v_class::text, 'call', v_decl);
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

-- transfer_need: its merged text (20261019140001_w09_transfer_records.sql) with decisions 5, 2 and 6: lock 9005 shared before the hand-over read, lock 9007 on the function's kind and the source ID before the key read, the input commit compared in the run check (28 (4) to (6)).
create or replace function devos_api.transfer_need(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'transfer_need';
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
  v_mission uuid;
  v_inst boolean;
  v_status devos_private.need_status;
  v_declared jsonb;
  v_fields jsonb;
  v_found boolean := false;
  v_prev_sha text;
  v_prev_agg uuid;
  v_partial bigint;
  v_begun bigint;
  v_done bigint;
  v_id uuid;
  v_mark jsonb;
  v_run_commit text;
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
      v_reason := 'transfer_need admits only the role class devos_kurulum (B section 4, the ledger transfer)';
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
    v_sid := p_in -> 'transfer_source' ->> 'source_id';
    v_sha := p_in -> 'transfer_source' ->> 'sha256';
    if (p_in -> 'transfer_source' ->> 'kind') <> 'need' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.kind: not need (EV-C02-013 3.1)';
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
    v_src := jsonb_build_object('kind', 'need', 'source_id', v_sid, 'path', p_in -> 'transfer_source' ->> 'path',
                                'input_commit', p_in -> 'transfer_source' ->> 'input_commit',
                                'last_commit', p_in -> 'transfer_source' ->> 'last_commit', 'sha256', v_sha);
    -- The Need's fields (B 3.2; EV-C02-005 2.3).
    foreach v_key in array array['mission_ref', 'condition', 'why_needed', 'status'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p_in ->> 'mission_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'mission_ref: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_mission := (p_in ->> 'mission_ref')::uuid;
    if (p_in ->> 'status') not in ('open', 'resolved') then
      v_code := 'invalid_field';
      v_reason := 'status: not open or resolved (a transferred note; EV-C02-005 2.3; EV-C02-013 3.2)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_status := (p_in ->> 'status')::devos_private.need_status;
    foreach v_key in array array['consumer', 'return_to'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
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
    perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_need: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
    perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext('need' || ':' || v_sid));
    select e.payload -> 'transfer_source' ->> 'sha256', e.aggregate_id into v_prev_sha, v_prev_agg
      from devos_private.event e
     where e.event_type = 'transferred' and (e.payload -> 'transfer_source' ->> 'kind') = 'need'
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
    else
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

      -- The run's input commit (EV-C02-013 28 (6); EV-C02-005 3.2): the input_commit of the run's first begun event.
      select e.payload ->> 'input_commit' into v_run_commit
        from devos_private.event e
       where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
       order by e.id limit 1;
      if v_run_commit is null then
        v_code := 'could_not_check'; v_reason := 'run: the begun event of the run lacks its input commit (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if (p_in -> 'transfer_source' ->> 'input_commit') <> v_run_commit then
        v_code := 'invalid_field';
        v_reason := 'transfer_source: input_commit is not the run''s input commit (EV-C02-005 3.2)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- The installation's Mission (3.2; B 3.2's transferred bullet), locked for share.
      v_check := 'mission_ref';
      perform 1 from devos_private.mission m where m.id = v_mission for share;
      if not found then
        v_code := 'reference_missing';
        v_reason := 'mission_ref: names no Mission written yet (EV-C02-013 3.1, "Order")';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_check := 'installation_mission';
      v_inst := devos_private.is_installation_mission(v_mission);
      if v_inst is null then
        v_code := 'could_not_check';
        v_reason := 'installation_mission: whether the Mission is the installation''s is missing or partial';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if not v_inst then
        v_code := 'invalid_field';
        v_reason := 'mission_ref: not the installation''s Mission (EV-C02-013 3.2; B 3.2)';
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
  if v_found then
    return jsonb_build_object('status', 'ok', 'id', v_prev_agg, 'repeat', true);
  end if;

  -- The write block: step (g). The Need and its transferred mark (S2's index is the backstop).
  begin
    v_check := 'write';
    insert into devos_private.need (mission_ref, condition, why_needed, consumer, return_to, status)
    values (v_mission, p_in ->> 'condition', p_in ->> 'why_needed', p_in ->> 'consumer', p_in ->> 'return_to', v_status)
    returning id into v_id;
    v_mark := jsonb_build_object('transfer_source', v_src, 'run_id', v_run, 'lacks', '[]'::jsonb);
    if v_declared is not null then
      v_mark := v_mark || jsonb_build_object('declared', v_declared);
    end if;
    if v_fields is not null then
      v_mark := v_mark || jsonb_build_object('source_fields', v_fields);
    end if;
    perform devos_private.write_event('need', v_id, null, 'transferred', v_mark, v_class::text, 'call', v_decl);
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

-- transfer_finding: its merged text (20261019140001_w09_transfer_records.sql) with decisions 5, 2 and 6: lock 9005 shared before the hand-over read, lock 9007 on the function's kind and the source ID before the key read, the input commit compared in the run check (28 (4) to (6)).
create or replace function devos_api.transfer_finding(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'transfer_finding';
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
  v_changeable devos_private.finding_changeable;
  v_estatus devos_private.epistemic_status;
  v_authority devos_private.current_authority;
  v_stype devos_private.source_type;
  v_spans jsonb := '[]'::jsonb;
  v_span jsonb;
  v_date date;
  v_fresh date;
  v_lacks jsonb;
  v_declared jsonb;
  v_fields jsonb;
  v_found boolean := false;
  v_prev_sha text;
  v_prev_agg uuid;
  v_prev_rev integer;
  v_partial bigint;
  v_begun bigint;
  v_done bigint;
  v_id uuid;
  v_mark jsonb;
  v_run_commit text;
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
      v_reason := 'transfer_finding admits only the role class devos_kurulum (B section 4, the ledger transfer)';
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
    v_sid := p_in -> 'transfer_source' ->> 'source_id';
    v_sha := p_in -> 'transfer_source' ->> 'sha256';
    if (p_in -> 'transfer_source' ->> 'kind') <> 'finding' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.kind: not finding (EV-C02-013 3.1)';
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
    v_src := jsonb_build_object('kind', 'finding', 'source_id', v_sid, 'path', p_in -> 'transfer_source' ->> 'path',
                                'input_commit', p_in -> 'transfer_source' ->> 'input_commit',
                                'last_commit', p_in -> 'transfer_source' ->> 'last_commit', 'sha256', v_sha);
    -- The Finding's fields (B 3.8; EV-C02-005 1.2 row 15, S4).
    foreach v_key in array array['claim', 'scope', 'counter_evidence_searched', 'changeable', 'epistemic_status',
                                 'current_authority', 'privacy_class', 'status'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p_in ->> 'scope') !~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$' then
      v_code := 'invalid_field'; v_reason := 'scope: not a dotted path of lower-case labels';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p_in ->> 'changeable') not in ('yes', 'no', 'not_recorded') then
      v_code := 'invalid_field'; v_reason := 'changeable: not yes, no or not_recorded (EV-C02-005 S4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_changeable := (p_in ->> 'changeable')::devos_private.finding_changeable;
    if (p_in ->> 'epistemic_status') not in ('observation', 'user_decision', 'inference', 'hypothesis', 'proposal') then
      v_code := 'invalid_field';
      v_reason := 'epistemic_status: not observation, user_decision, inference, hypothesis or proposal';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_estatus := (p_in ->> 'epistemic_status')::devos_private.epistemic_status;
    if (p_in ->> 'current_authority') not in ('can_open_work', 'instruction', 'information_only') then
      v_code := 'invalid_field'; v_reason := 'current_authority: not can_open_work, instruction or information_only';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_authority := (p_in ->> 'current_authority')::devos_private.current_authority;
    if (p_in ->> 'privacy_class') <> 'public' then
      v_code := 'invalid_field';
      v_reason := 'privacy_class: not public (a transferred finding; B 3.8; EV-C02-005 1.2 row 15)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p_in ->> 'status') <> 'candidate' then
      v_code := 'invalid_field';
      v_reason := 'status: not candidate (a transferred finding; B 3.8; EV-C02-005 1.2 row 15)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'source_type'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'source_type') <> 'string'
         or (p_in ->> 'source_type') not in ('foundation', 'candidate_study', 'context', 'exploration', 'historical_record',
                                             'archived_report', 'legacy_repo') then
        v_code := 'invalid_field'; v_reason := 'source_type: not one of Appendix B 3.8''s source types';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_stype := (p_in ->> 'source_type')::devos_private.source_type;
    end if;
    if coalesce(jsonb_typeof(p_in -> 'source_spans'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'source_spans') <> 'array' then
        v_code := 'invalid_field'; v_reason := 'source_spans: not an array';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_spans := p_in -> 'source_spans';
      for v_span in select x from pg_catalog.jsonb_array_elements(v_spans) x loop
        if jsonb_typeof(v_span) <> 'object' or coalesce(jsonb_typeof(v_span -> 'primary'), 'null') <> 'boolean' then
          v_code := 'invalid_field';
          v_reason := 'source_spans: each entry is an object whose primary, a boolean, says whether its source is primary';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if coalesce(jsonb_typeof(v_span -> 'read_at'), 'null') <> 'null' then
          v_date := null;
          if jsonb_typeof(v_span -> 'read_at') = 'string' and (v_span ->> 'read_at') ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' then
            begin
              v_date := (v_span ->> 'read_at')::date;
            exception when others then
              v_date := null;
            end;
          end if;
          if v_date is null then
            v_code := 'invalid_field'; v_reason := 'source_spans: a read_at is not a date (YYYY-MM-DD)';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        end if;
      end loop;
    end if;
    foreach v_key in array array['confidence', 'use_scope'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if coalesce(jsonb_typeof(p_in -> 'fresh_until'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'fresh_until') = 'string' and (p_in ->> 'fresh_until') ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' then
        begin
          v_fresh := (p_in ->> 'fresh_until')::date;
        exception when others then
          v_fresh := null;
        end;
      end if;
      if v_fresh is null then
        v_code := 'invalid_field'; v_reason := 'fresh_until: not a date (YYYY-MM-DD)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
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
    -- What the record lacks (EV-C02-013 3.1): the gate fields held as not_recorded (B 3.8), then the optional fields
    -- left empty.
    select coalesce(jsonb_agg(u.k order by u.o), '[]'::jsonb) into v_lacks
      from unnest(array['counter_evidence_searched', 'changeable', 'source_type', 'source_spans', 'qualifiers',
                        'confidence', 'open_questions', 'fresh_until', 'use_scope']) with ordinality u(k, o)
     where (u.k in ('counter_evidence_searched', 'changeable') and (p_in ->> u.k) = 'not_recorded')
        or (u.k not in ('counter_evidence_searched', 'changeable')
            and (coalesce(jsonb_typeof(p_in -> u.k), 'null') = 'null'
                 or p_in -> u.k in ('[]'::jsonb, '{}'::jsonb)
                 or (jsonb_typeof(p_in -> u.k) = 'string' and btrim(p_in ->> u.k) = '')));

    -- (f) The closing rule (B:397).
    v_check := 'handover';
    perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_finding: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
    perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext('finding' || ':' || v_sid));
    select e.payload -> 'transfer_source' ->> 'sha256', e.aggregate_id into v_prev_sha, v_prev_agg
      from devos_private.event e
     where e.event_type = 'transferred' and (e.payload -> 'transfer_source' ->> 'kind') = 'finding'
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
      select max(r.revision) into v_prev_rev from devos_private.finding_revision r where r.finding_id = v_prev_agg;
      if v_prev_rev is null then
        v_code := 'could_not_check'; v_reason := 'key: the transferred Finding''s revision is missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    else
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

      -- The run's input commit (EV-C02-013 28 (6); EV-C02-005 3.2): the input_commit of the run's first begun event.
      select e.payload ->> 'input_commit' into v_run_commit
        from devos_private.event e
       where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
       order by e.id limit 1;
      if v_run_commit is null then
        v_code := 'could_not_check'; v_reason := 'run: the begun event of the run lacks its input commit (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if (p_in -> 'transfer_source' ->> 'input_commit') <> v_run_commit then
        v_code := 'invalid_field';
        v_reason := 'transfer_source: input_commit is not the run''s input commit (EV-C02-005 3.2)';
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
  if v_found then
    return jsonb_build_object('status', 'ok', 'id', v_prev_agg, 'revision', v_prev_rev, 'repeat', true);
  end if;

  -- The write block: step (g). The Finding, its revision 1 and its transferred mark (S2's index is the backstop).
  begin
    v_check := 'write';
    insert into devos_private.finding (status, scope, privacy_class) values ('candidate', p_in ->> 'scope', 'public')
    returning id into v_id;
    insert into devos_private.finding_revision (finding_id, revision, claim, source_spans, qualifiers,
                                                counter_evidence_searched, confidence, open_questions, changeable,
                                                fresh_until, use_scope, source_type, epistemic_status, current_authority)
    values (v_id, 1, p_in ->> 'claim', v_spans, nullif(p_in -> 'qualifiers', 'null'::jsonb),
            p_in ->> 'counter_evidence_searched', p_in ->> 'confidence', nullif(p_in -> 'open_questions', 'null'::jsonb),
            v_changeable, v_fresh, p_in ->> 'use_scope', v_stype, v_estatus, v_authority);
    v_mark := jsonb_build_object('transfer_source', v_src, 'run_id', v_run, 'lacks', v_lacks);
    if v_declared is not null then
      v_mark := v_mark || jsonb_build_object('declared', v_declared);
    end if;
    if v_fields is not null then
      v_mark := v_mark || jsonb_build_object('source_fields', v_fields);
    end if;
    perform devos_private.write_event('finding', v_id, 1, 'transferred', v_mark, v_class::text, 'call', v_decl);
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

-- transfer_review: its merged text (20261019160001_w09_transfer_copies.sql) with decisions 5, 2 and 6: lock 9005 shared before the hand-over read, lock 9007 on the function's kind and the source ID before the key read, the input commit compared in the run check (28 (4) to (6)).
create or replace function devos_api.transfer_review(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'transfer_review';
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
  v_target uuid;
  v_trev integer;
  v_tfam text;
  v_ok boolean;
  v_cver text;
  v_basis jsonb;
  v_result devos_private.verdict_result;
  v_objections jsonb := '[]'::jsonb;
  v_evidence jsonb := '[]'::jsonb;
  v_limits jsonb := '[]'::jsonb;
  v_declared jsonb;
  v_fields jsonb;
  v_after boolean;
  v_found boolean := false;
  v_prev_sha text;
  v_prev_agg uuid;
  v_prev_verdict uuid;
  v_partial bigint;
  v_begun bigint;
  v_done bigint;
  v_id uuid;
  v_vid uuid;
  v_mark jsonb;
  v_run_commit text;
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
      v_reason := 'transfer_review admits only the role class devos_kurulum (B section 4, the ledger transfer)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (c) The form. kind first: a sample Review is opened only by the database (EV-C02-008 2.2 condition 2).
    v_check := 'input';
    if p_in is null then
      v_code := 'missing_field'; v_reason := 'p: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in) <> 'object' then
      v_code := 'invalid_field'; v_reason := 'p: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'kind'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'kind: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'kind') = 'string' and (p_in ->> 'kind') = 'sample' then
      v_code := 'kind_not_allowed';
      v_reason := 'kind: a sample Review is opened only by the database (B 3.11; EV-C02-008 2.2 condition 2)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'kind') <> 'string' or (p_in ->> 'kind') <> 'review' then
      v_code := 'invalid_field'; v_reason := 'kind: not review';
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
    if (p_in -> 'transfer_source' ->> 'kind') <> 'verdict' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.kind: not verdict (EV-C02-013 3.1)';
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
    v_src := jsonb_build_object('kind', 'verdict', 'source_id', v_sid, 'path', p_in -> 'transfer_source' ->> 'path',
                                'input_commit', p_in -> 'transfer_source' ->> 'input_commit',
                                'last_commit', p_in -> 'transfer_source' ->> 'last_commit', 'sha256', v_sha);
    -- The Review copy's fields (B 3.11; EV-C02-005 2.4).
    if coalesce(jsonb_typeof(p_in -> 'target_ref'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'target_ref') <> 'string'
         or (p_in ->> 'target_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
        v_code := 'invalid_field'; v_reason := 'target_ref: not a uuid';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_target := (p_in ->> 'target_ref')::uuid;
    end if;
    if coalesce(jsonb_typeof(p_in -> 'target_revision'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'target_revision') <> 'number' or (p_in ->> 'target_revision') !~ '^[1-9][0-9]{0,8}$' then
        v_code := 'invalid_field'; v_reason := 'target_revision: not an integer of at least 1';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_target is null then
        v_code := 'invalid_field'; v_reason := 'target_revision: sent without target_ref, so it names nothing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_trev := (p_in ->> 'target_revision')::integer;
    end if;
    foreach v_key in array array['claim', 'criterion'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if coalesce(jsonb_typeof(p_in -> 'criterion_version'), 'null') not in ('null', 'string', 'number') then
      v_code := 'invalid_field'; v_reason := 'criterion_version: not a string or a number';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_cver := case when coalesce(jsonb_typeof(p_in -> 'criterion_version'), 'null') = 'null' then null
                   else p_in ->> 'criterion_version' end;
    -- basis_refs: mandatory (B section 4's Review row); for a copy, the commit and the acceptance condition judged
    -- (B 3.11), kept as the transfer sends them.
    if coalesce(jsonb_typeof(p_in -> 'basis_refs'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'basis_refs: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'basis_refs') <> 'array' then
      v_code := 'invalid_field'; v_reason := 'basis_refs: not an array';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_array_length(p_in -> 'basis_refs') = 0 then
      v_code := 'missing_field'; v_reason := 'basis_refs: empty (a review''s basis is mandatory, B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_basis := p_in -> 'basis_refs';
    foreach v_key in array array['reviewer_declared_session', 'independence_level', 'use'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p_in ->> 'independence_level') <> 'fresh_context_subagent' then
      v_code := 'invalid_field';
      v_reason := 'independence_level: a copy of an installation checker verdict is fresh_context_subagent (B 3.11)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    -- The Verdict copy.
    if coalesce(jsonb_typeof(p_in -> 'verdict'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'verdict: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'verdict') <> 'object' then
      v_code := 'invalid_field'; v_reason := 'verdict: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'verdict' -> 'result'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'verdict.result: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'verdict' -> 'result') <> 'string'
       or (p_in -> 'verdict' ->> 'result') not in ('pass', 'fail', 'conditional', 'indeterminate') then
      v_code := 'invalid_field'; v_reason := 'verdict.result: not pass, fail, conditional or indeterminate';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_result := (p_in -> 'verdict' ->> 'result')::devos_private.verdict_result;
    foreach v_key in array array['objections', 'evidence_refs', 'limits'] loop
      if coalesce(jsonb_typeof(p_in -> 'verdict' -> v_key), 'null') not in ('null', 'array') then
        v_code := 'invalid_field'; v_reason := 'verdict.' || v_key || ': not an array';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if jsonb_typeof(p_in -> 'verdict' -> 'objections') = 'array' then v_objections := p_in -> 'verdict' -> 'objections'; end if;
    if jsonb_typeof(p_in -> 'verdict' -> 'evidence_refs') = 'array' then v_evidence := p_in -> 'verdict' -> 'evidence_refs'; end if;
    if jsonb_typeof(p_in -> 'verdict' -> 'limits') = 'array' then v_limits := p_in -> 'verdict' -> 'limits'; end if;
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

    -- (f) Not closed by the hand-over (B:397); whether it has happened sets the run rule and the mark.
    v_check := 'handover';
    perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);
    v_after := exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over');

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
    perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext('verdict' || ':' || v_sid));
    select e.payload -> 'transfer_source' ->> 'sha256', e.aggregate_id into v_prev_sha, v_prev_agg
      from devos_private.event e
     where e.event_type = 'transferred' and (e.payload -> 'transfer_source' ->> 'kind') = 'verdict'
       and (e.payload -> 'transfer_source' ->> 'source_id') = v_sid
     order by e.id limit 1;
    v_found := found;
    if v_found then
      if v_prev_sha is null or v_prev_agg is null then
        v_code := 'could_not_check'; v_reason := 'key: the earlier transferred event lacks its sha256 or its record (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_prev_sha <> v_sha then
        v_code := 'conflict';
        v_reason := 'transfer_source: this source is already transferred with another sha256 (EV-C02-013 3.1)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      select v.id into v_prev_verdict from devos_private.verdict v where v.review_ref = v_prev_agg
       order by v.created_at, v.id limit 1;
      if v_prev_verdict is null then
        v_code := 'could_not_check'; v_reason := 'key: the transferred Review copy''s Verdict is missing (partial)';
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

        -- The run's input commit (EV-C02-013 28 (6); EV-C02-005 3.2): the input_commit of the run's first begun event.
        select e.payload ->> 'input_commit' into v_run_commit
          from devos_private.event e
         where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
         order by e.id limit 1;
        if v_run_commit is null then
          v_code := 'could_not_check'; v_reason := 'run: the begun event of the run lacks its input commit (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if (p_in -> 'transfer_source' ->> 'input_commit') <> v_run_commit then
          v_code := 'invalid_field';
          v_reason := 'transfer_source: input_commit is not the run''s input commit (EV-C02-005 3.2)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;

      -- The target, when named (3.2's row: a target_ref naming nothing is reference_missing; its family is not judged).
      if v_target is not null then
        v_check := 'target_ref';
        select f.fam into v_tfam
          from (select 'work'::text as fam from devos_private.work x where x.id = v_target
                union all select 'mission' from devos_private.mission x where x.id = v_target
                union all select 'decision' from devos_private.decision x where x.id = v_target
                union all select 'finding' from devos_private.finding x where x.id = v_target
                union all select 'artifact' from devos_private.artifact x where x.id = v_target
                union all select 'need' from devos_private.need x where x.id = v_target
                union all select 'relation' from devos_private.relation x where x.id = v_target
                union all select 'effort_policy' from devos_private.effort_policy x where x.id = v_target
                union all select 'assignment' from devos_private.assignment x where x.id = v_target
                union all select 'review' from devos_private.review x where x.id = v_target
                union all select 'verdict' from devos_private.verdict x where x.id = v_target
                union all select 'acceptance' from devos_private.acceptance x where x.id = v_target
                union all select 'operation' from devos_private.operation x where x.id = v_target
                union all select 'observation' from devos_private.observation x where x.id = v_target) f
         limit 1;
        if v_tfam is null then
          v_code := 'reference_missing';
          v_reason := 'target_ref: names no record written yet (EV-C02-013 3.1, "Order"; 3.2)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_trev is not null then
          if v_tfam not in ('work', 'mission', 'decision', 'finding', 'artifact') then
            v_code := 'invalid_field'; v_reason := 'target_revision: the record named has no revisions';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          v_ok := case v_tfam
            when 'work' then exists (select 1 from devos_private.work_revision x where x.work_id = v_target and x.revision = v_trev)
            when 'mission' then exists (select 1 from devos_private.mission_revision x
                                         where x.mission_id = v_target and x.revision = v_trev)
            when 'decision' then exists (select 1 from devos_private.decision_revision x
                                          where x.decision_id = v_target and x.revision = v_trev)
            when 'finding' then exists (select 1 from devos_private.finding_revision x
                                         where x.finding_id = v_target and x.revision = v_trev)
            else exists (select 1 from devos_private.artifact_revision x where x.artifact_id = v_target and x.revision = v_trev)
          end;
          if not coalesce(v_ok, false) then
            v_code := 'reference_missing';
            v_reason := 'target_revision: names no revision of the record written yet (EV-C02-013 3.1, "Order")';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
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
    return jsonb_build_object('status', 'ok', 'id', v_prev_agg, 'verdict_id', v_prev_verdict, 'repeat', true);
  end if;

  -- The write block: step (g). The Review copy, its Verdict, and the Review's transferred mark (S2's index is the
  -- backstop).
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    insert into devos_private.review (id, kind, target_ref, target_revision, claim, criterion_ref, criterion_version, use,
                                      basis_refs, reviewer_declared_session, reviewer_role_class, independence_level)
    values (v_id, 'review', v_target, v_trev, p_in ->> 'claim', p_in ->> 'criterion', v_cver, p_in ->> 'use', v_basis,
            p_in ->> 'reviewer_declared_session', v_class, 'fresh_context_subagent');
    v_vid := pg_catalog.gen_random_uuid();
    insert into devos_private.verdict (id, review_ref, result, evidence_refs, objections, limits)
    values (v_vid, v_id, v_result, v_evidence, v_objections, v_limits);
    v_mark := jsonb_build_object('transfer_source', v_src, 'run_id', v_run,
                                 'lacks', case when v_target is null then '["target_ref"]'::jsonb else '[]'::jsonb end,
                                 'verdict_id', v_vid);
    if v_after then
      v_mark := v_mark || jsonb_build_object('after_handover', true);
    end if;
    if v_declared is not null then
      v_mark := v_mark || jsonb_build_object('declared', v_declared);
    end if;
    if v_fields is not null then
      v_mark := v_mark || jsonb_build_object('source_fields', v_fields);
    end if;
    perform devos_private.write_event('review', v_id, null, 'transferred', v_mark, v_class::text, 'call', v_decl);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id, 'verdict_id', v_vid);
end
$fn$;

-- transfer_acceptance: its merged text (20261019160001_w09_transfer_copies.sql) with decisions 5, 2 and 6: lock 9005 shared before the hand-over read, lock 9007 on the function's kind and the source ID before the key read, the input commit compared in the run check (28 (4) to (6)).
create or replace function devos_api.transfer_acceptance(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'transfer_acceptance';
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
  v_target uuid;
  v_trev integer;
  v_review uuid;
  v_evidence jsonb;
  v_residual jsonb := '[]'::jsonb;
  v_entry jsonb;
  v_i integer;
  v_eid bigint;
  v_etype text;
  v_le boolean := false;
  v_names_review boolean := false;
  v_fam text;
  v_declared jsonb;
  v_fields jsonb;
  v_after boolean;
  v_found boolean := false;
  v_prev_sha text;
  v_prev_agg uuid;
  v_partial bigint;
  v_begun bigint;
  v_done bigint;
  v_ruse text;
  v_rfound boolean;
  v_ctype text;
  v_cclass text;
  v_cfound boolean;
  v_nverdicts bigint;
  v_nfailed bigint;
  v_ncond bigint;
  v_tr bigint;
  v_null bigint;
  v_mission uuid;
  v_inst boolean;
  v_owner uuid;
  v_tfam text;
  v_cur integer;
  v_wacc devos_private.work_acceptance;
  v_wmission uuid;
  v_dstatus devos_private.decision_status;
  v_dalt devos_private.alternatives_state;
  v_dopt jsonb;
  v_dsvp text;
  v_drev_found boolean;
  v_id uuid;
  v_mark jsonb;
  v_run_commit text;
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
      v_reason := 'transfer_acceptance admits only the role class devos_kurulum (B section 4, the ledger transfer)';
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
    if (p_in -> 'transfer_source' ->> 'kind') <> 'acceptance' then
      v_code := 'invalid_field'; v_reason := 'transfer_source.kind: not acceptance (EV-C02-013 3.1)';
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
    v_src := jsonb_build_object('kind', 'acceptance', 'source_id', v_sid, 'path', p_in -> 'transfer_source' ->> 'path',
                                'input_commit', p_in -> 'transfer_source' ->> 'input_commit',
                                'last_commit', p_in -> 'transfer_source' ->> 'last_commit', 'sha256', v_sha);
    -- The Acceptance copy's fields (B 3.11; EV-C02-005 2.4).
    foreach v_key in array array['target_ref', 'review_ref', 'accepted_use', 'scope'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p_in ->> 'target_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'target_ref: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_target := (p_in ->> 'target_ref')::uuid;
    if (p_in ->> 'review_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'review_ref: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_review := (p_in ->> 'review_ref')::uuid;
    if (p_in ->> 'accepted_use') <> 'installation_acceptance' then
      v_code := 'invalid_field';
      v_reason := 'accepted_use: an installation acceptance''s copy is installation_acceptance (B 3.11; EV-C02-005 2.4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p_in ->> 'scope') <> 'installation' then
      v_code := 'invalid_field';
      v_reason := 'scope: not installation (the transfer copies installation acceptances; B 3.11; EV-C02-005 2.4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'target_revision'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'target_revision') <> 'number' or (p_in ->> 'target_revision') !~ '^[1-9][0-9]{0,8}$' then
        v_code := 'invalid_field'; v_reason := 'target_revision: not an integer of at least 1';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_trev := (p_in ->> 'target_revision')::integer;
    end if;
    if coalesce(jsonb_typeof(p_in -> 'current_evidence'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'current_evidence: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'current_evidence') <> 'array' then
      v_code := 'invalid_field'; v_reason := 'current_evidence: not an array';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_evidence := p_in -> 'current_evidence';
    for v_i in 0 .. jsonb_array_length(v_evidence) - 1 loop
      v_entry := v_evidence -> v_i;
      if not ((jsonb_typeof(v_entry) = 'string'
               and (v_entry #>> '{}') ~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$')
              or (jsonb_typeof(v_entry) = 'object' and jsonb_typeof(v_entry -> 'event_id') = 'number'
                  and (v_entry ->> 'event_id') ~ '^[1-9][0-9]{0,17}$')) then
        v_code := 'invalid_field';
        v_reason := 'current_evidence: each entry is a record''s uuid or {"event_id": <integer>} (EV-C02-013 3.2)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(v_entry) = 'string' and (v_entry #>> '{}')::uuid = v_review then
        v_names_review := true;
      end if;
    end loop;
    if not v_names_review then
      v_code := 'invalid_field';
      v_reason := 'current_evidence: does not name the Review copy (B 3.11: the Acceptance names that verdict)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'residual_decisions'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'residual_decisions') <> 'array' then
        v_code := 'invalid_field'; v_reason := 'residual_decisions: not an array';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_residual := p_in -> 'residual_decisions';
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

    -- (f) Not closed by the hand-over (B:397); whether it has happened sets the run rule and the mark.
    v_check := 'handover';
    perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);
    v_after := exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over');

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
    perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext('acceptance' || ':' || v_sid));
    select e.payload -> 'transfer_source' ->> 'sha256', e.aggregate_id into v_prev_sha, v_prev_agg
      from devos_private.event e
     where e.event_type = 'transferred' and (e.payload -> 'transfer_source' ->> 'kind') = 'acceptance'
       and (e.payload -> 'transfer_source' ->> 'source_id') = v_sid
     order by e.id limit 1;
    v_found := found;
    if v_found then
      if v_prev_sha is null or v_prev_agg is null then
        v_code := 'could_not_check'; v_reason := 'key: the earlier transferred event lacks its sha256 or its record (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_prev_sha <> v_sha then
        v_code := 'conflict';
        v_reason := 'transfer_source: this source is already transferred with another sha256 (EV-C02-013 3.1)';
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

        -- The run's input commit (EV-C02-013 28 (6); EV-C02-005 3.2): the input_commit of the run's first begun event.
        select e.payload ->> 'input_commit' into v_run_commit
          from devos_private.event e
         where e.event_type = 'transfer_run' and e.payload ->> 'run_id' = v_run and e.payload ->> 'phase' = 'begun'
         order by e.id limit 1;
        if v_run_commit is null then
          v_code := 'could_not_check'; v_reason := 'run: the begun event of the run lacks its input commit (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if (p_in -> 'transfer_source' ->> 'input_commit') <> v_run_commit then
          v_code := 'invalid_field';
          v_reason := 'transfer_source: input_commit is not the run''s input commit (EV-C02-005 3.2)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;

      -- The Review copy (3.2: a Review with a transferred creation event), its Verdicts and its use.
      v_check := 'review_ref';
      select r.use into v_ruse from devos_private.review r where r.id = v_review for share;
      v_rfound := found;
      if not v_rfound then
        v_code := 'verdict_missing'; v_reason := 'review_ref: names no Review copy (EV-C02-013 3.2)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      select e.event_type into v_ctype from devos_private.event e
       where e.aggregate_type = 'review' and e.aggregate_id = v_review order by e.id limit 1;
      v_cfound := found;
      if not v_cfound or v_ctype is null then
        v_code := 'could_not_check'; v_reason := 'review_ref: the Review''s creation event is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_ctype <> 'transferred' then
        v_code := 'verdict_missing';
        v_reason := 'review_ref: the Review is no copy the transfer wrote (its creation event is not transferred)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_check := 'verdict';
      select count(*), count(*) filter (where v.result in ('fail', 'indeterminate')),
             count(*) filter (where v.result = 'conditional')
        into v_nverdicts, v_nfailed, v_ncond
        from devos_private.verdict v where v.review_ref = v_review;
      if v_nverdicts = 0 then
        v_code := 'could_not_check'; v_reason := 'verdict: the Review copy''s Verdict is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_nfailed > 0 then
        v_code := 'verdict_failed';
        v_reason := 'the Review copy''s verdict is fail or indeterminate, which accepts nothing (B 3.11; EV-C02-005 2.4)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_ruse is null then
        v_code := 'could_not_check'; v_reason := 'review_ref: the Review copy''s use is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_ruse <> (p_in ->> 'accepted_use') then
        v_code := 'invalid_field';
        v_reason := 'accepted_use: not the use the Review copy was for; a verdict is not carried over to another use (B 3.11)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- current_evidence: every entry names something written (3.1, "Order"); a conditional verdict needs an entry
      -- that names a ledger_entry event, the record of its conditions met (EV-C02-005 2.4).
      v_check := 'current_evidence';
      for v_i in 0 .. jsonb_array_length(v_evidence) - 1 loop
        v_entry := v_evidence -> v_i;
        if jsonb_typeof(v_entry) = 'string' then
          v_fam := null;
          select f.fam into v_fam
            from (select 'work'::text as fam from devos_private.work x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'mission' from devos_private.mission x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'decision' from devos_private.decision x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'finding' from devos_private.finding x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'artifact' from devos_private.artifact x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'need' from devos_private.need x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'relation' from devos_private.relation x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'effort_policy' from devos_private.effort_policy x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'assignment' from devos_private.assignment x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'review' from devos_private.review x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'verdict' from devos_private.verdict x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'acceptance' from devos_private.acceptance x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'operation' from devos_private.operation x where x.id = (v_entry #>> '{}')::uuid
                  union all select 'observation' from devos_private.observation x where x.id = (v_entry #>> '{}')::uuid) f
           limit 1;
          if v_fam is null then
            v_code := 'reference_missing';
            v_reason := 'current_evidence: an entry names no record written yet (EV-C02-013 3.1, "Order")';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        else
          v_eid := (v_entry ->> 'event_id')::bigint;
          select e.event_type into v_etype from devos_private.event e where e.id = v_eid;
          if not found then
            v_code := 'reference_missing';
            v_reason := 'current_evidence: an entry names no event written yet (EV-C02-013 3.1, "Order")';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if v_etype is null then
            v_code := 'could_not_check'; v_reason := 'current_evidence: an event it names lacks its type (partial)';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if v_etype = 'ledger_entry' then
            v_le := true;
          end if;
        end if;
      end loop;
      if v_ncond > 0 and not v_le then
        v_code := 'conditions_not_recorded';
        v_reason := 'a conditional verdict, and current_evidence names no ledger_entry event that records its '
                    || 'conditions met (EV-C02-005 2.4)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- The installation's Mission (the one Mission whose creation event is transferred, EV-C02-013 section 4) and its
      -- owner authority, D-010's Decision by construction (R1-9; B 3.11).
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
      select r.owner_authority into v_owner from devos_private.mission_revision r
       where r.mission_id = v_mission order by r.revision desc limit 1;
      if v_owner is null then
        v_code := 'could_not_check';
        v_reason := 'installation_mission: its current revision or its owner_authority is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;

      -- The target: a Work or a Decision, written, at its current revision, and an installation record (R2-2).
      v_check := 'target_ref';
      select f.fam into v_tfam
        from (select 'work'::text as fam from devos_private.work x where x.id = v_target
              union all select 'mission' from devos_private.mission x where x.id = v_target
              union all select 'decision' from devos_private.decision x where x.id = v_target
              union all select 'finding' from devos_private.finding x where x.id = v_target
              union all select 'artifact' from devos_private.artifact x where x.id = v_target
              union all select 'need' from devos_private.need x where x.id = v_target
              union all select 'relation' from devos_private.relation x where x.id = v_target
              union all select 'effort_policy' from devos_private.effort_policy x where x.id = v_target
              union all select 'assignment' from devos_private.assignment x where x.id = v_target
              union all select 'review' from devos_private.review x where x.id = v_target
              union all select 'verdict' from devos_private.verdict x where x.id = v_target
              union all select 'acceptance' from devos_private.acceptance x where x.id = v_target
              union all select 'operation' from devos_private.operation x where x.id = v_target
              union all select 'observation' from devos_private.observation x where x.id = v_target) f
       limit 1;
      if v_tfam is null then
        v_code := 'reference_missing';
        v_reason := 'target_ref: names no record written yet (EV-C02-013 3.1, "Order")';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_tfam not in ('work', 'decision') then
        v_code := 'invalid_field';
        v_reason := 'target_ref: an installation acceptance''s copy sets a Work or a Decision accepted (EV-C02-013 3.2)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_tfam = 'work' then
        -- The work item's row first (DM-01), then Rule O's devos_kurulum clause as 2.3 reads it: the current
        -- revision's Mission revision, that Mission's creation event.
        select w.acceptance into v_wacc from devos_private.work w where w.id = v_target for update;
        select r.revision, mr.mission_id into v_cur, v_wmission
          from devos_private.work_revision r
          left join devos_private.mission_revision mr on mr.id = r.mission_revision_id
         where r.work_id = v_target order by r.revision desc limit 1;
        if v_wacc is null or v_cur is null then
          v_code := 'could_not_check'; v_reason := 'target_ref: the Work''s state or current revision is missing (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      else
        select d.status into v_dstatus from devos_private.decision d where d.id = v_target for update;
        select r.revision, r.alternatives_state, r.options, r.single_viable_path_reason
          into v_cur, v_dalt, v_dopt, v_dsvp
          from devos_private.decision_revision r where r.decision_id = v_target order by r.revision desc limit 1;
        v_drev_found := found;
        if v_dstatus is null or not v_drev_found or v_cur is null then
          v_code := 'could_not_check';
          v_reason := 'target_ref: the Decision''s status or current revision is missing (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
      if v_trev is not null then
        if v_trev > v_cur then
          v_code := 'reference_missing';
          v_reason := 'target_revision: names no revision of the record written yet (EV-C02-013 3.1, "Order")';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_trev < v_cur then
          v_code := 'stale_revision'; v_reason := 'target_revision: not the target''s current revision';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
      v_check := 'rule_o';
      if v_tfam = 'work' then
        if v_wmission is null then
          v_code := 'could_not_check'; v_reason := 'rule_o: the Work''s Mission is missing (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        v_inst := devos_private.is_installation_mission(v_wmission);
        if v_inst is null then
          v_code := 'could_not_check';
          v_reason := 'rule_o: whether the Work''s Mission is the installation''s is missing or partial';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if not v_inst then
          v_code := 'not_owner';
          v_reason := 'rule_o: devos_kurulum sets accepted only a work item under the installation''s Mission (EV-C02-013 3.2, R2-2)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      else
        select e.event_type, e.role_class into v_ctype, v_cclass from devos_private.event e
         where e.aggregate_type = 'decision' and e.aggregate_id = v_target order by e.id limit 1;
        v_cfound := found;
        if not v_cfound or v_ctype is null or v_cclass is null or v_ctype not in ('decision_opened', 'transferred') then
          v_code := 'could_not_check'; v_reason := 'rule_o: the Decision''s creation event is missing (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_cclass <> 'devos_kurulum' then
          v_code := 'not_owner';
          v_reason := 'rule_o: devos_kurulum sets accepted only a decision the installation opened or transferred (EV-C02-013 3.2, R2-2)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        v_check := 'decision';
        if v_dstatus not in ('answered', 'accepted') then
          v_code := 'invalid_field';
          v_reason := 'target_ref: a Decision is set accepted only from answered (EV-C02-013 3.2; EV-C02-005 2.4)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_dalt = 'open_exploration'
           and (v_dopt is null or v_dopt in ('null'::jsonb, '[]'::jsonb, '{}'::jsonb, '""'::jsonb))
           and coalesce(btrim(v_dsvp), '') = '' then
          v_code := 'open_exploration';
          v_reason := 'B 3.17: a decision in open_exploration is not accepted before its options or '
                      || 'single_viable_path_reason are entered';
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
    return jsonb_build_object('status', 'ok', 'id', v_prev_agg, 'repeat', true);
  end if;

  -- The write block: step (g). The Acceptance, its transferred mark (S2's index is the backstop), and the target's
  -- state with acceptance_set at its current revision.
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    insert into devos_private.acceptance (id, target_ref, target_revision, accepted_use, scope, current_evidence,
                                          residual_decisions, owner_authority)
    values (v_id, v_target, v_cur, p_in ->> 'accepted_use', 'installation', v_evidence, v_residual, v_owner);
    v_mark := jsonb_build_object('transfer_source', v_src, 'run_id', v_run,
                                 'lacks', case when v_le then '[]'::jsonb else '["ledger_entry"]'::jsonb end);
    if v_after then
      v_mark := v_mark || jsonb_build_object('after_handover', true);
    end if;
    if v_declared is not null then
      v_mark := v_mark || jsonb_build_object('declared', v_declared);
    end if;
    if v_fields is not null then
      v_mark := v_mark || jsonb_build_object('source_fields', v_fields);
    end if;
    perform devos_private.write_event('acceptance', v_id, null, 'transferred', v_mark, v_class::text, 'call', v_decl);
    if v_tfam = 'work' and v_wacc <> 'accepted' then
      update devos_private.work w set acceptance = 'accepted' where w.id = v_target;
      perform devos_private.write_event('work', v_target, v_cur, 'acceptance_set',
        jsonb_build_object('acceptance', 'accepted', 'previous_acceptance', v_wacc::text, 'acceptance_id', v_id,
                           'review_ref', v_review),
        v_class::text, 'call', v_decl);
    elsif v_tfam = 'decision' and v_dstatus = 'answered' then
      update devos_private.decision d set status = 'accepted' where d.id = v_target;
      perform devos_private.write_event('decision', v_target, v_cur, 'acceptance_set',
        jsonb_build_object('status', 'accepted', 'previous_status', 'answered', 'acceptance_id', v_id,
                           'review_ref', v_review),
        v_class::text, 'call', v_decl);
    end if;
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

-- The two partial indexes (EV-C02-018 16 decision 8; section 8; EV-C02-013 28 (9); N-302 (6)). Neither is unique: a
-- run has a begun and a completed event, and an entry ID can have a transfer_event event and a record_ledger_entry
-- event. No function and no answer changes for them.
create index event_transfer_run_idx on devos_private.event ((payload ->> 'run_id')) where event_type = 'transfer_run';
comment on index devos_private.event_transfer_run_idx is
  'The run lookups by run_id (EV-C02-018 section 8, N-302 (6); EV-C02-013 28 (9))';
create index event_ledger_entry_idx on devos_private.event ((payload ->> 'entry_id')) where event_type = 'ledger_entry';
comment on index devos_private.event_ledger_entry_idx is
  'record_ledger_entry''s entry lookup by entry_id (EV-C02-018 section 8, N-302 (6); EV-C02-013 28 (9))';

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)), written again for the fourteen: PUBLIC's
-- default EXECUTE is revoked, and so is any privilege of the four API roles; then EXECUTE is granted to anon, the
-- role a Data API request with the publishable key runs as. Each function checks the token itself. This file adds
-- no type and no devos_private function.
revoke all on function devos_api.prepare_operation(text, jsonb) from public;
revoke all on function devos_api.begin_transfer_run(jsonb) from public;
revoke all on function devos_api.end_transfer_run(jsonb) from public;
revoke all on function devos_api.record_handover(jsonb) from public;
revoke all on function devos_api.transfer_event(jsonb) from public;
revoke all on function devos_api.transfer_artifact(jsonb) from public;
revoke all on function devos_api.transfer_mission(jsonb) from public;
revoke all on function devos_api.transfer_work(jsonb) from public;
revoke all on function devos_api.transfer_relation(jsonb) from public;
revoke all on function devos_api.transfer_decision(jsonb) from public;
revoke all on function devos_api.transfer_need(jsonb) from public;
revoke all on function devos_api.transfer_finding(jsonb) from public;
revoke all on function devos_api.transfer_review(jsonb) from public;
revoke all on function devos_api.transfer_acceptance(jsonb) from public;
do $$
declare r text; f text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      foreach f in array array[
        'devos_api.prepare_operation(text, jsonb)',
        'devos_api.begin_transfer_run(jsonb)',
        'devos_api.end_transfer_run(jsonb)',
        'devos_api.record_handover(jsonb)',
        'devos_api.transfer_event(jsonb)',
        'devos_api.transfer_artifact(jsonb)',
        'devos_api.transfer_mission(jsonb)',
        'devos_api.transfer_work(jsonb)',
        'devos_api.transfer_relation(jsonb)',
        'devos_api.transfer_decision(jsonb)',
        'devos_api.transfer_need(jsonb)',
        'devos_api.transfer_finding(jsonb)',
        'devos_api.transfer_review(jsonb)',
        'devos_api.transfer_acceptance(jsonb)'] loop
        execute format('revoke all on function %s from %I', f, r);
      end loop;
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.prepare_operation(text, jsonb) to anon;
    grant execute on function devos_api.begin_transfer_run(jsonb) to anon;
    grant execute on function devos_api.end_transfer_run(jsonb) to anon;
    grant execute on function devos_api.record_handover(jsonb) to anon;
    grant execute on function devos_api.transfer_event(jsonb) to anon;
    grant execute on function devos_api.transfer_artifact(jsonb) to anon;
    grant execute on function devos_api.transfer_mission(jsonb) to anon;
    grant execute on function devos_api.transfer_work(jsonb) to anon;
    grant execute on function devos_api.transfer_relation(jsonb) to anon;
    grant execute on function devos_api.transfer_decision(jsonb) to anon;
    grant execute on function devos_api.transfer_need(jsonb) to anon;
    grant execute on function devos_api.transfer_finding(jsonb) to anon;
    grant execute on function devos_api.transfer_review(jsonb) to anon;
    grant execute on function devos_api.transfer_acceptance(jsonb) to anon;
  end if;
end
$$;
