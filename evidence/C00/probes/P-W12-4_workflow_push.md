# P-W12-4: can this environment push a GitHub Actions workflow? (pre-registration)

**Item:** W-C00-12, tranche 1a (`plan/builder/w-c00-12/12_tranche_plan.md` §2.1). **Written:** 2026-10-03, before any attempt; the time is in the commit. **Producer:** run `session_01XUsVQowRbLJdC1E8gFvxZq`. **Runs:** only after the narrow re-review R-W12-2 passes.

**Why.** The independent detector (C-R8) and the main-definition record check (C-R9) are workflow files under `.github/workflows/`. GitHub refuses a push that adds or changes a workflow file unless the pushing credential has the `workflow` scope. The scope of this environment's git credential is unknown (OI-005). If the push is refused, both workflows become one account action for Batu, sent in his batch.

**Set-up.** A probe branch `claude/probe-w12-workflow`, cut from `main`, adds only `.github/workflows/probe-noop.yml`: a workflow with a single `workflow_dispatch` trigger and one step that runs `echo probe`. It has no schedule and no secrets. Pushing to a non-default branch does not make a scheduled workflow run. The branch is never merged, and it is recorded as abandoned after the probe.

**Questions and PASS conditions:**

| ID | Question | PASS only if | If FAIL |
|---|---|---|---|
| P-W12-4a | Is a push that adds a workflow file accepted? | `git push` exits 0 and `git ls-remote origin claude/probe-w12-workflow` shows the pushed SHA | The push error text is recorded verbatim. It is **not** retried by another route (R-R21): no GitHub contents API, no MCP file write. C-R8 and C-R9 go to Batu as one account action |
| P-W12-4b | Does GitHub register the workflow? | The repository's workflow list (REST `GET /repos/batuhanozgun/devos/actions/workflows`, read through the proxy) names `probe-noop.yml` on that branch, or states that workflows on non-default branches are listed only after a run. Either way, the answer is recorded as observed | The answer is recorded as observed; it does not block C-R8, which runs from `main` |

**Not tested here:** that a scheduled workflow fires on time. That is T-C6 and T-C7 in 1d, by `workflow_dispatch` against a scratch state.
