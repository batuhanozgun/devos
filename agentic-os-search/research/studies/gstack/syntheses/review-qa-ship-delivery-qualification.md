# gstack Subsystem Synthesis — Review, QA, Ship, and Delivery Qualification

## Status

- **Study:** `gstack`
- **Target:** `garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`
- **Observed:** 2026-09-05
- **Synthesis status:** bounded subsystem synthesis; not a whole-repository conclusion
- **Depends on:** `planning-specification-work-admission.md`
- **Foundation/SOUL adoption status:** none; external-target evidence only

## Question

When implementation exists, how does the pinned gstack revision decide whether the work is sufficiently reviewed, empirically tested, aligned with the plan, and qualified to ship? In particular, do upstream planning/review states actually constrain shipping, or are they only recommendations?

## Short answer

**INFERENCE:** gstack implements a **delivery-qualification stack**, not a strict linear `review → QA → ship` state machine.

`/ship` is the principal closure/orchestration boundary. It does not require every earlier specialist workflow to have run. Instead, it recomputes several kinds of evidence at ship time and conditionally turns available durable artifacts into gates.

A gstack-native reconstruction is:

```text
implemented branch
      │
      ├── historical review state ───────────────┐
      │                                           │ context / freshness
      ▼                                           │
/ship preflight                                   │
      │                                           │
      ├── merge latest base                       │
      ├── run test suites + classify ownership    │
      ├── assess changed-path coverage            │
      ├── if plan discoverable: audit completion  │
      │       └── if verifiable UI plan: /qa-only │
      ├── fresh pre-landing diff review            │
      ├── specialist / red-team review             │
      ├── adversarial Claude + optional Codex      │
      ├── fix → re-test → re-review closure loop   │
      ├── documentation/release synchronization    │
      └── PR body as consolidated evidence record  │
                                                  │
                         review logs / plan / QA artifacts
```

The strongest answer to the opening question is therefore:

> **Upstream qualification can constrain shipping, but only when the relevant artifact/state is discoverable and the ship workflow recognizes it. Missing prior Eng/CEO/Design reviews do not universally block ship because `/ship` can produce a fresh diff-scoped Eng Review itself. A discovered plan, however, is promoted from context into an active delivery-control input: known missing or unverifiable plan items interrupt shipping until the user resolves or explicitly overrides them.**

This is a conditional, evidence-sensitive, user-sovereign control model — not a fail-closed universal lifecycle.

---

## 1. `/review`, `/qa`, and `/ship` answer different verification questions

### `/review` — structural/diff reasoning

`review/SKILL.md.tmpl` examines the branch diff for defects that ordinary tests may miss: data safety, race/concurrency, trust-boundary errors, shell injection, enum/value completeness, design/code quality and other structural risks.

Its review machinery includes:

- scope-drift and plan-completion comparison;
- confidence calibration;
- a pre-emit evidence rule requiring the motivating source lines for high-confidence findings;
- specialist review lenses;
- optional/conditional red team;
- a Fix-First policy that separates mechanical fixes from user-judgment findings;
- persisted review results and finding fingerprints.

**INFERENCE:** `/review` is primarily a **source/diff oracle**: it reasons about the implementation and its structure.

### `/qa-only` — user-observable empirical evidence

`qa-only/SKILL.md.tmpl` and the shared QA methodology require browser-based testing as a user rather than reading implementation source. The workflow navigates pages, exercises interactions/forms/states, checks console errors, tests responsive behavior, reproduces problems, and records screenshots/repro steps.

Interactive defects require before/action/result evidence plus a snapshot delta; issues are retried before being accepted as reproducible. Reports and screenshots are durable artifacts.

**INFERENCE:** `/qa-only` is a materially different **runtime/user-observation oracle** from static review.

### `/qa` — empirical evidence plus corrective loop

`qa/SKILL.md.tmpl` extends the same browser methodology into:

```text
observe → classify → minimally fix → atomic commit → re-observe
                                      │
                                      └→ regression test when appropriate
```

It reverts fixes that make behavior worse, distinguishes verified/best-effort/reverted/deferred outcomes, reruns final QA, and self-regulates the volume/risk of accumulated fixes with a stop heuristic and hard cap.

