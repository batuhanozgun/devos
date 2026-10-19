-- Synthetic test data (plan Section 8 item 13): every record, event, run, path and source ID below is made up inside
-- this transaction (text 'w14_fixture SYNTHETIC W-C02-14', source IDs 'w14_fixture_<run tag>_*', commit and hash strings
-- made at run time from md5 of fixed synthetic words, random uuids) and holds no personal or business data and no
-- credential. Tokens are issued at run time inside this rolled-back transaction, kept in a PL/pgSQL variable only, and
-- never stored, printed, compared or put in an error text (W-C02-07's README section 6). Nothing is committed.
--
-- Claim: the ledger transfer's functions (EV-C02-005 section 15 S5; section 12; Appendix B section 4's row "Ledger
-- transfer") admit only devos_kurulum; after the ledger_handed_over event every one but transfer_review,
-- transfer_acceptance, transfer_artifact (for a verdict file) and record_ledger_entry refuses; each write and its
-- transferred event are one transaction (no record without its mark, no mark without its record); a source already
-- written with the same hash writes nothing, and with another hash is refused; and transfer_acceptance refuses a Review
-- copy that is missing, failed, or conditional with no ledger entry, and on an accepted call sets the target accepted.
-- Specification: tests/C02/W-C02-14/T-W14-FN_transfer_functions.md. Serves W-C02-09 point 10 (N-277).
-- Runs: in devos-test by the migration job's test step as postgres, once W-C02-09's pull request copies this file byte
-- for byte to supabase/migrations/tests/w14_fn_transfer_functions.sql; with its breaks (tests/C02/W-C02-14/breaks/
-- B-FN-*) on W-C02-07's throwaway database (tests/C02/W-C02-07/README.md section 5.2). Transport sql-set-role: each
-- call runs as anon with the token header simulated by set_config('request.headers', ..., true); session_user stays
-- postgres.
-- Interface assumed: the specification's "Interface assumed" (W-C02-07's README 8.1, its chosen keys for four of the
-- fourteen functions; the other ten's payloads, their prerequisites, the run rule after the hand-over and the form in
-- which current_evidence names an event as W-C02-09's interface record gives them: evidence/C02/EV-C02-013_w09_interface.md
-- sections 1 and 3, Revision 1).
-- Revised before any result (EV-C02-013, 2026-10-17; ledger rule 3): the ten recipes and their prerequisites filled, the
-- installation's Mission planted for transfer_acceptance, run_id dropped after the hand-over, FN-G's counted row read,
-- FN-A-cond-pos formed. No case ID and no expected outcome changed.
-- Revised again before any result (EV-C02-013 Revision 2, 2026-10-18; ledger rule 3): FN-A's and FN-O-transfer_acceptance's
-- target is a Work transferred under the installation's Mission (R2-2); 50 cases added for the ten functions' transaction
-- rule and key, transfer_mission's mission_authority, run_not_open and cycle (N-279 (13)); the event count leaves out the
-- token functions' env_token events (EV-C02-013 2.1, M09-01). No earlier case ID or expected outcome changed.
-- Revised under ledger rule 3, 2026-10-19 (N-302 (1) and (c); CHK-C02-103 C1 (c)), before any result: the FN-T-half
-- cases are judged only when the function exists and their FN-T-ev control was accepted; 23 cases added for M09-10's
-- rules EV-C02-014 12.4 lists, record_ledger_entry's Rule O and a declared role_class (the third block below). No earlier
-- case ID or expected outcome changed.
-- Revised under ledger rule 3, 2026-10-19 (N-303 with its L-398 annotation; CHK-C02-104 C2, its X1 and C1), before any
-- result: 30 cases added for M09-11's rules EV-C02-014 13.4 lists, the refusal of special and offset-less answer times
-- and transfer_mission's one-Mission lock (the fourth block below). No earlier case ID or expected outcome changed.
-- Safety: no psql meta-command and no backslash; owner-level states (a planted hand-over, a trigger that raises) are
-- made inside subtransactions that are undone; stops at its first error; one row per case, then PASS, FAIL or COULD NOT
-- CHECK (FAIL and COULD NOT CHECK raise).
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '120s';

-- Results (W-C02-07's README section 3; helpers copied from tests/C02/W-C02-14/job/w14_sch_transfer_schema.sql).
create temp table w14_results (case_id text primary key,
  outcome text not null check (outcome in ('ok', 'bad', 'could_not_check')), detail text not null);
create temp table w14_ctx (tag text not null);
insert into w14_ctx select 'w14_fixture_' || left(md5(random()::text), 8);

create function pg_temp.w14_rec(p_id text, p_outcome text, p_detail text) returns void language sql as $f$
  insert into w14_results values (p_id, p_outcome, left(replace(coalesce(p_detail, ''), chr(10), ' '), 600))
  on conflict (case_id) do update set
    outcome = case when w14_results.outcome = 'bad' or excluded.outcome = 'bad' then 'bad'
                   when w14_results.outcome = 'could_not_check' or excluded.outcome = 'could_not_check'
                   then 'could_not_check' else 'ok' end,
    detail = left(w14_results.detail || ' | ' || excluded.detail, 1200)
$f$;
-- ok when p_cond is true, bad when false, could_not_check when null.
create function pg_temp.w14_check(p_id text, p_cond boolean, p_detail text) returns void language sql as $f$
  select pg_temp.w14_rec(p_id, case when p_cond then 'ok' when not p_cond then 'bad' else 'could_not_check' end, p_detail)
$f$;
create function pg_temp.w14_tag() returns text language sql as $f$ select tag from w14_ctx limit 1 $f$;
create function pg_temp.w14_hex(p_seed text, p_len int) returns text language sql as $f$
  select left(md5(p_seed || ':a') || md5(p_seed || ':b'), p_len)
$f$;

-- The fourteen functions (B section 4's row; EV-C02-005 section 12), and the two sets section 12 gives after the
-- ledger_handed_over event.
create function pg_temp.w14_fns() returns text[] language sql immutable as $f$
  select array['begin_transfer_run', 'transfer_mission', 'transfer_work', 'transfer_relation', 'transfer_decision',
               'transfer_review', 'transfer_acceptance', 'transfer_need', 'transfer_finding', 'transfer_artifact',
               'transfer_event', 'end_transfer_run', 'record_handover', 'record_ledger_entry']
$f$;
create function pg_temp.w14_closing() returns text[] language sql immutable as $f$
  select array['begin_transfer_run', 'transfer_mission', 'transfer_work', 'transfer_relation', 'transfer_decision',
               'transfer_need', 'transfer_finding', 'transfer_event', 'end_transfer_run', 'record_handover']
$f$;
-- The token refusals' reason codes (README 8.1, fixed) and the gate's (chosen).
create function pg_temp.w14_gate_codes() returns text[] language sql immutable as $f$
  select array['missing', 'empty', 'malformed', 'unknown', 'revoked', 'header_unreadable', 'role_class_not_permitted']
$f$;

-- One call as a role class (README 5.1 (a)); p_class null: no token at all. A raised error is kept, the token scrubbed.
create function pg_temp.w14_call(p_class text, p_fn text, p jsonb) returns jsonb language plpgsql as $f$
declare tok text; r jsonb; st text; msg text;
begin
  if p_class is null then
    perform set_config('request.headers', '{}', true);
  else
    begin
      execute 'select devos_private.issue_env_token($1)::text' into tok using p_class;
      if left(tok, 1) = '{' then tok := (tok::jsonb) ->> 'token'; end if;
    exception when others then
      return jsonb_build_object('w14_cnc', 'a synthetic token of class ' || p_class || ' could not be issued: ' || sqlstate);
    end;
    perform set_config('request.headers', json_build_object('x-devos-env-token', tok)::text, true);
  end if;
  begin
    execute 'set local role anon';
    execute format('select devos_api.%I($1)', p_fn) into r using p;
    execute 'reset role';
  exception when others then
    get stacked diagnostics st = returned_sqlstate, msg = message_text;
    execute 'reset role';
    r := jsonb_build_object('raised', true, 'sqlstate', st,
                            'message', left(replace(msg, coalesce(tok, chr(1)), '[w14: presented value]'), 160));
  end;
  tok := null;
  perform set_config('request.headers', '{}', true);
  return coalesce(r, '{"status": "absent"}'::jsonb);
end $f$;

-- accepted | refused | could_not_check (the check's own answer) | raised | unknown | test (the test's own failure).
create function pg_temp.w14_kind(r jsonb) returns text language sql immutable as $f$
  select case when r ? 'w14_cnc' then 'test' when r ? 'raised' then 'raised'
              when r ->> 'status' = 'refused' and r ->> 'reason_code' = 'could_not_check' then 'could_not_check'
              when r ->> 'status' = 'refused' then 'refused' when r ->> 'status' = 'ok' then 'accepted' else 'unknown' end
$f$;
create function pg_temp.w14_brief(r jsonb) returns text language sql immutable as $f$
  select pg_temp.w14_kind(r) || coalesce(' [' || nullif(concat_ws(' ', r ->> 'reason_code', r ->> 'reason',
         r ->> 'sqlstate', r ->> 'message', r ->> 'w14_cnc'), '') || ']', '')
$f$;
-- The id an accepted call returns (README 8.1: "A call that writes a record carries its id").
create function pg_temp.w14_id(r jsonb) returns text language sql immutable as $f$
  select coalesce(r ->> 'id', r ->> 'review_id', r ->> 'acceptance_id', r ->> 'decision_id')
$f$;

-- Row counts of the tables the fourteen can write (those that exist), env_tokens excepted (issuing a token adds one).
-- Revised before any result (EV-C02-013 section 2.1 and M09-01, 2026-10-18): for the same reason, the event count leaves
-- out the env_token_issued and env_token_revoked events of aggregate env_token, which the owner-only token functions
-- write (role_class owner, origin owner; DM-31) for every synthetic token this file issues; no transfer function writes one.
create function pg_temp.w14_counts() returns jsonb language plpgsql as $f$
declare t text; n bigint; j jsonb := '{}';
begin
  foreach t in array array['event', 'rejected_attempt', 'mission', 'mission_revision', 'work', 'work_revision',
    'relation', 'decision', 'decision_revision', 'review', 'verdict', 'acceptance', 'need', 'finding', 'finding_revision',
    'artifact', 'artifact_revision', 'effort_policy', 'global_authority_epoch'] loop
    if to_regclass('devos_private.' || t) is not null then
      execute format('select count(*) from devos_private.%I x', t) || case when t = 'event'
        then ' where x.aggregate_type::text is distinct from ''env_token''' else '' end into n;
      j := j || jsonb_build_object(t, n);
    end if;
  end loop;
  return j;
end $f$;
-- The tables whose count differs between two snapshots, p_except left out.
create function pg_temp.w14_changed(a jsonb, b jsonb, p_except text[] default '{}') returns text[] language sql as $f$
  select coalesce(array_agg(k order by k), '{}') from jsonb_object_keys(a) k
   where not k = any(p_except) and a -> k is distinct from b -> k
$f$;
create function pg_temp.w14_delta(a jsonb, b jsonb, t text) returns bigint language sql as $f$
  select (b ->> t)::bigint - (a ->> t)::bigint
$f$;
-- The transferred events of one source ID, any kind (S2's key; the kind is the build's to spell).
create function pg_temp.w14_marks(p_sid text) returns bigint language plpgsql as $f$
declare n bigint;
begin
  execute 'select count(*) from devos_private.event e where e.event_type::text = ''transferred''
             and e.payload -> ''transfer_source'' ->> ''source_id'' = $1' into n using p_sid;
  return n;
end $f$;

-- Plants one row as the owner (copied from w14_sch_transfer_schema.sql's w14_plant, which is Group B's w07_plant with
-- its IN-list rule); used only for the Work a Review and an Acceptance copy name.
create function pg_temp.w14_listed(p_table text, p_col text) returns text[] language sql as $f$
  select coalesce(array_agg(m[1] order by con.conname, ord), '{}')
    from pg_constraint con
    join pg_attribute att on att.attrelid = con.conrelid and att.attname = p_col
    cross join lateral regexp_matches(pg_get_constraintdef(con.oid), '''([a-z][a-z0-9_]*)''', 'g') with ordinality r(m, ord)
   where con.conrelid = to_regclass('devos_private.' || p_table) and con.contype = 'c'
     and con.conkey = array[att.attnum]
     and pg_get_constraintdef(con.oid) like '%= ANY (ARRAY[%'
     and pg_get_constraintdef(con.oid) not like '%<>%' and upper(pg_get_constraintdef(con.oid)) not like '%NOT %'
$f$;
create function pg_temp.w14_plant(p_table text, p_vals jsonb default '{}', p_depth int default 0)
returns jsonb language plpgsql as $f$
declare rel regclass := to_regclass(p_table); a record; j jsonb := coalesce(p_vals, '{}'); fk record;
        parent jsonb; cols text; r jsonb; listed text[];
begin
  if rel is null then raise exception 'w14 plant: % does not exist', p_table; end if;
  for a in select att.attname, att.attnum, att.atttypid, t.typtype, t.typcategory, t.typname
             from pg_attribute att join pg_type t on t.oid = att.atttypid
            where att.attrelid = rel and att.attnum > 0 and not att.attisdropped and att.attnotnull
              and not att.atthasdef and att.attidentity = '' and att.attgenerated = '' order by att.attnum loop
    continue when j ? a.attname;
    select con.confrelid::regclass::text as ptab,
           (select pa.attname from pg_attribute pa where pa.attrelid = con.confrelid and pa.attnum = con.confkey[1]) as pcol
      into fk from pg_constraint con
     where con.conrelid = rel and con.contype = 'f' and con.conkey = array[a.attnum]::smallint[] limit 1;
    if fk.ptab is not null then
      if p_depth >= 4 then raise exception 'w14 plant: foreign keys nest deeper than 4 from %', p_table; end if;
      parent := pg_temp.w14_plant(fk.ptab, '{}', p_depth + 1);
      j := j || jsonb_build_object(a.attname, parent -> fk.pcol);
      continue;
    end if;
    listed := '{}';
    if a.typname in ('text', 'varchar', 'bpchar', 'name', 'citext') then
      listed := pg_temp.w14_listed(replace(rel::text, 'devos_private.', ''), a.attname);
    end if;
    j := j || jsonb_build_object(a.attname, case
      when a.typtype = 'e' then to_jsonb((select e.enumlabel from pg_enum e where e.enumtypid = a.atttypid
                                          order by e.enumsortorder limit 1))
      when a.typname = 'uuid' then to_jsonb(gen_random_uuid())
      when a.typname in ('text', 'varchar', 'bpchar', 'name', 'citext') then
        to_jsonb(case when a.attname like '%scope%' then 'synthetic.w14fixture'
                      when cardinality(listed) > 0 then listed[1]
                      else 'w14_fixture SYNTHETIC W-C02-14' end)
      when a.typcategory = 'N' then to_jsonb(1)
      when a.typname = 'bool' then to_jsonb(false)
      when a.typname in ('timestamptz', 'timestamp') then to_jsonb(now())
      when a.typname = 'date' then to_jsonb(current_date)
      when a.typname in ('json', 'jsonb') then case when a.attname ~ '(s|refs|spans)$' then '[]'::jsonb else '{}'::jsonb end
      when a.typcategory = 'A' then '[]'::jsonb
      else null end);
    if j -> a.attname is null or jsonb_typeof(j -> a.attname) = 'null' then
      raise exception 'w14 plant: no synthetic value for %.% of type %', p_table, a.attname, a.typname;
    end if;
  end loop;
  select string_agg(quote_ident(x), ', ') into cols from jsonb_object_keys(j) x;
  if cols is null then
    execute format('insert into %s as w14_x default values returning to_jsonb(w14_x)', rel) into r;
    return r;
  end if;
  execute format('insert into %s as w14_x (%s) select %s from jsonb_populate_record(null::%s, $1) returning to_jsonb(w14_x)',
                 rel, cols, cols, rel) using j into r;
  return r;
end $f$;
-- A synthetic work item (its first revision under a planted Mission revision); returns its id.
create function pg_temp.w14_work() returns text language sql as $f$
  select pg_temp.w14_plant('devos_private.work_revision', jsonb_build_object('purpose',
         'w14_fixture SYNTHETIC W-C02-14 target of a verdict copy')) ->> 'work_id'
$f$;
create function pg_temp.w14_work_acceptance(p_id text) returns text language plpgsql as $f$
declare s text;
begin
  execute 'select to_jsonb(w) ->> ''acceptance'' from devos_private.work w where w.id::text = $1' into s using p_id;
  return coalesce(s, 'absent');
end $f$;

-- S1's transfer_source (EV-C02-005 section 15), as W-C02-07's N02 and N04 send it.
create function pg_temp.w14_src(p_kind text, p_sid text, p_text text default 'one') returns jsonb language sql as $f$
  select jsonb_build_object('kind', p_kind, 'source_id', p_sid, 'path', 'w14_fixture/' || p_sid || '.md',
    'input_commit', pg_temp.w14_hex('w14 input commit', 40), 'last_commit', pg_temp.w14_hex('w14 last commit ' || p_sid, 40),
    'sha256', pg_temp.w14_hex('w14 text ' || p_sid || ' ' || p_text, 64))
$f$;

-- The recipes: one accepted call per function. Four keep the payload keys W-C02-07's README 8.1 chooses
-- (begin_transfer_run, transfer_decision, transfer_review, transfer_acceptance; "The payload keys T-W07-N02 and T-W07-N04
-- send, each chosen"); the other ten send the keys W-C02-09's interface record names (EV-C02-013 section 3.2, the table
-- "The fourteen", and its paragraph "What the ten recipes need"). A null recipe still gives could_not_check, never a pass.
-- p_o: the call's own values (run_id, source ID, text, target, review, verdict result, current_evidence, and the ids the
-- prerequisites made: mission, mission_revision, decision, decision_revision, from, to, stage, kind, class, path).
-- After the ledger_handed_over event a copy names no run (EV-C02-013 section 3.1, D-7): with no 'run' in p_o,
-- transfer_review, transfer_acceptance and transfer_artifact send no run_id key at all.
create function pg_temp.w14_recipe(p_fn text, p_o jsonb) returns jsonb language plpgsql as $f$
declare sid text := coalesce(p_o ->> 'sid', pg_temp.w14_tag() || '_' || p_fn); txt text := coalesce(p_o ->> 'text', 'one');
        j jsonb; kind text := coalesce(p_o ->> 'kind', 'record_line');
begin
  if p_fn = 'begin_transfer_run' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'input_commit', pg_temp.w14_hex('w14 input commit', 40),
      'manifest_sha256', pg_temp.w14_hex('w14 manifest ' || (p_o ->> 'run'), 64), 'counts', '{}'::jsonb,
      'phase', 'begun', 'mode', coalesce(p_o ->> 'mode', 'ahead'));
  elsif p_fn = 'transfer_decision' then
    j := jsonb_build_object('class', coalesce(p_o ->> 'class', 'high_impact'), 'question', 'w14_fixture SYNTHETIC W-C02-14 decision ' || sid,
      'why_this_owner', 'w14_fixture SYNTHETIC W-C02-14: a rule of the fixture schema',
      'options', '[]'::jsonb, 'alternatives_considered', '[]'::jsonb, 'alternatives_state', 'compared',
      'criteria', '[]'::jsonb, 'evidence_refs', '[]'::jsonb, 'assumptions', '[]'::jsonb, 'premises', '[]'::jsonb,
      'reversibility', null, 'reopen_triggers', '[]'::jsonb, 'recommendation', null, 'recommendation_rationale', null,
      'status', coalesce(p_o ->> 'status', 'answered'), 'run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('decision', sid, txt));
    if p_o ->> 'class' = 'batu' then
      -- The answered batu Decision the installation's Mission rests on (EV-C02-013 3.2, transfer_mission's row, R1-9).
      j := j || jsonb_build_object('presented_text_tr', 'w14_fixture SYNTHETIC W-C02-14 karar metni',
        'answer_original_tr', 'w14_fixture SYNTHETIC W-C02-14 yanit', 'answer_interpretation_en',
        'w14_fixture SYNTHETIC W-C02-14 answer', 'answered_by', 'w14_fixture SYNTHETIC', 'answer_channel_ref',
        'w14_fixture/channel', 'answered_at', now());
    end if;
    return j;
  elsif p_fn = 'transfer_review' then
    j := jsonb_build_object('run_id', p_o ->> 'run', 'kind', 'review',
      'claim', 'w14_fixture SYNTHETIC W-C02-14 installation verdict copy ' || sid, 'target_ref', p_o ->> 'target',
      'criterion', 'w14_fixture/plan/work/W-W14-FIXTURE.md', 'basis_refs', jsonb_build_array('w14_fixture_tree'),
      'reviewer_declared_session', 'w14_fixture_checker_run SYNTHETIC W-C02-14', 'independence_level', 'fresh_context_subagent',
      'use', 'installation_acceptance', 'verdict', jsonb_build_object('result', coalesce(p_o ->> 'result', 'pass'),
      'objections', '[]'::jsonb, 'evidence_refs', '[]'::jsonb, 'limits', '[]'::jsonb),
      'transfer_source', pg_temp.w14_src('verdict', sid, txt));
    return case when p_o ->> 'run' is null then j - 'run_id' else j end;
  elsif p_fn = 'transfer_acceptance' then
    j := jsonb_build_object('run_id', p_o ->> 'run', 'target_ref', p_o ->> 'target', 'review_ref', p_o ->> 'review',
      'accepted_use', 'installation_acceptance', 'scope', 'installation',
      'current_evidence', coalesce(p_o -> 'evidence', jsonb_build_array(p_o ->> 'review')),
      'transfer_source', pg_temp.w14_src('acceptance', sid, txt));
    return case when p_o ->> 'run' is null then j - 'run_id' else j end;
  -- The ten, from EV-C02-013 section 3.2 (* there: required).
  elsif p_fn = 'end_transfer_run' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'counts', coalesce(p_o -> 'counts', '{}'::jsonb), 'phase', 'completed');
  elsif p_fn = 'record_handover' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'input_commit', pg_temp.w14_hex('w14 input commit', 40),
      'mark_commit', pg_temp.w14_hex('w14 mark commit ' || sid, 40), 'handed_over_sha256', pg_temp.w14_hex('w14 handed over ' || sid, 64));
  elsif p_fn = 'transfer_mission' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('mission', sid, txt),
      'purpose', 'w14_fixture SYNTHETIC W-C02-14 installation mission ' || sid, 'scope', 'installation',
      'acceptance', 'w14_fixture SYNTHETIC W-C02-14 acceptance', 'owner_authority', p_o ->> 'decision',
      'owner_authority_revision', coalesce((p_o ->> 'authority_revision')::int, (p_o ->> 'decision_revision')::int),
      'constraints', '[]'::jsonb, 'status', 'active');
  elsif p_fn = 'transfer_work' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('work', sid, txt),
      'mission_ref', p_o ->> 'mission', 'mission_revision', (p_o ->> 'mission_revision')::int, 'scope', 'installation',
      'purpose', 'w14_fixture SYNTHETIC W-C02-14 work item ' || sid, 'impact_class', 'high', 'execution', 'planned',
      'acceptance', 'proposed', 'effort_policy', jsonb_build_object('level', 'high', 'expert_assessment_ref',
      'w14_fixture/expert_assessment', 'non_removable_steps', jsonb_build_array('w14_fixture SYNTHETIC step')));
  elsif p_fn = 'transfer_relation' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('relation', sid, txt),
      'type', coalesce(p_o ->> 'type', 'about'), 'from_ref', p_o ->> 'from', 'from_revision', 1, 'to_ref', p_o ->> 'to', 'to_revision', 1,
      'scope', 'installation', 'hard', coalesce((p_o ->> 'hard')::boolean, false), 'method', 'mechanical', 'epistemic_status', 'observation');
  elsif p_fn = 'transfer_need' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('need', sid, txt),
      'mission_ref', p_o ->> 'mission', 'condition', 'w14_fixture SYNTHETIC W-C02-14 condition ' || sid,
      'why_needed', 'w14_fixture SYNTHETIC W-C02-14: a fixture need', 'status', 'open');
  elsif p_fn = 'transfer_finding' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('finding', sid, txt),
      'claim', 'w14_fixture SYNTHETIC W-C02-14 finding ' || sid, 'scope', 'installation',
      'counter_evidence_searched', 'not_recorded', 'changeable', 'not_recorded', 'epistemic_status', 'observation',
      'current_authority', 'information_only', 'privacy_class', 'public', 'status', 'candidate');
  elsif p_fn = 'transfer_artifact' then
    j := jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('artifact', sid, txt),
      'path', coalesce(p_o ->> 'path', 'w14_fixture/' || sid || '.md'), 'commit', pg_temp.w14_hex('w14 artifact commit ' || sid, 40),
      'kind', coalesce(p_o ->> 'artifact_kind', 'git_file'), 'scope', 'installation', 'status', 'current');
    return case when p_o ->> 'run' is null then j - 'run_id' else j end;
  elsif p_fn = 'transfer_event' then
    j := jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src(kind, sid, txt), 'event_type', kind,
      'aggregate_type', 'work', 'aggregate_id', p_o ->> 'target', 'text', 'w14_fixture SYNTHETIC W-C02-14 line ' || sid);
    if kind = 'ledger_entry' then j := j || jsonb_build_object('entry_id', sid, 'entry_date', current_date::text); end if;
    return j;
  elsif p_fn = 'record_ledger_entry' then
    return jsonb_build_object('stage_work_id', p_o ->> 'stage', 'entry_id', sid, 'entry_date', current_date::text,
      'text', 'w14_fixture SYNTHETIC W-C02-14 ledger entry ' || sid || ' ' || txt);
  end if;
  return null;
