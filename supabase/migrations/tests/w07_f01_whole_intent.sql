-- Synthetic test data (plan Section 8 item 13): every mission, work item, scope (synthetic.w07.*), path (w07_fixture/*),
-- idempotency key (w07_fixture_key_*), effect class (w07_fixture_effect), session id and text below is made up for this
-- test, labelled SYNTHETIC W-C02-07, and holds no personal or business data. Tokens are issued at run time inside this
-- rolled-back transaction, held only in PL/pgSQL variables, and never printed, stored in the results or compared.
--
-- Claim: an idempotency key is bound to the operation's whole intent (Appendix C F01; B 3.12; EV-C02-002 DM-28).
-- Specification: tests/C02/W-C02-07/T-W07-F01_whole_intent.md (cases, interface assumed, break patches B-F01-1 to -3).
-- Runs: the migration job's devos-test step as postgres (README 5.1 (a)); the break harness's throwaway database (5.2).
-- Transport: sql-set-role. Each call runs as role anon with the x-devos-env-token header simulated through
-- set_config('request.headers', ..., true); this shows neither that the Data API passes the header nor a network secret.
-- Safety: everything is inside begin ... rollback; no psql meta-command; before the build exists the file ends in
-- COULD NOT CHECK. Output: one row per case, then PASS (notice) or FAIL / COULD NOT CHECK (raised).
-- Revised under ledger rule 3, 2026-10-19 (N-297 (c)), before any result of this file: F01-g's plant is valid at global
-- epoch 1; see the specification's "Revision under ledger rule 3 (N-297, 2026-10-19)".
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

create function pg_temp.w07_op(p_work jsonb, p_key text, p_change jsonb default '{}') returns jsonb language sql as $f$
  select jsonb_build_object('idempotency_namespace', 'w07_fixture', 'idempotency_key', p_key,
    'effect_class', 'w07_fixture_effect', 'target', 'w07_fixture/target_a', 'expected_base', 'w07_fixture_base_1',
    'payload_hash', 'w07_fixture_payload_1',
    'work_ref', p_work->>'id', 'work_revision', (p_work->>'revision')::int,
    'read_set', jsonb_build_array(jsonb_build_object('ref', p_work->>'id', 'revision', (p_work->>'revision')::int)))
    || p_change
$f$;

-- Back-dates every timestamp column of the operation with this key by 400 days (owner; DM-28's "long delay").
create function pg_temp.w07_backdate(p_key text) returns int language plpgsql as $f$
declare sets text; n int;
begin
  select string_agg(format('%I = %I - interval %L', attname, attname, '400 days'), ', ') into sets
    from pg_attribute where attrelid = 'devos_private.operation'::regclass and attnum > 0 and not attisdropped
     and format_type(atttypid, atttypmod) like 'timestamp%';
  if sets is null then return 0; end if;
  execute format('update devos_private.operation set %s where idempotency_namespace = %L and idempotency_key = %L',
                 sets, 'w07_fixture', p_key);
  get diagnostics n = row_count;
  return n;
end $f$;

-- DM-28's look: a DELETE on the operation table in any function body of the given schemas (pg_temp included only
-- for the look's own positive control).
create function pg_temp.w07_delete_paths(p_schemas text[]) returns int language sql as $f$
  select count(*)::int from pg_proc p join pg_namespace n on n.oid = p.pronamespace
  where (n.nspname = any(p_schemas) or (n.nspname like 'pg_temp%' and 'pg_temp' = any(p_schemas)))
    and p.prokind in ('f', 'p') and p.prosrc ~* 'delete[[:space:]]+from[[:space:]]+(only[[:space:]]+)?("?devos_private"?[.])?"?operation"?[[:>:]]'
$f$;

-- Phase C3 (G1): a second synthetic effect class, planted by the owner inside this transaction like the first.
create function pg_temp.w07_effect_class_b() returns void language plpgsql as $f$
begin
  if not exists (select 1 from devos_private.effect_class where effect_class = 'w07_fixture_effect_b') then
    perform pg_temp.w07_owner_insert('devos_private.effect_class', jsonb_build_object(
      'effect_class', 'w07_fixture_effect_b', 'irreversible', 'false',
      'mandatory_read_set', '{work,hard_dependencies,claim,authority_epoch,expected_base,inputs}'));
  end if;
end $f$;

do $$
declare why text; k text; w text; m jsonb; w1 jsonb; w2 jsonb; c jsonb; c2 jsonb; c3 jsonb; r jsonb; s0 jsonb;
        id1 text; id2 text; n int; roles text; rl text;
begin
  why := pg_temp.w07_pre(array['devos_private.issue_env_token(text)', 'devos_private.revoke_env_token(*)',
    'devos_api.open_mission(jsonb)', 'devos_api.admit_work(jsonb)', 'devos_api.claim(uuid,text)',
    'devos_api.release(text)', 'devos_api.prepare_operation(text,jsonb)', 'devos_private.decision',
    'devos_private.operation', 'devos_private.effect_class']);
  if why is not null then perform pg_temp.w07_cnc('F01-pre', why); return; end if;
  begin
    k := pg_temp.w07_tok('devos_kurulum');
    w := pg_temp.w07_tok('devos_calisma');
    m := pg_temp.w07_fixture_mission(k, 'synthetic.w07.f01');
    w1 := pg_temp.w07_fixture_work(w, m, 'synthetic.w07.f01');
    w2 := pg_temp.w07_fixture_work(w, m, 'synthetic.w07.f01');
    perform pg_temp.w07_effect_class();
    c := pg_temp.w07_claim(w, w1);
    c3 := pg_temp.w07_claim(w, w2);
    if c->>'status' is distinct from 'ok' or c3->>'status' is distinct from 'ok' then
      raise exception 'w07: fixture claim refused: %', coalesce(c->>'reason_code', c->>'w07_raised', c3->>'reason_code');
    end if;
  exception when others then
    perform pg_temp.w07_cnc('F01-pre', 'fixture: ' || sqlstate || ' ' || left(sqlerrm, 300));
    return;
  end;

  -- Positive control: the same key with the same full intent returns the existing record and no new effect.
  r := pg_temp.w07_prepare(w, c->>'claim_token', pg_temp.w07_op(w1, 'w07_fixture_key_1'));
  perform pg_temp.w07_judge('F01-pos1 first prepare', r, 'ok');
  id1 := r->>'id';
  s0 := pg_temp.w07_state();
  r := pg_temp.w07_prepare(w, c->>'claim_token', pg_temp.w07_op(w1, 'w07_fixture_key_1'));
  perform pg_temp.w07_judge('F01-pos2 exact repeat', r, 'ok',
    case when r->>'id' is distinct from id1 then 'another record returned'
         when pg_temp.w07_state() <> s0 then 'state changed (a new operation or event)' end);

  -- (a) same content, different target; (b) different expected base; (e) different content; (f) other work item.
  -- Phase C3: the digest is taken before each call (it was taken after the call, so "nothing changed" compared the
  -- state with itself).
  s0 := pg_temp.w07_state();
  r := pg_temp.w07_prepare(w, c->>'claim_token',
         pg_temp.w07_op(w1, 'w07_fixture_key_1', '{"target": "w07_fixture/target_b"}'));
  perform pg_temp.w07_judge('F01-a different target', r, 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);
  s0 := pg_temp.w07_state();
  r := pg_temp.w07_prepare(w, c->>'claim_token',
         pg_temp.w07_op(w1, 'w07_fixture_key_1', '{"expected_base": "w07_fixture_base_2"}'));
  perform pg_temp.w07_judge('F01-b different expected base', r, 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);
  s0 := pg_temp.w07_state();
  r := pg_temp.w07_prepare(w, c->>'claim_token',
         pg_temp.w07_op(w1, 'w07_fixture_key_1', '{"payload_hash": "w07_fixture_payload_2"}'));
  perform pg_temp.w07_judge('F01-e different content', r, 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);
  s0 := pg_temp.w07_state();
  r := pg_temp.w07_prepare(w, c3->>'claim_token', pg_temp.w07_op(w2, 'w07_fixture_key_1'));
  perform pg_temp.w07_judge('F01-f other work item', r, 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);

  -- Phase C3 (G1): the type. (t1) the same key with another effect class; (t2) the same key under another
  -- idempotency namespace, which must never be answered from key 1's record (refused as a conflict, or accepted as a
  -- record of its own with another id: the design does not say whether the namespace is part of the key or of the
  -- intent, so both are allowed and only "the existing record returned" is bad).
  begin
    perform pg_temp.w07_effect_class_b();
    s0 := pg_temp.w07_state();
    r := pg_temp.w07_prepare(w, c->>'claim_token',
           pg_temp.w07_op(w1, 'w07_fixture_key_1', '{"effect_class": "w07_fixture_effect_b"}'));
    perform pg_temp.w07_judge('F01-t1 different effect class', r, 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed' end);
  exception when others then
    perform pg_temp.w07_cnc('F01-t1 different effect class', 'could not plant the second class: ' || left(sqlerrm, 200));
  end;
  s0 := pg_temp.w07_state();
  r := pg_temp.w07_prepare(w, c->>'claim_token',
         pg_temp.w07_op(w1, 'w07_fixture_key_1', '{"idempotency_namespace": "w07_fixture_ns_b"}'));
  if r->>'status' = 'ok' then
    perform pg_temp.w07_judge('F01-t2 another namespace', r, 'ok',
      case when r->>'id' is not distinct from id1 or r->>'id' is null
             then 'answered from key 1''s record in another namespace (the existing record returned)'
           when pg_temp.w07_state() = s0 then 'accepted as its own record, but nothing was written' end,
      'accepted as a record of its own (the namespace read as part of the key)');
  else
    perform pg_temp.w07_judge('F01-t2 another namespace', r, 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed' end, 'refused (the namespace read as part of the intent)');
  end if;

  -- Phase C3 (G2): the authority epoch on its own. The design gives no path where only the epoch differs (a new
  -- epoch ends the claim, B 3.5), so the state is planted: key 4 is prepared, then the owner sets its stored epoch one
  -- lower; the same key and intent from the same claim (same generation, the current epoch) must be a conflict.
  begin
    r := pg_temp.w07_prepare(w, c->>'claim_token', pg_temp.w07_op(w1, 'w07_fixture_key_4'));
    if r->>'status' is distinct from 'ok' then raise exception 'prepare of key 4 refused'; end if;
    -- Revised under ledger rule 3, 2026-10-19 (N-297 (c); CHK-C02-096 C1 (c)): one lower only where the stored epoch is
    -- above 1, else one higher. At global epoch 1 the stored epoch is 1, and one lower broke the column's check
    -- (authority_epoch >= 1), so F01-g was could_not_check there; either way the stored epoch differs from the claim's.
    update devos_private.operation set authority_epoch = case when authority_epoch > 1 then authority_epoch - 1 else authority_epoch + 1 end
     where idempotency_namespace = 'w07_fixture' and idempotency_key = 'w07_fixture_key_4';
    get diagnostics n = row_count;
    if n <> 1 then raise exception 'the epoch plant touched % rows', n; end if;
    s0 := pg_temp.w07_state();
    r := pg_temp.w07_prepare(w, c->>'claim_token', pg_temp.w07_op(w1, 'w07_fixture_key_4'));
    perform pg_temp.w07_judge('F01-g different authority epoch', r, 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed' end);
  exception when others then
    perform pg_temp.w07_cnc('F01-g different authority epoch', 'could not plant the earlier epoch: ' || left(sqlerrm, 200));
  end;

  -- (c) everything the same, different claim generation.
  begin
    r := pg_temp.w07_call(w, 'select devos_api.release($1)', c->>'claim_token');
    if r->>'status' is distinct from 'ok' then raise exception 'release refused'; end if;
    c2 := pg_temp.w07_claim(w, w1);
    if c2->>'status' is distinct from 'ok' then raise exception 'second claim refused'; end if;
    s0 := pg_temp.w07_state();
    r := pg_temp.w07_prepare(w, c2->>'claim_token', pg_temp.w07_op(w1, 'w07_fixture_key_1'));
    perform pg_temp.w07_judge('F01-c different claim generation', r, 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed' end);
  exception when others then
    perform pg_temp.w07_cnc('F01-c different claim generation', 'could not plant the new generation: ' || left(sqlerrm, 200));
  end;

  -- (d) a delayed retry after a long delay (DM-28: keys never deleted): back-dated record, then retried.
  begin
    if c2 is null or c2->>'status' is distinct from 'ok' then raise exception 'no current claim'; end if;
    r := pg_temp.w07_prepare(w, c2->>'claim_token', pg_temp.w07_op(w1, 'w07_fixture_key_2'));
    if r->>'status' is distinct from 'ok' then raise exception 'prepare of key 2 refused'; end if;
    id2 := r->>'id';
    n := pg_temp.w07_backdate('w07_fixture_key_2');
    if n <> 1 then raise exception 'back-dating touched % rows', n; end if;
    s0 := pg_temp.w07_state();
    r := pg_temp.w07_prepare(w, c2->>'claim_token', pg_temp.w07_op(w1, 'w07_fixture_key_2'));
    perform pg_temp.w07_judge('F01-d1 late retry, same intent', r, 'ok',
      case when r->>'id' is distinct from id2 then 'answered as a new operation'
           when pg_temp.w07_state() <> s0 then 'state changed'
           when r->>'operation_status' is distinct from
                (select o.status::text from devos_private.operation o where o.id::text = id2)
             then 'the returned status is not the stored state' end);
  exception when others then
    perform pg_temp.w07_cnc('F01-d1 late retry, same intent', 'could not plant the late retry: ' || left(sqlerrm, 200));
  end;
  begin
    if c2 is null or c2->>'status' is distinct from 'ok' then raise exception 'no current claim'; end if;
    r := pg_temp.w07_prepare(w, c2->>'claim_token', pg_temp.w07_op(w1, 'w07_fixture_key_3'));
    if r->>'status' is distinct from 'ok' then raise exception 'prepare of key 3 refused'; end if;
    n := pg_temp.w07_backdate('w07_fixture_key_3');
    if n <> 1 then raise exception 'back-dating touched % rows', n; end if;
    s0 := pg_temp.w07_state();
    r := pg_temp.w07_prepare(w, c2->>'claim_token',
           pg_temp.w07_op(w1, 'w07_fixture_key_3', '{"target": "w07_fixture/target_c"}'));
    perform pg_temp.w07_judge('F01-d2 late retry, changed target', r, 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed (accepted as new)' end);
  exception when others then
    perform pg_temp.w07_cnc('F01-d2 late retry, changed target', 'could not plant the late retry: ' || left(sqlerrm, 200));
  end;

  -- (d3) DM-28 looked for: no path deletes Operation rows. The look's own control finds a planted body.
  begin
    execute 'create function pg_temp.w07_probe_delete() returns void language sql as '
         || quote_literal('delete from devos_private.operation where false');
    n := pg_temp.w07_delete_paths(array['pg_temp']);
    if n < 1 then
      perform pg_temp.w07_cnc('F01-d3 no delete path', 'the look missed its planted control');
    else
      n := pg_temp.w07_delete_paths(array['devos_api', 'devos_private']);
      roles := '';
      for rl in select rolname from pg_roles where rolname in ('anon', 'authenticated', 'devos_calisma',
                  'devos_denetim', 'devos_sinav', 'devos_kurulum', 'devos_ci', 'devos_backup') loop
        if has_table_privilege(rl, 'devos_private.operation', 'delete')
           or has_table_privilege(rl, 'devos_private.operation', 'truncate') then roles := roles || rl || ' '; end if;
      end loop;
      insert into w07_results values ('F01-d3',
        case when n = 0 and roles = '' then 'ok' else 'bad' end,
        format('no delete path: function bodies deleting operation rows: %s; roles with DELETE or TRUNCATE: %s (control found %s)',
               n, coalesce(nullif(roles, ''), 'none'), 1));
    end if;
  exception when others then
    perform pg_temp.w07_cnc('F01-d3 no delete path', 'the look could not run: ' || left(sqlerrm, 200));
  end;
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_F01_WHOLE_INTENT FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_F01_WHOLE_INTENT COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_F01_WHOLE_INTENT PASS (%/%)', n, n;
end $$;

rollback;
