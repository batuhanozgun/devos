-- Synthetic test data (plan Section 8 item 13): every Mission, decision, work item, relation, exam run, effort policy and
-- claim below is made up for this test, labelled SYNTHETIC W-C02-07 or w07_fixture, and holds no personal or business
-- data and no credential. Tokens are issued at run time inside this rolled-back transaction, kept in a PL/pgSQL variable
-- only, and never stored, printed, compared or put in an error text; a claim token's value is replaced before any answer
-- is kept (README section 6).
--
-- Claim. T-W07-N08 part X (phase C4b; EV-C02-008 section 5.1, N-262, decided and accepted; PC-47 place 1, B:286): the
-- exam fact reaches no token but the exam environment's through an answer. An exam task opened with devos_sinav and
-- named by an EvalRun through record_eval_run gets, from every function the working session calls, the answer an
-- ordinary work item opened with devos_calisma gets (property P; EXF-pair-*); the nine functions the reader finder of part
-- A exempts give the working, audit, devos_kurulum and devos_ci tokens the same answer with or without an EvalRun
-- (N08-x-<function>-<class>); record_eval_run writes nothing on the Work it names (N08-s3); devos_sinav claims no work
-- item, and no EvalRun names a work item a devos_sinav claim is on (N08-s4).
-- Specification: tests/C02/W-C02-07/T-W07-N08_exam_records.md, part X.
-- Where it runs: the migration job's devos-test step, as postgres, after the merge's migrations (README 5.1 (a)); the
-- break harness's throwaway PostgreSQL (README 5.2). Transport sql-set-role: each call runs as anon with the token header
-- simulated by set_config('request.headers', ..., true), so session_user stays postgres.
-- Interface assumed: the specification's "Interface assumed" (README section 8.1; revised before a first result if the
-- build chooses another form, README section 8).
-- Safety: everything runs inside begin ... rollback; nothing is committed. Each pair's steps run in a subtransaction
-- undone after them, so every pair starts from the same fixtures. No psql meta-command is used.
-- Output: one row per case (case_id, outcome, detail), then W07_N08_EXAM_FACT PASS as a notice, or FAIL / COULD NOT CHECK
-- as an exception (README section 3). Before the build exists it gives COULD NOT CHECK.
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '180s';

