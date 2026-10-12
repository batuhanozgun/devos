-- Synthetic test data (plan Section 8 item 13): every mission, work item, operation, observation, source text
-- ("w07_fixture synthetic ..."), scope (synthetic.w07.f07) and time below is made up for this test, labelled SYNTHETIC
-- W-C02-07, and holds no personal or business data; (c)'s "pull request merged" and "main reverted" are synthetic
-- observations, not GitHub (C08 takes real GitHub). Tokens are issued at run time inside this rolled-back
-- transaction, held only in PL/pgSQL variables, and never printed or stored.
--
-- Claim: observations are appended, never overwritten or deleted; "applied in the past", "current now" and
-- "accepted" are separate questions (Appendix C F07, its C02 part; B 3.12). Specification:
-- tests/C02/W-C02-07/T-W07-F07_observation_history.md.
-- Runs: the migration job's devos-test step as postgres (README 5.1 (a)); the break harness's throwaway database (5.2).
-- Transport: sql-set-role (role anon, header simulated with set_config; the record says so).
-- Safety: everything is inside begin ... rollback; no psql meta-command; before the build exists it ends in
-- COULD NOT CHECK. Output: one row per case, then PASS (notice) or FAIL / COULD NOT CHECK (raised).
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '60s';

create temp table w07_results (case_id text primary key, outcome text not null, detail text not null);

-- ===== Group A helpers, v1 (copied unchanged into every Group A SQL file; source: this file; README section 7) =====
create function pg_temp.w07_pre(p_need text[]) returns text language plpgsql as $f$
declare s text;
begin
  if to_regrole('anon') is null then return 'role anon does not exist'; end if;
  if to_regnamespace('devos_api') is null or to_regnamespace('devos_private') is null then
    return 'schema devos_api or devos_private does not exist';
  end if;
  if not has_schema_privilege('anon', 'devos_api', 'usage') then return 'anon has no USAGE on devos_api'; end if;
  foreach s in array p_need loop
    if s like '%(*)' then  -- a function of this name, whatever its arguments (README section 8: revoke_env_token's ID type)
      if not exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace
                     where n.nspname || '.' || p.proname = left(s, -3)) then return s || ' does not exist'; end if;
    elsif s like '%(%' then
      if to_regprocedure(s) is null then return s || ' does not exist'; end if;
      if s like 'devos_api.%' and not has_function_privilege('anon', s, 'execute') then
        return 'anon has no EXECUTE on ' || s;
      end if;
    elsif to_regclass(s) is null then
      return 'table ' || s || ' does not exist';
    end if;
  end loop;
  return null;
end $f$;

-- One call as role anon with a token header (null: no header). $1 text, $2 jsonb, $3 text are bound, never inlined.
create function pg_temp.w07_call(p_token text, p_sql text, p_t text default null, p_j jsonb default null,
                                 p_u text default null) returns jsonb language plpgsql as $f$
declare r jsonb; err text;
begin
  begin
    perform set_config('request.headers', case when p_token is null then '{}'
                       else json_build_object('x-devos-env-token', p_token)::text end, true);
    execute 'set local role anon';
    execute p_sql into r using p_t, p_j, p_u;
    execute 'reset role';
  exception when others then
    err := sqlstate || ' ' || left(sqlerrm, 200);
  end;
  perform set_config('request.headers', '{}', true);
  if err is not null then
    if (p_token is not null and p_token <> '' and position(p_token in err) > 0)
       or (p_t is not null and p_t <> '' and position(p_t in err) > 0) then
      err := 'error text withheld: it contained a presented token';
    end if;
    return jsonb_build_object('w07_raised', err);
  end if;
  return coalesce(r, jsonb_build_object('w07_raised', 'null result'));
end $f$;

-- p_want: ok | refused | could_not_check | not_ok (refused or could_not_check) | token (a token reason code wanted).
create function pg_temp.w07_judge(p_id text, r jsonb, p_want text, p_extra_bad text default null,
                                  p_note text default '') returns void language plpgsql as $f$
-- Interface v1 (README section 8): "could not check" is status refused with reason_code could_not_check.
declare st text := case when r->>'status' = 'refused' and r->>'reason_code' = 'could_not_check' then 'could_not_check'
                        when r->>'status' = 'could_not_check' then 'could_not_check as a status (not interface v1)'
                        else r->>'status' end;
        rc text := r->>'reason_code'; o text; d text;
        tokcodes text[] := array['missing', 'empty', 'malformed', 'unknown', 'revoked', 'header_unreadable'];
