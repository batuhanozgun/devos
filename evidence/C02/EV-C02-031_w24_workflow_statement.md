---
id: EV-C02-031
title: "W-C02-24: the producer's statement on part 10.2's open line (Workflow stays in ALLOWED_NON_MCP), for CHK-C02-131 C1"
stage: C02
kind: observation
source: "producer a780f294ca31e5c6d (reader task), its final message taken with tools/subagent_audit.py last after its end status, DISCIPLINES OK"
---

# EV-C02-031 · W-C02-24: the method statement the approach left open

Filed by the executor (L-450). CHK-C02-131's C1 (a defect blocking the merge) found that A2 pinned "Workflow stays in ALLOWED_NON_MCP" without the statement that part 10.2's `open:` line requires from its owner, the producer, before the condition is pinned. A reader-form producer task asked that question; its answer is below, verbatim. A2 now cites it (`plan/work/W-C02-24.md`, A2's second bullet). The statement agrees with the pin, so no test line changes.

## The producer's final message

Package: none delivered (file absent)
Nonce: none delivered
Take-up: PROCEED. The task asks for the one method statement the approach's `open:` line leaves to the producer. A2 needs that statement before CHK-C02-131's C1 can close, and I can settle it by reading the guard's code paths and the test at `a3c208c`. No write is needed.

## Disciplines (D1–D9)
D1: yes: I weighed three options (stay, so TW decides; leave, so T1 decides; leave and add a check ahead of T1) against the rule ID, the reason text, the tests and how a denied caller recovers, and only "stay" meets clause (2) without adding a new mechanism.
D2: yes: the test designer had already pinned "stays", so I tested the reverse and argued the strongest case for "leaves" (a list called "allowed" that holds a tool always denied); my answer rests on the code path, not on the pin.
D3: uncertain: I could not see the Claude Code version (2.1.304), because `claude --version` was denied by B7; I limited the claim to what does not depend on the client: both matchers are `.*`, and PreToolUse and PermissionRequest both go through `decide()`.
D4: no
D5: yes: the item file was too long to show in one output and I cut its lines at 3,000 characters, so I went back to the `open:` line, clause (2), dispositions (2), A2 and A6 directly and saw each of them whole.
D6: no
D7: no
D8: yes: I checked that the guard on `main` (290b9e5) is byte-identical to the one at `a3c208c` (the `git diff --stat` output is empty), so code read at `main` holds for the item's head.
D9: no

Read, and what each changed:
- `plan/work/W-C02-24.md` at `a3c208c` (A2 lines 45 to 50, A5, A6, the approach block and its `open:` line): this defines the question. Clause (2) asks for "one reason of its own, which names the Agent route", and disposition (2) says the denial cost is "small since the denial names the route". Both justified the answer.
- `tools/test_tool_allowlist.sh` at `a3c208c`:
  - lines 20 to 40: the matcher control.
  - lines 87 to 97: the `t` and `lt` helpers. `lt` takes the rule ID out of the reason text the caller sees.
  - lines 173 to 187: the TW comment and cases.
  - lines 1150 to 1180: `W21_LIST`, W21-ok-list and W21-ok-listed.
  These justified the answer and showed what each option costs in tests.
- `.claude/hooks/tool_allowlist.py` at `main`: `ALLOWED_NON_MCP` and `LOCAL_TOOLS` (lines 100 to 127), `RULES` T1 to T4 (lines 216 to 232), `decide()` (lines 2160 to 2250), and how `main()` routes the two events. These justified the answer.
- `git grep` at `a3c208c` for every use of `ALLOWED_NON_MCP` and `LOCAL_TOOLS`, which also hit `tests/C02/W-C02-21/README.md` R4. That limited the cost of "leaves".
- `.claude/settings.json`: both hook matchers are `.*`. This justified the liveness point.
- `plan/Ek_D_Dusunme_Protokolleri.md`: section 2 item 3, plus D1 to D8 in section 3.
- Not read: the library (the task's library line is none), EV-C02-028 (the task quotes what bears on this), and CHK-C02-131 (not filed yet).

Relied on:
- `decide()` checks USER_TOOLS, then `if name not in ALLOWED_NON_MCP: raise Bad("T1", ...)` at lines 2193 to 2194. Only then does it reach the per-tool branches, including the Workflow branch at 2209. (observed)
- T1's "what to do instead" says only "Use an allowed tool. A new tool is added only by a reviewed change to this file." It does not name the Agent route (line 220 onward). (observed)
- A denial carries exactly one rule ID and one `RULES` entry: the `Bad` that was raised. So "denied by T1, with TW then naming why" cannot happen unless a Workflow check runs before line 2193. (observed in the code; the conclusion is inferred)
- `Workflow` is also in `LOCAL_TOOLS` (line 123), so L4 skips it. `LOCAL_TOOLS` is only read inside `name in ALLOWED_NON_MCP` (line 2177). (observed)
- Both events go through the same `decide()` (`main()`, lines 2308 to 2332). (observed)
- Both hook matchers are `.*`, so the guard sees every Workflow call whichever option is chosen. (observed in `.claude/settings.json`)
- `lt` reads the decision and the rule ID from the reason text the caller gets (test lines 92 to 97). So the ten `lt deny TW` cases (lines 178 to 187) fail if T1 decides the call. (observed)
- W21-ok-list needs `len(want) == 28` and `rest == want`, and `W21_LIST` (lines 1152 to 1154) holds `Workflow`. W21-ok-listed (lines 1172 to 1180) passes any listed name whose empty-input call is allowed, or denied by a rule other than T1. A TW denial meets that. (observed)
- The approach cites `W21_LIST` at lines 856 to 858 of base `b547565`. At `a3c208c` it is at lines 1152 to 1154. Same block, shifted lines. (observed)

Unsure:
- Claude Code 2.1.304: I could not see it (B7 denied `claude --version`). The statement only needs the client to deliver Workflow calls to the hook with `tool_name` "Workflow". The existing Workflow cases assume this equally for both options, but no client trace was observed. A Workflow call seen in the guard's decision log on a 2.1.304 session would settle it.

For:
- The executor files the statement in the item's record and has A2's second bullet (line 47) cite it.
- The fresh checker of CHK-C02-131 C1 judges whether the statement and A2 agree.
- M1a's producer builds the TW branch to it.

Received from / Returned to:
- None received or returned.
- Outside my scope, for M1a's producer through the executor, as a proposal only: a short comment at the `"Workflow"` entry of `ALLOWED_NON_MCP` saying it stays listed so that TW, not T1, decides it. Otherwise the list reads as if Workflow were allowed.
- Also for the executor: the approach's line numbers for `W21_LIST` (856 to 858) are stale at `a3c208c` (1152 to 1154). That is a reference fix, not a defect in the product.

Product:
- **Statement:** Workflow: stays in ALLOWED_NON_MCP

  Reason:
  1. **The reason text a denied caller sees.** Clause (2) needs a reason of Workflow's own that names the Agent route. Disposition (2) counts on that text to keep the cost of each denied plan small (ultracode plans a workflow, meets the denial and switches to Agent in one step). If Workflow left the list, line 2194 would deny it under T1, whose text only says "Use an allowed tool". The TW rule ID and the Agent-route text would be lost, because a denial carries only the one rule that raised it. Keeping TW after leaving would need a new Workflow check placed before line 2193. That is the same branch moved to a special place, with a list that no longer says which tools reach the per-tool rules. It adds a mechanism and gains nothing.
  2. **The guard's code paths.** If it stays, M1a replaces the parser branch at lines 2209 to 2231 with one `raise Bad("TW", ...)` at the same spot. That spot comes after the NUL check (G0), the MCP checks, USER_TOOLS and T1. L4 stays skipped (Workflow is in `LOCAL_TOOLS`, and its input does not leave the session). One branch covers PreToolUse and PermissionRequest, since both go through `decide()`. Taking it back in later (disposition 2's reopening) changes that one branch and nothing else. Leaving would also mean taking `Workflow` off `LOCAL_TOOLS`, or keeping a stale entry there.
  3. **What the test assumes at `a3c208c`.** Lines 173 to 177 state "stays" in a comment. The ten TW cases (lines 178 to 187) use `lt`, which checks the rule ID in the reason text, and all of them would fail under T1. `W21_LIST` (lines 1152 to 1154) and W21-ok-list (28 names, exact equality) pass unchanged. W21-ok-listed passes, because Workflow's empty-input call is denied by TW, not T1. The matcher control at line 28 is untouched. "Leaves" would mean rewriting all ten TW cases or adding the pre-T1 branch, removing `Workflow` from `W21_LIST`, changing 28 to 27 and the "none is added at main 3262699" label, and changing `tests/C02/W-C02-21/README.md` R4.
  4. **Liveness.** No difference in whether the call is seen or how fast it is decided: both matchers are `.*` and both options deny at once, with no wait or hang. The difference is in recovery, and that favours TW (point 1).

  A2 as pinned (line 47) already matches this statement and needs no test-line change. It only needs to cite the statement instead of saying the producer had not stated it.
- **Files:** none written or deleted.
- **Tests:** none run; the task names none. Read-only commands:
  - `git show a3c208c:<path>`, exit 0.
  - `git diff --stat main a3c208c -- .claude/hooks/tool_allowlist.py`: empty output, so the guard is identical.
  - `python3 -c` reading the two hook matchers: printed `.*` and `.*`.
- **Where it ran:** in this session's working tree, `/home/user/devos` (branch `claude/gifted-lovelace-4kx0y9`, `main` at 290b9e5). The `python3` that read the matchers is Python 3.13.16. The test script at `a3c208c` was copied to `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/t.sh` for reading only; it was not run.

Guard denials:
- One, rule B7 (no command lines that carry account credentials), decision log #1612. It denied `claude --version`. I did not look for the version another way: I re-ran only the two other commands and recorded the version as unverified under Unsure. I did not run `tools/guard_report.py`, because this task allows no writes; the executor can record it.
