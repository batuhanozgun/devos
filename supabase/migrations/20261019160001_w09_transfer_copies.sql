-- DevOS schema (W-C02-09), not a fixture. M09-12: the ledger transfer's verdict and acceptance copies.
-- Sources: plan/work/W-C02-09.md points 1, 2, 3, 5, 7 and 10; Appendix B principles 2, 3 and 8, section 2 (the
-- devos_kurulum row), 3.11 (the ledger transfer's copy of an installation checker verdict), 3.13 ("The ledger
-- transfer's events") and section 4 (the rows "Review" and "Ledger transfer"); evidence/C02/EV-C02-005_ledger_transfer.md
-- sections 2.4, 3.1, 3.2, 12 and 15 (S1, S2, S4, S5); evidence/C02/EV-C02-008_design_addendum_roles_and_samples.md 1.7.1,
-- 1.7.3 and 2.7; evidence/C02/EV-C02-013_w09_interface.md sections 1 (items 1 to 14), 2.3 ("What Rule O reads"), 2.6,
-- 3.1, 3.2 (with R1-10 and R2-2), 4, 10, 12, 25 (C-M10), 26 (C-M11) and 27 (C-M12). Record:
-- evidence/C02/EV-C02-014_w09_build.md section 14.
-- It holds exactly section 10's row M09-12, the last two of the ledger transfer's fourteen functions:
-- devos_api.transfer_review and devos_api.transfer_acceptance. It adds no table, type or private function, and changes
-- nothing of M09-01 to M09-11 or of the rule corrections (20261019080001), whose helpers it calls: caller_role_class,
-- write_event, reject and is_installation_mission. No token, hash or key value is written here. Neither function takes
-- a claim token or counts a claim, and neither names the exam table.
-- Every function: security definer, owner postgres (the migration login), search_path pg_catalog then pg_temp, and
-- every DevOS relation, type and function it names schema-qualified (EV-C02-013 section 1 item 12).
--
-- The common form is M09-10's and M09-11's (EV-C02-013 section 1 items 6, 7, 9 and 10, R1-1): (a) the derivation,
-- before any other check; then a read block holding (b) the role list, the literal array['devos_kurulum'] of the
-- function's own text (B:48; B section 4: "Only devos_kurulum"), (c) the input's form and (f) the group's and the
-- family's rules, writing nothing (its row locks stay with the transaction); then a write block holding (g) the records
-- and their events through devos_private.write_event, with the caller's role class and origin call. A check that
-- decides a refusal sets v_code and v_reason and raises P0D01; any other error in the read block is could_not_check,
-- "<v_check>: its input could not be read (SQLSTATE <code>)"; any error in the write block is write_failed (S2's index
-- event_transferred_key among them), but P0D02, which is could_not_check with its fixed reason. After either block's
-- refusal one per-call RejectedAttempt row is written by devos_private.reject. A reason holds fixed text and an SQLSTATE
-- only. Keys a function does not read are ignored (item 4); declared_session_id goes to the events and the refusal
-- rows only (item 5). Each function takes p jsonb (EV-C02-013 section 3) and reads it through ALIAS FOR $1 (N-288).
--
-- The group's rules, as M09-10 and M09-11 build them (EV-C02-013 3.1, 3.2, 25 (1) and 26 (1)), in this order after the
-- form:
-- * Closing (B:397): neither function is closed by the ledger_handed_over event; both still write after it, until the
--   C03 migration that hands binding review to the audit environment removes them (EV-C02-005 section 12; N-222).
-- * The key (S2; 3.1): a transferred event of the same transfer_source kind and source_id with the same sha256 is the
--   exact repeat, answered ok with the existing id and "repeat": true, nothing written; another sha256 is conflict. It is
--   read before the run rule; S2's index is the backstop in the write block.
-- * The run (3.1 with R1-8): before the hand-over a call names an open run (a transfer_run event of phase begun and none
--   of phase completed for its run_id), else run_not_open; after it a copy names no run, and a run_id present is
--   run_not_open whatever the run's state. The mark then records "run_id": null and "after_handover": true.
-- * Order (3.1; EV-C02-005 3.2): a record the call references that is not yet written is reference_missing.
-- * The mark (3.1): one transferred event per transferred key, on the record's aggregate (the Review for a verdict copy;
--   the Acceptance), with no revision (neither family has revisions), payload {transfer_source (its six validated
--   strings), run_id, lacks}, with declared and source_fields when sent. It is the record's creation event (26 (1)).
-- * Sampling (3.1; EV-C02-008 2.7): neither function is one of the four that draw a sample.

