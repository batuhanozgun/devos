-- DevOS schema (W-C02-09), not a fixture. M09-02: the private helpers, the six-class literal and Route A.
-- Sources: plan/work/W-C02-09.md points 1, 2, 3 and 7; Appendix B principles 4, 6 and 9, 3.3 to 3.5 and 3.13;
-- evidence/C02/EV-C02-013_w09_interface.md sections 1 (items 6, 7, 9, 12, 13, 14), 2.1, 2.3, 2.4, 2.5, 4, 5 (D-9) and
-- 10, with Revision 1 (R1-1, R1-12) and Revision 2 (R2-5, R2-6, R2-8); EV-C02-002 DM-01, DM-06, DM-34; plan/work/C02.md
-- note N-279 item (8) (route A, L-342 to L-344). Record: evidence/C02/EV-C02-014_w09_build.md section 3.
-- It holds exactly section 10's row M09-02: devos_private.reject (the per-call refusal writer), the inner-block
-- SQLSTATEs (below), devos_private.scope_within, check_claim, hard_dependency_cycle, is_installation_mission and
-- ready_value; devos_api.token_role_class() replaced with the six-class literal; and N-279 (8)'s route A, TEMPORARY on
-- the current database revoked from PUBLIC and from the four API roles, with its self-check. No token, hash or key
-- value is written here, and no statement runs an owner-only function.
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12).
--
-- The inner-block SQLSTATEs (EV-C02-013 section 1 item 7, R1-1). They are a contract of the devos_api functions that
-- later migrations write; no object holds them. P0D01: a refusal decided by a check in a function's read block; the
-- check first sets the function's own v_code and v_reason, then raises P0D01, and the read block's handler keeps them.
-- P0D02: raised by a check that runs inside the write block (a trigger on a written table, W-C02-10) when its own input
-- cannot be read, with a fixed reason as its message; the write block's handler maps it to could_not_check with that
-- reason. Any other error is could_not_check in the read block and write_failed in the write block. The helpers below
-- follow the contract: each returns its decision as a value, raises neither code, and catches no error, so an error in
-- reading their input reaches the caller's read block, which answers could_not_check with the caller's v_check.

-- The per-call refusal writer (EV-C02-013 section 1 items 7 and 9; DM-19; B:270). One RejectedAttempt row for a caller
-- whose token was verified and that was refused for any reason, with its role class, reason code, fixed reason text,
-- declared session and the record it names (target_ref, with target_revision only beside a target_ref). The caller
-- passes fixed text only, never input content, SQLERRM, a token or anything derived from one. It returns the refusal
-- answer, {"status": "refused", "reason_code", "reason"} and no other key, so a function ends with
-- "return devos_private.reject(...)" after both of its blocks. A failed write raises: the call then ends with an error
-- and its transaction rolls back whole (EV-C02-013 section 1 item 7). The counted form for a call without a verified
-- token is devos_private.reject_counted (M09-01).
create function devos_private.reject(p_function_name text, p_role_class devos_private.role_class, p_reason_code text,
                                     p_reason text, p_declared_session_id text default null,
                                     p_target_ref uuid default null, p_target_revision integer default null)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_reason text := coalesce(p_reason, 'the function gave no reason');
begin
  insert into devos_private.rejected_attempt (function_name, role_class, reason_code, reason, declared_session_id,
                                              target_ref, target_revision)
  values (p_function_name, p_role_class::text, p_reason_code, v_reason, p_declared_session_id, p_target_ref,
          case when p_target_ref is null then null else p_target_revision end);
  return jsonb_build_object('status', 'refused', 'reason_code', p_reason_code, 'reason', v_reason);
end
$fn$;

-- Scope containment (B principle 4; EV-C02-002 DM-34 (a)): a scope lies within another when it equals it or lies under
-- it, label by label ('a.b' lies within 'a' and 'a.b', never within 'a.bc' or 'a.b.c'). NULL for a NULL input. The
-- form of each scope is checked where it is read (the tables' checks, or the calling function's invalid_field).
create function devos_private.scope_within(p_scope text, p_container text)
returns boolean
language sql
immutable
strict
security definer
set search_path = pg_catalog, pg_temp
as $fn$
  select p_scope = p_container or left(p_scope, length(p_container) + 1) = p_container || '.'
$fn$;

