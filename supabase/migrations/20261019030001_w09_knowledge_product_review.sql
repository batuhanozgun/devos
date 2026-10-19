-- DevOS schema (W-C02-09), not a fixture. M09-07: knowledge, product and review.
-- Sources: plan/work/W-C02-09.md points 1, 2, 3, 4, 5, 7 and 8; Appendix B principles 2, 3, 4, 8 and 12, section 2,
-- 3.8, 3.10, 3.11, 3.13 and section 4 (rows "Knowledge", "Product" and "Review"); evidence/C02/EV-C02-013_w09_interface.md
-- sections 1 (items 1 to 14), 2.6 with R1-7 and R2-1, 10 and 20 (C-M07); EV-C02-008 1.2 (review_finding), 2.2
-- (condition 2) and 5.2 (a); EV-C02-002 DM-19, DM-25, DM-26, DM-31, DM-36; EV-C02-003 section 4.2. Record:
-- evidence/C02/EV-C02-014_w09_build.md section 8.
-- It holds exactly section 10's row M09-07, the seven functions of EV-C02-013 section 2.6: devos_api.record_finding,
-- review_finding, register_artifact, open_review, record_verdict, accept and read_review. It adds no table, type or
-- private function, and changes nothing of M09-01 to M09-06, whose helpers it calls: caller_role_class, write_event,
-- reject, scope_within, check_claim and ready_value. No token, hash or key value is written here.
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12).
--
-- The common form is M09-03's to M09-06's (EV-C02-013 section 1 items 6, 7, 9 and 10, R1-1): (a) the derivation,
-- before any other check; then a read block holding (b) the role list, a literal of the function's own text (B:48),
-- (c) the input's form, (e) the claim, for register_artifact, and (f) the family's rules, writing nothing (its row
-- locks stay with the transaction); then a write block holding (g) the writes and their events through
-- devos_private.write_event, with the caller's role class. A check that decides a refusal sets v_code and v_reason and
-- raises P0D01; any other error in the read block is could_not_check, "<v_check>: its input could not be read (SQLSTATE
-- <code>)"; any error in the write block is write_failed, but P0D02, which is could_not_check with its fixed reason.
-- After either block's refusal one per-call RejectedAttempt row is written by devos_private.reject. A reason holds fixed
-- text and an SQLSTATE only. Keys a function does not read are ignored (item 4). Parameters keep the names of
-- EV-C02-013 2.6 and README 8.1 (named calls), and the bodies read them through ALIAS FOR $n, never qualified by the
-- function's name (N-288), so that a merged break patch that renames a function and wraps it leaves the renamed body
-- working.
--
-- A reference these functions must read (a review's target and basis, a verdict's criterion) names a record of one of
-- the families M09-06's relate looks up: Work, Mission, Decision, Finding and Artifact (with revisions), Need,
-- Relation, EffortPolicy, Assignment, Review, Verdict, Acceptance, Operation and Observation (without). One that names
-- no record of these, a revisioned record sent without its revision, a revision it does not have, or a revision sent
-- for a record without revisions, is could_not_check (EV-C02-013 section 1 item 14 with R1-2). None of the seven reads
-- the exam table: no function here admits devos_sinav but read_review, which reads no exam record, so for every class
-- an exam record is a record these functions cannot find (EV-C02-008 5.1 (c) bound 1). Open samples (EV-C02-008 5.2):
-- C02's schema cannot yet tell an open block from a complete one, so read_review withholds every sample Review from
-- every class but devos_denetim until W-C02-10's sampling gives the block's state (C-M07).

