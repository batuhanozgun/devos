# EV-C01-016 · W-C01-37: row 9, hooks and the check before writing in a session with one repository (PC-21 item 5)

**What this is.** The record W-C01-37 asks for, judged point by point against its acceptance block. PC-21 item 5 takes row 9 this way: the documentation on where a repository's hooks and permission rules load is read with its date, and its several-repository case is taken as the design (one repository per session); the routine's session records whether the repository's hooks are active in it; the guard's fail-closed properties are DevOS's own tests (W-C01-38), not this item. The record also answers plan 6.7's mark at plan line 729, which the C01 coverage table maps to row 9 (`plan/work/C01.md`:139, through the replacement rule at :91), and disposes of N-048 and of N-063's P4 and U2. Run records are cited as `<run>/<file>:<line>` under `evidence/C01/routine/runs/R1a-20261011T0808Z/` or `evidence/C01/routine/runs/R1b-20261011T0913Z/`; EV-C01-007 (its opening paragraph) shows these copies byte-identical to the run branches.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | R1a read `main` `5d0cc58a9bff5a88087bee3c509a851628e642e0` and R1b read `main` `fdaf4e50c360994ea2cb8be3a4ade92fa0a0035c` (their stamps; EV-C01-007). The configuration that decides the hooks is the same blob at both and at this record's base `main` `f957519e4afc5fc11241f7ea1b7b2dd350503527`: `.claude/settings.json` `ce7d09dd9f55d427969398d01d30064f638971cb`, `.claude/hooks/tool_allowlist.py` `35c23f7421783ddfe892b01bc0a3d9c5720f74f9` (last changed in `1764100`, 2026-10-06) |
| Deployment configuration | The routine `devos-c01-rutin` in the cloud environment `devos-kurulum`, with the one repository `batuhanozgun/devos` and every connector removed (EV-C01-005; EV-C01-006). Sessions: R1a `session_01P5d7WNny3Jpuabt2A2V3Bm`, R1b `cse_014hehG4ta6ADXdHPSDCSTs1`. Mode "auto" by each session's context (R1a/OPENING.md:18; R1b/OPENING.md:18). Claude Code version: could not check (`not visible` in both runs; EV-C01-007, "What the record cannot show", which gives the cause and what stands in for it); so this result is tied to the run date, 2026-10-11, and to `devos-kurulum`, not to a version. The documentation read describes Anthropic-hosted cloud environments |
| Criterion version | W-C01-37's acceptance block, `plan/work/W-C01-37.md` blob `d7824a083218cb607779983a14d86a6a6ec4eb23`, the same at `5d0cc58`, `fdaf4e5` and `f957519`; the file was last changed by the C01 re-plan (W-C01-31: `44cef4e`, `94caefb`, `24e484f`; L-182). Read with plan C01 row 9 (plan line 952) and the PC-21 note, items 5 and 9 (lines 968, 972). The routine part's success and failure were fixed before any run in `evidence/C01/routine/ROUTINE_DESIGN.md`:104 at `f957519` |
| Input | The stored prompt and `CONTROL.md` versions 1 (R1a) and 2 (R1b), opening record part A item 1 and the closing record's push table (ROUTINE_DESIGN.md section 7). The documentation pages listed under "Facts taken from the documentation" |
| Actual observation | The two runs' records (point 2); the documentation, fetched by this producer on 2026-10-11 at 12:47Z (point 1); the guard's code at `f957519` (point 2); one same-session reading of the working session's container (point 2) |
| Raw evidence ID | Branch `claude/probe-c01-r1a-20261011T0808Z`, head `67fcd98a8ec84f3a2269f4227cca6cdbbbc9b251`; branch `claude/probe-c01-r1b-20261011T0913Z`, head `568cf6a1bf5ad96002bf41d0423ddd6edda7217f` (both confirmed by `git ls-remote` on 2026-10-11); copies under `evidence/C01/routine/runs/`. The pages, fetched as markdown with HTTP 200, by SHA-256 of the fetched bytes: cloud-environments `8a249b9094768984a50cd4d13bdac75ddf96bc719ad43f3f2cb02a2b44cb1a7d`; settings `a8cc395af5e0938659ddfd38a703bdc8a5151640216c5230098408e30625e380`; hooks `3a1f944503d05a61fdc0fac62add9ba3d877ccb03dd4ef9c3c79881c973938ef`; routines `9cfb8c114e4563ea7b5022bd054568e044e3126f63692b243d5e12d8b3b70c75` (not kept in `devos`) |
| Independence level | What each run records of itself: self-observation (D-017 item 2(a)), dated 2026-10-11. The documentation and the code: read by a producer, a fresh-context subagent of the working session. Judged by a fresh-context checker (declared, Ek A 5.3) |

