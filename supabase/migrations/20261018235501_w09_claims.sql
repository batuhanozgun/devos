-- DevOS schema (W-C02-09), not a fixture. M09-05: readiness and claim.
-- Sources: plan/work/W-C02-09.md points 1 to 5 and 7; Appendix B principles 2, 6, 8 and 9, 3.3, 3.5, 3.13 and section 4
-- (row "Readiness and claim"); evidence/C02/EV-C02-013_w09_interface.md sections 1 (items 1 to 14), 2.4, 6 (the claim
-- expiry, single-claim revocation, S8 line 2, concurrency), 10 and 18 (C-M05); EV-C02-003 sections 1.3, 1.7 and 4.3;
-- EV-C02-008 1.2 (ready_works' row), 1.7.1 and 5.1 (c) bound 3; EV-C02-002 DM-01, DM-06, DM-07, DM-19, DM-29, DM-31;
-- tests/C02/W-C02-07/shared/token_format.md section 2 (the claim token's form). Record: evidence/C02/EV-C02-014_w09_build.md
-- section 6.
-- It holds exactly section 10's row M09-05, the five functions of EV-C02-013 section 2.4: devos_api.ready_works, claim,
-- heartbeat, release and revoke_claim. It adds no table, type or private function, and changes nothing of M09-01 to
-- M09-04, whose helpers it calls: caller_role_class, token_hash, write_event, reject, check_claim, ready_value and
-- is_installation_mission. No token, hash or key value is written here.
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12).
--
-- The common form is M09-03's and M09-04's (EV-C02-013 section 1 items 6, 7, 9 and 10, R1-1): (a) the derivation,
-- before any other check; then a read block holding (b) the role list, a literal of the function's own text (B:48),
-- (c) the input's form, (d) ownership, (e) the claim check and (f) the family's rules, writing nothing (its row locks
-- stay with the transaction); then a write block holding (g) the writes and their events through
-- devos_private.write_event, with the caller's role class. A check that decides a refusal sets v_code and v_reason and
-- raises P0D01; any other error in the read block is could_not_check, "<v_check>: its input could not be read
-- (SQLSTATE <code>)"; any error in the write block is write_failed, but P0D02, which is could_not_check with its fixed
-- reason. After either block's refusal one per-call RejectedAttempt row is written by devos_private.reject. A reason
-- holds fixed text and an SQLSTATE only.
--
-- The claim token (EV-C02-003 section 1.7; token_format.md section 2; W-C02-09 point 4). It is made in claim's write
-- block: the claim marker (spelled in two pieces, so that only shared/token_format.md and the scan's pattern file hold
-- it, as M09-01 spells the environment marker) followed by 43 URL-safe Base64 characters, without padding, of 32 bytes
-- from pgcrypto's gen_random_bytes, the environment token's generator. Only its hash is stored, in
-- assignment.claim_token_hash, by devos_private.token_hash (the one hash rule of both kinds). It is returned once, in
-- claim's answer only. No other function returns it; no event payload, refusal row, error or notice holds it or its hash.
-- heartbeat and release take it as their parameter and hand it to devos_private.check_claim, which hashes it.
--
-- Parameters keep the names EV-C02-013 2.4 and README 8.1 give them (named calls), and the bodies read them through
-- ALIAS FOR $n, never qualified by the function's name, so that a merged break patch that renames a function and wraps
-- it (B-DM07-1, B-N08-4, B-N17-1, B-6RG-1, B-6RG-2, B-EXF-1) leaves the renamed body working.
--
-- Locks, in DM-01's order (EV-C02-002 DM-01; EV-C02-013 section 6, "Concurrency"): the work item's row, the claims, the
-- global authority epoch's row (for share). claim, heartbeat, release and revoke_claim lock the work item for update
-- (claim in its own text, as M09-04's Rule C relies on: EV-C02-014 5.2 item 6; the other three through check_claim
-- with p_for_update, or in their own text); the unique index assignment_one_active_claim is the backstop.

-- ready_works (EV-C02-013 2.4 with C-M05; EV-C02-008 1.2 and 5.1 (c) bound 3; B 3.3: "ready is the momentary result of a
-- query"; DM-06): the work items the caller's class may claim now. A read: it changes no table but rejected_attempt,
-- its comment begins devos:read, VOLATILE (DM-36). devos_sinav: always an empty list (bound 3: devos_sinav claims no
-- work item in C02), read from nothing. devos_kurulum: the ready items under the installation's Mission; devos_calisma
-- and devos_denetim: the ready items under any other Mission. Ready is devos_private.ready_value true (only true is
-- ready, B principle 6); an item whose Mission cannot be told installation or not (is_installation_mission NULL) is not
-- listed. Each row: {"id", "work_id" (the same), "revision", "scope", "purpose", "impact_class"} of the item's current
-- revision (C-M05: id beside 2.4's work_id). An input that cannot be read is could_not_check.
create function devos_api.ready_works()
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  v_fn constant text := 'ready_works';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_works jsonb := '[]'::jsonb;
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
      v_reason := 'ready_works admits only the role classes devos_calisma, devos_denetim, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_class <> 'devos_sinav' then
      v_check := 'readiness';
      select coalesce(jsonb_agg(jsonb_build_object('id', c.id, 'work_id', c.id, 'revision', c.revision, 'scope', c.scope,
                                                   'purpose', c.purpose, 'impact_class', c.impact_class::text)
                                order by c.created_at, c.id), '[]'::jsonb)
        into v_works
        from (select w.id, w.created_at, cr.revision, cr.scope, cr.purpose, cr.impact_class, mr.mission_id
                from devos_private.work w
                join lateral (select x.revision, x.scope, x.purpose, x.impact_class, x.mission_revision_id
                                from devos_private.work_revision x
                               where x.work_id = w.id
                               order by x.revision desc
                               limit 1) cr on true
                join devos_private.mission_revision mr on mr.id = cr.mission_revision_id) c
       where devos_private.ready_value(c.id) is true
         and devos_private.is_installation_mission(c.mission_id) = (v_class = 'devos_kurulum');
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
  return jsonb_build_object('status', 'ok', 'works', v_works);
end
$fn$;
comment on function devos_api.ready_works() is
  'devos:read The work items the caller''s role class may claim now (EV-C02-013 section 2.4)';

-- claim (EV-C02-013 2.4 with C-M05; B 3.5, principle 8; DM-01, DM-06, DM-07, DM-31; EV-C02-008 5.1 (c) bound 3): an
-- Assignment and its claim token. Order after the gate: work_id NULL: missing_field; devos_sinav: exam_subject (bound
-- 3, before any read); the work item, locked for update (not_found); its current revision (could_not_check when
-- missing); ownership: devos_kurulum only under the installation's Mission, devos_calisma and devos_denetim only under
-- another (not_owner; a Mission whose creation event cannot be read: could_not_check); the work item's claims, locked
-- for update: one without its status or generation, or an active one without its lease, could_not_check (partial); an
-- active claim whose lease has not run out: already_claimed; readiness (devos_private.ready_value): false not_ready,
-- NULL could_not_check (C-M05); the global authority epoch, for share (missing: could_not_check). Writes: each active
-- claim of the work item whose lease has run out set expired, with claim_expired (origin rule, the caller's class;
-- DM-06, DM-31); the new Assignment (the next generation, the current revision, the global epoch, lease now() + 30
-- minutes, the caller's role class, the declared session as declared, the token's hash only) and claimed. Answer
-- {"status": "ok", "id", "assignment_id" (the same), "claim_token", "generation", "lease_expires_at"}. No exact repeat:
-- a second claim is refused already_claimed. devos_calisma, devos_denetim, devos_sinav, devos_kurulum at the gate.
create function devos_api.claim(work_id uuid, declared_session_id text default null)
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
    select count(*) filter (where a.status is null or a.generation is null
                              or (a.status = 'active' and a.lease_expires_at is null)),
           count(*) filter (where a.status = 'active' and a.lease_expires_at > now()),
           max(a.generation)
      into v_partial, v_live, v_newest
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

    -- (f) The global authority epoch, for share, last in DM-01's order: the epoch the claim is made in.
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
    -- DM-06: the claim that next takes the work item marks a lapsed claim expired, with its event (origin rule).
    for v_old in update devos_private.assignment a set status = 'expired'
                  where a.work_ref = p_work and a.status = 'active' and a.lease_expires_at <= now()
                  returning a.id, a.generation, a.lease_expires_at loop
      perform devos_private.write_event('assignment', v_old.id, null, 'claim_expired',
        jsonb_build_object('work_ref', p_work, 'generation', v_old.generation, 'status', 'expired',
                           'lease_expires_at', v_old.lease_expires_at),
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

-- heartbeat (EV-C02-013 2.4; B 3.5; DM-07; EV-C02-003 4.3, S8 line 2): the claim check (devos_private.check_claim, the
-- work item and the claim for update): the claim the token names must be active, on a work item not cancelled, its
-- lease not run out, of the work item's newest generation, of the current global authority epoch and of the caller's
-- role class; then its lease is extended to now() + 30 minutes and heartbeat is written. Answer {"status": "ok", "id"
-- (the Assignment), "lease_expires_at"}. No exact repeat: each extends from its own time. devos_calisma,
-- devos_denetim, devos_sinav, devos_kurulum at the gate (as claim).
create function devos_api.heartbeat(claim_token text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_token alias for $1;
  v_fn constant text := 'heartbeat';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_claim jsonb;
  v_id uuid;
  v_work uuid;
  v_lease timestamptz;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;

  -- The read block: steps (b) and (e).
  begin
    if not (v_class = any (array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'heartbeat admits only the role classes devos_calisma, devos_denetim, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    -- (e) The claim check, the work item and the claim locked for update (DM-01).
    v_check := 'claim';
    v_claim := devos_private.check_claim(p_token, null, v_class, true);
    if v_claim ->> 'status' is distinct from 'ok' then
      v_code := coalesce(v_claim ->> 'reason_code', 'could_not_check');
      v_reason := coalesce(v_claim ->> 'reason', 'claim: the claim check gave no answer');
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_id := (v_claim ->> 'assignment_id')::uuid;
    v_work := (v_claim ->> 'work_id')::uuid;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  v_claim := null;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason);
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    v_lease := now() + interval '30 minutes';
    update devos_private.assignment a set lease_expires_at = v_lease, last_heartbeat_at = now() where a.id = v_id;
    perform devos_private.write_event('assignment', v_id, null, 'heartbeat',
      jsonb_build_object('work_ref', v_work, 'lease_expires_at', v_lease), v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id, 'lease_expires_at', v_lease);
end
$fn$;

-- release (EV-C02-013 2.4; B 3.5; DM-01, DM-07; EV-C02-003 4.3, S8 line 2): the claim check as heartbeat's (the work
-- item and the claim for update); then the claim's status released and released written; the work item can be claimed
-- at once under a new generation. A released claim fails the check (claim_not_active), so a second identical call is
-- refused, writing nothing (EV-C02-013 section 1 item 10). Answer {"status": "ok", "id"}. Roles as claim.
create function devos_api.release(claim_token text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_token alias for $1;
  v_fn constant text := 'release';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_claim jsonb;
  v_id uuid;
  v_work uuid;
  v_generation integer;
begin
  -- (a) The derivation.
  v_class := devos_private.caller_role_class(v_fn);
  if v_class is null then
    return jsonb_build_object('status', 'refused',
                              'reason_code', coalesce(current_setting('devos.reason_code', true), 'could_not_check'),
                              'reason', coalesce(current_setting('devos.reason', true), 'the derivation gave no reason'));
  end if;

  -- The read block: steps (b) and (e).
  begin
    if not (v_class = any (array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'release admits only the role classes devos_calisma, devos_denetim, devos_sinav and devos_kurulum';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    -- (e) The claim check, the work item and the claim locked for update (DM-01: release locks the work item).
    v_check := 'claim';
    v_claim := devos_private.check_claim(p_token, null, v_class, true);
    if v_claim ->> 'status' is distinct from 'ok' then
      v_code := coalesce(v_claim ->> 'reason_code', 'could_not_check');
      v_reason := coalesce(v_claim ->> 'reason', 'claim: the claim check gave no answer');
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_id := (v_claim ->> 'assignment_id')::uuid;
    v_work := (v_claim ->> 'work_id')::uuid;
    v_generation := (v_claim ->> 'generation')::integer;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  v_claim := null;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason);
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    update devos_private.assignment a set status = 'released' where a.id = v_id;
    perform devos_private.write_event('assignment', v_id, null, 'released',
      jsonb_build_object('work_ref', v_work, 'generation', v_generation, 'status', 'released'),
      v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id);
end
$fn$;

-- revoke_claim (EV-C02-013 2.4 with C-M05; B 3.5: "revoke_claim revokes one claim, with its reason; only
-- devos_denetim calls it"; DM-29, DM-01): devos_denetim only. assignment_id NULL, or reason NULL: missing_field. The
-- claim (not_found); its work item locked for update, then the claim for update (DM-01's order); a claim without its
-- status, or an active one without its lease: could_not_check (partial); already revoked: the exact repeat; released,
-- expired, or active with its lease run out (DM-06: a lapsed claim counts as no claim): claim_not_active. Writes the
-- status revoked and claim_revoked (payload with the reason). The work item can be claimed again at once, under a new
-- generation. Refusal rows carry target_ref assignment_id. Answer {"status": "ok", "id"}.
create function devos_api.revoke_claim(assignment_id uuid, reason text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_assignment alias for $1;
  p_reason alias for $2;
  v_fn constant text := 'revoke_claim';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_answer jsonb;
  v_work uuid;
  v_status devos_private.assignment_status;
  v_lease timestamptz;
  v_generation integer;
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
      v_reason := 'revoke_claim admits only the role class devos_denetim (DM-29)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if p_assignment is null then
      v_code := 'missing_field'; v_reason := 'assignment_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if p_reason is null then
      v_code := 'missing_field'; v_reason := 'reason: missing (B 3.5: a claim is revoked with its reason)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The claim, its work item locked for update, then the claim for update (DM-01's order).
    v_check := 'claim';
    select a.work_ref into v_work from devos_private.assignment a where a.id = p_assignment;
    if not found then
      v_code := 'not_found'; v_reason := 'assignment_id: names no claim';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_work is null then
      v_code := 'could_not_check'; v_reason := 'claim: its work item is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    perform 1 from devos_private.work w where w.id = v_work for update;
    if not found then
      v_code := 'could_not_check'; v_reason := 'claim: its work item is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    select a.status, a.lease_expires_at, a.generation into v_status, v_lease, v_generation
      from devos_private.assignment a where a.id = p_assignment for update;
    if not found then
      v_code := 'could_not_check'; v_reason := 'claim: the claim is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_status is null then
      v_code := 'could_not_check'; v_reason := 'claim: its status is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'repeat';
    if v_status = 'revoked' then
      v_answer := jsonb_build_object('status', 'ok', 'id', p_assignment, 'repeat', true);
    elsif v_status <> 'active' then
      v_code := 'claim_not_active'; v_reason := 'the claim is not active (released or expired)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    elsif v_lease is null then
      v_code := 'could_not_check'; v_reason := 'claim: its lease is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    elsif v_lease <= now() then
      v_code := 'claim_not_active'; v_reason := 'the claim is not active (its lease has run out)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_assignment);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    update devos_private.assignment a set status = 'revoked' where a.id = p_assignment;
    perform devos_private.write_event('assignment', p_assignment, null, 'claim_revoked',
      jsonb_build_object('work_ref', v_work, 'generation', v_generation, 'status', 'revoked',
                         'reason', p_reason),
      v_class::text, 'call', null);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_assignment);
  end if;
  return jsonb_build_object('status', 'ok', 'id', p_assignment);
end
$fn$;

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)). PUBLIC's default EXECUTE is revoked from
-- the five functions, and so is any privilege of the four API roles; then EXECUTE is granted to anon, the role a Data
-- API request with the publishable key runs as. Each function checks the token itself. This file adds no type and no
-- devos_private function.
revoke all on function devos_api.ready_works() from public;
revoke all on function devos_api.claim(uuid, text) from public;
revoke all on function devos_api.heartbeat(text) from public;
revoke all on function devos_api.release(text) from public;
revoke all on function devos_api.revoke_claim(uuid, text) from public;
do $$
declare r text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      execute format('revoke all on function devos_api.ready_works() from %I', r);
      execute format('revoke all on function devos_api.claim(uuid, text) from %I', r);
      execute format('revoke all on function devos_api.heartbeat(text) from %I', r);
      execute format('revoke all on function devos_api.release(text) from %I', r);
      execute format('revoke all on function devos_api.revoke_claim(uuid, text) from %I', r);
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.ready_works() to anon;
    grant execute on function devos_api.claim(uuid, text) to anon;
    grant execute on function devos_api.heartbeat(text) to anon;
    grant execute on function devos_api.release(text) to anon;
    grant execute on function devos_api.revoke_claim(uuid, text) to anon;
  end if;
end
$$;
