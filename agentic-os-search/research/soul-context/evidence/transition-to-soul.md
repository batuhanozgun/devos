# Transition to SOUL — evidence synthesis

**Status:** active synthesis; direct evidence + bounded inference  
**Date:** 2026-08-29

## Question

How did the work move from KEEL / os-architect concerns into the SOUL first-principles rebuild, and what does that transition imply about why SOUL Research exists?

This note separates:

- direct historical evidence,
- direct SOUL statements,
- inference that still needs testing.

## 1. Historical problem moved above "product bug" level

By 2026-08-08..13 the os-architect/KEEL work was no longer only asking which mechanisms were missing.

Recorded concerns included:

- question is not automatically a task;
- intended outcome and premise may need to be re-derived before execution;
- owner should not become a hidden orchestrator or technical verifier;
- session/state continuity can carry results while losing purpose/reason;
- multiple agents/reviewers can share one frame/source/model failure;
- controls can measure form while failing to measure value;
- lessons may exist but not be invoked at the moment they are needed;
- a mechanism should be challenged with "would we build this from zero?";
- immediate defect and why it was not anticipated/prevented/detected are separate causal questions;
- "seat-level reasoning" can be strong while system-level reasoning remains ownerless.

The 2026-08-11 gstack record additionally contains an owner direction that an **"araştırma evi"** will be created and that research will feed a later new development effort. It was a direction statement rather than a formal product decision.

## 2. KEEL was not simply failing mechanically

Current KEEL inspection and the last os-architect work show real mechanical progress:

- state/order guards,
- role/write boundaries,
- verifier/read-only separation,
- fresh verification cards,
- fail-visible closure,
- mutation-test definitions.

The last os-architect commit also records a verifier correctly stopping at `DOĞRULANAMADI` on declaration-quality grounds while substantive work was otherwise strong.

Therefore the transition should **not** be summarized as "KEEL was broken, so SOUL replaced it."

A better supported historical reading is:

> KEEL's operating discipline was becoming mechanically stronger while the unresolved problem was moving upward: framing, system formation, system-level reasoning, owner orchestration, generality, and the process by which the architecture itself is designed and verified.

This is still a synthesis, not a quoted historical decision.

## 3. Source gap in os-architect

`os-architect` has no commits in the 2026-08-14..25 interval and exposes only `main` in the connected view. Therefore the exact naming/launch decision that turns the August 13 evaluation into the August 25 SOUL repository cannot be recovered from this repository alone.

Do not fill this gap from narrative convenience.

## 4. SOUL bootstrap changes the problem definition

`batuhanozgun/soul` `main` bootstrap on 2026-08-25 states:

- SOUL is rebuilt from first principles;
- it is a general-purpose agentic architecture;
- its target is intended outcome → controlled, verifiable working system;
- development machinery and reusable product are deliberately separate;
- Development OS comes before product architecture.

The `phase0/development-os` branch makes the shift explicit rather than implied.

### Product definition

SOUL's stated job is **system formation**, not executing a preset workflow:

1. understand intended outcome;
2. determine what working system is required;
3. create/organize capabilities;
4. operate toward the outcome;
5. verify progress/correctness;
6. adapt when assumptions fail;
7. preserve continuity/governance/state over time.

This is a generalization above KEEL's software-project operating-discipline scope.

## 5. Why Development OS comes first

WP-000 states the reason directly:

SOUL will require long-running, multi-session architecture work. If that work depends on conversation history, hidden model memory or producer self-certification, the development process will **reproduce the same agentic failure classes SOUL is intended to control**.

Therefore Phase 0 intentionally excludes:

- complete SOUL product architecture,
- implementation technology choice,
- mapping KEEL folders into SOUL,
- runtime code.

The process for making product decisions is controlled before those decisions are made.

## 6. Development OS was tested against its own claims

The first fresh verifier did not rubber-stamp Phase 0.

WP-001 / `VERIFICATION-WP-000-2026-08-25.md` returned overall **FAIL** because:

- mandatory cold-start orders in different authoritative/procedural surfaces were internally incompatible;
- `NEXT_SESSION.md` duplicated the active-work fact and had drifted stale against canonical `STATE.md`.

Nine other criteria passed, but the declared cold-start/single-source criteria failed, so the overall target failed.

This is direct behavioral evidence that fail-visible independent verification was not only manifesto language.

## 7. Direct predecessor → SOUL evidence chain

`development/05_evidence/REASONING-POLICY-SYNTHESIS-2026-08-26.md` explicitly reads and cites predecessor material from:

- KEEL-Work,
- keel-dev,
- installed KEEL instance (`oyun2`),
- os-architect,
- keel-research.

It separates **source-derived principles** from **SOUL-specific synthesis decisions**.

Source-derived principles include external project truth, authority/evidence separation, observation-vs-inference distinction, producer/tool/retrieval non-proof, challenging existing mechanisms/plans, framing/necessity/alternative/falsification checks, owner-vs-technical authority separation, double-cause failure analysis, observable/mechanical controls, proportional reasoning depth and exact-target verification freshness.

SOUL-specific decisions then recompose these into a new Development OS rather than importing predecessor folders/rituals unchanged.

This directly supports:

> SOUL is historically informed by KEEL/os-architect lessons, but its first-principles rebuild is an explicit synthesis step rather than a literal KEEL transplant.

## 8. Working answer: why SOUL Research exists

### Directly supported background

SOUL itself is attempting a much broader problem than KEEL: form and operate the right controlled system for an intended outcome, across tasks/domains, while preserving evidence, authority, continuity, verification and adaptation.

Its own development process is intentionally prevented from deciding that architecture prematurely.

### Best current inference about the separate SOUL Research project

The SOUL Research project appears to exist to provide the **research/evidence layer needed before or alongside those architecture decisions**, so that SOUL is not designed by:

- copying KEEL's software-project-specific mechanisms,
- relying on current-tool affordances,
- repeating one model's framing,
- promoting historical lessons into universal requirements without challenge,
- or closing architecture from intuition before the general failure/capability landscape is understood.

In other words, the likely research objective is not "find features for SOUL." It is closer to:

> reconstruct and test the general problem model for dependable agentic system formation, identify which failure classes/principles truly generalize beyond KEEL, bring in independent external evidence and alternatives, and produce durable research artefacts that can later constrain SOUL architecture work.

**Epistemic status:** strong working inference, not yet a verbatim SOUL Research charter discovered in the source repos.

## 9. What still needs validation

1. Search SOUL Phase 0 work/evidence for an explicit boundary between product-development research and the separate SOUL Research effort.
2. Read only later Phase 0 reasoning/adversarial packages that introduce new failure classes; avoid consuming every branch.
3. Determine whether capability/failure architecture WPs explicitly call for external research artefacts and how they expect them to enter decisions.
4. If a direct SOUL Research charter exists elsewhere, it supersedes this inferred wording.

## Current decision

The transition question is sufficiently mature to have its own note, but not sufficiently closed to declare the SOUL Research purpose final. The next reading should test the **research-to-architecture boundary**, not collect more examples of already-established KEEL mechanisms.
