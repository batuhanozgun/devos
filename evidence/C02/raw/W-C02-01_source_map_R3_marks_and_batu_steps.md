# C02 source map R3: marks and Batu's steps

## Disciplines (D1–D9)
D1: yes: I kept "mark", "label" and "requirement" apart, and left the two open framings (which Supabase project carries the tokens; who opens a session in each new environment) as stated alternatives instead of choosing one.
D2: yes: I checked each example label in the brief against its record instead of taking it as given, and found that row 3's facts come from documentation and were not observed.
D3: yes: every finding is mapped to the two things W-C02-01 item 2 asks for, and every choice is left to the executor, because stage authority is the executor's.
D4: yes: my completeness claim rests on label searches plus content-term sweeps. Their limits are stated under Open, because a search that finds nothing does not prove absence.
D5: yes: I read the plan, Appendix B, Appendix C, C02.md and C01.md in full (long lines through targeted extraction), and checked the brief's line pointers against the files: line 1230 holds; N-125's "line 1206" is stale.
D6: no
D7: no
D8: yes: I confirmed the working tree is at `origin/main` `796c427` with no local changes, and noted that the local `main` ref is stale (`298fc73`).
D9: no

**Question and the decision it serves.** For the executor's work list (W-C02-01, acceptance item 2): (a) every mark and label that names C02 as the place of a check, with the item or later stage it belongs to; (b) every step Batu takes in C02.

**Abbreviations.** P = `/home/user/devos/plan/DevOS_Kurulum_Plani.md`; B = `/home/user/devos/plan/Ek_B_Veri_Modeli.md`; C = `/home/user/devos/plan/Ek_C_Testler.md`; S02 = `/home/user/devos/plan/work/C02.md`; S01 = `/home/user/devos/plan/work/C01.md`; KI = `/home/user/devos/plan/key_inventory.md`; EV2 = `/home/user/devos/evidence/C01/EV-C01-002_row3_environment_token.md`; EV4 = `/home/user/devos/evidence/C01/EV-C01-004_environment_separation_one_account.md`; decision records are under `/home/user/devos/plan/decisions/`.

**Kinds.** A **Mark** is an "[Awaiting verification: …]" that names C02. A **Label** is another status label, or a stage or test cell, that names C02 as the place of a check. A **Req** is text that makes a claim C02 must show, or a deadline that falls before or in C02. Exactly two Marks name C02: P:319 and P:997. All my statements in this section are what the source states, unless marked as inference.

## 1. Every place

### Plan Section 4 (capabilities)
| Place | Quote | Kind | What C02 must show |
|---|---|---|---|
| P:319 (K-3 Status) | "the rule working in the database **[Awaiting verification: C02]**" | Mark | The format gate for high-impact decisions (K-3 item 2; B 3.17) rejects in the database, and its break test fails when the rule is removed. Served by C N02 (C02), task 5, task 6, and the Acceptance lines "✘ The format gates reject empty fields" and "when each rule is deliberately broken, the related test fails". |
| P:435 (K-9 Status) | "the environment token's form is C02's token design (row 3; PC-21 item 4; note N-131…)" | Label (pointer) | The token's form is chosen, and row 3's fail path decided, before task 3 (N-131). The K-9 negative tests stay "[Awaiting verification: C03]". |

