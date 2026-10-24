# gstack Subsystem Synthesis — Planning, Specification, and Work Admission

## Status

- **Study:** `gstack`
- **Target:** `garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`
- **Observed:** 2026-09-05
- **Synthesis status:** bounded subsystem synthesis; not a whole-repository conclusion
- **Foundation/SOUL adoption status:** none; this is external-target evidence only

## Question

How does the pinned gstack revision turn an initially ambiguous request into increasingly decision-ready and execution-ready work, and where does it place human, model, artifact, and runtime boundaries along that path?

## Short answer

**INFERENCE:** gstack does not implement planning as one conversation or one generic planning skill. It implements a **composable work-admission pipeline** made of distinct specialist roles, durable artifacts, explicit authority gates, shared review machinery, and optional delegation modes.

A useful gstack-native reconstruction is:

```text
intent / idea
    │
    ▼
/office-hours
problem framing → premises → alternatives → user-selected direction
    │
    ▼
durable design decision record
    │
    ├─────────────► /plan-ceo-review
    │               product scope / ambition / failure / trajectory pressure-test
    │
    └─────────────► /plan-eng-review
                    review-target authority → architecture/tests/performance hardening
                            │
                            ▼
                   reviewed plan + durable review state
                            │
                            ▼
                         /spec
              why → boundaries → code-grounded interrogation
                 → confirmed executable specification
                            │
                            ▼
               safety / quality / sink gates
                            │
                            ▼
          GitHub issue + local archive + decision record
                            │
                            ▼
          optional isolated worktree / agent execution
```

This is not a single mandatory global state machine. The root router can route directly to a later specialist, prerequisites can be suggested rather than forced, and `/autoplan` changes the delegation regime. The stronger claim is therefore: **gstack provides interoperable staged mechanisms that can form a planning-to-work-admission chain, with artifact discovery and review state making that chain more than conversational convention.**

---

## 1. Discovery is separated from implementation

### Observations

`office-hours/SKILL.md.tmpl` declares a hard boundary: the skill produces design docs, not code, and must not invoke implementation work. It first gathers repository/context evidence, prior designs, and the user's goal, then selects Startup or Builder posture.

The two carved conversation sections are intentionally different:

- Startup mode forces evidence about demand, current workaround, a specific affected human, narrowest viable wedge, observed usage, and future-fit.
- Builder mode optimizes for delight, shareability, exploration, and a fast path to something real.

Both modes retain a premise challenge and mandatory alternatives before a direction is committed. Even a fully formed plan may fast-track questioning, but the parent contract still requires premise checking and alternatives.

### Authority boundary

`office-hours` does not allow a recommended approach to become the design decision merely because the model believes it is clearly best. After producing at least two alternatives, it STOPs and requires explicit user selection before generating the design record.

**INFERENCE:** gstack treats **solution selection as an authority-bearing transition**, not merely another reasoning step.

### Evidence quality

The startup/builder posture has first-party E2E evaluation (`test/skill-e2e-office-hours.test.ts`) that invokes the skill through a real model and uses an LLM judge to score whether forcing specificity and builder-mode “wildness” survive at runtime. This is behavioral evidence, but not independent replication: the judge and generator are part of the same first-party evaluation system and the test targets posture rather than the entire approval/handoff lifecycle.

---

## 2. The design doc is a handoff object, not a transcript

### Observations

The `office-hours` design/handoff section writes an approved design into durable state and creates lineage:

- local cross-session copy under gstack state;
- repository copy under `docs/designs/` when possible;
- `Supersedes:` links for design revision history;
- `DRAFT` → explicit Approve/Revise/Start-over gate → `APPROVED`;
- repo-bound bytes are scanned at the sink before they leave the private store;
- downstream plan reviews are told how to discover prior design artifacts automatically.

The source explicitly frames the artifact as a **decision record, not a transcript**: settled decisions and rejection reasons should be preserved concisely rather than replaying the whole discussion.

### Inference

The artifact performs at least four jobs simultaneously:

1. **representation:** captures the current agreed problem/direction;
2. **continuity:** survives conversation boundaries;
3. **authority evidence:** records which direction was actually approved;
4. **handoff:** gives downstream reviewers a source of truth for problem/constraints/chosen approach.

