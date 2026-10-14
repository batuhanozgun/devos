-- DevOS schema (W-C02-08), not a fixture. Part 6, after parts 1 to 5: the ledger transfer's own schema (point 9;
-- EV-C02-005 section 15, S1 to S4).
-- Sources: plan/work/W-C02-08.md point 9; evidence/C02/EV-C02-005_ledger_transfer.md sections 3.1, 3.2, 3.4, 11 and 15;
-- Appendix B 3.8, 3.13 ("The ledger transfer's events") and 3.17 as PC-44 applies them. Its tests, T-W14-SCH
-- (tests/C02/W-C02-14/), were merged into main in 178468b before this file was written (point 9's git order).
-- Record: evidence/C02/EV-C02-012_schema_roles_access.md section 9. This file builds what parts 2 to 4 say waits for
-- point 9. S5, the transfer's functions, is W-C02-09's (EV-C02-005 section 15; note N-277): no function is created here.
-- No progress table and no hand-over table (EV-C02-005 section 15): the progress record is the transfer_run and
-- transferred events with S2's index, and the hand-over record is the one ledger_handed_over event.

-- S1. The transfer's event types (transferred, transfer_run, ledger_handed_over, ledger_entry, note_line, record_line,
-- usage_reading, batu_step, ledger_state_row) are values of event.event_type, whose form part 2 checks. B 3.13 gives no
-- closed list of event types and W-C02-09's functions write others, so no list is built here.
-- A transferred event's payload holds transfer_source, an object whose six fields are each a JSON string, input_commit
-- 40 lower-case hexadecimal characters. A NULL result is a refusal (coalesce), so a missing or JSON-null field, or an
-- array in place of the object, cannot pass; kind and source_id are then never SQL NULL in S2's key.
alter table devos_private.event add constraint event_transferred_transfer_source check (
  event_type <> 'transferred' or coalesce(
    jsonb_typeof(payload -> 'transfer_source') = 'object'
    and jsonb_typeof(payload -> 'transfer_source' -> 'kind') = 'string'
    and jsonb_typeof(payload -> 'transfer_source' -> 'source_id') = 'string'
    and jsonb_typeof(payload -> 'transfer_source' -> 'path') = 'string'
    and jsonb_typeof(payload -> 'transfer_source' -> 'input_commit') = 'string'
    and jsonb_typeof(payload -> 'transfer_source' -> 'last_commit') = 'string'
    and jsonb_typeof(payload -> 'transfer_source' -> 'sha256') = 'string'
    and (payload -> 'transfer_source' ->> 'input_commit') ~ '^[0-9a-f]{40}$',
    false));

-- S1. At most one ledger_handed_over event (the hand-over record; EV-C02-005 section 3.4).
create unique index event_one_ledger_handover on devos_private.event (event_type)
  where event_type = 'ledger_handed_over';
comment on index devos_private.event_one_ledger_handover is
  'At most one ledger_handed_over event (EV-C02-005 section 15, S1)';

-- S2. The idempotency key: one transferred creation event per (kind, source ID) (EV-C02-005 section 3.1; B 3.13).
create unique index event_transferred_key on devos_private.event
  ((payload -> 'transfer_source' ->> 'kind'), (payload -> 'transfer_source' ->> 'source_id'))
  where event_type = 'transferred';
comment on index devos_private.event_transferred_key is
  'The ledger transfer''s idempotency key (EV-C02-005 section 15, S2)';

-- S3. Decision's status declined (B 3.17; PC-44 place 8), in B's order. The value is not used in this file.
alter type devos_private.decision_status add value 'declined' after 'accepted';

-- S4. Finding's changeable is the value set yes / no / not_recorded (EV-C02-005 S4; B 3.8), an enum as the build's other
-- value sets are. Part 4 made it boolean; no row exists before this file in any project, and the cast keeps any row's
-- meaning. counter_evidence_searched stays text, so not_recorded is one of its values. That either field takes
-- not_recorded only on a transferred row is the format gate's, W-C02-10's (B 3.8; EV-C02-005 "Interfaces assumed").
-- The view that reads the column is dropped and made again with part 5's definition.
create type devos_private.finding_changeable as enum ('yes', 'no', 'not_recorded');
drop view devos_private.finding_current;
alter table devos_private.finding_revision alter column changeable type devos_private.finding_changeable
  using (case when changeable then 'yes' else 'no' end)::devos_private.finding_changeable;
create view devos_private.finding_current with (security_invoker = true) as
  select f.id, r.revision, r.claim, r.source_spans, r.qualifiers, r.counter_evidence_searched, r.confidence,
         r.open_questions, r.changeable, r.fresh_until, r.agent_addressed, f.privacy_class, f.scope, f.status, r.use_scope,
         f.created_at, r.created_at as revised_at
    from devos_private.finding f
    join lateral (select * from devos_private.finding_revision x where x.finding_id = f.id
                   order by x.revision desc limit 1) r on true;

-- S4, the other rows. Artifact kind (git_file, git_tree) and Acceptance accepted_use (installation_acceptance) stay
-- free text: Appendix B 3.10 and 3.11 give neither field a list, and W-C02-07's merged tests write other kinds, so the
-- transfer's values are admitted with no closed set (the record, section 9). EffortPolicy's step-set exception is the
-- format gate's, W-C02-10's (B 3.18; EV-C02-005 "Interfaces assumed").

-- Point 4 for the view made again here: part 5's access rule, applied to it.
revoke all on devos_private.finding_current from public;
do $$
declare r text;
begin
  foreach r in array array['anon', 'authenticated', 'authenticator', 'service_role'] loop
    if exists (select 1 from pg_catalog.pg_roles where rolname = r) then
      execute format('revoke all on devos_private.finding_current from %I', r);
    end if;
  end loop;
end
$$;