### Plan Section 6
| Place | Quote | Kind | What C02 must show |
|---|---|---|---|
| P:631 (6.2) | "Batu enters it into the repository's secret settings (Section 12, C02)… Its exact form is designed and probed in C02's first task… A comparison function, built with the migration path in C02's first task" | Req ([Proposal]) | Task 0. A difference found by the comparison, or a comparison that could not run, stops the work it affects (P8 item 14). |
| P:639–642 (6.3 table) | `devos-kurulum` "Installation operations after C02"; `devos-calisma` and `devos-denetim` "C02–C03"; `devos-sinav` "C02 (environment and token)" | Label | The environments and their tokens exist by task 7. `devos-kurulum` gains a database authority after C02, so it needs a token (N-125). |
| P:646–648 (6.3) | "The builder writes a database function that generates tokens but cannot run it… shows the token once… it only tests that the token exists and works with the expected authority" | Req | Task 3 (consistent with B:35 "Cannot: Issuing tokens" and B:46) and task 7. |
| P:652 (6.3 Network) | "[Verified: …; not independently tested]… Whether the database can take the token from that header is not stated there; the token's form is chosen in C02's token design" | Label | C02 shows the header path works, or applies row 3's first branch (an Edge Function gate). |
| P:723 (6.7, database row) | "C01 #3; C02; C03 tests 1, 2" | Label | C02's real-token tests. The "C01 #3" cell states as observed what was only read in documentation (S02:82; N-209 item 2). |
| P:724 (6.7, migrations row) | "C02 task 0 and acceptance" | Label | The channel's negative test: "✘ The migration credential cannot be read by an agent session, nor by a workflow run for a branch other than `main`" (P:1007). |
| P:731 (6.7, control-surface row) | "(D-020 (a): the three environments stay in his account)" | Req (status) | C02 builds the environments under D-020 (a)'s residual. Separation over the control surface rests on the guard plus S9 (N-136). |

### Plan Section 9: introduction and tables
| Place | Quote | Kind | Requirement |
|---|---|---|---|
| P:848 | "C02 builds what C02's own acceptance conditions and C02-stage tests need, plus what C03 needs at its start… asks again whether a deferred part is needed earlier" | Req | The work list itself |
| P:852 | "C05's exam setup, in C02's exam environment" | Label | Task 7 |
| P:853 | "C02's format gate on Need records the brake" | Label | C N01 |
| P:858 | "Decision's class rule and format gate (C02)" | Label | C N02 and N29 |
| P:864 | "without the rule gate, the identity chain and the format gates, C07's needs and decisions… would rest on the agent's word" | Req | Why C02 cannot move |
| P:870 | "At the end of C02 it is transferred… Acceptance of the transfer: no duplication…; …resumes…; links and versions match; …`ledger.md` is not an authoritative write surface" | Req | Task 8; C N18 |
| P:878 | "from C02, Test designer" | Req | W-C02-02 |
| P:895 | "C02 \| Data model, rule gate, identity chain, F01–F08 regressions, ledger transfer \| The decision channel's interface (C06)" | Label | What C02 leaves open, and where it goes |

### Plan Section 9: C00 and C01 text with deadlines "before C02"
| Place | Quote | Kind | Status |
|---|---|---|---|
| P:924 (PC-18 note) | "N-109 … checks it before C02 builds DevOS's environments" | Req | Closed as a residual Batu accepted, D-019 (a), 2026-10-11T05:49:08Z (S01:418). It reopens at D-003's re-assessment at C03 (D-019:18). |
| P:926 (PC-21 note) | "the account-change option goes to Batu before C02" | Req | D-020 answered (a), 2026-10-11T05:59Z (D-020:9–13). |
| P:934 | "environments, tokens and routines are built only in C02–C06" | Req | — |
| P:938 (probe setup P3) | "C02's first migration removes the schema, and the probe tokens with it" | Req | Stale: P3 was never built (P:965; KI:15, 36–37; S01:434). See G1. |
| P:947 (row 3 fail path) | "Visibility is then recorded as a residual risk before C02 builds the identity chain… redesigned before C02" | Req | Carried to N-131, before task 3. |
| P:953, P:969 (row 9; PC-21 item 5) | "If the guard does not fail closed, it is corrected before C02 opens DevOS's environments" | Req | Met: W-C01-38 accepted; 772 ok, 0 BAD at `e9fc0a4` (S01:368, 374). Re-checked before task 7 by N-174. |
| P:961, P:971 (row 17; PC-21 item 7) | "the frame is reviewed (Section 6.12) before C02 builds the environments and the identity chain"; "FR-05 is the frame review" | Req | Met: FR-05 accepted; D-020 (a). |
| P:962 (row 18) | "corrected… before C02"; "the threat model decides before C02 whether private content… may reach it" | Req | Met: PC-30 accepted; branch (b) does not apply (PC-30:22). |
| P:968 (PC-21 item 4) | "settled by C02's token design…; the database's derivation of the role class is shown by C02's own tests. The fail path is unchanged and is decided there." | Req | Task 3, C N04, F06's `role_class` check, and the real-token Acceptance line. |
| P:973 (PC-21 item 9) | "these readings are repeated when the platform changes" | Req | Carried to N-208 (trigger and owner chosen in this work list). |
| P:979 (PC-39 note) | D-029's effect observed "in C02's first sessions" | Req | Moot: D-029 was answered (b) on 2026-10-12T05:53Z, so there is no effect to observe. The listing residual goes to C03 (N-187). |
| P:981, 987, 989 (phase-A probe) | "done before C02 starts"; "enters C02's work list, which asks again each record family's first need" | Req | Carried to N-128. |

