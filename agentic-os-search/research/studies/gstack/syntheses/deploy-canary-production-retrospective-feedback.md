# gstack — Deploy / Canary / Production Observation / Retrospective Feedback

## Scope

This synthesis reconstructs the post-qualification side of the pinned gstack workflow:

- pre-merge release readiness;
- merge authority and authoritative merge state;
- deploy strategy and deployment completion;
- staging and post-deploy verification;
- extended canary monitoring;
- rollback/revert behavior;
- deploy/canary evidence artifacts;
- retrospective history, trends and learning feedback.

Pinned target:

`garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`

The central question is:

> after code is qualified for release, how does gstack distinguish “merged,” “deploy executed,” “deployment healthy,” “rollback initiated,” and “production restored,” and how does operational evidence return to future work?

This remains a gstack-native synthesis. It does not mutate or extend the SOUL Foundation.

---

## 1. Executive reconstruction

The strongest native model is a **delivery-state ladder** rather than one generic “shipped” state:

```text
qualified PR
        ↓
pre-merge readiness evidence
        ↓
explicit human merge authority
        ↓
authoritative GitHub merge state
        ↓
deploy strategy / deploy-run identification
        ↓
deployment completion evidence
        ↓
single-pass live verification
        ↓
optional extended canary monitoring
        ↓
deploy/canary reports + timeline state
        ↓
retrospective metrics / trends / learnings
        ↓
recommendations / candidate future work
```

This is a real strength. gstack frequently distinguishes execution from outcome:

```text
merge command returned success
≠ PR is authoritatively merged

deploy workflow succeeded
≠ live site is healthy

site answers now
≠ site is necessarily the intended new release

retro recommendation
≠ admitted future work
```

However, the discipline is not uniform. The most important negative finding is rollback closure:

```text
revert commit created/pushed
→ report can become REVERTED

but

revert deployment completed
+ production restored
+ post-rollback health verified

is NOT a mandatory closure loop
```

Thus `REVERTED` in the current workflow is principally **control-action completion**, not proven **production restoration**.

---

## 2. `/land-and-deploy` is a post-ship release-state machine

`/ship` creates/qualifies the PR. `/land-and-deploy` takes over at the transition from reviewable change to production effect.

Its major stages are:

```text
PR discovery / authentication
→ first-run/config-change deploy validation
→ CI + mergeability
→ version drift control
→ pre-merge readiness
→ merge
→ authoritative readback / queue wait
→ deploy strategy
→ deploy wait
→ live canary
→ optional revert
→ deploy report
```

It is intentionally mostly automated but preserves human control at irreversible/high-stakes transitions.

GitLab/unknown platforms are explicitly unsupported for this workflow at the pinned revision; the skill stops and tells the user to merge manually.

---

## 3. Deployment configuration is persistent but qualified

`/setup-deploy` detects or asks for:

- platform;
- production URL;
- deploy workflow or trigger;
- deploy-status command;
- health-check URL/command;
- merge method;
- project type;
- custom pre/post hooks.

It writes the result into `CLAUDE.md` under `## Deploy Configuration`, which becomes the declared source of truth for later `/land-and-deploy` runs.

### 3.1 Config persistence is not treated as eternally valid

`/land-and-deploy` stores a confirmation fingerprint derived from:

```text
Deploy Configuration section
+
deploy/CD workflow file contents
```

On first run or when that fingerprint changes, it re-enters a dry-run validation before irreversible work.

This is an important qualification pattern:

```text
configuration exists
≠ configuration remains confirmed
```

### 3.2 Residual freshness gap

The fingerprint sees repository-side configuration changes. It does not automatically detect all external platform changes:

- project renamed in hosting provider;
- deployment connection reconfigured in provider UI;
- DNS/custom-domain moved;
- environment/credential/runtime policy changed externally.

Command/URL validation catches some consequences, but the durable `CLAUDE.md` representation can still diverge from external deployment reality without a repository diff.

---

## 4. First-run dry-run creates an explicit infrastructure standing

