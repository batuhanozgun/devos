-- DevOS schema (W-C02-09), not a fixture. M09-11: the ledger transfer's records.
-- Sources: plan/work/W-C02-09.md points 1, 2, 3, 5, 7 and 10; Appendix B principles 2, 3, 4, 6 and 8, section 2 (the
-- devos_kurulum row), 3.1, 3.2, 3.3, 3.4, 3.8, 3.13 ("The ledger transfer's events"), 3.17, 3.18 and section 4 (the row
-- "Ledger transfer"); evidence/C02/EV-C02-005_ledger_transfer.md sections 1.2, 1.4, 2.1, 2.2, 2.3, 2.6, 3.1 to 3.3 and
-- 15 (S1, S2, S4, S5); evidence/C02/EV-C02-008_design_addendum_roles_and_samples.md 1.7.1, 1.7.3 and 2.7;
-- evidence/C02/EV-C02-013_w09_interface.md sections 1 (items 1 to 14), 2.2 (R2-7, C-20), 2.5 (R2-5), 3.1, 3.2, 10,
-- 22 (1) and 25 (C-M10), and 26 (C-M11). Record: evidence/C02/EV-C02-014_w09_build.md section 13.
-- It holds exactly section 10's row M09-11, six of the ledger transfer's fourteen functions: devos_api.transfer_mission,
-- transfer_work, transfer_relation, transfer_decision, transfer_need and transfer_finding. It adds no table, type or
-- private function, and changes nothing of M09-01 to M09-10 or of the rule corrections (20261019080001), whose helpers
-- it calls: caller_role_class, write_event, reject, scope_within, hard_dependency_cycle and is_installation_mission. No
-- token, hash or key value is written here. None of the six takes a claim token or counts a claim.
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12).
--
-- The common form is M09-03's to M09-10's (EV-C02-013 section 1 items 6, 7, 9 and 10, R1-1): (a) the derivation,
-- before any other check; then a read block holding (b) the role list, the literal array['devos_kurulum'] of the
-- function's own text (B:48; B section 4: "Only devos_kurulum"), (c) the input's form and (f) the group's and the
-- family's rules, writing nothing (its row locks and its transaction-level advisory lock stay with the transaction);
-- then a write block holding (g) the record, its revision and its transferred mark, through devos_private.write_event,
-- with the caller's role class and origin call. A check that decides a refusal sets v_code and v_reason and raises
-- P0D01; any other error in the read block is could_not_check, "<v_check>: its input could not be read (SQLSTATE
-- <code>)"; any error in the write block is write_failed (S2's index event_transferred_key among them), but P0D02, which
-- is could_not_check with its fixed reason. After either block's refusal one per-call RejectedAttempt row is written by
-- devos_private.reject. A reason holds fixed text and an SQLSTATE only. Keys a function does not read are ignored (item
-- 4); declared_session_id goes to the events and the refusal rows only (item 5). Each function takes p jsonb
-- (EV-C02-013 section 3) and reads it through ALIAS FOR $1 (N-288).
--
-- The group's rules, as M09-10 builds them (EV-C02-013 3.1, 3.2 and 25 (1)), in this order after the form:
-- * Closing (B:397): with a ledger_handed_over event present, all six refuse handed_over, an exact repeat included.
-- * The key (S2; 3.1): a transferred event of the same transfer_source kind and source_id with the same sha256 is the
--   exact repeat, answered ok with the existing id and "repeat": true, nothing written; another sha256 is conflict. It is
--   read before the run rule; S2's index is the backstop in the write block.
-- * The run (3.1): every call names an open run (a transfer_run event of phase begun and none of phase completed for
--   its run_id), else run_not_open.
-- * Order (3.1; EV-C02-005 3.2): a record the call references that is not yet written is reference_missing.
-- * The mark (3.1): one transferred event per transferred key, on the record's aggregate at its revision 1 (none for a
--   family without revisions), payload {transfer_source (its six validated strings), run_id, lacks}, with declared and
--   source_fields when sent; the record's own fields carry no source date: created_at is the database's (EV-C02-013
--   22 (1)). The transferred event is the record's creation event; no other event is written.
-- * Sampling (3.1; EV-C02-008 2.7): transfer_decision, transfer_work, transfer_finding and transfer_need call nothing
--   until W-C02-10 builds the sampling function and replaces them.

