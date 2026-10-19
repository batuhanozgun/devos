-- DevOS schema (W-C02-09), not a fixture. The rule corrections: the corrective migration of EV-C02-013 section 22 (7).
-- Sources: plan/work/W-C02-09.md points 1 to 7; Appendix B principles 2, 3, 6 and 9, 3.1, 3.4, 3.5, 3.8, 3.17,
-- section 4 (row "Relation"), the env_tokens rule (B:377) and section 8 (concurrency control, B:472);
-- evidence/C02/EV-C02-013_w09_interface.md sections 1 (items 6, 7, 9, 12, 13), 10 and 22 (C-D17), with section 23
-- (C-RC, this file's choices); evidence/C02/EV-C02-017_w09_rule_decisions.md sections 1 (e), 3 (e), 4 (e), 5 (e), 6
-- and 9 (the executor's decisions, L-378); evidence/C02/checks/CHK-C02-095.md; plan/work/C02.md notes N-284, N-288,
-- N-289, N-292, N-296 (3) and N-299. Record: evidence/C02/EV-C02-014_w09_build.md section 10.
-- It holds exactly what section 22 (7) names, and nothing else:
--  - N-288: devos_api.mark_stale, cancel_work and reopen_for_review (M09-04) replaced with their parameters read
--    through ALIAS FOR $n, never qualified by the function's name; no change of behaviour;
--  - N-284 option C: devos_api.revise_mission (M09-03), the widening rule (section 22 (1));
--  - N-289 option B: the shared private predicate devos_private.claim_live, and every count of a live claim through
--    it: devos_private.ready_value (M09-02), devos_api.claim (M09-05; the epoch read after the claims are locked, and
--    a claim of an earlier epoch marked expired), Rule C in devos_api.revise_work and cancel_work (M09-04), relate and
--    retract_relation (M09-06) (section 22 (3));
--  - N-292 option B: devos_api.affected_entities and explain_paths (M09-06), the edge per type (section 22 (4));
--  - N-296 (3) option B: devos_api.review_finding (M09-07), a withdrawn Finding refused (section 22 (5)).
-- devos_api.revoke_claim stays as built (N-299's annotation, L-385). Each replaced function is its merged text with
-- only the changes its comment names (the build record gives each function's difference): the same signature, role
-- literal, order of checks, codes and reasons elsewhere; its grants written again (section 1 item 13); the devos:read
-- comment of the two walks written again. Every function reads its parameters through ALIAS FOR $n, so that a merged
-- break patch that renames a function and wraps it leaves the renamed body working (N-288). No token, hash or key
-- value is written here, and no statement runs an owner-only function.
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12). The common form of
-- the devos_api functions is M09-03's (section 1 items 6, 7, 9 and 10, R1-1), unchanged.

-- The live claim (N-289 option B; EV-C02-013 section 22 (3); B:377: revoke_env_token "increments the global authority
-- epoch, which ends every claim of the old epoch (principle 9)"; B:23; DM-06). A claim is live when its status is
-- active, its lease has not run out at now(), and its authority_epoch equals the global authority epoch. Answer: true
-- (live); false (not active, its lease run out, or of another epoch, so it counts as lapsed); NULL (could not check)
-- when the status is NULL, an active claim's lease is NULL, or an active claim whose lease has not run out cannot be
-- judged by its epoch (its own epoch NULL, or the global epoch's row missing or NULL; EV-C02-013 section 1 item 7 (ii)).
-- The epoch is read only for an active claim whose lease runs, with a plain read that takes no lock (section 22 (3):
-- a plain read can only miss a concurrent increment, which counts an old claim as live and fails safe); claim reads it
-- for share before it calls this function, so there the value cannot move. Every count of a live claim goes through
-- this one function, so the counts cannot drift apart. It writes nothing and raises nothing of its own; an unreadable
-- input raises, and the caller's read block answers could_not_check. Owner only.
create function devos_private.claim_live(claim_status devos_private.assignment_status, claim_lease timestamptz,
                                         claim_epoch bigint)
returns boolean
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_status alias for $1;
  p_lease alias for $2;
  p_epoch alias for $3;
  v_global bigint;
begin
  if p_status is null then
    return null;
  end if;
  if p_status <> 'active' then
    return false;
  end if;
  if p_lease is null then
    return null;
  end if;
  if p_lease <= now() then
    return false;
  end if;
  select g.epoch into v_global from devos_private.global_authority_epoch g where g.singleton;
  if not found or v_global is null or p_epoch is null then
    return null;
  end if;
  return p_epoch = v_global;
end
$fn$;

-- ready_value (M09-02; EV-C02-013 2.4 with section 22 (3)), replaced: "no active claim whose lease has not run out"
-- becomes "no live claim" (devos_private.claim_live), so a claim of an earlier epoch no longer keeps its work item from
-- being ready; a claim the predicate cannot judge leaves readiness unknown (NULL), as a partial claim did. Its other
-- conditions and its three-valued form are M09-02's, unchanged; its parameters through ALIAS FOR $n.
create or replace function devos_private.ready_value(p_work_id uuid, p_own_claim uuid default null)
returns boolean
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_work alias for $1;
  p_own alias for $2;
  v_exec devos_private.work_execution;
  v_mission uuid;
  v_mission_status devos_private.mission_status;
  v_value_exec boolean;
  v_value_mission boolean;
  v_value_claims boolean;
  v_value_groups boolean;
  v_live boolean;
  v_partial boolean;
  v_false bigint;
  v_unknown bigint;
begin
  select w.execution, mr.mission_id into v_exec, v_mission
    from devos_private.work w
    left join lateral (select x.mission_revision_id from devos_private.work_revision x
                        where x.work_id = w.id order by x.revision desc limit 1) r on true
    left join devos_private.mission_revision mr on mr.id = r.mission_revision_id
   where w.id = p_work;
  if not found then
    return null;
  end if;
  v_value_exec := case when v_exec is null then null
                       when v_exec in ('planned', 'ready', 'waiting') then true
                       else false end;

  if v_mission is null then
    v_value_mission := null;
  else
    select m.status into v_mission_status from devos_private.mission m where m.id = v_mission;
    v_value_mission := case when not found or v_mission_status is null then null
                            else v_mission_status = 'active' end;
  end if;

  select coalesce(bool_or(devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch)), false),
         coalesce(bool_or(devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch) is null), false)
    into v_live, v_partial
    from devos_private.assignment a
   where a.work_ref = p_work and a.id is distinct from p_own;
  v_value_claims := case when v_live then false when v_partial then null else true end;

  with dep as (
    select r.id, r.to_ref, r.to_revision, r.group_id, r.group_mode,
           (r.type is null or r.hard is null or r.validity is null
            or (r.group_id is not null and r.group_mode is null)) as partial
      from devos_private.relation r
     where r.from_ref = p_work
       and (r.type is null or r.type = 'depends_on')
       and (r.hard is null or r.hard)
       and (r.validity is null or r.validity = 'current')
  ),
  member as (
    select d.id, d.group_id, d.group_mode,
           case
             when d.partial then null
             when exists (select 1 from devos_private.work w where w.id = d.to_ref) then
               (select case when w.execution is null or w.acceptance is null or d.to_revision is null then null
                            when not exists (select 1 from devos_private.work_revision x
                                              where x.work_id = w.id and x.revision = d.to_revision) then null
                            else w.acceptance = 'accepted' end
                  from devos_private.work w where w.id = d.to_ref)
             when exists (select 1 from devos_private.need n where n.id = d.to_ref) then
               (select case when n.status is null or d.to_revision is not null then null
                            else n.status = 'resolved' end
                  from devos_private.need n where n.id = d.to_ref)
             when exists (select 1 from devos_private.decision c where c.id = d.to_ref) then
               (select case when c.status is null or d.to_revision is null then null
                            when not exists (select 1 from devos_private.decision_revision x
                                              where x.decision_id = c.id and x.revision = d.to_revision) then null
                            else c.status in ('answered', 'accepted') end
                  from devos_private.decision c where c.id = d.to_ref)
             else null
           end as val
      from dep d
  ),
  grp as (
    select count(distinct m.group_mode) as modes,
           coalesce(min(m.group_mode::text), 'ALL') as mode,
           count(*) filter (where m.val) as n_true,
           count(*) filter (where not m.val) as n_false,
           count(*) filter (where m.val is null) as n_unknown
      from member m
     group by coalesce(m.group_id, m.id)
  ),
  gval as (
    select case when g.modes > 1 then null
                when g.mode = 'ANY' then case when g.n_true > 0 then true when g.n_unknown > 0 then null else false end
                else case when g.n_false > 0 then false when g.n_unknown > 0 then null else true end
           end as val
      from grp g
  )
  select count(*) filter (where not v.val), count(*) filter (where v.val is null)
    into v_false, v_unknown
    from gval v;
  v_value_groups := case when v_false > 0 then false when v_unknown > 0 then null else true end;

  if v_value_exec is false or v_value_mission is false or v_value_claims is false or v_value_groups is false then
    return false;
  end if;
  if v_value_exec is null or v_value_mission is null or v_value_claims is null or v_value_groups is null then
    return null;
  end if;
  return true;
end
$fn$;

-- revise_mission (M09-03; EV-C02-013 2.2 with section 22 (1), N-284 option C), replaced. At the mission_authority step,
-- after stale_revision: a widening of the scope or a change of purpose that names owner_authority (checked as
-- open_mission checks it) is refused mission_authority when the Decision named is the owner_authority of any revision
-- of this Mission, current or earlier; then its answered_at is read with the Decision's row (already read for share):
-- NULL is could_not_check, earlier than the created_at of the Mission's current revision is mission_authority, and an
-- equal time passes. A narrowing, a status change and an owner_authority sent without a widening keep M09-03's checks.
-- The rule rests on mission_revision.created_at being the database's write time and on answered_at being written only
-- by transfer_decision and C06's intake (section 22 (1)). Its other checks are M09-03's, unchanged; p through ALIAS
-- FOR $1.
create or replace function devos_api.revise_mission(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
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
  v_danswered_at timestamptz;
  v_mstatus devos_private.mission_status;
  v_cur_rev integer;
  v_cur_purpose text;
  v_cur_scope text;
  v_cur_constraints jsonb;
  v_cur_acceptance text;
  v_cur_authority uuid;
  v_cur_created timestamptz;
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
  if jsonb_typeof(p_in -> 'declared_session_id') = 'string' then
    v_decl := p_in ->> 'declared_session_id';
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'revise_mission admits only the role class devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    v_check := 'input';
    if p_in is null then
      v_code := 'missing_field'; v_reason := 'p: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in) <> 'object' then
      v_code := 'invalid_field'; v_reason := 'p: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'id'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'id') <> 'string'
       or (p_in ->> 'id') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'id: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_id := (p_in ->> 'id')::uuid;
    v_target := v_id;
    if coalesce(jsonb_typeof(p_in -> 'base_revision'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'base_revision: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'base_revision') <> 'number' or (p_in ->> 'base_revision') !~ '^[1-9][0-9]{0,8}$' then
      v_code := 'invalid_field'; v_reason := 'base_revision: not an integer of at least 1';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_base := (p_in ->> 'base_revision')::integer;
    v_target_rev := v_base;
    foreach v_key in array array['purpose', 'scope', 'acceptance', 'reason'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if jsonb_typeof(p_in -> 'scope') = 'string' and (p_in ->> 'scope') !~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$' then
      v_code := 'invalid_field'; v_reason := 'scope: not a dotted path of lower-case labels';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'constraints'), 'null') not in ('null', 'array') then
      v_code := 'invalid_field'; v_reason := 'constraints: not an array';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'status'), 'null') <> 'null'
       and (jsonb_typeof(p_in -> 'status') <> 'string' or (p_in ->> 'status') not in ('active', 'paused', 'closed')) then
      v_code := 'invalid_field'; v_reason := 'status: not active, paused or closed';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'owner_authority'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'owner_authority') <> 'string'
         or (p_in ->> 'owner_authority') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
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
      v_authority_sent := true;
    elsif coalesce(jsonb_typeof(p_in -> 'owner_authority_revision'), 'null') <> 'null' then
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
    select r.revision, r.purpose, r.scope, r.constraints, r.acceptance, r.owner_authority, r.created_at
      into v_cur_rev, v_cur_purpose, v_cur_scope, v_cur_constraints, v_cur_acceptance, v_cur_authority, v_cur_created
      from devos_private.mission_revision r where r.mission_id = v_id order by r.revision desc limit 1;
    if not found then
      v_code := 'could_not_check'; v_reason := 'mission: its current revision is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_new_purpose := coalesce(case when jsonb_typeof(p_in -> 'purpose') = 'string' then p_in ->> 'purpose' end, v_cur_purpose);
    v_new_scope := coalesce(case when jsonb_typeof(p_in -> 'scope') = 'string' then p_in ->> 'scope' end, v_cur_scope);
    v_new_acceptance := coalesce(case when jsonb_typeof(p_in -> 'acceptance') = 'string' then p_in ->> 'acceptance' end,
                                 v_cur_acceptance);
    v_new_constraints := coalesce(case when jsonb_typeof(p_in -> 'constraints') = 'array' then p_in -> 'constraints' end,
                                  v_cur_constraints);
    v_new_authority := coalesce(v_authority, v_cur_authority);
    v_new_status := coalesce(case when jsonb_typeof(p_in -> 'status') = 'string'
                                  then (p_in ->> 'status')::devos_private.mission_status end, v_mstatus);
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

    -- A call that writes a new revision needs a reason (B principle 3, B:17; EV-C02-013 2.2 with C-086); a call that
    -- changes the status alone writes no revision and needs none.
    if v_answer is null and v_content_changed then
      v_check := 'reason';
      if coalesce(jsonb_typeof(p_in -> 'reason'), 'null') <> 'string' then
        v_code := 'missing_field'; v_reason := 'reason: missing (a call that writes a new revision needs one)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end if;

    if v_answer is null and v_authority_sent then
      -- owner_authority sent: checked on every such call (DM-23 (a)), in open_mission's order (R2-7, C-20).
      v_check := 'owner_authority';
      select d.class, d.status, d.answered_revision, d.answered_at into v_dclass, v_dstatus, v_danswered, v_danswered_at
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
        -- N-284 option C (EV-C02-013 section 22 (1)): a new decision of Batu's. (1) Not the owner authority of any
        -- revision of this Mission, current or earlier.
        perform 1 from devos_private.mission_revision r where r.mission_id = v_id and r.owner_authority = v_authority;
        if found then
          v_code := 'mission_authority';
          v_reason := 'owner_authority: a Decision this Mission already rests on cannot widen it (B 3.1, B 3.17)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        -- (2) Answered no earlier than the Mission's current revision was written; an equal time passes.
        if v_danswered_at is null then
          v_code := 'could_not_check'; v_reason := 'owner_authority: answered_at missing';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_cur_created is null then
          v_code := 'could_not_check'; v_reason := 'mission: its current revision''s created_at is missing (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_danswered_at < v_cur_created then
          v_code := 'mission_authority';
          v_reason := 'owner_authority: answered before the Mission''s current revision (B 3.1)';
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
              case when jsonb_typeof(p_in -> 'reason') = 'string' then p_in ->> 'reason' end);
      perform devos_private.write_event('mission', v_id, v_rev, 'mission_revised',
        jsonb_build_object('base_revision', v_base, 'revision', v_rev, 'purpose', v_new_purpose,
                           'scope', v_new_scope, 'acceptance', v_new_acceptance, 'constraints', v_new_constraints,
                           'owner_authority', v_new_authority, 'owner_authority_revision', v_authority_rev,
                           'reason', case when jsonb_typeof(p_in -> 'reason') = 'string' then p_in ->> 'reason' end),
        v_class::text, 'call', v_decl);
    end if;
    if v_status_changed then
      update devos_private.mission m set status = v_new_status where m.id = v_id;
      perform devos_private.write_event('mission', v_id, v_rev, 'mission_status_set',
        jsonb_strip_nulls(jsonb_build_object('status', v_new_status::text, 'previous_status', v_mstatus::text,
                           'reason', case when jsonb_typeof(p_in -> 'reason') = 'string' then p_in ->> 'reason' end)),
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

-- revise_work (M09-04; EV-C02-013 2.3 with section 22 (3)), replaced: Rule C counts a live claim of another role class
-- through devos_private.claim_live (a claim of an earlier epoch counts as lapsed). Its other checks are M09-04's,
-- unchanged; p through ALIAS FOR $1.
create or replace function devos_api.revise_work(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
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
  if jsonb_typeof(p_in -> 'declared_session_id') = 'string' then
    v_decl := p_in ->> 'declared_session_id';
  end if;

  -- The read block: steps (b) to (f).
  begin
    if not (v_class = any (array['devos_calisma', 'devos_sinav', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'revise_work admits only the role classes devos_calisma, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    v_check := 'input';
    if p_in is null then
      v_code := 'missing_field'; v_reason := 'p: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in) <> 'object' then
      v_code := 'invalid_field'; v_reason := 'p: not a JSON object';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'id'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'id') <> 'string'
       or (p_in ->> 'id') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'id: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_id := (p_in ->> 'id')::uuid;
    if coalesce(jsonb_typeof(p_in -> 'base_revision'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'base_revision: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'base_revision') <> 'number' or (p_in ->> 'base_revision') !~ '^[1-9][0-9]{0,8}$' then
      v_code := 'invalid_field'; v_reason := 'base_revision: not an integer of at least 1';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_base := (p_in ->> 'base_revision')::integer;
    v_target_rev := v_base;
    foreach v_key in array array['scope', 'purpose', 'impact_class', 'consumer', 'return_to', 'stop_rule',
                                 'acceptance_ref', 'effort_policy_ref', 'reason'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') not in ('null', 'string') then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if jsonb_typeof(p_in -> 'scope') = 'string' and (p_in ->> 'scope') !~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$' then
      v_code := 'invalid_field'; v_reason := 'scope: not a dotted path of lower-case labels';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'impact_class') = 'string' and (p_in ->> 'impact_class') not in ('routine', 'high') then
      v_code := 'invalid_field'; v_reason := 'impact_class: not routine or high';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'effort_policy_ref') = 'string'
       and (p_in ->> 'effort_policy_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'effort_policy_ref: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'mission_revision'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'mission_revision') <> 'number' or (p_in ->> 'mission_revision') !~ '^[1-9][0-9]{0,8}$' then
        v_code := 'invalid_field'; v_reason := 'mission_revision: not an integer of at least 1';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_mrev := (p_in ->> 'mission_revision')::integer;
    end if;
    foreach v_key in array array['input_refs', 'target_refs', 'method_refs', 'mandatory_needs'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') not in ('null', 'array') then
        v_code := 'invalid_field'; v_reason := v_key || ': not an array';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    foreach v_key in array array['input_refs', 'target_refs'] loop
      if jsonb_typeof(p_in -> v_key) = 'array' then
        for v_el in select x.value from jsonb_array_elements(p_in -> v_key) x loop
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
    select count(*) filter (where a.status is null or (a.status = 'active' and a.role_class is null)
                              or devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch) is null),
           count(*) filter (where devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch)
                              and a.role_class <> v_class)
      into v_partial, v_other
      from devos_private.assignment a where a.work_ref = v_id;
    if v_partial > 0 then
      v_code := 'could_not_check'; v_reason := 'rule_c: a claim on the work item lacks its status, lease, role class or epoch (partial)';
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
    v_new_scope := coalesce(case when jsonb_typeof(p_in -> 'scope') = 'string' then p_in ->> 'scope' end, v_cur_scope);
    v_new_purpose := coalesce(case when jsonb_typeof(p_in -> 'purpose') = 'string' then p_in ->> 'purpose' end, v_cur_purpose);
    v_new_impact := coalesce(case when jsonb_typeof(p_in -> 'impact_class') = 'string'
                                  then (p_in ->> 'impact_class')::devos_private.impact_class end, v_cur_impact);
    v_new_consumer := case when jsonb_typeof(p_in -> 'consumer') = 'string' then p_in ->> 'consumer' else v_cur_consumer end;
    v_new_return_to := case when jsonb_typeof(p_in -> 'return_to') = 'string' then p_in ->> 'return_to' else v_cur_return_to end;
    v_new_stop_rule := case when jsonb_typeof(p_in -> 'stop_rule') = 'string' then p_in ->> 'stop_rule' else v_cur_stop_rule end;
    v_new_acceptance_ref := case when jsonb_typeof(p_in -> 'acceptance_ref') = 'string' then p_in ->> 'acceptance_ref'
                                 else v_cur_acceptance_ref end;
    v_new_policy := case when jsonb_typeof(p_in -> 'effort_policy_ref') = 'string' then (p_in ->> 'effort_policy_ref')::uuid
                         else v_cur_policy end;
    v_new_input := case when jsonb_typeof(p_in -> 'input_refs') = 'array' then p_in -> 'input_refs' else v_cur_input end;
    v_new_target := case when jsonb_typeof(p_in -> 'target_refs') = 'array' then p_in -> 'target_refs' else v_cur_target end;
    v_new_method := case when jsonb_typeof(p_in -> 'method_refs') = 'array' then p_in -> 'method_refs' else v_cur_method end;
    v_new_needs := case when jsonb_typeof(p_in -> 'mandatory_needs') = 'array' then p_in -> 'mandatory_needs' else v_cur_needs end;

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
      if coalesce(jsonb_typeof(p_in -> 'reason'), 'null') <> 'string' then
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
        if jsonb_typeof(p_in -> v_key) = 'array' then
          v_check := v_key;
          for v_el in select x.value from jsonb_array_elements(p_in -> v_key) x loop
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

      if jsonb_typeof(p_in -> 'effort_policy_ref') = 'string' then
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
            p_in ->> 'reason');
    perform devos_private.write_event('work', v_id, v_rev, 'work_revised',
      jsonb_strip_nulls(jsonb_build_object('base_revision', v_base, 'revision', v_rev, 'mission_ref', v_mission,
        'mission_revision', v_mrev, 'scope', v_new_scope, 'purpose', v_new_purpose, 'impact_class', v_new_impact::text,
        'input_refs', v_new_input, 'target_refs', v_new_target, 'consumer', v_new_consumer, 'return_to', v_new_return_to,
        'stop_rule', v_new_stop_rule, 'acceptance_ref', v_new_acceptance_ref, 'effort_policy_ref', v_new_policy,
        'method_refs', v_new_method, 'mandatory_needs', v_new_needs, 'reason', p_in ->> 'reason')),
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

-- mark_stale (M09-04; EV-C02-013 2.3), replaced for N-288 only: its parameters through ALIAS FOR $n, no change of
-- behaviour.
create or replace function devos_api.mark_stale(work_id uuid, reason text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_work alias for $1;
  p_reason alias for $2;
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
    if p_work is null then
      v_code := 'missing_field'; v_reason := 'work_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The work item and its current revision.
    v_check := 'work';
    select w.qualification into v_qual from devos_private.work w where w.id = p_work for update;
    if not found then
      v_code := 'not_found'; v_reason := 'work_id: names no Work';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_qual is null then
      v_code := 'could_not_check'; v_reason := 'work: its qualification is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select r.revision, r.mission_revision_id into v_cur_rev, v_cur_mrev
      from devos_private.work_revision r where r.work_id = p_work order by r.revision desc limit 1;
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
      perform 1 from devos_private.eval_run e where e.work_ref = p_work;
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
      v_answer := jsonb_build_object('status', 'ok', 'id', p_work, 'repeat', true);
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_work);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    update devos_private.work w set qualification = 'stale' where w.id = p_work;
    perform devos_private.write_event('work', p_work, v_cur_rev, 'work_marked_stale',
      jsonb_strip_nulls(jsonb_build_object('qualification', 'stale', 'previous_qualification', v_qual::text,
                                           'reason', p_reason)),
      v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_work);
  end if;
  return jsonb_build_object('status', 'ok', 'id', p_work);
end
$fn$;

-- cancel_work (M09-04; EV-C02-013 2.3 with section 22 (3)), replaced once for N-288 and N-289 B: its parameters through
-- ALIAS FOR $n, and Rule C's count through devos_private.claim_live. Its other checks are M09-04's, unchanged.
create or replace function devos_api.cancel_work(work_id uuid, reason text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_work alias for $1;
  p_reason alias for $2;
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
    if p_work is null then
      v_code := 'missing_field'; v_reason := 'work_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The work item and its current revision.
    v_check := 'work';
    select w.execution into v_exec from devos_private.work w where w.id = p_work for update;
    if not found then
      v_code := 'not_found'; v_reason := 'work_id: names no Work';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_exec is null then
      v_code := 'could_not_check'; v_reason := 'work: its execution is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select r.revision, r.mission_revision_id into v_cur_rev, v_cur_mrev
      from devos_private.work_revision r where r.work_id = p_work order by r.revision desc limit 1;
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
      perform 1 from devos_private.eval_run e where e.work_ref = p_work;
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
    select count(*) filter (where a.status is null or (a.status = 'active' and a.role_class is null)
                              or devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch) is null),
           count(*) filter (where devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch)
                              and a.role_class <> v_class)
      into v_partial, v_other
      from devos_private.assignment a where a.work_ref = p_work;
    if v_partial > 0 then
      v_code := 'could_not_check'; v_reason := 'rule_c: a claim on the work item lacks its status, lease, role class or epoch (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_other > 0 then
      v_code := 'other_class_claim'; v_reason := 'Rule C: another role class holds an active claim on the work item';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    v_check := 'repeat';
    if v_exec = 'cancelled' then
      v_answer := jsonb_build_object('status', 'ok', 'id', p_work, 'repeat', true);
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_work);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    update devos_private.work w set execution = 'cancelled' where w.id = p_work;
    perform devos_private.write_event('work', p_work, v_cur_rev, 'work_cancelled',
      jsonb_strip_nulls(jsonb_build_object('execution', 'cancelled', 'previous_execution', v_exec::text,
                                           'reason', p_reason)),
      v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_work);
  end if;
  return jsonb_build_object('status', 'ok', 'id', p_work);
end
$fn$;

-- reopen_for_review (M09-04; EV-C02-013 2.3), replaced for N-288 only: its parameters through ALIAS FOR $n, no change of
-- behaviour.
create or replace function devos_api.reopen_for_review(work_id uuid, reason text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_work alias for $1;
  p_reason alias for $2;
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
    if p_work is null then
      v_code := 'missing_field'; v_reason := 'work_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The work item and its current revision.
    v_check := 'work';
    select w.qualification into v_qual from devos_private.work w where w.id = p_work for update;
    if not found then
      v_code := 'not_found'; v_reason := 'work_id: names no Work';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_qual is null then
      v_code := 'could_not_check'; v_reason := 'work: its qualification is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select r.revision, r.mission_revision_id into v_cur_rev, v_cur_mrev
      from devos_private.work_revision r where r.work_id = p_work order by r.revision desc limit 1;
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
        perform 1 from devos_private.eval_run e where e.work_ref = p_work;
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
      v_answer := jsonb_build_object('status', 'ok', 'id', p_work, 'repeat', true);
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_work);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    update devos_private.work w set qualification = 'needs_review' where w.id = p_work;
    perform devos_private.write_event('work', p_work, v_cur_rev, 'work_reopened_for_review',
      jsonb_strip_nulls(jsonb_build_object('qualification', 'needs_review', 'previous_qualification', v_qual::text,
                                           'reason', p_reason)),
      v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_work);
  end if;
  return jsonb_build_object('status', 'ok', 'id', p_work);
end
$fn$;

-- claim (M09-05; EV-C02-013 2.4 and 18 (2) with section 22 (3)), replaced. Order after the gate, as M09-05's but for
-- the epoch: work_id NULL: missing_field; devos_sinav: exam_subject; the work item, for update (not_found); its current
-- revision; ownership; the work item's claims, for update; then the global authority epoch, for share (missing:
-- could_not_check), before anything about the claims is judged, still last in DM-01's order of locks; then one without
-- its status or generation, or one the predicate cannot judge: could_not_check; a live claim (devos_private.claim_live):
-- already_claimed; readiness (ready_value, which follows the predicate): false not_ready, NULL could_not_check. The
-- write block marks expired every active claim of the work item that counts as lapsed (its lease run out, or an earlier
-- epoch), listed by the read block, each with claim_expired (origin rule, the caller's class), whose payload names the
-- claim's authority_epoch and the global epoch read; then the new Assignment and claimed, as M09-05.
create or replace function devos_api.claim(work_id uuid, declared_session_id text default null)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_work alias for $1;
  p_session alias for $2;
  v_fn constant text := 'claim';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_exec devos_private.work_execution;
  v_rev integer;
  v_mrev uuid;
  v_mission uuid;
  v_inst boolean;
  v_partial bigint;
  v_live bigint;
  v_newest integer;
  v_ready boolean;
  v_epoch bigint;
  v_lapsed uuid[];
  v_old record;
  v_token text;
  v_hash text;
  v_id uuid;
  v_generation integer;
  v_lease timestamptz;
  v_answer jsonb;
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
      v_reason := 'claim admits only the role classes devos_calisma, devos_denetim, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if p_work is null then
      v_code := 'missing_field'; v_reason := 'work_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    -- EV-C02-008 5.1 (c) bound 3: devos_sinav claims no work item in C02; its own code, after the gate, before any read.
    if v_class = 'devos_sinav' then
      v_code := 'exam_subject';
      v_reason := 'devos_sinav claims no work item in C02 (EV-C02-008 5.1 (c) bound 3)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- The work item, locked for update (DM-01's first row lock), and its current revision.
    v_check := 'work';
    select w.execution into v_exec from devos_private.work w where w.id = p_work for update;
    if not found then
      v_code := 'not_found'; v_reason := 'work_id: names no Work';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select r.revision, r.mission_revision_id into v_rev, v_mrev
      from devos_private.work_revision r where r.work_id = p_work order by r.revision desc limit 1;
    if not found or v_rev is null then
      v_code := 'could_not_check'; v_reason := 'work: its current revision is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (d) Ownership (EV-C02-013 2.4; EV-C02-008 1.2, B:35): devos_kurulum only under the installation's Mission,
    -- devos_calisma and devos_denetim only under another. Read as Rule O reads the Mission (2.3, R2-6).
    v_check := 'ownership';
    select mr.mission_id into v_mission from devos_private.mission_revision mr where mr.id = v_mrev;
    if v_mission is null then
      v_code := 'could_not_check'; v_reason := 'ownership: the work item''s Mission is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_inst := devos_private.is_installation_mission(v_mission);
    if v_inst is null then
      v_code := 'could_not_check';
      v_reason := 'ownership: whether the work item lies under the installation''s Mission is missing or partial';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_class = 'devos_kurulum' and not v_inst then
      v_code := 'not_owner';
      v_reason := 'claim: devos_kurulum claims only the work items under the installation''s Mission';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_class in ('devos_calisma', 'devos_denetim') and v_inst then
      v_code := 'not_owner';
      v_reason := 'claim: the work items under the installation''s Mission are claimed only with devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The work item's claims, locked for update (DM-01: the claim after the work item).
    v_check := 'claims';
    perform 1 from devos_private.assignment a where a.work_ref = p_work for update;

    -- (f) The global authority epoch, for share, after the claims (DM-01's order of locks: the work item, the claims,
    -- the epoch), and before the live count is judged (EV-C02-013 section 22 (3)): the epoch the claim is made in.
    v_check := 'epoch';
    select g.epoch into v_epoch from devos_private.global_authority_epoch g where g.singleton for share;
    if not found then
      v_code := 'could_not_check'; v_reason := 'epoch: the global authority epoch is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_epoch is null then
      v_code := 'could_not_check'; v_reason := 'epoch: its value is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The live claims (devos_private.claim_live: active, lease not run out, of the current epoch), and the active
    -- claims that count as lapsed (lease run out, or an earlier epoch), which the write block marks expired.
    v_check := 'claims';
    select count(*) filter (where a.status is null or a.generation is null
                              or devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch) is null),
           count(*) filter (where devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch)),
           max(a.generation),
           coalesce(array_agg(a.id order by a.generation)
                      filter (where a.status = 'active'
                                and not devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch)),
                    '{}'::uuid[])
      into v_partial, v_live, v_newest, v_lapsed
      from devos_private.assignment a where a.work_ref = p_work;
    if v_partial > 0 then
      v_code := 'could_not_check'; v_reason := 'claims: a claim on the work item lacks its status, lease or generation (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_live > 0 then
      v_code := 'already_claimed'; v_reason := 'the work item has an active claim whose lease has not run out';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) Readiness (B 3.3: the claim re-checks the conditions ready_works reads; B principle 6: only true is ready).
    v_check := 'readiness';
    v_ready := devos_private.ready_value(p_work);
    if v_ready is null then
      v_code := 'could_not_check';
      v_reason := 'readiness: a condition or a hard dependency of the work item is missing or unknown';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if not v_ready then
      v_code := 'not_ready'; v_reason := 'the work item is not ready';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, p_session, p_work);
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    -- DM-06 with N-289 B: the claim that next takes the work item marks every claim that counts as lapsed expired (its
    -- lease run out, or an earlier authority epoch; the read block's list), with its event (origin rule), whose payload
    -- names the claim's epoch beside the global epoch read, so a reader tells the two ends of a claim apart.
    for v_old in update devos_private.assignment a set status = 'expired'
                  where a.id = any (v_lapsed) and a.status = 'active'
                  returning a.id, a.generation, a.lease_expires_at, a.authority_epoch loop
      perform devos_private.write_event('assignment', v_old.id, null, 'claim_expired',
        jsonb_build_object('work_ref', p_work, 'generation', v_old.generation, 'status', 'expired',
                           'lease_expires_at', v_old.lease_expires_at, 'authority_epoch', v_old.authority_epoch,
                           'global_authority_epoch', v_epoch),
        v_class::text, 'rule', p_session);
    end loop;
    v_generation := coalesce(v_newest, 0) + 1;
    v_lease := now() + interval '30 minutes';
    v_token := 'dv' || 'clm1_'
               || translate(rtrim(encode(extensions.gen_random_bytes(32), 'base64'), '='), '+/', '-_');
    v_hash := devos_private.token_hash(v_token);
    insert into devos_private.assignment (work_ref, work_revision, declared_session_id, role_class, claim_token_hash,
                                          generation, authority_epoch, lease_expires_at)
    values (p_work, v_rev, p_session, v_class, v_hash, v_generation, v_epoch, v_lease)
    returning id into v_id;
    v_hash := null;
    perform devos_private.write_event('assignment', v_id, null, 'claimed',
      jsonb_build_object('work_ref', p_work, 'work_revision', v_rev, 'generation', v_generation,
                         'authority_epoch', v_epoch, 'lease_expires_at', v_lease),
      v_class::text, 'call', p_session);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  v_hash := null;
  if v_code is not null then
    v_token := null;
    return devos_private.reject(v_fn, v_class, v_code, v_reason, p_session, p_work);
  end if;
  v_answer := jsonb_build_object('status', 'ok', 'id', v_id, 'assignment_id', v_id, 'claim_token', v_token,
                                 'generation', v_generation, 'lease_expires_at', v_lease);
  v_token := null;
  return v_answer;
end
$fn$;

-- relate (M09-06; EV-C02-013 2.5 with section 22 (3)), replaced: Rule C counts a live claim through
-- devos_private.claim_live. Its other checks are M09-06's, unchanged.
create or replace function devos_api.relate(p jsonb)
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
        select count(*) filter (where a.status is null or (a.status = 'active' and a.role_class is null)
                                  or devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch) is null),
               count(*) filter (where devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch)
                                  and a.role_class <> v_class)
          into v_partial, v_other
          from devos_private.assignment a where a.work_ref = v_from;
        if v_partial > 0 then
          v_code := 'could_not_check';
          v_reason := 'rule_c: a claim on the work item lacks its status, lease, role class or epoch (partial)';
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