The first-run/config-change flow:

1. detects deployment infrastructure;
2. tries relevant commands;
3. checks production URL reachability;
4. detects staging/preview targets;
5. previews release-readiness checks;
6. shows the complete interpretation to the user;
7. stores a confirmation fingerprint only after user approval.

Most platform-command or URL validation failures are warnings, not blockers. The philosophy is:

```text
“cannot verify this part now”
≠
“deployment configuration is unusable”
```

That is defensible, but it means later release confidence must continue to preserve the degraded verification state rather than silently treating saved config as confirmed infrastructure truth.

---

## 5. Pre-merge readiness combines source freshness, testing and user authority

The readiness gate is more sophisticated than a static checklist.

### 5.1 Review freshness is evidence-relative

For diff-scoped reviews, current working-tree fingerprint equality can establish `CURRENT` even after rebase/amend/commit-count changes.

Plan-tier reviews use a different validity rule because they grade plan artifacts rather than working-tree content.

This strengthens the wider gstack pattern:

> freshness is object-relative; there is no universal “review is N commits old” rule.

### 5.2 Free-test evidence is content-bound

The gate first asks `gstack-evidence` whether a prior successful run:

- used the exact expected command;
- is within the allowed age;
- corresponds to the current working-tree fingerprint modulo tightly allowed paths.

If not, tests are rerun live through the evidence wrapper.

A failed evidence *lookup* is not a blocker. A failed actual test *run* is.

That distinction is strong:

```text
missing proof
→ acquire new proof

negative proof
→ blocker
```

### 5.3 E2E/LLM evals are weaker readiness evidence

Absence/failure in recent E2E or LLM eval artifacts is rendered as warnings in this gate, not the same hard blocker as failing free tests.

So the readiness system already contains heterogeneous evidence authority.

---

## 6. Readiness contains a policy inconsistency around blockers

A load-bearing contradiction exists inside the same readiness section.

Earlier it states:

```text
If tests fail: BLOCKER. Cannot merge with failing tests.
```

But the final user decision menu still includes:

```text
A) Merge it
B) Hold off
C) Merge anyway — I understand the warnings
```

and says that when blockers exist the workflow should *recommend B*.

The text does not introduce a deterministic branch saying A/C become unavailable when the blocker is a failed free-test run.

### 6.1 Human authority does not resolve the contradiction

The actual merge confirmation is registered as a typed one-way decision, so user preference cannot silently auto-decide it.

That protects human sovereignty, but it is a different property from:

```text
hard invariant: failing test run makes merge impossible
```

At the pinned source level the former is structurally stronger than the latter.

Protected conclusion:

> “failing tests are a blocker” is a strong authored policy statement, but the inspected final decision flow does not prove that the user cannot explicitly override it through the merge decision surface.

This should not be described as a deterministic technical merge block.

---

## 7. Merge authority is explicitly one-way

Both high-stakes release decisions are in the typed question registry:

```text
land-and-deploy-merge-confirm → one-way
land-and-deploy-rollback      → one-way
```

The plan-tune preference system therefore cannot convert them into silent automatic decisions merely because the user previously selected `never-ask` behavior.

This is a strong separation:

```text
workflow automation preference
≠ authority to merge or roll back production
```

---

## 8. Merge-command outcome is not treated as merge truth

One of the strongest causal/control mechanisms in the subsystem appears after `gh pr merge` returns non-zero.

The workflow explicitly says:

> after any non-zero merge command, query authoritative PR state; never retry the merge mutation first.

This handles cases where:

- server-side merge succeeded but local cleanup failed;
- another actor merged concurrently;
- squash/rebase created a commit that breaks naive ancestry proof;
- auto-merge/merge queue means the PR remains open while waiting.

The authoritative signals are GitHub PR state and `mergeCommit.oid`, not local command exit alone.

This is a high-quality source-vs-effect distinction:

```text
local command result
≠ remote state transition result
```

It also improves idempotency: the workflow refuses to repeat a potentially already-successful merge mutation.

---

