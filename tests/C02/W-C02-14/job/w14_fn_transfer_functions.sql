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
-- fourteen functions; the other ten's payloads, their prerequisites, the run rule after the hand-over and the form in
-- which current_evidence names an event as W-C02-09's interface record gives them: evidence/C02/EV-C02-013_w09_interface.md
-- sections 1 and 3, Revision 1).
-- Revised before any result (EV-C02-013, 2026-10-17; ledger rule 3): the ten recipes and their prerequisites filled, the
-- installation's Mission planted for transfer_acceptance, run_id dropped after the hand-over, FN-G's counted row read,
-- FN-A-cond-pos formed. No case ID and no expected outcome changed.
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

-- The recipes: one accepted call per function. Four keep the payload keys W-C02-07's README 8.1 chooses
-- (begin_transfer_run, transfer_decision, transfer_review, transfer_acceptance; "The payload keys T-W07-N02 and T-W07-N04
-- send, each chosen"); the other ten send the keys W-C02-09's interface record names (EV-C02-013 section 3.2, the table
-- "The fourteen", and its paragraph "What the ten recipes need"). A null recipe still gives could_not_check, never a pass.
-- p_o: the call's own values (run_id, source ID, text, target, review, verdict result, current_evidence, and the ids the
-- prerequisites made: mission, mission_revision, decision, decision_revision, from, to, stage, kind, class, path).
-- After the ledger_handed_over event a copy names no run (EV-C02-013 section 3.1, D-7): with no 'run' in p_o,
-- transfer_review, transfer_acceptance and transfer_artifact send no run_id key at all.
create function pg_temp.w14_recipe(p_fn text, p_o jsonb) returns jsonb language plpgsql as $f$
declare sid text := coalesce(p_o ->> 'sid', pg_temp.w14_tag() || '_' || p_fn); txt text := coalesce(p_o ->> 'text', 'one');
        j jsonb; kind text := coalesce(p_o ->> 'kind', 'record_line');