-- retract_relation (M09-06; EV-C02-013 2.5 with section 22 (3)), replaced: Rule C counts a live claim through
-- devos_private.claim_live. Its other checks are M09-06's, unchanged.
create or replace function devos_api.retract_relation(relation_id uuid, reason text)
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
        select count(*) filter (where a.status is null or (a.status = 'active' and a.role_class is null)
                                  or devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch) is null),
               count(*) filter (where devos_private.claim_live(a.status, a.lease_expires_at, a.authority_epoch)
                                  and a.role_class <> v_class)
          into v_partial, v_other
          from devos_private.assignment a where a.work_ref = v_from;
        if v_partial > 0 then
          v_code := 'could_not_check';
          v_reason := 'rule_c: a claim on the work item lacks its status, lease, role class or epoch (partial)';
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

-- The walks' edge (N-292 option B; EV-C02-013 section 22 (4); B:149; B:226; Appendix C K09). An edge is a pair (record
-- changed, record affected): (to_ref, from_ref) for depends_on, derived_from, supersedes, uses, reviews, blocks_effect
-- and about, as M09-06 built it; (from_ref, to_ref) for supports and challenges; both pairs for part_of. A relation
-- whose type is NULL is partial input: it is not walked, and a walk that meets it (either end in the level being
-- walked) is not complete. Retracted relations are not walked; stale ones are; a NULL validity makes the walk not
-- complete; the max_depth test, explain_paths' region and its depth-first search all use the same edge set. Each walk
-- reads the edges from devos_private.relation in one subquery; nothing else of M09-06's walks changes.