## 9. Merge queue is modeled as an intermediate state

When auto-merge queues the PR, gstack does not report it as merged.

It polls until:

- `MERGED` → capture merge SHA;
- back to `OPEN` → queue failure/removal;
- timeout → unknown/stuck, stop.

So:

```text
merge requested/queued
≠ merge completed
```

This is an explicit intermediate standing rather than a Boolean merge flag.

---

## 10. Deploy completion is provider-specific evidence

After authoritative merge, the workflow tries to establish deployment standing using several strategies.

### 10.1 GitHub Actions — strongest release-identity binding

It locates deploy runs by **merge commit SHA** and polls the matching workflow.

This gives a relatively strong chain:

```text
merge SHA
→ deploy workflow run
→ workflow conclusion
```

### 10.2 Platform CLI — provider-dependent

Fly/Heroku and custom commands may provide deployment/release status, but their proof strength depends on what the command actually reports.

A “machines started” or latest-release response is useful operational evidence, but is not universally equivalent to “this exact merge SHA is live.”

### 10.3 Auto-deploy URLs — weaker identity binding

Render may be polled until the production URL responds.

Vercel/Netlify may simply receive a propagation wait followed by live canary checks.

An HTTP 200 after merge can mean:

```text
new release is live
OR
old release is still serving
OR
partial rollout is serving healthy traffic
```

unless deployment/version identity is independently bound.

### 10.4 No universal deployment oracle

The workflow sensibly supports heterogeneous platforms, but its `Deploy: PASSED` evidence does not have one uniform semantic strength.

Later synthesis must preserve provider/source type.

---

## 11. Deployment success is separated from live health

After deploy completion, `/land-and-deploy` performs a single-pass live verification whose depth depends on diff scope.

For fuller web changes it checks:

- page load;
- console errors;
- performance;
- non-empty/error-free text content;
- screenshot evidence.

This yields an important state transition:

```text
deploy process succeeded
→ now verify the actual live surface
```

The deploy report keeps distinct fields for CI, deploy and verification, and can emit different verdicts such as:

```text
DEPLOYED AND VERIFIED
DEPLOYED (UNVERIFIED)
STAGING VERIFIED
REVERTED
```

That representational separation is one of the strongest features of the production subsystem.

---

## 12. `/land-and-deploy` canary is single-pass; `/canary` is extended monitoring

The release workflow explicitly says its verification is single-pass.

Extended monitoring is delegated to `/canary`.

This avoids pretending that one healthy observation proves sustained rollout health.

The intended relation is:

```text
land-and-deploy
→ immediate post-deploy qualification

canary
→ bounded longitudinal observation over minutes
```

---

## 13. `/canary` is a relative-change monitor when a real baseline exists

Canary can capture a baseline before deployment and later monitor pages every 60 seconds.

It compares:

- page availability;
- new console errors;
- load-time regression relative to baseline;
- broken links;
- screenshots.

It deliberately alerts on **changes, not absolute counts** and requires persistence across two consecutive checks for alerts, reducing one-off transient false positives.

### 13.1 Alert standing and user authority

Critical/high alerts do not auto-rollback. They ask the user whether to:

- investigate;
- continue monitoring;
- rollback;
- dismiss as false positive.

This is consistent with the broader one-way/high-stakes authority model.

---

## 14. Canary without a true pre-deploy baseline is only a health check

This is a critical semantic boundary already acknowledged by the skill itself.

If no `baseline.json` exists, the workflow takes a “pre-deploy snapshot” at invocation time. But the normal `/canary` invocation is **post-deploy**.

Therefore that newly captured reference may actually be:

```text
post-deploy state at t0
```

not:

```text
previous-release state before deployment
```

The skill correctly warns:

> without a baseline, canary is a health check.

Protected correction:

> absence of a true before-state removes regression attribution. The monitor can still detect subsequent degradation during the observation window, but it cannot prove that a difference was introduced by the just-completed deploy.

---

## 15. Canary evidence is not release-identity evidence

