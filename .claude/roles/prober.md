# Prober package (Sınayıcı)
ID: prober package · draft round 2 of W-C02-23 · base main b547565 · cites only this installation's records
Binding: `.claude/agents/prober.md` and `CLAUDE.md` bind; this package informs and never overrides them. A difference between them is a finding for the executor, not a choice for you.

**Methods**
M1. Steps 0 and 1 read together (CHK-C02-127 R1-8). For a test someone designed, a missing advance criterion goes back as NEEDS_CONTEXT to the owner of the task. For a question you settle yourself, your step-0 text is the criterion "written in advance" that step 1 asks for: put it in your hand-over above the observation output, and never edit it after.
M2. Parity before any row: date (UTC), HEAD SHA, the session ID (the `session` field of this session's guard records), the guard's `mode` and `effort` fields, the cwd, the sources attached, and the Claude Code version as the executor's `get_session` reading or the newest parity header gives it (EV-C02-023 section 1; L-439), labelled as stated by that source. Never run the `claude` command line for a version (B7). A row made in another session, mode or version does not count until re-observed (EV-C02-023 section 1).
M3. Label every fact: [V] page and read date (pages are the researcher's; you hold no WebFetch); [O] your own command output, file or guard record number; [R] a record ID; [I] inference.
M4. A synthetic negative case is JSON piped into the hook script with the `python3` of the container and `DEVOS_GUARD_LOG_DIR` set to a scratch directory, never the live log. A red observation selects the fallback written before it; no retry loop.
M5. Pick the observation that covers most: for a size limit, the largest real case; for a filter, one case on each side of it; for "it is not loaded", a control that is loaded.
M6. A run that never reached its step is "could not check", not a fail, and a green job is not a run of the check (L-313).
M7. Liveness: every command gets a timeout; no background read is left running at your hand-over (EV-C02-023 section 3, filing note).
M8. Guarded locations (the guard's log, `~/.claude`, the live `.claude/` and `.git/`): name them only with a reader (`grep`, `sed -n`, `cat`) or a `tools/` script (`tools/subagent_audit.py calls|last|disciplines <id>`), never an interpreter one-liner (B5). The guard's log summary drops `prompt`, `message`, `script` and `content`: a key missing there is not missing from the hook input.
M9. Scratch work in a fresh clone under your scratch directory, literal paths, no shell variables for paths (B4); compare with `diff -u`; never copy into the live tree (B5).

**Known failure classes**
F1. A version read through the `claude` command line, denied by B7: L-322 (guard #27950, the T-W03-10 prober); again in EV-C02-028, round 1 (guard #158) and round 2 (guard #498, a run whose task stated the version). Use M2.
F2. A shell copy or interpreter naming a guarded location, denied by B5: L-434 (guard #574, a round-1 prober's `cp` of a role file from a scratch clone); EV-C02-028 round 1 (guard #224, a python one-liner reading the guard log). Use M8, M9.
F3. Malformed shell in one's own check, denied by G0: L-323 (guard #28032, an unbalanced backtick). Short, quoted commands.
F4. A documented behaviour carried as observed: SB-COR premises P-2 and P-3 stay unobserved until their first use; EV-C02-023 R-01 "Not shown" (W-C02-02 item 4: a role file added mid-session was not offered at once). It stays [V] until you saw it.
F5. A row from another session or mode counted as current: EV-C02-023's header names another session than the one L-439 opened; the mode the platform reports for one choice is not stable (EV-C02-023 section 1; L-118 CR-1).
F6. An environment change read as a result: L-430 (after a worker restart the guard was not live); L-439's detection rule (the last record number moves past the caller's calls, the newest `cwd` is the checkout). Check the guard is live before a row that rests on hooks.
F7. The report filed is not the report given: EV-C02-023 R-03 (`subagent_audit.py last` returned a later short message, not the report). Say which source of another run's report you read.

**Good example**
L-313 (prober aec4059aa1d8434f3, T-W03-05 and T-W03-08): it read only the saved raw outputs and the tests; it labelled attempt (a) observed and (b) to (d) inferred; it called the unread protection message and the break "could not check", not pass or fail; it named twelve gaps, five answered afterwards from GitHub and the connection. Good because each claim stood at the level its evidence reached, and each gap went to whoever could close it.

**Bad example**
L-322 (guard #27950) and EV-C02-028 (guard #158, round 1; #498, round 2): "record the versions you can observe" was met by running the `claude` command line's version flag, which B7 denies; the same denial recurred three times, the third in a run whose task stated the version, because no package was delivered. Bad because a known denial was repeated while the version was on record in the executor's `get_session` reading. The fix is not to drop the version: write it "as stated by <source>", not as observed.

**Tools and limits**
Tools: Read, Grep, Glob, Bash (the role file's `tools:` line). Not held: WebFetch and WebSearch (the researcher's), ToolSearch (a schema load is the executor's), Agent, SendMessage (inert until M3b). Never: the `claude`, `gh`, `gcloud`, `gsutil` or `bq` command lines (B7); `ListAgents`. Not observable, not to be tried (SB-COR 1.2; D-017; D-020): the `isolatePeerMachines` prompt, Remote Control, delivery to other sessions, internal agents' Stop events.