-- affected_entities (M09-06; EV-C02-013 2.5 and 19 (3) with section 22 (4)), replaced: the edge above.
create or replace function devos_api.affected_entities(root uuid, limits jsonb)
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
      if exists (select 1 from (select x.validity, x.to_ref as changed, x.from_ref as affected from devos_private.relation x
               where x.type is not null and x.type not in ('supports', 'challenges')
              union all
              select x.validity, x.from_ref, x.to_ref from devos_private.relation x
               where x.type in ('supports', 'challenges', 'part_of')) r where r.changed = any (v_frontier) and r.validity is null)
         or exists (select 1 from devos_private.relation x
                     where x.type is null and (x.from_ref = any (v_frontier) or x.to_ref = any (v_frontier))) then
        v_complete := false;
      end if;
      if v_depth >= v_max_depth then
        if exists (select 1 from (select x.validity, x.to_ref as changed, x.from_ref as affected from devos_private.relation x
               where x.type is not null and x.type not in ('supports', 'challenges')
              union all
              select x.validity, x.from_ref, x.to_ref from devos_private.relation x
               where x.type in ('supports', 'challenges', 'part_of')) r
                    where r.changed = any (v_frontier) and r.validity <> 'retracted' and not (r.affected = any (v_seen))) then
          v_complete := false;
        end if;
        exit;
      end if;
      v_depth := v_depth + 1;
      select coalesce(array_agg(distinct r.affected), '{}'::uuid[]) into v_cand
        from (select x.validity, x.to_ref as changed, x.from_ref as affected from devos_private.relation x
               where x.type is not null and x.type not in ('supports', 'challenges')
              union all
              select x.validity, x.from_ref, x.to_ref from devos_private.relation x
               where x.type in ('supports', 'challenges', 'part_of')) r
       where r.changed = any (v_frontier) and r.validity <> 'retracted' and not (r.affected = any (v_seen));
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
      for v_e in select distinct on (r.affected) r.affected as node, r.changed as parent
                   from (select x.validity, x.to_ref as changed, x.from_ref as affected from devos_private.relation x
               where x.type is not null and x.type not in ('supports', 'challenges')
              union all
              select x.validity, x.from_ref, x.to_ref from devos_private.relation x
               where x.type in ('supports', 'challenges', 'part_of')) r
                  where r.changed = any (v_frontier) and r.validity <> 'retracted' and r.affected = any (v_vis)
                  order by r.affected, r.changed loop
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