begin
  if p_fn = 'begin_transfer_run' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'input_commit', pg_temp.w14_hex('w14 input commit', 40),
      'manifest_sha256', pg_temp.w14_hex('w14 manifest ' || (p_o ->> 'run'), 64), 'counts', '{}'::jsonb,
      'phase', 'begun', 'mode', coalesce(p_o ->> 'mode', 'ahead'));
  elsif p_fn = 'transfer_decision' then
    j := jsonb_build_object('class', coalesce(p_o ->> 'class', 'high_impact'), 'question', 'w14_fixture SYNTHETIC W-C02-14 decision ' || sid,
      'why_this_owner', 'w14_fixture SYNTHETIC W-C02-14: a rule of the fixture schema',
      'options', '[]'::jsonb, 'alternatives_considered', '[]'::jsonb, 'alternatives_state', 'compared',
      'criteria', '[]'::jsonb, 'evidence_refs', '[]'::jsonb, 'assumptions', '[]'::jsonb, 'premises', '[]'::jsonb,
      'reversibility', null, 'reopen_triggers', '[]'::jsonb, 'recommendation', null, 'recommendation_rationale', null,
      'status', 'answered', 'run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('decision', sid, txt));
    if p_o ->> 'class' = 'batu' then
      -- The answered batu Decision the installation's Mission rests on (EV-C02-013 3.2, transfer_mission's row, R1-9).
      j := j || jsonb_build_object('presented_text_tr', 'w14_fixture SYNTHETIC W-C02-14 karar metni',
        'answer_original_tr', 'w14_fixture SYNTHETIC W-C02-14 yanit', 'answer_interpretation_en',
        'w14_fixture SYNTHETIC W-C02-14 answer', 'answered_by', 'w14_fixture SYNTHETIC', 'answer_channel_ref',
        'w14_fixture/channel', 'answered_at', now());
    end if;
    return j;
  elsif p_fn = 'transfer_review' then
    j := jsonb_build_object('run_id', p_o ->> 'run', 'kind', 'review',
      'claim', 'w14_fixture SYNTHETIC W-C02-14 installation verdict copy ' || sid, 'target_ref', p_o ->> 'target',
      'criterion', 'w14_fixture/plan/work/W-W14-FIXTURE.md', 'basis_refs', jsonb_build_array('w14_fixture_tree'),
      'reviewer_declared_session', 'w14_fixture_checker_run SYNTHETIC W-C02-14', 'independence_level', 'fresh_context_subagent',
      'use', 'installation_acceptance', 'verdict', jsonb_build_object('result', coalesce(p_o ->> 'result', 'pass'),
      'objections', '[]'::jsonb, 'evidence_refs', '[]'::jsonb, 'limits', '[]'::jsonb),
      'transfer_source', pg_temp.w14_src('verdict', sid, txt));
    return case when p_o ->> 'run' is null then j - 'run_id' else j end;
  elsif p_fn = 'transfer_acceptance' then
    j := jsonb_build_object('run_id', p_o ->> 'run', 'target_ref', p_o ->> 'target', 'review_ref', p_o ->> 'review',
      'accepted_use', 'installation_acceptance', 'scope', 'installation',
      'current_evidence', coalesce(p_o -> 'evidence', jsonb_build_array(p_o ->> 'review')),
      'transfer_source', pg_temp.w14_src('acceptance', sid, txt));
    return case when p_o ->> 'run' is null then j - 'run_id' else j end;
  -- The ten, from EV-C02-013 section 3.2 (* there: required).
  elsif p_fn = 'end_transfer_run' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'counts', '{}'::jsonb, 'phase', 'completed');
  elsif p_fn = 'record_handover' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'input_commit', pg_temp.w14_hex('w14 input commit', 40),
      'mark_commit', pg_temp.w14_hex('w14 mark commit ' || sid, 40), 'handed_over_sha256', pg_temp.w14_hex('w14 handed over ' || sid, 64));
  elsif p_fn = 'transfer_mission' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('mission', sid, txt),
      'purpose', 'w14_fixture SYNTHETIC W-C02-14 installation mission ' || sid, 'scope', 'installation',
      'acceptance', 'w14_fixture SYNTHETIC W-C02-14 acceptance', 'owner_authority', p_o ->> 'decision',
      'owner_authority_revision', (p_o ->> 'decision_revision')::int, 'constraints', '[]'::jsonb, 'status', 'active');
  elsif p_fn = 'transfer_work' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('work', sid, txt),
      'mission_ref', p_o ->> 'mission', 'mission_revision', (p_o ->> 'mission_revision')::int, 'scope', 'installation',
      'purpose', 'w14_fixture SYNTHETIC W-C02-14 work item ' || sid, 'impact_class', 'high', 'execution', 'planned',
      'acceptance', 'proposed', 'effort_policy', jsonb_build_object('level', 'high', 'expert_assessment_ref',
      'w14_fixture/expert_assessment', 'non_removable_steps', jsonb_build_array('w14_fixture SYNTHETIC step')));
  elsif p_fn = 'transfer_relation' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('relation', sid, txt),
      'type', 'about', 'from_ref', p_o ->> 'from', 'from_revision', 1, 'to_ref', p_o ->> 'to', 'to_revision', 1,
      'scope', 'installation', 'hard', false, 'method', 'mechanical', 'epistemic_status', 'observation');
  elsif p_fn = 'transfer_need' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('need', sid, txt),
      'mission_ref', p_o ->> 'mission', 'condition', 'w14_fixture SYNTHETIC W-C02-14 condition ' || sid,
      'why_needed', 'w14_fixture SYNTHETIC W-C02-14: a fixture need', 'status', 'open');
  elsif p_fn = 'transfer_finding' then
    return jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('finding', sid, txt),
      'claim', 'w14_fixture SYNTHETIC W-C02-14 finding ' || sid, 'scope', 'installation',
      'counter_evidence_searched', 'not_recorded', 'changeable', 'not_recorded', 'epistemic_status', 'observation',
      'current_authority', 'information_only', 'privacy_class', 'public', 'status', 'candidate');
  elsif p_fn = 'transfer_artifact' then
    j := jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src('artifact', sid, txt),
      'path', coalesce(p_o ->> 'path', 'w14_fixture/' || sid || '.md'), 'commit', pg_temp.w14_hex('w14 artifact commit ' || sid, 40),
      'kind', coalesce(p_o ->> 'artifact_kind', 'git_file'), 'scope', 'installation', 'status', 'current');
    return case when p_o ->> 'run' is null then j - 'run_id' else j end;
  elsif p_fn = 'transfer_event' then
    j := jsonb_build_object('run_id', p_o ->> 'run', 'transfer_source', pg_temp.w14_src(kind, sid, txt), 'event_type', kind,
      'aggregate_type', 'work', 'aggregate_id', p_o ->> 'target', 'text', 'w14_fixture SYNTHETIC W-C02-14 line ' || sid);
    if kind = 'ledger_entry' then j := j || jsonb_build_object('entry_id', sid, 'entry_date', current_date::text); end if;
    return j;
  elsif p_fn = 'record_ledger_entry' then
    return jsonb_build_object('stage_work_id', p_o ->> 'stage', 'entry_id', sid, 'entry_date', current_date::text,
      'text', 'w14_fixture SYNTHETIC W-C02-14 ledger entry ' || sid || ' ' || txt);
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

