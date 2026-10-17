-- Synthetic test data (plan Section 8 item 13): every Mission, decision, work item, relation, exam run, claim and
-- artifact below is made up for this test, labelled SYNTHETIC W-C02-07 or w07_fixture, and holds no personal or
-- business data and no credential. Tokens are issued at run time inside this rolled-back transaction, kept in a
-- PL/pgSQL variable only, and never stored, printed, compared or put in an error text (README section 6).
--
-- Claim. T-W07-ROC: Rules O and C of EV-C02-008 section 1.7.1. A class the role gate admits changes a work item (its
-- revision, staleness, cancellation, review set, hard relations) only where Rule O lets it: devos_kurulum only the
-- installation's work items, devos_sinav only work items its exam link names, devos_calisma any work item not under
-- the installation's Mission, with the same answers on an exam task as on an ordinary item; devos_denetim's
-- reopen_for_review any item. Rule C: a revision, a cancellation or a hard relation is refused while another role
-- class's claim is on the item; mark_stale is not; a claim of the caller's own class does not stop a cancellation, and
-- the claimant's earlier result is kept as a candidate (B:136).
-- Specification: tests/C02/W-C02-07/T-W07-ROC_ownership_and_claim_class.md
-- Where it runs: the migration job's devos-test step, as postgres, after the merge's migrations (README 5.1 (a));
-- the break harness's throwaway PostgreSQL (README 5.2). Transport sql-set-role: each call runs as anon with the token
-- header simulated by set_config('request.headers', ..., true), so session_user stays postgres.
-- Interface assumed: the specification's "Interface assumed" (README section 8.1; revised before a first result if the
-- build chooses another form, README section 8). Two owner-level statements the build's record names are hooks below
-- (pg_temp.roc_hook); empty, the cases that need them give could_not_check with the reason.
-- Safety: everything runs inside begin ... rollback; nothing is committed. Each case's call runs in a subtransaction
-- that is undone after it is observed, so the fixtures stay as made. No psql meta-command is used.
-- Output: one row per case (case_id, outcome, detail), then W07_ROC_OWNERSHIP_AND_CLAIM_CLASS PASS as a notice, or
-- FAIL / COULD NOT CHECK as an exception (README section 3). Before the build exists it gives COULD NOT CHECK.
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '120s';

-- Common helpers of Group C (copied from w07_n03_effort_policy.sql, README section 7, with two more call forms in
-- w07_sig and w07_call for README 8.1's (work_id uuid, reason text) and (relation_id uuid, reason text); source: Group C's prelude, which
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
      'confidence', 'medium', 'changeable', 'no', 'epistemic_status', 'observation', 'current_authority', 'information_only', 'privacy_class', 'public', 'scope', 'synthetic.w07_fixture', 'status', 'candidate');
    if k = 'fbm1' then a := a || '{"counter_evidence_searched": "-"}';
    elsif k = 'fbm2' then a := a || jsonb_build_object('claim', lab || ': the w07_fixture product costs 10 units today',
         'counter_evidence_searched', 'none found', 'changeable', 'no'); end if;
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
-- Hooks (README section 8): owner-level statements the build's record names before the first result. Empty: the
-- cases that need them give could_not_check, never a pass.
create function pg_temp.roc_hook(p_key text) returns text language sql immutable as $f$
  select t.v from (values
    -- Returns the id (text) of a Mission the build treats as the installation's under Rule O: the Mission the ledger
    -- transfer's transfer_mission writes, whose creation event is of type transferred (B:138, B:268; CHK-C02-025 F5,
    -- "W-C02-09's record should name this marker"). Run as owner inside this rolled-back transaction.
    ('installation_mission', ''),
    -- Given $1 = from_ref and $2 = to_ref (work item ids, text), returns the id (text) of a relation between them whose
    -- creation event is of type transferred (B:268; EV-C02-008 1.7.1's last bullet), in the form W-C02-09's record names.
    ('transferred_relation', '')
  ) t(k, v) where t.k = p_key
$f$;

create temp table roc_ans (case_id text primary key, kind text, code text);