**INFERENCE:** `/qa` is not only a verifier; it is a bounded **test–repair–reverification loop** whose evidence is tied to user-visible behavior.

### `/ship` — evidence aggregation and release admission

`/ship` consumes or recreates several of the above evidence forms, merges base, executes tests, checks coverage, audits plan completion, can invoke `/qa-only` for declared plan verification, performs fresh pre-landing review, runs adversarial passes, and assembles the results into release/PR artifacts.

**INFERENCE:** `/ship` is best modeled as a **delivery qualification orchestrator**, not simply a push/PR command.

---

## 2. Historical Eng Review is required conceptually but not as a prior-work prerequisite

The shared Review Readiness Dashboard declares Eng Review the only review that gates shipping by default. Its Eng row accepts either:

- `plan-eng-review` — plan-stage architecture review; or
- `review` — diff-scoped implementation review.

Entries older than seven days are ignored, and diff-scoped review freshness can be determined content-first from a working-tree fingerprint rather than merely commit count.

However, `/ship` preflight explicitly handles `Eng Review != CLEAR` by saying that ship will run its own pre-landing review later. It does **not** block merely because an earlier `/plan-eng-review` or standalone `/review` was absent. CEO and Design review absence is informational.

There is no contradiction if the unit is modeled correctly:

```text
required concept:    a current Eng Review before landing
not required:        a prior standalone Eng Review invocation
ship can satisfy:    current diff-scoped Eng Review itself
```

**INFERENCE:** gstack separates **qualification type** from **workflow provenance**. A required standing may be satisfied by different work paths.

This is one of the strongest mechanisms observed so far because it avoids two opposite failures:

- treating historical process ceremony as mandatory even when ship can recompute stronger/fresher evidence;
- shipping with no engineering review merely because no earlier review exists.

There is also a global `skip_eng_review` escape hatch. Therefore even this required-by-default qualification remains configurable rather than absolute.

---

## 3. Review freshness is content-relative, not only timestamp-relative

The Review Dashboard's staleness rules distinguish plan-tier and diff-tier evidence.

For diff-scoped review entries:

- identical working-tree fingerprint means CURRENT even after rebase/amend/commit changes;
- if fingerprint is unavailable or mismatched, commit ancestry/count is a fallback;
- rebased-away commit identity grades UNKNOWN/stale rather than silently current.

For plan-tier reviews:

- the working-tree rule does not apply because the reviewed object is a plan;
- seven-day recency remains the default;
- where `plan_sha256` exists, changed plan bytes can be surfaced as stale.

**INFERENCE:** validity is evaluated relative to the **object actually reviewed**, not merely “a review happened recently.”

This is a stronger design than a simple timestamp badge, but it is still implemented through generated workflow instructions and local review-log tooling; broader runtime/tool tests should be inspected before treating every branch of the freshness policy as behaviorally verified.

---

## 4. A plan becomes an active ship-control object when it is discoverable

The difference between standalone `/review` and `/ship` plan completion is important.

### In `/review`

The plan-completion pass is generally informational. It reconstructs plan intent and classifies items as:

- DONE
- PARTIAL
- NOT DONE
- CHANGED
- UNVERIFIABLE

It explicitly recognizes different verification modes:

- DIFF-VERIFIABLE
- CROSS-REPO
- EXTERNAL-STATE
- CONTENT-SHAPE

and refuses to equate “related code exists” with “the deliverable exists.” Concrete filesystem paths must be checked where reachable; external state is honestly surfaced as unverifiable. High-impact discrepancies can still trigger a user decision, but the audit's main role is review evidence.

### In `/ship`

The same conceptual audit is promoted into a **release gate** and dispatched in a fresh foreground subagent context.

If NOT DONE items exist, shipping interrupts and the user must choose among:

- stop and implement;
- explicitly defer/ship anyway;
- intentionally drop the item.

If UNVERIFIABLE items exist, confirmation is per-item by default. A negative confirmation converts the item into missing work and stops shipping. The workflow explicitly forbids silent blanket confirmation because of a prior failure pattern (VAS-449).

If the audit subagent fails, `/ship` falls back to an inline audit; if that also fails, it surfaces an explicit skip-vs-stop decision rather than silently passing.

