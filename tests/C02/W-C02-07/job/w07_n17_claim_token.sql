-- Synthetic test data (plan Section 8 item 13): every mission, work item, scope (synthetic.w07.n17), path
-- (w07_fixture/*), session id (w07_fixture_session_*) and text below is made up for this test, labelled SYNTHETIC
-- W-C02-07, and holds no personal or business data. Environment and claim tokens are issued at run time inside this
-- rolled-back transaction, held only in PL/pgSQL variables, altered only at run time, and never printed or stored.
--
-- Claim: no effect without the claim's own token, and no call that takes a claim token (an effect, heartbeat or
-- release) under another role class's environment token (Appendix C N17 as PC-43 place 11 words it; EV-C02-003 §4.3;
-- B 3.5; EV-C02-002 DM-06, DM-07). Specification: tests/C02/W-C02-07/T-W07-N17_claim_token.md.
-- Runs: the migration job's devos-test step as postgres (README 5.1 (a)); the break harness's throwaway database (5.2).
-- Transport: sql-set-role (role anon, header simulated with set_config; the record says so, W-C02-09 point 3).
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

-- Owner-level: the claim's lease is planted as already passed (README section 9; no wait).
create function pg_temp.w07_lapse(p_assignment text) returns int language plpgsql as $f$
declare n int;
begin
  update devos_private.assignment set lease_expires_at = now() - interval '1 second' where id::text = p_assignment;
  get diagnostics n = row_count;
  return n;
end $f$;

-- A well-formed but unknown claim token: one character of an issued token's random part changed at run time.
create function pg_temp.w07_alter(p_token text) returns text language sql as $f$
  select overlay(p_token placing case when right(p_token, 1) = 'a' then 'b' else 'a' end from length(p_token) for 1)
$f$;

do $$
declare why text; k text; w text; a text; s text; m jsonb; w1 jsonb; w2 jsonb; w3 jsonb; w4 jsonb; w5 jsonb; c5 jsonb;
        c1 jsonb; c2 jsonb; ck jsonb; c4 jsonb; r jsonb; s0 jsonb;
begin
  why := pg_temp.w07_pre(array['devos_private.issue_env_token(text)', 'devos_api.open_mission(jsonb)',
    'devos_api.admit_work(jsonb)', 'devos_api.claim(uuid,text)', 'devos_api.heartbeat(text)', 'devos_api.release(text)',
    'devos_api.register_artifact(text,jsonb)', 'devos_private.decision', 'devos_private.assignment']);
  if why is not null then perform pg_temp.w07_cnc('N17-pre', why); return; end if;
  begin
    k := pg_temp.w07_tok('devos_kurulum');
    w := pg_temp.w07_tok('devos_calisma');
    a := pg_temp.w07_tok('devos_denetim');
    s := pg_temp.w07_tok('devos_sinav');
    m := pg_temp.w07_fixture_mission(k, 'synthetic.w07.n17');
    w1 := pg_temp.w07_fixture_work(w, m, 'synthetic.w07.n17');
    w2 := pg_temp.w07_fixture_work(w, m, 'synthetic.w07.n17');
    w3 := pg_temp.w07_fixture_work(k, m, 'synthetic.w07.n17');
    w4 := pg_temp.w07_fixture_work(w, m, 'synthetic.w07.n17');
    c1 := pg_temp.w07_claim(w, w1, 'w07_fixture_session_a');
    c2 := pg_temp.w07_claim(w, w2, 'w07_fixture_session_b');
    ck := pg_temp.w07_claim(k, w3, 'w07_fixture_session_k');
    c4 := pg_temp.w07_claim(w, w4, 'w07_fixture_session_a');
    w5 := pg_temp.w07_fixture_work(w, m, 'synthetic.w07.n17');
    c5 := pg_temp.w07_claim(w, w5, 'w07_fixture_session_a');
    if c1->>'status' is distinct from 'ok' or c2->>'status' is distinct from 'ok'
       or ck->>'status' is distinct from 'ok' or c4->>'status' is distinct from 'ok'
       or c5->>'status' is distinct from 'ok' then
      raise exception 'w07: a fixture claim was refused';
    end if;
  exception when others then
    perform pg_temp.w07_cnc('N17-pre', 'fixture: ' || sqlstate || ' ' || left(sqlerrm, 300));
    return;
  end;

  -- Positive controls: the right claim token with the claim's own role class.
  perform pg_temp.w07_judge('N17-pos1 effect, own claim, calisma',
    pg_temp.w07_effect(w, c1->>'claim_token', w1, 'n17/pos1'), 'ok');
  perform pg_temp.w07_judge('N17-pos2 effect, devos_kurulum''s own claim',
    pg_temp.w07_effect(k, ck->>'claim_token', w3, 'n17/pos2'), 'ok');
  perform pg_temp.w07_judge('N17-pos3 heartbeat, own claim',
    pg_temp.w07_call(w, 'select devos_api.heartbeat($1)', c1->>'claim_token'), 'ok');

  -- Negatives; each differs from a positive control in one thing, and must change nothing.
  s0 := pg_temp.w07_state();
  perform pg_temp.w07_judge('N17-n1 another session''s claim token on this work item',
    pg_temp.w07_effect(w, c2->>'claim_token', w1, 'n17/n1', null, 'w07_fixture_session_b'), 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);
  s0 := pg_temp.w07_state();
  perform pg_temp.w07_judge('N17-n2 no claim token',
    pg_temp.w07_effect(w, null, w1, 'n17/n2'), 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);
  s0 := pg_temp.w07_state();
  perform pg_temp.w07_judge('N17-n3 empty claim token',
    pg_temp.w07_effect(w, '', w1, 'n17/n3'), 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);
  s0 := pg_temp.w07_state();
  perform pg_temp.w07_judge('N17-n4 well-formed unknown claim token',
    pg_temp.w07_effect(w, pg_temp.w07_alter(c1->>'claim_token'), w1, 'n17/n4'), 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);
  s0 := pg_temp.w07_state();
  perform pg_temp.w07_judge('N17-n5 effect with the claim token under the audit token',
    pg_temp.w07_effect(a, c1->>'claim_token', w1, 'n17/n5'), 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);
  s0 := pg_temp.w07_state();
  perform pg_temp.w07_judge('N17-n6 heartbeat with the claim token under the exam token',
    pg_temp.w07_call(s, 'select devos_api.heartbeat($1)', c1->>'claim_token'), 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);
  s0 := pg_temp.w07_state();
  perform pg_temp.w07_judge('N17-n7 release with a working claim''s token under the devos_kurulum token',
    pg_temp.w07_call(k, 'select devos_api.release($1)', c5->>'claim_token'), 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);
  s0 := pg_temp.w07_state();
  perform pg_temp.w07_judge('N17-n8 devos_kurulum''s claim token under the working token',
    pg_temp.w07_effect(w, ck->>'claim_token', w3, 'n17/n8'), 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);
  begin
    if pg_temp.w07_lapse(c4->>'assignment_id') <> 1 then raise exception 'the lease could not be planted'; end if;
    s0 := pg_temp.w07_state();
    perform pg_temp.w07_judge('N17-n9 effect with a lapsed claim (DM-06)',
      pg_temp.w07_effect(w, c4->>'claim_token', w4, 'n17/n9'), 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed' end);
  exception when others then
    perform pg_temp.w07_cnc('N17-n9 effect with a lapsed claim (DM-06)', left(sqlerrm, 200));
  end;

  -- The last positive control: release with the claim's own role class (after the negatives that needed c1 active).
  perform pg_temp.w07_judge('N17-pos4 release, own claim',
    pg_temp.w07_call(w, 'select devos_api.release($1)', c1->>'claim_token'), 'ok');
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_N17_CLAIM_TOKEN FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_N17_CLAIM_TOKEN COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_N17_CLAIM_TOKEN PASS (%/%)', n, n;
end $$;

rollback;
