# gstack — Guarded Action / Security Review

**Study target:** `garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`  
**Target package version:** 1.79.0  
**Study status:** BOUNDED SUBSYSTEM SYNTHESIS  
**Foundation status:** candidate-study evidence only; no Foundation mutation

## Question

Outside the already-synthesized browser runtime security and investigate freeze behavior, how does gstack constrain dangerous action, preserve human authority on one-way decisions, qualify security findings, and decide when uncertainty should deny, ask, degrade, suppress, or remain informational?

The central correction is that gstack does **not** have one universal “security mode.” It has several control families with different semantics:

```text
A. preventive tool interposition
   /careful → Bash ask/deny
   /freeze  → Edit/Write scope deny
   /guard   → composition of the two

B. decision-authority protection
   one-way-door registry + AUQ preference hook
   → destructive/high-stakes choices cannot be silently preference-suppressed

C. detective / advisory security qualification
   /cso
   → candidate generation
   → hard false-positive filtering
   → active source verification
   → fresh verifier
   → confidence/status gate
   → report + trend

D. host capability substitution
   Claude host: actual PreToolUse hooks
   external hosts: generated Safety Advisory prose
```

These layers differ in whether they can actually stop an effect, merely force a human decision, or only produce evidence/recommendations.

---

# 1. `/careful`: opt-in runtime interposition on Bash

## 1.1 What it actually controls

On the Claude host, `/careful` declares a `PreToolUse` hook for `Bash` and routes every Bash tool call through `careful/bin/check-careful.sh`.

The hook parses the tool payload and classifies the command before execution.

Its main control classes are:

```text
safe / no match
→ allow (no permission decision)

MEDIUM destructive pattern
→ permissionDecision: ask

narrow HIGH catastrophic pattern
→ permissionDecision: deny
```

This is a real tool-interposition control, not merely prompt prose, on the host that supports the hook.

---

## 1.2 MEDIUM is the dominant policy

Most destructive families are not hard-blocked. They trigger an explicit approval question:

- recursive `rm` outside known build-artifact exceptions;
- SQL `DROP TABLE`, `DROP DATABASE`, `TRUNCATE`;
- git force-push;
- `git reset --hard`;
- `git checkout .` / `git restore .`;
- `kubectl delete`;
- destructive Docker removal/prune;
- user-configured additive project/global patterns.

This means the ordinary policy is:

```text
potentially destructive command
→ interrupt automatic execution
→ return authority to the user
```

not:

```text
potentially destructive command
→ universally deny
```

That distinction matters. `/careful` is primarily an **authority-interposition system**, with a very small hard-deny subset.

---

## 1.3 HIGH tier is deliberately tiny

The pinned implementation hard-denies two catastrophic **simple-command** classes:

1. recursive deletion of the filesystem root / whole home class (`/`, `~`, `$HOME`, `/*` variants);
2. force-push targeting the repository’s default branch.

Even here the source explicitly limits the claim:

> best-effort advisory hard-stop, not a policy boundary

Why only simple commands?

The script cannot safely infer the semantic target/cwd of arbitrary shell composition. Any command containing shell chaining/piping/newlines falls back to MEDIUM `ask` rather than pretending it can prove the high-risk target.

Thus:

```text
known catastrophic + simple enough to classify
→ deny

potentially catastrophic + semantically ambiguous compound shell
→ ask
```

This is a conservative uncertainty policy, but not a complete shell sandbox.

---

## 1.4 Unreadable/obfuscated commands fail toward human review

The hook is hardened against several bypass/failure classes:

- malformed/unparseable JSON payload → `ask`;
- missing shared hook helper → `ask`;
- `${IFS}` / shell word-splitting obfuscation → `ask`;
- base64-to-shell patterns → `ask`;
- quoted arguments cannot truncate the parser before a later destructive command;
- command substitutions cannot ride the safe build-directory exception;
- multi-command chains cannot use a final safe-looking `rm` to hide an earlier unsafe one.

A key failure-polarity rule emerges:

```text
cannot reliably safety-classify a Bash command
→ do not silently allow
→ ask the user
```

This is stronger than fail-open and weaker than universal deny.

---

## 1.5 Safe exceptions are narrow and structurally constrained

Known disposable build/cache targets such as `node_modules`, `.next`, `dist`, `build`, `.cache`, etc. can pass without warning, but only when the **whole command** matches the safe shape.

The implementation deliberately accepts false-positive asks for some chained safe commands rather than broaden the whitelist in a way that allows a dangerous command to hide behind safe-looking syntax.

This is an explicit precision/recall trade in favor of safety at the execution boundary.

---

