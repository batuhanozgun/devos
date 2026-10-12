-- Synthetic test data (plan Section 8 item 13): the Mission, decisions, sample reviews, verdicts and revisions written
-- here are made up (text 'SYNTHETIC W-C02-07 w07_fixture'); no personal or business data, no credential. Tokens are
-- issued at run time and kept in PL/pgSQL variables only (README section 6).
--
-- THROWAWAY DATABASE ONLY. This scenario COMMITS, in several transactions, so it is not under supabase/migrations/
-- and the migration job never runs it; it refuses to run unless w07.throwaway = 'yes' and no role supabase_admin
-- exists (README 5.2). It is run by tests/C02/W-C02-07/harness/run_breaks.py.
-- Claim (T-W07-N28 part B2; EV-C02-008 section 2.5, S-neg-take; PC-46): a sample Review the database opened in an
-- earlier transaction can be judged (a Verdict on it alone is accepted), but the transaction that writes a Verdict on
-- it, or takes it by setting its reviewer fields if the build has that form, cannot also hold a new revision of its
-- target, in either order. Specification: tests/C02/W-C02-07/T-W07-N28_verifier_does_not_repair.md. The sample
-- stream of high_impact and batu decisions is set to a block of 1 here, as EV-C02-008 2.5 allows on the throwaway
-- database, so each decision draws its sample. No psql meta-command.
do $g$
begin
  if coalesce(current_setting('w07.throwaway', true), '') <> 'yes' then
    raise exception 'w07 scenario refused: the setting w07.throwaway is not yes (throwaway database only)';
  end if;
  if exists (select 1 from pg_roles where rolname = 'supabase_admin') then
    raise exception 'w07 scenario refused: role supabase_admin exists, so this may be a Supabase project';
  end if;
end $g$;
set search_path = pg_catalog, pg_temp;
set statement_timeout = '120s';
-- Common helpers of Group C (copied from w07_n03_effort_policy.sql, README section 7; source: Group C's prelude, which
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
                   when 'prepare_operation' then '(text,jsonb)' else '(jsonb)' end
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
        and column_name in ('name', 'irreversible')) <> 2 then
    raise exception using errcode = 'P0W07', message = 'devos_private.effect_class lacks name or irreversible'; end if;
  if not exists (select 1 from devos_private.effect_class where name::text = 'w07_fixture_reversible') then
    perform pg_temp.w07_plant_row('effect_class', '{"name": "w07_fixture_reversible", "irreversible": "false"}'); end if;
  if not exists (select 1 from devos_private.effect_class where name::text = 'w07_fixture_irreversible') then
    perform pg_temp.w07_plant_row('effect_class', '{"name": "w07_fixture_irreversible", "irreversible": "true"}'); end if;
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


-- Phase C4a (EV-C02-008 section 2.5). Hooks the build's record names before the first result (README section 8); empty,
-- the cases that need them give could_not_check with the reason, never a pass.
create function pg_temp.s_hook(p_key text) returns text language sql immutable as $f$
  select t.v from (values
    -- An owner-level statement that makes the sampling path's marker unreadable (EV-C02-008 2.2 condition 2: "W-C02-10's
    -- build chooses its form ... records it, and section 2.5's cases test it"); it runs inside an undone subtransaction.
    ('sample_marker_unreadable', ''),
    -- Taking a sample by setting its reviewer fields, if W-C02-10's build gives taking that form: an owner-level or
    -- devos_api statement with $1 = the sample's id. 'none' when the build takes a sample only through record_verdict
    -- (then the case is not applicable, and the specification and a notice say so: EV-C02-008 2.5, B-S3).
    ('take_sample', '')
  ) t(k, v) where t.k = p_key
$f$;

-- B:232's reviewer fields of a Review row: true when every one present is empty, null when none is present.
create function pg_temp.s_reviewer_empty(p_row jsonb) returns boolean language sql immutable as $f$
  select case when count(*) = 0 then null else bool_and(e.value is null or jsonb_typeof(e.value) = 'null'
           or e.value in ('""'::jsonb, '[]'::jsonb, '{}'::jsonb)) end
  from jsonb_each(p_row) e
  where e.key in ('reviewer_declared_session', 'reviewer_role_class', 'independence_level', 'view_ref', 'shared_with_producer')