-- The claim check (EV-C02-013 section 2.4, "The claim check of an effect"; B 3.5; EV-C02-003 section 4.3, S8 line 2;
-- DM-01, DM-06). The claim token's hash (the hash rule of devos_private.token_hash) must name an Assignment
-- (claim_unknown; no token: claim_missing) of the work item p_work_id (claim_unknown, with the same reason text, so the
-- answer does not tell that the claim exists for another item; p_work_id NULL, for heartbeat and release, skips this),
-- active (claim_not_active), on a work item that is not cancelled (claim_not_active: EV-C02-013 2.3, cancel_work's row,
-- "its late effect is refused by the claim check"), with its lease not run out at now() (claim_expired), of the work
-- item's newest generation (claim_generation), made in the current global authority epoch (claim_epoch), and of the
-- caller's role class (claim_class). Locks in DM-01's order: the work item's row, the claim, then the global epoch's
-- row for share; the work item and the claim for share (an effect's re-check), or for update when p_for_update (a
-- function that changes the claim, release or heartbeat). A row the check needs that is missing, or a NULL where it
-- needs a value, is could_not_check with the input named (EV-C02-013 section 1 item 7 (ii)); never read as a pass.
-- Answer: {"status": "ok", "assignment_id", "work_id", "work_revision", "generation", "authority_epoch",
-- "lease_expires_at"}, or {"status": "refused", "reason_code", "reason"}, which the caller turns into its v_code and
-- v_reason and raises P0D01. F08 (a)'s dependency re-check is devos_private.ready_value's (with p_own_claim).
create function devos_private.check_claim(p_claim_token text, p_work_id uuid, p_role_class devos_private.role_class,
                                          p_for_update boolean default false)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_hash text;
  v_work uuid;
  v_found boolean;
  v_exec devos_private.work_execution;
  v_id uuid;
  v_work_revision integer;
  v_status devos_private.assignment_status;
  v_lease timestamptz;
  v_generation integer;
  v_claim_epoch bigint;
  v_class devos_private.role_class;
  v_newest integer;
  v_generation_partial boolean;
  v_epoch bigint;
  v_epoch_found boolean;
