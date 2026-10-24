# gstack — Memory, Learnings, Context Continuity, and GBrain

## Status and boundary

**Status:** BOUNDED SUBSYSTEM SYNTHESIS  
**External target:** `garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`  
**Observed:** 2026-09-05  
**Package:** 1.79.0

This synthesis reconstructs how gstack preserves and reuses prior informational state across sessions, projects and planning workflows.

It covers four distinct mechanisms:

1. explicit session/work checkpoints (`/context-save`, `/context-restore`);
2. local structured learnings (`learnings.jsonl`, `/learn`);
3. GBrain-backed typed planning context and local cache;
4. trust/ingest controls governing what may enter or leave persistent brain state.

It also examines freshness, confidence, scope, privacy, cache invalidation, stale fallback, host/runtime dependence and verification evidence.

It does **not** treat these mechanisms as one generic “memory system.” Their authority and freshness semantics are materially different. It does not independently validate GBrain itself or the semantic correctness of stored content.

Foundation projection remains deferred.

---

## 1. Executive reconstruction

At the pinned revision, gstack memory is not “save everything and retrieve it later.” It is a set of differently qualified informational channels:

```text
A. Context checkpoint
   conversation + git-state summary
   → explicit handoff / continuity artifact

B. Local learning
   observed / inferred / user-stated lesson
   + confidence + source + files + timestamp
   → advisory reusable evidence

C. Brain planning digest
   typed GBrain pages
   → scoped cache entity
   + TTL + byte budget + invalidation
   → planning preflight input

D. Trust / ingest authority
   endpoint trust + repo policy + privacy allowlist
   → controls whether persistent brain interaction is allowed
```

The key architectural result is:

> gstack does not assign one universal standing to remembered information. It differentiates memory by provenance, scope, age, trust, intended consumer and operational use.

But the qualification is incomplete in an important place: **GBrain stale-fallback state is computed by the cache layer and then hidden from the planning model by the resolver.** Continuity survives, but the consumer loses the freshness signal.

---

## 2. Context checkpoints are continuity artifacts, not current truth

### 2.1 Explicit save

`/context-save` is a no-code-change state-capture workflow. It gathers current repository/session context and writes an append-only Markdown checkpoint under the project-scoped gstack state directory.

The checkpoint includes fields such as:

- status;
- branch;
- timestamp;
- optional session duration;
- modified files;
- work summary;
- decisions made;
- remaining work;
- notes/context for continuation.

The save mechanism uses:

- timestamp-based filenames;
- Bash-side title sanitization;
- collision-safe suffixes;
- append-only behavior rather than overwrite.

Focused hardening tests exercise shell metacharacter stripping, traversal-resistant title handling, length limits and collision-safe append semantics.

### 2.2 Restore is branch-aware

`/context-restore` scans checkpoints with this approximate priority:

```text
newest current-branch checkpoint
        ↓ fallback
newest other-branch checkpoint
```

The implementation:

- scans a bounded newest set;
- prefers current-branch checkpoint metadata;
- falls back across branches for worktree/Conductor handoff;
- caps the candidate list;
- uses the timestamp encoded in filename rather than filesystem mtime as canonical ordering.

Other-branch restore is surfaced as a branch mismatch rather than silently pretending the checkpoint belongs to the active branch.

### 2.3 Important epistemic limit

The checkpoint body is an **LLM-authored summary** of conversation and repository state at save time.

Restore does not mechanically revalidate statements such as:

```text
Remaining work: X
Decision: Y
This file still needs Z
```

against current source before presenting them.

Therefore:

```text
checkpoint exists + is newest
≠
checkpoint claims are still current truth
```

Branch/timestamp metadata provides provenance and recency context, but semantic freshness still requires downstream reasoning/re-entry into source where load-bearing.

The correct role is:

> a high-value continuity/handoff representation of prior work state, not an authoritative replacement for current repository state.

---

## 3. Context continuity has both deterministic and live-agent evidence

The context subsystem is better behaviorally verified than several high-level workflow contracts.

