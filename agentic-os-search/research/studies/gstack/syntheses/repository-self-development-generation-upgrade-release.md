# gstack — Repository Self-Development / Generation / Upgrade / Release

## Scope

This synthesis reconstructs how the pinned gstack revision develops, materializes, updates, migrates, versions and releases **itself**.

Pinned target:

`garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`  
Version: `1.79.0`

Protected question:

> how does gstack turn authored repository state into installed executable behavior, evolve that behavior across versions, preserve working state through regeneration/upgrades, and decide what “updated” or “released” actually means?

This is the final gstack-native subsystem synthesis required for the first research layer. It does not mutate the SOUL Foundation.

---

## 1. Executive reconstruction

The repository is not merely a collection of skill Markdown files. Its self-development lifecycle is closer to a compiler/install/update/release pipeline:

```text
authored sources
  templates + resolvers + host configs + runtime code
        ↓
generation / compilation
        ↓
generated host behavior trees + compiled runtime assets
        ↓
setup / materialization
        ↓
installed skill aliases + runtime assets + hooks + user-local render overlays
        ↓
live sessions / long-lived daemons
        ↓
update detection + self-update / manual upgrade
        ↓
setup + migrations + daemon reconciliation
        ↓
version / changelog / documentation qualification
        ↓
PR queue collision checks + CI gates
        ↓
next repository version
```

The strongest system-level conclusion is:

> **repository source state, generated behavior state, installed runtime state, running-process state and release/version state are distinct standings.**

A useful negative equation is:

```text
source HEAD advanced
≠ generated artifacts current
≠ installation materialized
≠ running daemon current
≠ migration complete
≠ user-visible behavior current
≠ release semantics correct
```

Much of gstack's self-development machinery exists because earlier versions collapsed one or more of these distinctions.

---

## 2. Canonical authored state versus generated behavior

### 2.1 Templates/resolvers are the source; generated `SKILL.md` is a compiled view

`CLAUDE.md` explicitly defines the authoring workflow:

1. edit `SKILL.md.tmpl` or other generator sources;
2. run `bun run gen:skill-docs`;
3. commit both source and tracked generated output.

Generated `SKILL.md` files carry an auto-generated header and are validated against `--dry-run` regeneration.

This makes a generated skill similar to a build artifact with an intentionally committed Claude-host rendering. It is **not** the correct conflict-resolution surface. The repository explicitly says generated conflicts should be resolved at the template/resolver source and then regenerated.

Therefore:

```text
SKILL.md generated output
= inspectable / executable representation
≠ canonical authoring source
```

### 2.2 Generation is contextual compilation, not textual copying

`scripts/gen-skill-docs.ts` composes behavior from multiple sources:

- template text;
- resolver outputs;
- host configuration;
- model/profile overlays;
- carved on-demand sections;
- suppression decisions;
- catalog/explain-level configuration;
- optionally persisted local detection state for user-local renders.

This explains why a single source template may legitimately produce different target-host behavior.

It also means source-view fidelity depends on preserving the compilation inputs. A generated skill can be syntactically fresh while having different semantics because host/model/resolver inputs differ.

### 2.3 Reproducible canonical render versus machine-local render

A particularly important split is deliberate:

```text
canonical committed render
→ reproducible; does not depend on local GBrain detection

user-local render
→ may respect detected local capabilities / brain configuration
```

The local path uses an out-of-tree render destination (`~/.gstack/render/...`) rather than mutating tracked repository output.

This is a mature separation between:

- shared repository truth;
- generated canonical representation;
- machine-/user-specific materialization.

---

## 3. Generation freshness and what it actually proves

### 3.1 Strong tracked-output freshness for the canonical Claude tree

`test/gen-skill-docs.test.ts` and `.github/workflows/skill-docs.yml` provide multiple pins:

- dynamic template discovery;
- generated-header checks;
- strict frontmatter YAML parsing;
- source command/snapshot parity;
- version parity;
- `--dry-run` freshness;
- all-host generation success;
- no unexpected untracked generated files.