end $f$;

-- A run begun with devos_kurulum (the transfer's records belong to an open run, EV-C02-005 section 12); returns its id,
-- or null when begin_transfer_run does not accept its recipe.
create function pg_temp.w14_begin(p_run text) returns text language plpgsql as $f$
declare r jsonb;
begin
  r := pg_temp.w14_call('devos_kurulum', 'begin_transfer_run', pg_temp.w14_recipe('begin_transfer_run', jsonb_build_object('run', p_run)));
  if pg_temp.w14_kind(r) = 'accepted' then return p_run; end if;
  return null;
end $f$;

-- The prerequisites EV-C02-013 section 3.2 names ("Prerequisites a test must plant"). A prerequisite call that is not
-- accepted raises P0W17, which every case reads as could_not_check with that reason, never a pass.
create function pg_temp.w14_need(p_what text, r jsonb) returns text language plpgsql as $f$
begin
  if pg_temp.w14_kind(r) = 'accepted' and pg_temp.w14_id(r) is not null then return pg_temp.w14_id(r); end if;
  raise exception using errcode = 'P0W17', message = 'a prerequisite (' || p_what || ') was not accepted: ' || pg_temp.w14_brief(r);
end $f$;
-- The answered batu Decision transferred with source ID D-010, untagged (EV-C02-013 3.2, R1-9; S2's index allows it,
-- since this file's transaction is rolled back). One already committed in the database tested is used as it is.
create function pg_temp.w14_d010(p_run text) returns jsonb language plpgsql as $f$
declare d text; dr int;
begin
  execute 'select d.id::text from devos_private.decision d join devos_private.event e on e.aggregate_id = d.id
            where e.event_type::text = ''transferred'' and e.payload -> ''transfer_source'' ->> ''source_id'' = ''D-010''
            order by e.id limit 1' into d;
  if d is null then
    d := pg_temp.w14_need('transfer_decision with source ID D-010', pg_temp.w14_call('devos_kurulum', 'transfer_decision',
           pg_temp.w14_recipe('transfer_decision', jsonb_build_object('run', p_run, 'sid', 'D-010', 'class', 'batu'))));
  end if;
  execute 'select coalesce((to_jsonb(x) ->> ''answered_revision'')::int, 1) from devos_private.decision x where x.id::text = $1'
    into dr using d;
  return jsonb_build_object('decision', d, 'decision_revision', dr);
end $f$;
-- The installation's Mission: the one Mission whose creation event is transferred (EV-C02-013 section 4, the hook
-- installation_mission), made here by its second form, transfer_decision (D-010) then transfer_mission with devos_kurulum.
-- One already committed in the database tested is used as it is. Returns its id and current revision.
create function pg_temp.w14_install(p_run text) returns jsonb language plpgsql as $f$
declare m text; n int;
begin
  execute 'select m.id::text from devos_private.mission m where exists (select 1 from devos_private.event e
             where e.aggregate_id = m.id and e.event_type::text = ''transferred'') order by m.created_at limit 1' into m;
  if m is null then
    m := pg_temp.w14_need('transfer_mission', pg_temp.w14_call('devos_kurulum', 'transfer_mission',
           pg_temp.w14_recipe('transfer_mission', jsonb_build_object('run', p_run, 'sid', pg_temp.w14_tag() || '_INSTALL')
                                                  || pg_temp.w14_d010(p_run))));
  end if;
  execute 'select max(r.revision) from devos_private.mission_revision r where r.mission_id::text = $1' into n using m;
  return jsonb_build_object('mission', m, 'mission_revision', n);
