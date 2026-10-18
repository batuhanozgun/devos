-- DevOS schema (W-C02-09), not a fixture. M09-04: Work and effort policy.
-- Sources: plan/work/W-C02-09.md points 1, 2, 3, 5 and 7; Appendix B principles 2, 3, 4 and 8, 3.3, 3.13, 3.18 and
-- section 4 (rows "Work" and "User and policy"); evidence/C02/EV-C02-013_w09_interface.md sections 1 (items 3 to 14),
-- 2.3 with "What Rule O reads" (R2-6), R2-4 (the {ref, revision} form of input_refs and target_refs), R2-9 (the repeat
-- before stale_revision), sections 10 and 17 (C-M04); EV-C02-008 1.7.1 (Rules O and C) and 1.7.4 (set_effort_policy's
-- three kinds); EV-C02-002 DM-01, DM-02, DM-09, DM-19, DM-31, DM-34. Record: evidence/C02/EV-C02-014_w09_build.md section 5.
-- It holds exactly section 10's row M09-04, the six functions of EV-C02-013 section 2.3: devos_api.admit_work,
-- revise_work, mark_stale, cancel_work, reopen_for_review and set_effort_policy. It adds no table, type or private
-- function, and changes nothing of M09-01 to M09-03, whose helpers it calls: caller_role_class, write_event, reject,
-- scope_within and is_installation_mission. No token, hash or key value is written here.
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12).
--
-- The common form is M09-03's (EV-C02-013 section 1 items 6, 7, 9 and 10, R1-1): (a) the derivation, before any other
-- check; then a read block holding (b) the role list, a literal of the function's own text (B:48), (c) the input's form,
-- (d) ownership (Rule O, then Rule C) and (f) the family's rules, writing nothing; then a write block holding (g) the
-- writes and their events through devos_private.write_event, with the caller's role class. A check that decides a
-- refusal sets v_code and v_reason and raises P0D01; any other error in the read block is could_not_check,
-- "<v_check>: its input could not be read (SQLSTATE <code>)"; any error in the write block is write_failed, but P0D02,
-- which is could_not_check with its fixed reason. After either block's refusal one per-call RejectedAttempt row is
-- written by devos_private.reject. A reason holds fixed text and an SQLSTATE only. Keys a function does not read are
-- ignored (item 4); declared_session_id goes to the events and the refusal rows only (item 5). An exact repeat writes
-- nothing and answers ok with the existing id and "repeat": true, before stale_revision (item 10, R2-9).
--
-- Rule O (EV-C02-008 1.7.1), as EV-C02-013 2.3 says it reads: the work item's current revision in work_revision (its
-- mission_revision_id), the mission_revision row that names (its mission_id), and, through is_installation_mission,
-- that Mission's events; for devos_sinav, the exam link; never devos_private.mission. devos_kurulum: only a work item
-- under the installation's Mission; devos_calisma: only one not under it (an exam task is changed as any other item);
-- devos_sinav: only one its exam link names; devos_denetim (reopen_for_review only): any. A Mission whose creation event
-- cannot be read is could_not_check, never "not transferred" (item 7 (ii)). Rule C (revise_work, cancel_work): refused
-- other_class_claim while an active claim whose lease has not run out (DM-06) is held by another role class; a claim
-- without its status, lease or role class is could_not_check. The reasons name the rule, never the item's opener.