The CI path actually regenerates and checks `git diff --exit-code` for tracked generated files.

This is stronger than a static “generator exits 0” check: it verifies that tracked generated representation matches current generator inputs.

### 3.2 External-host freshness has a weaker standing

The same CI file states a deliberate limitation: the nine gitignored external-host output trees generate successfully but are not byte-freshness compared as committed artifacts, because they are untracked/ignored.

Thus:

```text
all hosts generated successfully
→ structural/generation standing

tracked Claude output byte-fresh
→ stronger representation parity standing
```

They are not interchangeable.

This reinforces the earlier portability result:

> generation health is not behavioral portability health, and generation success is not identical to persisted byte-freshness.

---

## 4. Setup is materialization, not a trivial installer

The `setup` script is a major runtime boundary. It converts a repository checkout into host-visible and runtime-usable state.

Its responsibilities include, among others:

- host-specific installation;
- symlink versus copy behavior by platform;
- ownership/provenance checks before replacing paths;
- generation/build execution;
- runtime asset installation;
- hooks and settings registration;
- browser/runtime dependencies;
- user-local render wiring;
- migrations;
- stale-hook healing;
- GBrain detection and overlays.

Therefore “repository contains the correct skill” does not prove “installed skill is complete.”

### 4.1 Runtime assets are part of a skill contract

A historical defect demonstrated the distinction: installers once linked only `SKILL.md` and carved sections, leaving sibling runtime assets absent. Skills such as review, QA, upgrade, careful and freeze then looked installed but could not execute all referenced behavior.

`test/setup-claude-skill-assets.test.ts` now runs the real extracted installer functions into a temporary skills tree and asserts:

- required sibling assets are installed;
- carved sections remain available;
- build/source/test/template exclusions remain excluded;
- alias-relative references resolve;
- repo-anchored references resolve, with explicit built-artifact exceptions;
- known-broken reference exemptions are a shrink-only ratchet and currently empty.

This yields a strong distinction:

```text
skill document present
≠ skill installation complete
```

### 4.2 Provenance matters before replacement

Setup carries path-ownership/provenance logic, especially where Windows copy semantics replace symlinks. This is not just portability glue: it is authority protection. A directory collision with user-owned content must not be treated as gstack-owned state merely because its path matches an expected install location.

---

## 5. Atomic user-local rendering preserves the last working materialization

Pre-v1.67 behavior rendered brain-aware skill output directly into the tracked install checkout. That had two costs:

1. it permanently dirtied a git install with generated content;
2. upgrades then confused regenerable render dirt with user-authored local changes.

The current design renders to a temporary out-dir and swaps the result into the stable live render path only after successful generation.

`test/user-render-out-dir-install.test.ts` behaviorally pins that:

- setup/user render writes to a temporary out-dir;
- successful render atomically replaces the live render;
- failed render leaves the previous live render untouched;
- existing installed symlinks continue resolving to the previous working render;
- the canonical source tree remains unchanged;
- installer/relink prefers a user-local rendered `SKILL.md` only when it exists.

The important mechanism is:

```text
candidate materialization
        ↓
validate/build succeeds?
   no → retain previous live state
   yes → atomic-ish path swap
```

This is a recurring gstack theme: **preserve known-working state under incomplete replacement**.

---

## 6. Upgrade has multiple distinct paths

There is no single universal “upgrade” mechanism.

### 6.1 Manual / skill-driven `/gstack-upgrade`

The upgrade workflow first detects install type.

For git installs it prefers:

```text
git fetch
→ git pull --ff-only --autostash
→ setup
```

If fast-forward fails, destructive reset is not automatic unless safety conditions are proven. Dirty files and unpushed commits are inspected and a one-way human decision gate is used before discarding state.

For vendored installs the flow uses a replacement directory + `.bak` recovery design. A stale backup from an earlier failed upgrade causes an abort rather than silently deleting what may be the only recoverable copy.

