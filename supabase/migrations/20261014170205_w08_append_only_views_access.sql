-- DevOS schema (W-C02-08), not a fixture. Part 5 of 5: append-only revisions and observations, the current views, and
-- the access rules (C02 task 4).
-- Sources: plan/work/W-C02-08.md points 3 and 4; plan 6.2 ("devos_private (all tables, closed to the outside) and
-- devos_api (functions only)"); Appendix B principles 1 and 3, 3.12; EV-C02-002 DM-02; EV-C02-003 section 4.1 (last row:
-- no role class writes any table directly); tests/C02/W-C02-07/README.md section 8.1 ("anon ... has USAGE on devos_api").
-- Record: evidence/C02/EV-C02-012_schema_roles_access.md.

-- Append-only (DM-02: "The revision table refuses update and delete to every role"; TRUNCATE counts as a delete, the
-- executor's decision in T-W07-DM02; B 3.12: "Observations are appended, not deleted"). The refusal holds for the owner too.
create function devos_private.refuse_change() returns trigger
language plpgsql
set search_path = pg_catalog, pg_temp
as $fn$
begin
  raise exception using errcode = 'restrict_violation',
    message = format('%s.%s is append-only: %s refused', tg_table_schema, tg_table_name, tg_op);
end
$fn$;
revoke all on function devos_private.refuse_change() from public;

do $$
declare t text;
begin
  foreach t in array array['mission_revision', 'decision_revision', 'work_revision', 'finding_revision',
                           'artifact_revision', 'observation'] loop
    execute format('create trigger %I before update or delete on devos_private.%I for each row '
                   'execute function devos_private.refuse_change()', t || '_append_only', t);
    execute format('create trigger %I before truncate on devos_private.%I for each statement '
                   'execute function devos_private.refuse_change()', t || '_no_truncate', t);
  end loop;
end
$$;

-- The current form of each family with revisions (DM-02: "the current form is a view"). Each runs with its caller's
-- privileges, so it never reads a table on its owner's behalf.
create view devos_private.mission_current with (security_invoker = true) as
  select m.id, r.revision, m.status, r.purpose, r.scope, r.constraints, r.acceptance, r.owner_authority,
         m.created_at, r.created_at as revised_at
    from devos_private.mission m
    join lateral (select * from devos_private.mission_revision x where x.mission_id = m.id
                   order by x.revision desc limit 1) r on true;

create view devos_private.decision_current with (security_invoker = true) as
  select d.id, r.revision, d.class, d.status, r.question, r.presented_text_tr, d.answer_original_tr,
         d.answer_interpretation_en, r.why_this_owner, r.options, r.alternatives_considered, r.single_viable_path_reason,
         r.premises, r.criteria, r.evidence_refs, r.assumptions, r.reversibility, r.reopen_triggers, r.recommendation,
         r.recommendation_rationale, r.if_unanswered, r.alternatives_state, d.answer, d.answered_by, d.answer_channel_ref,
         d.answered_revision, d.answered_at, d.created_at, r.created_at as revised_at
    from devos_private.decision d
    join lateral (select * from devos_private.decision_revision x where x.decision_id = d.id
                   order by x.revision desc limit 1) r on true;

create view devos_private.work_current with (security_invoker = true) as
  select w.id, r.revision, mr.mission_id as mission_ref, mr.revision as mission_revision, r.scope, r.purpose,
         r.input_refs, r.target_refs, r.consumer, r.return_to, r.stop_rule, r.acceptance_ref, r.impact_class,
         r.effort_policy_ref, r.method_refs, r.mandatory_needs, w.execution, w.qualification, w.acceptance, w.effect,
         w.created_at, r.created_at as revised_at
    from devos_private.work w
    join lateral (select * from devos_private.work_revision x where x.work_id = w.id
                   order by x.revision desc limit 1) r on true
    join devos_private.mission_revision mr on mr.id = r.mission_revision_id;

create view devos_private.finding_current with (security_invoker = true) as
  select f.id, r.revision, r.claim, r.source_spans, r.qualifiers, r.counter_evidence_searched, r.confidence,
         r.open_questions, r.changeable, r.fresh_until, r.agent_addressed, f.privacy_class, f.scope, f.status, r.use_scope,
         f.created_at, r.created_at as revised_at
    from devos_private.finding f
    join lateral (select * from devos_private.finding_revision x where x.finding_id = f.id
                   order by x.revision desc limit 1) r on true;

create view devos_private.artifact_current with (security_invoker = true) as
  select a.id, r.revision, r.path, r.commit, r.kind, a.scope, a.status, a.created_at, r.created_at as revised_at
    from devos_private.artifact a
    join lateral (select * from devos_private.artifact_revision x where x.artifact_id = a.id
                   order by x.revision desc limit 1) r on true;

-- Access rules (task 4; B principle 1). Nothing in devos_private is granted to PUBLIC or to a role a publishable key,
-- an environment token or a job credential reaches (anon, authenticated, and authenticator, the Data API's login); every
-- read and write goes through a devos_api function (W-C02-09). service_role, which only Supabase's secret key reaches
-- (held by no agent environment, 6.3), is closed too. No role class is a database role (EV-C02-003 section 1.1), so
-- there is no role class to revoke from or grant to here. PostgreSQL gives PUBLIC EXECUTE on a new function; that is
-- revoked for every function in devos_private, and each later function revokes its own (as deployment_drift does).
revoke all on schema devos_private from public;
revoke all on all tables in schema devos_private from public;
revoke all on all sequences in schema devos_private from public;
revoke all on all functions in schema devos_private from public;
revoke all on schema devos_api from public;
do $$
declare r text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      execute format('revoke all on schema devos_private from %I', r);
      execute format('revoke all on all tables in schema devos_private from %I', r);
      execute format('revoke all on all sequences in schema devos_private from %I', r);
      execute format('revoke all on all functions in schema devos_private from %I', r);
      execute format('revoke all on schema devos_api from %I', r);
    end if;
  end loop;
  -- The Data API runs a request with the publishable key as anon (README 8.1 of W-C02-07's tests). anon may resolve
  -- names in devos_api; it calls only the functions granted to it, each with its own token check (W-C02-09). Nothing in
  -- devos_api is a table, view or sequence (plan 6.2).
  if exists (select 1 from pg_catalog.pg_roles where rolname = 'anon') then
    grant usage on schema devos_api to anon;
  end if;
end
$$;

comment on schema devos_private is
  'DevOS private schema: all tables, closed to the outside (plan 6.2; Appendix B principle 1)';
comment on schema devos_api is
  'DevOS API schema: functions only (plan 6.2); agents call only these functions';