begin
  if r ? 'w07_raised' then
    o := 'could_not_check';
    d := 'raised ' || (r->>'w07_raised') || ' (interface: a refusal is returned, EV-C02-002 DM-19)';
  elsif st is null or st not in ('ok', 'refused', 'could_not_check') then
    o := 'could_not_check'; d := 'status ' || coalesce(st, 'absent') || ' is not ok, refused or could_not_check';
  elsif p_want = 'ok' then
    if st = 'ok' then o := 'ok'; d := 'accepted';
    else o := 'bad'; d := 'not accepted: ' || st || ' ' || coalesce(rc, ''); end if;
  elsif st = 'ok' then
    o := 'bad'; d := 'accepted, wanted ' || p_want;
  elsif p_want = 'token' then
    if st = 'refused' and rc = any(tokcodes) then o := 'ok'; d := 'refused: ' || rc;
    else o := 'bad'; d := st || ' ' || coalesce(rc, '') || ', wanted a token reason code'; end if;
  elsif rc = any(tokcodes) then
    o := 'could_not_check'; d := 'refused for another reason: the token was not verified (' || rc || ')';
  elsif p_want = 'not_ok' then
    o := 'ok'; d := st || ' ' || coalesce(rc, '');
  elsif p_want = 'refused' and st = 'refused' then
    o := 'ok'; d := 'refused: ' || coalesce(rc, '(no reason code)');
  elsif p_want = 'refused' then
    o := 'could_not_check'; d := 'answered could_not_check (' || coalesce(rc, '') || '), wanted the rule''s refusal';
  elsif st = 'could_not_check' then
    o := 'ok'; d := 'could not check: ' || coalesce(rc, '');
  else
    o := 'bad'; d := 'answered ' || st || ' (' || coalesce(rc, '') || '): could not check folded into fail';
  end if;
  if o = 'ok' and p_extra_bad is not null then o := 'bad'; d := d || '; ' || p_extra_bad; end if;
  -- case_id is the bare case ID (README section 1); the words after it go to detail.
  insert into w07_results values (split_part(p_id, ' ', 1), o,
    left(coalesce(nullif(substr(p_id, length(split_part(p_id, ' ', 1)) + 2), '') || ': ', '') || d
         || case when p_note <> '' then ' | ' || p_note else '' end, 400));
end $f$;

create function pg_temp.w07_cnc(p_id text, p_why text) returns void language sql as $f$
  insert into w07_results values (split_part(p_id, ' ', 1), 'could_not_check',
    left(coalesce(nullif(substr(p_id, length(split_part(p_id, ' ', 1)) + 2), '') || ': ', '') || p_why, 400))
$f$;

-- A digest of every devos_private table but RejectedAttempt and token tables, hash and token columns left out.
create function pg_temp.w07_state() returns jsonb language plpgsql as $f$
declare t record; cols text; h text; res jsonb := '{}';
begin
  for t in select c.oid, c.relname from pg_class c join pg_namespace n on n.oid = c.relnamespace
           where n.nspname = 'devos_private' and c.relkind in ('r', 'p') and c.relname not like '%rejected%'
             and c.relname not like '%token%' order by c.relname loop
    select string_agg(quote_ident(attname), ', ' order by attnum) into cols from pg_attribute
      where attrelid = t.oid and attnum > 0 and not attisdropped and attname not like '%hash%'
        and attname not like '%token%';
    continue when cols is null;
    execute format('select md5(coalesce(string_agg(x, %L order by x), %L)) from (select row(%s)::text x from devos_private.%I) s',
                   '|', '', cols, t.relname) into h;
    res := res || jsonb_build_object(t.relname, h);
  end loop;
  return res;
end $f$;