### Deterministic hardening tests

`test/context-save-hardening.test.ts` exercises the actual shell patterns for:

- title sanitization;
- filename collisions;
- append-only preservation;
- empty checkpoint set behavior;
- newest-by-filename ordering;
- current-branch preference/fallback;
- bounded candidate listing.

### Real skill routing / live-agent E2E

`test/skill-e2e-context-skills.test.ts` uses real skill execution to test selected behaviors including:

- context-save routing;
- save→restore round-trip;
- checkpoint lookup;
- empty state;
- list delegation;
- branch-scoped listing;
- legacy compatibility.

This establishes stronger evidence for continuity mechanics than a template-only claim.

It still does not validate whether the LLM's saved summary is semantically complete or accurate in arbitrary real projects.

---

## 4. Local learnings are append-oriented, sourced observations with confidence

The local learning store is project-scoped JSONL, conceptually:

```text
~/.gstack/projects/<slug>/learnings.jsonl
```

Rows carry fields including:

- timestamp;
- skill;
- type;
- key;
- insight;
- confidence;
- source;
- branch/commit where available;
- affected files;
- trust marker for cross-project reuse.

The source vocabulary distinguishes at least:

- `observed`;
- `user-stated`;
- `inferred`;
- `cross-model`.

This is important because the same sentence stored as a user statement and as a model inference should not have equal persistence semantics.

### Latest-winner model

Normal writes append rather than update in place. Search resolves duplicate `key + type` rows by selecting the latest winner.

This preserves history while letting a newer learning supersede an older one operationally.

`/learn prune` is an exception: user-approved removal can rewrite the JSONL store to delete selected rows. Updating a learning normally appends a new winner.

---

## 5. Learning confidence decays selectively

`gstack-learnings-search` applies age-based effective-confidence decay to `observed` and `inferred` rows.

The implemented rule removes roughly one confidence point per 30 days of age.

`user-stated` rows do **not** decay under the same rule.

Focused tests behaviorally check both cases.

This encodes a useful asymmetry:

```text
old observation
→ weaker evidence over time

old explicit user preference/statement
→ retained unless superseded/removed
```

This is not universally safe — user preferences and facts can also change — but it is a deliberate epistemic policy rather than timeless memory by default.

### Missing automatic file-change invalidation

Affected-file references are stored and `/learn prune` can inspect whether referenced files still exist, but local learning retrieval does not automatically invalidate a row merely because a referenced file changed after the learning was recorded.

Thus confidence decay and source provenance improve qualification, but semantic staleness remains partly advisory/user-managed.

---

## 6. Cross-project learnings use an allowlist trust rule

Local learnings can optionally be searched across projects.

The cross-project gate is deliberately strict:

```text
foreign row trusted === true
→ eligible

trusted === false
→ excluded

trusted field missing
→ excluded
```

The logger marks rows trusted for this purpose when their source is `user-stated`.

Focused tests explicitly prevent legacy rows with no `trusted` field from slipping through.

This is a strong contamination control:

> another project's model-observed or inferred lesson is not automatically allowed to alter the current project's reasoning.

Same-project observed/inferred learnings remain usable, because their project boundary is already considered the trust scope.

---

## 7. Learning ingestion applies a prompt-injection filter before persistence

`gstack-learnings-log` validates schema fields and rejects instruction-like suspicious content using the shared injection detector.

A regression test confirms that a learning such as an instruction to ignore previous instructions / exfiltrate secrets is rejected and nothing is persisted.

The tests also contain false-positive protection for legitimate prose that discusses “override” behavior.

This should not be overclaimed as general prompt-injection safety: it is a heuristic filter over the learning ingestion path. But it recognizes an important memory threat class:

```text
malicious/untrusted text
→ persistent memory
→ future prompt context
```

and attempts to stop that transition at write time.

---

## 8. `/learn` is primarily a memory-management interface

`learn/SKILL.md.tmpl` supports operations such as:

- recent learnings;
- search;
- manual add;
- prune/reconcile;
- export;
- statistics.

The skill has a hard no-code-change boundary.

Pruning is interactive and can identify candidates based on:

- missing referenced files;
- contradictory same-key insights;
- staleness/context concerns.

The contradiction step remains model-assisted rather than a deterministic logical consistency engine.

A live-agent E2E seeds several learnings and verifies `/learn` can retrieve/summarize them. This supports basic behavioral usability but not the correctness of semantic contradiction/pruning judgments.

---

## 9. GBrain planning memory is typed and budgeted before it reaches the model

The brain-cache design is materially different from free-form search.

`scripts/brain-cache-spec.ts` defines canonical cache entities with:

- scope;
- TTL;
- byte budget;
- source page pattern / fetch behavior;
- per-skill subset membership.

Observed entity classes include:

| Entity | Scope | Approx TTL |
|---|---|---:|
| `user-profile` | cross-project | 7d |
| `product` | project | 1d |
| `goals` | project | 12h |
| `developer-persona` | project | 7d |
| `brand` | project | 7d |
| `competitive-intel` | project | 1d |
| `recent-decisions` | project | 12h |
| `salience` | project | 4h |

The actual set and values are centralized so runtime/docs/tests share one spec.

### Per-skill retrieval subsets

Brain preflight is not injected globally.

Registered planning consumers load only selected entities. For example:

```text
office-hours
→ product, goals, user-profile, recent-decisions, salience

plan-eng-review
→ product, recent-decisions
```

Tests explicitly check that non-planning consumers such as `ship`, `qa`, `investigate`, `retro`, `design-review` receive no `BRAIN_PREFLIGHT` block.

This is an important containment principle:

> persistent memory is routed according to work role rather than globally flooding every agent context.

---

## 10. Context-window cost is treated as a resource constraint

Each brain digest has a byte budget, and planning skills have aggregate preflight budgets.

The cache CLI truncates runtime digests to the entity budget.

Separate gate-tier tests check the generated brain preflight/refresh/write-back instruction blocks so the *instructions about memory* also do not grow without bound.

The tests explicitly distinguish:

```text
runtime digest data budget
versus
resolver instruction budget
```

This is a useful design point: memory usefulness is constrained by the finite attention/context capacity of the consuming model.

A stale comment in `brain-cache-spec.ts` references a separate `autoplan-preflight-budget.test.ts`; that path does not exist at the pinned revision. Equivalent autoplan budget assertions are present in `brain-cache-spec.test.ts` and `skill-preflight-budget.test.ts`. Actual tests, not the stale filename comment, are the source of truth.

---

## 11. Brain cache validity includes more than time

The cache layer tracks freshness using multiple signals, not TTL alone.

Observed invalidation/validity inputs include:

- entity TTL;
- explicit invalidation caused by selected workflow writes;
- schema pack identity/version;
- active GBrain endpoint identity;
- cache meta validity;
- project scope;
- refresh lock/concurrency state.

Endpoint identity matters because switching the backing brain should not allow a cache built from another endpoint to masquerade as current memory.

Malformed/missing cache metadata is treated as a rebuild condition rather than blindly trusted warm state.

This is a meaningful qualification model:

```text
file exists
≠
valid cache
```

---

## 12. Stale-but-usable continuity exists — but the freshness label is lost at consumption

This is the strongest corrective finding in this subsystem.

### Cache layer behavior

`gstack-brain-cache get` distinguishes states including:

- `warm`;
- `cold-refreshed`;
- `stale-fallback`;
- `missing`.

When the brain cannot refresh an expired digest but an old cache file exists, it can return `stale-fallback` and still emit the old digest.

The CLI prints non-warm state information to **stderr** while printing digest content to stdout.

So at the cache boundary the epistemic condition is represented correctly:

```text
content = usable
freshness = stale fallback
```

### Planning resolver behavior

`generateBrainPreflight()` invokes each cache lookup like:

```bash
gstack-brain-cache get ... 2>/dev/null
```