begin
  if p_claim_token is null or p_claim_token ~ '^[[:space:]]*$' then
    return jsonb_build_object('status', 'refused', 'reason_code', 'claim_missing',
                              'reason', 'the call carries no claim token');
  end if;
  v_hash := devos_private.token_hash(p_claim_token);
  select a.work_ref into v_work from devos_private.assignment a where a.claim_token_hash = v_hash;
  if not found or (p_work_id is not null and v_work is distinct from p_work_id) then
    return jsonb_build_object('status', 'refused', 'reason_code', 'claim_unknown',
                              'reason', 'the claim token names no claim of this work item');
  end if;
  if v_work is null then
    return jsonb_build_object('status', 'refused', 'reason_code', 'could_not_check',
                              'reason', 'claim: its work item is missing (partial)');
  end if;

  -- DM-01's order: the work item, the claim, the global authority epoch.
  if p_for_update then
    select w.execution into v_exec from devos_private.work w where w.id = v_work for update;
  else
    select w.execution into v_exec from devos_private.work w where w.id = v_work for share;
  end if;
  if not found then
    return jsonb_build_object('status', 'refused', 'reason_code', 'could_not_check',
                              'reason', 'claim: its work item is missing');
  end if;
  if p_for_update then
    select a.id, a.work_revision, a.status, a.lease_expires_at, a.generation, a.authority_epoch, a.role_class
      into v_id, v_work_revision, v_status, v_lease, v_generation, v_claim_epoch, v_class
      from devos_private.assignment a where a.claim_token_hash = v_hash for update;
  else
    select a.id, a.work_revision, a.status, a.lease_expires_at, a.generation, a.authority_epoch, a.role_class
      into v_id, v_work_revision, v_status, v_lease, v_generation, v_claim_epoch, v_class
      from devos_private.assignment a where a.claim_token_hash = v_hash for share;
  end if;
  v_found := found;
  select g.epoch into v_epoch from devos_private.global_authority_epoch g where g.singleton for share;
  v_epoch_found := found;
  select max(a.generation), coalesce(bool_or(a.generation is null), false) into v_newest, v_generation_partial
    from devos_private.assignment a where a.work_ref = v_work;
  v_hash := null;

  if not v_found then
    return jsonb_build_object('status', 'refused', 'reason_code', 'could_not_check',
                              'reason', 'claim: the claim is missing');
  end if;
  if v_status is null then
    return jsonb_build_object('status', 'refused', 'reason_code', 'could_not_check',
                              'reason', 'claim: its status is missing (partial)');
  end if;
  if v_status <> 'active' then
    return jsonb_build_object('status', 'refused', 'reason_code', 'claim_not_active',
                              'reason', 'the claim is not active');
  end if;
  if v_exec is null then
    return jsonb_build_object('status', 'refused', 'reason_code', 'could_not_check',
                              'reason', 'claim: the work item''s execution is missing (partial)');
  end if;
  if v_exec = 'cancelled' then
    return jsonb_build_object('status', 'refused', 'reason_code', 'claim_not_active',
                              'reason', 'the claim''s work item is cancelled');
  end if;
  if v_lease is null then
    return jsonb_build_object('status', 'refused', 'reason_code', 'could_not_check',
                              'reason', 'claim: its lease is missing (partial)');
  end if;
  if v_lease <= now() then
    return jsonb_build_object('status', 'refused', 'reason_code', 'claim_expired',
                              'reason', 'the claim''s lease has run out');
  end if;
  if v_generation is null or v_newest is null or v_generation_partial then
    return jsonb_build_object('status', 'refused', 'reason_code', 'could_not_check',
                              'reason', 'claim: a generation is missing (partial)');
  end if;
  if v_generation < v_newest then
    return jsonb_build_object('status', 'refused', 'reason_code', 'claim_generation',
                              'reason', 'the claim is not of the work item''s newest generation');
  end if;
  if not v_epoch_found then
    return jsonb_build_object('status', 'refused', 'reason_code', 'could_not_check',
                              'reason', 'claim: the global authority epoch is missing');
  end if;
  if v_epoch is null or v_claim_epoch is null then
    return jsonb_build_object('status', 'refused', 'reason_code', 'could_not_check',
                              'reason', 'claim: an authority epoch is missing (partial)');
  end if;
  if v_claim_epoch <> v_epoch then
    return jsonb_build_object('status', 'refused', 'reason_code', 'claim_epoch',
                              'reason', 'the claim was made in an earlier authority epoch');
  end if;
  if v_class is null or p_role_class is null then
    return jsonb_build_object('status', 'refused', 'reason_code', 'could_not_check',
                              'reason', 'claim: a role class is missing (partial)');
  end if;
  if v_class <> p_role_class then
    return jsonb_build_object('status', 'refused', 'reason_code', 'claim_class',
                              'reason', 'the caller''s role class is not the claim''s');
  end if;
  return jsonb_build_object('status', 'ok', 'assignment_id', v_id, 'work_id', v_work, 'work_revision', v_work_revision,
                            'generation', v_generation, 'authority_epoch', v_claim_epoch, 'lease_expires_at', v_lease);
end
$fn$;

