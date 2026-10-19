-- DevOS schema (W-C02-09), not a fixture. M09-06: Relation.
-- Sources: plan/work/W-C02-09.md points 1, 2, 3, 5, 6 and 7; Appendix B principles 2, 3, 6 and 8, 3.4, 3.13, 3.15,
-- section 4 (row "Relation") and section 7 ("Privacy"); evidence/C02/EV-C02-013_w09_interface.md sections 1 (items 1
-- to 14), 2.5 with R1-2, R1-3 and R2-5, 4 (the row on Rule O for relations), 6, 10 and 19 (C-M06); EV-C02-008 1.2, 1.7.1
-- (Rules O and C), 5.1 (the exam fact) and 5.2 (d); EV-C02-002 DM-01, DM-19, DM-31, DM-35, DM-36. Record:
-- evidence/C02/EV-C02-014_w09_build.md section 7.
-- It holds exactly section 10's row M09-06, the four functions of EV-C02-013 section 2.5: devos_api.relate,
-- retract_relation, affected_entities and explain_paths. It adds no table, type or private function, and changes
-- nothing of M09-01 to M09-05, whose helpers it calls: caller_role_class, write_event, reject, hard_dependency_cycle
-- and is_installation_mission. No token, hash or key value is written here.
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12).
--
-- The common form is M09-03's to M09-05's (EV-C02-013 section 1 items 6, 7, 9 and 10, R1-1): (a) the derivation,
-- before any other check; then a read block holding (b) the role list, a literal of the function's own text (B:48),
-- (c) the input's form, (d) ownership (Rule O, then Rule C) and (f) the family's rules, writing nothing (its row locks
-- and the advisory lock stay with the transaction); then, for relate and retract_relation, a write block holding (g)
-- the writes and their events through devos_private.write_event, with the caller's role class. A check that decides a
-- refusal sets v_code and v_reason and raises P0D01; any other error in the read block is could_not_check,
-- "<v_check>: its input could not be read (SQLSTATE <code>)"; any error in the write block is write_failed, but P0D02,
-- which is could_not_check with its fixed reason. After either block's refusal one per-call RejectedAttempt row is
-- written by devos_private.reject. A reason holds fixed text and an SQLSTATE only. Keys a function does not read are
-- ignored (item 4). Parameters keep the names of EV-C02-013 2.5 and README 8.1 (named calls), and the bodies read them
-- through ALIAS FOR $n, never qualified by the function's name, so that a merged break patch that renames a function
-- and wraps it leaves the renamed body working (N-288; EV-C02-014 6.1).
--
-- Relation ends (EV-C02-013 2.5 with R1-2, R1-3; EV-C02-008 5.1 (b)). An end names a record of one of the families
-- looked up here: Work, Mission, Decision, Finding and Artifact (with revisions), Need, Relation, EffortPolicy,
-- Assignment, Review, Verdict, Acceptance, Operation and Observation (without). An end that names no record of these,
-- a revisioned record's end sent without its revision, a revision it does not have, or a revision sent for a record
-- without revisions, is could_not_check with the same reason text whichever it is. An exam record (EvalRun) is read
-- only when the caller's class is devos_sinav (EV-C02-008 5.1 (c) bound 1): for devos_sinav it is refused exam_record;
-- for every other class it is a record this function cannot find, so its answer and reason code are those of an id
-- that names no record. The two walks and their root and target checks follow the same rule: an exam record is hidden
-- from every class but devos_sinav, exactly as a record that does not exist. Open samples and their Verdicts are
-- W-C02-10's to withhold (EV-C02-008 5.2 (d)); nothing here can tell an open block.
--
-- Rule O (EV-C02-008 1.7.1), as EV-C02-013 2.3 says it reads: the work item's current revision in work_revision (its
-- mission_revision_id), the mission_revision row that names (its mission_id), and, through is_installation_mission,
-- that Mission's events; for devos_sinav, the exam link; never devos_private.mission. devos_kurulum: only a work item
-- under the installation's Mission; devos_calisma: only one not under it (an exam task is changed as any other item);
-- devos_sinav: only one its exam link names. A Mission whose creation event cannot be read is could_not_check, never
-- "not transferred" (item 7 (ii)). retract_relation also reads the relation's own creation event: a relation whose
-- creation event is transferred is retracted only with devos_kurulum (EV-C02-013 19 (2), C-M06), beside the work-item
-- clauses when its from_ref is a work item. Rule C, for a hard relation from a work item: refused other_class_claim
-- while an active claim whose lease has not run out (DM-06) is held by another role class; a claim without its status,
-- lease or role class is could_not_check. The reasons name the rule, never the item's opener or the claimant's class.
--
-- The walks (EV-C02-013 2.5; B section 4: "the result carries completeness information"; EV-C02-008 5.1 (b): they
-- follow Relation rows only). An edge is a relation that is not retracted: its to_ref is the record changed and its
-- from_ref the record affected (T-W07-F04's reading of derived_from, taken for every type; C-M06). A relation whose
-- validity is NULL is partial input: not walked, and the result is not complete. complete is true only when no limit
-- was reached and no record was hidden or missing on the way.

-- relate (EV-C02-013 2.5 with R1-2, R1-3, R2-5 and C-M06; B 3.4; W-C02-09 point 6; DM-01): one Relation and
-- relation_created. Payload: type, from_ref, to_ref, scope, method and epistemic_status required; from_revision,
-- to_revision, hard (default false), group_id with group_mode, use. Order after the gate: the form (relation_rule for
-- model_extracted with observation, B 3.4, PC-16, decided by the input alone); for a hard depends_on, the cycle check
-- through devos_private.hard_dependency_cycle, which first takes DM-01's one advisory lock, before any row lock; the
-- from end (its row locked for update), then the to end (not locked); Rule O when from_ref is a work item; Rule C when
-- the relation is hard and from_ref is a work item; the group (a group_id held by a current relation from another
-- from_ref or with the other mode: invalid_field, B principle 6); the exact repeat (the same current relation: type,
-- ends, revisions, hard, group and use; EV-C02-013 2.5's key), ok with "repeat": true; the cycle's answer (true:
-- cycle; NULL: could_not_check). group_mode without group_id makes the relation a group of its own (group_id its own
-- id, R2-5). devos_calisma, devos_sinav, devos_kurulum (EV-C02-008 1.2). Answer {"status": "ok", "id"}.
create function devos_api.relate(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'relate';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_answer jsonb;
  v_key text;
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
  v_dep boolean := false;
  v_cycle boolean;
  v_end text;
  v_ref uuid;
  v_rev integer;
  v_fam text;
  v_from_fam text;
  v_ok boolean;
  v_mrev uuid;
  v_mission uuid;
  v_inst boolean;
  v_partial bigint;
  v_other bigint;
  v_n bigint;
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
    if not (v_class = any (array['devos_calisma', 'devos_sinav', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'relate admits only the role classes devos_calisma, devos_sinav and devos_kurulum';
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
    foreach v_key in array array['type', 'from_ref', 'to_ref', 'scope', 'method', 'epistemic_status'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
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
    if (p_in ->> 'scope') !~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$' then
      v_code := 'invalid_field'; v_reason := 'scope: not a dotted path of lower-case labels';
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
    -- Relation's rule (B 3.4, PC-16 place 13; W-C02-09 point 6); the table's check is the backstop.
    if v_method = 'model_extracted' and v_estatus = 'observation' then
      v_code := 'relation_rule';
      v_reason := 'B 3.4: a relation with method model_extracted cannot have epistemic_status observation';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- DM-01: a hard dependency's write first takes the one advisory lock (in the helper), then checks for a cycle,
    -- before any row lock. The answer is used after the ends and the rules below.
    v_dep := v_type = 'depends_on' and v_hard;
    if v_dep then
      v_check := 'cycle';
      v_cycle := devos_private.hard_dependency_cycle(v_from, v_to);
    end if;

    -- (f) The two ends (R1-2, R1-3): each names a record with the revision it needs.
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
      if v_fam is null and v_class = 'devos_sinav' then
        -- Only devos_sinav's call reads the exam records (EV-C02-008 5.1 (c) bound 1); B 3.15: no relation names one.
        perform 1 from devos_private.eval_run x where x.id = v_ref;
        if found then
          v_code := 'exam_record';
          v_reason := v_end || ': names an exam record, which no relation may name (B 3.15; EV-C02-008 5.1 (b))';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
      if v_fam is null then
        v_code := 'could_not_check'; v_reason := v_end || ': the record could not be read';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_ok := case
        when v_fam not in ('work', 'mission', 'decision', 'finding', 'artifact') then v_rev is null
        when v_rev is null then false
        when v_fam = 'work' then
          exists (select 1 from devos_private.work_revision x where x.work_id = v_ref and x.revision = v_rev)
        when v_fam = 'mission' then
          exists (select 1 from devos_private.mission_revision x where x.mission_id = v_ref and x.revision = v_rev)
        when v_fam = 'decision' then
          exists (select 1 from devos_private.decision_revision x where x.decision_id = v_ref and x.revision = v_rev)
        when v_fam = 'finding' then
          exists (select 1 from devos_private.finding_revision x where x.finding_id = v_ref and x.revision = v_rev)
        else
          exists (select 1 from devos_private.artifact_revision x where x.artifact_id = v_ref and x.revision = v_rev)
      end;
      if not coalesce(v_ok, false) then
        v_code := 'could_not_check'; v_reason := v_end || ': the record could not be read';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_end = 'from_ref' then
        v_from_fam := v_fam;
        -- The row of from_ref's record, locked for update: an exact repeat and Rule C are then decided once per from_ref
        -- (claim also locks a work item for update, EV-C02-014 5.2 item 6). The to end is not locked (no deadlock
        -- between A -> B and B -> A).
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

    if v_from_fam = 'work' then
      -- (d) Rule O (EV-C02-008 1.7.1; EV-C02-013 2.3, "What Rule O reads").
      v_check := 'rule_o';
      select r.mission_revision_id into v_mrev
        from devos_private.work_revision r where r.work_id = v_from order by r.revision desc limit 1;
      if v_mrev is null then
        v_code := 'could_not_check'; v_reason := 'rule_o: the work item''s current revision is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      select mr.mission_id into v_mission from devos_private.mission_revision mr where mr.id = v_mrev;
      if v_mission is null then
        v_code := 'could_not_check'; v_reason := 'rule_o: the work item''s Mission is missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_class = 'devos_sinav' then
        perform 1 from devos_private.eval_run e where e.work_ref = v_from;
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

      -- (d) Rule C, for a hard relation (EV-C02-008 1.7.1): no active claim of another class whose lease runs (DM-06).
      if v_hard then
        v_check := 'rule_c';
        select count(*) filter (where a.status is null
                                  or (a.status = 'active' and (a.lease_expires_at is null or a.role_class is null))),
               count(*) filter (where a.status = 'active' and a.lease_expires_at > now() and a.role_class <> v_class)
          into v_partial, v_other
          from devos_private.assignment a where a.work_ref = v_from;
        if v_partial > 0 then
          v_code := 'could_not_check';
          v_reason := 'rule_c: a claim on the work item lacks its status, lease or role class (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_other > 0 then
          v_code := 'other_class_claim'; v_reason := 'Rule C: another role class holds an active claim on the work item';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
    end if;

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

    -- The exact repeat (B 3.4: no new record and no new event), after the ownership rules (EV-C02-014 5.2 item 7).
    v_check := 'repeat';
    select r.id into v_id
      from devos_private.relation r
     where r.from_ref = v_from and r.to_ref = v_to and r.type = v_type and r.validity = 'current'
       and r.from_revision is not distinct from v_from_rev and r.to_revision is not distinct from v_to_rev
       and r.hard = v_hard and r.use is not distinct from v_use
       and ((v_gid is not null and r.group_id = v_gid and r.group_mode = v_gmode)
            or (v_gid is null and v_gmode is not null and r.group_id = r.id and r.group_mode = v_gmode)
            or (v_gid is null and v_gmode is null and r.group_id is null))
     order by r.created_at, r.id
     limit 1;
    if v_id is not null then
      v_answer := jsonb_build_object('status', 'ok', 'id', v_id, 'repeat', true);
    end if;

    -- (f) The cycle (B 3.4: "In hard dependencies a cycle is rejected"), read above under the lock.
    if v_answer is null and v_dep then
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
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    if v_gid is null and v_gmode is not null then
      v_gid := v_id;
    end if;
    insert into devos_private.relation (id, type, from_ref, from_revision, to_ref, to_revision, scope, hard, group_id,
                                        group_mode, use, method, epistemic_status)
    values (v_id, v_type, v_from, v_from_rev, v_to, v_to_rev, v_scope, v_hard, v_gid, v_gmode, v_use, v_method,
            v_estatus);
    perform devos_private.write_event('relation', v_id, null, 'relation_created',
      jsonb_strip_nulls(jsonb_build_object('type', v_type::text, 'from_ref', v_from, 'from_revision', v_from_rev,
                                           'to_ref', v_to, 'to_revision', v_to_rev, 'scope', v_scope, 'hard', v_hard,
                                           'group_id', v_gid, 'group_mode', v_gmode::text, 'use', v_use,
                                           'method', v_method::text, 'epistemic_status', v_estatus::text,
                                           'validity', 'current')),
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
  return jsonb_build_object('status', 'ok', 'id', v_id);
end
$fn$;

-- retract_relation (EV-C02-013 2.5 and C-M06; B 3.4; EV-C02-008 1.7.1): the relation's validity set retracted, with
-- its reason in the event relation_retracted. Order after the gate: relation_id NULL: missing_field; the relation
-- (not_found; its from_ref, hard or validity NULL: could_not_check); its from_ref's work item, if it is one, locked for
-- update, then the relation for update (DM-01's order: the work item first); Rule O: the relation's creation event (its
-- first event; missing, or its type NULL: could_not_check), transferred only with devos_kurulum, and the work-item
-- clauses when from_ref is a work item; Rule C when the relation is hard and from_ref is a work item; already
-- retracted: the exact repeat. State, not a revision (Relation has none), so reason may be NULL, as mark_stale's
-- (EV-C02-013 17 (1)). devos_calisma, devos_sinav, devos_kurulum. Refusal rows carry target_ref relation_id. Answer
-- {"status": "ok", "id"}.
create function devos_api.retract_relation(relation_id uuid, reason text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_relation alias for $1;
  p_reason alias for $2;
  v_fn constant text := 'retract_relation';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_answer jsonb;
  v_from uuid;
  v_hard boolean;
  v_validity devos_private.relation_validity;
  v_from_work boolean;
  v_etype text;
  v_mrev uuid;
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
      v_reason := 'retract_relation admits only the role classes devos_calisma, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if p_relation is null then
      v_code := 'missing_field'; v_reason := 'relation_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The relation, its work item locked first, then the relation (DM-01's order).
    v_check := 'relation';
    select r.from_ref into v_from from devos_private.relation r where r.id = p_relation;
    if not found then
      v_code := 'not_found'; v_reason := 'relation_id: names no Relation';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_from is null then
      v_code := 'could_not_check'; v_reason := 'relation: its from_ref is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'work';
    perform 1 from devos_private.work w where w.id = v_from for update;
    v_from_work := found;
    v_check := 'relation';
    select r.hard, r.validity into v_hard, v_validity from devos_private.relation r where r.id = p_relation for update;
    if v_hard is null or v_validity is null then
      v_code := 'could_not_check'; v_reason := 'relation: its hard or validity is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (d) Rule O: the relation's creation event (EV-C02-008 1.7.1, "a relation whose creation event is transferred").
    v_check := 'rule_o';
    select e.event_type into v_etype
      from devos_private.event e
     where e.aggregate_type = 'relation' and e.aggregate_id = p_relation
     order by e.id
     limit 1;
    if not found then
      v_code := 'could_not_check'; v_reason := 'rule_o: the relation''s creation event is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_etype is null then
      v_code := 'could_not_check'; v_reason := 'rule_o: the relation''s creation event lacks its type (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_etype = 'transferred' and v_class <> 'devos_kurulum' then
      v_code := 'not_owner'; v_reason := 'Rule O: a transferred relation is retracted only with devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_from_work then
      -- (d) Rule O on the work item (EV-C02-013 2.3, "What Rule O reads").
      select r.mission_revision_id into v_mrev
        from devos_private.work_revision r where r.work_id = v_from order by r.revision desc limit 1;
      if v_mrev is null then
        v_code := 'could_not_check'; v_reason := 'rule_o: the work item''s current revision is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      select mr.mission_id into v_mission from devos_private.mission_revision mr where mr.id = v_mrev;
      if v_mission is null then
        v_code := 'could_not_check'; v_reason := 'rule_o: the work item''s Mission is missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_class = 'devos_sinav' then
        perform 1 from devos_private.eval_run e where e.work_ref = v_from;
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

      -- (d) Rule C, for a hard relation (EV-C02-008 1.7.1).
      if v_hard then
        v_check := 'rule_c';
        select count(*) filter (where a.status is null
                                  or (a.status = 'active' and (a.lease_expires_at is null or a.role_class is null))),
               count(*) filter (where a.status = 'active' and a.lease_expires_at > now() and a.role_class <> v_class)
          into v_partial, v_other
          from devos_private.assignment a where a.work_ref = v_from;
        if v_partial > 0 then
          v_code := 'could_not_check';
          v_reason := 'rule_c: a claim on the work item lacks its status, lease or role class (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_other > 0 then
          v_code := 'other_class_claim'; v_reason := 'Rule C: another role class holds an active claim on the work item';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
    end if;

    v_check := 'repeat';
    if v_validity = 'retracted' then
      v_answer := jsonb_build_object('status', 'ok', 'id', p_relation, 'repeat', true);
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_relation);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    update devos_private.relation r set validity = 'retracted' where r.id = p_relation;
    perform devos_private.write_event('relation', p_relation, null, 'relation_retracted',
      jsonb_strip_nulls(jsonb_build_object('validity', 'retracted', 'previous_validity', v_validity::text,
                                           'reason', p_reason)),
      v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_relation);
  end if;
  return jsonb_build_object('status', 'ok', 'id', p_relation);
end
$fn$;

-- affected_entities (EV-C02-013 2.5 and C-M06; B section 4, row "Relation"; Appendix C F04; DM-35 as EV-C02-008 5.1
-- narrows it): the records a change of root affects, each once, with one explanatory path each, walked breadth first
-- along the edges above. limits: max_depth (default 5) and max_records (default 500), each a JSON integer of at least 1.
-- The root must name a record the caller may see, else could_not_check (F04-m1, -m3). A record met on the way that the
-- caller may not see (an exam record for a class but devos_sinav), or that names no record, is neither listed nor walked
-- through, and makes the result not complete; so is a relation whose validity is NULL, a depth beyond which an
-- unwalked edge remains, and a record limit reached. The root itself is not listed. A read: it changes no table but
-- rejected_attempt, its comment begins devos:read, VOLATILE (DM-36). devos_calisma, devos_denetim, devos_sinav,
-- devos_kurulum (EV-C02-008 1.2). Answer {"status": "ok", "records": [{"ref", "path": [root, ..., ref]}], "complete"}.
create function devos_api.affected_entities(root uuid, limits jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_root alias for $1;
  p_limits alias for $2;
  v_fn constant text := 'affected_entities';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_max_depth integer := 5;
  v_max_records integer := 500;
  v_fam text;
  v_seen uuid[];
  v_frontier uuid[];
  v_next uuid[];
  v_cand uuid[];
  v_vis uuid[];
  v_paths jsonb;
  v_records jsonb := '[]'::jsonb;
  v_count integer := 0;
  v_depth integer := 0;
  v_complete boolean := true;
  v_stop boolean := false;
  v_e record;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;

  -- The read block (a read has no write block).
  begin
    if not (v_class = any (array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'affected_entities admits only the role classes devos_calisma, devos_denetim, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if p_root is null then
      v_code := 'missing_field'; v_reason := 'root: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_limits), 'null') <> 'null' then
      if jsonb_typeof(p_limits) <> 'object' then
        v_code := 'invalid_field'; v_reason := 'limits: not a JSON object';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      foreach v_key in array array['max_depth', 'max_records'] loop
        if coalesce(jsonb_typeof(p_limits -> v_key), 'null') <> 'null' then
          if jsonb_typeof(p_limits -> v_key) <> 'number' or (p_limits ->> v_key) !~ '^[1-9][0-9]{0,8}$' then
            v_code := 'invalid_field'; v_reason := v_key || ': not an integer of at least 1';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if v_key = 'max_depth' then
            v_max_depth := (p_limits ->> v_key)::integer;
          else
            v_max_records := (p_limits ->> v_key)::integer;
          end if;
        end if;
      end loop;
    end if;

    -- The root: a record the caller may see (EV-C02-008 5.1 (b): an exam record is answered as no record).
    v_check := 'root';
    select f.fam into v_fam
      from (select 'work'::text as fam from devos_private.work x where x.id = p_root
            union all select 'mission' from devos_private.mission x where x.id = p_root
            union all select 'decision' from devos_private.decision x where x.id = p_root
            union all select 'finding' from devos_private.finding x where x.id = p_root
            union all select 'artifact' from devos_private.artifact x where x.id = p_root
            union all select 'need' from devos_private.need x where x.id = p_root
            union all select 'relation' from devos_private.relation x where x.id = p_root
            union all select 'effort_policy' from devos_private.effort_policy x where x.id = p_root
            union all select 'assignment' from devos_private.assignment x where x.id = p_root
            union all select 'review' from devos_private.review x where x.id = p_root
            union all select 'verdict' from devos_private.verdict x where x.id = p_root
            union all select 'acceptance' from devos_private.acceptance x where x.id = p_root
            union all select 'operation' from devos_private.operation x where x.id = p_root
            union all select 'observation' from devos_private.observation x where x.id = p_root) f
     limit 1;
    if v_fam is null and v_class = 'devos_sinav' then
      perform 1 from devos_private.eval_run x where x.id = p_root;
      if found then
        v_fam := 'eval_run';
      end if;
    end if;
    if v_fam is null then
      v_code := 'could_not_check'; v_reason := 'root: the record could not be read';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The walk, breadth first: each record once, with the first path that reaches it.
    v_check := 'walk';
    v_seen := array[p_root];
    v_frontier := array[p_root];
    v_paths := jsonb_build_object(p_root::text, jsonb_build_array(p_root::text));
    while cardinality(v_frontier) > 0 and not v_stop loop
      if exists (select 1 from devos_private.relation r where r.to_ref = any (v_frontier) and r.validity is null) then
        v_complete := false;
      end if;
      if v_depth >= v_max_depth then
        if exists (select 1 from devos_private.relation r
                    where r.to_ref = any (v_frontier) and r.validity <> 'retracted' and not (r.from_ref = any (v_seen))) then
          v_complete := false;
        end if;
        exit;
      end if;
      v_depth := v_depth + 1;
      select coalesce(array_agg(distinct r.from_ref), '{}'::uuid[]) into v_cand
        from devos_private.relation r
       where r.to_ref = any (v_frontier) and r.validity <> 'retracted' and not (r.from_ref = any (v_seen));
      exit when cardinality(v_cand) = 0;
      select coalesce(array_agg(f.id), '{}'::uuid[]) into v_vis
        from (select x.id from devos_private.work x where x.id = any (v_cand)
              union all select x.id from devos_private.mission x where x.id = any (v_cand)
              union all select x.id from devos_private.decision x where x.id = any (v_cand)
              union all select x.id from devos_private.finding x where x.id = any (v_cand)
              union all select x.id from devos_private.artifact x where x.id = any (v_cand)
              union all select x.id from devos_private.need x where x.id = any (v_cand)
              union all select x.id from devos_private.relation x where x.id = any (v_cand)
              union all select x.id from devos_private.effort_policy x where x.id = any (v_cand)
              union all select x.id from devos_private.assignment x where x.id = any (v_cand)
              union all select x.id from devos_private.review x where x.id = any (v_cand)
              union all select x.id from devos_private.verdict x where x.id = any (v_cand)
              union all select x.id from devos_private.acceptance x where x.id = any (v_cand)
              union all select x.id from devos_private.operation x where x.id = any (v_cand)
              union all select x.id from devos_private.observation x where x.id = any (v_cand)) f;
      if v_class = 'devos_sinav' then
        select v_vis || coalesce(array_agg(x.id), '{}'::uuid[]) into v_vis
          from devos_private.eval_run x where x.id = any (v_cand);
      end if;
      if cardinality(v_vis) < cardinality(v_cand) then
        v_complete := false;  -- a record the caller may not see, or none: not named, not walked through
      end if;
      v_seen := v_seen || v_cand;
      v_next := '{}'::uuid[];
      for v_e in select distinct on (r.from_ref) r.from_ref as node, r.to_ref as parent
                   from devos_private.relation r
                  where r.to_ref = any (v_frontier) and r.validity <> 'retracted' and r.from_ref = any (v_vis)
                  order by r.from_ref, r.to_ref loop
        if v_count >= v_max_records then
          v_complete := false;
          v_stop := true;
          exit;
        end if;
        v_paths := v_paths || jsonb_build_object(v_e.node::text,
                                                 (v_paths -> (v_e.parent::text)) || to_jsonb(v_e.node::text));
        v_records := v_records || jsonb_build_array(jsonb_build_object('ref', v_e.node,
                                                                       'path', v_paths -> (v_e.node::text)));
        v_count := v_count + 1;
        v_next := v_next || v_e.node;
      end loop;
      v_frontier := v_next;
    end loop;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_root);
  end if;
  return jsonb_build_object('status', 'ok', 'records', v_records, 'complete', v_complete);
end
$fn$;
comment on function devos_api.affected_entities(uuid, jsonb) is
  'devos:read The records a change of root affects, each once with one path, and a completeness flag (EV-C02-013 section 2.5)';

-- explain_paths (EV-C02-013 2.5 and C-M06; Appendix C F04: "the path explanation is separate and bounded"): the paths
-- from root to target along the edges above, each a list [root, ..., target] of records the caller may see, with no
-- record twice. limits: max_depth (default 5, the edges in a path) and max_paths (default 20), each a JSON integer of
-- at least 1. Root and target must each name a record the caller may see, else could_not_check (F04-m2, -m4-paths);
-- target equal to root: invalid_field. It walks the region within max_depth breadth first, as affected_entities, then
-- searches depth first, only through records from which target can be reached, and stops after max_paths + 1 paths or
-- 20000 steps. complete is true only when the walk was complete, no more than max_paths paths exist, no path was cut at
-- max_depth and the step bound was not reached. A read, as affected_entities. devos_calisma, devos_denetim,
-- devos_sinav, devos_kurulum. Answer {"status": "ok", "paths": [[root, ..., target], ...], "complete"}.
create function devos_api.explain_paths(root uuid, target uuid, limits jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_root alias for $1;
  p_target alias for $2;
  p_limits alias for $3;
  v_fn constant text := 'explain_paths';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_max_depth integer := 5;
  v_max_paths integer := 20;
  v_budget constant integer := 20000;
  v_end text;
  v_ref uuid;
  v_fam text;
  v_seen uuid[];
  v_frontier uuid[];
  v_cand uuid[];
  v_vis uuid[];
  v_region uuid[];
  v_ea uuid[] := '{}'::uuid[];
  v_eb uuid[] := '{}'::uuid[];
  v_back uuid[];
  v_add uuid[];
  v_adj jsonb;
  v_path uuid[];
  v_idx integer[];
  v_n integer;
  v_top uuid;
  v_succ jsonb;
  v_i integer;
  v_s uuid;
  v_found jsonb := '[]'::jsonb;
  v_nfound integer := 0;
  v_steps integer := 0;
  v_depth integer := 0;
  v_complete boolean := true;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;

  -- The read block (a read has no write block).
  begin
    if not (v_class = any (array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'explain_paths admits only the role classes devos_calisma, devos_denetim, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if p_root is null then
      v_code := 'missing_field'; v_reason := 'root: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if p_target is null then
      v_code := 'missing_field'; v_reason := 'target: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if p_target = p_root then
      v_code := 'invalid_field'; v_reason := 'target: names the root itself';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_limits), 'null') <> 'null' then
      if jsonb_typeof(p_limits) <> 'object' then
        v_code := 'invalid_field'; v_reason := 'limits: not a JSON object';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      foreach v_key in array array['max_depth', 'max_paths'] loop
        if coalesce(jsonb_typeof(p_limits -> v_key), 'null') <> 'null' then
          if jsonb_typeof(p_limits -> v_key) <> 'number' or (p_limits ->> v_key) !~ '^[1-9][0-9]{0,8}$' then
            v_code := 'invalid_field'; v_reason := v_key || ': not an integer of at least 1';
            raise exception using errcode = 'P0D01', message = 'devos refusal';
          end if;
          if v_key = 'max_depth' then
            v_max_depth := (p_limits ->> v_key)::integer;
          else
            v_max_paths := (p_limits ->> v_key)::integer;
          end if;
        end if;
      end loop;
    end if;

    -- The root and the target: records the caller may see (EV-C02-008 5.1 (b)).
    foreach v_end in array array['root', 'target'] loop
      v_check := v_end;
      if v_end = 'root' then v_ref := p_root; else v_ref := p_target; end if;
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
      if v_fam is null and v_class = 'devos_sinav' then
        perform 1 from devos_private.eval_run x where x.id = v_ref;
        if found then
          v_fam := 'eval_run';
        end if;
      end if;
      if v_fam is null then
        v_code := 'could_not_check'; v_reason := v_end || ': the record could not be read';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;

    -- The region within max_depth, breadth first, with every edge between its visible records.
    v_check := 'walk';
    v_seen := array[p_root];
    v_frontier := array[p_root];
    v_region := array[p_root];
    while cardinality(v_frontier) > 0 loop
      if exists (select 1 from devos_private.relation r where r.to_ref = any (v_frontier) and r.validity is null) then
        v_complete := false;
      end if;
      if v_depth >= v_max_depth then
        -- Any edge out of the last level, to a record seen or not, may lengthen a path beyond max_depth.
        if exists (select 1 from devos_private.relation r
                    where r.to_ref = any (v_frontier) and r.validity <> 'retracted') then
          v_complete := false;
        end if;
        exit;
      end if;
      v_depth := v_depth + 1;
      select coalesce(array_agg(distinct r.from_ref), '{}'::uuid[]) into v_cand
        from devos_private.relation r
       where r.to_ref = any (v_frontier) and r.validity <> 'retracted' and not (r.from_ref = any (v_seen));
      v_vis := '{}'::uuid[];
      if cardinality(v_cand) > 0 then
        select coalesce(array_agg(f.id), '{}'::uuid[]) into v_vis
          from (select x.id from devos_private.work x where x.id = any (v_cand)
                union all select x.id from devos_private.mission x where x.id = any (v_cand)
                union all select x.id from devos_private.decision x where x.id = any (v_cand)
                union all select x.id from devos_private.finding x where x.id = any (v_cand)
                union all select x.id from devos_private.artifact x where x.id = any (v_cand)
                union all select x.id from devos_private.need x where x.id = any (v_cand)
                union all select x.id from devos_private.relation x where x.id = any (v_cand)
                union all select x.id from devos_private.effort_policy x where x.id = any (v_cand)
                union all select x.id from devos_private.assignment x where x.id = any (v_cand)
                union all select x.id from devos_private.review x where x.id = any (v_cand)
                union all select x.id from devos_private.verdict x where x.id = any (v_cand)
                union all select x.id from devos_private.acceptance x where x.id = any (v_cand)
                union all select x.id from devos_private.operation x where x.id = any (v_cand)
                union all select x.id from devos_private.observation x where x.id = any (v_cand)) f;
        if v_class = 'devos_sinav' then
          select v_vis || coalesce(array_agg(x.id), '{}'::uuid[]) into v_vis
            from devos_private.eval_run x where x.id = any (v_cand);
        end if;
        if cardinality(v_vis) < cardinality(v_cand) then
          v_complete := false;
        end if;
      end if;
      v_seen := v_seen || v_cand;
      v_region := v_region || v_vis;
      select v_ea || coalesce(array_agg(d.parent order by d.parent, d.node), '{}'::uuid[]),
             v_eb || coalesce(array_agg(d.node order by d.parent, d.node), '{}'::uuid[])
        into v_ea, v_eb
        from (select distinct r.to_ref as parent, r.from_ref as node
                from devos_private.relation r
               where r.to_ref = any (v_frontier) and r.validity <> 'retracted' and r.from_ref = any (v_region)) d;
      v_frontier := v_vis;
    end loop;

    if p_target = any (v_region) then
      -- The records that can reach target, within the region.
      v_back := array[p_target];
      loop
        select coalesce(array_agg(distinct e.a), '{}'::uuid[]) into v_add
          from unnest(v_ea, v_eb) as e(a, b)
         where e.b = any (v_back) and not (e.a = any (v_back));
        exit when cardinality(v_add) = 0;
        v_back := v_back || v_add;
      end loop;
      select coalesce(jsonb_object_agg(s.a, s.succ), '{}'::jsonb) into v_adj
        from (select d.a::text as a, jsonb_agg(d.b::text order by d.b) as succ
                from (select distinct e.a, e.b from unnest(v_ea, v_eb) as e(a, b)
                       where e.a = any (v_back) and e.b = any (v_back)) d
               group by d.a) s;
      -- Depth first, simple paths only, bounded by max_depth, max_paths + 1 paths and the step bound.
      v_path := array[p_root];
      v_idx := array[0];
      v_n := 1;
      while v_n > 0 loop
        v_steps := v_steps + 1;
        if v_steps > v_budget then
          v_complete := false;
          exit;
        end if;
        v_top := v_path[v_n];
        if v_top = p_target then
          v_nfound := v_nfound + 1;
          if v_nfound > v_max_paths then
            v_complete := false;
            exit;
          end if;
          v_found := v_found || jsonb_build_array(to_jsonb(v_path::text[]));
          v_n := v_n - 1; v_path := v_path[1:v_n]; v_idx := v_idx[1:v_n];
          continue;
        end if;
        v_succ := coalesce(v_adj -> (v_top::text), '[]'::jsonb);
        if v_n - 1 >= v_max_depth then
          if jsonb_array_length(v_succ) > 0 then
            v_complete := false;  -- a path cut at max_depth
          end if;
          v_n := v_n - 1; v_path := v_path[1:v_n]; v_idx := v_idx[1:v_n];
          continue;
        end if;
        v_i := v_idx[v_n];
        if v_i >= jsonb_array_length(v_succ) then
          v_n := v_n - 1; v_path := v_path[1:v_n]; v_idx := v_idx[1:v_n];
          continue;
        end if;
        v_idx[v_n] := v_i + 1;
        v_s := (v_succ ->> v_i)::uuid;
        if v_s = any (v_path) then
          continue;
        end if;
        v_n := v_n + 1;
        v_path := v_path || v_s;
        v_idx := v_idx || 0;
      end loop;
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_root);
  end if;
  return jsonb_build_object('status', 'ok', 'paths', v_found, 'complete', v_complete);
end
$fn$;
comment on function devos_api.explain_paths(uuid, uuid, jsonb) is
  'devos:read A bounded list of paths from root to target, and a completeness flag (EV-C02-013 section 2.5)';

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)). PUBLIC's default EXECUTE is revoked from
-- the four functions, and so is any privilege of the four API roles; then EXECUTE is granted to anon, the role a Data
-- API request with the publishable key runs as. Each function checks the token itself. This file adds no type and no
-- devos_private function.
revoke all on function devos_api.relate(jsonb) from public;
revoke all on function devos_api.retract_relation(uuid, text) from public;
revoke all on function devos_api.affected_entities(uuid, jsonb) from public;
revoke all on function devos_api.explain_paths(uuid, uuid, jsonb) from public;
do $$
declare r text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      execute format('revoke all on function devos_api.relate(jsonb) from %I', r);
      execute format('revoke all on function devos_api.retract_relation(uuid, text) from %I', r);
      execute format('revoke all on function devos_api.affected_entities(uuid, jsonb) from %I', r);
      execute format('revoke all on function devos_api.explain_paths(uuid, uuid, jsonb) from %I', r);
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.relate(jsonb) to anon;
    grant execute on function devos_api.retract_relation(uuid, text) to anon;
    grant execute on function devos_api.affected_entities(uuid, jsonb) to anon;
    grant execute on function devos_api.explain_paths(uuid, uuid, jsonb) to anon;
  end if;
end
$$;