## How the criterion is read

PC-21's note governs where it and row 9 differ (plan line 963). Item 5 (line 968) takes the several-repository case as the design, asks the routine's session to record whether the repository's hooks are active, and leaves the guard's fail-closed properties to DevOS's own tests (W-C01-38). The block adds the check before writing to the public repository. For the routine, success and failure were fixed before the runs (ROUTINE_DESIGN.md:104 at `f957519`): "the repository's hooks are active in the routine's session, and the check before writing to the public repository ran on the run's own push (the push counted under the rule that carries the leak check, working order section 10). Failure: no decision log, or the push not counted." The leak check is rule L1 (`plan/Installation_Working_Order.md`:138; `.claude/hooks/tool_allowlist.py`:2000-2002, where an allowed push returns rule L1).

## Point 1 (✔). The documentation, read with its date; DevOS's one-repository rule

Met.

- **Where a repository's hooks and permission rules load.** Read 2026-10-11 from the Claude Code documentation (no page shows a last-updated date):
  - cloud-environments, "What carries over from your setup": "Cloud sessions start from a fresh clone of your repository." The table row "Your repo's `.claude/settings.json` hooks and permission rules" reads "Yes, in a session with one repository", with the reason "Part of the clone".
  - settings, "Settings in cloud sessions": shared project settings are "read in a session with one repository, because the file is part of the clone and the session starts inside it". In an Anthropic-hosted environment, "a session with several repositories starts above the clones and reads only the `enabledPlugins` and `extraKnownMarketplaces` keys from each repository's `.claude/settings.json`, not permission rules, hooks, `env`, or other keys". User and local settings files are "not read".
  - cloud-environments, "Setup scripts vs. SessionStart hooks": in an Anthropic-hosted environment, "Claude Code runs hooks from the repository and from your organization's server-managed settings". Under "Limitations in cloud sessions": "a session with several repositories doesn't load hooks from any repository's `.claude/settings.json`".
  - hooks: "Claude Code fires the same hook events wherever it runs", cloud sessions included.
  - routines: routines "run autonomously as full Claude Code cloud sessions: there is no permission-mode picker"; "Routines are in research preview."
  - Each is recorded in PC-21 item 9's form under "Facts taken from the documentation" below. The same facts were read on 2026-10-10 (ROUTINE_DESIGN.md:39, F10) and earlier on 2026-10-11 (EV-C01-004:130, settings page); this reading agrees with both.
