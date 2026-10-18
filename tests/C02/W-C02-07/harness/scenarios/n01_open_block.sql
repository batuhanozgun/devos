-- Synthetic test data (plan Section 8 item 13): the Mission, decisions, needs, work items, effort policies, findings,
-- relations and the Verdict written here are made up (text 'SYNTHETIC W-C02-07 w07_fixture'); no personal or business
-- data, no credential. Tokens are issued at run time and kept in PL/pgSQL variables only (README section 6).
--
-- THROWAWAY DATABASE ONLY. This scenario COMMITS, in several transactions, so it is not under supabase/migrations/ and
-- the migration job never runs it; it refuses to run unless w07.throwaway = 'yes' and no role supabase_admin exists
-- (README 5.2). It is run by tests/C02/W-C02-07/harness/run_breaks.py, with the patches that name it.
-- Claim (T-W07-N01 part B; phase C4b; EV-C02-008 section 5.2, N-263, decided and accepted; PC-47 places 2 and 3, B:247
-- and B:478): while the block of its stream that drew it is still open, a sample Review, any Verdict on it and every event
-- of either are read by no class but devos_denetim; no read returns a value that changes with them; no relation names
-- them, so the two walks from the sampled target answer as from an undrawn record, and with either id as root, and relate
-- with either as an end, answer as for an id that names no record. devos_denetim's reads return them at once, and once
-- the block is complete the working token's read returns the Verdict. Also the routine streams (work items and decisions
-- labelled routine), which EV-C02-008 5.2 lets the designer put here rather than in T-W07-N29. The Verdict needs a later
-- transaction than the sampled record's (EV-C02-002 DM-41 (a)), so these cases run only here, on the throwaway database.
-- Specification: tests/C02/W-C02-07/T-W07-N01_need_justification.md, part B. No psql meta-command.
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
set statement_timeout = '180s';
-- Common helpers of Group C (copied from w07_n01_need_justification.sql, README section 7, with two more call forms in
-- w07_call for README 8.1's affected_entities(root uuid, limits jsonb) and explain_paths(root uuid, target uuid, limits
-- jsonb); source: this group's prelude, which
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
-- W-C02-03's w03_plant_function). Revised before any result (note N-278 (4); EV-C02-013 D-14, 2026-10-17): a value
-- meets the column's own CHECK where the schema fixes a form (a text column whose CHECK asks for 64 or 40 lower-case
-- hexadecimal characters gets a synthetic string of that form, drawn at run time; a json column whose CHECK asks for
-- an object gets {}), and an enum column gets its type's first label instead of null.
create function pg_temp.w07_plant_row(p_tbl text, p_base jsonb) returns void language plpgsql as $f$
declare cols text := ''; vals text := ''; c record; k text; chk text;
begin
  for k in select jsonb_object_keys(p_base) loop
    cols := cols || ', ' || quote_ident(k); vals := vals || ', ' || quote_literal(p_base->>k) || '::' ||
      (select format_type(a.atttypid, a.atttypmod) from pg_attribute a where a.attrelid = ('devos_private.' || p_tbl)::regclass and a.attname = k);
  end loop;
  for c in select column_name, data_type, udt_schema, udt_name from information_schema.columns
           where table_schema = 'devos_private' and table_name = p_tbl and is_nullable = 'NO' and column_default is null
             and is_identity = 'NO' and is_generated = 'NEVER' and not (p_base ? column_name) order by ordinal_position loop
    select coalesce(string_agg(pg_get_constraintdef(con.oid), ' '), '') into chk from pg_constraint con
      join pg_attribute att on att.attrelid = con.conrelid and att.attnum = any (con.conkey)
     where con.conrelid = ('devos_private.' || p_tbl)::regclass and con.contype = 'c' and att.attname = c.column_name;
    cols := cols || ', ' || quote_ident(c.column_name);
    vals := vals || ', ' || case
      when c.data_type in ('text', 'character varying', 'character') and position('[0-9a-f]{64}' in chk) > 0
        then quote_literal(md5(random()::text) || md5(random()::text))
      when c.data_type in ('text', 'character varying', 'character') and position('[0-9a-f]{40}' in chk) > 0
        then quote_literal(left(md5(random()::text) || md5(random()::text), 40))
      when c.data_type in ('text', 'character varying', 'character') then quote_literal('w07_fixture SYNTHETIC W-C02-07')
      when c.data_type in ('integer', 'bigint', 'smallint', 'numeric') then '1'
      when c.data_type like 'timestamp%' then 'now()'
      when c.data_type = 'boolean' then 'false'
      when c.data_type in ('json', 'jsonb') and position('jsonb_typeof(' || c.column_name || ') = ''object''' in chk) > 0
        then quote_literal('{}') || '::' || c.data_type
      when c.data_type in ('json', 'jsonb') then quote_literal('[]') || '::' || c.data_type
      when c.data_type = 'uuid' then 'gen_random_uuid()'
      when c.data_type = 'ARRAY' then quote_literal('{}') || '::' || quote_ident(ltrim(c.udt_name, '_')) || '[]'
      when c.data_type = 'USER-DEFINED' then coalesce((select quote_literal(e.enumlabel) || '::' || quote_ident(c.udt_schema) || '.'
        || quote_ident(c.udt_name) from pg_enum e join pg_type t on t.oid = e.enumtypid join pg_namespace n on n.oid = t.typnamespace
        where n.nspname = c.udt_schema and t.typname = c.udt_name order by e.enumsortorder limit 1), 'null')
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
  -- Revised before any result (EV-C02-013 R2-1, 2026-10-18): an effect names the revision of its work item
  -- (work_revision, required with work_ref), read here as owner at the claim.
  return jsonb_build_object('work_ref', p_work, 'claim_token', r->>'claim_token', 'work_revision',
    (select w.revision from devos_private.work_current w where w.id::text = p_work));
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