and concatenates only stdout into the model's `## Brain Context` block.

The resolver then tells the model that the cache “handles staleness, refresh, and stale-but-usable fallback automatically,” but the concrete `stale-fallback` status emitted by the CLI is discarded.

Therefore the consuming planning model sees:

```text
old digest content
```

without necessarily seeing:

```text
this digest is stale because refresh failed
```

This is a genuine source→view fidelity loss.

### Consequence

The system prioritizes continuity over blocking planning when the brain is unreachable, which is reasonable. But it does not preserve the full qualification state across the representation boundary.

The correct finding is:

> gstack's cache **knows** when brain context is stale, but the current planning preflight **does not reliably tell the agent** that the supplied context came from stale fallback.

This can cause a stale memory artifact to exert the same apparent authority as a warm one.

---

## 13. Background refresh reduces latency but cannot repair current-turn hidden staleness

Planning preflight skills kick a non-blocking background cache refresh after their work.

The intention is to refresh entities near their TTL so the next invocation remains warm.

This improves future freshness without delaying the current user.

However:

```text
current invocation consumed stale fallback invisibly
→ background refresh may help next invocation
→ does not restore the missing freshness signal for the decision already made
```

Thus asynchronous warming is performance/future-freshness optimization, not a substitute for preserving current-turn provenance.

---

## 14. Salience has a dedicated privacy allowlist before cache persistence

The `salience` digest has the shortest TTL and a default slug-prefix allowlist.

The default allows categories such as:

- `projects/`;
- `gstack/`;
- `concepts/`.

It excludes sensitive categories such as personal/family/therapy/reflection/medical-like content.

Focused tests verify allow/block behavior and configuration override semantics.

The intended control placement is important: disallowed salience is filtered **before writing the digest to disk**, not merely hidden at prompt rendering time.

This reduces both prompt leakage and local cache persistence of sensitive memory.

It remains prefix-policy-based privacy, not semantic proof that every allowed page is non-sensitive.

---

## 15. User profile is intentionally cross-project; most brain context is not

Among the planning cache entities, `user-profile` is the deliberate cross-project entity.

Other planning digests are project-scoped.

Tests pin that distinction in generated preflight commands:

```text
user-profile get
→ no --project

project entities
→ --project "$SLUG"
```

This keeps product/architecture/project decisions from automatically bleeding into unrelated projects while allowing stable personal calibration patterns to travel.

The same design also creates a larger blast radius for incorrect user-profile content, so its provenance/trust/freshness is particularly load-bearing.

---

## 16. GBrain trust is an authority problem, not only a retrieval preference

`/setup-gbrain` makes storage topology and trust explicit.

Possible configurations include local PGLite, Supabase-backed brains and remote HTTP MCP brains.

The workflow asks the user where the brain should live rather than silently choosing.

For remote/shared setups it surfaces that giving the local agent brain access may expose all pages visible to that brain account.

### Endpoint trust policy

Brain trust differentiates at least:

```text
personal
shared
unset
```

Local endpoints can default to personal; ambiguous remote endpoints require an explicit policy decision.

Calibration write-back is intended only for personal brains so individual prediction/taste calibration does not pollute a shared/team brain.

This is a strong actor/authority distinction inside the memory subsystem itself.

---

## 17. Repository policy controls whether project information may enter GBrain

A separate per-remote policy store records:

- `read-write`;
- `read-only`;
- `deny`.

The policy is keyed on a normalized git remote so equivalent HTTPS/SSH spellings map to the same authority decision.

### Meaning

```text
read-write
→ may search + write/import project memory

read-only
→ may search but must not write/import

deny
→ no GBrain interaction for the repo
```

### Batch ingest failure polarity

The unattended batch reader deliberately behaves differently from interactive setup.

If the policy store is corrupt during an unattended batch ingest:

```text
do NOT quarantine and continue
→ fail hard
```

because silently discarding the store could bypass an existing `deny` policy.

The TypeScript client classifies read/spawn errors but explicitly leaves fail-open/fail-closed polarity to the consumer.

