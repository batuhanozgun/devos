-- Synthetic test data (plan Section 8 item 13): every record, event, run, path and source ID below is made up inside
-- this transaction (text 'w14_fixture SYNTHETIC W-C02-14', source IDs 'w14_fixture_<run tag>_*', commit and hash strings
-- made at run time from md5 of fixed synthetic words, random uuids) and holds no personal or business data and no
-- credential. Tokens are issued at run time inside this rolled-back transaction, kept in a PL/pgSQL variable only, and
-- never stored, printed, compared or put in an error text (W-C02-07's README section 6). Nothing is committed.
--
-- Claim: the ledger transfer's functions (EV-C02-005 section 15 S5; section 12; Appendix B section 4's row "Ledger
-- transfer") admit only devos_kurulum; after the ledger_handed_over event every one but transfer_review,
-- transfer_acceptance, transfer_artifact (for a verdict file) and record_ledger_entry refuses; each write and its
-- transferred event are one transaction (no record without its mark, no mark without its record); a source already
-- written with the same hash writes nothing, and with another hash is refused; and transfer_acceptance refuses a Review
-- copy that is missing, failed, or conditional with no ledger entry, and on an accepted call sets the target accepted.
-- Specification: tests/C02/W-C02-14/T-W14-FN_transfer_functions.md. Serves W-C02-09 point 10 (N-277).
-- Runs: in devos-test by the migration job's test step as postgres, once W-C02-09's pull request copies this file byte
-- for byte to supabase/migrations/tests/w14_fn_transfer_functions.sql; with its breaks (tests/C02/W-C02-14/breaks/
-- B-FN-*) on W-C02-07's throwaway database (tests/C02/W-C02-07/README.md section 5.2). Transport sql-set-role: each
-- call runs as anon with the token header simulated by set_config('request.headers', ..., true); session_user stays
-- postgres.
-- Interface assumed: the specification's "Interface assumed" (W-C02-07's README 8.1, its chosen keys for four of the
-- fourteen functions; the other ten's payloads are not named, and the cases that need an accepted call of one of them
-- give could_not_check).
-- Safety: no psql meta-command and no backslash; owner-level states (a planted hand-over, a trigger that raises) are
-- made inside subtransactions that are undone; stops at its first error; one row per case, then PASS, FAIL or COULD NOT
-- CHECK (FAIL and COULD NOT CHECK raise).
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '120s';

