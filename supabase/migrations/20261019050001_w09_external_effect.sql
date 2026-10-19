-- DevOS schema (W-C02-09), not a fixture. M09-08: external effect.
-- Sources: plan/work/W-C02-09.md points 1, 2, 3, 4, 5, 7 and 8; Appendix B principles 2, 3, 4, 5, 8 and 9, section 2,
-- 3.5, 3.12, 3.13 and section 4 (row "External effect"); Appendix C F01, F05, F07, F08; evidence/C02/
-- EV-C02-013_w09_interface.md sections 1 (items 1 to 14), 2.7 with R2-1, R2-3 and R2-4, 6 (row F08), 10 and 21 (C-17,
-- C-M08); EV-C02-008 1.7.2 (operation_state); EV-C02-003 section 4.1 (the row "external-effect intents and their
-- observations"); EV-C02-002 DM-01, DM-06, DM-19, DM-28, DM-31, DM-36, DM-37. Record: evidence/C02/EV-C02-014_w09_build.md
-- section 9.
-- It holds exactly section 10's row M09-08, the four functions of EV-C02-013 section 2.7: devos_api.prepare_operation,
-- record_attempt, record_observation and operation_state. It adds no table, type or private function, and changes
-- nothing of M09-01 to M09-07, whose helpers it calls: caller_role_class, write_event, reject, scope_within,
-- check_claim, ready_value and is_installation_mission. No token, hash or key value is written here.
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12).
--
-- The common form is M09-03's to M09-07's (EV-C02-013 section 1 items 6, 7, 9 and 10, R1-1): (a) the derivation,
-- before any other check; then a read block holding (b) the role list, a literal of the function's own text (B:48),
-- (c) the input's form, (d) ownership where a function has it, (e) the claim, for the two functions that take a claim
-- token, and (f) the family's rules, writing nothing (its row locks stay with the transaction); then a write block
-- holding (g) the writes and their events through devos_private.write_event, with the caller's role class. A check that
-- decides a refusal sets v_code and v_reason and raises P0D01; any other error in the read block is could_not_check,
-- "<v_check>: its input could not be read (SQLSTATE <code>)"; any error in the write block is write_failed, but P0D02,
-- which is could_not_check with its fixed reason. After either block's refusal one per-call RejectedAttempt row is
-- written by devos_private.reject. A reason holds fixed text and an SQLSTATE only. Keys a function does not read are
-- ignored (item 4); declared_session_id goes to the events and the refusal rows only (item 5). Parameters keep the names
-- of EV-C02-013 2.7 and README 8.1 (named calls), and the bodies read them through ALIAS FOR $n, never qualified by the
-- function's name (N-288). No claim token, and nothing derived from one, reaches an event, a record or a refusal row.
--
-- The read set (B 3.12; EV-C02-013 section 6, row F08, with R1-2 and R2-4; C-M08). prepare_operation stores in
-- operation.read_set one entry per element, each an object with the key element: work (the work item and the revision
-- the call names), hard_dependencies (one per current hard depends_on relation from the work item: its id, to_ref and
-- to_revision), claim (the claim checked, with its generation), authority_epoch (the global epoch), expected_base (the
-- call's, when it gives one), target (target_ref with target_revision), inputs (the caller's entry for each of the work
-- item's input_refs) and agent (every other entry of the caller). work, hard_dependencies, claim and authority_epoch
-- are filled for every class: B 3.12 re-checks the work item, its dependencies and the claim at the moment of every
-- effect. The effect class's mandatory_read_set adds what the server cannot fill: expected_base (the call must give
-- one, else read_set_short) and inputs (each input needs the caller's entry, else read_set_short, F08 (d)). An element
-- name the class lists that is none of the six is could_not_check. record_attempt re-checks every entry.
--
-- A reference these functions must read (a target, a read-set entry) names a record of one of the families M09-06's
-- relate looks up: Work, Mission, Decision, Finding and Artifact (with revisions), Need, Relation, EffortPolicy,
-- Assignment, Review, Verdict, Acceptance, Operation and Observation (without). A read-set entry names a revision of
-- the first five (B principle 3); one that names no record, a record without revisions, or no such revision, or is sent
-- without its revision, is could_not_check (EV-C02-013 section 1 item 14 with R1-2). None of the four functions names
-- the exam table: for every class an exam record is a record they cannot find.

-- prepare_operation (EV-C02-013 2.7 with R2-1, R2-3, R2-4, C-17 and C-M08; B 3.12; Appendix C F01, F05, F08; DM-28,
-- DM-37): an Operation and operation_prepared, under the claim of the work item it is prepared on. Payload:
-- idempotency_namespace, idempotency_key, effect_class, target, payload_hash (strings), work_ref and work_revision
-- required; expected_base (a string), target_ref with target_revision (a Work or an Artifact the effect acts on),
-- read_set (an array of {"ref": <uuid>, "revision": <integer>}; default []). Order after the gate: the form
-- (work_revision, target_revision or an entry's revision absent or JSON null: could_not_check, a reference sent without
-- its revision, R2-1, R2-4); the claim through devos_private.check_claim with the work item; the idempotency key: a
-- record with the same namespace and key and the same full intent (effect_class, target, expected_base, payload_hash,
-- the work item and its revision, the target record and its revision, the claim and its generation, the authority
-- epoch; F01) is the exact repeat, answered from the record with "repeat": true and nothing written; another intent is
-- conflict; then the effect class (a class the table does not hold, or a partial row: could_not_check, C-17); the work
-- item's revision (none: could_not_check; earlier: stale_revision); its readiness with the caller's own claim left out
-- (false: not_ready; NULL: could_not_check; F08 (a)); the target (another family: invalid_field; no record or revision:
-- could_not_check; earlier: stale_revision; scope not within the work item's: scope_outside; F05); each read-set entry
-- (no record or revision: could_not_check; earlier: stale_revision; a Work, Artifact or Finding whose scope is not
-- within the work item's: scope_outside); the class's mandatory elements (read_set_short). A key's record is never
-- deleted (DM-28). devos_calisma, devos_kurulum (EV-C02-003 section 4.1; B section 2). Answer {"status": "ok", "id",
-- "operation_status"}; the exact repeat adds "repeat": true and answers the record's stored status (F01 (d)).
create function devos_api.prepare_operation(claim_token text, p jsonb)
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

-- record_attempt (EV-C02-013 2.7, section 6's row F08, and C-M08; B 3.5, 3.12; Appendix C F08): one attempt of a prepared
-- operation, at the moment of its effect. Order after the gate: operation_id NULL: missing_field; the Operation, read
-- for its work item (none: not_found); the claim through devos_private.check_claim with that work item (every claim
-- code of 2.4; DM-01's locks: the work item, the claim, the epoch, for share); then the Operation locked for update and
-- its read set re-checked (F08; B 3.12): the claim presented must be the one the operation was prepared under, and the
-- authority epoch the one it was prepared in (else read_set_changed); the work item at the revision prepared (a new
-- revision: read_set_changed); its readiness with the caller's own claim left out (false: not_ready; NULL:
-- could_not_check; F08 (a)); its current hard dependencies the ones prepared (else read_set_changed); every target,
-- input and agent entry at the revision prepared (else read_set_changed; F08 (b)); a stored entry that is partial or
-- names no record that can be read: could_not_check. Every attempt counts (B 3.12 attempts): no exact repeat. The
-- status moves from prepared to attempted; another status stays. devos_calisma, devos_kurulum. Answer {"status": "ok",
-- "id", "attempts", "operation_status"}.
create function devos_api.record_attempt(claim_token text, operation_id uuid)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_token alias for $1;
  p_op alias for $2;
  v_fn constant text := 'record_attempt';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_work uuid;
  v_claim jsonb;
  v_assignment uuid;
  v_generation integer;
  v_epoch bigint;
  v_status text;
  v_attempts integer;
  v_asg uuid;
  v_gen integer;
  v_oepoch bigint;
  v_read jsonb;
  v_entry jsonb;
  v_i integer;
  v_el text;
  v_n_work bigint;
  v_n_claim bigint;
  v_n_epoch bigint;
  v_wrev integer;
  v_cur integer;
  v_ready boolean;
  v_deps_now jsonb;
  v_deps_then jsonb;
  v_ref uuid;
  v_rev integer;
  v_fam text;
  v_rcur integer;
  v_new_status text;
  v_new_attempts integer;
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
    if not (v_class = any (array['devos_calisma', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'record_attempt admits only the role classes devos_calisma and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if p_op is null then
      v_code := 'missing_field'; v_reason := 'operation_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The Operation's work item, for the claim check (the row is locked after the claim, in DM-01's order).
    v_check := 'operation';
    select o.work_ref into v_work from devos_private.operation o where o.id = p_op;
    if not found then
      v_code := 'not_found'; v_reason := 'operation_id: names no Operation';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_work is null then
      v_code := 'could_not_check'; v_reason := 'operation: its work item is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (e) The claim check of an effect (EV-C02-013 2.4; B 3.5; S8 line 2), on the operation's work item.
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

    -- (f) The Operation, locked for update (the attempts are counted one by one).
    v_check := 'operation';
    select o.status::text, o.attempts, o.assignment_ref, o.generation, o.authority_epoch, o.read_set
      into v_status, v_attempts, v_asg, v_gen, v_oepoch, v_read
      from devos_private.operation o where o.id = p_op
       for update;
    if v_status is null or v_attempts is null or v_asg is null or v_gen is null or v_oepoch is null
       or v_read is null or jsonb_typeof(v_read) <> 'array' then
      v_code := 'could_not_check'; v_reason := 'operation: its record is partial';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The re-check at the moment of the effect (F08; B 3.12). First the stored read set's form.
    v_check := 'read_set';
    v_n_work := 0;
    v_n_claim := 0;
    v_n_epoch := 0;
    for v_i in 0 .. jsonb_array_length(v_read) - 1 loop
      v_entry := v_read -> v_i;
      v_el := case when jsonb_typeof(v_entry) = 'object' then v_entry ->> 'element' end;
      if v_el is null or v_el not in ('work', 'hard_dependencies', 'claim', 'authority_epoch', 'expected_base', 'target',
                                      'inputs', 'agent') then
        v_code := 'could_not_check'; v_reason := 'read_set: an entry of the operation''s read set is partial';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_el = 'work' then
        v_n_work := v_n_work + 1;
        if (v_entry ->> 'ref') is distinct from v_work::text or coalesce(jsonb_typeof(v_entry -> 'revision'), 'null') <> 'number' then
          v_code := 'could_not_check'; v_reason := 'read_set: the operation''s work entry is partial';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        v_wrev := (v_entry ->> 'revision')::integer;
      elsif v_el = 'claim' then
        v_n_claim := v_n_claim + 1;
        if coalesce(jsonb_typeof(v_entry -> 'ref'), 'null') <> 'string'
           or coalesce(jsonb_typeof(v_entry -> 'generation'), 'null') <> 'number' then
          v_code := 'could_not_check'; v_reason := 'read_set: the operation''s claim entry is partial';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if (v_entry ->> 'ref')::uuid <> v_assignment or (v_entry ->> 'generation')::integer <> v_generation then
          v_code := 'read_set_changed';
          v_reason := 'claim: the operation was prepared under another claim of its work item (F08 (c))';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      elsif v_el = 'authority_epoch' then
        v_n_epoch := v_n_epoch + 1;
        if coalesce(jsonb_typeof(v_entry -> 'epoch'), 'null') <> 'number' then
          v_code := 'could_not_check'; v_reason := 'read_set: the operation''s authority epoch entry is partial';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if (v_entry ->> 'epoch')::bigint <> v_epoch then
          v_code := 'read_set_changed';
          v_reason := 'authority_epoch: the operation was prepared in another authority epoch (B principle 9)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      elsif v_el in ('target', 'inputs', 'agent') then
        if coalesce(jsonb_typeof(v_entry -> 'ref'), 'null') <> 'string'
           or coalesce(jsonb_typeof(v_entry -> 'revision'), 'null') <> 'number' then
          v_code := 'could_not_check'; v_reason := 'read_set: an entry of the operation''s read set is partial';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      elsif v_el = 'hard_dependencies' then
        if coalesce(jsonb_typeof(v_entry -> 'ref'), 'null') <> 'string'
           or coalesce(jsonb_typeof(v_entry -> 'to_ref'), 'null') <> 'string' then
          v_code := 'could_not_check'; v_reason := 'read_set: an entry of the operation''s read set is partial';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
    end loop;
    if v_n_work <> 1 or v_n_claim <> 1 or v_n_epoch <> 1 then
      v_code := 'could_not_check'; v_reason := 'read_set: the operation''s work, claim or authority epoch entry is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    -- The claim and epoch the record's own columns hold (F01's intent fields).
    if v_asg <> v_assignment or v_gen <> v_generation then
      v_code := 'read_set_changed';
      v_reason := 'claim: the operation was prepared under another claim of its work item (F08 (c))';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_oepoch <> v_epoch then
      v_code := 'read_set_changed';
      v_reason := 'authority_epoch: the operation was prepared in another authority epoch (B principle 9)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The work item at the revision prepared (F08 (w)), read under check_claim's lock on the work item.
    v_check := 'work_revision';
    select max(r.revision) into v_cur from devos_private.work_revision r where r.work_id = v_work;
    if v_cur is null then
      v_code := 'could_not_check'; v_reason := 'work_revision: the work item''s current revision is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_wrev <> v_cur then
      v_code := 'read_set_changed'; v_reason := 'work: the work item has another revision than the one prepared (F08)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The work item still ready (F08 (a)), the caller's own claim left out.
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

    -- Its hard dependencies the ones prepared (F08 (a)).
    v_check := 'hard_dependencies';
    select coalesce(jsonb_agg(jsonb_strip_nulls(jsonb_build_object('element', 'hard_dependencies', 'ref', r.id,
                                                                   'to_ref', r.to_ref, 'to_revision', r.to_revision))
                              order by r.id), '[]'::jsonb)
      into v_deps_now
      from devos_private.relation r
     where r.from_ref = v_work and r.type = 'depends_on' and r.hard and r.validity = 'current';
    select coalesce(jsonb_agg(e order by (e ->> 'ref')::uuid), '[]'::jsonb) into v_deps_then
      from jsonb_array_elements(v_read) e where e ->> 'element' = 'hard_dependencies';
    if v_deps_now <> v_deps_then then
      v_code := 'read_set_changed';
      v_reason := 'hard_dependencies: the work item''s hard dependencies changed since the prepare (F08 (a))';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- Every record the operation read, at the revision prepared (F08 (b)).
    v_check := 'read_set';
    for v_i in 0 .. jsonb_array_length(v_read) - 1 loop
      v_entry := v_read -> v_i;
      continue when (v_entry ->> 'element') not in ('target', 'inputs', 'agent');
      v_ref := (v_entry ->> 'ref')::uuid;
      v_rev := (v_entry ->> 'revision')::integer;
      v_fam := null;
      select f.fam into v_fam
        from (select 'work'::text as fam from devos_private.work x where x.id = v_ref
              union all select 'mission' from devos_private.mission x where x.id = v_ref
              union all select 'decision' from devos_private.decision x where x.id = v_ref
              union all select 'finding' from devos_private.finding x where x.id = v_ref
              union all select 'artifact' from devos_private.artifact x where x.id = v_ref) f
       limit 1;
      v_rcur := case v_fam
        when 'work' then (select max(x.revision) from devos_private.work_revision x where x.work_id = v_ref)
        when 'mission' then (select max(x.revision) from devos_private.mission_revision x where x.mission_id = v_ref)
        when 'decision' then (select max(x.revision) from devos_private.decision_revision x where x.decision_id = v_ref)
        when 'finding' then (select max(x.revision) from devos_private.finding_revision x where x.finding_id = v_ref)
        when 'artifact' then (select max(x.revision) from devos_private.artifact_revision x where x.artifact_id = v_ref)
      end;
      if v_rcur is null then
        v_code := 'could_not_check'; v_reason := 'read_set: an entry''s record or revision could not be read';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_rev <> v_rcur then
        v_code := 'read_set_changed';
        v_reason := 'read_set: a record the operation read has another revision than the one prepared (F08 (b))';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  v_claim := null;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_op);
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    update devos_private.operation o
       set attempts = o.attempts + 1,
           status = case when o.status = 'prepared' then 'attempted'::devos_private.operation_status else o.status end
     where o.id = p_op
    returning o.attempts, o.status::text into v_new_attempts, v_new_status;
    perform devos_private.write_event('operation', p_op, null, 'operation_attempted',
      jsonb_build_object('attempts', v_new_attempts, 'status', v_new_status, 'previous_status', v_status,
                         'assignment_id', v_assignment, 'generation', v_generation),
      v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_op);
  end if;
  return jsonb_build_object('status', 'ok', 'id', p_op, 'attempts', v_new_attempts, 'operation_status', v_new_status);
end
$fn$;

-- record_observation (EV-C02-013 2.7 and C-M08; B 3.12, principle 5; Appendix C F07; EV-C02-003 section 4.1): one
-- Observation of an Operation, appended, never replacing an earlier one (the table is append-only, migration
-- 20261014170205). Payload: operation_ref (the Operation's id), source (a string) and observed_effect (applied,
-- not_applied or unknown) required; observed_at (a time with its zone; default now()), details (an object; default {}).
-- No claim token (README 8.1): an observation states what was seen, it makes no effect. Order after the form: the
-- Operation locked for update (none: not_found); ownership, the reading of EV-C02-003 section 4.1's cell
-- "devos_kurulum: the installation's own records" by EV-C02-008 1.7.1's Rule O: devos_kurulum only on an operation
-- whose work item lies under the installation's Mission, devos_calisma only on one whose work item does not (else
-- not_owner; a Mission whose creation event cannot be read: could_not_check). The status moves from prepared or
-- attempted to observed, with operation_status_set; another status stays. The work item's acceptance and effect axes
-- are not touched (F07: "accepted" is a separate question). devos_calisma, devos_kurulum. Answer {"status": "ok", "id",
-- "operation_status"}.
create function devos_api.record_observation(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'record_observation';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_op uuid;
  v_source text;
  v_effect text;
  v_at timestamptz;
  v_details jsonb := '{}'::jsonb;
  v_status text;
  v_work uuid;
  v_mrev uuid;
  v_mission uuid;
  v_inst boolean;
  v_id uuid;
  v_new_status text;
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
      v_reason := 'record_observation admits only the role classes devos_calisma and devos_kurulum';
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
    foreach v_key in array array['operation_ref', 'source', 'observed_effect'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p_in ->> 'operation_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'operation_ref: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_op := (p_in ->> 'operation_ref')::uuid;
    v_source := p_in ->> 'source';
    if (p_in ->> 'observed_effect') not in ('applied', 'not_applied', 'unknown') then
      v_code := 'invalid_field'; v_reason := 'observed_effect: not applied, not_applied or unknown';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_effect := p_in ->> 'observed_effect';
    if coalesce(jsonb_typeof(p_in -> 'observed_at'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'observed_at') <> 'string' then
        v_code := 'invalid_field'; v_reason := 'observed_at: not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      begin
        v_at := (p_in ->> 'observed_at')::timestamptz;
      exception when others then
        v_code := 'invalid_field'; v_reason := 'observed_at: not a time';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end;
    end if;
    if coalesce(jsonb_typeof(p_in -> 'details'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'details') <> 'object' then
        v_code := 'invalid_field'; v_reason := 'details: not a JSON object';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_details := p_in -> 'details';
    end if;

    -- (f) The Operation, locked for update (its status may move).
    v_check := 'operation';
    select o.status::text, o.work_ref into v_status, v_work from devos_private.operation o where o.id = v_op for update;
    if not found then
      v_code := 'not_found'; v_reason := 'operation_ref: names no Operation';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_status is null or v_work is null then
      v_code := 'could_not_check'; v_reason := 'operation: its record is partial';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (d) Ownership (EV-C02-003 section 4.1; EV-C02-008 1.7.1's Rule O, as EV-C02-013 2.3 says it reads).
    v_check := 'ownership';
    select r.mission_revision_id into v_mrev
      from devos_private.work_revision r where r.work_id = v_work order by r.revision desc limit 1;
    if v_mrev is not null then
      select mr.mission_id into v_mission from devos_private.mission_revision mr where mr.id = v_mrev;
    end if;
    if v_mission is null then
      v_code := 'could_not_check'; v_reason := 'ownership: the operation''s work item''s Mission is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_inst := devos_private.is_installation_mission(v_mission);
    if v_inst is null then
      v_code := 'could_not_check';
      v_reason := 'ownership: whether the operation''s work item lies under the installation''s Mission is missing or partial';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_class = 'devos_kurulum' and not v_inst then
      v_code := 'not_owner';
      v_reason := 'devos_kurulum records observations only of operations under the installation''s Mission (its own records)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_class = 'devos_calisma' and v_inst then
      v_code := 'not_owner';
      v_reason := 'devos_calisma does not record observations of operations under the installation''s Mission';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_op);
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    insert into devos_private.observation (id, operation_ref, source, observed_at, observed_effect, details)
    values (v_id, v_op, v_source, coalesce(v_at, now()), v_effect::devos_private.observed_effect, v_details)
    returning observed_at into v_at;
    perform devos_private.write_event('observation', v_id, null, 'observation_recorded',
      jsonb_build_object('operation_ref', v_op, 'source', v_source, 'observed_at', v_at, 'observed_effect', v_effect,
                         'details', v_details),
      v_class::text, 'call', v_decl);
    v_new_status := v_status;
    if v_status in ('prepared', 'attempted') then
      update devos_private.operation o set status = 'observed' where o.id = v_op;
      v_new_status := 'observed';
      perform devos_private.write_event('operation', v_op, null, 'operation_status_set',
        jsonb_build_object('status', 'observed', 'previous_status', v_status, 'observation_id', v_id),
        v_class::text, 'call', v_decl);
    end if;
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_op);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id, 'operation_status', v_new_status);
end
$fn$;

-- operation_state (EV-C02-008 1.7.2; EV-C02-013 2.7 and C-M08; Appendix C F07): the three separate questions of an
-- Operation, as a read. operation_status: the Operation's status (named so because the answer's own status is section
-- 1 item 1's ok or refused); ever_applied: whether any of its observations is applied ("applied in the past");
-- current_effect: the observed_effect of its latest observation by observed_at, not by arrival ("current now"; JSON
-- null when it has none, unknown when two or more observations share the latest time and disagree). "Accepted" is the
-- work item's and Acceptance's, not this read's. An observation without its effect or time is could_not_check. All four
-- of EV-C02-008 1.7.2's classes, as a literal: devos_calisma, devos_denetim, devos_sinav, devos_kurulum. A read: it
-- changes no table but rejected_attempt, it is VOLATILE because it records its refusals (DM-36), and its comment begins
-- devos:read. It has no write block. Answer {"status": "ok", "operation_status", "ever_applied", "current_effect"}.
create function devos_api.operation_state(operation_id uuid)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_op alias for $1;
  v_fn constant text := 'operation_state';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_status text;
  v_partial bigint;
  v_ever boolean;
  v_latest timestamptz;
  v_kinds bigint;
  v_current text;
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
    if not (v_class = any (array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'operation_state admits only the role classes devos_calisma, devos_denetim, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if p_op is null then
      v_code := 'missing_field'; v_reason := 'operation_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'operation';
    select o.status::text into v_status from devos_private.operation o where o.id = p_op;
    if not found then
      v_code := 'not_found'; v_reason := 'operation_id: names no Operation';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_status is null then
      v_code := 'could_not_check'; v_reason := 'operation: its status is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'observations';
    select count(*) filter (where b.observed_effect is null or b.observed_at is null),
           coalesce(bool_or(b.observed_effect = 'applied'), false), max(b.observed_at)
      into v_partial, v_ever, v_latest
      from devos_private.observation b where b.operation_ref = p_op;
    if v_partial > 0 then
      v_code := 'could_not_check'; v_reason := 'observations: an observation''s effect or time is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_latest is not null then
      select count(distinct b.observed_effect), min(b.observed_effect::text) into v_kinds, v_current
        from devos_private.observation b where b.operation_ref = p_op and b.observed_at = v_latest;
      if v_kinds > 1 then
        v_current := 'unknown';
      end if;
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_op);
  end if;
  return jsonb_build_object('status', 'ok', 'operation_status', v_status, 'ever_applied', v_ever,
                            'current_effect', v_current);
end
$fn$;
comment on function devos_api.operation_state(uuid) is
  'devos:read An Operation''s status, whether it was ever applied, and its current observed effect (EV-C02-008 1.7.2; EV-C02-013 section 2.7)';

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)). PUBLIC's default EXECUTE is revoked from
-- the four functions, and so is any privilege of the four API roles; then EXECUTE is granted to anon, the role a Data
-- API request with the publishable key runs as. Each function checks the token itself. This file adds no type and no
-- devos_private function.
revoke all on function devos_api.prepare_operation(text, jsonb) from public;
revoke all on function devos_api.record_attempt(text, uuid) from public;
revoke all on function devos_api.record_observation(jsonb) from public;
revoke all on function devos_api.operation_state(uuid) from public;
do $$
declare r text; f text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      foreach f in array array['devos_api.prepare_operation(text, jsonb)', 'devos_api.record_attempt(text, uuid)',
                               'devos_api.record_observation(jsonb)', 'devos_api.operation_state(uuid)'] loop
        execute format('revoke all on function %s from %I', f, r);
      end loop;
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.prepare_operation(text, jsonb) to anon;
    grant execute on function devos_api.record_attempt(text, uuid) to anon;
    grant execute on function devos_api.record_observation(jsonb) to anon;
    grant execute on function devos_api.operation_state(uuid) to anon;
  end if;
end
$$;