`test/ship-plan-completion-invariants.test.ts` deterministically pins several of those remediation properties against the generated ship union:

- concrete path checks;
- validator detection;
- mandatory per-item UNVERIFIABLE confirmation;
- no silent fail-open after audit failure.

### Critical boundary

**No plan file found → plan completion audit skips.**

Therefore:

> The plan is not a mandatory universal prerequisite to shipping. But once a relevant plan is discoverable, its actionable items become acceptance evidence and can actively interrupt release.

**INFERENCE, strong:** gstack converts a durable Information artifact into a conditional **Work/Control constraint** without making the artifact itself globally mandatory.

---

## 5. Plan verification can turn declared acceptance steps into browser evidence

After plan-completion, `/ship` searches the plan for a verification/testing section. If one exists and a dev-server URL can be resolved, it loads `/qa-only` and uses the plan's verification items as the primary test cases.

That creates a chain:

```text
planned verification claim
        ↓
concrete browser test case
        ↓
user-observable runtime evidence
        ↓
PASS / FAIL
        ↓
ship decision
```

A failure interrupts ship and asks whether to fix or knowingly ship the issue.

However:

- no plan → skip;
- no verification section → skip;
- no discoverable server → skip;
- unreadable QA skill → skip.

Thus general standalone QA is not a mandatory phase of every ship. The stronger statement is:

> **gstack can promote plan-declared verification into ship-time empirical browser validation, but this path is conditional on the presence and executability of the verification specification.**

This is materially narrower than treating the README's `Review → Test → Ship` wording as proof that every release traverses a universal QA state.

---

## 6. Test-suite evidence is ownership-aware

The ship test section merges the base branch before running tests so the verdict is about the code in a more landing-like state.

Test executions are wrapped in an evidence ledger that records command, exit status, working-tree fingerprint and log path.

When tests fail, the workflow does not treat every failure identically. It classifies whether the failure is:

- in-branch;
- likely pre-existing;
- ambiguous.

Ambiguity defaults to in-branch because allowing a possibly branch-caused failure through is considered more dangerous than stopping unnecessarily.

Known in-branch failures block. Pre-existing failures route through explicit ownership/scope choices influenced by repository mode (solo vs collaborative/unknown).

**INFERENCE:** test validity is partly relational: a red test matters differently depending on whether the candidate work is responsible for it.

This prevents “the suite is red, therefore this branch is bad” from being the only model, while retaining conservative failure polarity under uncertainty.

---

## 7. Coverage is an AI-assessed path map with thresholds, not ordinary line coverage

The ship coverage audit asks a fresh-context subagent to inspect every changed file, trace data/control paths, user flows, error states and boundary conditions, then map those paths to existing tests.

It distinguishes:

- code paths;
- user flows;
- E2E-worthy integration paths;
- LLM changes that may require evals.

It can generate missing tests and then applies project-defined or default thresholds:

- target default: 80%
- minimum default: 60%

Below target, the user can request more tests, ship accepting risk, or mark paths intentionally uncovered. Below minimum, the user can still explicitly override after the generation attempts.

If a numeric coverage percentage cannot be determined, the gate skips rather than inventing 0%.

### Evidence-strength caveat

This percentage is **model-assessed changed-path coverage**, not an objective instrumentation-derived line/branch coverage metric. It may provide broader semantic coverage than a line counter, but its oracle is also less deterministic.

The audit's subagent failure fallback is explicitly non-blocking: partial results are preferred to stopping ship.

**INFERENCE:** this is a risk/coverage decision aid with configurable/overrideable admission semantics, not a hard mathematical proof of test sufficiency.

---

## 8. Pre-landing review is recomputed and has a fix-to-closure loop

Ship Step 9 does not accept a historical clean review as sufficient. It performs a fresh diff review after base merge/tests/plan audit.

The inspected mechanism includes:

- critical + informational checklist passes;
- motivating-source-line requirement for high-confidence findings;
- conditional design review;
- specialist selection based on scope;
- adaptive specialist gating from historical hit rates;
- never-gate treatment for high-risk insurance specialists such as security/data migration;
- fresh-context specialist subagents in the intended production contract;
- merge/dedup and multi-specialist agreement;
- conditional red team;
- prior-user-skipped finding suppression only when the same fingerprint recurs **and its file has not changed**;
- Fix-First AUTO-FIX vs ASK decisions.