-- ===== The open block (EV-C02-008 5.2, N-263; phase C4b) =====
-- us_reads holds each read's answer before and after the Verdict; us_part holds each sub-check's outcome per class.
create temp table us_reads (slot text, phase text, cls text, reader text, arg text, answer jsonb);
create temp table us_part (slot text, cls text, part text, outcome text, detail text);

create function pg_temp.us_fx(p_k text) returns text language sql as $f$ select v from w07_fx where k = p_k $f$;
create function pg_temp.us_set(p_k text, p_v text) returns void language sql as $f$
  insert into w07_fx values (p_k, coalesce(p_v, '')) on conflict (k) do update set v = excluded.v $f$;
create function pg_temp.us_add(p_slot text, p_cls text, p_part text, p_outcome text, p_detail text) returns void language sql as $f$
  insert into us_part values (p_slot, p_cls, p_part, p_outcome, left(coalesce(p_detail, ''), 400)) $f$;

-- Times inside an answer (keys ending in _at) and the test's own w07_ keys are dropped: the reads before and after the
-- Verdict run in different transactions.
create function pg_temp.us_strip(j jsonb) returns jsonb language plpgsql immutable as $f$
declare k text; v jsonb; o jsonb := '{}'; a jsonb := '[]';
begin
  if jsonb_typeof(j) = 'object' then
    for k, v in select * from jsonb_each(j) loop
      continue when k ~ '_at$' or k like 'w07[_]%';
      o := o || jsonb_build_object(k, pg_temp.us_strip(v));
    end loop;
    return o;
  elsif jsonb_typeof(j) = 'array' then
    for v in select * from jsonb_array_elements(j) loop a := a || jsonb_build_array(pg_temp.us_strip(v)); end loop;
    return a;
  end if;
  return j;
end $f$;
-- The answer as text with each id of p_ids replaced by the label at the same place in p_labels.
create function pg_temp.us_sub(j jsonb, p_ids text[], p_labels text[]) returns text language plpgsql immutable as $f$
declare s text := coalesce(pg_temp.us_strip(j)::text, 'null'); i int;
begin
  for i in 1 .. coalesce(array_length(p_ids, 1), 0) loop
    if p_ids[i] is not null and p_ids[i] <> '' then s := replace(s, p_ids[i], p_labels[i]); end if;
  end loop;
  return s;
end $f$;
-- Every scalar of an answer with the key it sits under.
create function pg_temp.us_leaves(j jsonb, p_key text default '') returns table (k text, v text) language plpgsql immutable as $f$
declare kk text; vv jsonb;
begin
  if jsonb_typeof(j) = 'object' then
    for kk, vv in select * from jsonb_each(j) loop return query select * from pg_temp.us_leaves(vv, kk); end loop;
  elsif jsonb_typeof(j) = 'array' then
    for vv in select * from jsonb_array_elements(j) loop return query select * from pg_temp.us_leaves(vv, p_key); end loop;
  elsif j is not null and jsonb_typeof(j) <> 'null' then
    k := p_key; v := j #>> '{}'; return next;
  end if;
end $f$;

