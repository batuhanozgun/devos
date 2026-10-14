-- DevOS schema (W-C02-08), not a fixture. Part 3 of 5: Decision, Mission, Need, EffortPolicy, Work and WorkStanding,
-- Relation, Assignment.
-- Sources: plan/work/W-C02-08.md point 3; Appendix B principles 3 to 5 and 3.1 to 3.5, 3.17, 3.18; EV-C02-002 DM-02
-- (revision storage), DM-07, DM-09, DM-11, DM-24, DM-34, DM-45, DM-46. Record: evidence/C02/EV-C02-012_schema_roles_access.md.
-- Form (DM-02): a family with revisions has one row per object for its identity and state, and an append-only
-- <family>_revision table holding every revision; the current form is a view (part 5). Rules a function or a gate applies
-- (format gates, sampling, impact class, scope containment, answer binding) are W-C02-09's and W-C02-10's.
-- A scope is a dotted path of lower-case labels (B principle 4; DM-34).

-- Decision (B 3.17). Class, status and the answer are state of the identity row; the text of each revision is in
-- decision_revision. The status value declined (PC-44 place 8) is added by 20261014182601 (the record, section 9).
create type devos_private.decision_class as enum ('routine', 'high_impact', 'batu');
create type devos_private.decision_status as enum ('draft', 'open', 'answered', 'accepted', 'superseded', 'withdrawn');
create type devos_private.alternatives_state as enum ('compared', 'single_viable_path', 'open_exploration');

create table devos_private.decision (
  id uuid primary key default gen_random_uuid(),
  class devos_private.decision_class not null,
  status devos_private.decision_status not null default 'draft',
  answer jsonb,
  answer_original_tr text,
  answer_interpretation_en text,
  answered_by text,
  answer_channel_ref text,
  answered_revision integer check (answered_revision >= 1),
  answered_at timestamptz,
  created_at timestamptz not null default now()
);

create table devos_private.decision_revision (
  id uuid primary key default gen_random_uuid(),
  decision_id uuid not null references devos_private.decision (id),
  revision integer not null check (revision >= 1),
  question text not null,
  presented_text_tr text,
  why_this_owner text,
  options jsonb,
  alternatives_considered jsonb,
  single_viable_path_reason text,
  premises jsonb,
  criteria jsonb,
  evidence_refs jsonb,
  assumptions jsonb,
  reversibility text,
  reopen_triggers jsonb,
  recommendation text,
  recommendation_rationale text,
  if_unanswered text,
  alternatives_state devos_private.alternatives_state,
  reason text,
  created_at timestamptz not null default now(),
  unique (decision_id, revision)
);

-- Mission (B 3.1). owner_authority names Batu's decision record; an answered decision gets no new revision (DM-11), so
-- the decision names the revision answered. Constraints are references to Constraint (C05), kept as a list until then.
create type devos_private.mission_status as enum ('active', 'paused', 'closed');

create table devos_private.mission (
  id uuid primary key default gen_random_uuid(),
  status devos_private.mission_status not null default 'active',
  created_at timestamptz not null default now()
);