This path therefore has substantial rollback/preservation thinking.

### 6.2 Session-start automatic update

`bin/gstack-session-update` is a different operational path:

- only when auto-upgrade/team behavior is enabled;
- throttled;
- backgrounded so session startup is not blocked;
- guarded by a lock with holder identity, TTL and heartbeat;
- stale-lock reclaim uses atomic move-aside rather than racy remove-then-create;
- `git pull --ff-only --autostash`;
- local generated/patched state is re-rendered/healed;
- setup is attempted when HEAD moves;
- activity is logged.

`test/session-update-autostash.test.ts` provides behavioral evidence for the pull/autostash and lock-liveness classes.

This is a highly engineered liveness path — but it has a standing problem described below.

---

## 7. Update detection has a deliberate availability-over-freshness compromise

`bin/gstack-update-check` contains a sophisticated remote-version path:

- local VERSION as current identity;
- separate TTLs for `UP_TO_DATE` and `UPGRADE_AVAILABLE` cache entries;
- SHA resolution through `git ls-remote`;
- SHA-pinned raw VERSION fetch to avoid branch-raw CDN staleness;
- semantic ordering guard so a stale lower remote never becomes a backward upgrade;
- snooze/backoff state;
- explicit crash trap.

A crash is correctly represented as:

```text
CHECK_FAILED ... update status UNKNOWN, not up-to-date
```

because silence previously produced a long false-current incident.

### 7.1 Negative finding: unreachable/invalid remote is still cached as `UP_TO_DATE`

The same script treats an empty or invalid remote VERSION as:

```text
UP_TO_DATE <local>
```

and stores that result in the cache.

This is not an inference from error handling; `browse/test/gstack-update-check.test.ts` explicitly pins current behavior with cases such as:

- invalid remote response → cache `UP_TO_DATE`;
- unreachable remote → exit silently + cache `UP_TO_DATE`.

Therefore:

```text
remote could not establish freshness
→ positive/current representation
```

for this failure class.

The system treats script crashes and network/parse failures differently:

```text
script crash     → UNKNOWN
remote unavailable/invalid → UP_TO_DATE
```

This is a real epistemic asymmetry. It favors non-disruptive preamble behavior over strict freshness truth.

It should not be interpreted as “remote freshness was verified.”

---

## 8. Source checkout advancement and installed-runtime advancement can diverge

`bin/gstack-session-update` contains another important boundary.

When git HEAD changes, it runs `./setup -q`. If setup fails, the path logs `SETUP_FAILED` but continues. It can still:

- write `just-upgraded-from`;
- clear update/snooze state;
- log `UPDATED from=... to=...` based on repository VERSION.

The targeted tests found for this script strongly cover autostash and lock identity/liveness, but no targeted test was found for the `SETUP_FAILED` → marker/`UPDATED` standing sequence.

The conservative conclusion is therefore:

> **source-observed gap + targeted coverage gap:** this auto-update path can represent checkout advancement as an update even when materialization/setup failed.

Do not strengthen this into a claim that every setup failure leaves a broken install; setup may have partially or sufficiently materialized before failing. The precise problem is representation:

```text
checkout advanced
≠ setup succeeded
```

but the auto-update completion markers do not preserve that distinction.

This contrasts with the stronger “candidate render failed → retain previous render” semantics in user-local rendering.

---

## 9. Migrations are idempotent locally but global selection is version-window based

Upgrade migrations live under `gstack-upgrade/migrations/v*.sh` and cover state changes that regeneration/setup alone cannot express.

The design includes good local properties:

- ordered versioned migrations;
- scripts intended to be idempotent;
- several migrations have their own journal/done markers;
- installation directory is passed explicitly for migrations that mutate install state;
- tests cover specific migration contracts and re-entry behavior.

The v1.27 rename migration is a strong example: it has a journal, per-step completion, a `.done` marker and safe re-entry after interruption.

### 9.1 Negative finding: migration selection can permanently skip an unperformed migration

