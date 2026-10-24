# gstack — Investigation, Root-Cause Discipline, and Debug Control

## Status and boundary

**Status:** BOUNDED SUBSYSTEM SYNTHESIS  
**External target:** `garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`  
**Observed:** 2026-09-05  
**Package:** 1.79.0

This synthesis reconstructs `/investigate` as gstack's debugging / causal-control workflow.

It covers:

- symptom collection and reproduction;
- hypothesis formation and falsification;
- recent-change / prior-learning evidence;
- the “no fix before cause” contract;
- 3-strike escalation;
- scope-lock / freeze coupling;
- regression testing and fresh verification;
- investigation reporting and durable learning handoff;
- host-specific enforcement differences;
- the actual test evidence behind those claims;
- the distinction between a confirmed proximate hypothesis and deeper systemic root-cause analysis.

It does **not** yet synthesize the whole learnings/GBrain subsystem, the whole guarded-action family, or independent debugging effectiveness. Memory mechanisms are read only as far as necessary to understand investigation handoff.

---

## 1. Executive reconstruction

`/investigate` is not primarily a bug-fixing prompt. Its intended control sequence is:

```text
observed failure / symptom
        ↓
collect evidence + trace code/change history
        ↓
reproduce
        ↓
form explicit testable hypothesis
        ↓
lock mutation scope where supported
        ↓
pattern / prior-learning analysis
        ↓
try to falsify or confirm hypothesis
        │
        ├─ false → return to evidence gathering
        │          └─ after 3 failed hypotheses → STOP / escalate
        │
        └─ confirmed
              ↓
        minimal root-cause fix
              ↓
        regression test
              ↓
        full test suite
              ↓
        fresh reproduction of original failure
              ↓
        structured report + durable learning
```

The strongest design principle is **epistemic admission before mutation**:

> implementation is supposed to begin only after a specific, testable causal claim has been supported by reproduction/evidence.

However, the evidence level behind this workflow is uneven. The causal methodology is mainly a skill-level behavioral contract. The edit-scope `freeze` submechanism has real shell-level enforcement and focused tests. The investigate-specific 3-strike / no-fix-before-cause / regression / fresh-verification sequence does not have a registered behavioral E2E in the skill coverage matrix at the pinned revision.

---

## 2. The “Iron Law” is a workflow policy, not a runtime proof

`investigate/SKILL.md.tmpl` declares:

> **NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST.**

The workflow then orders root-cause investigation and hypothesis testing before implementation.

This is meaningful policy evidence because the same skill also specifies:

- trace the code path;
- inspect recent changes;
- reproduce before guessing;
- state a concrete “Root cause hypothesis”;
- instrument/assert/log to test it;
- return to evidence gathering when falsified;
- only implement once confirmed.

But the key distinction is:

```text
skill says “do not edit before confirmed cause”
≠
runtime necessarily prevents every premature edit
```

The frontmatter hook does not know whether a root-cause hypothesis has been confirmed. It checks only the freeze path boundary. So the causal ordering remains model/workflow compliance rather than a mechanically enforced state machine.

The strongest accurate formulation is:

> gstack encodes a strong **causal-before-mutation behavioral contract**, but it does not mechanically gate Edit/Write on a machine-readable “root cause confirmed” state.

---

## 3. Evidence gathering precedes hypothesis formation

The skill deliberately asks the agent to gather context **before forming any hypothesis**:

1. collect symptoms / errors / reproduction steps;
2. read and trace the code path;
3. inspect recent commits touching affected files;
4. reproduce if possible;
5. check prior investigation/learnings for recurring patterns.

This sequence tries to counter a common debugging failure mode:

```text
first plausible explanation
→ immediate patch
→ new symptom
→ another patch
→ causal drift / thrash
```

### Regression framing

For regressions, the skill says the relevant cause should be sought in the changed behavior/diff. This is a useful search-space reduction, but should not be interpreted universally: a newly surfaced bug can also expose an older latent defect under a new environment or input. The workflow gives recent-change evidence strong priority; it does not prove the changed line is always the deepest cause.

### Reproduction status matters

The skill explicitly says that if the bug cannot be reproduced, the agent should gather more evidence instead of proceeding as if a diagnosis were established.