-- record_finding (EV-C02-013 2.6 and C-M07; B 3.8, principles 10 and 12; DM-25, DM-26): a Finding, its revision 1 and
-- finding_recorded. Payload: claim, scope, counter_evidence_searched, changeable (yes or no), epistemic_status and
-- current_authority required; source_type (null allowed, N-278 (5)), source_spans (each an object with primary, a
-- boolean, and read_at, a date, when the span is dated), qualifiers, confidence, open_questions, fresh_until (a date),
-- agent_addressed (an array; absent: not assessed), privacy_class (default private_derived), use_scope, status (only
-- candidate). not_recorded, in counter_evidence_searched or changeable, is admitted only on a record the ledger
-- transfer writes (B 3.8; EV-C02-005 S4): invalid_field here. Whether a filled field is meaningful is W-C02-10's format
-- gate (principle 12), not refused here except when absent. devos_calisma, devos_kurulum (EV-C02-003 section 4.1).
-- Answer {"status": "ok", "id", "revision": 1}.
create function devos_api.record_finding(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'record_finding';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_scope text;
  v_changeable devos_private.finding_changeable;
  v_estatus devos_private.epistemic_status;
  v_cauth devos_private.current_authority;
  v_stype devos_private.source_type;
  v_privacy devos_private.privacy_class := 'private_derived';
  v_spans jsonb := '[]'::jsonb;
  v_span jsonb;
  v_i integer;
  v_date date;
  v_fresh date;
  v_agent jsonb;
  v_qual jsonb;
  v_open jsonb;
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
      v_reason := 'record_finding admits only the role classes devos_calisma and devos_kurulum';
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
    foreach v_key in array array['claim', 'scope', 'counter_evidence_searched', 'changeable', 'epistemic_status',
                                 'current_authority'] loop
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
    v_scope := p_in ->> 'scope';
    if (p_in ->> 'counter_evidence_searched') = 'not_recorded' then
      v_code := 'invalid_field';
      v_reason := 'counter_evidence_searched: not_recorded is admitted only on a record the ledger transfer writes (B 3.8)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if (p_in ->> 'changeable') not in ('yes', 'no') then
      v_code := 'invalid_field';
      v_reason := 'changeable: not yes or no (not_recorded is admitted only on a record the ledger transfer writes, B 3.8)';
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
    v_cauth := (p_in ->> 'current_authority')::devos_private.current_authority;
    if coalesce(jsonb_typeof(p_in -> 'source_type'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'source_type') <> 'string'
         or (p_in ->> 'source_type') not in ('foundation', 'candidate_study', 'context', 'exploration', 'historical_record',
                                             'archived_report', 'legacy_repo') then
        v_code := 'invalid_field'; v_reason := 'source_type: not one of Appendix B 3.8''s source types';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_stype := (p_in ->> 'source_type')::devos_private.source_type;
    end if;
    -- source_spans: each entry carries whether its source is primary and, when dated, the date it was read (DM-26 (a)).
    if coalesce(jsonb_typeof(p_in -> 'source_spans'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'source_spans') <> 'array' then
        v_code := 'invalid_field'; v_reason := 'source_spans: not an array';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_spans := p_in -> 'source_spans';
      for v_i in 0 .. jsonb_array_length(v_spans) - 1 loop
        v_span := v_spans -> v_i;
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
    v_qual := nullif(p_in -> 'qualifiers', 'null'::jsonb);
    v_open := nullif(p_in -> 'open_questions', 'null'::jsonb);
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
    -- agent_addressed: absent (null) when not assessed, an array (empty when none was found) when assessed (DM-12).
    if coalesce(jsonb_typeof(p_in -> 'agent_addressed'), 'null') not in ('null', 'array') then
      v_code := 'invalid_field'; v_reason := 'agent_addressed: not an array';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_agent := nullif(p_in -> 'agent_addressed', 'null'::jsonb);
    if coalesce(jsonb_typeof(p_in -> 'privacy_class'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'privacy_class') <> 'string'
         or (p_in ->> 'privacy_class') not in ('private_derived', 'public', 'private') then
        v_code := 'invalid_field'; v_reason := 'privacy_class: not private_derived, public or private';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_privacy := (p_in ->> 'privacy_class')::devos_private.privacy_class;
    end if;
    if coalesce(jsonb_typeof(p_in -> 'status'), 'null') <> 'null'
       and (jsonb_typeof(p_in -> 'status') <> 'string' or (p_in ->> 'status') <> 'candidate') then
      v_code := 'invalid_field';
      v_reason := 'status: a finding is recorded as candidate; review_finding moves it (EV-C02-008 1.2)';
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
    v_id := pg_catalog.gen_random_uuid();
    insert into devos_private.finding (id, status, scope, privacy_class)
    values (v_id, 'candidate', v_scope, v_privacy);
    insert into devos_private.finding_revision (finding_id, revision, claim, source_spans, qualifiers,
                                                counter_evidence_searched, confidence, open_questions, changeable,
                                                fresh_until, agent_addressed, use_scope, source_type, epistemic_status,
                                                current_authority)
    values (v_id, 1, p_in ->> 'claim', v_spans, v_qual, p_in ->> 'counter_evidence_searched', p_in ->> 'confidence',
            v_open, v_changeable, v_fresh, v_agent, p_in ->> 'use_scope', v_stype, v_estatus, v_cauth);
    -- The payload: the record's fields, its keys without a value left out (the values themselves kept as sent).
    perform devos_private.write_event('finding', v_id, 1, 'finding_recorded',
      (select coalesce(jsonb_object_agg(e.key, e.value), '{}'::jsonb)
         from jsonb_each(jsonb_build_object('claim', p_in ->> 'claim', 'scope', v_scope, 'status', 'candidate',
        'privacy_class', v_privacy::text, 'source_spans', v_spans, 'qualifiers', v_qual,
        'counter_evidence_searched', p_in ->> 'counter_evidence_searched', 'confidence', p_in ->> 'confidence',
        'open_questions', v_open, 'changeable', v_changeable::text, 'fresh_until', v_fresh,
        'agent_addressed', v_agent, 'use_scope', p_in ->> 'use_scope', 'source_type', v_stype::text,
        'epistemic_status', v_estatus::text, 'current_authority', v_cauth::text)) e
        where jsonb_typeof(e.value) <> 'null'),
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

-- review_finding (EV-C02-013 2.6 and C-M07; B 3.8; EV-C02-008 1.2; DM-26; Appendix C N09): a Finding's status moved to
-- reviewed, accepted_for_use or stale, with finding_reviewed. Order after the gate: an argument NULL: missing_field; a
-- status other than the three (the writer's withdrawn among them, EV-C02-008 section 4 item 2): invalid_field; the
-- Finding locked for update (not_found; its status or current revision missing: could_not_check); revision not its
-- current revision: stale_revision; the same status: the exact repeat, ok with "repeat": true; a move to reviewed or
-- accepted_for_use of a finding whose counter_evidence_searched or changeable holds not_recorded: invalid_field (B 3.8:
-- "until a review enters both"); N09 for a move to accepted_for_use of a finding whose changeable is yes: at least one
-- primary span, and every primary span dated by its read_at, else invalid_field; a span without its primary marker, or a
-- read_at that is not a date: could_not_check (partial). It reads the spans' markers and reading dates, never
-- fresh_until (B 3.8: "Until C04 this reads changeable and its source spans' primary or secondary marker and reading
-- date"; DM-26 (b); C-M07). devos_denetim only (EV-C02-008 1.2). Answer {"status": "ok", "id"}.
create function devos_api.review_finding(finding_id uuid, revision integer, status text)
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

-- register_artifact (EV-C02-013 2.6 with R2-1 and C-M07; B 3.10, principles 3, 4 and 8; Appendix C F05, F08; DM-06):
-- an Artifact, its revision 1 and artifact_registered, under the claim of the work item it is made on. Payload:
-- work_ref, work_revision, path, kind and scope required; commit (40 or 64 lower-case hexadecimal characters), status
-- (candidate, current or superseded; default candidate). Order after the gate: the form (work_revision absent or JSON
-- null: could_not_check, a reference sent without its revision, R2-1); the claim through devos_private.check_claim with
-- the work item (claim_missing, claim_unknown also for a work_ref that is not the claim's work item, claim_not_active,
-- claim_expired, claim_generation, claim_epoch, claim_class; the work item and the claim locked for share, DM-01);
-- work_revision naming no revision of the work item: could_not_check; an earlier one: stale_revision, compared with the
-- work item's current revision read under that lock (F08-w; R2-1); the work item's readiness re-checked at the effect
-- through devos_private.ready_value with the caller's own claim left out (F08 (a); EV-C02-014 3.5 item 4): false is
-- not_ready, NULL could_not_check; the artifact's scope not within the work item's: scope_outside (F05). The tie to the
-- work item is the event's payload (R2-1: work_ref, work_revision, assignment_id, generation); never the claim token
-- or its hash. The path-table refusal under a routine item is W-C02-10's. devos_calisma, devos_kurulum (EV-C02-003
-- section 4.1; B section 2: devos_denetim and devos_sinav write no products). Answer {"status": "ok", "id", "revision": 1}.
create function devos_api.register_artifact(claim_token text, p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_token alias for $1;
  p_in alias for $2;
  v_fn constant text := 'register_artifact';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_work uuid;
  v_wrev integer;
  v_scope text;
  v_commit text;
  v_status devos_private.artifact_status := 'candidate';
  v_claim jsonb;
  v_assignment uuid;
  v_generation integer;
  v_cur integer;
  v_wscope text;
  v_ready boolean;
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
      v_reason := 'register_artifact admits only the role classes devos_calisma and devos_kurulum';
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
    foreach v_key in array array['path', 'kind', 'scope'] loop
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
    v_scope := p_in ->> 'scope';
    if coalesce(jsonb_typeof(p_in -> 'commit'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'commit') <> 'string' or (p_in ->> 'commit') !~ '^[0-9a-f]{40}([0-9a-f]{24})?$' then
        v_code := 'invalid_field'; v_reason := 'commit: not 40 or 64 lower-case hexadecimal characters';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_commit := p_in ->> 'commit';
    end if;
    if coalesce(jsonb_typeof(p_in -> 'status'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'status') <> 'string' or (p_in ->> 'status') not in ('candidate', 'current', 'superseded') then
        v_code := 'invalid_field'; v_reason := 'status: not candidate, current or superseded';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_status := (p_in ->> 'status')::devos_private.artifact_status;
    end if;

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
    v_claim := null;

    -- (f) The work item's revision at the effect (R2-1; F08-w), read under check_claim's lock on the work item.
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

    -- (f) The work item still ready at the moment of the effect (F08 (a)), the caller's own claim left out.
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

    -- (f) The scope of the target and of the work item (B principle 4; F05).
    v_check := 'scope';
    select r.scope into v_wscope from devos_private.work_revision r where r.work_id = v_work and r.revision = v_cur;
    if v_wscope is null then
      v_code := 'could_not_check'; v_reason := 'scope: the work item''s scope is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if not coalesce(devos_private.scope_within(v_scope, v_wscope), false) then
      v_code := 'scope_outside'; v_reason := 'scope: the artifact''s scope does not lie within the work item''s (B principle 4)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
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

  -- The write block: step (g).
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    insert into devos_private.artifact (id, status, scope) values (v_id, v_status, v_scope);
    insert into devos_private.artifact_revision (artifact_id, revision, path, commit, kind)
    values (v_id, 1, p_in ->> 'path', v_commit, p_in ->> 'kind');
    perform devos_private.write_event('artifact', v_id, 1, 'artifact_registered',
      jsonb_strip_nulls(jsonb_build_object('path', p_in ->> 'path', 'commit', v_commit, 'kind', p_in ->> 'kind',
        'scope', v_scope, 'status', v_status::text, 'work_ref', v_work, 'work_revision', v_wrev,
        'assignment_id', v_assignment, 'generation', v_generation)),
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
  return jsonb_build_object('status', 'ok', 'id', v_id, 'revision', 1);
end
$fn$;

-- open_review (EV-C02-013 2.6 with R1-7 and C-M07; B 3.11 and section 4's Review row; EV-C02-008 2.2 condition 2):
-- a Review of kind review and review_opened. Payload: kind (review only; sample: kind_not_allowed, from every token,
-- since only the database opens a sample), target_ref, use, basis_refs (non-empty; each {"ref": <uuid>, "revision":
-- <integer>}, a revision the review rests on, B 3.11) and independence_level (B 3.11's six levels) required;
-- target_revision, target_snapshot, claim, criterion (written to criterion_ref, R1-7) with criterion_version, view_ref,
-- shared_with_producer. reviewer_role_class is the token's class; reviewer_declared_session is declared_session_id, as
-- declared (B principle 8). Order after the form: the target, a record of the families above, with the revision it
-- needs (could_not_check otherwise), its identity row locked for share; a revisioned target named at a revision that is
-- not its current one: stale_revision (a work item's, or any record's, revision checked at the review; C-M07); each
-- basis entry a record with the revision it needs (could_not_check otherwise). DM-41's trigger and the sample's own
-- rules are W-C02-10's. devos_denetim only (B section 4: "Only devos_denetim"). Answer {"status": "ok", "id"}.
create function devos_api.open_review(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'open_review';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_target uuid;
  v_trev integer;
  v_cver text;
  v_basis jsonb;
  v_entry jsonb;
  v_level devos_private.independence_level;
  v_shared jsonb;
  v_items jsonb;
  v_item jsonb;
  v_name text;
  v_ref uuid;
  v_rev integer;
  v_fam text;
  v_ok boolean;
  v_cur integer;
  v_i integer;
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
    if not (v_class = any (array['devos_denetim']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'open_review admits only the role class devos_denetim';
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
    foreach v_key in array array['target_ref', 'use', 'independence_level'] loop
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
    if coalesce(jsonb_typeof(p_in -> 'target_revision'), 'null') <> 'null' then
      if jsonb_typeof(p_in -> 'target_revision') <> 'number' or (p_in ->> 'target_revision') !~ '^[1-9][0-9]{0,8}$' then
        v_code := 'invalid_field'; v_reason := 'target_revision: not an integer of at least 1';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_trev := (p_in ->> 'target_revision')::integer;
    end if;
    foreach v_key in array array['target_snapshot', 'claim', 'criterion', 'view_ref'] loop
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
    if (p_in ->> 'independence_level') not in ('same_session', 'fresh_context_subagent', 'same_model_other_session',
                                               'other_view', 'other_model_family', 'batu_expert') then
      v_code := 'invalid_field'; v_reason := 'independence_level: not one of Appendix B 3.11''s six levels';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_level := (p_in ->> 'independence_level')::devos_private.independence_level;
    v_shared := nullif(p_in -> 'shared_with_producer', 'null'::jsonb);
    -- basis_refs (B section 4: mandatory; B 3.11: the revisions the verdict rests on).
    if coalesce(jsonb_typeof(p_in -> 'basis_refs'), 'null') = 'null' then
      v_code := 'missing_field'; v_reason := 'basis_refs: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if jsonb_typeof(p_in -> 'basis_refs') <> 'array' then
      v_code := 'invalid_field'; v_reason := 'basis_refs: not an array';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_basis := p_in -> 'basis_refs';
    if jsonb_array_length(v_basis) = 0 then
      v_code := 'missing_field'; v_reason := 'basis_refs: empty (a review''s basis is mandatory)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_items := jsonb_build_array(jsonb_strip_nulls(jsonb_build_object('name', 'target_ref', 'ref', v_target,
                                                                      'revision', v_trev)));
    for v_i in 0 .. jsonb_array_length(v_basis) - 1 loop
      v_entry := v_basis -> v_i;
      if jsonb_typeof(v_entry) <> 'object' or coalesce(jsonb_typeof(v_entry -> 'ref'), 'null') <> 'string'
         or (v_entry ->> 'ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
         or (coalesce(jsonb_typeof(v_entry -> 'revision'), 'null') <> 'null'
             and (jsonb_typeof(v_entry -> 'revision') <> 'number' or (v_entry ->> 'revision') !~ '^[1-9][0-9]{0,8}$')) then
        v_code := 'invalid_field';
        v_reason := 'basis_refs: each entry is {"ref": <uuid>, "revision": <integer>} (the revision for a record with revisions)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_items := v_items || jsonb_build_array(jsonb_strip_nulls(jsonb_build_object('name', 'basis_refs',
                   'ref', (v_entry ->> 'ref')::uuid,
                   'revision', case when jsonb_typeof(v_entry -> 'revision') = 'number'
                                    then (v_entry ->> 'revision')::integer end)));
    end loop;

    -- (f) The target and the basis: each a record with the revision it needs (R1-2).
    for v_i in 0 .. jsonb_array_length(v_items) - 1 loop
      v_item := v_items -> v_i;
      v_name := v_item ->> 'name';
      v_check := v_name;
      v_ref := (v_item ->> 'ref')::uuid;
      v_rev := (v_item ->> 'revision')::integer;
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
      v_ok := case
        when v_fam is null then false
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
        v_code := 'could_not_check';
        v_reason := case when v_name = 'target_ref' then 'target_ref: the record could not be read'
                         else 'basis_refs: a record could not be read' end;
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_name = 'target_ref' and v_fam in ('work', 'mission', 'decision', 'finding', 'artifact') then
        -- The target's identity row for share, then its current revision: a review names the revision it judges, and
        -- that revision must be the current one when the review opens (C-M07).
        if v_fam = 'work' then
          perform 1 from devos_private.work x where x.id = v_ref for share;
          select max(x.revision) into v_cur from devos_private.work_revision x where x.work_id = v_ref;
        elsif v_fam = 'mission' then
          perform 1 from devos_private.mission x where x.id = v_ref for share;
          select max(x.revision) into v_cur from devos_private.mission_revision x where x.mission_id = v_ref;
        elsif v_fam = 'decision' then
          perform 1 from devos_private.decision x where x.id = v_ref for share;
          select max(x.revision) into v_cur from devos_private.decision_revision x where x.decision_id = v_ref;
        elsif v_fam = 'finding' then
          perform 1 from devos_private.finding x where x.id = v_ref for share;
          select max(x.revision) into v_cur from devos_private.finding_revision x where x.finding_id = v_ref;
        else
          perform 1 from devos_private.artifact x where x.id = v_ref for share;
          select max(x.revision) into v_cur from devos_private.artifact_revision x where x.artifact_id = v_ref;
        end if;
        if v_cur is null then
          v_code := 'could_not_check'; v_reason := 'target_ref: the record could not be read';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_rev <> v_cur then
          v_code := 'stale_revision'; v_reason := 'target_revision: not the target''s current revision';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
    end loop;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_target, v_trev);
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    insert into devos_private.review (id, kind, target_ref, target_revision, target_snapshot, claim, criterion_ref,
                                      criterion_version, use, basis_refs, reviewer_declared_session,
                                      reviewer_role_class, independence_level, view_ref, shared_with_producer)
    values (v_id, 'review', v_target, v_trev, p_in ->> 'target_snapshot', p_in ->> 'claim', p_in ->> 'criterion',
            v_cver, p_in ->> 'use', v_basis, v_decl, v_class, v_level, p_in ->> 'view_ref', v_shared);
    perform devos_private.write_event('review', v_id, null, 'review_opened',
      (select coalesce(jsonb_object_agg(e.key, e.value), '{}'::jsonb)
         from jsonb_each(jsonb_build_object('kind', 'review', 'target_ref', v_target, 'target_revision', v_trev,
        'target_snapshot', p_in ->> 'target_snapshot', 'claim', p_in ->> 'claim', 'criterion', p_in ->> 'criterion',
        'criterion_version', v_cver, 'use', p_in ->> 'use', 'basis_refs', v_basis,
        'reviewer_role_class', v_class::text, 'independence_level', v_level::text, 'view_ref', p_in ->> 'view_ref',
        'shared_with_producer', v_shared)) e
        where jsonb_typeof(e.value) <> 'null'),
      v_class::text, 'call', v_decl);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_target, v_trev);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id);
end
$fn$;

-- record_verdict (EV-C02-013 2.6 and C-M07; B 3.11): a Verdict on a Review and verdict_recorded. Payload: review_ref
-- and result (pass, fail, conditional or indeterminate) required; evidence_refs, objections and limits, each an array
-- (default []). review_ref naming no Review: not_found, the id of the record the call acts on (2.6's row). A Review may
-- hold several verdicts (B 3.11: an indeterminate one leaves the review open). DM-41's trigger and the open sample's
-- withholding are W-C02-10's. devos_denetim only (B section 4's Review row; B 3.11: "Binding verdicts ... are written
-- only with the devos_denetim role"). Answer {"status": "ok", "id"}.
create function devos_api.record_verdict(p jsonb)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_in alias for $1;
  v_fn constant text := 'record_verdict';
  v_class devos_private.role_class;
  v_decl text;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_key text;
  v_review uuid;
  v_result devos_private.verdict_result;
  v_lists jsonb := '{}'::jsonb;
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
    if not (v_class = any (array['devos_denetim']::devos_private.role_class[])) then
      v_code := 'role_class_not_permitted';
      v_reason := 'record_verdict admits only the role class devos_denetim';
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
    foreach v_key in array array['review_ref', 'result'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_code := 'missing_field'; v_reason := v_key || ': missing';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if jsonb_typeof(p_in -> v_key) <> 'string' then
        v_code := 'invalid_field'; v_reason := v_key || ': not a string';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
    end loop;
    if (p_in ->> 'review_ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_code := 'invalid_field'; v_reason := 'review_ref: not a uuid';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_review := (p_in ->> 'review_ref')::uuid;
    if (p_in ->> 'result') not in ('pass', 'fail', 'conditional', 'indeterminate') then
      v_code := 'invalid_field'; v_reason := 'result: not pass, fail, conditional or indeterminate (B 3.11)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_result := (p_in ->> 'result')::devos_private.verdict_result;
    foreach v_key in array array['evidence_refs', 'objections', 'limits'] loop
      if coalesce(jsonb_typeof(p_in -> v_key), 'null') = 'null' then
        v_lists := v_lists || jsonb_build_object(v_key, '[]'::jsonb);
      elsif jsonb_typeof(p_in -> v_key) <> 'array' then
        v_code := 'invalid_field'; v_reason := v_key || ': not an array';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      else
        v_lists := v_lists || jsonb_build_object(v_key, p_in -> v_key);
      end if;
    end loop;

    -- (f) The Review the verdict is on.
    v_check := 'review';
    perform 1 from devos_private.review r where r.id = v_review for share;
    if not found then
      v_code := 'not_found'; v_reason := 'review_ref: names no Review';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_review);
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    insert into devos_private.verdict (id, review_ref, result, evidence_refs, objections, limits)
    values (v_id, v_review, v_result, v_lists -> 'evidence_refs', v_lists -> 'objections', v_lists -> 'limits');
    perform devos_private.write_event('verdict', v_id, null, 'verdict_recorded',
      jsonb_build_object('review_ref', v_review, 'result', v_result::text, 'evidence_refs', v_lists -> 'evidence_refs',
                         'objections', v_lists -> 'objections', 'limits', v_lists -> 'limits'),
      v_class::text, 'call', v_decl);
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, v_decl, v_review);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id);
end
$fn$;

-- accept (EV-C02-013 2.6 and C-M07; B 3.11, section 2; Appendix C N25 (its C02 part), N04; EV-C02-003 section 4.2): an
-- Acceptance of a verdict's target for one use, accepted, and on a Work target its acceptance set to accepted with
-- acceptance_set. Order after the gate: an argument NULL: missing_field; the Verdict (not_found; its result or Review
-- missing: could_not_check); result fail or indeterminate: verdict_failed; its Review (missing: could_not_check); the
-- Review not the audit environment's (reviewer_role_class other than devos_denetim, as the ledger transfer's copies
-- are, which count as no audit verdict: verdict_missing; NULL: could_not_check); the staleness of the verdict (B 3.11:
-- "When basis_refs, criterion or use changes, the verdict goes stale"; N25), each invalid_field: accepted_use not the
-- Review's use; the target (its identity row locked for update; not a record, or a revision it does not have:
-- could_not_check) at a revision other than its current one; a basis entry at a revision other than its record's current
-- one (an entry that names no record, or a malformed or empty basis: could_not_check); a criterion that names a
-- revisioned record at a version other than its current revision (one that is no DevOS record is not compared, a
-- residual); a target whose family has no scope (an Acceptance holds its target's scope): invalid_field; the same
-- verdict and use already accepted for the target: the exact repeat, ok with "repeat": true. The Acceptance's
-- current_evidence names the verdict (B 3.11). devos_denetim only. Answer {"status": "ok", "id"}.
create function devos_api.accept(verdict_ref uuid, accepted_use text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_verdict alias for $1;
  p_use alias for $2;
  v_fn constant text := 'accept';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_answer jsonb;
  v_found boolean;
  v_review uuid;
  v_result devos_private.verdict_result;
  v_kind devos_private.review_kind;
  v_target uuid;
  v_trev integer;
  v_crit text;
  v_cver text;
  v_ruse text;
  v_basis jsonb;
  v_rclass devos_private.role_class;
  v_entry jsonb;
  v_items jsonb;
  v_item jsonb;
  v_name text;
  v_ref uuid;
  v_rev integer;
  v_fam text;
  v_tfam text;
  v_ok boolean;
  v_cur integer;
  v_scope text;
  v_wacc devos_private.work_acceptance;
  v_i integer;
  v_id uuid;
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
      v_reason := 'accept admits only the role class devos_denetim';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (c) The form.
    v_check := 'input';
    if p_verdict is null then
      v_code := 'missing_field'; v_reason := 'verdict_ref: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if p_use is null then
      v_code := 'missing_field'; v_reason := 'accepted_use: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The Verdict and its result.
    v_check := 'verdict';
    select v.review_ref, v.result into v_review, v_result from devos_private.verdict v where v.id = p_verdict;
    v_found := found;
    if not v_found then
      v_code := 'not_found'; v_reason := 'verdict_ref: names no Verdict';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_review is null or v_result is null then
      v_code := 'could_not_check'; v_reason := 'verdict: its Review or its result is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_result in ('fail', 'indeterminate') then
      v_code := 'verdict_failed';
      v_reason := 'the verdict''s result is fail or indeterminate, which accepts nothing (B 3.11)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The Review: an audit verdict's (B section 2: the ledger transfer's copies count as no audit verdict).
    v_check := 'review';
    select r.kind, r.target_ref, r.target_revision, r.criterion_ref, r.criterion_version, r.use, r.basis_refs,
           r.reviewer_role_class
      into v_kind, v_target, v_trev, v_crit, v_cver, v_ruse, v_basis, v_rclass
      from devos_private.review r where r.id = v_review;
    if not found then
      v_code := 'could_not_check'; v_reason := 'review: the verdict''s Review is missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_rclass is null then
      v_code := 'could_not_check'; v_reason := 'review: its reviewer''s role class is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    -- The audit class written in two pieces, so that a merged break patch that widens the role list by rewriting the
    -- quoted class names in this text (B-N04-1) widens the gate alone.
    if v_rclass::text <> ('devos_' || 'denetim') then
      v_code := 'verdict_missing';
      v_reason := 'the verdict''s Review is not the audit environment''s, so it is no audit verdict (B section 2; B 3.11)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;

    -- (f) The verdict's staleness (B 3.11; N25): the use, then the target, the basis and the criterion.
    v_check := 'use';
    if v_ruse is null then
      v_code := 'could_not_check'; v_reason := 'review: its use is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if v_ruse <> p_use then
      v_code := 'invalid_field';
      v_reason := 'accepted_use: not the use the Review was for; a verdict is not carried over to another use (B 3.11)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'target_ref';
    if v_target is null then
      v_code := 'could_not_check'; v_reason := 'target_ref: missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_items := jsonb_build_array(jsonb_strip_nulls(jsonb_build_object('name', 'target_ref', 'ref', v_target,
                                                                      'revision', v_trev)));
    v_check := 'basis_refs';
    if v_basis is null or jsonb_typeof(v_basis) <> 'array' or jsonb_array_length(v_basis) = 0 then
      v_code := 'could_not_check'; v_reason := 'basis_refs: missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    for v_i in 0 .. jsonb_array_length(v_basis) - 1 loop
      v_entry := v_basis -> v_i;
      if jsonb_typeof(v_entry) <> 'object' or coalesce(jsonb_typeof(v_entry -> 'ref'), 'null') <> 'string'
         or (v_entry ->> 'ref') !~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
         or (coalesce(jsonb_typeof(v_entry -> 'revision'), 'null') <> 'null'
             and (jsonb_typeof(v_entry -> 'revision') <> 'number' or (v_entry ->> 'revision') !~ '^[1-9][0-9]{0,8}$')) then
        v_code := 'could_not_check'; v_reason := 'basis_refs: an entry is not {"ref", "revision"} (partial)';
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      v_items := v_items || jsonb_build_array(jsonb_strip_nulls(jsonb_build_object('name', 'basis_refs',
                   'ref', (v_entry ->> 'ref')::uuid,
                   'revision', case when jsonb_typeof(v_entry -> 'revision') = 'number'
                                    then (v_entry ->> 'revision')::integer end)));
    end loop;
    -- A criterion that names a DevOS record is compared at its version; one that is no record's id is not (a residual).
    if v_crit ~* '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' then
      v_items := v_items || jsonb_build_array(jsonb_strip_nulls(jsonb_build_object('name', 'criterion',
                   'ref', v_crit::uuid,
                   'revision', case when v_cver ~ '^[1-9][0-9]{0,8}$' then v_cver::integer end)));
    end if;

    for v_i in 0 .. jsonb_array_length(v_items) - 1 loop
      v_item := v_items -> v_i;
      v_name := v_item ->> 'name';
      v_check := v_name;
      v_ref := (v_item ->> 'ref')::uuid;
      v_rev := (v_item ->> 'revision')::integer;
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
        v_code := 'could_not_check';
        v_reason := case v_name when 'target_ref' then 'target_ref: the record could not be read'
                                when 'criterion' then 'criterion: the record could not be read'
                                else 'basis_refs: a record could not be read' end;
        raise exception using errcode = 'P0D01', message = 'devos refusal';
      end if;
      if v_name = 'target_ref' then
        -- An Acceptance holds its target's scope (acceptance.scope); the target's row is locked before its revision is
        -- read, so that its staleness and the write are decided on one state (DM-01: the work item first).
        if v_fam not in ('work', 'mission', 'finding', 'artifact', 'relation') then
          v_code := 'invalid_field';
          v_reason := 'target_ref: an Acceptance holds its target''s scope, and a record of this family has none';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        v_tfam := v_fam;
        if v_fam = 'work' then
          select w.acceptance into v_wacc from devos_private.work w where w.id = v_ref for update;
          select x.scope into v_scope from devos_private.work_revision x where x.work_id = v_ref
           order by x.revision desc limit 1;
        elsif v_fam = 'mission' then
          perform 1 from devos_private.mission x where x.id = v_ref for update;
          select x.scope into v_scope from devos_private.mission_revision x where x.mission_id = v_ref
           order by x.revision desc limit 1;
        elsif v_fam = 'finding' then
          select x.scope into v_scope from devos_private.finding x where x.id = v_ref for update;
        elsif v_fam = 'artifact' then
          select x.scope into v_scope from devos_private.artifact x where x.id = v_ref for update;
        else
          select x.scope into v_scope from devos_private.relation x where x.id = v_ref for update;
        end if;
        if v_scope is null or (v_fam = 'work' and v_wacc is null) then
          v_code := 'could_not_check'; v_reason := 'target_ref: its scope or state is missing (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
      if v_fam not in ('work', 'mission', 'decision', 'finding', 'artifact') then
        -- A record without revisions: no revision can be named for it (a criterion's version is then not compared).
        if v_rev is not null and v_name <> 'criterion' then
          v_code := 'could_not_check';
          v_reason := v_name || ': a revision is named for a record that has none';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      else
        v_cur := case v_fam
          when 'work' then (select max(x.revision) from devos_private.work_revision x where x.work_id = v_ref)
          when 'mission' then (select max(x.revision) from devos_private.mission_revision x where x.mission_id = v_ref)
          when 'decision' then (select max(x.revision) from devos_private.decision_revision x where x.decision_id = v_ref)
          when 'finding' then (select max(x.revision) from devos_private.finding_revision x where x.finding_id = v_ref)
          else (select max(x.revision) from devos_private.artifact_revision x where x.artifact_id = v_ref)
        end;
        if v_rev is null or v_cur is null or v_rev > v_cur then
          v_code := 'could_not_check';
          v_reason := v_name || ': its revision is missing, or names a revision the record does not have (partial)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
        if v_rev < v_cur then
          v_code := 'invalid_field';
          v_reason := v_name || ': a newer revision exists, so the verdict is stale (B 3.11; N25)';
          raise exception using errcode = 'P0D01', message = 'devos refusal';
        end if;
      end if;
    end loop;

    -- The exact repeat: the same verdict and use already accepted for this target.
    v_check := 'repeat';
    select a.id into v_id
      from devos_private.acceptance a
     where a.target_ref = v_target and a.accepted_use = p_use
       and a.current_evidence @> jsonb_build_array(p_verdict::text)
     order by a.created_at, a.id
     limit 1;
    if v_id is not null then
      v_answer := jsonb_build_object('status', 'ok', 'id', v_id, 'repeat', true);
    end if;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_verdict);
  end if;
  if v_answer is not null then
    return v_answer;
  end if;

  -- The write block: step (g).
  begin
    v_check := 'write';
    v_id := pg_catalog.gen_random_uuid();
    insert into devos_private.acceptance (id, target_ref, target_revision, accepted_use, scope, current_evidence,
                                          residual_decisions)
    values (v_id, v_target, v_trev, p_use, v_scope, jsonb_build_array(p_verdict::text), '[]'::jsonb);
    perform devos_private.write_event('acceptance', v_id, null, 'accepted',
      jsonb_strip_nulls(jsonb_build_object('target_ref', v_target, 'target_revision', v_trev, 'accepted_use', p_use,
        'scope', v_scope, 'current_evidence', jsonb_build_array(p_verdict::text), 'verdict_ref', p_verdict,
        'review_ref', v_review)),
      v_class::text, 'call', null);
    if v_tfam = 'work' and v_wacc <> 'accepted' then
      update devos_private.work w set acceptance = 'accepted' where w.id = v_target;
      perform devos_private.write_event('work', v_target, v_trev, 'acceptance_set',
        jsonb_build_object('acceptance', 'accepted', 'previous_acceptance', v_wacc::text, 'acceptance_id', v_id,
                           'verdict_ref', p_verdict),
        v_class::text, 'call', null);
    end if;
  exception
    when sqlstate 'P0D02' then
      v_code := 'could_not_check'; v_reason := left(sqlerrm, 200);
    when others then
      v_code := 'write_failed'; v_reason := 'the write failed (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_verdict);
  end if;
  return jsonb_build_object('status', 'ok', 'id', v_id);
end
$fn$;

-- read_review (EV-C02-013 2.6 and C-M07; section 4, row R12; B:40; EV-C02-008 1.4 and 5.2 (a)): one Review with its
-- verdicts. review_id NULL: missing_field; an id that names no Review: not_found; a Review whose kind is missing:
-- could_not_check. A Review of kind sample, and so its verdicts, is withheld from every class but devos_denetim with the
-- answer and reason of an id that names no Review (EV-C02-008 5.2 (a): while the sample's block is open; C02's schema
-- cannot yet tell a complete block, so every sample is treated as open until W-C02-10's sampling gives the block's
-- state; C-M07). All six role classes, as a literal. A read: it changes no table but rejected_attempt, it is VOLATILE
-- because it records its refusals (DM-36), and its comment begins devos:read. It has no write block.
-- Answer {"status": "ok", "review": {...the Review's fields}, "verdicts": [...each Verdict's fields]}.
create function devos_api.read_review(review_id uuid)
returns jsonb
language plpgsql
volatile
security definer
set search_path = pg_catalog, pg_temp
as $fn$
declare
  p_review alias for $1;
  v_fn constant text := 'read_review';
  v_class devos_private.role_class;
  v_code text;
  v_reason text;
  v_check text := 'role_list';
  v_row jsonb;
  v_verdicts jsonb;
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
      v_reason := 'read_review admits only the six role classes of Appendix B section 2';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'input';
    if p_review is null then
      v_code := 'missing_field'; v_reason := 'review_id: missing';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'review';
    select to_jsonb(r) into v_row from devos_private.review r where r.id = p_review;
    if v_row is null then
      v_code := 'not_found'; v_reason := 'review_id: names no Review';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    if coalesce(jsonb_typeof(v_row -> 'kind'), 'null') = 'null' then
      v_code := 'could_not_check'; v_reason := 'review: its kind is missing (partial)';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    -- An open sample is answered, for a class but the audit environment's, as an id that names no Review (5.2 (a)).
    if (v_row ->> 'kind') = 'sample' and v_class::text <> ('devos_' || 'denetim') then
      v_row := null;
      v_code := 'not_found'; v_reason := 'review_id: names no Review';
      raise exception using errcode = 'P0D01', message = 'devos refusal';
    end if;
    v_check := 'verdicts';
    select coalesce(jsonb_agg(to_jsonb(v) order by v.created_at, v.id), '[]'::jsonb) into v_verdicts
      from devos_private.verdict v where v.review_ref = p_review;
  exception
    when sqlstate 'P0D01' then null;
    when others then
      v_code := 'could_not_check';
      v_reason := v_check || ': its input could not be read (SQLSTATE ' || sqlstate || ')';
  end;
  if v_code is not null then
    return devos_private.reject(v_fn, v_class, v_code, v_reason, null, p_review);
  end if;
  return jsonb_build_object('status', 'ok', 'review', v_row, 'verdicts', v_verdicts);
end
$fn$;
comment on function devos_api.read_review(uuid) is
  'devos:read One Review with its verdicts; a sample withheld from every class but the audit environment (EV-C02-013 section 2.6; row R12)';

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)). PUBLIC's default EXECUTE is revoked from
-- the seven functions, and so is any privilege of the four API roles; then EXECUTE is granted to anon, the role a Data
-- API request with the publishable key runs as. Each function checks the token itself. This file adds no type and no
-- devos_private function.
revoke all on function devos_api.record_finding(jsonb) from public;
revoke all on function devos_api.review_finding(uuid, integer, text) from public;
revoke all on function devos_api.register_artifact(text, jsonb) from public;
revoke all on function devos_api.open_review(jsonb) from public;
revoke all on function devos_api.record_verdict(jsonb) from public;
revoke all on function devos_api.accept(uuid, text) from public;
revoke all on function devos_api.read_review(uuid) from public;
do $$
declare r text; f text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      foreach f in array array['devos_api.record_finding(jsonb)', 'devos_api.review_finding(uuid, integer, text)',
                               'devos_api.register_artifact(text, jsonb)', 'devos_api.open_review(jsonb)',
                               'devos_api.record_verdict(jsonb)', 'devos_api.accept(uuid, text)',
                               'devos_api.read_review(uuid)'] loop
        execute format('revoke all on function %s from %I', f, r);
      end loop;
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.record_finding(jsonb) to anon;
    grant execute on function devos_api.review_finding(uuid, integer, text) to anon;
    grant execute on function devos_api.register_artifact(text, jsonb) to anon;
    grant execute on function devos_api.open_review(jsonb) to anon;
    grant execute on function devos_api.record_verdict(jsonb) to anon;
    grant execute on function devos_api.accept(uuid, text) to anon;
    grant execute on function devos_api.read_review(uuid) to anon;
  end if;
end
$$;