### Plan Section 9: C02's own text
| Place | Quote | Kind | Requirement |
|---|---|---|---|
| P:997 (task 0) | "The credential's exact form… and how GitHub limits it to that job on `main` **[Awaiting verification: read from the current GitHub and Supabase documentation, with its date, and probed here]**"; "The first migration also removes C01's probe schema" | Mark (second sentence stale; see G1) | Task 0 and the three migration conditions in the Acceptance line |
| P:998–1005 | Tasks 1 to 8: task 3 is the identity chain and the issuing function; task 7 is "The three environments… and their tokens (Batu, through the Section 6.3 flow)"; task 8 is the ledger transfer | Req | — |
| P:1007 | Acceptance, including "✘ With each environment's real token, an operation that requires another environment's authority is rejected"; "✘ An operation with another session's claim, and with a fake session ID, is rejected"; the three migration conditions; "✔ The C01 probe schema and its tokens no longer exist" | Req | — |
| P:1009 | Criteria 8, 10, 15, 30 | Label | — |

### Plan: later stages, Section 10 and Section 12
| Place | Quote | Kind | Where it moves, and what it comes before |
|---|---|---|---|
| P:1013, 1017 (C03) | the audit environment re-reviews "the acceptances given in C00–C02" by sample, "and C02's identity chain in full (PC-10)" | Label | The full review of the identity chain moves to C03 and comes before C03's acceptance. Until then a verdict's origin is checked by its form only (working order section 10). |
| P:1033 (C04 Acceptance) | "(a finding or decision recorded from C02 on)" | Req | C02's Finding and Decision records must be searchable in C04 (B:430). |
| P:1135 (10.1) | "the environment token and the identity chain (6.3, K-9)… the migration path (6.2; C02)" | Label (designed, awaiting verification) | Tasks 0, 3 and 7 |
| P:1230 | Section 12 item 1 | Batu's step | See section 2 |
| P:1239 (key inventory) | "the C01 probe tokens (until C02's first migration removes them), the three environment tokens, the installation environment's token, the CI role's key, … the migration credential of each project" | Req (first clause stale) | See G1 and G4 |