Both the setup runner and `/gstack-upgrade` select migration scripts primarily by old→new **version window**.

The repository's own pinned `TODOS.md` explicitly records the failure class:

- a migration may default-skip in non-interactive mode;
- the outer version marker then advances past that migration;
- future normal upgrades will not re-offer it;
- direct manual invocation becomes the only recovery path;
- desired future design is per-migration `.done/.skipped` state rather than global version-window selection alone.

The v1.27 script itself acknowledges this: on non-interactive skip it prints a direct rerun command because “there is no runner re-ask.”

Therefore:

```text
migration script was in the eligible version window
≠ migration completed

outer setup/upgrade version advanced
≠ all migrations in the window completed
```

This is a direct counterexample to a simplistic monotonic-upgrade state machine.

---

## 10. Long-lived processes create a separate runtime freshness problem

An upgrade that changes files does not automatically replace already-running code.

The `/gstack-upgrade` workflow explicitly handles the browser daemon as a separate standing:

- compare newly built binary hash to daemon state;
- no live daemon → nothing to reconcile;
- matching hash → current;
- stale responsive daemon → stop it so next command starts fresh;
- stale busy daemon → defer rather than kill active work.

This confirms another distinct relation:

```text
files on disk current
≠ live process current
```

The daemon rule also shows work/liveness authority: “stale” does not automatically authorize termination when the process is actively doing work.

---

## 11. Version state is partially deterministic and partially judgmental

### 11.1 Exact version-state handling is extracted from prompt prose

`bin/gstack-version-bump` exists because version idempotency was too dangerous to leave entirely in `/ship` prose.

It defines deterministic states:

```text
FRESH
ALREADY_BUMPED
DRIFT_STALE_PKG
DRIFT_UNEXPECTED
```

and separates:

```text
classify → read only
write    → write exact approved version
repair   → repair manifest drift without another bump
```

Tests exhaustively pin state classification and mutations.

The writer also:

- validates 3-/4-digit forms;
- preserves the 4-digit gstack VERSION source while writing npm-valid 3-digit manifests;
- synchronizes existing npm lockfiles;
- surfaces half-writes with a distinct failure code;
- constrains configurable version/manifest paths to the repository, including symlink escape checks.

This is a strong move from **agent interpretation → deterministic state machine** for a known footgun.

### 11.2 Bump level remains semantic judgment

The CLI deliberately does **not** decide whether work deserves micro/patch/minor/major. That remains an interpretation of release scale and user-facing meaning.

`CLAUDE.md` provides guideposts but calls them smell checks, not mechanical rules.

Thus:

```text
exact version write
→ deterministic

meaning of release scale
→ judgmental / policy-guided
```

This is an intentional division of labor rather than unfinished extraction.

---

## 12. Queue-aware allocation treats version identity as a shared resource

`bin/gstack-next-version` treats a VERSION slot as something that can be claimed concurrently by:

- open PRs/MRs;
- active sibling worktrees.

It is a reader/reporter, not a writer. It scans other claims and proposes the next free slot while preserving the requested bump level.

`test/gstack-next-version.test.ts` covers the arithmetic and collision semantics extensively, including 3-digit repositories and multi-collision scenarios.

The corresponding Version Gate CI:

1. reads base and PR versions;
2. reconstructs bump level from the first changed numeric slot (`scripts/detect-bump.ts`);
3. queries the queue allocator;
4. rejects a PR whose VERSION is not above base or collides with another known open claim.

### 12.1 The gate intentionally fails open on allocator failure

`.github/workflows/version-gate.yml` and `scripts/compare-pr-version.ts` explicitly prefer not to freeze the merge queue if the allocator/API fails.

If the util is offline, malformed or cannot run, collision checking can be skipped with a warning.

Therefore a passing Version Gate proves only a bounded property:

> when the queue view was available and interpretable, this branch did not claim a known conflicting slot and its version was above base.

It does **not** prove:

- queue knowledge was complete under every failure;
- bump level was semantically appropriate;
- release notes accurately described the diff;
- generated/install/runtime states were current.

---

## 13. Release identity is branch-scoped; CHANGELOG is a released-view artifact

`CLAUDE.md` makes an unusually explicit distinction between **branch development history** and **what the user actually receives**.

Rules include:

- each shipping branch gets its own version and CHANGELOG entry;
- merging a newer main does not make the branch's own release identity disappear;
- branch-internal intermediate versions that never landed are not user releases;
- multiple branch-internal entries should be collapsed into the final released entry;
- CHANGELOG should describe capabilities present in the final main-vs-branch diff, not planning/review/fix chronology.

This is a source/view fidelity policy:

```text
branch construction history
≠ released product history
```

The released-view artifact intentionally hides internal dead ends and intermediate branch versions.

This is not evidence destruction: commits/PR history retain contributor/process history; CHANGELOG has a different audience and semantic role.

---

## 14. Documentation is explicitly post-implementation qualification

`/document-release` sits after code is shipped into the branch/PR flow but before merge.

Its job is not simply “write docs.” It reconstructs a documentation coverage view from the actual diff:

- public surface inventory;
- Diataxis-style reference/how-to/tutorial/explanation coverage map;
- architecture diagram drift;
- cross-document contradictions;
- version/CHANGELOG consistency;
- TODO cleanup;
- PR body documentation debt.

It has explicit authority boundaries:

- factual corrections can be automatic;
- risky narrative/security/large rewrites require human authority;
- CHANGELOG may be polished but not regenerated/clobbered;
- VERSION is never silently bumped;
- spawned/headless mode further restricts VERSION/CHANGELOG mutations.

This supports a broader result:

> documentation is treated as a derived representation that must be re-qualified against shipped source, not as an automatically authoritative description of the repository.

That is consistent with the study's direct discovery that `docs/PROJECT_STRUCTURE.md` and host docs can lag actual implementation.

---

## 15. “Release” does not necessarily mean tag-pinned immutable installation

A protected TODO in the pinned repository records an unresolved release semantics issue (`#2378`):

- update-check compares the local VERSION to `main:VERSION`;
- upgrade installs `main` HEAD;
- therefore users can receive commits that sit between version-release points.

The repository itself describes the design question as tag-pinned installs versus HEAD installs.

This is an important standing limitation:

```text
VERSION says vX
≠ installed checkout necessarily equals an immutable vX tag snapshot
```

At the pinned revision, **VERSION is a product/release identity signal, but upgrade materialization is main-HEAD-oriented rather than strict release-tag deployment**.

No dedicated pinned GitHub `release.yml` publication workflow was found; the inspected release machinery is centered on VERSION/CHANGELOG/PR/ship discipline and queue-aware merge workflow, not a single immutable release-publisher pipeline.

---

## 16. Evolution chronology — from features toward controlled recurrence

Chronology was used here as a horizontal validation stream, not as another taxonomy.

The commit history up to the pinned revision shows a compressed evolution over roughly six months:

### Early phase — workflow and capability expansion

March/early April history includes rapid addition of:

- QA behavioral requirements and LLM judging;
- Codex as an outside-model surface;
- richer planning workflows;
- persistent browser/CDP/sidebar capabilities;
- per-tab coordination.

This period is feature-heavy and establishes many of the later system surfaces.

### Middle phase — real environment and community failure pressure

By May, large “wave” commits are explicitly organized around community-reported bugs and bisected failures. Examples include:

- cross-plugin state contamination;
- GBrain API/schema drift;
- Windows build incompatibility;
- CLI/runtime-version incompatibility;
- diff-scope correctness;
- new Windows fresh-install E2E gates.

The architecture starts accumulating **failure-class-specific regression pins** rather than only feature tests.

### Later phase — self-consistency and control-system hardening

By the v1.67 tracker wave, the repository is explicitly repairing second-order operating-system problems:

- host generated-output fixtures;
- complete runtime asset installation;
- user-local rendering no longer dirtying canonical checkout;
- upgrade migrations receiving the true install directory;
- stale generated render state not being resurrected by stash;
- substantial test/coverage audits;
- host/setup/brain-sync integrity.

The repository is increasingly working on the correctness of **its own machinery for changing itself**.

### Pinned phase — recurrence/liveness becomes a first-class defect class

v1.79 is particularly revealing. The release is explicitly framed as the **third recurrence** of a subagent-dispatch liveness class after Claude Code changed background semantics.

The response is layered:

```text
specific fix
→ shared foreground-dispatch guidance
→ deadline/recovery semantics
→ generated-carrier pins
→ structural scanner for future dispatch sites
→ behavioral E2E proving the model actually uses Agent with foreground flag
→ adversarial review of the recovery contract
```

This is the strongest evidence for the study's evolution hypothesis:

> repeated failures are progressively converted from local fixes into reusable contracts, deterministic helpers, structural scanners, behavioral tests and CI reconciliation.

But the process is not monotonic perfection. The same pinned state still contains explicit TODOs and counterexamples where qualification is lost or outer standing advances too far (migration selection, release-tag semantics, update-check offline freshness, session-update setup completion).

---

## 17. A recurring self-development pattern

Across generation, setup, upgrade, versioning and test history, a common progression appears:

```text
behavior begins as prose / local convention
        ↓
real failure exposes ambiguity or hidden state
        ↓
state distinction is named
        ↓
reusable resolver/helper/CLI is extracted
        ↓
structural invariant / scanner is added
        ↓
behavioral or environment E2E is added when affordable
        ↓
CI/release consequence is attached where justified
```

Examples:

- version re-bump footgun → `gstack-version-bump` state machine;
- version queue collision → `gstack-next-version` + Version Gate;
- generated render dirt → out-dir rendering + atomic swap + migration;
- missing runtime assets → generalized installer asset linking + path-resolution tests;
- stale generated docs → generator freshness CI;
- hidden test non-execution → strict/sharded eval reconciliation;
- repeated subagent stranding → explicit dispatch contract + scanner + E2E.

This is not universal automation. Some control remains deliberately advisory or human-authorized.

---

## 18. Failure polarity in self-development is context-specific

The subsystem does not implement one global “fail closed” philosophy.

Examples:

| Condition | Observed posture |
|---|---|
| tracked generated Claude output stale | CI fail |
| external host generation error | generation/CI fail |
| user-local render candidate fails | retain previous live render |
| destructive upgrade reset with user state | ask / one-way authority |
| stale `.bak` on vendored upgrade | abort |
| individual migration error | warn / continue |
| non-interactive migration consent gate | skip / manual rerun |
| update-check script crash | report UNKNOWN |
| update-check invalid/unreachable remote | cache UP_TO_DATE |
| session-start update pull failure | log / preserve session availability |
| session-start setup failure after HEAD moved | log failure but completion markers can still advance |
| version queue util unavailable | CI warning / fail-open |
| known version collision | CI fail |
| stale responsive daemon | stop |
| stale busy daemon | defer |

This is coherent only when the user/runtime cost of blocking is considered. It also creates epistemic asymmetries that downstream consumers must not flatten.

---

## 19. Verification-strength map

### Strong source + deterministic test evidence

- template→generated-file freshness for tracked Claude output;
- version-state classifier/writer;
- queue slot arithmetic;
- installer runtime-asset path completeness;
- user-render temp/swap behavior;
- update-check cache/version behavior;
- migration journal/idempotency for selected migrations;
- session-update autostash/lock liveness.

### Strong source observation, narrower behavioral coverage

- entire multi-host setup flow as one end-to-end install transaction;
- complete manual `/gstack-upgrade` rollback behavior across every install type;
- setup failure after successful session-update pull and user-visible “updated” representation;
- all migration selection/retry combinations;
- semantic appropriateness of bump level;
- CHANGELOG truthfulness for arbitrary releases.

