-- Synthetic test data (plan Section 8 item 13): every mission, work item, relation, artifact, operation, scope
-- (synthetic.w07.f08), path (w07_fixture/*), key, reason and text below is made up for this test, labelled SYNTHETIC
-- W-C02-07, and holds no personal or business data. Tokens are issued at run time inside this rolled-back
-- transaction, held only in PL/pgSQL variables, and never printed or stored.
--
-- Claim: at the moment of effect, the current work item, its hard dependencies, the claim (active, current generation,
-- valid epoch, lease not run out) and the read set are checked again, and the read set's mandatory elements are the
-- server's (Appendix C F08; B 3.12; EV-C02-002 DM-06, DM-37; EV-C02-004 X-07). Specification:
-- tests/C02/W-C02-07/T-W07-F08_recheck_at_effect.md. Expiry is planted as passed (no wait; README section 9).
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

create function pg_temp.w07_dep(p_tok text, p_from jsonb, p_to jsonb) returns jsonb language sql as $f$
  select pg_temp.w07_call(p_tok, 'select devos_api.relate($2)', null, jsonb_build_object('type', 'depends_on',
    'from_ref', jsonb_build_object('id', p_from->>'id', 'revision', (p_from->>'revision')::int),
    'to_ref', jsonb_build_object('id', p_to->>'id', 'revision', (p_to->>'revision')::int),
    'hard', true, 'group_mode', 'ALL', 'scope', p_from->>'scope', 'method', 'recorded', 'epistemic_status', 'observation'))
$f$;

create function pg_temp.w07_op08(p_work jsonb, p_key text, p_read jsonb) returns jsonb language sql as $f$
  select jsonb_build_object('idempotency_namespace', 'w07_fixture', 'idempotency_key', p_key,
    'effect_class', 'w07_fixture_effect', 'target', 'w07_fixture/target_f08', 'expected_base', 'w07_fixture_base_1',
    'payload_hash', 'w07_fixture_payload_1',
    'work_ref', jsonb_build_object('id', p_work->>'id', 'revision', (p_work->>'revision')::int), 'read_set', p_read)
$f$;

create function pg_temp.w07_ref(p jsonb) returns jsonb language sql as $f$
  select jsonb_build_object('ref', p->>'id', 'revision', (p->>'revision')::int)
$f$;

do $$
declare why text; k text; w text; a text; m jsonb; sc text := 'synthetic.w07.f08';
        wa jsonb; wx jsonb; we jsonb; wb jsonb; wsrc jsonb; wc1 jsonb; wc2 jsonb; wc3 jsonb; wd jsonb; wi1 jsonb; wi2 jsonb;
        ca jsonb; ce jsonb; cb jsonb; cc1 jsonb; cc2 jsonb; cc3 jsonb; cd jsonb; r jsonb; x jsonb; s0 jsonb; art0 text;
        wg jsonb; ww jsonb; wv jsonb; cg jsonb; cg2 jsonb; cw jsonb; cv jsonb;  -- phase C3 (G3, G4)
begin
  why := pg_temp.w07_pre(array['devos_private.issue_env_token(text)', 'devos_private.revoke_env_token(*)',
    'devos_api.open_mission(jsonb)', 'devos_api.admit_work(jsonb)', 'devos_api.revise_work(jsonb)',
    'devos_api.claim(uuid,text)', 'devos_api.relate(jsonb)', 'devos_api.revoke_claim(uuid,text)',
    'devos_api.register_artifact(text,jsonb)', 'devos_api.prepare_operation(text,jsonb)',
    'devos_api.record_attempt(text,uuid)', 'devos_private.decision', 'devos_private.effect_class',
    'devos_private.work', 'devos_private.assignment', 'devos_private.artifact']);
  if why is not null then perform pg_temp.w07_cnc('F08-pre', why); return; end if;
  begin
    k := pg_temp.w07_tok('devos_kurulum');
    w := pg_temp.w07_tok('devos_calisma');
    a := pg_temp.w07_tok('devos_denetim');
    m := pg_temp.w07_fixture_mission(k, sc);
    wa := pg_temp.w07_fixture_work(w, m, sc); wx := pg_temp.w07_fixture_work(w, m, sc);
    we := pg_temp.w07_fixture_work(w, m, sc); wb := pg_temp.w07_fixture_work(w, m, sc);
    wsrc := pg_temp.w07_fixture_work(w, m, sc); wc1 := pg_temp.w07_fixture_work(w, m, sc);
    wc2 := pg_temp.w07_fixture_work(w, m, sc); wc3 := pg_temp.w07_fixture_work(w, m, sc);
    wi1 := pg_temp.w07_fixture_work(w, m, sc); wi2 := pg_temp.w07_fixture_work(w, m, sc);
    wg := pg_temp.w07_fixture_work(w, m, sc); ww := pg_temp.w07_fixture_work(w, m, sc);
    wv := pg_temp.w07_fixture_work(w, m, sc);
    wd := pg_temp.w07_fixture_work(w, m, sc, jsonb_build_object('input_refs', jsonb_build_array(
            jsonb_build_object('id', wi1->>'id', 'revision', 1), jsonb_build_object('id', wi2->>'id', 'revision', 1))));
    perform pg_temp.w07_effect_class();
    ca := pg_temp.w07_claim(w, wa); ce := pg_temp.w07_claim(w, we); cb := pg_temp.w07_claim(w, wb);
    cc1 := pg_temp.w07_claim(w, wc1); cc2 := pg_temp.w07_claim(w, wc2); cc3 := pg_temp.w07_claim(w, wc3);
    cd := pg_temp.w07_claim(w, wd);
    cg := pg_temp.w07_claim(w, wg); cw := pg_temp.w07_claim(w, ww); cv := pg_temp.w07_claim(w, wv);
    if ca->>'status' is distinct from 'ok' or ce->>'status' is distinct from 'ok' or cb->>'status' is distinct from 'ok'
       or cc1->>'status' is distinct from 'ok' or cc2->>'status' is distinct from 'ok'
       or cc3->>'status' is distinct from 'ok' or cd->>'status' is distinct from 'ok'
       or cg->>'status' is distinct from 'ok' or cw->>'status' is distinct from 'ok' or cv->>'status' is distinct from 'ok' then
      raise exception 'w07: a fixture claim was refused';
    end if;
  exception when others then
    perform pg_temp.w07_cnc('F08-pre', 'fixture: ' || sqlstate || ' ' || left(sqlerrm, 300));
    return;
  end;

  -- (a) a new hard dependency after the claim (the original finding). Before it, the effect goes through.
  r := pg_temp.w07_effect(w, ca->>'claim_token', wa, 'f08/a_before');
  perform pg_temp.w07_judge('F08-pos0 effect before the dependency', r, 'ok');
  art0 := r->>'id';
  begin
    x := pg_temp.w07_dep(w, wa, wx);
    if x->>'status' is distinct from 'ok' then raise exception 'relate refused: %', coalesce(x->>'reason_code', x->>'w07_raised'); end if;
    s0 := pg_temp.w07_state();
    r := pg_temp.w07_effect(w, ca->>'claim_token', wa, 'f08/a_after');
    perform pg_temp.w07_judge('F08-a a hard dependency opened after the claim', r, 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed'
           when art0 is not null and not exists (select 1 from devos_private.artifact t where t.id::text = art0)
             then 'the earlier candidate result was removed' end);
    -- Positive: an independent exploration work item continues under another claim.
    perform pg_temp.w07_judge('F08-pos1 an independent work item under another claim',
      pg_temp.w07_effect(w, ce->>'claim_token', we, 'f08/independent'), 'ok');
    -- Positive: after the dependency is resolved (planted by the owner: finished and accepted), the effect is made.
    update devos_private.work set execution = 'finished', acceptance = 'accepted' where id::text = wx->>'id';
    perform pg_temp.w07_judge('F08-pos2 effect after the dependency is resolved',
      pg_temp.w07_effect(w, ca->>'claim_token', wa, 'f08/a_resolved'), 'ok');
  exception when others then
    perform pg_temp.w07_cnc('F08-a a hard dependency opened after the claim', left(sqlerrm, 200));
  end;

  -- (b) a change to a source in the read set between prepare and the effect.
  begin
    r := pg_temp.w07_prepare(w, cb->>'claim_token',
           pg_temp.w07_op08(wb, 'w07_fixture_key_f08_b', jsonb_build_array(pg_temp.w07_ref(wb), pg_temp.w07_ref(wsrc))));
    if r->>'status' is distinct from 'ok' then raise exception 'prepare refused: %', coalesce(r->>'reason_code', r->>'w07_raised'); end if;
    x := pg_temp.w07_call(w, 'select devos_api.revise_work($2)', null, jsonb_build_object('id', wsrc->>'id',
           'base_revision', (wsrc->>'revision')::int, 'scope', sc, 'reason', 'w07_fixture SYNTHETIC W-C02-07 source change'));
    if x->>'status' is distinct from 'ok' then raise exception 'the source could not be revised'; end if;
    s0 := pg_temp.w07_state();
    perform pg_temp.w07_judge('F08-b a source in the read set changed',
      pg_temp.w07_call(w, 'select devos_api.record_attempt($1, $3::uuid)', cb->>'claim_token', null, r->>'id'), 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed' end);
    r := pg_temp.w07_prepare(w, cb->>'claim_token', pg_temp.w07_op08(wb, 'w07_fixture_key_f08_b2',
           jsonb_build_array(pg_temp.w07_ref(wb), jsonb_build_object('ref', wsrc->>'id', 'revision', (wsrc->>'revision')::int + 1))));
    if r->>'status' = 'ok' then
      perform pg_temp.w07_judge('F08-pos3 effect with the current read set',
        pg_temp.w07_call(w, 'select devos_api.record_attempt($1, $3::uuid)', cb->>'claim_token', null, r->>'id'), 'ok');
    else
      perform pg_temp.w07_judge('F08-pos3 effect with the current read set', r, 'ok');
    end if;
  exception when others then
    perform pg_temp.w07_cnc('F08-b a source in the read set changed', left(sqlerrm, 200));
  end;

  -- (c1) the claim revoked by the audit environment; then the work item can be claimed again at once.
  begin
    r := pg_temp.w07_call(a, 'select devos_api.revoke_claim($3::uuid, $1)', 'w07_fixture SYNTHETIC W-C02-07 reason', null,
                          cc1->>'assignment_id');
    if r->>'status' is distinct from 'ok' then raise exception 'revoke_claim refused'; end if;
    s0 := pg_temp.w07_state();
    perform pg_temp.w07_judge('F08-c1 effect with a revoked claim',
      pg_temp.w07_effect(w, cc1->>'claim_token', wc1, 'f08/c1'), 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed' end);
    x := pg_temp.w07_claim(w, wc1);
    perform pg_temp.w07_judge('F08-pos4 a new claim after the revocation makes the effect',
      case when x->>'status' = 'ok' then pg_temp.w07_effect(w, x->>'claim_token', wc1, 'f08/c1_new') else x end, 'ok');
  exception when others then
    perform pg_temp.w07_cnc('F08-c1 effect with a revoked claim', left(sqlerrm, 200));
  end;
  -- (c2) the claim's lease run out (planted, DM-06).
  begin
    update devos_private.assignment set lease_expires_at = now() - interval '1 second' where id::text = cc2->>'assignment_id';
    s0 := pg_temp.w07_state();
    perform pg_temp.w07_judge('F08-c2 effect with an expired claim',
      pg_temp.w07_effect(w, cc2->>'claim_token', wc2, 'f08/c2'), 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed' end);
  exception when others then
    perform pg_temp.w07_cnc('F08-c2 effect with an expired claim', left(sqlerrm, 200));
  end;

  -- Phase C3 (G3): the claim's current generation at the moment of effect. (g1) the claim released, then an effect
  -- with its token; (pos6) the work item claimed again at once and the new claim's effect made; (g2) then an effect
  -- with the earlier generation's token (W-C02-09 point 4: "with a released ... claim", "with an earlier generation").
  begin
    r := pg_temp.w07_call(w, 'select devos_api.release($1)', cg->>'claim_token');
    if r->>'status' is distinct from 'ok' then
      raise exception 'release refused: %', coalesce(r->>'reason_code', r->>'w07_raised', r->>'status');
    end if;
    s0 := pg_temp.w07_state();
    perform pg_temp.w07_judge('F08-g1 effect with a released claim',
      pg_temp.w07_effect(w, cg->>'claim_token', wg, 'f08/g1'), 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed' end);
    cg2 := pg_temp.w07_claim(w, wg);
    perform pg_temp.w07_judge('F08-pos6 the new generation''s claim makes the effect',
      case when cg2->>'status' = 'ok' then pg_temp.w07_effect(w, cg2->>'claim_token', wg, 'f08/g_new') else cg2 end, 'ok');
    if cg2->>'status' is distinct from 'ok' then raise exception 'the work item could not be claimed again'; end if;
    s0 := pg_temp.w07_state();
    perform pg_temp.w07_judge('F08-g2 effect with the earlier generation''s token',
      pg_temp.w07_effect(w, cg->>'claim_token', wg, 'f08/g2'), 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed' end);
  exception when others then
    perform pg_temp.w07_cnc(g, left(sqlerrm, 200))
      from unnest(array['F08-g1', 'F08-pos6', 'F08-g2']) g;  -- the block's rows were rolled back with it
  end;

  -- Phase C3 (G4): the current work item at the moment of effect. (w) the work item is revised after its claim; the
  -- effect then names the revision it was claimed at; (pos7) the same effect on a work item not revised. They differ
  -- only in the revision made between the claim and the effect.
  begin
    x := pg_temp.w07_call(w, 'select devos_api.revise_work($2)', null, jsonb_build_object('id', ww->>'id',
           'base_revision', (ww->>'revision')::int, 'scope', sc, 'reason', 'w07_fixture SYNTHETIC W-C02-07 work change'));
    if x->>'status' is distinct from 'ok' then
      raise exception 'the work item could not be revised: %', coalesce(x->>'reason_code', x->>'w07_raised', x->>'status');
    end if;
    s0 := pg_temp.w07_state();
    perform pg_temp.w07_judge('F08-w the work item revised after the claim',
      pg_temp.w07_effect(w, cw->>'claim_token', ww, 'f08/w'), 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed' end);
  exception when others then
    perform pg_temp.w07_cnc('F08-w the work item revised after the claim', left(sqlerrm, 200));
  end;
  perform pg_temp.w07_judge('F08-pos7 the same effect on a work item not revised',
    pg_temp.w07_effect(w, cv->>'claim_token', wv, 'f08/w_unrevised'), 'ok');

  -- (d) the agent writes an incomplete read set: one of the work item's inputs is left out (DM-37).
  perform pg_temp.w07_judge('F08-pos5 a read set naming every input',
    pg_temp.w07_prepare(w, cd->>'claim_token', pg_temp.w07_op08(wd, 'w07_fixture_key_f08_d_full',
      jsonb_build_array(pg_temp.w07_ref(wd), pg_temp.w07_ref(wi1), pg_temp.w07_ref(wi2)))), 'ok');
  s0 := pg_temp.w07_state();
  perform pg_temp.w07_judge('F08-d a read set without one mandatory input',
    pg_temp.w07_prepare(w, cd->>'claim_token', pg_temp.w07_op08(wd, 'w07_fixture_key_f08_d_part',
      jsonb_build_array(pg_temp.w07_ref(wd), pg_temp.w07_ref(wi1)))), 'refused',
    case when pg_temp.w07_state() <> s0 then 'state changed' end);

  -- (c3) an authority epoch change after the claim (a synthetic token revoked, EV-C02-004 X-07). Last: it ends every
  -- claim of the old epoch.
  begin
    perform pg_temp.w07_bump_epoch();
    s0 := pg_temp.w07_state();
    perform pg_temp.w07_judge('F08-c3 effect after an authority epoch change',
      pg_temp.w07_effect(w, cc3->>'claim_token', wc3, 'f08/c3'), 'refused',
      case when pg_temp.w07_state() <> s0 then 'state changed' end);
  exception when others then
    perform pg_temp.w07_cnc('F08-c3 effect after an authority epoch change', left(sqlerrm, 200));
  end;
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_F08_RECHECK_AT_EFFECT FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_F08_RECHECK_AT_EFFECT COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_F08_RECHECK_AT_EFFECT PASS (%/%)', n, n;
end $$;

rollback;