-- explain_paths (M09-06; EV-C02-013 2.5 and 19 (4) with section 22 (4)), replaced: the edge above.
create or replace function devos_api.explain_paths(root uuid, target uuid, limits jsonb)
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
      if exists (select 1 from (select x.validity, x.to_ref as changed, x.from_ref as affected from devos_private.relation x
               where x.type is not null and x.type not in ('supports', 'challenges')
              union all
              select x.validity, x.from_ref, x.to_ref from devos_private.relation x
               where x.type in ('supports', 'challenges', 'part_of')) r where r.changed = any (v_frontier) and r.validity is null)
         or exists (select 1 from devos_private.relation x
                     where x.type is null and (x.from_ref = any (v_frontier) or x.to_ref = any (v_frontier))) then
        v_complete := false;
      end if;
      if v_depth >= v_max_depth then
        -- Any edge out of the last level, to a record seen or not, may lengthen a path beyond max_depth.
        if exists (select 1 from (select x.validity, x.to_ref as changed, x.from_ref as affected from devos_private.relation x
               where x.type is not null and x.type not in ('supports', 'challenges')
              union all
              select x.validity, x.from_ref, x.to_ref from devos_private.relation x
               where x.type in ('supports', 'challenges', 'part_of')) r
                    where r.changed = any (v_frontier) and r.validity <> 'retracted') then
          v_complete := false;
        end if;
        exit;
      end if;
      v_depth := v_depth + 1;
      select coalesce(array_agg(distinct r.affected), '{}'::uuid[]) into v_cand
        from (select x.validity, x.to_ref as changed, x.from_ref as affected from devos_private.relation x
               where x.type is not null and x.type not in ('supports', 'challenges')
              union all
              select x.validity, x.from_ref, x.to_ref from devos_private.relation x
               where x.type in ('supports', 'challenges', 'part_of')) r
       where r.changed = any (v_frontier) and r.validity <> 'retracted' and not (r.affected = any (v_seen));
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
        from (select distinct r.changed as parent, r.affected as node
                from (select x.validity, x.to_ref as changed, x.from_ref as affected from devos_private.relation x
               where x.type is not null and x.type not in ('supports', 'challenges')
              union all
              select x.validity, x.from_ref, x.to_ref from devos_private.relation x
               where x.type in ('supports', 'challenges', 'part_of')) r
               where r.changed = any (v_frontier) and r.validity <> 'retracted' and r.affected = any (v_region)) d;
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

