-- DevOS schema (W-C02-08), not a fixture. Part 7, after parts 1 to 6: Finding's three separate fields, source_type,
-- epistemic_status and current_authority (Appendix B 3.8, "for every source and finding"; CHK-C02-068 C1).
-- Sources: plan/work/W-C02-08.md points 2 and 3; Appendix B 3.8; plan 6.6 ("for each record or statement"); EV-C02-002
-- DM-02; plan/work/C04.md note N-094, T-35. Record: evidence/C02/EV-C02-012_schema_roles_access.md section 3.1.
-- Where: on finding_revision, with the claim they qualify (DM-02: content on the revision, state on the identity row).
-- No row exists in any project before this file (no migration of this item has been applied), so NOT NULL needs no
-- default; none is given, since a default would record an assessment nobody made.

-- B 3.8's values. epistemic_status reuses part 3's type, which has exactly these values (B 3.4 and 3.8 give the same list).
create type devos_private.source_type as enum ('foundation', 'candidate_study', 'context', 'exploration',
  'historical_record', 'archived_report', 'legacy_repo');
create type devos_private.current_authority as enum ('can_open_work', 'instruction', 'information_only');

-- source_type is nullable: B's values are library categories only, and T-35 (C04's start) adds the value for records
-- DevOS makes. Until then NULL means "not one of B's library categories; T-35's value pending", so a DevOS-made finding
-- is not forced into a library category. T-35's migration adds the value and can then make the column NOT NULL.
alter table devos_private.finding_revision
  add column source_type devos_private.source_type,
  add column epistemic_status devos_private.epistemic_status not null,
  add column current_authority devos_private.current_authority not null;
comment on column devos_private.finding_revision.source_type is
  'Appendix B 3.8. NULL: not one of B''s library categories (a DevOS-made record); T-35''s value pending (plan/work/C04.md)';

-- The current form shows them (DM-02). The view keeps its columns and its privileges; the three are added at its end.
create or replace view devos_private.finding_current with (security_invoker = true) as
  select f.id, r.revision, r.claim, r.source_spans, r.qualifiers, r.counter_evidence_searched, r.confidence,
         r.open_questions, r.changeable, r.fresh_until, r.agent_addressed, f.privacy_class, f.scope, f.status, r.use_scope,
         f.created_at, r.created_at as revised_at, r.source_type, r.epistemic_status, r.current_authority
    from devos_private.finding f
    join lateral (select * from devos_private.finding_revision x where x.finding_id = f.id
                   order by x.revision desc limit 1) r on true;
-- The two types made here are closed by part 8, which revokes USAGE on every type in devos_private.
