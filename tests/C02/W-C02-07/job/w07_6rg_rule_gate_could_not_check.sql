-- Synthetic test data (plan Section 8 item 13): every mission, work item, relation, operation, scope
-- (synthetic.w07.rg), key and text below is made up for this test, labelled SYNTHETIC W-C02-07, and holds no personal
-- or business data. Tokens are issued at run time inside this rolled-back transaction, held only in PL/pgSQL
-- variables, and never printed or stored. The missing, unreadable and partial inputs are planted by the owner inside
-- subtransactions that are rolled back before the next case (as W-C02-03's w03_drift_could_not_check.sql does).
--
-- Claim: each rule-gate check that C02 builds, given missing, unreadable or partial input, answers "could not check",
-- kept apart from clean and from fail, and lets no write through; a readiness group with an unknown member is not
-- ready (W-C02-07 point 6; W-C02-09 point 7; plan Section 8 item 14; PC-16; B principle 6; EV-C02-002 DM-01, DM-06,
-- DM-37). Specification: tests/C02/W-C02-07/T-W07-6RG_rule_gate_could_not_check.md.
-- Added under ledger rule 3, 2026-10-19 (N-301): the two reads that hand a gate check its input, the epoch's
-- (authority_epoch: 6RG-a0 to -a2) and the fingerprint store's (fingerprint_matches: 6RG-f0, -f1; Appendix C N06).
-- Runs: the migration job's devos-test step as postgres (README 5.1 (a)); the break harness's throwaway database (5.2).
-- Transport: sql-set-role (role anon, header simulated with set_config; the record says so).
-- Safety: everything is inside begin ... rollback; no psql meta-command; before the build exists it ends in
-- COULD NOT CHECK. Output: one row per case, per-check counts as a notice, then PASS / FAIL / COULD NOT CHECK.
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
  -- Revised before any result (EV-C02-013 R2-7, 2026-10-18): the answer is bound to the revision answered (DM-11 (a)),
  -- so the answered Decision names answered_revision 1, which open_mission compares with owner_authority_revision.
  d := pg_temp.w07_owner_insert('devos_private.decision', jsonb_build_object('class', 'batu', 'status', 'answered',
                                                                          'answered_revision', 1));
  if to_regclass('devos_private.decision_revision') is not null then
    perform pg_temp.w07_owner_insert('devos_private.decision_revision', jsonb_build_object('revision', 1),
                                     jsonb_build_object('devos_private.decision', d->>'id'));
  end if;
  r := pg_temp.w07_call(p_k, 'select devos_api.open_mission($2)', null, jsonb_build_object(
         'purpose', 'w07_fixture SYNTHETIC W-C02-07 mission (plan Section 8 item 13); not work',
         'scope', p_scope, 'owner_authority', d->>'id', 'owner_authority_revision', 1,
         'acceptance', 'w07_fixture SYNTHETIC W-C02-07', 'constraints', '[]'::jsonb));
  if r->>'status' is distinct from 'ok' then
    raise exception 'w07: fixture mission not opened: %', coalesce(r->>'reason_code', r->>'w07_raised', r->>'status');
  end if;
  return jsonb_build_object('id', r->>'id', 'revision', coalesce((r->>'revision')::int, 1), 'scope', p_scope);
end $f$;

create function pg_temp.w07_work_payload(p_mission jsonb, p_scope text, p_extra jsonb default '{}') returns jsonb
language sql as $f$
  select jsonb_build_object(
    'mission_ref', p_mission->>'id', 'mission_revision', (p_mission->>'revision')::int,
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
    'work_ref', p_work->>'id', 'work_revision', (p_work->>'revision')::int,
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

create temp table w07_answers (grp text, answer text);

-- The global authority epoch's table and column, found in the catalogue (EV-C02-002 DM-01: one row in devos_private).
create function pg_temp.w07_epoch_table() returns text[] language plpgsql as $f$
declare t text; col text; n int;
begin
  select count(*), min(c.oid::regclass::text) into n, t from pg_class c join pg_namespace s on s.oid = c.relnamespace
   where s.nspname = 'devos_private' and c.relkind = 'r' and c.relname = 'global_authority_epoch';
  if n <> 1 then return null; end if;
  select min(attname) into col from pg_attribute where attrelid = t::regclass and attnum > 0 and not attisdropped
     and attname = 'epoch' and format_type(atttypid, atttypmod) in ('bigint', 'integer');
  if col is null then return null; end if;
  return array[t, col];
end $f$;

-- One planted case: plant, call, compare the state before and after the call, undo everything, then judge.
create function pg_temp.w07_planted(p_id text, p_plant text, p_tok text, p_sql text, p_t text, p_j jsonb, p_u text,
                                    p_want text) returns void language plpgsql as $f$
declare r jsonb; s0 jsonb; s1 jsonb; planted boolean := false; perr text;
begin
  begin
    if p_plant is not null then execute p_plant; end if;
    planted := true;
    s0 := pg_temp.w07_state();
    r := pg_temp.w07_call(p_tok, p_sql, p_t, p_j, p_u);
    s1 := pg_temp.w07_state();
    raise exception using errcode = 'P0W07', message = 'w07: undo the planted state';
  exception
    when sqlstate 'P0W07' then null;
    when others then perr := sqlstate || ' ' || left(sqlerrm, 160);
  end;
  if not planted or r is null then
    perform pg_temp.w07_cnc(p_id, 'the input state could not be planted: ' || coalesce(perr, 'no result'));
    return;
  end if;
  insert into w07_answers values (substr(split_part(p_id, ' ', 1), 1, 5), pg_temp.w07_answer_kind(r));
  -- Phase C6 (CHK-C02-030 C7): a could-not-check answer returns nothing through it: no key that names or carries a
  -- record, an operation, a claim or a list (the keys are interface v1's choice, README 8.1; revised with it).
  perform pg_temp.w07_judge(p_id, r, p_want,
    case when p_want <> 'ok' and s1 <> s0 then 'the write went through (state changed)'
         when p_want = 'could_not_check' and r ?| array['id', 'operation_id', 'claim_token', 'assignment_id', 'revision',
                                                          'records', 'works', 'paths', 'rows']
           then 'returned through the could-not-check answer: '
                || (select string_agg(k, ', ' order by k) from jsonb_object_keys(r) k
                     where k not in ('status', 'reason_code', 'reason')) end);
end $f$;

-- Phase C5 (CHK-C02-030 C8): one answer's kind for the per-check counts, in interface v1's terms (README 8.1): a
-- could-not-check answer (status refused, reason_code could_not_check) is counted as could_not_check, never as refused;
-- refused is any other refusal (fail); ok is clean; a raised error or any other form is counted apart as other.
create function pg_temp.w07_answer_kind(r jsonb) returns text language sql immutable as $f$
  select case when r ? 'w07_raised' then 'raised'
              when r->>'status' = 'refused' and r->>'reason_code' = 'could_not_check' then 'could_not_check'
              when r->>'status' in ('ok', 'refused') then r->>'status'
              else 'other: ' || coalesce(r->>'status', 'absent') end $f$;

-- One readiness case through ready_works(): is the work item listed? A could_not_check answer counts as not listed.
create function pg_temp.w07_ready_case(p_id text, p_plant text, p_tok text, p_work text, p_listed boolean)
returns void language plpgsql as $f$
declare r jsonb; planted boolean := false; perr text; listed boolean;
begin
  begin
    if p_plant is not null then execute p_plant; end if;
    planted := true;
    r := pg_temp.w07_call(p_tok, 'select devos_api.ready_works()');
    raise exception using errcode = 'P0W07', message = 'w07: undo the planted state';
  exception
    when sqlstate 'P0W07' then null;
    when others then perr := sqlstate || ' ' || left(sqlerrm, 160);
  end;
  -- Phase C5 (CHK-C02-030 C8): interface v1's could not check (status refused, reason_code could_not_check) is a
  -- readable answer here, taken as "not listed", as the comment above says; any other refusal, a raised error or
  -- another form is no readable answer, the test's own could not check.
  if not planted or r is null or r ? 'w07_raised'
     or pg_temp.w07_answer_kind(r) not in ('ok', 'could_not_check') then
    perform pg_temp.w07_cnc(p_id, 'no readable answer: ' || coalesce(perr, r->>'w07_raised',
      nullif(concat_ws(' ', r->>'status', r->>'reason_code'), ''), 'none'));
    return;
  end if;
  insert into w07_answers values (substr(split_part(p_id, ' ', 1), 1, 5), pg_temp.w07_answer_kind(r));
  listed := r->>'status' = 'ok' and exists (select 1 from jsonb_array_elements(coalesce(r->'works', '[]')) e
                                             where e->>'id' = p_work);
  insert into w07_results values (split_part(p_id, ' ', 1), case when listed = p_listed then 'ok' else 'bad' end,
    substr(p_id, length(split_part(p_id, ' ', 1)) + 2) || format(': answered %s, work item %s (wanted %s)',
      pg_temp.w07_answer_kind(r), case when listed then 'listed' else 'not listed' end, case when p_listed then 'listed' else 'not listed' end));
end $f$;

create function pg_temp.w07_op6(p_work jsonb, p_key text, p_read jsonb) returns jsonb language sql as $f$
  select jsonb_build_object('idempotency_namespace', 'w07_fixture', 'idempotency_key', p_key,
    'effect_class', 'w07_fixture_effect', 'target', 'w07_fixture/target_rg', 'expected_base', 'w07_fixture_base_1',
    'payload_hash', 'w07_fixture_payload_1',
    'work_ref', p_work->>'id', 'work_revision', (p_work->>'revision')::int, 'read_set', p_read)
$f$;

create function pg_temp.w07_rel(p_from jsonb, p_to jsonb, p_type text, p_hard boolean) returns jsonb language sql as $f$
  select jsonb_build_object('type', p_type, 'from_ref', p_from->>'id', 'from_revision', (p_from->>'revision')::int,
    'to_ref', p_to->>'id', 'hard', p_hard, 'group_mode', 'ALL', 'scope', p_from->>'scope', 'method', 'recorded',
    'epistemic_status', 'observation')
    -- The flat form (EV-C02-013 section 1 item 3, D-1): to_revision only when the end carries one, so 6RG-r3's end
    -- "partial (no revision)" is sent without to_revision.
    || case when p_to ? 'revision' then jsonb_build_object('to_revision', (p_to->>'revision')::int) else '{}'::jsonb end
$f$;

do $$
declare why text; k text; w text; m jsonb; sc text := 'synthetic.w07.rg'; ep text[]; ept text; epc text; wt text;
        wr1 jsonb; wr2 jsonb; wr3 jsonb; wr4 jsonb; wr5 jsonb; wg1 jsonb; wg2 jsonb; wm1 jsonb; wm2 jsonb; wl jsonb;
        cr1 jsonb; cl jsonb; x jsonb; ref1 jsonb; plant text; g record; eff text := 'select devos_api.register_artifact($1, $2)';
        art jsonb; asg text := 'devos_private.assignment'; ci text;
begin
  why := pg_temp.w07_pre(array['devos_private.issue_env_token(text)', 'devos_api.open_mission(jsonb)',
    'devos_api.admit_work(jsonb)', 'devos_api.claim(uuid,text)', 'devos_api.relate(jsonb)', 'devos_api.ready_works()',
    'devos_api.register_artifact(text,jsonb)', 'devos_api.prepare_operation(text,jsonb)', 'devos_private.decision',
    'devos_private.effect_class', 'devos_private.work', 'devos_private.relation', 'devos_private.assignment']);
  if why is null then
    ep := pg_temp.w07_epoch_table();
    if ep is null then why := 'the global authority epoch''s table (devos_private.global_authority_epoch with an integer column epoch, README section 8) was not found'; end if;
  end if;
  if why is not null then perform pg_temp.w07_cnc('6RG-pre', why); return; end if;
  ept := ep[1]; epc := ep[2];
  wt := coalesce(to_regclass('devos_private.work_revision')::text, 'devos_private.work');
  begin
    k := pg_temp.w07_tok('devos_kurulum');
    w := pg_temp.w07_tok('devos_calisma');
    m := pg_temp.w07_fixture_mission(k, sc);
    wr1 := pg_temp.w07_fixture_work(w, m, sc); wr2 := pg_temp.w07_fixture_work(w, m, sc);
    wr3 := pg_temp.w07_fixture_work(w, m, sc); wr4 := pg_temp.w07_fixture_work(w, m, sc);
    wr5 := pg_temp.w07_fixture_work(w, m, sc); wl := pg_temp.w07_fixture_work(w, m, sc);
    wg1 := pg_temp.w07_fixture_work(w, m, sc); wg2 := pg_temp.w07_fixture_work(w, m, sc);
    wm1 := pg_temp.w07_fixture_work(w, m, sc); wm2 := pg_temp.w07_fixture_work(w, m, sc);
    perform pg_temp.w07_effect_class();
    for g in select * from (values (wg1, wm1), (wg2, wm2)) v(a, b) loop
      x := pg_temp.w07_call(w, 'select devos_api.relate($2)', null, pg_temp.w07_rel(g.a, jsonb_build_object('id', g.b->>'id',
             'revision', (g.b->>'revision')::int), 'depends_on', true));
      if x->>'status' is distinct from 'ok' then raise exception 'w07: fixture dependency refused'; end if;
    end loop;
    -- Both groups' one member is true (owner-planted: finished and accepted) until a case plants otherwise.
    update devos_private.work set execution = 'finished', acceptance = 'accepted' where id::text in (wm1->>'id', wm2->>'id');
    cr1 := pg_temp.w07_claim(w, wr1); cl := pg_temp.w07_claim(w, wl);
    if cr1->>'status' is distinct from 'ok' or cl->>'status' is distinct from 'ok' then raise exception 'w07: claim refused'; end if;
  exception when others then
    perform pg_temp.w07_cnc('6RG-pre', 'fixture: ' || sqlstate || ' ' || left(sqlerrm, 300));
    return;
  end;
  art := jsonb_build_object('work_ref', wr1->>'id', 'work_revision', (wr1->>'revision')::int,
           'path', 'w07_fixture/rg', 'commit', repeat('a7', 20), 'kind', 'w07_fixture', 'scope', sc,
           'declared_session_id', 'w07_fixture_session_a');

  -- 1. The global authority epoch: missing, unreadable, partial; at the effect and at the claim.
  perform pg_temp.w07_planted('6RG-e0 positive control: effect with the epoch readable', null, w, eff, cr1->>'claim_token', art, null, 'ok');
  perform pg_temp.w07_planted('6RG-e1 epoch row missing, at the effect',
    format('alter table %s disable trigger user; delete from %s', ept, ept), w, eff, cr1->>'claim_token', art, null, 'could_not_check');
  perform pg_temp.w07_planted('6RG-e2 epoch table unreadable, at the effect',
    format('alter table %s rename to w07_hidden_epoch', ept), w, eff, cr1->>'claim_token', art, null, 'could_not_check');
  perform pg_temp.w07_planted('6RG-e3 epoch value partial (null), at the effect',
    format('alter table %s disable trigger user; alter table %s alter column %I drop not null; update %s set %I = null', ept, ept, epc, ept, epc),
    w, eff, cr1->>'claim_token', art, null, 'could_not_check');
  perform pg_temp.w07_planted('6RG-e4 epoch row missing, at the claim',
    format('alter table %s disable trigger user; delete from %s', ept, ept), w, 'select devos_api.claim($3::uuid, $1)',
    'w07_fixture_session_a', null, wr2->>'id', 'could_not_check');

  -- 2. A referenced record or revision (relate wr3 -> wr4): missing record, missing revision, partial, unreadable.
  ref1 := jsonb_build_object('id', wr4->>'id', 'revision', (wr4->>'revision')::int);
  perform pg_temp.w07_planted('6RG-r0 positive control: both references readable', null, w, 'select devos_api.relate($2)', null,
    pg_temp.w07_rel(wr3, ref1, 'about', false), null, 'ok');
  perform pg_temp.w07_planted('6RG-r1 referenced record missing', null, w, 'select devos_api.relate($2)', null,
    pg_temp.w07_rel(wr3, jsonb_build_object('id', gen_random_uuid(), 'revision', 1), 'about', false), null, 'could_not_check');
  perform pg_temp.w07_planted('6RG-r2 referenced revision missing', null, w, 'select devos_api.relate($2)', null,
    pg_temp.w07_rel(wr3, jsonb_build_object('id', wr4->>'id', 'revision', 999), 'about', false), null, 'could_not_check');
  perform pg_temp.w07_planted('6RG-r3 reference partial (no revision)', null, w, 'select devos_api.relate($2)', null,
    pg_temp.w07_rel(wr3, jsonb_build_object('id', wr4->>'id'), 'about', false), null, 'could_not_check');
  perform pg_temp.w07_planted('6RG-r4 referenced record unreadable', format('alter table %s rename to w07_hidden_work', wt),
    w, 'select devos_api.relate($2)', null, pg_temp.w07_rel(wr3, ref1, 'supports', false), null, 'could_not_check');

  -- 3. An element of the read set (prepare_operation under cr1): missing, partial, unreadable.
  perform pg_temp.w07_planted('6RG-s0 positive control: read set readable', null, w, 'select devos_api.prepare_operation($1, $2)',
    cr1->>'claim_token', pg_temp.w07_op6(wr1, 'w07_fixture_key_rg_s0', jsonb_build_array(jsonb_build_object('ref', wr1->>'id', 'revision', 1))),
    null, 'ok');
  perform pg_temp.w07_planted('6RG-s1 read-set element missing', null, w, 'select devos_api.prepare_operation($1, $2)',
    cr1->>'claim_token', pg_temp.w07_op6(wr1, 'w07_fixture_key_rg_s1', jsonb_build_array(jsonb_build_object('ref', wr1->>'id', 'revision', 1),
      jsonb_build_object('ref', gen_random_uuid(), 'revision', 1))), null, 'could_not_check');
  perform pg_temp.w07_planted('6RG-s2 read-set element partial (no revision)', null, w, 'select devos_api.prepare_operation($1, $2)',
    cr1->>'claim_token', pg_temp.w07_op6(wr1, 'w07_fixture_key_rg_s2', jsonb_build_array(jsonb_build_object('ref', wr1->>'id', 'revision', 1),
      jsonb_build_object('ref', wr5->>'id'))), null, 'could_not_check');
  perform pg_temp.w07_planted('6RG-s3 read-set element unreadable', format('alter table %s rename to w07_hidden_work', wt),
    w, 'select devos_api.prepare_operation($1, $2)', cr1->>'claim_token', pg_temp.w07_op6(wr1, 'w07_fixture_key_rg_s3',
      jsonb_build_array(jsonb_build_object('ref', wr1->>'id', 'revision', 1), jsonb_build_object('ref', wr5->>'id', 'revision', 1))),
    null, 'could_not_check');

  -- 3b. Phase C5 (CHK-C02-030 C7 (c)): the effect-class read (EV-C02-002 DM-37: whether the effect is irreversible and
  -- the mandatory elements of the read set, read by prepare_operation from the effect-class table). The same call as
  -- 6RG-s0 (its positive pair), with the synthetic class's row missing, the table unreadable, or irreversible null.
  perform pg_temp.w07_planted('6RG-c1 effect class row missing',
    'alter table devos_private.effect_class disable trigger user; '
    || 'delete from devos_private.effect_class where effect_class = ''w07_fixture_effect''',
    w, 'select devos_api.prepare_operation($1, $2)', cr1->>'claim_token', pg_temp.w07_op6(wr1, 'w07_fixture_key_rg_c1',
      jsonb_build_array(jsonb_build_object('ref', wr1->>'id', 'revision', 1))), null, 'could_not_check');
  perform pg_temp.w07_planted('6RG-c2 effect class table unreadable',
    'alter table devos_private.effect_class rename to w07_hidden_effect_class',
    w, 'select devos_api.prepare_operation($1, $2)', cr1->>'claim_token', pg_temp.w07_op6(wr1, 'w07_fixture_key_rg_c2',
      jsonb_build_array(jsonb_build_object('ref', wr1->>'id', 'revision', 1))), null, 'could_not_check');
  perform pg_temp.w07_planted('6RG-c3 effect class partial (irreversible null)',
    'alter table devos_private.effect_class disable trigger user; '
    || 'alter table devos_private.effect_class alter column irreversible drop not null; '
    || 'update devos_private.effect_class set irreversible = null where effect_class = ''w07_fixture_effect''',
    w, 'select devos_api.prepare_operation($1, $2)', cr1->>'claim_token', pg_temp.w07_op6(wr1, 'w07_fixture_key_rg_c3',
      jsonb_build_array(jsonb_build_object('ref', wr1->>'id', 'revision', 1))), null, 'could_not_check');

  -- 4. Readiness: an ALL group whose member is unknown is not ready (B principle 6).
  perform pg_temp.w07_ready_case('6RG-g0 positive control: a group whose member is true is ready', null, w, wg1->>'id', true);
  perform pg_temp.w07_ready_case('6RG-g1 member''s state partial (null): not ready',
    format('alter table devos_private.work disable trigger user; alter table devos_private.work alter column execution drop not null; '
           'update devos_private.work set execution = null where id::text = %L', wm2->>'id'), w, wg2->>'id', false);
  perform pg_temp.w07_ready_case('6RG-g2 member''s revision missing: not ready',
    format('alter table devos_private.relation disable trigger user; update devos_private.relation set to_revision = 999 where from_ref::text = %L',
           wg2->>'id'), w, wg2->>'id', false);
  perform pg_temp.w07_planted('6RG-g3 the group unreadable, at the claim', 'alter table devos_private.relation rename to w07_hidden_relation',
    w, 'select devos_api.claim($3::uuid, $1)', 'w07_fixture_session_b', null, wg2->>'id', 'could_not_check');

  -- 5. The claim's expiry inputs (DM-06): lease missing, unreadable; generation partial; at claim, effect and ready_works().
  perform pg_temp.w07_planted('6RG-l0 positive control: effect with the lease readable', null, w, eff, cl->>'claim_token',
    art || jsonb_build_object('work_ref', wl->>'id', 'work_revision', (wl->>'revision')::int), null, 'ok');
  plant := format('alter table %s disable trigger user; alter table %s alter column lease_expires_at drop not null; '
                  'update %s set lease_expires_at = null where id::text = %L', asg, asg, asg, cl->>'assignment_id');
  perform pg_temp.w07_planted('6RG-l1 lease missing, at the next claim', plant, w, 'select devos_api.claim($3::uuid, $1)',
    'w07_fixture_session_b', null, wl->>'id', 'could_not_check');
  perform pg_temp.w07_planted('6RG-l2 lease unreadable, at the next claim',
    format('alter table %s rename column lease_expires_at to w07_hidden_lease', asg), w, 'select devos_api.claim($3::uuid, $1)',
    'w07_fixture_session_b', null, wl->>'id', 'could_not_check');
  perform pg_temp.w07_planted('6RG-l3 generation partial (null), at the next claim',
    format('alter table %s disable trigger user; alter table %s alter column generation drop not null; '
           'update %s set generation = null where id::text = %L', asg, asg, asg, cl->>'assignment_id'),
    w, 'select devos_api.claim($3::uuid, $1)', 'w07_fixture_session_b', null, wl->>'id', 'could_not_check');
  perform pg_temp.w07_planted('6RG-l4 lease missing, at the effect', plant, w, eff, cl->>'claim_token',
    art || jsonb_build_object('work_ref', wl->>'id', 'work_revision', (wl->>'revision')::int), null, 'could_not_check');
  perform pg_temp.w07_ready_case('6RG-l5 lease missing: ready_works() does not offer the work item', plant, w, wl->>'id', false);

  -- 6. Added under ledger rule 3, 2026-10-19 (N-301; EV-C02-014 section 11, k17 and k20): the two reads that hand a
  -- check of the gate its input, the global authority epoch (authority_epoch, EV-C02-008 1.4 row R12; B principle 9)
  -- and the fingerprint store (fingerprint_matches, row R13; Appendix C N06: "with the fingerprint store absent, the
  -- write is stopped as 'could not check', not let through as clean"). Each answers its missing or partial input
  -- "could not check", never clean; each beside its positive control on readable input.
  perform pg_temp.w07_planted('6RG-a0 positive control: the epoch read with its row readable', null, w,
    'select devos_api.authority_epoch()', null, null, null, 'ok');
  perform pg_temp.w07_planted('6RG-a1 epoch row missing, at its read',
    format('alter table %s disable trigger user; delete from %s', ept, ept), w, 'select devos_api.authority_epoch()',
    null, null, null, 'could_not_check');
  perform pg_temp.w07_planted('6RG-a2 epoch value partial (null), at its read',
    format('alter table %s disable trigger user; alter table %s alter column %I drop not null; update %s set %I = null', ept, ept, epc, ept, epc),
    w, 'select devos_api.authority_epoch()', null, null, null, 'could_not_check');
  begin
    ci := pg_temp.w07_tok('devos_ci');
  exception when others then
    ci := null;
  end;
  if ci is null then
    perform pg_temp.w07_cnc('6RG-f0 positive control', 'the devos_ci token could not be issued');
    perform pg_temp.w07_cnc('6RG-f1 fingerprint store absent', 'the devos_ci token could not be issued');
  else
    perform pg_temp.w07_planted('6RG-f0 positive control: the fingerprint read with the store readable', null, ci,
      'select devos_api.fingerprint_matches(array[$1])', 'w07_fixture_hash_rg', null, null, 'ok');
    perform pg_temp.w07_planted('6RG-f1 fingerprint store absent (unreadable), at its read',
      'alter table devos_private.leak_fingerprint rename to w07_hidden_leak_fingerprint', ci,
      'select devos_api.fingerprint_matches(array[$1])', 'w07_fixture_hash_rg', null, null, 'could_not_check');
    ci := null;
  end if;

  -- Per check: the answers seen, with the denominator (README section 3).
  -- Interface v1's kinds (w07_answer_kind; phase C5, CHK-C02-030 C8): clean (ok), fail (any other refusal) and could
  -- not check are counted apart; a raised error or another form is "other", the test's own could not check.
  for g in select grp, count(*) filter (where answer = 'ok') ok, count(*) filter (where answer = 'refused') refused,
                  count(*) filter (where answer = 'could_not_check') cnc, count(*) filter (where answer not in ('ok', 'refused', 'could_not_check')) other,
                  count(*) n from w07_answers group by grp order by grp loop
    raise notice 'W07_6RG answers % : clean (ok) %, fail (refused) %, could not check %, other %, of %', g.grp, g.ok, g.refused, g.cnc, g.other, g.n;
  end loop;
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_6RG_RULE_GATE_COULD_NOT_CHECK FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_6RG_RULE_GATE_COULD_NOT_CHECK COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_6RG_RULE_GATE_COULD_NOT_CHECK PASS (%/%)', n, n;
end $$;

rollback;
