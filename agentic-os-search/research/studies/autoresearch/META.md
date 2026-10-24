# autoresearch — Candidate Study Metadata

- **Study ID / title:** `autoresearch` — Karpathy autoresearch
- **Study type:** `external-target`
- **Status:** **PLANNED / RESEARCH NOT STARTED**. Preliminary qualification/intake only; no full source ledger, runtime campaign, independent evaluation, causal validation or SOUL/Development OS adoption assessment has been completed.
- **Research object:** `karpathy/autoresearch`, a small repository that places an AI coding agent in a bounded autonomous experiment loop around an LLM training setup.
- **Canonical external target:** https://github.com/karpathy/autoresearch
- **Observed branch/ref:** upstream default branch `master`; observed HEAD `228791fb499afffb54b46200aca536f79142f117`.
- **Observation date:** 2026-09-29.
- **Package entrypoint:** this `META.md`.

## Primary question / purpose

Investigate what can and cannot be learned from the repository's bounded empirical improvement loop:

`propose → mutate → execute → measure → retain/revert → repeat`

The main project-facing question is:

> Under what conditions can an agent-run experiment loop produce trustworthy improvement of a system or working method, and under what conditions does it instead produce local optimization, evaluator overfitting, metric gaming, invalid comparison or false confidence? Which parts, if any, transfer to Development OS or SOUL, and with what authority, verification, resource and stopping boundaries?

The research must keep at least three objects separate:

1. improvement of the mutable target artefact;
2. quality/reliability of the search or experiment process;
3. transfer of any discovered mechanism to broader SOUL / Development OS work.

A positive result in one does not establish the others.

## Preliminary qualification signals — not study findings

The initial intake observed a deliberately narrow arrangement in the upstream repository:

- `train.py` is the main agent-mutable surface;
- `prepare.py` contains fixed data/evaluation/runtime constants and is outside the agent's permitted mutation surface;
- experiments use a fixed five-minute training budget and a primary `val_bpb` metric;
- the first run establishes a baseline;
- candidate changes are committed, executed, logged and retained or reverted according to measured outcome;
- `program.md` instructs the agent to continue the experiment loop autonomously until interrupted.

These observations qualify the target for research; they are not yet a verified account of the repository's full behavior, historical runs, efficacy, generality or safety.

## Potential Foundation relevance

Provisional many-to-many retrieval hints only; not Foundation taxonomy membership or structural adoption.

- **Work — strong candidate:** experiment lifecycle, candidate variation, baseline, acceptance/rejection, rollback, iteration, stopping and exploration-versus-exploitation.
- **Information — strong candidate:** experiment history, provenance, metric/evidence identity, result logging, baseline comparison, rejected-result retention and evaluator exposure.
- **Actors — strong/conditional:** proposer/executor/evaluator roles; capability versus authority; human-controlled research-program instructions versus agent-controlled target mutations.
- **Environment — strong/conditional:** bounded mutable surface, immutable/fixed evaluation surface, compute/time budget, sandbox/runtime constraints and platform dependence.
- **Relations / control — strong candidate:** proposal → execution → observation → standing; accept/reject transitions; version binding; evaluator integrity; rollback and branch lineage.

## Potential Development OS relevance

Candidate mechanism/reference for:

- controlled improvement of harnesses, context assembly, decomposition, retrieval, verification, routing or other bounded development methods;
- explicit separation of mutable method surfaces from evaluator/acceptance surfaces;
- baseline-bound experimentation and versioned evidence;
- reversible experimental change with retained negative evidence;
- bounded autonomous experimentation under resource, authority and stop constraints.

The study must not assume that Development OS should use greedy keep/revert hill-climbing, one scalar objective, indefinite autonomous execution or self-modification. Those are research questions and possible falsifiers.

## Potential SOUL relevance

Candidate input for **bounded adaptation**, not a general SOUL reasoning architecture.

Potential questions include:

- when a task/project-specific procedure is stable and measurable enough for empirical adaptation;
- how a SOUL instance could compare strategy variants without confusing proxy improvement with real goal achievement;
- how holdout validation, independent verification, multi-objective standing and real-world effects should constrain self-improvement claims;
- how learning from failed or near-miss variants should differ from immediate greedy discard;
- which changes may be proposed or tested by an agent versus which require external acceptance authority.

No claim is made that a scalar optimization loop is suitable for open-ended reasoning, research quality, goal discovery or general decision quality.

## Reuse modes

Potential future reuse as:

- candidate mechanism / pattern;
- implementation-learning reference;
- experiment-design input;
- benchmark/test-case source;
- verification and evaluator-integrity pressure test;
- falsifier/counterexample for simplistic self-improvement claims;
- design pressure for authority, rollback, resource-budget and stopping semantics.

## Candidate research seams

A future full study should distinguish and test at least:

1. **Mutation boundary:** what exactly the agent can change and what it cannot.
2. **Evaluation boundary:** whether the evaluator is merely immutable or also sufficiently valid, independent and hard to game.
3. **Adaptive overfitting:** repeated use of the same validation signal and the need for development/selection/holdout separation.
4. **Search policy:** greedy keep/revert versus portfolios, branches, stepping stones, recombination and Pareto/multi-objective retention.
5. **Experiment identity:** binding hypothesis, code state, environment, run, metric and decision.
6. **Negative evidence:** how crashes, regressions and discarded ideas remain reusable rather than disappearing.
7. **Resource accounting:** fixed wall-clock budget versus total compute, memory, proposer effort and external cost.
8. **Autonomy boundary:** indefinite loop instructions versus bounded autonomy, stop criteria, risk budgets and external effects.
9. **Transfer:** which lessons survive outside LLM training and which rely on the unusually clean scalar objective and sandbox.
10. **Research-org layer:** the distinction between human-edited `program.md` and agent-edited target code, including whether/how the research procedure itself can be evaluated.

## Related studies

- `the-carbon-layer/videos/mQfTdNVCOB0-harness-engineering` — especially Meta-Harness evidence-driven harness evolution and experiment-family audits. This is the nearest existing study; autoresearch should be compared with it rather than treated as discovery of an entirely new problem class.
- `gstack` — qualification, verification, self-development and standing boundaries.
- `context-memory-harness-engineering` — broader harness/context/memory boundaries.
- `multi-agent-patterns` — relevant only if future research expands from the current single-agent baseline to multi-actor experiment organizations.

## Epistemic / authority boundary

This package is a **candidate study registration**.

It does not establish that:

- autoresearch reliably produces better models or methods;
- its evaluator is resistant to gaming or adaptive overfitting;
- its search process is efficient or repeatable;
- its mechanism transfers to open-ended software work, research or SOUL;
- the repository should be adopted, forked or integrated;
- any observed mechanism is a Foundation primitive or architecture decision;
- Development OS or SOUL should self-modify autonomously.

Current architecture/design/implementation authority remains outside this study.

## Freshness / revalidation requirement

Before load-bearing reuse, revalidate at least:

- current upstream HEAD and file layout;
- `README.md`, `program.md`, `prepare.py`, `train.py` contracts;
- mutable versus fixed surfaces;
- metric/time-budget semantics;
- current platform/runtime assumptions;
- any new evaluation, branching, multi-agent or research-org mechanisms added upstream.

Historical experiment claims, external posts/forks and efficacy claims require their own source recovery; current repository state does not retroactively verify them.

## Next authorised research step

When this study is explicitly activated, begin with a pinned source inventory and source ledger for the observed upstream ref, then recover the exact experiment/evaluation/control loop before making project-facing transfer claims. Compare selectively with the existing Meta-Harness/harness-evolution study after the native autoresearch mechanism is understood in its own terms.

No research campaign or implementation is authorised merely by this registration.