end $f$;
-- What each of the ten needs before its call (EV-C02-013 3.2's paragraph "What the ten recipes need"), as p_o keys.
create function pg_temp.w14_prep(p_fn text, p_run text) returns jsonb language plpgsql as $f$
declare i jsonb;
begin
  if p_fn = 'transfer_mission' then return pg_temp.w14_d010(p_run);
  elsif p_fn in ('transfer_work', 'transfer_need', 'record_handover', 'transfer_acceptance') then return pg_temp.w14_install(p_run);
  elsif p_fn = 'transfer_relation' then return jsonb_build_object('from', pg_temp.w14_work(), 'to', pg_temp.w14_work());
  elsif p_fn = 'transfer_event' then return jsonb_build_object('target', pg_temp.w14_work());
  elsif p_fn = 'record_ledger_entry' then
    i := pg_temp.w14_install(p_run);
    return i || jsonb_build_object('stage', pg_temp.w14_need('transfer_work for the stage''s Work', pg_temp.w14_call('devos_kurulum',
      'transfer_work', pg_temp.w14_recipe('transfer_work', i || jsonb_build_object('run', p_run, 'sid', pg_temp.w14_tag() || '_W-stage')))));
  end if;
  return '{}'::jsonb;
end $f$;
-- The counted RejectedAttempt row of an unverified call (B 3.13, B:270; EV-C02-013 section 1 item 9): the sum of its
-- count for this function and reason code missing, under any of the function's spellings. Null when it cannot be read.
create function pg_temp.w14_counted(p_fn text) returns bigint language plpgsql as $f$
declare n bigint;
begin
  execute 'select coalesce(sum(x.count), 0) from devos_private.rejected_attempt x where x.counted_hour is not null
             and x.reason_code::text = ''missing'' and x.function_name::text in ($1, ''devos_api.'' || $1, $1 || ''(jsonb)'',
             ''devos_api.'' || $1 || ''(jsonb)'')' into n using p_fn;
  return n;
exception when others then return null;
end $f$;

-- The hand-over planted as the owner (S1: at most one ledger_handed_over event, on the installation's Mission).
create function pg_temp.w14_handover() returns void language plpgsql as $f$
begin
  insert into devos_private.event (aggregate_type, aggregate_id, event_type, payload, role_class, origin)
  values ('mission', gen_random_uuid(), 'ledger_handed_over', jsonb_build_object('run_id', pg_temp.w14_tag() || '_run_handover',
          'input_commit', pg_temp.w14_hex('w14 input commit', 40), 'mark_commit', pg_temp.w14_hex('w14 mark commit', 40),
          'handed_over_sha256', pg_temp.w14_hex('w14 handed over list', 64), 'w14_fixture', 'SYNTHETIC W-C02-14'), 'owner', 'owner');
end $f$;
create function pg_temp.w14_handovers() returns bigint language plpgsql as $f$
declare n bigint;
begin execute 'select count(*) from devos_private.event e where e.event_type::text = ''ledger_handed_over''' into n; return n; end $f$;

-- A trigger function that raises: planted on a table inside an undone block, so that a write of the function under test
-- fails part-way (W-C02-09 point 5: "An error raised mid-transaction leaves no half state and no orphan event").
create function pg_temp.w14_boom() returns trigger language plpgsql as $f$
begin
  raise exception using errcode = 'P0W15', message = 'w14: planted failure of one write';
end $f$;

create function pg_temp.w14_pre() returns text language plpgsql as $f$
declare t text;
begin
  if to_regprocedure('devos_private.issue_env_token(text)') is null then return 'devos_private.issue_env_token(text) does not exist'; end if;
  foreach t in array array['event', 'rejected_attempt', 'review', 'verdict', 'acceptance', 'work', 'work_revision', 'decision'] loop
    if to_regclass('devos_private.' || t) is null then return 'devos_private.' || t || ' does not exist'; end if;
  end loop;
  if not exists (select 1 from pg_roles where rolname = 'anon') then return 'role anon does not exist'; end if;
  if not exists (select 1 from unnest(pg_temp.w14_fns()) f where to_regprocedure('devos_api.' || f || '(jsonb)') is not null) then
    return 'no function of the ledger transfer''s group exists in devos_api (W-C02-09 builds them; EV-C02-005 S5)';
  end if;
  return null;
end $f$;

do $$
declare why text; f text; c text; r jsonb; r2 jsonb; k text; s0 jsonb; s1 jsonb; acc jsonb; ok boolean; det text;
        run text; tag text := pg_temp.w14_tag(); rcp jsonb; pre text; w text; rv text; rv2 text; sid text; ch text[];
        miss text[]; n0 bigint; n1 bigint; i bigint; res jsonb; w2 text;
        ctlk text;  -- N-302 (1), 2026-10-19
begin
  why := pg_temp.w14_pre();
  if why is not null then
    perform pg_temp.w14_rec('FN-pre', 'could_not_check', why);
    return;
  end if;

  -- FN-M-cat: the fourteen are devos_api functions of one jsonb parameter, with definer rights and a fixed search_path
  -- (W-C02-09 point 2; README 8.1). A missing one is a FAIL here, not a could not check.
  select coalesce(array_agg(x), '{}') into miss from unnest(pg_temp.w14_fns()) x
   where not exists (select 1 from pg_proc p where p.oid = to_regprocedure('devos_api.' || x || '(jsonb)') and p.prosecdef
                       and exists (select 1 from unnest(coalesce(p.proconfig, '{}')) g where g like 'search_path=%'));
  perform pg_temp.w14_check('FN-M-cat', cardinality(miss) = 0,
    case when cardinality(miss) = 0 then 'all fourteen are devos_api.<name>(jsonb), security definer, with a fixed search_path'
         else 'absent, not security definer, or without a fixed search_path: ' || array_to_string(miss, ', ') end);

  -- FN-G-<fn>: the gate. With each other role class's token and with none, refused for the class (or the token), and
  -- nothing written but RejectedAttempt rows, one per call with a verified token (B 3.13; DM-19). FN-G-pos-<fn>: the
  -- same function with devos_kurulum and the same input is not refused for the class or the token: the one thing the
  -- gate tests differs. Each function's calls are undone.
  foreach f in array pg_temp.w14_fns() loop
    if to_regprocedure('devos_api.' || f || '(jsonb)') is null then
      perform pg_temp.w14_rec(cid, 'could_not_check', 'devos_api.' || f || '(jsonb) does not exist (FN-M-cat fails)')
        from unnest(array['FN-G-' || f, 'FN-G-pos-' || f]) cid;
      continue;
    end if;
    acc := '[]';
    begin
      s0 := pg_temp.w14_counts(); ok := true; det := '';
      foreach c in array array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_ci', 'devos_backup', 'none'] loop
        if c = 'none' then n0 := pg_temp.w14_counted(f); end if;
        r := pg_temp.w14_call(case when c = 'none' then null else c end, f, '{}'::jsonb);
        k := pg_temp.w14_kind(r);
        -- The no-token call's counted row increases in place by one (B:270; CHK-C02-075 finding 2 (e); EV-C02-013 D-11).
        if c = 'none' then
          n1 := pg_temp.w14_counted(f);
          if n0 is null or n1 is null then ok := null;
          elsif ok is not null and n1 - n0 <> 1 then ok := false; end if;
          det := det || format('counted row (missing) %s -> %s (wanted +1); ', coalesce(n0::text, 'unreadable'), coalesce(n1::text, 'unreadable'));
        end if;
        if k in ('test', 'raised', 'unknown') then ok := null;
        elsif ok is not null and not (k = 'refused' and r ->> 'reason_code' = case when c = 'none' then 'missing' else 'role_class_not_permitted' end) then
          ok := false;
        end if;
        det := det || c || ': ' || pg_temp.w14_brief(r) || '; ';
      end loop;
      s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
      if ok is not null and (cardinality(ch) > 0 or pg_temp.w14_delta(s0, s1, 'rejected_attempt') < 5) then ok := false; end if;
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-G-' || f, 'cond', ok, 'detail', det || format(
        'tables changed besides rejected_attempt: %s; rejected_attempt rows +%s (wanted none, and at least 5)',
        coalesce(nullif(array_to_string(ch, ', '), ''), 'none'), pg_temp.w14_delta(s0, s1, 'rejected_attempt'))));
      r := pg_temp.w14_call('devos_kurulum', f, '{}'::jsonb); k := pg_temp.w14_kind(r);
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-G-pos-' || f,
        'cond', case when k in ('test', 'raised', 'unknown') then null
                     else not (k = 'refused' and r ->> 'reason_code' = any(pg_temp.w14_gate_codes())) end,
        'detail', 'devos_kurulum, the same input: ' || pg_temp.w14_brief(r) || ' (wanted no refusal for the class or the token)'));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-G-' || f, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

  if pg_temp.w14_handovers() > 0 then
    perform pg_temp.w14_rec(y.cid, 'could_not_check', 'a ledger_handed_over event is already in this database, so the state '
      || 'before the hand-over cannot be planted') from (select 'FN-C-' || x as cid from unnest(pg_temp.w14_closing()) x) y;
  end if;

  -- FN-C-<fn>: after the hand-over, each of the ten refuses with devos_kurulum and writes nothing but RejectedAttempt
  -- (EV-C02-005 section 12; B section 4). Its control is the same call before the hand-over, accepted.
  foreach f in array pg_temp.w14_closing() loop
    exit when pg_temp.w14_handovers() > 0;
    rcp := pg_temp.w14_recipe(f, jsonb_build_object('run', tag || '_run_c_' || f));
    if rcp is null then
      perform pg_temp.w14_rec('FN-C-' || f, 'could_not_check', f || ': no recipe is formed for it, so no accepted call can '
        || 'be made; the test designer fills its recipe from W-C02-09''s record (EV-C02-013 section 3.2) before the first result');
      continue;
    end if;
    acc := '[]';
    begin
      run := tag || '_run_c_' || f;
      if f <> 'begin_transfer_run' then run := pg_temp.w14_begin(run); end if;
      if run is null then
        pre := 'begin_transfer_run did not accept its recipe, so no run is open';
      else
        -- Its prerequisites (EV-C02-013 3.2), planted before the call.
        rcp := pg_temp.w14_recipe(f, jsonb_build_object('run', run) || case when f = 'begin_transfer_run' then '{}'::jsonb
                                                                            else pg_temp.w14_prep(f, run) end);
        r := pg_temp.w14_call('devos_kurulum', f, rcp); pre := pg_temp.w14_brief(r);
        if pg_temp.w14_kind(r) = 'accepted' then pre := null; end if;
      end if;
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when sqlstate 'P0W17' then pre := sqlerrm;
      when others then pre := 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160);
    end;
    if pre is not null then
      perform pg_temp.w14_rec('FN-C-' || f, 'could_not_check', 'the control (the same call before the hand-over) was not '
        || 'accepted with the chosen keys: ' || pre);
      continue;
    end if;
    begin
      run := tag || '_run_c_' || f;
      if f <> 'begin_transfer_run' then run := pg_temp.w14_begin(run); end if;
      -- The same call as the control, its prerequisites planted before the hand-over (they write through the functions).
      rcp := pg_temp.w14_recipe(f, jsonb_build_object('run', run) || case when f = 'begin_transfer_run' then '{}'::jsonb
                                                                          else pg_temp.w14_prep(f, run) end);
      perform pg_temp.w14_handover();
      s0 := pg_temp.w14_counts();
      r := pg_temp.w14_call('devos_kurulum', f, rcp); k := pg_temp.w14_kind(r);
      s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-C-' || f,
        'cond', case when k in ('test', 'raised', 'unknown') then null else k = 'refused' and cardinality(ch) = 0 end,
        'detail', format('after the ledger_handed_over event: %s; tables changed besides rejected_attempt: %s (wanted '
          || 'refused, none); before it the same call was accepted', pg_temp.w14_brief(r),
          coalesce(nullif(array_to_string(ch, ', '), ''), 'none'))));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when sqlstate 'P0W17' then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-C-' || f, 'cond', null, 'detail', sqlerrm));
      when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-C-' || f, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

  -- FN-O-<fn>: after the hand-over, transfer_review, transfer_acceptance, transfer_artifact (a verdict file) and
  -- record_ledger_entry still write (EV-C02-005 section 12; EV-C02-013 3.1 "Closing"). The copies send no run_id
  -- (EV-C02-013 3.1, D-7). What they need is planted before the hand-over, through the functions: an open run, the
  -- installation's Mission (transfer_acceptance takes its owner authority from it, EV-C02-013 D-8), the stage's Work
  -- (record_ledger_entry, under that Mission), and a Work the copies name.
  acc := '[]';
  begin
    if pg_temp.w14_handovers() > 0 then raise exception using errcode = 'P0W16', message = 'a ledger_handed_over event is already here'; end if;
    run := pg_temp.w14_begin(tag || '_run_o');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    res := pg_temp.w14_install(run);
    -- Revised before any result (EV-C02-013 R2-2, 2026-10-18): the copies name w2, the stage Work transferred under the
    -- installation's Mission, since transfer_acceptance accepts only an installation record (EV-C02-013 3.2).
    w2 := pg_temp.w14_need('transfer_work for the stage''s Work', pg_temp.w14_call('devos_kurulum', 'transfer_work',
            pg_temp.w14_recipe('transfer_work', res || jsonb_build_object('run', run, 'sid', tag || '_W-O1'))));
    perform pg_temp.w14_handover();
    s0 := pg_temp.w14_counts();
    r := pg_temp.w14_call('devos_kurulum', 'transfer_review', pg_temp.w14_recipe('transfer_review',
           jsonb_build_object('sid', tag || '_CHK-O1', 'target', w2)));
    s1 := pg_temp.w14_counts(); rv := pg_temp.w14_id(r);
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_review',
      'cond', case when pg_temp.w14_kind(r) in ('test', 'raised', 'unknown') then null
                   else pg_temp.w14_kind(r) = 'accepted' and pg_temp.w14_delta(s0, s1, 'review') = 1 and pg_temp.w14_marks(tag || '_CHK-O1') = 1 end,
      'detail', format('after the hand-over, no run_id: transfer_review %s; review rows +%s, its transferred events %s (wanted '
        || 'accepted, +1, 1)', pg_temp.w14_brief(r), pg_temp.w14_delta(s0, s1, 'review'), pg_temp.w14_marks(tag || '_CHK-O1'))));
    s0 := pg_temp.w14_counts();
    r2 := pg_temp.w14_call('devos_kurulum', 'transfer_acceptance', pg_temp.w14_recipe('transfer_acceptance',
           jsonb_build_object('sid', tag || '_ACC-O1', 'target', w2, 'review', rv)));
    s1 := pg_temp.w14_counts();
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_acceptance',
      'cond', case when pg_temp.w14_kind(r) <> 'accepted' or pg_temp.w14_kind(r2) in ('test', 'raised', 'unknown') then null
                   else pg_temp.w14_kind(r2) = 'accepted' and pg_temp.w14_delta(s0, s1, 'acceptance') = 1 end,
      'detail', format('after the hand-over, no run_id: transfer_acceptance of that copy %s; acceptance rows +%s (wanted accepted, +1)',
        pg_temp.w14_brief(r2), pg_temp.w14_delta(s0, s1, 'acceptance'))));
    -- A verdict file's Artifact: a git_file whose path is a check's verdict file (EV-C02-013 3.2, transfer_artifact's row).
    s0 := pg_temp.w14_counts();
    r := pg_temp.w14_call('devos_kurulum', 'transfer_artifact', pg_temp.w14_recipe('transfer_artifact',
           jsonb_build_object('sid', tag || '_ART-O1', 'artifact_kind', 'git_file',
                              'path', 'evidence/C99/checks/CHK-C99-' || abs(hashtext(tag))::text || '.md')));
    s1 := pg_temp.w14_counts();
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_artifact',
      'cond', case when pg_temp.w14_kind(r) in ('test', 'raised', 'unknown') then null
                   else pg_temp.w14_kind(r) = 'accepted' and pg_temp.w14_delta(s0, s1, 'artifact') = 1 and pg_temp.w14_marks(tag || '_ART-O1') = 1 end,
      'detail', format('after the hand-over, no run_id: transfer_artifact of a verdict file (git_file, a synthetic '
        || 'evidence/C99/checks/ path) %s; artifact rows +%s, its transferred events %s (wanted accepted, +1, 1)',
        pg_temp.w14_brief(r), pg_temp.w14_delta(s0, s1, 'artifact'), pg_temp.w14_marks(tag || '_ART-O1'))));
    -- record_ledger_entry writes one ledger_entry event on the stage's Work, and nothing else (EV-C02-005 section 12).
    execute 'select count(*) from devos_private.event e where e.event_type::text = ''ledger_entry'' and e.aggregate_id::text = $1'
      into n0 using w2;
    i := (select count(*) from devos_private.event e where e.event_type::text = 'transferred');
    s0 := pg_temp.w14_counts();
    r := pg_temp.w14_call('devos_kurulum', 'record_ledger_entry', pg_temp.w14_recipe('record_ledger_entry',
           jsonb_build_object('sid', tag || '_L-O1', 'stage', w2)));
    s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt', 'event']);
    execute 'select count(*) from devos_private.event e where e.event_type::text = ''ledger_entry'' and e.aggregate_id::text = $1'
      into n1 using w2;
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-O-record_ledger_entry',
      'cond', case when pg_temp.w14_kind(r) in ('test', 'raised', 'unknown') then null
                   else pg_temp.w14_kind(r) = 'accepted' and pg_temp.w14_delta(s0, s1, 'event') = 1 and n1 - n0 = 1
                        and (select count(*) from devos_private.event e where e.event_type::text = 'transferred') = i
                        and cardinality(ch) = 0 end,
      'detail', format('after the hand-over: record_ledger_entry on the stage''s Work %s; event rows +%s, its ledger_entry '
        || 'events +%s, transferred events +%s, other tables changed: %s (wanted accepted, +1, +1, +0, none)', pg_temp.w14_brief(r),
        pg_temp.w14_delta(s0, s1, 'event'), n1 - n0, (select count(*) from devos_private.event e where e.event_type::text = 'transferred') - i,
        coalesce(nullif(array_to_string(ch, ', '), ''), 'none'))));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W16' or sqlstate 'P0W17' then
      acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm))
                from unnest(array['FN-O-transfer_review', 'FN-O-transfer_acceptance', 'FN-O-transfer_artifact',
                                  'FN-O-record_ledger_entry']) x);
    when others then
      acc := acc || (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail',
        'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)))
                from unnest(array['FN-O-transfer_review', 'FN-O-transfer_acceptance', 'FN-O-transfer_artifact',
                                  'FN-O-record_ledger_entry']) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  -- FN-O-transfer_artifact-other: after the hand-over, another file's Artifact is refused and nothing but RejectedAttempt
  -- changes. Its control: the same call, with a run, before the hand-over, accepted (else could_not_check).
  pre := null;
  begin
    if pg_temp.w14_handovers() > 0 then raise exception using errcode = 'P0W17', message = 'a ledger_handed_over event is already here'; end if;
    run := pg_temp.w14_begin(tag || '_run_o_other');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    r := pg_temp.w14_call('devos_kurulum', 'transfer_artifact', pg_temp.w14_recipe('transfer_artifact',
           jsonb_build_object('run', run, 'sid', tag || '_ART-O2', 'artifact_kind', 'git_file')));
    if pg_temp.w14_kind(r) <> 'accepted' then pre := 'the control (the same call with a run, before the hand-over) was not '
      || 'accepted with the chosen keys: ' || pg_temp.w14_brief(r); end if;
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then pre := sqlerrm;
    when others then pre := 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160);
  end;
  if pre is not null then
    perform pg_temp.w14_rec('FN-O-transfer_artifact-other', 'could_not_check', pre);
  else
    acc := '[]';
    begin
      perform pg_temp.w14_handover();
      s0 := pg_temp.w14_counts();
      r := pg_temp.w14_call('devos_kurulum', 'transfer_artifact', pg_temp.w14_recipe('transfer_artifact',
             jsonb_build_object('sid', tag || '_ART-O2', 'artifact_kind', 'git_file')));
      s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']); k := pg_temp.w14_kind(r);
      acc := jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_artifact-other',
        'cond', case when k in ('test', 'raised', 'unknown') then null else k = 'refused' and cardinality(ch) = 0 end,
        'detail', format('after the hand-over, no run_id: transfer_artifact of a file that is not a verdict file %s; tables '
          || 'changed besides rejected_attempt: %s (wanted refused, none); before it the same call with a run was accepted',
          pg_temp.w14_brief(r), coalesce(nullif(array_to_string(ch, ', '), ''), 'none'))));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when others then acc := jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_artifact-other', 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end if;

  -- FN-T-ev-<fn> (positive controls of the transaction rule and of S1's "role_class from the token"): an accepted write
  -- adds its record and exactly one transferred event, which names the record and carries the transfer_source sent,
  -- role_class devos_kurulum, origin call. FN-T-half-*: the same call with one of its writes made to fail leaves neither
  -- the record nor the mark.
  foreach f in array array['transfer_review', 'transfer_decision'] loop
    acc := '[]'; ctlk := null;
    begin
      run := pg_temp.w14_begin(tag || '_run_t_' || f); sid := tag || '_T-' || f; w := pg_temp.w14_work();
      rcp := pg_temp.w14_recipe(f, jsonb_build_object('run', run, 'sid', sid, 'target', w));
      s0 := pg_temp.w14_counts();
      r := pg_temp.w14_call('devos_kurulum', f, rcp); s1 := pg_temp.w14_counts(); rv := pg_temp.w14_id(r);
      -- Revised under ledger rule 3, 2026-10-19 (N-302 (1)): the kind of this accepted call is kept as the control of the
      -- FN-T-half cases below, which are judged only when the same call without the planted failure was accepted.
      ctlk := case when run is null then 'no run' else pg_temp.w14_kind(r) end;
      execute 'select jsonb_agg(jsonb_build_object(''agg'', e.aggregate_id::text, ''rc'', e.role_class::text, ''origin'', e.origin::text,
                 ''src'', e.payload -> ''transfer_source'')) from devos_private.event e where e.event_type::text = ''transferred''
                 and e.payload -> ''transfer_source'' ->> ''source_id'' = $1' into res using sid;
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-T-ev-' || f,
        'cond', case when run is null or pg_temp.w14_kind(r) <> 'accepted' then null
                     else jsonb_array_length(coalesce(res, '[]')) = 1 and res -> 0 ->> 'agg' = rv
                          and res -> 0 ->> 'rc' = 'devos_kurulum' and res -> 0 ->> 'origin' = 'call'
                          and res -> 0 -> 'src' -> 'source_id' = rcp -> 'transfer_source' -> 'source_id'
                          and res -> 0 -> 'src' -> 'sha256' = rcp -> 'transfer_source' -> 'sha256'
                          and pg_temp.w14_delta(s0, s1, case f when 'transfer_review' then 'review' else 'decision' end) = 1 end,
        'detail', format('%s: %s; its transferred events %s (wanted one, naming the record %s, role_class devos_kurulum, origin '
          || 'call, the transfer_source sent); %s rows +%s', f, pg_temp.w14_brief(r), coalesce(jsonb_array_length(res), 0),
          coalesce(rv, 'none'), case f when 'transfer_review' then 'review' else 'decision' end,
          pg_temp.w14_delta(s0, s1, case f when 'transfer_review' then 'review' else 'decision' end))));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-T-ev-' || f, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
    -- The planted failures: the mark's write (a trigger on event for transferred rows), and, for transfer_review, the
    -- Verdict's write (a trigger on verdict), each in its own undone block.
    foreach c in array case f when 'transfer_review' then array['ev', 'rec'] else array['ev'] end loop
      acc := '[]';
      begin
        run := pg_temp.w14_begin(tag || '_run_h_' || f || c); sid := tag || '_H-' || f || '-' || c; w := pg_temp.w14_work();
        rcp := pg_temp.w14_recipe(f, jsonb_build_object('run', run, 'sid', sid, 'target', w));
        if c = 'ev' then
          execute 'create trigger w14_boom before insert on devos_private.event for each row when (new.event_type::text = '
               || '''transferred'') execute function pg_temp.w14_boom()';
        else
          execute 'create trigger w14_boom before insert on devos_private.verdict for each row execute function pg_temp.w14_boom()';
        end if;
        s0 := pg_temp.w14_counts();
        r := pg_temp.w14_call('devos_kurulum', f, rcp); s1 := pg_temp.w14_counts();
        ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
        -- Revised under ledger rule 3, 2026-10-19 (N-302 (1); EV-C02-014 12.4): the case is judged only when the function
        -- exists and its control, FN-T-ev-<f>'s call without the planted failure, was accepted. The first version read a
        -- call to a function that does not exist ("raised", 42883) as "not accepted" and passed for that reason.
        acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-T-half-' || c || '-' || f,
          'cond', case when run is null or to_regprocedure('devos_api.' || f || '(jsonb)') is null
                            or ctlk is distinct from 'accepted' then null
                       else pg_temp.w14_kind(r) <> 'accepted' and cardinality(ch) = 0 and pg_temp.w14_marks(sid) = 0 end,
          'detail', format('%s with the %s write made to fail: %s; tables changed besides rejected_attempt: %s; its '
            || 'transferred events %s (wanted not accepted, none, 0); control (the same call without the failure, FN-T-ev): %s'
            || '%s', f, case c when 'ev' then 'transferred event''s' else 'Verdict''s' end,
            pg_temp.w14_brief(r), coalesce(nullif(array_to_string(ch, ', '), ''), 'none'), pg_temp.w14_marks(sid),
            coalesce(ctlk, 'not made'), case when to_regprocedure('devos_api.' || f || '(jsonb)') is null
              then '; devos_api.' || f || '(jsonb) does not exist (FN-M-cat fails), so no failure of its writes can be planted'
              else '' end)));
        raise exception using errcode = 'P0W14', message = 'w14: undo the block';
      exception
        when sqlstate 'P0W14' then null;
        when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-T-half-' || c || '-' || f, 'cond', null,
          'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
      end;
      perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
    end loop;
  end loop;

  -- FN-I-*: the idempotency key's answers (EV-C02-005 3.1; B 3.13). The same source with the same hash: accepted, the
  -- same id, nothing written. With another hash: refused, nothing written but RejectedAttempt.
  foreach f in array array['transfer_review', 'transfer_decision'] loop
    acc := '[]';
    begin
      run := pg_temp.w14_begin(tag || '_run_i_' || f); sid := tag || '_I-' || f; w := pg_temp.w14_work();
      r := pg_temp.w14_call('devos_kurulum', f, pg_temp.w14_recipe(f, jsonb_build_object('run', run, 'sid', sid, 'target', w)));
      rv := pg_temp.w14_id(r);
      if run is null or pg_temp.w14_kind(r) <> 'accepted' then
        acc := jsonb_build_array(jsonb_build_object('id', case f when 'transfer_review' then 'FN-I-same' else 'FN-I-same-decision' end,
                 'cond', null, 'detail', 'the first write was not accepted with the chosen keys: ' || pg_temp.w14_brief(r)),
               jsonb_build_object('id', case f when 'transfer_review' then 'FN-I-other-review' else 'FN-I-other-decision' end,
                 'cond', null, 'detail', 'the first write was not accepted with the chosen keys: ' || pg_temp.w14_brief(r)));
      else
        s0 := pg_temp.w14_counts();
        r2 := pg_temp.w14_call('devos_kurulum', f, pg_temp.w14_recipe(f, jsonb_build_object('run', run, 'sid', sid, 'target', w)));
        s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
        acc := acc || jsonb_build_array(jsonb_build_object('id', case f when 'transfer_review' then 'FN-I-same' else 'FN-I-same-decision' end,
          'cond', case when pg_temp.w14_kind(r2) in ('test', 'unknown') then null
                       else pg_temp.w14_kind(r2) = 'accepted' and pg_temp.w14_id(r2) = rv and cardinality(ch) = 0 end,
          'detail', format('%s, an exact repeat (same source, same hash): %s, id %s (first %s); tables changed besides '
            || 'rejected_attempt: %s (wanted accepted, the same id, none)', f, pg_temp.w14_brief(r2),
            coalesce(pg_temp.w14_id(r2), 'none'), rv, coalesce(nullif(array_to_string(ch, ', '), ''), 'none'))));
        s0 := pg_temp.w14_counts();
        r2 := pg_temp.w14_call('devos_kurulum', f, pg_temp.w14_recipe(f, jsonb_build_object('run', run, 'sid', sid, 'target', w, 'text', 'two')));
        s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
        acc := acc || jsonb_build_array(jsonb_build_object('id', case f when 'transfer_review' then 'FN-I-other-review' else 'FN-I-other-decision' end,
          'cond', case when pg_temp.w14_kind(r2) in ('test', 'raised', 'unknown') then null
                       else pg_temp.w14_kind(r2) = 'refused' and cardinality(ch) = 0 and pg_temp.w14_marks(sid) = 1
                            and pg_temp.w14_delta(s0, s1, 'rejected_attempt') >= 1 end,
          'detail', format('%s, the same source with another hash: %s; tables changed besides rejected_attempt: %s; its '
            || 'transferred events %s; rejected_attempt rows +%s (wanted refused, none, 1, at least 1)', f, pg_temp.w14_brief(r2),
            coalesce(nullif(array_to_string(ch, ', '), ''), 'none'), pg_temp.w14_marks(sid), pg_temp.w14_delta(s0, s1, 'rejected_attempt'))));
      end if;
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when others then acc := acc || jsonb_build_array(jsonb_build_object('id', case f when 'transfer_review' then 'FN-I-same' else 'FN-I-same-decision' end, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

  -- FN-A-*: transfer_acceptance (EV-C02-005 2.4): it refuses when the Review copy it names is missing, when that
  -- verdict's result is fail, or, for a conditional result, when it names no ledger_entry event; an accepted call sets
  -- the target Work's acceptance to accepted in the same transaction. Each case differs from FN-A-pos in one thing.
  -- The installation's Mission is planted in each (transfer_acceptance takes its owner authority from it; EV-C02-013 3.2
  -- and D-8). FN-A-cond-pos: the conditional copy with a ledger_entry event, written by transfer_event, that
  -- current_evidence names as {"event_id": n} (EV-C02-013 3.2, transfer_acceptance's row and "What the ten recipes need").
  foreach c in array array['pos', 'missing', 'fail', 'cond', 'cond-pos'] loop
    acc := '[]';
    begin
      run := pg_temp.w14_begin(tag || '_run_a_' || c);
      if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
      -- Revised before any result (EV-C02-013 R2-2, 2026-10-18): the target w is a Work transferred under the
      -- installation's Mission (transfer_acceptance accepts only an installation record, EV-C02-013 3.2), its own source
      -- ID per case, so each FN-A case still differs from FN-A-pos in one thing only.
      rcp := pg_temp.w14_install(run);
      w := pg_temp.w14_need('transfer_work for the target Work', pg_temp.w14_call('devos_kurulum', 'transfer_work',
             pg_temp.w14_recipe('transfer_work', rcp || jsonb_build_object('run', run, 'sid', tag || '_W-A-' || c))));
      r := pg_temp.w14_call('devos_kurulum', 'transfer_review', pg_temp.w14_recipe('transfer_review', jsonb_build_object('run', run,
             'sid', tag || '_A-' || c, 'target', w, 'result', case c when 'fail' then 'fail' when 'cond' then 'conditional'
                                                                    when 'cond-pos' then 'conditional' else 'pass' end)));
      rv := case when c = 'missing' then gen_random_uuid()::text else pg_temp.w14_id(r) end;
      res := null;
      if c = 'cond-pos' then
        res := jsonb_build_array(rv, jsonb_build_object('event_id', (pg_temp.w14_need('transfer_event of a ledger_entry',
                 pg_temp.w14_call('devos_kurulum', 'transfer_event', pg_temp.w14_recipe('transfer_event', jsonb_build_object('run', run,
                 'sid', tag || '_LE-A', 'kind', 'ledger_entry', 'target', w)))))::bigint));
      end if;
      if pg_temp.w14_kind(r) <> 'accepted' then
        acc := jsonb_build_array(jsonb_build_object('id', 'FN-A-' || c, 'cond', null,
                 'detail', 'the Review copy was not accepted with the chosen keys: ' || pg_temp.w14_brief(r)));
      else
        s0 := pg_temp.w14_counts();
        r2 := pg_temp.w14_call('devos_kurulum', 'transfer_acceptance', pg_temp.w14_recipe('transfer_acceptance',
               jsonb_build_object('run', run, 'sid', tag || '_ACC-' || c, 'target', w, 'review', rv)
               || case when res is null then '{}'::jsonb else jsonb_build_object('evidence', res) end));
        s1 := pg_temp.w14_counts(); k := pg_temp.w14_kind(r2);
        acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-A-' || c,
          'cond', case when k in ('test', 'raised', 'unknown') then null
                       when c in ('pos', 'cond-pos') then k = 'accepted' and pg_temp.w14_delta(s0, s1, 'acceptance') = 1
                                           and pg_temp.w14_work_acceptance(w) = 'accepted' and pg_temp.w14_marks(tag || '_ACC-' || c) = 1
                       else k = 'refused' and cardinality(pg_temp.w14_changed(s0, s1, array['rejected_attempt'])) = 0
                            and pg_temp.w14_work_acceptance(w) = 'proposed' end,
          'detail', format('transfer_acceptance naming %s: %s; acceptance rows +%s; the Work''s acceptance %s; tables changed '
            || 'besides rejected_attempt: %s (wanted %s)', case c when 'pos' then 'a pass copy' when 'missing' then 'an id that '
            || 'names no Review copy' when 'fail' then 'a fail copy' when 'cond' then 'a conditional copy, current_evidence '
            || 'naming only it' else 'a conditional copy, current_evidence naming it and a ledger_entry event as {"event_id": n}' end,
            pg_temp.w14_brief(r2), pg_temp.w14_delta(s0, s1, 'acceptance'), pg_temp.w14_work_acceptance(w),
            coalesce(nullif(array_to_string(pg_temp.w14_changed(s0, s1, array['rejected_attempt']), ', '), ''), 'none'),
            case when c in ('pos', 'cond-pos') then 'accepted, +1, accepted, its one transferred event' else 'refused, +0, proposed, none' end)));
      end if;
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when sqlstate 'P0W17' then acc := jsonb_build_array(jsonb_build_object('id', 'FN-A-' || c, 'cond', null, 'detail', sqlerrm));
      when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-A-' || c, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

  -- FN-R-declared: a declared role class in the payload changes nothing (B principle 8; S1: role_class from the token).
  acc := '[]';
  begin
    run := pg_temp.w14_begin(tag || '_run_r'); w := pg_temp.w14_work(); sid := tag || '_R-1';
    r := pg_temp.w14_call('devos_kurulum', 'transfer_review', pg_temp.w14_recipe('transfer_review',
           jsonb_build_object('run', run, 'sid', sid, 'target', w)) || '{"role_class": "devos_denetim", "reviewer_role_class": "devos_denetim", "origin": "owner"}');
    rv := pg_temp.w14_id(r);
    if run is null or pg_temp.w14_kind(r) <> 'accepted' then
      acc := jsonb_build_array(jsonb_build_object('id', 'FN-R-declared', 'cond', null, 'detail',
               'not accepted with declared role keys added (a build may refuse unknown keys): ' || pg_temp.w14_brief(r)));
    else
      execute 'select to_jsonb(x) ->> ''reviewer_role_class'' from devos_private.review x where x.id::text = $1' into det using rv;
      execute 'select string_agg(distinct e.role_class::text || ''/'' || e.origin::text, '','') from devos_private.event e
                where e.aggregate_id::text = $1' into pre using rv;
      acc := jsonb_build_array(jsonb_build_object('id', 'FN-R-declared', 'cond', det = 'devos_kurulum' and pre = 'devos_kurulum/call',
               'detail', format('declared devos_denetim and origin owner: accepted; the copy''s reviewer_role_class %s, its events '
                 || '%s (wanted devos_kurulum, devos_kurulum/call)', coalesce(det, 'absent'), coalesce(pre, 'none'))));
    end if;
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-R-declared', 'cond', null,
      'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
end $$;

-- Revised before any result (EV-C02-013 Revision 2 section 3 and note N-279 (13), 2026-10-18; ledger rule 3): the cases
-- "Not covered" (2) left out. For the other ten functions (transfer_mission, transfer_work, transfer_relation,
-- transfer_need, transfer_finding, transfer_artifact, transfer_event, end_transfer_run, record_handover,
-- record_ledger_entry): FN-T-ev-<fn> (an accepted call writes what EV-C02-013 3.2's column "Writes, and its answer"
-- names, with its mark), FN-T-half-ev-<fn> (that mark's write, or for the three that write no mark their one event, made
-- to fail: nothing stays), FN-I-same-<fn> (an exact repeat: the same id, nothing new; record_handover: refused
-- handed_over, nothing new, EV-C02-013 3.2 R2-9) and FN-I-other-<fn> (another hash: refused conflict; end_transfer_run
-- with other counts: run_not_open); transfer_mission's mission_authority (FN-MA-*), run_not_open (FN-RN-*) and
-- transfer_relation's cycle (FN-CY-*). New case IDs; every earlier case ID and expected outcome is kept.
create function pg_temp.w14_ten() returns text[] language sql immutable as $f$
  select array['transfer_mission', 'transfer_work', 'transfer_relation', 'transfer_need', 'transfer_finding',
               'transfer_artifact', 'transfer_event', 'end_transfer_run', 'record_handover', 'record_ledger_entry']
$f$;
-- What each of the ten writes (EV-C02-013 3.2, "Writes, and its answer"; 3.1, one transferred event per transferred
-- key): the family tables with their row deltas ("d"), and the event types with their counts ("ev").
create function pg_temp.w14_writes(p_fn text) returns jsonb language sql immutable as $f$
  select (case p_fn
    when 'transfer_mission' then '{"d": {"mission": 1, "mission_revision": 1}, "ev": {"transferred": 1}}'
    when 'transfer_work' then '{"d": {"work": 1, "work_revision": 1, "effort_policy": 1}, "ev": {"transferred": 2}}'
    when 'transfer_relation' then '{"d": {"relation": 1}, "ev": {"transferred": 1}}'
    when 'transfer_need' then '{"d": {"need": 1}, "ev": {"transferred": 1}}'
    when 'transfer_finding' then '{"d": {"finding": 1, "finding_revision": 1}, "ev": {"transferred": 1}}'
    when 'transfer_artifact' then '{"d": {"artifact": 1, "artifact_revision": 1}, "ev": {"transferred": 1}}'
    when 'transfer_event' then '{"d": {}, "ev": {"transferred": 1, "record_line": 1}}'
    when 'end_transfer_run' then '{"d": {}, "ev": {"transfer_run": 1, "transferred": 0}}'
    when 'record_handover' then '{"d": {}, "ev": {"ledger_handed_over": 1, "transferred": 0}}'
    when 'record_ledger_entry' then '{"d": {}, "ev": {"ledger_entry": 1, "transferred": 0}}' end)::jsonb
$f$;
-- The event FN-T-half-ev-<fn> makes fail: the transferred mark, or the one event of the three that write no mark.
create function pg_temp.w14_mark_type(p_fn text) returns text language sql immutable as $f$
  select case p_fn when 'end_transfer_run' then 'transfer_run' when 'record_handover' then 'ledger_handed_over'
                   when 'record_ledger_entry' then 'ledger_entry' else 'transferred' end
$f$;
create function pg_temp.w14_evmax() returns bigint language plpgsql as $f$
declare n bigint;
begin execute 'select coalesce(max(e.id), 0) from devos_private.event e' into n; return n; end $f$;
create function pg_temp.w14_events_after(p_after bigint) returns jsonb language plpgsql as $f$
declare j jsonb;
begin
  execute 'select coalesce(jsonb_agg(jsonb_build_object(''id'', e.id::text, ''type'', e.event_type::text, ''agg'', e.aggregate_id::text,
             ''rc'', e.role_class::text, ''origin'', e.origin::text, ''payload'', e.payload) order by e.id), ''[]''::jsonb)
             from devos_private.event e where e.id > $1 and e.aggregate_type::text is distinct from ''env_token''' into j using p_after;
  return j;
