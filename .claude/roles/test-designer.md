# Test designer: package (installation helper; SB-COR 2.3)

`.claude/agents/test-designer.md` and `CLAUDE.md` bind; this package informs them and never overrides them. A difference between them is a finding for the executor, not a choice for you. The role file's procedure and bans are not repeated here. Every case ID below is a record on `main`; open it when its class bears on your item.

**Methods (what the role file does not spell out)**

1. **Size to the claim.** Size the cases to each claim's triage paragraph, never to the length of the specification or the build's rule list. The cheapest discriminating observation first; another case only where another failure class needs it.
2. **Count the denominator.** A check over a set (files, IDs, paths, `asked:` entries, keys) first asserts the set's expected size, so an empty set or a missing member cannot pass.
3. **Every route to the same effect.** List the routes to the protected effect (tool aliases such as `Agent` and `Task`, workflow scripts, a subagent's own calls, the PermissionRequest event, resumes by message, another interpreter, a revert) and give each a case, or name it under "not covered".
4. **Pin the rule, not only the outcome.** A case that asserts only allow or deny passes for the wrong reason once a broader rule lands in front of it. When a rule is added, re-read the neighbouring cases and pin each one's rule ID.
5. **Where it runs.** Name the point that executes each test at every change it guards (a merge-gate step, a hook) and its trigger set, which includes every input the check reads (a constant in another file, a message it subtracts). Name which copy runs: the merge gate and the guard run the working tree's copy, so a change to either is first enforced at the merge after its own sync.
6. **Over-blocking is a failure.** Every deny rule gets a sound case that must pass, taken from real work where one exists (a task form actually used, a record actually merged, a true revert after `main` moved on).
7. **Measure the property, not a representation.** Compare bytes, not characters; the resulting tree, not the text of a diff (its index line and hunk headers change when `main` moves).
8. **A marker must be able to occur.** Before pinning an observation, check that no merge planned before it removes the state it looks for.
9. **Interface first.** Bind a fixture to what the producer stated: rule IDs, grammars, which copy runs, how a fixture checkout is built. An interface not stated goes back to the producer before you write recipes.
10. **Containment.** A check that can fail inside itself (a timeout, a decode error, a missing file) gets two cases: that call refused as "could not check", and an unrelated call decided exactly as before.
11. **Claims, not mechanics.** Write the claim and the evidence that would refute it; leave copy, order and deadline mechanics to the working order unless the mechanic is the claim.
12. **Synthetic negatives only** (D-020; D-017): planted cases go to the hook or script as input; a live observation is the first natural occurrence.

**Known failure classes, each with its recorded case**

- FC1 Any denial or error accepted as the refusal: N-283 (6).
- FC2 A case passing for the wrong reason: N-279 (1), from L-394.
- FC3 One fault repeated across hand-edited fixture copies: N-283 (sixteen copies).
- FC4 Recipes written against an assumed interface, broken when the build added a rule: N-291; N-302 and N-303's annotations; CHK-C02-090 findings 7 and 12.
- FC5 The counted environment declared for one attribute only: the job's tokens step (N-304 (4)); the interpreter version (L-415, L-422; N-309 (2), (5)).
- FC6 A passive window as an acceptance gate, with almost no power to fail: CHK-C02-085 K2; CHK-C02-115 C4; N-314.
- FC7 Methods bound as conditions, so every detour became a loosening: EV-C02-020 section 5, gap 4; L-404.
- FC8 Test size driven by coverage, not risk: T-W14-FN's 290 cases (L-415); EV-C02-020 section 5, gap 1.
- FC9 Ledger rule 3 read as forbidding a stronger replacement before its result: L-426 departure (6); L-425.
- FC10 A false record copied into a test: CHK-C02-086 C2.
- FC11 Revision loops without a cap: EV-C02-020 section 5, gap 5.
- FC12 No continuity between instances, the same classes found again: EV-C02-020 section 5, gap 6. Add a class here when a check finds a new one.
- FC13 A check stated with no point that runs it at the change, or with a trigger set that misses an input it reads: EV-C02-028 part 8 (PR-A2's size test, found by all five roles) and its round 2.
- FC14 An observation whose marker a planned merge makes impossible: EV-C02-028 part 8 (PR-A2's merge against W-C02-22 point 10's "file absent" marker; answered by sequencing).
- FC15 An exact comparison that a sound case cannot pass: EV-C02-028 round 2 (a revert compared as diff text fails once `main` has moved).

**Examples from this installation**

- **Good:** W-C02-22's point 10. Why it is good: its counted environment is fixed before any run counts; a counting rule drops contaminated runs; a negative control sits on file (A-C7NEG); the red path is decided in advance; and its binding checker broke the real head once per check family, each break turning its own check ID red (CHK-C02-127).
- **Bad:** W-C02-09's 24-hour log count (CHK-C02-085 K2, then CHK-C02-115 C4).
- Why it is bad: a zero showed only that nothing was logged, so the test could hardly fail; its 24 hours came from a tool's reach, not from any consumer's need; and the paths that bore the risk had already been exercised actively (EV-C02-020 section 5, gap 3). An active probe of each path, decided with a checker before its result, was the stronger replacement that ledger rule 3 allows (FC9).

**Tools and limits (beyond the role file)**

- Tests of the mechanisms live under `tools/` or `tests/`, class high in the merge gate; pin a test file's SHA-256 in the acceptance block when its content is the oracle.
- In `tools/test_tool_allowlist.sh`, `t` asserts only the decision and `lt` also the rule ID. A fixture checkout gets a copy of the guard under test, because the guard reads the checkout its own file is in.
- Scratch git work: listed subcommands only, each with `-C <literal path>` (guard rule B11).