-- Results (W-C02-07's README section 3; helpers copied from tests/C02/W-C02-14/job/w14_sch_transfer_schema.sql).
create temp table w14_results (case_id text primary key,
  outcome text not null check (outcome in ('ok', 'bad', 'could_not_check')), detail text not null);
create temp table w14_ctx (tag text not null);
insert into w14_ctx select 'w14_fixture_' || left(md5(random()::text), 8);

create function pg_temp.w14_rec(p_id text, p_outcome text, p_detail text) returns void language sql as $f$
  insert into w14_results values (p_id, p_outcome, left(replace(coalesce(p_detail, ''), chr(10), ' '), 600))
  on conflict (case_id) do update set
    outcome = case when w14_results.outcome = 'bad' or excluded.outcome = 'bad' then 'bad'
                   when w14_results.outcome = 'could_not_check' or excluded.outcome = 'could_not_check'
                   then 'could_not_check' else 'ok' end,
    detail = left(w14_results.detail || ' | ' || excluded.detail, 1200)
$f$;
-- ok when p_cond is true, bad when false, could_not_check when null.
create function pg_temp.w14_check(p_id text, p_cond boolean, p_detail text) returns void language sql as $f$
  select pg_temp.w14_rec(p_id, case when p_cond then 'ok' when not p_cond then 'bad' else 'could_not_check' end, p_detail)
$f$;
create function pg_temp.w14_tag() returns text language sql as $f$ select tag from w14_ctx limit 1 $f$;
create function pg_temp.w14_hex(p_seed text, p_len int) returns text language sql as $f$
  select left(md5(p_seed || ':a') || md5(p_seed || ':b'), p_len)
$f$;

-- The fourteen functions (B section 4's row; EV-C02-005 section 12), and the two sets section 12 gives after the
-- ledger_handed_over event.
create function pg_temp.w14_fns() returns text[] language sql immutable as $f$
  select array['begin_transfer_run', 'transfer_mission', 'transfer_work', 'transfer_relation', 'transfer_decision',
               'transfer_review', 'transfer_acceptance', 'transfer_need', 'transfer_finding', 'transfer_artifact',
               'transfer_event', 'end_transfer_run', 'record_handover', 'record_ledger_entry']
$f$;
create function pg_temp.w14_closing() returns text[] language sql immutable as $f$
  select array['begin_transfer_run', 'transfer_mission', 'transfer_work', 'transfer_relation', 'transfer_decision',
               'transfer_need', 'transfer_finding', 'transfer_event', 'end_transfer_run', 'record_handover']
$f$;
-- The token refusals' reason codes (README 8.1, fixed) and the gate's (chosen).
create function pg_temp.w14_gate_codes() returns text[] language sql immutable as $f$
  select array['missing', 'empty', 'malformed', 'unknown', 'revoked', 'header_unreadable', 'role_class_not_permitted']
$f$;

-- One call as a role class (README 5.1 (a)); p_class null: no token at all. A raised error is kept, the token scrubbed.
create function pg_temp.w14_call(p_class text, p_fn text, p jsonb) returns jsonb language plpgsql as $f$
declare tok text; r jsonb; st text; msg text;
begin
  if p_class is null then
    perform set_config('request.headers', '{}', true);
  else
    begin
      execute 'select devos_private.issue_env_token($1)::text' into tok using p_class;
      if left(tok, 1) = '{' then tok := (tok::jsonb) ->> 'token'; end if;
    exception when others then
      return jsonb_build_object('w14_cnc', 'a synthetic token of class ' || p_class || ' could not be issued: ' || sqlstate);
    end;
    perform set_config('request.headers', json_build_object('x-devos-env-token', tok)::text, true);
  end if;
  begin
    execute 'set local role anon';
    execute format('select devos_api.%I($1)', p_fn) into r using p;
    execute 'reset role';
  exception when others then
    get stacked diagnostics st = returned_sqlstate, msg = message_text;
    execute 'reset role';
    r := jsonb_build_object('raised', true, 'sqlstate', st,
                            'message', left(replace(msg, coalesce(tok, chr(1)), '[w14: presented value]'), 160));
  end;
  tok := null;
  perform set_config('request.headers', '{}', true);
  return coalesce(r, '{"status": "absent"}'::jsonb);
end $f$;

-- accepted | refused | could_not_check (the check's own answer) | raised | unknown | test (the test's own failure).
create function pg_temp.w14_kind(r jsonb) returns text language sql immutable as $f$
  select case when r ? 'w14_cnc' then 'test' when r ? 'raised' then 'raised'
              when r ->> 'status' = 'refused' and r ->> 'reason_code' = 'could_not_check' then 'could_not_check'
              when r ->> 'status' = 'refused' then 'refused' when r ->> 'status' = 'ok' then 'accepted' else 'unknown' end
$f$;
create function pg_temp.w14_brief(r jsonb) returns text language sql immutable as $f$
  select pg_temp.w14_kind(r) || coalesce(' [' || nullif(concat_ws(' ', r ->> 'reason_code', r ->> 'reason',
         r ->> 'sqlstate', r ->> 'message', r ->> 'w14_cnc'), '') || ']', '')
$f$;
-- The id an accepted call returns (README 8.1: "A call that writes a record carries its id").
create function pg_temp.w14_id(r jsonb) returns text language sql immutable as $f$
  select coalesce(r ->> 'id', r ->> 'review_id', r ->> 'acceptance_id', r ->> 'decision_id')
$f$;

-- Row counts of the tables the fourteen can write (those that exist), env_tokens excepted (issuing a token adds one).
create function pg_temp.w14_counts() returns jsonb language plpgsql as $f$
declare t text; n bigint; j jsonb := '{}';
begin
  foreach t in array array['event', 'rejected_attempt', 'mission', 'mission_revision', 'work', 'work_revision',
    'relation', 'decision', 'decision_revision', 'review', 'verdict', 'acceptance', 'need', 'finding', 'finding_revision',
    'artifact', 'artifact_revision', 'effort_policy', 'global_authority_epoch'] loop
    if to_regclass('devos_private.' || t) is not null then
      execute format('select count(*) from devos_private.%I', t) into n;
      j := j || jsonb_build_object(t, n);
    end if;
  end loop;
  return j;
end $f$;
-- The tables whose count differs between two snapshots, p_except left out.
create function pg_temp.w14_changed(a jsonb, b jsonb, p_except text[] default '{}') returns text[] language sql as $f$
  select coalesce(array_agg(k order by k), '{}') from jsonb_object_keys(a) k
   where not k = any(p_except) and a -> k is distinct from b -> k
$f$;
create function pg_temp.w14_delta(a jsonb, b jsonb, t text) returns bigint language sql as $f$
  select (b ->> t)::bigint - (a ->> t)::bigint
$f$;
-- The transferred events of one source ID, any kind (S2's key; the kind is the build's to spell).
create function pg_temp.w14_marks(p_sid text) returns bigint language plpgsql as $f$
declare n bigint;
begin
  execute 'select count(*) from devos_private.event e where e.event_type::text = ''transferred''
             and e.payload -> ''transfer_source'' ->> ''source_id'' = $1' into n using p_sid;
  return n;
end $f$;

-- Plants one row as the owner (copied from w14_sch_transfer_schema.sql's w14_plant, which is Group B's w07_plant with
-- its IN-list rule); used only for the Work a Review and an Acceptance copy name.
create function pg_temp.w14_listed(p_table text, p_col text) returns text[] language sql as $f$
  select coalesce(array_agg(m[1] order by con.conname, ord), '{}')
    from pg_constraint con
    join pg_attribute att on att.attrelid = con.conrelid and att.attname = p_col
    cross join lateral regexp_matches(pg_get_constraintdef(con.oid), '''([a-z][a-z0-9_]*)''', 'g') with ordinality r(m, ord)
   where con.conrelid = to_regclass('devos_private.' || p_table) and con.contype = 'c'
     and con.conkey = array[att.attnum]
     and pg_get_constraintdef(con.oid) like '%= ANY (ARRAY[%'
     and pg_get_constraintdef(con.oid) not like '%<>%' and upper(pg_get_constraintdef(con.oid)) not like '%NOT %'
$f$;
create function pg_temp.w14_plant(p_table text, p_vals jsonb default '{}', p_depth int default 0)
returns jsonb language plpgsql as $f$
declare rel regclass := to_regclass(p_table); a record; j jsonb := coalesce(p_vals, '{}'); fk record;
        parent jsonb; cols text; r jsonb; listed text[];
begin
  if rel is null then raise exception 'w14 plant: % does not exist', p_table; end if;
  for a in select att.attname, att.attnum, att.atttypid, t.typtype, t.typcategory, t.typname
             from pg_attribute att join pg_type t on t.oid = att.atttypid
            where att.attrelid = rel and att.attnum > 0 and not att.attisdropped and att.attnotnull
              and not att.atthasdef and att.attidentity = '' and att.attgenerated = '' order by att.attnum loop
    continue when j ? a.attname;
    select con.confrelid::regclass::text as ptab,
           (select pa.attname from pg_attribute pa where pa.attrelid = con.confrelid and pa.attnum = con.confkey[1]) as pcol
      into fk from pg_constraint con
     where con.conrelid = rel and con.contype = 'f' and con.conkey = array[a.attnum]::smallint[] limit 1;
    if fk.ptab is not null then
      if p_depth >= 4 then raise exception 'w14 plant: foreign keys nest deeper than 4 from %', p_table; end if;
      parent := pg_temp.w14_plant(fk.ptab, '{}', p_depth + 1);
      j := j || jsonb_build_object(a.attname, parent -> fk.pcol);
      continue;
    end if;
    listed := '{}';
    if a.typname in ('text', 'varchar', 'bpchar', 'name', 'citext') then
      listed := pg_temp.w14_listed(replace(rel::text, 'devos_private.', ''), a.attname);
    end if;
    j := j || jsonb_build_object(a.attname, case
      when a.typtype = 'e' then to_jsonb((select e.enumlabel from pg_enum e where e.enumtypid = a.atttypid
                                          order by e.enumsortorder limit 1))
      when a.typname = 'uuid' then to_jsonb(gen_random_uuid())
      when a.typname in ('text', 'varchar', 'bpchar', 'name', 'citext') then
        to_jsonb(case when a.attname like '%scope%' then 'synthetic.w14fixture'
                      when cardinality(listed) > 0 then listed[1]
                      else 'w14_fixture SYNTHETIC W-C02-14' end)
      when a.typcategory = 'N' then to_jsonb(1)
      when a.typname = 'bool' then to_jsonb(false)
      when a.typname in ('timestamptz', 'timestamp') then to_jsonb(now())
      when a.typname = 'date' then to_jsonb(current_date)
      when a.typname in ('json', 'jsonb') then case when a.attname ~ '(s|refs|spans)$' then '[]'::jsonb else '{}'::jsonb end
      when a.typcategory = 'A' then '[]'::jsonb
      else null end);
    if j -> a.attname is null or jsonb_typeof(j -> a.attname) = 'null' then
      raise exception 'w14 plant: no synthetic value for %.% of type %', p_table, a.attname, a.typname;
    end if;
  end loop;
  select string_agg(quote_ident(x), ', ') into cols from jsonb_object_keys(j) x;
  if cols is null then
    execute format('insert into %s as w14_x default values returning to_jsonb(w14_x)', rel) into r;
    return r;
  end if;
  execute format('insert into %s as w14_x (%s) select %s from jsonb_populate_record(null::%s, $1) returning to_jsonb(w14_x)',
                 rel, cols, cols, rel) using j into r;
  return r;
end $f$;
-- A synthetic work item (its first revision under a planted Mission revision); returns its id.
create function pg_temp.w14_work() returns text language sql as $f$
  select pg_temp.w14_plant('devos_private.work_revision', jsonb_build_object('purpose',
         'w14_fixture SYNTHETIC W-C02-14 target of a verdict copy')) ->> 'work_id'
$f$;
create function pg_temp.w14_work_acceptance(p_id text) returns text language plpgsql as $f$
declare s text;
begin
  execute 'select to_jsonb(w) ->> ''acceptance'' from devos_private.work w where w.id::text = $1' into s using p_id;
  return coalesce(s, 'absent');
end $f$;

-- S1's transfer_source (EV-C02-005 section 15), as W-C02-07's N02 and N04 send it.
create function pg_temp.w14_src(p_kind text, p_sid text, p_text text default 'one') returns jsonb language sql as $f$
  select jsonb_build_object('kind', p_kind, 'source_id', p_sid, 'path', 'w14_fixture/' || p_sid || '.md',
    'input_commit', pg_temp.w14_hex('w14 input commit', 40), 'last_commit', pg_temp.w14_hex('w14 last commit ' || p_sid, 40),
    'sha256', pg_temp.w14_hex('w14 text ' || p_sid || ' ' || p_text, 64))
$f$;

-- The recipes: one accepted call per function, with the payload keys W-C02-07's README 8.1 chooses for four of the
-- fourteen (begin_transfer_run, transfer_decision, transfer_review, transfer_acceptance; "The payload keys T-W07-N02 and
-- T-W07-N04 send, each chosen"). For the other ten no source names the keys (EV-C02-005 section 12 names the functions
-- only), so their recipe is null and every case that needs an accepted call of one gives could_not_check, never a pass.
-- The test designer fills each once W-C02-09's record names its payload, before the first result (README section 8).
-- p_o: the call's own values (run_id, source ID, text, target, review, verdict result, current_evidence).
create function pg_temp.w14_recipe(p_fn text, p_o jsonb) returns jsonb language plpgsql as $f$
declare sid text := coalesce(p_o ->> 'sid', pg_temp.w14_tag() || '_' || p_fn); txt text := coalesce(p_o ->> 'text', 'one');
begin
  if p_fn = 'begin_transfer_run' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'input_commit', pg_temp.w14_hex('w14 input commit', 40),
      'manifest_sha256', pg_temp.w14_hex('w14 manifest ' || (p_o ->> 'run'), 64), 'counts', '{}'::jsonb,
      'phase', 'begun', 'mode', coalesce(p_o ->> 'mode', 'ahead'));
  elsif p_fn = 'transfer_decision' then
    return jsonb_build_object('class', 'high_impact', 'question', 'w14_fixture SYNTHETIC W-C02-14 decision ' || sid,
      'why_this_owner', 'w14_fixture SYNTHETIC W-C02-14: a rule of the fixture schema',
      'options', '[]'::jsonb, 'alternatives_considered', '[]'::jsonb, 'alternatives_state', 'compared',
      'criteria', '[]'::jsonb, 'evidence_refs', '[]'::jsonb, 'assumptions', '[]'::jsonb, 'premises', '[]'::jsonb,
      'reversibility', null, 'reopen_triggers', '[]'::jsonb, 'recommendation', null, 'recommendation_rationale', null,
      'status', 'answered', 'run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('decision', sid, txt));
  elsif p_fn = 'transfer_review' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'kind', 'review',
      'claim', 'w14_fixture SYNTHETIC W-C02-14 installation verdict copy ' || sid, 'target_ref', p_o ->> 'target',
      'criterion', 'w14_fixture/plan/work/W-W14-FIXTURE.md', 'basis_refs', jsonb_build_array('w14_fixture_tree'),
      'reviewer_declared_session', 'w14_fixture_checker_run SYNTHETIC W-C02-14', 'independence_level', 'fresh_context_subagent',
      'use', 'installation_acceptance', 'verdict', jsonb_build_object('result', coalesce(p_o ->> 'result', 'pass'),
      'objections', '[]'::jsonb, 'evidence_refs', '[]'::jsonb, 'limits', '[]'::jsonb),
      'transfer_source', pg_temp.w14_src('verdict', sid, txt));
  elsif p_fn = 'transfer_acceptance' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'target_ref', p_o ->> 'target', 'review_ref', p_o ->> 'review',
      'accepted_use', 'installation_acceptance', 'scope', 'installation',
      'current_evidence', coalesce(p_o -> 'evidence', jsonb_build_array(p_o ->> 'review')),
      'transfer_source', pg_temp.w14_src('acceptance', sid, txt));
  end if;
  return null;