-- transfer_review (EV-C02-013 3.2 and 27 (1); README 8.1; EV-C02-005 2.4; B 3.11's copy rule): the Review copy of an
-- installation checker verdict, its Verdict, and one transferred mark on the Review, payload {transfer_source, run_id,
-- lacks, verdict_id} (and after_handover, declared, source_fields as 3.1 says). Payload: kind (review), transfer_source
-- (S1's six strings, kind verdict), basis_refs (a non-empty array, kept as sent), reviewer_declared_session (a string),
-- independence_level (fresh_context_subagent), use (a string), verdict (an object: result pass, fail, conditional or
-- indeterminate, required; objections, evidence_refs and limits, arrays, default []), all required; claim, criterion
-- (strings), criterion_version (a string or a number), target_ref (a uuid string) with target_revision (an integer of at
-- least 1, only with target_ref), run_id (before the hand-over an open run; after it none), declared and source_fields
-- (objects). reviewer_role_class is the token's (B 3.11); a key of that name in the call is not read. Order after the
-- gate: kind (absent missing_field; sample kind_not_allowed, before any other key, EV-C02-008 2.2 condition 2; another
-- value invalid_field); the rest of the form; the key (repeat or conflict); the run; target_ref, when sent: a record
-- of M09-06's fourteen families, else reference_missing; a target_revision for a record without revisions
-- invalid_field; one the record does not have reference_missing. The target's family, scope and staleness are not
-- judged (3.2's row). lacks lists target_ref when none is sent (B 3.11: a verdict whose source names no commit "is
-- listed by the transfer"). Answer {"status": "ok", "id" (the Review), "verdict_id"}.
create function devos_api.transfer_review(p jsonb)
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
    v_after := exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over');

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
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

-- transfer_acceptance (EV-C02-013 3.2 with R1-10, R2-2 and 27 (2); README 8.1; EV-C02-005 2.4; B 3.11's copy rule):
-- the Acceptance copy of an installation acceptance, its transferred mark, and in the same transaction its target's
-- state with acceptance_set: a Work's acceptance to accepted, a Decision's status to accepted from answered (an already
-- accepted target is left as it is, with no event). Payload: target_ref (a uuid string), review_ref (a uuid string),
-- accepted_use (installation_acceptance), scope (installation), current_evidence (an array: a uuid string names a
-- record, an object {"event_id": <integer>} names an Event), transfer_source (S1's six strings, kind acceptance), all
-- required; target_revision (an integer of at least 1), residual_decisions (an array, default []), run_id (before the
-- hand-over an open run; after it none), declared and source_fields (objects). Order after the gate: the form; the key
-- (repeat or conflict); the run; the Review copy: a Review with a transferred creation event (no Review of that id, or
-- one whose creation event is another, verdict_missing; no creation event, or one of NULL type, could_not_check), its
-- Verdicts (none: could_not_check; one fail or indeterminate: verdict_failed), its use (another than accepted_use:
-- invalid_field, B 3.11); current_evidence: it names the Review copy (B 3.11, else invalid_field), each uuid a record
-- of M09-06's fourteen families and each event_id an Event (else reference_missing), and for a conditional verdict an
-- entry names a ledger_entry event (else conditions_not_recorded); the installation's Mission (none: reference_missing;
-- two, or one that cannot be told: could_not_check) and its current revision's owner_authority (NULL: could_not_check),
-- D-010's Decision by construction (R1-9); the target: no record reference_missing, a family other than Work or
-- Decision invalid_field; target_revision a revision not written reference_missing, an earlier one stale_revision;
-- ownership (R2-2): a Work under the installation's Mission by Rule O's devos_kurulum clause, read as 2.3 reads it (a
-- Mission that cannot be told: could_not_check; another: not_owner); a Decision whose creation event (its first event,
-- decision_opened or transferred) is of class devos_kurulum (missing or partial: could_not_check; another class:
-- not_owner); then a Decision's status answered or accepted (else invalid_field) and B 3.17's open_exploration rule. The
-- Review copy's target is not compared with target_ref (N-279 (18); EV-C02-005 2.4 maps the copy's target to the tree).
-- lacks lists ledger_entry when current_evidence names no ledger_entry event (EV-C02-005 2.4: such an Acceptance names
-- the verdicts only and is listed by the transfer). Answer {"status": "ok", "id"}.
create function devos_api.transfer_acceptance(p jsonb)
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
    v_after := exists (select 1 from devos_private.event e where e.event_type = 'ledger_handed_over');

    -- The key (S2): the exact repeat, or conflict.
    v_check := 'key';
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

-- Grants (EV-C02-013 section 1 item 13; T-W08-PRIV's constraint, N-278 (7)). PUBLIC's default EXECUTE is revoked from
-- the two functions, and so is any privilege of the four API roles; then EXECUTE is granted to anon, the role a Data
-- API request with the publishable key runs as. Each function checks the token itself. This file adds no type and no
-- devos_private function. Neither is a read, so neither carries the devos:read comment (F06).
revoke all on function devos_api.transfer_review(jsonb) from public;
revoke all on function devos_api.transfer_acceptance(jsonb) from public;
do $$
declare r text; f text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      foreach f in array array['devos_api.transfer_review(jsonb)', 'devos_api.transfer_acceptance(jsonb)'] loop
        execute format('revoke all on function %s from %I', f, r);
      end loop;
    end if;
  end loop;
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant execute on function devos_api.transfer_review(jsonb) to anon;
    grant execute on function devos_api.transfer_acceptance(jsonb) to anon;
  end if;
end
$$;