-- transfer_mission (EV-C02-013 3.2 with R1-9, R2-7, C-20 and 26 (2); B 3.1, B:397; EV-C02-005 1.2 row 1, 2.1; DM-23):
-- the installation's Mission and its revision 1, and its transferred mark. Payload: run_id, transfer_source (kind
-- mission), purpose, scope (installation), acceptance, owner_authority (a Decision's uuid) and owner_authority_revision,
-- all required; constraints (an array, default []); status (active, paused or closed; default active). Order after the
-- gate: the form (owner_authority_revision absent: could_not_check, a reference without its revision; not an integer of
-- at least 1: invalid_field); the closing rule; the key; the open run; one Mission, under a transaction-level advisory
-- lock (key 9004): a Mission whose creation event is transferred exists, conflict (EV-C02-005 2.1); a Mission's
-- creation event whose type is NULL, could_not_check; the owner authority, in 2.2's order: a Decision not yet written,
-- reference_missing (3.1, "Order"); its class or status NULL, could_not_check; not batu, or not answered or accepted, mission_authority; answered_revision NULL,
-- could_not_check; answered_revision other than owner_authority_revision, mission_authority; then D-010 (R1-9): its
-- creation event missing or of NULL type, could_not_check; not a transferred event of kind decision and source ID
-- D-010, mission_authority. It writes no created_at from its input. Answer {"status": "ok", "id", "revision": 1}.
create function devos_api.transfer_mission(p jsonb)
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
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_mission: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
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

-- transfer_work (EV-C02-013 3.2 with R2-4 and 26 (3); B 3.3, 3.18; EV-C02-005 1.2 rows 2, 3 and 5, 1.4, 2.1): a Work,
-- its revision 1 and its own EffortPolicy (work_ref the Work, level high, no reduction), with two transferred marks:
-- the Work's (kind work) and the policy's (kind effort_policy, the Work's source ID, lacks the two steps the
-- installation's records do not hold). No claim is made (EV-C02-005 row 3). Payload: run_id, transfer_source (kind
-- work), mission_ref (the installation's Mission), mission_revision, scope (installation), purpose, impact_class (high
-- only), execution and acceptance (as recorded), effort_policy ({level: high, expert_assessment_ref,
-- non_removable_steps}), all required; acceptance_ref, consumer, return_to, stop_rule (strings); input_refs and
-- target_refs (arrays of {ref, revision}, R2-4), method_refs, mandatory_needs (arrays), each default []. Order after the
-- gate: the form (mission_revision absent: could_not_check); the closing rule; the key (the Work's; a policy mark of
-- the source without the Work's: could_not_check); the open run; the Mission, for share: not yet written,
-- reference_missing; not the installation's, invalid_field; one that cannot be told, could_not_check; its revision:
-- none such, reference_missing; an earlier one, stale_revision; the scope not within the Mission revision's,
-- scope_outside (B principle 4); each element of input_refs and target_refs: a record of another family than Work,
-- Artifact, Finding or Decision, invalid_field; none such, or no such revision, reference_missing. Answer {"status":
-- "ok", "id", "revision": 1, "effort_policy_id"}.
create function devos_api.transfer_work(p jsonb)
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
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_work: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the Work's mark; the exact repeat answers the Work and its policy.
    v_check := 'key';
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

-- transfer_relation (EV-C02-013 3.2 with R2-5 and 26 (4); B 3.4; EV-C02-005 3.3): a Relation and its transferred mark
-- (aggregate relation: the hook transferred_relation's form, section 4). Payload: run_id, transfer_source (kind
-- relation), type (B 3.4's ten), from_ref and to_ref (uuids), scope (installation), method and epistemic_status, all
-- required; from_revision and to_revision (an end with revisions needs its own); hard (default false); group_id with
-- group_mode, or group_mode alone, a group of its own (R2-5); use; validity (current, stale or retracted; default
-- current). Order after the gate: the form (an end sent as a number or an object, an Event's form: invalid_field,
-- section 12; relation_rule for model_extracted with observation, B 3.4); the closing rule; the key; the open run; for
-- a hard depends_on, M09-02's hard_dependency_cycle, which takes DM-01's advisory lock before any row lock; the two
-- ends, each a record of M09-06's fourteen families: none written yet, reference_missing (3.1, "Order"); a revisioned
-- record's end without its revision, could_not_check; a revision not written yet, reference_missing; a revision sent
-- for a record without revisions, invalid_field; the from_ref row locked for update; the group (one from_ref, one
-- mode); a current relation of the same type, ends, revisions, hard, group and use not written under this key:
-- conflict (B 3.4: an exact repeat makes no new record); the cycle (true: cycle; NULL: could_not_check). No Rule O or
-- Rule C (EV-C02-008 1.7.1 lists neither for the transfer). Answer {"status": "ok", "id"}.
create function devos_api.transfer_relation(p jsonb)
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
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_relation: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
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

-- transfer_decision (EV-C02-013 3.2 with R2-7, 22 (1) and 26 (5); README 8.1; B 3.17; EV-C02-005 2.2 and 2.6): a
-- Decision in the status its record holds, its revision 1, and its transferred mark, whose lacks lists the fields the
-- record leaves empty (B:308; EV-C02-005 2.2). Payload: run_id, transfer_source (kind decision), class (high_impact or
-- batu; routine is refused, EV-C02-005 2.2), question and status (answered, accepted, declined, superseded, withdrawn or
-- open), all required; B 3.17's fields presented_text_tr, why_this_owner, options, alternatives_considered,
-- single_viable_path_reason, premises, criteria, evidence_refs, assumptions, reversibility, reopen_triggers,
-- recommendation, recommendation_rationale, if_unanswered and alternatives_state; the answer fields
-- answer_original_tr, answer_interpretation_en, answered_by, answer_channel_ref and answered_at (a time), copied as
-- recorded. answered_revision is 1 when the status is answered, accepted or declined, or when answered_at is sent
-- (EV-C02-005 2.6; DM-11); answered_at is the record's own value, never the database's clock (EV-C02-013 22 (1)). The
-- answer key is not read (EV-C02-005 2.2: it stays empty). Order after the gate: the form, with open_exploration
-- (alternatives_state open_exploration, status answered or accepted, and neither options nor single_viable_path_reason
-- entered; B 3.17) decided from the call alone; the closing rule; the key; the open run. Answer {"status": "ok", "id",
-- "revision": 1}.
create function devos_api.transfer_decision(p jsonb)
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
    if jsonb_typeof(p_in -> 'answered_at') = 'string' then
      begin
        v_answered_at := (p_in ->> 'answered_at')::timestamptz;
      exception when others then
        v_answered_at := null;
      end;
      if v_answered_at is null then
        v_code := 'invalid_field'; v_reason := 'answered_at: not a time';
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
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_decision: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
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

-- transfer_need (EV-C02-013 3.2 and 26 (6); B 3.2's transferred bullet; EV-C02-005 2.3): a Need and its transferred
-- mark. Payload: run_id, transfer_source (kind need), mission_ref (the installation's Mission), condition, why_needed
-- and status (open or resolved), all required; consumer and return_to (strings). Need's origin is left empty (B 3.2).
-- Order after the gate: the form; the closing rule; the key; the open run; the Mission, for share: not yet written,
-- reference_missing; not the installation's, invalid_field; one that cannot be told, could_not_check. Answer
-- {"status": "ok", "id"}.
create function devos_api.transfer_need(p jsonb)
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
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_need: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
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

-- transfer_finding (EV-C02-013 3.2 and 26 (7); B 3.8's transferred bullet; EV-C02-005 1.2 row 15, S4): a Finding, its
-- revision 1 and its transferred mark, whose lacks lists the gate fields held as not_recorded and the optional fields
-- the record leaves empty. Payload: run_id, transfer_source (kind finding), claim, scope, counter_evidence_searched
-- (not_recorded admitted here only), changeable (yes, no or not_recorded), epistemic_status, current_authority,
-- privacy_class (public only) and status (candidate only), all required; source_type, source_spans (each an object
-- with primary, a boolean, and read_at, a date, when dated), qualifiers, confidence, open_questions, fresh_until (a
-- date) and use_scope. Order after the gate: the form; the closing rule; the key; the open run. Answer {"status":
-- "ok", "id", "revision": 1}.
create function devos_api.transfer_finding(p jsonb)
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
    if exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over') then
      v_code := 'handed_over';
      v_reason := 'transfer_finding: the ledger is handed over (a ledger_handed_over event exists; B section 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
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

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)). PUBLIC's default EXECUTE is revoked from
-- the six functions, and so is any privilege of the four API roles; then EXECUTE is granted to anon, the role a Data
-- API request with the publishable key runs as. Each function checks the token itself. This file adds no type and no
-- devos_private function. None of the six is a read, so none carries the devos:read comment (F06).
revoke all on function devos_api.transfer_mission(jsonb) from public;
revoke all on function devos_api.transfer_work(jsonb) from public;
revoke all on function devos_api.transfer_relation(jsonb) from public;
revoke all on function devos_api.transfer_decision(jsonb) from public;
revoke all on function devos_api.transfer_need(jsonb) from public;
revoke all on function devos_api.transfer_finding(jsonb) from public;
do $$
declare r text; f text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      foreach f in array array['devos_api.transfer_mission(jsonb)', 'devos_api.transfer_work(jsonb)',
                               'devos_api.transfer_relation(jsonb)', 'devos_api.transfer_decision(jsonb)',
                               'devos_api.transfer_need(jsonb)', 'devos_api.transfer_finding(jsonb)'] loop
        execute format('revoke all on function %s from %I', f, r);
      end loop;
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.transfer_mission(jsonb) to anon;
    grant execute on function devos_api.transfer_work(jsonb) to anon;
    grant execute on function devos_api.transfer_relation(jsonb) to anon;
    grant execute on function devos_api.transfer_decision(jsonb) to anon;
    grant execute on function devos_api.transfer_need(jsonb) to anon;
    grant execute on function devos_api.transfer_finding(jsonb) to anon;
  end if;
end
$$;