end $f$;

-- A run begun with devos_kurulum (the transfer's records belong to an open run, EV-C02-005 section 12); returns its id,
-- or null when begin_transfer_run does not accept its recipe.
create function pg_temp.w14_begin(p_run text) returns text language plpgsql as $f$
declare r jsonb;
begin
  r := pg_temp.w14_call('devos_kurulum', 'begin_transfer_run', pg_temp.w14_recipe('begin_transfer_run', jsonb_build_object('run', p_run)));
  if pg_temp.w14_kind(r) = 'accepted' then return p_run; end if;
  return null;
end $f$;

-- The hand-over planted as the owner (S1: at most one ledger_handed_over event, on the installation's Mission).
create function pg_temp.w14_handover() returns void language plpgsql as $f$
begin
  insert into devos_private.event (aggregate_type, aggregate_id, event_type, payload, role_class, origin)
  values ('mission', gen_random_uuid(), 'ledger_handed_over', jsonb_build_object('run_id', pg_temp.w14_tag() || '_run_handover',
          'input_commit', pg_temp.w14_hex('w14 input commit', 40), 'mark_commit', pg_temp.w14_hex('w14 mark commit', 40),
          'handed_over_sha256', pg_temp.w14_hex('w14 handed over list', 64), 'w14_fixture', 'SYNTHETIC W-C02-14'), 'owner', 'owner');
end $f$;
create function pg_temp.w14_handovers() returns bigint language plpgsql as $f$
declare n bigint;
begin execute 'select count(*) from devos_private.event e where e.event_type::text = ''ledger_handed_over''' into n; return n; end $f$;

-- A trigger function that raises: planted on a table inside an undone block, so that a write of the function under test
-- fails part-way (W-C02-09 point 5: "An error raised mid-transaction leaves no half state and no orphan event").
create function pg_temp.w14_boom() returns trigger language plpgsql as $f$
begin
  raise exception using errcode = 'P0W15', message = 'w14: planted failure of one write';
end $f$;

create function pg_temp.w14_pre() returns text language plpgsql as $f$
declare t text;
begin
  if to_regprocedure('devos_private.issue_env_token(text)') is null then return 'devos_private.issue_env_token(text) does not exist'; end if;
  foreach t in array array['event', 'rejected_attempt', 'review', 'verdict', 'acceptance', 'work', 'work_revision', 'decision'] loop
    if to_regclass('devos_private.' || t) is null then return 'devos_private.' || t || ' does not exist'; end if;
  end loop;
  if not exists (select 1 from pg_roles where rolname = 'anon') then return 'role anon does not exist'; end if;
  if not exists (select 1 from unnest(pg_temp.w14_fns()) f where to_regprocedure('devos_api.' || f || '(jsonb)') is not null) then
    return 'no function of the ledger transfer''s group exists in devos_api (W-C02-09 builds them; EV-C02-005 S5)';
  end if;
  return null;
end $f$;

do $$
declare why text; f text; c text; r jsonb; r2 jsonb; k text; s0 jsonb; s1 jsonb; acc jsonb; ok boolean; det text;
        run text; tag text := pg_temp.w14_tag(); rcp jsonb; pre text; w text; rv text; rv2 text; sid text; ch text[];
        miss text[]; n0 bigint; n1 bigint; i int; res jsonb;
begin
  why := pg_temp.w14_pre();
  if why is not null then
    perform pg_temp.w14_rec('FN-pre', 'could_not_check', why);
    return;
  end if;

  -- FN-M-cat: the fourteen are devos_api functions of one jsonb parameter, with definer rights and a fixed search_path
  -- (W-C02-09 point 2; README 8.1). A missing one is a FAIL here, not a could not check.
  select coalesce(array_agg(x), '{}') into miss from unnest(pg_temp.w14_fns()) x
   where not exists (select 1 from pg_proc p where p.oid = to_regprocedure('devos_api.' || x || '(jsonb)') and p.prosecdef
                       and exists (select 1 from unnest(coalesce(p.proconfig, '{}')) g where g like 'search_path=%'));
  perform pg_temp.w14_check('FN-M-cat', cardinality(miss) = 0,
    case when cardinality(miss) = 0 then 'all fourteen are devos_api.<name>(jsonb), security definer, with a fixed search_path'
         else 'absent, not security definer, or without a fixed search_path: ' || array_to_string(miss, ', ') end);

  -- FN-G-<fn>: the gate. With each other role class's token and with none, refused for the class (or the token), and
  -- nothing written but RejectedAttempt rows, one per call with a verified token (B 3.13; DM-19). FN-G-pos-<fn>: the
  -- same function with devos_kurulum and the same input is not refused for the class or the token: the one thing the
  -- gate tests differs. Each function's calls are undone.
  foreach f in array pg_temp.w14_fns() loop
    if to_regprocedure('devos_api.' || f || '(jsonb)') is null then
      perform pg_temp.w14_rec(cid, 'could_not_check', 'devos_api.' || f || '(jsonb) does not exist (FN-M-cat fails)')
        from unnest(array['FN-G-' || f, 'FN-G-pos-' || f]) cid;
      continue;
    end if;
    acc := '[]';
    begin
      s0 := pg_temp.w14_counts(); ok := true; det := '';
      foreach c in array array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_ci', 'devos_backup', 'none'] loop
        r := pg_temp.w14_call(case when c = 'none' then null else c end, f, '{}'::jsonb);
        k := pg_temp.w14_kind(r);
        if k in ('test', 'raised', 'unknown') then ok := null;
        elsif ok is not null and not (k = 'refused' and r ->> 'reason_code' = case when c = 'none' then 'missing' else 'role_class_not_permitted' end) then
          ok := false;
        end if;
        det := det || c || ': ' || pg_temp.w14_brief(r) || '; ';
      end loop;
      s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
      if ok is not null and (cardinality(ch) > 0 or pg_temp.w14_delta(s0, s1, 'rejected_attempt') < 5) then ok := false; end if;
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-G-' || f, 'cond', ok, 'detail', det || format(
        'tables changed besides rejected_attempt: %s; rejected_attempt rows +%s (wanted none, and at least 5)',
        coalesce(nullif(array_to_string(ch, ', '), ''), 'none'), pg_temp.w14_delta(s0, s1, 'rejected_attempt'))));
      r := pg_temp.w14_call('devos_kurulum', f, '{}'::jsonb); k := pg_temp.w14_kind(r);
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-G-pos-' || f,
        'cond', case when k in ('test', 'raised', 'unknown') then null
                     else not (k = 'refused' and r ->> 'reason_code' = any(pg_temp.w14_gate_codes())) end,
        'detail', 'devos_kurulum, the same input: ' || pg_temp.w14_brief(r) || ' (wanted no refusal for the class or the token)'));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-G-' || f, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

  if pg_temp.w14_handovers() > 0 then
    perform pg_temp.w14_rec(y.cid, 'could_not_check', 'a ledger_handed_over event is already in this database, so the state '
      || 'before the hand-over cannot be planted') from (select 'FN-C-' || x as cid from unnest(pg_temp.w14_closing()) x) y;
  end if;

  -- FN-C-<fn>: after the hand-over, each of the ten refuses with devos_kurulum and writes nothing but RejectedAttempt
  -- (EV-C02-005 section 12; B section 4). Its control is the same call before the hand-over, accepted.
  foreach f in array pg_temp.w14_closing() loop
    exit when pg_temp.w14_handovers() > 0;
    rcp := pg_temp.w14_recipe(f, jsonb_build_object('run', tag || '_run_c_' || f));
    if rcp is null then
      perform pg_temp.w14_rec('FN-C-' || f, 'could_not_check', f || ': no source names its payload keys (EV-C02-005 section '
        || '12 names the functions only), so no accepted call can be formed; the test designer fills its recipe from '
        || 'W-C02-09''s record before the first result (README section 8; as T-W07-F06''s G20)');
      continue;
    end if;
    acc := '[]';
    begin
      run := tag || '_run_c_' || f;
      if f <> 'begin_transfer_run' then run := pg_temp.w14_begin(run); end if;
      if run is null then
        pre := 'begin_transfer_run did not accept its recipe, so no run is open';
      else
        r := pg_temp.w14_call('devos_kurulum', f, rcp); pre := pg_temp.w14_brief(r);
        if pg_temp.w14_kind(r) = 'accepted' then pre := null; end if;
      end if;
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when others then pre := 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160);
    end;
    if pre is not null then
      perform pg_temp.w14_rec('FN-C-' || f, 'could_not_check', 'the control (the same call before the hand-over) was not '
        || 'accepted with the chosen keys: ' || pre);
      continue;
    end if;
    begin
      run := tag || '_run_c_' || f;
      if f <> 'begin_transfer_run' then run := pg_temp.w14_begin(run); end if;
      perform pg_temp.w14_handover();
      s0 := pg_temp.w14_counts();
      r := pg_temp.w14_call('devos_kurulum', f, rcp); k := pg_temp.w14_kind(r);
      s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-C-' || f,
        'cond', case when k in ('test', 'raised', 'unknown') then null else k = 'refused' and cardinality(ch) = 0 end,
        'detail', format('after the ledger_handed_over event: %s; tables changed besides rejected_attempt: %s (wanted '
          || 'refused, none); before it the same call was accepted', pg_temp.w14_brief(r),
          coalesce(nullif(array_to_string(ch, ', '), ''), 'none'))));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-C-' || f, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

  -- FN-O-<fn>: after the hand-over, transfer_review and transfer_acceptance still write a verdict copy (section 12).
  -- transfer_artifact (for a verdict file, and refused for another file) and record_ledger_entry: no recipe.
  perform pg_temp.w14_rec(cid, 'could_not_check', 'no source names its payload keys (EV-C02-005 section 12), so no call of it '
    || 'can be formed; the test designer fills its recipe from W-C02-09''s record before the first result')
    from unnest(array['FN-O-transfer_artifact', 'FN-O-transfer_artifact-other', 'FN-O-record_ledger_entry']) cid;
  acc := '[]';
  begin
    if pg_temp.w14_handovers() > 0 then raise exception using errcode = 'P0W16', message = 'a ledger_handed_over event is already here'; end if;
    run := pg_temp.w14_begin(tag || '_run_o');
    w := pg_temp.w14_work();
    perform pg_temp.w14_handover();
    s0 := pg_temp.w14_counts();
    r := pg_temp.w14_call('devos_kurulum', 'transfer_review', pg_temp.w14_recipe('transfer_review',
           jsonb_build_object('run', run, 'sid', tag || '_CHK-O1', 'target', w)));
    s1 := pg_temp.w14_counts(); rv := pg_temp.w14_id(r);
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_review',
      'cond', case when run is null or pg_temp.w14_kind(r) in ('test', 'raised', 'unknown') then null
                   else pg_temp.w14_kind(r) = 'accepted' and pg_temp.w14_delta(s0, s1, 'review') = 1 and pg_temp.w14_marks(tag || '_CHK-O1') = 1 end,
      'detail', format('after the hand-over (run %s): transfer_review %s; review rows +%s, its transferred events %s (wanted '
        || 'accepted, +1, 1)', coalesce(run, 'not begun'), pg_temp.w14_brief(r), pg_temp.w14_delta(s0, s1, 'review'),
        pg_temp.w14_marks(tag || '_CHK-O1'))));
    s0 := pg_temp.w14_counts();
    r2 := pg_temp.w14_call('devos_kurulum', 'transfer_acceptance', pg_temp.w14_recipe('transfer_acceptance',
           jsonb_build_object('run', run, 'sid', tag || '_ACC-O1', 'target', w, 'review', rv)));
    s1 := pg_temp.w14_counts();
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_acceptance',
      'cond', case when run is null or pg_temp.w14_kind(r) <> 'accepted' or pg_temp.w14_kind(r2) in ('test', 'raised', 'unknown') then null
                   else pg_temp.w14_kind(r2) = 'accepted' and pg_temp.w14_delta(s0, s1, 'acceptance') = 1 end,
      'detail', format('after the hand-over: transfer_acceptance of that copy %s; acceptance rows +%s (wanted accepted, +1)',
        pg_temp.w14_brief(r2), pg_temp.w14_delta(s0, s1, 'acceptance'))));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W16' then
      acc := jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_review', 'cond', null, 'detail', sqlerrm),
                               jsonb_build_object('id', 'FN-O-transfer_acceptance', 'cond', null, 'detail', sqlerrm));
    when others then
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_review', 'cond', null, 'detail',
        'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- FN-T-ev-<fn> (positive controls of the transaction rule and of S1's "role_class from the token"): an accepted write
  -- adds its record and exactly one transferred event, which names the record and carries the transfer_source sent,
  -- role_class devos_kurulum, origin call. FN-T-half-*: the same call with one of its writes made to fail leaves neither
  -- the record nor the mark.
  foreach f in array array['transfer_review', 'transfer_decision'] loop
    acc := '[]';
    begin
      run := pg_temp.w14_begin(tag || '_run_t_' || f); sid := tag || '_T-' || f; w := pg_temp.w14_work();
      rcp := pg_temp.w14_recipe(f, jsonb_build_object('run', run, 'sid', sid, 'target', w));
      s0 := pg_temp.w14_counts();
      r := pg_temp.w14_call('devos_kurulum', f, rcp); s1 := pg_temp.w14_counts(); rv := pg_temp.w14_id(r);
      execute 'select jsonb_agg(jsonb_build_object(''agg'', e.aggregate_id::text, ''rc'', e.role_class::text, ''origin'', e.origin::text,
                 ''src'', e.payload -> ''transfer_source'')) from devos_private.event e where e.event_type::text = ''transferred''
                 and e.payload -> ''transfer_source'' ->> ''source_id'' = $1' into res using sid;
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-T-ev-' || f,
        'cond', case when run is null or pg_temp.w14_kind(r) <> 'accepted' then null
                     else jsonb_array_length(coalesce(res, '[]')) = 1 and res -> 0 ->> 'agg' = rv
                          and res -> 0 ->> 'rc' = 'devos_kurulum' and res -> 0 ->> 'origin' = 'call'
                          and res -> 0 -> 'src' -> 'source_id' = rcp -> 'transfer_source' -> 'source_id'
                          and res -> 0 -> 'src' -> 'sha256' = rcp -> 'transfer_source' -> 'sha256'
                          and pg_temp.w14_delta(s0, s1, case f when 'transfer_review' then 'review' else 'decision' end) = 1 end,
        'detail', format('%s: %s; its transferred events %s (wanted one, naming the record %s, role_class devos_kurulum, origin '
          || 'call, the transfer_source sent); %s rows +%s', f, pg_temp.w14_brief(r), coalesce(jsonb_array_length(res), 0),
          coalesce(rv, 'none'), case f when 'transfer_review' then 'review' else 'decision' end,
          pg_temp.w14_delta(s0, s1, case f when 'transfer_review' then 'review' else 'decision' end))));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-T-ev-' || f, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
    -- The planted failures: the mark's write (a trigger on event for transferred rows), and, for transfer_review, the
    -- Verdict's write (a trigger on verdict), each in its own undone block.
    foreach c in array case f when 'transfer_review' then array['ev', 'rec'] else array['ev'] end loop
      acc := '[]';
      begin
        run := pg_temp.w14_begin(tag || '_run_h_' || f || c); sid := tag || '_H-' || f || '-' || c; w := pg_temp.w14_work();
        rcp := pg_temp.w14_recipe(f, jsonb_build_object('run', run, 'sid', sid, 'target', w));
        if c = 'ev' then
          execute 'create trigger w14_boom before insert on devos_private.event for each row when (new.event_type::text = '
               || '''transferred'') execute function pg_temp.w14_boom()';
        else
          execute 'create trigger w14_boom before insert on devos_private.verdict for each row execute function pg_temp.w14_boom()';
        end if;
        s0 := pg_temp.w14_counts();
        r := pg_temp.w14_call('devos_kurulum', f, rcp); s1 := pg_temp.w14_counts();
        ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
        acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-T-half-' || c || '-' || f,
          'cond', case when run is null then null else pg_temp.w14_kind(r) <> 'accepted' and cardinality(ch) = 0
                       and pg_temp.w14_marks(sid) = 0 end,
          'detail', format('%s with the %s write made to fail: %s; tables changed besides rejected_attempt: %s; its '
            || 'transferred events %s (wanted not accepted, none, 0)', f, case c when 'ev' then 'transferred event''s' else 'Verdict''s' end,
            pg_temp.w14_brief(r), coalesce(nullif(array_to_string(ch, ', '), ''), 'none'), pg_temp.w14_marks(sid))));
        raise exception using errcode = 'P0W14', message = 'w14: undo the block';
      exception
        when sqlstate 'P0W14' then null;
        when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-T-half-' || c || '-' || f, 'cond', null,
          'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
      end;
      perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
    end loop;
  end loop;

  -- FN-I-*: the idempotency key's answers (EV-C02-005 3.1; B 3.13). The same source with the same hash: accepted, the
  -- same id, nothing written. With another hash: refused, nothing written but RejectedAttempt.
  foreach f in array array['transfer_review', 'transfer_decision'] loop
    acc := '[]';
    begin
      run := pg_temp.w14_begin(tag || '_run_i_' || f); sid := tag || '_I-' || f; w := pg_temp.w14_work();
      r := pg_temp.w14_call('devos_kurulum', f, pg_temp.w14_recipe(f, jsonb_build_object('run', run, 'sid', sid, 'target', w)));
      rv := pg_temp.w14_id(r);
      if run is null or pg_temp.w14_kind(r) <> 'accepted' then
        acc := jsonb_build_array(jsonb_build_object('id', case f when 'transfer_review' then 'FN-I-same' else 'FN-I-same-decision' end,
                 'cond', null, 'detail', 'the first write was not accepted with the chosen keys: ' || pg_temp.w14_brief(r)),
               jsonb_build_object('id', case f when 'transfer_review' then 'FN-I-other-review' else 'FN-I-other-decision' end,
                 'cond', null, 'detail', 'the first write was not accepted with the chosen keys: ' || pg_temp.w14_brief(r)));
      else
        s0 := pg_temp.w14_counts();
        r2 := pg_temp.w14_call('devos_kurulum', f, pg_temp.w14_recipe(f, jsonb_build_object('run', run, 'sid', sid, 'target', w)));
        s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
        acc := acc || jsonb_build_array(jsonb_build_object('id', case f when 'transfer_review' then 'FN-I-same' else 'FN-I-same-decision' end,
          'cond', case when pg_temp.w14_kind(r2) in ('test', 'unknown') then null
                       else pg_temp.w14_kind(r2) = 'accepted' and pg_temp.w14_id(r2) = rv and cardinality(ch) = 0 end,
          'detail', format('%s, an exact repeat (same source, same hash): %s, id %s (first %s); tables changed besides '
            || 'rejected_attempt: %s (wanted accepted, the same id, none)', f, pg_temp.w14_brief(r2),
            coalesce(pg_temp.w14_id(r2), 'none'), rv, coalesce(nullif(array_to_string(ch, ', '), ''), 'none'))));
        s0 := pg_temp.w14_counts();
        r2 := pg_temp.w14_call('devos_kurulum', f, pg_temp.w14_recipe(f, jsonb_build_object('run', run, 'sid', sid, 'target', w, 'text', 'two')));
        s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']);
        acc := acc || jsonb_build_array(jsonb_build_object('id', case f when 'transfer_review' then 'FN-I-other-review' else 'FN-I-other-decision' end,
          'cond', case when pg_temp.w14_kind(r2) in ('test', 'raised', 'unknown') then null
                       else pg_temp.w14_kind(r2) = 'refused' and cardinality(ch) = 0 and pg_temp.w14_marks(sid) = 1
                            and pg_temp.w14_delta(s0, s1, 'rejected_attempt') >= 1 end,
          'detail', format('%s, the same source with another hash: %s; tables changed besides rejected_attempt: %s; its '
            || 'transferred events %s; rejected_attempt rows +%s (wanted refused, none, 1, at least 1)', f, pg_temp.w14_brief(r2),
            coalesce(nullif(array_to_string(ch, ', '), ''), 'none'), pg_temp.w14_marks(sid), pg_temp.w14_delta(s0, s1, 'rejected_attempt'))));
      end if;
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when others then acc := acc || jsonb_build_array(jsonb_build_object('id', case f when 'transfer_review' then 'FN-I-same' else 'FN-I-same-decision' end, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

  -- FN-A-*: transfer_acceptance (EV-C02-005 2.4): it refuses when the Review copy it names is missing, when that
  -- verdict's result is fail, or, for a conditional result, when it names no ledger_entry event; an accepted call sets
  -- the target Work's acceptance to accepted in the same transaction. Each case differs from FN-A-pos in one thing.
  foreach c in array array['pos', 'missing', 'fail', 'cond'] loop
    acc := '[]';
    begin
      run := pg_temp.w14_begin(tag || '_run_a_' || c); w := pg_temp.w14_work();
      r := pg_temp.w14_call('devos_kurulum', 'transfer_review', pg_temp.w14_recipe('transfer_review', jsonb_build_object('run', run,
             'sid', tag || '_A-' || c, 'target', w, 'result', case c when 'fail' then 'fail' when 'cond' then 'conditional' else 'pass' end)));
      rv := case when c = 'missing' then gen_random_uuid()::text else pg_temp.w14_id(r) end;
      if run is null or pg_temp.w14_kind(r) <> 'accepted' then
        acc := jsonb_build_array(jsonb_build_object('id', 'FN-A-' || c, 'cond', null,
                 'detail', 'the Review copy was not accepted with the chosen keys: ' || pg_temp.w14_brief(r)));
      else
        s0 := pg_temp.w14_counts();
        r2 := pg_temp.w14_call('devos_kurulum', 'transfer_acceptance', pg_temp.w14_recipe('transfer_acceptance',
               jsonb_build_object('run', run, 'sid', tag || '_ACC-' || c, 'target', w, 'review', rv)));
        s1 := pg_temp.w14_counts(); k := pg_temp.w14_kind(r2);
        acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-A-' || c,
          'cond', case when k in ('test', 'raised', 'unknown') then null
                       when c = 'pos' then k = 'accepted' and pg_temp.w14_delta(s0, s1, 'acceptance') = 1
                                           and pg_temp.w14_work_acceptance(w) = 'accepted' and pg_temp.w14_marks(tag || '_ACC-' || c) = 1
                       else k = 'refused' and cardinality(pg_temp.w14_changed(s0, s1, array['rejected_attempt'])) = 0
                            and pg_temp.w14_work_acceptance(w) = 'proposed' end,
          'detail', format('transfer_acceptance naming %s: %s; acceptance rows +%s; the Work''s acceptance %s; tables changed '
            || 'besides rejected_attempt: %s (wanted %s)', case c when 'pos' then 'a pass copy' when 'missing' then 'an id that '
            || 'names no Review copy' when 'fail' then 'a fail copy' else 'a conditional copy, current_evidence naming only it' end,
            pg_temp.w14_brief(r2), pg_temp.w14_delta(s0, s1, 'acceptance'), pg_temp.w14_work_acceptance(w),
            coalesce(nullif(array_to_string(pg_temp.w14_changed(s0, s1, array['rejected_attempt']), ', '), ''), 'none'),
            case c when 'pos' then 'accepted, +1, accepted, its one transferred event' else 'refused, +0, proposed, none' end)));
      end if;
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-A-' || c, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;
  perform pg_temp.w14_rec('FN-A-cond-pos', 'could_not_check', 'a conditional copy with the ledger_entry event that records '
    || 'its conditions met: no source names how current_evidence names an event (EV-C02-005 2.4); filled from W-C02-09''s record');

  -- FN-R-declared: a declared role class in the payload changes nothing (B principle 8; S1: role_class from the token).
  acc := '[]';
  begin
    run := pg_temp.w14_begin(tag || '_run_r'); w := pg_temp.w14_work(); sid := tag || '_R-1';
    r := pg_temp.w14_call('devos_kurulum', 'transfer_review', pg_temp.w14_recipe('transfer_review',
           jsonb_build_object('run', run, 'sid', sid, 'target', w)) || '{"role_class": "devos_denetim", "reviewer_role_class": "devos_denetim", "origin": "owner"}');
    rv := pg_temp.w14_id(r);
    if run is null or pg_temp.w14_kind(r) <> 'accepted' then
      acc := jsonb_build_array(jsonb_build_object('id', 'FN-R-declared', 'cond', null, 'detail',
               'not accepted with declared role keys added (a build may refuse unknown keys): ' || pg_temp.w14_brief(r)));
    else
      execute 'select to_jsonb(x) ->> ''reviewer_role_class'' from devos_private.review x where x.id::text = $1' into det using rv;
      execute 'select string_agg(distinct e.role_class::text || ''/'' || e.origin::text, '','') from devos_private.event e
                where e.aggregate_id::text = $1' into pre using rv;
      acc := jsonb_build_array(jsonb_build_object('id', 'FN-R-declared', 'cond', det = 'devos_kurulum' and pre = 'devos_kurulum/call',
               'detail', format('declared devos_denetim and origin owner: accepted; the copy''s reviewer_role_class %s, its events '
                 || '%s (wanted devos_kurulum, devos_kurulum/call)', coalesce(det, 'absent'), coalesce(pre, 'none'))));
    end if;
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-R-declared', 'cond', null,
      'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
end $$;

select case_id, outcome, detail from w14_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w14_results;
  if nb > 0 then
    raise exception 'W14_FN_TRANSFER_FUNCTIONS FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W14_FN_TRANSFER_FUNCTIONS COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W14_FN_TRANSFER_FUNCTIONS PASS (%/%)', n, n;
end $$;

rollback;