-- review_finding (M09-07; EV-C02-013 2.6 and 20 (2) with section 22 (5), N-296 (3) option B), replaced: once the
-- Finding is locked and its status read, a withdrawn Finding is refused invalid_field, before the current revision,
-- stale_revision, the exact repeat and the gates. No other order of statuses is built (section 22 (5)). Its other
-- checks are M09-07's, unchanged.
create or replace function devos_api.review_finding(finding_id uuid, revision integer, status text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_finding alias for $1;
  p_revision alias for $2;
  p_status alias for $3;
  v_fn constant text := 'review_finding';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_answer jsonb;
  v_status devos_private.finding_status;
  v_cur integer;
  v_spans jsonb;
  v_span jsonb;
  v_changeable devos_private.finding_changeable;
  v_counter text;
  v_i integer;
  v_primary integer := 0;
  v_undated boolean := false;
  v_date date;
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
      v_reason := 'review_finding admits only the role class devos_denetim';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (c) The form.
    v_check := 'input';
    if p_finding is null then
      v_code := 'missing_field'; v_reason := 'finding_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if p_revision is null then
      v_code := 'missing_field'; v_reason := 'revision: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if p_status is null then
      v_code := 'missing_field'; v_reason := 'status: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if p_revision < 1 then
      v_code := 'invalid_field'; v_reason := 'revision: not an integer of at least 1';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if p_status not in ('reviewed', 'accepted_for_use', 'stale') then
      v_code := 'invalid_field';
      v_reason := 'status: only reviewed, accepted_for_use or stale (a review''s transitions; EV-C02-008 1.2)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The Finding and its current revision.
    v_check := 'finding';
    select f.status into v_status from devos_private.finding f where f.id = p_finding for update;
    if not found then
      v_code := 'not_found'; v_reason := 'finding_id: names no Finding';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_status is null then
      v_code := 'could_not_check'; v_reason := 'finding: its status is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    -- N-296 (3) option B (EV-C02-013 section 22 (5)): leaving withdrawn, the writer's status, is not a review.
    if v_status = 'withdrawn' then
      v_code := 'invalid_field';
      v_reason := 'finding: a withdrawn finding is not under review (EV-C02-008 section 4 item 2)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select r.revision, r.source_spans, r.changeable, r.counter_evidence_searched
      into v_cur, v_spans, v_changeable, v_counter
      from devos_private.finding_revision r where r.finding_id = p_finding order by r.revision desc limit 1;
    if v_cur is null then
      v_code := 'could_not_check'; v_reason := 'finding: its current revision is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if p_revision <> v_cur then
      v_code := 'stale_revision'; v_reason := 'revision: not the Finding''s current revision';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_status::text = p_status then
      v_answer := jsonb_build_object('status', 'ok', 'id', p_finding, 'repeat', true);
    end if;

    if v_answer is null and p_status in ('reviewed', 'accepted_for_use') then
      -- B 3.8: a finding with not_recorded cannot move to reviewed or accepted_for_use until a review enters both.
      v_check := 'not_recorded';
      if v_changeable is null or v_counter is null then
        v_code := 'could_not_check';
        v_reason := 'finding: its changeable or counter_evidence_searched is missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_changeable = 'not_recorded' or v_counter = 'not_recorded' then
        v_code := 'invalid_field';
        v_reason := 'B 3.8: a finding whose counter_evidence_searched or changeable holds not_recorded cannot move to '
                    || 'reviewed or accepted_for_use until a review enters both';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end if;

    if v_answer is null and p_status = 'accepted_for_use' and v_changeable = 'yes' then
      -- N09 (B 3.8; DM-26): information that can change is not accepted for use undated or without a primary source.
      v_check := 'source_spans';
      if v_spans is null or jsonb_typeof(v_spans) <> 'array' then
        v_code := 'could_not_check'; v_reason := 'source_spans: missing (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      for v_i in 0 .. jsonb_array_length(v_spans) - 1 loop
        v_span := v_spans -> v_i;
        if jsonb_typeof(v_span) <> 'object' or coalesce(jsonb_typeof(v_span -> 'primary'), 'null') <> 'boolean' then
          v_code := 'could_not_check';
          v_reason := 'source_spans: an entry lacks its primary or secondary marker (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if (v_span ->> 'primary')::boolean then
          v_primary := v_primary + 1;
          if coalesce(jsonb_typeof(v_span -> 'read_at'), 'null') = 'null' then
            v_undated := true;
          else
            v_date := null;
            if jsonb_typeof(v_span -> 'read_at') = 'string' and (v_span ->> 'read_at') ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' then
              begin
                v_date := (v_span ->> 'read_at')::date;
              exception when others then
                v_date := null;
              end;
            end if;
            if v_date is null then
              v_code := 'could_not_check'; v_reason := 'source_spans: a primary span''s read_at could not be read as a date';
              raise exception using errcode = 'P0D01', message = 'devos refusal';
            end if;
          end if;
        end if;
      end loop;
      if v_primary = 0 then
        v_code := 'invalid_field';
        v_reason := 'N09 (B 3.8): information that can change is not accepted for use without a primary source span';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_undated then
        v_code := 'invalid_field';
        v_reason := 'N09 (B 3.8): information that can change is not accepted for use while a primary source span is undated';
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
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_finding,
                                case when p_revision >= 1 then p_revision end);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    update devos_private.finding f set status = p_status::devos_private.finding_status where f.id = p_finding;
    perform devos_private.write_event('finding', p_finding, v_cur, 'finding_reviewed',
      jsonb_build_object('status', p_status, 'previous_status', v_status::text, 'revision', v_cur),
      v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_finding,
                                case when p_revision >= 1 then p_revision end);
  end if;
  return jsonb_build_object('status', 'ok', 'id', p_finding);