## 1.6 Project customization can add, not subtract

Global and per-project regex files are consulted only after built-in destructive families.

They can introduce extra `ask` rules but cannot suppress or weaken baseline controls.

So user configuration is monotonic in the safety direction:

```text
baseline controls
+
optional extra warnings
```

rather than arbitrary policy replacement.

---

# 2. `/guard`: composition, not a new sandbox

`/guard` combines:

```text
Bash  → careful hook
Edit  → freeze hook
Write → freeze hook
```

It asks the user for a freeze directory, writes the normal `freeze-dir.txt` state, then relies on the two existing mechanisms.

This is important because “full safety mode” can sound stronger than its actual capability model.

`/guard` does **not** create one unified mutation sandbox. It composes resource-specific controls:

- Bash gets destructive-pattern inspection;
- Edit/Write get directory-boundary enforcement;
- arbitrary shell file mutation is not covered by the freeze Edit/Write hook merely because `/guard` is active.

Therefore:

```text
Guard mode
≠ complete process/filesystem sandbox
```

It is a composition of two partial but real controls.

---

# 3. Host capability changes control strength

This subsystem exposes one of the clearest portability/fidelity gaps in the pinned system.

Claude skill frontmatter can carry PreToolUse hooks. Common external-host generation strips hook frontmatter.

The generator detects hooked tools and inserts prose such as:

> Safety Advisory: ... pause and verify before executing potentially destructive operations ... ask the user if uncertain.

The generated-host regression test explicitly requires `gstack-careful`, `gstack-freeze` and `gstack-guard` to have Safety Advisory prose **and no hooks frontmatter**.

Thus the same conceptual skill changes from:

```text
Claude host
Bash/Edit/Write tool call
→ deterministic pre-execution hook
→ ask/deny enforcement
```

into:

```text
external host
model reads safety prose
→ expected to self-police
```

That is not equivalent control strength.

A load-bearing conclusion follows:

> whether a gstack safety rule is policy prose or runtime enforcement depends on the host capability surface.

The skill name alone cannot establish the effective safety boundary.

---

# 4. One-way doors: preserving human decision authority

A second preventive/control layer operates at **decision time**, not Bash execution time.

The plan-tuning system can learn that the user prefers not to be repeatedly asked certain questions. Without a safety exception, this creates an obvious risk:

```text
user preference: “never ask this again”
+
later destructive decision
→ accidental silent auto-approval
```

The pinned system explicitly prevents that.

---

## 4.1 Typed registry is the primary safety source

`scripts/question-registry.ts` assigns known questions a `door_type`:

```text
one-way
or
two-way
```

Known security/destructive/architectural questions are asserted one-way in gate-tier tests, including:

- ship broken-test disposition;
- review SQL safety / LLM trust boundary;
- CSO global-scan approval;
- CSO finding remediation;
- deploy merge / rollback;
- applying an investigate fix;
- architecture/premise changes;
- privacy/external-search gates.

This typed registry is intentionally the primary control because prose wording is too unstable to carry a safety boundary.

---

## 4.2 Keyword classifier is only the secondary net

For ad-hoc/unregistered questions, `scripts/one-way-doors.ts` applies conservative patterns for:

- delete/wipe/purge/truncate;
- database DROP/DELETE;
- force push/reset/clean;
- kubectl/terraform destructive actions;
- credential revoke/reset/rotate;
- architecture/data-model/schema/breaking changes.

It also marks security-audit approval and land/deploy approval categories as one-way.

The repository explicitly documents why this is secondary:

```text
wording-based classifier alone
→ too brittle for primary safety
```

This is an important design quality: semantic prose classification is used as defense-in-depth, not treated as the authoritative registry.

---

## 4.3 Preference suppression cannot override one-way standing

The Claude AskUserQuestion PreToolUse hook implements the decisive rule:

```text
never-ask preference
+
two-way question
+
unambiguous recommended option
→ auto-decide via deny+reason feedback

never-ask preference
+
one-way question
→ PASS THROUGH
→ user still receives the question
```

Likewise, if recommendation parsing is ambiguous, it refuses to auto-decide.

An unregistered destructive question with a stored never-ask preference is caught by the secondary keyword net and still passes through to the human.

So the system protects an important distinction:

> convenience preference is not authority to erase human confirmation on irreversible/high-stakes choices.

This is stronger than merely telling the model “ask before dangerous things,” because the Claude host hook deterministically intercepts the AskUserQuestion tool path.

---

# 5. `/cso`: detective/advisory security qualification

`/cso` is a fundamentally different control family.

It does not primarily stop dangerous operations. It creates a **qualified security evidence artifact**.