$f$;
-- The sample Review rows naming a record (its id in the row).
create function pg_temp.s_sample_rows(p_id text) returns jsonb language plpgsql as $f$
declare j jsonb;
begin
  execute 'select coalesce(jsonb_agg(to_jsonb(r)), ''[]'') from devos_private.review r where r.kind::text = ''sample''
             and strpos(to_jsonb(r)::text, $1) > 0' into j using p_id;
  return j;
end $f$;
-- The cases of this file.
create temp table s_take (k text primary key, v text);
create function pg_temp.s_v(p_k text) returns text language sql as $f$ select v from s_take where k = p_k $f$;
create function pg_temp.s_verdict_args(p_review text) returns jsonb language sql as $f$
  select jsonb_build_object('review_ref', p_review, 'result', 'fail',
    'reason', 'SYNTHETIC W-C02-07 w07_fixture: the sampled decision''s premises are not stated')
$f$;
create function pg_temp.s_verdicts(p_review text) returns int language plpgsql as $f$
declare n int;
begin execute 'select count(*) from devos_private.verdict v where v.review_ref::text = $1' into n using p_review; return n; end $f$;
-- A new revision (2) of a decision, planted at owner level with only its key: every other column takes its default or a
-- synthetic value (Group C's w07_plant_row), so a column the build fills per transaction (DM-41 compares by the
-- transaction id) is this transaction's, not copied from revision 1. Returns null, or the error that refused it.
create function pg_temp.s_new_rev(p_decision text) returns text language plpgsql as $f$
begin
  perform pg_temp.w07_plant_row('decision_revision', jsonb_build_object('decision_id', p_decision, 'revision', 2));
  return null;
exception when others then
  return sqlstate || ' ' || left(sqlerrm, 160);
end $f$;
create function pg_temp.s_rev2(p_decision text) returns int language plpgsql as $f$
declare n int;
begin execute 'select count(*) from devos_private.decision_revision r where r.decision_id::text = $1 and r.revision = 2' into n using p_decision; return n; end $f$;

-- Transaction 1: the decision stream at a block of 1, as owner.
do $$
begin
  if to_regclass('devos_private.verdict') is null or to_regclass('devos_private.review') is null
     or to_regclass('devos_private.sample_stream') is null or to_regclass('devos_private.decision_revision') is null
     or to_regprocedure('devos_api.record_verdict(jsonb)') is null or to_regprocedure('devos_api.open_decision(jsonb)') is null then
    insert into s_take values ('pre', 'devos_private.verdict, review, sample_stream or decision_revision, or devos_api.record_verdict or open_decision, does not exist');
    return;
  end if;
  update devos_private.sample_stream set block_size = 1, block_seen = 0, block_position = null where stream::text = 'decision';
  if not found then insert into s_take values ('pre', 'the decision sample stream has no row'); end if;
exception when others then
  insert into s_take values ('pre', 'the decision stream could not be set to a block of 1: ' || sqlstate || ' ' || left(sqlerrm, 160)) on conflict do nothing;
end $$;

-- Transaction 2: the Mission and four high_impact decisions opened with the working token; each draws its sample.
do $$
declare i int; r jsonb; rows jsonb;
begin
  if pg_temp.s_v('pre') is not null then return; end if;
  perform pg_temp.w07_mission();
  for i in 1..4 loop
    r := pg_temp.w07_call('devos_calisma', 'open_decision', pg_temp.w07_args('decision', 'complete', nextval('w07_seq')::int, 'high_impact'));
    if pg_temp.w07_kind(r) <> 'accepted' then
      insert into s_take values ('pre', 'decision ' || i || ' was refused: ' || pg_temp.w07_brief(r)); return;
    end if;
    rows := pg_temp.s_sample_rows(r->>'id');
    if jsonb_array_length(rows) <> 1 then
      insert into s_take values ('pre', format('decision %s drew %s sample Reviews at a block of 1 (wanted 1)', i, jsonb_array_length(rows))); return;
    end if;
    insert into s_take values ('d' || i, r->>'id'), ('s' || i, rows->0->>'id');
  end loop;
exception when others then
  insert into s_take values ('pre', 'the fixtures could not be made: ' || sqlstate || ' ' || left(sqlerrm, 160)) on conflict do nothing;
end $$;

