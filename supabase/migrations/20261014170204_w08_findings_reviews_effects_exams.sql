-- DevOS schema (W-C02-08), not a fixture. Part 4 of 5: Finding, Artifact, Review, Verdict, Acceptance, the effect
-- classes, Operation, Observation, EvalRun, LeakFingerprint.
-- Sources: plan/work/W-C02-08.md point 3; Appendix B principle 10 and 3.8, 3.10 to 3.12, 3.15, 3.23; EV-C02-002 DM-12,
-- DM-24 to DM-26, DM-28, DM-30, DM-34, DM-37. Record: evidence/C02/EV-C02-012_schema_roles_access.md.
-- Form as in part 3 (DM-02). The format gates on Finding (DM-30) and the sample are W-C02-10's; the value sets the
-- ledger transfer adds (EV-C02-005 section 15, S4) are added by 20261014182601 (the record, section 9).

create type devos_private.privacy_class as enum ('private_derived', 'public', 'private');

-- Finding (B 3.8). Identity and state: status, scope (DM-34) and privacy_class (DM-25: private_derived by default).
create type devos_private.finding_status as enum ('candidate', 'reviewed', 'accepted_for_use', 'stale', 'withdrawn');

create table devos_private.finding (
  id uuid primary key default gen_random_uuid(),
  status devos_private.finding_status not null default 'candidate',
  scope text not null check (scope ~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$'),
  privacy_class devos_private.privacy_class not null default 'private_derived',
  created_at timestamptz not null default now()
);

-- source_spans: each entry with whether its source is primary or secondary and the date it was read (DM-26).
-- agent_addressed: absent (null) when not assessed, an empty list when none was found (DM-12).
create table devos_private.finding_revision (
  id uuid primary key default gen_random_uuid(),
  finding_id uuid not null references devos_private.finding (id),
  revision integer not null check (revision >= 1),
  claim text not null,
  source_spans jsonb not null default '[]' check (jsonb_typeof(source_spans) = 'array'),
  qualifiers jsonb,
  counter_evidence_searched text not null,
  confidence text,
  open_questions jsonb,
  changeable boolean not null,
  fresh_until date,
  agent_addressed jsonb check (agent_addressed is null or jsonb_typeof(agent_addressed) = 'array'),
  use_scope text,
  reason text,
  created_at timestamptz not null default now(),
  unique (finding_id, revision)
);

-- Artifact (B 3.10). Assembly is C08's.
create type devos_private.artifact_status as enum ('candidate', 'current', 'superseded');

create table devos_private.artifact (
  id uuid primary key default gen_random_uuid(),
  status devos_private.artifact_status not null default 'candidate',
  scope text not null check (scope ~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$'),
  created_at timestamptz not null default now()
);

create table devos_private.artifact_revision (
  id uuid primary key default gen_random_uuid(),
  artifact_id uuid not null references devos_private.artifact (id),
  revision integer not null check (revision >= 1),
  path text not null,
  commit text check (commit ~ '^[0-9a-f]{40}([0-9a-f]{24})?$'),
  kind text not null,
  reason text,
  created_at timestamptz not null default now(),
  unique (artifact_id, revision)
);

-- Review, Verdict, Acceptance (B 3.11). The sample Review's own rules (EV-C02-008 section 2; DM-41) are W-C02-10's.
-- reviewer_role_class comes from the token; a sample the database opens has no reviewer.
create type devos_private.review_kind as enum ('review', 'sample');
create type devos_private.independence_level as enum ('same_session', 'fresh_context_subagent',
  'same_model_other_session', 'other_view', 'other_model_family', 'batu_expert');
create type devos_private.verdict_result as enum ('pass', 'fail', 'conditional', 'indeterminate');

create table devos_private.review (
  id uuid primary key default gen_random_uuid(),
  kind devos_private.review_kind not null,
  target_ref uuid,
  target_revision integer check (target_revision >= 1),
  target_snapshot text,
  claim text,
  criterion_ref text,
  criterion_version text,
  use text not null,
  basis_refs jsonb not null default '[]' check (jsonb_typeof(basis_refs) = 'array'),
  reviewer_declared_session text,
  reviewer_role_class devos_private.role_class,
  independence_level devos_private.independence_level,
  view_ref text,
  shared_with_producer jsonb,
  created_at timestamptz not null default now()
);

create table devos_private.verdict (
  id uuid primary key default gen_random_uuid(),
  review_ref uuid not null references devos_private.review (id),
  result devos_private.verdict_result not null,
  evidence_refs jsonb not null default '[]' check (jsonb_typeof(evidence_refs) = 'array'),
  objections jsonb not null default '[]' check (jsonb_typeof(objections) = 'array'),
  limits jsonb not null default '[]' check (jsonb_typeof(limits) = 'array'),
  created_at timestamptz not null default now()
);

create table devos_private.acceptance (
  id uuid primary key default gen_random_uuid(),
  target_ref uuid not null,
  target_revision integer check (target_revision >= 1),
  accepted_use text not null,
  scope text not null check (scope ~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$'),
  current_evidence jsonb not null default '[]' check (jsonb_typeof(current_evidence) = 'array'),
  residual_decisions jsonb not null default '[]' check (jsonb_typeof(residual_decisions) = 'array'),
  owner_authority uuid references devos_private.decision (id),
  created_at timestamptz not null default now()
);

-- The server's table of effect classes (B 3.12; DM-37): filled by migration by the stage that first prepares each kind
-- of effect (C03's effect channels, C08's release); empty in C02.
create table devos_private.effect_class (
  effect_class text primary key check (effect_class ~ '^[a-z][a-z0-9_]*$'),
  irreversible boolean not null,
  mandatory_read_set text[] not null
);

-- Operation and Observation (B 3.12). An idempotency key is unique per namespace and its record is never deleted
-- (DM-28: no function deletes it and no application role holds a privilege on the table).
create type devos_private.operation_status as enum ('prepared', 'attempted', 'observed', 'conflicted', 'abandoned');
create type devos_private.observed_effect as enum ('applied', 'not_applied', 'unknown');

create table devos_private.operation (
  id uuid primary key default gen_random_uuid(),
  idempotency_namespace text not null,
  idempotency_key text not null,
  effect_class text not null references devos_private.effect_class (effect_class),
  target text not null,
  expected_base text,
  payload_hash text not null,
  work_ref uuid not null references devos_private.work (id),
  assignment_ref uuid not null references devos_private.assignment (id),
  generation integer not null check (generation >= 1),
  authority_epoch bigint not null check (authority_epoch >= 1),
  read_set jsonb not null default '[]' check (jsonb_typeof(read_set) = 'array'),
  status devos_private.operation_status not null default 'prepared',
  attempts integer not null default 0 check (attempts >= 0),
  created_at timestamptz not null default now(),
  unique (idempotency_namespace, idempotency_key)
);

create table devos_private.observation (
  id uuid primary key default gen_random_uuid(),
  operation_ref uuid not null references devos_private.operation (id),
  source text not null,
  observed_at timestamptz not null default now(),
  observed_effect devos_private.observed_effect not null,
  details jsonb not null default '{}'
);

-- EvalRun (B 3.15; DM-24): the exam link lives only here (work_ref with its revision). Its access rule: no application
-- role reads or writes it directly (part 5); devos_sinav's reads and writes come with W-C02-09's functions. The grader's
-- fields are C05's (DM-14). Competence is C05's.
create table devos_private.eval_run (
  id uuid primary key default gen_random_uuid(),
  eval_set_id text not null,
  eval_set_version text not null,
  subject_role text not null,
  subject_release text,
  runner_session text not null,
  work_ref uuid not null,
  work_revision integer not null,
  results jsonb not null check (jsonb_typeof(results) = 'object'),
  run_at timestamptz not null default now(),
  foreign key (work_ref, work_revision) references devos_private.work_revision (work_id, revision)
);

-- LeakFingerprint (B 3.23; DM-17): no content is kept. source_ref is required for library rows and refers to Source from
-- C04; C03's synthetic fingerprints come through the migration path, labelled synthetic.
create type devos_private.fingerprint_origin as enum ('library', 'synthetic');

create table devos_private.leak_fingerprint (
  id bigint generated by default as identity primary key,
  hash text not null check (hash <> ''),
  source_ref uuid,
  origin devos_private.fingerprint_origin not null,
  created_at timestamptz not null default now(),
  constraint leak_fingerprint_library_source check (origin = 'synthetic' or source_ref is not null)
);
create index leak_fingerprint_hash_idx on devos_private.leak_fingerprint (hash);
