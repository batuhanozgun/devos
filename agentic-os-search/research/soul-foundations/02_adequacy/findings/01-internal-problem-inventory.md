# Finding 01 — Unconstrained Internal Problem Inventory

**Status:** current Phase-A derived inventory; produced before mapping to the four foundations  
**Evidence scope:** current SOUL / Development OS first-party sources plus lived OS Architect / KEEL lineage evidence  
**Important:** these are problem families, not proposed ontology classes or architecture modules.

## Method

The inventory deliberately avoided beginning with Records / Work / Actors / Technical Work Environment.

For each first-party or lived-history source, the question was:

> What problem pressure required the system to know, decide, preserve, perform, constrain, verify, observe, recover or adapt something?

Existing solution forms such as roles, repositories, ADRs, hooks, files, workflows and verifiers were treated as attempted mechanisms. The underlying problem pressure was extracted separately.

## P1 — Intended outcome, problem framing and success meaning

A system must distinguish:
- the user's underlying intended outcome from the literal request/question;
- missing facts from preferences, values and owner-only judgement;
- solution momentum from the actual problem that warrants work;
- execution completion from outcome success.

Observed pressure:
- SOUL begins from intended outcome rather than a preset workflow;
- WP-021 exists partly because material findings were too quickly converted into repair-shaped work;
- OS Architect history repeatedly found `question/request = task` and repair-first framing failures.

Failure if omitted:
- the system can execute correctly against the wrong objective or prematurely freeze the kind of work required.

## P2 — Selection, admission, sequencing and commitment of effort

A system must determine:
- what possible work should become actual work;
- what should be rejected, deferred, investigated, designed, built, verified or reframed;
- sequencing/dependency/readiness;
- when a finding creates a repair, research question, design question or no new work.

Observed pressure:
- WP-021 explicitly separates result integration from substantive next-work selection;
- historical repair loops showed that correct local findings can still produce wrong next work.

Failure if omitted:
- repository state can be correct while the system continues doing the wrong next thing.

## P3 — Formation, acquisition and admission of capability

A system may need to determine:
- which capabilities are necessary for the intended outcome;
- whether they already exist;
- whether to integrate, construct, research, test or reject a missing capability;
- when a newly formed capability is safe/verified enough to admit.

Observed pressure:
- SOUL explicitly targets task-specific system formation and governed capability acquisition rather than asking the user to pre-design the agent/tool structure.

Failure if omitted:
- missing capability either becomes silent improvisation or pushes system-design responsibility back to the user.

## P4 — Execution, orchestration, coordination and handoff

A system must handle:
- actual execution and situated adaptation;
- multi-participant coordination;
- handoffs and integration;
- dependencies and concurrency;
- bounded versus continuing work;
- transitions between design, build, verification and result integration when relevant.

Observed pressure:
- SOUL Runtime explicitly includes execution, orchestration, context assembly, tool use, handoff, verification, recovery and completion;
- Development OS exists so fresh sessions can take bounded responsibility and hand off safely.

Failure if omitted:
- local competence does not compose into reliable system-level progress.

## P5 — Authority, decision ownership, obligation and approval

A system must distinguish:
- technical capability from permission and decision authority;
- performer from decider, verifier, integrator, principal and accountable party;
- system-derivable choices from owner value/judgement decisions;
- reversible/local choices from higher-impact decisions;
- who may change acceptance criteria or control rules.

Observed pressure:
- SOUL explicitly requires bounded authority and human-owner boundaries;
- Development OS decision classes and role separation exist to prevent implementation momentum, producer confidence or integration convenience from silently becoming authority.

Failure if omitted:
- the system may perform technically possible actions that it is not entitled to decide or may turn the human into a hidden orchestrator.

## P6 — Durable project truth, continuity and selective context

A system must preserve enough externalised truth that:
- a fresh session can reconstruct current purpose, state, authority, evidence and next responsibility;
- history/currentness/standing are not silently conflated;
- one fact does not drift across duplicated authoritative homes;
- context loaded for one responsibility is bounded without hiding institutional truth.

Observed pressure:
- Development OS was created specifically to escape chat/session/model-memory dependence;
- old OS Architect workspaces collapsed through duplication, size growth, mixed lifetimes and unreadable canonical surfaces;
- `current state` and `historical trace` repeatedly had to be separated.

Failure if omitted:
- good work degrades across time/session boundaries or current truth becomes unrecoverable.

## P7 — Evidence, verification, evaluation, acceptance and epistemic status

A system must distinguish:
- claim from supporting evidence;
- tool success from outcome correctness;
- producer assertion from independent verification;
- verification from adversarial review;
- verified / false / unknown / not-verifiable;
- execution complete from accepted/validated outcome.

Observed pressure:
- SOUL definition and non-negotiables reject self-certification;
- KEEL/OS Architect found green checks that produced zero information until deliberate mutation/falsification;
- Development OS separates research, verification, review and integration responsibilities.

Failure if omitted:
- plausible narrative or mechanically green state becomes false confidence.

## P8 — Constraints, policy, safety, privilege and protected properties