-- Transaction 3: S-neg-take-pos, the paired positive: a Verdict on sample 1 alone, with the audit token, is accepted.
do $$
declare r jsonb;
begin
  if pg_temp.s_v('pre') is not null then return; end if;
  r := pg_temp.w07_call('devos_denetim', 'record_verdict', pg_temp.s_verdict_args(pg_temp.s_v('s1')));
  if pg_temp.w07_kind(r) = 'unknown' then
    perform pg_temp.w07_put('S-neg-take-pos', 'could_not_check', 'record_verdict: not an answer of interface v1: ' || pg_temp.w07_brief(r));
  else
    perform pg_temp.w07_rec('S-neg-take-pos', pg_temp.w07_kind(r) = 'accepted' and pg_temp.s_verdicts(pg_temp.s_v('s1')) = 1,
      'a Verdict on a sample Review opened in an earlier transaction, alone: ' || pg_temp.w07_brief(r));
  end if;
end $$;

-- Transaction 4: S-neg-take-verdict-first: a Verdict on sample 2, then a new revision of its target, in one transaction.
do $$
declare r jsonb; e text; d text := pg_temp.s_v('d2'); s text := pg_temp.s_v('s2');
begin
  if pg_temp.s_v('pre') is not null then return; end if;
  r := pg_temp.w07_call('devos_denetim', 'record_verdict', pg_temp.s_verdict_args(s));
  e := pg_temp.s_new_rev(d);
  perform pg_temp.w07_rec('S-neg-take-verdict-first', not (pg_temp.s_verdicts(s) = 1 and pg_temp.s_rev2(d) = 1),
    format('verdict: %s; then revision 2 of the target: %s; both written: %s', pg_temp.w07_brief(r), coalesce('refused: ' || e, 'written'),
           pg_temp.s_verdicts(s) = 1 and pg_temp.s_rev2(d) = 1));
end $$;

-- Transaction 5: S-neg-take-revision-first: a new revision of sample 3's target, then a Verdict on sample 3.
do $$
declare r jsonb; e text; d text := pg_temp.s_v('d3'); s text := pg_temp.s_v('s3');
begin
  if pg_temp.s_v('pre') is not null then return; end if;
  e := pg_temp.s_new_rev(d);
  r := pg_temp.w07_call('devos_denetim', 'record_verdict', pg_temp.s_verdict_args(s));
  perform pg_temp.w07_rec('S-neg-take-revision-first', not (pg_temp.s_verdicts(s) = 1 and pg_temp.s_rev2(d) = 1),
    format('revision 2 of the target: %s; then the verdict: %s; both written: %s', coalesce('refused: ' || e, 'written'), pg_temp.w07_brief(r),
           pg_temp.s_verdicts(s) = 1 and pg_temp.s_rev2(d) = 1));
end $$;

-- Transaction 6: S-neg-take-fields: taking sample 4 by setting its reviewer fields, if the build has that form, then a
-- new revision of its target, in one transaction.
do $$
declare h text := pg_temp.s_hook('take_sample'); e1 text; e2 text; d text := pg_temp.s_v('d4'); s text := pg_temp.s_v('s4'); row jsonb;
begin
  if pg_temp.s_v('pre') is not null then return; end if;
  if coalesce(h, '') = '' then
    perform pg_temp.w07_put('S-neg-take-fields', 'could_not_check', 'W-C02-10''s record states whether taking a sample sets its reviewer fields; '
      || 'pg_temp.s_hook(''take_sample'') is empty until then (README section 8)');
    return;
  end if;
  if h = 'none' then
    raise notice 'T-W07-N28 S-neg-take-fields: not applicable: the build takes a sample only through record_verdict (EV-C02-008 2.5, B-S3)';
    return;
  end if;
  begin execute h using s; exception when others then e1 := sqlstate || ' ' || left(sqlerrm, 160); end;
  e2 := pg_temp.s_new_rev(d);
  execute 'select to_jsonb(r) from devos_private.review r where r.id::text = $1' into row using s;
  perform pg_temp.w07_rec('S-neg-take-fields', not (coalesce(pg_temp.s_reviewer_empty(row), true) = false and pg_temp.s_rev2(d) = 1),
    format('taking: %s; then revision 2: %s', coalesce('refused: ' || e1, 'done'), coalesce('refused: ' || e2, 'written')));
end $$;

do $$
begin
  if pg_temp.s_v('pre') is not null then
    perform pg_temp.w07_put('S-take-pre', 'could_not_check', pg_temp.s_v('pre'));
  end if;
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'N28_SAMPLE_TAKING FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'N28_SAMPLE_TAKING COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'N28_SAMPLE_TAKING PASS (%/%)', n, n;
end $$;