end
$fn$;

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)). PUBLIC's default EXECUTE is revoked from
-- every function this file creates or replaces, and so is any privilege of the four API roles; the devos_private
-- functions are owner-only, nothing is granted; EXECUTE on the eleven devos_api functions is granted to anon again, the
-- role a Data API request with the publishable key runs as; each checks the token itself. This file adds no type.
revoke all on function devos_private.claim_live(devos_private.assignment_status, timestamptz, bigint) from public;
revoke all on function devos_private.ready_value(uuid, uuid) from public;
revoke all on function devos_api.revise_mission(jsonb) from public;
revoke all on function devos_api.revise_work(jsonb) from public;
revoke all on function devos_api.mark_stale(uuid, text) from public;
revoke all on function devos_api.cancel_work(uuid, text) from public;
revoke all on function devos_api.reopen_for_review(uuid, text) from public;
revoke all on function devos_api.claim(uuid, text) from public;
revoke all on function devos_api.relate(jsonb) from public;
revoke all on function devos_api.retract_relation(uuid, text) from public;
revoke all on function devos_api.affected_entities(uuid, jsonb) from public;
revoke all on function devos_api.explain_paths(uuid, uuid, jsonb) from public;
revoke all on function devos_api.review_finding(uuid, integer, text) from public;
do $$
declare r text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      execute format('revoke all on function devos_private.claim_live(devos_private.assignment_status, timestamptz, '
                     'bigint) from %I', r);
      execute format('revoke all on function devos_private.ready_value(uuid, uuid) from %I', r);
      execute format('revoke all on function devos_api.revise_mission(jsonb) from %I', r);
      execute format('revoke all on function devos_api.revise_work(jsonb) from %I', r);
      execute format('revoke all on function devos_api.mark_stale(uuid, text) from %I', r);
      execute format('revoke all on function devos_api.cancel_work(uuid, text) from %I', r);
      execute format('revoke all on function devos_api.reopen_for_review(uuid, text) from %I', r);
      execute format('revoke all on function devos_api.claim(uuid, text) from %I', r);
      execute format('revoke all on function devos_api.relate(jsonb) from %I', r);
      execute format('revoke all on function devos_api.retract_relation(uuid, text) from %I', r);
      execute format('revoke all on function devos_api.affected_entities(uuid, jsonb) from %I', r);
      execute format('revoke all on function devos_api.explain_paths(uuid, uuid, jsonb) from %I', r);
      execute format('revoke all on function devos_api.review_finding(uuid, integer, text) from %I', r);
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.revise_mission(jsonb) to anon;
    grant execute on function devos_api.revise_work(jsonb) to anon;
    grant execute on function devos_api.mark_stale(uuid, text) to anon;
    grant execute on function devos_api.cancel_work(uuid, text) to anon;
    grant execute on function devos_api.reopen_for_review(uuid, text) to anon;
    grant execute on function devos_api.claim(uuid, text) to anon;
    grant execute on function devos_api.relate(jsonb) to anon;
    grant execute on function devos_api.retract_relation(uuid, text) to anon;
    grant execute on function devos_api.affected_entities(uuid, jsonb) to anon;
    grant execute on function devos_api.explain_paths(uuid, uuid, jsonb) to anon;
    grant execute on function devos_api.review_finding(uuid, integer, text) to anon;
  end if;
end
$$;