A system must know:
- what actions/capabilities are prohibited or bounded;
- what properties a change must preserve;
- what permissions, budgets, risk gates or safety constraints apply;
- which controls the constrained component itself may not rewrite.

Observed pressure:
- SOUL non-negotiables require bounded authority, protected control state, fail-visible conditions and governed evolution;
- KEEL implemented mechanical guardrails because prompt reminders repeatedly failed to enforce learned constraints.

Failure if omitted:
- the system can satisfy local objectives by violating the conditions that make the result acceptable or safe.

## P9 — Technical means, resource conditions and operational readiness

A system must know:
- which tools/services/resources/interfaces are actually available;
- whether they are usable, permitted, healthy and sufficient;
- which technical dependencies or interfaces make work possible;
- whether a nominally present mechanism is actually wired/executed.

Observed pressure:
- SOUL system formation includes tools and newly created capabilities;
- KEEL evidence repeatedly distinguishes declared mechanism from actual hook/code wiring;
- OS Architect found `damga var, taşıyıcı yok` failures where a declared state had no operating mechanism.

Failure if omitted:
- design assumes capability that the realized technical setting cannot actually provide.

## P10 — Observability, current condition, unknowns and truthful failure states

A system must represent:
- current condition and why it believes that condition;
- blocked, stale, conflicted, partial, unknown and unverified states;
- whether observations are sufficient to infer readiness/health;
- when a measurement is unavailable rather than numerically bad.

Observed pressure:
- SOUL makes observability part of correctness;
- KEEL failures showed sentinel values, stale marks and always-green gates collapsing `unknown` into a misleading measured state.

Failure if omitted:
- control logic acts confidently on absence of measurement or on a proxy unrelated to the protected property.

## P11 — Failure containment, recovery, rollback, compensation and reopen paths

A system must handle:
- partial failure without forcing false completion;
- rollback or safe fallback when change fails;
- repair versus redesign/reframe decisions;
- compensation/retry where effects already occurred;
- reopening earlier assumptions when implementation falsifies them.

Observed pressure:
- SOUL Runtime/Evolution include recovery;
- WP-021's current design challenge explicitly includes rollback, disable, partial rollout and forward-restoration semantics;
- repeated historical failures showed that local patching can preserve the faulty frame.

Failure if omitted:
- failures become dead ends, hidden partial states or repeated repair loops.

## P12 — Learning, adaptation and governed evolution

A system must determine:
- which observed failures are reusable lessons;
- whether a lesson indicates local repair, broader control, changed capability or changed model;
- how validated learning reaches future need-time;
- how the system can evolve without allowing a running task to rewrite its own correctness criteria.

Observed pressure:
- SOUL has an explicit Evolution concern;
- OS Architect identified the recurrent root `a lesson is written in one line and not carried to sibling lines`;
- repeated failures motivate deterministic controls where practical.

Failure if omitted:
- the system repeatedly rediscovers lessons or self-modifies in an uncontrolled manner.

## P13 — External/domain reality, observations and effects

A general-purpose system may need to distinguish:
- the technical support setting used to perform work;
- the external/domain reality the work is about or acts upon;
- observations/representations of that reality;
- intended versus actual externally visible effects.

Internal-lineage signal:
- Work's isolated research explicitly deferred `externally visible effects` and asked whether they belong to Work state, persistent Records, domain state outside both, or a relation among them;
- the earlier broad Environment research accidentally studied a boundary-relative operating-world problem rather than Technical Work Environment, indicating that the distinction is structurally plausible rather than merely terminological.

Current status:
- **candidate missing-region pressure; not established.**
- This requires external/cross-lineage challenge because the current project lineage may under-exercise physical/domain-world interaction.

Failure if omitted:
- the system may confuse its records/beliefs with the reality they describe or confuse the technical means of acting with the domain being acted upon.

## P14 — Human values, preferences, affected parties and owner boundary

A system must determine:
- which questions are factual/derivable and which require human preference/value judgement;
- who is affected or benefits even when they are not performers;
- when explicit consent/approval is required;
- how autonomy remains useful without silently replacing legitimate human authority.

Observed pressure:
- SOUL explicitly reserves value judgements and defined approval boundaries to the human owner;
- Actors research independently exposed affected/beneficiary/rights-holder relations as unresolved cross-boundary questions.

Failure if omitted:
- either the human becomes routine machinery for technical work or the system silently makes decisions that belong to human/social authority.

## Cross-family observation before foundation mapping

Several families are visibly entangled:

- authority affects work selection, access and acceptance;
- durable information supports coordination, verification and continuity;
- technical readiness gates possible work;
- verification depends on evidence, independent decision roles and the target being checked;
- recovery generates new work and changes technical/system state;
- learning changes future controls and capabilities.

This entanglement is **not yet evidence for a separate relation/control plane**. It is only a warning that a successful top-level decomposition must explain cross-family relations rather than pretending each problem is isolated.

## Internal-lineage limitation

SOUL, Development OS, OS Architect and KEEL are related systems and share historical assumptions. Their convergence can establish project relevance but cannot establish general-purpose completeness.

The next phases therefore map this inventory to the four independent foundations and then attack the mapping with rival frames and external holdouts.