This is a good example of context-sensitive authority semantics:

```text
interactive recovery path
→ can quarantine/re-ask user

unattended data movement path
→ fail closed if policy cannot be determined
```

Focused tests exercise the real Bash policy script, normalization parity, corrupt-store hard failure and batch client behavior.

---

## 18. Memory ingest actually applies repo policy before transcript writes

The repository policy is not setup prose only.

`gstack-memory-ingest.ts` calls the shared batch policy client over distinct transcript remotes before write staging/import.

For transcripts:

- `read-only` → skipped because ingest is a page write;
- `deny` → skipped;
- `read-write` → eligible;
- `none` → currently eligible when no explicit policy is set, subject to other setup/sync controls.

If a policy store exists but cannot be read/spawned, ingest aborts before **any** write/state/staging import rather than risking bypass of a saved denial.

The probe path is also intended to apply the same policy filter so preview counts match the actual write path.

This converts trust preference into an actual data-movement control.

---

## 19. Memory ingest has its own continuity and integrity controls

`gstack-memory-ingest.ts` walks transcript and curated-artifact sources, including local learnings/plans/reports.

Observed controls include:

- mtime fast path plus full-content SHA when needed;
- atomic ingest-state writes;
- partial transcript recovery;
- unattributed-session handling;
- optional local secret scan;
- policy filtering before writes;
- import accounting reconciliation;
- refusal to advance state on malformed/insufficient importer success evidence.

The last point is especially important: an importer exit code of 0 without parseable/accountable output is not accepted as proof that data landed.

So ingestion has an evidence-of-effect requirement rather than treating process success as sufficient.

---

## 20. GBrain sync is multi-stage and intentionally partially degradable

`/sync-gbrain` coordinates code, memory and brain/artifact synchronization.

It performs preflight classification of the local/remote engine state and repo trust before running the orchestrator.

Different failures have different semantics:

- explicit repo `deny` → stop;
- broken local engine in some modes → stop/remediate;
- remote thin client → local stages can skip by design;
- orchestrator stage failure → later stages can continue;
- cache refresh can be forced independently.

Thus “brain synchronized” is not one binary state. Code index, memory ingest, artifact sync and cache freshness can diverge.

A consumer needs to know which informational surface it relies on.

---

## 21. GBrain planning memory can influence decisions, not merely answer search

The generated planning preflight tells agents to:

- avoid re-asking questions whose answers appear in memory;
- frame recommendations against stored goals;
- flag conflict with recent decisions;
- surface user-profile calibration patterns when relevant.

That makes the brain cache an **active decision input**.

It can change:

```text
which questions are asked
which options are recommended
which prior decisions are treated as constraints/conflicts
```

This is stronger than optional background reference material.

Because of that influence, freshness/provenance problems — especially hidden stale fallback — are load-bearing rather than cosmetic.

By contrast, many local learnings operate more like advisory evidence that the agent searches when relevant.

---

## 22. Brain write-back is selectively gated and partly future-facing

Planning skills can render a calibration write-back block with per-skill weighting.

The design requires:

- a personal brain trust policy;
- a feature flag / upstream capability;
- typed `kind=bet` semantics;
- cache invalidation after write.

At the pinned revision the resolver itself says the feature flag is currently false pending an upstream GBrain `takes_add` capability.

So this should be represented as:

```text
implemented/plumbed write-back contract
but not generally active runtime behavior yet
```

The tests verify generated wiring, weights, trust-policy text and invalidation commands; they do not prove the future MCP operation is live.

---

## 23. Verification map