create table devos_private.mission_revision (
  id uuid primary key default gen_random_uuid(),
  mission_id uuid not null references devos_private.mission (id),
  revision integer not null check (revision >= 1),
  purpose text not null,
  scope text not null check (scope ~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$'),
  constraints jsonb not null default '[]' check (jsonb_typeof(constraints) = 'array'),
  acceptance text not null,
  owner_authority uuid not null references devos_private.decision (id),
  reason text,
  created_at timestamptz not null default now(),
  unique (mission_id, revision)
);

-- Need (B 3.2). Inquiry is a Need in the state investigating until C07 (B's activation table).
create type devos_private.need_origin as enum ('goal', 'method', 'useful');
create type devos_private.need_status as enum ('open', 'investigating', 'resolved', 'dropped', 'superseded');

create table devos_private.need (
  id uuid primary key default gen_random_uuid(),
  mission_ref uuid not null references devos_private.mission (id),
  condition text not null,
  origin devos_private.need_origin,
  method_ref text,
  why_needed text not null,
  evidence_for jsonb,
  evidence_against jsonb,
  assumptions jsonb,
  alternatives jsonb,
  consumer text,
  return_to text,
  uncertainty text,
  status devos_private.need_status not null default 'open',
  created_at timestamptz not null default now()
);

-- Work and WorkStanding (B 3.3; DM-09: WorkStanding's axes are the state fields of the work item's row).
create type devos_private.work_execution as enum ('planned', 'ready', 'running', 'waiting', 'finished', 'cancelled');
create type devos_private.work_qualification as enum ('current', 'stale', 'needs_review');
create type devos_private.work_acceptance as enum ('proposed', 'accepted', 'rejected');
create type devos_private.work_effect as enum ('none', 'prepared', 'observed', 'unknown');
create type devos_private.impact_class as enum ('routine', 'high');

create table devos_private.work (
  id uuid primary key default gen_random_uuid(),
  execution devos_private.work_execution not null default 'planned',
  qualification devos_private.work_qualification not null default 'current',
  acceptance devos_private.work_acceptance not null default 'proposed',
  effect devos_private.work_effect not null default 'none',
  created_at timestamptz not null default now()
);

-- EffortPolicy (B 3.18; DM-09: its own family). A standing policy has no work_ref and names its work_class.
create type devos_private.effort_policy_status as enum ('active', 'retired');

create table devos_private.effort_policy (
  id uuid primary key default gen_random_uuid(),
  work_ref uuid references devos_private.work (id),
  work_class text,
  standing_policy_ref uuid references devos_private.effort_policy (id),
  level text not null default 'high',
  expert_assessment_ref text not null,
  reduction_reason text,
  approved_by_role_class devos_private.role_class check (approved_by_role_class = 'devos_denetim'),
  non_removable_steps jsonb not null check (jsonb_typeof(non_removable_steps) = 'array'),
  status devos_private.effort_policy_status not null default 'active',
  created_at timestamptz not null default now(),
  constraint effort_policy_item_or_standing check ((work_ref is null) <> (work_class is null))
);

-- A work revision. mission_revision_id is the one foreign key to the Mission revision the work is tied to (B 3.3's
-- mission_ref and mission_revision; DM-02: a reference to a revision is a foreign key to that table); the current view
-- shows both. mandatory_needs is a field of the revision, empty allowed in C02 (DM-45).
create table devos_private.work_revision (
  id uuid primary key default gen_random_uuid(),
  work_id uuid not null references devos_private.work (id),
  revision integer not null check (revision >= 1),
  mission_revision_id uuid not null references devos_private.mission_revision (id),
  scope text not null check (scope ~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$'),
  purpose text not null,
  input_refs jsonb not null default '[]' check (jsonb_typeof(input_refs) = 'array'),
  target_refs jsonb not null default '[]' check (jsonb_typeof(target_refs) = 'array'),
  consumer text,
  return_to text,
  stop_rule text,
  acceptance_ref text,
  impact_class devos_private.impact_class not null,
  effort_policy_ref uuid references devos_private.effort_policy (id),
  method_refs jsonb not null default '[]' check (jsonb_typeof(method_refs) = 'array'),
  mandatory_needs jsonb not null default '[]' check (jsonb_typeof(mandatory_needs) = 'array'),
  reason text,
  created_at timestamptz not null default now(),
  unique (work_id, revision)
);

-- Relation (B 3.4). method and epistemic_status with exactly B 3.4's values (PC-16 place 13). The type informed_of and
-- its own fields come together in C06 (B 3.4: "built when informed_of is first needed").
create type devos_private.relation_type as enum ('depends_on', 'supports', 'challenges', 'derived_from', 'supersedes',
  'uses', 'part_of', 'reviews', 'blocks_effect', 'about');
create type devos_private.group_mode as enum ('ALL', 'ANY');
create type devos_private.relation_validity as enum ('current', 'stale', 'retracted');
create type devos_private.relation_method as enum ('mechanical', 'model_extracted', 'recorded');
create type devos_private.epistemic_status as enum ('observation', 'user_decision', 'inference', 'hypothesis', 'proposal');

create table devos_private.relation (
  id uuid primary key default gen_random_uuid(),
  type devos_private.relation_type not null,
  from_ref uuid not null,
  from_revision integer check (from_revision >= 1),
  to_ref uuid not null,
  to_revision integer check (to_revision >= 1),
  scope text not null check (scope ~ '^[a-z][a-z0-9_]*([.][a-z][a-z0-9_]*)*$'),
  hard boolean not null default false,
  group_id uuid,
  group_mode devos_private.group_mode,
  validity devos_private.relation_validity not null default 'current',
  use text,
  method devos_private.relation_method not null,
  epistemic_status devos_private.epistemic_status not null,
  created_at timestamptz not null default now(),
  constraint relation_group check ((group_id is null) = (group_mode is null)),
  -- B 3.4: "A relation with method = model_extracted cannot have epistemic_status = observation" (PC-16).
  constraint relation_model_extracted_not_observation
    check (not (method = 'model_extracted' and epistemic_status = 'observation'))
);
create index relation_from_idx on devos_private.relation (from_ref);
create index relation_to_idx on devos_private.relation (to_ref);

-- Assignment (B 3.5): the claim. One active claim per work item is a uniqueness constraint (B 3.5; DM-01's backstop).
-- role_class is the claim's, from the token (S8 line 2, EV-C02-003 section 4.3); authority_epoch is the epoch the claim was
-- made in, distinct from the global authority epoch's row. Only the claim token's hash is kept (EV-C02-003 section 1.7).
create type devos_private.assignment_status as enum ('active', 'released', 'expired', 'revoked');

create table devos_private.assignment (
  id uuid primary key default gen_random_uuid(),
  work_ref uuid not null,
  work_revision integer not null,
  declared_session_id text,
  role_class devos_private.role_class not null,
  claim_token_hash text not null unique check (claim_token_hash ~ '^[0-9a-f]{64}$'),
  generation integer not null check (generation >= 1),
  authority_epoch bigint not null check (authority_epoch >= 1),
  lease_expires_at timestamptz not null,
  last_heartbeat_at timestamptz,
  status devos_private.assignment_status not null default 'active',
  created_at timestamptz not null default now(),
  foreign key (work_ref, work_revision) references devos_private.work_revision (work_id, revision),
  unique (work_ref, generation)
);
create unique index assignment_one_active_claim on devos_private.assignment (work_ref) where status = 'active';
comment on index devos_private.assignment_one_active_claim is
  'One active claim per work item (Appendix B 3.5), enforced by the database';
