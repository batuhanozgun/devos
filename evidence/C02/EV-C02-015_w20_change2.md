---
id: EV-C02-015
item: "W-C02-20 (change 2, the client path's exception)"
kind: record
title: "The client path's exception to the token stop (rule L5; W-C02-20 point 3): the change, the readings, the runs, the breaks, point 8's run in the clone, point 11's parameters and point 12's envelope"
date: 2026-10-18
main_at: 4630798
produced_by: "a fresh-context producer subagent of the working session (same session; declared, Ek A 5.3), not the test designer of T-W20-3c2 and not change 1's producers"
sources:
  - "plan/work/W-C02-20.md, its acceptance block as at main 4630798 (points 3, 5, 7, 8, 11, 12)."
  - "evidence/C02/EV-C02-003_identity_chain_and_environments.md sections 1.6 and 1.7."
  - "tests/C02/W-C02-20/README.md section 12 and tools/test_token_stop.py's P3c2-* cases, committed first by the test designer at 8985abb."
  - "tools/devos_rpc.py, blob e450b90b557c191b64ac6b19bd785e1dff7b378b, added by 9af14f1 and merged into main by 7a6f3ea (PR #352)."
---

# EV-C02-015 · W-C02-20 change 2: the client path's exception (rule L5)

Nothing here holds a string of either token format or either marker. Every synthetic string the runs used was made at run time by the test program from the shared files and never written to a file.

## 1. The change, line by line

One file: `.claude/hooks/tool_allowlist.py` (67 lines added, 7 removed, against `8985abb`). `.claude/settings.json`, `tools/test_tool_allowlist.sh` and the test designer's files are unchanged: no case needed them.