end $f$;
create function pg_temp.w14_types(p_evs jsonb) returns text language sql immutable as $f$
  select coalesce(string_agg(x ->> 'type', ',' order by x ->> 'type'), 'none') from jsonb_array_elements(p_evs) x
$f$;
-- The aggregate of a begun run (the id begin_transfer_run answers; EV-C02-013 3.2).
create function pg_temp.w14_run_agg(p_run text) returns text language plpgsql as $f$
declare a text;
begin
  execute 'select e.aggregate_id::text from devos_private.event e where e.event_type::text = ''transfer_run''
             and e.payload ->> ''run_id'' = $1 and e.payload ->> ''phase'' = ''begun'' order by e.id limit 1' into a using p_run;
  return a;
end $f$;
-- FN-T-ev's condition for one accepted call: the family tables change exactly as w14_writes says, the event types are
-- added in its counts, every new event is devos_kurulum/call, and the answer's id names what it wrote.
create function pg_temp.w14_t_ev(p_fn text, r jsonb, p_o jsonb, rcp jsonb, s0 jsonb, s1 jsonb, evs jsonb) returns boolean
language plpgsql as $f$
declare wr jsonb := pg_temp.w14_writes(p_fn); rid text := pg_temp.w14_id(r); sid text := rcp -> 'transfer_source' ->> 'source_id';
        sha text := rcp -> 'transfer_source' ->> 'sha256'; ok boolean; agg text;
begin
  ok := pg_temp.w14_changed(s0, s1, array['rejected_attempt', 'event']) = array(select x from jsonb_object_keys(wr -> 'd') x order by x)
    and not exists (select 1 from jsonb_each_text(wr -> 'd') x where pg_temp.w14_delta(s0, s1, x.key) <> x.value::bigint)
    and not exists (select 1 from jsonb_each_text(wr -> 'ev') x
                     where (select count(*) from jsonb_array_elements(evs) e where e ->> 'type' = x.key) <> x.value::bigint)
    and not exists (select 1 from jsonb_array_elements(evs) e where e ->> 'rc' is distinct from 'devos_kurulum'
                     or e ->> 'origin' is distinct from 'call');
  if p_fn = 'end_transfer_run' then
    agg := pg_temp.w14_run_agg(p_o ->> 'run');
    ok := ok and rid = agg and exists (select 1 from jsonb_array_elements(evs) e where e ->> 'type' = 'transfer_run'
            and e ->> 'agg' = agg and e -> 'payload' ->> 'phase' = 'completed' and e -> 'payload' ->> 'run_id' = p_o ->> 'run');
  elsif p_fn = 'record_handover' then
    ok := ok and rid = p_o ->> 'mission' and exists (select 1 from jsonb_array_elements(evs) e
            where e ->> 'type' = 'ledger_handed_over' and e ->> 'agg' = p_o ->> 'mission');
  elsif p_fn = 'record_ledger_entry' then
    ok := ok and exists (select 1 from jsonb_array_elements(evs) e where e ->> 'type' = 'ledger_entry' and e ->> 'id' = rid
            and e ->> 'agg' = p_o ->> 'stage');
  elsif p_fn = 'transfer_event' then
    ok := ok and exists (select 1 from jsonb_array_elements(evs) e where e ->> 'type' = 'record_line' and e ->> 'id' = rid
            and e ->> 'agg' = p_o ->> 'target')
      and exists (select 1 from jsonb_array_elements(evs) e where e ->> 'type' = 'transferred' and e -> 'payload' ->> 'event_id' = rid
            and e -> 'payload' -> 'transfer_source' ->> 'source_id' = sid and e -> 'payload' -> 'transfer_source' ->> 'sha256' = sha);
  else
    ok := ok and exists (select 1 from jsonb_array_elements(evs) e where e ->> 'type' = 'transferred' and e ->> 'agg' = rid
            and e -> 'payload' -> 'transfer_source' ->> 'source_id' = sid and e -> 'payload' -> 'transfer_source' ->> 'sha256' = sha)
      and not exists (select 1 from jsonb_array_elements(evs) e where e ->> 'type' = 'transferred'
            and (e -> 'payload' -> 'transfer_source' ->> 'source_id') is distinct from sid);
  end if;
  return coalesce(ok, false);
end $f$;

do $$
declare f text; c text; run text; tag text := pg_temp.w14_tag(); sid text; po jsonb; rcp jsonb; r jsonb; r2 jsonb;
        s0 jsonb; s1 jsonb; e0 bigint; evs jsonb; ch text[]; acc jsonb; k text; rid text; want text; d text; w1 text; w2 text;
        ids text[]; ctlk text;  -- ctlk: N-302 (1), 2026-10-19