This is one of the clearest early examples that gstack's workflow cannot be modeled as prompts alone. The filesystem/state layout participates in the workflow protocol.

---

## 3. Product-scope review and engineering review are different decision roles

### Product/scope pressure-test — `/plan-ceo-review`

`plan-ceo-review` distinguishes explicit scope postures such as expansion, selective expansion, hold scope, and reduction. The chosen mode affects the review posture, but scope changes remain user opt-in. The review then runs a broad 11-section examination spanning architecture, error/rescue mapping, threat model, data/interaction edge cases, code quality, testing, performance, observability, deployment, long-term trajectory, and conditional design/UX.

Important outputs are durable or decision-shaped rather than merely narrative:

- NOT in scope;
- What already exists;
- Dream-state delta;
- Error & Rescue Registry;
- Failure Modes Registry;
- TODO proposals;
- diagrams;
- task emission;
- completion summary;
- review log and decision log.

Every finding in the interactive path is individually approval-bearing. Outside-model findings remain informational until the user accepts them.

### Engineering hardening — `/plan-eng-review`

`plan-eng-review` begins with a different authority question: **what exactly is being reviewed?** Outside recognized plan-mode or an explicitly named target, its first tool action must be a user question; it forbids reading the repository before the target is resolved.

After target resolution it checks prior design material, searches existing implementation, challenges excess scope/complexity, and reviews architecture, code quality, tests, and performance. Findings again require explicit user decisions. It emits implementation-oriented artifacts including failure modes, test mapping, tasks, and a module-level worktree parallelization strategy.

### Inference

These are not duplicate “review personalities.” They hold different work responsibilities:

```text
CEO review:       Should this be the scope/direction we carry forward?
Eng review:       Given a resolved target, is the execution design hard enough to build?
```

The separation is important because **scope authority and implementation adequacy are not treated as the same judgment**.

---

## 4. `/spec` is an admission boundary from agreed intent to executable work

### Conversational admission criteria

`spec/SKILL.md.tmpl` refuses to file an issue immediately. It requires:

1. affected actor / stakeholder;
2. verified current behavior;
3. desired behavior;
4. why now;
5. observable completion criterion;
6. explicit scope/out-of-scope and dependencies;
7. failure and rollback thinking;
8. code evidence before technical interrogation.

A central rule is that Phase 3 must inspect the codebase before asking technical questions; questions answerable from source should not be bounced back to the user.

**INFERENCE:** ambiguity is treated as **work not yet admissible**, rather than as uncertainty an implementer should absorb later.

### Confirmed draft → mechanical safety tail

After the user confirms the draft, the carved `gate-and-file` section applies a distinct mechanical/control tail:

- local semantic privacy/confidentiality review;
- fail-closed redaction that cannot be disabled by `--no-gate`;
- optional Codex executability score and ambiguity feedback;
- exact-bytes re-scan before issue filing;
- exact-bytes re-scan before archival;
- local archive by default;
- plan-mode-aware file-only vs execution-mode file+spawn behavior;
- dirty-worktree gate;
- TOCTOU re-check;
- exact SHA pin;
- unique worktree/branch naming;
- final user confirmation before agent spawn.

The filed issue and archive are not dead documents: the issue number is recorded for later `/ship` integration, and the decision log preserves the core approach across sessions.

### Verification evidence

`test/spec-template-invariants.test.ts` statically pins many of these contracts against the actual templates/generated section: phase gating, mandatory questions, code-first evidence, sink ordering, fail-closed redaction, sanitized archive body, dirty-worktree/TOCTOU handling, SHA pin, concurrency suffixes, plan-mode dispatch, and carved-section placement.

`test/skill-coverage-matrix.ts` explicitly distinguishes CI-blocking gate coverage from periodic deeper behavioral tests and lists both deterministic `/spec` invariants and periodic PTY/LLM-judge evaluation.

**Verification limit:** static invariant tests prove the instruction/generation structure contains the required contract; they do not prove that every model execution follows it. Periodic E2E improves behavioral evidence but is still first-party and has bounded scenario/oracle coverage.