If a fix is applied during ship, the workflow commits the fix and **within the same invocation** reruns tests and review. It repeats until a full pass makes zero fixes, bounded to three cycles; non-convergence then becomes a blocker.

```text
review
  ↓
fix
  ↓
tests
  ↓
review
  ↓
zero-fix pass? ── no → loop (max 3)
      │
     yes
      ▼
continue ship
```

**INFERENCE, strong:** gstack treats review not as a one-shot judgment but as a bounded **closure process** whose verdict must be recomputed after the evidence object changes.

---

## 9. Review Army verification evidence is meaningful but uneven

`test/skill-e2e-review.test.ts` behaviorally exercises selected review capabilities against planted defects, including SQL-injection-style source, enum-completeness omissions and design anti-patterns.

`test/skill-e2e-review-army.test.ts` covers migration-safety, N+1/performance, plan-delivery gaps, quality score and related scenarios. But several scenarios instruct the primary test agent to read and apply specialist checklists itself rather than reproducing the full production parallel-Agent topology.

Therefore the E2Es support claims such as:

- the checklist logic can lead a model to detect selected planted issue classes;
- plan completion can identify a known missing deliverable;
- selected output contracts can survive generation.

They do **not** fully establish:

- that every production specialist is dispatched correctly under every scope configuration;
- that parallel fresh-context isolation works identically in all hosts;
- that merged/deduplicated specialist verdicts have calibrated real-world false-positive rates.

This distinction matters more than simply counting E2E files.

---

## 10. QA has stronger behavioral evidence for its core action boundary

`test/skill-e2e-qa-workflow.test.ts` exercises multiple real workflow properties:

- `/qa` against a running test server;
- `/qa-only` with the Edit tool deliberately unavailable, then verifies no source modification occurred and the working tree remained clean apart from report/state paths;
- `/qa` fix-loop behavior on a deliberately buggy local app, verifying at least one new fix commit and actual source-edit tool use;
- additional bootstrap scenarios in the broader file.

These are still first-party E2Es, but for the tested boundaries they observe the actual behavioral distinction between:

```text
QA-only = observe/report
QA      = observe + modify + commit + reverify
```

That is stronger evidence than the workflow prose alone.

---

## 11. Adversarial review is “always attempted,” not “guaranteed independent coverage”

Ship's adversarial section says every diff gets Claude adversarial review and Codex adversarial challenge, with an additional structured Codex review for large diffs.

The actual control semantics are more nuanced:

- Claude adversarial uses a fresh-context subagent, but the source itself explicitly says it is the **same model family**, not an outside model.
- Codex may be disabled by user configuration, unavailable, unauthenticated, broken, unusable, or suppressed when already running under Codex.
- Codex adversarial errors/timeouts are non-blocking and are meant to be surfaced as missing coverage rather than a clean result.
- the large-diff structured Codex review can produce a P1 gate, but the user can choose to continue.
- cross-model synthesis combines overlapping and unique findings.

**R04 boundary:** model diversity can increase challenge freshness but does not automatically establish independent verification. Claude/Codex still share the same candidate diff and gstack orchestration; their criteria and downstream decision process are first-party controlled.

**INFERENCE:** adversarial review is best described as a **heterogeneous challenge layer with graceful degradation**, not an invariant independent-verification prerequisite.

---

## 12. Ship's controls have intentionally different failure polarities

The subsystem does not use one global “fail closed” philosophy. The failure polarity depends on what the missing evidence means.