begin
  if pg_temp.w14_pre() is not null then return; end if;  -- FN-pre is recorded by the block above
  ids := array(select x || g from unnest(array['FN-T-ev-', 'FN-T-half-ev-', 'FN-I-same-']) x, unnest(pg_temp.w14_ten()) g)
      || array(select 'FN-I-other-' || g from unnest(pg_temp.w14_ten()) g where g <> 'record_handover')
      || array['FN-MA-pos', 'FN-MA-class', 'FN-MA-status', 'FN-MA-source', 'FN-MA-revision',
               'FN-RN-pos', 'FN-RN-never', 'FN-RN-completed', 'FN-RN-after-handover', 'FN-CY-pos', 'FN-CY-cycle'];
  if pg_temp.w14_handovers() > 0 then
    perform pg_temp.w14_rec(x, 'could_not_check', 'a ledger_handed_over event is already in this database, so the state '
      || 'before the hand-over cannot be planted') from unnest(ids) x;
    return;
  end if;

  foreach f in array pg_temp.w14_ten() loop
    if to_regprocedure('devos_api.' || f || '(jsonb)') is null then
      perform pg_temp.w14_rec(x, 'could_not_check', 'devos_api.' || f || '(jsonb) does not exist (FN-M-cat fails)')
        from unnest(ids) x where x like '%-' || f;
      continue;
    end if;
    -- FN-T-ev-<fn>: the accepted call and what it writes (EV-C02-013 3.1 and 3.2).
    acc := '[]'; ctlk := null;
    begin
      run := pg_temp.w14_begin(tag || '_run_t2_' || f); sid := tag || '_T2-' || f;
      if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
      po := jsonb_build_object('run', run, 'sid', sid) || pg_temp.w14_prep(f, run);
      rcp := pg_temp.w14_recipe(f, po);
      s0 := pg_temp.w14_counts(); e0 := pg_temp.w14_evmax();
      r := pg_temp.w14_call('devos_kurulum', f, rcp);
      s1 := pg_temp.w14_counts(); evs := pg_temp.w14_events_after(e0); k := pg_temp.w14_kind(r);
      ctlk := k;  -- N-302 (1), 2026-10-19: the control of FN-T-half-ev-<fn> below
      acc := jsonb_build_array(jsonb_build_object('id', 'FN-T-ev-' || f,
        'cond', case when k <> 'accepted' then null else pg_temp.w14_t_ev(f, r, po, rcp, s0, s1, evs) end,
        'detail', format('%s: %s; tables changed besides event and rejected_attempt: %s; new events: %s; roles/origins: %s (wanted '
          || 'accepted, writing %s, every event devos_kurulum/call, the answer''s id naming what it wrote)', f, pg_temp.w14_brief(r),
          coalesce(nullif(array_to_string(pg_temp.w14_changed(s0, s1, array['rejected_attempt', 'event']), ', '), ''), 'none'),
          pg_temp.w14_types(evs), (select string_agg(distinct (e ->> 'rc') || '/' || (e ->> 'origin'), ',') from jsonb_array_elements(evs) e),
          pg_temp.w14_writes(f)::text)));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when sqlstate 'P0W17' then acc := jsonb_build_array(jsonb_build_object('id', 'FN-T-ev-' || f, 'cond', null, 'detail', sqlerrm));
      when others then acc := jsonb_build_array(jsonb_build_object('id', 'FN-T-ev-' || f, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
    -- FN-T-half-ev-<fn>: the same call with its mark's write (or its one event's) made to fail; nothing stays.
    acc := '[]';
    begin
      run := pg_temp.w14_begin(tag || '_run_h2_' || f); sid := tag || '_H2-' || f;
      if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
      po := jsonb_build_object('run', run, 'sid', sid) || pg_temp.w14_prep(f, run);
      rcp := pg_temp.w14_recipe(f, po);
      execute format('create trigger w14_boom before insert on devos_private.event for each row when (new.event_type::text = %L) '
                     || 'execute function pg_temp.w14_boom()', pg_temp.w14_mark_type(f));
      s0 := pg_temp.w14_counts();
      r := pg_temp.w14_call('devos_kurulum', f, rcp); k := pg_temp.w14_kind(r);
      s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
      -- Revised under ledger rule 3, 2026-10-19 (N-302 (1), the same failure class for the ten): judged only when its
      -- control, FN-T-ev-<fn>'s call without the planted failure, was accepted; else could_not_check.
      acc := jsonb_build_array(jsonb_build_object('id', 'FN-T-half-ev-' || f,
        'cond', case when k = 'test' or ctlk is distinct from 'accepted' then null
                     else k <> 'accepted' and cardinality(ch) = 0 and pg_temp.w14_marks(sid) = 0 end,
        'detail', format('%s with its %s event''s write made to fail: %s; tables changed besides rejected_attempt: %s; transferred '
          || 'events of the source %s (wanted not accepted, none, 0); control (FN-T-ev, without the failure): %s', f,
          pg_temp.w14_mark_type(f), pg_temp.w14_brief(r), coalesce(nullif(array_to_string(ch, ', '), ''), 'none'),
          pg_temp.w14_marks(sid), coalesce(ctlk, 'not made'))));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when sqlstate 'P0W17' then acc := jsonb_build_array(jsonb_build_object('id', 'FN-T-half-ev-' || f, 'cond', null, 'detail', sqlerrm));
      when others then acc := jsonb_build_array(jsonb_build_object('id', 'FN-T-half-ev-' || f, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
    -- FN-I-same-<fn> and FN-I-other-<fn>: the key's two answers (EV-C02-013 3.1; 3.2's rows for end_transfer_run,
    -- record_handover and record_ledger_entry).
    acc := '[]';
    begin
      run := pg_temp.w14_begin(tag || '_run_i2_' || f); sid := tag || '_I2-' || f;
      if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
      po := jsonb_build_object('run', run, 'sid', sid) || pg_temp.w14_prep(f, run);
      r := pg_temp.w14_call('devos_kurulum', f, pg_temp.w14_recipe(f, po)); rid := pg_temp.w14_id(r);
      if pg_temp.w14_kind(r) <> 'accepted' then
        acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the first write was not accepted with the '
                 || 'chosen keys: ' || pg_temp.w14_brief(r))) from unnest(ids) x where x in ('FN-I-same-' || f, 'FN-I-other-' || f));
      else
        s0 := pg_temp.w14_counts();
        r2 := pg_temp.w14_call('devos_kurulum', f, pg_temp.w14_recipe(f, po)); k := pg_temp.w14_kind(r2);
        s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
        acc := jsonb_build_array(jsonb_build_object('id', 'FN-I-same-' || f,
          'cond', case when k in ('test', 'unknown') then null
                       when f = 'record_handover' then k = 'refused' and r2 ->> 'reason_code' = 'handed_over' and cardinality(ch) = 0
                       else k = 'accepted' and pg_temp.w14_id(r2) = rid and cardinality(ch) = 0 end,
          'detail', format('%s, an exact repeat: %s, id %s (first %s); tables changed besides rejected_attempt: %s (wanted %s)', f,
            pg_temp.w14_brief(r2), coalesce(pg_temp.w14_id(r2), 'none'), rid, coalesce(nullif(array_to_string(ch, ', '), ''), 'none'),
            case when f = 'record_handover' then 'refused handed_over, none: its second call comes after the hand-over its first recorded'
                 else 'accepted, the same id, none' end)));
        if f <> 'record_handover' then
          want := case when f = 'end_transfer_run' then 'run_not_open' else 'conflict' end;
          s0 := pg_temp.w14_counts();
          r2 := pg_temp.w14_call('devos_kurulum', f, pg_temp.w14_recipe(f, po || case when f = 'end_transfer_run'
                  then jsonb_build_object('counts', jsonb_build_object('w14_fixture', 1)) else jsonb_build_object('text', 'two') end));
          k := pg_temp.w14_kind(r2);
          s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
          acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-I-other-' || f,
            'cond', case when k in ('test', 'raised', 'unknown') then null
                         else k = 'refused' and r2 ->> 'reason_code' = want and cardinality(ch) = 0
                              and pg_temp.w14_delta(s0, s1, 'rejected_attempt') >= 1
                              and pg_temp.w14_marks(sid) = (pg_temp.w14_writes(f) -> 'ev' ->> 'transferred')::bigint end,
            'detail', format('%s, the same key with %s: %s; tables changed besides rejected_attempt: %s; transferred events of the '
              || 'source %s; rejected_attempt rows +%s (wanted refused %s, none, %s, at least 1)', f,
              case when f = 'end_transfer_run' then 'other counts' else 'another hash' end, pg_temp.w14_brief(r2),
              coalesce(nullif(array_to_string(ch, ', '), ''), 'none'), pg_temp.w14_marks(sid), pg_temp.w14_delta(s0, s1, 'rejected_attempt'),
              want, pg_temp.w14_writes(f) -> 'ev' ->> 'transferred')));
        end if;
      end if;
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm))
                                           from unnest(ids) x where x in ('FN-I-same-' || f, 'FN-I-other-' || f));
      when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail',
        'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)))
                                 from unnest(ids) x where x in ('FN-I-same-' || f, 'FN-I-other-' || f));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

  -- FN-MA-*: transfer_mission's mission_authority (EV-C02-013 3.2 with R1-9 and R2-7; B:397, B:106; DM-23): the owner
  -- authority must be a transferred Decision of class batu, answered or accepted, answered at the revision named, with
  -- source ID D-010. FN-MA-pos is the accepted call; each other case differs from it in one thing.
  foreach c in array array['pos', 'class', 'status', 'source', 'revision'] loop
    acc := '[]';
    begin
      if to_regprocedure('devos_api.transfer_mission(jsonb)') is null or to_regprocedure('devos_api.transfer_decision(jsonb)') is null then
        raise exception using errcode = 'P0W17', message = 'transfer_mission or transfer_decision does not exist (FN-M-cat fails)'; end if;
      execute 'select count(*) from devos_private.event e where e.event_type::text = ''transferred'' and (e.aggregate_type::text = ''mission''
                 or e.payload -> ''transfer_source'' ->> ''source_id'' = ''D-010'')' into rid;
      if rid <> '0' then raise exception using errcode = 'P0W17', message = 'a transferred Mission or a D-010 Decision is already in this '
        || 'database, so a new one cannot be planted (S2''s index)'; end if;
      run := pg_temp.w14_begin(tag || '_run_ma_' || c);
      if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
      d := pg_temp.w14_need('transfer_decision of the owner authority', pg_temp.w14_call('devos_kurulum', 'transfer_decision',
             pg_temp.w14_recipe('transfer_decision', jsonb_build_object('run', run,
               'sid', case c when 'source' then tag || '_D-011' else 'D-010' end,
               'class', case c when 'class' then 'high_impact' else 'batu' end,
               'status', case c when 'status' then 'open' else 'answered' end))));
      s0 := pg_temp.w14_counts();
      r := pg_temp.w14_call('devos_kurulum', 'transfer_mission', pg_temp.w14_recipe('transfer_mission', jsonb_build_object('run', run,
             'sid', tag || '_INSTALL-MA-' || c, 'decision', d, 'decision_revision', 1)
             || case when c = 'revision' then jsonb_build_object('authority_revision', 2) else '{}'::jsonb end));
      s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']); k := pg_temp.w14_kind(r);
      acc := jsonb_build_array(jsonb_build_object('id', 'FN-MA-' || c,
        'cond', case when k in ('test', 'raised', 'unknown') then null
                     when c = 'pos' then k = 'accepted' and pg_temp.w14_delta(s0, s1, 'mission') = 1
                     else k = 'refused' and r ->> 'reason_code' = 'mission_authority' and cardinality(ch) = 0 end,
        'detail', format('transfer_mission on %s: %s; tables changed besides rejected_attempt: %s (wanted %s)',
          case c when 'pos' then 'an answered batu Decision with source ID D-010, its answered revision'
                 when 'class' then 'an answered Decision of class high_impact (source ID D-010)'
                 when 'status' then 'a batu Decision with status open (source ID D-010)'
                 when 'source' then 'an answered batu Decision with another source ID'
                 else 'an answered batu Decision with source ID D-010, owner_authority_revision 2 (answered at 1)' end,
          pg_temp.w14_brief(r), coalesce(nullif(array_to_string(ch, ', '), ''), 'none'),
          case when c = 'pos' then 'accepted, +1 mission' else 'refused mission_authority, none' end)));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when sqlstate 'P0W17' then acc := jsonb_build_array(jsonb_build_object('id', 'FN-MA-' || c, 'cond', null, 'detail', sqlerrm));
      when others then acc := jsonb_build_array(jsonb_build_object('id', 'FN-MA-' || c, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

  -- FN-RN-*: the run rule (EV-C02-013 3.1, with R1-8): before the hand-over a writing call names an open run, else
  -- run_not_open; after it, a copy that sends a run_id is refused run_not_open whatever the run's state. FN-RN-pos is
  -- transfer_finding with an open run; -never and -completed differ from it in the run named; -after-handover is
  -- FN-O-transfer_review's call with the run_id of a run begun before the hand-over added.
  foreach c in array array['pos', 'never', 'completed', 'after-handover'] loop
    acc := '[]';
    begin
      f := case when c = 'after-handover' then 'transfer_review' else 'transfer_finding' end;
      if to_regprocedure('devos_api.' || f || '(jsonb)') is null then
        raise exception using errcode = 'P0W17', message = 'devos_api.' || f || '(jsonb) does not exist (FN-M-cat fails)'; end if;
      sid := tag || '_RN-' || c;
      if c = 'never' then run := tag || '_run_never_begun';
      else
        run := pg_temp.w14_begin(tag || '_run_rn_' || c);
        if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
      end if;
      if c = 'completed' then
        r := pg_temp.w14_call('devos_kurulum', 'end_transfer_run', pg_temp.w14_recipe('end_transfer_run', jsonb_build_object('run', run)));
        if pg_temp.w14_kind(r) <> 'accepted' then raise exception using errcode = 'P0W17', message = 'end_transfer_run did not '
          || 'complete the run: ' || pg_temp.w14_brief(r); end if;
      end if;
      if c = 'after-handover' then w1 := pg_temp.w14_work(); perform pg_temp.w14_handover(); end if;
      s0 := pg_temp.w14_counts();
      r := pg_temp.w14_call('devos_kurulum', f, pg_temp.w14_recipe(f, jsonb_build_object('run', run, 'sid', sid, 'target', w1)));
      s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']); k := pg_temp.w14_kind(r);
      acc := jsonb_build_array(jsonb_build_object('id', 'FN-RN-' || c,
        'cond', case when k in ('test', 'raised', 'unknown') then null
                     when c = 'pos' then k = 'accepted' and pg_temp.w14_delta(s0, s1, 'finding') = 1
                     else k = 'refused' and r ->> 'reason_code' = 'run_not_open' and cardinality(ch) = 0 end,
        'detail', format('%s naming %s: %s; tables changed besides rejected_attempt: %s (wanted %s)', f,
          case c when 'pos' then 'an open run' when 'never' then 'a run never begun' when 'completed' then 'a run completed by end_transfer_run'
                 else 'a run begun before the planted hand-over, after it' end,
          pg_temp.w14_brief(r), coalesce(nullif(array_to_string(ch, ', '), ''), 'none'),
          case when c = 'pos' then 'accepted, +1 finding' else 'refused run_not_open, none' end)));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when sqlstate 'P0W17' then acc := jsonb_build_array(jsonb_build_object('id', 'FN-RN-' || c, 'cond', null, 'detail', sqlerrm));
      when others then acc := jsonb_build_array(jsonb_build_object('id', 'FN-RN-' || c, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

  -- FN-CY-*: transfer_relation's cycle (EV-C02-013 3.2; B principle 6): a hard depends_on that closes a cycle is
  -- refused cycle. FN-CY-pos is the first hard depends_on, accepted; FN-CY-cycle its reverse, which closes the cycle.
  acc := '[]';
  begin
    if to_regprocedure('devos_api.transfer_relation(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.transfer_relation(jsonb) does not exist (FN-M-cat fails)'; end if;
    run := pg_temp.w14_begin(tag || '_run_cy');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    w1 := pg_temp.w14_work(); w2 := pg_temp.w14_work();
    s0 := pg_temp.w14_counts();
    r := pg_temp.w14_call('devos_kurulum', 'transfer_relation', pg_temp.w14_recipe('transfer_relation', jsonb_build_object('run', run,
           'sid', tag || '_REL-CY1', 'from', w1, 'to', w2, 'type', 'depends_on', 'hard', true)));
    s1 := pg_temp.w14_counts(); k := pg_temp.w14_kind(r);
    acc := jsonb_build_array(jsonb_build_object('id', 'FN-CY-pos',
      'cond', case when k in ('test', 'raised', 'unknown') then null else k = 'accepted' and pg_temp.w14_delta(s0, s1, 'relation') = 1 end,
      'detail', format('transfer_relation, a hard depends_on from one Work to another: %s; relation rows +%s (wanted accepted, +1)',
        pg_temp.w14_brief(r), pg_temp.w14_delta(s0, s1, 'relation'))));
    if k = 'accepted' then
      s0 := pg_temp.w14_counts();
      r2 := pg_temp.w14_call('devos_kurulum', 'transfer_relation', pg_temp.w14_recipe('transfer_relation', jsonb_build_object('run', run,
             'sid', tag || '_REL-CY2', 'from', w2, 'to', w1, 'type', 'depends_on', 'hard', true)));
      s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']); k := pg_temp.w14_kind(r2);
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-CY-cycle',
        'cond', case when k in ('test', 'raised', 'unknown') then null
                     else k = 'refused' and r2 ->> 'reason_code' = 'cycle' and cardinality(ch) = 0 end,
        'detail', format('transfer_relation, the reverse hard depends_on, which closes a cycle: %s; tables changed besides '
          || 'rejected_attempt: %s (wanted refused cycle, none)', pg_temp.w14_brief(r2), coalesce(nullif(array_to_string(ch, ', '), ''), 'none'))));
    else
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-CY-cycle', 'cond', null,
        'detail', 'its positive pair (the first hard depends_on) was not accepted, so no cycle could be closed: ' || pg_temp.w14_brief(r)));
    end if;
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm))
                                         from unnest(array['FN-CY-pos', 'FN-CY-cycle']) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail',
      'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)))
                               from unnest(array['FN-CY-pos', 'FN-CY-cycle']) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
end $$;