-- Common helpers of Group C (copied from w07_roc_ownership_and_claim_class.sql, README section 7, with five more call
-- forms in w07_sig and w07_call for README 8.1's heartbeat and release (claim_token text), ready_works(), affected_entities
-- (root uuid, limits jsonb) and explain_paths(root uuid, target uuid, limits jsonb); source: Group C's prelude, which
-- follows W-C02-03's w03_drift_could_not_check.sql for the results table, the subtransactions and the final block).
create temp table w07_results (case_id text primary key, outcome text not null, detail text not null);
create temp table w07_fx (k text primary key, v text not null);
create temp sequence w07_seq;

create function pg_temp.w07_put(p_id text, p_outcome text, p_detail text) returns void language plpgsql as $f$
begin
  insert into w07_results values (p_id, p_outcome, left(coalesce(p_detail, ''), 700))
  on conflict (case_id) do update set
    outcome = case when 'bad' in (w07_results.outcome, excluded.outcome) then 'bad'
                   when 'could_not_check' in (w07_results.outcome, excluded.outcome) then 'could_not_check' else 'ok' end,
    detail = left(w07_results.detail || ' | ' || excluded.detail, 1000);
end $f$;
create function pg_temp.w07_rec(p_id text, p_ok boolean, p_detail text) returns void language plpgsql as $f$
begin perform pg_temp.w07_put(p_id, case when p_ok then 'ok' else 'bad' end, p_detail); end $f$;

-- Returns the reason when an object the file needs is absent (W-C02-03's w03_pre()).
-- Interface v1 (README section 8): a record writer takes p jsonb; an effect takes (claim_token text, p jsonb); claim
-- takes (work_id uuid, declared_session_id text).
create function pg_temp.w07_sig(p_fn text) returns text language sql immutable as $f$
  select case p_fn when 'claim' then '(uuid,text)' when 'register_artifact' then '(text,jsonb)'
                   when 'prepare_operation' then '(text,jsonb)'
                   when 'mark_stale' then '(uuid,text)' when 'cancel_work' then '(uuid,text)'
                   when 'reopen_for_review' then '(uuid,text)' when 'retract_relation' then '(uuid,text)'
                   when 'heartbeat' then '(text)' when 'release' then '(text)' when 'ready_works' then '()'
                   when 'affected_entities' then '(uuid,jsonb)' when 'explain_paths' then '(uuid,uuid,jsonb)'
                   else '(jsonb)' end
$f$;

create function pg_temp.w07_pre(p_fns text[], p_tbls text[]) returns text language plpgsql as $f$
declare x text;
begin
  if to_regprocedure('devos_private.issue_env_token(text)') is null then
    return 'devos_private.issue_env_token(text) does not exist'; end if;
  foreach x in array p_fns loop
    if to_regprocedure('devos_api.' || x || pg_temp.w07_sig(x)) is null then
      return 'devos_api.' || x || pg_temp.w07_sig(x) || ' does not exist'; end if;
  end loop;
  foreach x in array p_tbls loop
    if to_regclass('devos_private.' || x) is null then return 'devos_private.' || x || ' does not exist'; end if;
  end loop;
  if not exists (select 1 from pg_roles where rolname = 'anon') then return 'role anon does not exist'; end if;
  return null;
end $f$;

-- One call as a role class (README 5.1 (a)): a synthetic token issued as owner inside this rolled-back transaction,
-- kept only in a variable, sent in the simulated header; the call runs as anon (the role the publishable key
-- reaches). The token is never stored, printed or compared. A refusal raised instead of returned counts as refused.
create function pg_temp.w07_call(p_class text, p_fn text, p_args jsonb) returns jsonb language plpgsql as $f$
declare tok text; r jsonb; st text; msg text; cu text;
begin
  if p_class is null then
    perform set_config('request.headers', '{}', true);
  else
    begin
      execute 'select devos_private.issue_env_token($1)::text' into tok using p_class;
      if left(tok, 1) = '{' then tok := (tok::jsonb)->>'token'; end if;
    exception when others then
      return jsonb_build_object('w07_cnc', 'a synthetic token of class ' || p_class || ' could not be issued: ' || sqlstate);
    end;
    perform set_config('request.headers', json_build_object('x-devos-env-token', tok)::text, true);
    tok := null;
  end if;
  begin
    execute 'set local role anon';
    if p_fn = 'claim' then
      execute 'select devos_api.claim(($1->>''work_id'')::uuid, $1->>''declared_session_id'')' into r using p_args;
    elsif p_fn in ('mark_stale', 'cancel_work', 'reopen_for_review') then  -- README 8.1: (work_id uuid, reason text)
      execute format('select devos_api.%I(($1->>''work_id'')::uuid, $1->>''reason'')', p_fn) into r using p_args;
    elsif p_fn = 'retract_relation' then  -- README 8.1: (relation_id uuid, reason text)
      execute 'select devos_api.retract_relation(($1->>''relation_id'')::uuid, $1->>''reason'')' into r using p_args;
    elsif p_fn in ('heartbeat', 'release') then  -- README 8.1: (claim_token text)
      execute format('select devos_api.%I($1->>''claim_token'')', p_fn) into r using p_args;
    elsif p_fn = 'ready_works' then  -- README 8.1: ready_works()
      execute 'select devos_api.ready_works()' into r;
    elsif p_fn = 'affected_entities' then  -- README 8.1: affected_entities(root uuid, limits jsonb)
      execute 'select devos_api.affected_entities(($1->>''root'')::uuid, $1->''limits'')' into r using p_args;
    elsif p_fn = 'explain_paths' then  -- README 8.1: explain_paths(root uuid, target uuid, limits jsonb)
      execute 'select devos_api.explain_paths(($1->>''root'')::uuid, ($1->>''target'')::uuid, $1->''limits'')' into r using p_args;
    elsif p_fn in ('register_artifact', 'prepare_operation') then
      execute format('select devos_api.%I($1->>''claim_token'', $1 - ''claim_token'')', p_fn) into r using p_args;
    else
      execute format('select devos_api.%I($1)', p_fn) into r using p_args;
    end if;
    cu := current_user;
    execute 'reset role';
  exception when others then
    get stacked diagnostics st = returned_sqlstate, msg = message_text;
    r := jsonb_build_object('status', 'refused', 'raised', true, 'sqlstate', st, 'message', left(msg, 160));
    cu := 'anon';
  end;
  perform set_config('request.headers', '{}', true);
  if r is null or jsonb_typeof(r) <> 'object' then
    r := jsonb_build_object('status', 'unknown', 'raw', left(coalesce(r::text, 'null'), 60)); end if;
  return r || jsonb_build_object('w07_user', cu, 'w07_session_user', session_user);
end $f$;

create function pg_temp.w07_kind(r jsonb) returns text language sql immutable as $f$
  select case
    when r ? 'w07_cnc' then 'test_cnc'
    when r ? 'raised' then 'unknown'  -- interface v1: a refusal is returned, never raised (EV-C02-002 DM-19 (a))
    when r->>'status' = 'refused' and r->>'reason_code' = 'could_not_check' then 'could_not_check'
    when r->>'status' = 'refused' then 'refused'
    when r->>'status' = 'ok' then 'accepted'
    else 'unknown' end $f$;
create function pg_temp.w07_why(r jsonb) returns text language sql immutable as $f$
  select lower(concat_ws(' ', r->>'reason_code', r->>'field', r->>'missing', r->>'check', r->>'reason', r->>'message',
                         r->>'sqlstate')) $f$;
create function pg_temp.w07_brief(r jsonb) returns text language sql immutable as $f$
  select concat_ws(' ', pg_temp.w07_kind(r), '[' || nullif(pg_temp.w07_why(r), '') || ']', 'as ' || (r->>'w07_user'),
                   'session_user ' || (r->>'w07_session_user')) $f$;
-- Every entry must match; an entry 'a|b' matches when a or b is in the reason.
create function pg_temp.w07_match(r jsonb, p_why text[]) returns boolean language plpgsql immutable as $f$
declare e text; ok boolean;
begin
  if p_why is null then return true; end if;
  foreach e in array p_why loop
    select bool_or(strpos(pg_temp.w07_why(r), lower(a)) > 0) into ok from unnest(string_to_array(e, '|')) a;
    if not ok then return false; end if;
  end loop;
  return true;
end $f$;
create function pg_temp.w07_count(p_tbl text) returns bigint language plpgsql as $f$
declare n bigint;
begin execute format('select count(*) from devos_private.%I', p_tbl) into n; return n; end $f$;

-- p_want: accepted | refused | could_not_check. p_tbl: the family table that must not change on a refusal and must
-- gain one row on an acceptance.
create function pg_temp.w07_expect(p_case text, p_class text, p_fn text, p_args jsonb, p_want text,
                                   p_why text[] default null, p_tbl text default null) returns jsonb language plpgsql as $f$
declare n0 bigint; n1 bigint; r jsonb; k text; ok boolean;
begin
  if p_tbl is not null then n0 := pg_temp.w07_count(p_tbl); end if;
  r := pg_temp.w07_call(p_class, p_fn, p_args);
  k := pg_temp.w07_kind(r);
  if k = 'test_cnc' then perform pg_temp.w07_put(p_case, 'could_not_check', r->>'w07_cnc'); return r; end if;
  if k = 'unknown' then  -- not an answer of interface v1 (README section 8): the test's own could not check
    perform pg_temp.w07_put(p_case, 'could_not_check', format('%s with %s: not an answer of interface v1: %s', p_fn,
      coalesce(p_class, 'no token'), pg_temp.w07_brief(r)));
    return r;
  end if;
  ok := k = p_want and (p_want = 'accepted' or pg_temp.w07_match(r, p_why));
  if p_tbl is not null then
    n1 := pg_temp.w07_count(p_tbl);
    if p_want <> 'accepted' and n1 <> n0 then ok := false; end if;
    if p_want = 'accepted' and n1 <> n0 + 1 then ok := false; end if;
  end if;
  perform pg_temp.w07_rec(p_case, ok, format('%s with %s: wanted %s%s; got %s%s', p_fn, coalesce(p_class, 'no token'), p_want,
    coalesce(' naming ' || array_to_string(p_why, ' and '), ''), pg_temp.w07_brief(r),
    case when p_tbl is not null then format('; %s rows %s -> %s', p_tbl, n0, n1) else '' end));
  return r;
end $f$;

-- Sample reviews whose row names the record's id; p_queued: only those queued for the audit environment (a field
-- of the review row holds devos_denetim).
create function pg_temp.w07_samples(p_id text, p_queued boolean default true) returns int language plpgsql as $f$
declare n int;
begin
  select count(*) into n from devos_private.review r
   where r.kind::text = 'sample' and strpos(to_jsonb(r)::text, p_id) > 0
     and (not p_queued or exists (select 1 from jsonb_each_text(to_jsonb(r)) e where e.value = 'devos_denetim'));
  return n;
end $f$;
create function pg_temp.w07_samples_all() returns int language plpgsql as $f$
declare n int;
begin select count(*) into n from devos_private.review r where r.kind::text = 'sample'; return n; end $f$;

create function pg_temp.w07_fn(p_family text) returns text language sql immutable as $f$
  select case p_family when 'need' then 'record_need' when 'decision' then 'open_decision'
    when 'decision_routine' then 'open_decision' when 'effort_policy' then 'set_effort_policy'
    when 'finding' then 'record_finding' when 'work' then 'admit_work' end $f$;

create function pg_temp.w07_rev(p_id text) returns int language plpgsql as $f$
declare n int;
begin select max(revision) into n from devos_private.decision_revision where decision_id::text = p_id; return n; end $f$;

-- Owner-level state change of a decision (the path the ledger transfer and C06 take is not built here; DM-11 and
-- DM-46 make the rules the decision's own). Returns null, or the error that refused it.
create function pg_temp.w07_set_status(p_id text, p_status text, p_rev int) returns text language plpgsql as $f$
declare sets text := format('status = %L', p_status); c text; st text; msg text;
begin
  if p_status = 'answered' then
    sets := sets || format(', answered_revision = %s', coalesce(p_rev::text, 'null'));
    for c in select column_name from information_schema.columns where table_schema = 'devos_private'
              and table_name = 'decision' and column_name in ('answered_at', 'answered_by', 'answer_channel_ref', 'answer',
              'answer_original_tr', 'answer_interpretation_en') loop
      sets := sets || ', ' || quote_ident(c) || ' = ' || case c when 'answered_at' then 'now()'
        else quote_literal('w07_fixture SYNTHETIC W-C02-07 ' || c) end;
    end loop;
  end if;
  begin
    execute format('update devos_private.decision set %s where id::text = %L', sets, p_id);
  exception when others then
    get stacked diagnostics st = returned_sqlstate, msg = message_text;
    return st || ' ' || left(msg, 160);
  end;
  return null;
end $f$;
create function pg_temp.w07_dec_state(p_id text) returns text language plpgsql as $f$
declare s text;
begin
  execute format('select concat_ws('' '', ''status'', status, ''answered_revision'', coalesce(answered_revision::text, ''null'')) from devos_private.decision where id::text = %L', p_id) into s;
  return coalesce(s, 'absent');
end $f$;

-- A copy of the current revision with p_changes, as the next revision (owner level). Returns null or the error.
create function pg_temp.w07_new_revision(p_id text, p_changes jsonb) returns text language plpgsql as $f$
declare cur int := pg_temp.w07_rev(p_id); ch jsonb; cols text; st text; msg text;
begin
  ch := p_changes || jsonb_build_object('revision', cur + 1);
  select string_agg(quote_ident(column_name), ', ' order by ordinal_position) into cols
    from information_schema.columns where table_schema = 'devos_private' and table_name = 'decision_revision'
     and not (column_name = 'id' and (column_default is not null or is_identity = 'YES'));
  if exists (select 1 from information_schema.columns where table_schema = 'devos_private' and table_name = 'decision_revision'
             and column_name = 'id' and column_default is null and is_identity = 'NO' and data_type = 'uuid') then
    ch := ch || jsonb_build_object('id', gen_random_uuid()); end if;
  begin
    execute format('insert into devos_private.decision_revision (%s) select %s from (select (jsonb_populate_record(null::devos_private.decision_revision, to_jsonb(r) || %L::jsonb)).* from devos_private.decision_revision r where r.decision_id::text = %L and r.revision = %s) s',
                   cols, cols, ch, p_id, cur);
  exception when others then
    get stacked diagnostics st = returned_sqlstate, msg = message_text;
    return st || ' ' || left(msg, 160);
  end;
  return null;
end $f$;

-- Inserts one owner-level fixture row; NOT NULL columns without a default get synthetic values by type (as
-- W-C02-03's w03_plant_function).
create function pg_temp.w07_plant_row(p_tbl text, p_base jsonb) returns void language plpgsql as $f$
declare cols text := ''; vals text := ''; c record; k text;
begin
  for k in select jsonb_object_keys(p_base) loop
    cols := cols || ', ' || quote_ident(k); vals := vals || ', ' || quote_literal(p_base->>k) || '::' ||
      (select format_type(a.atttypid, a.atttypmod) from pg_attribute a where a.attrelid = ('devos_private.' || p_tbl)::regclass and a.attname = k);
  end loop;
  for c in select column_name, data_type, udt_name from information_schema.columns
           where table_schema = 'devos_private' and table_name = p_tbl and is_nullable = 'NO' and column_default is null
             and is_identity = 'NO' and is_generated = 'NEVER' and not (p_base ? column_name) order by ordinal_position loop
    cols := cols || ', ' || quote_ident(c.column_name);
    vals := vals || ', ' || case
      when c.data_type in ('text', 'character varying', 'character') then quote_literal('w07_fixture SYNTHETIC W-C02-07')
      when c.data_type in ('integer', 'bigint', 'smallint', 'numeric') then '1'
      when c.data_type like 'timestamp%' then 'now()'
      when c.data_type = 'boolean' then 'false'
      when c.data_type in ('json', 'jsonb') then quote_literal('[]') || '::' || c.data_type
      when c.data_type = 'uuid' then 'gen_random_uuid()'
      when c.data_type = 'ARRAY' then quote_literal('{}') || '::' || quote_ident(ltrim(c.udt_name, '_')) || '[]'
      else 'null' end;
  end loop;
  execute format('insert into devos_private.%I (%s) values (%s)', p_tbl, substr(cols, 3), substr(vals, 3));
end $f$;

-- Arguments of one record of a family. p_kind: complete | fbm1 | fbm2 | fbm_alt (fbm1 and fbm2 by turns) |
-- trigger (routine items and decisions that only a declared trigger makes high-impact). p_class: the decision's
-- class, or the work item's impact class.
create function pg_temp.w07_args(p_family text, p_kind text, p_i int, p_class text default 'high_impact') returns jsonb
language plpgsql as $f$
declare a jsonb; k text := p_kind; lab text;
begin
  if k = 'fbm_alt' then k := case when p_i % 2 = 1 then 'fbm1' else 'fbm2' end; end if;
  lab := 'SYNTHETIC W-C02-07 w07_fixture ' || p_family || ' ' || k || ' ' || p_i;
  if p_family = 'need' then
    a := jsonb_build_object('mission_ref', pg_temp.w07_mission(), 'condition', lab || ': the version of the w07_fixture schema is unknown',
      'origin', 'goal', 'why_needed', lab || ': without it the w07_fixture migration would target the wrong schema version',
      'alternatives', jsonb_build_array(lab || ': proceed and accept the risk of a failed migration'), 'status', 'open');
    if k = 'fbm1' then a := a || '{"why_needed": "-"}';
    elsif k = 'fbm2' then a := a || '{"why_needed": "SYNTHETIC W-C02-07: it is needed because it is needed"}'; end if;
  elsif p_family = 'decision' then
    a := jsonb_build_object('class', p_class, 'question', lab || ': which storage form for the w07_fixture table?',
      'why_this_owner', lab || ': the schema rule makes it high_impact',
      'options', jsonb_build_array(
        jsonb_build_object('description', 'w07_fixture form A', 'purpose', 'store', 'benefit', 'simple', 'cost', 'low', 'risk', 'low'),
        jsonb_build_object('description', 'w07_fixture form B', 'purpose', 'store', 'benefit', 'fast', 'cost', 'medium', 'risk', 'medium')),
      'alternatives_considered', jsonb_build_array('w07_fixture form A', 'w07_fixture form B'), 'alternatives_state', 'compared',
      'criteria', jsonb_build_array(lab || ': query cost'), 'evidence_refs', jsonb_build_array('w07_fixture_evidence_' || p_i),
      'assumptions', jsonb_build_array(lab || ': a low write rate'), 'premises', jsonb_build_array(lab || ': one writer per table'),
      'reversibility', lab || ': reversible by a later w07_fixture migration',
      'reopen_triggers', jsonb_build_array(lab || ': more than 100 writes per second'),
      'recommendation', 'w07_fixture form A', 'recommendation_rationale', lab || ': simpler at the same cost', 'status', 'open');
    if p_class = 'batu' then a := a || jsonb_build_object('presented_text_tr', 'SENTETIK W-C02-07 deneme metni ' || p_i); end if;
    if k = 'fbm1' then a := a || '{"criteria": ["x"], "premises": ["x"], "assumptions": ["x"], "reopen_triggers": ["x"], "reversibility": "x"}';
    elsif k = 'fbm2' then a := a || '{"alternatives_state": "single_viable_path", "options": [], "single_viable_path_reason": "SYNTHETIC W-C02-07: it is the only way because there is no other way"}';
    elsif k = 'single' then a := a || jsonb_build_object('alternatives_state', 'single_viable_path', 'options', '[]'::jsonb,
         'single_viable_path_reason', lab || ': only form A fits the existing w07_fixture foreign keys; form B would break them');
    elsif k = 'open_exploration' then a := a || '{"alternatives_state": "open_exploration", "options": []}';
    end if;
  elsif p_family = 'decision_routine' then
    a := jsonb_build_object('class', 'routine', 'question', lab || ': which wording for the w07_fixture label?',
      'why_this_owner', lab || ': a wording choice', 'status', 'open');
    if k = 'trigger' then a := a || jsonb_build_object('question', lab || ': change a column of the w07_fixture schema (declared trigger: schema)'); end if;
  elsif p_family = 'effort_policy' then
    a := jsonb_build_object('work_ref', pg_temp.w07_work('high'), 'level', 'high',
      'expert_assessment_ref', lab || ': expert assessment of the w07_fixture item: a schema change, high effort',
      'non_removable_steps', '["verification", "alternatives_research", "external_source_research"]'::jsonb, 'status', 'active');
    if k = 'fbm1' then a := a || '{"expert_assessment_ref": "n/a"}';
    elsif k = 'fbm2' then a := a || '{"expert_assessment_ref": "SYNTHETIC W-C02-07 lorem ipsum dolor, unrelated to the item"}'; end if;
  elsif p_family = 'finding' then
    a := jsonb_build_object('claim', lab || ': the w07_fixture parser accepts UTF-8 input',
      'source_spans', jsonb_build_array(jsonb_build_object('source', 'w07_fixture_source', 'span', '1-2', 'primary', true, 'read_at', '2026-10-12')),
      'counter_evidence_searched', lab || ': searched the w07_fixture issue list for contrary reports; none found',
      'confidence', 'medium', 'changeable', false, 'privacy_class', 'public', 'scope', 'synthetic.w07_fixture', 'status', 'candidate');
    if k = 'fbm1' then a := a || '{"counter_evidence_searched": "-"}';
    elsif k = 'fbm2' then a := a || jsonb_build_object('claim', lab || ': the w07_fixture product costs 10 units today',
         'counter_evidence_searched', 'none found', 'changeable', false); end if;
  elsif p_family = 'work' then
    a := jsonb_build_object('mission_ref', pg_temp.w07_mission(), 'mission_revision', 1, 'scope', 'synthetic.w07_fixture.c',
      'purpose', lab || ': tidy the w07_fixture notes', 'impact_class', p_class, 'stop_rule', lab || ': stop when the notes are tidy',
      'consumer', 'w07_fixture', 'return_to', 'w07_fixture');
    if k = 'trigger' then a := a || jsonb_build_object('purpose', lab || ': add a w07_fixture job that creates a recurring cost (declared trigger: cost)'); end if;
  end if;
  return a;
end $f$;

-- Fixtures through devos_api (README 5.1 (a)): a batu-class decision answered at owner level (C02 has no answering
-- function; B:390), the Mission on it with the devos_kurulum token (DM-23; EV3 4.1), and work items.
create function pg_temp.w07_decision(p_class text, p_kind text default 'complete') returns text language plpgsql as $f$
declare r jsonb;
begin
  if p_class = 'routine' then
    r := pg_temp.w07_call('devos_calisma', 'open_decision', pg_temp.w07_args('decision_routine', 'complete', nextval('w07_seq')::int));
  else
    r := pg_temp.w07_call('devos_calisma', 'open_decision', pg_temp.w07_args('decision', p_kind, nextval('w07_seq')::int, p_class));
  end if;
  if pg_temp.w07_kind(r) <> 'accepted' then
    raise exception using errcode = 'P0W07', message = 'fixture decision of class ' || p_class || ' refused: ' || pg_temp.w07_brief(r);
  end if;
  return r->>'id';
end $f$;
create function pg_temp.w07_answered(p_class text) returns text language plpgsql as $f$
declare d text := pg_temp.w07_decision(p_class); e text;
begin
  e := pg_temp.w07_set_status(d, 'answered', pg_temp.w07_rev(d));
  if e is not null then raise exception using errcode = 'P0W07', message = 'fixture answer of a ' || p_class || ' decision refused: ' || e; end if;
  return d;
end $f$;
create function pg_temp.w07_mission() returns text language plpgsql as $f$
declare m text; d text; r jsonb;
begin
  select v into m from w07_fx where k = 'mission';
  if m is not null then return m; end if;
  d := pg_temp.w07_answered('batu');
  insert into w07_fx values ('mission_decision', d);
  r := pg_temp.w07_call('devos_kurulum', 'open_mission', jsonb_build_object('owner_authority', d, 'owner_authority_revision', 1,
    'scope', 'synthetic.w07_fixture', 'purpose', 'Synthetic test fixture (plan Section 8 item 13): W-C02-07; not work',
    'acceptance', 'SYNTHETIC W-C02-07', 'status', 'active'));
  if pg_temp.w07_kind(r) <> 'accepted' then
    raise exception using errcode = 'P0W07', message = 'fixture Mission refused: ' || pg_temp.w07_brief(r); end if;
  insert into w07_fx values ('mission', r->>'id');
  return r->>'id';
end $f$;
create function pg_temp.w07_work(p_impact text, p_kind text default 'complete') returns text language plpgsql as $f$
declare r jsonb;
begin
  r := pg_temp.w07_call('devos_calisma', 'admit_work', pg_temp.w07_args('work', p_kind, nextval('w07_seq')::int, p_impact));
  if pg_temp.w07_kind(r) <> 'accepted' then
    raise exception using errcode = 'P0W07', message = 'fixture work item (' || p_impact || ') refused: ' || pg_temp.w07_brief(r); end if;
  return r->>'id';
end $f$;
-- Claims a work item; returns the arguments an effect needs. The claim token stays in the returned value only.
create function pg_temp.w07_claimed(p_work text) returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  r := pg_temp.w07_call('devos_calisma', 'claim', jsonb_build_object('work_ref', p_work, 'work_id', p_work,
                                                                       'declared_session_id', 'w07_fixture_session'));
  if pg_temp.w07_kind(r) <> 'accepted' or (r->>'claim_token') is null then
    raise exception using errcode = 'P0W07', message = 'fixture claim refused: ' || pg_temp.w07_brief(r - 'claim_token'); end if;
  return jsonb_build_object('work_ref', p_work, 'claim_token', r->>'claim_token');
end $f$;

-- The sample stream's state (owner level): block_size, block_seen (records counted in the open block),
-- block_position (the hidden position). DM-08.
create function pg_temp.w07_state(p_stream text) returns jsonb language plpgsql as $f$
declare s jsonb;
begin
  execute 'select to_jsonb(x) from devos_private.sample_stream x where x.stream::text = $1' into s using p_stream;
  return s;
end $f$;
-- Brings a stream to a block boundary with complete records; returns null, or why it could not.
create function pg_temp.w07_align(p_stream text, p_family text, p_class text) returns text language plpgsql as $f$
declare s jsonb; n int; i int; r jsonb;
begin
  s := pg_temp.w07_state(p_stream);
  if s is null or (s->>'block_size') is null or (s->>'block_seen') is null then
    return 'stream ' || p_stream || ': block_size or block_seen not readable'; end if;
  n := ((s->>'block_size')::int - (s->>'block_seen')::int) % (s->>'block_size')::int;
  for i in 1..n loop
    r := pg_temp.w07_call('devos_calisma', pg_temp.w07_fn(p_family),
                          pg_temp.w07_args(p_family, 'complete', nextval('w07_seq')::int, p_class));
    if pg_temp.w07_kind(r) <> 'accepted' then return 'a complete record to align was refused: ' || pg_temp.w07_brief(r); end if;
  end loop;
  s := pg_temp.w07_state(p_stream);
  if (s->>'block_seen')::int <> 0 then return format('stream %s not at a block boundary after %s records', p_stream, n); end if;
  return null;
end $f$;
-- Plants p_blocks complete blocks of p_kind records, from a block boundary; ok iff every record is accepted, each
-- block has exactly one sample review queued for the audit environment, and the stream ends at a boundary.
create function pg_temp.w07_blocks(p_case text, p_stream text, p_family text, p_kind text, p_class text, p_blocks int,
                                   p_extra jsonb default '{}') returns void language plpgsql as $f$
declare why text; s jsonb; bs int; b int; i int; r jsonb; x text; ids text[]; k int; ka int; per int[] := '{}';
        pera int[] := '{}'; tot int := 0;
begin
  begin
    why := pg_temp.w07_align(p_stream, p_family, p_class);
  exception when others then why := 'alignment stopped: ' || sqlstate || ' ' || left(sqlerrm, 160); end;
  if why is not null then perform pg_temp.w07_put(p_case, 'could_not_check', why); return; end if;
  bs := (pg_temp.w07_state(p_stream)->>'block_size')::int;
  for b in 1..p_blocks loop
    ids := '{}';
    for i in 1..bs loop
      r := pg_temp.w07_call('devos_calisma', pg_temp.w07_fn(p_family),
                            pg_temp.w07_args(p_family, p_kind, nextval('w07_seq')::int, p_class) || p_extra);
      if pg_temp.w07_kind(r) <> 'accepted' then
        perform pg_temp.w07_rec(p_case, false, format('block %s record %s (%s) not accepted: %s', b, i, p_kind, pg_temp.w07_brief(r)));
        return;
      end if;
      ids := ids || (r->>'id');
    end loop;
    k := 0; ka := 0;
    foreach x in array ids loop k := k + pg_temp.w07_samples(x); ka := ka + pg_temp.w07_samples(x, false); end loop;
    per := per || k; pera := pera || ka; tot := tot + k;
  end loop;
  s := pg_temp.w07_state(p_stream);
  perform pg_temp.w07_rec(p_case, (select bool_and(v = 1) from unnest(per) v) and (s->>'block_seen')::int = 0,
    format('stream %s, block %s, %s block(s) of %s records (%s planted, all accepted): sample reviews queued for devos_denetim per block %s (wanted 1 each; of kind sample at all: %s); %s of %s caught; block_seen at the end %s',
           p_stream, bs, p_blocks, p_kind, p_blocks * bs, per, pera, tot, p_blocks * bs, s->>'block_seen'));
end $f$;
-- Runs one group of cases; an error of the test itself makes the group could_not_check (never a pass).
create function pg_temp.w07_run(p_group text, p_sql text) returns void language plpgsql as $f$
begin
  execute p_sql;
exception when others then
  perform pg_temp.w07_put(p_group, 'could_not_check', 'the group stopped on an error of the test itself: ' || sqlstate || ' ' || left(sqlerrm, 200));
end $f$;
-- Synthetic effect classes (owner-level fixtures inside this rolled-back transaction; DM-37's table is filled by
-- migration, and C02 prepares no real effect, so the impact-class cases plant one reversible and one irreversible).
create function pg_temp.w07_effect_classes() returns void language plpgsql as $f$
begin
  if (select count(*) from information_schema.columns where table_schema = 'devos_private' and table_name = 'effect_class'
        and column_name in ('effect_class', 'irreversible', 'mandatory_read_set')) <> 3 then
    raise exception using errcode = 'P0W07', message = 'devos_private.effect_class lacks effect_class, irreversible or mandatory_read_set (README section 8.1)'; end if;
  if not exists (select 1 from devos_private.effect_class where effect_class::text = 'w07_fixture_reversible') then
    perform pg_temp.w07_plant_row('effect_class', '{"effect_class": "w07_fixture_reversible", "irreversible": "false", "mandatory_read_set": "{work,hard_dependencies,claim,authority_epoch,expected_base,inputs}"}'); end if;
  if not exists (select 1 from devos_private.effect_class where effect_class::text = 'w07_fixture_irreversible') then
    perform pg_temp.w07_plant_row('effect_class', '{"effect_class": "w07_fixture_irreversible", "irreversible": "true", "mandatory_read_set": "{work,hard_dependencies,claim,authority_epoch,expected_base,inputs}"}'); end if;
end $f$;
-- The arguments of an effect under a claimed work item (README section 8: the build's names are assumed).
create function pg_temp.w07_effect_args(p_claim jsonb, p_class text, p_target text) returns jsonb language sql as $f$
  select p_claim || jsonb_build_object('effect_class', p_class, 'target', p_target, 'idempotency_namespace', 'w07_fixture',
    'idempotency_key', 'w07_fixture_' || nextval('w07_seq'), 'expected_base', 'w07_fixture_base', 'payload_hash', repeat('b', 64),
    'read_set', '[]'::jsonb, 'payload', jsonb_build_object('note', 'SYNTHETIC W-C02-07')) $f$;
create function pg_temp.w07_artifact_args(p_claim jsonb, p_path text) returns jsonb language sql as $f$
  select p_claim || jsonb_build_object('path', p_path, 'commit', repeat('c', 40), 'kind', 'note', 'scope', 'synthetic.w07_fixture.c',
    'status', 'candidate') $f$;

-- Plants p_ddl inside a subtransaction, makes one call, then undoes p_ddl (W-C02-03's w03_hidden_case).
create function pg_temp.w07_under(p_ddl text, p_class text, p_fn text, p_args jsonb, p_tbl text) returns jsonb language plpgsql as $f$
declare r jsonb; n0 bigint; n1 bigint; planted boolean := false; perr text;
begin
  n0 := pg_temp.w07_count(p_tbl);
  begin
    execute p_ddl;
    planted := true;
    r := pg_temp.w07_call(p_class, p_fn, p_args);
    n1 := pg_temp.w07_count(p_tbl);
    raise exception using errcode = 'P0W7U', message = 'w07: undo the planted state';
  exception
    when sqlstate 'P0W7U' then null;
    when others then perr := sqlstate || ' ' || left(sqlerrm, 160);
  end;
  if not planted or perr is not null then return jsonb_build_object('w07_cnc', 'the input could not be planted: ' || coalesce(perr, '?')); end if;
  return r || jsonb_build_object('w07_n0', n0, 'w07_n1', n1);
end $f$;

-- The cases of this file.
-- ===== T-W07-N08 part X (phase C4b; EV-C02-008 5.1) =====

-- Every value an answer holds, ids aside (EV-C02-008 5.1: "the same result, ids aside"): uuids become <id>, a claim
-- token's value becomes <claim token> before anything is kept, and keys ending in _at (times of this transaction) and the
-- test's own w07_ keys are dropped.
create function pg_temp.n08x_strip(j jsonb) returns jsonb language plpgsql immutable as $f$
declare k text; v jsonb; o jsonb := '{}'; a jsonb := '[]';
begin
  if jsonb_typeof(j) = 'object' then
    for k, v in select * from jsonb_each(j) loop
      continue when k ~ '_at$' or k like 'w07[_]%';
      if k = 'claim_token' then o := o || jsonb_build_object(k, '<claim token>'); continue; end if;
      o := o || jsonb_build_object(k, pg_temp.n08x_strip(v));
    end loop;
    return o;
  elsif jsonb_typeof(j) = 'array' then
    for v in select * from jsonb_array_elements(j) loop a := a || jsonb_build_array(pg_temp.n08x_strip(v)); end loop;
    return a;
  elsif jsonb_typeof(j) = 'string' then
    return to_jsonb(regexp_replace(j #>> '{}', '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}', '<id>', 'g'));
  end if;
  return j;
end $f$;

-- One step's record: its label, the answer's kind and reason code, and the answer ids aside.
create function pg_temp.n08x_step(p_label text, r jsonb) returns jsonb language sql as $f$
  select jsonb_build_object('step', p_label, 'kind', pg_temp.w07_kind(r), 'code', r->>'reason_code',
                            'answer', pg_temp.n08x_strip(r - 'claim_token'))
$f$;

create function pg_temp.n08x_fx(p_k text) returns text language sql as $f$ select v from w07_fx where k = p_k $f$;

-- The arguments: the same payload for w_e and w_o (EV-C02-008 5.1's EXF-pair: "the same Mission, scope, purpose, labels
-- and effort policy").
create function pg_temp.n08x_work_args() returns jsonb language sql as $f$
  select pg_temp.w07_args('work', 'complete', 900, 'high') || jsonb_build_object('mission_ref', pg_temp.n08x_fx('mission'))
$f$;
create function pg_temp.n08x_policy(p_w text) returns jsonb language sql as $f$
  select jsonb_build_object('work_ref', p_w, 'level', 'high',
    'expert_assessment_ref', 'SYNTHETIC W-C02-07 w07_fixture: expert assessment of the paired item, high effort',
    'non_removable_steps', '["verification", "alternatives_research", "external_source_research"]'::jsonb, 'status', 'active')
$f$;
-- record_eval_run's payload: B 3.14's EvalRun fields in p (README 8.1, interface v1), the work item in work_ref.
create function pg_temp.n08x_run_args(p_w text) returns jsonb language sql as $f$
  select jsonb_build_object('work_ref', p_w, 'work_revision', 1, 'eval_set_id', 'w07_fixture_eval_set',
    'eval_set_version', 'w07_fixture_v1', 'subject_role', 'w07_fixture_role', 'subject_release', 'w07_fixture_release',
    'runner_session', 'w07_fixture_session_exam', 'results', jsonb_build_object('w07_fixture', 'SYNTHETIC W-C02-07'), 'run_at', now())
$f$;
create function pg_temp.n08x_rel(p_from text, p_to text, p_type text, p_hard boolean) returns jsonb language sql as $f$
  select jsonb_build_object('type', p_type, 'from_ref', p_from, 'from_revision', 1, 'to_ref', p_to, 'to_revision', 1,
    'scope', 'synthetic.w07_fixture.c', 'hard', p_hard, 'method', 'recorded', 'epistemic_status', 'inference')
$f$;
-- RejectedAttempt rows of one function under one class (DM-19: "each refusal is recorded").
create function pg_temp.n08x_ra(p_fn text, p_class text) returns bigint language plpgsql as $f$
declare n bigint;
begin
  execute 'select coalesce(sum(coalesce(x."count", 1)), 0) from devos_private.rejected_attempt x
            where x.function_name::text in ($1, ''devos_api.'' || $1) and x.role_class::text = $2' into n using p_fn, p_class;
  return n;
end $f$;

-- The steps of one function on one work item p_w, with p_class's token, run in a subtransaction undone after them, so
-- that each pair starts from the same fixtures. For each function: accepted and refused calls (EV-C02-008 5.1's EXF-pair:
-- "a stale revision, an empty required field, a claim another working session holds"). p_acc: the step that the working
-- token must see accepted on at least one item (the pair is then not compared in a refused state only; accepted on one and
-- refused on the other is a difference).
create function pg_temp.n08x_seq(p_fn text, p_class text, p_w text) returns jsonb language plpgsql as $f$
declare out jsonb := '[]'; r jsonb; tok text; rid text; g text; side text := case when p_w = pg_temp.n08x_fx('w_e') then 'e' else 'o' end;
        wx text := pg_temp.n08x_fx('w_x');
begin
  begin
    if p_fn = 'claim' then
      r := pg_temp.w07_call(p_class, 'claim', jsonb_build_object('work_id', p_w, 'declared_session_id', 'w07_fixture_session_a'));
      execute 'select to_jsonb(a)->>''generation'' from devos_private.assignment a where to_jsonb(a)->>''work_ref'' = $1
                and to_jsonb(a)->>''status'' = ''active''' into g using p_w;
      out := out || jsonb_build_array(pg_temp.n08x_step('first claim', r), jsonb_build_object('step', 'its generation, read as owner', 'value', g));
      r := pg_temp.w07_call(p_class, 'claim', jsonb_build_object('work_id', p_w, 'declared_session_id', 'w07_fixture_session_b'));
      out := out || jsonb_build_array(pg_temp.n08x_step('a claim another working session holds', r));
    elsif p_fn in ('heartbeat', 'release') then
      r := pg_temp.w07_call(p_class, 'claim', jsonb_build_object('work_id', p_w, 'declared_session_id', 'w07_fixture_session_a'));
      tok := r->>'claim_token';
      out := out || jsonb_build_array(pg_temp.n08x_step('claim', r));
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('claim_token', tok));
      out := out || jsonb_build_array(pg_temp.n08x_step(p_fn || ' with the claim', r));
      if p_fn = 'heartbeat' then
        r := pg_temp.w07_call(p_class, 'release', jsonb_build_object('claim_token', tok));
        out := out || jsonb_build_array(pg_temp.n08x_step('release', r));
      end if;
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('claim_token', tok));
      out := out || jsonb_build_array(pg_temp.n08x_step(p_fn || ' with the released claim', r));
      tok := null;
    elsif p_fn = 'revise_work' then
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('id', p_w, 'base_revision', 1, 'scope', 'synthetic.w07_fixture.c',
             'purpose', 'SYNTHETIC W-C02-07 w07_fixture: revised purpose', 'reason', 'SYNTHETIC W-C02-07 w07_fixture revision'));
      out := out || jsonb_build_array(pg_temp.n08x_step('a revision on the current revision', r));
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('id', p_w, 'base_revision', 1, 'scope', 'synthetic.w07_fixture.c',
             'purpose', 'SYNTHETIC W-C02-07 w07_fixture: a second revision', 'reason', 'SYNTHETIC W-C02-07 w07_fixture revision'));
      out := out || jsonb_build_array(pg_temp.n08x_step('a stale revision', r));
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('id', p_w, 'base_revision', 2, 'scope', 'synthetic.w07_fixture.c',
             'purpose', '', 'reason', 'SYNTHETIC W-C02-07 w07_fixture revision'));
      out := out || jsonb_build_array(pg_temp.n08x_step('an empty required field', r));
    elsif p_fn in ('mark_stale', 'cancel_work') then
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('work_id', p_w, 'reason', 'SYNTHETIC W-C02-07 w07_fixture ' || p_fn));
      out := out || jsonb_build_array(pg_temp.n08x_step('with its reason', r));
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('work_id', p_w, 'reason', 'SYNTHETIC W-C02-07 w07_fixture ' || p_fn || ' again'));
      out := out || jsonb_build_array(pg_temp.n08x_step('again', r));
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('work_id', p_w, 'reason', ''));
      out := out || jsonb_build_array(pg_temp.n08x_step('an empty reason', r));
    elsif p_fn = 'reopen_for_review' then
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('work_id', p_w, 'reason', 'SYNTHETIC W-C02-07 w07_fixture reopen of an open item'));
      out := out || jsonb_build_array(pg_temp.n08x_step('on the open item', r));
      execute 'update devos_private.work set execution = ''finished'', acceptance = ''accepted'' where id::text = $1' using p_w;
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('work_id', p_w, 'reason', 'SYNTHETIC W-C02-07 w07_fixture reopen'));
      out := out || jsonb_build_array(pg_temp.n08x_step('on the item planted finished and accepted', r));
    elsif p_fn = 'relate' then
      r := pg_temp.w07_call(p_class, p_fn, pg_temp.n08x_rel(p_w, wx, 'depends_on', true));
      out := out || jsonb_build_array(pg_temp.n08x_step('a hard depends_on from the item', r));
      r := pg_temp.w07_call(p_class, p_fn, pg_temp.n08x_rel(wx, p_w, 'depends_on', true));
      out := out || jsonb_build_array(pg_temp.n08x_step('the opposite hard depends_on (a cycle)', r));
      r := pg_temp.w07_call(p_class, p_fn, pg_temp.n08x_rel(p_w, wx, '', false));
      out := out || jsonb_build_array(pg_temp.n08x_step('an empty type', r));
    elsif p_fn = 'retract_relation' then
      r := pg_temp.w07_call('devos_calisma', 'relate', pg_temp.n08x_rel(p_w, wx, 'depends_on', true));
      if pg_temp.w07_kind(r) <> 'accepted' then
        out := out || jsonb_build_array(jsonb_build_object('step', 'setup', 'kind', 'test_cnc', 'code', 'the relation to retract was not made'));
      else
        rid := r->>'id';
        r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('relation_id', rid, 'reason', 'SYNTHETIC W-C02-07 w07_fixture retraction'));
        out := out || jsonb_build_array(pg_temp.n08x_step('the hard relation from the item', r));
        r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('relation_id', rid, 'reason', 'SYNTHETIC W-C02-07 w07_fixture retraction again'));
        out := out || jsonb_build_array(pg_temp.n08x_step('again', r));
      end if;
    elsif p_fn = 'set_effort_policy' then
      r := pg_temp.w07_call(p_class, p_fn, pg_temp.n08x_policy(p_w));
      out := out || jsonb_build_array(pg_temp.n08x_step('kind (a), the default', r));
      r := pg_temp.w07_call(p_class, p_fn, pg_temp.n08x_policy(p_w) || '{"expert_assessment_ref": ""}');
      out := out || jsonb_build_array(pg_temp.n08x_step('an empty expert assessment', r));
      r := pg_temp.w07_call(p_class, p_fn, pg_temp.n08x_policy(p_w) || '{"level": "low"}');
      out := out || jsonb_build_array(pg_temp.n08x_step('a reduction with no approval', r));
    elsif p_fn = 'affected_entities' then
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('root', pg_temp.n08x_fx('r_' || side), 'limits', '{"max_depth": 50, "max_records": 100, "max_paths": 5}'::jsonb));
      out := out || jsonb_build_array(pg_temp.n08x_step('from r: x, the item and y', r));
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('root', p_w, 'limits', '{"max_depth": 50, "max_records": 100, "max_paths": 5}'::jsonb));
      out := out || jsonb_build_array(pg_temp.n08x_step('with the item as root', r));
    elsif p_fn = 'explain_paths' then
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('root', pg_temp.n08x_fx('r_' || side), 'target', p_w, 'limits', '{"max_depth": 50, "max_records": 100, "max_paths": 5}'::jsonb));
      out := out || jsonb_build_array(pg_temp.n08x_step('from r to the item', r));
      r := pg_temp.w07_call(p_class, p_fn, jsonb_build_object('root', p_w, 'target', pg_temp.n08x_fx('y_' || side), 'limits', '{"max_depth": 50, "max_records": 100, "max_paths": 5}'::jsonb));
      out := out || jsonb_build_array(pg_temp.n08x_step('from the item to y', r));
    end if;
    raise exception using errcode = 'P0W7U', message = 'w07: undo the steps';
  exception
    when sqlstate 'P0W7U' then null;
    when others then
      out := out || jsonb_build_array(jsonb_build_object('step', 'the steps', 'kind', 'test_cnc', 'code',
        'stopped on an error of the test itself: ' || sqlstate || ' ' || left(sqlerrm, 120)));
  end;
  return out;
end $f$;

-- The step the working token must see accepted on at least one item, per function (1-based; 0: none).
create function pg_temp.n08x_acc(p_fn text) returns int language sql immutable as $f$
  select case p_fn when 'claim' then 1 when 'heartbeat' then 2 when 'release' then 2 when 'revise_work' then 1
    when 'mark_stale' then 1 when 'cancel_work' then 1 when 'reopen_for_review' then 2 when 'relate' then 1
    when 'retract_relation' then 1 when 'set_effort_policy' then 1 when 'affected_entities' then 1 when 'explain_paths' then 1
    else 0 end
$f$;

-- One pair: the same steps on w_e and on w_o compared (status, reason code and answer, ids aside).
create function pg_temp.n08x_pair(p_case text, p_fn text, p_class text, p_need_acc boolean) returns void language plpgsql as $f$
declare a jsonb; b jsonb; i int; acc int := pg_temp.n08x_acc(p_fn); why text; diff text := '';
begin
  a := pg_temp.n08x_seq(p_fn, p_class, pg_temp.n08x_fx('w_e'));
  b := pg_temp.n08x_seq(p_fn, p_class, pg_temp.n08x_fx('w_o'));
  select string_agg(format('%s: %s', s->>'step', s->>'code'), '; ') into why
    from jsonb_array_elements(a || b) s where s->>'kind' in ('test_cnc', 'unknown');
  if why is not null then
    perform pg_temp.w07_put(p_case, 'could_not_check', p_fn || ' with ' || p_class || ': not observed in interface v1''s form: ' || why);
    return;
  end if;
  if p_need_acc and acc > 0 and not (a->(acc - 1)->>'kind' = 'accepted' or b->(acc - 1)->>'kind' = 'accepted') then
    perform pg_temp.w07_put(p_case, 'could_not_check', format('%s with %s: the step "%s" was accepted on neither item (exam task: %s %s; ordinary: %s %s), so the pair is not compared in an accepted state',
      p_fn, p_class, a->(acc - 1)->>'step', a->(acc - 1)->>'kind', coalesce(a->(acc - 1)->>'code', '-'), b->(acc - 1)->>'kind', coalesce(b->(acc - 1)->>'code', '-')));
    return;
  end if;
  for i in 0 .. greatest(jsonb_array_length(a), jsonb_array_length(b)) - 1 loop
    if a->i is distinct from b->i then
      diff := diff || format(' step %s differs: on the exam task %s; on the ordinary item %s.', i + 1, left(coalesce((a->i)::text, 'none'), 200), left(coalesce((b->i)::text, 'none'), 200));
    end if;
  end loop;
  perform pg_temp.w07_rec(p_case, diff = '', format('%s with %s, on the exam task w_e and the ordinary item w_o: %s%s', p_fn, p_class,
    (select string_agg(format('%s %s/%s', s->>'step', s->>'kind', coalesce(s->>'code', '-')), '; ') from jsonb_array_elements(a) s),
    case when diff = '' then ' (the same on each, ids aside)' else '.' || diff end));
end $f$;

-- ready_works (EXF-pair-ready_works): it lists both or neither, and its rows for them differ in nothing but the id.
create function pg_temp.n08x_ready() returns void language plpgsql as $f$
declare r jsonb; re jsonb; ro jsonb; we text := pg_temp.n08x_fx('w_e'); wo text := pg_temp.n08x_fx('w_o');
begin
  r := pg_temp.w07_call('devos_calisma', 'ready_works', '{}');
  if pg_temp.w07_kind(r) <> 'accepted' then
    perform pg_temp.w07_put('EXF-pair-ready_works', 'could_not_check', 'ready_works with the working token: ' || pg_temp.w07_brief(r)); return;
  end if;
  select jsonb_agg(x) into re from jsonb_array_elements(case when jsonb_typeof(r->'works') = 'array' then r->'works' else '[]' end) x
   where strpos(x::text, we) > 0;
  select jsonb_agg(x) into ro from jsonb_array_elements(case when jsonb_typeof(r->'works') = 'array' then r->'works' else '[]' end) x
   where strpos(x::text, wo) > 0;
  perform pg_temp.w07_rec('EXF-pair-ready_works', (re is null) = (ro is null) and pg_temp.n08x_strip(re) is not distinct from pg_temp.n08x_strip(ro),
    format('ready_works, working token: the exam task %s, the ordinary item %s; rows ids aside: %s / %s (wanted both or neither, the rows the same)',
      case when re is null then 'not listed' else 'listed' end, case when ro is null then 'not listed' else 'listed' end,
      left(coalesce(pg_temp.n08x_strip(re)::text, '-'), 200), left(coalesce(pg_temp.n08x_strip(ro)::text, '-'), 200)));
end $f$;

-- The owner's view of the pair (EXF-pair-state): the Work row, its revisions, the events whose aggregate is the Work and
-- the effort policies, ids, times, transaction ids and the events' role_class aside, are the same (bound 2 of 5.1 (c):
-- record_eval_run writes no field, revision or event on the Work it names; DM-24: no exam field on Work).
create function pg_temp.n08x_view(p_w text) returns jsonb language plpgsql as $f$
declare w jsonb; rv jsonb; ev jsonb; ep jsonb;
begin
  execute 'select to_jsonb(x) from devos_private.work x where x.id::text = $1' into w using p_w;
  execute 'select coalesce(jsonb_agg(to_jsonb(x) - ''tx_id'' order by to_jsonb(x)->>''revision''), ''[]'') from devos_private.work_revision x
            where to_jsonb(x)->>''work_id'' = $1' into rv using p_w;
  execute 'select coalesce(jsonb_agg(to_jsonb(x) - array[''id'', ''role_class'', ''tx_id'', ''declared_session_id'']
                   order by (to_jsonb(x) - array[''id'', ''role_class'', ''tx_id'', ''declared_session_id'', ''created_at''])::text), ''[]'')
            from devos_private.event x where to_jsonb(x)->>''aggregate_id'' = $1' into ev using p_w;
  execute 'select coalesce(jsonb_agg(to_jsonb(x) - array[''id'', ''work_ref''] order by (to_jsonb(x) - array[''id'', ''work_ref''])::text), ''[]'')
            from devos_private.effort_policy x where to_jsonb(x)->>''work_ref'' = $1' into ep using p_w;
  return pg_temp.n08x_strip(jsonb_build_object('work', w, 'revisions', rv, 'events', ev, 'effort_policies', ep));
end $f$;
create function pg_temp.n08x_state() returns void language plpgsql as $f$
declare a jsonb; b jsonb; k text; diff text := '';
begin
  if not exists (select 1 from information_schema.columns where table_schema = 'devos_private' and table_name = 'event' and column_name = 'aggregate_id') then
    perform pg_temp.w07_put('EXF-pair-state', 'could_not_check', 'devos_private.event has no aggregate_id (B 3.13''s field, assumed)'); return;
  end if;
  a := pg_temp.n08x_view(pg_temp.n08x_fx('w_e')); b := pg_temp.n08x_view(pg_temp.n08x_fx('w_o'));
  foreach k in array array['work', 'revisions', 'events', 'effort_policies'] loop
    if a->k is distinct from b->k then diff := diff || format(' %s differ: %s / %s.', k, left((a->k)::text, 200), left((b->k)::text, 200)); end if;
  end loop;
  perform pg_temp.w07_rec('EXF-pair-state', diff = '' and jsonb_array_length(a->'events') > 0,
    format('as owner: the Work row, %s revision(s), %s event(s) on the Work, %s effort polic(ies) of the exam task against the ordinary item%s',
      jsonb_array_length(a->'revisions'), jsonb_array_length(a->'events'), jsonb_array_length(a->'effort_policies'),
      case when diff = '' then ': the same, ids, times and the events'' role_class aside' else ':' || diff end));
end $f$;

-- The fixtures (EV-C02-008 5.1's EXF-pair, as CHK-C02-027 B and CHK-C02-032 F11 (d) order them): w_e opened through
-- admit_work with the exam token; before its EvalRun exists, devos_sinav's claim on it (EXF-pair-sin-claim: refused);
-- then the EvalRun through record_eval_run with the exam token; then w_e's kind (a) effort policy with the exam token,
-- which Rule O admits only once the EvalRun names w_e. w_o opened with the working token, with the same payload and
-- policy. w_x, and the graph r <- x <- item <- y on each side, made with the working token.
create function pg_temp.n08x_fixtures() returns text language plpgsql as $f$
declare r jsonb; m text; s text; w text; ra0 bigint;
begin
  m := pg_temp.w07_mission();
  r := pg_temp.w07_call('devos_sinav', 'admit_work', pg_temp.n08x_work_args());
  if pg_temp.w07_kind(r) <> 'accepted' then return 'devos_sinav''s admit_work (B:38) was not accepted: ' || pg_temp.w07_brief(r); end if;
  insert into w07_fx values ('w_e', r->>'id');
  ra0 := pg_temp.n08x_ra('claim', 'devos_sinav');
  r := pg_temp.w07_call('devos_sinav', 'claim', jsonb_build_object('work_id', pg_temp.n08x_fx('w_e'), 'declared_session_id', 'w07_fixture_session_exam'));
  if pg_temp.w07_kind(r) in ('test_cnc', 'unknown') then
    perform pg_temp.w07_put('EXF-pair-sin-claim', 'could_not_check', 'claim with the exam token: ' || pg_temp.w07_brief(r - 'claim_token'));
  else
    perform pg_temp.w07_rec('EXF-pair-sin-claim', pg_temp.w07_kind(r) = 'refused' and r->>'reason_code' <> all(array['role_class_not_permitted',
        'missing', 'empty', 'malformed', 'unknown', 'revoked', 'header_unreadable']) and pg_temp.n08x_ra('claim', 'devos_sinav') = ra0 + 1,
      format('claim on w_e with the exam token before its EvalRun exists: %s; recorded %s time(s) (wanted refused after the gate, its own reason code, recorded once)',
        pg_temp.w07_brief(r - 'claim_token'), pg_temp.n08x_ra('claim', 'devos_sinav') - ra0));
  end if;
  r := null;
  r := pg_temp.w07_call('devos_sinav', 'record_eval_run', pg_temp.n08x_run_args(pg_temp.n08x_fx('w_e')));
  if pg_temp.w07_kind(r) <> 'accepted' then return 'record_eval_run with the exam token, naming w_e, was not accepted (its payload is README 8.1''s v1 form): ' || pg_temp.w07_brief(r); end if;
  if not exists (select 1 from devos_private.eval_run x where to_jsonb(x)->>'work_ref' = pg_temp.n08x_fx('w_e')) then
    return 'no EvalRun row names w_e in work_ref after record_eval_run (DM-24)'; end if;
  r := pg_temp.w07_call('devos_sinav', 'set_effort_policy', pg_temp.n08x_policy(pg_temp.n08x_fx('w_e')));
  if pg_temp.w07_kind(r) <> 'accepted' then return 'w_e''s kind (a) effort policy with the exam token was not accepted: ' || pg_temp.w07_brief(r); end if;
  r := pg_temp.w07_call('devos_calisma', 'admit_work', pg_temp.n08x_work_args());
  if pg_temp.w07_kind(r) <> 'accepted' then return 'w_o with the working token was not accepted: ' || pg_temp.w07_brief(r); end if;
  insert into w07_fx values ('w_o', r->>'id');
  r := pg_temp.w07_call('devos_calisma', 'set_effort_policy', pg_temp.n08x_policy(pg_temp.n08x_fx('w_o')));
  if pg_temp.w07_kind(r) <> 'accepted' then return 'w_o''s kind (a) effort policy with the working token was not accepted: ' || pg_temp.w07_brief(r); end if;
  foreach s in array array['w_x', 'r_e', 'x_e', 'y_e', 'r_o', 'x_o', 'y_o'] loop
    r := pg_temp.w07_call('devos_calisma', 'admit_work', pg_temp.w07_args('work', 'complete', nextval('w07_seq')::int, 'high')
           || jsonb_build_object('mission_ref', m));
    if pg_temp.w07_kind(r) <> 'accepted' then return 'fixture ' || s || ' was not accepted: ' || pg_temp.w07_brief(r); end if;
    insert into w07_fx values (s, r->>'id');
  end loop;
  foreach s in array array['e', 'o'] loop
    w := pg_temp.n08x_fx('w_' || s);
    foreach r in array array[jsonb_build_array('x_' || s, 'r_' || s), jsonb_build_array('w_' || s, 'x_' || s), jsonb_build_array('y_' || s, 'w_' || s)] loop
      r := pg_temp.w07_call('devos_calisma', 'relate', pg_temp.n08x_rel(pg_temp.n08x_fx(r->>0), pg_temp.n08x_fx(r->>1), 'derived_from', false));
      if pg_temp.w07_kind(r) <> 'accepted' then return 'a relation of the walk graph was not made: ' || pg_temp.w07_brief(r); end if;
    end loop;
  end loop;
  return null;
end $f$;

-- N08-s3 (EV-C02-008 5.1's table): record_eval_run with the exam token on a work item: the Work's rows, revisions and
-- events, compared before and after, are unchanged (bound 2).
create function pg_temp.n08x_s3() returns void language plpgsql as $f$
declare r jsonb; w text; v0 text; v1 text;
begin
  r := pg_temp.w07_call('devos_calisma', 'admit_work', pg_temp.w07_args('work', 'complete', nextval('w07_seq')::int, 'high')
         || jsonb_build_object('mission_ref', pg_temp.n08x_fx('mission')));
  if pg_temp.w07_kind(r) <> 'accepted' then perform pg_temp.w07_put('N08-s3', 'could_not_check', 'the work item was not made: ' || pg_temp.w07_brief(r)); return; end if;
  w := r->>'id';
  if not exists (select 1 from information_schema.columns where table_schema = 'devos_private' and table_name = 'event' and column_name = 'aggregate_id') then
    perform pg_temp.w07_put('N08-s3', 'could_not_check', 'devos_private.event has no aggregate_id (B 3.13''s field, assumed)'); return;
  end if;
  execute 'select concat_ws(''|'', (select to_jsonb(x)::text from devos_private.work x where x.id::text = $1),
             (select string_agg(to_jsonb(x)::text, '','' order by to_jsonb(x)::text) from devos_private.work_revision x where to_jsonb(x)->>''work_id'' = $1),
             (select count(*)::text || '':'' || coalesce(string_agg(to_jsonb(x)::text, '','' order by x.id), '''') from devos_private.event x where to_jsonb(x)->>''aggregate_id'' = $1))'
    into v0 using w;
  r := pg_temp.w07_call('devos_sinav', 'record_eval_run', pg_temp.n08x_run_args(w));
  execute 'select concat_ws(''|'', (select to_jsonb(x)::text from devos_private.work x where x.id::text = $1),
             (select string_agg(to_jsonb(x)::text, '','' order by to_jsonb(x)::text) from devos_private.work_revision x where to_jsonb(x)->>''work_id'' = $1),
             (select count(*)::text || '':'' || coalesce(string_agg(to_jsonb(x)::text, '','' order by x.id), '''') from devos_private.event x where to_jsonb(x)->>''aggregate_id'' = $1))'
    into v1 using w;
  if pg_temp.w07_kind(r) <> 'accepted' then
    perform pg_temp.w07_put('N08-s3', 'could_not_check', 'record_eval_run with the exam token was not accepted: ' || pg_temp.w07_brief(r)); return;
  end if;
  perform pg_temp.w07_rec('N08-s3', v0 = v1, 'record_eval_run, exam token, on a work item: the Work''s row, revisions and events '
    || case when v0 = v1 then 'unchanged' else 'changed' end || ' (wanted unchanged)');
end $f$;

-- N08-s4 (EV-C02-008 5.1 (c) 3, revised after CHK-C02-027 C): claim with the exam token on a work item an EvalRun
-- names, one devos_sinav opened that no EvalRun names yet, and one devos_calisma opened: each refused after the gate, the
-- three with the same reason code, not the role gate's, each recorded. Then record_eval_run on a work item with an active
-- claim of class devos_sinav, planted by the owner (a state only a fault makes): refused and recorded.
create function pg_temp.n08x_s4() returns void language plpgsql as $f$
declare r jsonb; ws text; wc text; ra0 bigint; ra1 bigint; codes text[] := '{}'; c text; k text; i int := 0; e0 bigint; e1 bigint; why text;
begin
  r := pg_temp.w07_call('devos_sinav', 'admit_work', pg_temp.w07_args('work', 'complete', nextval('w07_seq')::int, 'high')
         || jsonb_build_object('mission_ref', pg_temp.n08x_fx('mission')));
  if pg_temp.w07_kind(r) = 'accepted' then ws := r->>'id'; else why := 'devos_sinav''s admit_work: ' || pg_temp.w07_brief(r); end if;
  r := pg_temp.w07_call('devos_calisma', 'admit_work', pg_temp.w07_args('work', 'complete', nextval('w07_seq')::int, 'high')
         || jsonb_build_object('mission_ref', pg_temp.n08x_fx('mission')));
  if pg_temp.w07_kind(r) = 'accepted' then wc := r->>'id'; else why := coalesce(why || '; ', '') || 'devos_calisma''s admit_work: ' || pg_temp.w07_brief(r); end if;
  foreach k in array array['linked', 'unlinked', 'working'] loop
    i := i + 1;
    c := case k when 'linked' then pg_temp.n08x_fx('w_e') when 'unlinked' then ws else wc end;
    if c is null then
      perform pg_temp.w07_put('N08-s4-claim-' || k, 'could_not_check', coalesce(why, 'the fixture of this kind was not made')); codes := codes || 'none'::text; continue;
    end if;
    begin
      ra0 := pg_temp.n08x_ra('claim', 'devos_sinav');
      r := pg_temp.w07_call('devos_sinav', 'claim', jsonb_build_object('work_id', c, 'declared_session_id', 'w07_fixture_session_exam'));
      ra1 := pg_temp.n08x_ra('claim', 'devos_sinav');
      raise exception using errcode = 'P0W7U', message = 'w07: undo the claim';
    exception when sqlstate 'P0W7U' then null;
    end;
    if pg_temp.w07_kind(r) in ('test_cnc', 'unknown') then
      perform pg_temp.w07_put('N08-s4-claim-' || k, 'could_not_check', 'claim with the exam token: ' || pg_temp.w07_brief(r - 'claim_token'));
      codes := codes || 'none'::text; continue;
    end if;
    codes := codes || coalesce(case when pg_temp.w07_kind(r) = 'refused' then r->>'reason_code' end, 'accepted');
    perform pg_temp.w07_rec('N08-s4-claim-' || k, pg_temp.w07_kind(r) = 'refused' and r->>'reason_code' <> all(array['role_class_not_permitted',
        'missing', 'empty', 'malformed', 'unknown', 'revoked', 'header_unreadable']) and ra1 = ra0 + 1,
      format('claim with the exam token on %s: %s; recorded %s time(s) (wanted refused after the gate, not the role gate''s code, recorded once)',
        case k when 'linked' then 'a work item an EvalRun names' when 'unlinked' then 'a work item devos_sinav opened that no EvalRun names'
               else 'a work item devos_calisma opened' end, pg_temp.w07_brief(r - 'claim_token'), ra1 - ra0));
    r := null;
  end loop;
  if 'none' = any(codes) then
    perform pg_temp.w07_put('N08-s4-code', 'could_not_check', 'not every claim was observed: ' || array_to_string(codes, ', '));
  else
    perform pg_temp.w07_rec('N08-s4-code', codes[1] = codes[2] and codes[2] = codes[3] and codes[1] <> 'accepted',
      'the three refusals'' reason codes: ' || array_to_string(codes, ', ') || ' (wanted one code, the same for each)');
  end if;
  -- The exam run on a work item with a planted active claim of class devos_sinav.
  if wc is null then perform pg_temp.w07_put('N08-s4-run', 'could_not_check', coalesce(why, 'no work item')); return; end if;
  why := null;
  begin
    perform pg_temp.w07_plant_row('assignment', jsonb_build_object('work_ref', wc, 'role_class', 'devos_sinav', 'status', 'active',
      'declared_session_id', 'w07_fixture_session_exam'));
    execute 'select count(*) from devos_private.eval_run' into e0;
    ra0 := pg_temp.n08x_ra('record_eval_run', 'devos_sinav');
    r := pg_temp.w07_call('devos_sinav', 'record_eval_run', pg_temp.n08x_run_args(wc));
    ra1 := pg_temp.n08x_ra('record_eval_run', 'devos_sinav');
    execute 'select count(*) from devos_private.eval_run' into e1;
    raise exception using errcode = 'P0W7U', message = 'w07: undo the planted claim';
  exception
    when sqlstate 'P0W7U' then null;
    when others then why := 'the active claim of class devos_sinav could not be planted (Assignment''s work_ref, role_class, status assumed): ' || sqlstate || ' ' || left(sqlerrm, 120);
  end;
  if why is not null then perform pg_temp.w07_put('N08-s4-run', 'could_not_check', why); return; end if;
  if pg_temp.w07_kind(r) in ('test_cnc', 'unknown') then
    perform pg_temp.w07_put('N08-s4-run', 'could_not_check', 'record_eval_run: ' || pg_temp.w07_brief(r)); return;
  end if;
  perform pg_temp.w07_rec('N08-s4-run', pg_temp.w07_kind(r) = 'refused' and ra1 = ra0 + 1 and e1 = e0,
    format('record_eval_run, exam token, on a work item with an active claim of class devos_sinav: %s; recorded %s time(s); EvalRun rows %s -> %s (wanted refused, recorded once, none added)',
      pg_temp.w07_brief(r), ra1 - ra0, e0, e1));
end $f$;

-- The pair cases and N08-x.
create function pg_temp.n08x_pairs() returns void language plpgsql as $f$
declare fn text; cls text;
  short jsonb := '{"devos_calisma": "cal", "devos_denetim": "den", "devos_kurulum": "kur", "devos_ci": "ci"}';
begin
  perform pg_temp.n08x_ready();
  foreach fn in array array['claim', 'heartbeat', 'release', 'revise_work', 'mark_stale', 'cancel_work', 'reopen_for_review',
                            'relate', 'retract_relation', 'set_effort_policy'] loop
    perform pg_temp.n08x_pair('EXF-pair-' || fn, fn, 'devos_calisma', true);
  end loop;
  perform pg_temp.n08x_pair('EXF-pair-reads-affected_entities', 'affected_entities', 'devos_calisma', true);
  perform pg_temp.n08x_pair('EXF-pair-reads-explain_paths', 'explain_paths', 'devos_calisma', true);
  perform pg_temp.n08x_state();
  -- N08-x-<function>-<class> (EV-C02-008 5.1, after CHK-C02-027 D): EXF-pair's comparison with each of the four tokens
  -- the reader finder's role-refusal rule names, for the nine functions it exempts.
  foreach fn in array pg_temp.n08_exempt() loop
    foreach cls in array array['devos_calisma', 'devos_denetim', 'devos_kurulum', 'devos_ci'] loop
      perform pg_temp.n08x_pair(format('N08-x-%s-%s', fn, short->>cls), fn, cls, false);
    end loop;
  end loop;
end $f$;
create function pg_temp.n08_exempt() returns text[] language sql immutable as $f$
  select array['revise_work', 'mark_stale', 'cancel_work', 'reopen_for_review', 'relate', 'retract_relation',
               'set_effort_policy', 'affected_entities', 'explain_paths']
$f$;

do $$
declare why text;
begin
  why := pg_temp.w07_pre(string_to_array('admit_work,open_mission,open_decision,claim,heartbeat,release,record_eval_run,set_effort_policy,'
           || 'revise_work,mark_stale,cancel_work,reopen_for_review,relate,retract_relation,ready_works,affected_entities,explain_paths', ','),
         string_to_array('work,work_revision,eval_run,decision,decision_revision,mission,event,rejected_attempt,assignment,effort_policy,relation', ','));
  if why is null then
    begin
      perform pg_temp.w07_mission();
    exception when others then
      why := 'the fixture Mission could not be made: ' || sqlstate || ' ' || left(sqlerrm, 200);
    end;
  end if;
  if why is not null then
    perform pg_temp.w07_put('N08-pre-x', 'could_not_check', why);
    return;
  end if;
  begin
    why := pg_temp.n08x_fixtures();
  exception when others then
    why := 'the pair fixtures stopped on an error of the test itself: ' || sqlstate || ' ' || left(sqlerrm, 200);
  end;
  if why is not null then
    perform pg_temp.w07_put('EXF-pair-fixtures', 'could_not_check', why);
  else
    perform pg_temp.w07_run('EXF-pair', $q$select pg_temp.n08x_pairs()$q$);
  end if;
  perform pg_temp.w07_run('N08-s3', $q$select pg_temp.n08x_s3()$q$);
  perform pg_temp.w07_run('N08-s4', $q$select pg_temp.n08x_s4()$q$);
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_N08_EXAM_FACT FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_N08_EXAM_FACT COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_N08_EXAM_FACT PASS (%/%)', n, n;
end $$;

rollback;