### Appendices
- **B:3** "Implemented in the test project in C02". **B:22** principle 8, the identity chain. **B:26** "The share is set in C02 and recorded" (sample share of format-gated records; Req). **B:35** `devos_kurulum` "Cannot: Issuing tokens". **B:46** `issue_env_token`: "only the project owner (Batu, from the Supabase dashboard) can run this function"; `revoke_env_token` raises the epoch.
- **B:59–96, activation table, rows with C02:** Mission, Need, Work and WorkStanding, Relation, Assignment, Finding, Artifact, Review/Verdict/Acceptance, Operation and Observation, Event, EvalRun ("C02, for C03"), Decision (`answer_decision` in C06), EffortPolicy, LeakFingerprint ("C02, for C03"), EnvToken ("C02 tasks 3 and 7; N04"). **B:98** `devos_calisma`, `devos_denetim` and `devos_sinav` in C02; `devos_backup` and `devos_ci` "in C02, for C03".
- **B:154, B:410** claim expiry built in C02; whether a job applies it is chosen in C02 with tests. **B:265** Release is not built in C02. **B:390** `mark_exported` in C02, for C03 test 8; `deployment_drift` in C02 with the migration path, and "the checks of every later pull request run it".
- **B:436–446** Section 8, details chosen in C02 (all Req). Row B:446 cites "C01 #3 observation", but that fact was read in documentation, not observed (N-209 item 2).
- **C, tests whose stage is C02:** C:30 (F01–F08, stage C02); C:95 F07 (C02 and C08); C:106 Concurrency; N01, N02, N03 (C:118–120); N04 (C:121, C02/C05/C10); N09 (C:126, C02/C04); N17 (C:134); N18, the ledger transfer (C:135); N25 (C:142); N28 (C:145); N29 (C:146, C02/C05); K05 (C:160). F02 is tested in C04 (C:50, P:1007). **C:11:** the other test fields are filled in "from C02".
- **Appendix F, line 27:** the `/goal` proof names "plan/work/C12.md until the ledger moves to the database at the end of C02, its database record after that" (Req on task 8).
- **Appendix E §6 and §7** set the form of every step of Batu's (each step one action; what he should see at the end; the system checks the result). They do not name C02.
- **Appendices A, D and G:** no mention of C02.

### Stage files
- **S02, all open notes, each a Req:**
  - N-031 (:24): re-observe once the raw-evidence store exists.
  - N-032 (:32): structural format gate, in C02 or C03.
  - N-064 (:40): rows R17 and R23 under B Section 8.
  - N-074 (:44): T-31 (strengthen the acceptance conditions before work starts), T-36, T-37.
  - N-092 (:48): T-36, T-37 and T-77, deadline C02's start; the plan text changes "at C02's start, with its work list".
  - N-112 (:60): version comparison.
  - N-125 (:64): Batu's steps for the installation token and the CI key.
  - N-127 (:68) and N-198 (:98): before C02 closes.
  - N-128 (:72): the phase-A probe's result.
  - N-131 (:80): before task 3.
  - N-136 (:86): S5 before task 3; the rest before task 7.
  - N-181 (:90): before task 7.
  - N-174 (:94): before task 7.
  - N-201 (:102): the "Batu's steps" section.
  - N-202 (:106): branch listing at or after 2026-10-13T08:40Z.
  - N-205 (:110): working order section 5.
  - N-207 (:115): the combined scenario at C02's end.
  - N-208 (:120): re-reading C01's documentation-based facts.
  - N-209 (:125): plan text corrections.