-- Added under ledger rule 3, 2026-10-19 (note N-302 (c) with its L-396 annotation; CHK-C02-103 C1 (c); EV-C02-014 12.4),
-- before any result of this file: cases for the rules of M09-10's six functions that EV-C02-014 12.4 lists as reached
-- only by its producer's self-check and that no merged case reached at main 9399614 with M09-11 (the producer's break
-- copies, made again and run against the merged file: b03, b07, b09, b10, b13, b14, b15, b17, b18, b22, b23, b24, b26,
-- b27), and the two the checker found: record_ledger_entry's Rule O (its break X2, the same rule as b18) and a role_class
-- key declared in the call on the six functions' events (its break X4: the class must come from the token). New case
-- IDs; every earlier case ID and expected outcome is kept. Each ✘ case differs from an accepted call of this file
-- (named in the specification) in one thing, and wants the reason code EV-C02-013 3.2 and section 25 give, with nothing
-- written but rejected_attempt (+1 or more); another code, or an acceptance, is bad; a raised answer is the test's own
-- could_not_check.
create function pg_temp.w14_try(p_fn text, p jsonb) returns jsonb language plpgsql as $f$
declare s0 jsonb; s1 jsonb; e0 bigint; r jsonb;
begin
  s0 := pg_temp.w14_counts(); e0 := pg_temp.w14_evmax();
  r := pg_temp.w14_call('devos_kurulum', p_fn, p);
  s1 := pg_temp.w14_counts();
  return jsonb_build_object('r', r, 'ch', to_jsonb(pg_temp.w14_changed(s0, s1, array['rejected_attempt'])),
    'evs', pg_temp.w14_events_after(e0), 'ra', pg_temp.w14_delta(s0, s1, 'rejected_attempt'));
end $f$;
create function pg_temp.w14_refused_with(t jsonb, p_code text) returns boolean language sql immutable as $f$
  select case when pg_temp.w14_kind(t -> 'r') in ('test', 'raised', 'unknown') then null
              else t -> 'r' ->> 'status' = 'refused' and t -> 'r' ->> 'reason_code' = p_code
                   and jsonb_array_length(t -> 'ch') = 0 and (t ->> 'ra')::bigint >= 1 end
$f$;
create function pg_temp.w14_say(t jsonb, p_want text) returns text language sql immutable as $f$
  select pg_temp.w14_brief(t -> 'r') || '; tables changed besides rejected_attempt: '
    || coalesce(nullif((select string_agg(x, ', ') from jsonb_array_elements_text(t -> 'ch') x), ''), 'none')
    || '; rejected_attempt rows +' || coalesce(t ->> 'ra', '?') || ' (wanted ' || p_want || ')'
$f$;
-- A Mission that is not the installation's. p_event true: opened through open_mission with devos_kurulum, on an owner-
-- planted batu Decision answered at revision 1 (its creation event is mission_opened, not transferred; T-W07-F06's
-- pg_temp.f06_rule_o_mission does the same). p_event false: planted by the owner, with no creation event. Returns the
-- Mission's id and its revision row's id; raises P0W17 when it cannot be made.
create function pg_temp.w14_other_mission(p_event boolean) returns jsonb language plpgsql as $f$
declare dc jsonb; r jsonb; m text; mr text;
begin
  if p_event then
    dc := pg_temp.w14_plant('devos_private.decision', '{"class": "batu", "status": "answered", "answered_revision": 1}');
    perform pg_temp.w14_plant('devos_private.decision_revision', jsonb_build_object('decision_id', dc -> 'id', 'revision', 1));
    r := pg_temp.w14_call('devos_kurulum', 'open_mission', jsonb_build_object('purpose',
           'w14_fixture SYNTHETIC W-C02-14 a Mission that is not the installation''s', 'scope', 'synthetic.w14fixture',
           'owner_authority', dc -> 'id', 'owner_authority_revision', 1, 'acceptance', 'w14_fixture SYNTHETIC W-C02-14',
           'constraints', '[]'::jsonb));
    m := pg_temp.w14_need('open_mission of a Mission that is not the installation''s', r);
  else
    m := pg_temp.w14_plant('devos_private.mission_revision', '{}') ->> 'mission_id';
  end if;
  execute 'select x.id::text from devos_private.mission_revision x where x.mission_id::text = $1 order by x.revision desc limit 1'
    into mr using m;
  if mr is null then raise exception using errcode = 'P0W17', message = 'the other Mission has no revision row'; end if;
  return jsonb_build_object('mission', m, 'mission_revision_id', mr);
end $f$;

do $$
declare tag text := pg_temp.w14_tag(); run text; acc jsonb; t jsonb; po jsonb; rcp jsonb; i jsonb; w text; om jsonb;
        f text; k text; ids text[]; blk text[]; nb bigint; vpath text;