-- Owner-level insert of one synthetic row: p_fixed by column, p_fk by referenced table, other NOT NULL columns by type.
create function pg_temp.w07_owner_insert(p_table text, p_fixed jsonb, p_fk jsonb default '{}') returns jsonb
language plpgsql as $f$
declare c record; cols text := ''; vals text := ''; v text; r jsonb;
begin
  for c in
    select a.attname, format_type(a.atttypid, a.atttypmod) as typ, t.typtype, a.attnotnull,
           exists (select 1 from pg_attrdef d where d.adrelid = a.attrelid and d.adnum = a.attnum) as hasdef,
           a.attidentity, a.attgenerated,
           (select k.confrelid::regclass::text from pg_constraint k where k.conrelid = a.attrelid and k.contype = 'f'
              and k.conkey = array[a.attnum]::int2[] limit 1) as fk_to
    from pg_attribute a join pg_type t on t.oid = a.atttypid
    where a.attrelid = p_table::regclass and a.attnum > 0 and not a.attisdropped order by a.attnum
  loop
    v := null;
    if p_fixed ? c.attname then
      v := quote_literal(p_fixed->>c.attname) || '::' || c.typ;
    elsif c.fk_to is not null and p_fk ? c.fk_to then
      v := quote_literal(p_fk->>c.fk_to) || '::' || c.typ;
    elsif c.attnotnull and not c.hasdef and c.attidentity = '' and c.attgenerated = '' then
      v := case
        when c.typtype = 'e' then format('(enum_range(null::%s))[1]', c.typ)
        when c.typ like '%[]' then quote_literal('{}') || '::' || c.typ
        when c.typ = 'text' or c.typ like 'character varying%' then quote_literal('w07_fixture SYNTHETIC W-C02-07')
        when c.typ in ('integer', 'bigint', 'smallint') or c.typ like 'numeric%' then '1'
        when c.typ like 'timestamp%' then 'now()'
        when c.typ = 'date' then 'current_date'
        when c.typ = 'boolean' then 'false'
        when c.typ in ('json', 'jsonb') then quote_literal('{}') || '::' || c.typ
        when c.typ = 'uuid' then 'gen_random_uuid()'
        else null end;
      if v is null then raise exception 'w07: no synthetic value for %.% (%)', p_table, c.attname, c.typ; end if;
    end if;
    if v is not null then cols := cols || ', ' || quote_ident(c.attname); vals := vals || ', ' || v; end if;
  end loop;
  execute format('insert into %s as w07_row (%s) values (%s) returning to_jsonb(w07_row.*)',
                 p_table, substr(cols, 3), substr(vals, 3)) into r;
  return r;
end $f$;

create function pg_temp.w07_tok(p_class text) returns text language plpgsql as $f$
begin
  return devos_private.issue_env_token(p_class);
end $f$;

-- F08 (c)'s epoch change: revoke a synthetic token (EV-C02-004 X-07).
-- Revocation by the env_tokens row ID (README section 8, interface v1): mark the rows present, then revoke, as owner,
-- each row issued since the mark. Row IDs are not secret; no token, hash or part of one is read or kept.
create function pg_temp.w07_token_mark() returns void language plpgsql as $f$
begin
  create temp table if not exists w07_token_marked (id text);
  delete from w07_token_marked;
  execute 'insert into w07_token_marked select id::text from devos_private.env_tokens';
end $f$;

create function pg_temp.w07_revoke_since_mark() returns int language plpgsql as $f$
declare i text; n int := 0;
begin
  for i in execute 'select id::text from devos_private.env_tokens where id::text not in (select id from w07_token_marked)'
  loop
    execute format('select devos_private.revoke_env_token(%L)', i);
    n := n + 1;
  end loop;
  return n;
end $f$;

create function pg_temp.w07_bump_epoch() returns void language plpgsql as $f$
declare t text;
begin
  perform pg_temp.w07_token_mark();
  t := devos_private.issue_env_token('devos_sinav');
  t := null;
  perform pg_temp.w07_revoke_since_mark();
end $f$;