That supports a causal-confidence distinction:

```text
symptom report
<
plausible hypothesis
<
reproduced mechanism
<
fix + regression + fresh reproduction
```

---

## 4. Hypotheses are explicit and falsifiable by design

The required intermediate artifact is a sentence of the form:

```text
Root cause hypothesis: <specific claim about what is wrong and why>
```

The next phase requires an intervention/observation intended to test that claim: temporary logs, assertions, or debug output followed by reproduction.

If the evidence disagrees, the workflow explicitly rejects guessing and returns to investigation.

This is stronger than “think deeply before coding” because it creates a named falsifiable object.

But it still leaves causal-depth quality to the agent. A hypothesis can be testable yet shallow:

```text
“this null is passed here”
```

may explain the immediate crash without explaining:

```text
why the invalid state was allowed to exist,
why validation failed to catch it,
or why the same class can recur elsewhere.
```

That distinction becomes important in Section 11.

---

## 5. Three failed hypotheses trigger an authority/escalation transition

The skill's 3-strike rule says that after three hypotheses fail, the agent must stop and involve the user rather than continuing indefinitely.

The user gets choices roughly equivalent to:

- continue with a newly stated hypothesis;
- escalate to a human who knows the system;
- add instrumentation and wait for future evidence.

This is not merely a debugging heuristic. It changes **who is allowed to decide the next investigation investment**.

```text
agent-led investigation
        ↓ 3 failed hypotheses
automatic continuation authority ends
        ↓
user/human chooses whether to continue, escalate, or instrument-and-wait
```

That makes uncertainty accumulation a control input rather than an invisible cost.

### Internal wording inconsistency

The same skill later says “3+ failed fix attempts → STOP,” while the hypothesis phase says three failed **hypotheses**. Because the workflow also says no fix before root cause confirmation, these are not semantically identical counters.

There is no machine-readable strike counter, so this wording mismatch is currently behavioral ambiguity rather than an implementation-state conflict. The safer reading is that repeated unsuccessful debugging attempts should trigger escalation instead of thrash.

---

## 6. Scope lock is the most mechanically enforced part of `/investigate`

After a root-cause hypothesis is formed, the Claude-oriented investigate workflow probes for the freeze hook and, when available, writes the narrowest affected directory to:

```text
$GSTACK_STATE_ROOT/freeze-dir.txt
```

`Edit` and `Write` PreToolUse hooks run `freeze/bin/check-freeze.sh`.

The hook:

- reads the target `file_path` from tool input;
- resolves the boundary and target path;
- resolves final-component symlinks;
- allows targets inside the boundary;
- returns `permissionDecision: deny` outside it;
- denies on unparseable non-empty payloads;
- denies if critical helper code is missing while a freeze is active.

This is actual execution-time control for those tool calls, not merely prose.

Focused tests exercise:

- in-boundary allow;
- out-of-boundary deny;
- malformed JSON fail-closed;
- quote/newline-safe deny JSON;
- space-bearing paths;
- broken-install fail-closed;
- symlink escape denial.

A separate investigate regression test also pins the `$HOME`-anchored hook path after an earlier path form silently failed to resolve.

### Important boundary

`freeze/SKILL.md.tmpl` explicitly states that this is **not a full security boundary**.

It covers `Edit` and `Write`, but not arbitrary mutation through `Bash` such as `sed`, redirection, scripts, package tools, etc.

Therefore:

```text
investigate scope lock
=
real Edit/Write tool guardrail where host hooks exist

investigate scope lock
≠
filesystem sandbox
≠
complete mutation confinement
```

---

## 7. Freeze enforcement is host-specific

This is a material portability correction.

### Claude Code

`hosts/claude.ts` keeps `hooks` in generated skill frontmatter. Therefore the investigate Edit/Write PreToolUse freeze hook survives generation on the primary Claude host.

### Codex and common external hosts

The common external-host frontmatter defaults keep only `name` and `description`; `hosts/codex.ts` also uses an explicit `name`/`description` allowlist.

That means Claude-specific frontmatter hooks are stripped from those generated variants.

### OpenClaw

The checked-in OpenClaw investigate adaptation preserves the causal phases but omits the Scope Lock/freeze section entirely.

