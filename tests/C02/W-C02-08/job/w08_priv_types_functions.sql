-- Synthetic test data (plan Section 8 item 13): the objects planted here are made up inside this transaction and go
-- with its rollback: the enum types devos_private.w08_fixture_type_closed, _public, _anon and _default (one label,
-- 'SYNTHETIC W-C02-08') and the functions devos_private.w08_fixture_fn_closed(), _public() and _default() (each returns
-- 1), each commented 'SYNTHETIC W-C02-08 fixture of T-W08-PRIV (rolled back)'. No personal or business data, no
-- credential. Nothing is committed.
--
-- Claim: no privilege on a type or a function of devos_private is held by anyone but the object's owner. (1) No grantee
-- but the owner in the ACL of any type that keeps privileges of its own (true array types keep none: PostgreSQL
-- refuses GRANT and REVOKE on them, 0LP01, and checks the element type instead). (2) USAGE on no type, arrays
-- included, and (3) EXECUTE on no function, for public, anon, authenticated, authenticator and
-- service_role, by PostgreSQL's own has_type_privilege and has_function_privilege; and no grantee but the owner in any
-- function's ACL. W-C02-08 point 4 ("no privilege on devos_private or its objects for an application role or PUBLIC"),
-- in devos-test, as CHK-C02-070 C2 asks. Specification: tests/C02/W-C02-08/T-W08-PRIV_type_function_privileges.md.
-- Serves: W-C02-08 point 4, the types and functions of devos_private in devos-test (CHK-C02-070 C2). Written after
-- W-C02-08's build and its devos catalogue read were seen: it observes in devos-test what was read in devos, because no
-- other route reads devos-test's catalogue, and it changes no acceptance condition.
-- Runs: in devos-test by the migration job's test step as postgres, once its byte-for-byte copy is in
-- supabase/migrations/tests/; with its break on the throwaway database (W-C02-07's harness). The objects are read from
-- the catalogue at run time, so a type or function a later migration adds to devos_private is covered without editing
-- this file. devos_api's functions are not read: W-C02-09 grants some of them to roles by design.
-- Controls: the planted objects above are read by the same loop and the same two readings as the real objects. An open
-- plant must read bad, a closed one ok; a control that does not hold makes its row could_not_check, so the run is
-- COULD NOT CHECK, never a pass (the pattern of w03_fixture_apply_read.sql, whose planted variant "not red as it must
-- be" gives COULD NOT CHECK). A control row is ok when the control held, so it never fails the run.
-- Result: NOTICE "W08_PRIV_TYPES_FUNCTIONS PASS (n/n)"; FAIL and COULD NOT CHECK raise, so the step fails and go is
-- not yes. Safety: one transaction that ends in rollback; no psql meta-command; no backslash anywhere; stops at its
-- first error.
begin;
set local search_path = pg_catalog, pg_temp;
set local statement_timeout = '60s';

create temp table w08_results (case_id text primary key,
  outcome text not null check (outcome in ('ok', 'bad', 'could_not_check')), detail text not null);

-- As W-C02-07's w07_rec: a case recorded twice keeps the worse outcome and both details.
create function pg_temp.w08_rec(p_id text, p_outcome text, p_detail text) returns void language sql as $f$
  insert into w08_results values (p_id, p_outcome, left(replace(coalesce(p_detail, ''), chr(10), ' '), 900))
  on conflict (case_id) do update set
    outcome = case when w08_results.outcome = 'bad' or excluded.outcome = 'bad' then 'bad'
                   when w08_results.outcome = 'could_not_check' or excluded.outcome = 'could_not_check'
                   then 'could_not_check' else 'ok' end,
    detail = left(w08_results.detail || ' | ' || excluded.detail, 1500)
$f$;

-- ok when p_cond is true, bad when false, could_not_check when null.
create function pg_temp.w08_check(p_id text, p_cond boolean, p_detail text) returns void language sql as $f$
  select pg_temp.w08_rec(p_id, case when p_cond then 'ok' when not p_cond then 'bad' else 'could_not_check' end,
                         p_detail)
$f$;

-- The roles CHK-C02-070 C2 names. public is PostgreSQL's pseudo-role that every role belongs to; it always exists.
create function pg_temp.w08_roles() returns text[] language sql as $f$
  select array['public', 'anon', 'authenticated', 'authenticator', 'service_role']
$f$;

create function pg_temp.w08_role_exists(p text) returns boolean language sql as $f$
  select p = 'public' or exists (select 1 from pg_roles where rolname = p)
$f$;

-- A type that keeps no privileges of its own: a true array type (PostgreSQL's own test, IsTrueArrayType; it checks the
-- element type). Its ACL is not read; USAGE on it is. Every other type's ACL is read, a multirange's (it keeps its own
-- on PostgreSQL 16) and a domain's over an array (category A, its own ACL) included.
create function pg_temp.w08_follows(p oid) returns boolean language sql as $f$
  select t.typelem <> 0 and t.typsubscript = 'pg_catalog.array_subscript_handler'::pg_catalog.regproc
    from pg_type t where t.oid = p
$f$;

-- The grantees other than the owner in an ACL, each as 'GRANTEE PRIVILEGE', read as PostgreSQL applies the ACL: a null
-- ACL is the built-in default (acldefault: USAGE to PUBLIC on a type, EXECUTE to PUBLIC on a function, and the
-- owner's). An empty array when there are none.
create function pg_temp.w08_others(p_acl aclitem[], p_kind "char", p_owner oid) returns text[] language sql as $f$
  select coalesce(array_agg(g order by g), '{}') from (
    select case when a.grantee = 0 then 'PUBLIC' else pg_get_userbyid(a.grantee)::text end || ' ' || a.privilege_type
           || case when a.is_grantable then ' WITH GRANT OPTION' else '' end as g
      from aclexplode(coalesce(p_acl, acldefault(p_kind, p_owner))) a
     where a.grantee <> p_owner) x
$f$;

-- The roles of w08_roles() that hold the privilege by PostgreSQL's own check (membership, PUBLIC and an array's element
-- type counted). A role that does not exist is not asked; the caller records it as could_not_check.
create function pg_temp.w08_holders(p_oid oid, p_kind text) returns text[] language plpgsql as $f$
declare r text; h text[] := '{}';
begin
  foreach r in array pg_temp.w08_roles() loop
    continue when not pg_temp.w08_role_exists(r);
    if p_kind = 'type' then
      if has_type_privilege(r::name, p_oid, 'USAGE') then h := h || r; end if;
    else
      if has_function_privilege(r::name, p_oid, 'EXECUTE') then h := h || r; end if;
    end if;
  end loop;
  return h;
end $f$;

-- Plants one synthetic object in devos_private as the owner, inside this transaction (W-C02-07's README 5.1 (a),
-- "Fixtures"). p_state: 'default' (as created); 'closed' (revoked from PUBLIC and from anon, authenticated,
-- authenticator and service_role where they exist, as the migrations close theirs); 'public' or 'anon' (closed, then
-- USAGE or EXECUTE granted to PUBLIC or to anon). Returns its oid, or raises.
create function pg_temp.w08_plant(p_kind text, p_state text) returns oid language plpgsql as $f$
declare nm text := 'w08_fixture_' || case when p_kind = 'type' then 'type_' else 'fn_' end || p_state;
        obj text; o oid; r text; priv text := case when p_kind = 'type' then 'usage' else 'execute' end;
begin
  if p_kind = 'type' then
    execute format('create type devos_private.%I as enum (%L)', nm, 'SYNTHETIC W-C02-08');
    obj := format('type devos_private.%I', nm);
    o := to_regtype(format('devos_private.%I', nm));
  else
    execute format('create function devos_private.%I() returns integer language sql as %L', nm, 'select 1');
    obj := format('function devos_private.%I()', nm);
    o := to_regprocedure(format('devos_private.%I()', nm));
  end if;
  if o is null then raise exception 'w08 plant: % was not found after its creation', obj; end if;
  execute format('comment on %s is %L', obj, 'SYNTHETIC W-C02-08 fixture of T-W08-PRIV (rolled back)');
  if p_state <> 'default' then
    execute format('revoke all on %s from public', obj);
    foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
      if exists (select 1 from pg_roles where rolname = r) then
        execute format('revoke all on %s from %I', obj, r);
      end if;
    end loop;
  end if;
  if p_state = 'public' then
    execute format('grant %s on %s to public', priv, obj);
  elsif p_state = 'anon' then
    if not exists (select 1 from pg_roles where rolname = 'anon') then
      raise exception 'w08 plant: role anon does not exist';
    end if;
    execute format('grant %s on %s to anon', priv, obj);
  end if;
  return o;
end $f$;

create temp table w08_plants (key text primary key, oid oid, why text);
-- Every type and function of devos_private as the loop saw it, plants included.
create temp table w08_seen (kind text, oid oid, name text, display text, typtype "char", elem oid, follows boolean,
  owner text, acl text, has_null_acl boolean, others text[], holders text[], plant text);

do $$
declare k text; o oid; why text; n int; nown int; nfol int; nf int; fns text; kinds text; r text; held text;
        p w08_plants%rowtype; s w08_seen%rowtype; a w08_seen%rowtype; ok boolean;
begin
  if to_regnamespace('devos_private') is null then
    perform pg_temp.w08_rec('PRIV-pre', 'could_not_check', 'schema devos_private does not exist');
    return;
  end if;
  raise notice 'W08_PRIV server: PostgreSQL %, database %, session user %, current user %, read at % UTC',
    current_setting('server_version'), current_database(), session_user, current_user,
    to_char(clock_timestamp() at time zone 'utc', 'YYYY-MM-DD"T"HH24:MI:SS"Z"');

  -- The planted controls (synthetic), each in its own subtransaction: one that cannot be planted is recorded with why.
  foreach k in array array['type:closed', 'type:public', 'type:anon', 'type:default',
                           'function:closed', 'function:public', 'function:default'] loop
    begin
      o := pg_temp.w08_plant(split_part(k, ':', 1), split_part(k, ':', 2));
      insert into w08_plants values (k, o, null);
    exception when others then
      insert into w08_plants values (k, null, sqlstate || ' ' || left(sqlerrm, 200));
    end;
  end loop;

  -- One loop over every type and every function of devos_private, real and planted alike.
  insert into w08_seen
  select 'type', ty.oid, ty.typname::text, replace(format_type(ty.oid, null), 'devos_private.', ''), ty.typtype,
         ty.typelem, pg_temp.w08_follows(ty.oid), pg_get_userbyid(ty.typowner)::text,
         coalesce(ty.typacl::text, 'null (the default ' || acldefault('T', ty.typowner)::text || ')'), ty.typacl is null,
         case when pg_temp.w08_follows(ty.oid) then null else pg_temp.w08_others(ty.typacl, 'T', ty.typowner) end,
         pg_temp.w08_holders(ty.oid, 'type'), null
    from pg_type ty join pg_namespace n on n.oid = ty.typnamespace
   where n.nspname = 'devos_private';
  insert into w08_seen
  select 'function', pr.oid, pr.proname::text, replace(pr.oid::regprocedure::text, 'devos_private.', ''), null, null,
         false, pg_get_userbyid(pr.proowner)::text,
         coalesce(pr.proacl::text, 'null (the default ' || acldefault('f', pr.proowner)::text || ')'), pr.proacl is null,
         pg_temp.w08_others(pr.proacl, 'f', pr.proowner), pg_temp.w08_holders(pr.oid, 'function'), null
    from pg_proc pr join pg_namespace n on n.oid = pr.pronamespace
   where n.nspname = 'devos_private';
  -- A plant, and a planted type's array, belong to its control; everything else is judged as real.
  update w08_seen x set plant = pl.key from w08_plants pl
   where pl.oid is not null and x.kind = split_part(pl.key, ':', 1)
     and (x.oid = pl.oid or (x.kind = 'type' and x.follows and x.elem = pl.oid));

  -- Positive control: the readings see the real objects.
  select count(*) filter (where kind = 'type'), count(*) filter (where kind = 'type' and not follows),
         count(*) filter (where kind = 'type' and follows), count(*) filter (where kind = 'function'),
         string_agg(display, ', ' order by display) filter (where kind = 'function')
    into n, nown, nfol, nf, fns from w08_seen where plant is null;
  select string_agg(format('%s %s', c, t), ', ' order by t) into kinds from (
    select case typtype when 'e' then 'enum' when 'c' then 'composite' when 'd' then 'domain' when 'r' then 'range'
                        when 'm' then 'multirange' when 'b' then case when follows then 'true array' else 'base' end
                        else 'other' end as t, count(*) as c
      from w08_seen where kind = 'type' and plant is null group by 1) x;
  perform pg_temp.w08_check('PRIV-pos', case when nown > 0 and nf > 0 then true end,
    format('the readings saw %s types of devos_private (%s), %s of them with privileges of their own and %s true array '
           'types, and %s function(s): %s', n, coalesce(kinds, 'none'), nown, nfol, nf, coalesce(fns, 'none'))
    || case when nown > 0 and nf > 0 then '' else '; with no type or no function the checks below would hold vacuously' end);

  -- (1) Each real type that keeps privileges of its own: no grantee but its owner.
  perform pg_temp.w08_check('PRIV-tacl:' || replace(x.name, ' ', '_'), cardinality(x.others) = 0,
    format('owner %s; ACL %s; grantees other than the owner: %s', x.owner, x.acl,
           coalesce(nullif(array_to_string(x.others, ', '), ''), 'none')))
    from w08_seen x where x.kind = 'type' and x.plant is null and not x.follows;
  -- (3) Each real function: no grantee but its owner.
  perform pg_temp.w08_check('PRIV-facl:' || replace(x.display, ' ', '_'), cardinality(x.others) = 0,
    format('owner %s; ACL %s; grantees other than the owner: %s', x.owner, x.acl,
           coalesce(nullif(array_to_string(x.others, ', '), ''), 'none')))
    from w08_seen x where x.kind = 'function' and x.plant is null;

  -- (2) and (3) by role: USAGE on no real type, arrays included, and EXECUTE on no real function.
  foreach r in array pg_temp.w08_roles() loop
    if not pg_temp.w08_role_exists(r) then
      perform pg_temp.w08_rec('PRIV-tuse:' || r, 'could_not_check',
        format('role %s does not exist in this database, so has_type_privilege could not be asked for it', r));
      perform pg_temp.w08_rec('PRIV-fexec:' || r, 'could_not_check',
        format('role %s does not exist in this database, so has_function_privilege could not be asked for it', r));
      continue;
    end if;
    select string_agg(display, ', ' order by display) filter (where r = any(holders)) into held
      from w08_seen where kind = 'type' and plant is null;
    perform pg_temp.w08_check('PRIV-tuse:' || r, case when n > 0 then held is null end,
      format('has_type_privilege(%s, type, USAGE) asked on all %s types of devos_private (%s true array); '
             'true on: %s', r, n, nfol, coalesce(held, 'none')));
    select string_agg(display, ', ' order by display) filter (where r = any(holders)) into held
      from w08_seen where kind = 'function' and plant is null;
    perform pg_temp.w08_check('PRIV-fexec:' || r, case when nf > 0 then held is null end,
      format('has_function_privilege(%s, function, EXECUTE) asked on all %s function(s) of devos_private; true on: %s',
             r, nf, coalesce(held, 'none')));
  end loop;

  -- The planted controls, judged from what the same loop and readings gave on them. Open plants must read bad (shown in
  -- the detail as "readings: bad"), closed ones ok; a control that does not hold is could_not_check.
  for p in select * from w08_plants order by key loop
    k := 'PRIV-ctl-' || replace(p.key, ':', '-');
    if p.oid is null then
      perform pg_temp.w08_rec(k, 'could_not_check', 'the synthetic plant could not be made: ' || p.why);
      continue;
    end if;
    select * into s from w08_seen where oid = p.oid and plant = p.key and kind = split_part(p.key, ':', 1);
    if not found then
      perform pg_temp.w08_rec(k, 'could_not_check', 'the synthetic plant was made but the loop did not select it');
      continue;
    end if;
    a := null;
    if s.kind = 'type' then
      select * into a from w08_seen where plant = p.key and follows and elem = p.oid;
      if a.oid is null then
        perform pg_temp.w08_rec(k, 'could_not_check', 'the synthetic type''s array type was not selected by the loop');
        continue;
      end if;
    end if;
    why := format('%s %s, owner %s, ACL %s; grantees other than the owner: %s; %s held by: %s%s', s.kind, s.display,
                  s.owner, s.acl, coalesce(nullif(array_to_string(s.others, ', '), ''), 'none'),
                  case when s.kind = 'type' then 'USAGE' else 'EXECUTE' end,
                  coalesce(nullif(array_to_string(s.holders, ', '), ''), 'none'),
                  case when s.kind = 'type' then format('; its array %s, USAGE held by: %s', a.display,
                       coalesce(nullif(array_to_string(a.holders, ', '), ''), 'none')) else '' end);
    if split_part(p.key, ':', 2) = 'closed' then
      ok := cardinality(s.others) = 0 and cardinality(s.holders) = 0 and (s.kind <> 'type' or cardinality(a.holders) = 0);
      perform pg_temp.w08_rec(k, case when ok then 'ok' else 'could_not_check' end,
        case when ok then 'control held (positive): readings: ok on the planted owner-only synthetic '
             else 'control did not hold: the readings refuse an owner-only synthetic ' end || why);
    elsif split_part(p.key, ':', 2) = 'public' then
      ok := (case when s.kind = 'type' then 'PUBLIC USAGE' else 'PUBLIC EXECUTE' end) = any(s.others)
            and 'public' = any(s.holders) and (s.kind <> 'type' or 'public' = any(a.holders));
      perform pg_temp.w08_rec(k, case when ok then 'ok' else 'could_not_check' end,
        case when ok then 'control held (negative): readings: bad on the synthetic '
             else 'control did not hold: the readings do not see the grant to PUBLIC on the synthetic ' end || why);
    elsif split_part(p.key, ':', 2) = 'anon' then
      ok := 'anon USAGE' = any(s.others) and 'anon' = any(s.holders) and not 'public' = any(s.holders)
            and 'anon' = any(a.holders);
      perform pg_temp.w08_rec(k, case when ok then 'ok' else 'could_not_check' end,
        case when ok then 'control held (negative): readings: bad on the synthetic '
             else 'control did not hold: the readings do not see the grant to anon alone on the synthetic ' end || why);
    else
      -- Left at its creation ACL: the ACL reading must name PUBLIC exactly when PostgreSQL's check gives PUBLIC the
      -- privilege. Under PostgreSQL's built-in default (a null ACL) both do, and the readings give bad; a database whose
      -- default privileges close new objects is told apart by the detail ("not exercised").
      ok := ((case when s.kind = 'type' then 'PUBLIC USAGE' else 'PUBLIC EXECUTE' end) = any(s.others))
            = ('public' = any(s.holders));
      perform pg_temp.w08_rec(k, case when ok then 'ok' else 'could_not_check' end,
        case when not ok then 'control did not hold: the ACL reading and PostgreSQL''s privilege check disagree on PUBLIC for the synthetic '
             when 'public' = any(s.holders) then 'control held (negative): readings: bad on the synthetic '
             else 'control held but not exercised (this database''s default privileges give a new object no PUBLIC grant): readings: ok on the synthetic ' end
        || why || case when s.has_null_acl then '; its ACL is null, read through acldefault' else '; its ACL is not null' end);
    end if;
  end loop;
end $$;

select case_id, outcome, detail from w08_results order by case_id;

do $$
declare nb int; nc int; n int;
begin
  select count(*) filter (where outcome = 'bad'), count(*) filter (where outcome = 'could_not_check'), count(*)
    into nb, nc, n from w08_results;
  if nb > 0 then
    raise exception 'W08_PRIV_TYPES_FUNCTIONS FAIL (% bad, % could not check, of %)', nb, nc, n;
  elsif nc > 0 or n = 0 then
    raise exception 'W08_PRIV_TYPES_FUNCTIONS COULD NOT CHECK (% of % could not be checked)', nc, n;
  end if;
  raise notice 'W08_PRIV_TYPES_FUNCTIONS PASS (%/%)', n, n;
end $$;

rollback;