-- The fixture Mission: an owner-planted synthetic Decision of class batu, answered (devos-test only, rolled back; never
-- in devos, EV-C02-002 DM-23), then open_mission with the devos_kurulum token.
create function pg_temp.w07_fixture_mission(p_k text, p_scope text) returns jsonb language plpgsql as $f$
declare d jsonb; r jsonb;
begin
  d := pg_temp.w07_owner_insert('devos_private.decision', jsonb_build_object('class', 'batu', 'status', 'answered'));
  if to_regclass('devos_private.decision_revision') is not null then
    perform pg_temp.w07_owner_insert('devos_private.decision_revision', jsonb_build_object('revision', 1),
                                     jsonb_build_object('devos_private.decision', d->>'id'));
  end if;
  r := pg_temp.w07_call(p_k, 'select devos_api.open_mission($2)', null, jsonb_build_object(
         'purpose', 'w07_fixture SYNTHETIC W-C02-07 mission (plan Section 8 item 13); not work',
         'scope', p_scope, 'owner_authority', jsonb_build_object('id', d->>'id', 'revision', 1),
         'acceptance', 'w07_fixture SYNTHETIC W-C02-07', 'constraints', '[]'::jsonb));
  if r->>'status' is distinct from 'ok' then
    raise exception 'w07: fixture mission not opened: %', coalesce(r->>'reason_code', r->>'w07_raised', r->>'status');
  end if;
  return jsonb_build_object('id', r->>'id', 'revision', coalesce((r->>'revision')::int, 1), 'scope', p_scope);
end $f$;

create function pg_temp.w07_work_payload(p_mission jsonb, p_scope text, p_extra jsonb default '{}') returns jsonb
language sql as $f$
  select jsonb_build_object(
    'mission_ref', jsonb_build_object('id', p_mission->>'id', 'revision', (p_mission->>'revision')::int),
    'scope', p_scope, 'purpose', 'w07_fixture SYNTHETIC W-C02-07 work item', 'impact_class', 'routine',
    'consumer', 'w07_fixture', 'return_to', 'w07_fixture', 'stop_rule', 'w07_fixture',
    'input_refs', '[]'::jsonb, 'target_refs', '[]'::jsonb, 'mandatory_needs', '[]'::jsonb) || p_extra
$f$;

create function pg_temp.w07_fixture_work(p_tok text, p_mission jsonb, p_scope text, p_extra jsonb default '{}')
returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  r := pg_temp.w07_call(p_tok, 'select devos_api.admit_work($2)', null,
                        pg_temp.w07_work_payload(p_mission, p_scope, p_extra));
  if r->>'status' is distinct from 'ok' then
    raise exception 'w07: fixture work not admitted: %', coalesce(r->>'reason_code', r->>'w07_raised', r->>'status');
  end if;
  return jsonb_build_object('id', r->>'id', 'revision', coalesce((r->>'revision')::int, 1), 'scope', p_scope);
end $f$;

-- claim's result holds the claim token: keep it in a variable only, read only status, reason_code and ids from it.
create function pg_temp.w07_claim(p_tok text, p_work jsonb, p_session text default 'w07_fixture_session_a')
returns jsonb language sql as $f$
  select pg_temp.w07_call(p_tok, 'select devos_api.claim($3::uuid, $1)', p_session, null, p_work->>'id')
$f$;

-- The effect used by Group A: register_artifact with the claim token (B principle 8: every effect on a work item).
create function pg_temp.w07_effect(p_tok text, p_claim text, p_work jsonb, p_path text, p_scope text default null,
                                   p_session text default 'w07_fixture_session_a') returns jsonb language sql as $f$
  select pg_temp.w07_call(p_tok, 'select devos_api.register_artifact($1, $2)', p_claim, jsonb_build_object(
    'work_ref', jsonb_build_object('id', p_work->>'id', 'revision', (p_work->>'revision')::int),
    'path', 'w07_fixture/' || p_path, 'commit', repeat('a7', 20), 'kind', 'w07_fixture',
    'scope', coalesce(p_scope, p_work->>'scope'), 'declared_session_id', p_session))
$f$;

-- The synthetic effect class, planted by the owner inside this transaction (EV-C02-002 DM-37; see the specification).
create function pg_temp.w07_effect_class() returns void language plpgsql as $f$
begin
  if not exists (select 1 from devos_private.effect_class where effect_class = 'w07_fixture_effect') then
    perform pg_temp.w07_owner_insert('devos_private.effect_class', jsonb_build_object(
      'effect_class', 'w07_fixture_effect', 'irreversible', 'false',
      'mandatory_read_set', '{work,hard_dependencies,claim,authority_epoch,expected_base,inputs}'));
  end if;
end $f$;

create function pg_temp.w07_prepare(p_tok text, p_claim text, p_op jsonb) returns jsonb language sql as $f$
  select pg_temp.w07_call(p_tok, 'select devos_api.prepare_operation($1, $2)', p_claim, p_op)