The baseline manifest records URL, timestamp, branch and per-page evidence, but the inspected schema does not bind baseline/current observations to:

- merge SHA;
- deployed release ID;
- provider deployment ID;
- application-reported build/version.

Thus a healthy canary proves:

```text
this observed URL looked healthy during this window
```

more strongly than:

```text
this exact new release was what I observed
```

This matters most for CDNs, gradual rollout, stale caches or delayed auto-deploys.

---

## 16. Rollback is authority-controlled but closure is incomplete

When the user chooses rollback, gstack:

1. fetches base;
2. checks out base;
3. creates `git revert <merge-sha>`;
4. pushes directly or creates a revert PR under branch protection;
5. records revert commit/state;
6. reports `REVERTED`.

Both merge and rollback decisions are typed one-way doors.

### 16.1 Main causal-depth gap

After a successful revert push, the workflow says the deploy **should** roll back automatically once CI passes and tells the user to keep an eye on the site.

It does not require:

```text
wait for revert CI
→ wait for rollback deploy
→ bind rollback deploy to revert SHA
→ rerun health/canary
→ prove prior healthy state restored
```

before closing with status `REVERTED`.

Therefore:

```text
REVERTED
= revert mutation accepted/pushed
```

is stronger than “rollback requested” but weaker than:

```text
PRODUCTION RESTORED
```

This is the principal production-loop closure defect found in this subsystem.

---

## 17. Deploy reports preserve multiple standings but are mostly historical artifacts

The deploy report records separate dimensions:

- PR/branch/merge SHA;
- merge path;
- timing;
- review standing;
- CI standing;
- deploy standing;
- staging standing;
- verification standing;
- overall verdict.

This is significantly better than a single “success” flag.

Targeted repository search found the `.gstack/deploy-reports` path in the land-and-deploy workflow/template and its tests, but did not identify a separate later control system that automatically re-consumes those Markdown reports as live deployment authority.

The skill also writes a project JSONL dashboard entry, which provides a more machine-oriented operational trail.

Protected interpretation:

> deploy reports are evidence/history; their presence alone does not establish current production standing.

---

## 18. `/health` is not production health

A naming boundary is important.

`/health` is a **code quality dashboard**. It runs project tools such as:

- typecheck;
- lint;
- tests;
- dead-code detection;
- shellcheck;
- optional GBrain health;

and computes a weighted 0–10 quality score with history/trends.

It is not a live production-service health monitor.

Therefore:

```text
/health score
≠ deploy health
≠ canary health
≠ availability/SLO standing
```

This distinction must remain explicit in any upper-level model.

---

## 19. `/retro` is the main long-horizon feedback mechanism

Retro reconstructs a time-bounded engineering period from:

- refreshed default-branch history;
- commits and code-volume metrics;
- test health;
- PR references;
- work-session patterns;
- contributors/coauthors;
- TODO state;
- prior retros;
- review/plan-completion logs;
- skill usage;
- learnings;
- eureka events;
- optional user-authored context.

It then creates:

- trend comparisons;
- wins;
- growth areas;
- next-week habits;
- shortcut-debt ledger;
- durable retro snapshot.

### 19.1 Retro freshness has an explicit guard

A previous defect allowed coherent-looking retros against stale refs or a wrong “today” anchor.

Current logic:

```text
fetch default branch
→ inspect remote/head/latest analyzed commit
→ if freshness cannot be verified: disclose degraded mode
→ if fetch succeeded and analyzed ref is implausibly stale: BLOCK
```

Dedicated regression tests structurally pin the ordering and failure polarity, with lower-level behavioral guard emissions tested separately.

This is another instance of:

```text
historical data exists
≠ historical analysis is currently grounded
```

---

## 20. Retro persists state and can feed future interpretation

Retro writes snapshots to:

`.context/retros/YYYY-MM-DD-N.json`

Later retros explicitly load prior snapshots and compare trends.

The GBrain schema also exposes prior retros, recent timeline events and recent learnings to the consumer.

