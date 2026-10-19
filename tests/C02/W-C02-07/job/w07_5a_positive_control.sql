-- Synthetic test data (plan Section 8 item 13): the two work items and the working token are made up inside this
-- transaction (text 'w07_fixture SYNTHETIC W-C02-07', scope 'synthetic.w07fixture'). No personal or business data, no
-- credential; the token is kept in a PL/pgSQL variable only. Nothing is committed.
--
-- Claim: T-W07-5A's positive control (5A-pos): the change a direct INSERT may not make (a new relation row) is
-- accepted through its devos_api function, relate, as anon with a working token, so that T-W07-5A is not a check
-- that refuses everything (plan Section 8 item 2; W-C02-08 point 4: "The positive control ... runs with W-C02-09").
-- Specification: tests/C02/W-C02-07/T-W07-5A_no_direct_writes.md. Serves: W-C02-09 point 8.
-- Phase C5 (CHK-C02-030 C1): moved here, unchanged, from w07_5a_no_direct_writes.sql, so that the negatives file can
-- be copied on W-C02-08's build and this one on W-C02-09's (README 5.1 (c)). T-W07-5A is PASS only when both are.
-- Runs: in devos-test by the migration job's test step as postgres, once copied (README 5.1 (a), (c)); with B-5A-1's
-- file on the throwaway database. Safety: no psql meta-command; stops at its first error.
-- Revised under ledger rule 3, 2026-10-19 (N-291; EV-C02-013 section 17 (5) and 19 (5)), before any result of this
-- file: the two work items sit under a Mission opened through open_mission, so that Rule O can read its creation
-- event; see T-W07-5A's "Revision under ledger rule 3 (N-291, 2026-10-19)".
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '300s';
-- Common helpers (Group B of W-C02-07; copied into each file, since no file includes another: README 5.1 (a), 7).
-- w07_call calls a devos_api function the way the Data API calls a remote procedure: JSON keys bound to parameters
-- by name (a key k binds a parameter named k or p_k), as the role the publishable key reaches (anon), with the token
-- header simulated in request.headers (README 5.1 (a): transport sql-set-role). A call that cannot be formed (no such
-- function, a key without a parameter, a required parameter without a value) is reported under "interface", never
-- as a refusal. Tokens live only in PL/pgSQL variables; a token value found in a result or error is replaced before
-- anything is stored, and the call is flagged.
create temp table w07_results (case_id text primary key,
  outcome text not null check (outcome in ('ok', 'bad', 'could_not_check')), detail text not null);

create function pg_temp.w07_rec(p_id text, p_outcome text, p_detail text) returns void language sql as $f$
  insert into w07_results values (p_id, p_outcome, left(replace(coalesce(p_detail, ''), chr(10), ' '), 600))
  on conflict (case_id) do update set
    outcome = case when w07_results.outcome = 'bad' or excluded.outcome = 'bad' then 'bad'
                   when w07_results.outcome = 'could_not_check' or excluded.outcome = 'could_not_check'
                   then 'could_not_check' else 'ok' end,
    detail = left(w07_results.detail || ' | ' || excluded.detail, 1200)
$f$;

-- ok when p_cond is true, bad when false, could_not_check when null.
create function pg_temp.w07_check(p_id text, p_cond boolean, p_detail text) returns void language sql as $f$
  select pg_temp.w07_rec(p_id, case when p_cond then 'ok' when not p_cond then 'bad' else 'could_not_check' end,
                         p_detail)
$f$;

create function pg_temp.w07_call(p_fn text, p_args jsonb, p_token text, p_role text default 'anon',
                                 p_fill_null boolean default false) returns jsonb language plpgsql as $f$
declare
  n_over int; anames text[]; amodes "char"[]; atypes oid[]; nin int; ndef int; rset boolean; rtype oid;
  innames text[]; i int; k text; v jsonb; parts text[] := '{}'; used text[] := '{}'; q text; typ text;
  r jsonb; err text; t0 timestamptz; orig text := current_user; echoed boolean := false;