The workflow is approximately:

```text
attack-surface census
→ phase-specific candidate generation
→ hard false-positive exclusions
→ confidence gate
→ active source/code verification
→ fresh verifier child
→ pre-emit source-quotation gate
→ VERIFIED / UNVERIFIED / TENTATIVE standing
→ exploit scenario + remediation
→ persisted report + trend comparison
```

Its output is security evidence and recommendation, not runtime prevention.

---

# 6. CSO optimizes daily mode for precision, comprehensive mode for recall

The two main modes intentionally have different epistemic thresholds.

## Daily

```text
minimum confidence = 8/10
“zero noise” objective
below 8 → do not report
```

## Comprehensive

```text
minimum threshold = 2/10
include weak candidates
label low-confidence results TENTATIVE
```

This means security standing is mode-relative.

A missing item from the daily report does **not** mean “proved safe”; it can mean a candidate did not meet the reporting threshold.

Likewise, a comprehensive-mode tentative item is not the same standing as a verified daily finding.

---

# 7. False-positive filtering is explicit system behavior

CSO carries a large hard-exclusion/precedent layer that removes classes judged too noisy or insufficiently actionable unless a concrete exception applies.

Examples include:

- generic DoS/resource-exhaustion findings, except LLM spend amplification;
- missing hardening without an actual vulnerability;
- non-exploitable race/timing concerns;
- test fixture findings not imported by production code;
- path-only SSRF;
- ordinary user-message content incorrectly called prompt injection;
- documentation-only findings, except executable `SKILL.md` prompt code;
- local-dev container findings not used in production.

This is not merely presentation cleanup. It changes which candidates are admitted into the security-reporting workstream.

The intended product objective is explicitly:

> zero noise is more important than zero misses

for the default daily mode.

Thus CSO is not a maximum-recall scanner by default.

---

# 8. Security status and confidence are separate dimensions

CSO uses at least three distinct concepts:

```text
severity
confidence
verification status
```

Verification status can be:

- `VERIFIED` — actively confirmed by tracing/safe test;
- `UNVERIFIED` — pattern exists but could not be confirmed;
- `TENTATIVE` — comprehensive-mode low-confidence candidate.

A finding can therefore be high-severity while still not being verified.

This prevents flattening “security finding exists” into one truth state.

---

# 9. Active verification is source-grounded and non-exploitative

CSO attempts to prove findings where safe without turning the audit into uncontrolled exploitation.

Examples:

- validate secret format but do not call live provider APIs;
- trace webhook signature middleware without sending requests;
- trace SSRF path to internal target without making network requests;
- parse CI workflow behavior;
- check dependency call reachability;
- trace user input into LLM prompt construction.

This is a deliberate evidence boundary:

```text
stronger than pattern matching
but
short of live destructive/exploit execution
```

That fits the skill’s read-only/advisory purpose.

---

# 10. Pre-emit source quotation is an important evidence gate

Before promotion into the report, the skill requires the motivating code to be quoted with file/line context.

If the auditor cannot quote the source that supports the claim, confidence is forced down to the 4–5 range and the finding is suppressed from the main report.

This kills a common LLM failure class:

```text
“field/function/protection does not exist”
without reading the source that would establish existence/absence
```

Framework-generated constructs receive a special correction: the relevant migration/decorator/Meta/schema source should be inspected instead of relying on literal grep absence.

This is a strong source→claim fidelity mechanism in authored policy.

---

# 11. Fresh verifier reduces anchoring but does not create external independence

Every candidate surviving the initial gate is intended to receive a fresh Agent verification pass.

The verifier receives:

- file path + line;
- false-positive rules;
- the candidate problem;

but not the first scanner’s full reasoning chain.

This reduces anchoring and forces a second read of the source.

However:

```text
fresh child context
≠ independent security firm
≠ independent model necessarily
≠ independent oracle
```

The skill itself handles Agent unavailability honestly: it self-verifies and marks the result as such instead of pretending independent verification happened.

The live diff-mode E2E is meaningful here: repository comments record that the real agent finds the planted webhook issue, spawns the verification child, writes the report, and previously exceeded the old test budget only during closing telemetry. Other small-scope E2Es intentionally disable Agent verification, so behavioral coverage is still scenario-specific.

---

# 12. CSO “read-only” is behavioral scope, not a technical write sandbox

The skill’s Important Rules say:

> Read-only. Never modify code. Produce findings and recommendations only.

But the skill is allowed the `Write` tool because it must persist `.gstack/security-reports/*.json`.

No separate inspected runtime hook constrains CSO Write calls to the report directory.

Therefore the safe claim is:

```text
CSO code-mutation prohibition
→ authored behavioral contract
```

not:

```text
CSO process physically cannot modify source code
```

This parallels a broader gstack pattern: role/standing does not automatically imply technical capability restriction.

---

# 13. Security reports are historical evidence, not live security standing

CSO persists reports under:

`.gstack/security-reports/{timestamp}.json`

with:

- findings;
- confidence/status;
- fingerprints;
- attack-surface summary;
- filter statistics;
- trend metadata;
- verification labels.

Prior reports are compared by fingerprint to classify findings as resolved, persistent or new.

This is useful longitudinal evidence, but the targeted pinned-repo search found the report surface primarily inside CSO itself and its E2E fixture. No separate runtime action gate was found that blocks deployment/ship merely because a historical CSO report contains a finding.

So:

```text
security report exists
≠ current security state is unchanged
≠ deployment automatically blocked
≠ finding automatically still valid
```

The report is a timestamped audit artifact. Current security standing would require current source/environment re-evaluation.

This is particularly important because the browser subsystem already contained a historical example where an unfed security-status surface was removed rather than allowed to report false-green state. The same source-fidelity principle applies here.

---

# 14. Security remediation preserves user authority

For important findings, CSO presents remediation choices such as:

- fix now;
- mitigate;
- accept risk;
- defer with security label.

The plan-tuning registry marks CSO security-finding decisions as one-way doors.

Therefore a learned “never ask me” preference does not silently turn a security remediation into an automatic irreversible choice.

This links detective security evidence to a separate authority-control layer rather than letting the scanner directly own remediation.

---

# 15. Failure-polarity matrix

| Condition | Result | Meaning |
|---|---|---|
| ordinary safe Bash command under careful | allow | no safety intervention |
| recognized destructive Bash family | ask | return authority to user |
| malformed/obfuscated command | ask | uncertainty does not silently allow |
| recursive root/home delete, simple form | deny | narrow HIGH hard-stop |
| force-push default branch, simple form | deny | narrow HIGH hard-stop |
| same danger inside compound shell | ask | parser will not pretend semantic certainty |
| external host without hooks | Safety Advisory prose | enforcement degrades to model compliance |
| two-way AUQ + stored never-ask + clear recommendation | auto-decide | preference optimization |
| one-way AUQ + stored never-ask | pass through | safety outranks preference |
| ambiguous recommended AUQ | pass through | refuse silent wrong auto-decision |
| CSO daily candidate <8 | suppress | precision-first reporting |
| CSO comprehensive candidate 2–7 | TENTATIVE | recall-first but explicitly weak standing |
| source line cannot be quoted | confidence forced down / suppressed | source-grounding failure |
| verification child unavailable | self-verify + label | degrade honestly rather than counterfeit independence |

This shows there is no universal gstack failure polarity. The response depends on whether the system is controlling **effects**, **human authority**, or **evidence quality**.

---

# 16. Bounded findings

### S1 — gstack security controls separate prevention, decision authority and detection

**Status:** strong synthesis conclusion.

`/careful`/freeze/guard can interpose on tool actions; one-way doors protect human confirmation; CSO produces qualified security evidence. They must not be collapsed into one security layer.

### S2 — `/careful` is primarily an ask gate with a narrow deny tier

**Status:** strong implementation + deterministic-test observation.

Most destructive commands are overridable after user confirmation; only a very small catastrophic simple-command subset is denied.

### S3 — careful uncertainty fails toward human review, not silent allow

**Status:** strong implementation/test conclusion.

Malformed JSON, helper loss and shell obfuscation produce `ask` rather than allow.

### S4 — `/guard` is composition, not a universal sandbox

**Status:** strong source conclusion.

It combines Bash destructive-command interposition with Edit/Write directory scope. Those are different resource controls and still leave gaps such as arbitrary shell filesystem effects.

### S5 — host capability materially changes effective safety semantics

**Status:** strong generation/test conclusion.

Claude host retains hooks; external hosts receive Safety Advisory prose and no hook frontmatter. A cross-host skill name does not guarantee equivalent enforcement.

### S6 — learned convenience preferences cannot suppress one-way safety decisions

**Status:** strong implementation/test conclusion.

Typed registry standing is primary; keyword classification is defense-in-depth; one-way questions remain human-visible even under never-ask preferences.

### S7 — CSO is a qualification/evidence system, not a runtime security boundary

**Status:** strong authored-contract conclusion.

It scans, verifies, filters and reports; it does not itself prevent vulnerable code from executing or automatically block delivery.

### S8 — CSO default mode deliberately favors precision over recall