| Mechanism | Evidence observed | Strength / limit |
|---|---|---|
| context checkpoint append/ordering/hardening | exact shell-pattern tests | strong deterministic evidence |
| context save→restore use | real skill E2E | selected behavioral evidence |
| semantic accuracy/currentness of checkpoint summary | no independent/current-source revalidation | open / advisory |
| learning schema + append/latest-winner | real CLI tests | strong implementation/behavior evidence |
| observed/inferred confidence decay | CLI tests | behavioral evidence |
| user-stated no-decay | CLI tests | behavioral evidence; policy choice, not universal truth |
| cross-project trusted-only learning import | real CLI tests | strong selected evidence |
| learning injection rejection | logger tests | behavioral heuristic evidence |
| `/learn` retrieval | live-agent E2E | selected behavioral evidence |
| brain entity/subset/TTL/budget spec | shared source + gate tests | strong structural evidence |
| cache warm/missing/stale-fallback states | cache round-trip tests | strong state-machine evidence |
| stale status shown to planning model | source tracing proves stderr suppressed | **negative finding: not preserved** |
| salience privacy prefixes | focused tests | strong prefix-policy evidence; not semantic privacy proof |
| repo trust normalization/batch policy | real Bash + TS client tests | strong selected evidence |
| repo policy applied to transcript ingest | ingest implementation + focused policy tests | strong implementation evidence; whole live GBrain ingest not independently reproduced here |
| GBrain semantic correctness | not independently evaluated | open |
| memory system as a whole | no independent external validation | not established |

---

## 24. Strongest subsystem conclusions

### M1 — gstack memory is plural, not one store

**Status:** strong subsystem conclusion.

Checkpoint continuity, local learnings, typed brain digests and trust/ingest policy have different scope, provenance and authority semantics.

### M2 — remembered information is often qualified by metadata

**Status:** strong implementation observation.

Branch/timestamp, source/confidence/files, TTL/scope/entity type and trust policy all qualify remembered state before reuse.

### M3 — context checkpoints preserve continuity but can be semantically stale

**Status:** strong inference.

Restore chooses a relevant recent artifact, but does not automatically validate its LLM-authored claims against current source.

### M4 — local learnings are treated as fallible evidence

**Status:** strong implementation observation.

Source, confidence, age decay, affected files, latest-winner semantics and cross-project trust reduce the chance that every old inference becomes permanent truth.

### M5 — user statements receive higher persistence authority than model observations

**Status:** strong policy observation.

User-stated learnings avoid normal confidence decay and are the default class eligible for cross-project trust. This is deliberate authority weighting.

### M6 — persistent-memory poisoning is recognized as a distinct threat

**Status:** bounded implementation/test observation.

Learning ingestion rejects instruction-like content; salience has a privacy allowlist; repo trust can block ingest; remote/shared brain setup requires explicit trust decisions.

### M7 — brain planning context is an active work-control input

**Status:** strong source/inference.

Preflight memory can suppress questions, frame recommendations and flag conflicts with prior decisions. It is not passive lookup only.

### M8 — brain context is routed and budgeted by consumer

**Status:** strong implementation + tests.

Different planning skills receive different entity subsets and context budgets; non-planning skills do not receive the preflight block.

### M9 — cache validity includes time, source identity and explicit invalidation

**Status:** strong implementation/test inference.

TTL, endpoint identity, schema identity and workflow invalidation determine whether an existing digest is considered current.

### M10 — stale continuity loses epistemic labeling at the final prompt boundary

**Status:** **strong negative source-fidelity finding.**

The cache CLI distinguishes `stale-fallback`, but the planning resolver discards stderr and injects only stale content. The agent can therefore receive stale memory without being told it is stale.

### M11 — memory trust decisions are enforced at data-movement boundaries

**Status:** strong implementation/test observation.

Per-remote read-only/deny policies are applied before transcript ingest writes, and unreadable unattended policy state fails closed.

### M12 — interactive and unattended trust failures intentionally have different polarity

**Status:** strong design observation.

Interactive setup can recover/quarantine/re-ask; unattended ingest refuses to proceed when a saved policy cannot be determined.

### M13 — synchronization state is multidimensional

**Status:** strong subsystem inference.

Code index, transcript/artifact memory, remote brain availability, cache freshness and artifact sync can each be healthy/degraded/absent independently.

### M14 — some brain write-back design is present but not fully active

**Status:** direct source qualification.