- **DevOS's rule.** DevOS's sessions attach one repository each (plan line 968, row 9's fail path taken as the design). It is recorded in N-134 item (2) on `plan/work/C05.md`:62 and N-135 item (2) on `plan/work/C06.md`:69 ("DevOS's routines attach one repository each"). N-138 (`plan/work/C05.md`:67) has the exam routine attach `devos` only. N-139 (`plan/work/C06.md`:74) gives every routine `devos` only. The notes say "routines" where PC-21 says "sessions". In phase B, DevOS's own sessions are started by its routines (plan 6.4; EV-C00-012 P2). A session Batu opens from the app is covered by plan 6.7's row at line 729 (below).

## Point 2 (✔). The routine's sessions: hooks active, and the check before writing

Met, on both runs. The check ran in its store-less form: service names only (below).

- **Hooks active.**
  - R1a: "This session's decision log exists (`session_01P5d7WNny3Jpuabt2A2V3Bm.jsonl`); hash chain intact." Its allowed calls are counted by rule, "0 passed to the user", and it has denials (R1a/OPENING.md:7-13). It denied three calls: #8 (B8), #16 (L1) and #28 (B5) (R1a/CLOSING.md:53-59).
  - R1b: the same for `session_014hehG4ta6ADXdHPSDCSTs1.jsonl`, "hash chain intact", "0 passed to the user" (R1b/OPENING.md:7-13). It denied #19 (B5), #22 (B7), and #58 and #79 (B7), which were made inside its two subagents (R1b/CLOSING.md:58-63; R1b/ROW4.md:14, 24). The guard's rule T2 counted the Agent calls themselves, 8 for the 8 made (R1b/ROW4.md:43).
  - So the PreToolUse hook decided the session's own calls, its subagents' calls and the Agent tool's calls, with no prompt. The configured hooks are the four of `.claude/settings.json` (R1a/OPENING.md:41; R1b/OPENING.md:41).
- **The check before writing ran on the runs' own pushes.**
  - R1a: before its closing push, "`L1 6` allowed and one L1 denial". The six are the stamp, opening record, queue, Q1, Q2 and hand-over; the platform accepted each (R1a/CLOSING.md:26-36).
  - R1a's denial #16 shows the check running and failing closed. On the first stamp push, "the leak check could not derive the service names because the starting checkout was shallow and lacked revision `3cd686a`; it failed closed" (R1a/OPENING.md:10; R1a/CLOSING.md:30). The run completed the checkout's history and the push then passed (R1a/CLOSING.md:39; EV-C01-005:41).
  - R1b: "the report at 09:19:41Z counts L1 9 for the nine pushes above ... No push was denied" (R1b/CLOSING.md:44).
  - Each run's last push, its closing record, is not counted in its own record.
- **The form the check ran in: service names only.** The code and the records show it; the runs' records do not print the check's detail, so this is an inference from them, not a run's own observation.
  - The code (`.claude/hooks/tool_allowlist.py` at `f957519`):
    - `leak_state()` returns None when neither a library clone (at the one place, `/home/user/agentic-os-search`, line 76) nor a fingerprint store (line 77) exists (lines 1638-1640).
    - `fingerprint_hits` then returns 0 (lines 1693-1695), so only the service names are compared (lines 1742, 1717-1720).
    - An allowed push's detail then reads "(no library clone and no store: service names only)" (lines 1883-1884).
    - The working order states the same rule: "with neither, only the service names are checked" (`plan/Installation_Working_Order.md`:138).
  - No clone: R1a counted 0 git checkouts beside its starting checkout (R1a/OPENING.md:15), which covers that one place. R1b's count was denied (#19), but its own context scopes its GitHub access to `batuhanozgun/devos` alone (R1b/OPENING.md:15). Neither run records an attach, a clone or a store build.
  - No store: only `tools/leak_fingerprints.py build` writes the store, from the clone (working order:138). Each run started on a freshly booted machine with a fresh clone (EV-C01-007 point 2).
    - The working session's container lies in the same environment (EV-C01-007, "What the record cannot show", on the version). Read by this producer on 2026-10-11 at about 12:48Z, `/home/user` there holds only `devos`: no clone and no store.
    - So the environment does not supply a store. This is a same-session reading.
  - So the runs' pushes were compared with the service names only, and the fingerprint layer had nothing to compare with. EV-C01-005:41 says the pushes "passed the full check". That holds for the service-name part, which the shallow checkout had first prevented. It does not hold for the fingerprint layer.
- **The fail path does not apply.** Two readings were weighed (D1):
  - (a) The check ran in the form the working order gives a session without the library. The success definition fixed before the runs is met.
  - (b) "The check" means the comparison with the library's fingerprints, and under plan Section 8 item 14 a missing store is "could not check".
  - Under both readings row 9's result for the routine is the same. The routine's sessions had no route to the library's content that the fingerprint layer covers: no clone, and the GitHub proxy serves API requests only for attached repositories (documented, below; not independently tested). The service-name layer ran and failed closed when its own input was missing (#16). So no residual reaches Batu from row 9.
  - Reading (b) matters for phase B. There, sessions reach the library only by search, without a clone (plan line 865). And plan C03 test 6 and Appendix C N06 require that with the store absent the write is stopped as "could not check". Note N-171 on `plan/work/C03.md` carries this to the stage that writes test 6.
- **Limits.**
  - Self-observation only (D-017 item 2(a)): a run's guard report is its own record.
  - Of the four hooks, PreToolUse is shown deciding. PermissionRequest runs the same script, and "0 passed to the user" is consistent with it, but no call is attributed to it. PostToolUse (session-tool creation) and SessionStart (`compact`) had no matching event. All four load from the same file, which the documentation makes the unit of loading.
  - The GitHub-write route of L1 was not exercised: neither run called a GitHub tool (R1b/CLOSING.md:52).
  - Permission rules: the repository's only permission key is `"defaultMode": "acceptEdits"` (`.claude/settings.json`:8-10). Both runs report auto mode, and the routines page says routines have no permission-mode picker. Whether that key was read is not shown. The block does not ask it; DevOS's permission layer is its hooks. The mode itself is row 18's and N-047's matter.

## Point 3 (✔). The notes this item serves

| Note | Disposition | Reason |
|---|---|---|
| N-048 (`plan/work/C01.md`) | Met; closed with a dated paragraph on the note | Its premise is now documented (point 1): hooks and permission rules do not load in a session with several repositories. DevOS takes that as its design (PC-21 item 5; N-134, N-135, N-138, N-139). The relaying session's counter-observation does not contradict it. That session (`devos`, with the library added later) still ran the hook. It started inside its one clone, and the documentation does not say what a repository attached later does. The installation's working session also kept running the guard after it attached the library mid-session (`plan/ledger/C00-log.md`:1571; guard records #4041 and #4046). That part rests on self-observation only. The guard allows `add_repo` only for `devos` and the library read-only (`.claude/hooks/tool_allowlist.py`:1450-1456). It creates sessions only from a revision that carries `.claude/settings.json` (lines 1446-1448) |
| N-063, row P4 | Carried with a named place: W-C01-27, which decides N-063's rows. Its application: N-138 (`plan/work/C05.md`) and N-139 (`plan/work/C06.md`) | P4's open point ("which repositories the exam and audit sessions attach"; EV-C00-012:149, :284) is answered by design, not by a trial. Hooks do not load in a session with several repositories, so the exam and audit routines attach `devos` only, and exam material lives in the database (N-138). A dated line on N-063 records this |
| N-063, row U2 | Carried with a named place: W-C01-27 | Row 9 observed part of U2 (EV-C00-012:166, :301) in routine sessions. PreToolUse allows and denies with no prompt, on the session's own calls, its subagents' calls and the Agent tool's calls (point 2). Not observed by row 9: SessionStart at resume or compaction (EV-C01-007 point 4), Stop blocking (no Stop hook is configured), UserPromptSubmit, the platform's treatment of a hook error, and the session ID in the hook input. The guard's own failure is W-C01-38's. A dated line on N-063 records this |
| N-134 (`plan/work/C05.md`), N-135 (`plan/work/C06.md`) | Carried with a named place: the notes themselves, unchanged | Their item (2) is DevOS's one-repository rule. This record adds its documentation basis, dated 2026-10-11. Both stay open for the stages that create the routines |

## Plan line 729's mark

Plan 6.7, the row "Interactive sessions and phase A", reads: "a session whose checkout does not carry `.claude/` runs without it **[Awaiting verification: C01 #9]**".

- **Answered at the documentation level** (read 2026-10-11; not independently tested). The repository's hooks reach a cloud session only from the `.claude/settings.json` in its one repository's clone ("Part of the clone"). The only other hook source named is an organization's server-managed settings, which do not carry DevOS's guard. So a session whose checkout lacks `.claude/` runs without the guard.
- **The documentation adds a case the row does not name.** A session with several repositories reads no repository's hooks. It runs without the guard even when its checkouts carry `.claude/`. The row's "Who can change it" names "Batu (the environment and repositories at opening)".
- **The guard's own side.** It creates sessions only from a revision that carries `.claude/settings.json` (rule S2, lines 1446-1448). `create_session` takes one source (N-048).
- **The text change.** The mark's text changes only through plan Section 14 (as EV-C01-002 and EV-C01-003 left their marks). N-170 on `plan/work/C01.md` carries the change: the answer with its source and date, and the several-repository case. Its deadline is C01's stage close (W-C01-30 point 5).
- **Plan 10.1** (plan line 1128, which the coverage table at `plan/work/C01.md`:145 lists as "Plan 1115, 1117" from the text at `c843988`) names row 9 for "the leak check before writing to the public repository" and "the guard hook of phase B". The first is point 2 here. The guard's fail-closed part is W-C01-38's. C03 tests both.

## Facts taken from the documentation (PC-21 item 9)

Sources, all read 2026-10-11, each fetched as markdown; none shows a last-updated date:
- **E**: https://code.claude.com/docs/en/cloud-environments
- **S**: https://code.claude.com/docs/en/settings
- **H**: https://code.claude.com/docs/en/hooks
- **R**: https://code.claude.com/docs/en/routines

The facts:

- A repository's `.claude/settings.json` hooks and permission rules load in a cloud session with one repository, as part of the clone. A session with several repositories starts above the clones and reads only `enabledPlugins` and `extraKnownMarketplaces` from each repository's settings file, not permission rules or hooks. Guaranteed by platform (documented in E, "What carries over from your setup" and "Limitations in cloud sessions", and S, "Settings in cloud sessions", read 2026-10-11); not independently tested. The one-repository half is consistent with R1a's and R1b's self-observation (point 2). The documentation does not state what a repository attached after the session starts does.
- In an Anthropic-hosted environment, Claude Code runs hooks from the repository and from the organization's server-managed settings; user and local settings files are not read. Guaranteed by platform (documented in E, "Setup scripts vs. SessionStart hooks", and S, "Settings in cloud sessions", read 2026-10-11); not independently tested.
- Claude Code fires the same hook events in cloud sessions as elsewhere. Guaranteed by platform (documented in H, introduction, read 2026-10-11); not independently tested beyond the PreToolUse decisions of point 2.
- Routines run as full Claude Code cloud sessions with no permission-mode picker. Guaranteed by platform (documented in R, read 2026-10-11); not independently tested.
- The GitHub proxy serves GitHub API requests for the repositories attached to the session; a request for another repository gets a 403. Guaranteed by platform (documented in E, "GitHub proxy", read 2026-10-11); not independently tested. Whether git clone or fetch is limited the same way is not stated (W-C01-39's matter).

Qualifiers:
- Per environment, only the variables, secrets and network setting are separate. The setup script is also per environment (EV-C01-002:102).
- The GitHub identity and the account's connectors are shared across the account.
- An environment's variables are readable inside its own sessions.
- The channel to the model's own service stays open whatever the network setting.
- These pages describe Anthropic-hosted environments; a self-hosted environment reads settings differently (E; S).
- Routines are a research preview ("Behavior, limits, and the API surface may change", R), so these readings are repeated when the platform changes (plan 0.3 item 12).

## What the record cannot show

- **Self-observation.** Whether the hooks were active, and how many pushes passed under L1, is each run's own guard report. Nothing outside the sessions read their decision logs, which stayed in their containers.
- **The store-less form is inferred.** It rests on the code, R1a's checkout count, the fresh machines and a same-session reading of the environment. The runs did not print L1's detail.
- **Two runs only**, on 2026-10-11, of one routine with one repository; the Claude Code version is "could not check" (envelope).
- **No several-repository session was observed.** That case rests on the documentation alone, and PC-21 item 5 takes its fail path as the design.

## Result

| Part | Result | Where |
|---|---|---|
| 1. The documentation on where permission rules and hooks load, with its reading date; DevOS's one-repository rule recorded (N-134, N-135) | met | Point 1 |
| 2a. A run records whether the repository's hooks are active in its session | met (R1a, R1b) | Point 2 |
| 2b. A run records whether the check before writing runs in its session | met (R1a, R1b), in its store-less form, service names only; the fail path does not apply | Point 2 |
| 3. The notes this item serves, each disposed of with its reason | met: N-048 closed; P4 and U2 carried to W-C01-27; N-134 and N-135 carried | Point 3 |
| Envelope and PC-21 item 9's claim on every documentation fact | recorded; the Claude Code version is "could not check" | Envelope; "Facts taken from the documentation" |
| Plan line 729's mark (coverage table) | answered at the documentation level; its text change carried by N-170 | "Plan line 729's mark" |

No part of the block is "could not check", and row 9's fail path does not apply, so no plan change follows from row 9. Reading (b) of point 2 is carried to C03 by N-171.