-- admit_work (EV-C02-013 2.3 with R2-4; B 3.3, principle 4; DM-34): a Work, its revision 1 and work_admitted. Payload:
-- mission_ref, mission_revision, scope, purpose, impact_class (routine or high) required; input_refs, target_refs (each
-- element {"ref": <uuid>, "revision": <integer>} naming a revision of a Work, an Artifact, a Finding or a Decision),
-- consumer, return_to, stop_rule, acceptance_ref, effort_policy_ref, method_refs, mandatory_needs. Order after the form:
-- the Mission (could_not_check when it cannot be read: a reference); mission_revision naming no revision of it:
-- could_not_check; an earlier one: stale_revision; the Mission not active: mission_not_active; a scope not equal to or
-- under the Mission revision's: scope_outside; each element of input_refs and target_refs (another family:
-- invalid_field; no record, no such revision, or no revision sent: could_not_check); effort_policy_ref (no record:
-- could_not_check; a retired policy: invalid_field, B 3.18). mission_revision absent: could_not_check (a reference
-- without its revision, as C-20 and R2-1). The impact-class rules are W-C02-10's. devos_calisma, devos_sinav,
-- devos_kurulum (EV-C02-003 4.1). No exact repeat: a second call admits a second work item.
create function devos_api.admit_work(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'admit_work';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_el jsonb;
  v_ref uuid;
  v_ref_rev integer;
  v_rev_found boolean;
  v_mission uuid;
  v_mrev integer;
  v_mrev_id uuid;
  v_mscope text;
  v_mcur integer;
  v_mstatus devos_private.mission_status;
  v_within boolean;
  v_impact devos_private.impact_class;
  v_input jsonb;
  v_target jsonb;
  v_method jsonb;
  v_needs jsonb;
  v_policy uuid;
  v_pstatus devos_private.effort_policy_status;
  v_id uuid;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;
  if jsonb_typeof(p -> 'declared_session_id') = 'string' then
    v_decl := p ->> 'declared_session_id';
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_calisma', 'devos_sinav', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'admit_work admits only the role classes devos_calisma, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    v_check := 'input';
    if p is null then
      v_code := 'missing_field'; v_reason := 'p: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p) <> 'object' then
      v_code := 'invalid_field'; v_reason := 'p: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    foreach v_key in array array['mission_ref', 'scope', 'purpose', 'impact_class'] loop
      if coalesce(jsonb_typeof(p -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p ->> 'mission_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'mission_ref: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_mission := (p ->> 'mission_ref')::uuid;
    if (p ->> 'scope') !~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$' then
      v_code := 'invalid_field'; v_reason := 'scope: not a dotted path of lower-case labels';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p ->> 'impact_class') not in ('routine', 'high') then
      v_code := 'invalid_field'; v_reason := 'impact_class: not routine or high';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_impact := (p ->> 'impact_class')::devos_private.impact_class;
    if coalesce(jsonb_typeof(p -> 'mission_revision'), 'null') = 'null' then
      v_code := 'could_not_check'; v_reason := 'mission_revision: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p -> 'mission_revision') <> 'number' or (p ->> 'mission_revision') !~ '^[1-9][0-9]{0,8}$' then
      v_code := 'invalid_field'; v_reason := 'mission_revision: not an integer of at least 1';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_mrev := (p ->> 'mission_revision')::integer;
    foreach v_key in array array['consumer', 'return_to', 'stop_rule', 'acceptance_ref', 'effort_policy_ref'] loop
      if coalesce(jsonb_typeof(p -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if jsonb_typeof(p -> 'effort_policy_ref') = 'string' then
      if (p ->> 'effort_policy_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
        v_code := 'invalid_field'; v_reason := 'effort_policy_ref: not a uuid';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_policy := (p ->> 'effort_policy_ref')::uuid;
    end if;
    foreach v_key in array array['input_refs', 'target_refs', 'method_refs', 'mandatory_needs'] loop
      if coalesce(jsonb_typeof(p -> v_key), 'null') not in ('null', 'array') then
        v_code := 'invalid_field'; v_reason := v_key || ': not an array';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    v_input := coalesce(nullif(p -> 'input_refs', 'null'::jsonb), '[]'::jsonb);
    v_target := coalesce(nullif(p -> 'target_refs', 'null'::jsonb), '[]'::jsonb);
    v_method := coalesce(nullif(p -> 'method_refs', 'null'::jsonb), '[]'::jsonb);
    v_needs := coalesce(nullif(p -> 'mandatory_needs', 'null'::jsonb), '[]'::jsonb);
    foreach v_key in array array['input_refs', 'target_refs'] loop
      for v_el in select x.value from jsonb_array_elements(case when v_key = 'input_refs' then v_input else v_target end) x loop
        if jsonb_typeof(v_el) <> 'object' or coalesce(jsonb_typeof(v_el -> 'ref'), 'null') <> 'string'
           or (v_el ->> 'ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
           or (coalesce(jsonb_typeof(v_el -> 'revision'), 'null') <> 'null'
               and (jsonb_typeof(v_el -> 'revision') <> 'number' or (v_el ->> 'revision') !~ '^[1-9][0-9]{0,8}$')) then
          v_code := 'invalid_field'; v_reason := v_key || ': an element is not {"ref": <uuid>, "revision": <integer>}';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end loop;
    end loop;

    -- (f) The Mission and the revision named (B 3.3: "link to the mission revision").
    v_check := 'mission_ref';
    select m.status into v_mstatus from devos_private.mission m where m.id = v_mission for share;
    if not found then
      v_code := 'could_not_check'; v_reason := 'mission_ref: the record could not be read';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_mstatus is null then
      v_code := 'could_not_check'; v_reason := 'mission_ref: its status is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'mission_revision';
    select max(r.revision) into v_mcur from devos_private.mission_revision r where r.mission_id = v_mission;
    if v_mcur is null then
      v_code := 'could_not_check'; v_reason := 'mission_ref: the Mission has no revision (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select r.id, r.scope into v_mrev_id, v_mscope
      from devos_private.mission_revision r where r.mission_id = v_mission and r.revision = v_mrev;
    if v_mrev_id is null or v_mscope is null then
      v_code := 'could_not_check'; v_reason := 'mission_revision: the revision could not be read';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_mrev <> v_mcur then
      v_code := 'stale_revision'; v_reason := 'mission_revision: not the Mission''s current revision';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_mstatus <> 'active' then
      v_code := 'mission_not_active'; v_reason := 'mission_ref: the Mission is not active';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'scope';
    v_within := devos_private.scope_within(p ->> 'scope', v_mscope);
    if v_within is null then
      v_code := 'could_not_check'; v_reason := 'scope: the containment could not be decided';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if not v_within then
      v_code := 'scope_outside'; v_reason := 'scope: does not equal or lie under the Mission''s scope (B principle 4; DM-34)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The records input_refs and target_refs name (EV-C02-013 2.3, R2-4).
    foreach v_key in array array['input_refs', 'target_refs'] loop
      v_check := v_key;
      for v_el in select x.value from jsonb_array_elements(case when v_key = 'input_refs' then v_input else v_target end) x loop
        v_ref := (v_el ->> 'ref')::uuid;
        v_ref_rev := case when jsonb_typeof(v_el -> 'revision') = 'number' then (v_el ->> 'revision')::integer end;
        if exists (select 1 from devos_private.work x where x.id = v_ref) then
          v_rev_found := exists (select 1 from devos_private.work_revision x where x.work_id = v_ref and x.revision = v_ref_rev);
        elsif exists (select 1 from devos_private.artifact x where x.id = v_ref) then
          v_rev_found := exists (select 1 from devos_private.artifact_revision x where x.artifact_id = v_ref and x.revision = v_ref_rev);
        elsif exists (select 1 from devos_private.finding x where x.id = v_ref) then
          v_rev_found := exists (select 1 from devos_private.finding_revision x where x.finding_id = v_ref and x.revision = v_ref_rev);
        elsif exists (select 1 from devos_private.decision x where x.id = v_ref) then
          v_rev_found := exists (select 1 from devos_private.decision_revision x where x.decision_id = v_ref and x.revision = v_ref_rev);
        elsif exists (select 1 from devos_private.mission x where x.id = v_ref)
              or exists (select 1 from devos_private.need x where x.id = v_ref)
              or exists (select 1 from devos_private.relation x where x.id = v_ref)
              or exists (select 1 from devos_private.effort_policy x where x.id = v_ref)
              or exists (select 1 from devos_private.assignment x where x.id = v_ref)
              or exists (select 1 from devos_private.review x where x.id = v_ref)
              or exists (select 1 from devos_private.verdict x where x.id = v_ref)
              or exists (select 1 from devos_private.acceptance x where x.id = v_ref)
              or exists (select 1 from devos_private.operation x where x.id = v_ref) then
          v_code := 'invalid_field';
          v_reason := v_key || ': an element names a record that is not a Work, an Artifact, a Finding or a Decision';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        else
          v_code := 'could_not_check'; v_reason := v_key || ': a record could not be read';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_ref_rev is null then
          v_code := 'could_not_check'; v_reason := v_key || ': an element is sent without its revision (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if not v_rev_found then
          v_code := 'could_not_check'; v_reason := v_key || ': a record could not be read';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end loop;
    end loop;

    -- (f) The effort policy named (B 3.18: "an item cannot cite a retired policy").
    if v_policy is not null then
      v_check := 'effort_policy_ref';
      select ep.status into v_pstatus from devos_private.effort_policy ep where ep.id = v_policy for share;
      if not found then
        v_code := 'could_not_check'; v_reason := 'effort_policy_ref: the record could not be read';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_pstatus is null then
        v_code := 'could_not_check'; v_reason := 'effort_policy_ref: its status is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_pstatus = 'retired' then
        v_code := 'invalid_field'; v_reason := 'effort_policy_ref: names a retired policy (B 3.18)';
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

  -- The write block: step (g).
  begin
    v_check := 'write';
    insert into devos_private.work default values returning id into v_id;
    insert into devos_private.work_revision (work_id, revision, mission_revision_id, scope, purpose, input_refs, target_refs,
                                             consumer, return_to, stop_rule, acceptance_ref, impact_class,
                                             effort_policy_ref, method_refs, mandatory_needs)
    values (v_id, 1, v_mrev_id, p ->> 'scope', p ->> 'purpose', v_input, v_target, p ->> 'consumer', p ->> 'return_to',
            p ->> 'stop_rule', p ->> 'acceptance_ref', v_impact, v_policy, v_method, v_needs);
    perform devos_private.write_event('work', v_id, 1, 'work_admitted',
      jsonb_strip_nulls(jsonb_build_object('mission_ref', v_mission, 'mission_revision', v_mrev, 'scope', p ->> 'scope',
        'purpose', p ->> 'purpose', 'impact_class', v_impact::text, 'input_refs', v_input, 'target_refs', v_target,
        'consumer', p ->> 'consumer', 'return_to', p ->> 'return_to', 'stop_rule', p ->> 'stop_rule',
        'acceptance_ref', p ->> 'acceptance_ref', 'effort_policy_ref', v_policy, 'method_refs', v_method,
        'mandatory_needs', v_needs)),
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
  return jsonb_build_object('status', 'ok', 'id', v_id, 'revision', 1);
end
$fn$;

-- revise_work (EV-C02-013 2.3 with R2-4, R2-9 and C-M04; B principle 3, 3.3; DM-02): a new revision of a work item.
-- Payload: id and base_revision (required); any revision field of admit_work but mission_ref (mission_revision, scope,
-- purpose, impact_class, input_refs, target_refs, consumer, return_to, stop_rule, acceptance_ref, effort_policy_ref,
-- method_refs, mandatory_needs); reason, required on every call that writes a new revision (B principle 3: an update
-- "produces a new revision and a reason"). A key absent or JSON null keeps the current revision's value. Order after
-- the form: the work item (not_found; its row locked for update); its current revision (could_not_check when
-- missing); Rule O; Rule C; a mission_revision sent that names no revision of the work item's Mission:
-- could_not_check; the exact repeat (every field as the current revision's: ok, "repeat": true, before
-- stale_revision); no string reason: missing_field; base_revision not the current revision: stale_revision; a
-- mission_revision sent that is not the Mission's current: stale_revision; the elements of input_refs and target_refs
-- sent, and effort_policy_ref, as admit_work checks them; a scope not equal to or under the scope of the Mission
-- revision the new revision is tied to: scope_outside. devos_calisma, devos_sinav, devos_kurulum (EV-C02-008 1.2).
create function devos_api.revise_work(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'revise_work';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_el jsonb;
  v_ref uuid;
  v_ref_rev integer;
  v_rev_found boolean;
  v_answer jsonb;
  v_id uuid;
  v_base integer;
  v_target_rev integer;
  v_mrev integer;
  v_mcur integer;
  v_mission uuid;
  v_mscope text;
  v_inst boolean;
  v_partial bigint;
  v_other bigint;
  v_within boolean;
  v_pstatus devos_private.effort_policy_status;
  v_cur_rev integer;
  v_cur_mrev uuid;
  v_cur_scope text;
  v_cur_purpose text;
  v_cur_input jsonb;
  v_cur_target jsonb;
  v_cur_consumer text;
  v_cur_return_to text;
  v_cur_stop_rule text;
  v_cur_acceptance_ref text;
  v_cur_impact devos_private.impact_class;
  v_cur_policy uuid;
  v_cur_method jsonb;
  v_cur_needs jsonb;
  v_new_mrev uuid;
  v_new_mscope text;
  v_new_scope text;
  v_new_purpose text;
  v_new_input jsonb;
  v_new_target jsonb;
  v_new_consumer text;
  v_new_return_to text;
  v_new_stop_rule text;
  v_new_acceptance_ref text;
  v_new_impact devos_private.impact_class;
  v_new_policy uuid;
  v_new_method jsonb;
  v_new_needs jsonb;
  v_rev integer;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;
  if jsonb_typeof(p -> 'declared_session_id') = 'string' then
    v_decl := p ->> 'declared_session_id';
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_calisma', 'devos_sinav', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'revise_work admits only the role classes devos_calisma, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    v_check := 'input';
    if p is null then
      v_code := 'missing_field'; v_reason := 'p: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p) <> 'object' then
      v_code := 'invalid_field'; v_reason := 'p: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p -> 'id'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p -> 'id') <> 'string'
       or (p ->> 'id') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'id: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_id := (p ->> 'id')::uuid;
    if coalesce(jsonb_typeof(p -> 'base_revision'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'base_revision: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p -> 'base_revision') <> 'number' or (p ->> 'base_revision') !~ '^[1-9][0-9]{0,8}$' then
      v_code := 'invalid_field'; v_reason := 'base_revision: not an integer of at least 1';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_base := (p ->> 'base_revision')::integer;
    v_target_rev := v_base;
    foreach v_key in array array['scope', 'purpose', 'impact_class', 'consumer', 'return_to', 'stop_rule',
                                 'acceptance_ref', 'effort_policy_ref', 'reason'] loop
      if coalesce(jsonb_typeof(p -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if jsonb_typeof(p -> 'scope') = 'string' and (p ->> 'scope') !~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$' then
      v_code := 'invalid_field'; v_reason := 'scope: not a dotted path of lower-case labels';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p -> 'impact_class') = 'string' and (p ->> 'impact_class') not in ('routine', 'high') then
      v_code := 'invalid_field'; v_reason := 'impact_class: not routine or high';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p -> 'effort_policy_ref') = 'string'
       and (p ->> 'effort_policy_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'effort_policy_ref: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p -> 'mission_revision'), 'null') <> 'null' then
      if jsonb_typeof(p -> 'mission_revision') <> 'number' or (p ->> 'mission_revision') !~ '^[1-9][0-9]{0,8}$' then
        v_code := 'invalid_field'; v_reason := 'mission_revision: not an integer of at least 1';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_mrev := (p ->> 'mission_revision')::integer;
    end if;
    foreach v_key in array array['input_refs', 'target_refs', 'method_refs', 'mandatory_needs'] loop
      if coalesce(jsonb_typeof(p -> v_key), 'null') not in ('null', 'array') then
        v_code := 'invalid_field'; v_reason := v_key || ': not an array';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    foreach v_key in array array['input_refs', 'target_refs'] loop
      if jsonb_typeof(p -> v_key) = 'array' then
        for v_el in select x.value from jsonb_array_elements(p -> v_key) x loop
          if jsonb_typeof(v_el) <> 'object' or coalesce(jsonb_typeof(v_el -> 'ref'), 'null') <> 'string'
             or (v_el ->> 'ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
             or (coalesce(jsonb_typeof(v_el -> 'revision'), 'null') <> 'null'
                 and (jsonb_typeof(v_el -> 'revision') <> 'number' or (v_el ->> 'revision') !~ '^[1-9][0-9]{0,8}$')) then
            v_code := 'invalid_field'; v_reason := v_key || ': an element is not {"ref": <uuid>, "revision": <integer>}';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        end loop;
      end if;
    end loop;

    -- (f) The work item and its current revision.
    v_check := 'work';
    perform 1 from devos_private.work w where w.id = v_id for update;
    if not found then
      v_code := 'not_found'; v_reason := 'id: names no Work';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select r.revision, r.mission_revision_id, r.scope, r.purpose, r.input_refs, r.target_refs, r.consumer, r.return_to,
           r.stop_rule, r.acceptance_ref, r.impact_class, r.effort_policy_ref, r.method_refs, r.mandatory_needs
      into v_cur_rev, v_cur_mrev, v_cur_scope, v_cur_purpose, v_cur_input, v_cur_target, v_cur_consumer, v_cur_return_to,
           v_cur_stop_rule, v_cur_acceptance_ref, v_cur_impact, v_cur_policy, v_cur_method, v_cur_needs
      from devos_private.work_revision r where r.work_id = v_id order by r.revision desc limit 1;
    if not found or v_cur_rev is null or v_cur_scope is null then
      v_code := 'could_not_check'; v_reason := 'work: its current revision is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (d) Rule O (EV-C02-008 1.7.1; EV-C02-013 2.3, "What Rule O reads").
    v_check := 'rule_o';
    select mr.mission_id, mr.scope into v_mission, v_mscope
      from devos_private.mission_revision mr where mr.id = v_cur_mrev;
    if v_mission is null then
      v_code := 'could_not_check'; v_reason := 'rule_o: the work item''s Mission is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_class = 'devos_sinav' then
      perform 1 from devos_private.eval_run e where e.work_ref = v_id;
      if not found then
        v_code := 'not_owner';
        v_reason := 'Rule O: devos_sinav changes only the work items its exam link names';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    else
      v_inst := devos_private.is_installation_mission(v_mission);
      if v_inst is null then
        v_code := 'could_not_check';
        v_reason := 'rule_o: whether the work item lies under the installation''s Mission is missing or partial';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_class = 'devos_kurulum' and not v_inst then
        v_code := 'not_owner';
        v_reason := 'Rule O: devos_kurulum changes only the work items under the installation''s Mission';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_class = 'devos_calisma' and v_inst then
        v_code := 'not_owner';
        v_reason := 'Rule O: devos_calisma does not change the work items under the installation''s Mission';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end if;

    -- (d) Rule C (EV-C02-008 1.7.1): no active claim of another role class whose lease has not run out (DM-06).
    v_check := 'rule_c';
    select count(*) filter (where a.status is null
                              or (a.status = 'active' and (a.lease_expires_at is null or a.role_class is null))),
           count(*) filter (where a.status = 'active' and a.lease_expires_at > now() and a.role_class <> v_class)
      into v_partial, v_other
      from devos_private.assignment a where a.work_ref = v_id;
    if v_partial > 0 then
      v_code := 'could_not_check'; v_reason := 'rule_c: a claim on the work item lacks its status, lease or role class (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_other > 0 then
      v_code := 'other_class_claim'; v_reason := 'Rule C: another role class holds an active claim on the work item';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The new revision's values; a key absent or JSON null keeps the current value.
    v_check := 'mission_revision';
    v_new_mrev := v_cur_mrev;
    v_new_mscope := v_mscope;
    if v_mrev is not null then
      select r.id, r.scope into v_new_mrev, v_new_mscope
        from devos_private.mission_revision r where r.mission_id = v_mission and r.revision = v_mrev;
      if v_new_mrev is null or v_new_mscope is null then
        v_code := 'could_not_check'; v_reason := 'mission_revision: the revision could not be read';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end if;
    v_new_scope := coalesce(case when jsonb_typeof(p -> 'scope') = 'string' then p ->> 'scope' end, v_cur_scope);
    v_new_purpose := coalesce(case when jsonb_typeof(p -> 'purpose') = 'string' then p ->> 'purpose' end, v_cur_purpose);
    v_new_impact := coalesce(case when jsonb_typeof(p -> 'impact_class') = 'string'
                                  then (p ->> 'impact_class')::devos_private.impact_class end, v_cur_impact);
    v_new_consumer := case when jsonb_typeof(p -> 'consumer') = 'string' then p ->> 'consumer' else v_cur_consumer end;
    v_new_return_to := case when jsonb_typeof(p -> 'return_to') = 'string' then p ->> 'return_to' else v_cur_return_to end;
    v_new_stop_rule := case when jsonb_typeof(p -> 'stop_rule') = 'string' then p ->> 'stop_rule' else v_cur_stop_rule end;
    v_new_acceptance_ref := case when jsonb_typeof(p -> 'acceptance_ref') = 'string' then p ->> 'acceptance_ref'
                                 else v_cur_acceptance_ref end;
    v_new_policy := case when jsonb_typeof(p -> 'effort_policy_ref') = 'string' then (p ->> 'effort_policy_ref')::uuid
                         else v_cur_policy end;
    v_new_input := case when jsonb_typeof(p -> 'input_refs') = 'array' then p -> 'input_refs' else v_cur_input end;
    v_new_target := case when jsonb_typeof(p -> 'target_refs') = 'array' then p -> 'target_refs' else v_cur_target end;
    v_new_method := case when jsonb_typeof(p -> 'method_refs') = 'array' then p -> 'method_refs' else v_cur_method end;
    v_new_needs := case when jsonb_typeof(p -> 'mandatory_needs') = 'array' then p -> 'mandatory_needs' else v_cur_needs end;

    -- The exact repeat, before stale_revision (item 10, R2-9).
    v_check := 'repeat';
    if v_new_mrev is not distinct from v_cur_mrev and v_new_scope is not distinct from v_cur_scope
       and v_new_purpose is not distinct from v_cur_purpose and v_new_impact is not distinct from v_cur_impact
       and v_new_consumer is not distinct from v_cur_consumer and v_new_return_to is not distinct from v_cur_return_to
       and v_new_stop_rule is not distinct from v_cur_stop_rule
       and v_new_acceptance_ref is not distinct from v_cur_acceptance_ref
       and v_new_policy is not distinct from v_cur_policy and v_new_input is not distinct from v_cur_input
       and v_new_target is not distinct from v_cur_target and v_new_method is not distinct from v_cur_method
       and v_new_needs is not distinct from v_cur_needs then
      v_answer := jsonb_build_object('status', 'ok', 'id', v_id, 'revision', v_cur_rev, 'repeat', true);
    end if;

    if v_answer is null then
      -- A new revision needs its reason (B principle 3, B:17; EV-C02-013 section 17 (1)).
      v_check := 'reason';
      if coalesce(jsonb_typeof(p -> 'reason'), 'null') <> 'string' then
        v_code := 'missing_field'; v_reason := 'reason: missing (a call that writes a new revision needs one)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_check := 'revision';
      if v_base <> v_cur_rev then
        v_code := 'stale_revision'; v_reason := 'base_revision: not the work item''s current revision';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_mrev is not null then
        v_check := 'mission_revision';
        select max(r.revision) into v_mcur from devos_private.mission_revision r where r.mission_id = v_mission;
        if v_mcur is null then
          v_code := 'could_not_check'; v_reason := 'mission_revision: the Mission''s current revision could not be read';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_mrev <> v_mcur then
          v_code := 'stale_revision'; v_reason := 'mission_revision: not the Mission''s current revision';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;

      -- (f) The records the input_refs and target_refs sent name (EV-C02-013 2.3, R2-4).
      foreach v_key in array array['input_refs', 'target_refs'] loop
        if jsonb_typeof(p -> v_key) = 'array' then
          v_check := v_key;
          for v_el in select x.value from jsonb_array_elements(p -> v_key) x loop
            v_ref := (v_el ->> 'ref')::uuid;
            v_ref_rev := case when jsonb_typeof(v_el -> 'revision') = 'number' then (v_el ->> 'revision')::integer end;
            if exists (select 1 from devos_private.work x where x.id = v_ref) then
              v_rev_found := exists (select 1 from devos_private.work_revision x where x.work_id = v_ref and x.revision = v_ref_rev);
            elsif exists (select 1 from devos_private.artifact x where x.id = v_ref) then
              v_rev_found := exists (select 1 from devos_private.artifact_revision x where x.artifact_id = v_ref and x.revision = v_ref_rev);
            elsif exists (select 1 from devos_private.finding x where x.id = v_ref) then
              v_rev_found := exists (select 1 from devos_private.finding_revision x where x.finding_id = v_ref and x.revision = v_ref_rev);
            elsif exists (select 1 from devos_private.decision x where x.id = v_ref) then
              v_rev_found := exists (select 1 from devos_private.decision_revision x where x.decision_id = v_ref and x.revision = v_ref_rev);
            elsif exists (select 1 from devos_private.mission x where x.id = v_ref)
                  or exists (select 1 from devos_private.need x where x.id = v_ref)
                  or exists (select 1 from devos_private.relation x where x.id = v_ref)
                  or exists (select 1 from devos_private.effort_policy x where x.id = v_ref)
                  or exists (select 1 from devos_private.assignment x where x.id = v_ref)
                  or exists (select 1 from devos_private.review x where x.id = v_ref)
                  or exists (select 1 from devos_private.verdict x where x.id = v_ref)
                  or exists (select 1 from devos_private.acceptance x where x.id = v_ref)
                  or exists (select 1 from devos_private.operation x where x.id = v_ref) then
              v_code := 'invalid_field';
              v_reason := v_key || ': an element names a record that is not a Work, an Artifact, a Finding or a Decision';
              raise exception using errcode = 'P0D01', message = 'devos refusal';
            else
              v_code := 'could_not_check'; v_reason := v_key || ': a record could not be read';
              raise exception using errcode = 'P0D01', message = 'devos refusal';
            end if;
            if v_ref_rev is null then
              v_code := 'could_not_check'; v_reason := v_key || ': an element is sent without its revision (partial)';
              raise exception using errcode = 'P0D01', message = 'devos refusal';
            end if;
            if not v_rev_found then
              v_code := 'could_not_check'; v_reason := v_key || ': a record could not be read';
              raise exception using errcode = 'P0D01', message = 'devos refusal';
            end if;
          end loop;
        end if;
      end loop;

      if jsonb_typeof(p -> 'effort_policy_ref') = 'string' then
        v_check := 'effort_policy_ref';
        select ep.status into v_pstatus from devos_private.effort_policy ep where ep.id = v_new_policy for share;
        if not found then
          v_code := 'could_not_check'; v_reason := 'effort_policy_ref: the record could not be read';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_pstatus is null then
          v_code := 'could_not_check'; v_reason := 'effort_policy_ref: its status is missing (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_pstatus = 'retired' then
          v_code := 'invalid_field'; v_reason := 'effort_policy_ref: names a retired policy (B 3.18)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;

      v_check := 'scope';
      v_within := devos_private.scope_within(v_new_scope, v_new_mscope);
      if v_within is null then
        v_code := 'could_not_check'; v_reason := 'scope: the containment could not be decided';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if not v_within then
        v_code := 'scope_outside'; v_reason := 'scope: does not equal or lie under the Mission''s scope (B principle 4; DM-34)';
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
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_id, v_target_rev);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    v_rev := v_cur_rev + 1;
    insert into devos_private.work_revision (work_id, revision, mission_revision_id, scope, purpose, input_refs, target_refs,
                                             consumer, return_to, stop_rule, acceptance_ref, impact_class,
                                             effort_policy_ref, method_refs, mandatory_needs, reason)
    values (v_id, v_rev, v_new_mrev, v_new_scope, v_new_purpose, v_new_input, v_new_target, v_new_consumer,
            v_new_return_to, v_new_stop_rule, v_new_acceptance_ref, v_new_impact, v_new_policy, v_new_method, v_new_needs,
            p ->> 'reason');
    perform devos_private.write_event('work', v_id, v_rev, 'work_revised',
      jsonb_strip_nulls(jsonb_build_object('base_revision', v_base, 'revision', v_rev, 'mission_ref', v_mission,
        'mission_revision', v_mrev, 'scope', v_new_scope, 'purpose', v_new_purpose, 'impact_class', v_new_impact::text,
        'input_refs', v_new_input, 'target_refs', v_new_target, 'consumer', v_new_consumer, 'return_to', v_new_return_to,
        'stop_rule', v_new_stop_rule, 'acceptance_ref', v_new_acceptance_ref, 'effort_policy_ref', v_new_policy,
        'method_refs', v_new_method, 'mandatory_needs', v_new_needs, 'reason', p ->> 'reason')),
      v_class::text, 'call', v_decl);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_id, v_target_rev);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id, 'revision', v_rev);
end
$fn$;

-- mark_stale (EV-C02-013 2.3; B 3.3: "If a work item's input changes, it becomes qualification = stale; the old output
-- is not deleted"): the work item's qualification set stale, with its reason in the event work_marked_stale. Rule O,
-- not Rule C (B:134: a running claimant must learn that its input changed). An id that names no Work: not_found.
-- Already stale: the exact repeat. State, not a revision (DM-09), so reason may be NULL. devos_calisma, devos_sinav,
-- devos_kurulum (EV-C02-008 1.2).
create function devos_api.mark_stale(work_id uuid, reason text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'mark_stale';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_answer jsonb;
  v_qual devos_private.work_qualification;
  v_cur_rev integer;
  v_cur_mrev uuid;
  v_mission uuid;
  v_inst boolean;
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
    if not (v_class = any (array['devos_calisma', 'devos_sinav', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'mark_stale admits only the role classes devos_calisma, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if work_id is null then
      v_code := 'missing_field'; v_reason := 'work_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The work item and its current revision.
    v_check := 'work';
    select w.qualification into v_qual from devos_private.work w where w.id = work_id for update;
    if not found then
      v_code := 'not_found'; v_reason := 'work_id: names no Work';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_qual is null then
      v_code := 'could_not_check'; v_reason := 'work: its qualification is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select r.revision, r.mission_revision_id into v_cur_rev, v_cur_mrev
      from devos_private.work_revision r where r.work_id = mark_stale.work_id order by r.revision desc limit 1;
    if not found or v_cur_rev is null then
      v_code := 'could_not_check'; v_reason := 'work: its current revision is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (d) Rule O (EV-C02-008 1.7.1; EV-C02-013 2.3, "What Rule O reads").
    v_check := 'rule_o';
    select mr.mission_id into v_mission from devos_private.mission_revision mr where mr.id = v_cur_mrev;
    if v_mission is null then
      v_code := 'could_not_check'; v_reason := 'rule_o: the work item''s Mission is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_class = 'devos_sinav' then
      perform 1 from devos_private.eval_run e where e.work_ref = mark_stale.work_id;
      if not found then
        v_code := 'not_owner';
        v_reason := 'Rule O: devos_sinav changes only the work items its exam link names';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    else
      v_inst := devos_private.is_installation_mission(v_mission);
      if v_inst is null then
        v_code := 'could_not_check';
        v_reason := 'rule_o: whether the work item lies under the installation''s Mission is missing or partial';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_class = 'devos_kurulum' and not v_inst then
        v_code := 'not_owner';
        v_reason := 'Rule O: devos_kurulum changes only the work items under the installation''s Mission';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_class = 'devos_calisma' and v_inst then
        v_code := 'not_owner';
        v_reason := 'Rule O: devos_calisma does not change the work items under the installation''s Mission';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end if;

    v_check := 'repeat';
    if v_qual = 'stale' then
      v_answer := jsonb_build_object('status', 'ok', 'id', work_id, 'repeat', true);
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, work_id);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    update devos_private.work w set qualification = 'stale' where w.id = mark_stale.work_id;
    perform devos_private.write_event('work', work_id, v_cur_rev, 'work_marked_stale',
      jsonb_strip_nulls(jsonb_build_object('qualification', 'stale', 'previous_qualification', v_qual::text,
                                           'reason', reason)),
      v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, work_id);
  end if;
  return jsonb_build_object('status', 'ok', 'id', work_id);
end
$fn$;

-- cancel_work (EV-C02-013 2.3; B 3.3: "The late result of a cancelled claim is kept as candidate evidence"): the work
-- item's execution set cancelled, with its reason in the event work_cancelled. Rule O, then Rule C (EV-C02-008 1.7.1).
-- A claim of the caller's own class stays; its late effect is refused by the claim check (check_claim:
-- claim_not_active), and nothing it registered is changed. An id that names no Work: not_found. Already cancelled: the
-- exact repeat. State, not a revision (DM-09), so reason may be NULL. devos_calisma, devos_sinav, devos_kurulum.
create function devos_api.cancel_work(work_id uuid, reason text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'cancel_work';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_answer jsonb;
  v_exec devos_private.work_execution;
  v_cur_rev integer;
  v_cur_mrev uuid;
  v_mission uuid;
  v_inst boolean;
  v_partial bigint;
  v_other bigint;
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
    if not (v_class = any (array['devos_calisma', 'devos_sinav', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'cancel_work admits only the role classes devos_calisma, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if work_id is null then
      v_code := 'missing_field'; v_reason := 'work_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The work item and its current revision.
    v_check := 'work';
    select w.execution into v_exec from devos_private.work w where w.id = work_id for update;
    if not found then
      v_code := 'not_found'; v_reason := 'work_id: names no Work';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_exec is null then
      v_code := 'could_not_check'; v_reason := 'work: its execution is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select r.revision, r.mission_revision_id into v_cur_rev, v_cur_mrev
      from devos_private.work_revision r where r.work_id = cancel_work.work_id order by r.revision desc limit 1;
    if not found or v_cur_rev is null then
      v_code := 'could_not_check'; v_reason := 'work: its current revision is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (d) Rule O (EV-C02-008 1.7.1; EV-C02-013 2.3, "What Rule O reads").
    v_check := 'rule_o';
    select mr.mission_id into v_mission from devos_private.mission_revision mr where mr.id = v_cur_mrev;
    if v_mission is null then
      v_code := 'could_not_check'; v_reason := 'rule_o: the work item''s Mission is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_class = 'devos_sinav' then
      perform 1 from devos_private.eval_run e where e.work_ref = cancel_work.work_id;
      if not found then
        v_code := 'not_owner';
        v_reason := 'Rule O: devos_sinav changes only the work items its exam link names';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    else
      v_inst := devos_private.is_installation_mission(v_mission);
      if v_inst is null then
        v_code := 'could_not_check';
        v_reason := 'rule_o: whether the work item lies under the installation''s Mission is missing or partial';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_class = 'devos_kurulum' and not v_inst then
        v_code := 'not_owner';
        v_reason := 'Rule O: devos_kurulum changes only the work items under the installation''s Mission';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_class = 'devos_calisma' and v_inst then
        v_code := 'not_owner';
        v_reason := 'Rule O: devos_calisma does not change the work items under the installation''s Mission';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end if;

    -- (d) Rule C (EV-C02-008 1.7.1): no active claim of another role class whose lease has not run out (DM-06).
    v_check := 'rule_c';
    select count(*) filter (where a.status is null
                              or (a.status = 'active' and (a.lease_expires_at is null or a.role_class is null))),
           count(*) filter (where a.status = 'active' and a.lease_expires_at > now() and a.role_class <> v_class)
      into v_partial, v_other
      from devos_private.assignment a where a.work_ref = cancel_work.work_id;
    if v_partial > 0 then
      v_code := 'could_not_check'; v_reason := 'rule_c: a claim on the work item lacks its status, lease or role class (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_other > 0 then
      v_code := 'other_class_claim'; v_reason := 'Rule C: another role class holds an active claim on the work item';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    v_check := 'repeat';
    if v_exec = 'cancelled' then
      v_answer := jsonb_build_object('status', 'ok', 'id', work_id, 'repeat', true);
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, work_id);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    update devos_private.work w set execution = 'cancelled' where w.id = cancel_work.work_id;
    perform devos_private.write_event('work', work_id, v_cur_rev, 'work_cancelled',
      jsonb_strip_nulls(jsonb_build_object('execution', 'cancelled', 'previous_execution', v_exec::text,
                                           'reason', reason)),
      v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, work_id);
  end if;
  return jsonb_build_object('status', 'ok', 'id', work_id);
end
$fn$;

-- reopen_for_review (EV-C02-013 2.3; B 3.3: "Reopening: work items whose basis has changed are taken into the candidate
-- review set; they are not cancelled automatically"): the work item's qualification set needs_review, with its reason
-- in the event work_reopened_for_review; nothing else changes. Rule O, devos_denetim on any work item (EV-C02-008
-- 1.7.1); not Rule C (B:135). An id that names no Work: not_found. Already needs_review: the exact repeat. State, not a
-- revision (DM-09), so reason may be NULL. devos_calisma, devos_denetim, devos_sinav, devos_kurulum (EV-C02-008 1.2).
create function devos_api.reopen_for_review(work_id uuid, reason text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'reopen_for_review';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_answer jsonb;
  v_qual devos_private.work_qualification;
  v_cur_rev integer;
  v_cur_mrev uuid;
  v_mission uuid;
  v_inst boolean;
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
      v_reason := 'reopen_for_review admits only the role classes devos_calisma, devos_denetim, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if work_id is null then
      v_code := 'missing_field'; v_reason := 'work_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The work item and its current revision.
    v_check := 'work';
    select w.qualification into v_qual from devos_private.work w where w.id = work_id for update;
    if not found then
      v_code := 'not_found'; v_reason := 'work_id: names no Work';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_qual is null then
      v_code := 'could_not_check'; v_reason := 'work: its qualification is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select r.revision, r.mission_revision_id into v_cur_rev, v_cur_mrev
      from devos_private.work_revision r where r.work_id = reopen_for_review.work_id order by r.revision desc limit 1;
    if not found or v_cur_rev is null then
      v_code := 'could_not_check'; v_reason := 'work: its current revision is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (d) Rule O (EV-C02-008 1.7.1; EV-C02-013 2.3, "What Rule O reads"): devos_denetim on any work item.
    if v_class <> 'devos_denetim' then
      v_check := 'rule_o';
      select mr.mission_id into v_mission from devos_private.mission_revision mr where mr.id = v_cur_mrev;
      if v_mission is null then
        v_code := 'could_not_check'; v_reason := 'rule_o: the work item''s Mission is missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_class = 'devos_sinav' then
        perform 1 from devos_private.eval_run e where e.work_ref = reopen_for_review.work_id;
        if not found then
          v_code := 'not_owner';
          v_reason := 'Rule O: devos_sinav changes only the work items its exam link names';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      else
        v_inst := devos_private.is_installation_mission(v_mission);
        if v_inst is null then
          v_code := 'could_not_check';
          v_reason := 'rule_o: whether the work item lies under the installation''s Mission is missing or partial';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_class = 'devos_kurulum' and not v_inst then
          v_code := 'not_owner';
          v_reason := 'Rule O: devos_kurulum changes only the work items under the installation''s Mission';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_class = 'devos_calisma' and v_inst then
          v_code := 'not_owner';
          v_reason := 'Rule O: devos_calisma does not change the work items under the installation''s Mission';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
    end if;

    v_check := 'repeat';
    if v_qual = 'needs_review' then
      v_answer := jsonb_build_object('status', 'ok', 'id', work_id, 'repeat', true);
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, work_id);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    update devos_private.work w set qualification = 'needs_review' where w.id = reopen_for_review.work_id;
    perform devos_private.write_event('work', work_id, v_cur_rev, 'work_reopened_for_review',
      jsonb_strip_nulls(jsonb_build_object('qualification', 'needs_review', 'previous_qualification', v_qual::text,
                                           'reason', reason)),
      v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, work_id);
  end if;
  return jsonb_build_object('status', 'ok', 'id', work_id);
end
$fn$;

-- set_effort_policy (EV-C02-013 2.3 and section 17 (C-M04); EV-C02-008 1.7.4; B 3.18; plan 6.10 (P:763)). One function,
-- three kinds of write, told apart by the payload:
-- - an item's policy (work_ref, the work item's uuid; level, expert_assessment_ref, non_removable_steps required;
--   standing_policy_ref, reduction_reason). Its floor is level high, or the level of the active standing policy it
--   cites. At or above the floor it is kind (a), written by the classes Rule O gives the item (devos_calisma, devos_sinav
--   on its exam tasks, devos_kurulum on the installation's); devos_denetim is refused not_owner. Below the floor it is a
--   reduction, kind (b): devos_denetim only, else not_owner, with a reduction_reason (P:763: "A reduction is made with a
--   reason and with the approval of the audit environment"), else missing_field; approved_by_role_class devos_denetim.
--   Writing an item's policy retires the item's earlier active one (event effort_policy_retired, origin rule). The same
--   content as the item's active policy: the exact repeat.
-- - a standing policy, kind (c) (work_class; level, expert_assessment_ref, non_removable_steps required;
--   reduction_reason): devos_denetim only, else not_owner; approved_by_role_class devos_denetim.
-- - retire_id, kind (c): a standing policy retired, devos_denetim only, else not_owner; an id that names no policy:
--   not_found; an item's policy: invalid_field; already retired: the exact repeat.
-- level is high, medium or low, in that order (chosen; section 17 (2)). A standing_policy_ref that names no policy:
-- could_not_check; one that names an item's policy or a retired one: invalid_field (B 3.18: "an item cannot cite a
-- retired policy"). The work item's own revision is not changed. The format gate (an empty expert assessment, a
-- removed step) and N03's steps are W-C02-10's. devos_calisma, devos_denetim, devos_sinav, devos_kurulum at the gate.
create function devos_api.set_effort_policy(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'set_effort_policy';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_kind text;
  v_answer jsonb;
  v_target uuid;
  v_work uuid;
  v_cur_rev integer;
  v_cur_mrev uuid;
  v_mission uuid;
  v_inst boolean;
  v_level text;
  v_rank integer;
  v_floor integer := 3;
  v_steps jsonb;
  v_standing uuid;
  v_s_work uuid;
  v_s_level text;
  v_s_status devos_private.effort_policy_status;
  v_r_work uuid;
  v_r_status devos_private.effort_policy_status;
  v_reduction boolean := false;
  v_approved devos_private.role_class;
  v_id uuid;
  v_old uuid;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;
  if jsonb_typeof(p -> 'declared_session_id') = 'string' then
    v_decl := p ->> 'declared_session_id';
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'set_effort_policy admits only the role classes devos_calisma, devos_denetim, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    v_check := 'input';
    if p is null then
      v_code := 'missing_field'; v_reason := 'p: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p) <> 'object' then
      v_code := 'invalid_field'; v_reason := 'p: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    foreach v_key in array array['retire_id', 'work_ref', 'work_class', 'level', 'expert_assessment_ref',
                                 'reduction_reason', 'standing_policy_ref'] loop
      if coalesce(jsonb_typeof(p -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if jsonb_typeof(p -> 'retire_id') = 'string' then
      v_kind := 'retire';
      if (p ->> 'retire_id') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
        v_code := 'invalid_field'; v_reason := 'retire_id: not a uuid';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_target := (p ->> 'retire_id')::uuid;
    elsif jsonb_typeof(p -> 'work_ref') = 'string' then
      v_kind := 'item';
      if jsonb_typeof(p -> 'work_class') = 'string' then
        v_code := 'invalid_field'; v_reason := 'work_ref and work_class: a policy is a work item''s or a standing one, not both';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if (p ->> 'work_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
        v_code := 'invalid_field'; v_reason := 'work_ref: not a uuid';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_work := (p ->> 'work_ref')::uuid;
      if jsonb_typeof(p -> 'standing_policy_ref') = 'string' then
        if (p ->> 'standing_policy_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
          v_code := 'invalid_field'; v_reason := 'standing_policy_ref: not a uuid';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        v_standing := (p ->> 'standing_policy_ref')::uuid;
      end if;
    elsif jsonb_typeof(p -> 'work_class') = 'string' then
      v_kind := 'standing';
      if jsonb_typeof(p -> 'standing_policy_ref') = 'string' then
        v_code := 'invalid_field'; v_reason := 'standing_policy_ref: a standing policy cites none';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    else
      v_code := 'missing_field'; v_reason := 'work_ref, work_class or retire_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_kind <> 'retire' then
      foreach v_key in array array['level', 'expert_assessment_ref', 'non_removable_steps'] loop
        if coalesce(jsonb_typeof(p -> v_key), 'null') = 'null' then
          v_code := 'missing_field'; v_reason := v_key || ': missing';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end loop;
      v_level := p ->> 'level';
      v_rank := case v_level when 'high' then 3 when 'medium' then 2 when 'low' then 1 end;
      if v_rank is null then
        v_code := 'invalid_field'; v_reason := 'level: not high, medium or low';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p -> 'non_removable_steps') <> 'array' then
        v_code := 'invalid_field'; v_reason := 'non_removable_steps: not an array';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_steps := p -> 'non_removable_steps';
    end if;

    if v_kind = 'retire' then
      -- (d) The approval (B 3.18: "A standing policy is written and retired only with devos_denetim").
      v_check := 'approval';
      if v_class <> 'devos_denetim' then
        v_code := 'not_owner'; v_reason := 'a standing policy is retired only with devos_denetim (B 3.18)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_check := 'retire_id';
      select ep.work_ref, ep.status into v_r_work, v_r_status
        from devos_private.effort_policy ep where ep.id = v_target for update;
      if not found then
        v_code := 'not_found'; v_reason := 'retire_id: names no EffortPolicy';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_r_work is not null then
        v_code := 'invalid_field';
        v_reason := 'retire_id: names a work item''s policy, which its next policy retires (EV-C02-013 2.3)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_r_status is null then
        v_code := 'could_not_check'; v_reason := 'retire_id: its status is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_r_status = 'retired' then
        v_answer := jsonb_build_object('status', 'ok', 'id', v_target, 'repeat', true);
      end if;
    elsif v_kind = 'standing' then
      v_check := 'approval';
      if v_class <> 'devos_denetim' then
        v_code := 'not_owner'; v_reason := 'a standing policy is written only with devos_denetim (B 3.18)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_approved := 'devos_denetim';
    else
      -- (f) The work item, and the standing policy it cites.
      v_check := 'work_ref';
      perform 1 from devos_private.work w where w.id = v_work for update;
      if not found then
        v_code := 'could_not_check'; v_reason := 'work_ref: the record could not be read';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      select r.revision, r.mission_revision_id into v_cur_rev, v_cur_mrev
        from devos_private.work_revision r where r.work_id = v_work order by r.revision desc limit 1;
      if not found or v_cur_rev is null then
        v_code := 'could_not_check'; v_reason := 'work_ref: its current revision is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_standing is not null then
        v_check := 'standing_policy_ref';
        select ep.work_ref, ep.level, ep.status into v_s_work, v_s_level, v_s_status
          from devos_private.effort_policy ep where ep.id = v_standing for share;
        if not found then
          v_code := 'could_not_check'; v_reason := 'standing_policy_ref: the record could not be read';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_s_work is not null then
          v_code := 'invalid_field'; v_reason := 'standing_policy_ref: names a work item''s policy, not a standing one';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        v_floor := case v_s_level when 'high' then 3 when 'medium' then 2 when 'low' then 1 end;
        if v_floor is null or v_s_status is null then
          v_code := 'could_not_check'; v_reason := 'standing_policy_ref: its level or status could not be read (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_s_status = 'retired' then
          v_code := 'invalid_field'; v_reason := 'standing_policy_ref: names a retired policy (B 3.18)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
      v_reduction := v_rank < v_floor;

      -- (d) The approval (B 3.18; EV-C02-008 1.7.4), then Rule O for kind (a).
      v_check := 'approval';
      if v_reduction then
        if v_class <> 'devos_denetim' then
          v_code := 'not_owner';
          v_reason := 'a reduction needs the audit environment''s approval: only devos_denetim makes it (B 3.18)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if coalesce(jsonb_typeof(p -> 'reduction_reason'), 'null') <> 'string' then
          v_code := 'missing_field'; v_reason := 'reduction_reason: missing (a reduction is made with a reason, P:763)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        v_approved := 'devos_denetim';
      else
        if v_class = 'devos_denetim' then
          v_code := 'not_owner';
          v_reason := 'devos_denetim approves reductions and standing policies; a work item''s policy within its floor '
                      || 'is written by the classes Rule O gives the item (EV-C02-008 1.7.4)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        v_check := 'rule_o';
        select mr.mission_id into v_mission from devos_private.mission_revision mr where mr.id = v_cur_mrev;
        if v_mission is null then
          v_code := 'could_not_check'; v_reason := 'rule_o: the work item''s Mission is missing';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_class = 'devos_sinav' then
          perform 1 from devos_private.eval_run e where e.work_ref = v_work;
          if not found then
            v_code := 'not_owner';
            v_reason := 'Rule O: devos_sinav changes only the work items its exam link names';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        else
          v_inst := devos_private.is_installation_mission(v_mission);
          if v_inst is null then
            v_code := 'could_not_check';
            v_reason := 'rule_o: whether the work item lies under the installation''s Mission is missing or partial';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if v_class = 'devos_kurulum' and not v_inst then
            v_code := 'not_owner';
            v_reason := 'Rule O: devos_kurulum changes only the work items under the installation''s Mission';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if v_class = 'devos_calisma' and v_inst then
            v_code := 'not_owner';
            v_reason := 'Rule O: devos_calisma does not change the work items under the installation''s Mission';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
        end if;
      end if;

      -- The exact repeat: the same content as the item's active policy.
      v_check := 'repeat';
      select ep.id into v_old from devos_private.effort_policy ep
       where ep.work_ref = v_work and ep.status = 'active' and ep.level = v_level
         and ep.expert_assessment_ref = p ->> 'expert_assessment_ref' and ep.non_removable_steps = v_steps
         and ep.standing_policy_ref is not distinct from v_standing
         and ep.reduction_reason is not distinct from (p ->> 'reduction_reason')
         and ep.approved_by_role_class is not distinct from v_approved
       order by ep.created_at desc limit 1;
      if v_old is not null then
        v_answer := jsonb_build_object('status', 'ok', 'id', v_old, 'repeat', true);
      end if;
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_target);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    if v_kind = 'retire' then
      update devos_private.effort_policy ep set status = 'retired' where ep.id = v_target;
      perform devos_private.write_event('effort_policy', v_target, null, 'effort_policy_retired',
        jsonb_build_object('status', 'retired', 'previous_status', 'active'), v_class::text, 'call', v_decl);
      v_id := v_target;
    else
      if v_kind = 'item' then
        for v_old in update devos_private.effort_policy ep set status = 'retired'
                      where ep.work_ref = v_work and ep.status = 'active' returning ep.id loop
          perform devos_private.write_event('effort_policy', v_old, null, 'effort_policy_retired',
            jsonb_build_object('status', 'retired', 'previous_status', 'active', 'work_ref', v_work,
                               'why', 'a new policy for the work item was written'),
            v_class::text, 'rule', v_decl);
        end loop;
      end if;
      insert into devos_private.effort_policy (work_ref, work_class, standing_policy_ref, level, expert_assessment_ref,
                                               reduction_reason, approved_by_role_class, non_removable_steps, status)
      values (v_work, case when v_kind = 'standing' then p ->> 'work_class' end, v_standing, v_level,
              p ->> 'expert_assessment_ref', p ->> 'reduction_reason', v_approved, v_steps, 'active')
      returning id into v_id;
      perform devos_private.write_event('effort_policy', v_id, null, 'effort_policy_set',
        jsonb_strip_nulls(jsonb_build_object('kind', case when v_kind = 'standing' then 'standing'
                                                          when v_reduction then 'reduction' else 'item' end,
          'work_ref', v_work, 'work_class', case when v_kind = 'standing' then p ->> 'work_class' end,
          'standing_policy_ref', v_standing, 'level', v_level, 'expert_assessment_ref', p ->> 'expert_assessment_ref',
          'reduction_reason', p ->> 'reduction_reason', 'approved_by_role_class', v_approved::text,
          'non_removable_steps', v_steps, 'status', 'active')),
        v_class::text, 'call', v_decl);
    end if;
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_target);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id);
end
$fn$;

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)). PUBLIC's default EXECUTE is revoked from
-- every function this file creates, and so is any privilege of the four API roles; each is then granted to anon, the
-- role a Data API request with the publishable key runs as. Each checks the token itself. This file adds no type and no
-- devos_private function.
revoke all on function devos_api.admit_work(jsonb) from public;
revoke all on function devos_api.revise_work(jsonb) from public;
revoke all on function devos_api.mark_stale(uuid, text) from public;
revoke all on function devos_api.cancel_work(uuid, text) from public;
revoke all on function devos_api.reopen_for_review(uuid, text) from public;
revoke all on function devos_api.set_effort_policy(jsonb) from public;
do $$
declare r text; f text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      foreach f in array array['devos_api.admit_work(jsonb)', 'devos_api.revise_work(jsonb)',
                               'devos_api.mark_stale(uuid, text)', 'devos_api.cancel_work(uuid, text)',
                               'devos_api.reopen_for_review(uuid, text)', 'devos_api.set_effort_policy(jsonb)'] loop
        execute format('revoke all on function %s from %I', f, r);
      end loop;
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.admit_work(jsonb) to anon;
    grant execute on function devos_api.revise_work(jsonb) to anon;
    grant execute on function devos_api.mark_stale(uuid, text) to anon;
    grant execute on function devos_api.cancel_work(uuid, text) to anon;
    grant execute on function devos_api.reopen_for_review(uuid, text) to anon;
    grant execute on function devos_api.set_effort_policy(jsonb) to anon;
  end if;
end
$$;