-- Every devos_private table but env_tokens, event and rejected_attempt, as (count, hash): "nothing changed". The
-- hashes are compared, never printed.
create function pg_temp.roc_snap() returns jsonb language plpgsql as $f$
declare t record; j jsonb := '{}'; c bigint; h text;
begin
  for t in select cl.oid::regclass::text rel, cl.relname from pg_class cl join pg_namespace n on n.oid = cl.relnamespace
           where n.nspname = 'devos_private' and cl.relkind in ('r', 'p')
             and cl.relname not in ('env_tokens', 'event', 'rejected_attempt') order by cl.relname loop
    execute format('select count(*), coalesce(md5(string_agg(x::text, ''|'' order by x::text)), '''') from %s x', t.rel) into c, h;
    j := j || jsonb_build_object(t.relname, jsonb_build_array(c, h));
  end loop;
  return j;
end $f$;

-- One call, observed and then undone: p_prep (owner level, may be null) runs first; the answer and whether any
-- devos_private table changed are returned; the call's effects and p_prep's are rolled back.
create function pg_temp.roc_try(p_class text, p_fn text, p_args jsonb, p_prep text default null) returns jsonb
language plpgsql as $f$
declare r jsonb; s0 jsonb; s1 jsonb; pe text;
begin
  begin
    if p_prep is not null then
      begin
        execute p_prep;
      exception when others then
        pe := sqlstate || ' ' || left(sqlerrm, 140);
        raise exception using errcode = 'P0W7U', message = 'w07: prep failed';
      end;
    end if;
    s0 := pg_temp.roc_snap();
    r := pg_temp.w07_call(p_class, p_fn, p_args);
    s1 := pg_temp.roc_snap();
    raise exception using errcode = 'P0W7U', message = 'w07: undo the case';
  exception when sqlstate 'P0W7U' then null;
  end;
  if pe is not null then return jsonb_build_object('w07_cnc', 'the planted state could not be made: ' || pe); end if;
  return r || jsonb_build_object('w07_changed', s0 is distinct from s1);
end $f$;

-- p_want: accepted | refused. A refusal must be returned (interface v1), after the gate (not a token refusal, which
-- would mean the test's own token failed), and leave every table as it was.
create function pg_temp.roc_case(p_case text, p_class text, p_fn text, p_args jsonb, p_want text, p_prep text default null)
returns jsonb language plpgsql as $f$
declare r jsonb; k text; ok boolean;
begin
  r := pg_temp.roc_try(p_class, p_fn, p_args, p_prep);
  k := pg_temp.w07_kind(r);
  if k = 'refused' and r->>'reason_code' = any(array['missing', 'empty', 'malformed', 'unknown', 'revoked', 'header_unreadable']) then
    k := 'test_cnc'; r := r || jsonb_build_object('w07_cnc', 'the synthetic token was refused (' || (r->>'reason_code') || ')');
  end if;
  insert into roc_ans values (p_case, k, r->>'reason_code') on conflict (case_id) do update set kind = excluded.kind, code = excluded.code;
  if k = 'test_cnc' then perform pg_temp.w07_put(p_case, 'could_not_check', r->>'w07_cnc'); return r; end if;
  if k = 'unknown' then
    perform pg_temp.w07_put(p_case, 'could_not_check', format('%s with %s: not an answer of interface v1: %s', p_fn, p_class,
      pg_temp.w07_brief(r)));
    return r;
  end if;
  ok := k = p_want and (p_want = 'accepted' or not coalesce((r->>'w07_changed')::boolean, true));
  perform pg_temp.w07_rec(p_case, ok, format('%s with %s: wanted %s; got %s; tables changed: %s', p_fn, p_class, p_want,
    pg_temp.w07_brief(r), coalesce(r->>'w07_changed', '?')));
  return r;
end $f$;

-- A work item admitted under p_mission with p_class's token; null when refused (the reason goes to p_why).
create function pg_temp.roc_admit(p_class text, p_mission text) returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  r := pg_temp.w07_call(p_class, 'admit_work', pg_temp.w07_args('work', 'complete', nextval('w07_seq')::int, 'routine')
         || jsonb_build_object('mission_ref', p_mission));
  if pg_temp.w07_kind(r) <> 'accepted' then return jsonb_build_object('why', p_class || ' admit_work: ' || pg_temp.w07_brief(r)); end if;
  return jsonb_build_object('id', r->>'id');
end $f$;
create function pg_temp.roc_rel_args(p_from text, p_to text, p_hard boolean) returns jsonb language sql as $f$
  select jsonb_build_object('type', case when p_hard then 'depends_on' else 'about' end, 'from_ref', p_from, 'from_revision', 1,
    'to_ref', p_to, 'to_revision', 1, 'scope', 'synthetic.w07_fixture.c', 'hard', p_hard, 'method', 'recorded',
    'epistemic_status', 'inference')
$f$;
create function pg_temp.roc_relate(p_class text, p_from text, p_to text) returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  r := pg_temp.w07_call(p_class, 'relate', pg_temp.roc_rel_args(p_from, p_to, true));
  if pg_temp.w07_kind(r) <> 'accepted' then return jsonb_build_object('why', p_class || ' relate: ' || pg_temp.w07_brief(r)); end if;
  return jsonb_build_object('id', r->>'id');
end $f$;
create function pg_temp.roc_fx(p_k text) returns text language sql as $f$ select v from w07_fx where k = p_k $f$;

-- The fixtures: an ordinary Mission (opened with devos_kurulum, as every Mission until C06), two working items, an
-- exam task opened with devos_sinav and linked by an exam run, and, through the hook, an item under the
-- installation's Mission; for each kind, a hard relation from it to w_other (to retract).
create function pg_temp.roc_fixtures() returns void language plpgsql as $f$
declare m text; x jsonb; h text; im text;
begin
  m := pg_temp.w07_mission();
  x := pg_temp.roc_admit('devos_calisma', m);
  if x ? 'why' then raise exception using errcode = 'P0W07', message = 'fixture w_other: ' || (x->>'why'); end if;
  insert into w07_fx values ('w_other', x->>'id');
  x := pg_temp.roc_admit('devos_calisma', m);
  if x ? 'why' then raise exception using errcode = 'P0W07', message = 'fixture w_cal: ' || (x->>'why'); end if;
  insert into w07_fx values ('w_cal', x->>'id');
  -- The exam task: opened with devos_sinav as ordinary work (B:38, B:286); its exam link is an exam run naming it,
  -- planted at owner level (record_eval_run's payload is not fixed: README 8.1). If the build refuses devos_sinav's
  -- admit_work for a task with no exam link yet, the task is opened with devos_calisma and the detail says so.
  x := pg_temp.roc_admit('devos_sinav', m);
  if x ? 'why' then
    insert into w07_fx values ('w_exam_opener', 'devos_calisma (devos_sinav refused: ' || left(x->>'why', 200) || ')');
    x := pg_temp.roc_admit('devos_calisma', m);
    if x ? 'why' then raise exception using errcode = 'P0W07', message = 'fixture w_exam: ' || (x->>'why'); end if;
  else
    insert into w07_fx values ('w_exam_opener', 'devos_sinav');
  end if;
  insert into w07_fx values ('w_exam', x->>'id');
  perform pg_temp.w07_plant_row('eval_run', jsonb_build_object('work_ref', x->>'id'));
  -- The installation's Mission, through the hook.
  h := pg_temp.roc_hook('installation_mission');
  if coalesce(h, '') = '' then
    insert into w07_fx values ('inst_why', 'the installation''s Mission is marked by a form W-C02-09''s record names (CHK-C02-025 F5); '
      || 'pg_temp.roc_hook(''installation_mission'') is empty until then (README section 8)');
  else
    begin
      execute h into im;
      x := pg_temp.roc_admit('devos_kurulum', im);
      if x ? 'why' then raise exception using errcode = 'P0W07', message = x->>'why'; end if;
      insert into w07_fx values ('w_inst', x->>'id');
    exception when others then
      insert into w07_fx values ('inst_why', 'the installation''s work item could not be made: ' || sqlstate || ' ' || left(sqlerrm, 200));
    end;
  end if;
  -- One hard relation from each kind to w_other, made with a class Rule O admits on it.
  x := pg_temp.roc_relate('devos_calisma', pg_temp.roc_fx('w_cal'), pg_temp.roc_fx('w_other'));
  insert into w07_fx values ('r_cal', coalesce(x->>'id', '')), ('r_cal_why', coalesce(x->>'why', ''));
  x := pg_temp.roc_relate('devos_calisma', pg_temp.roc_fx('w_exam'), pg_temp.roc_fx('w_other'));
  insert into w07_fx values ('r_exam', coalesce(x->>'id', '')), ('r_exam_why', coalesce(x->>'why', ''));
  if pg_temp.roc_fx('w_inst') is not null then
    x := pg_temp.roc_relate('devos_kurulum', pg_temp.roc_fx('w_inst'), pg_temp.roc_fx('w_other'));
    insert into w07_fx values ('r_inst', coalesce(x->>'id', '')), ('r_inst_why', coalesce(x->>'why', ''));
  end if;
end $f$;

-- The arguments of each function on one work item (or, for retract_relation, on the relation from it).
create function pg_temp.roc_args(p_fn text, p_work text, p_rel text) returns jsonb language sql as $f$
  select case p_fn
    when 'revise_work' then jsonb_build_object('id', p_work, 'base_revision', 1, 'scope', 'synthetic.w07_fixture.c',
      'purpose', 'SYNTHETIC W-C02-07 w07_fixture: revised purpose', 'reason', 'SYNTHETIC W-C02-07 w07_fixture revision')
    when 'relate' then pg_temp.roc_rel_args(p_work, (select v from w07_fx where k = 'w_other'), true)
             || jsonb_build_object('type', 'depends_on')
    when 'retract_relation' then jsonb_build_object('relation_id', p_rel, 'reason', 'SYNTHETIC W-C02-07 w07_fixture retraction')
    else jsonb_build_object('work_id', p_work, 'reason', 'SYNTHETIC W-C02-07 w07_fixture ' || p_fn) end
$f$;

-- Rule O, every function x class x kind (EV-C02-008 1.7.1's table of tests). reopen_for_review's items are planted
-- finished and accepted first (its input, as T-W07-F06's recipe plants it), inside the undone subtransaction.
create function pg_temp.roc_rule_o() returns void language plpgsql as $f$
declare fn text; cls text; kind text; w text; rel text; want text; cid text; prep text; why text;
        expect jsonb := jsonb_build_object(
          'devos_calisma', jsonb_build_object('cal', 'accepted', 'inst', 'refused', 'exam', 'accepted'),
          'devos_sinav', jsonb_build_object('cal', 'refused', 'inst', 'refused', 'exam', 'accepted'),
          'devos_kurulum', jsonb_build_object('cal', 'refused', 'inst', 'accepted', 'exam', 'refused'));
        short jsonb := '{"devos_calisma": "cal", "devos_sinav": "sin", "devos_kurulum": "kur", "devos_denetim": "den"}';
begin
  foreach fn in array array['revise_work', 'mark_stale', 'cancel_work', 'reopen_for_review', 'relate', 'retract_relation'] loop
    foreach cls in array array['devos_calisma', 'devos_sinav', 'devos_kurulum', 'devos_denetim'] loop
      continue when cls = 'devos_denetim' and fn <> 'reopen_for_review';  -- den passes only reopen_for_review's gate (R24)
      foreach kind in array array['cal', 'inst', 'exam'] loop
        cid := format('ROC-o-%s-%s-%s', fn, short->>cls, kind);
        w := pg_temp.roc_fx('w_' || kind); rel := nullif(pg_temp.roc_fx('r_' || kind), '');
        if w is null then
          perform pg_temp.w07_put(cid, 'could_not_check', coalesce(pg_temp.roc_fx(kind || '_why'), 'no work item of this kind')); continue;
        end if;
        if fn = 'retract_relation' and rel is null then
          perform pg_temp.w07_put(cid, 'could_not_check', 'no relation from this kind could be made: ' || coalesce(pg_temp.roc_fx('r_' || kind || '_why'), '?')); continue;
        end if;
        want := case when cls = 'devos_denetim' then 'accepted' else expect->cls->>kind end;
        prep := case when fn = 'reopen_for_review' then
          format('update devos_private.work set execution = ''finished'', acceptance = ''accepted'' where id::text = %L', w) end;
        perform pg_temp.roc_case(cid, cls, fn, pg_temp.roc_args(fn, w, rel), want, prep);
      end loop;
    end loop;
  end loop;
  -- The exam fact not leaked by Rules O and C (1.7.1): devos_calisma's answer on the exam task equals its answer on an
  -- ordinary working item, function by function (status and reason code).
  foreach fn in array array['revise_work', 'mark_stale', 'cancel_work', 'reopen_for_review', 'relate', 'retract_relation'] loop
    cid := 'ROC-leak-' || fn;
    if exists (select 1 from roc_ans a join roc_ans b on true where a.case_id = format('ROC-o-%s-cal-cal', fn)
               and b.case_id = format('ROC-o-%s-cal-exam', fn) and 'test_cnc' not in (a.kind, b.kind) and 'unknown' not in (a.kind, b.kind)) then
      perform pg_temp.w07_rec(cid, (select a.kind = b.kind and coalesce(a.code, '') = coalesce(b.code, '') from roc_ans a, roc_ans b
                                    where a.case_id = format('ROC-o-%s-cal-cal', fn) and b.case_id = format('ROC-o-%s-cal-exam', fn)),
        (select format('devos_calisma on an ordinary item: %s %s; on the exam task (opened with %s): %s %s', a.kind, coalesce(a.code, '-'),
                       pg_temp.roc_fx('w_exam_opener'), b.kind, coalesce(b.code, '-'))
           from roc_ans a, roc_ans b where a.case_id = format('ROC-o-%s-cal-cal', fn) and b.case_id = format('ROC-o-%s-cal-exam', fn)));
    else
      perform pg_temp.w07_put(cid, 'could_not_check', 'one of the two answers compared was not observed');
    end if;
  end loop;
  -- A relation whose creation event is transferred is retracted only with devos_kurulum (1.7.1).
  why := null;
  if coalesce(pg_temp.roc_hook('transferred_relation'), '') = '' then
    why := 'a transferred relation is planted in a form W-C02-09''s record names; pg_temp.roc_hook(''transferred_relation'') is empty until then (README section 8)';
  else
    begin
      execute pg_temp.roc_hook('transferred_relation') using pg_temp.roc_fx('w_cal'), pg_temp.roc_fx('w_other') into rel;
    exception when others then
      why := 'the transferred relation could not be planted: ' || sqlstate || ' ' || left(sqlerrm, 160);
    end;
  end if;
  foreach cls in array array['devos_calisma', 'devos_sinav', 'devos_kurulum'] loop
    cid := 'ROC-o-retract_relation-' || (short->>cls) || '-transferred';
    if why is not null then perform pg_temp.w07_put(cid, 'could_not_check', why); continue; end if;
    perform pg_temp.roc_case(cid, cls, 'retract_relation', pg_temp.roc_args('retract_relation', null, rel),
      case when cls = 'devos_kurulum' then 'accepted' else 'refused' end);
  end loop;
end $f$;

-- Phase C5 (CHK-C02-030 C4): an active devos_denetim claim on a work item, planted at owner level (README 5.1 (a)),
-- with Appendix B 3.5's fields where the table has them: the next generation, the current global authority epoch,
-- the item's current revision, a lease of 30 minutes (EV-C02-002 DM-07). No token is issued for it: its claim token
-- hash is random characters, the hash of no token, never read or compared. Returns null, or why it failed.
create function pg_temp.roc_plant_audit_claim(p_work text) returns text language plpgsql as $f$
begin
  return pg_temp.roc_plant_claim(p_work, 'devos_denetim', 'w07_fixture_session_audit SYNTHETIC W-C02-07');
end $f$;
create function pg_temp.roc_plant_claim(p_work text, p_class text, p_session text) returns text language plpgsql as $f$
declare base jsonb := '{}'; v text;
begin
  if to_regclass('devos_private.assignment') is null then return 'devos_private.assignment does not exist'; end if;
  base := jsonb_build_object('work_ref', p_work, 'role_class', p_class, 'status', 'active',
                             'declared_session_id', p_session,
                             'lease_expires_at', (now() + interval '30 minutes')::text, 'last_heartbeat_at', now()::text);
  execute 'select (coalesce(max((to_jsonb(a)->>''generation'')::bigint), 0) + 1)::text from devos_private.assignment a
             where to_jsonb(a)->>''work_ref'' = $1' into v using p_work;
  base := base || jsonb_build_object('generation', v);
  if to_regclass('devos_private.global_authority_epoch') is not null then
    execute 'select max(epoch)::text from devos_private.global_authority_epoch' into v;
    if v is not null then base := base || jsonb_build_object('authority_epoch', v); end if;
  end if;
  execute 'select to_jsonb(w)->>''revision'' from devos_private.work w where w.id::text = $1' into v using p_work;
  if v is not null then base := base || jsonb_build_object('work_revision', v); end if;
  -- random characters, the hash of no token (read as text, or as bytea's escape form, which needs no backslash)
  base := base || jsonb_build_object('claim_token_hash', md5(random()::text) || md5(random()::text));
  -- only the keys the table has
  select coalesce(jsonb_object_agg(k, base->k), '{}') into base from jsonb_object_keys(base) k
   where exists (select 1 from information_schema.columns
                  where table_schema = 'devos_private' and table_name = 'assignment' and column_name = k);
  begin
    perform pg_temp.w07_plant_row('assignment', base);
  exception when others then
    return sqlstate || ' ' || left(sqlerrm, 200);
  end;
  return null;
end $f$;

-- Rule C: with an audit claim on a working item, devos_calisma's revision, cancellation and hard relations are refused,
-- and mark_stale and a descriptive relation are accepted (1.7.1).
create function pg_temp.roc_rule_c() returns void language plpgsql as $f$
declare m text := pg_temp.w07_mission(); x jsonb; wc text; wo text; rc text; r jsonb; why text; c text;
begin
  x := pg_temp.roc_admit('devos_calisma', m); wc := x->>'id'; why := x->>'why';
  if why is null then x := pg_temp.roc_admit('devos_calisma', m); wo := x->>'id'; why := x->>'why'; end if;
  if why is null then x := pg_temp.roc_relate('devos_calisma', wc, wo); rc := x->>'id'; why := x->>'why'; end if;
  if why is null then
    r := pg_temp.w07_call('devos_denetim', 'claim', jsonb_build_object('work_id', wc, 'declared_session_id', 'w07_fixture_session_audit'));
    if pg_temp.w07_kind(r) <> 'accepted' then
      -- Phase C5 (CHK-C02-030 C4; README 5.1 (a)): the rule under test is Rule C, not who may claim (devos_denetim's
      -- claim row's "its review work" is C03's design, EV-C02-008 1.7.5 (a)), so the audit claim is planted, active,
      -- at owner level inside this rolled-back transaction, and Rule C's six cases are judged in C02.
      why := pg_temp.roc_plant_audit_claim(wc);
      if why is not null then
        why := 'devos_denetim''s claim was refused (' || pg_temp.w07_brief(r - 'claim_token')
          || '), and the owner-level plant of an active devos_denetim claim failed: ' || why;
      end if;
    end if;
    r := null;
  end if;
  if why is not null then
    foreach c in array array['ROC-c-revise_work', 'ROC-c-cancel_work', 'ROC-c-relate', 'ROC-c-retract_relation',
                             'ROC-c-mark_stale-pos', 'ROC-c-relate-soft-pos'] loop
      perform pg_temp.w07_put(c, 'could_not_check', why);
    end loop;
    return;
  end if;
  perform pg_temp.roc_case('ROC-c-revise_work', 'devos_calisma', 'revise_work', pg_temp.roc_args('revise_work', wc, null), 'refused');
  perform pg_temp.roc_case('ROC-c-cancel_work', 'devos_calisma', 'cancel_work', pg_temp.roc_args('cancel_work', wc, null), 'refused');
  perform pg_temp.roc_case('ROC-c-relate', 'devos_calisma', 'relate', pg_temp.roc_rel_args(wc, wo, true), 'refused');
  perform pg_temp.roc_case('ROC-c-retract_relation', 'devos_calisma', 'retract_relation', pg_temp.roc_args('retract_relation', null, rc), 'refused');
  perform pg_temp.roc_case('ROC-c-mark_stale-pos', 'devos_calisma', 'mark_stale', pg_temp.roc_args('mark_stale', wc, null), 'accepted');
  perform pg_temp.roc_case('ROC-c-relate-soft-pos', 'devos_calisma', 'relate', pg_temp.roc_rel_args(wc, wo, false), 'accepted');
end $f$;

-- Phase C5 (CHK-C02-030 C7 (b); W-C02-07 point 6; W-C02-09 point 7; README section 3 (i)). Rules O and C read inputs
-- that can be missing, unreadable or partial: the work item's Mission reference (Rule O), the relation's creation event
-- (Rule O's "transferred" check, read for every relation retract_relation is given) and the active claims (Rule C).
-- Each is planted at owner level, one at a time, inside an undone subtransaction, on a call the unplanted file accepts
-- (ROC-o-revise_work-cal-cal and ROC-o-retract_relation-cal-cal are the positive pairs). Wanted: interface v1's could
-- not check (status refused, reason_code could_not_check), kept apart from clean (accepted) and from fail (refused with
-- another code), with no table changed, no event on the target and no record returned. The forms are the designer's
-- (T-W07-ROC, "Could not check"):
--   missing    the Mission reference null; the relation's creation event deleted; the claims table absent (renamed);
--   unreadable every privilege on the table that holds the input (mission, event, assignment) revoked from the called
--              function's owner for the call, and given back before the observation;
--   partial    the Mission reference naming no Mission; the creation event with its event_type null; an active claim on
--              the item with its role_class null.
create function pg_temp.roc_x_owner(p_fn text) returns text language plpgsql as $f$
declare o text; su boolean;
begin
  select pg_get_userbyid(p.proowner), r.rolsuper into o, su from pg_proc p join pg_namespace n on n.oid = p.pronamespace
    join pg_roles r on r.oid = p.proowner where n.nspname = 'devos_api' and p.proname = p_fn limit 1;
  if o is null then raise exception using errcode = 'P0W07', message = 'devos_api.' || p_fn || ' does not exist'; end if;
  if su then raise exception using errcode = 'P0W07', message = 'devos_api.' || p_fn || '''s owner is a superuser, '
    || 'so no privilege can make a table unreadable to it'; end if;
  return o;
end $f$;
-- The data part of a plant (before the "before" snapshot).
create function pg_temp.roc_x_prep(p_kind text, p_id text) returns void language plpgsql as $f$
declare t text; mc text; c record; n bigint; tot bigint := 0;
begin
  if p_kind in ('mission-missing', 'mission-partial') then
    -- Revision before any result (N-278 (2), same class): the built link is work_revision.mission_revision_id (DM-02).
    for t, mc in select table_name, column_name from information_schema.columns where table_schema = 'devos_private'
              and table_name in ('work', 'work_revision') and column_name in ('mission_ref', 'mission_revision_id') loop
      execute format('alter table devos_private.%I alter column %I drop not null', t, mc);
      if p_kind = 'mission-partial' then
        for c in select con.conname from pg_constraint con where con.conrelid = ('devos_private.' || t)::regclass
                   and con.contype = 'f' and exists (select 1 from pg_attribute a where a.attrelid = con.conrelid
                   and a.attnum = any(con.conkey) and a.attname = mc) loop
          execute format('alter table devos_private.%I drop constraint %I', t, c.conname);
        end loop;
      end if;
      -- The built revision table is append-only by trigger (DM-02); the owner-level plant switches its user triggers off
      -- for this one update, as the event branch below does.
      execute format('alter table devos_private.%I disable trigger user', t);
      execute format('update devos_private.%I x set %I = %s where (%L = ''work'' and to_jsonb(x)->>''id'' = $1) '
                     || 'or to_jsonb(x)->>''work_id'' = $1 or to_jsonb(x)->>''work_ref'' = $1', t, mc,
                     case when p_kind = 'mission-missing' then 'null'
                          else quote_literal(md5('w07_fixture SYNTHETIC W-C02-07 no such mission')::uuid::text) end, t)
        using p_id;
      get diagnostics n = row_count; tot := tot + n;
      execute format('alter table devos_private.%I enable trigger user', t);
    end loop;
    if tot = 0 then raise exception using errcode = 'P0W07', message = 'no mission_ref of the work item was found to plant'; end if;
  elsif p_kind in ('event-missing', 'event-partial') then
    execute 'alter table devos_private.event disable trigger user';
    if p_kind = 'event-missing' then
      execute 'delete from devos_private.event e where to_jsonb(e)->>''aggregate_id'' = $1' using p_id;
    else
      execute 'alter table devos_private.event alter column event_type drop not null';
      execute 'update devos_private.event e set event_type = null where e.ctid = (select x.ctid from devos_private.event x
                 where to_jsonb(x)->>''aggregate_id'' = $1 order by to_jsonb(x)->>''created_at'' limit 1)' using p_id;
    end if;
    get diagnostics n = row_count;
    execute 'alter table devos_private.event enable trigger user';
    if n = 0 then raise exception using errcode = 'P0W07', message = 'the relation has no creation event to plant on'; end if;
  elsif p_kind = 'claims-partial' then
    t := pg_temp.roc_plant_claim(p_id, 'devos_denetim', 'w07_fixture_session_partial SYNTHETIC W-C02-07');
    if t is not null then raise exception using errcode = 'P0W07', message = 'the claim could not be planted: ' || t; end if;
    execute 'alter table devos_private.assignment alter column role_class drop not null';
    execute 'update devos_private.assignment a set role_class = null where to_jsonb(a)->>''work_ref'' = $1
               and to_jsonb(a)->>''declared_session_id'' = ''w07_fixture_session_partial SYNTHETIC W-C02-07''' using p_id;
    get diagnostics n = row_count;
    if n = 0 then raise exception using errcode = 'P0W07', message = 'the planted claim was not found'; end if;
  end if;
end $f$;
-- The access part of a plant (after the "before" snapshot), and its reversal (before the "after" snapshot).
create function pg_temp.roc_x_access(p_kind text, p_fn text, p_on boolean) returns void language plpgsql as $f$
declare t text := case split_part(p_kind, '-', 1) when 'mission' then 'mission' when 'event' then 'event' else 'assignment' end;
begin
  if p_kind like '%-unreadable' then
    if to_regclass('devos_private.' || t) is null then
      raise exception using errcode = 'P0W07', message = 'devos_private.' || t || ' does not exist'; end if;
    execute format(case when p_on then 'revoke all on devos_private.%I from %I' else 'grant all on devos_private.%I to %I' end,
                   t, pg_temp.roc_x_owner(p_fn));
  elsif p_kind = 'claims-missing' then
    if p_on then execute 'alter table devos_private.assignment rename to assignment_w07_missing';
    else execute 'alter table devos_private.assignment_w07_missing rename to assignment'; end if;
  end if;
end $f$;
create function pg_temp.roc_x_events(p_target text) returns bigint language plpgsql as $f$
declare n bigint;
begin
  execute 'select count(*) from devos_private.event e where to_jsonb(e)->>''aggregate_id'' = $1' into n using p_target;
  return n;
exception when others then return null;
end $f$;
create function pg_temp.roc_x_case(p_case text, p_fn text, p_args jsonb, p_kind text, p_id text, p_target text)
returns text language plpgsql as $f$
declare r jsonb; s0 jsonb; s1 jsonb; e0 bigint; e1 bigint; pe text; k text; ret text;
begin
  begin
    begin
      perform pg_temp.roc_x_prep(p_kind, p_id);
      s0 := pg_temp.roc_snap(); e0 := pg_temp.roc_x_events(p_target);
      perform pg_temp.roc_x_access(p_kind, p_fn, true);
    exception when others then
      pe := sqlstate || ' ' || left(sqlerrm, 160);
      raise exception using errcode = 'P0W7U', message = 'w07: plant failed';
    end;
    r := pg_temp.w07_call('devos_calisma', p_fn, p_args);
    perform pg_temp.roc_x_access(p_kind, p_fn, false);
    s1 := pg_temp.roc_snap(); e1 := pg_temp.roc_x_events(p_target);
    raise exception using errcode = 'P0W7U', message = 'w07: undo the case';
  exception when sqlstate 'P0W7U' then null;
  end;
  if pe is not null then
    perform pg_temp.w07_put(p_case, 'could_not_check', 'the ' || p_kind || ' input could not be planted: ' || pe); return 'test';
  end if;
  k := pg_temp.w07_kind(r);
  if k = 'refused' and r->>'reason_code' = any(array['missing', 'empty', 'malformed', 'unknown', 'revoked', 'header_unreadable']) then
    perform pg_temp.w07_put(p_case, 'could_not_check', 'the synthetic token was refused (' || (r->>'reason_code') || ')'); return 'test';
  elsif k in ('unknown', 'test_cnc') then
    perform pg_temp.w07_put(p_case, 'could_not_check', format('%s, %s planted: not an answer of interface v1: %s', p_fn, p_kind,
      pg_temp.w07_brief(r))); return 'test';
  elsif k = 'accepted' then
    perform pg_temp.w07_rec(p_case, false, format('%s, %s planted: answered clean (accepted), wanted could not check: %s',
      p_fn, p_kind, pg_temp.w07_brief(r))); ret := 'clean';
  elsif k = 'refused' then
    perform pg_temp.w07_rec(p_case, false, format('%s, %s planted: refused with %s, wanted could_not_check (could not check '
      || 'folded into fail)', p_fn, p_kind, coalesce(r->>'reason_code', '(no reason code)'))); ret := 'fail';
  else
    perform pg_temp.w07_rec(p_case, s0 is not distinct from s1 and e0 is not distinct from e1
        and not (r ?| array['id', 'records', 'works', 'paths', 'revision']),
      format('%s, %s planted: could not check (%s); tables changed: %s; events on the target %s -> %s; record keys returned: %s',
        p_fn, p_kind, left(coalesce(r->>'reason', ''), 120), s0 is distinct from s1, coalesce(e0::text, '?'), coalesce(e1::text, '?'),
        r ?| array['id', 'records', 'works', 'paths', 'revision'])); ret := 'could_not_check';
  end if;
  return ret;
end $f$;
create function pg_temp.roc_x() returns void language plpgsql as $f$
declare w text := pg_temp.roc_fx('w_cal'); rel text := pg_temp.roc_fx('r_cal'); kind text; form text; ans text;
        n jsonb := '{}'; chk text;
begin
  if coalesce(w, '') = '' then
    foreach kind in array array['o-mission', 'o-event', 'c-claims'] loop
      foreach form in array array['missing', 'unreadable', 'partial'] loop
        perform pg_temp.w07_put('ROC-x-' || kind || '-' || form, 'could_not_check', 'the fixture w_cal was not made');
      end loop;
    end loop;
    return;
  end if;
  foreach form in array array['missing', 'unreadable', 'partial'] loop
    ans := pg_temp.roc_x_case('ROC-x-o-mission-' || form, 'revise_work', pg_temp.roc_args('revise_work', w, null),
                              'mission-' || form, w, w);
    n := jsonb_set(n, array['Rule O, the Mission reference (revise_work)'], coalesce(n->'Rule O, the Mission reference (revise_work)', '[]') || to_jsonb(ans));
    if coalesce(rel, '') = '' then
      perform pg_temp.w07_put('ROC-x-o-event-' || form, 'could_not_check', 'the fixture relation r_cal was not made: '
        || coalesce(pg_temp.roc_fx('r_cal_why'), ''));
      ans := 'test';
    else
      ans := pg_temp.roc_x_case('ROC-x-o-event-' || form, 'retract_relation', pg_temp.roc_args('retract_relation', null, rel),
                                'event-' || form, rel, rel);
    end if;
    n := jsonb_set(n, array['Rule O, the creation event (retract_relation)'], coalesce(n->'Rule O, the creation event (retract_relation)', '[]') || to_jsonb(ans));
    ans := pg_temp.roc_x_case('ROC-x-c-claims-' || form, 'revise_work', pg_temp.roc_args('revise_work', w, null),
                              'claims-' || form, w, w);
    n := jsonb_set(n, array['Rule C, the active claims (revise_work)'], coalesce(n->'Rule C, the active claims (revise_work)', '[]') || to_jsonb(ans));
  end loop;
  -- README section 3: per check, the counts of clean, fail and could-not-check answers, with the denominator.
  for chk in select jsonb_object_keys(n) loop
    raise notice 'W07_ROC per-check answers, %: clean %, fail %, could not check %, the test''s own could not check %, of %', chk,
      (select count(*) from jsonb_array_elements_text(n->chk) x where x = 'clean'),
      (select count(*) from jsonb_array_elements_text(n->chk) x where x = 'fail'),
      (select count(*) from jsonb_array_elements_text(n->chk) x where x = 'could_not_check'),
      (select count(*) from jsonb_array_elements_text(n->chk) x where x = 'test'),
      jsonb_array_length(n->chk);
  end loop;
end $f$;

-- Rule C within one class: another working session's claim does not stop devos_calisma's cancellation, and the
-- claimant's result registered before it is kept as a candidate (B:136).
create function pg_temp.roc_same_class() returns void language plpgsql as $f$
declare m text := pg_temp.w07_mission(); x jsonb; ws text; cl jsonb; a jsonb; aid text; a0 text; a1 text; r jsonb; ex text;
begin
  x := pg_temp.roc_admit('devos_calisma', m);
  if x ? 'why' then
    perform pg_temp.w07_put('ROC-c-same-class-cancel', 'could_not_check', x->>'why');
    perform pg_temp.w07_put('ROC-c-late', 'could_not_check', x->>'why'); return;
  end if;
  ws := x->>'id';
  cl := pg_temp.w07_claimed(ws);  -- devos_calisma, declared session w07_fixture_session (the "other" working session)
  a := pg_temp.w07_call('devos_calisma', 'register_artifact', pg_temp.w07_artifact_args(cl, 'notes/w07_fixture_roc_late.md'));
  cl := null;
  if pg_temp.w07_kind(a) = 'accepted' then aid := a->>'id'; end if;
  begin
    if aid is not null then execute 'select to_jsonb(x)::text from devos_private.artifact x where x.id::text = $1' into a0 using aid; end if;
    r := pg_temp.w07_call('devos_calisma', 'cancel_work', jsonb_build_object('work_id', ws, 'reason',
           'SYNTHETIC W-C02-07 w07_fixture: cancelled by another working session'));
    execute 'select execution::text from devos_private.work where id::text = $1' into ex using ws;
    if aid is not null then execute 'select to_jsonb(x)::text from devos_private.artifact x where x.id::text = $1' into a1 using aid; end if;
    raise exception using errcode = 'P0W7U', message = 'w07: undo the case';
  exception when sqlstate 'P0W7U' then null;
  end;
  if pg_temp.w07_kind(r) = 'unknown' then
    perform pg_temp.w07_put('ROC-c-same-class-cancel', 'could_not_check', 'cancel_work: not an answer of interface v1: ' || pg_temp.w07_brief(r));
  else
    perform pg_temp.w07_rec('ROC-c-same-class-cancel', pg_temp.w07_kind(r) = 'accepted' and ex = 'cancelled',
      format('cancel_work with devos_calisma while another working session holds the claim: %s; execution %s (wanted accepted, cancelled)',
             pg_temp.w07_brief(r), coalesce(ex, 'absent')));
  end if;
  if aid is null then
    perform pg_temp.w07_put('ROC-c-late', 'could_not_check', 'the claimant''s artifact was not registered: ' || pg_temp.w07_brief(a));
  else
    perform pg_temp.w07_rec('ROC-c-late', a1 is not null and a1 = a0 and (a1::jsonb)->>'status' = 'candidate',
      format('the claimant''s artifact after the cancellation: %s, status %s (wanted present, unchanged, candidate)',
             case when a1 is null then 'absent' when a1 = a0 then 'unchanged' else 'changed' end, coalesce((a1::jsonb)->>'status', '-')));
  end if;
end $f$;

do $$
declare why text;
begin
  why := pg_temp.w07_pre(string_to_array('revise_work,mark_stale,cancel_work,reopen_for_review,relate,retract_relation,admit_work,open_mission,open_decision,claim,register_artifact', ','),
                         string_to_array('work,relation,eval_run,artifact,decision,decision_revision,mission', ','));
  if why is null then
    begin
      perform pg_temp.roc_fixtures();
    exception when others then
      why := 'the fixtures could not be made: ' || sqlstate || ' ' || left(sqlerrm, 200);
    end;
  end if;
  if why is not null then
    perform pg_temp.w07_put('ROC-pre', 'could_not_check', why);
    return;
  end if;
  perform pg_temp.w07_run('ROC-o', $q$select pg_temp.roc_rule_o()$q$);
  perform pg_temp.w07_run('ROC-c', $q$select pg_temp.roc_rule_c()$q$);
  perform pg_temp.w07_run('ROC-c-same-class', $q$select pg_temp.roc_same_class()$q$);
  perform pg_temp.w07_run('ROC-x', $q$select pg_temp.roc_x()$q$);
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_ROC_OWNERSHIP_AND_CLAIM_CLASS FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_ROC_OWNERSHIP_AND_CLAIM_CLASS COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_ROC_OWNERSHIP_AND_CLAIM_CLASS PASS (%/%)', n, n;
end $$;

rollback;