begin
  select count(*) into n_over from pg_proc p join pg_namespace n on n.oid = p.pronamespace
   where n.nspname = 'devos_api' and p.proname = p_fn;
  if n_over <> 1 then
    return jsonb_build_object('interface', format('devos_api.%s: %s definitions', p_fn, n_over));
  end if;
  select p.proargnames, p.proargmodes, array(select unnest(p.proargtypes)), p.pronargs, p.pronargdefaults,
         p.proretset, p.prorettype
    into anames, amodes, atypes, nin, ndef, rset, rtype
    from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'devos_api' and p.proname = p_fn;
  if amodes is null then
    innames := array(select anames[o] from generate_series(1, nin) o);
  else
    innames := array(select anames[o] from generate_subscripts(amodes, 1) o where amodes[o] in ('i', 'b', 'v') order by o);
  end if;
  for i in 1 .. nin loop
    k := null;
    if innames[i] is not null then
      if coalesce(p_args, '{}') ? innames[i] then k := innames[i];
      elsif innames[i] = 'p' and atypes[i] = 3802 then k := '*';  -- interface v1: a record's fields in p jsonb
      end if;
    end if;
    typ := format_type(atypes[i], null);
    if k = '*' then
      v := coalesce(p_args, '{}') - array_remove(innames, null); used := used || array(select jsonb_object_keys(v));
      parts := parts || format('%I => %L::jsonb', innames[i], v::text);
    elsif k is not null then
      v := p_args -> k; used := used || k;
      if jsonb_typeof(v) = 'null' then parts := parts || format('%I => null::%s', innames[i], typ);
      elsif atypes[i] in (114, 3802) then parts := parts || format('%I => %L::%s', innames[i], v::text, typ);
      elsif jsonb_typeof(v) = 'array' then
        parts := parts || format('%I => array(select jsonb_array_elements_text(%L::jsonb))::%s', innames[i], v::text, typ);
      else parts := parts || format('%I => %L::%s', innames[i], v #>> '{}', typ);
      end if;
    elsif i > nin - ndef then null;
    elsif p_fill_null and innames[i] is not null then parts := parts || format('%I => null::%s', innames[i], typ);
    else
      return jsonb_build_object('interface', format('devos_api.%s: parameter %s has no value', p_fn,
                                                    coalesce(innames[i], '$' || i)));
    end if;
  end loop;
  select x into k from jsonb_object_keys(coalesce(p_args, '{}')) x where not x = any(used) limit 1;
  if k is not null then
    return jsonb_build_object('interface', format('devos_api.%s: no parameter for key %s', p_fn, k));
  end if;
  if not exists (select 1 from pg_roles where rolname = p_role) or not pg_has_role(current_user, p_role, 'MEMBER') then
    return jsonb_build_object('interface', format('cannot act as role %s', p_role));
  end if;
  if rset then
    q := format('select coalesce(jsonb_agg(to_jsonb(w07_r)), ''[]''::jsonb) from devos_api.%I(%s) w07_r', p_fn,
                array_to_string(parts, ', '));
  elsif rtype = 2278 then
    q := format('select null::jsonb from (select devos_api.%I(%s)) w07_s', p_fn, array_to_string(parts, ', '));
  else
    q := format('select to_jsonb(devos_api.%I(%s))', p_fn, array_to_string(parts, ', '));
  end if;
  perform set_config('request.headers', case when p_token is null then '{}'
                     else json_build_object('x-devos-env-token', p_token)::text end, true);
  t0 := clock_timestamp();
  begin
    execute format('set local role %I', p_role);
    execute q into r;
    execute format('set local role %I', orig);
  exception when others then
    err := sqlstate || ' ' || left(sqlerrm, 200);
  end;
  perform set_config('request.headers', '', true);
  if p_token is not null and length(p_token) > 0 then
    if position(p_token in coalesce(err, '')) > 0 or position(p_token in coalesce(r::text, '')) > 0 then
      echoed := true;
      err := replace(err, p_token, '[a token value]');
      r := replace(r::text, p_token, '[a token value]')::jsonb;
    end if;
  end if;
  return jsonb_build_object('result', r, 'error', err, 'echoed', echoed,
                            'ms', round(extract(epoch from clock_timestamp() - t0) * 1000));
end $f$;

-- A call is refused when it raised (a privilege refusing a direct write raises), or returned status refused
-- (interface v1, README section 8; DM-19: a function returns its refusal, which T-W07-DM19 checks).
create function pg_temp.w07_refused(c jsonb) returns boolean language sql as $f$
  select coalesce(not (c ? 'interface') and (c->>'error' is not null
      or (coalesce(jsonb_typeof(c->'result'), '') = 'object' and (
            c->'result'->>'status' = 'refused'))), false)  -- interface v1 (README section 8)
$f$;

create function pg_temp.w07_show(c jsonb) returns text language sql as $f$
  select case when c ? 'interface' then 'interface: ' || (c->>'interface')
              else coalesce('raised ' || (c->>'error'), 'returned ' || left(coalesce(c->>'result', 'null'), 200))
                   || case when (c->>'echoed')::boolean then ' [A TOKEN VALUE WAS ECHOED]' else '' end end
$f$;

-- Row count and content hash of every devos_private table (env_tokens: count only, so nothing derived from a
-- token is computed). The hashes are compared, never printed.
create function pg_temp.w07_snap() returns jsonb language plpgsql as $f$
declare t record; j jsonb := '{}'; c bigint; h text;
begin
  for t in select cl.oid::regclass::text as rel, cl.relname from pg_class cl join pg_namespace n on n.oid = cl.relnamespace
           where n.nspname = 'devos_private' and cl.relkind in ('r', 'p') order by cl.relname loop
    if t.relname = 'env_tokens' then
      execute format('select count(*) from %s', t.rel) into c; h := '';
    else
      execute format('select count(*), coalesce(md5(string_agg(x::text, ''|'' order by x::text)), '''') from %s x',
                     t.rel) into c, h;
    end if;
    j := j || jsonb_build_object(t.relname, jsonb_build_array(c, h));
  end loop;
  return j;
end $f$;

create function pg_temp.w07_changed(a jsonb, b jsonb, p_except text[] default '{}') returns text[] language sql as $f$
  select coalesce(array_agg(k order by k), '{}') from jsonb_object_keys(a || b) k
   where a->k is distinct from b->k and not k = any(p_except)
$f$;

create function pg_temp.w07_ids(p_table text) returns text[] language plpgsql as $f$
declare a text[];
begin
  execute format('select coalesce(array_agg(id::text), ''{}'') from %s', p_table) into a;
  return a;
end $f$;

-- Plants one row as the owner (README 5.1 (a), "Fixtures"): the columns in p_vals take those values; every other
-- NOT NULL column without a default gets a synthetic value by its type, and a NOT NULL single-column foreign key a
-- newly planted parent row. Raises when it cannot; callers turn that into could_not_check.
create function pg_temp.w07_plant(p_table text, p_vals jsonb default '{}', p_depth int default 0)
returns jsonb language plpgsql as $f$
declare rel regclass := to_regclass(p_table); a record; j jsonb := coalesce(p_vals, '{}'); fk record;
        parent jsonb; cols text; r jsonb;
begin
  if rel is null then raise exception 'w07 plant: % does not exist', p_table; end if;
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
      if p_depth >= 4 then raise exception 'w07 plant: foreign keys nest deeper than 4 from %', p_table; end if;
      parent := pg_temp.w07_plant(fk.ptab, '{}', p_depth + 1);
      j := j || jsonb_build_object(a.attname, parent -> fk.pcol);
      continue;
    end if;
    j := j || jsonb_build_object(a.attname, case
      when a.typtype = 'e' then to_jsonb((select e.enumlabel from pg_enum e where e.enumtypid = a.atttypid
                                          order by e.enumsortorder limit 1))
      when a.typname = 'uuid' then to_jsonb(gen_random_uuid())
      when a.typname in ('text', 'varchar', 'bpchar', 'name', 'citext') then
        to_jsonb(case when a.attname like '%scope%' then 'synthetic.w07fixture' else 'w07_fixture SYNTHETIC W-C02-07' end)
      when a.typcategory = 'N' then to_jsonb(1)
      when a.typname = 'bool' then to_jsonb(false)
      when a.typname in ('timestamptz', 'timestamp') then to_jsonb(now())
      when a.typname = 'date' then to_jsonb(current_date)
      when a.typname in ('json', 'jsonb') then case when a.attname ~ '(s|refs|spans)$' then '[]'::jsonb else '{}'::jsonb end
      when a.typcategory = 'A' then '[]'::jsonb
      else null end);
    if j -> a.attname is null or jsonb_typeof(j -> a.attname) = 'null' then
      raise exception 'w07 plant: no synthetic value for %.% of type %', p_table, a.attname, a.typname;
    end if;
  end loop;
  select string_agg(quote_ident(x), ', ') into cols from jsonb_object_keys(j) x;
  if cols is null then
    execute format('insert into %s as w07_x default values returning to_jsonb(w07_x)', rel) into r;
    return r;
  end if;
  execute format('insert into %s as w07_x (%s) select %s from jsonb_populate_record(null::%s, $1) returning to_jsonb(w07_x)',
                 rel, cols, cols, rel) using j into r;
  return r;
end $f$;

-- Issues a synthetic token as the owner, inside this rolled-back transaction (EV-C02-003 §6.3).
create function pg_temp.w07_token(p_class text) returns text language plpgsql as $f$
declare t text;
begin
  execute 'select devos_private.issue_env_token($1)::text' using p_class into t;
  if t like '{%' then t := t::jsonb ->> 'token'; end if;
  return t;
end $f$;

-- RejectedAttempt rows of one function (its name with or without the schema), as written since p_after.
create function pg_temp.w07_ra(p_fn text, p_after text[] default '{}') returns jsonb language plpgsql as $f$
declare r jsonb;
begin
  execute 'select coalesce(jsonb_agg(to_jsonb(x) - ''id''), ''[]'') from devos_private.rejected_attempt x
            where x.function_name in ($1, ''devos_api.'' || $1) and not x.id::text = any($2)'
     using p_fn, p_after into r;
  return r;
end $f$;

-- The roles under test: Supabase's anon and authenticated (the publishable key's roles), authenticator (the Data
-- API's login, which the key reaches), and every database role named for a role class (B section 2), where it exists.
create function pg_temp.w07_roles() returns text[] language sql as $f$
  select array(select rolname from pg_roles where rolname in ('anon', 'authenticated', 'authenticator',
    'devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum', 'devos_ci', 'devos_backup', 'devos_ingest')
    order by rolname)
$f$;

-- Reads granted by name (W-C02-08 point 4: "each read so granted is listed with its reason"). EV-C02-003 grants none:
-- every read goes through a devos_api function (section 4.1). A grant added later is listed here with its reason.
create function pg_temp.w07_granted_reads() returns text[] language sql as $f$ select '{}'::text[] $f$;

create function pg_temp.w07_pre() returns text language plpgsql as $f$
begin
  if to_regnamespace('devos_private') is null then return 'schema devos_private does not exist'; end if;
  if not exists (select 1 from pg_class c join pg_namespace n on n.oid = c.relnamespace
                  where n.nspname = 'devos_private' and c.relkind in ('r', 'p')) then
    return 'devos_private has no table';
  end if;
  if not exists (select 1 from pg_roles where rolname = 'anon') or not exists (select 1 from pg_roles where rolname = 'authenticated') then
    return 'role anon or authenticated does not exist';
  end if;
  return null;
end $f$;

-- Revised under ledger rule 3, before any result (N-291; EV-C02-013 section 17 (5) and 19 (5); 2026-10-19). The Mission
-- 5A-pos's two work items sit under, copied from job/w07_f06_state_change_event.sql's pg_temp.f06_rule_o_mission
-- (N-285 (1)). Rule O reads the work item's revision, the Mission revision it names and that Mission's creation event
-- (EV-C02-013 2.3, "What Rule O reads"); a Mission w07_plant makes has no event, so Rule O answers could_not_check and
-- relate refuses the control on a correct build. This Mission is opened through open_mission with the devos_kurulum
-- token, on an owner-planted batu Decision answered at revision 1, scope synthetic.w07fixture. Its creation event is
-- mission_opened, not transferred, so the devos_calisma call is inside Rule O's cal clause (EV-C02-008 1.7.1).
-- Returns the Mission revision row; raises when it cannot be made, and the caller turns that into could_not_check.
create function pg_temp.w07_rule_o_mission(p_kur text) returns jsonb language plpgsql as $f$
declare dc jsonb; c jsonb; r jsonb;
begin
  dc := pg_temp.w07_plant('devos_private.decision', '{"class": "batu", "status": "answered", "answered_revision": 1}');
  perform pg_temp.w07_plant('devos_private.decision_revision', jsonb_build_object('decision_id', dc->'id', 'revision', 1));
  c := pg_temp.w07_call('open_mission', jsonb_build_object('purpose', 'w07_fixture SYNTHETIC W-C02-07 Rule O mission; not work',
         'scope', 'synthetic.w07fixture', 'owner_authority', dc->'id', 'owner_authority_revision', 1,
         'acceptance', 'w07_fixture SYNTHETIC W-C02-07', 'constraints', '[]'::jsonb), p_kur);
  if c ? 'interface' or c->>'error' is not null or c->'result'->>'status' is distinct from 'ok' then
    raise exception 'the Rule O fixture Mission was not opened: %', pg_temp.w07_show(c);
  end if;
  execute 'select to_jsonb(x) from devos_private.mission_revision x where x.mission_id::text = $1 order by x.revision desc limit 1'
     into r using c->'result'->>'id';
  if r is null then raise exception 'the Rule O fixture Mission has no revision row'; end if;
  return r;
end $f$;

-- One statement as one role, in a subtransaction that is always undone. Returns the SQLSTATE, or 'none'.
create function pg_temp.w07_try(p_role text, p_sql text) returns text language plpgsql as $f$
declare st text := 'none'; orig text := current_user;
begin
  begin
    execute format('set local role %I', p_role);
    begin
      execute p_sql;
    exception when others then st := sqlstate;
    end;
    execute format('set local role %I', orig);
    raise exception using errcode = 'P0W07', message = 'w07: undo the attempt';
  exception when sqlstate 'P0W07' then null;
            when others then st := 'setup:' || sqlstate;
  end;
  return st;
end $f$;

do $$
declare why text; t_cal text; a jsonb; b jsonb; c jsonb; n0 bigint; n1 bigint; om jsonb;
begin
  why := pg_temp.w07_pre();
  if why is not null then
    perform pg_temp.w07_rec('5A-pre', 'could_not_check', why);
    return;
  end if;
  if to_regprocedure('devos_api.relate(jsonb)') is null and not exists (
       select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'devos_api' and p.proname = 'relate') then
    perform pg_temp.w07_rec('5A-pos', 'could_not_check', 'devos_api.relate does not exist (W-C02-09 builds it)');
    return;
  end if;
  -- 5A-pos: the same kind of change (a new relation row) through devos_api.relate, as anon with a working token.
  begin
    t_cal := pg_temp.w07_token('devos_calisma');
    -- Revised under ledger rule 3 (N-291, 2026-10-19): both work items under the Rule O Mission.
    om := pg_temp.w07_rule_o_mission(pg_temp.w07_token('devos_kurulum'));
    a := pg_temp.w07_plant('devos_private.work_revision', jsonb_build_object('mission_revision_id', om->'id'));
    b := pg_temp.w07_plant('devos_private.work_revision', jsonb_build_object('mission_revision_id', om->'id'));
  exception when others then
    perform pg_temp.w07_rec('5A-pos', 'could_not_check', 'fixtures could not be made: ' || sqlstate || ' ' || left(sqlerrm, 200));
    return;
  end;
  execute 'select count(*) from devos_private.relation' into n0;
  c := pg_temp.w07_call('relate', jsonb_build_object('type', 'about', 'from_ref', a->'work_id', 'from_revision', a->'revision',
         'to_ref', b->'work_id', 'to_revision', b->'revision', 'scope', 'synthetic.w07fixture', 'hard', false,
         'method', 'recorded', 'epistemic_status', 'inference'), t_cal);
  execute 'select count(*) from devos_private.relation' into n1;
  if c ? 'interface' then
    perform pg_temp.w07_rec('5A-pos', 'could_not_check', pg_temp.w07_show(c));
  else
    perform pg_temp.w07_check('5A-pos', not pg_temp.w07_refused(c) and n1 = n0 + 1,
      pg_temp.w07_show(c) || format('; relation rows %s -> %s', n0, n1));
  end if;
end $$;

select case_id, outcome, detail from w07_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w07_results;
  if nb > 0 then
    raise exception 'W07_5A_POSITIVE_CONTROL FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W07_5A_POSITIVE_CONTROL COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W07_5A_POSITIVE_CONTROL PASS (%/%)', n, n;
end $$;

rollback;
