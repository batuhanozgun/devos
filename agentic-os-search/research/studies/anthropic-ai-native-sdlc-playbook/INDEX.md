# Anthropic AI-Native SDLC Playbook — INDEX

## Role

Retrieval router for this candidate external-target study.

This package preserves deep research into Anthropic's 2026 **The AI-Native SDLC playbook** and its official detail surface. It is reusable candidate research, **not** Foundation authority, architecture decision or implementation commitment.

For classification/reuse first read `META.md`. For package completion/current scope read `STATE.md`.

## Fast routes

| Need | Read first | Then if needed |
|---|---|---|
| What is this study and when should it be reused? | `META.md` | `STATE.md` |
| What does the playbook actually propose? | `01-PLAYBOOK-RESEARCH.md` | relevant official source in `02-SOURCE-LINK-LEDGER.md` |
| Why was this target worth preserving? | `00-WHY-THIS-RESEARCH.md` | `03-SOUL-DEVELOPMENT-OS-ASSESSMENT.md` |
| What links did the article itself give for deeper implementation detail? | `02-SOURCE-LINK-LEDGER.md` | current official documentation URL |
| Which claims come from Anthropic's real operating practice rather than only the playbook? | `01-PLAYBOOK-RESEARCH.md` → operational evidence | security/on-call sources in ledger |
| What is similar to SOUL / Development OS? | `03-SOUL-DEVELOPMENT-OS-ASSESSMENT.md` | direct SOUL source pointers there |
| What does Development OS already define more rigorously? | `03-SOUL-DEVELOPMENT-OS-ASSESSMENT.md` | verification/role/decision source pointers |
| What looks new or especially valuable for later SOUL/DevOS? | `03-SOUL-DEVELOPMENT-OS-ASSESSMENT.md` → design pressures | `04-FALSIFIERS-LIMITATIONS-OPEN-QUESTIONS.md` |
| What should **not** be imported from the playbook uncritically? | `04-FALSIFIERS-LIMITATIONS-OPEN-QUESTIONS.md` | Work/Actors/Information/Foundation sources as needed |
| Is a current Claude capability/settings/security claim still true? | `02-SOURCE-LINK-LEDGER.md` | re-open the authoritative current external URL; do not rely on this package alone |

## Package map

### `META.md`

Package-local canonical classification/reuse surface:

- external-target classification;
- Foundation/SOUL/Development OS relevance hints;
- strongest candidate findings;
- revisit triggers;
- freshness requirements;
- authority boundary.

### `STATE.md`

Bounded work-state surface:

- what was researched;
- what is complete;
- what remains unverified;
- no automatic next work;
- reopen conditions.

### `00-WHY-THIS-RESEARCH.md`

Explains why the source is unusually valuable despite being vendor-authored:

- it describes an end-to-end agent-native software operating model rather than only coding assistance;
- it links abstract workflow claims to concrete runtime/control documentation;
- it exposes real first-party operational failures and control responses;
- it creates useful pressure on SOUL / Development OS without being architecture authority.

### `01-PLAYBOOK-RESEARCH.md`

Detailed study of:

- “code is no longer the bottleneck” thesis;
- artifact-driven loop;
- 12-play dependency graph;
- Plan / Design / Build / Test / Deploy / Maintain;
- `intent.md`, `spec.md`, `plan.md` and audit-chain semantics;
- `CLAUDE.md`, Skills, Hooks and control hierarchy;
- worktrees/subagents;
- feedback loops and continuous evals;
- AI review and CI/CD;
- control-band maintenance loop;
- official runtime enforcement / telemetry surface;
- first-party security and on-call operational evidence.

### `02-SOURCE-LINK-LEDGER.md`

Source inventory containing:

- primary playbook;
- **31 unique article-provided detail destinations** under the package's inventory boundary;
- article Resources/acknowledgments setup chain;
- official Academy companion;
- first-party deep-dives;
- bounded third-party falsifiers;
- source role, freshness and caveat notes.

### `03-SOUL-DEVELOPMENT-OS-ASSESSMENT.md`

Cross-system assessment:

- abstraction-level alignment;
- strong overlaps;
- areas where SOUL / Development OS is currently semantically stronger;
- areas where Anthropic is operationally more concrete/mature;
- new design pressures;
- Foundation-specific relevance without taxonomy promotion.

### `04-FALSIFIERS-LIMITATIONS-OPEN-QUESTIONS.md`

Adversarial layer:

- test/oracle overclaim;
- ex-ante plan vs post-hoc/as-built revision problem;
- fixed six-stage lifecycle risk;
- fresh context ≠ independent verification;
- hidden human orchestration;
- source-of-truth duplication tension;
- repo/deployed-reality gap;
- transitive authority;
- policy/instruction drift;
- challenge-set freshness;
- vendor evidence limitations;
- future questions worth reopening only in an authorised phase.

## Reading discipline

Do not read every linked Claude page every time.

Use progressive retrieval:

`META → relevant package finding → ledger source pointer → current authoritative external source when decision-critical`.

The external ecosystem is fast-moving. A package statement such as “Claude Code supports X setting” is an observation as of the research date, not a permanent product contract.

## Authority boundary

This package may later serve as:

- evidence/reference;
- falsifier;
- design pressure;
- implementation-learning source;
- benchmark/eval source;
- software-domain operating-model prior art.

It does **not** by itself justify:

- changing the Foundation tree;
- adopting Anthropic's six-stage SDLC as SOUL Work semantics;
- selecting Claude/Claude Code as a dependency;
- changing Development OS governance;
- beginning architecture or implementation work.

Current project authorization must always be recovered independently from the relevant `STATE.md` surfaces.