| Condition | Observed ship behavior | Control character |
|---|---|---|
| on base branch | abort | hard blocker |
| branch-caused test failure | stop | hard blocker |
| ambiguous test ownership | default toward branch-caused | conservative |
| prior Eng Review missing/stale | continue to fresh ship review | recompute rather than block |
| plan NOT DONE | interrupt; user may defer/drop | overrideable gate |
| plan UNVERIFIABLE | per-item confirmation; negative stops | evidence-seeking, overrideable |
| plan audit machinery fails twice | explicit skip-vs-stop question | no silent fail-open |
| plan absent | skip plan-completion audit | conditional control |
| plan verification unavailable | skip with reason | fail-open coverage gap |
| browser verification FAIL | ask fix vs ship-known-issue | overrideable gate |
| coverage < minimum | ask tests vs explicit override | overrideable risk gate |
| coverage percentage indeterminate | skip numeric gate | fail-open uncertainty |
| Claude adversarial unavailable | continue | quality enhancement |
| Codex unavailable/disabled/error | continue with reduced coverage | graceful degradation |
| review auto-fixes change code | rerun tests + review | verdict refresh |
| repeated review fixes after 3 cycles | stop | non-convergence blocker |

**INFERENCE:** gstack distinguishes between **known candidate-caused invalidity**, **missing-but-recoverable evidence**, **optional challenge diversity**, and **user-accepted residual risk** rather than applying one undifferentiated blocking rule.

---

## 13. Release artifacts aggregate the evidence trail

Ship's PR-body workflow regenerates a fresh public release summary from the current run rather than reusing stale PR content. The body can include:

- Test Coverage;
- Pre-Landing Review;
- Design Review;
- Eval Results;
- Greptile Review;
- Scope Drift;
- Plan Completion;
- Linked Spec;
- verification/documentation material.

`/document-release` is dispatched in a fresh spawned subagent before PR creation. Its machine-readable result is consumed by the parent, and failures are handled without falsely reporting documentation as current.

Ship also persists a local review/log row containing release evidence such as coverage percentage, plan-item counts and verification result.

**INFERENCE:** the release/PR object functions as an **evidence aggregation artifact**, not just a prose description of commits.

---

## 14. Relationship to the planning/specification subsystem

The first synthesis found that planning produces increasingly qualified states and durable artifacts. The delivery subsystem shows what makes some of those states operationally consequential later:

```text
qualified upstream decision
          │
          ▼
durable artifact / review entry
          │
          ▼
downstream discovery
          │
          ▼
consumer-specific validity check
          │
          ▼
context, gate, recomputation, or skip
```

The critical mechanism is therefore **not “documents persist.”** It is:

> **a persisted artifact can carry a prior decision or requirement forward only when a later consumer can identify the artifact, establish its relevance/freshness, and map its contents into the consumer's own control semantics.**

This also explains why the same artifact can be informational in `/review` but blocking/overrideable in `/ship`.

---

## 15. Strongest subsystem-level findings

### D1 — Delivery qualification is multi-oracle

**INFERENCE, strong:** gstack combines source/diff review, conventional tests, semantic path-coverage reasoning, plan/deliverable reconciliation, browser-observed behavior and adversarial challenge. These evidence channels are heterogeneous, though not necessarily independent.

### D2 — Required qualification is decoupled from prior ceremony

**INFERENCE, strong:** a current Eng Review is required by default, but it need not have been produced earlier; `/ship` can recreate it from current diff state. This privileges fresh evidence over process attendance.

### D3 — Durable intent can become active release control

**INFERENCE, strong:** discoverable plan items are not passive documentation at ship time. NOT DONE / UNVERIFIABLE states can interrupt release and require explicit resolution or override.

### D4 — Absence and negative evidence are treated differently

**INFERENCE, strong:** known branch-caused failures block; absent optional challenge passes degrade coverage; absence of a plan removes the plan-specific gate; unreadable/failed critical audit machinery surfaces an explicit decision instead of silently certifying success.

### D5 — Verdicts are refreshed after the reviewed object changes

**INFERENCE, strong:** ship reruns verification steps on each invocation, merges base before tests, and reruns tests/review after review fixes. Historical clean status does not automatically remain authoritative after content changes.

### D6 — User sovereignty remains inside the release-control plane

**INFERENCE, strong:** several low-confidence, residual-risk, scope-drop and coverage decisions are explicit user overrides. The system does not equate “gate exists” with “model has final authority.”

### D7 — Verification depth is uneven across mechanisms

**INFERENCE, strong:** deterministic invariants strongly pin some workflow contracts; selected real-agent/browser E2Es substantiate some behaviors; other complex multi-agent/cross-model topologies have only partial or first-party scenario coverage. “Many tests” must not be converted into one undifferentiated confidence score.