**Status:** direct authored-policy observation.

Daily 8/10 threshold suppresses uncertain candidates; comprehensive mode exposes much weaker findings as TENTATIVE.

### S9 — CSO security standing is multidimensional

**Status:** strong source conclusion.

Severity, confidence and verification status are separate. A finding can be severe but unverified, or low-confidence/tentative in comprehensive mode.

### S10 — source quotation is a claim-admission gate

**Status:** strong authored-policy observation.

Failure to quote the motivating current source forces confidence down and suppresses the finding from the main report.

### S11 — fresh verifier is an anti-anchoring mechanism, not independent external verification

**Status:** verification qualification.

Reasoning separation improves challenge quality, but common model/object/orchestration dependencies remain.

### S12 — CSO read-only standing is behavioral, not capability-enforced

**Status:** strong corrective finding.

The skill has Write capability for report persistence and no inspected write-sandbox that technically prevents source mutation.

### S13 — CSO reports are timestamped historical evidence, not automatically current security truth

**Status:** bounded source/retrieval conclusion.

Trend comparison exists, but no targeted pinned-repo evidence showed the report acting as a live deployment/runtime security gate.

### S14 — security authority is deliberately separated from remediation execution

**Status:** strong cross-source conclusion.

CSO identifies/recommends; one-way AUQ gates keep important remediation/risk decisions with the human rather than allowing scanner findings to directly authorize irreversible action.

---

# 17. Verification strength

## Strong

- `careful/bin/check-careful.sh` implementation;
- `test/hook-scripts.test.ts` deterministic realistic Bash cases, including parser bypass regressions, obfuscation, HIGH deny and MEDIUM ask semantics;
- generated hook wiring on Claude;
- one-way-door typed registry and classifier tests;
- AskUserQuestion preference-hook tests proving one-way overrides never-ask and ambiguity refuses auto-decision;
- external-host generator test proving safety prose + removed hooks;
- CSO authored filtering/verification/report schema;
- CSO live full/diff/infra E2Es for selected planted vulnerabilities/report behavior;
- diff E2E historical/test evidence that verifier child actually runs in the selected path.

## Bounded

- effectiveness of regex-based careful classification against arbitrary shell semantics;
- CSO’s semantic correctness over large/complex real systems;
- calibration validity of the 1–10 confidence scale;
- independence of same-family verification children;
- longitudinal security trend accuracy when code is refactored/moved enough to alter fingerprints;
- equivalent preventive enforcement across non-Claude hosts.

## Not established

- complete OS/process/filesystem sandboxing;
- universal hard-deny policy boundary;
- professional-grade penetration-test equivalence;
- automatic ship/deploy blocking based on CSO report standing;
- independent external security verification.

---

# 18. Source re-entry map

Load-bearing sources include:

- `careful/SKILL.md.tmpl`;
- `careful/bin/check-careful.sh`;
- `guard/SKILL.md.tmpl`;
- `freeze/bin/check-freeze.sh` and freeze synthesis;
- `test/hook-scripts.test.ts`;
- `scripts/gen-skill-docs.ts` safety-advisory generation;
- `test/gen-skill-docs.test.ts` external-host hook-removal/safety-prose pin;
- `scripts/question-registry.ts` via registry tests;
- `scripts/one-way-doors.ts`;
- `hosts/claude/hooks/question-preference-hook.ts`;
- `test/plan-tune.test.ts`;
- `test/question-preference-hook.test.ts`;
- `cso/SKILL.md` / `.tmpl`;
- `test/skill-e2e-cso.test.ts`.

---

# 19. Implication for the gstack system model

Seven native subsystem syntheses now support a stronger system-level model:

```text
Planning/spec
→ qualifies intent before admission

Review/ship
→ qualifies implementation before delivery

Browser/runtime
→ qualifies capability, effects and evidence

Investigate
→ qualifies causal explanation before corrective mutation

Memory/context
→ qualifies prior information before reuse

Multi-agent coordination
→ qualifies delegation, completion and child evidence

Guarded action/security
→ qualifies whether an effect may proceed,
   whether the human must decide,
   and whether a security claim deserves report standing
```

The important negative pressure test is host portability: on Claude, some security boundaries are runtime hooks; on external hosts the same conceptual skill can degrade to prose. Therefore the **effective environment/capability surface** is load-bearing to whether a declared control is actually enforceable.

This makes **host adapters / portability fidelity** the next natural subsystem. Multi-agent coordination and guarded-action security have now independently exposed the same question:

> when gstack renders the same workflow for another host, which semantics are preserved, which are rewritten, which are suppressed, and which silently weaken from enforcement to advice?