begin
  if pg_temp.w14_pre() is not null then return; end if;  -- FN-pre is recorded by the first block
  ids := array['FN-BR-repeat', 'FN-BR-conflict', 'FN-ER-never', 'FN-HO-never', 'FN-HO-noinst', 'FN-TE-never', 'FN-TE-agg',
               'FN-TE-kind', 'FN-TE-staterow-pos', 'FN-TE-staterow', 'FN-LE-owner', 'FN-LE-owner-cnc', 'FN-TA-never',
               'FN-TA-scope', 'FN-TA-anchor', 'FN-TA-run-after', 'FN-TA-mark-after']
      || array(select 'FN-R-declared-' || x from unnest(array['begin_transfer_run', 'end_transfer_run', 'record_handover',
                                                               'transfer_event', 'record_ledger_entry', 'transfer_artifact']) x);
  if pg_temp.w14_handovers() > 0 then
    perform pg_temp.w14_rec(x, 'could_not_check', 'a ledger_handed_over event is already in this database, so the state '
      || 'before the hand-over cannot be planted') from unnest(ids) x;
    return;
  end if;
  vpath := 'evidence/C99/checks/CHK-C99-' || abs(hashtext(tag || ' mark'))::text || '.md';

  -- FN-BR-repeat (✔; its pair) and FN-BR-conflict (✘; b03): begin_transfer_run's key (EV-C02-013 3.2 and 25 (2)): the
  -- same run_id with the same input commit, manifest, counts and mode is the exact repeat (ok, the run's aggregate id,
  -- nothing written); with another manifest it is refused conflict, and the run keeps its one begun event.
  blk := array['FN-BR-repeat', 'FN-BR-conflict']; acc := '[]';
  begin
    if to_regprocedure('devos_api.begin_transfer_run(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.begin_transfer_run(jsonb) does not exist (FN-M-cat fails)'; end if;
    run := pg_temp.w14_begin(tag || '_run_br');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    rcp := pg_temp.w14_recipe('begin_transfer_run', jsonb_build_object('run', run));
    t := pg_temp.w14_try('begin_transfer_run', rcp); k := pg_temp.w14_kind(t -> 'r');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-BR-repeat',
      'cond', case when k in ('test', 'raised', 'unknown') then null
                   else k = 'accepted' and t -> 'r' ->> 'id' = pg_temp.w14_run_agg(run) and jsonb_array_length(t -> 'ch') = 0 end,
      'detail', 'begin_transfer_run, the same run_id and payload again: ' || pg_temp.w14_brief(t -> 'r') || ', id names the run''s '
        || 'aggregate: ' || coalesce((t -> 'r' ->> 'id' = pg_temp.w14_run_agg(run))::text, 'no') || '; tables changed besides '
        || 'rejected_attempt: ' || (t -> 'ch')::text || ' (wanted accepted, the run''s aggregate, none)'));
    t := pg_temp.w14_try('begin_transfer_run', rcp || jsonb_build_object('manifest_sha256', pg_temp.w14_hex('w14 another manifest ' || run, 64)));
    execute 'select count(*) from devos_private.event e where e.event_type::text = ''transfer_run'' and e.payload ->> ''run_id'' = $1'
      into nb using run;
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-BR-conflict',
      'cond', case when pg_temp.w14_refused_with(t, 'conflict') is null then null else pg_temp.w14_refused_with(t, 'conflict') and nb = 1 end,
      'detail', 'begin_transfer_run, the same run_id with another manifest: ' || pg_temp.w14_say(t, 'refused conflict, none, at least 1')
        || '; the run''s transfer_run events ' || nb || ' (wanted 1)'));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- FN-ER-never (✘; b07): end_transfer_run naming a run never begun is refused run_not_open (EV-C02-013 3.2 and 25 (3));
  -- its pair is FN-T-ev-end_transfer_run (a begun run).
  blk := array['FN-ER-never']; acc := '[]';
  begin
    if to_regprocedure('devos_api.end_transfer_run(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.end_transfer_run(jsonb) does not exist (FN-M-cat fails)'; end if;
    t := pg_temp.w14_try('end_transfer_run', pg_temp.w14_recipe('end_transfer_run', jsonb_build_object('run', tag || '_run_er_never_begun')));
    acc := jsonb_build_array(jsonb_build_object('id', 'FN-ER-never', 'cond', pg_temp.w14_refused_with(t, 'run_not_open'),
      'detail', 'end_transfer_run naming a run never begun: ' || pg_temp.w14_say(t, 'refused run_not_open, none, at least 1')));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- FN-HO-never (✘; b09): record_handover naming a run never begun, the installation's Mission present, is refused
  -- reference_missing and writes no ledger_handed_over event (EV-C02-013 3.2 and 25 (4)); its pair is
  -- FN-T-ev-record_handover (a begun run).
  blk := array['FN-HO-never']; acc := '[]';
  begin
    if to_regprocedure('devos_api.record_handover(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.record_handover(jsonb) does not exist (FN-M-cat fails)'; end if;
    run := pg_temp.w14_begin(tag || '_run_ho');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    i := pg_temp.w14_install(run);
    t := pg_temp.w14_try('record_handover', pg_temp.w14_recipe('record_handover', jsonb_build_object('run', tag || '_run_ho_never_begun',
           'sid', tag || '_HO-never')));
    acc := jsonb_build_array(jsonb_build_object('id', 'FN-HO-never',
      'cond', case when pg_temp.w14_refused_with(t, 'reference_missing') is null then null
                   else pg_temp.w14_refused_with(t, 'reference_missing') and pg_temp.w14_handovers() = 0 end,
      'detail', 'record_handover naming a run never begun, the installation''s Mission present: '
        || pg_temp.w14_say(t, 'refused reference_missing, none, at least 1') || '; ledger_handed_over events ' || pg_temp.w14_handovers()));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- FN-HO-noinst (✘; b10): record_handover with a begun run and no installation Mission is refused reference_missing
  -- (EV-C02-013 3.2: "no installation Mission"; 26 (1): the transfer group's code for a record not yet written, which the
  -- transfer tool tells apart from could_not_check). It needs a database with no transferred Mission, else could_not_check.
  blk := array['FN-HO-noinst']; acc := '[]';
  begin
    if to_regprocedure('devos_api.record_handover(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.record_handover(jsonb) does not exist (FN-M-cat fails)'; end if;
    execute 'select count(*) from devos_private.event e where e.event_type::text = ''transferred'' and e.aggregate_type::text = ''mission'''
      into nb;
    if nb > 0 then raise exception using errcode = 'P0W17', message = 'a transferred Mission is already in this database, so its absence '
      || 'cannot be planted'; end if;
    run := pg_temp.w14_begin(tag || '_run_ho_noinst');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    t := pg_temp.w14_try('record_handover', pg_temp.w14_recipe('record_handover', jsonb_build_object('run', run, 'sid', tag || '_HO-noinst')));
    acc := jsonb_build_array(jsonb_build_object('id', 'FN-HO-noinst', 'cond', pg_temp.w14_refused_with(t, 'reference_missing'),
      'detail', 'record_handover with a begun run and no installation Mission: ' || pg_temp.w14_say(t, 'refused reference_missing, none, at least 1')));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- FN-TE-never (✘; b13), FN-TE-agg (✘; b14), FN-TE-kind (✘; b15): transfer_event (EV-C02-013 3.2 and 25 (5)) naming a run
  -- never begun is refused run_not_open; an aggregate_id that names no Work, reference_missing; an event_type other than
  -- its transfer_source's kind (both of the six), invalid_field. Each differs from FN-T-ev-transfer_event's call in that.
  blk := array['FN-TE-never', 'FN-TE-agg', 'FN-TE-kind']; acc := '[]';
  begin
    if to_regprocedure('devos_api.transfer_event(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.transfer_event(jsonb) does not exist (FN-M-cat fails)'; end if;
    run := pg_temp.w14_begin(tag || '_run_te');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    w := pg_temp.w14_work();
    t := pg_temp.w14_try('transfer_event', pg_temp.w14_recipe('transfer_event', jsonb_build_object('run', tag || '_run_te_never_begun',
           'sid', tag || '_TE-never#1', 'target', w)));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TE-never', 'cond', pg_temp.w14_refused_with(t, 'run_not_open'),
      'detail', 'transfer_event naming a run never begun: ' || pg_temp.w14_say(t, 'refused run_not_open, none, at least 1')));
    t := pg_temp.w14_try('transfer_event', pg_temp.w14_recipe('transfer_event', jsonb_build_object('run', run,
           'sid', tag || '_TE-agg#1', 'target', gen_random_uuid()::text)));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TE-agg', 'cond', pg_temp.w14_refused_with(t, 'reference_missing'),
      'detail', 'transfer_event whose aggregate_id names no Work: ' || pg_temp.w14_say(t, 'refused reference_missing, none, at least 1')));
    t := pg_temp.w14_try('transfer_event', pg_temp.w14_recipe('transfer_event', jsonb_build_object('run', run,
           'sid', tag || '_TE-kind#1', 'target', w)) || '{"event_type": "usage_reading"}');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TE-kind', 'cond', pg_temp.w14_refused_with(t, 'invalid_field'),
      'detail', 'transfer_event of kind record_line with event_type usage_reading: ' || pg_temp.w14_say(t, 'refused invalid_field, none, at least 1')));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- FN-TE-staterow-pos (✔) and FN-TE-staterow (✘; b17): a ledger_state_row event is written only on the installation's
  -- Mission (EV-C02-013 3.2 and 25 (5)): on it, accepted, with its typed event on that Mission; on a Mission opened through
  -- open_mission (not the installation's, with a creation event), refused invalid_field. The two differ in the Mission named.
  blk := array['FN-TE-staterow-pos', 'FN-TE-staterow']; acc := '[]';
  begin
    if to_regprocedure('devos_api.transfer_event(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.transfer_event(jsonb) does not exist (FN-M-cat fails)'; end if;
    run := pg_temp.w14_begin(tag || '_run_tes');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    i := pg_temp.w14_install(run);
    om := pg_temp.w14_other_mission(true);
    t := pg_temp.w14_try('transfer_event', pg_temp.w14_recipe('transfer_event', jsonb_build_object('run', run, 'sid', tag || '_TES-inst',
           'kind', 'ledger_state_row', 'target', i ->> 'mission')) || '{"aggregate_type": "mission"}');
    k := pg_temp.w14_kind(t -> 'r');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TE-staterow-pos',
      'cond', case when k in ('test', 'raised', 'unknown') then null
                   else k = 'accepted' and exists (select 1 from jsonb_array_elements(t -> 'evs') e
                          where e ->> 'type' = 'ledger_state_row' and e ->> 'agg' = i ->> 'mission') end,
      'detail', 'transfer_event of kind ledger_state_row on the installation''s Mission: ' || pg_temp.w14_brief(t -> 'r')
        || '; new events ' || pg_temp.w14_types(t -> 'evs') || ' (wanted accepted, a ledger_state_row event on that Mission)'));
    t := pg_temp.w14_try('transfer_event', pg_temp.w14_recipe('transfer_event', jsonb_build_object('run', run, 'sid', tag || '_TES-other',
           'kind', 'ledger_state_row', 'target', om ->> 'mission')) || '{"aggregate_type": "mission"}');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TE-staterow',
      'cond', case when k <> 'accepted' then null else pg_temp.w14_refused_with(t, 'invalid_field') end,
      'detail', 'transfer_event of kind ledger_state_row on a Mission opened through open_mission: '
        || pg_temp.w14_say(t, 'refused invalid_field, none, at least 1') || '; its pair on the installation''s Mission: ' || k));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- FN-LE-owner (✘; b18, the checker's X2) and FN-LE-owner-cnc (✘; b18): record_ledger_entry applies Rule O's
  -- devos_kurulum clause (EV-C02-013 3.2 and 25 (6); EV-C02-008 1.7.1): a stage Work under a Mission opened through
  -- open_mission (not the installation's) is refused not_owner; one under a Mission with no creation event, which cannot be
  -- told the installation's or not, could_not_check (W-C02-09 point 7). Each differs from FN-T-ev-record_ledger_entry's
  -- call in the Mission its stage Work lies under.
  blk := array['FN-LE-owner', 'FN-LE-owner-cnc']; acc := '[]';
  begin
    if to_regprocedure('devos_api.record_ledger_entry(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.record_ledger_entry(jsonb) does not exist (FN-M-cat fails)'; end if;
    om := pg_temp.w14_other_mission(true);
    w := pg_temp.w14_plant('devos_private.work_revision', jsonb_build_object('mission_revision_id', om ->> 'mission_revision_id',
           'purpose', 'w14_fixture SYNTHETIC W-C02-14 a stage outside the installation')) ->> 'work_id';
    t := pg_temp.w14_try('record_ledger_entry', pg_temp.w14_recipe('record_ledger_entry', jsonb_build_object('sid', tag || '_LE-owner', 'stage', w)));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-LE-owner', 'cond', pg_temp.w14_refused_with(t, 'not_owner'),
      'detail', 'record_ledger_entry on a Work under a Mission opened through open_mission: ' || pg_temp.w14_say(t, 'refused not_owner, none, at least 1')));
    om := pg_temp.w14_other_mission(false);
    w := pg_temp.w14_plant('devos_private.work_revision', jsonb_build_object('mission_revision_id', om ->> 'mission_revision_id',
           'purpose', 'w14_fixture SYNTHETIC W-C02-14 a stage under a Mission with no creation event')) ->> 'work_id';
    t := pg_temp.w14_try('record_ledger_entry', pg_temp.w14_recipe('record_ledger_entry', jsonb_build_object('sid', tag || '_LE-cnc', 'stage', w)));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-LE-owner-cnc', 'cond', pg_temp.w14_refused_with(t, 'could_not_check'),
      'detail', 'record_ledger_entry on a Work under a Mission with no creation event: ' || pg_temp.w14_say(t, 'refused could_not_check, none, at least 1')));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- FN-TA-never (✘; b24) and FN-TA-scope (✘; b27), before the hand-over (EV-C02-013 3.2 and 25 (7)): transfer_artifact naming
  -- a run never begun is refused run_not_open; with a scope other than installation, invalid_field. Each differs from
  -- FN-T-ev-transfer_artifact's call in that.
  blk := array['FN-TA-never', 'FN-TA-scope']; acc := '[]';
  begin
    if to_regprocedure('devos_api.transfer_artifact(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.transfer_artifact(jsonb) does not exist (FN-M-cat fails)'; end if;
    run := pg_temp.w14_begin(tag || '_run_ta');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    t := pg_temp.w14_try('transfer_artifact', pg_temp.w14_recipe('transfer_artifact', jsonb_build_object('run', tag || '_run_ta_never_begun',
           'sid', tag || '_TA-never')));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TA-never', 'cond', pg_temp.w14_refused_with(t, 'run_not_open'),
      'detail', 'transfer_artifact naming a run never begun: ' || pg_temp.w14_say(t, 'refused run_not_open, none, at least 1')));
    t := pg_temp.w14_try('transfer_artifact', pg_temp.w14_recipe('transfer_artifact', jsonb_build_object('run', run,
           'sid', tag || '_TA-scope')) || '{"scope": "synthetic.w14fixture"}');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TA-scope', 'cond', pg_temp.w14_refused_with(t, 'invalid_field'),
      'detail', 'transfer_artifact with scope synthetic.w14fixture: ' || pg_temp.w14_say(t, 'refused invalid_field, none, at least 1')));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- After the planted hand-over (EV-C02-013 3.1 "Closing" and "The run" with R1-8; 3.2; 25 (7)): FN-TA-anchor (✘; b22) a
  -- git_file whose path holds a verdict file's form after another prefix is not a verdict file: refused handed_over;
  -- FN-TA-run-after (✘; b23) a verdict file sent with the run_id of a run begun before the hand-over: refused run_not_open;
  -- FN-TA-mark-after (✔; b26) the verdict file with no run_id is written and its transferred mark records "run_id": null
  -- and "after_handover": true. The first two differ from FN-O-transfer_artifact (accepted) in the path and in the run_id.
  blk := array['FN-TA-anchor', 'FN-TA-run-after', 'FN-TA-mark-after']; acc := '[]';
  begin
    if to_regprocedure('devos_api.transfer_artifact(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.transfer_artifact(jsonb) does not exist (FN-M-cat fails)'; end if;
    run := pg_temp.w14_begin(tag || '_run_ta_after');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    perform pg_temp.w14_handover();
    t := pg_temp.w14_try('transfer_artifact', pg_temp.w14_recipe('transfer_artifact', jsonb_build_object('sid', tag || '_TA-anchor',
           'artifact_kind', 'git_file', 'path', 'w14_fixture/' || vpath)));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TA-anchor', 'cond', pg_temp.w14_refused_with(t, 'handed_over'),
      'detail', 'after the hand-over, transfer_artifact of w14_fixture/ followed by a verdict file''s path: '
        || pg_temp.w14_say(t, 'refused handed_over, none, at least 1')));
    t := pg_temp.w14_try('transfer_artifact', pg_temp.w14_recipe('transfer_artifact', jsonb_build_object('run', run, 'sid', tag || '_TA-runafter',
           'artifact_kind', 'git_file', 'path', vpath)));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TA-run-after', 'cond', pg_temp.w14_refused_with(t, 'run_not_open'),
      'detail', 'after the hand-over, transfer_artifact of a verdict file with the run_id of a run begun before it: '
        || pg_temp.w14_say(t, 'refused run_not_open, none, at least 1')));
    t := pg_temp.w14_try('transfer_artifact', pg_temp.w14_recipe('transfer_artifact', jsonb_build_object('sid', tag || '_TA-markafter',
           'artifact_kind', 'git_file', 'path', vpath)));
    k := pg_temp.w14_kind(t -> 'r');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TA-mark-after',
      'cond', case when k in ('test', 'raised', 'unknown') then null
                   else k = 'accepted' and (select count(*) from jsonb_array_elements(t -> 'evs') e where e ->> 'type' = 'transferred'
                          and e -> 'payload' -> 'transfer_source' ->> 'source_id' = tag || '_TA-markafter'
                          and jsonb_typeof(e -> 'payload' -> 'run_id') = 'null' and e -> 'payload' -> 'after_handover' = 'true'::jsonb) = 1 end,
      'detail', 'after the hand-over, transfer_artifact of a verdict file with no run_id: ' || pg_temp.w14_brief(t -> 'r') || '; its '
        || 'mark''s run_id and after_handover: ' || coalesce((select string_agg(coalesce(e -> 'payload' ->> 'run_id', 'null') || '/'
        || coalesce(e -> 'payload' ->> 'after_handover', 'absent'), ',') from jsonb_array_elements(t -> 'evs') e where e ->> 'type' = 'transferred'), 'no mark')
        || ' (wanted accepted, one mark with null/true)'));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- FN-R-declared-<fn> (✔; the checker's X4): M09-10's six with role_class devos_denetim and origin owner added to the
  -- payload: accepted, and every event the call writes is devos_kurulum/call (W-C02-09 point 3, fifth bullet; point 5;
  -- EV-C02-005 S1: "role_class from the token"). It is FN-T-ev-<fn>'s call with the two keys added; a build that refuses the
  -- keys makes the case could_not_check (FN-R-declared's rule).
  foreach f in array array['begin_transfer_run', 'end_transfer_run', 'record_handover', 'transfer_event', 'record_ledger_entry',
                           'transfer_artifact'] loop
    acc := '[]';
    begin
      if to_regprocedure('devos_api.' || f || '(jsonb)') is null then
        raise exception using errcode = 'P0W17', message = 'devos_api.' || f || '(jsonb) does not exist (FN-M-cat fails)'; end if;
      if f = 'begin_transfer_run' then
        po := jsonb_build_object('run', tag || '_run_rd_' || f);
      else
        run := pg_temp.w14_begin(tag || '_run_rd_' || f);
        if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
        po := jsonb_build_object('run', run, 'sid', tag || '_RD-' || f) || pg_temp.w14_prep(f, run);
      end if;
      t := pg_temp.w14_try(f, pg_temp.w14_recipe(f, po) || '{"role_class": "devos_denetim", "origin": "owner"}');
      k := pg_temp.w14_kind(t -> 'r');
      acc := jsonb_build_array(jsonb_build_object('id', 'FN-R-declared-' || f,
        'cond', case when k <> 'accepted' then null
                     else jsonb_array_length(t -> 'evs') >= 1 and not exists (select 1 from jsonb_array_elements(t -> 'evs') e
                            where e ->> 'rc' is distinct from 'devos_kurulum' or e ->> 'origin' is distinct from 'call') end,
        'detail', format('%s with role_class devos_denetim and origin owner declared: %s; new events %s, roles/origins %s (wanted '
          || 'accepted, every event devos_kurulum/call; not accepted: could_not_check)', f, pg_temp.w14_brief(t -> 'r'),
          pg_temp.w14_types(t -> 'evs'), coalesce((select string_agg(distinct (e ->> 'rc') || '/' || (e ->> 'origin'), ',')
          from jsonb_array_elements(t -> 'evs') e), 'none'))));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when sqlstate 'P0W17' then acc := jsonb_build_array(jsonb_build_object('id', 'FN-R-declared-' || f, 'cond', null, 'detail', sqlerrm));
      when others then acc := jsonb_build_array(jsonb_build_object('id', 'FN-R-declared-' || f, 'cond', null, 'detail',
        'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;
end $$;

-- Added under ledger rule 3, 2026-10-19 (note N-303 with its L-398 annotation; CHK-C02-104 C2 and its X1; CHK-C02-104
-- C1 as CHK-C02-105 judged it built; EV-C02-014 13.4; EV-C02-013 26 (2) to (7)), before any result of this file: cases
-- for the rules of M09-11's six functions that EV-C02-014 13.4 lists as reached by no merged test (the producer's break
-- copies b03 to b06, b12, b14 to b18, b20, b23 to b25, b27, b28, b31, b32), the refusal of special and offset-less
-- answer times (C1), and transfer_mission's one-Mission advisory lock (X1; a structural case, see the specification's
-- "Not covered" (11)). New case IDs; every earlier case ID and expected outcome is kept. Each ✘ case differs from an
-- accepted call of this file (named in the specification) in one thing and wants the reason code EV-C02-013 3.2 and
-- section 26 give, with nothing written but rejected_attempt (+1 or more); another code, or an acceptance, is bad; a
-- raised answer, or a prerequisite not accepted, is the test's own could_not_check.
-- One row of a family table, as JSON (null when it names none).
create function pg_temp.w14_row(p_table text, p_where text, p_id text) returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  execute format('select to_jsonb(x) from %s x where x.%I::text = $1 limit 1', p_table, p_where) into r using p_id;
  return r;
end $f$;
-- The accepted-case judgement: null when the answer is outside interface v1 or the test's own, else accepted and p_more.
create function pg_temp.w14_accepted_and(t jsonb, p_more boolean) returns boolean language sql immutable as $f$
  select case when pg_temp.w14_kind(t -> 'r') in ('test', 'raised', 'unknown') then null
              else pg_temp.w14_kind(t -> 'r') = 'accepted' and coalesce(p_more, false) end
$f$;

do $$
declare tag text := pg_temp.w14_tag(); run text; acc jsonb; t jsonb; t2 jsonb; i jsonb; om jsonb; d jsonb; w text; w2 text;
        nd text; k text; ids text[]; blk text[]; nb bigint; nb2 bigint; row jsonb; src text; base jsonb; tz text;
begin
  if pg_temp.w14_pre() is not null then return; end if;  -- FN-pre is recorded by the first block
  ids := array['FN-TD-routine', 'FN-TD-openexp-pos', 'FN-TD-openexp', 'FN-TD-at-recorded', 'FN-TD-at-date', 'FN-TD-at-now',
               'FN-TD-at-infinity', 'FN-TD-at-nooffset', 'FN-TD-rev-accepted', 'FN-TD-rev-declined', 'FN-TD-rev-open',
               'FN-TM-second', 'FN-TM-time', 'FN-TM-lock', 'FN-TW-mission', 'FN-TW-routine', 'FN-TW-stale-pos', 'FN-TW-stale',
               'FN-TW-scope', 'FN-TW-element-pos', 'FN-TW-element', 'FN-TR-end', 'FN-TR-end-rev', 'FN-TR-rule', 'FN-TR-same',
               'FN-TN-mission', 'FN-TN-status', 'FN-TN-resolved', 'FN-TF-privacy', 'FN-TF-status'];
  if pg_temp.w14_handovers() > 0 then
    perform pg_temp.w14_rec(x, 'could_not_check', 'a ledger_handed_over event is already in this database, so the state '
      || 'before the hand-over cannot be planted') from unnest(ids) x;
    return;
  end if;

  -- transfer_decision (EV-C02-013 3.2 and 26 (5); B 3.17; DM-11; EV-C02-005 2.2 and 2.6). FN-TD-routine (✘; b03): class
  -- routine, invalid_field. FN-TD-openexp-pos (✔) and FN-TD-openexp (✘; b04): alternatives_state open_exploration with
  -- status answered and no options: with a single_viable_path_reason accepted, without it refused open_exploration.
  -- FN-TD-at-recorded (✔; the clock break): answered_at 2026-10-05T17:50:00Z is written as sent, never the clock (22 (1)).
  -- FN-TD-at-now, -at-infinity, -at-nooffset (✘; C1): answered_at now, infinity, 2026-10-05T17:50:00 (no offset):
  -- invalid_field. FN-TD-rev-accepted, -rev-declined (✔; b06): status accepted or declined, no answered_at:
  -- answered_revision 1. FN-TD-rev-open (✔): status open, no answered_at: answered_revision null. Each differs from
  -- FN-T-ev-transfer_decision's call (class high_impact, status answered, alternatives compared) in the one thing named.
  blk := array['FN-TD-routine', 'FN-TD-openexp-pos', 'FN-TD-openexp', 'FN-TD-at-recorded', 'FN-TD-at-now', 'FN-TD-at-infinity',
               'FN-TD-at-nooffset', 'FN-TD-rev-accepted', 'FN-TD-rev-declined', 'FN-TD-rev-open']; acc := '[]';
  begin
    if to_regprocedure('devos_api.transfer_decision(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.transfer_decision(jsonb) does not exist (FN-M-cat fails)'; end if;
    run := pg_temp.w14_begin(tag || '_run_td4');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    t := pg_temp.w14_try('transfer_decision', pg_temp.w14_recipe('transfer_decision', jsonb_build_object('run', run, 'sid', tag || '_TD-routine',
           'class', 'routine')));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TD-routine', 'cond', pg_temp.w14_refused_with(t, 'invalid_field'),
      'detail', 'transfer_decision of class routine: ' || pg_temp.w14_say(t, 'refused invalid_field, none, at least 1')));
    t := pg_temp.w14_try('transfer_decision', pg_temp.w14_recipe('transfer_decision', jsonb_build_object('run', run, 'sid', tag || '_TD-oe-pos'))
           || '{"alternatives_state": "open_exploration", "single_viable_path_reason": "w14_fixture SYNTHETIC W-C02-14 one path"}');
    k := pg_temp.w14_kind(t -> 'r');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TD-openexp-pos',
      'cond', pg_temp.w14_accepted_and(t, (t -> 'ch') ? 'decision' and pg_temp.w14_marks(tag || '_TD-oe-pos') = 1),
      'detail', 'transfer_decision, open_exploration, answered, no options, with a single_viable_path_reason: '
        || pg_temp.w14_brief(t -> 'r') || '; its marks ' || pg_temp.w14_marks(tag || '_TD-oe-pos') || ' (wanted accepted, 1)'));
    t := pg_temp.w14_try('transfer_decision', pg_temp.w14_recipe('transfer_decision', jsonb_build_object('run', run, 'sid', tag || '_TD-oe'))
           || '{"alternatives_state": "open_exploration"}');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TD-openexp',
      'cond', case when k <> 'accepted' then null else pg_temp.w14_refused_with(t, 'open_exploration') end,
      'detail', 'transfer_decision, open_exploration, answered, no options, no single_viable_path_reason: '
        || pg_temp.w14_say(t, 'refused open_exploration, none, at least 1') || '; its pair FN-TD-openexp-pos: ' || k));
    t := pg_temp.w14_try('transfer_decision', pg_temp.w14_recipe('transfer_decision', jsonb_build_object('run', run, 'sid', tag || '_TD-at'))
           || '{"answered_at": "2026-10-05T17:50:00Z"}');
    row := pg_temp.w14_row('devos_private.decision', 'id', pg_temp.w14_id(t -> 'r'));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TD-at-recorded',
      'cond', pg_temp.w14_accepted_and(t, (row ->> 'answered_at')::timestamptz = '2026-10-05T17:50:00Z'::timestamptz
                and (row ->> 'answered_revision')::int = 1),
      'detail', 'transfer_decision with answered_at 2026-10-05T17:50:00Z: ' || pg_temp.w14_brief(t -> 'r') || '; stored answered_at '
        || coalesce(row ->> 'answered_at', 'none') || ', answered_revision ' || coalesce(row ->> 'answered_revision', 'none')
        || ' (wanted accepted, that instant, 1)'));
    foreach src in array array['now', 'infinity', '2026-10-05T17:50:00'] loop
      t := pg_temp.w14_try('transfer_decision', pg_temp.w14_recipe('transfer_decision', jsonb_build_object('run', run,
             'sid', tag || '_TD-at-' || md5(src))) || jsonb_build_object('answered_at', src));
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TD-at-' || case src when 'now' then 'now' when 'infinity' then 'infinity'
          else 'nooffset' end, 'cond', case when pg_temp.w14_kind(t -> 'r') = 'accepted' then false
          else pg_temp.w14_refused_with(t, 'invalid_field') end,
        'detail', 'transfer_decision with answered_at "' || src || '": ' || pg_temp.w14_say(t, 'refused invalid_field, none, at least 1')
          || '; stored answered_at ' || coalesce(pg_temp.w14_row('devos_private.decision', 'id', pg_temp.w14_id(t -> 'r')) ->> 'answered_at', 'none')));
    end loop;
    foreach src in array array['accepted', 'declined', 'open'] loop
      t := pg_temp.w14_try('transfer_decision', pg_temp.w14_recipe('transfer_decision', jsonb_build_object('run', run,
             'sid', tag || '_TD-rev-' || src, 'status', src)));
      row := pg_temp.w14_row('devos_private.decision', 'id', pg_temp.w14_id(t -> 'r'));
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TD-rev-' || src,
        'cond', pg_temp.w14_accepted_and(t, row ->> 'status' = src and case when src = 'open' then row -> 'answered_revision' = 'null'::jsonb
                  else (row ->> 'answered_revision')::int = 1 end),
        'detail', 'transfer_decision of status ' || src || ', no answered_at: ' || pg_temp.w14_brief(t -> 'r') || '; stored status '
          || coalesce(row ->> 'status', 'none') || ', answered_revision ' || coalesce(row ->> 'answered_revision', 'null')
          || ' (wanted accepted, ' || case when src = 'open' then 'null' else '1' end || ')'));
    end loop;
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- FN-TD-at-date (✔; C1): answered_at 2026-10-07, a bare date, is read as 00:00 UTC whatever the session's TimeZone
  -- (EV-C02-013 26 (5) as CHK-C02-104 C1 had it built): under TimeZone Asia/Kolkata, set for this undone block only, it
  -- is stored as 2026-10-07T00:00:00Z. The first bytes' plain cast read it as midnight in the session's zone.
  blk := array['FN-TD-at-date']; acc := '[]'; tz := current_setting('TimeZone');
  begin
    if to_regprocedure('devos_api.transfer_decision(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.transfer_decision(jsonb) does not exist (FN-M-cat fails)'; end if;
    run := pg_temp.w14_begin(tag || '_run_td4d');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    perform set_config('TimeZone', 'Asia/Kolkata', true);
    t := pg_temp.w14_try('transfer_decision', pg_temp.w14_recipe('transfer_decision', jsonb_build_object('run', run, 'sid', tag || '_TD-date'))
           || '{"answered_at": "2026-10-07"}');
    row := pg_temp.w14_row('devos_private.decision', 'id', pg_temp.w14_id(t -> 'r'));
    acc := jsonb_build_array(jsonb_build_object('id', 'FN-TD-at-date',
      'cond', pg_temp.w14_accepted_and(t, (row ->> 'answered_at')::timestamptz = '2026-10-07T00:00:00Z'::timestamptz),
      'detail', 'under TimeZone Asia/Kolkata, transfer_decision with answered_at 2026-10-07: ' || pg_temp.w14_brief(t -> 'r')
        || '; stored answered_at ' || coalesce(row ->> 'answered_at', 'none') || ' (wanted accepted, 2026-10-07T00:00:00Z)'));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  if current_setting('TimeZone') is distinct from tz then
    acc := jsonb_build_array(jsonb_build_object('id', 'FN-TD-at-date', 'cond', null, 'detail', 'the test''s own TimeZone was not '
      || 'restored after its block (README section 3 (ii))'));
    perform set_config('TimeZone', tz, true);
  end if;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- transfer_mission (EV-C02-013 3.2 and 26 (2); EV-C02-005 2.1; 22 (1)). FN-TM-time (✔; b14): the installation's
  -- Mission transferred with a created_at key of 2001-01-01T00:00:00Z: accepted, and its revision's created_at is the
  -- database's time (this transaction's now()), not the call's. FN-TM-second (✘; b12): then a second transfer_mission,
  -- another source ID, on the same D-010 Decision: refused conflict, and one transferred Mission stays. Its pair is
  -- FN-MA-pos (the first Mission, accepted). Both need a database with no transferred Mission, else could_not_check.
  blk := array['FN-TM-time', 'FN-TM-second']; acc := '[]';
  begin
    if to_regprocedure('devos_api.transfer_mission(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.transfer_mission(jsonb) does not exist (FN-M-cat fails)'; end if;
    execute 'select count(*) from devos_private.event e where e.event_type::text = ''transferred'' and e.aggregate_type::text = ''mission'''
      into nb;
    if nb > 0 then raise exception using errcode = 'P0W17', message = 'a transferred Mission is already in this database, so a first '
      || 'transfer_mission cannot be made'; end if;
    run := pg_temp.w14_begin(tag || '_run_tm4');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    d := pg_temp.w14_d010(run);
    t := pg_temp.w14_try('transfer_mission', pg_temp.w14_recipe('transfer_mission', jsonb_build_object('run', run, 'sid', tag || '_TM-time') || d)
           || '{"created_at": "2001-01-01T00:00:00Z"}');
    execute 'select to_jsonb(x) from devos_private.mission_revision x where x.mission_id::text = $1 and x.revision = 1'
      into row using pg_temp.w14_id(t -> 'r');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TM-time',
      'cond', pg_temp.w14_accepted_and(t, (row ->> 'created_at')::timestamptz = now()),
      'detail', 'transfer_mission with created_at 2001-01-01T00:00:00Z sent: ' || pg_temp.w14_brief(t -> 'r') || '; its revision''s '
        || 'created_at is now(): ' || coalesce(((row ->> 'created_at')::timestamptz = now())::text, 'no revision row')
        || ' (wanted accepted, true)'));
    k := pg_temp.w14_kind(t -> 'r');
    t2 := pg_temp.w14_try('transfer_mission', pg_temp.w14_recipe('transfer_mission', jsonb_build_object('run', run, 'sid', tag || '_TM-second') || d));
    execute 'select count(distinct e.aggregate_id) from devos_private.event e where e.event_type::text = ''transferred'' and '
      || 'e.aggregate_type::text = ''mission''' into nb2;
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TM-second',
      'cond', case when k <> 'accepted' or pg_temp.w14_refused_with(t2, 'conflict') is null then null
                   else pg_temp.w14_refused_with(t2, 'conflict') and nb2 = 1 end,
      'detail', 'a second transfer_mission, another source ID, after the installation''s Mission: '
        || pg_temp.w14_say(t2, 'refused conflict, none, at least 1') || '; transferred Missions ' || nb2 || ' (wanted 1); the first: ' || k));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- FN-TM-lock (structural; CHK-C02-104's X1; EV-C02-013 26 (2): "The one-Mission check runs under advisory lock
  -- 9004"): transfer_mission's own text takes the transaction-level advisory lock with key 9004. One session cannot show
  -- that the lock orders two concurrent first calls ("Not covered" (11)); this case turns red when the lock is removed.
  begin
    if to_regprocedure('devos_api.transfer_mission(jsonb)') is null then
      perform pg_temp.w14_rec('FN-TM-lock', 'could_not_check', 'devos_api.transfer_mission(jsonb) does not exist (FN-M-cat fails)');
    else
      src := pg_get_functiondef('devos_api.transfer_mission(jsonb)'::regprocedure);
      src := regexp_replace(src, '[[:space:]]', '', 'g');
      perform pg_temp.w14_check('FN-TM-lock', position('pg_advisory_xact_lock(9004,' in src) > 0, 'transfer_mission''s text '
        || 'takes pg_advisory_xact_lock(9004, …): ' || (position('pg_advisory_xact_lock(9004,' in src) > 0)::text || ' (wanted true)');
    end if;
  exception when others then
    perform pg_temp.w14_rec('FN-TM-lock', 'could_not_check', 'the test stopped on its own error (README section 3 (ii)): '
      || sqlstate || ' ' || left(sqlerrm, 160));
  end;

  -- transfer_work (EV-C02-013 3.2 and 26 (3); B 3.3; EV-C02-005 1.2 rows 2, 3 and 1.4). Each differs from
  -- FN-T-ev-transfer_work's call (the installation's Mission at its current revision, scope installation, impact high, no
  -- elements) in one thing. FN-TW-mission (✘; b15): a Mission opened through open_mission: invalid_field.
  -- FN-TW-routine (✘; b16): impact_class routine: invalid_field. FN-TW-element-pos (✔) and FN-TW-element (✘; b20):
  -- input_refs naming a planted Work at revision 1: accepted; naming a planted Need: invalid_field.
  blk := array['FN-TW-mission', 'FN-TW-routine', 'FN-TW-element-pos', 'FN-TW-element']; acc := '[]';
  begin
    if to_regprocedure('devos_api.transfer_work(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.transfer_work(jsonb) does not exist (FN-M-cat fails)'; end if;
    run := pg_temp.w14_begin(tag || '_run_tw4');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    i := pg_temp.w14_install(run);
    om := pg_temp.w14_other_mission(true);
    t := pg_temp.w14_try('transfer_work', pg_temp.w14_recipe('transfer_work', jsonb_build_object('run', run, 'sid', tag || '_TW-mission',
           'mission', om ->> 'mission', 'mission_revision', 1)));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TW-mission', 'cond', pg_temp.w14_refused_with(t, 'invalid_field'),
      'detail', 'transfer_work under a Mission opened through open_mission: ' || pg_temp.w14_say(t, 'refused invalid_field, none, at least 1')));
    t := pg_temp.w14_try('transfer_work', pg_temp.w14_recipe('transfer_work', i || jsonb_build_object('run', run, 'sid', tag || '_TW-routine'))
           || '{"impact_class": "routine"}');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TW-routine', 'cond', pg_temp.w14_refused_with(t, 'invalid_field'),
      'detail', 'transfer_work with impact_class routine: ' || pg_temp.w14_say(t, 'refused invalid_field, none, at least 1')));
    w := pg_temp.w14_work();
    t := pg_temp.w14_try('transfer_work', pg_temp.w14_recipe('transfer_work', i || jsonb_build_object('run', run, 'sid', tag || '_TW-el-pos'))
           || jsonb_build_object('input_refs', jsonb_build_array(jsonb_build_object('ref', w, 'revision', 1))));
    k := pg_temp.w14_kind(t -> 'r');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TW-element-pos',
      'cond', pg_temp.w14_accepted_and(t, pg_temp.w14_marks(tag || '_TW-el-pos') = 2),
      'detail', 'transfer_work with input_refs naming a Work at revision 1: ' || pg_temp.w14_brief(t -> 'r') || '; marks of the source '
        || pg_temp.w14_marks(tag || '_TW-el-pos') || ' (wanted accepted, 2)'));
    nd := pg_temp.w14_plant('devos_private.need', '{}') ->> 'id';
    t := pg_temp.w14_try('transfer_work', pg_temp.w14_recipe('transfer_work', i || jsonb_build_object('run', run, 'sid', tag || '_TW-el'))
           || jsonb_build_object('input_refs', jsonb_build_array(jsonb_build_object('ref', nd, 'revision', 1))));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TW-element',
      'cond', case when k <> 'accepted' then null else pg_temp.w14_refused_with(t, 'invalid_field') end,
      'detail', 'transfer_work with input_refs naming a Need: ' || pg_temp.w14_say(t, 'refused invalid_field, none, at least 1')
        || '; its pair FN-TW-element-pos: ' || k));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- FN-TW-stale-pos (✔), FN-TW-stale (✘; b17) and FN-TW-scope (✘; b18): with a second revision of the installation's
  -- Mission planted by the owner (scope installation), transfer_work naming revision 2 is accepted and naming revision 1
  -- is refused stale_revision; in another undone block, with the second revision's scope synthetic.w14other, naming it
  -- is refused scope_outside (B principle 4: installation is not within synthetic.w14other).
  foreach src in array array['installation', 'synthetic.w14other'] loop
    blk := case when src = 'installation' then array['FN-TW-stale-pos', 'FN-TW-stale'] else array['FN-TW-scope'] end; acc := '[]';
    begin
      if to_regprocedure('devos_api.transfer_work(jsonb)') is null then
        raise exception using errcode = 'P0W17', message = 'devos_api.transfer_work(jsonb) does not exist (FN-M-cat fails)'; end if;
      run := pg_temp.w14_begin(tag || '_run_tw4r' || md5(src));
      if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
      i := pg_temp.w14_install(run);
      perform pg_temp.w14_plant('devos_private.mission_revision', jsonb_build_object('mission_id', i ->> 'mission',
        'revision', (i ->> 'mission_revision')::int + 1, 'scope', src, 'purpose', 'w14_fixture SYNTHETIC W-C02-14 a later revision'));
      if src = 'installation' then
        t := pg_temp.w14_try('transfer_work', pg_temp.w14_recipe('transfer_work', jsonb_build_object('run', run, 'sid', tag || '_TW-stale-pos',
               'mission', i ->> 'mission', 'mission_revision', (i ->> 'mission_revision')::int + 1)));
        k := pg_temp.w14_kind(t -> 'r');
        acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TW-stale-pos', 'cond', pg_temp.w14_accepted_and(t, true),
          'detail', 'transfer_work naming the Mission''s current revision (planted revision 2): ' || pg_temp.w14_brief(t -> 'r')
            || ' (wanted accepted)'));
        t := pg_temp.w14_try('transfer_work', pg_temp.w14_recipe('transfer_work', i || jsonb_build_object('run', run, 'sid', tag || '_TW-stale')));
        acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TW-stale',
          'cond', case when k <> 'accepted' then null else pg_temp.w14_refused_with(t, 'stale_revision') end,
          'detail', 'transfer_work naming the Mission''s earlier revision: ' || pg_temp.w14_say(t, 'refused stale_revision, none, at least 1')
            || '; its pair FN-TW-stale-pos: ' || k));
      else
        t := pg_temp.w14_try('transfer_work', pg_temp.w14_recipe('transfer_work', jsonb_build_object('run', run, 'sid', tag || '_TW-scope',
               'mission', i ->> 'mission', 'mission_revision', (i ->> 'mission_revision')::int + 1)));
        acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TW-scope', 'cond', pg_temp.w14_refused_with(t, 'scope_outside'),
          'detail', 'transfer_work of scope installation naming a Mission revision of scope synthetic.w14other: '
            || pg_temp.w14_say(t, 'refused scope_outside, none, at least 1')));
      end if;
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
      when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
        || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

  -- transfer_relation (EV-C02-013 3.2 and 26 (4); B 3.4; plan Section 9 / W-C02-09 point 6 for relation_rule). Each
  -- differs from FN-T-ev-transfer_relation's call (two planted Works at revision 1, type about, method mechanical) in
  -- one thing. FN-TR-end (✘; b24): from_ref names no record: reference_missing. FN-TR-end-rev (✘; b24): to_revision 2 of
  -- a Work with one revision: reference_missing. FN-TR-rule (✘; b25): method model_extracted with epistemic_status
  -- observation: relation_rule. FN-TR-same (✘; b23): after that call accepted, the same relation (type, ends, revisions,
  -- hard, group, use) under another source ID: refused conflict, no second Relation.
  blk := array['FN-TR-end', 'FN-TR-end-rev', 'FN-TR-rule', 'FN-TR-same']; acc := '[]';
  begin
    if to_regprocedure('devos_api.transfer_relation(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.transfer_relation(jsonb) does not exist (FN-M-cat fails)'; end if;
    run := pg_temp.w14_begin(tag || '_run_tr4');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    w := pg_temp.w14_work(); w2 := pg_temp.w14_work();
    t := pg_temp.w14_try('transfer_relation', pg_temp.w14_recipe('transfer_relation', jsonb_build_object('run', run, 'sid', tag || '_TR-end',
           'from', gen_random_uuid()::text, 'to', w2)));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TR-end', 'cond', pg_temp.w14_refused_with(t, 'reference_missing'),
      'detail', 'transfer_relation whose from_ref names no record: ' || pg_temp.w14_say(t, 'refused reference_missing, none, at least 1')));
    t := pg_temp.w14_try('transfer_relation', pg_temp.w14_recipe('transfer_relation', jsonb_build_object('run', run, 'sid', tag || '_TR-endrev',
           'from', w, 'to', w2)) || '{"to_revision": 2}');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TR-end-rev', 'cond', pg_temp.w14_refused_with(t, 'reference_missing'),
      'detail', 'transfer_relation naming to_revision 2 of a Work with one revision: ' || pg_temp.w14_say(t, 'refused reference_missing, none, at least 1')));
    t := pg_temp.w14_try('transfer_relation', pg_temp.w14_recipe('transfer_relation', jsonb_build_object('run', run, 'sid', tag || '_TR-rule',
           'from', w, 'to', w2)) || '{"method": "model_extracted", "epistemic_status": "observation"}');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TR-rule', 'cond', pg_temp.w14_refused_with(t, 'relation_rule'),
      'detail', 'transfer_relation with method model_extracted and epistemic_status observation: '
        || pg_temp.w14_say(t, 'refused relation_rule, none, at least 1')));
    t := pg_temp.w14_try('transfer_relation', pg_temp.w14_recipe('transfer_relation', jsonb_build_object('run', run, 'sid', tag || '_TR-same-1',
           'from', w, 'to', w2)));
    k := pg_temp.w14_kind(t -> 'r');
    t2 := pg_temp.w14_try('transfer_relation', pg_temp.w14_recipe('transfer_relation', jsonb_build_object('run', run, 'sid', tag || '_TR-same-2',
           'from', w, 'to', w2)));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TR-same',
      'cond', case when k <> 'accepted' then null else pg_temp.w14_refused_with(t2, 'conflict') and pg_temp.w14_marks(tag || '_TR-same-2') = 0 end,
      'detail', 'the same relation again under another source ID: ' || pg_temp.w14_say(t2, 'refused conflict, none, at least 1')
        || '; marks of the second source ' || pg_temp.w14_marks(tag || '_TR-same-2') || ' (wanted 0); the first: ' || k));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- transfer_need (EV-C02-013 3.2 and 26 (6); B 3.2) and transfer_finding (3.2 and 26 (7); B 3.8; EV-C02-005 1.2 row 15).
  -- Each differs from FN-T-ev-transfer_need's or FN-T-ev-transfer_finding's call in one thing. FN-TN-mission (✘; b27): a
  -- Mission opened through open_mission: invalid_field. FN-TN-status (✘; b28): status investigating: invalid_field.
  -- FN-TN-resolved (✔): status resolved: accepted, +1 need. FN-TF-privacy (✘; b31): privacy_class private:
  -- invalid_field. FN-TF-status (✘; b32): status reviewed: invalid_field.
  blk := array['FN-TN-mission', 'FN-TN-status', 'FN-TN-resolved', 'FN-TF-privacy', 'FN-TF-status']; acc := '[]';
  begin
    if to_regprocedure('devos_api.transfer_need(jsonb)') is null or to_regprocedure('devos_api.transfer_finding(jsonb)') is null then
      raise exception using errcode = 'P0W17', message = 'devos_api.transfer_need(jsonb) or transfer_finding(jsonb) does not exist (FN-M-cat fails)'; end if;
    run := pg_temp.w14_begin(tag || '_run_tn4');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    i := pg_temp.w14_install(run);
    om := pg_temp.w14_other_mission(true);
    t := pg_temp.w14_try('transfer_need', pg_temp.w14_recipe('transfer_need', jsonb_build_object('run', run, 'sid', tag || '_TN-mission',
           'mission', om ->> 'mission')));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TN-mission', 'cond', pg_temp.w14_refused_with(t, 'invalid_field'),
      'detail', 'transfer_need under a Mission opened through open_mission: ' || pg_temp.w14_say(t, 'refused invalid_field, none, at least 1')));
    t := pg_temp.w14_try('transfer_need', pg_temp.w14_recipe('transfer_need', i || jsonb_build_object('run', run, 'sid', tag || '_TN-status'))
           || '{"status": "investigating"}');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TN-status', 'cond', pg_temp.w14_refused_with(t, 'invalid_field'),
      'detail', 'transfer_need with status investigating: ' || pg_temp.w14_say(t, 'refused invalid_field, none, at least 1')));
    t := pg_temp.w14_try('transfer_need', pg_temp.w14_recipe('transfer_need', i || jsonb_build_object('run', run, 'sid', tag || '_TN-resolved'))
           || '{"status": "resolved"}');
    row := pg_temp.w14_row('devos_private.need', 'id', pg_temp.w14_id(t -> 'r'));
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TN-resolved',
      'cond', pg_temp.w14_accepted_and(t, row ->> 'status' = 'resolved' and pg_temp.w14_marks(tag || '_TN-resolved') = 1),
      'detail', 'transfer_need with status resolved: ' || pg_temp.w14_brief(t -> 'r') || '; stored status ' || coalesce(row ->> 'status', 'none')
        || ' (wanted accepted, resolved)'));
    t := pg_temp.w14_try('transfer_finding', pg_temp.w14_recipe('transfer_finding', jsonb_build_object('run', run, 'sid', tag || '_TF-privacy'))
           || '{"privacy_class": "private"}');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TF-privacy', 'cond', pg_temp.w14_refused_with(t, 'invalid_field'),
      'detail', 'transfer_finding with privacy_class private: ' || pg_temp.w14_say(t, 'refused invalid_field, none, at least 1')));
    t := pg_temp.w14_try('transfer_finding', pg_temp.w14_recipe('transfer_finding', jsonb_build_object('run', run, 'sid', tag || '_TF-status'))
           || '{"status": "reviewed"}');
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-TF-status', 'cond', pg_temp.w14_refused_with(t, 'invalid_field'),
      'detail', 'transfer_finding with status reviewed: ' || pg_temp.w14_say(t, 'refused invalid_field, none, at least 1')));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm)) from unnest(blk) x);
    when others then acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', 'the test stopped on its own error '
      || '(README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160))) from unnest(blk) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
end $$;

select case_id, outcome, detail from w14_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w14_results;
  if nb > 0 then
    raise exception 'W14_FN_TRANSFER_FUNCTIONS FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W14_FN_TRANSFER_FUNCTIONS COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W14_FN_TRANSFER_FUNCTIONS PASS (%/%)', n, n;
end $$;

rollback;