---

## 16. Open questions before cross-system promotion

1. How deterministic is the actual `gstack-review-log/read` runtime and working-tree fingerprint implementation under concurrent worktrees and rebases?
2. What is the false-positive/false-negative behavior of the AI-assessed changed-path coverage percentage versus instrumented coverage on real projects?
3. How robustly do Agent-tool foreground/fresh-context requirements survive different host implementations? The upstream TODO corpus itself contains interest in structurally enforcing some background-dispatch rules.
4. How much practical independence do the Claude specialist/red-team/Codex passes produce after accounting for common diff, criteria, prompt construction and orchestration?
5. Does the persistent browser runtime provide stronger deterministic evidence primitives than the QA instruction contract alone suggests?
6. What security/permission controls protect browser state, credentials, external actions and PR/deploy sinks?
7. How does `/land-and-deploy` and `/canary` extend delivery qualification into production observation and rollback/feedback?
8. How are ship/review/QA results consumed by `/retro`, learnings and GBrain, and how does that feedback avoid stale or overgeneralized lessons?

Until these are answered, this file is a bounded model of **implementation-to-release qualification**, not a complete model of gstack's production lifecycle.

---

## Source anchors

Pinned upstream sources used for this synthesis include:

- `review/SKILL.md.tmpl` — blob `a1d6a172746bdc4905731fe4e96ffb6976a579e9`
- `review/sections/manifest.json` — blob `26a94ca3a7ed431514d857d9b6bd758afa859e88`
- `review/sections/plan-completion.md.tmpl` — blob `7a7ae47e4ae31f1e28991bf7b233fc665f2ad4a8`
- `review/sections/plan-completion.md` — blob `38da1ae08b0d966004d522b74af3f48ffceadcf3`
- `ship/SKILL.md.tmpl` — pinned source read; re-check exact blob before byte-level reuse
- `ship/sections/manifest.json` — blob `e4394e5623f9421972c9be642f7d202760af866d`
- `ship/sections/tests.md` — pinned generated section read substantially
- `ship/sections/test-coverage.md` — pinned generated section read substantially
- `ship/sections/plan-completion.md` — blob `2c36cefe477d68768a5623090c9a90835427ae5f`
- `ship/sections/review-army.md` — blob `bb1c3b82910ebaccf1beecfa10bf0771cc777601`
- `ship/sections/adversarial.md` — blob `254331b9f615a09dc6e96deb952d622fe54bcd32`
- `ship/sections/pr-body.md` — pinned generated section read substantially
- `qa-only/SKILL.md.tmpl` — blob `75c4123cc5c406ffdd36c71a094335c137135b1e`
- `qa/SKILL.md.tmpl` — blob `d15a0c5d151ec6a8b15cd3a31dc96430ddb91909`
- `scripts/resolvers/utility.ts` — blob `911b01d8f7e5264a759cfa878c440e7f642eb7cb`
- `scripts/resolvers/review.ts` — blob `04f2dee0091e768ad1a11feda9f3a824256bfb45`
- `test/ship-plan-completion-invariants.test.ts` — blob `26c565b1b093262697832d3b161c479bbb5ce07b`
- `test/skill-e2e-ship-idempotency.test.ts` — blob `29ef83827d66b150d4114a3e7efa8124975a4dfc`
- `test/skill-e2e-review.test.ts` — blob `75b9accd3939e35877c4245bc3a33d9e2977eff0`
- `test/skill-e2e-review-army.test.ts` — pinned source substantially read; exact blob re-check before byte-level reuse
- `test/skill-e2e-qa-workflow.test.ts` — pinned source substantially read; exact blob re-check before byte-level reuse
- `test/skill-coverage-matrix.ts` — blob `7359afbce8144625e3b832d0fa9044fb753185a8`

## Next research dependency

The strongest next cluster is the **browser/runtime + security/permission boundary**. QA and ship depend heavily on `$B` browser evidence and persistent state, but this synthesis has only modeled that capability from its consumer contracts. The next pass should descend into the actual daemon/CLI/CDP implementation, authentication/state persistence, tunnel/listener isolation, action safety and runtime tests before promoting browser-derived evidence into the broader gstack model.