-- The read functions that can return a Review, a Verdict or an Event (EV-C02-008 5.2's table: "found by its text, as
-- T-W07-N08 finds EvalRun's readers"): devos_api functions with the read marker (DM-36) whose text names the review,
-- verdict or event table. The two walks have sub-checks of their own.
create function pg_temp.us_readers() returns table (oid oid, name text, names_event boolean) language sql stable as $f$
  select p.oid, p.proname::text, p.prosrc ~* '[[:<:]]event[[:>:]]' from pg_proc p join pg_namespace s on s.oid = p.pronamespace
   where s.nspname = 'devos_api' and coalesce(obj_description(p.oid, 'pg_proc'), '') like 'devos:read%'
     and p.prosrc ~* '[[:<:]](review|verdict|event)[[:>:]]' and p.proname not in ('affected_entities', 'explain_paths')
   order by p.proname
$f$;
-- One read with p_class's token: every uuid argument is p_id; other arguments get a neutral value by type. The answer is
-- the rows the function returns, as a list (a function returning one jsonb gives one row).
create function pg_temp.us_read(p_class text, p_oid oid, p_id text) returns jsonb language plpgsql as $f$
declare pr record; parts text[] := '{}'; i int; t record; v text; nm text; named boolean := true; q text; tok text; r jsonb; err text;
begin
  select p.*, s.nspname into pr from pg_proc p join pg_namespace s on s.oid = p.pronamespace where p.oid = p_oid;
  for i in 1 .. pr.pronargs - pr.pronargdefaults loop
    if coalesce(pr.proargnames[i], '') = '' then named := false; end if;
  end loop;
  for i in 1 .. pr.pronargs - pr.pronargdefaults loop
    select * into t from pg_type where oid = pr.proargtypes[i - 1];
    nm := coalesce(pr.proargnames[i], '');
    v := case when t.typname = 'uuid' then quote_literal(coalesce(p_id, gen_random_uuid()::text)) || '::uuid'
              when t.typname in ('json', 'jsonb') then '''{}''::' || t.typname
              when t.typname in ('timestamptz', 'timestamp', 'date') then '(now() - interval ''1 day'')::' || t.typname
              when t.typcategory = 'N' then '100::' || format_type(t.oid, null)
              when t.typcategory = 'B' then 'false'
              when t.typcategory = 'S' then quote_literal('w07_fixture SYNTHETIC W-C02-07')
              else 'null::' || format_type(t.oid, null) end;
    parts := parts || case when named then format('%I => %s', nm, v) else v end;
  end loop;
  q := format('select coalesce(jsonb_agg(to_jsonb(w07x)), ''[]'') from %I.%I(%s) as w07x', pr.nspname, pr.proname, array_to_string(parts, ', '));
  begin
    execute 'select devos_private.issue_env_token($1)::text' into tok using p_class;
    if left(tok, 1) = '{' then tok := (tok::jsonb)->>'token'; end if;
  exception when others then return jsonb_build_object('w07_cnc', 'a token of class ' || p_class || ' could not be issued');
  end;
  perform set_config('request.headers', json_build_object('x-devos-env-token', tok)::text, true);
  tok := null;
  begin
    execute 'set local role anon';
    execute q into r;
    execute 'reset role';
  exception when others then err := sqlstate || ' ' || left(sqlerrm, 120);
  end;
  perform set_config('request.headers', '{}', true);
  if err is not null then return jsonb_build_object('w07_cnc', p_class || ' ' || pr.proname || ' raised ' || err); end if;
  return r;
end $f$;

-- RejectedAttempt rows added since p_before (ids), as [function, class, code].
create function pg_temp.us_ra_ids() returns text[] language plpgsql as $f$
declare a text[];
begin execute 'select coalesce(array_agg(id::text), ''{}'') from devos_private.rejected_attempt' into a; return a; end $f$;
create function pg_temp.us_ra_new(p_before text[]) returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  execute 'select coalesce(jsonb_agg(jsonb_build_array(x.function_name::text, x.role_class::text, x.reason_code::text)
             order by x.function_name::text, x.reason_code::text), ''[]'') from devos_private.rejected_attempt x where not x.id::text = any($1)'
    into r using p_before;
  return r;
end $f$;
-- A call with its answer and the RejectedAttempt rows it added.
create function pg_temp.us_call(p_class text, p_fn text, p_args jsonb) returns jsonb language plpgsql as $f$
declare b text[] := pg_temp.us_ra_ids(); r jsonb;
begin
  r := pg_temp.w07_call(p_class, p_fn, p_args);
  return jsonb_build_object('answer', r, 'ra', pg_temp.us_ra_new(b));
end $f$;
create function pg_temp.us_walk_args(p_root text, p_target text) returns jsonb language sql as $f$
  select jsonb_build_object('root', p_root, 'limits', '{"max_depth": 50, "max_records": 100, "max_paths": 5}'::jsonb)
         || case when p_target is null then '{}'::jsonb else jsonb_build_object('target', p_target) end
$f$;

-- Transaction 1: a block opened by alignment, the drawing write accepted, the block not yet complete (EV-C02-008 5.2's
-- table). Records of p_kind are written with the working token until the database draws one; if the draw falls on the
-- block's last record, the block is complete, and the next block is tried (at most six). The sampled target t, an
-- undrawn record u of the same block, the sample s, and for the walks a work item relating to each of t and u (x_t ->
-- t, x_u -> u, derived_from: "the same relations").
create function pg_temp.us_open(p_slot text, p_stream text, p_family text, p_kind text, p_class text) returns void language plpgsql as $f$
declare why text; bs int; b int; i int; r jsonb; ids text[]; t text; u text; s text; x text; y text; k text;
begin
  why := pg_temp.w07_align(p_stream, p_family, p_class);
  if why is not null then perform pg_temp.us_set(p_slot || '_why', why); return; end if;
  bs := (pg_temp.w07_state(p_stream)->>'block_size')::int;
  if bs < 2 then
    perform pg_temp.us_set(p_slot || '_why', format('the stream''s block is %s, so no block can stay open (a scenario run earlier in the same database may have set it, as T-W07-N28 part B2 sets the decision stream''s)', bs));
    return;
  end if;
  for b in 1 .. 6 loop
    ids := '{}'; t := null;
    for i in 1 .. bs loop
      r := pg_temp.w07_call('devos_calisma', pg_temp.w07_fn(p_family), pg_temp.w07_args(p_family, p_kind, nextval('w07_seq')::int, p_class));
      if pg_temp.w07_kind(r) <> 'accepted' then perform pg_temp.us_set(p_slot || '_why', 'a record was not accepted: ' || pg_temp.w07_brief(r)); return; end if;
      ids := ids || (r->>'id');
      if pg_temp.w07_samples(r->>'id', false) > 0 then t := r->>'id'; exit; end if;
    end loop;
    exit when t is not null and (pg_temp.w07_state(p_stream)->>'block_seen')::int <> 0;
    if t is null then perform pg_temp.us_set(p_slot || '_why', format('a complete block of %s drew no sample', bs)); return; end if;
  end loop;
  if t is null or (pg_temp.w07_state(p_stream)->>'block_seen')::int = 0 then
    perform pg_temp.us_set(p_slot || '_why', 'no open block with a drawn record in six blocks'); return;
  end if;
  if array_length(ids, 1) >= 2 then u := ids[1];
  else
    r := pg_temp.w07_call('devos_calisma', pg_temp.w07_fn(p_family), pg_temp.w07_args(p_family, p_kind, nextval('w07_seq')::int, p_class));
    if pg_temp.w07_kind(r) <> 'accepted' or (pg_temp.w07_state(p_stream)->>'block_seen')::int = 0 then
      perform pg_temp.us_set(p_slot || '_why', 'no undrawn record of the open block could be written'); return;
    end if;
    u := r->>'id';
  end if;
  select r2.id::text into s from devos_private.review r2 where r2.kind::text = 'sample' and strpos(to_jsonb(r2)::text, t) > 0 limit 1;
  perform pg_temp.us_set(p_slot || '_t', t); perform pg_temp.us_set(p_slot || '_u', u); perform pg_temp.us_set(p_slot || '_s', s);
  foreach k in array array['t', 'u'] loop
    r := pg_temp.w07_call('devos_calisma', 'admit_work', pg_temp.w07_args('work', 'complete', nextval('w07_seq')::int, 'high')
           || jsonb_build_object('mission_ref', pg_temp.w07_mission()));
    if pg_temp.w07_kind(r) <> 'accepted' then perform pg_temp.us_set(p_slot || '_walkwhy', 'x_' || k || ': ' || pg_temp.w07_brief(r)); continue; end if;
    x := r->>'id'; y := pg_temp.us_fx(p_slot || '_' || k);
    r := pg_temp.w07_call('devos_calisma', 'relate', jsonb_build_object('type', 'derived_from', 'from_ref', x, 'from_revision', 1,
           'to_ref', y, 'to_revision', 1, 'scope', 'synthetic.w07_fixture.c', 'hard', false, 'method', 'recorded', 'epistemic_status', 'inference'));
    if pg_temp.w07_kind(r) <> 'accepted' then perform pg_temp.us_set(p_slot || '_walkwhy', 'relation x_' || k || ' -> ' || k || ': ' || pg_temp.w07_brief(r)); continue; end if;
    perform pg_temp.us_set(p_slot || '_x' || k, x);
  end loop;
end $f$;

-- Transactions 2 and 4: every found reader, with each class's token, with t, u and s as its uuid arguments.
create function pg_temp.us_reads(p_slot text, p_phase text, p_classes text[]) returns void language plpgsql as $f$
declare c text; rd record; a text;
begin
  if pg_temp.us_fx(p_slot || '_why') is not null then return; end if;
  foreach c in array p_classes loop
    for rd in select * from pg_temp.us_readers() loop
      foreach a in array array['t', 'u', 's'] loop
        insert into us_reads values (p_slot, p_phase, c, rd.name, a, pg_temp.us_read(c, rd.oid, pg_temp.us_fx(p_slot || '_' || a)));
      end loop;
    end loop;
  end loop;
end $f$;

-- Transaction 3: inside the open block, a Verdict on the sample with the audit token (EV-C02-008 5.2's table, CHK-C02-028
-- C2), in a later transaction than the sampled record's (DM-41 (a)).
create function pg_temp.us_verdict(p_slot text) returns void language plpgsql as $f$
declare r jsonb; v text;
begin
  if pg_temp.us_fx(p_slot || '_why') is not null then return; end if;
  r := pg_temp.w07_call('devos_denetim', 'record_verdict', jsonb_build_object('review_ref', pg_temp.us_fx(p_slot || '_s'), 'result', 'fail',
         'reason', 'SYNTHETIC W-C02-07 w07_fixture: the sampled record''s content is not judged here'));
  if pg_temp.w07_kind(r) <> 'accepted' then perform pg_temp.us_set(p_slot || '_why', 'the Verdict on the open sample (audit token) was not accepted: ' || pg_temp.w07_brief(r)); return; end if;
  select x.id::text into v from devos_private.verdict x where x.review_ref::text = pg_temp.us_fx(p_slot || '_s') limit 1;
  perform pg_temp.us_set(p_slot || '_v', coalesce(v, r->>'id'));
end $f$;

-- Transaction 4 (after us_reads 'b'): each class's sub-checks.
create function pg_temp.us_check(p_slot text, p_classes text[]) returns void language plpgsql as $f$
declare c text; t text := pg_temp.us_fx(p_slot || '_t'); u text := pg_temp.us_fx(p_slot || '_u'); s text := pg_temp.us_fx(p_slot || '_s');
        v text := pg_temp.us_fx(p_slot || '_v'); xt text := pg_temp.us_fx(p_slot || '_xt'); xu text := pg_temp.us_fx(p_slot || '_xu');
        evs text[]; rr record; bad text; n text; a jsonb; b jsonb; e text; x jsonb; y jsonb; ok boolean;
begin
  if pg_temp.us_fx(p_slot || '_why') is not null then return; end if;
  execute 'select coalesce(array_agg(x.id::text), ''{}'') from devos_private.event x where to_jsonb(x)->>''aggregate_id'' in ($1, $2)' into evs using s, v;
  -- (1) the reads: unchanged by the Verdict; holding no id of the sample, the Verdict or their events; the same with t as
  -- with u, ids aside.
  foreach c in array p_classes loop
    bad := '';
    for rr in select ra.reader, ra.arg, ra.answer a0, rb.answer b0 from us_reads ra join us_reads rb using (slot, cls, reader, arg)
              where ra.slot = p_slot and ra.cls = c and ra.phase = 'a' and rb.phase = 'b' order by 1, 2 loop
      if rr.a0 ? 'w07_cnc' or rr.b0 ? 'w07_cnc' then
        perform pg_temp.us_add(p_slot, c, 'reads', 'could_not_check', coalesce(rr.b0->>'w07_cnc', rr.a0->>'w07_cnc')); continue;
      end if;
      if pg_temp.us_strip(rr.a0) is distinct from pg_temp.us_strip(rr.b0) then bad := bad || format(' %s(%s) changed when the Verdict was written;', rr.reader, rr.arg); end if;
      if strpos(rr.b0::text, s) > 0 then bad := bad || format(' %s(%s) holds the sample''s id;', rr.reader, rr.arg); end if;
      if v is not null and strpos(rr.b0::text, v) > 0 then bad := bad || format(' %s(%s) holds the Verdict''s id;', rr.reader, rr.arg); end if;
      if exists (select 1 from pg_temp.us_leaves(rr.b0) l where (l.k ~* '(^id$|_id$|^ref$|_ref$)') and l.v = any(evs)) then
        bad := bad || format(' %s(%s) holds an id of their events;', rr.reader, rr.arg); end if;
    end loop;
    for rr in select ra.reader, ra.answer at, rb.answer au from us_reads ra join us_reads rb using (slot, phase, cls, reader)
              where ra.slot = p_slot and ra.cls = c and ra.phase = 'b' and ra.arg = 't' and rb.arg = 'u' loop
      if not (rr.at ? 'w07_cnc' or rr.au ? 'w07_cnc')
         and pg_temp.us_sub(rr.at, array[t], array['<rec>']) <> pg_temp.us_sub(rr.au, array[u], array['<rec>']) then
        bad := bad || format(' %s with the sampled record differs from the undrawn one;', rr.reader);
      end if;
    end loop;
    perform pg_temp.us_add(p_slot, c, 'reads', case when bad = '' then 'ok' else 'bad' end,
      coalesce(nullif(bad, ''), format(' %s reader(s) found, unchanged by the Verdict, holding none of its ids', (select count(*) from pg_temp.us_readers()))));
  end loop;
  -- (2) relate with the sample's id and the Verdict's id as an end, against an id that names no record, for each class
  -- relate's gate admits; run before the walks.
  foreach c in array p_classes loop
    continue when c not in ('devos_calisma', 'devos_sinav', 'devos_kurulum');
    bad := '';
    foreach e in array array[s, v] loop
      continue when e is null;
      n := gen_random_uuid()::text;
      x := pg_temp.us_call(c, 'relate', jsonb_build_object('type', 'about', 'from_ref', e, 'from_revision', 1, 'to_ref', u, 'to_revision', 1,
             'scope', 'synthetic.w07_fixture.c', 'hard', false, 'method', 'recorded', 'epistemic_status', 'inference'));
      y := pg_temp.us_call(c, 'relate', jsonb_build_object('type', 'about', 'from_ref', n, 'from_revision', 1, 'to_ref', u, 'to_revision', 1,
             'scope', 'synthetic.w07_fixture.c', 'hard', false, 'method', 'recorded', 'epistemic_status', 'inference'));
      if pg_temp.w07_kind(x->'answer') in ('test_cnc', 'unknown') or pg_temp.w07_kind(y->'answer') in ('test_cnc', 'unknown') then
        perform pg_temp.us_add(p_slot, c, 'relate', 'could_not_check', 'relate: ' || pg_temp.w07_brief(x->'answer') || ' / ' || pg_temp.w07_brief(y->'answer'));
        continue;
      end if;
      if pg_temp.us_sub(x->'answer', array[e], array['<end>']) <> pg_temp.us_sub(y->'answer', array[n], array['<end>']) or x->'ra' <> y->'ra' then
        bad := bad || format(' relate with the %s as an end: %s, recorded %s; with an id that names no record: %s, recorded %s;',
          case when e = s then 'sample''s id' else 'Verdict''s id' end, pg_temp.w07_brief(x->'answer'), x->'ra', pg_temp.w07_brief(y->'answer'), y->'ra');
      end if;
    end loop;
    perform pg_temp.us_add(p_slot, c, 'relate', case when bad = '' then 'ok' else 'bad' end, coalesce(nullif(bad, ''), ' relate answers as for no record'));
  end loop;
  -- (3) the walks from the sampled target against an undrawn record with the same relations, and with the sample's id and
  -- the Verdict's id as root, against an id that names no record.
  foreach c in array p_classes loop
    if xt is null or xu is null then
      perform pg_temp.us_add(p_slot, c, 'walks', 'could_not_check', 'the walk fixtures were not made: ' || coalesce(pg_temp.us_fx(p_slot || '_walkwhy'), '?')); continue;
    end if;
    bad := '';
    a := pg_temp.us_call(c, 'affected_entities', pg_temp.us_walk_args(t, null)); b := pg_temp.us_call(c, 'affected_entities', pg_temp.us_walk_args(u, null));
    if pg_temp.us_sub(a->'answer', array[t, xt], array['<root>', '<x>']) <> pg_temp.us_sub(b->'answer', array[u, xu], array['<root>', '<x>']) then
      bad := bad || ' affected_entities from the sampled target differs from the undrawn record''s;'; end if;
    a := pg_temp.us_call(c, 'explain_paths', pg_temp.us_walk_args(t, xt)); b := pg_temp.us_call(c, 'explain_paths', pg_temp.us_walk_args(u, xu));
    if pg_temp.us_sub(a->'answer', array[t, xt], array['<root>', '<x>']) <> pg_temp.us_sub(b->'answer', array[u, xu], array['<root>', '<x>']) then
      bad := bad || ' explain_paths from the sampled target differs from the undrawn record''s;'; end if;
    foreach e in array array[s, v] loop
      continue when e is null;
      n := gen_random_uuid()::text;
      a := pg_temp.us_call(c, 'affected_entities', pg_temp.us_walk_args(e, null)); b := pg_temp.us_call(c, 'affected_entities', pg_temp.us_walk_args(n, null));
      if pg_temp.us_sub(a->'answer', array[e], array['<root>']) <> pg_temp.us_sub(b->'answer', array[n], array['<root>']) or a->'ra' <> b->'ra' then
        bad := bad || format(' affected_entities with the %s as root differs from an id that names no record;', case when e = s then 'sample''s id' else 'Verdict''s id' end); end if;
      a := pg_temp.us_call(c, 'explain_paths', pg_temp.us_walk_args(e, xt)); b := pg_temp.us_call(c, 'explain_paths', pg_temp.us_walk_args(n, xt));
      if pg_temp.us_sub(a->'answer', array[e], array['<root>']) <> pg_temp.us_sub(b->'answer', array[n], array['<root>']) or a->'ra' <> b->'ra' then
        bad := bad || format(' explain_paths with the %s as root differs from an id that names no record;', case when e = s then 'sample''s id' else 'Verdict''s id' end); end if;
    end loop;
    perform pg_temp.us_add(p_slot, c, 'walks', case when bad = '' then 'ok' else 'bad' end, coalesce(nullif(bad, ''), ' the walks as from an undrawn record and as for no record'));
  end loop;
end $f$;

-- One case per class from its sub-checks.
create function pg_temp.us_record(p_slot text, p_cls text, p_case text) returns void language plpgsql as $f$
declare o text; d text;
begin
  if pg_temp.us_fx(p_slot || '_why') is not null then
    perform pg_temp.w07_put(p_case, 'could_not_check', 'the open block could not be planted: ' || pg_temp.us_fx(p_slot || '_why')); return;
  end if;
  select case when bool_or(outcome = 'bad') then 'bad' when bool_or(outcome = 'could_not_check') then 'could_not_check'
              when count(*) = 0 then 'could_not_check' else 'ok' end,
         string_agg(part || ': ' || outcome || detail, ' | ' order by part)
    into o, d from us_part where slot = p_slot and cls = p_cls;
  perform pg_temp.w07_put(p_case, o, format('%s, inside the open block of %s, with the sample and a Verdict on it: %s', p_cls, p_slot, coalesce(d, 'no sub-check ran')));
end $f$;

-- N01-unseen-den (positive): with the audit token, a found reader returns the sample, one returns the Verdict, and, where a
-- found reader names the event table, one returns an id of their events.
create function pg_temp.us_den(p_slot text, p_case text) returns void language plpgsql as $f$
declare s text := pg_temp.us_fx(p_slot || '_s'); v text := pg_temp.us_fx(p_slot || '_v'); evs text[]; fs boolean; fv boolean; fe boolean; ne boolean;
begin
  if pg_temp.us_fx(p_slot || '_why') is not null then
    perform pg_temp.w07_put(p_case, 'could_not_check', 'the open block could not be planted: ' || pg_temp.us_fx(p_slot || '_why')); return;
  end if;
  if not exists (select 1 from pg_temp.us_readers()) then
    perform pg_temp.w07_put(p_case, 'could_not_check', 'no read function that can return a Review, a Verdict or an Event was found (the build names R12''s reader and the queue''s; EV-C02-008 1.4)'); return;
  end if;
  execute 'select coalesce(array_agg(x.id::text), ''{}'') from devos_private.event x where to_jsonb(x)->>''aggregate_id'' in ($1, $2)' into evs using s, v;
  select bool_or(strpos(answer::text, s) > 0), bool_or(strpos(answer::text, v) > 0),
         bool_or(exists (select 1 from pg_temp.us_leaves(answer) l where l.k ~* '(^id$|_id$)' and l.v = any(evs)))
    into fs, fv, fe from us_reads where slot = p_slot and cls = 'devos_denetim' and phase = 'b' and not (answer ? 'w07_cnc');
  select bool_or(names_event) into ne from pg_temp.us_readers();
  perform pg_temp.w07_rec(p_case, coalesce(fs, false) and coalesce(fv, false) and (not ne or coalesce(fe, false)),
    format('devos_denetim, inside the open block: the sample %s, the Verdict %s, their events %s (wanted the queue''s read to return them)',
      case when fs then 'returned' else 'not returned' end, case when fv then 'returned' else 'not returned' end,
      case when not ne then 'not read by any found reader' when fe then 'returned' else 'not returned' end));
end $f$;

-- N01-unseen-after (positive): the block completed, the working token's reads return the Verdict.
create function pg_temp.us_after(p_slot text, p_case text, p_stream text, p_family text, p_kind text, p_class text) returns void language plpgsql as $f$
declare r jsonb; i int := 0; rd record; found boolean := false; v text := pg_temp.us_fx(p_slot || '_v');
begin
  if pg_temp.us_fx(p_slot || '_why') is not null then
    perform pg_temp.w07_put(p_case, 'could_not_check', 'the open block could not be planted: ' || pg_temp.us_fx(p_slot || '_why')); return;
  end if;
  while (pg_temp.w07_state(p_stream)->>'block_seen')::int <> 0 and i < 20 loop
    r := pg_temp.w07_call('devos_calisma', pg_temp.w07_fn(p_family), pg_temp.w07_args(p_family, p_kind, nextval('w07_seq')::int, p_class));
    if pg_temp.w07_kind(r) <> 'accepted' then perform pg_temp.w07_put(p_case, 'could_not_check', 'the block could not be completed: ' || pg_temp.w07_brief(r)); return; end if;
    i := i + 1;
  end loop;
  if not exists (select 1 from pg_temp.us_readers()) then
    perform pg_temp.w07_put(p_case, 'could_not_check', 'no read function that can return a Review or a Verdict was found (R12''s reader is the build''s to name)'); return;
  end if;
  for rd in select * from pg_temp.us_readers() loop
    r := pg_temp.us_read('devos_calisma', rd.oid, pg_temp.us_fx(p_slot || '_t'));
    if not (r ? 'w07_cnc') and strpos(r::text, v) > 0 then found := true; end if;
  end loop;
  perform pg_temp.w07_rec(p_case, found, format('the block completed (%s more record(s)); the working token''s reads with the sampled record %s the Verdict (wanted returned)',
    i, case when found then 'return' else 'do not return' end));
end $f$;
do $$
declare why text;
begin
  why := pg_temp.w07_pre(string_to_array('record_need,open_decision,open_mission,admit_work,relate,record_verdict', ','), string_to_array('need,review,verdict,event,rejected_attempt,sample_stream,decision,decision_revision,mission,work', ','));
  if why is null and (to_regprocedure('devos_api.affected_entities(uuid,jsonb)') is null or to_regprocedure('devos_api.explain_paths(uuid,uuid,jsonb)') is null) then
    why := 'devos_api.affected_entities(uuid,jsonb) or explain_paths(uuid,uuid,jsonb) does not exist';
  end if;
  if why is null then
    begin
      perform pg_temp.w07_mission();
    exception when others then why := 'the fixture Mission could not be made: ' || sqlstate || ' ' || left(sqlerrm, 200);
    end;
  end if;
  if why is not null then perform pg_temp.us_set('pre_why', why); end if;
end $$;
-- need: transaction 1, the open block; 2, the reads before the Verdict; 3, the Verdict (audit token); 4, the reads after it
-- and the sub-checks (EV-C02-008 5.2's table; DM-41 (a): the Verdict cannot share the sampled record's transaction).
do $$ begin
  if pg_temp.us_fx('pre_why') is not null then perform pg_temp.us_set('need_why', pg_temp.us_fx('pre_why')); return; end if;
  perform pg_temp.us_open('need', 'need', 'need', 'complete', null);
exception when others then perform pg_temp.us_set('need_why', 'stopped on an error of the test itself: ' || sqlstate || ' ' || left(sqlerrm, 200));
end $$;
do $$ begin perform pg_temp.us_reads('need', 'a', array['devos_calisma', 'devos_sinav', 'devos_kurulum', 'devos_ci', 'devos_denetim']);
exception when others then perform pg_temp.us_set('need_why', 'the reads stopped: ' || sqlstate || ' ' || left(sqlerrm, 200)); end $$;
do $$ begin perform pg_temp.us_verdict('need');
exception when others then perform pg_temp.us_set('need_why', 'the Verdict stopped: ' || sqlstate || ' ' || left(sqlerrm, 200)); end $$;
do $$ begin
  perform pg_temp.us_reads('need', 'b', array['devos_calisma', 'devos_sinav', 'devos_kurulum', 'devos_ci', 'devos_denetim']);
  perform pg_temp.us_check('need', array['devos_calisma', 'devos_sinav', 'devos_kurulum', 'devos_ci']);
exception when others then perform pg_temp.us_set('need_why', 'the checks stopped: ' || sqlstate || ' ' || left(sqlerrm, 200));
end $$;
do $$ begin
  perform pg_temp.us_record('need', 'devos_calisma', 'N01-unseen-cal');
  perform pg_temp.us_record('need', 'devos_sinav', 'N01-unseen-sin');
  perform pg_temp.us_record('need', 'devos_kurulum', 'N01-unseen-kur');
  perform pg_temp.us_record('need', 'devos_ci', 'N01-unseen-ci');
  perform pg_temp.us_den('need', 'N01-unseen-den');
end $$;
do $$ begin perform pg_temp.us_after('need', 'N01-unseen-after', 'need', 'need', 'complete', null);
exception when others then perform pg_temp.w07_put('N01-unseen-after', 'could_not_check', 'stopped: ' || sqlstate || ' ' || left(sqlerrm, 200)); end $$;
-- work_routine: transaction 1, the open block; 2, the reads before the Verdict; 3, the Verdict (audit token); 4, the reads after it
-- and the sub-checks (EV-C02-008 5.2's table; DM-41 (a): the Verdict cannot share the sampled record's transaction).
do $$ begin
  if pg_temp.us_fx('pre_why') is not null then perform pg_temp.us_set('work_routine_why', pg_temp.us_fx('pre_why')); return; end if;
  perform pg_temp.us_open('work_routine', 'work_routine', 'work', 'complete', 'routine');
exception when others then perform pg_temp.us_set('work_routine_why', 'stopped on an error of the test itself: ' || sqlstate || ' ' || left(sqlerrm, 200));
end $$;
do $$ begin perform pg_temp.us_reads('work_routine', 'a', array['devos_calisma']);
exception when others then perform pg_temp.us_set('work_routine_why', 'the reads stopped: ' || sqlstate || ' ' || left(sqlerrm, 200)); end $$;
do $$ begin perform pg_temp.us_verdict('work_routine');
exception when others then perform pg_temp.us_set('work_routine_why', 'the Verdict stopped: ' || sqlstate || ' ' || left(sqlerrm, 200)); end $$;
do $$ begin
  perform pg_temp.us_reads('work_routine', 'b', array['devos_calisma']);
  perform pg_temp.us_check('work_routine', array['devos_calisma']);
exception when others then perform pg_temp.us_set('work_routine_why', 'the checks stopped: ' || sqlstate || ' ' || left(sqlerrm, 200));
end $$;
do $$ begin perform pg_temp.us_record('work_routine', 'devos_calisma', 'N01-unseen-routine-work'); end $$;
-- decision_routine: transaction 1, the open block; 2, the reads before the Verdict; 3, the Verdict (audit token); 4, the reads after it
-- and the sub-checks (EV-C02-008 5.2's table; DM-41 (a): the Verdict cannot share the sampled record's transaction).
do $$ begin
  if pg_temp.us_fx('pre_why') is not null then perform pg_temp.us_set('decision_routine_why', pg_temp.us_fx('pre_why')); return; end if;
  perform pg_temp.us_open('decision_routine', 'decision_routine', 'decision_routine', 'complete', null);
exception when others then perform pg_temp.us_set('decision_routine_why', 'stopped on an error of the test itself: ' || sqlstate || ' ' || left(sqlerrm, 200));
end $$;
do $$ begin perform pg_temp.us_reads('decision_routine', 'a', array['devos_calisma']);
exception when others then perform pg_temp.us_set('decision_routine_why', 'the reads stopped: ' || sqlstate || ' ' || left(sqlerrm, 200)); end $$;
do $$ begin perform pg_temp.us_verdict('decision_routine');
exception when others then perform pg_temp.us_set('decision_routine_why', 'the Verdict stopped: ' || sqlstate || ' ' || left(sqlerrm, 200)); end $$;
do $$ begin
  perform pg_temp.us_reads('decision_routine', 'b', array['devos_calisma']);
  perform pg_temp.us_check('decision_routine', array['devos_calisma']);
exception when others then perform pg_temp.us_set('decision_routine_why', 'the checks stopped: ' || sqlstate || ' ' || left(sqlerrm, 200));
end $$;
do $$ begin perform pg_temp.us_record('decision_routine', 'devos_calisma', 'N01-unseen-routine-decision'); end $$;
select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'N01_OPEN_BLOCK FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'N01_OPEN_BLOCK COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'N01_OPEN_BLOCK PASS (%/%)', n, n;
end $$;