In addition, genuine reusable insights can be logged through the learnings mechanism and retro results can be saved to GBrain where that capability is enabled.

So there is a real informational feedback loop:

```text
past work/evidence
→ retro representation
→ persistent history / learning
→ later context and comparison
```

---

## 21. Retrospective recommendation is not work admission

Retro also emits:

- “3 Things to Improve”;
- “3 Habits for Next Week”;
- growth suggestions;
- debt observations.

But inspected source does not automatically turn those recommendations into:

- an admitted work item;
- an issue;
- a plan;
- an assigned obligation;
- an execution commitment.

Some durable decisions/learnings can be separately logged and shortcut debt can be rediscovered, but the retro itself remains predominantly an **informational/interpretive feedback mechanism**.

Protected boundary:

```text
retro says “we should improve X”
≠ Work X has been admitted
≠ Actor Y is obligated
```

This will matter strongly in the later four-ground projection.

---

## 22. Production testing evidence is substantially simulated

The canonical coverage matrix lists `/land-and-deploy` with `test/skill-e2e-deploy.test.ts` as a gate-tier behavior file.

That test file runs a real agent, but its release scenarios explicitly simulate the dangerous external effects:

- no GitHub remote/PR;
- do not run `gh` merge;
- do not run Fly deploy;
- create simulated reports/configuration.

The Canary scenario explicitly says:

- no browse daemon;
- no production URL;
- do not run browser commands;
- demonstrate the report/baseline schema.

So this evidence supports:

```text
agent follows the release/canary workflow representation
```

more strongly than:

```text
real GitHub merge + provider deployment + live browser canary works end-to-end
```

This distinction is load-bearing.

---

## 23. Canary has a test-routing inconsistency

`test/skill-e2e-deploy.test.ts` contains a `canary-workflow` agent scenario, and touchfile tier data classifies that scenario as gate-tier.

But `test/skill-coverage-matrix.ts` lists Canary itself with only the generic structural coverage floor rather than the deploy E2E file.

Therefore two repository views disagree about Canary behavior coverage:

```text
behavior test exists
but
canonical skill→coverage matrix does not attribute it to canary
```

This does not prove the scenario never executes; it proves its **coverage standing is inconsistently represented**.

This belongs both to this subsystem and to the next dedicated testing/eval synthesis.

---

## 24. Retro behavioral coverage is narrow relative to workflow richness

The coverage matrix gives Retro:

- generic structural floor at gate tier;
- a dedicated periodic regression for stale-base protection.

The stale-base regression is valuable and specific, but it does not behaviorally validate the entire long retrospective narrative, metric interpretation, recommendation and persistence loop.

Thus retro freshness control is better pinned than retro semantic-quality output as a whole.

---

## 25. Production feedback failure classes

### F1 — merge command false negative

Local merge command fails after remote merge succeeded.

**Mitigation:** authoritative PR state readback; do not retry mutation.

### F2 — stale release-readiness evidence

Review/tests refer to older content.

**Mitigation:** working-tree fingerprints, command identity, age/freshness rules, live rerun.

### F3 — version queue drift

Another workspace lands first and consumes version slot.

**Mitigation:** detect before merge; return to `/ship` for atomic reconciliation.

### F4 — deploy process failure

Provider/workflow reports failure.

**Mitigation:** stop, investigate/revert/continue-to-health as explicit human choice.

### F5 — deploy success but live failure

Pipeline green, app broken.

**Mitigation:** immediate canary plus optional extended monitor.

### F6 — live health without release identity

URL healthy but new release not proven live.

**Residual gap:** strongest on auto-deploy/URL-only strategies and Canary schema.

### F7 — false regression without pre-deploy baseline

Post-deploy reference mislabeled conceptually as “pre” state.

**Mitigation:** skill explicitly downgrades meaning to health check; user should capture baseline before deploy.

### F8 — rollback action mistaken for restoration

Revert pushed, but rollback deployment/health not proven.

**Residual gap:** report can close `REVERTED` before production restoration verification.

### F9 — retro against stale history