- **S01:** :34 (phase-A result goes into a note on C02); :39 (limit (b): N-202 can reopen C01); :111 (says "removed by C02's first migration": stale); :126 and :187 (N-112's comparison from C02); :163 (Plan 652 and B:446 carried to N-131); :294 (separations rest on the database: N-131, N-136); :328 (keys that Section 12 does not name are N-125); :434 (no probe token to revoke before C02); :439 (N-129 carried to N-198); :402 (N-144 carried to N-205). The other "before C02" items (:86–:93, :349, :366, :372) are closed.
- **Other stage files:** C03.md:112 (N-203: S9 removes session tools "from C02"; whether that is the right criterion, by purpose, is C03's question); C04.md:66 and C06.md:41 (B 3.4 fields written by PC-16 "before C02", built in C06); C06.md:45 (ECC-80 "decided and built in C02"); C09.md:39 (T-65: "The migration part is PC-16's, before C02 task 0 is accepted"); C12.md:28 (N-140: C02's bridge is replaced at C12); C07.md:44 (phase-A probe recorded before C02); C05.md:23 and :58 are pointers.

### Decision records naming C02
- D-019:17 and :36: "C02's work on the environments waits for the answer" (answered).
- D-020:17, :39, :41, :53: "All three environments are built in his account at C02".
- FR-05:28, :32, :34, :56, :69: the token's form carried to C02; DevOS's role rules are shown by "its own negative tests in C02 and C03".
- PC-21:15 and :110.
- PC-18:75–76.
- PC-30:16.
- PC-35:16 and :100: the keep-out holds before C02 builds the environments. It was observed Out at the working session's start on 2026-10-12 (PC-35:129).
- PC-38:16 and :52.
- PC-39:16 and :81.
- D-003:9 and :13: the residual lasts "until the audit environment exists (C02–C03)".
- D-008:11; D-009 (withdrawn); D-010:23: test designer "from C02".
- FR-06:43 and PC-23:60: from C02 the test designer writes the acceptance conditions, with the premise inventory PC-23 requires.
- PC-27:16: affects C02 only under option (b), which was not taken.

## 2. Batu's steps in C02

**P:1230, quoted:** "**C02:** Creating the three environments (working, audit, exam); for each, running in the Supabase dashboard the single SQL line the builder gives, and pasting the resulting token into that environment's settings field. Entering the migration credential, in the form C02's first task designs, into the secret settings of the `devos` repository so that only the migration job can read it, one for each Supabase project (6.2)."

| # | Step | Source | C02 task | Waits on | Records |
|---|---|---|---|---|---|
| 1 | Enter the migration credential, one per project (`devos`, `devos-test`), so that only the migration job can read it | P:1230, P:631, P:997; KI rows 23–24 | Task 0 (first) | Task 0's form, designed from the GitHub and Supabase documentation read with its date, and probed. Who creates the credential is not stated; it may need its own SQL text or a setting only the repository owner can make (inference; G8). Every later database change waits on this step (P:631). | None open |
| 2 | Create `devos-calisma`, `devos-denetim`, `devos-sinav` with the settings the builder gives: network level (P:652; S6), publishable key as a variable (P:646; EV4:155) | P:1230; P:1004 | Task 7 | N-136's pre-task-7 work (S9 bridge merged with a checker verdict and confirmed by a session listing its own tools), N-174, N-181; the plan change of P:648 and P:1230 (EV4:364) | D-020 (a) answered; D-019 (a) answered; D-003 residual until C03 |
| 3 | Per environment, run the one SQL line that issues its token (shown once) | P:1230, P:648; B:46 | Tasks 3 and 7 | The issuing function existing in that project, which reaches it only through the migration path (step 1, task 0). Which project is not stated in P:1230; S5 names the live project's host (EV4:154). See G3. | — |
| 4 | Store the token, in the same sitting as step 3. Under S5 this is a **network secret** on that environment, with the host and a custom header without prefix, not the plan's "settings field" | EV4:152–170; S02:87 | Before task 3 (form); task 7 | N-131 choosing the form. If the variable form were chosen, the difference against criterion 26 is Batu's to decide (EV2:150). | — |
| 5 | The step text for task 7 also carries S4(d) and (e): his own sessions, his CLI default and any Claude Project stay on an environment with no DevOS token; nothing secret goes into account-wide items | S02:87; EV4:135–141 | Task 7 | As step 2 | D-020 |
| 6 | Issue the installation environment's token (`devos_kurulum`) and store it in `devos-kurulum` | N-125 (S02:65); KI row 21; P:639 | Task 3; task 4 (N04 and N08 run with this token, S02:87); task 8 at the latest | The issuing function. Section 12 has no such step, so a plan change is owed. Whether the running working session picks up a newly added secret is not stated (G14). | — |
| 7 | Issue the CI role's key (`devos_ci`) into GitHub Actions secrets (which repository is not stated) | N-125; KI row 22 | Task 0's pull-request checks run `deployment_drift` (B:387, 390) | Its form; see G5 for an ordering gap | — |
| 8 | Inference, not stated anywhere: open one session in each new environment, from a first message the builder gives | P:1007 real-token line; E §7 item 4; P:878 "comes to Batu as a single, narrow question" | Acceptance; task 7's check | See G7 | D-008 applies to such sessions (inference) |
| 9 | Only if needed: revoke and renew a token that leaves its field; after a detection, `revoke_env_token` and archive the environment | P:648, P:947; EV4:257–259 | — | — | — |
| 10 | Only if needed: if N-202's listing shows a probe branch, the routine's deletion goes back to him | S02:107 | — | Not before 2026-10-13T08:40Z | — |

No decision record is open (all D and FR records are answered, accepted, declined, withdrawn or superseded). Batching, as inference: step 1 stands alone at task 0. Steps 3, 4, 6 and 7 can be batched in one sitting once task 3's function is applied, with step 2 just before. Each is given in the Appendix E §7 form and listed under "Batu's steps" in S02, with asked and done dates (N-201).

## 3. What C01 recorded that C02 relies on

| Fact | Label | Where |
|---|---|---|
| Each environment's variables and secrets are its own; variables are readable by the environment's own sessions; network secrets (Pro and Max) are attached outside the VM in a named header, cannot be read, and cannot be viewed after saving; the Supabase host is not on the Trusted list | Documented, not independently tested (read 2026-10-10) | EV2:110–113, :53, :86 |
| Row 3's token form and role-class derivation | Could not check in C01; handed to C02. C01 observed neither part of row 3 (S02:82). P:235, P:723, P:734 and B:446 still call it observed (N-209). | EV2:128–171 |
| The database can take the token from the header | Not stated; could not check | EV2:97; EV4:315 |
| W-C01-42's structure: S5 (network secret), S8 (three configuration lines), S9 (bridge), S4, X1 | Design from the plan and documentation, not independently tested (EV4:15). That a repository file's deny applies in these sessions is an inference to be confirmed by C02's self-observation (EV4:225–227). | EV4; S02:86–88 |
| Row 17: no limit by environment is stated, so the unfavourable case is the design | Documented, not independently tested. L-119 (a session in Accept edits cannot start sessions) is observed. | P:731; EV-C01-003 §§3–5 |
| Row 9: hooks and permission rules load only in a session with one repository | Documented, not independently tested. That the hooks were active in runs R1a and R1b is self-observation; no several-repository session was observed. | EV-C01-016:88–119 |
| Row 12's design path | One part met at documentation level; five parts not stated or could not check. Pushes made as the machine account were observed in a 7-hour window. Who can change the rule of `main` is not stated (N-175, before C03 test 5). | EV-C01-018:76–95, :152 |
| The guard fails closed | Observed by DevOS's own tests (772 ok, 0 BAD). The platform applying `onFailure: "block"` is documented, not independently tested. | S01:368, 374; EV-C01-017:187–216 |
| N-109, the platform's session credentials | A residual Batu accepted (D-019), not a shown result | S01:418 |
| ECC kept out | Observed at the working session's start; its cause is an inference | PC-35:129 |
| Synced skills | Observed listed in run P4; loading denied by rule T4; listing is a residual (D-029 (b)) | P:979 |
| Probe tokens and P3 schema | Recorded as never created. That `devos-test` holds no probe schema was not observed in anything I read. | KI:15, 36–37 |
| Phase-A result | Its checker found criteria met; none of its decisions is accepted | S02:73–77 |

## 4. Contradictions or gaps

- **G1.** The P3 schema and the probe tokens were never built, yet P:938, P:997, P:1239, S01:111 and KI:11 still say C02's first migration removes them. N-209 does not list these lines. The ✔ condition at P:1007 can be met by an observation of absence, not by a migration.
- **G2.** P:648 and P:1230 ("settings field") conflict with S5's network secret. A plan change is owed before C02 relies on S5 (EV4:364; S02:87). KI rows 18–21 follow it.
- **G3.** No source says which project issues the environment tokens. S5 names the live project (EV4:154), while B:3 and P:998 put C02's work "first in the test project". Whether a second set of tokens is needed for `devos-test` is open.
- **G4.** The installation token and the CI key have no step in Section 12 (N-125). N-125 cites "line 1206", which is now P:1230.
- **G5.** The CI key is needed earlier than stated (inference). B:98 says `devos_ci` exists "in C02, for C03", but B:390 and P:631 have the pull-request checks run `deployment_drift` from task 0, and only the migration job and `devos_ci` may call it (B:387). If `devos_ci` is an environment token, its issuing function only arrives with task 3.
- **G6.** Design question for task 0 (inference). B:45 says every `devos_api` function first verifies an environment token, but the migration job, which calls `deployment_drift`, holds a migration credential, not a token.
- **G7.** The real-token Acceptance line (P:1007), and the system check of E §7 item 4, need requests from inside each environment. Under S5 only sessions running there carry the token. The executor cannot start sessions (D-009 withdrawn; L-119; S9; the guard). So a step of Batu's that no source names is implied (inference).
- **G8.** The migration ✘ ("nor by a workflow run for a branch other than `main`") cannot rest on the rule of `main` until N-175 settles who can change it (P:719, before C03 test 5). Sessions push to branches as a collaborator with write access. The GitHub mechanism behind the mark at P:997 is unread.
- **G9.** S8 line 1 denies `devos_kurulum` verdict and acceptance rights, and B:237 allows those writes only to `devos_denetim`. Yet task 8 transfers checker verdicts into Review and Verdict, and checker verdicts continue until C03. EV4:191 says "C02 names the right and when it ends"; this is still open.
- **G10.** P:870 and N18 name only `ledger.md` as no longer authoritative after the transfer, but the ledger is now spread over `plan/work`, `plan/decisions`, `plan/ledger/*-log.md` and `evidence` (`plan/ledger.md`:3). Appendix F line 27 relies on the transfer. Which files stop being write surfaces is not stated.
- **G11.** S8 line 3 (a claim needs a registration; N-136, task 4) needs SessionRecord and `register_session`, which activate only in C04 (B:90, B:390).
- **G12.** B Section 8 lists vector index and chunk size as "chosen in C02", but bases both on C04's benchmark (B:444–445).
- **G13.** Needs at C03's start (inference). C03 test 6 needs LeakFingerprint rows that only `devos_ingest` writes, and that role comes in C04 (B:327, B:98). C03 test 8 may need the backup credential, which is entered only in C09 (KI row 29).
- **G14.** Whether a network secret added to `devos-kurulum` reaches the running working session is not stated. EV2:88 covers variables only.

## Open
- **Not read:** PC-08, PC-09, PC-10, PC-16 and the other PC records in full (I read them only through the plan text and context searches); W-C02-02's acceptance; the W-C01 item files; EV-C01-015 and EV-C01-008 beyond the cited lines; Appendices A, D (beyond section 2 item 3 and section 3), E (beyond §6–§8) and G (search only). The stage files C03–C12 were read only around their C02 hits.
- **Search limits:** label searches plus content-term sweeps ("identity chain", "first migration", "three environments", token, migration, ledger, "before C02", "in C02"). A place that names C02 by other wording could be missed.
- **Not checked:** the database state (whether a probe schema exists), and the current GitHub and Supabase documentation (no web access).
- **For the decision:** this changes nothing already decided. It adds owed plan changes (G1, G2, G4) and the gaps G3, G5–G11 and G14 for the work list to place, plus steps 6 to 8 of Batu's beyond Section 12.
- **Guard denials:** none.