Planning calibration write-back is generated and tested but gated on a currently-disabled feature flag/upstream capability at the pinned revision.

---

## 25. Memory control model

A neutral reconstruction is:

```text
Prior event / decision / observation
        ↓
representation chosen
  ┌──────────────┬──────────────┬──────────────┐
checkpoint    local learning   brain page/cache
  │              │              │
branch/time   source/confidence TTL/scope/type
  │              │              │
  └──────────────┴──────────────┘
                 ↓
        trust + privacy + ingest policy
                 ↓
        retrieval / routing / budget
                 ↓
        current agent context
                 ↓
        question / recommendation / plan
                 ↓
     optional write-back / invalidation
```

The system is strongest where the qualification metadata survives into consumption.

The hidden `stale-fallback` case shows the failure mode when qualification is computed upstream but lost in the final representation.

---

## 26. Cross-subsystem consequence

The first five syntheses now show a repeated architecture:

```text
Planning/spec
→ qualify intent before work admission

Review/ship
→ qualify implementation before delivery

Browser/runtime
→ qualify capability/effect/evidence at execution boundaries

Investigate
→ qualify causal explanation before corrective mutation

Memory/context
→ qualify prior informational state before reuse
```

The memory subsystem strengthens the working hypothesis that gstack is organized around **qualified transitions and qualified representations**.

It also supplies the first strong counterexample to a clean architecture narrative: qualification can be present internally yet lost at a representation boundary (`stale-fallback` → content-only prompt injection).

This counterexample is valuable because later system synthesis should explain both the design pattern and where the implementation violates it.

---

## 27. Remaining gaps

This subsystem is sufficiently reconstructed for the current research ladder, with these later dependencies:

1. independent semantic-quality evaluation of GBrain results;
2. explicit freshness labeling in planning preflight;
3. automatic semantic revalidation of restored checkpoints where load-bearing;
4. stale/user-stated preference supersession policy;
5. stronger file/content-change invalidation for local learnings;
6. full memory-ingest secret/privacy behavior under real remote sync;
7. complete GBrain artifact/transcript lifecycle and deletion/retention guarantees;
8. shared-team brain conflict/authority handling;
9. behavioral E2E proving brain preflight changes planning appropriately without over-trusting stale context;
10. multi-agent interaction with shared memory and concurrent writes.

The next high-value subsystem is **multi-agent / cross-model coordination**, because planning, ship, browser sharing and memory now all expose actor-to-actor handoffs whose authority, isolation and evidence-sharing semantics need a unified reconstruction.

---

## 28. Source re-entry map

Load-bearing sources include:

- `context-save/SKILL.md.tmpl`
- `context-restore/SKILL.md.tmpl`
- `learn/SKILL.md.tmpl`
- `scripts/resolvers/learnings.ts`
- `bin/gstack-learnings-log`
- `bin/gstack-learnings-search`
- `scripts/brain-cache-spec.ts`
- `bin/gstack-brain-cache`
- `scripts/resolvers/gbrain.ts`
- `setup-gbrain/SKILL.md.tmpl`
- `sync-gbrain/SKILL.md.tmpl`
- `bin/gstack-gbrain-repo-policy`
- `lib/gbrain-repo-policy-client.ts`
- `bin/gstack-memory-ingest.ts`
- `test/context-save-hardening.test.ts`
- `test/skill-e2e-context-skills.test.ts`
- `test/learnings.test.ts`
- `test/gstack-learnings-search.test.ts`
- `test/skill-e2e-learnings.test.ts`
- `test/brain-cache-spec.test.ts`
- `test/brain-cache-roundtrip.test.ts`
- `test/brain-preflight.test.ts`
- `test/skill-preflight-budget.test.ts`
- `test/salience-allowlist.test.ts`
- `test/gbrain-repo-policy-client.test.ts`

Use `../SOURCE-LEDGER.md` for exact read status and pinned identifiers. Re-enter long sources marked `SUBSTANTIAL / CONTINUE` before stronger whole-file claims.