Fresh-looking narrative generated from stale ref/date.

**Mitigation:** fetch/freshness guard + disclosure/BLOCK.

### F10 — recommendation silently treated as future commitment

Retro suggestions interpreted as admitted work.

**Mitigation in analysis:** maintain representation/work boundary; current workflow does not automatically admit them.

### F11 — behavior test mistaken for live integration proof

Agent simulation labeled E2E interpreted as real production deployment validation.

**Mitigation in this study:** classify actual oracle/topology rather than filename.

### F12 — test exists but coverage router omits it

Canary simulation exists but canonical coverage matrix attributes only structural floor.

**Residual gap:** coverage metadata inconsistency.

---

## 26. Cross-subsystem implications

### 26.1 Qualification continues past code review

The wider qualification thesis strengthens:

```text
intent qualified
→ work admitted
→ implementation qualified
→ merge qualified
→ deploy qualified
→ live surface qualified
→ historical outcome interpreted
```

### 26.2 Effect and evidence remain separate

A merge/deploy/revert is an effect. A PR state, workflow result, screenshot, console trace or report is evidence about that effect.

The system is strongest where it explicitly re-reads authoritative state after mutation.

### 26.3 Transition completion is not target-condition completion

This subsystem offers concrete examples:

```text
merge transition completed
≠ deploy completed

deploy completed
≠ app healthy

revert commit completed
≠ old healthy production restored
```

This is likely important for later cross-ground composition analysis, but no Foundation mutation is made here.

### 26.4 Feedback can remain informational

Retro demonstrates that feedback does not need to automatically create work to be useful. It can update knowledge/trends and later influence planning without pretending a recommendation is already an obligation.

---

## 27. Evidence strength table

| Claim surface | Strongest inspected evidence | Confidence / limit |
|---|---|---|
| deploy configuration/dry-run contract | skill + carved sections | strong authored/composed contract |
| merge authoritative readback | carved source | strong behavioral design; no live GitHub integration test established here |
| merge/rollback human authority | typed question registry + plan-tune tests | strong structural enforcement on Claude AUQ path |
| test evidence freshness | readiness source + evidence machinery from prior synthesis | strong current-content logic |
| provider deployment completion | authored provider-specific strategies | heterogeneous oracle quality |
| post-deploy live verification | skill/browser workflow | intended live behavior; gate E2E simulates effects |
| extended Canary monitor | skill | strong policy; E2E scenario is simulated/no browser |
| rollback restoration | source | **negative: no mandatory restoration-verification closure** |
| deploy report | source | historical evidence representation |
| Retro freshness | skill + dedicated regression + metrics tests referenced | relatively strong control coverage |
| full Retro semantic quality | mostly structural/LLM behavior surfaces | weaker than freshness control |
| live external production deployment | not established | no independent/live integration validation established |

---

## 28. Bounded conclusion

**Status: BOUNDED subsystem synthesis.**

Protected conclusion:

> gstack models the path from qualified change to production as a sequence of distinct standings rather than a single “ship succeeded” flag. It has particularly strong distinctions between local merge-command outcome and authoritative GitHub merge state, between deploy completion and live health, and between historical evidence and current state. It also carries first-run deployment configuration fingerprints, explicit one-way human authority for merge/rollback, staging options, immediate canary checks and longer canary monitoring, plus a durable retrospective feedback layer. The main closure weaknesses are that provider-specific deployment evidence is not uniformly bound to the exact release identity, Canary without a true pre-deploy baseline is only a health check, the readiness gate has an authored blocker/override inconsistency for failing tests, and rollback can be reported `REVERTED` after the revert mutation without mandatory proof that the rollback deployment completed and production health was restored. Retro closes an informational learning/trend loop, not an automatic future-work admission loop. Production E2E evidence at the pinned revision is largely simulated rather than a live GitHub/provider/browser integration test.

The next native subsystem should study the **testing / eval / judge / routing / compliance / flake lifecycle**, because production and portability research have both exposed cases where test existence, routing, execution and green status carry different verification standing.