Therefore the accurate system-level claim is:

> `/investigate`'s causal methodology is portable across host adaptations, but the **runtime Edit/Write freeze enforcement is not a universal gstack-host capability** at the pinned revision.

This is an example where generated behavioral semantics and host runtime affordances diverge intentionally.

---

## 8. Freeze lifecycle is explicit but not automatically closed by investigate

The investigate workflow writes the freeze boundary and tells the user to run `/unfreeze` to remove it.

`/unfreeze` deletes the freeze state file.

The investigate skill itself does not contain an automatic unfreeze step at successful completion.

Because `GSTACK_STATE_ROOT` can resolve to durable gstack state (for example `$HOME/.gstack` outside plugin-specific state), the safe model is:

> the freeze boundary persists until explicitly cleared or until the host/session environment makes that state unreachable; investigate itself does not guarantee automatic cleanup.

This may be intentional conservatism, but it is a lifecycle property consumers must know. “For this debug session” is therefore a behavioral description, not by itself a proof that persistence cannot outlive the conversational turn/session on every installation mode.

---

## 9. Implementation is admitted only after the causal claim is “confirmed”

Once the hypothesis is treated as confirmed, the intended implementation phase adds three controls:

### Minimal causal intervention

The skill asks for the smallest change that eliminates the actual problem and explicitly discourages adjacent refactoring.

### Regression test

A regression test should:

```text
fail without the fix
pass with the fix
```

This is stronger than simply adding coverage after the fact: the test is supposed to demonstrate sensitivity to the causal change.

### Blast-radius escalation

If the fix touches more than five files, user confirmation is required because such breadth may indicate a larger architectural issue or an over-broad intervention.

Again, these are behavioral workflow gates; no investigate-specific runtime controller mechanically counts touched files before allowing edits.

---

## 10. Verification is deliberately fresh and tied to the original symptom

The completion contract requires both:

- rerunning the test suite;
- reproducing the **original bug scenario** and confirming it is gone.

This is an important oracle choice.

A regression/unit test can validate the mechanism as encoded in the test, while the original reproduction validates that the observed failure actually changed.

The intended completion evidence is therefore:

```text
mechanism test
+
original-symptom reproduction
+
full-suite regression check
```

The structured debug report records symptom, root cause, fix, evidence, regression test, related history/architecture notes and a status:

- DONE;
- DONE_WITH_CONCERNS;
- BLOCKED.

The existence of `DONE_WITH_CONCERNS` is useful epistemically: the workflow has a state for “fixed but not fully verifiable” rather than forcing a false binary done/not-done claim.

---

## 11. “Root cause” in `/investigate` is not guaranteed to mean systemic root cause

This is the most important causal-depth qualification.

The skill contains genuine causal discipline:

- trace data flow;
- reproduce;
- state testable hypothesis;
- falsify hypotheses;
- inspect history;
- treat recurring bugs as architectural smell;
- stop after repeated failure;
- require regression tests and fresh reproduction.

But it does **not** impose a mandatory double-cause analysis such as:

```text
A. Why did the defect/failure occur?
B. Why did the system allow it, fail to prevent it, or fail to detect it earlier?
```

Nor does it require every investigation to identify prevention/detection/organizational contributors before calling the causal hypothesis “root cause.”

Consequently, a first confirmed mechanism may be labeled root cause even when it is only the deepest cause needed to produce a local fix.

### Where the workflow does push deeper

Several signals can force deeper reasoning:

- recurring failures in the same area are called an architectural smell;
- each fix revealing another problem is treated as “wrong layer”;
- three failed hypotheses can trigger architectural escalation;
- >5-file fixes trigger blast-radius review;
- regression testing asks whether the selected intervention controls recurrence of the observed case.

These are meaningful systemic-pressure mechanisms.

### Where it can still stop shallow

If one hypothesis explains the immediate mechanism, yields a small fix, passes the regression test, and makes the original symptom disappear, the workflow can legitimately terminate without separately analyzing why the defect was not prevented/detected or whether the same class exists elsewhere.

Therefore:

> `/investigate` is a strong **hypothesis-driven debugging discipline**, but not a formal guarantee of organization/system-level root-cause analysis.