1. **The docstring's rule families** (point 10's first sentence): L5 is named as L4's one exception, the claim token's format in the arguments of the client script's own call to the live host, with the script's content pinned, and that call's text never repeated.
2. **`RULES["L4"]`'s "What to do instead"** gains one sentence: a claim token goes to `devos_api` only by the client path (rule L5). Its other words are unchanged (point 5's guidance stays).
3. **`RULES["L5"]`**, new: its title, why it exists (the exact form, the guard's tree, the pinned script), where it is written (the working order, EV-C02-003 sections 1.6 and 1.7, W-C02-20 point 3) and what to do instead.
4. **`LEAK_WITHHELD`** adds L5, so the summary in the decision log and in any denial is withheld for every L5 decision, the allow included (README R12). `summary()` says "an L5 decision" rather than "denial" for it; L1, L2 and L4 keep their text.
5. **`token_stop()`** takes `claim_ok`: texts read with the environment token's finder only. Every other text is read with both finders, as before.
6. **`CLIENT_REL`, `CLIENT_SHA256`, `CLIENT_CALL`**, new constants with a comment. `CLIENT_SHA256` is the SHA-256 of `tools/devos_rpc.py` as merged (`30c8cf43…cbbe102`, blob `e450b90b557c`). `CLIENT_CALL` is the one accepted command, matched in full: `python3 -I tools/devos_rpc.py <function>`, the function as the client accepts it (`[a-z_][a-z0-9_]{0,62}`), then either a single-quoted here-string or a here-document whose delimiter is in single or double quotes, and at most one final newline.
7. **`client_args(args, data)`**, new: the span of the call's arguments in the command (the here-string's content, or the here-document's body), or `None`. It is `None` when the command is not a string, when the hook input's `cwd` is missing, not absolute, or not the guard's own tree (`ROOT`, two directories above the hook, by `realpath`), when the command does not match `CLIENT_CALL` in full, when a here-document body holds a line equal to its delimiter (the document would end there and the rest would run as commands), or when `ROOT/tools/devos_rpc.py` cannot be read (missing, a directory, a link loop) or its SHA-256 is not the pinned one.
8. **`decide()`**: for a Bash call, `span = client_args(...)` before the rules. With a span, L4 reads every string of the input with the arguments cut out of the command (both finders), and the arguments with the environment finder only. Without one, L4 runs as before. Then every other rule runs unchanged (G0, B1 to B11, the push rules). If nothing denies, the call is allowed as `L5`, not `B0`. If any rule other than L1, L2 or L4 denies a call that has a span, the denial is returned as `L5` with a detail that names only that rule's ID and title, so that neither the call's text nor a detail built from it is repeated. An L4 denial (the environment format in the arguments, or a claim string elsewhere in the call, or "could not check") keeps its rule.

**In plain words.** A claim-format string may leave in one place only: the input the client script reads, in the client's own call, typed exactly as `python3 -I tools/devos_rpc.py <function> <<< '<json>'` or with a quoted here-document, from the checkout's root, alone in its Bash call, while the script is byte for byte the one merged. Anything else in that call (the command outside the input, the description, any other field) is read by L4 as before. The environment token's format is stopped everywhere, the client's input included. The allowed call is logged as L5 with its text withheld.

## 2. The readings of README 12.1

All followed. None departs from point 3's text.

- **R7 followed.** The client is looked for in the guard's own tree (`ROOT`), as L4 finds the shared files. No absolute path is named.
- **R8 followed.** The two ✔ forms are accepted. A pipe into the client, a second command, an unquoted here-document and a double-quoted here-string are denied, and so are the absolute path, `./` and the call without `-I` (`info-abs`, `-dot`, `-no-I`: observed `deny`). One addition inside R8's "quoted here-document": a delimiter in double quotes (`<<"EOF"`) is accepted as well as single quotes, since bash expands neither. No case turns on it. A probe showed it allowed as L5, with nothing repeated. A `<<-` document is not accepted.
- **R9 followed.** The client's whole content is pinned. This goes further than point 3's third bullet, which names a change of the path or of how the script learns its host: with the pin, any change of the script turns the exception off (the positive controls `BAD`) until a guard change follows it. That is stricter, not wider.
- **R10 followed.** Only the Bash call's `command`, and within it only the client's input. The environment format is denied everywhere.
- **R11 followed.** The rule is `L5`.
- **R12 followed.** L5 is in `LEAK_WITHHELD`. Another rule's denial of a client-path call is also returned as L5 with no text. No case reaches that path. A probe with `dangerouslyDisableSandbox` set gave `deny`, `L5`, detail "rule B10 (the sandbox stays on) denies the client path's call", and no format string in the output or the log.
- **R13 followed.** A client that is missing, a directory or a link loop gives no span, so the call is denied by L4 as a match (not "could not check").
- **R14** is the test's construction. It holds: `env-with-claim` is `BAD` at `8985abb` and `ok` with the change.

## 3. The runs (raw last lines; outputs searched with both finder patterns: no format string in any of them)

All runs were made in the clone `td11`, branch `claude/c02-w20-change2` at `8985abb`, with the change uncommitted, on 2026-10-18.

- **Baseline, the guard at `8985abb` unchanged:** `python3 -I tools/test_token_stop.py`, exit 1, `TOKEN_STOP_TEST FAIL (ok 529, BAD 8, info 29)`. The 8 `BAD` lines are `P3c2-pos-herestring`, `-pos-heredoc`, `-pos-tree` and `-env-with-claim` on both events, as the designer foresaw. `W20-P7-markers` is `ok`: `4630798` removed the markers from CHK-C02-077 before `8985abb`.
- **With the change:** `python3 -I tools/test_token_stop.py`, exit 0, `TOKEN_STOP_TEST PASS (ok 537, BAD 0, info 29)`. Observed for `info`: `info-abs`, `-dot`, `-no-I` deny; `info-file-arg` allow.
- **The whole suite with the change:** `bash tools/test_tool_allowlist.sh`, exit 0, 1518 lines, 1485 `ok`, 0 `BAD`, 31 `info`. Its last lines are `ok   W20-P7-markers …`, `TOKEN_STOP_TEST PASS (ok 537, BAD 0, info 29)` and `ALLOWLIST_TEST PASS`. One `info` line names skipped controls: "branch claude/c02-w20-change2 is not on the remote: branch controls expect a deny, and the devos-x URL and outcome_branch main controls are SKIPPED". The branch is not pushed in this clone, and pushing it is the executor's (section 5).

## 4. The breaks of README 12.4, applied to this build

Each break was a full copy of the clone with one edit of the exception in its guard, and `python3 -I tools/test_token_stop.py` was run alone at the copy's root. Each turned exactly its named cases `BAD`, on both events, and no other line. Each run's last line was `FAIL`. Every count is one `BAD` line lower than the designer's 12.5, because `W20-P7-markers` is now `ok`.

| Break | The edit made | Last line | `BAD` cases (each on both events) |
|---|---|---|---|
| (e1) | the whole command excused once it holds `tools/devos_rpc.py`; `cwd` and content checks kept | `FAIL (ok 477, BAD 60, info 29)` | the 30 of 12.4: `arg-*` (4), every `beside-*` (13), `host-arg`, `-arg-option`, `host-var-*` (3), `look-bak`, `-bash-c`, `-clone-abs`, `-comment`, `-dir`, `-exec`, `-interp`, `-wrapper` |
| (e2) | the content not hashed, a readable file enough | `FAIL (ok 533, BAD 4, info 29)` | `host-tree-const`, `host-tree-url` |
| (e3) | the environment finder skipped on the client's input | `FAIL (ok 531, BAD 6, info 29)` | `env-herestring`, `env-heredoc`, `env-with-claim` |
| (e4) | any path in the client's place (`\S+`), content check kept | `FAIL (ok 523, BAD 14, info 29)` | `script-merge-gate`, `script-guard-report`, `look-bak`, `-sibling`, `-dir`, `-copy-identical`, `-clone-abs` |
| (e5) | any tool any of whose strings holds the client call; all its strings read for the environment format only | `FAIL (ok 529, BAD 8, info 29)` | `tool-gh-comment`, `tool-send-later`, `tool-pn`, `field-description` |
| (e6) | the client's file not read | `FAIL (ok 527, BAD 10, info 29)` | `host-tree-const`, `host-tree-url`, `missing-file`, `-dir`, `-loop` |
| (e7) | every field of a client-path call read for the environment format only | `FAIL (ok 535, BAD 2, info 29)` | `field-description` |
| (e8) | the `cwd` check removed | `FAIL (ok 533, BAD 4, info 29)` | `look-clone-cwd`, `look-clone-identical-cwd` |
| (f) | `span = None` | `FAIL (ok 529, BAD 8, info 29)` | `pos-herestring`, `pos-heredoc`, `pos-tree`, `env-with-claim` |
| (h2) | L5 taken out of `LEAK_WITHHELD` | `FAIL (ok 531, BAD 6, info 29)` | `pos-herestring`, `pos-heredoc`, `pos-tree` |
| (h3) | the allow returned as `B0` | `FAIL (ok 531, BAD 6, info 29)` | `pos-herestring`, `pos-heredoc`, `pos-tree` |

Section 4's (a), the stop removed, was not run on this build. It is change 1's break, and point 13's checker builds every break itself.

## 5. Point 8 (the guard's three properties), as far as the clone shows them

Point 8's run of record is the suite at the commit that will be live, on a pushed branch, after this item's last change of the guard. This change is that last change, so the run must be repeated at the executor's commit. The run in section 3 is at an uncommitted tree, on a branch that is not pushed. It counts as a preview, not as point 8's run. What it shows for the three properties:
- **A tool not on the list is denied:** the T1 cases, `Monitor`'s `W21-x-*` among them, are all `ok`.
- **It never answers "ask":** `ok   no output answered ask`.
- **It denies when it fails or runs past its time limit:** `ok   hook timeouts [600, 600] s, above the call's 400 s budget …`; `onFailure "block"` on both events `ok`; the wrapper's blocks (`wrapper blocks broken guard …`, `wrapper blocks when python3 is missing`) and the PermissionRequest deny on the guard's own exit 2 and on unreadable input are all `ok`.
- No `BAD` line. The one skipped group is the remote-branch controls (section 3), and those run once the branch is pushed.

This change alters the guard after CHK-C02-057's point 8 run at `5de47dc`. So the executor's repeat at this change's commit becomes the run that W-C02-11 point 6's last bullet relies on. It counts while its blobs are the live tree's.

## 6. Point 11's parameters (PC-23)

- **The pin** (R9; README 12.1, 2026-10-17; point 3's third bullet). Every change of `tools/devos_rpc.py` turns the exception off until a guard change follows it. That guard change is class high: a fresh-context checker's verdict and the merge gate, about one review cycle. Until it merges, calls that carry a claim token are denied (they fail closed), and calls that carry none are unaffected. This lands on W-C02-09's critical path only when it changes the client. Ending the wait sooner at the same quality would mean a change of the client and of the pin in one pull request, which the merge gate then judges once. That is the executor's call.
- **The deadline "before N-221 step 5"** (the item's text, 2026-10-12, L-294). Observed: N-221 step 5's own call (`token_role_class < /dev/null`, no format string) is already allowed by the unchanged guard (`P3c2-pos-step5` is `ok` at `8985abb`, rule `B0`). So step 5's self-check does not wait on this change. What waits on it is the first call that carries a claim token (`heartbeat`, `release`). Whether the item's deadline is moved accordingly is the executor's decision, through the item's own text. This record does not change it.

## 7. Point 12's evidence envelope

- **Source commit:** the executor's commit of this change, still to be made. The criterion version is the `main` commit of W-C02-20's acceptance block, as in EV-C02-010.
- **Configuration at `8985abb`** (the base; the guard changes in the commit):
  - `.claude/hooks/tool_allowlist.py` `64e2dd70ea97193846f533d5d046335adfe05933` (before)
  - `.claude/settings.json` `eb0ea8624e56e978897a16755b370885fcc0189d`
  - `tests/C02/W-C02-07/shared/token_format.md` `175c68c75602321c0eff50fb7b698fabb1ea83cb`
  - `tests/C02/W-C02-07/shared/scan_patterns.json` `b548c8cea2c485256a9b4bd8499aa0eb29db3b48`
  - `tools/devos_rpc.py` `e450b90b557c191b64ac6b19bd785e1dff7b378b`
  - `tools/test_tool_allowlist.sh` `bcd0b9936c98952428ca65f2f60d1731a0c0220e`
  - `tools/test_token_stop.py` `d4920da5634f264f5f6ce95afd4a13c3b30c4cb0`
- **Left for the executor:** the guard's blob after the commit, taken with `git rev-parse <commit>:.claude/hooks/tool_allowlist.py`. Every other blob above should be unchanged at that commit, and the executor confirms it with the same command.
- **Input:** the 61 `P3c2-*` shapes of `tools/test_token_stop.py` and the whole suite.
- **Raw output:** the runs of sections 3 and 4 were kept in the producer's scratch directory, not filed. Point 8's run of record at the commit is filed raw by the executor, as in EV-C02-010 F2.
- **Independence level:** a producer's own runs. They are not independent assurance; point 13's checker judges.

## 8. The client path's script and its merge (point 3's record)

The script is `tools/devos_rpc.py`. Commit `9af14f1` added it, and `7a6f3ea` (PR #352) merged it into `main`: `9af14f1` is an ancestor of `7a6f3ea` and not of its first parent. This change is based on `8985abb`, which descends from `7a6f3ea`, so it merges after the script.

## 9. What this change does not cover (residuals, beside README 12.6)

- **The hook input's `cwd`.** The guard reads it as the shell's directory, as its other rules do. If the two differed, the relative path would run another file.
- **`python3` is not resolved by the guard.** An interpreter earlier on the process's `PATH` is outside the call's text. A `PATH` set in the call does not match the form.
- **Time of check against time of use** (12.6): the pin is read at the decision, not at the run.
- **The string in the session's own transcript:** the client path is typed into the call by design (EV-C02-003 section 1.7: a session holds its own claim tokens). The platform's readers are the block's "Not covered" (c).

## 10. Point 10: the texts this change makes incomplete (for the executor's plan change)

The guard's docstring names L5. Working order section 10 (its rule list and "What it does") names L4 and not its exception, so it becomes incomplete. It changes through plan Section 14 with a `PC-<nn>` record. That is the executor's, and this producer does not write it. Plan 6.7's network row (P:734) is unaffected by the exception.