### Explicit known limitations / open design debt

- per-migration pending/skip standing in outer runners;
- main-HEAD upgrade versus tag-pinned release semantics;
- partially hardcoded host setup dispatch;
- update-check unreachable/invalid remote represented as `UP_TO_DATE`;
- external-host generated output not committed-byte-freshness checked;
- setup/materialization success not fully preserved in session-update completion markers.

---

## 20. Cross-subsystem implications

### 20.1 gstack qualifies its own operating system

Earlier syntheses found qualification of intent, work, implementation, evidence, authority, causal explanation, prior memory, delegation, host semantics and production state.

This subsystem adds another level:

> gstack also qualifies — imperfectly — **the machinery that produces and updates those qualifiers**.

That makes self-development part of the operating system, not merely repository maintenance.

### 20.2 Representation fidelity is recursive

The chain can contain multiple derived representations:

```text
template/resolver source
→ generated skill
→ installed alias/render
→ running agent context
→ eval result
→ release documentation
```

Each boundary can lose qualification metadata. The study has now observed several real examples across different subsystems.

### 20.3 Work-system continuity includes executable continuity

Checkpointing conversations is only one form of continuity. The self-development layer also tries to preserve:

- last working render;
- local user changes;
- migration progress;
- install path ownership;
- updater lock ownership;
- long-lived daemon work;
- branch release identity.

### 20.4 Release is a bundle of standings, not one event

A useful decomposition is:

```text
source complete
→ generated representation fresh
→ install/materialization valid
→ version identity assigned
→ release docs represent diff
→ queue slot valid
→ CI gates pass
→ branch merges
→ users update
→ migrations/materialization succeed
→ running processes converge
```

No single marker inspected in this subsystem proves the whole chain.

---

## 21. Native first-layer conclusion

With this subsystem, the gstack-native first research layer can be considered **boundedly complete** for the pinned revision.

The layer now covers:

1. planning / specification / work admission;
2. review / QA / ship qualification;
3. browser runtime / security / evidence;
4. investigation / causal control;
5. memory / learnings / GBrain;
6. multi-agent / cross-model coordination;
7. guarded action / security review;
8. host adaptation / portability;
9. deploy / canary / production / retrospective feedback;
10. testing / eval / routing / compliance / flake lifecycle;
11. repository self-development / generation / setup / upgrade / release.

Chronology was sampled across early capability growth, middle community/environment bug waves, later self-consistency hardening and the pinned v1.79 recurrence fix. It supports the mechanism model sufficiently for the next step; a full linear CHANGELOG read is not required to close this layer and would add large amounts of release prose without proportionate structural information.

The next authorized research layer should no longer ask “what is each subsystem?” It should ask:

> **how do these subsystems compose into one operating system, which state/authority/evidence objects cross subsystem boundaries, and where does qualification strengthen, weaken or get lost as work moves through the system?**

Only after that gstack-native cross-system synthesis should the study project the result onto Information, Work, Actors and Environment.

---

## 22. Protected cautions

1. Generated-file freshness is not host semantic equivalence.
2. Setup success and repository HEAD are distinct standings.
3. Update-check `UP_TO_DATE` is not always remote freshness evidence; invalid/unreachable remote currently collapses into that cache state.
4. Session-start update completion markers can outpace setup/materialization success.
5. Migration script idempotency does not solve outer-runner version-window skipping.
6. VERSION identity does not establish tag-pinned immutable installed code at the pinned design.
7. Queue-aware version CI intentionally fails open when its allocator/API is unavailable.
8. A numerically valid bump does not prove the semantic bump level was appropriate.
9. CHANGELOG is a released-product view, not a full development-history ledger.
10. Documentation release is a representation audit, not runtime truth.
11. Chronology evidence is first-party repository history; it establishes evolution in the project, not external effectiveness.
12. All conclusions remain pinned-revision conclusions; revalidate current upstream before load-bearing later adoption.