---

## 5. `/autoplan` changes the delegation regime rather than deleting governance

Interactive reviews ask the user at many issue-level decision points. `/autoplan` deliberately replaces most of those intermediate decisions with six explicit decision principles while preserving full-depth analysis and artifact production.

It distinguishes:

- **Mechanical** — auto-decide;
- **Taste** — auto-decide, record, surface at final gate;
- **User Challenge** — both models want to change the user's stated direction; never auto-decide, user direction remains default until final approval.

It enforces a sequential phase order:

```text
CEO → Design (conditional) → DX (conditional) → Eng (always last)
```

and maintains a decision audit trail plus one final approval gate.

The generator has to explicitly suppress imported child-skill scope gates in this parent context, and `test/skill-validation.test.ts` pins that skip-list requirement. This is evidence that the authors recognize **composed workflows can create contradictory authority gates unless the parent/child contract is explicit**.

`test/skill-e2e-autoplan-dual-voice.test.ts` checks that a Claude subagent and Codex voice are actually dispatched, or that Codex failure degrades explicitly. The test itself says it is periodic/non-gating and does not require full Phase-1 completion, which limits what it can establish.

### Inference

Interactive and autoplan paths reveal an important gstack mechanism:

> **Decision authority is a configurable part of the workflow topology.**

The system can move from per-issue human authorization to bounded delegated judgment without pretending the user has vanished from the control model.

---

## 6. Generated skills are composed behavioral programs

### Observations

The canonical skill authoring path is not simply hand-written `SKILL.md` files.

`scripts/gen-skill-docs.ts` describes the pipeline as:

```text
.tmpl → placeholder discovery → resolver expansion → formatting → generated .md
```

Generation supports dry-run freshness checks, host/model overlays, output isolation, and host-specific behavior.

`scripts/resolvers/index.ts` centralizes reusable behavioral fragments including preamble, review machinery, Codex challenge, learnings, GBrain, task emission, redaction, skill composition, section loading, and design-doc discovery.

`scripts/resolvers/sections.ts` implements a host-aware carve:

- Claude receives a smaller decision-tree skeleton whose section placeholder becomes a STOP+Read pointer to an on-demand source;
- non-Claude hosts receive the section body inlined into the generated monolith;
- the section manifest is passive metadata; the skeleton decides when a section applies.

`scripts/resolvers/composition.ts` implements parent→child skill composition by instructing the agent to load the child skill and explicitly skip parent-owned sections.

### Inference

For this subsystem, the meaningful behavioral unit is therefore:

```text
template skeleton
+ shared resolver policy
+ on-demand section body
+ host-specific rendering
+ child-skill composition rules
+ tests/evals
```

A generated skill file is an important runtime artifact, but not the only source required to explain why the behavior has its shape.

---

## 7. Router semantics make the pipeline composable, not universally mandatory

The top-level `SKILL.md.tmpl` is a router. It maps user intent directly to specialized skills and allows a persistent `proactive` preference that can disable automatic skill invocation/suggestion.

This matters for the subsystem model. The existence of a natural chain does **not** mean every work item must traverse every stage. A user can ask directly for a spec, an engineering review, or shipping. Some downstream skills advertise `benefits-from` prior stages and can discover their artifacts, but the router itself is intent-based rather than a single central state-machine executor.

**INFERENCE:** gstack favors **loosely coupled staged protocols with shared durable state** over one monolithic workflow engine.

This creates flexibility, but it also creates a future research question: which later gates (especially `/ship`) detect that necessary upstream evidence is absent or stale, versus merely recommending earlier skills?

---

## 8. Authority and artifact map