-- The prerequisites EV-C02-013 section 3.2 names ("Prerequisites a test must plant"). A prerequisite call that is not
-- accepted raises P0W17, which every case reads as could_not_check with that reason, never a pass.
create function pg_temp.w14_need(p_what text, r jsonb) returns text language plpgsql as $f$
begin
  if pg_temp.w14_kind(r) = 'accepted' and pg_temp.w14_id(r) is not null then return pg_temp.w14_id(r); end if;
  raise exception using errcode = 'P0W17', message = 'a prerequisite (' || p_what || ') was not accepted: ' || pg_temp.w14_brief(r);
end $f$;
-- The answered batu Decision transferred with source ID D-010, untagged (EV-C02-013 3.2, R1-9; S2's index allows it,
-- since this file's transaction is rolled back). One already committed in the database tested is used as it is.
create function pg_temp.w14_d010(p_run text) returns jsonb language plpgsql as $f$
declare d text; dr int;
begin
  execute 'select d.id::text from devos_private.decision d join devos_private.event e on e.aggregate_id = d.id
            where e.event_type::text = ''transferred'' and e.payload -> ''transfer_source'' ->> ''source_id'' = ''D-010''
            order by e.id limit 1' into d;
  if d is null then
    d := pg_temp.w14_need('transfer_decision with source ID D-010', pg_temp.w14_call('devos_kurulum', 'transfer_decision',
           pg_temp.w14_recipe('transfer_decision', jsonb_build_object('run', p_run, 'sid', 'D-010', 'class', 'batu'))));
  end if;
  execute 'select coalesce((to_jsonb(x) ->> ''answered_revision'')::int, 1) from devos_private.decision x where x.id::text = $1'
    into dr using d;
  return jsonb_build_object('decision', d, 'decision_revision', dr);
end $f$;
-- The installation's Mission: the one Mission whose creation event is transferred (EV-C02-013 section 4, the hook
-- installation_mission), made here by its second form, transfer_decision (D-010) then transfer_mission with devos_kurulum.
-- One already committed in the database tested is used as it is. Returns its id and current revision.
create function pg_temp.w14_install(p_run text) returns jsonb language plpgsql as $f$
declare m text; n int;
begin
  execute 'select m.id::text from devos_private.mission m where exists (select 1 from devos_private.event e
             where e.aggregate_id = m.id and e.event_type::text = ''transferred'') order by m.created_at limit 1' into m;
  if m is null then
    m := pg_temp.w14_need('transfer_mission', pg_temp.w14_call('devos_kurulum', 'transfer_mission',
           pg_temp.w14_recipe('transfer_mission', jsonb_build_object('run', p_run, 'sid', pg_temp.w14_tag() || '_INSTALL')
                                                  || pg_temp.w14_d010(p_run))));
  end if;
  execute 'select max(r.revision) from devos_private.mission_revision r where r.mission_id::text = $1' into n using m;
  return jsonb_build_object('mission', m, 'mission_revision', n);