-- The cycle check of a hard dependency (B 3.4: "In hard dependencies a cycle is rejected"; EV-C02-013 section 2.5;
-- DM-01: "A write of a hard dependency first takes one transaction-level advisory lock, then checks for a cycle, then
-- writes"). It first takes the one queue of every hard-dependency write, the transaction-level advisory lock with the
-- two keys (9001, 1) (chosen; the two-key space is apart from any one-key lock), which a caller takes first in DM-01's
-- order, before the work item's row; the lock stays with the transaction when the caller's read block ends normally.
-- Each later statement reads with a snapshot taken after the lock is granted, so a concurrent writer's committed edge is
-- seen (READ COMMITTED). Then it answers whether a hard depends_on from p_from to p_to would close a cycle: true when
-- p_from equals p_to or a path of hard depends_on relations that are not retracted leads from p_to back to p_from;
-- false when no path does; NULL (could not check) when a path to p_from, or any edge the walk reaches, has a NULL in
-- type, hard, validity or to_ref (EV-C02-013 section 1 item 7 (ii)). The caller refuses cycle on true and
-- could_not_check on NULL.
create function devos_private.hard_dependency_cycle(p_from uuid, p_to uuid)
returns boolean
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_cycle boolean;
  v_partial boolean;
begin
  perform pg_catalog.pg_advisory_xact_lock(9001, 1);
  if p_from is null or p_to is null then
    return null;
  end if;
  if p_from = p_to then
    return true;
  end if;
  with recursive walk (node, partial) as (
    select p_to, false
    union
    select r.to_ref,
           w.partial or r.type is null or r.hard is null or r.validity is null or r.to_ref is null
      from walk w
      join devos_private.relation r on r.from_ref = w.node
     where (r.type is null or r.type = 'depends_on')
       and (r.hard is null or r.hard)
       and (r.validity is null or r.validity <> 'retracted')
  )
  select coalesce(bool_or(w.node = p_from and not w.partial), false), coalesce(bool_or(w.partial), false)
    into v_cycle, v_partial
    from walk w;
  if v_cycle then
    return true;
  end if;
  if v_partial then
    return null;
  end if;
  return false;
end
$fn$;

-- The installation's Mission (EV-C02-013 sections 2.3 and 4; hook installation_mission; R2-6): the one Mission whose
-- creation event, its first event on aggregate mission, is of type transferred. It reads devos_private.event only, never
-- devos_private.mission (R2-6: Rule O does not read it). True for that Mission; false for a Mission whose creation event
-- is of another type; NULL (could not check) when the Mission has no event (its creation event is missing), when that
-- event's type is NULL, or when another Mission's creation event is transferred or has a NULL type too, so that "the one
-- Mission" cannot be told (EV-C02-013 section 1 item 7 (ii): never "not transferred" for a missing input).
create function devos_private.is_installation_mission(p_mission_id uuid)
returns boolean
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_type text;
  v_others bigint;
begin
  select e.event_type into v_type
    from devos_private.event e
   where e.aggregate_type = 'mission' and e.aggregate_id = p_mission_id
   order by e.id
   limit 1;
  if not found or v_type is null then
    return null;
  end if;
  if v_type <> 'transferred' then
    return false;
  end if;
  select count(*) into v_others
    from (select distinct on (e.aggregate_id) e.aggregate_id, e.event_type
            from devos_private.event e
           where e.aggregate_type = 'mission' and e.aggregate_id is distinct from p_mission_id
           order by e.aggregate_id, e.id) f
   where f.event_type is null or f.event_type = 'transferred';
  if v_others > 0 then
    return null;
  end if;
  return true;
end
$fn$;

-- Readiness, three-valued (B principle 6; B 3.3 and 3.5; EV-C02-013 section 2.4 with R2-5; DM-06). A work item is ready
-- when its execution is planned, ready or waiting, its Mission (through its current revision's mission_revision) is
-- active, it has no active claim whose lease has not run out (p_own_claim, the caller's own verified claim at an
-- effect's re-check, F08 (a), is left out of this condition), and every group of its current hard depends_on relations
-- is true. A group is the relations that share a group_id, under their group_mode; a relation with no group_id is a
-- group of one, which has its member's value whatever its mode. ALL: one false gives false, else one unknown gives
-- unknown. ANY: one true gives true, else one unknown gives unknown. A member is true when its target is a Work whose
-- acceptance is accepted, a Need resolved, or a Decision answered or accepted; false when the target exists in another
-- state; unknown when the target is in none of the three families, or the revision the relation names does not exist
-- (or a revisioned target is named without one; a Need has no revisions, so a Need named with one), or a state field it
-- is judged on (a Work's execution and acceptance, a Need's or a Decision's status) is NULL. The conditions are joined
-- three-valued: one false gives false, else one unknown gives NULL. NULL also for a work item that does not exist or
-- whose Mission cannot be found, an active claim whose lease is NULL, a claim whose status is NULL, and a relation from
-- the work item with a NULL in type, hard or validity, or with a group_id but no group_mode, or a group with two modes.
-- Only true is ready. An unreadable input raises, and the caller's read block answers could_not_check.
create function devos_private.ready_value(p_work_id uuid, p_own_claim uuid default null)
returns boolean
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
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
   where w.id = p_work_id;
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

  select coalesce(bool_or(a.status = 'active' and a.lease_expires_at > now()), false),
         coalesce(bool_or(a.status is null or (a.status = 'active' and a.lease_expires_at is null)), false)
    into v_live, v_partial
    from devos_private.assignment a
   where a.work_ref = p_work_id and a.id is distinct from p_own_claim;
  v_value_claims := case when v_live then false when v_partial then null else true end;

  with dep as (
    select r.id, r.to_ref, r.to_revision, r.group_id, r.group_mode,
           (r.type is null or r.hard is null or r.validity is null
            or (r.group_id is not null and r.group_mode is null)) as partial
      from devos_private.relation r
     where r.from_ref = p_work_id
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

-- token_role_class(), replaced (EV-C02-013 section 2.1 with R2-8; section 1 items 6 (a), 6 (b) and 9; B:48: "The role
-- list sits in the function's definition"). (a) The derivation; an unverified token is refused with its token code, as
-- before. (b) The role list, a literal of the six classes in this text: a verified class not on it is refused
-- role_class_not_permitted with one per-call RejectedAttempt row, so a class added to devos_private.role_class later
-- (devos_ingest, C04) is refused until a migration puts it on this list. Same signature; VOLATILE; a read: it changes
-- no table but rejected_attempt, and its comment begins devos:read. It has no check after (b), so no read or write block.
create or replace function devos_api.token_role_class()
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_class devos_private.role_class;
begin
  v_class := devos_private.caller_role_class('token_role_class');
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;
  if not (v_class = any (array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum', 'devos_ci',
                               'devos_backup']::devos_private.role_class[])) then
    return devos_private.reject('token_role_class', v_class, 'role_class_not_permitted',
                                'token_role_class admits only the six role classes of Appendix B section 2');
  end if;
  return jsonb_build_object('status', 'ok', 'role_class', v_class::text);
end
$fn$;
comment on function devos_api.token_role_class() is
  'devos:read The role class of the caller''s verified environment token, for the six classes (EV-C02-013 section 2.1)';

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)). PUBLIC's default EXECUTE is revoked from
-- every function this file creates or replaces, and so is any privilege of the four API roles. The devos_private
-- functions are owner-only: nothing is granted. token_role_class() is granted to anon again, the role a Data API
-- request with the publishable key runs as; it checks the token itself. This file adds no type.
revoke all on function devos_private.reject(text, devos_private.role_class, text, text, text, uuid, integer) from public;
revoke all on function devos_private.scope_within(text, text) from public;
revoke all on function devos_private.check_claim(text, uuid, devos_private.role_class, boolean) from public;
revoke all on function devos_private.hard_dependency_cycle(uuid, uuid) from public;
revoke all on function devos_private.is_installation_mission(uuid) from public;
revoke all on function devos_private.ready_value(uuid, uuid) from public;
revoke all on function devos_api.token_role_class() from public;
do $$
declare r text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      execute format('revoke all on function devos_private.reject(text, devos_private.role_class, text, text, text, '
                     'uuid, integer) from %I', r);
      execute format('revoke all on function devos_private.scope_within(text, text) from %I', r);
      execute format('revoke all on function devos_private.check_claim(text, uuid, devos_private.role_class, boolean) '
                     'from %I', r);
      execute format('revoke all on function devos_private.hard_dependency_cycle(uuid, uuid) from %I', r);
      execute format('revoke all on function devos_private.is_installation_mission(uuid) from %I', r);
      execute format('revoke all on function devos_private.ready_value(uuid, uuid) from %I', r);
      execute format('revoke all on function devos_api.token_role_class() from %I', r);
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.token_role_class() to anon;
  end if;
end
$$;

-- Route A (N-279 (8), L-342 to L-344; EV-C02-013 section 5 D-9 with R1-12; W-C02-09 point 2: "no application role may
-- create objects in a schema on that path"). TEMPORARY on the current database is revoked from PUBLIC and from anon,
-- authenticated, authenticator and service_role, so that none of them can create objects in pg_temp, the second schema
-- of every DevOS function's search_path. The migration login postgres owns the database and keeps TEMPORARY through
-- its own grant, not through PUBLIC; PUBLIC keeps CONNECT. Every other role that had TEMPORARY only through PUBLIC
-- (Supabase's own service roles) is first granted it explicitly, so that Supabase's services keep their privilege as it
-- was; left out are the four API roles, every role one of them is a member of (so none of the four regains TEMPORARY by
-- inheritance or SET ROLE), superusers (who need no grant), PostgreSQL's predefined pg_ roles, the database owner and
-- every role that already holds TEMPORARY itself. The grant reads pg_roles at apply time, because the set of
-- Supabase's roles is the platform's, may differ between the two projects and between platform versions, and was read
-- in neither project; a fixed list would rest on a guess (the record, section 3.2). GRANT and REVOKE on a database take
-- its name, not an expression, so the current database's name is put in with format('%I'). DevOS creates no database
-- role of its own (role classes are token values, EV-C02-003 section 1.1), so there is none to leave out.
-- The block then checks its own effect (EV-C02-013 R1-12, what devos-test must show before devos) and raises, so that
-- the whole migration fails and the migration job applies nothing to devos, unless: (a) postgres has TEMPORARY; (b)
-- PUBLIC has none (no TEMPORARY entry for PUBLIC in the database's ACL, its default ACL read when it has none, and
-- has_database_privilege false for public), and none of the four API roles that exists has it, by any route; and
-- (c) every role that had TEMPORARY when this block began, other than the four and the predefined pg_ roles, still has
-- it, so no Supabase service loses the privilege. The "before" set is read in this block, before the first grant. The
-- message names only the condition that failed and the roles.
do $$
declare
  r record;
  v_db text := current_database();
  v_four text[] := array['anon', 'authenticated', 'authenticator', 'service_role'];
  v_before oid[];
  v_roles text;
begin
  select coalesce(array_agg(g.oid), '{}') into v_before
    from pg_catalog.pg_roles g
   where g.rolname !~ '^pg_'
     and g.rolname <> all (v_four)
     and pg_catalog.has_database_privilege(g.oid, v_db, 'TEMPORARY');

  for r in
    select g.rolname
      from pg_catalog.pg_roles g
     where not g.rolsuper
       and g.rolname !~ '^pg_'
       and g.rolname <> all (v_four)
       and g.oid <> (select d.datdba from pg_catalog.pg_database d where d.datname = v_db)
       and not exists (select 1
                         from pg_catalog.pg_database d
                         cross join lateral pg_catalog.aclexplode(d.datacl) a
                        where d.datname = v_db and a.grantee = g.oid and a.privilege_type = 'TEMPORARY')
       and not exists (select 1
                         from pg_catalog.pg_roles f
                        where f.rolname = any (v_four) and pg_catalog.pg_has_role(f.oid, g.oid, 'MEMBER'))
     order by g.rolname
  loop
    execute format('grant temporary on database %I to %I', v_db, r.rolname);
  end loop;
  execute format('revoke temporary on database %I from public', v_db);
  for r in select f.rolname from pg_catalog.pg_roles f where f.rolname = any (v_four) order by f.rolname loop
    execute format('revoke temporary on database %I from %I', v_db, r.rolname);
  end loop;

  -- The self-check (R1-12 (a), (b), (c)).
  if not exists (select 1 from pg_catalog.pg_roles g where g.rolname = 'postgres')
     or not pg_catalog.has_database_privilege('postgres', v_db, 'TEMPORARY') then
    raise exception 'route A self-check failed: (a) postgres has no TEMPORARY on the database';
  end if;
  if exists (select 1
               from pg_catalog.pg_database d
              cross join lateral pg_catalog.aclexplode(coalesce(d.datacl, pg_catalog.acldefault('d', d.datdba))) a
              where d.datname = v_db and a.grantee = 0 and a.privilege_type = 'TEMPORARY')
     or pg_catalog.has_database_privilege('public', v_db, 'TEMPORARY') then
    raise exception 'route A self-check failed: (b) PUBLIC still has TEMPORARY on the database';
  end if;
  select string_agg(f.rolname, ', ' order by f.rolname) into v_roles
    from pg_catalog.pg_roles f
   where f.rolname = any (v_four) and pg_catalog.has_database_privilege(f.oid, v_db, 'TEMPORARY');
  if v_roles is not null then
    raise exception 'route A self-check failed: (b) API roles that still have TEMPORARY on the database: %', v_roles;
  end if;
  select string_agg(g.rolname, ', ' order by g.rolname) into v_roles
    from pg_catalog.pg_roles g
   where g.oid = any (v_before) and not pg_catalog.has_database_privilege(g.oid, v_db, 'TEMPORARY');
  if v_roles is not null then
    raise exception 'route A self-check failed: (c) roles that had TEMPORARY on the database before route A and lost it: %',
      v_roles;
  end if;
end
$$;