| Transition | Primary role/mechanism | Authority pattern | Durable evidence/output |
|---|---|---|---|
| idea → framed problem | `/office-hours` | user goal/mode input; skill may challenge | session/design context |
| premises → solution candidates | `/office-hours` | premises and final approach require user agreement | design record inputs |
| chosen direction → approved design | design/handoff section | Approve / Revise / Start over | approved design doc + lineage |
| design/plan → scope posture | `/plan-ceo-review` | explicit mode; scope mutations opt-in | CEO plan, decisions, review logs |
| plan → review target | `/plan-eng-review` | target must be user/host-resolved before inspection | target-bound review context |
| finding → plan mutation | interactive plan reviews | one finding → one user decision | plan/report/log/task records |
| many review questions → delegated run | `/autoplan` | principles auto-decide bounded classes; final user gate | decision audit trail + phase logs |
| intent → backlog-ready work | `/spec` | draft confirmation before filing tail | spec body |
| safe spec → external issue/archive | `/spec` mechanical tail | redaction may block; score may request revision | issue + sanitized archive + decision log |
| filed work → spawned agent | `/spec --execute`/default execution mode | dirty-tree choice + final spawn confirmation | SHA-pinned worktree/branch metadata |

---

## 9. Promotion / relationship behavior must be separated from work-quality evidence

`office-hours` also contains a relationship/growth subsystem: founder-signal tracking, tiered return-user behavior, YC application messaging, founder-resource recommendations, resource telemetry, and persisted opt-out configuration.

**OBSERVATION:** this behavior is genuinely part of the pinned system and uses durable profile/config state.

**R02 boundary:** it is not evidence that the planning mechanisms are technically or epistemically better. The study must not let author affiliation, YC promotion, founder flattery, retention logic, or user-acquisition incentives raise confidence in the planning model. Conversely, the existence of promotion does not by itself invalidate the work mechanisms. The two should be evaluated separately.

---

## 10. What is structurally pinned vs behaviorally tested

| Claim class | Current evidence | Current strength |
|---|---|---|
| Skills declare hard STOP/approval boundaries | pinned templates + carved sections | strong for intended contract |
| Generated skills are template/resolver/section compositions | generator + resolver implementation | strong for implementation structure |
| `/spec` retains redaction/admission/race-safety markers in the correct source locations | deterministic invariant tests | strong structural enforcement |
| Eng-review STOP can occur before model writes findings in a seeded complex-plan scenario | periodic real-PTY E2E | meaningful behavioral evidence, scenario-bound |
| Office-hours startup/builder posture survives generation | LLM-judged E2E | behavioral but judge-dependent |
| Autoplan dispatches dual voices or degrades explicitly | periodic E2E | behavioral but partial-pipeline and first-party |
| Whole planning chain always preserves every intended authority boundary in real use | not established | open |
| Cross-model review is independent verification | not established; shared artifact/framing and first-party orchestration remain | must not claim |

---

## 11. Strongest subsystem-level findings

### P1 — Planning is a sequence of qualification transitions

**INFERENCE, strong:** gstack repeatedly turns “continue” into a qualified state transition: problem sufficiently framed, premise agreed, approach chosen, scope accepted, target resolved, review finding decided, spec confirmed, sink safe, spawn authorized.

### P2 — Durable artifacts are part of the control flow

**INFERENCE, strong:** design docs, CEO plans, review reports/logs, task artifacts, decision logs, issues, archives, and worktree metadata are not merely documentation. They support discovery, staleness judgments, downstream handoff, or later automation.

### P3 — Human authority is granular, but delegation can be explicit

**INFERENCE, strong:** interactive skills use fine-grained user gates; `/autoplan` is not “remove the human” but “delegate specified decision classes to a declared policy, then rejoin at a final approval boundary.”

### P4 — Completeness is a design value with scope tension explicitly managed

**INFERENCE, moderate-strong:** gstack simultaneously pushes completeness/edge-case coverage (“boil lakes/ocean”) and scope discipline (minimal viable alternative, scope modes, complexity smells, explicit out-of-scope). The tension is not resolved by one universal rule; it is mediated by stage and mode.

### P5 — The system attempts to preserve workflow semantics across heterogeneous hosts

**INFERENCE, moderate:** carved section behavior, host-aware generation, and parent/child composition indicate that “the same skill” is an abstract behavioral contract rendered differently per host. A broader host-portability study is still required before judging fidelity.

---

## 12. Open questions before cross-system promotion

