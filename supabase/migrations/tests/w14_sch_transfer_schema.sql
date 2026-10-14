-- Synthetic test data (plan Section 8 item 13): every row and event planted here is made up inside this transaction
-- (text 'w14_fixture SYNTHETIC W-C02-14', scope 'synthetic.w14fixture', source IDs 'w14_fixture_<run tag>_*', commit
-- and hash strings made at run time from md5 of fixed synthetic strings, random uuids) and holds no personal or
-- business data and no credential. Nothing is committed: the file ends in rollback.
--
-- Claim: the ledger transfer's own schema, as EV-C02-005 section 15 gives it (S1 to S4), is in the database: the
-- idempotency index admits one `transferred` creation event per (kind, source ID) and refuses a second; no
-- `transferred` event escapes that key (its `transfer_source` is required, an object with its six fields, `kind` and
-- `source_id` not JSON null, `input_commit` 40 hexadecimal characters); at most one `ledger_handed_over` event exists;
-- and the event types S1 names, Decision's status `declined` (S3) and S4's values are admitted.
-- Revised before any result for CHK-C02-066 C2 and C3 (cases SCH-S1-null-kind, -null-source_id, -commit-nonhex, and
-- the designer's -commit-null and -src-array; 38 cases): see the specification's "Revision before any result".
-- Specification: tests/C02/W-C02-14/T-W14-SCH_transfer_schema.md. Serves W-C02-08 point 9: the part of W-C02-14
-- point 13's tests that judges W-C02-08's transfer schema.
-- Runs: in devos-test by the migration job's test step as postgres, once W-C02-08's pull request copies this file
-- byte for byte to supabase/migrations/tests/w14_sch_transfer_schema.sql; with its breaks
-- (tests/C02/W-C02-14/breaks/) on W-C02-07's throwaway database (tests/C02/W-C02-07/README.md section 5.2).
-- Interface assumed: the specification's "Interface assumed". Every attempt is an owner-level insert, the layer the
-- schema itself holds; the functions that write these records (S5) are W-C02-09's and are not called here.
-- Safety: no psql meta-command and no backslash; stops at its first error; one row per case, then PASS, FAIL or
-- COULD NOT CHECK (FAIL and COULD NOT CHECK raise).
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '60s';

-- Results (W-C02-07's README section 3; the helpers below are copied from Group B's w07_rec and w07_check in
-- tests/C02/W-C02-07/job/w07_dm02_revision_append_only.sql, renamed w14_, since no file includes another).
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
  select pg_temp.w14_rec(p_id, case when p_cond then 'ok' when not p_cond then 'bad' else 'could_not_check' end,
                         p_detail)
$f$;

create function pg_temp.w14_tag() returns text language sql as $f$ select tag from w14_ctx limit 1 $f$;

-- A synthetic hexadecimal string of p_len characters (40 for a commit, 64 for a SHA-256), made at run time so that no
-- file holds one; never printed.
create function pg_temp.w14_hex(p_seed text, p_len int) returns text language sql as $f$
  select left(md5(p_seed || ':a') || md5(p_seed || ':b'), p_len)
$f$;

-- The table of a family that holds a column: the identity table (<family>) first, else its revision table
-- (EV-C02-002 DM-02: identity and state in one row per object, content in <family>_revision).
create function pg_temp.w14_home(p_family text, p_col text) returns text language sql as $f$
  select t from unnest(array[p_family, p_family || '_revision']) with ordinality u(t, o)
   where exists (select 1 from information_schema.columns c where c.table_schema = 'devos_private'
                   and c.table_name = u.t and c.column_name = p_col)
   order by o limit 1
$f$;

-- The quoted identifiers that single-column CHECK constraints on one column admit (a value set's members), in order:
-- only constraints in the form PostgreSQL prints for IN (= ANY (ARRAY[...])), never one with a negation (NOT IN
-- prints as <> ALL), so that a value a constraint refuses is never taken for one it admits.
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

-- A value for a column that is not one of p_exclude: the first member its CHECK constraints list, else a synthetic
-- string (for a column with no such list).
create function pg_temp.w14_other(p_table text, p_col text, p_exclude text[]) returns text language sql as $f$
  select coalesce((select x from unnest(pg_temp.w14_listed(p_table, p_col)) x where not x = any(p_exclude) limit 1),
                  'w14_fixture_value')
$f$;

-- Plants one row as the owner (copied from Group B's w07_plant, same file as above, with two changes: a NOT NULL text
-- column takes the first member its CHECK constraints list, and a scope column 'synthetic.w14fixture'). The columns in
-- p_vals take those values; every other NOT NULL column without a default gets a synthetic value by its type, and a
-- NOT NULL single-column foreign key a newly planted parent row. Raises when it cannot.
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

-- One owner-level Event row (B 3.13's fields; role_class and origin those of the transfer's call, EV-C02-005 S1:
-- "origin call, role_class from the token"). Keys whose column the table lacks are left out, so that the case fails
-- on the rule, not on a column name this file chose.
create function pg_temp.w14_event(p_type text, p_payload jsonb, p_agg_type text, p_agg_id uuid) returns jsonb
language plpgsql as $f$
declare j jsonb; k text;
begin
  j := jsonb_build_object('event_type', p_type, 'payload', p_payload, 'aggregate_type', p_agg_type,
                          'aggregate_id', p_agg_id, 'aggregate_revision', 1, 'role_class', 'devos_kurulum',
                          'origin', 'call');
  for k in select jsonb_object_keys(j) loop
    if not exists (select 1 from information_schema.columns c where c.table_schema = 'devos_private'
                     and c.table_name = 'event' and c.column_name = k) then
      j := j - k;
    end if;
  end loop;
  return pg_temp.w14_plant('devos_private.event', j);
end $f$;

-- S1's transfer_source (kind, source_id, path, input_commit of 40 hexadecimal characters, last_commit, sha256) and a
-- transferred event's payload (transfer_source, plus the source's own date and actor, declared).
create function pg_temp.w14_src(p_kind text, p_sid text, p_text text default 'one') returns jsonb language sql as $f$
  select jsonb_build_object('kind', p_kind, 'source_id', p_sid, 'path', 'w14_fixture/' || p_sid || '.md',
    'input_commit', pg_temp.w14_hex('w14 input commit', 40),
    'last_commit', pg_temp.w14_hex('w14 last commit ' || p_sid, 40),
    'sha256', pg_temp.w14_hex('w14 text ' || p_sid || ' ' || p_text, 64))
$f$;

create function pg_temp.w14_tpayload(p_src jsonb) returns jsonb language sql as $f$
  select jsonb_build_object('transfer_source', p_src, 'declared_date', '2026-10-14',
                            'declared_actor', 'w14_fixture SYNTHETIC W-C02-14', 'w14_fixture', 'SYNTHETIC W-C02-14')
$f$;

-- One attempt to plant an event: 'accepted' or 'refused: <sqlstate> <message>'. Undone unless p_keep.
create function pg_temp.w14_try_event(p_type text, p_payload jsonb, p_agg_type text, p_keep boolean default false)
returns text language plpgsql as $f$
declare res text;
begin
  begin
    perform pg_temp.w14_event(p_type, p_payload, p_agg_type, gen_random_uuid());
    res := 'accepted';
    if not p_keep then raise exception using errcode = 'P0W14', message = 'w14: undo the attempt'; end if;
  exception
    when sqlstate 'P0W14' then null;
    when others then res := 'refused: ' || sqlstate || ' ' || left(sqlerrm, 160);
  end;
  return res;
end $f$;

-- The transferred events of one key (S2's two expressions).
create function pg_temp.w14_count_key(p_kind text, p_sid text) returns bigint language plpgsql as $f$
declare n bigint;
begin
  execute 'select count(*) from devos_private.event e where e.event_type::text = ''transferred''
             and e.payload -> ''transfer_source'' ->> ''kind'' = $1
             and e.payload -> ''transfer_source'' ->> ''source_id'' = $2' using p_kind, p_sid into n;
  return n;
end $f$;

-- One attempt to plant a record of a family whose columns p_vals names, as the transfer writes it: its `transferred`
-- creation event first (B 3.13), then the identity row with the identity table's columns, then, when p_vals names a
-- revision table's column, its revision row. Always undone. 'accepted' or 'refused: ...'.
create function pg_temp.w14_try_record(p_family text, p_vals jsonb) returns text language plpgsql as $f$
declare res text; id uuid := gen_random_uuid(); k text; h text; idv jsonb := '{}'; rv jsonb := '{}'; fkcol text;
begin
  for k in select jsonb_object_keys(p_vals) loop
    h := pg_temp.w14_home(p_family, k);
    if h is null then return format('refused: no column %s in %s or %s_revision (interface)', k, p_family, p_family); end if;
    if h = p_family then idv := idv || jsonb_build_object(k, p_vals -> k); else rv := rv || jsonb_build_object(k, p_vals -> k); end if;
  end loop;
  begin
    perform pg_temp.w14_event('transferred',
      pg_temp.w14_tpayload(pg_temp.w14_src(p_family, pg_temp.w14_tag() || '_' || p_family || '_' || left(id::text, 8))),
      p_family, id);
    perform pg_temp.w14_plant('devos_private.' || p_family, jsonb_build_object('id', id) || idv);
    if rv <> '{}'::jsonb then
      select a.attname into fkcol from pg_constraint con join pg_attribute a on a.attrelid = con.conrelid and a.attnum = con.conkey[1]
       where con.conrelid = to_regclass('devos_private.' || p_family || '_revision') and con.contype = 'f'
         and con.confrelid = to_regclass('devos_private.' || p_family) and cardinality(con.conkey) = 1 limit 1;
      if fkcol is null then
        raise exception 'w14: %_revision has no single-column foreign key to %', p_family, p_family;
      end if;
      perform pg_temp.w14_plant('devos_private.' || p_family || '_revision', jsonb_build_object(fkcol, id) || rv);
    end if;
    res := 'accepted';
    raise exception using errcode = 'P0W14', message = 'w14: undo the attempt';
  exception
    when sqlstate 'P0W14' then null;
    when others then res := 'refused: ' || sqlstate || ' ' || left(sqlerrm, 160);
  end;
  return res;
end $f$;

create function pg_temp.w14_pre() returns text language plpgsql as $f$
declare c text; p text[];
begin
  if to_regclass('devos_private.event') is null then return 'devos_private.event does not exist (B 3.13)'; end if;
  foreach c in array array['event_type', 'payload', 'aggregate_type', 'aggregate_id'] loop
    if not exists (select 1 from information_schema.columns x where x.table_schema = 'devos_private'
                     and x.table_name = 'event' and x.column_name = c) then
      return format('devos_private.event has no column %s (B 3.13)', c);
    end if;
  end loop;
  if (select data_type from information_schema.columns x where x.table_schema = 'devos_private'
        and x.table_name = 'event' and x.column_name = 'payload') <> 'jsonb' then
    return 'devos_private.event.payload is not jsonb (EV-C02-005 S2 indexes payload -> transfer_source)';
  end if;
  foreach p slice 1 in array array[array['decision', 'status'], array['finding', 'changeable'],
                                   array['finding', 'counter_evidence_searched'], array['artifact', 'kind'],
                                   array['acceptance', 'accepted_use']] loop
    if pg_temp.w14_home(p[1], p[2]) is null then
      return format('no column %s in devos_private.%s or %s_revision (B 3.17, 3.8, 3.10, 3.11)', p[2], p[1], p[1]);
    end if;
  end loop;
  return null;
end $f$;

do $$
declare why text; t text; r text; r2 text; tag text := pg_temp.w14_tag(); k text; n0 bigint; n1 bigint;
        accepted_any boolean := false; types text[] := array['transferred', 'transfer_run', 'ledger_entry', 'note_line',
        'record_line', 'usage_reading', 'batu_step', 'ledger_state_row']; res jsonb := '{}'; p jsonb; s jsonb;
        base text; v text; idx text; acc jsonb; src0 jsonb;
begin
  why := pg_temp.w14_pre();
  if why is not null then
    perform pg_temp.w14_rec('SCH-pre', 'could_not_check', why);
    return;
  end if;

  -- S1: the event types (positive controls). Each attempt undone.
  foreach t in array types loop
    p := case t
      when 'transferred' then pg_temp.w14_tpayload(pg_temp.w14_src('decision', tag || '_T1'))
      when 'transfer_run' then jsonb_build_object('run_id', gen_random_uuid()::text, 'input_commit',
             pg_temp.w14_hex('w14 input commit', 40), 'manifest_sha256', pg_temp.w14_hex('w14 manifest', 64),
             'counts', jsonb_build_object('decision', 1), 'phase', 'begun', 'mode', 'ahead')
      when 'ledger_entry' then jsonb_build_object('entry_id', tag || '_L-1', 'entry_date', '2026-10-14',
             'text', 'w14_fixture SYNTHETIC W-C02-14')
      else jsonb_build_object('w14_fixture', 'SYNTHETIC W-C02-14', 'source_id', tag || '_' || t, 'ordinal', 1,
             'text', 'w14_fixture SYNTHETIC W-C02-14') end;
    r := pg_temp.w14_try_event(t, p, case when t in ('note_line') then 'need'
                                          when t in ('transfer_run', 'ledger_state_row') then 'mission'
                                          when t = 'transferred' then 'decision' else 'work' end);
    if t = 'transfer_run' and r = 'accepted' then
      -- S1's other values of phase and mode, each in its own event.
      foreach s in array array['{"phase": "completed", "mode": "full"}'::jsonb, '{"phase": "begun", "mode": "full"}'::jsonb,
                               '{"phase": "completed", "mode": "verdict_copies"}'::jsonb] loop
        r2 := pg_temp.w14_try_event(t, p || s || jsonb_build_object('run_id', gen_random_uuid()::text), 'mission');
        if r2 <> 'accepted' then r := 'phase ' || (s ->> 'phase') || ', mode ' || (s ->> 'mode') || ': ' || r2; end if;
      end loop;
    end if;
    res := res || jsonb_build_object(t, r);
    accepted_any := accepted_any or r = 'accepted';
  end loop;
  foreach t in array types loop
    if accepted_any then
      perform pg_temp.w14_check('SCH-S1-type-' || t, res ->> t = 'accepted', 'event_type ' || t || ': ' || (res ->> t));
    else
      perform pg_temp.w14_rec('SCH-S1-type-' || t, 'could_not_check', 'no event of any S1 type could be planted, '
        || 'so the fixture, not a type, may be what is refused: ' || (res ->> t));
    end if;
  end loop;

  -- S2: the idempotency index. A base event is kept for the block, then undone with it. Outcomes are collected in
  -- acc (a PL/pgSQL variable survives the undo; a row of w14_results written inside the block would not) and
  -- recorded after it.
  acc := '[]';
  begin
    k := tag || '_D-901';
    base := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(pg_temp.w14_src('decision', k)), 'decision', true);
    if base <> 'accepted' then
      acc := (select jsonb_agg(jsonb_build_object('id', c, 'cond', null,
                'detail', 'the first transferred event of the key could not be planted: ' || base))
                from unnest(array['SCH-S2-dup-same', 'SCH-S2-dup-other', 'SCH-S2-pos-kind', 'SCH-S2-pos-sid']) c);
    else
      n0 := pg_temp.w14_count_key('decision', k);
      r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(pg_temp.w14_src('decision', k)), 'decision');
      n1 := pg_temp.w14_count_key('decision', k);
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'SCH-S2-dup-same', 'cond', r like 'refused%' and n1 = n0 and n0 = 1,
        'detail', format('a second transferred event, same kind, source ID and hash: %s; events of the key before %s, after %s', r, n0, n1)));
      r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(pg_temp.w14_src('decision', k, 'two')), 'decision');
      n1 := pg_temp.w14_count_key('decision', k);
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'SCH-S2-dup-other', 'cond', r like 'refused%' and n1 = n0 and n0 = 1,
        'detail', format('a second transferred event, same kind and source ID, another hash: %s; events of the key before %s, after %s', r, n0, n1)));
      r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(pg_temp.w14_src('need', k)), 'need');
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'SCH-S2-pos-kind', 'cond', r = 'accepted',
        'detail', 'same source ID, another kind: ' || r));
      r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(pg_temp.w14_src('decision', tag || '_D-902')), 'decision');
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'SCH-S2-pos-sid', 'cond', r = 'accepted',
        'detail', 'same kind, another source ID: ' || r));
    end if;
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception when sqlstate 'P0W14' then null;
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- S2 in the catalogue: a valid unique index on event over the two expressions, partial on transferred.
  select string_agg(i.indexrelid::regclass::text, ', ') into idx from pg_index i
   where i.indrelid = 'devos_private.event'::regclass and i.indisunique and i.indisvalid and i.indnatts = 2
     and i.indpred is not null and pg_get_expr(i.indpred, i.indrelid) like '%transferred%'
     and pg_get_indexdef(i.indexrelid) like '%transfer_source%' and pg_get_indexdef(i.indexrelid) like '%kind%'
     and pg_get_indexdef(i.indexrelid) like '%source_id%';
  perform pg_temp.w14_check('SCH-S2-cat', idx is not null,
    coalesce('unique partial index found: ' || idx, 'no valid unique index on devos_private.event over '
      || 'transfer_source kind and source_id with a predicate naming transferred'));

  -- S1: a transferred event needs its transfer_source, with every field, input_commit 40 hexadecimal characters.
  src0 := pg_temp.w14_src('decision', tag || '_R0');
  r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(src0), 'decision');
  if r <> 'accepted' then
    perform pg_temp.w14_rec(c, 'could_not_check', 'the well-formed transferred event (the positive control) was not accepted: ' || r)
      from unnest(array['SCH-S1-nosrc', 'SCH-S1-miss-kind', 'SCH-S1-miss-source_id', 'SCH-S1-miss-path',
                        'SCH-S1-miss-input_commit', 'SCH-S1-miss-last_commit', 'SCH-S1-miss-sha256', 'SCH-S1-commit',
                        'SCH-S1-null-kind', 'SCH-S1-null-source_id', 'SCH-S1-commit-nonhex', 'SCH-S1-commit-null',
                        'SCH-S1-src-array']) c;
  else
    r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(pg_temp.w14_src('decision', tag || '_R1')) - 'transfer_source', 'decision');
    perform pg_temp.w14_check('SCH-S1-nosrc', r like 'refused%', 'a transferred event with no transfer_source: ' || r);
    foreach t in array array['kind', 'source_id', 'path', 'input_commit', 'last_commit', 'sha256'] loop
      r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(pg_temp.w14_src('decision', tag || '_R2_' || t) - t), 'decision');
      perform pg_temp.w14_check('SCH-S1-miss-' || t, r like 'refused%', 'transfer_source without ' || t || ': ' || r);
    end loop;
    r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(pg_temp.w14_src('decision', tag || '_R3')
           || jsonb_build_object('input_commit', pg_temp.w14_hex('w14 input commit', 7))), 'decision');
    perform pg_temp.w14_check('SCH-S1-commit', r like 'refused%', 'input_commit of 7 hexadecimal characters: ' || r);
    -- Revision before any result (CHK-C02-066 C2 and C3): each case below is the well-formed event's own transfer_source
    -- (src0, accepted above) changed in one thing, so that event is its positive control. A key field that is JSON null
    -- gives the index's expression SQL NULL, and NULL keys are distinct, so the event would escape S2's key; a check of
    -- key existence alone (?&) admits it.
    foreach t in array array['kind', 'source_id'] loop
      r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(src0 || jsonb_build_object(t, null)), 'decision');
      perform pg_temp.w14_check('SCH-S1-null-' || t, r like 'refused%',
        'transfer_source with ' || t || ' JSON null, the other five fields well formed: ' || r);
    end loop;
    -- input_commit of 40 characters that are not hexadecimal, the length of the well-formed one, so a rule on length
    -- alone admits it: (a) none hexadecimal; (b) 39 hexadecimal and the 20th not. Both attempts under one case ID
    -- (w14_rec keeps the worse), so each must be refused.
    v := translate(src0 ->> 'input_commit', '0123456789abcdef', 'ghijklmnopqrstuv');
    r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(src0 || jsonb_build_object('input_commit', v)), 'decision');
    perform pg_temp.w14_check('SCH-S1-commit-nonhex', case when char_length(v) = 40 and v !~ '[0-9a-fA-F]' then r like 'refused%' end,
      format('input_commit of %s characters, none hexadecimal: %s', char_length(v), r));
    v := overlay(src0 ->> 'input_commit' placing 'z' from 20 for 1);
    r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(src0 || jsonb_build_object('input_commit', v)), 'decision');
    perform pg_temp.w14_check('SCH-S1-commit-nonhex', case when char_length(v) = 40 then r like 'refused%' end,
      format('input_commit of %s characters, the 20th not hexadecimal: %s', char_length(v), r));
    -- The designer's additions, same class (a value S1 requires that a check of existence or of NULL-tolerant form lets
    -- through): input_commit JSON null; transfer_source an array of the six field names instead of the object (?& is
    -- true for an array of those strings, and every ->> on it is SQL NULL, so it too escapes the key).
    r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(src0 || jsonb_build_object('input_commit', null)), 'decision');
    perform pg_temp.w14_check('SCH-S1-commit-null', r like 'refused%', 'input_commit JSON null, the other five fields well formed: ' || r);
    r := pg_temp.w14_try_event('transferred', pg_temp.w14_tpayload(src0) || jsonb_build_object('transfer_source',
           (select jsonb_agg(x order by x) from jsonb_object_keys(src0) x)), 'decision');
    perform pg_temp.w14_check('SCH-S1-src-array', r like 'refused%', 'transfer_source an array of its six field names, not an object: ' || r);
  end if;

  -- S1: at most one ledger_handed_over event (on the installation's Mission). Outcomes collected as for S2.
  acc := '[]';
  begin
    execute 'select count(*) from devos_private.event e where e.event_type::text = ''ledger_handed_over''' into n0;
    p := jsonb_build_object('run_id', gen_random_uuid()::text, 'input_commit', pg_temp.w14_hex('w14 input commit', 40),
           'mark_commit', pg_temp.w14_hex('w14 mark commit', 40), 'handed_over_sha256', pg_temp.w14_hex('w14 list', 64),
           'w14_fixture', 'SYNTHETIC W-C02-14');
    if n0 = 0 then
      r := pg_temp.w14_try_event('ledger_handed_over', p, 'mission', true);
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'SCH-S1-type-ledger_handed_over', 'cond', r = 'accepted',
        'detail', 'the first ledger_handed_over event: ' || r));
    else
      r := 'accepted';
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'SCH-S1-type-ledger_handed_over', 'cond', null,
        'detail', format('%s ledger_handed_over event(s) already in this database, so the first cannot be planted', n0)));
    end if;
    if r <> 'accepted' then
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'SCH-S1-handover-two', 'cond', null,
        'detail', 'no first ledger_handed_over event to repeat'));
    else
      execute 'select count(*) from devos_private.event e where e.event_type::text = ''ledger_handed_over''' into n0;
      r := pg_temp.w14_try_event('ledger_handed_over', p || jsonb_build_object('run_id', gen_random_uuid()::text), 'mission');
      execute 'select count(*) from devos_private.event e where e.event_type::text = ''ledger_handed_over''' into n1;
      acc := acc || jsonb_build_array(jsonb_build_object('id', 'SCH-S1-handover-two', 'cond', r like 'refused%' and n1 = n0,
        'detail', format('a second ledger_handed_over event: %s; such events before %s, after %s', r, n0, n1)));
    end if;
    raise exception using errcode = 'P0W14', message = 'w14: undo the block';
  exception when sqlstate 'P0W14' then null;
  end;
  perform pg_temp.w14_check(e ->> 'id', (e ->> 'cond')::boolean, e ->> 'detail') from jsonb_array_elements(acc) e;

  -- S3: Decision's status admits declined; the status is a value set (a status B 3.17 does not list is refused).
  base := pg_temp.w14_try_record('decision', '{"status": "open"}');
  if base <> 'accepted' then
    perform pg_temp.w14_rec(c, 'could_not_check', 'a Decision with status open (the base fixture) was not accepted: ' || base)
      from unnest(array['SCH-S3-declined', 'SCH-S3-closed']) c;
  else
    r := pg_temp.w14_try_record('decision', '{"status": "declined"}');
    perform pg_temp.w14_check('SCH-S3-declined', r = 'accepted', 'status declined: ' || r);
    r := pg_temp.w14_try_record('decision', '{"status": "w14_fixture_not_a_status"}');
    perform pg_temp.w14_check('SCH-S3-closed', r like 'refused%', 'a status B 3.17 does not list: ' || r);
  end if;

  -- S4, Finding: changeable is the value set yes / no / not_recorded; counter_evidence_searched takes not_recorded.
  -- Every Finding here names counter_evidence_searched, so each case differs from the base in one field only.
  s := '{"counter_evidence_searched": "w14_fixture SYNTHETIC W-C02-14: none found"}';
  base := pg_temp.w14_try_record('finding', s || '{"changeable": "yes"}');
  if base <> 'accepted' then
    perform pg_temp.w14_rec(c, 'could_not_check', 'a Finding with changeable yes (the base fixture) was not accepted: ' || base)
      from unnest(array['SCH-S4-chg-yes', 'SCH-S4-chg-no', 'SCH-S4-chg-nr', 'SCH-S4-chg-closed', 'SCH-S4-ces-nr']) c;
  else
    perform pg_temp.w14_check('SCH-S4-chg-yes', true, 'changeable yes: ' || base);
    foreach v in array array['no', 'not_recorded'] loop
      r := pg_temp.w14_try_record('finding', s || jsonb_build_object('changeable', v));
      perform pg_temp.w14_check(case v when 'no' then 'SCH-S4-chg-no' else 'SCH-S4-chg-nr' end, r = 'accepted', 'changeable ' || v || ': ' || r);
    end loop;
    r := pg_temp.w14_try_record('finding', s || '{"changeable": "w14_fixture_maybe"}');
    perform pg_temp.w14_check('SCH-S4-chg-closed', r like 'refused%', 'changeable outside yes / no / not_recorded: ' || r);
    r := pg_temp.w14_try_record('finding', '{"changeable": "yes", "counter_evidence_searched": "not_recorded"}');
    perform pg_temp.w14_check('SCH-S4-ces-nr', r = 'accepted', 'counter_evidence_searched not_recorded: ' || r);
  end if;

  -- S4, Artifact: kind admits git_file and git_tree (the base takes another value, so a break of these two leaves it).
  v := pg_temp.w14_other(pg_temp.w14_home('artifact', 'kind'), 'kind', array['git_file', 'git_tree']);
  base := pg_temp.w14_try_record('artifact', jsonb_build_object('kind', v));
  if base <> 'accepted' then
    perform pg_temp.w14_rec(c, 'could_not_check', 'an Artifact of another kind (the base fixture) was not accepted: ' || base)
      from unnest(array['SCH-S4-art-git_file', 'SCH-S4-art-git_tree']) c;
  else
    foreach v in array array['git_file', 'git_tree'] loop
      r := pg_temp.w14_try_record('artifact', jsonb_build_object('kind', v));
      perform pg_temp.w14_check('SCH-S4-art-' || v, r = 'accepted', 'kind ' || v || ': ' || r);
    end loop;
  end if;

  -- S4, Acceptance: accepted_use admits installation_acceptance.
  v := pg_temp.w14_other(pg_temp.w14_home('acceptance', 'accepted_use'), 'accepted_use', array['installation_acceptance']);
  base := pg_temp.w14_try_record('acceptance', jsonb_build_object('accepted_use', v));
  if base <> 'accepted' then
    perform pg_temp.w14_rec('SCH-S4-acc-use', 'could_not_check', 'an Acceptance of another use (the base fixture) was not accepted: ' || base);
  else
    r := pg_temp.w14_try_record('acceptance', '{"accepted_use": "installation_acceptance"}');
    perform pg_temp.w14_check('SCH-S4-acc-use', r = 'accepted', 'accepted_use installation_acceptance: ' || r);
  end if;
end $$;

select case_id, outcome, detail from w14_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w14_results;
  if nb > 0 then
    raise exception 'W14_SCH_TRANSFER_SCHEMA FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W14_SCH_TRANSFER_SCHEMA COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W14_SCH_TRANSFER_SCHEMA PASS (%/%)', n, n;
end $$;

rollback;
