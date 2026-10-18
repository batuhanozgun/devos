-- DevOS schema (W-C02-09), not a fixture. M09-03: Mission, need and decision.
-- Sources: plan/work/W-C02-09.md points 1, 2, 3, 5 and 7; Appendix B principles 2, 3, 4 and 8, 3.1, 3.2, 3.4, 3.13,
-- 3.17 and section 4 (rows "Mission and need" and "Decision"); evidence/C02/EV-C02-013_w09_interface.md sections 1
-- (items 3 to 14), 2.2, 2.3 ("What Rule O reads"), 6 and 10, with Revision 1 (R1-1, R1-2, R1-4, R1-6), Revision 2 (R2-6,
-- R2-7, R2-9) and the correction of 2026-10-18 (section 15, C-20); EV-C02-002 DM-11, DM-19, DM-23, DM-31, DM-33, DM-34,
-- DM-36; EV-C02-008 1.7.1 (Rule O). Record: evidence/C02/EV-C02-014_w09_build.md section 4.
-- It holds exactly section 10's row M09-03, the seven functions of EV-C02-013 section 2.2: devos_api.open_mission,
-- revise_mission, record_need, resolve_need, open_decision, link_prior_decisions and read_decision. It adds no table,
-- type or private function, and changes nothing of M09-01 or M09-02, whose helpers it calls: caller_role_class,
-- write_event, reject, scope_within and is_installation_mission. No token, hash or key value is written here.
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12).
--
-- The common form (EV-C02-013 section 1 items 6, 7, 9 and 10, R1-1). (a) The derivation, before any other check: an
-- unverified token is refused with its token code, counted by the derivation itself. Then two PL/pgSQL blocks, one after
-- the other. The read block holds (b) the role list, a literal of the function's own text (B:48), (c) the input's form,
-- (d) ownership and (f) the family's rules; it writes nothing, and its row locks stay with the transaction when it ends
-- normally. A check that decides a refusal sets v_code and v_reason and raises P0D01; any other error there is
-- could_not_check, "<v_check>: its input could not be read (SQLSTATE <code>)". The write block holds (g), the writes and
-- their events, through devos_private.write_event, with the caller's role class and origin call; any error there is
-- write_failed, but P0D02 (a write-path check that could not read its input), which is could_not_check with its fixed
-- reason. After either block's refusal, outside both, one per-call RejectedAttempt row is written by
-- devos_private.reject, which returns {"status": "refused", "reason_code", "reason"}. A reason holds fixed text and an
-- SQLSTATE only, never input content or SQLERRM (P0D02's message excepted, a fixed reason by its contract). Keys a
-- function does not read are ignored (item 4); declared_session_id is written to the events and the refusal rows and
-- read for nothing else (item 5). An exact repeat writes nothing and answers ok with the existing id and
-- "repeat": true, checked before stale_revision (item 10, R2-9).

-- open_mission (EV-C02-013 2.2 with R2-7 and C-20; B 3.1; DM-23 (a)): a Mission and its revision 1 on Batu's decision.
-- Payload: purpose, scope, acceptance, owner_authority (a Decision's uuid) and owner_authority_revision (all required),
-- constraints (an array, default []). The owner authority is checked in this order: a Decision that does not exist:
-- could_not_check (a reference); class not batu, or status neither answered nor accepted: mission_authority;
-- answered_revision NULL: could_not_check; answered_revision other than owner_authority_revision, a revision the
-- Decision does not have included: mission_authority. owner_authority_revision absent: could_not_check (a reference
-- without its revision); not an integer of at least 1: invalid_field. The revision is not a column (Mission names the
-- Decision; the Decision names the revision answered), so the mission_opened event's payload keeps it. devos_kurulum only,
-- until C06 (EV-C02-003 4.1; DM-23 (b)). No exact repeat: a second call opens a second Mission.
create function devos_api.open_mission(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'open_mission';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_constraints jsonb;
  v_authority uuid;
  v_authority_rev integer;
  v_dclass devos_private.decision_class;
  v_dstatus devos_private.decision_status;
  v_danswered integer;
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
    if not (v_class = any (array['devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'open_mission admits only the role class devos_kurulum';
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
    foreach v_key in array array['purpose', 'scope', 'acceptance', 'owner_authority'] loop
      if coalesce(jsonb_typeof(p -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p ->> 'scope') !~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$' then
      v_code := 'invalid_field'; v_reason := 'scope: not a dotted path of lower-case labels';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p ->> 'owner_authority') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'owner_authority: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_authority := (p ->> 'owner_authority')::uuid;
    if coalesce(jsonb_typeof(p -> 'owner_authority_revision'), 'null') = 'null' then
      v_code := 'could_not_check'; v_reason := 'owner_authority_revision: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p -> 'owner_authority_revision') <> 'number'
       or (p ->> 'owner_authority_revision') !~ '^[1-9][0-9]{0,8}$' then
      v_code := 'invalid_field'; v_reason := 'owner_authority_revision: not an integer of at least 1';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_authority_rev := (p ->> 'owner_authority_revision')::integer;
    v_constraints := coalesce(nullif(p -> 'constraints', 'null'::jsonb), '[]'::jsonb);
    if jsonb_typeof(v_constraints) <> 'array' then
      v_code := 'invalid_field'; v_reason := 'constraints: not an array';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The owner authority (B 3.1: "opened or widened only by a decision that belongs to Batu").
    v_check := 'owner_authority';
    select d.class, d.status, d.answered_revision into v_dclass, v_dstatus, v_danswered
      from devos_private.decision d where d.id = v_authority for share;
    if not found then
      v_code := 'could_not_check'; v_reason := 'owner_authority: the record could not be read';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_dclass is null or v_dstatus is null then
      v_code := 'could_not_check'; v_reason := 'owner_authority: its class or status is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_dclass <> 'batu' or v_dstatus not in ('answered', 'accepted') then
      v_code := 'mission_authority';
      v_reason := 'owner_authority: not an answered or accepted Decision of class batu (B 3.1; DM-23)';
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
    insert into devos_private.mission (status) values ('active') returning id into v_id;
    insert into devos_private.mission_revision (mission_id, revision, purpose, scope, constraints, acceptance,
                                                owner_authority)
    values (v_id, 1, p ->> 'purpose', p ->> 'scope', v_constraints, p ->> 'acceptance', v_authority);
    perform devos_private.write_event('mission', v_id, 1, 'mission_opened',
      jsonb_build_object('purpose', p ->> 'purpose', 'scope', p ->> 'scope', 'acceptance', p ->> 'acceptance',
                         'constraints', v_constraints, 'owner_authority', v_authority,
                         'owner_authority_revision', v_authority_rev, 'status', 'active'),
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

-- revise_mission (EV-C02-013 2.2 with R1-4, R2-7, R2-9 and C-20; B 3.1; DM-02; DM-23 (a)). Payload: id and base_revision
-- (required), then any of purpose, scope, acceptance, owner_authority with owner_authority_revision, constraints,
-- status (active, paused, closed) and reason. A change of content gives a new revision (event mission_revised); a
-- change of status alone is state (event mission_status_set); a call may do both. Order: the form; the Mission
-- (not_found; its row locked for update); a closed Mission is terminal (mission_closed, for every change; a call that
-- changes nothing answers the exact repeat); owner_authority, when sent, checked as open_mission checks it, on every
-- such call; the exact repeat (content and status as current: ok, "repeat": true, before stale_revision); base_revision
-- not the current revision: stale_revision; a scope that does not lie within the current one, or a changed purpose,
-- needs a Decision of Batu's named in the call (owner_authority), else mission_authority. Pausing, resuming and closing
-- need no decision (B 3.1 names only "opened or widened").
create function devos_api.revise_mission(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'revise_mission';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_answer jsonb;
  v_id uuid;
  v_base integer;
  v_target uuid;
  v_target_rev integer;
  v_authority_sent boolean := false;
  v_authority uuid;
  v_authority_rev integer;
  v_dclass devos_private.decision_class;
  v_dstatus devos_private.decision_status;
  v_danswered integer;
  v_mstatus devos_private.mission_status;
  v_cur_rev integer;
  v_cur_purpose text;
  v_cur_scope text;
  v_cur_constraints jsonb;
  v_cur_acceptance text;
  v_cur_authority uuid;
  v_new_purpose text;
  v_new_scope text;
  v_new_constraints jsonb;
  v_new_acceptance text;
  v_new_authority uuid;
  v_new_status devos_private.mission_status;
  v_content_changed boolean;
  v_status_changed boolean;
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
    if not (v_class = any (array['devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'revise_mission admits only the role class devos_kurulum';
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
    v_target := v_id;
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
    foreach v_key in array array['purpose', 'scope', 'acceptance', 'reason'] loop
      if coalesce(jsonb_typeof(p -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if jsonb_typeof(p -> 'scope') = 'string' and (p ->> 'scope') !~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$' then
      v_code := 'invalid_field'; v_reason := 'scope: not a dotted path of lower-case labels';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p -> 'constraints'), 'null') not in ('null', 'array') then
      v_code := 'invalid_field'; v_reason := 'constraints: not an array';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p -> 'status'), 'null') <> 'null'
       and (jsonb_typeof(p -> 'status') <> 'string' or (p ->> 'status') not in ('active', 'paused', 'closed')) then
      v_code := 'invalid_field'; v_reason := 'status: not active, paused or closed';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p -> 'owner_authority'), 'null') <> 'null' then
      if jsonb_typeof(p -> 'owner_authority') <> 'string'
         or (p ->> 'owner_authority') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
        v_code := 'invalid_field'; v_reason := 'owner_authority: not a uuid';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_authority := (p ->> 'owner_authority')::uuid;
      if coalesce(jsonb_typeof(p -> 'owner_authority_revision'), 'null') = 'null' then
        v_code := 'could_not_check'; v_reason := 'owner_authority_revision: missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p -> 'owner_authority_revision') <> 'number'
         or (p ->> 'owner_authority_revision') !~ '^[1-9][0-9]{0,8}$' then
        v_code := 'invalid_field'; v_reason := 'owner_authority_revision: not an integer of at least 1';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_authority_rev := (p ->> 'owner_authority_revision')::integer;
      v_authority_sent := true;
    elsif coalesce(jsonb_typeof(p -> 'owner_authority_revision'), 'null') <> 'null' then
      v_code := 'missing_field'; v_reason := 'owner_authority: missing (owner_authority_revision is sent without it)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The Mission and its current revision.
    v_check := 'mission';
    select m.status into v_mstatus from devos_private.mission m where m.id = v_id for update;
    if not found then
      v_code := 'not_found'; v_reason := 'id: names no Mission';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_mstatus is null then
      v_code := 'could_not_check'; v_reason := 'mission: its status is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select r.revision, r.purpose, r.scope, r.constraints, r.acceptance, r.owner_authority
      into v_cur_rev, v_cur_purpose, v_cur_scope, v_cur_constraints, v_cur_acceptance, v_cur_authority
      from devos_private.mission_revision r where r.mission_id = v_id order by r.revision desc limit 1;
    if not found then
      v_code := 'could_not_check'; v_reason := 'mission: its current revision is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_new_purpose := coalesce(case when jsonb_typeof(p -> 'purpose') = 'string' then p ->> 'purpose' end, v_cur_purpose);
    v_new_scope := coalesce(case when jsonb_typeof(p -> 'scope') = 'string' then p ->> 'scope' end, v_cur_scope);
    v_new_acceptance := coalesce(case when jsonb_typeof(p -> 'acceptance') = 'string' then p ->> 'acceptance' end,
                                 v_cur_acceptance);
    v_new_constraints := coalesce(case when jsonb_typeof(p -> 'constraints') = 'array' then p -> 'constraints' end,
                                  v_cur_constraints);
    v_new_authority := coalesce(v_authority, v_cur_authority);
    v_new_status := coalesce(case when jsonb_typeof(p -> 'status') = 'string'
                                  then (p ->> 'status')::devos_private.mission_status end, v_mstatus);
    v_content_changed := v_new_purpose is distinct from v_cur_purpose or v_new_scope is distinct from v_cur_scope
                         or v_new_acceptance is distinct from v_cur_acceptance
                         or v_new_constraints is distinct from v_cur_constraints
                         or v_new_authority is distinct from v_cur_authority;
    v_status_changed := v_new_status is distinct from v_mstatus;

    -- A closed Mission is terminal (R1-4): every change is refused; a call that changes nothing is the exact repeat.
    v_check := 'mission_closed';
    if v_mstatus = 'closed' then
      if v_content_changed or v_status_changed then
        v_code := 'mission_closed'; v_reason := 'the Mission is closed, which is terminal (EV-C02-013 2.2)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_answer := jsonb_build_object('status', 'ok', 'id', v_id, 'revision', v_cur_rev, 'repeat', true);
    end if;

    if v_answer is null and v_authority_sent then
      -- owner_authority sent: checked on every such call (DM-23 (a)), in open_mission's order (R2-7, C-20).
      v_check := 'owner_authority';
      select d.class, d.status, d.answered_revision into v_dclass, v_dstatus, v_danswered
        from devos_private.decision d where d.id = v_authority for share;
      if not found then
        v_code := 'could_not_check'; v_reason := 'owner_authority: the record could not be read';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_dclass is null or v_dstatus is null then
        v_code := 'could_not_check'; v_reason := 'owner_authority: its class or status is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_dclass <> 'batu' or v_dstatus not in ('answered', 'accepted') then
        v_code := 'mission_authority';
        v_reason := 'owner_authority: not an answered or accepted Decision of class batu (B 3.1; DM-23)';
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
    end if;

    if v_answer is null then
      -- The exact repeat, before stale_revision (item 10, R2-9).
      v_check := 'repeat';
      if not v_content_changed and not v_status_changed then
        v_answer := jsonb_build_object('status', 'ok', 'id', v_id, 'revision', v_cur_rev, 'repeat', true);
      end if;
    end if;

    if v_answer is null then
      v_check := 'revision';
      if v_base <> v_cur_rev then
        v_code := 'stale_revision'; v_reason := 'base_revision: not the Mission''s current revision';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_check := 'mission_authority';
      if (v_new_scope <> v_cur_scope and not devos_private.scope_within(v_new_scope, v_cur_scope))
         or v_new_purpose <> v_cur_purpose then
        if not v_authority_sent then
          v_code := 'mission_authority';
          v_reason := 'widening the scope or changing the purpose needs a Decision of Batu''s named in the call '
                      || '(owner_authority; B 3.1)';
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
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_target, v_target_rev);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    v_rev := v_cur_rev;
    if v_content_changed then
      v_rev := v_cur_rev + 1;
      insert into devos_private.mission_revision (mission_id, revision, purpose, scope, constraints, acceptance,
                                                  owner_authority, reason)
      values (v_id, v_rev, v_new_purpose, v_new_scope, v_new_constraints, v_new_acceptance, v_new_authority,
              case when jsonb_typeof(p -> 'reason') = 'string' then p ->> 'reason' end);
      perform devos_private.write_event('mission', v_id, v_rev, 'mission_revised',
        jsonb_build_object('base_revision', v_base, 'revision', v_rev, 'purpose', v_new_purpose,
                           'scope', v_new_scope, 'acceptance', v_new_acceptance, 'constraints', v_new_constraints,
                           'owner_authority', v_new_authority, 'owner_authority_revision', v_authority_rev,
                           'reason', case when jsonb_typeof(p -> 'reason') = 'string' then p ->> 'reason' end),
        v_class::text, 'call', v_decl);
    end if;
    if v_status_changed then
      update devos_private.mission m set status = v_new_status where m.id = v_id;
      perform devos_private.write_event('mission', v_id, v_rev, 'mission_status_set',
        jsonb_strip_nulls(jsonb_build_object('status', v_new_status::text, 'previous_status', v_mstatus::text,
                           'reason', case when jsonb_typeof(p -> 'reason') = 'string' then p ->> 'reason' end)),
        v_class::text, 'call', v_decl);
    end if;
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_target, v_target_rev);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id, 'revision', v_rev);
end
$fn$;

-- record_need (EV-C02-013 2.2; B 3.2): a Need under an active Mission. Payload: mission_ref, condition and why_needed
-- (required); origin (goal, method, useful), method_ref, evidence_for, evidence_against, assumptions, alternatives,
-- consumer, return_to, uncertainty; status (open or investigating, default open). A Mission that cannot be read:
-- could_not_check (a reference; W-C02-09 point 7; EV-C02-013 item 14 with R1-2); a Mission not active:
-- mission_not_active. why_needed empty or meaningless is W-C02-10's format gate (N01); only its absence is refused
-- here. devos_calisma, devos_sinav, devos_kurulum (EV-C02-003 4.1). No exact repeat: a second call records a second Need.
create function devos_api.record_need(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'record_need';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_mission uuid;
  v_mstatus devos_private.mission_status;
  v_status devos_private.need_status;
  v_origin devos_private.need_origin;
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
      v_reason := 'record_need admits only the role classes devos_calisma, devos_sinav and devos_kurulum';
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
    foreach v_key in array array['mission_ref', 'condition', 'why_needed'] loop
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
    foreach v_key in array array['method_ref', 'consumer', 'return_to', 'uncertainty', 'origin', 'status'] loop
      if coalesce(jsonb_typeof(p -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if jsonb_typeof(p -> 'origin') = 'string' then
      if (p ->> 'origin') not in ('goal', 'method', 'useful') then
        v_code := 'invalid_field'; v_reason := 'origin: not goal, method or useful';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_origin := (p ->> 'origin')::devos_private.need_origin;
    end if;
    v_status := 'open';
    if jsonb_typeof(p -> 'status') = 'string' then
      if (p ->> 'status') not in ('open', 'investigating') then
        v_code := 'invalid_field'; v_reason := 'status: a new Need is open or investigating';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_status := (p ->> 'status')::devos_private.need_status;
    end if;

    -- (f) The Mission it serves.
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
    if v_mstatus <> 'active' then
      v_code := 'mission_not_active'; v_reason := 'mission_ref: the Mission is not active';
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

  -- The write block: step (g).
  begin
    v_check := 'write';
    insert into devos_private.need (mission_ref, condition, origin, method_ref, why_needed, evidence_for,
                                    evidence_against, assumptions, alternatives, consumer, return_to, uncertainty, status)
    values (v_mission, p ->> 'condition', v_origin, p ->> 'method_ref', p ->> 'why_needed',
            nullif(p -> 'evidence_for', 'null'::jsonb), nullif(p -> 'evidence_against', 'null'::jsonb),
            nullif(p -> 'assumptions', 'null'::jsonb), nullif(p -> 'alternatives', 'null'::jsonb),
            p ->> 'consumer', p ->> 'return_to', p ->> 'uncertainty', v_status)
    returning id into v_id;
    perform devos_private.write_event('need', v_id, null, 'need_recorded',
      jsonb_build_object('mission_ref', v_mission, 'condition', p ->> 'condition',
        'origin', v_origin::text, 'method_ref', p ->> 'method_ref', 'why_needed', p ->> 'why_needed',
        'evidence_for', nullif(p -> 'evidence_for', 'null'::jsonb),
        'evidence_against', nullif(p -> 'evidence_against', 'null'::jsonb),
        'assumptions', nullif(p -> 'assumptions', 'null'::jsonb), 'alternatives', nullif(p -> 'alternatives', 'null'::jsonb),
        'consumer', p ->> 'consumer', 'return_to', p ->> 'return_to', 'uncertainty', p ->> 'uncertainty',
        'status', v_status::text),
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

-- resolve_need (EV-C02-013 2.2; README 8.1's form): the Need need_id set resolved, with its reason in the event
-- need_resolved. An id that names no Need: not_found. Already resolved: the exact repeat. A Need dropped or superseded:
-- invalid_field. devos_calisma, devos_sinav, devos_kurulum.
create function devos_api.resolve_need(need_id uuid, reason text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'resolve_need';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_answer jsonb;
  v_status devos_private.need_status;
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
      v_reason := 'resolve_need admits only the role classes devos_calisma, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if need_id is null then
      v_code := 'missing_field'; v_reason := 'need_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'need';
    select n.status into v_status from devos_private.need n where n.id = need_id for update;
    if not found then
      v_code := 'not_found'; v_reason := 'need_id: names no Need';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_status is null then
      v_code := 'could_not_check'; v_reason := 'need: its status is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_status = 'resolved' then
      v_answer := jsonb_build_object('status', 'ok', 'id', need_id, 'repeat', true);
    elsif v_status in ('dropped', 'superseded') then
      v_code := 'invalid_field'; v_reason := 'need_id: the Need is dropped or superseded';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, need_id);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    update devos_private.need n set status = 'resolved' where n.id = need_id;
    perform devos_private.write_event('need', need_id, null, 'need_resolved',
      jsonb_strip_nulls(jsonb_build_object('reason', reason, 'previous_status', v_status::text)),
      v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, need_id);
  end if;
  return jsonb_build_object('status', 'ok', 'id', need_id);
end
$fn$;

-- open_decision (EV-C02-013 2.2 with R1-6; B 3.17): a Decision and its revision 1, status draft or open. Payload: class
-- (routine, high_impact, batu) and question (required); B 3.17's fields presented_text_tr, why_this_owner, options,
-- alternatives_considered, single_viable_path_reason, premises, criteria, evidence_refs, assumptions, reversibility,
-- reopen_triggers, recommendation, recommendation_rationale, if_unanswered, alternatives_state; status (default draft);
-- work_ref (optional). Decision has no work_ref field, so the tie to a work item is one Relation about from the work
-- item (its current revision) to the new decision (revision 1), hard false, method recorded, epistemic_status
-- observation, scope the work item's, with its relation_created event, in the same transaction; the decision_opened
-- event's payload holds work_ref. The call makes the check relate makes for that relation (EV-C02-008 1.7.1, Rule O, as
-- EV-C02-013 2.3 says it reads): devos_kurulum only on a work item under the installation's Mission, devos_calisma on
-- any other, devos_sinav on a work item its exam link names; otherwise not_owner, the reason naming the rule, never the
-- opener. Rule C is not checked: the relation is not hard. A work_ref that names no Work, or a work item whose Mission
-- cannot be read: could_not_check. The class rules and the gate at open are W-C02-10's (B 3.17). devos_calisma,
-- devos_sinav, devos_kurulum. No exact repeat: a second call opens a second Decision.
create function devos_api.open_decision(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'open_decision';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_dclass devos_private.decision_class;
  v_status devos_private.decision_status;
  v_alt devos_private.alternatives_state;
  v_work uuid;
  v_work_rev integer;
  v_work_scope text;
  v_mrev uuid;
  v_mission uuid;
  v_inst boolean;
  v_id uuid;
  v_rel uuid;
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
      v_reason := 'open_decision admits only the role classes devos_calisma, devos_sinav and devos_kurulum';
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
    foreach v_key in array array['class', 'question'] loop
      if coalesce(jsonb_typeof(p -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p ->> 'class') not in ('routine', 'high_impact', 'batu') then
      v_code := 'invalid_field'; v_reason := 'class: not routine, high_impact or batu';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_dclass := (p ->> 'class')::devos_private.decision_class;
    foreach v_key in array array['presented_text_tr', 'why_this_owner', 'single_viable_path_reason', 'reversibility',
                                 'recommendation', 'recommendation_rationale', 'if_unanswered', 'alternatives_state',
                                 'status', 'work_ref'] loop
      if coalesce(jsonb_typeof(p -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    v_status := 'draft';
    if jsonb_typeof(p -> 'status') = 'string' then
      if (p ->> 'status') not in ('draft', 'open') then
        v_code := 'invalid_field'; v_reason := 'status: a new Decision is draft or open';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_status := (p ->> 'status')::devos_private.decision_status;
    end if;
    if jsonb_typeof(p -> 'alternatives_state') = 'string' then
      if (p ->> 'alternatives_state') not in ('compared', 'single_viable_path', 'open_exploration') then
        v_code := 'invalid_field'; v_reason := 'alternatives_state: not compared, single_viable_path or open_exploration';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_alt := (p ->> 'alternatives_state')::devos_private.alternatives_state;
    end if;
    if jsonb_typeof(p -> 'work_ref') = 'string' then
      if (p ->> 'work_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
        v_code := 'invalid_field'; v_reason := 'work_ref: not a uuid';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_work := (p ->> 'work_ref')::uuid;
    end if;

    -- (d) Rule O on the work item the decision is tied to (EV-C02-008 1.7.1; EV-C02-013 2.3, "What Rule O reads").
    if v_work is not null then
      v_check := 'work_ref';
      perform 1 from devos_private.work w where w.id = v_work for share;
      if not found then
        v_code := 'could_not_check'; v_reason := 'work_ref: the record could not be read';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      select r.revision, r.scope, r.mission_revision_id into v_work_rev, v_work_scope, v_mrev
        from devos_private.work_revision r where r.work_id = v_work order by r.revision desc limit 1;
      if not found or v_work_rev is null or v_work_scope is null then
        v_code := 'could_not_check'; v_reason := 'work_ref: its current revision is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_check := 'rule_o';
      select mr.mission_id into v_mission from devos_private.mission_revision mr where mr.id = v_mrev;
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
    insert into devos_private.decision (class, status) values (v_dclass, v_status) returning id into v_id;
    insert into devos_private.decision_revision (decision_id, revision, question, presented_text_tr, why_this_owner,
                                                 options, alternatives_considered, single_viable_path_reason, premises,
                                                 criteria, evidence_refs, assumptions, reversibility, reopen_triggers,
                                                 recommendation, recommendation_rationale, if_unanswered,
                                                 alternatives_state)
    values (v_id, 1, p ->> 'question', p ->> 'presented_text_tr', p ->> 'why_this_owner',
            nullif(p -> 'options', 'null'::jsonb), nullif(p -> 'alternatives_considered', 'null'::jsonb),
            p ->> 'single_viable_path_reason', nullif(p -> 'premises', 'null'::jsonb),
            nullif(p -> 'criteria', 'null'::jsonb), nullif(p -> 'evidence_refs', 'null'::jsonb),
            nullif(p -> 'assumptions', 'null'::jsonb), p ->> 'reversibility', nullif(p -> 'reopen_triggers', 'null'::jsonb),
            p ->> 'recommendation', p ->> 'recommendation_rationale', p ->> 'if_unanswered', v_alt);
    perform devos_private.write_event('decision', v_id, 1, 'decision_opened',
      jsonb_strip_nulls(jsonb_build_object('class', v_dclass::text, 'status', v_status::text, 'question', p ->> 'question',
                                           'alternatives_state', v_alt::text, 'work_ref', v_work)),
      v_class::text, 'call', v_decl);
    if v_work is not null then
      insert into devos_private.relation (type, from_ref, from_revision, to_ref, to_revision, scope, hard, method,
                                          epistemic_status)
      values ('about', v_work, v_work_rev, v_id, 1, v_work_scope, false, 'recorded', 'observation')
      returning id into v_rel;
      perform devos_private.write_event('relation', v_rel, null, 'relation_created',
        jsonb_build_object('type', 'about', 'from_ref', v_work, 'from_revision', v_work_rev, 'to_ref', v_id,
                           'to_revision', 1, 'scope', v_work_scope, 'hard', false, 'method', 'recorded',
                           'epistemic_status', 'observation', 'validity', 'current'),
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
  if v_rel is not null then
    return jsonb_build_object('status', 'ok', 'id', v_id, 'revision', 1, 'relation_id', v_rel);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id, 'revision', 1);
end
$fn$;

-- link_prior_decisions (EV-C02-013 2.2; B 3.4, 3.17; DM-33, DM-34): one Relation about per prior decision, from the
-- decision decision_id (its current revision) to the prior (its current revision), hard false, method recorded,
-- epistemic_status inference, scope the scope sent (a Decision has none), each with its relation_created event.
-- Payload: decision_id, prior_ids (an array of at least one uuid) and scope, all required. A prior already linked by a
-- current about relation from this decision gets no new relation (B 3.4); a call that links none anew is the exact
-- repeat. decision_id names no Decision: not_found (the record the call acts on); a prior that cannot be read:
-- could_not_check (a reference; EV-C02-013 item 14 with R1-2); a prior that is the decision itself: invalid_field.
-- Until C04 it links only what the caller names (DM-33). devos_calisma, devos_sinav, devos_kurulum.
create function devos_api.link_prior_decisions(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'link_prior_decisions';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_el jsonb;
  v_dec uuid;
  v_target uuid;
  v_dec_rev integer;
  v_prior uuid;
  v_prior_rev integer;
  v_priors uuid[] := '{}';
  v_prior_revs integer[] := '{}';
  v_existing uuid[] := '{}';
  v_rel uuid;
  v_ids jsonb := '[]';
  v_new integer := 0;
  v_scope text;
  i integer;
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
      v_reason := 'link_prior_decisions admits only the role classes devos_calisma, devos_sinav and devos_kurulum';
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
    foreach v_key in array array['decision_id', 'prior_ids', 'scope'] loop
      if coalesce(jsonb_typeof(p -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if jsonb_typeof(p -> 'decision_id') <> 'string'
       or (p ->> 'decision_id') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'decision_id: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_dec := (p ->> 'decision_id')::uuid;
    v_target := v_dec;
    if jsonb_typeof(p -> 'scope') <> 'string' or (p ->> 'scope') !~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$' then
      v_code := 'invalid_field'; v_reason := 'scope: not a dotted path of lower-case labels';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_scope := p ->> 'scope';
    if jsonb_typeof(p -> 'prior_ids') <> 'array' or jsonb_array_length(p -> 'prior_ids') = 0 then
      v_code := 'invalid_field'; v_reason := 'prior_ids: not an array of at least one uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    for v_el in select e.value from jsonb_array_elements(p -> 'prior_ids') with ordinality e(value, n) order by e.n loop
      if jsonb_typeof(v_el) <> 'string'
         or (v_el #>> '{}') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
        v_code := 'invalid_field'; v_reason := 'prior_ids: an element is not a uuid';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_prior := (v_el #>> '{}')::uuid;
      if v_prior = v_dec then
        v_code := 'invalid_field'; v_reason := 'prior_ids: names the decision itself';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if not (v_prior = any (v_priors)) then
        v_priors := v_priors || v_prior;
      end if;
    end loop;

    -- (f) The decision, then each prior and whether it is already linked.
    v_check := 'decision';
    perform 1 from devos_private.decision d where d.id = v_dec for update;
    if not found then
      v_code := 'not_found'; v_reason := 'decision_id: names no Decision';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select max(r.revision) into v_dec_rev from devos_private.decision_revision r where r.decision_id = v_dec;
    if v_dec_rev is null then
      v_code := 'could_not_check'; v_reason := 'decision: its current revision is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'prior_ids';
    for i in 1 .. coalesce(array_length(v_priors, 1), 0) loop
      perform 1 from devos_private.decision d where d.id = v_priors[i] for share;
      if not found then
        v_code := 'could_not_check'; v_reason := 'prior_ids: a record could not be read';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      select max(r.revision) into v_prior_rev from devos_private.decision_revision r where r.decision_id = v_priors[i];
      if v_prior_rev is null then
        v_code := 'could_not_check'; v_reason := 'prior_ids: a prior''s current revision is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_prior_revs := v_prior_revs || v_prior_rev;
      v_rel := null;
      select r.id into v_rel from devos_private.relation r
       where r.type = 'about' and r.from_ref = v_dec and r.to_ref = v_priors[i] and r.validity = 'current'
       order by r.created_at, r.id limit 1;
      v_existing := v_existing || v_rel;
    end loop;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_target);
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    for i in 1 .. coalesce(array_length(v_priors, 1), 0) loop
      if v_existing[i] is not null then
        v_ids := v_ids || to_jsonb(v_existing[i]);
        continue;
      end if;
      insert into devos_private.relation (type, from_ref, from_revision, to_ref, to_revision, scope, hard, method,
                                          epistemic_status)
      values ('about', v_dec, v_dec_rev, v_priors[i], v_prior_revs[i], v_scope, false, 'recorded', 'inference')
      returning id into v_rel;
      perform devos_private.write_event('relation', v_rel, null, 'relation_created',
        jsonb_build_object('type', 'about', 'from_ref', v_dec, 'from_revision', v_dec_rev, 'to_ref', v_priors[i],
                           'to_revision', v_prior_revs[i], 'scope', v_scope, 'hard', false, 'method', 'recorded',
                           'epistemic_status', 'inference', 'validity', 'current'),
        v_class::text, 'call', v_decl);
      v_ids := v_ids || to_jsonb(v_rel);
      v_new := v_new + 1;
    end loop;
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_target);
  end if;
  if v_new = 0 then
    return jsonb_build_object('status', 'ok', 'ids', v_ids, 'repeat', true);
  end if;
  return jsonb_build_object('status', 'ok', 'ids', v_ids);
end
$fn$;

-- read_decision (EV-C02-013 2.2 and section 4, row R12; B:40): one Decision's current revision and state, from
-- devos_private.decision_current. An id that names no Decision: not_found; a Decision without a revision:
-- could_not_check. All six role classes, as a literal. A read: it changes no table but rejected_attempt, it is VOLATILE
-- because it records its refusals (DM-36), and its comment begins devos:read. It has no write block.
create function devos_api.read_decision(decision_id uuid)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'read_decision';
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
    if not (v_class = any (array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum', 'devos_ci',
                                 'devos_backup']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'read_decision admits only the six role classes of Appendix B section 2';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if decision_id is null then
      v_code := 'missing_field'; v_reason := 'decision_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'decision';
    select to_jsonb(c) into v_row from devos_private.decision_current c where c.id = decision_id;
    if v_row is null then
      perform 1 from devos_private.decision d where d.id = decision_id;
      if found then
        v_code := 'could_not_check'; v_reason := 'decision: its current revision is missing (partial)';
      else
        v_code := 'not_found'; v_reason := 'decision_id: names no Decision';
      end if;
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, decision_id);
  end if;
  return jsonb_build_object('status', 'ok', 'decision', v_row);
end
$fn$;
comment on function devos_api.read_decision(uuid) is
  'devos:read One Decision''s current revision and state (EV-C02-013 section 2.2; row R12)';

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)). PUBLIC's default EXECUTE is revoked from
-- every function this file creates, and so is any privilege of the four API roles; each is then granted to anon, the
-- role a Data API request with the publishable key runs as. Each checks the token itself. This file adds no type and no
-- devos_private function.
revoke all on function devos_api.open_mission(jsonb) from public;
revoke all on function devos_api.revise_mission(jsonb) from public;
revoke all on function devos_api.record_need(jsonb) from public;
revoke all on function devos_api.resolve_need(uuid, text) from public;
revoke all on function devos_api.open_decision(jsonb) from public;
revoke all on function devos_api.link_prior_decisions(jsonb) from public;
revoke all on function devos_api.read_decision(uuid) from public;
do $$
declare r text; f text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      foreach f in array array['devos_api.open_mission(jsonb)', 'devos_api.revise_mission(jsonb)',
                               'devos_api.record_need(jsonb)', 'devos_api.resolve_need(uuid, text)',
                               'devos_api.open_decision(jsonb)', 'devos_api.link_prior_decisions(jsonb)',
                               'devos_api.read_decision(uuid)'] loop
        execute format('revoke all on function %s from %I', f, r);
      end loop;
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.open_mission(jsonb) to anon;
    grant execute on function devos_api.revise_mission(jsonb) to anon;
    grant execute on function devos_api.record_need(jsonb) to anon;
    grant execute on function devos_api.resolve_need(uuid, text) to anon;
    grant execute on function devos_api.open_decision(jsonb) to anon;
    grant execute on function devos_api.link_prior_decisions(jsonb) to anon;
    grant execute on function devos_api.read_decision(uuid) to anon;
  end if;
end
$$;