end $f$;
-- What each of the ten needs before its call (EV-C02-013 3.2's paragraph "What the ten recipes need"), as p_o keys.
create function pg_temp.w14_prep(p_fn text, p_run text) returns jsonb language plpgsql as $f$
declare i jsonb;
begin
  if p_fn = 'transfer_mission' then return pg_temp.w14_d010(p_run);
  elsif p_fn in ('transfer_work', 'transfer_need', 'record_handover', 'transfer_acceptance') then return pg_temp.w14_install(p_run);
  elsif p_fn = 'transfer_relation' then return jsonb_build_object('from', pg_temp.w14_work(), 'to', pg_temp.w14_work());
  elsif p_fn = 'transfer_event' then return jsonb_build_object('target', pg_temp.w14_work());
  elsif p_fn = 'record_ledger_entry' then
    i := pg_temp.w14_install(p_run);
    return i || jsonb_build_object('stage', pg_temp.w14_need('transfer_work for the stage''s Work', pg_temp.w14_call('devos_kurulum',
      'transfer_work', pg_temp.w14_recipe('transfer_work', i || jsonb_build_object('run', p_run, 'sid', pg_temp.w14_tag() || '_W-stage')))));
  end if;
  return '{}'::jsonb;
end $f$;
-- The counted RejectedAttempt row of an unverified call (B 3.13, B:270; EV-C02-013 section 1 item 9): the sum of its
-- count for this function and reason code missing, under any of the function's spellings. Null when it cannot be read.
create function pg_temp.w14_counted(p_fn text) returns bigint language plpgsql as $f$
declare n bigint;
begin
  execute 'select coalesce(sum(x.count), 0) from devos_private.rejected_attempt x where x.counted_hour is not null
             and x.reason_code::text = ''missing'' and x.function_name::text in ($1, ''devos_api.'' || $1, $1 || ''(jsonb)'',
             ''devos_api.'' || $1 || ''(jsonb)'')' into n using p_fn;
  return n;
exception when others then return null;
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
        miss text[]; n0 bigint; n1 bigint; i bigint; res jsonb; w2 text;
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
        if c = 'none' then n0 := pg_temp.w14_counted(f); end if;
        r := pg_temp.w14_call(case when c = 'none' then null else c end, f, '{}'::jsonb);
        k := pg_temp.w14_kind(r);
        -- The no-token call's counted row increases in place by one (B:270; CHK-C02-075 finding 2 (e); EV-C02-013 D-11).
        if c = 'none' then
          n1 := pg_temp.w14_counted(f);
          if n0 is null or n1 is null then ok := null;
          elsif ok is not null and n1 - n0 <> 1 then ok := false; end if;
          det := det || format('counted row (missing) %s -> %s (wanted +1); ', coalesce(n0::text, 'unreadable'), coalesce(n1::text, 'unreadable'));
        end if;
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
      perform pg_temp.w14_rec('FN-C-' || f, 'could_not_check', f || ': no recipe is formed for it, so no accepted call can '
        || 'be made; the test designer fills its recipe from W-C02-09''s record (EV-C02-013 section 3.2) before the first result');
      continue;
    end if;
    acc := '[]';
    begin
      run := tag || '_run_c_' || f;
      if f <> 'begin_transfer_run' then run := pg_temp.w14_begin(run); end if;
      if run is null then
        pre := 'begin_transfer_run did not accept its recipe, so no run is open';
      else
        -- Its prerequisites (EV-C02-013 3.2), planted before the call.
        rcp := pg_temp.w14_recipe(f, jsonb_build_object('run', run) || case when f = 'begin_transfer_run' then '{}'::jsonb
                                                                            else pg_temp.w14_prep(f, run) end);
        r := pg_temp.w14_call('devos_kurulum', f, rcp); pre := pg_temp.w14_brief(r);
        if pg_temp.w14_kind(r) = 'accepted' then pre := null; end if;
      end if;
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when sqlstate 'P0W17' then pre := sqlerrm;
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
      -- The same call as the control, its prerequisites planted before the hand-over (they write through the functions).
      rcp := pg_temp.w14_recipe(f, jsonb_build_object('run', run) || case when f = 'begin_transfer_run' then '{}'::jsonb
                                                                          else pg_temp.w14_prep(f, run) end);
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
      when sqlstate 'P0W17' then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-C-' || f, 'cond', null, 'detail', sqlerrm));
      when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-C-' || f, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

  -- FN-O-<fn>: after the hand-over, transfer_review, transfer_acceptance, transfer_artifact (a verdict file) and
  -- record_ledger_entry still write (EV-C02-005 section 12; EV-C02-013 3.1 "Closing"). The copies send no run_id
  -- (EV-C02-013 3.1, D-7). What they need is planted before the hand-over, through the functions: an open run, the
  -- installation's Mission (transfer_acceptance takes its owner authority from it, EV-C02-013 D-8), the stage's Work
  -- (record_ledger_entry, under that Mission), and a Work the copies name.
  acc := '[]';
  begin
    if pg_temp.w14_handovers() > 0 then raise exception using errcode = 'P0W16', message = 'a ledger_handed_over event is already here'; end if;
    run := pg_temp.w14_begin(tag || '_run_o');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    res := pg_temp.w14_install(run);
    w := pg_temp.w14_work();
    w2 := pg_temp.w14_need('transfer_work for the stage''s Work', pg_temp.w14_call('devos_kurulum', 'transfer_work',
            pg_temp.w14_recipe('transfer_work', res || jsonb_build_object('run', run, 'sid', tag || '_W-O1'))));
    perform pg_temp.w14_handover();
    s0 := pg_temp.w14_counts();
    r := pg_temp.w14_call('devos_kurulum', 'transfer_review', pg_temp.w14_recipe('transfer_review',
           jsonb_build_object('sid', tag || '_CHK-O1', 'target', w)));
    s1 := pg_temp.w14_counts(); rv := pg_temp.w14_id(r);
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_review',
      'cond', case when pg_temp.w14_kind(r) in ('test', 'raised', 'unknown') then null
                   else pg_temp.w14_kind(r) = 'accepted' and pg_temp.w14_delta(s0, s1, 'review') = 1 and pg_temp.w14_marks(tag || '_CHK-O1') = 1 end,
      'detail', format('after the hand-over, no run_id: transfer_review %s; review rows +%s, its transferred events %s (wanted '
        || 'accepted, +1, 1)', pg_temp.w14_brief(r), pg_temp.w14_delta(s0, s1, 'review'), pg_temp.w14_marks(tag || '_CHK-O1'))));
    s0 := pg_temp.w14_counts();
    r2 := pg_temp.w14_call('devos_kurulum', 'transfer_acceptance', pg_temp.w14_recipe('transfer_acceptance',
           jsonb_build_object('sid', tag || '_ACC-O1', 'target', w, 'review', rv)));
    s1 := pg_temp.w14_counts();
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_acceptance',
      'cond', case when pg_temp.w14_kind(r) <> 'accepted' or pg_temp.w14_kind(r2) in ('test', 'raised', 'unknown') then null
                   else pg_temp.w14_kind(r2) = 'accepted' and pg_temp.w14_delta(s0, s1, 'acceptance') = 1 end,
      'detail', format('after the hand-over, no run_id: transfer_acceptance of that copy %s; acceptance rows +%s (wanted accepted, +1)',
        pg_temp.w14_brief(r2), pg_temp.w14_delta(s0, s1, 'acceptance'))));
    -- A verdict file's Artifact: a git_file whose path is a check's verdict file (EV-C02-013 3.2, transfer_artifact's row).
    s0 := pg_temp.w14_counts();
    r := pg_temp.w14_call('devos_kurulum', 'transfer_artifact', pg_temp.w14_recipe('transfer_artifact',
           jsonb_build_object('sid', tag || '_ART-O1', 'artifact_kind', 'git_file',
                              'path', 'evidence/C99/checks/CHK-C99-' || abs(hashtext(tag))::text || '.md')));
    s1 := pg_temp.w14_counts();
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_artifact',
      'cond', case when pg_temp.w14_kind(r) in ('test', 'raised', 'unknown') then null
                   else pg_temp.w14_kind(r) = 'accepted' and pg_temp.w14_delta(s0, s1, 'artifact') = 1 and pg_temp.w14_marks(tag || '_ART-O1') = 1 end,
      'detail', format('after the hand-over, no run_id: transfer_artifact of a verdict file (git_file, a synthetic '
        || 'evidence/C99/checks/ path) %s; artifact rows +%s, its transferred events %s (wanted accepted, +1, 1)',
        pg_temp.w14_brief(r), pg_temp.w14_delta(s0, s1, 'artifact'), pg_temp.w14_marks(tag || '_ART-O1'))));
    -- record_ledger_entry writes one ledger_entry event on the stage's Work, and nothing else (EV-C02-005 section 12).
    execute 'select count(*) from devos_private.event e where e.event_type::text = ''ledger_entry'' and e.aggregate_id::text = $1'
      into n0 using w2;
    i := (select count(*) from devos_private.event e where e.event_type::text = 'transferred');
    s0 := pg_temp.w14_counts();
    r := pg_temp.w14_call('devos_kurulum', 'record_ledger_entry', pg_temp.w14_recipe('record_ledger_entry',
           jsonb_build_object('sid', tag || '_L-O1', 'stage', w2)));
    s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt', 'event']);
    execute 'select count(*) from devos_private.event e where e.event_type::text = ''ledger_entry'' and e.aggregate_id::text = $1'
      into n1 using w2;
    acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-O-record_ledger_entry',
      'cond', case when pg_temp.w14_kind(r) in ('test', 'raised', 'unknown') then null
                   else pg_temp.w14_kind(r) = 'accepted' and pg_temp.w14_delta(s0, s1, 'event') = 1 and n1 - n0 = 1
                        and (select count(*) from devos_private.event e where e.event_type::text = 'transferred') = i
                        and cardinality(ch) = 0 end,
      'detail', format('after the hand-over: record_ledger_entry on the stage''s Work %s; event rows +%s, its ledger_entry '
        || 'events +%s, transferred events +%s, other tables changed: %s (wanted accepted, +1, +1, +0, none)', pg_temp.w14_brief(r),
        pg_temp.w14_delta(s0, s1, 'event'), n1 - n0, (select count(*) from devos_private.event e where e.event_type::text = 'transferred') - i,
        coalesce(nullif(array_to_string(ch, ', '), ''), 'none'))));
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W16' or sqlstate 'P0W17' then
      acc := (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail', sqlerrm))
                from unnest(array['FN-O-transfer_review', 'FN-O-transfer_acceptance', 'FN-O-transfer_artifact',
                                  'FN-O-record_ledger_entry']) x);
    when others then
      acc := acc || (select jsonb_agg(jsonb_build_object('id', x, 'cond', null, 'detail',
        'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)))
                from unnest(array['FN-O-transfer_review', 'FN-O-transfer_acceptance', 'FN-O-transfer_artifact',
                                  'FN-O-record_ledger_entry']) x);
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  -- FN-O-transfer_artifact-other: after the hand-over, another file's Artifact is refused and nothing but RejectedAttempt
  -- changes. Its control: the same call, with a run, before the hand-over, accepted (else could_not_check).
  pre := null;
  begin
    if pg_temp.w14_handovers() > 0 then raise exception using errcode = 'P0W17', message = 'a ledger_handed_over event is already here'; end if;
    run := pg_temp.w14_begin(tag || '_run_o_other');
    if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
    r := pg_temp.w14_call('devos_kurulum', 'transfer_artifact', pg_temp.w14_recipe('transfer_artifact',
           jsonb_build_object('run', run, 'sid', tag || '_ART-O2', 'artifact_kind', 'git_file')));
    if pg_temp.w14_kind(r) <> 'accepted' then pre := 'the control (the same call with a run, before the hand-over) was not '
      || 'accepted with the chosen keys: ' || pg_temp.w14_brief(r); end if;
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception
    when sqlstate 'P0W14' then null;
    when sqlstate 'P0W17' then pre := sqlerrm;
    when others then pre := 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160);
  end;
  if pre is not null then
    perform pg_temp.w14_rec('FN-O-transfer_artifact-other', 'could_not_check', pre);
  else
    acc := '[]';
    begin
      perform pg_temp.w14_handover();
      s0 := pg_temp.w14_counts();
      r := pg_temp.w14_call('devos_kurulum', 'transfer_artifact', pg_temp.w14_recipe('transfer_artifact',
             jsonb_build_object('sid', tag || '_ART-O2', 'artifact_kind', 'git_file')));
      s1 := pg_temp.w14_counts(); ch := pg_temp.w14_changed(s0, s1, array['rejected_attempt']); k := pg_temp.w14_kind(r);
      acc := jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_artifact-other',
        'cond', case when k in ('test', 'raised', 'unknown') then null else k = 'refused' and cardinality(ch) = 0 end,
        'detail', format('after the hand-over, no run_id: transfer_artifact of a file that is not a verdict file %s; tables '
          || 'changed besides rejected_attempt: %s (wanted refused, none); before it the same call with a run was accepted',
          pg_temp.w14_brief(r), coalesce(nullif(array_to_string(ch, ', '), ''), 'none'))));
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when others then acc := jsonb_build_array(jsonb_build_object('id', 'FN-O-transfer_artifact-other', 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end if;

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
  -- The installation's Mission is planted in each (transfer_acceptance takes its owner authority from it; EV-C02-013 3.2
  -- and D-8). FN-A-cond-pos: the conditional copy with a ledger_entry event, written by transfer_event, that
  -- current_evidence names as {"event_id": n} (EV-C02-013 3.2, transfer_acceptance's row and "What the ten recipes need").
  foreach c in array array['pos', 'missing', 'fail', 'cond', 'cond-pos'] loop
    acc := '[]';
    begin
      run := pg_temp.w14_begin(tag || '_run_a_' || c); w := pg_temp.w14_work();
      if run is null then raise exception using errcode = 'P0W17', message = 'begin_transfer_run did not accept its recipe, so no run is open'; end if;
      perform pg_temp.w14_install(run);
      r := pg_temp.w14_call('devos_kurulum', 'transfer_review', pg_temp.w14_recipe('transfer_review', jsonb_build_object('run', run,
             'sid', tag || '_A-' || c, 'target', w, 'result', case c when 'fail' then 'fail' when 'cond' then 'conditional'
                                                                    when 'cond-pos' then 'conditional' else 'pass' end)));
      rv := case when c = 'missing' then gen_random_uuid()::text else pg_temp.w14_id(r) end;
      res := null;
      if c = 'cond-pos' then
        res := jsonb_build_array(rv, jsonb_build_object('event_id', (pg_temp.w14_need('transfer_event of a ledger_entry',
                 pg_temp.w14_call('devos_kurulum', 'transfer_event', pg_temp.w14_recipe('transfer_event', jsonb_build_object('run', run,
                 'sid', tag || '_LE-A', 'kind', 'ledger_entry', 'target', w)))))::bigint));
      end if;
      if pg_temp.w14_kind(r) <> 'accepted' then
        acc := jsonb_build_array(jsonb_build_object('id', 'FN-A-' || c, 'cond', null,
                 'detail', 'the Review copy was not accepted with the chosen keys: ' || pg_temp.w14_brief(r)));
      else
        s0 := pg_temp.w14_counts();
        r2 := pg_temp.w14_call('devos_kurulum', 'transfer_acceptance', pg_temp.w14_recipe('transfer_acceptance',
               jsonb_build_object('run', run, 'sid', tag || '_ACC-' || c, 'target', w, 'review', rv)
               || case when res is null then '{}'::jsonb else jsonb_build_object('evidence', res) end));
        s1 := pg_temp.w14_counts(); k := pg_temp.w14_kind(r2);
        acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-A-' || c,
          'cond', case when k in ('test', 'raised', 'unknown') then null
                       when c in ('pos', 'cond-pos') then k = 'accepted' and pg_temp.w14_delta(s0, s1, 'acceptance') = 1
                                           and pg_temp.w14_work_acceptance(w) = 'accepted' and pg_temp.w14_marks(tag || '_ACC-' || c) = 1
                       else k = 'refused' and cardinality(pg_temp.w14_changed(s0, s1, array['rejected_attempt'])) = 0
                            and pg_temp.w14_work_acceptance(w) = 'proposed' end,
          'detail', format('transfer_acceptance naming %s: %s; acceptance rows +%s; the Work''s acceptance %s; tables changed '
            || 'besides rejected_attempt: %s (wanted %s)', case c when 'pos' then 'a pass copy' when 'missing' then 'an id that '
            || 'names no Review copy' when 'fail' then 'a fail copy' when 'cond' then 'a conditional copy, current_evidence '
            || 'naming only it' else 'a conditional copy, current_evidence naming it and a ledger_entry event as {"event_id": n}' end,
            pg_temp.w14_brief(r2), pg_temp.w14_delta(s0, s1, 'acceptance'), pg_temp.w14_work_acceptance(w),
            coalesce(nullif(array_to_string(pg_temp.w14_changed(s0, s1, array['rejected_attempt']), ', '), ''), 'none'),
            case when c in ('pos', 'cond-pos') then 'accepted, +1, accepted, its one transferred event' else 'refused, +0, proposed, none' end)));
      end if;
      raise exception using errcode = 'P0W14', message = 'w14: undo the block';
    exception
      when sqlstate 'P0W14' then null;
      when sqlstate 'P0W17' then acc := jsonb_build_array(jsonb_build_object('id', 'FN-A-' || c, 'cond', null, 'detail', sqlerrm));
      when others then acc := acc || jsonb_build_array(jsonb_build_object('id', 'FN-A-' || c, 'cond', null,
        'detail', 'the test stopped on its own error (README section 3 (ii)): ' || sqlstate || ' ' || left(sqlerrm, 160)));
    end;
    perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;
  end loop;

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
