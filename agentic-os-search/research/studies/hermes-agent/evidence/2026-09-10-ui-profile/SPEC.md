# U01-M3 — Slash policy diagnostic specification

Scope: fixed upstream `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, full `gateway/slash_access.py`, expected Git blob `07204201e411f29f912bb9bba6beec0566acab9d`. This specification is written before the probe executes, after source inspection. Source-informed exploratory diagnostics, not an independent product certification.

Only the actual stdlib-only policy module is imported. Platform/config/source holders are synthetic namespaces. No gateway, adapter, provider, credential, configuration-file writer or memory mutator is run. The probe calls the policy API; the relationship to the real dispatch caller is established separately by pinned source reading.

Expected discriminating cases:

- A01: no admin list disables the command gate; `memory` is permitted at this layer. This does not bypass primary ingress authorization.
- A02: a configured admin list and no user additions denies `memory` and `skills` to a non-admin, but allows the `help`/`whoami` floor.
- A03: a listed admin can invoke `memory`, `skills`, and `approvals`.
- A04: a non-admin explicitly allowed `memory` passes `memory` but not `skills`; the policy API receives the canonical command name, not its arguments. Direct input `memory approve` is not an action-aware policy query. The real caller passes `memory` for each subcommand.
- A05: DM and group admin sets remain separate when both scopes are configured.
- A06: absent/empty DM user command list falls back to group user commands; an explicit nonempty DM list replaces that fallback.
- A07: configured command names and numeric IDs normalize as implemented (`/MEMORY`, comma lists, integer IDs).
- A08: missing platform configuration returns the disabled command-gate policy. This is an isolated resolver behavior, not an authenticated-user or live configuration claim.

Oracle: explicit expected values above, compared to actual return values. A deliberate mutation making `can_run` always true must be detected by A02. Separately, an altered file must be refused by the import identity guard before import. Both negative controls are separately labelled and do not replace real source identity or full-path testing.

Output: RESULT.json records source/spec/probe identity, Python/platform/time, each observation and expectation, and negative-control results. Original M2 and D3 probes are not rerun. Product authorization, deployed configuration, and real-user reachability remain NOT ASSESSED.