1. Does `/ship` actually gate on fresh/clean engineering review and plan completion in a way that closes this planning→execution loop, or are some checks advisory?
2. How are decision/task/review logs read by later skills, and what are their freshness/identity semantics under rebases, worktrees, and plan changes?
3. How much of interactive AskUserQuestion behavior is model-enforced versus deterministically constrained by wrappers/tools?
4. What is the actual oracle quality of the paid E2E/LLM-judge tests and what important negative cases are absent?
5. How faithful are external-host renders to Claude's carved/on-demand behavior?
6. How do GBrain/learnings alter later planning without causing stale or authority-inappropriate context carryover?
7. Where are privacy/security boundaries deterministic runtime controls versus instruction-level compliance?

Until those are answered, this subsystem is suitable as a **bounded model of planning/specification/work admission**, not as a complete model of gstack's software factory.

---

## Source anchors

Pinned upstream sources used for this synthesis:

- `SKILL.md.tmpl` — blob `402bd0d7b0f2bf02f6c9e4754e0e2a655f5f4057`
- `office-hours/SKILL.md.tmpl` — blob `ecd96fb4186115182a653f67e59c1dc7496ed326`
- `office-hours/sections/manifest.json` — blob `fa6df52648ceca8ea427056d73000c8a7d6cd870`
- `office-hours/sections/phase-2a-startup-diagnostic.md.tmpl` — blob `0e3a12274d5cbd2845130e529aec6f9118b7d479`
- `office-hours/sections/phase-2b-builder-brainstorm.md.tmpl` — blob `e49d6cd80b61b8b12cfc6e3d372b8b8c0857134b`
- `office-hours/sections/design-and-handoff.md.tmpl` — blob `5924dd706a141a77d96ea05aec998e6ddbaae5b9`
- `plan-ceo-review/SKILL.md.tmpl` — blob `1b1affe160d2919ee08e00f101784a97d210906a`
- `plan-ceo-review/sections/manifest.json` — blob `5ef4425a943600708ff1d0fdb9352f2a97c07de9`
- `plan-ceo-review/sections/review-sections.md.tmpl` — pinned source read during this pass; re-check blob before load-bearing reuse
- `plan-eng-review/SKILL.md.tmpl` — blob `e066e2c5f5028ad3b8485fe8606967ac1188b47e`
- `plan-eng-review/sections/manifest.json` — blob `f76e8f95bf4b313cecc2797278440cfc8f0a90a5`
- `plan-eng-review/sections/review-sections.md.tmpl` — pinned source read during this pass; re-check blob before load-bearing reuse
- `autoplan/SKILL.md.tmpl` — blob `6a034e15e7647980d74dfa71bfe17c25875ed054`
- `spec/SKILL.md.tmpl` — pinned source read during this pass; re-check blob before load-bearing reuse
- `spec/sections/gate-and-file.md.tmpl` — blob `f8923a834e9228d42b4e535ed8b97cb52e0e5a6d`
- `scripts/gen-skill-docs.ts` — pinned source read during this pass
- `scripts/resolvers/index.ts` — blob `cee08c2015a6ac2ff8605b02ac07a49d284d3ce1`
- `scripts/resolvers/sections.ts` — blob `c6425e19b93d20018057cf2fe6ae9eeb2f613a18`
- `scripts/resolvers/composition.ts` — blob `b8d3483d9bd961409025959eddcd8840dd5f98a8`
- `scripts/resolvers/review.ts` — pinned source partially inspected during this pass
- `test/spec-template-invariants.test.ts` — blob `40d2d22677cbd0a506c6395bc0e2b00b3a2149d2`
- `test/skill-coverage-matrix.ts` — blob `7359afbce8144625e3b832d0fa9044fb753185a8`
- `test/skill-e2e-plan-eng-plan-mode.test.ts` — blob `85eec6cc401bf79275aae0e34e11373a72e7c71b`
- `test/skill-e2e-autoplan-dual-voice.test.ts` — blob `1efc6dfc68643fa2772770ea9b87187986612e99`
- `test/skill-e2e-office-hours.test.ts` — blob `c3ad6c57b80ce6a78510f1e0d226b39900e9df49`

## Next research dependency

The highest-value continuation is to inspect the **review / QA / ship admission chain** and the review-log/dashboard consumers. That will test whether the planning subsystem's qualified states actually constrain downstream shipping or merely provide context and recommendations.