This distinction should be preserved in any later SOUL/Development OS comparison.

---

## 12. Prior investigations are operational evidence, not authoritative truth

The investigate workflow loads prior investigation/learnings context to find repeated patterns.

The underlying local learning store is append-only JSONL with fields including:

- timestamp;
- skill/type/key;
- insight;
- confidence;
- source;
- branch/commit;
- files.

The search path adds several epistemic controls:

- latest winner per key+type;
- effective-confidence decay for observed/inferred rows over time;
- query matching against key/insight/files;
- optional cross-project search;
- cross-project trust gate requiring `trusted === true` (user-stated) before another project's learning can influence the current one.

The logging path validates type/key/confidence/source and rejects instruction-like payloads before persistence.

This means prior investigations are treated as **candidate evidence with provenance/confidence/trust context**, not as immutable fact.

### Limit

The main `/investigate` template still tells the agent to use these learnings as context. Whether the agent correctly discounts stale/incorrect same-project learning remains a behavioral reasoning question; the storage/search controls do not independently validate the content.

---

## 13. Investigation results feed future work through two optional memory channels

At completion, investigation can persist knowledge through:

1. local project learnings (`gstack-learnings-log`, type `investigation`, affected files);
2. GBrain result saving when GBrain is present on a supporting host.

The GBrain resolver is optional and host-dependent; it explicitly says to continue without brain context if unavailable.

Therefore memory write-back is a compounding mechanism, not a required proof-of-completion gate.

The useful control topology is:

```text
current investigation
        ↓
verified causal lesson
        ↓
persist with source/confidence/files
        ↓
future investigation search
        ↓
prior pattern can alter new hypothesis/search order
```

This is a feedback path from past work into future causal reasoning.

---

## 14. Test/eval evidence is notably asymmetric

### Investigate-specific coverage matrix

At the pinned revision:

```text
investigate:
  gate: [skill-coverage-floor]
  periodic: []
```

The floor test is structural. It verifies generated skill existence/frontmatter/body/template resolution, not actual adherence to the debugging protocol.

There is no registered investigate-specific behavioral E2E proving that a real agent:

- refrains from fixing before a confirmed hypothesis;
- stops after three failed hypotheses;
- writes a causal regression test;
- reruns the original reproduction;
- requests approval for >5-file blast radius.

### Freeze submechanism

Freeze is different: its shell logic has direct tests for allow/deny/fail-closed/symlink behavior, and investigate has a specific hook-path regression test.

Thus the evidence map is:

```text
causal workflow discipline
→ strong authored policy
→ weak direct behavioral verification

Edit/Write freeze guardrail (Claude host)
→ runtime script
→ focused behavioral shell tests
```

This asymmetry is itself an important gstack finding: some crucial workflow principles have a much thinner verification floor than lower-level runtime controls.

---

## 15. Strongest subsystem conclusions

### I1 — `/investigate` separates diagnosis from intervention

**Status:** strong authored-contract observation.

The intended workflow makes a specific testable causal hypothesis the admission object before implementation.

### I2 — uncertainty accumulation changes control authority

**Status:** strong authored-contract observation.

Three failed hypotheses terminate automatic continuation and require user/human choice about further investigation, escalation or instrumentation.

### I3 — mutation scope is narrowed after a hypothesis, but enforcement is partial

**Status:** strong implementation + behavioral-test observation for Claude Edit/Write.

Freeze can hard-deny out-of-boundary Edit/Write tool calls, including symlink escapes and malformed hook payloads. Bash remains outside that guardrail.

### I4 — scope enforcement is host-dependent

**Status:** strong host-generation observation.

Claude retains hooks. Common external hosts such as Codex strip frontmatter hooks; OpenClaw's adapted investigate workflow omits freeze. Causal methodology is more portable than its runtime scope lock.

### I5 — successful investigation requires mechanism evidence plus fresh symptom evidence

**Status:** strong authored-contract observation.

Regression test + full suite + fresh original reproduction are distinct intended completion evidence.

### I6 — “root cause” is used more strongly than the workflow can guarantee

**Status:** strong analytical qualification.

The workflow usually demands a confirmed causal mechanism but does not require a prevention/detection/systemic-cause layer before declaring root cause.