$f$;
-- ===== end of Group A helpers, v1 =====

create function pg_temp.w07_obs(p_tok text, p_op text, p_effect text, p_ago interval, p_source text) returns jsonb
language sql as $f$
  select pg_temp.w07_call(p_tok, 'select devos_api.record_observation($2)', null, jsonb_build_object(
    'operation_ref', p_op, 'source', 'w07_fixture synthetic ' || p_source,
    'observed_at', to_char((now() - p_ago) at time zone 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS"Z"'),
    'observed_effect', p_effect))
$f$;

-- Owner read of one observation row as text (to see that it is unchanged later), and the count for an operation.
create function pg_temp.w07_obs_row(p_id text) returns text language plpgsql as $f$
begin
  return (select o::text from devos_private.observation o where o.id::text = p_id);
end $f$;
create function pg_temp.w07_obs_count(p_op text) returns int language plpgsql as $f$
begin
  return (select count(*)::int from devos_private.observation o where o.operation_ref::text = p_op);
end $f$;

-- One history case: the first observation's row is unchanged and both rows are present.
create function pg_temp.w07_hist(p_id text, p_op text, p_first text, p_first_row text) returns void language plpgsql as $f$
declare n int := pg_temp.w07_obs_count(p_op); now_row text := pg_temp.w07_obs_row(p_first);
begin
  insert into w07_results values (split_part(p_id, ' ', 1),
    case when n = 2 and now_row is not distinct from p_first_row then 'ok' else 'bad' end,
    substr(p_id, length(split_part(p_id, ' ', 1)) + 2) || format(': rows for the operation %s (wanted 2); first row %s',
      n, case when now_row is null then 'gone' when now_row = p_first_row then 'unchanged' else 'changed' end));
end $f$;

-- One current-state case, from the design's read: devos_api.operation_state(operation_id uuid), named with its
-- argument by EV-C02-008 1.7.2 ("The build may add fields ... it does not rename it"). Phase C4a: called by its
-- parameter's name, so that the name the Data API binds is the one tested.
create function pg_temp.w07_cur(p_id text, p_tok text, p_op text, p_current text) returns void language plpgsql as $f$
declare r jsonb := pg_temp.w07_call(p_tok, 'select devos_api.operation_state(operation_id => $3::uuid)', null, null, p_op);
begin
  perform pg_temp.w07_judge(p_id, r, 'ok',
    case when (r->'ever_applied') is distinct from 'true'::jsonb then 'applied in the past not answered as true'
         when r->>'current_effect' is distinct from p_current then 'current answered ' || coalesce(r->>'current_effect', 'nothing') end,
    'wanted ever_applied true, current ' || p_current);
end $f$;

do $$
declare why text; k text; w text; m jsonb; w1 jsonb; c1 jsonb; op text[] := '{}'; r jsonb; x jsonb; i int;
        first_id text; first_row text; acc0 text;
begin
  why := pg_temp.w07_pre(array['devos_private.issue_env_token(text)', 'devos_api.open_mission(jsonb)',
    'devos_api.admit_work(jsonb)', 'devos_api.claim(uuid,text)', 'devos_api.prepare_operation(text,jsonb)',
    'devos_api.record_observation(jsonb)', 'devos_private.decision', 'devos_private.effect_class',
    'devos_private.observation']);
  if why is not null then perform pg_temp.w07_cnc('F07-pre', why); return; end if;
  begin
    k := pg_temp.w07_tok('devos_kurulum');
    w := pg_temp.w07_tok('devos_calisma');
    m := pg_temp.w07_fixture_mission(k, 'synthetic.w07.f07');
    w1 := pg_temp.w07_fixture_work(w, m, 'synthetic.w07.f07');
    perform pg_temp.w07_effect_class();
    c1 := pg_temp.w07_claim(w, w1);
    if c1->>'status' is distinct from 'ok' then raise exception 'w07: claim refused'; end if;
    for i in 1..3 loop
      x := pg_temp.w07_prepare(w, c1->>'claim_token', jsonb_build_object('idempotency_namespace', 'w07_fixture',
        'idempotency_key', 'w07_fixture_key_f07_' || i, 'effect_class', 'w07_fixture_effect',
        'target', 'w07_fixture/target_f07_' || i, 'expected_base', 'w07_fixture_base_1', 'payload_hash', 'w07_fixture_payload_1',
        'work_ref', jsonb_build_object('id', w1->>'id', 'revision', (w1->>'revision')::int),
        'read_set', jsonb_build_array(jsonb_build_object('ref', w1->>'id', 'revision', (w1->>'revision')::int))));
      if x->>'status' is distinct from 'ok' then raise exception 'w07: fixture operation % refused', i; end if;
      op := op || (x->>'id');
    end loop;
    select acceptance::text into acc0 from devos_private.work where id::text = w1->>'id';
  exception when others then
    perform pg_temp.w07_cnc('F07-pre', 'fixture: ' || sqlstate || ' ' || left(sqlerrm, 300));
    return;
  end;

  -- (a) applied, then unknown (the original finding).
  r := pg_temp.w07_obs(w, op[1], 'applied', interval '2 hours', 'observer: applied');
  first_id := r->>'id'; first_row := pg_temp.w07_obs_row(first_id);
  x := pg_temp.w07_obs(w, op[1], 'unknown', interval '1 hour', 'observer: unknown');
  if r->>'status' = 'ok' and x->>'status' = 'ok' and first_row is not null then
    perform pg_temp.w07_hist('F07-a1 applied then unknown: history kept', op[1], first_id, first_row);
    perform pg_temp.w07_cur('F07-a2 applied then unknown: current state', w, op[1], 'unknown');
  else
    perform pg_temp.w07_cnc('F07-a1 applied then unknown: history kept', 'an observation was not recorded');
    perform pg_temp.w07_cnc('F07-a2 applied then unknown: current state', 'an observation was not recorded');
  end if;

  -- (b) out of order: the later "not applied" arrives first, the earlier "applied" arrives second.
  r := pg_temp.w07_obs(w, op[2], 'not_applied', interval '1 hour', 'observer: not applied (later, arrives first)');
  first_id := r->>'id'; first_row := pg_temp.w07_obs_row(first_id);
  x := pg_temp.w07_obs(w, op[2], 'applied', interval '2 hours', 'observer: applied (earlier, arrives second)');
  if r->>'status' = 'ok' and x->>'status' = 'ok' and first_row is not null then
    perform pg_temp.w07_hist('F07-b1 out of order: history kept', op[2], first_id, first_row);
    perform pg_temp.w07_cur('F07-b2 out of order: current state by observation time', w, op[2], 'not_applied');
  else
    perform pg_temp.w07_cnc('F07-b1 out of order: history kept', 'an observation was not recorded');
    perform pg_temp.w07_cnc('F07-b2 out of order: current state by observation time', 'an observation was not recorded');
  end if;

  -- (c) a synthetic sequence: the pull request merged (applied), then main reverted (not applied).
  r := pg_temp.w07_obs(w, op[3], 'applied', interval '2 hours', 'github: pull request merged');
  first_id := r->>'id'; first_row := pg_temp.w07_obs_row(first_id);
  x := pg_temp.w07_obs(w, op[3], 'not_applied', interval '1 hour', 'github: main reverted');
  if r->>'status' = 'ok' and x->>'status' = 'ok' and first_row is not null then
    perform pg_temp.w07_hist('F07-c1 merged then reverted: history kept', op[3], first_id, first_row);
    perform pg_temp.w07_cur('F07-c2 merged then reverted: current state', w, op[3], 'not_applied');
    insert into w07_results select 'F07-c3',
      case when acc0 is null then 'could_not_check'
           when (select acceptance::text from devos_private.work where id::text = w1->>'id') = acc0 then 'ok' else 'bad' end,
      'merged then reverted: the work item''s acceptance is a separate question, unchanged by observations (' || coalesce(acc0, 'unreadable') || ')';
  else
    perform pg_temp.w07_cnc('F07-c1 merged then reverted: history kept', 'an observation was not recorded');
    perform pg_temp.w07_cnc('F07-c2 merged then reverted: current state', 'an observation was not recorded');
    perform pg_temp.w07_cnc('F07-c3 merged then reverted: acceptance separate', 'an observation was not recorded');
  end if;
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_F07_OBSERVATION_HISTORY FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_F07_OBSERVATION_HISTORY COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_F07_OBSERVATION_HISTORY PASS (%/%)', n, n;
end $$;

rollback;
