-- Synthetic test data (plan Section 8 item 13): every record, text, scope and name below is made up for this test,
-- labelled SYNTHETIC W-C02-07 or w07_fixture, and holds no personal or business data and no credential. Tokens are
-- issued at run time inside this rolled-back transaction, kept in a PL/pgSQL variable only, and never stored, printed,
-- compared or put in an error text (README section 6).
--
-- Claim. N29, its Mission part beyond the class (EV-C02-017 section 9 item 1, N-284 option C; EV-C02-013 22 (1)): a
-- widening of a Mission names a batu Decision that is not the owner authority of any revision of this Mission and was
-- answered no earlier than the Mission's current revision was written (equal passes); otherwise mission_authority,
-- and a NULL answered_at is could_not_check. A narrowing keeps today's checks.
-- Specification: tests/C02/W-C02-07/T-W07-N29_impact_class.md, "Revision under ledger rule 3 (N-284, 2026-10-19)".
-- This is T-W07-N29's second file: its main file, job/w07_n29_impact_class.sql, needs W-C02-10's tables (its pre-check
-- names high_impact_path and sample_stream), while this rule is built by W-C02-09's corrective migration and judged
-- before W-C02-09's verdict (ii); so these cases stand in a file of their own, which W-C02-09 copies.
-- Where it runs: the migration job's devos-test step, as postgres, after the merge's migrations (README 5.1 (a));
-- the break harness's throwaway PostgreSQL (README 5.2). Transport sql-set-role: each call runs as anon with the token
-- header simulated by set_config('request.headers', ..., true), so session_user stays postgres.
-- Interface assumed: the specification's "Interface assumed" and EV-C02-013 22 (1)'s reason texts (revised before a
-- first result if the build chooses another form, README section 8).
-- Safety: everything runs inside begin ... rollback; nothing is committed. Owner-level states (a Decision's answer and
-- its answered_at) are planted inside this transaction; each refused case runs in a subtransaction undone after it.
-- No psql meta-command is used.
-- Output: one row per case (case_id, outcome, detail), then W07_N29_MISSION_WIDENING PASS as a notice, or FAIL / COULD
-- NOT CHECK as an exception (README section 3). Before the rule exists its refusal cases are bad (FAIL).
-- Written under ledger rule 3, 2026-10-19 (N-284; EV-C02-017 1 (e)), before any result of the corrective migration.
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '60s';