### I7 — recurring failures are explicitly allowed to pressure the analysis toward architecture

**Status:** strong authored-contract observation.

Prior repeated bugs, cascading fixes, multiple failed hypotheses and large blast radius are signals that the problem may be at the wrong abstraction layer.

### I8 — investigation knowledge is designed to compound, but remains fallible evidence

**Status:** strong implementation inference.

Learnings carry source/confidence/files, decay over time, and cross-project trust restrictions; they inform future investigations without becoming automatic truth.

### I9 — behavioral verification of the causal methodology is a current weak point

**Status:** direct coverage observation.

The coverage registry gives `/investigate` only the generic structural floor. This is materially weaker than the real-browser/runtime tests behind several other gstack mechanisms.

---

## 16. Causal-control model

A useful neutral reconstruction is:

```text
Failure observation
      ↓
Evidence acquisition
      ↓
Candidate causal model
      ↓
Falsification attempt
      ├─ fails → revise model / escalate if repeated
      └─ survives
            ↓
      bounded intervention
            ↓
      recurrence-specific test
            ↓
      fresh symptom verification
            ↓
      durable causal record
            ↓
      future search/hypothesis prior
```

The loop is not purely technical. It combines:

- epistemic state: what cause is currently supported;
- work state: investigation vs implementation vs verification;
- authority state: agent may continue vs must escalate;
- runtime constraint: where edits may be made;
- information persistence: what future sessions can reuse.

Those cross-cutting observations remain gstack-native here; four-ground projection is still deferred.

---

## 17. Remaining gaps

This subsystem is sufficiently reconstructed for the current synthesis ladder. Later clusters should revisit the following where relevant:

1. dedicated behavioral evals for `/investigate` causal ordering and 3-strike behavior;
2. whether host adapters should expose equivalent freeze enforcement outside Claude;
3. automatic freeze lifecycle cleanup / stale-boundary detection;
4. complete mutation confinement if gstack ever intends freeze to become more than an Edit/Write guardrail;
5. deeper systemic RCA contract separating occurrence cause from prevention/detection failure;
6. causal graph / multiple-contributor handling rather than singular “the root cause” language;
7. investigation effectiveness across intermittent/production-only failures;
8. broader memory/GBrain staleness and trust semantics;
9. how `/investigate` interacts with `/cso`, `/review`, `/ship`, `/retro` when the problem class is systemic rather than local.

---

## 18. Cross-subsystem consequence

The first four subsystem syntheses now expose a repeated pattern:

```text
Planning/spec:
  qualify intent before work admission

Review/ship:
  qualify implementation before delivery

Browser/runtime:
  qualify authority/effects/evidence at execution boundaries

Investigate:
  qualify causal explanation before corrective mutation
```

This strengthens — but does not yet prove — the working hypothesis that gstack's deeper design is based on **qualified transitions**, not merely a list of AI roles or commands.

The next useful subsystem is memory/learnings/GBrain because investigation shows that causal conclusions are deliberately fed back into future reasoning; reconstructing that memory lifecycle is now a direct dependency for understanding whether this qualification system compounds safely or accumulates stale/contaminated state.

---

## 19. Source re-entry map

Load-bearing sources for this synthesis include:

- `investigate/SKILL.md.tmpl`
- generated `investigate/SKILL.md` where resolver/telemetry output mattered
- `freeze/SKILL.md.tmpl`
- `freeze/bin/check-freeze.sh`
- `unfreeze/SKILL.md.tmpl`
- `bin/gstack-paths`
- `scripts/resolvers/learnings.ts`
- `bin/gstack-learnings-log`
- `bin/gstack-learnings-search`
- `scripts/resolvers/gbrain.ts`
- `hosts/define-host.ts`
- `hosts/claude.ts`
- `hosts/codex.ts`
- `openclaw/skills/gstack-openclaw-investigate/SKILL.md`
- `test/skill-coverage-matrix.ts`
- `test/skill-coverage-floor.test.ts`
- `test/investigate-freeze-path.test.ts`
- `test/hook-scripts.test.ts`

Use `../SOURCE-LEDGER.md` for exact read status and pinned identifiers. Return to upstream source before stronger reuse where a source is marked `SUBSTANTIAL / CONTINUE`.