-- Common helpers of Group C (copied into each Group C file, README section 7; source: this group's prelude, which
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
        when 'answer' then quote_literal(to_jsonb('w07_fixture SYNTHETIC W-C02-07 ' || c)::text) || '::jsonb'  -- jsonb (N-283)
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
-- Runs one group of cases; an error of the test itself makes the group could_not_check (never a pass).
create function pg_temp.w07_run(p_group text, p_sql text) returns void language plpgsql as $f$
begin
  execute p_sql;
exception when others then
  perform pg_temp.w07_put(p_group, 'could_not_check', 'the group stopped on an error of the test itself: ' || sqlstate || ' ' || left(sqlerrm, 200));
end $f$;
-- Synthetic effect classes (owner-level fixtures inside this rolled-back transaction; DM-37's table is filled by

-- ===== The cases of this file (EV-C02-017 section 9 item 1; EV-C02-013 22 (1)) =====
-- A Decision of class batu, opened with devos_calisma and answered at owner level (C02 has no answering function;
-- B:390), as T-W07-N29's own fixtures make it (pg_temp.w07_decision and w07_answered of job/w07_n29_impact_class.sql).
-- Its answered_at is then set at owner level as the case needs: 'now' keeps now(), the time every revision written in
-- this transaction carries; 'before' is one hour earlier; 'after' one minute later; 'null' clears it. answered_at is
-- written only by transfer_decision and, from C06, by the decision channel's intake (EV-C02-013 22 (1)), so an
-- owner-level plant is the only way to place it inside a rolled-back test.
create function pg_temp.n29w_args(p_i int) returns jsonb language sql as $f$
  select jsonb_build_object('class', 'batu', 'question', 'SYNTHETIC W-C02-07 w07_fixture N29-w ' || p_i || ': widen the w07_fixture Mission?',
    'why_this_owner', 'SYNTHETIC W-C02-07 w07_fixture: a Mission is widened only by a decision of Batu''s (B 3.1)',
    'options', jsonb_build_array(
      jsonb_build_object('description', 'w07_fixture widen', 'purpose', 'scope', 'benefit', 'more', 'cost', 'low', 'risk', 'low'),
      jsonb_build_object('description', 'w07_fixture keep', 'purpose', 'scope', 'benefit', 'none', 'cost', 'none', 'risk', 'low')),
    'alternatives_considered', jsonb_build_array('w07_fixture widen', 'w07_fixture keep'), 'alternatives_state', 'compared',
    'criteria', jsonb_build_array('SYNTHETIC W-C02-07 w07_fixture: scope'), 'evidence_refs', jsonb_build_array('w07_fixture_evidence_w' || p_i),
    'assumptions', jsonb_build_array('SYNTHETIC W-C02-07 w07_fixture: none'), 'premises', jsonb_build_array('SYNTHETIC W-C02-07 w07_fixture: one Mission'),
    'reversibility', 'SYNTHETIC W-C02-07 w07_fixture: reversible by a narrowing',
    'reopen_triggers', jsonb_build_array('SYNTHETIC W-C02-07 w07_fixture: a new goal'),
    'recommendation', 'w07_fixture widen', 'recommendation_rationale', 'SYNTHETIC W-C02-07 w07_fixture: the test needs it',
    'status', 'open', 'presented_text_tr', 'SENTETIK W-C02-07 deneme metni w' || p_i)
$f$;
create function pg_temp.n29w_decision(p_at text) returns text language plpgsql as $f$
declare r jsonb; d text; e text;
begin
  r := pg_temp.w07_call('devos_calisma', 'open_decision', pg_temp.n29w_args(nextval('w07_seq')::int));
  if pg_temp.w07_kind(r) <> 'accepted' then
    raise exception using errcode = 'P0W07', message = 'fixture batu Decision refused: ' || pg_temp.w07_brief(r); end if;
  d := r->>'id';
  e := pg_temp.w07_set_status(d, 'answered', pg_temp.w07_rev(d));
  if e is not null then raise exception using errcode = 'P0W07', message = 'fixture answer refused: ' || e; end if;
  execute format('update devos_private.decision set answered_at = %s where id::text = %L',
    case p_at when 'now' then 'now()' when 'before' then 'now() - interval ''1 hour''' when 'after' then 'now() + interval ''1 minute'''
              when 'null' then 'null' end, d);
  return d;
end $f$;

-- One revise_mission call with the devos_kurulum token (the only class that revises a Mission until C06), naming
-- p_dec as owner_authority (answered revision 1) and sending the current purpose and acceptance, so that the scope is
-- the one thing that changes. Observed inside a subtransaction that is undone after the call unless p_keep, then
-- judged: a refusal must carry p_why's reason code and fragment, add no Mission revision and leave the current scope;
-- an acceptance must add exactly one Mission revision with the scope sent.
create function pg_temp.n29w_case(p_case text, p_mid text, p_dec text, p_scope text, p_want text, p_why text[],
                                  p_keep boolean default false) returns void language plpgsql as $f$
declare row jsonb; r jsonb; n0 bigint; n1 bigint; sc1 text; k text; ok boolean;
begin
  begin
    execute 'select to_jsonb(x) from devos_private.mission_current x where x.id::text = $1' into row using p_mid;
    n0 := pg_temp.w07_count('mission_revision');
    r := pg_temp.w07_call('devos_kurulum', 'revise_mission', jsonb_build_object('id', p_mid,
      'base_revision', (row->>'revision')::int, 'mission_ref', p_mid, 'purpose', row->>'purpose',
      'acceptance', row->>'acceptance', 'status', 'active', 'scope', p_scope,
      'owner_authority', p_dec, 'owner_authority_revision', 1,
      'reason', 'w07_fixture SYNTHETIC W-C02-07 ' || p_case));
    n1 := pg_temp.w07_count('mission_revision');
    execute 'select x.scope from devos_private.mission_current x where x.id::text = $1' into sc1 using p_mid;
    if not p_keep then raise exception using errcode = 'P0W07', message = 'w07: undo the case'; end if;
  exception when sqlstate 'P0W07' then null;
  end;
  k := pg_temp.w07_kind(r);
  if k = 'test_cnc' then perform pg_temp.w07_put(p_case, 'could_not_check', r->>'w07_cnc'); return; end if;
  if k = 'unknown' then
    perform pg_temp.w07_put(p_case, 'could_not_check', 'revise_mission: not an answer of interface v1: ' || pg_temp.w07_brief(r));
    return;
  end if;
  if p_want = 'accepted' then
    ok := k = 'accepted' and n1 = n0 + 1 and sc1 = p_scope;
  else
    ok := k = p_want and pg_temp.w07_match(r, p_why) and n1 = n0 and sc1 = row->>'scope';
  end if;
  perform pg_temp.w07_rec(p_case, ok, format('revise_mission from scope %s to %s: wanted %s%s; got %s; Mission revisions %s -> %s; current scope %s',
    row->>'scope', p_scope, p_want, coalesce(' naming ' || array_to_string(p_why, ' and '), ''), pg_temp.w07_brief(r), n0, n1, coalesce(sc1, 'unreadable')));
end $f$;

create function pg_temp.n29w() returns void language plpgsql as $f$
declare d1 text; d2 text; r jsonb; mid text; s text := 'synthetic.w07_fixture_w' || nextval('w07_seq'); c text;
        rests text[] := array['mission_authority', 'rests on']; before text[] := array['mission_authority', 'answered before'];
begin
  d1 := pg_temp.n29w_decision('now');
  r := pg_temp.w07_call('devos_kurulum', 'open_mission', jsonb_build_object('owner_authority', d1, 'owner_authority_revision', 1,
    'scope', s || '.a.b', 'purpose', 'Synthetic test fixture (plan Section 8 item 13): W-C02-07 N29-w; not work',
    'acceptance', 'SYNTHETIC W-C02-07', 'status', 'active'));
  if pg_temp.w07_kind(r) <> 'accepted' then
    foreach c in array array['N29-w-same', 'N29-w-pos-equal', 'N29-w-earlier', 'N29-w-current', 'N29-w-before', 'N29-w-null',
                             'N29-w-pos-after', 'N29-w-pos-narrow'] loop
      perform pg_temp.w07_put(c, 'could_not_check', 'the fixture Mission could not be opened: ' || pg_temp.w07_brief(r));
    end loop;
    return;
  end if;
  mid := r->>'id';
  -- Revision 1 rests on d1. (1) The current owner authority again: refused by condition 1, nothing written.
  perform pg_temp.n29w_case('N29-w-same', mid, d1, s || '.a', 'refused', rests);
  -- The equal case, kept: a fresh Decision answered at the time revision 1 was written (equal passes). Revision 2
  -- rests on d2; d1 is now an earlier owner authority.
  d2 := pg_temp.n29w_decision('now');
  perform pg_temp.n29w_case('N29-w-pos-equal', mid, d2, s || '.a', 'accepted', null, true);
  if not exists (select 1 from w07_results where case_id = 'N29-w-pos-equal' and outcome = 'ok') then
    foreach c in array array['N29-w-earlier', 'N29-w-current', 'N29-w-before', 'N29-w-null', 'N29-w-pos-after', 'N29-w-pos-narrow'] loop
      perform pg_temp.w07_put(c, 'could_not_check', 'no second Mission revision: N29-w-pos-equal was not accepted');
    end loop;
    return;
  end if;
  -- (2) An earlier owner authority (revision 1's), answered at the time revision 2 was written, so only condition 1
  -- can refuse it.
  perform pg_temp.n29w_case('N29-w-earlier', mid, d1, s, 'refused', rests);
  -- The current owner authority after a widening (revision 2's).
  perform pg_temp.n29w_case('N29-w-current', mid, d2, s, 'refused', rests);
  -- (3) A fresh batu Decision answered before the current revision: refused by condition 2.
  perform pg_temp.n29w_case('N29-w-before', mid, pg_temp.n29w_decision('before'), s, 'refused', before);
  -- (5) A fresh batu Decision whose answered_at is NULL: could_not_check (EV-C02-013 section 1 item 7 (ii)).
  perform pg_temp.n29w_case('N29-w-null', mid, pg_temp.n29w_decision('null'), s, 'could_not_check', array['answered_at']);
  -- (4) A fresh batu Decision answered after the current revision: accepted.
  perform pg_temp.n29w_case('N29-w-pos-after', mid, pg_temp.n29w_decision('after'), s, 'accepted', null);
  -- A narrowing that names the current owner authority keeps today's checks: accepted (it differs from N29-w-current
  -- only in that the new scope lies within the current one).
  perform pg_temp.n29w_case('N29-w-pos-narrow', mid, d2, s || '.a.c', 'accepted', null);
end $f$;

do $$
declare why text;
begin
  why := pg_temp.w07_pre(string_to_array('open_decision,open_mission,revise_mission', ','),
                         string_to_array('decision,decision_revision,mission,mission_revision,mission_current', ','));
  if why is null and not exists (select 1 from information_schema.columns where table_schema = 'devos_private'
                                  and table_name = 'decision' and column_name = 'answered_at') then
    why := 'devos_private.decision has no column answered_at';
  end if;
  if why is not null then
    perform pg_temp.w07_put('N29-w-pre', 'could_not_check', why);
    return;
  end if;
  perform pg_temp.w07_run('N29-w', $q$select pg_temp.n29w()$q$);
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_N29_MISSION_WIDENING FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_N29_MISSION_WIDENING COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_N29_MISSION_WIDENING PASS (%/%)', n, n;
end $$;

rollback;
