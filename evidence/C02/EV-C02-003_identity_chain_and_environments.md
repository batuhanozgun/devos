---
id: EV-C02-003
item: W-C02-05
kind: design
sources:
  - "plan/DevOS_Kurulum_Plani.md at main 560bcab: criteria 8, 21, 25, 26 with the PC-08 note (line 235) and 30; K-9 items 2 to 4 and 9; 6.2; 6.3; 6.7 (database, migrations, GitHub, control-surface, network and scheduled-jobs rows); 6.12 item 1; Section 8 items 13 and 14; Section 9's ordering principle, 'Installation ledger', 'Closing each stage' and the builder's working order item 1; C00's sixth condition with the PC-18 and PC-21 notes; C01 row 3 with the PC-21 note items 4, 7, 8 and 9; C02 tasks 0 to 8 and its Acceptance; C03's tasks and tests 1, 3, 5 and 8; Section 12 items 1 and 4 and its key inventory paragraph; Section 14. Read 2026-10-12."
  - "plan/Ek_B_Veri_Modeli.md principles 1, 8 and 9, section 2, the activation table and line 98, 3.5, 3.11, 3.13, 3.15, 3.18, 3.24, 3.27, section 4 with its activation paragraph, section 8; plan/Ek_C_Testler.md C0, F06, F08, N03, N04, N08, N17, N26, N28, K06; plan/Ek_E_Iletisim.md sections 3, 6 and 7; plan/key_inventory.md. Read 2026-10-12."
  - "plan/work/W-C02-05.md; plan/work/C02.md (N-125, N-131, N-136, N-181, N-201, N-208, N-209, 'Batu's steps'); plan/work/C03.md (N-107, N-137, N-203); plan/work/C04.md; plan/work/C05.md (N-111, N-138); plan/work/C12.md (N-140); the acceptance blocks of plan/work/W-C02-07.md, W-C02-09.md and W-C02-12.md, read for their interfaces with this design only; plan/work/C01.md, 'Batu's steps'; plan/decisions/D-003, D-017, D-019, D-020, and PC-38 for the form of a plan change; plan/Installation_Working_Order.md sections 2, 4, 7, 8 and 9. Read 2026-10-12."
  - "evidence/C01/EV-C01-002_row3_environment_token.md (its documentation read 2026-10-10) and evidence/C01/EV-C01-004_environment_separation_one_account.md (its documentation read 2026-10-11); evidence/C01/routine/ROUTINE_DESIGN.md, 'Batu's step', for the words Batu has already seen on these screens."
  - "evidence/C02/raw/W-C02-01_source_map_R1_appendix_B.md (2.4, sections 4 and 5), _R2_appendix_C.md (sections 4 and 5), _R3_marks_and_batu_steps.md, _R4_open_notes.md ('Flags') and _R5_platform_documentation.md (its pages read 2026-10-12 between 12:58Z and 13:08Z)."
  - "Documentation passages re-read by this producer on 2026-10-12 from the raw copies the R5 researcher fetched that day: code.claude.com/docs/en/cloud-environments ('Configure your environment', 'Set environment variables', 'Add network secrets', 'Add a secret', 'Which requests get the secret', 'Requests that never get the secret', 'Archive an environment', 'Network access', 'Access levels'); supabase.com/docs/guides/api/securing-your-api ('Pre-request checks', the request-information table, 'Use additional API keys'); supabase.com/docs/guides/observability/log-field-reference ('Captured HTTP headers'). No page shows a content date."
  - "For the revision (section 'Revision after EV-C02-004'): evidence/C02/EV-C02-004_reconciliation_decisions.md (the executor's reconciliation decisions, parts 1 and 2) and the reading it rests on, evidence/C02/raw/W-C02-0405_reconciliation_R45.md; plan/DevOS_Kurulum_Plani.md, plan/Ek_B_Veri_Modeli.md, plan/Ek_C_Testler.md and plan/key_inventory.md at main eba94b1 (PC-40 merged); plan/decisions/PC-40.md; PC-42 places 27 to 36 and EV-C02-002's DM-01, DM-05, DM-19, DM-23, DM-29, DM-31, DM-36 and section 13 as they stand in W-C02-04's branch (read for their interfaces only; EV-C02-002 is being revised too); Appendix B 3.23 (line 327). Read 2026-10-12."
  - "For the changes after CHK-C02-010: evidence/C02/checks/CHK-C02-010.md (read in full); plan/work/W-C02-05.md's acceptance block; plan/Ek_E_Iletisim.md section 7; plan/work/W-C02-12.md points 1, 6, 7, 9 and 10; the R5 raw page copies re-read 2026-10-12 (CE 'Add a secret', 'Select an environment from the CLI', 'Network access', 'Access levels'; SA's request-information table; SL 'Sources' and 'Captured HTTP headers'; Supabase's logs page, 'Postgres'); git log -L of P:872, P:1013 and B:98 at 560bcab; plan/decisions/D-003, D-013 to D-031 (searched); plan/decisions/PC-43.md. Read 2026-10-12."
produced_by: "producer, fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH"
main_at: 560bcab1d2ac336be06c8eacca08700c44ed485b
date: 2026-10-12
claim: "design from the plan, the C01 records and the platforms' documentation; nothing observed on the platform; not independently tested"
---

# EV-C02-003 · The identity chain and the environments, designed (W-C02-05; C02 tasks 3, 4 and 7)

**What this is.** The design W-C02-05 asks for: the environment token's form and format, row 3's fail path, where each fact the design rests on is observed (task 3); the role classes and the three configuration lines of W-C01-42's S8 (task 4); who issues the installation environment's token and the CI role's key; and the three environments with Batu's steps (task 7); with N-208's re-reading rule. It is authority and configuration design at the level of need (D-017; FR-05; D-020): no trial across environments, no listing of the account's sessions or routines, no probe of the platform, and no material on ways around a control. Its plan text is `plan/decisions/PC-43.md`. The research library was not consulted: the question is the platforms' current behaviour, read from their current primary sources (R5; Appendix D, D9 item 4).

**Labels.** **[Obs: record]** observed, with its record. **[Doc: source, read date]** documented and not independently tested, recorded as PC-21 item 9 asks ("guaranteed by platform (documented in <source>, read <date>); not independently tested"), with PC-21 item 9's qualifiers. **[Inf]** inference. A choice is **decided**, **provisional** (with the observation that settles it and when), or **another item's or a later stage's** (with its deadline).

**Abbreviations.** P = `plan/DevOS_Kurulum_Plani.md`, B = `plan/Ek_B_Veri_Modeli.md`, C = `plan/Ek_C_Testler.md`, KI = `plan/key_inventory.md`, each with its line at `560bcab`. At `eba94b1` the lines of B, C and KI are the same; P's lines from 895 on are one higher and from 934 on three higher (so P:947 is P:950, P:1230 is P:1233), and P:235, P:723, P:734 and B:446 carry PC-40's text. PC-43 gives its own places at `eba94b1`. EV2 = EV-C01-002; EV4 = EV-C01-004 (S1 to S10, X1 to X4, R1 to R5 are its mechanism and residual IDs). R1 to R5 = the C02 source maps; "R5 G1" is item G1 of R5. CE = code.claude.com/docs/en/cloud-environments; SA = supabase.com/docs/guides/api/securing-your-api; SL = supabase.com/docs/guides/observability/log-field-reference. EV-C02-001 = W-C02-03's record (the migration path); EV-C02-002 = W-C02-04's (the data model).

**Names this design fixes** (none is secret): the live project `devos` (host `zyqgltzfzkdvrmvxlamz.supabase.co`) and the test project `devos-test` (host `cqbzxexxwrrbrlszoseg.supabase.co`), both public in P:630; the token header `x-devos-env-token`; the private derivation `devos_private.caller_role_class(function_name)` (§1.6); the read function `devos_api.token_role_class()`; the token refusals' reason codes (§15); "the identity chain's first part": `env_tokens` (EnvToken's table, B 3.27), the global authority epoch's row (EV-C02-002 DM-01), Event with its `origin` (B 3.13; EV-C02-002 DM-31), `issue_env_token`, `revoke_env_token`, the derivation, `token_role_class()` and RejectedAttempt (B 3.13; §15).

**Terms** (EV-C02-004 T-1 to T-11). "RejectedAttempt" is the record of a refused call (B 3.13, EV-C02-002 DM-19). "Verified token": the header's token matches a non-revoked `env_tokens` row; any other token is not verified. "The global authority epoch" is the one row principle 9 names (B:23), distinct from the per-claim field `authority_epoch` (B:150). `none` is a recorded value meaning no role class, never a default role class (plan 6.2). "Owner" names a role class only as a value of `role_class` or `origin`; for credentials this record says "the project owner" and "owner-level path". "Test database" is only EV-C02-002's throwaway database; "real-token tests" are only those in `devos` (§6.2).

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `560bcab1d2ac336be06c8eacca08700c44ed485b` (PR #275, C02's work list), at which W-C02-05's acceptance condition is in force; revised against `main` `eba94b18fc598eb60ccf5f751c04f6335912b21a` (PR #280, PC-40 merged), where the acceptance condition is unchanged |
| Deployment configuration | Working session `session_01XyxvJd3RayQk4HCrjurbVH`, cloud; this record was written by a fresh-context producer subagent in a scratch clone at that commit |
| Criterion version | W-C02-05's acceptance block at `560bcab` |
| Input | The sources in the front matter |
| Actual observation | None on the platform. Sections 1 to 17 are design; documentation facts are quoted from the readings named, with their dates. One observation of the executor's (this working session's tool list, 2026-10-12) is cited in §14 |
| Raw evidence ID | This record; the R5 researcher's raw page copies of 2026-10-12 (session scratchpad), from which the CE, SA and SL passages were re-read |
| Independence level | Same session, fresh-context subagent (declared, Ek A 5.3) |

## 0. The choices and their states (point 16)

Every choice the item's body, N-125, N-131, N-136's design parts, N-208 and R3 G2 to G7, G9, G11 and G14 contain, with its state.

| # | Choice | Source of the choice | State | Where |
|---|---|---|---|---|
| 1 | The environment token's form | Body; N-131 (2), (3); N-136 S5; B §8's token row | Decided: a network secret of its own environment, host of the live project, which issues every token, header `x-devos-env-token` without prefix, read by every `devos_api` function from `request.headers` | §1.1, §1.2 |
| 2 | The token's recognisable format | Body; point 1; P:734; P:947 | Decided (its structure). The literal marker is fixed by W-C02-07 when it writes its scan (before the build), and used by W-C02-09 and W-C02-11 | §1.3 |
| 3 | A token's validity against the authority epoch | Task 3; B principle 9; B 3.27 | Decided | §1.4 |
| 4 | Which Supabase project issues which tokens (R3 G3) | R3 G3 | Decided | §1.5 |
| 5 | Where the tests of the role-class derivation run (R3 G3) | R3 G3; point 1 | Decided | §1.5 |
| 6 | Row 3's fail path, its three branches under the chosen form | N-131 (3); P:947; PC-21 item 4 | Decided | §2.1 to §2.3 |
| 7 | N-063 D07, U1, U3 (database side), Q1, B4 | N-131; EV2 §4 (b) | D07, U1, U3 answered; Q1 and B4 carried as conditional questions to Batu, asked only if §2's branch 1 (a), 2 or 3 is observed | §2.4, §12 |
| 8 | Whether N-131 item (1) is met | N-131 (1) | Decided: met (PC-21 items 7 and 8; D-019 (a); D-020 (a)) | §2.5 |
| 9 | Where the session's inability to read a network secret is observed | N-131's line of 2026-10-12; PC-21 item 9 | Decided: the installation environment's self-check after Batu's step 4; each step-5 session; C03 test 3 | §3.2 |
| 10 | Whether the header path is observed before W-C02-09 builds the identity chain on it | Point 3 | Decided: yes, on the identity chain's first part, before the rest is built | §3.3 |
| 11 | The plan text that calls row 3's facts observed (P:235, P:723, P:734, B:446) | N-131's dated line; N-209 (2) | Corrected by PC-40 (W-C02-16), merged at `eba94b1`, whose text leaves where they are observed to this design; PC-43 places 14 to 16 name it at P:235, P:723 and P:734; B:446 stays as PC-40 left it, and the choice goes into PC-42's table of C02's choices (PC-43's entry "To apply after PC-42"; EV-C02-004 P-2) | §9.3, §17 |
| 12 | Each role class's can and cannot, in every direction | Point 4; B §2; R2 §5 (b) | Decided; every cell filled from B §2 and §4 (EV-C02-004 X-18) | §4.1 |
| 13 | S8 line 1: `devos_kurulum`'s "Cannot", the rights it keeps, and when each ends; against B:237 and the transfer (R3 G9) | N-136; R3 G9 | Decided; its verdict right limited to the ledger transfer's copies, which B:379 states (PC-43 place 13; EV-C02-004 "outside the pair"); the conflict with the transfer named and settled by origin (I-8) | §4.2 |
| 14 | S8 line 2: a call refused when the caller's role class differs from the claim's | N-136 | Decided: built in C02 task 4, for every call that takes a claim token (EV-C02-004 X-16); N17 extended | §4.3 |
| 15 | S8 line 3: a claim refused without a registration of the same role class (R3 G11; R4 "Flags" 1) | N-136; R3 G11 | A later stage's: moved to C04, with SessionRecord and `register_session`; carrier N-223 on `plan/work/C04.md`; deadline: when `register_session` is built in C04, and before C06 creates routines | §4.4 |
| 16 | Whether N04 and N08 run with the `devos_kurulum` token in C02 | N-136; N-137; C:125 | Decided: N04 in C02; N08's database part also in C02 (C:125's stage gains C02); N-137's C03 run stays | §4.5 |
| 17 | N17 covering a claim used with another role class's token | N-136 | Decided | §4.5 |
| 18 | Who issues the `devos_kurulum` token, when, in which form, where it is kept | N-125; KI row 21 | Decided | §5.1 |
| 19 | Who issues the `devos_ci` key, in which form, where it is kept (which repository's secrets) | N-125; R3 G4; KI row 22 | Decided | §5.2 |
| 20 | When `devos_ci` is issued; whether it is needed at task 0 (R3 G5) | R3 G5 | Decided (EV-C02-004 Y-03): issued at step 4; not needed at task 0, since until it exists the pull-request checks read the migration job's run record (EV-C02-001) | §5.2 |
| 21 | How `deployment_drift` authenticates the migration job; from when the pull-request checks run it (R3 G6) | R3 G6 | Decided by W-C02-03 (EV-C02-004 Y-02, Y-03): the migration job by its direct login, the one branch before the derivation, which this record names (§1.6); the pull-request checks with `devos_ci` from step 4 | §1.6, §5.3 |
| 22 | Whether `devos_backup`'s credential is needed before C09 for C03 test 8 and N26 (R1 2.4) | R1 2.4; KI row 29 | Decided: not needed; synthetic tokens in `devos-test`; the real credential at C09 | §5.4 |
| 23 | Section 12 item 1's text (R3 G2, G4) | N-125; R3 G2, G4 | Decided: PC-43 place 4 | §5.5, §9.1 |
| 24 | Whether a secret added to `devos-kurulum` reaches the running working session (R3 G14) | R3 G14 | Provisional: settled by the working session's self-check in the turn after Batu reports step 4 (the same day as the step) | §6.1 |
| 25 | That the working session runs in `devos-kurulum` | P:639 | Provisional: shown by the same self-check | §6.1 |
| 26 | How each environment's real token is tried from inside it when the executor cannot start sessions (R3 G7; "Batu's steps" row 5) | R3 G7 | Decided; each session records its `DEVOS_ENVIRONMENT` value and network result beside the role class it sees, which catches a token in the wrong environment and an environment at the wrong level; what stays unchecked is named (CHK-C02-010 C2) | §6.2 |
| 27 | A path for the owner-only functions (`issue_env_token`, `revoke_env_token`, F08 (c)'s epoch increment) in tests; "Batu's steps" row 1a | Point 6; B:46 | Decided (EV-C02-004 X-07, Y-05): the migration job's `devos-test` step, no step of Batu's; F08 (c)'s epoch change is a revocation; row 1a's owner-only lines not needed, and row 1a holds only the exposure of `devos_api` (row 39) | §6.3 |
| 28 | Batu's step text for rows 2 to 5, with S4 (d), S4 (e), S5 and S6 | N-136; point 7 | Decided | §7 |
| 29 | The network level of each environment (S6) | N-136; P:652 | Decided, as the plan sets it | §7 |
| 30 | N-208: trigger, owner, and the work each re-reading comes before | N-208 | Decided: its own note N-220 on `plan/work/C02.md`, carried forward by each stage's work list | §8 |
| 31 | Each other item of EV4 section 8 that bears on C02, and whose plan change makes it | Point 9 | Named with its carrier | §9.2 |
| 32 | The time each order, batch and hand-off adds on the critical path | Point 10; PC-23 | Decided | §10 |
| 33 | N-125, N-131, N-208 closed; N-136's design parts recorded; N-137, N-140, N-181, N-203 | Point 11 | Decided | §11 |
| 34 | How a refused call without a verified token is recorded | P:623; point 15 | Decided: as RejectedAttempt, with its reason code only, counted as EV-C02-002 DM-19 counts such calls (EV-C02-004 X-04 to X-06); the record's form and the count's key are W-C02-04's | §15 |
| 35 | `devos_ci`'s rights, given that every DevOS session is treated as able to read its key | §5.2 | Decided | §5.2 |
| 36 | The client path a session uses to call `devos_api`, and the guard's stop for strings of the token format | §1.6; P:734 | Another item's: W-C02-09 (the client) and W-C02-11 (the guard), before task 7 | §1.6 |
| 37 | S9's bridge, the installation's own uses of session tools, the recorder hook, the confirming tool list (N-136, N-181) | N-136 build parts | Another item's: W-C02-11, before task 7 | §11 |
| 38 | X1 within T-77 | N-136 | Another item's: N-092's plan text (W-C02-04) and the stages that build T-77's parts | §9.2, §11 |
| 39 | Exposing `devos_api` in each project's Data API settings (R5 S11) | R5 S11 | Decided (EV-C02-004 Y-06): asked once `devos_api` exists in both projects, in step 4's sitting (A), before the self-check; it moves into row 1's sitting if EV-C02-001's build shows the setting can be made before the schema exists | §7 |
| 40 | The header name's case (R5 R1) | R5 R1 | Decided: lower case | §1.1 |
| 41 | `request.jwt` against `request.jwt.claims` (R5 R2) | R5 R2 | Not needed: no JWT carries the token | §1.2 |
| 42 | A test that sends a synthetic token in the header itself | §6.3 | Decided: from the migration job's `devos-test` step only, outside DevOS sessions (EV-C02-004 Y-05) | §6.3 |
| 43 | N-209 (1) to (3) | N-209; point 17 | Another item's: PC-40 (W-C02-16), merged at `eba94b1` | §17 |
| 44 | The derivation every `devos_api` function calls first: its name, and the one function with a branch before it | EV-C02-004 X-01, Y-02 | Decided: `devos_private.caller_role_class(function_name)`; `deployment_drift` alone admits the migration job's direct login first | §1.6 |
| 45 | The claim token's form: random source and strength, hash, returned once, marker, guard stop | EV-C02-004 X-08; task 3 | Decided | §1.7 |
| 46 | `EnvToken.authority_epoch` (B:358): removed, or kept as informational | EV-C02-004 X-03 | Decided: removed (PC-43 place 7) | §1.4 |
| 47 | `revoke_claim`, `heartbeat`, `open_mission` and `revise_mission` in the matrix | EV-C02-004 X-11, X-17 | Decided | §4.1 |
| 48 | Who reads RejectedAttempt | EV-C02-004 X-13 | Decided: through the builder's read-only connection in `devos`, and in `devos-test` inside the migration job's step; `devos_kurulum` has no read | §6.2 |
| 49 | The token refusals' reason codes, and how calls without a verified token are counted | EV-C02-004 X-04, X-06 | Decided: the codes here; the count as RejectedAttempt counts them (EV-C02-002 DM-19's key) | §15 |
| 50 | Who writes the fixtures the real-token tests need in `devos`, and the Mission they hang under | EV-C02-004 X-10 | Decided: written with the `devos_kurulum` token, labelled synthetic, no synthetic `batu`-class record; the Mission's base and label are EV-C02-002's | §6.2 |
| 51 | How the Data API's own handling of the token's header (`request.headers`) is kept out of `devos`'s Postgres logs, and whether the builder's read-only connection reads them | CHK-C02-010 C3; point 14 | Decided: a check that keeps it out, by the executor (the statement-logging settings before sitting A; a count-only search of the logs with a positive control after the self-check and after B2); if it cannot be made, a documented, untested residual, owner the executor, recorded before sitting A. The connection offers `query_logs` **[Obs: the executor, 2026-10-12; `plan/ledger/C02-log.md` L-289]** | §3.1 F-g; §14 |

## 1. The token's form (point 1)

### 1.1 Decision

Each environment token is a **network secret of its own environment** (EV4 S5). Batu adds it to that environment's **Network secrets** with: the live project's host, which issues every token, as the only allowed website (§1.5); one custom header named `x-devos-env-token`, its prefix cleared; the token as its value. That is the documented form "For a header like `X-Api-Key` that takes the bare value, change the name and clear the prefix" **[Doc: CE "Add a secret", read 2026-10-10 (EV2 §1.3) and 2026-10-12]**.

A session calls a `devos_api` function as a Data API (PostgREST) remote procedure call to that host, with the publishable key in the `apikey` header, which "is mandatory and not configurable" **[Doc: SA "Use additional API keys", read 2026-10-12]**. The agent proxy adds `x-devos-env-token` to the request "after each request leaves the session's VM" **[Doc: CE "Add network secrets", read 2026-10-10 and 2026-10-12]**. Every `devos_api` function first calls the derivation (§1.6), which reads that one header from `request.headers`, hashes it (§1.7), finds the one non-revoked `env_tokens` row with that hash and returns its role class; nothing else gives a role class (B principle 8; B:45). The header name is lower case, as Supabase's own example reads a custom header (`current_setting('request.headers', true)::json->>'x-app-api-key'`) **[Doc: SA, read 2026-10-12]**; that is the case the function reads and the step text gives.

No DevOS credential goes into any environment variable, setup script, repository, record or chat. The publishable key and other non-secret settings (`DEVOS_ENVIRONMENT`) may be variables (EV4 S5; P:646).

**Reasons.**
- It is the only documented form whose value the session cannot read: sessions use the key "without seeing the key"; "the key doesn't appear in the session's environment variables or in any file"; "You can't view the value again after saving" **[Doc: CE, read 2026-10-10 (EV2 F3), 2026-10-11 (EV4 S5) and 2026-10-12 (R5 C1, C3)]**.
- So it meets criterion 26 as the PC-08 note reads it, a setting that "carries that environment's token to the database in a separate header without the session being able to read it" (P:235), and C00's sixth condition as the PC-18 note reads it, where a secret is visible in an environment variable "where the session can read it" (P:924). There is no departure from a criterion of Batu's, so nothing here goes to him.
- The Supabase side is documented: a function reads a request's headers from `request.headers` **[Doc: SA, read 2026-10-12 (R5 R1)]**, for the Data API only, not Realtime or Storage ("`pgrst.db_pre_request` … only works with the **Data API**"). DevOS's sessions use only the Data API.
- A secret's hosts stay reachable whichever network level is chosen: "Whichever level you pick, sessions can still reach these", a list that names the hosts listed on the environment's network secrets **[Doc: CE "Access levels", read 2026-10-10 and 2026-10-12]**. So each environment's network level follows its work (S6), not the token.
- One token can be revoked alone, by `revoke_env_token` (B:46).
- It adds no component.

**Why a custom header and not `Authorization`.** Supabase reads `Authorization: Bearer` as a user JWT and requires a separate `apikey` header **[Doc: R5 R3, signing-keys page, read 2026-10-12]**; a DevOS token there would be read as a malformed JWT **[Inf]**.

### 1.2 Alternatives weighed

| Alternative | What it would give | Why it was not chosen |
|---|---|---|
| (a) An environment variable (EV2 F2) | The simplest setting | The environment's sessions can read it: "Anyone who uses the environment can read the values" **[Doc: CE "Set environment variables", read 2026-10-12]**. It departs from criterion 26 as the PC-08 note reads it and from C00's sixth condition as the PC-18 note reads it, so it would be Batu's decision (point 12). It needs Full or a Custom list, since the Trusted list names no Supabase domain **[Doc: EV2 §1.3]**. Kept only as the conditional fallback of §2.1, which goes to Batu before anything relies on it |
| (b) A network secret in a custom header, read from `request.headers` (S5; R5 R1) | §1.1 | Chosen |
| (c) A network secret carrying a signed JWT whose `role` claim switches the database role (R5 R3) | PostgREST switches to a DevOS role per request, so Postgres grants enforce the role class | It is revoked only by rotating the signing key, which ends every token at once; `exp` "must be set", so every token expires and is issued again, a recurring step for Batu (criterion 21); someone must hold the private signing key, a new key to keep; whether a custom role works in the claim, and the grants `authenticator` needs, are not stated **[Doc: R5 R3, read 2026-10-12]**. JWTs are not used, so R5 R2 (`request.jwt` against `request.jwt.claims`) does not arise |
| (d) An Edge Function gate (row 3's first branch, P:947) | A function at the project's host receives every header, verifies the token and calls the database | A second component that must itself hold a database credential to call the database, and a second place to secure; not needed while the Data API passes the header, as documented. It stays row 3's first branch (§2.1) |
| (e) Per-role database users (EV2 §4 (b); N-063 D07) | A Postgres login per environment, with grants as the boundary | Its credential is a database password used over the Postgres protocol; a network secret is attached to HTTP requests "when the request's host matches" **[Doc: CE "Which requests get the secret", read 2026-10-12]**, so the password would sit in a variable the session can read **[Inf]**, the departure of (a). Not chosen |
| (f) FR-05 N3's option: keep each token where the session cannot read it, as a platform option (EV2 §4 (a)) | — | This is (b) |

### 1.3 The token's format

**Decision.** A token is a fixed class marker followed by a random part. The random part is drawn from the database's cryptographic random source at the strength of a 256-bit key, in a URL-safe alphabet. The marker names DevOS's environment tokens and the format's version; it is the same for every token and is chosen before any token exists. Its uses: the guard stops strings of the format in URLs and outbound text (P:734; P:947), the leak check does the same (C03, C04), the scans of W-C02-07 point 7 and W-C02-12 point 9 find them, and a session's self-check counts them (§3.2). The claim token has the same structure with a marker of its own (§1.7).

**The literal marker** is fixed by W-C02-07 when it writes its scan, since the tests come before the build. W-C02-09's issuing function and W-C02-11's guard pattern use the same marker. Neither this record, PC-43, the step text nor the key inventory writes it (§14). The marker holds nothing of any token's random part, so knowing it narrows nothing an attacker must guess **[Inf]**.

**Alternatives.** No marker, so that a token is only random: no outbound check could then tell a token from any other string, and 6.7's network row relies on a format (P:734). Not chosen. A marker per role class: an observer would learn which role a leaked token holds, and it stops nothing more. Not chosen.

### 1.4 Validity

- A token is verified while it is not revoked (EV-C02-004 X-04: "verified" and "valid" mean the same). `revoke_env_token` sets `revoked_at` and increments the global authority epoch (B:46). The global authority epoch is one row, and its lock order, the epoch last, is EV-C02-002's decision DM-01, which this design follows (EV-C02-004 X-02). The increment ends every claim of the old epoch (B principle 9; F08 (c)), not the other environments' tokens. If every token were bound to its epoch, one revocation would end every environment's token, and Batu would issue them all again (criterion 21) **[Inf]**; EV-C02-004 X-03 keeps this reading. At a restore, the old project's tokens are revoked and new ones issued in the new project (P:410).
- **`EnvToken.authority_epoch` (B:358) is removed** (PC-43 place 7; EV-C02-004 X-03). Reason: no rule reads it, and a field named like the global authority epoch on the token is what gave two readings of a token's validity (R-45 X-03, T-4); `issued_at` and the issue and revocation events (Event, `origin = owner`, EV-C02-002 DM-31) already give the epoch at which a token was issued. Alternative weighed: keep it with the meaning "the epoch when the token was issued, informational, not checked". Not chosen: the misreading stays possible, and a test would be needed to show that nothing checks it.
- One token per environment, issued by `devos` (§1.5). A renewal is: issue a new token, delete the secret and add it again with the new value (a secret "can't" be edited **[Doc: CE "Add a secret", read 2026-10-12]**), revoke the old token.
- The token exists only in its secret; `env_tokens`, EnvToken's table, keeps its hash (B 3.27).

### 1.5 Which project issues which tokens, and where the derivation is tested (R3 G3)

- **`devos` (live)** issues every DevOS token: the three environments' tokens, the `devos_kurulum` token (§5.1) and the `devos_ci` key (§5.2).
- **`devos-test`** issues only the synthetic tokens the migration job's `devos-test` step issues and discards in each run (§6.3). No route but the migration job reaches `devos-test` (EV-C02-004 Y-05), so no environment holds a `devos-test` token, the installation environment included (revised; see the alternatives).
- The three DevOS environments' work is on live state, and nothing in it needs the test project; a second secret in each would double Batu's steps for no work's need **[Inf]**.
- **The tests.** The database tests of the role-class derivation (W-C02-07's: N04, N08's database part, N17, F06's `role_class`, the authorization test, the refusals of §15) run in `devos-test`, on real PostgreSQL, with synthetic tokens, inside the migration job's `devos-test` step after a merge (B:3; P:998; W-C02-09 point 1; EV-C02-004 Y-01, Y-05). The header path with a real network secret is first observed in `devos`, by the installation environment's self-check, a read with its own `devos_kurulum` token (§3.3). Each environment's real token is tried in `devos` from inside that environment (§6.2): C02's Acceptance line "With each environment's real token, …" and W-C02-12; these are the real-token tests (EV-C02-004 X-10, T-10). C03 test 1 and K06 repeat with real tokens (C03).
- **Alternatives.** A token per environment in each project, so that the real-session tests run in `devos-test`: it doubles Batu's steps and puts a second credential in each environment, while the Acceptance asks about "each environment's real token", the live one **[Inf]**; EV-C02-004 X-10 rejects it too. Not chosen. `devos-test` only in C02, the live tokens at C03: the real-token line is C02's, and the environments work on live state. Not chosen. A second `devos_kurulum` token issued by `devos-test`, so that the header path is first observed on the test project and the installation can make dry runs there: this record's first version chose it. Not chosen now: EV-C02-004 Y-05 makes the migration job the only route to `devos-test`, the first observation in `devos` is a read that returns only a role class and changes nothing (§3.1), and dropping it removes an owner-only line and a secret from Batu's step 4.

### 1.6 The derivation, and what the build and the guard carry (named here, built elsewhere)

**The derivation** (EV-C02-004 X-01, Y-02). One private function, `devos_private.caller_role_class(function_name)`, not exposed through the Data API. It reads the `x-devos-env-token` header from `request.headers`, hashes it (§1.7), and returns the role class of the one non-revoked `env_tokens` row with that hash. If the token is not verified, it records the refusal as RejectedAttempt (B 3.13; counted as EV-C02-002 DM-19 counts calls without a verified token, with the calling function's name and the reason code of §15) and refuses the call with that reason code. Every `devos_api` function calls it first, before any other check, then checks its own list of permitted role classes (B:47). `deployment_drift` is the one function with a branch before it: it first admits a direct login whose `session_user` is the migration role (the migration job, EV-C02-001), and every other caller passes the derivation (EV-C02-004 Y-02; PC-41 words B:45 and B:387). `token_role_class()` is a read built on it: it returns the role class the caller's verified token gives, and is otherwise refused with its reason code like any call. Alternative weighed: the check written out inside each function. Not chosen: copies drift, and one function gives W-C02-07 one place to break.

- **W-C02-09:** the derivation; `token_role_class()` (PC-43 place 8); RejectedAttempt in the form W-C02-04 decides (§15); the claim token (§1.7); and the client path a session uses: a small script in the repository that calls the Data API with the publishable key from its variable, lets the proxy add the header, and never prints request headers.
- **W-C02-11 (before task 7):** the guard allows that client path in DevOS's sessions, and stops strings of the environment token's format and of the claim token's format (§1.7) in URLs and outbound text (P:734), each shown with a planted synthetic case.
- **Everywhere:** no function returns the header's value or puts it in an error, a notice or a log line (§14).

### 1.7 The claim token (EV-C02-004 X-08; C02 task 3)

**Decision.**
- **Random source and strength.** Drawn by `claim` from the database's cryptographic random source, at the strength of a 256-bit key, in a URL-safe alphabet: the same generator as the environment token's (§1.3).
- **Marker.** A fixed marker of its own, different from the environment token's, followed by the random part. Like the environment token's marker, it is fixed by W-C02-07 when it writes its scan, and neither this record, PC-43 nor the step text writes it (§14).
- **Hash.** Assignment keeps only `claim_token_hash` (B:150): SHA-256 of the whole token, computed in the database, unsalted, since the random part already has a 256-bit key's strength **[Inf]**. The environment token's `token_hash` is computed the same way, so both kinds have one hash rule. That PostgreSQL provides the function is not read here; W-C02-09's build confirms it.
- **Returned once.** Only `claim`'s result carries the token. No function returns it later or puts it in an error, notice or log line; `heartbeat`, `release` and every effect take it as a parameter and compare its hash, with the generation and the global authority epoch (B 3.5; EV-C02-002 A1.5), and with S8 line 2 (§4.3).
- **The guard stops it.** The guard and the leak check stop strings of the claim token's format in URLs and outbound text, as for the environment token (W-C02-11; C03, C04), except on the client path to the live project's host (§1.6). W-C02-12 point 9's scan of the repository, branches, issue #6 and the records looks for both formats. The session's own format scan (§3.2) counts only the environment token's format, since a session holds its own claim tokens by design.
- **Lifetime.** A claim token acts only while its claim is active, in its generation and epoch (B 3.5). It is the one DevOS credential a session can read (K-9 item 2 (b)); S8 line 2 keeps it from acting under another role class's environment token.

**Alternatives.**
- No marker, a random string only: no outbound check could tell a leaked claim token from any other string, and `devos` is a public repository. Not chosen.
- The environment token's marker: the session's scan would count its own claim tokens as findings of §2.2, and a leaked string would not say which kind of credential to revoke. Not chosen.
- A signed token carrying the claim's ID, generation and epoch: the database looks the claim up anyway (B:150 keeps the hash), and a signing key would be a new secret to keep. Not chosen.
- A slow password hash (with salt and work factor): built for low-entropy secrets; at 256 random bits it adds cost to every effect and no strength. Not chosen.
- A shorter random part (for example 128 bits): enough against guessing, but one generator and one strength for both kinds keeps one rule to test. Not chosen.

## 2. Row 3's fail path under the chosen form (point 2)

Plan C01 row 3's fail path has three branches (P:947; PC-21 item 4: "The fail path is unchanged and is decided there").

### 2.1 Branch 1: "If the header cannot be added: an Edge Function gate that authenticates."

- **Can it arise?** Under S5, yes, in three ways: (1a) the proxy does not attach the secret to the project host's requests; (1b) the Data API does not pass the custom header into `request.headers`; (1c) the header arrives under another name or case. The documentation says none of these happens (CE; SA). That the two together carry the token into a function is an inference that joins two vendors' documents (R5 R1).
- **What would show it.** The self-check of §3.3: `token_role_class()`, called over the real path, is refused with reason code `missing` while the secret is listed and not marked **Not sent** (CE: "If the list marks a secret **Not sent** instead, the note under it says why").
- **What follows.** (1b) or (1c): the Edge Function gate at the same host verifies the token and hands the role class to the database through the same setting the functions read. The derivation, the functions and their tests stay as they are; only the transport changes **[Inf]**. Telling (1a) from (1b): the gate's first version answers only whether the header reached it, never its value. (1a): no gate at the host can help, so the network-secret form fails. The only documented form left is the variable, which departs from criterion 26 as the PC-08 note reads it: Batu's decision (question Q-A, §12), before anything relies on it. C02's real-token work waits for his answer; the rest of C02 goes on.

### 2.2 Branch 2: "If the session can see its own token, the threat model decides."

- **Can it arise?** Under S5 the documentation says no (CE; EV2 F3). It could arise in three ways: the platform's statement fails; a DevOS function echoes the header (closed by §14's rule and its test); or the token is written somewhere readable by mistake.
- **What would show it.** A session's format scan (§3.2) counting a token-format string other than its own planted control.
- **What follows.** The token is revoked and renewed at once (P:648). The work that relies on that environment pauses. If the scan finds the newly issued token again, the cause is the platform, and visibility departs from criterion 26 as the PC-08 note reads it: Batu's decision (Q-A), read with EV2 §4 (a), so the threat model alone does not decide a departure from a criterion of his.

### 2.3 Branch 3: "If a session can read another environment's token, separation of authority fails, and the identity chain is redesigned before C02."

- **Can it arise?** Reading another environment's token through its settings does not arise on the documented statement "You can't view the value again after saving" (CE). Reading it through another session does not arise either, since that session cannot read its own (CE). *Using* another environment's token by acting in a session of that environment is the control surface, R1 of EV4 §4, which Batu accepted with D-020 (a) until D-003's re-assessment at C03.
- **What would show it.** A token-format string found by the scan in a session of another environment; or a database call whose role class (recorded per state-changing call and per refusal: F06; EV-C02-002 DM-19, DM-36; EV-C02-004 X-19) matches no session the executor knows of. From C06, X1 also flags it.
- **What follows.** The plan's branch 3: separation fails, the token is revoked, and the identity chain is redesigned before C02 relies on it. D-020's residual then no longer holds as accepted, so D-020's options (separate accounts) go back to Batu (Q-B, §12). N-063 B4 (a second machine account, or his subscription token in a private repository) arises only here.

### 2.4 The N-063 rows carried to N-131 (EV2 §4 (b))

| Row | Question | Disposition |
|---|---|---|
| D07 | How a role is identified: the token header or its fallback; per-role database users as a further fallback | Answered: the network-secret header (§1.1), with the Edge Function gate as row 3's first branch (§2.1); per-role database users weighed and not chosen (§1.2 (e)) |
| U1 | Secrets one session cannot read from another | Answered at the documentation level: a secret's value cannot be viewed after saving and is not in the VM **[Doc: CE]**; the session-side observation is §3.2; acting through another session is R1, accepted with D-020 (a) |
| U3 (database side) | Per-role access over HTTPS under the current key system | Answered: the Data API with the publishable key in `apikey` and the token in a custom header read from `request.headers` **[Doc: SA, read 2026-10-12]**; the joined path is first observed by §3.3 |
| Q1 | If U1 fails, which fallback | Carried: §2.2 and §2.3; Batu's questions Q-A and Q-B (§12), asked only if the observation shows it |
| B4 | Only if U1 fails: a second machine account, or his subscription token in a private repository | Carried with Q1: only on §2.3's path, through Q-B |

### 2.5 N-131 item (1)

Met. PC-21 named the design paths that do not depend on the two unsettled facts: item 7 for row 17's cross-environment part, item 8 for N-109. Batu answered D-019 (a) on 2026-10-11T05:49:08Z, so N-109 closed as a residual he accepted, not as a shown result, and C00's sixth condition is no longer provisional on it (P:926). He answered D-020 (a) on 2026-10-11T05:59Z, the account option row 17's fail path sends him. EV4 is the structure for (a). What remains is the re-assessment of D-019's and D-020's residuals with D-003 at C03 (their `reopen_if`), carried by N-137.

## 3. Each fact labelled, and where it is observed (point 3)

### 3.1 The facts the design rests on

| Fact | Label and source | First observed (where; before which work) | If not observed |
|---|---|---|---|
| F-a. A session cannot read a network secret | **[Doc: CE "Add network secrets", read 2026-10-10 (EV2 F3), 2026-10-11 (EV4 S5), 2026-10-12 (R5 C1, C3)]** | §3.2: the working session in `devos-kurulum` right after step 4; then each step-5 session (W-C02-12 point 9); C03 test 3 | It stays a documented, untested residual, labelled so |
| F-b. The proxy attaches a secret in the header the environment names to requests for its listed hosts, at every network level | **[Doc: CE "Which requests get the secret", "Access levels", read 2026-10-10 (EV2 F4) and 2026-10-12 (R5 C4)]** | §3.3 | §2.1 |
| F-c. A function reads a request's custom header from `request.headers` through the Data API, not through Realtime or Storage | **[Doc: SA, read 2026-10-12 (R5 R1)]** | §3.3 | §2.1 |
| F-d. F-b and F-c together carry the token into a `devos_api` function | **[Inf]**: it joins two vendors' documents (R5 R1) | §3.3, before W-C02-09 builds the rest of the identity chain | §2.1 |
| F-e. The `apikey` header is mandatory | **[Doc: SA, read 2026-10-12]** | §3.3 | — |
| F-f. The API gateway's logs omit custom headers: "Other headers still reach the application and client but are omitted from these logs" | **[Doc: SL, read 2026-10-12 (R5 R4)]** | Not observed here | §14's rules do not rely on it alone |
| F-g. Postgres logs can hold statement text and error details ("For `postgres_logs`, statement text and error details can appear in `event_message`"). The Data API puts every request header, the token's header among them, into `request.headers` ("JSON object of the request's headers"). That it does so through a statement in the request's transaction, which Postgres logging could record with the header's value, depending on the project's statement-logging settings (not read), is an inference (CHK-C02-010 point 14). This path is outside §14's rule for DevOS's functions (CHK-C02-010 C3) | **[Doc: SL "Sources"; SA, the request-information table; read 2026-10-12 (R5 R1, R4)]**; **[Inf]** for the statement and its logging | §14's log check, by the executor: part 1, `devos`'s statement-logging settings, before sitting A is asked; part 2, a count-only search of `devos`'s logs with its positive control, right after §3.3's self-check (before W-C02-09 builds beyond the first part) and again after B2's sessions (before W-C02-12's record is judged) | For DevOS's functions, §14's rule. For the Data API's own path, if the check cannot be made: a documented, untested residual, owner the executor, recorded before sitting A is asked (§14) |
| F-h. A secret added to an environment reaches a session already running there | Not stated **[Doc: CE, read 2026-10-12]**; **[Inf]** as §6.1 | §6.1 | §6.1 |
| F-i. Anyone with write access to a repository can read all its repository secrets | **[Doc: R5 G1, docs.github.com secure-use, read 2026-10-12]** | Not observed here | §5.2's rule |
| F-j. An environment secret reaches only jobs that reference the environment, after its rules pass; a branch rule is matched against the run's `GITHUB_REF` | **[Doc: R5 G2, G3, read 2026-10-12]** | — | §5.2 |
| F-k. Network secrets are available on Pro and Max plans, and no charge is named | **[Doc: CE "Requirements"; R5 section 5, read 2026-10-12]** | Batu's step 4 | §12 |
| F-l. A secret cannot be edited, only deleted and added again; a network-level change reaches running sessions "within about a minute" | **[Doc: CE, read 2026-10-12]** | — | — |
| F-m. The working session runs in `devos-kurulum` | The plan gives `devos-kurulum` the builder's installation work (P:639); not observed in any record read here | §6.1 | §6.1 |

The first observation (§3.3) sends no input: it is `token_role_class()` on `devos` with the installation environment's own `devos_kurulum` token, a read that returns only a role class and changes nothing when the token is verified (a refusal is counted as RejectedAttempt, the record §15 designs). The token is DevOS's own credential, not personal or business data, and nothing is written for the check, so plan Section 8 item 13 has no fixture or probe input to apply to here; the format scan's planted string is made up and labelled synthetic (§3.2). The database tests use only synthetic tokens they issue and discard themselves, inside the migration job's `devos-test` step (§6.3), and the real-token tests' fixtures in `devos` are labelled synthetic (§6.2). (Revised: the first version made this observation on `devos-test` with a second `devos_kurulum` token, which §1.5 now drops.)

### 3.2 The session's own format scan (where non-readability is observed)

Right after the secret is added, the session:
1. puts a synthetic string of the token format, labelled synthetic and made by the session, into a scratch file;
2. scans its environment variables, and the files it can read in its home, temporary and configuration folders (the user-level skills folder included) and in the repository clone, for strings of the format, printing only a count per place;
3. checks that the planted string is counted (the positive control), then deletes it;
4. treats any other count as a finding: the token is revoked and renewed, and §2.2 applies.

A place the guard does not let it read is recorded as "could not check" (plan Section 8 item 14), never as zero.

**Where it runs.** (i) The working session in `devos-kurulum`, right after step 4 (§3.3). (ii) Each step-5 session (§6.2; W-C02-12 point 9 places it there). (iii) C03 test 3's "there is no secret key in the agent environment" (N-107; N-222).

**Limits.** It cannot see process memory or the proxy, and it would miss a token stored in another encoding. It shows only that no readable copy was found in the places scanned, not that the token is unreadable "by any route" (row 3's words). The documentation states nothing broader either (EV2 §2 item 2).

### 3.3 The header path, observed before W-C02-09 builds on it

**Order.**
1. W-C02-07 writes the tests of the identity chain's first part: `env_tokens`, the global authority epoch's row, Event with its `origin` (B 3.13), `issue_env_token`, `revoke_env_token`, the derivation, `token_role_class()` and RejectedAttempt. Event and the epoch row are in it so that the first tokens' issue at step 4 has its events (EV-C02-004 X-15; EV-C02-002 DM-31, DM-36).
2. The first part merges through the migration path: the migration job applies it to `devos-test`, compares and runs its tests there, and applies it to `devos` only if all three succeed (EV-C02-004 Y-01; W-C02-09 point 1).
3. Batu does sitting A: the exposure of `devos_api` in both projects, then step 4 (§5.1; §7 part A; EV-C02-004 Y-06).
4. The working session calls `token_role_class()` on `devos` over the real path. ✔ It answers `devos_kurulum`, and the format scan finds nothing beyond its planted control.
5. W-C02-09 builds the rest of task 3's functions only after step 4 of this list. If step 4 fails, §2.1 applies.

**Why before.** Plan Section 9's ordering principle: "What is most uncertain, and would cost the most if it turned out wrong, is tested first". F-d is the most uncertain link in the chain. Observing it first costs one sitting of Batu's, which step 4 needs anyway.

**What is rebuilt if the path fails.** Only the transport (§2.1): the Edge Function gate hands the role class over through the same setting the functions read **[Inf]**. So being wrong costs little either way. The only cost of observing first is the wait for step 4, which W-C02-08's schema work overlaps (§10).

## 4. Role classes and S8, for task 4 (point 4)

### 4.1 What each role class can and cannot do

Rule for every cell: a function's permitted role classes are listed in its definition (B:47), and a role class not listed is refused, never given a default (plan 6.2; Section 8 item 14). ✔ allowed; ✘ refused. Every cell is filled from Appendix B section 2 (B:35 to B:41, with PC-43 place 5), section 4 (B:370 to B:388, with PC-43 place 13) and B 3.23, or from the decision named in it; none is left to another record (EV-C02-004 X-18; revised: the first version left nine cells "—").

| Operation (B section 4) | `devos_calisma` | `devos_denetim` | `devos_sinav` | `devos_kurulum` | `devos_ci` | `devos_backup` |
|---|---|---|---|---|---|---|
| `token_role_class()` | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Need and decision records; opening work other than missions (B:36) | ✔ | ✘ | ✔ exam tasks only, as ordinary work (B:38) | ✔ the installation's own (the transfer, and after it) | ✘ | ✘ |
| `open_mission`, `revise_mission` (B:371; EV-C02-004 X-17) | ✘ (B:36: "other than missions") | ✘ | ✘ | ✔ until C06 builds `answer_decision`'s path, which then names its role; only on a `batu`-class decision, answered or accepted (EV-C02-002 DM-23) | ✘ | ✘ |
| `claim`, `heartbeat`, `release` (B 3.5; `heartbeat` as `claim`, EV-C02-004 X-11) | ✔ | ✔ its review work | ✔ its exam work | ✔ the installation's work items | ✘ | ✘ |
| `revoke_claim` (EV-C02-002 DM-29; EV-C02-004 X-11) | ✘ | ✔ | ✘ | ✘ | ✘ | ✘ |
| Any call that takes a claim token (an effect, `heartbeat`, `release`) when the claim's role class differs from the caller's (S8 line 2; EV-C02-004 X-16) | ✘ | ✘ | ✘ | ✘ | ✘ | ✘ |
| Contributions, candidates, products, findings, context, proposals, external-effect intents and their observations (B:36; B 3.10, 3.12) | ✔ | ✘ (B:37) | ✘ products (B:38) | ✔ the installation's own records | ✘ (§5.2) | ✘ |
| Reviews, verdicts and acceptance; review of rule and control changes; authority approval for high-impact merges; advancing recovery stages (B:37; B:379) | ✘ (B:36; N04) | ✔ | ✘ (B:38) | ✘, except the ledger transfer's copies of the installation's checker verdicts and acceptances, through the transfer's path, until C03 (§4.2; PC-43 places 5 and 13) | ✘ (B:40) | ✘ |
| Effort-reduction approval; standing effort policies (B 3.18) | ✘ | ✔ | ✘ | ✘ | ✘ | ✘ |
| Release activation (C05's form, B 3.14) | ✘ | C05's form | ✘ | ✘ | ✘ | ✘ |
| `EvalRun` and `Competence` writes; reading `EvalRun`, the exam records and the fact that a task is an exam (B 3.15; EV4 S1, S2) | ✘ | ✘ | ✔ | ✘ | ✘ | ✘ (C09's export design, §5.4) |
| `competence_summary(role)` (B 3.15) | ✔ | ✔ | ✔ | ✔ | ✘ (not among B:40's reads) | ✘ (B:41: only `mark_exported`) |
| Reading review verdicts, decisions, current authority and epoch (B:40) | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ read only, for the export (B:41; C09) |
| Fingerprint matches (LeakFingerprint, B 3.23: "Only `devos_ingest` writes; `devos_ci` reads") | ✘ | ✘ | ✘ | ✘ | ✔ | ✘ (C09's export design, §5.4) |
| Recording a check's result (B:40's "writing observations", narrowed to the results of its own checks, §5.2) | ✘ | ✘ | ✘ | ✘ | ✔ | ✘ |
| Reading RejectedAttempt (EV-C02-002 DM-19; EV-C02-004 X-13) | ✘ | ✔ | ✘ | ✘ | ✘ | ✘ (C09's export design, §5.4) |
| `deployment_drift` (B:387) | ✘ | ✘ | ✘ | ✘ | ✔ | ✘ |
| `mark_exported`; reading for the export (B:41) | ✘ | ✘ | ✘ | ✘ | ✘ | ✔ |
| `ingest_source`; writing sources, chunks, vectors and fingerprints (B:39; B:376; from C04) | ✘ | ✘ | ✘ | ✘ | ✘ | ✘ (`devos_ingest` only) |
| `issue_env_token`, `revoke_env_token` (B:46) | ✘ | ✘ | ✘ | ✘ | ✘ | ✘ (the project owner only) |
| A direct write to any table (B principle 1) | ✘ | ✘ | ✘ | ✘ | ✘ | ✘ |

Notes on the cells. The row "Reading review verdicts, decisions, current authority and epoch" is no separation line: B:36 to B:38 refuse the environments, among reads, only the exam records, so its cells are positive controls. The migration job reaches `deployment_drift` by its direct login, the one branch before the derivation (§1.6; EV-C02-004 Y-02); it has no role class and no column. The builder's read-only connection, which reads RejectedAttempt in `devos` (§6.2), is not a role class either.

**Tests, in every direction.** Each ✘ cell, with that column's token, is a negative case of W-C02-07's authorization test, run in `devos-test` inside the migration job's step (synthetic tokens; §6.3). The separation lines are tried again by W-C02-12 with each environment's real token, from inside it. Each ✔ cell is a positive control. Every column is taken against every row, not only working against audit (R2 §5 (b)). `devos_ingest` arrives in C04 (B:98) and has no column here; the row `ingest_source` is tried from C04.

### 4.2 S8 line 1: `devos_kurulum`

**Cannot.**
- Issuing tokens (B:35).
- Reading or writing the exam records and the exam fact: always, until C12.
- Any verdict, acceptance, version activation, approval of a rule or control change, effort-reduction approval or authority approval for a high-impact merge that a rule counts as the audit environment's: always.
- Any verdict or acceptance other than the ledger transfer's copies (below).
- Reading RejectedAttempt (EV-C02-004 X-13; §6.2).

**Keeps, with when each ends.**
- **Installation operations:** the ledger transfer (task 8; W-C02-06), and after it the installation's own records through `devos_api` (its work items and claims on them, log events, decisions, findings). They end at C12, when `devos-kurulum` closes (P:644) and its token is revoked (KI row 21).
- **Opening and revising a Mission** (`open_mission`, `revise_mission`), only on a `batu`-class decision that is answered or accepted (EV-C02-002 DM-23), which the transfer brings in and the real-token tests' fixtures rest on (§6.2). It ends when C06 builds `answer_decision`'s path, which then names its role (EV-C02-004 X-17).
- **The ledger transfer's copies of the installation's checker verdicts and acceptances,** written as Review, Verdict and Acceptance through the transfer's own path, under role class `devos_kurulum` with independence `fresh_context_subagent`. No rule counts them as the audit environment's. `devos_kurulum` writes no other verdict or acceptance. The right ends when C03 hands binding review to the audit environment (P:872; P:1013); N-222 on `plan/work/C03.md` carries that end. B:379 ("Review … Only `devos_denetim`") says so (PC-43 place 13).

**Which of EV-C02-004's two options, and why** ("outside the pair": limited to the transfer's copies, or removed). **Limited.** Task 8 moves the checker verdicts into Review and Verdict (R1 §4), and only two role classes could write them: `devos_kurulum`, under its true origin, or `devos_denetim`, which would make an installation self-check look like an audit verdict (criterion 30). Removing the right would leave the transfer no honest writer. Limiting it to the transfer's copies closes what the first version left open: a verdict written directly with the `devos_kurulum` token, outside the transfer, which any installation session could write. The database tells a copy apart by the transfer's own path, which W-C02-06 designs (for example, a transfer function permitted to `devos_kurulum` only, while `record_verdict` and `accept` refuse it); a direct call is refused, and N04 shows it (PC-43 place 9). Verdicts the installation's checkers give after the transfer's first run and before C03's hand-over enter the database only by that path, as W-C02-06 designs its later runs; until then they stay in their check records under `evidence/` (I-8).

**Against B:237.** B:237 holds as written: "Binding verdicts and acceptance are written only with the `devos_denetim` role". The transfer's copy is not a binding verdict in the database's rules. It records the installation's checker verdict, which plan Section 9 makes the installation's binding review until C03 (P:872), and the database counts it nowhere a rule needs the audit environment.

**Against the roles W-C02-06 designs for the ledger transfer (R3 G9).** The conflict: task 8 moves checker verdicts into Review and Verdict, and item acceptances with them (R1 §4), while B:237 reserves binding verdicts and acceptance to `devos_denetim`. It is settled by origin. Transferred verdicts and acceptances keep their true origin: role class `devos_kurulum`, independence `fresh_context_subagent`. They count as no audit verdict. Writing them as `devos_denetim` would make an installation self-check look like an audit verdict (criterion 30), and is refused. C03's audit environment re-reviews them by sample (P:1013). If W-C02-06's record needs anything else, the executor reconciles the two records before either is judged (I-8).

**Alternatives.** No verdict right at all (EV-C02-004's second option), keeping the installation's verdicts in git until C03: the transfer would have no honest writer for the verdicts task 8 moves (above). Not chosen. A right to record any installation checker verdict until C03 (this record's first version): any session holding the `devos_kurulum` token could write a verdict outside the transfer, and B:379 did not provide for it (R-45, "outside the pair"). Not chosen now. `devos_kurulum` acting as `devos_denetim` until C03: it breaks criterion 30 and S8 line 1. Not chosen.

### 4.3 S8 line 2: the claim's role class

Each Assignment records the role class its token gave at the claim (B 3.5). Every function that takes a claim token (every effect, `heartbeat` and `release`) compares the caller's role class with the claim's and refuses a mismatch, recorded as RejectedAttempt with its reason (EV-C02-004 X-16; revised: the first version named effects only, which left a claim token carried into another environment able to extend or release its claim). It is built in C02 task 4 (W-C02-08, W-C02-09 point 4), and N17 covers it with a case for each kind of call (PC-43 place 11). EV-C02-002's `heartbeat` rule (PC-42 place 13) and `release` cite this line. Reason: the claim token is the one DevOS credential a session can read (K-9 item 2 (b)). Without this line, a claim token carried into another environment's session would act there (EV4 S8).

### 4.4 S8 line 3: moved to C04

**Decision.** "A claim is refused to a session that has no registration of the same role class" is built in C04, with SessionRecord and `register_session` (B:90; B:390). The activation table does not change.

**Reasons.**
1. It detects rather than separates. The role class comes from the token and the claim from the claim token, so no C02 or C03 separation line rests on it. Its purpose is to tie each claim to a registration that X1 reconciles (EV4 S8 line 3; X1), and X1 needs routines (C06) and SessionRecord (C04).
2. A registration's session ID is itself declared (B 3.24, `declared_session_id`), so registration in C02 would not make a fake session ID detectable **[Inf]**.
3. SessionRecord and `register_session` have no first need in C02 (B:55), and their fields (`routine_ref`, `handoff_ref`) depend on C04's and C06's designs (R4 "Flags", conflict 1).

**What would have relied on it, and how each is met without it.**
- C02's Acceptance "with a fake session ID": N04 and N17. A fake declared session ID changes nothing, since no authority rests on it (B principle 8), and an effect still needs the claim token.
- W-C02-07 point 2's "a claim without registration refused": moved, named here, and left out of PC-43's N17 text.
- W-C02-09 point 4 and W-C02-12 point 6: both already provide for a moved line ("unless W-C02-05's accepted design moved that line, which the record then names"); this section names it.
- C03 test 3 and N-137: neither relies on it.

**Carrier.** N-223 on `plan/work/C04.md`.

### 4.5 N04, N08 and N17

- **N04** runs with the `devos_kurulum` token in C02. Its stage includes C02, and S8 line 1 is a C02 rule.
- **N08's database part** (the exam records' access rule, which C02 builds for C03; B:78) also runs in C02, with the working, audit, `devos_kurulum` and `devos_ci` tokens. Reason: C02's Acceptance real-token line covers reading an exam record with another environment's token (point 15), and the rule is built in C02, so its break belongs with its build (the Acceptance's first line). N-137's C03 run (the exam fact S2, `devos-evals`, the audit token) stays as Appendix C and N-137 place it. C:125's stage column gains C02 (PC-43 place 10).
- **N17** covers a claim used with another role class's token (PC-43 place 11).

## 5. The job roles' and the installation's credentials (point 5)

### 5.1 The `devos_kurulum` token

- **Who.** Batu: `issue_env_token` runs only as the project owner (B:46).
- **When.** Step 4 (sitting A), as soon as the identity chain's first part has been applied to both projects and `devos_api` is exposed (EV-C02-004 Y-01, Y-06), before W-C02-09 builds the rest (§3.3). It is needed for the header-path observation and G14, N04's real run with this token (W-C02-12), the fixtures of the real-token tests (§6.2), the ledger transfer (W-C02-14), and the installation's records after the transfer.
- **Form.** A token from `issue_env_token('devos_kurulum')`, issued by `devos`; one token.
- **Where it is kept.** One network secret of `devos-kurulum`, with `devos`'s host only and the header `x-devos-env-token`. Its hash is in `devos`'s `env_tokens`, and nothing else holds it.
- **Alternatives.** A second token issued by `devos-test`, kept as a second secret with that project's host (this record's first version, then chosen so that the first observation was made off live state and the installation could make dry runs in `devos-test`): not chosen now. EV-C02-004 Y-05 makes the migration job the only route to `devos-test`, so the installation's dry runs there, if W-C02-14 wants them, run inside the job (I-8); the first observation on `devos` is a read that returns only a role class (§3.1); and Batu's sitting loses an owner-only line in `devos-test` and a secret. The live token at W-C02-14 only: the header path would then be built on before it is observed (§3.3). Not chosen.

### 5.2 The `devos_ci` key

- **Who.** Batu, by the owner-only function. The key is a token like the others, so every role class has one verification path.
- **Form.** `issue_env_token('devos_ci')`, one key, issued by `devos`. It reaches `devos` only, through the Data API, with the header set by the check itself (EV-C02-004 Y-03; revised: the first version left a second key for `devos-test` open).
- **Where it is kept.** A repository secret of `devos` (GitHub Actions), under the name the builder gives. It is not an environment secret limited to `main`, because the pull-request checks that use it run for pull-request refs, which a rule of `main` refuses **[Doc: R5 G3, read 2026-10-12]**.
- **What follows from where it is kept.** "Any user with write access to your repository has read access to all secrets configured in your repository" **[Doc: R5 G1, read 2026-10-12]**. DevOS's sessions push as the machine account, a writer (P:725). So every DevOS session is treated as able to read this key **[Inf]**.
- **So `devos_ci` holds no right any environment must not hold.** It reads only what the checks need and nothing an environment keeps from the others (never exam records; §4.1). It writes only the results of the checks it runs, labelled with its role class. No rule counts a `devos_ci` observation as an environment's observation of its own effect. W-C02-07's matrix tries every environment-only operation with its key (§15).
- **The release job (C08).** Its key may instead be an environment secret limited to `main`, since that job runs on `main`. That is C08's design, named here.
- **When.** Decided (EV-C02-004 Y-03): step 4, in the same sitting as `devos_kurulum`'s (§7 part A). Until it exists, the pull-request checks read the migration job's run record (EV-C02-001); from then, they call `deployment_drift` on `devos` with it. What a difference or "could not check" stops is EV-C02-001's (its point 1 (c)).
- **R3 G5.** `devos_ci` is not needed at task 0: the issuing function exists only from the identity chain's first part, and the pull-request checks before step 4 read the migration job's run record instead (EV-C02-004 Y-03).
- **Alternatives (when).** At C03's start (this record's first version, as one branch): C03's required checks would be the first to use it, but the pull-request checks of C02's later migrations would then have only the run record to read until C03; issuing it in sitting A costs one SQL line and one repository secret in a sitting Batu makes anyway. Not chosen.

### 5.3 How `deployment_drift` authenticates the migration job (R3 G6)

Decided by W-C02-03 (EV-C02-001; EV-C02-004 Y-02): the migration job calls `deployment_drift` through its direct database login with the migration credential, with no environment token; `deployment_drift` admits a direct login whose `session_user` is the migration role before the derivation, and every other caller passes the derivation. This record names `deployment_drift` as the one function with that branch (§1.6). No migration and no job calls `issue_env_token` or `revoke_env_token` in `devos`; EV-C02-001 states it as a rule of the job and of the migrations' review (EV-C02-004 Y-04).

### 5.4 `devos_backup`, against C03 test 8 and N26 (R1 2.4)

- **Not needed before C09.** C03 test 8 ("The backup role can only read") and N26's C03 part test the role's database rights. The migration job's `devos-test` step issues a synthetic `devos_backup` token, runs the cases, and discards it (§6.3). The real credential is entered at C09 (Section 12 item 4; KI row 29), in the form C09's backup design chooses: a token from `issue_env_token`, or a database login for the export whose rights must equal `devos_backup`'s, shown by N26 at C09.
- **Reason (the ordering principle).** The uncertain part, and the costly one if wrong, is the role's rights, which C02 builds and C03 tests. The credential's form depends on the export (5.7; C09). Issuing it now would keep a live credential with no user for six stages, in `devos-backup`'s secrets, which sessions are treated as able to reach (P:726) **[Inf]**.
- **What it leaves to C09.** 6.7's scheduled-jobs row counts the GitHub secret's scope as a layer, with C03 test 3 (N26) and C09 (P:736). That part can be observed only once the secret exists, so it is C09's; N-222 tells C03.
- **Exam records.** Whether `devos_backup`'s read covers them (the backup exports everything, while `EvalRun` is read only with `devos_sinav`, B:273) is C09's export design. Until C09, no `devos_backup` credential exists outside a test transaction.

### 5.5 Section 12 item 1

The steps this design adds, through PC-43 place 4:
- (a) sitting A: the exposure of `devos_api` in both projects (EV-C02-004 Y-06), the `devos_kurulum` token, the `devos_ci` key, and `devos-kurulum`'s publishable-key variable for `devos`;
- (b) steps 2 and 3: the environments with their network level and non-secret variables, and each token as a network secret, with S4 (d) and S4 (e);
- (c) step 5: the sessions.

They reach Batu by working order section 8, on issue #6, in §7's text.

## 6. The running session, and each token tried from inside its environment (point 6)

### 6.1 Does a secret added to `devos-kurulum` reach the running working session? (R3 G14)

Not stated in the documentation read (CE, 2026-10-10, 2026-10-11 and 2026-10-12). What is stated:
- variables are read when a session is created and "again each time Claude Code starts in the session's VM afterward": when "The VM is restored after being idle" ("after a few minutes without activity") or rebuilt;
- "Claude Code connects to the agent proxy when it launches";
- a network-level change reaches running sessions "within about a minute";
- after archiving, "Network secrets on the environment stay attached in its running sessions"

**[Doc: CE "Set environment variables", "Requests that never get the secret", "Network access", "Archive an environment", read 2026-10-12]**.

**[Inf]** Whether the proxy reads an environment's secrets per request or when Claude Code connects is not stated. Either way, a working session that waits for Batu goes idle, so its next turn restores the VM and starts Claude Code again, and after that the secret applies on both readings.

**State.** Provisional. It is settled by the self-check of §3.3, made in the turn after Batu reports step 4 (the same day as the step). The same check shows whether the working session runs in `devos-kurulum` (F-m).

**If the secret does not reach the session.** The self-check repeats at the session's next restore. If a restore has happened and the check still sees nothing, the executor asks Batu, as one narrow step, for one short session in `devos-kurulum` from a first message the builder gives, which makes the same check.
- If that session sees `devos_kurulum`, the path works and only the running session lacks the secret (G14: no). The working session's database work then waits for its next rebuild, or moves to a session Batu opens for it, as a narrow step.
- If that session also fails, §2.1 applies.

### 6.2 Each environment's real token, tried from inside it (R3 G7; "Batu's steps" row 5)

- **The step.** After steps 2 and 3, once W-C02-09's and W-C02-10's functions exist, Batu opens one session in each of `devos-calisma`, `devos-denetim` and `devos-sinav`. Each is attached to `devos` only, on Opus 5.5 in Accept edits (D-008), and started from one first message the builder gives, the same for all three (the token decides the role class). It reaches him as one narrow question (P:878 item 1).
- **The first message** (written by W-C02-12) asks for this, in this order, and nothing else:
  1. a record that the guard is live, and the session's own tool list at its start and at its end (N-181; S9);
  2. the format scan with its planted control (§3.2);
  3. `token_role_class()`, its answer recorded beside the value of the session's non-secret variable `DEVOS_ENVIRONMENT`, which Batu typed into that environment in B1 (§7);
  4. one plain request, sending no input and no credential, to one host outside the Trusted list that W-C02-12 names from CE's default list, recording only whether it was reached or refused (W-C02-12 point 10's self-observation of the network level);
  5. the cases of W-C02-12 points 4 to 6, each a database call with the session's own token on synthetic inputs labelled synthetic, using the fixtures below;
  6. a result file on the session's own `claude/` branch: the `DEVOS_ENVIRONMENT` value and the role class seen, side by side; the network result; each case's outcome and refusal reason; and the scan's counts;
  7. then stop.

  It is plainly defensive and minimal (D-017; D-020). No call acts on another environment's sessions, routines or settings.
- **What the comparison catches (CHK-C02-010 C2).** The expected results are `devos-calisma` with `devos_calisma` and its request reached; `devos-denetim` with `devos_denetim`, refused; `devos-sinav` with `devos_sinav`, refused (S6; P:652). W-C02-12's record compares the three result files with them.
  - *A token stored in the wrong environment* shows as a session whose role class does not match its `DEVOS_ENVIRONMENT` value, or as a role class seen in no session or in two. The same comparison catches a B2 session opened in the wrong environment. Batu then gets a narrow step: revoke the tokens involved and store new ones in the right environments (B:46: only he can revoke). That environment's session then runs again.
  - *An environment created at the wrong network level* shows as a network result that does not match its `DEVOS_ENVIRONMENT` value: `devos-calisma` refused, or `devos-denetim` or `devos-sinav` reached. Batu then changes the level in that environment's **Network access** selector, as a narrow step; running sessions follow "within about a minute" **[Doc: CE "Network access", read 2026-10-12]**. The request is then made again. That reached or refused tells Full from Trusted is **[Inf]** from CE's access-level table, whose **Trusted** row reads "Allowlisted domains only: package registries, GitHub, cloud SDKs" and whose **Full** row reads "Any domain", since what a refused request returns to the session is not stated in the pages read.
- **What stays unchecked, with its reason.**
  - *That an environment's name matches the `DEVOS_ENVIRONMENT` value typed in it.* A session can read its variables, but the pages read name nothing that gives it its environment's name **[Doc: CE, read 2026-10-12; Inf]**, and listing the account's environments is beyond this item's level of need. Batu types both in one dialog (B1 steps 10 and 12, 21 and 23, 32 and 34), and each step's see-line shows what he typed. The checks above key on the variable, the token and the level.
  - *A DevOS token stored in an environment outside the three* (one of his own, or Default). The B2 sessions run only in the three, and the system cannot see the account's other environments, for the same reason. B1's count check shows that no extra token was issued. S4 (d)'s standing rule, and X1 from C06, cover his own sessions, as B1's check says.
  - *A level stricter than Trusted* (None, or a Custom list) for `devos-denetim` or `devos-sinav`. It also refuses the request, so it is not told apart from Trusted. It narrows reach only, so it shows when the work needs a host the level refuses.
  - *The network result when the guard in the B2 session does not allow the request* (W-C02-11 sets what it allows). The result is then "could not check" (plan Section 8 item 14), and the level rests on Batu's report alone, labelled so (W-C02-12 point 10).
  - Which environment Batu's own sessions use, as B1's check says: visible from C06 (X1).
- **The fixtures in `devos`** (EV-C02-004 X-10). The records these cases need (a Mission and work items under it) are written beforehand, with the `devos_kurulum` token, through `devos_api`, each labelled synthetic (plan Section 8 item 13). No synthetic record of class `batu` is written into `devos`: a synthetic decision of Batu's class in the live database would carry his authority. The Mission rests on a decision of Batu's that exists, and EV-C02-002 names which and how the test Mission is labelled so that it cannot be taken for work.
- **How the results reach the records with no token value.** The database records each state-changing call's role class and each refusal's reason code (F06; §15; EV-C02-004 X-19), never a value. The session's file holds only role classes, the non-secret `DEVOS_ENVIRONMENT` value, the network result, outcomes and counts. The executor reads both through the builder's read-only connection (K-9 item 9), and W-C02-12's record compares them; a mismatch is a finding. `devos_kurulum` has no read of RejectedAttempt (EV-C02-004 X-13: least privilege; the read-only connection already reads `devos`); in `devos-test`, RejectedAttempt is read inside the migration job's step (§6.3). (Revised: the first version also read through the `devos_kurulum` token.)
- **One session per class is enough for the role-class lines.** "Another session's claim" made by one session that holds two claims and uses one claim's token on the other's work is a case within one session. W-C02-12 point 7 labels it so and does not count it as the real-session case. The database tells claims apart by their token only **[Inf]**, so the case tests the same rule, which N17 shows in `devos-test` (W-C02-07). A real-session case would need a second session in one environment, a further narrow step of Batu's. It is not asked for here, since it would test no rule N17 does not test.

### 6.3 The owner-only functions in tests (B:46; F08 (c))

**The path** (EV-C02-004 Y-05; revised: the first version assumed an owner-level test path of its own, I-5). The owner-level path in `devos-test` is the migration job's `devos-test` step: after it applies a migration there, the job runs C02's database tests in `devos-test` (EV-C02-001's probe P10 settles as which role, with `set role`). No other route reaches `devos-test`. So these tests run after a merge, inside the job, and only then does the job apply the migration to `devos` (Y-01). In each run:
- the test issues the synthetic tokens it needs, inside its own transaction;
- for a call over HTTP, it commits them, sends them with the header set explicitly, and revokes them before the run ends;
- it runs `revoke_env_token` the same way; F08 (c)'s epoch change is made by revoking one of these synthetic tokens with `revoke_env_token`, and there is no third owner-only function (EV-C02-004 X-07);
- it holds every token only in memory.

**Where explicit-header calls come from.** From the migration job's runner only, outside DevOS's sessions. No DevOS session calls `devos-test` (§1.5).

Nothing here is a step of Batu's, so "Batu's steps" row 1a's owner-only lines are not needed; row 1a then holds only the exposure of `devos_api` (EV-C02-004 Y-05, Y-06; §7). In `devos`, `issue_env_token` and `revoke_env_token` run only in Batu's steps (PC-43 place 6), and no migration and no job calls them there (Y-04).

**Every route that could run `issue_env_token`, and the layer that closes each** (W-C02-09 point 3):
1. Batu, in the dashboard: intended.
2. The migration credential for `devos`, which is owner-level (R5 S5, S6). Closed by three layers: no migration and no job calls the function in `devos`, a rule of the job and of the migrations' review (EV-C02-001; EV-C02-004 Y-04; looked for, W-C02-09 point 3); migrations are on the high-impact path list and merge only with a checker verdict (P:711; W-C02-19); and the job runs only `main`'s migrations (EV-C02-001).
3. The migration job's `devos-test` step, with the migration credential for `devos-test`: intended, for synthetic tokens only; its `devos` step runs no test (Y-05).
4. Supabase's secret (service) key: it is in no agent environment (K-9 item 3), and no API role is granted EXECUTE on the function.
5. The builder's Supabase connection: configured read-only and limited to one project (K-9 item 9; Section 12 "In preparation"). That it is read-only rests on its configuration, as N-032 (b) notes, not on a test here.

## 7. Batu's step text for task 7 and step 4 (point 7)

**Batches.**
- **A** (row 1a's exposure of `devos_api`, then step 4): asked as soon as the identity chain's first part is applied to both projects, so that `devos_api` exists in both (EV-C02-004 Y-01, Y-06); one sitting. If EV-C02-001's build shows the exposure can be made before the schema exists, it moves into row 1's sitting and A's steps 1 to 6 and 9 to 12 drop out (steps 7 and 8 then open `devos`, and step 13 follows). A holds no owner-only line in `devos-test` (EV-C02-004 Y-05).
- **B1** (steps 2 and 3): asked as soon as W-C02-11 is accepted (S9's bridge merged and confirmed; N-174's run; N-136: before task 7 and before any session runs in the three environments).
- **B2** (step 5): asked as soon as W-C02-09 and W-C02-10 are accepted.

B1 and B2 form one sitting if their prerequisites are met together. Each is posted on issue #6 (working order section 8) and listed under "Batu's steps" on `plan/work/C02.md` (N-201).

**Network levels (S6, as the plan sets them, P:652; 6.7's network row).** `devos-calisma` at **Full**: it does research and "needs broad internet access". `devos-denetim` and `devos-sinav` at **Trusted**, the documented default **[Doc: CE "Network access", read 2026-10-12]**, until C05's exam setup says whether the exam environment needs less (N-138). EV4 §5 left a fixed None for the exam environment out as more than the need.

The screen names below come from CE (read 2026-10-12) and from the C01 step text Batu has already followed (`evidence/C01/routine/ROUTINE_DESIGN.md`). The Supabase and GitHub labels are those products' usual ones, not re-read here **[Inf]**, except that a custom schema is exposed by adding it to "Exposed schemas" in the dashboard's API settings **[Doc: R5 S11, supabase.com/docs/guides/api/using-custom-schemas, read 2026-10-12]**; the menu entry's name ("Data API") is **[Inf]**. So each step says to stop with a screenshot if the screen differs.

**Single actions (CHK-C02-010 C1; Appendix E §7 item 1).** Every numbered step below is one action with its own see-line; no step repeats other steps by number. Three things follow from writing the steps out:
- After **Connect**, the **Edit environment** dialog stays open: "The secret appears in the list with its hosts, saved without the dialog's **Save changes** button" **[Doc: CE "Add a secret", read 2026-10-12]**. So A's return to the dialog is one step that finds it still open (step 35), and in B1 each token's part starts the Claude Code side by reloading its tab (steps 45, 65, 85), so that no earlier dialog or list is open; the environment parts do the same (steps 17, 28).
- Each line Batu pastes (the SQL lines and B2's first message) is posted on #6 in a code box of its own, which GitHub shows with a copy icon **[Inf]**; the step before each paste copies it from there.
- `/remote-env` "opens a picker of your existing environments" **[Doc: CE "Select an environment from the CLI", read 2026-10-12]**, so B1 types it, presses Enter and chooses **Default** as three steps, with their skip condition stated before them.

### 7.1 Türkçe metin (Batu için)

**A. Veritabanı arayüzünün açılması, kurulum ortamının anahtarı ve CI anahtarı** *(1a. satırdaki açma işi ve adım 4)*

DevOS'un veritabanı, kendisine hangi ortamdan seslenildiğini o ortamın kendi anahtarıyla (token) tanır. Bu bölümde önce DevOS'un veritabanı arayüzünü (`devos_api`) iki Supabase projesinde dışarıya açacaksın. Sonra kurulum ortamının (`devos-kurulum`; bu çalışma oturumunun ortamı) anahtarını üretip bu ortamın **ağ sırları** (network secrets) bölümüne koyacaksın. Ağ sırrı, oturumun göremediği, yalnız belirli bir adrese giden isteklere eklenen gizli değerdir. Son olarak denetimlerin (CI) anahtarını üretip `devos` deposunun sırlarına koyacaksın. Anahtarı hiçbir yere yazma, bana gönderme, ekran görüntüsünde gösterme; yalnız aşağıda söylenen kutuya yapıştır. Adımları bilgisayarda, tarayıcıdan yap. Bu konuyu (#6) bir sekmede açık tut: kopyalayacağın satırlar burada, her biri kendi kutusunda. Bir ekran burada yazdığından farklı görünürse o adımda dur ve bu konuya (#6) ekran görüntüsünü ekle (anahtar görünmesin); tahminle devam etme. Ek ücret yoktur.

1. supabase.com/dashboard adresini aç.
   Görmen gereken: projelerin listesi; içinde `devos` ve `devos-test`.
2. `devos-test` projesine tıkla.
   Görmen gereken: `devos-test` projesinin sayfası açılır.
3. Sol menüde **Project Settings**'e tıkla; bulamazsan dur.
   Görmen gereken: projenin ayarları.
4. **Data API**'ye tıkla; bulamazsan dur.
   Görmen gereken: **Exposed schemas** alanı.
5. **Exposed schemas** alanında `devos_api`'yi seç; listede yoksa dur. Alandaki diğer adlara dokunma.
   Görmen gereken: alanda, önceden orada olanların yanında `devos_api`.
6. **Save**'e tıkla.
   Görmen gereken: değişikliğin kaydedildiğini söyleyen bir bildirim; alanda `devos_api` duruyor.
7. supabase.com/dashboard adresini aç.
   Görmen gereken: projelerin listesi; içinde `devos`.
8. `devos` projesine tıkla.
   Görmen gereken: `devos` projesinin sayfası açılır.
9. Sol menüde **Project Settings**'e tıkla; bulamazsan dur.
   Görmen gereken: `devos` projesinin ayarları.
10. **Data API**'ye tıkla; bulamazsan dur.
    Görmen gereken: **Exposed schemas** alanı.
11. **Exposed schemas** alanında `devos_api`'yi seç; listede yoksa dur. Alandaki diğer adlara dokunma.
    Görmen gereken: alanda, önceden orada olanların yanında `devos_api`.
12. **Save**'e tıkla.
    Görmen gereken: değişikliğin kaydedildiğini söyleyen bir bildirim; `devos` projesinin **Exposed schemas** alanında da `devos_api` duruyor.
13. Sol menüde **SQL Editor**'e tıkla (hâlâ `devos` projesindesin); bulamazsan dur.
    Görmen gereken: boş bir sorgu kutusu.
14. Bu konuda (#6), şu satırın kutusundaki kopyalama simgesine tıkla: `select devos_private.issue_env_token('devos_kurulum');`
    Görmen gereken: simge kısa bir süre onay işaretine döner; satır panoda.
15. Supabase sekmesinde, sorgu kutusuna panodaki satırı yapıştır.
    Görmen gereken: kutuda yalnız bu satır.
16. **Run** düğmesine tıkla.
    Görmen gereken: altta tek satırlık bir sonuç, içinde uzun bir değer. Bu anahtardır ve yalnız bu kez gösterilir.
17. Sonuçtaki değeri kopyala.
    Görmen gereken: değer panoda. Başka hiçbir yere yapıştırma.
18. Yeni bir tarayıcı sekmesinde claude.ai/code adresini aç.
    Görmen gereken: Claude Code'un ana sayfası açılır.
19. Mesaj kutusunun üstündeki satırda, ortamın adını gösteren bulut simgesine tıkla.
    Görmen gereken: ortam seçenekleri açılır.
20. **Cloud**'u seç.
    Görmen gereken: bulut ortamlarının listesi; içinde `devos-kurulum`.
21. İmleci `devos-kurulum`'un üzerine getir.
    Görmen gereken: satırın sağında bir ayar simgesi belirir.
22. O ayar simgesine tıkla.
    Görmen gereken: **Edit environment** penceresi açılır.
23. Pencerede **Network secrets** bölümünü bul; yoksa dur.
    Görmen gereken: bölüm görünür (boş olabilir).
24. **Add secret**'e tıkla.
    Görmen gereken: bir form açılır; **Credential type** **Bearer** olarak durur. Onu değiştirme.
25. **Name** alanına `devos anahtari` yaz.
    Görmen gereken: bu ad alanda.
26. **Allowed websites** alanına `zyqgltzfzkdvrmvxlamz.supabase.co` yaz.
    Görmen gereken: alanda yalnız bu adres.
27. **Custom headers** satırında, **Name** kutusundaki `Authorization` yazısının yerine `x-devos-env-token` yaz.
    Görmen gereken: Name kutusunda tam olarak `x-devos-env-token`.
28. Aynı satırda **Prefix** kutusundaki `Bearer` yazısını sil.
    Görmen gereken: Prefix kutusu boş.
29. Aynı satırın **Value** kutusuna panodaki değeri yapıştır.
    Görmen gereken: değer kutuda (gizli görünebilir).
30. **Connect**'e tıkla.
    Görmen gereken: sır, `zyqgltzfzkdvrmvxlamz.supabase.co` adresiyle listede görünür ve altında **Not sent** yazmaz; pencere açık kalır. Değeri bir daha göremezsin; bu doğrudur.
31. Supabase sekmesinde sayfayı yenile.
    Görmen gereken: sonuç alanı boş; anahtar ekranda yok.
32. Sol menüde **Project Settings**'e tıkla.
    Görmen gereken: `devos` projesinin ayarları.
33. **API Keys**'e tıkla; bulamazsan dur.
    Görmen gereken: **Publishable key** satırı. Bu anahtar gizli değildir (herkese açık anahtardır).
34. **Publishable key** değerini kopyala.
    Görmen gereken: değer panoda.
35. claude.ai/code sekmesine geç.
    Görmen gereken: `devos-kurulum`'un **Edit environment** penceresi hâlâ açık; **Network secrets** listesinde `devos anahtari`.
36. **Environment variables** kutusunda son satırın sonuna tıkla.
    Görmen gereken: imleç son satırın sonunda.
37. **Enter**'a bas.
    Görmen gereken: imleç kutunun en altındaki yeni, boş satırda.
38. Bu satıra `DEVOS_PUBLISHABLE_KEY=` yaz.
    Görmen gereken: son satır `DEVOS_PUBLISHABLE_KEY=`. Diğer satırlara dokunma.
39. Hemen ardından, boşluk bırakmadan, panodaki değeri yapıştır.
    Görmen gereken: son satır `DEVOS_PUBLISHABLE_KEY=` ile başlar ve devamında değer vardır.
40. Pencerenin **Save changes** düğmesine tıkla.
    Görmen gereken: pencere kapanır.
41. Supabase sekmesinde, sol menüde **SQL Editor**'e tıkla.
    Görmen gereken: sorgu kutusu.
42. Kutuda bir satır varsa sil.
    Görmen gereken: kutu boş.
43. Bu konuda (#6), şu satırın kutusundaki kopyalama simgesine tıkla: `select devos_private.issue_env_token('devos_ci');`
    Görmen gereken: simge kısa bir süre onay işaretine döner; satır panoda.
44. Supabase sekmesinde, sorgu kutusuna panodaki satırı yapıştır.
    Görmen gereken: kutuda yalnız bu satır.
45. **Run** düğmesine tıkla.
    Görmen gereken: tek satırlık sonuç, içinde uzun bir değer.
46. Sonuçtaki değeri kopyala.
    Görmen gereken: değer panoda. Başka hiçbir yere yapıştırma.
47. Yeni bir sekmede github.com/batuhanozgun/devos/settings/secrets/actions adresini aç; sayfa açılmazsa dur.
    Görmen gereken: **Actions secrets** sayfası.
48. **New repository secret**'a tıkla.
    Görmen gereken: yeni sır formu.
49. **Name** alanına `DEVOS_CI_TOKEN` yaz.
    Görmen gereken: ad alanında `DEVOS_CI_TOKEN`.
50. **Secret** kutusuna panodaki değeri yapıştır.
    Görmen gereken: değer kutuda.
51. **Add secret**'e tıkla.
    Görmen gereken: listede `DEVOS_CI_TOKEN` görünür; değeri görünmez.
52. Supabase sekmesinde sayfayı yenile.
    Görmen gereken: sonuç alanı boş; anahtar ekranda yok.
53. Bu konuya (#6) "A tamam" yaz.
    Görmen gereken: yorumun konuda görünür.

*Sistemin kontrolü:* Ben bu oturumdan veritabanına, bu ortamın anahtarıyla bir okuma isteği gönderirim. Veritabanı isteğin `devos_kurulum`'dan geldiğini söylerse hem `devos_api` açılmıştır hem de anahtar doğru yerdedir. Oturumda anahtarın okunur bir kopyası olmadığını da kendim tararım. Anahtarın kendisini hiç görmem ve hiçbir kayda yazmam. Veritabanının günlüklerinde (log) anahtar biçiminde bir dize olup olmadığını da, hiçbir satırını okumadan, yalnız sayısını alarak denetlerim. `devos-test`'teki açılışı, taşıma işinin (migration job) oradaki bir sonraki çalışması gösterir. CI anahtarını, bundan sonraki ilk değişiklik isteğinin (pull request) denetimi kullanır ve sonucu kaydeder.

**B1. Üç DevOS ortamı ve anahtarları** *(adım 2 ve 3)*

DevOS'un çalışma, denetim ve sınav ortamlarını oluşturup her birine kendi anahtarını koyacağız. Kurallar A'dakiyle aynı: anahtarı hiçbir yere yazma ya da gösterme; ekran farklıysa dur; bu konuyu (#6) bir sekmede açık tut. Ek ücret yoktur. Ara vermen gerekirse yalnız 38. adımdan sonra ver: o noktada üç ortam kurulmuştur, henüz anahtar çıkarılmamıştır ve panoda yalnız gizli olmayan yayın anahtarı vardır. 39–98. adımların içinde ya da aralarında ara verme: her bölüm bir anahtar çıkarıp onu hemen saklar.

1. supabase.com/dashboard adresini aç.
   Görmen gereken: projelerin listesi.
2. `devos` projesine tıkla.
   Görmen gereken: projenin sayfası.
3. Sol menüde **Project Settings**'e tıkla.
   Görmen gereken: projenin ayarları.
4. **API Keys**'e tıkla.
   Görmen gereken: **Publishable key** satırı (gizli değildir).
5. **Publishable key** değerini kopyala.
   Görmen gereken: değer panoda.
6. Yeni bir sekmede claude.ai/code adresini aç.
   Görmen gereken: Claude Code'un ana sayfası.

*`devos-calisma` ortamı:*

7. Mesaj kutusunun üstündeki bulut simgesine tıkla.
   Görmen gereken: ortam seçenekleri.
8. **Cloud**'u seç.
   Görmen gereken: bulut ortamlarının listesi.
9. **Add cloud environment**'a tıkla.
   Görmen gereken: **New cloud environment** penceresi.
10. **Name** alanına `devos-calisma` yaz.
    Görmen gereken: ad alanında `devos-calisma`.
11. **Network access** seçicisinde **Full**'ü seç.
    Görmen gereken: seçicide **Full**.
12. **Environment variables** kutusuna şu satırı yaz: `DEVOS_ENVIRONMENT=devos-calisma`
    Görmen gereken: kutuda bu satır.
13. **Enter**'a bas.
    Görmen gereken: imleç ikinci, boş satırda.
14. Bu satıra `DEVOS_PUBLISHABLE_KEY=` yaz.
    Görmen gereken: ikinci satır `DEVOS_PUBLISHABLE_KEY=`.
15. Hemen ardından, boşluk bırakmadan, panodaki değeri yapıştır.
    Görmen gereken: kutuda iki satır; ikincisi `DEVOS_PUBLISHABLE_KEY=` ile başlar ve devamında değer vardır. **Setup script** kutusu boş kalır.
16. **Create environment**'a tıkla.
    Görmen gereken: `devos-calisma` listede.

*`devos-denetim` ortamı:*

17. claude.ai/code sekmesinde sayfayı yenile.
    Görmen gereken: Claude Code'un ana sayfası; açık bir pencere ya da liste yok.
18. Mesaj kutusunun üstündeki bulut simgesine tıkla.
    Görmen gereken: ortam seçenekleri.
19. **Cloud**'u seç.
    Görmen gereken: bulut ortamlarının listesi.
20. **Add cloud environment**'a tıkla.
    Görmen gereken: **New cloud environment** penceresi.
21. **Name** alanına `devos-denetim` yaz.
    Görmen gereken: ad alanında `devos-denetim`.
22. **Network access** seçicisinde **Trusted**'ı seç.
    Görmen gereken: seçicide **Trusted**.
23. **Environment variables** kutusuna şu satırı yaz: `DEVOS_ENVIRONMENT=devos-denetim`
    Görmen gereken: kutuda bu satır.
24. **Enter**'a bas.
    Görmen gereken: imleç ikinci, boş satırda.
25. Bu satıra `DEVOS_PUBLISHABLE_KEY=` yaz.
    Görmen gereken: ikinci satır `DEVOS_PUBLISHABLE_KEY=`.
26. Hemen ardından, boşluk bırakmadan, panodaki değeri yapıştır.
    Görmen gereken: kutuda iki satır; ikincisi `DEVOS_PUBLISHABLE_KEY=` ile başlar ve devamında değer vardır. **Setup script** kutusu boş kalır.
27. **Create environment**'a tıkla.
    Görmen gereken: `devos-denetim` listede.

*`devos-sinav` ortamı:*

28. claude.ai/code sekmesinde sayfayı yenile.
    Görmen gereken: Claude Code'un ana sayfası; açık bir pencere ya da liste yok.
29. Mesaj kutusunun üstündeki bulut simgesine tıkla.
    Görmen gereken: ortam seçenekleri.
30. **Cloud**'u seç.
    Görmen gereken: bulut ortamlarının listesi.
31. **Add cloud environment**'a tıkla.
    Görmen gereken: **New cloud environment** penceresi.
32. **Name** alanına `devos-sinav` yaz.
    Görmen gereken: ad alanında `devos-sinav`.
33. **Network access** seçicisinde **Trusted**'ı seç.
    Görmen gereken: seçicide **Trusted**.
34. **Environment variables** kutusuna şu satırı yaz: `DEVOS_ENVIRONMENT=devos-sinav`
    Görmen gereken: kutuda bu satır.
35. **Enter**'a bas.
    Görmen gereken: imleç ikinci, boş satırda.
36. Bu satıra `DEVOS_PUBLISHABLE_KEY=` yaz.
    Görmen gereken: ikinci satır `DEVOS_PUBLISHABLE_KEY=`.
37. Hemen ardından, boşluk bırakmadan, panodaki değeri yapıştır.
    Görmen gereken: kutuda iki satır; ikincisi `DEVOS_PUBLISHABLE_KEY=` ile başlar ve devamında değer vardır. **Setup script** kutusu boş kalır.
38. **Create environment**'a tıkla.
    Görmen gereken: listede `devos-calisma`, `devos-denetim` ve `devos-sinav`.

*`devos-calisma`'nın anahtarı:*

39. Supabase sekmesinde, `devos` projesinin sol menüsünde **SQL Editor**'e tıkla.
    Görmen gereken: sorgu kutusu.
40. Kutuda bir satır varsa sil.
    Görmen gereken: kutu boş.
41. Bu konuda (#6), şu satırın kutusundaki kopyalama simgesine tıkla: `select devos_private.issue_env_token('devos_calisma');`
    Görmen gereken: simge kısa bir süre onay işaretine döner; satır panoda.
42. Supabase sekmesinde, sorgu kutusuna panodaki satırı yapıştır.
    Görmen gereken: kutuda yalnız bu satır.
43. **Run**'a tıkla.
    Görmen gereken: tek satırlık sonuç, içinde uzun bir değer.
44. Değeri kopyala.
    Görmen gereken: değer panoda; başka yere yapıştırma.
45. claude.ai/code sekmesinde sayfayı yenile.
    Görmen gereken: Claude Code'un ana sayfası; açık bir pencere ya da liste yok.
46. Mesaj kutusunun üstündeki bulut simgesine tıkla.
    Görmen gereken: ortam seçenekleri.
47. **Cloud**'u seç.
    Görmen gereken: bulut ortamlarının listesi; içinde `devos-calisma`.
48. İmleci `devos-calisma`'nın üzerine getir.
    Görmen gereken: satırın sağında bir ayar simgesi belirir.
49. O ayar simgesine tıkla.
    Görmen gereken: `devos-calisma`'nın **Edit environment** penceresi.
50. Pencerede **Network secrets** bölümünü bul; yoksa dur.
    Görmen gereken: bölüm görünür (boş).
51. **Add secret**'e tıkla.
    Görmen gereken: bir form açılır; **Credential type** **Bearer** olarak durur. Onu değiştirme.
52. **Name** alanına `devos anahtari` yaz.
    Görmen gereken: bu ad alanda.
53. **Allowed websites** alanına `zyqgltzfzkdvrmvxlamz.supabase.co` yaz.
    Görmen gereken: alanda yalnız bu adres.
54. **Custom headers** satırında, **Name** kutusundaki `Authorization` yazısının yerine `x-devos-env-token` yaz.
    Görmen gereken: Name kutusunda tam olarak `x-devos-env-token`.
55. Aynı satırda **Prefix** kutusundaki `Bearer` yazısını sil.
    Görmen gereken: Prefix kutusu boş.
56. Aynı satırın **Value** kutusuna panodaki değeri yapıştır.
    Görmen gereken: değer kutuda (gizli görünebilir).
57. **Connect**'e tıkla.
    Görmen gereken: sır, `zyqgltzfzkdvrmvxlamz.supabase.co` adresiyle listede; altında **Not sent** yok. Değeri bir daha göremezsin; bu doğrudur.
58. Supabase sekmesinde sayfayı yenile.
    Görmen gereken: anahtar ekranda yok.

*`devos-denetim`'in anahtarı:*

59. Supabase sekmesinde, `devos` projesinin sol menüsünde **SQL Editor**'e tıkla.
    Görmen gereken: sorgu kutusu.
60. Kutuda bir satır varsa sil.
    Görmen gereken: kutu boş.
61. Bu konuda (#6), şu satırın kutusundaki kopyalama simgesine tıkla: `select devos_private.issue_env_token('devos_denetim');`
    Görmen gereken: simge kısa bir süre onay işaretine döner; satır panoda.
62. Supabase sekmesinde, sorgu kutusuna panodaki satırı yapıştır.
    Görmen gereken: kutuda yalnız bu satır.
63. **Run**'a tıkla.
    Görmen gereken: tek satırlık sonuç, içinde uzun bir değer.
64. Değeri kopyala.
    Görmen gereken: değer panoda; başka yere yapıştırma.
65. claude.ai/code sekmesinde sayfayı yenile.
    Görmen gereken: Claude Code'un ana sayfası; açık bir pencere ya da liste yok.
66. Mesaj kutusunun üstündeki bulut simgesine tıkla.
    Görmen gereken: ortam seçenekleri.
67. **Cloud**'u seç.
    Görmen gereken: bulut ortamlarının listesi; içinde `devos-denetim`.
68. İmleci `devos-denetim`'in üzerine getir.
    Görmen gereken: satırın sağında bir ayar simgesi belirir.
69. O ayar simgesine tıkla.
    Görmen gereken: `devos-denetim`'in **Edit environment** penceresi.
70. Pencerede **Network secrets** bölümünü bul; yoksa dur.
    Görmen gereken: bölüm görünür (boş).
71. **Add secret**'e tıkla.
    Görmen gereken: bir form açılır; **Credential type** **Bearer** olarak durur. Onu değiştirme.
72. **Name** alanına `devos anahtari` yaz.
    Görmen gereken: bu ad alanda.
73. **Allowed websites** alanına `zyqgltzfzkdvrmvxlamz.supabase.co` yaz.
    Görmen gereken: alanda yalnız bu adres.
74. **Custom headers** satırında, **Name** kutusundaki `Authorization` yazısının yerine `x-devos-env-token` yaz.
    Görmen gereken: Name kutusunda tam olarak `x-devos-env-token`.
75. Aynı satırda **Prefix** kutusundaki `Bearer` yazısını sil.
    Görmen gereken: Prefix kutusu boş.
76. Aynı satırın **Value** kutusuna panodaki değeri yapıştır.
    Görmen gereken: değer kutuda (gizli görünebilir).
77. **Connect**'e tıkla.
    Görmen gereken: sır, `zyqgltzfzkdvrmvxlamz.supabase.co` adresiyle listede; altında **Not sent** yok. Değeri bir daha göremezsin; bu doğrudur.
78. Supabase sekmesinde sayfayı yenile.
    Görmen gereken: anahtar ekranda yok.

*`devos-sinav`'ın anahtarı:*

79. Supabase sekmesinde, `devos` projesinin sol menüsünde **SQL Editor**'e tıkla.
    Görmen gereken: sorgu kutusu.
80. Kutuda bir satır varsa sil.
    Görmen gereken: kutu boş.
81. Bu konuda (#6), şu satırın kutusundaki kopyalama simgesine tıkla: `select devos_private.issue_env_token('devos_sinav');`
    Görmen gereken: simge kısa bir süre onay işaretine döner; satır panoda.
82. Supabase sekmesinde, sorgu kutusuna panodaki satırı yapıştır.
    Görmen gereken: kutuda yalnız bu satır.
83. **Run**'a tıkla.
    Görmen gereken: tek satırlık sonuç, içinde uzun bir değer.
84. Değeri kopyala.
    Görmen gereken: değer panoda; başka yere yapıştırma.
85. claude.ai/code sekmesinde sayfayı yenile.
    Görmen gereken: Claude Code'un ana sayfası; açık bir pencere ya da liste yok.
86. Mesaj kutusunun üstündeki bulut simgesine tıkla.
    Görmen gereken: ortam seçenekleri.
87. **Cloud**'u seç.
    Görmen gereken: bulut ortamlarının listesi; içinde `devos-sinav`.
88. İmleci `devos-sinav`'ın üzerine getir.
    Görmen gereken: satırın sağında bir ayar simgesi belirir.
89. O ayar simgesine tıkla.
    Görmen gereken: `devos-sinav`'ın **Edit environment** penceresi.
90. Pencerede **Network secrets** bölümünü bul; yoksa dur.
    Görmen gereken: bölüm görünür (boş).
91. **Add secret**'e tıkla.
    Görmen gereken: bir form açılır; **Credential type** **Bearer** olarak durur. Onu değiştirme.
92. **Name** alanına `devos anahtari` yaz.
    Görmen gereken: bu ad alanda.
93. **Allowed websites** alanına `zyqgltzfzkdvrmvxlamz.supabase.co` yaz.
    Görmen gereken: alanda yalnız bu adres.
94. **Custom headers** satırında, **Name** kutusundaki `Authorization` yazısının yerine `x-devos-env-token` yaz.
    Görmen gereken: Name kutusunda tam olarak `x-devos-env-token`.
95. Aynı satırda **Prefix** kutusundaki `Bearer` yazısını sil.
    Görmen gereken: Prefix kutusu boş.
96. Aynı satırın **Value** kutusuna panodaki değeri yapıştır.
    Görmen gereken: değer kutuda (gizli görünebilir).
97. **Connect**'e tıkla.
    Görmen gereken: sır, `zyqgltzfzkdvrmvxlamz.supabase.co` adresiyle listede; altında **Not sent** yok. Değeri bir daha göremezsin; bu doğrudur.
98. Supabase sekmesinde sayfayı yenile.
    Görmen gereken: anahtar ekranda yok.

*Komut satırı:* 99., 100. ve 101. adımlar yalnız bilgisayarında Claude Code'u komut satırından kullanıyorsan içindir. Kullanmıyorsan üçünü de atla ve 102. adıma geç.

99. Komut satırındaki Claude Code'a `/remote-env` yaz.
    Görmen gereken: satırda `/remote-env`.
100. **Enter**'a bas.
     Görmen gereken: ortamlarının listesi açılır.
101. Listeden **Default**'u seç.
     Görmen gereken: varsayılan ortam **Default**.
102. Bu konuya "B1 tamam" yaz.
     Görmen gereken: yorumun konuda görünür.

*Bundan sonra kalıcı iki kural:*
- Kendi işlerin için oturum açarken, ya da bir Claude Project'in ortamını seçerken, ortam seçicide DevOS'un ortamlarını (`devos-kurulum`, `devos-calisma`, `devos-denetim`, `devos-sinav`) seçme; **Default**'u ya da DevOS anahtarı olmayan başka bir ortamı kullan. Bir ortamdaki anahtar, o ortamda kim açarsa açsın her oturuma eklenir.
- Hesabının paylaşılan yerlerine (Claude'daki becerilere, bağlayıcılara, Project talimatlarına ve belleğine) hiçbir anahtar, şifre ya da DevOS'a özgü gizli bilgi koyma.

*Sistemin kontrolü:* Veritabanında her ortam için tam bir geçerli anahtar kaydı olduğunu okurum: yalnız sayısını ve tarihini, anahtarın kendisini değil. Her anahtarın doğru ortamda olduğunu ve her ortamın ağ düzeyini, aşağıdaki sınırlarla, B2'deki oturumlar gösterir: her oturum, ortamının `DEVOS_ENVIRONMENT` değerini, veritabanının o oturumun anahtarından çıkardığı rol sınıfının yanına yazar ve Trusted listesinde olmayan tek bir adrese, hiçbir veri göndermeden bir istek yapıp ulaşıp ulaşmadığını kaydeder (`devos-calisma` ulaşmalı; `devos-denetim` ve `devos-sinav` ulaşmamalı). Bir uyuşmazlıkta, ilgili anahtarları iptal edip doğru ortama yenilerini koyman ya da ağ düzeyini düzeltmen için sana kısa bir adım getiririm. Sistemin şimdilik göremedikleri: bir ortamın adının, içine yazdığın `DEVOS_ENVIRONMENT` değeriyle aynı olduğu (oturum ortamın adını göremez; ikisini aynı pencerede yazıyorsun) bir DevOS anahtarının bu üç ortamın dışındaki bir ortama konmadığı; `devos-denetim` ya da `devos-sinav` için Trusted'dan daha sıkı bir düzey (None ya da özel bir liste), çünkü o da isteği reddeder ve Trusted'dan ayırt edilemez; ve oturumu koruyan kurallar o isteğe izin vermezse ağ düzeyi (sonuç o zaman "kontrol edilemedi" olur ve düzey yalnız senin bildirimine dayanır). Kendi oturumlarının hangi ortamda açıldığını da sistem şimdilik göremez; DevOS'un kendi rutinleri gelince (C06) beklenmeyen bir oturum işaretlenir.

**B2. Her ortamda bir oturum** *(adım 5)*

Her ortamın anahtarı, ancak o ortamda çalışan bir oturumdan denenebilir; ben oturum açamam. Bu yüzden her ortamda kısa bir oturum açmanı rica ediyorum. Bu konuyu (#6) bir sekmede açık tut; ilk mesajı buradan kopyalayacaksın. Oturumlar kullanım hakkından düşer; ek ücret yoktur.

*`devos-calisma`'da oturum:*

1. Yeni bir sekmede claude.ai/code adresini aç.
   Görmen gereken: Claude Code'un ana sayfası.
2. Mesaj kutusunun üstündeki bulut simgesine tıkla.
   Görmen gereken: ortam seçenekleri.
3. **Cloud**'u seç.
   Görmen gereken: bulut ortamlarının listesi.
4. `devos-calisma`'ya tıkla.
   Görmen gereken: bulut simgesinde `devos-calisma` yazar.
5. Depo seçicide yalnız `batuhanozgun/devos`'u seçili bırak; başka depo ekleme.
   Görmen gereken: tek depo, `batuhanozgun/devos`.
6. Model seçicide **Opus 5.5**'i seç.
   Görmen gereken: seçicide Opus 5.5.
7. İzin modu seçicisinde **Accept edits**'i seç; seçiciyi bulamazsan dur.
   Görmen gereken: seçicide Accept edits.
8. Bu konuda (#6), verdiğim İngilizce ilk mesajın kutusundaki kopyalama simgesine tıkla; simge yoksa dur.
   Görmen gereken: simge kısa bir süre onay işaretine döner; mesaj panoda.
9. 1. adımda açtığın claude.ai/code sekmesinde, mesaj kutusuna panodaki mesajı hiç değiştirmeden yapıştır.
   Görmen gereken: mesaj kutuda, ilk satırı verdiğim metinle başlar.
10. Mesajı gönder.
    Görmen gereken: oturum çalışmaya başlar; işi bitince son satırında "DONE" yazar. Oturuma başka bir şey yazma.

*`devos-denetim`'de oturum:*

11. Yeni bir sekmede claude.ai/code adresini aç.
    Görmen gereken: Claude Code'un ana sayfası.
12. Mesaj kutusunun üstündeki bulut simgesine tıkla.
    Görmen gereken: ortam seçenekleri.
13. **Cloud**'u seç.
    Görmen gereken: bulut ortamlarının listesi.
14. `devos-denetim`'e tıkla.
    Görmen gereken: bulut simgesinde `devos-denetim` yazar.
15. Depo seçicide yalnız `batuhanozgun/devos`'u seçili bırak; başka depo ekleme.
    Görmen gereken: tek depo, `batuhanozgun/devos`.
16. Model seçicide **Opus 5.5**'i seç.
    Görmen gereken: seçicide Opus 5.5.
17. İzin modu seçicisinde **Accept edits**'i seç; seçiciyi bulamazsan dur.
    Görmen gereken: seçicide Accept edits.
18. Bu konuda (#6), verdiğim İngilizce ilk mesajın kutusundaki kopyalama simgesine tıkla; simge yoksa dur.
    Görmen gereken: simge kısa bir süre onay işaretine döner; mesaj panoda.
19. 11. adımda açtığın claude.ai/code sekmesinde, mesaj kutusuna panodaki mesajı hiç değiştirmeden yapıştır.
    Görmen gereken: mesaj kutuda, ilk satırı verdiğim metinle başlar.
20. Mesajı gönder.
    Görmen gereken: ikinci oturum çalışır ve "DONE" ile biter. Oturuma başka bir şey yazma.

*`devos-sinav`'da oturum:*

21. Yeni bir sekmede claude.ai/code adresini aç.
    Görmen gereken: Claude Code'un ana sayfası.
22. Mesaj kutusunun üstündeki bulut simgesine tıkla.
    Görmen gereken: ortam seçenekleri.
23. **Cloud**'u seç.
    Görmen gereken: bulut ortamlarının listesi.
24. `devos-sinav`'a tıkla.
    Görmen gereken: bulut simgesinde `devos-sinav` yazar.
25. Depo seçicide yalnız `batuhanozgun/devos`'u seçili bırak; başka depo ekleme.
    Görmen gereken: tek depo, `batuhanozgun/devos`.
26. Model seçicide **Opus 5.5**'i seç.
    Görmen gereken: seçicide Opus 5.5.
27. İzin modu seçicisinde **Accept edits**'i seç; seçiciyi bulamazsan dur.
    Görmen gereken: seçicide Accept edits.
28. Bu konuda (#6), verdiğim İngilizce ilk mesajın kutusundaki kopyalama simgesine tıkla; simge yoksa dur.
    Görmen gereken: simge kısa bir süre onay işaretine döner; mesaj panoda.
29. 21. adımda açtığın claude.ai/code sekmesinde, mesaj kutusuna panodaki mesajı hiç değiştirmeden yapıştır.
    Görmen gereken: mesaj kutuda, ilk satırı verdiğim metinle başlar.
30. Mesajı gönder.
    Görmen gereken: üçüncü oturum çalışır ve "DONE" ile biter. Oturuma başka bir şey yazma.
31. Bu konuya "B2 tamam" yaz.
    Görmen gereken: yorumun konuda görünür.

*Sistemin kontrolü:* Her oturum sonucunu kendi kayıt dalına yazar: ortamının `DEVOS_ENVIRONMENT` değeri, gördüğü rol sınıfı ve ağ denemesinin sonucu yan yana. Veritabanı da her değişikliğin ve her reddin hangi ortamın anahtarıyla geldiğini, her reddin nedenini de kaydeder. İkisini ben karşılaştırırım; anahtar hiçbir kayda girmez.

### 7.2 English rendering

**A. Exposing the database interface, the installation environment's token and the CI key (row 1a's exposure and step 4).** Intro: the database recognises which environment calls it by that environment's own token; Batu first exposes DevOS's database interface (`devos_api`) in both Supabase projects, then makes `devos-kurulum`'s token (the working session's environment) and stores it in its **Network secrets**, values the session cannot see, attached only to requests for one address, and last makes the CI key and stores it in the `devos` repository's secrets; he never writes, sends or shows a token, works in a browser on a computer, keeps issue #6 open in a tab (each line to copy is there, in a box of its own), and stops with a screenshot (no token visible) if a screen differs; no fee.
1. Open supabase.com/dashboard. *See:* the projects, `devos` and `devos-test` among them.
2. Click `devos-test`. *See:* its page.
3. Click **Project Settings** in the left menu; stop if absent. *See:* the project's settings.
4. Click **Data API**; stop if absent. *See:* the **Exposed schemas** field.
5. In **Exposed schemas**, select `devos_api`; stop if it is not listed; leave the other names. *See:* `devos_api` beside those already there.
6. Click **Save**. *See:* a notice that the change is saved; `devos_api` stays in the field.
7. Open supabase.com/dashboard. *See:* the projects, `devos` among them.
8. Click `devos`. *See:* its page.
9. Click **Project Settings** in the left menu; stop if absent. *See:* `devos`'s settings.
10. Click **Data API**; stop if absent. *See:* the **Exposed schemas** field.
11. In **Exposed schemas**, select `devos_api`; stop if it is not listed; leave the other names. *See:* `devos_api` beside those already there.
12. Click **Save**. *See:* a notice that the change is saved; `devos_api` in `devos`'s **Exposed schemas** too.
13. Click **SQL Editor** in the left menu (still in `devos`); stop if absent. *See:* an empty query box.
14. On #6, click the copy icon of the box holding `select devos_private.issue_env_token('devos_kurulum');`. *See:* the icon briefly turns into a tick; the line is on the clipboard.
15. In the Supabase tab, paste the line into the query box. *See:* only that line.
16. Click **Run**. *See:* a one-row result with a long value, shown only this once.
17. Copy the value. *See:* it is on the clipboard; paste it nowhere else.
18. Open claude.ai/code in a new tab. *See:* Claude Code's home page.
19. Click the cloud icon showing the environment's name, above the message box. *See:* the environment options.
20. Choose **Cloud**. *See:* the cloud environments, `devos-kurulum` among them.
21. Hover over `devos-kurulum`. *See:* a settings icon on the right.
22. Click it. *See:* the **Edit environment** dialog.
23. Find **Network secrets**; stop if absent. *See:* the section (maybe empty).
24. Click **Add secret**. *See:* a form; **Credential type** stays **Bearer**.
25. Type `devos anahtari` in **Name**. *See:* that name.
26. Type `zyqgltzfzkdvrmvxlamz.supabase.co` in **Allowed websites**. *See:* only that host.
27. In **Custom headers**, type `x-devos-env-token` in **Name** in place of `Authorization`. *See:* exactly that name.
28. Clear `Bearer` from **Prefix**. *See:* Prefix empty.
29. Paste the value into **Value**. *See:* the value (perhaps masked).
30. Click **Connect**. *See:* the secret listed with that host, not marked **Not sent**; the dialog stays open; its value cannot be viewed again, which is right.
31. Reload the Supabase tab. *See:* no token on screen.
32. Click **Project Settings** in the left menu. *See:* `devos`'s settings.
33. Click **API Keys**; stop if absent. *See:* the **Publishable key** (not secret).
34. Copy it. *See:* on the clipboard.
35. Switch to the claude.ai/code tab. *See:* `devos-kurulum`'s **Edit environment** dialog still open, `devos anahtari` under **Network secrets**.
36. Click at the end of the last line in **Environment variables**. *See:* the cursor there.
37. Press **Enter**. *See:* the cursor on a new, empty last line.
38. Type `DEVOS_PUBLISHABLE_KEY=`. *See:* that last line; no other line touched.
39. Paste the value right after it, with no space. *See:* the last line starts with `DEVOS_PUBLISHABLE_KEY=` and holds the value after it.
40. Click **Save changes**. *See:* the dialog closes.
41. In the Supabase tab, click **SQL Editor** in the left menu. *See:* the query box.
42. Delete any line in the box. *See:* the box empty.
43. On #6, click the copy icon of the box holding `select devos_private.issue_env_token('devos_ci');`. *See:* the icon briefly turns into a tick; the line is on the clipboard.
44. In the Supabase tab, paste the line into the query box. *See:* only that line.
45. Click **Run**. *See:* a one-row result with a long value.
46. Copy the value. *See:* on the clipboard only.
47. In a new tab, open github.com/batuhanozgun/devos/settings/secrets/actions; stop if it does not open. *See:* **Actions secrets**.
48. Click **New repository secret**. *See:* the form.
49. Type `DEVOS_CI_TOKEN` in **Name**. *See:* that name.
50. Paste the value into **Secret**. *See:* the value there.
51. Click **Add secret**. *See:* `DEVOS_CI_TOKEN` listed, its value hidden.
52. Reload the Supabase tab. *See:* no token on screen.
53. Write "A tamam" on issue #6. *See:* the comment.

*The system's check:* the working session calls the database with this environment's token; an answer of `devos_kurulum` shows both that `devos_api` is exposed and that the token is in place; the session also scans itself for a readable copy; the builder never sees or records a token, and checks `devos`'s logs for strings of the token format by a count only, reading no line (§14); the migration job's next run in `devos-test` shows the exposure there; the first pull request's check after this uses and records the CI key.

**B1. The three DevOS environments and their tokens (steps 2 and 3).** Same rules (issue #6 kept open in a tab); no fee. If he must pause, only after step 38: the three environments exist, no token has been issued, and the clipboard holds only the publishable key, which is not secret. Not inside or between steps 39 to 98: each part issues a token and stores it at once (CHK-C02-012's recommendation).
1. Open supabase.com/dashboard. *See:* the projects.
2. Click `devos`. *See:* its page.
3. Click **Project Settings**. *See:* its settings.
4. Click **API Keys**. *See:* the **Publishable key** (not secret).
5. Copy it. *See:* on the clipboard.
6. Open claude.ai/code in a new tab. *See:* the home page.

*`devos-calisma`:*
7. Click the cloud icon above the message box. *See:* the environment options.
8. Choose **Cloud**. *See:* the list.
9. Click **Add cloud environment**. *See:* **New cloud environment**.
10. Type `devos-calisma` in **Name**. *See:* that name.
11. Choose **Full** in **Network access**. *See:* Full.
12. Type `DEVOS_ENVIRONMENT=devos-calisma` in **Environment variables**. *See:* that line.
13. Press **Enter**. *See:* the cursor on a second, empty line.
14. Type `DEVOS_PUBLISHABLE_KEY=`. *See:* the second line reads so.
15. Paste the value right after it, with no space. *See:* two lines, the second starting `DEVOS_PUBLISHABLE_KEY=` with the value after it; **Setup script** stays empty.
16. Click **Create environment**. *See:* `devos-calisma` listed.

*`devos-denetim`:*
17. Reload the claude.ai/code tab. *See:* the home page, no dialog or list open.
18. Click the cloud icon above the message box. *See:* the environment options.
19. Choose **Cloud**. *See:* the list.
20. Click **Add cloud environment**. *See:* **New cloud environment**.
21. Type `devos-denetim` in **Name**. *See:* that name.
22. Choose **Trusted** in **Network access**. *See:* Trusted.
23. Type `DEVOS_ENVIRONMENT=devos-denetim` in **Environment variables**. *See:* that line.
24. Press **Enter**. *See:* the cursor on a second, empty line.
25. Type `DEVOS_PUBLISHABLE_KEY=`. *See:* the second line reads so.
26. Paste the value right after it, with no space. *See:* two lines, the second starting `DEVOS_PUBLISHABLE_KEY=` with the value after it; **Setup script** stays empty.
27. Click **Create environment**. *See:* `devos-denetim` listed.

*`devos-sinav`:*
28. Reload the claude.ai/code tab. *See:* the home page, no dialog or list open.
29. Click the cloud icon above the message box. *See:* the environment options.
30. Choose **Cloud**. *See:* the list.
31. Click **Add cloud environment**. *See:* **New cloud environment**.
32. Type `devos-sinav` in **Name**. *See:* that name.
33. Choose **Trusted** in **Network access**. *See:* Trusted.
34. Type `DEVOS_ENVIRONMENT=devos-sinav` in **Environment variables**. *See:* that line.
35. Press **Enter**. *See:* the cursor on a second, empty line.
36. Type `DEVOS_PUBLISHABLE_KEY=`. *See:* the second line reads so.
37. Paste the value right after it, with no space. *See:* two lines, the second starting `DEVOS_PUBLISHABLE_KEY=` with the value after it; **Setup script** stays empty.
38. Click **Create environment**. *See:* all three listed.

*`devos-calisma`'s token:*
39. In the Supabase tab, click **SQL Editor** in `devos`'s left menu. *See:* the query box.
40. Delete any line in the box. *See:* the box empty.
41. On #6, click the copy icon of the box holding `select devos_private.issue_env_token('devos_calisma');`. *See:* the icon briefly turns into a tick; the line is on the clipboard.
42. In the Supabase tab, paste the line into the query box. *See:* only that line.
43. Click **Run**. *See:* a one-row result with a long value.
44. Copy the value. *See:* on the clipboard only.
45. Reload the claude.ai/code tab. *See:* the home page, no dialog or list open.
46. Click the cloud icon above the message box. *See:* the environment options.
47. Choose **Cloud**. *See:* the list, `devos-calisma` among them.
48. Hover over `devos-calisma`. *See:* a settings icon on the right.
49. Click it. *See:* `devos-calisma`'s **Edit environment** dialog.
50. Find **Network secrets**; stop if absent. *See:* the section (empty).
51. Click **Add secret**. *See:* a form; **Credential type** stays **Bearer**.
52. Type `devos anahtari` in **Name**. *See:* that name.
53. Type `zyqgltzfzkdvrmvxlamz.supabase.co` in **Allowed websites**. *See:* only that host.
54. In **Custom headers**, type `x-devos-env-token` in **Name** in place of `Authorization`. *See:* exactly that name.
55. Clear `Bearer` from **Prefix**. *See:* Prefix empty.
56. Paste the value into **Value**. *See:* the value (perhaps masked).
57. Click **Connect**. *See:* the secret listed with that host, not **Not sent**; its value cannot be viewed again.
58. Reload the Supabase tab. *See:* no token on screen.

*`devos-denetim`'s token:*
59. In the Supabase tab, click **SQL Editor** in `devos`'s left menu. *See:* the query box.
60. Delete any line in the box. *See:* the box empty.
61. On #6, click the copy icon of the box holding `select devos_private.issue_env_token('devos_denetim');`. *See:* the icon briefly turns into a tick; the line is on the clipboard.
62. In the Supabase tab, paste the line into the query box. *See:* only that line.
63. Click **Run**. *See:* a one-row result with a long value.
64. Copy the value. *See:* on the clipboard only.
65. Reload the claude.ai/code tab. *See:* the home page, no dialog or list open.
66. Click the cloud icon above the message box. *See:* the environment options.
67. Choose **Cloud**. *See:* the list, `devos-denetim` among them.
68. Hover over `devos-denetim`. *See:* a settings icon on the right.
69. Click it. *See:* `devos-denetim`'s **Edit environment** dialog.
70. Find **Network secrets**; stop if absent. *See:* the section (empty).
71. Click **Add secret**. *See:* a form; **Credential type** stays **Bearer**.
72. Type `devos anahtari` in **Name**. *See:* that name.
73. Type `zyqgltzfzkdvrmvxlamz.supabase.co` in **Allowed websites**. *See:* only that host.
74. In **Custom headers**, type `x-devos-env-token` in **Name** in place of `Authorization`. *See:* exactly that name.
75. Clear `Bearer` from **Prefix**. *See:* Prefix empty.
76. Paste the value into **Value**. *See:* the value (perhaps masked).
77. Click **Connect**. *See:* the secret listed with that host, not **Not sent**; its value cannot be viewed again.
78. Reload the Supabase tab. *See:* no token on screen.

*`devos-sinav`'s token:*
79. In the Supabase tab, click **SQL Editor** in `devos`'s left menu. *See:* the query box.
80. Delete any line in the box. *See:* the box empty.
81. On #6, click the copy icon of the box holding `select devos_private.issue_env_token('devos_sinav');`. *See:* the icon briefly turns into a tick; the line is on the clipboard.
82. In the Supabase tab, paste the line into the query box. *See:* only that line.
83. Click **Run**. *See:* a one-row result with a long value.
84. Copy the value. *See:* on the clipboard only.
85. Reload the claude.ai/code tab. *See:* the home page, no dialog or list open.
86. Click the cloud icon above the message box. *See:* the environment options.
87. Choose **Cloud**. *See:* the list, `devos-sinav` among them.
88. Hover over `devos-sinav`. *See:* a settings icon on the right.
89. Click it. *See:* `devos-sinav`'s **Edit environment** dialog.
90. Find **Network secrets**; stop if absent. *See:* the section (empty).
91. Click **Add secret**. *See:* a form; **Credential type** stays **Bearer**.
92. Type `devos anahtari` in **Name**. *See:* that name.
93. Type `zyqgltzfzkdvrmvxlamz.supabase.co` in **Allowed websites**. *See:* only that host.
94. In **Custom headers**, type `x-devos-env-token` in **Name** in place of `Authorization`. *See:* exactly that name.
95. Clear `Bearer` from **Prefix**. *See:* Prefix empty.
96. Paste the value into **Value**. *See:* the value (perhaps masked).
97. Click **Connect**. *See:* the secret listed with that host, not **Not sent**; its value cannot be viewed again.
98. Reload the Supabase tab. *See:* no token on screen.

*Command line:* steps 99, 100 and 101 are only for him if he uses Claude Code from his computer's command line; otherwise he skips all three and goes to step 102.
99. Type `/remote-env` into Claude Code on the command line. *See:* `/remote-env` on the line.
100. Press **Enter**. *See:* a picker of his environments.
101. Choose **Default**. *See:* Default as the default.
102. Write "B1 tamam" on issue #6. *See:* the comment.

*Two standing rules (S4 (d), (e)):* his own sessions and any Claude Project's environment never use a DevOS environment, only **Default** or another environment with no DevOS token, since a token is attached to every session in its environment, whoever opens it; nothing secret goes into what the account shares (skills, connectors, Project instructions and memory). *The system's check:* the builder reads, through its read-only connection, that each environment has exactly one non-revoked token record (count and date only); B2's sessions show that each token is in its environment, and each environment's network level within the limits below: each session records its `DEVOS_ENVIRONMENT` value beside the role class the database derives from its token, and whether one plain request, sending nothing, to a host outside the Trusted list reached it (`devos-calisma` should, `devos-denetim` and `devos-sinav` should not); on a mismatch he gets a narrow step to revoke the tokens involved and store new ones in the right environments, or to correct the level; not visible to the system now: that an environment's name matches the `DEVOS_ENVIRONMENT` value typed in it (a session cannot see its environment's name; he types both in one dialog), that no DevOS token sits in an environment outside the three; a level stricter than Trusted (None, or a Custom list) for `devos-denetim` or `devos-sinav`, which also refuses the request and so is not told apart from Trusted; and the network level when the session's guard does not allow the request, whose result is then "could not check", the level resting on his report alone; which environment his own sessions use is not visible either; from C06 a session matching no expected run is flagged (X1).

**B2. One session in each environment (step 5).** Each token can be tried only from a session in its environment, and the builder cannot open sessions; he keeps issue #6 open in a tab, where the first message is; the sessions draw on his usage allowance; no fee.

*In `devos-calisma`:*
1. Open claude.ai/code in a new tab. *See:* the home page.
2. Click the cloud icon above the message box. *See:* the options.
3. Choose **Cloud**. *See:* the list.
4. Click `devos-calisma`. *See:* its name on the icon.
5. Leave only `batuhanozgun/devos` in the repository selector. *See:* one repository.
6. Choose **Opus 5.5** in the model selector. *See:* Opus 5.5.
7. Choose **Accept edits** in the permission-mode selector; stop if the selector is not found. *See:* Accept edits.
8. On #6, click the copy icon of the box holding the builder's English first message; stop if there is none. *See:* the icon briefly turns into a tick; the message is on the clipboard.
9. In the tab opened at step 1, paste the message into the message box unchanged. *See:* it in the box, its first line the builder's.
10. Send it. *See:* the session works and ends with a last line "DONE"; he types nothing else in it.

*In `devos-denetim`:*
11. Open claude.ai/code in a new tab. *See:* the home page.
12. Click the cloud icon above the message box. *See:* the options.
13. Choose **Cloud**. *See:* the list.
14. Click `devos-denetim`. *See:* its name on the icon.
15. Leave only `batuhanozgun/devos` in the repository selector. *See:* one repository.
16. Choose **Opus 5.5** in the model selector. *See:* Opus 5.5.
17. Choose **Accept edits** in the permission-mode selector; stop if the selector is not found. *See:* Accept edits.
18. On #6, click the copy icon of the box holding the builder's English first message; stop if there is none. *See:* the icon briefly turns into a tick; the message is on the clipboard.
19. In the tab opened at step 11, paste the message into the message box unchanged. *See:* it in the box, its first line the builder's.
20. Send it. *See:* the second session works and ends with "DONE"; he types nothing else in it.

*In `devos-sinav`:*
21. Open claude.ai/code in a new tab. *See:* the home page.
22. Click the cloud icon above the message box. *See:* the options.
23. Choose **Cloud**. *See:* the list.
24. Click `devos-sinav`. *See:* its name on the icon.
25. Leave only `batuhanozgun/devos` in the repository selector. *See:* one repository.
26. Choose **Opus 5.5** in the model selector. *See:* Opus 5.5.
27. Choose **Accept edits** in the permission-mode selector; stop if the selector is not found. *See:* Accept edits.
28. On #6, click the copy icon of the box holding the builder's English first message; stop if there is none. *See:* the icon briefly turns into a tick; the message is on the clipboard.
29. In the tab opened at step 21, paste the message into the message box unchanged. *See:* it in the box, its first line the builder's.
30. Send it. *See:* the third session works and ends with "DONE"; he types nothing else in it.
31. Write "B2 tamam" on issue #6. *See:* the comment.

*The system's check:* each session writes its result to its own branch: its `DEVOS_ENVIRONMENT` value, the role class it sees and its network result side by side; the database records the role class of each state-changing call and each refusal, and each refusal's reason; the builder compares the two; no token enters any record.

## 8. N-208: re-reading C01's documentation-based facts (point 8)

**Decision.** N-208 is carried by its own note, N-220 on `plan/work/C02.md`. Each stage's work list carries N-220 forward to the next stage's file, as N-201 is carried (N-210). N-111 is not widened, for three reasons:
- N-111's pointers N-112 to N-121 copy its text, and six of them are on stage files this item may not change, so a widened N-111 would leave them out of line;
- N-111's subject, row 4 and the Claude Code version, is narrower than N-208's, whose facts are mostly the platform's server side;
- a separate note keeps one text of each rule.

N-111's version comparison is reused, unchanged, as one of the two triggers.

**Triggers.**
- (T1) The Claude Code version N-111 compares differs from the one last recorded (N-111's points of comparison).
- (T2) At a point of comparison, the digest of the text of a cited page differs from the digest recorded at its last reading.

The first re-reading of the pages read between 2026-10-10 and 2026-10-12 compares their quoted passages word for word, as R5 C1 did, and records each page's digest; later readings compare digests.

**Points of comparison.** Right before each work named below, and at each stage's work list.

**Cited pages.**
- Those each row's record lists: EV2 S1 to S5 for row 3; EV-C01-016 for row 9; EV-C01-018 for row 12; EV-C01-003 for row 17; EV-C01-015 for row 18.
- The Supabase and GitHub pages this design relies on (R5 sections 1 to 4).

**Owner.** The executor. From C06, the maintenance work the plan assigns to platform changes (Section 13, "Platform features change fast": "maintenance work follows the changes"), which C06 names.

**The work each re-reading comes before.**

| Row | Comes before |
|---|---|
| 3 (environment token, network secrets) | Batu's step 4 (the first token stored); steps 2 and 3 (task 7, W-C02-12); C03 test 3; C09's restore drill, which issues tokens again |
| 9 (its multi-repository part) | C05's exam setup (task 4; N-138); C06's creation of the routines (N-139) |
| 12 (git reach; who can change the rule of `main`) | C03 test 5 (N-175); C04's ingestion and its closing step (N-133) |
| 17 (the control surface) | Task 7 (W-C02-11's bridge rests on it; W-C02-12); C03 test 3 and D-003's re-assessment (N-137); C06's creation of the routines |
| 18 (platform-side readers) | C03's work list (the classifier against each stage's actions); C06's creation of the routines (routine sessions' mode) |

**When a trigger fires.** The changed pages are re-read for the rows that cite them, with the date and the label (PC-21 item 9). If a row's fact changed, the row's fail path applies, and the plan changes through Section 14 before the named work. Until the re-reading is done, that work waits: "could not check" blocks it (Section 8 item 14).

**Does it fire on the change it is meant to catch, with no content date on the pages (R5)?** Yes for text. T2 compares the text itself, so a changed page shows without any date, and T1 catches a change on the Claude Code side even when the pages lag.

**What it misses (residual).**
- A behaviour change with neither a documentation change nor a version change, until DevOS's own tests or records show it (C03's tests; X1; §3.2's scan in each new environment).
- A change made and undone between two points of comparison.
- A new page that states something new.

Cosmetic edits also fire it; the cost is one re-reading.

**Time.** A re-reading is a researcher's fetch and comparison. R5's reading of 2026-10-12 took 12:58Z to 13:08Z, so a re-reading takes under an hour **[Inf]**. It is on the critical path only when it fires, right before its named work.

## 9. Plan text through Section 14 (point 9)

### 9.1 The places PC-43 changes

| PC-43 place | Text (at `eba94b1`; the same lines at `560bcab` except P:1233, then P:1230) | What changes |
|---|---|---|
| 1 | P:639, 6.3's table, the `devos-kurulum` row | Its authority from its token in C02; its "Cannot" (S8 line 1; EV4 §8 item 2) |
| 2 | P:648, 6.3 "How is the token generated?" | Who runs the line, in which project; the token added as a network secret with the host and header; nothing else holds it (EV4 §8 item 1; R3 G2) |
| 3 | P:652, 6.3 "Network" | The network level per environment; the token's form chosen; the Supabase side documented; the joined claim inferred and where it is first observed |
| 4 | P:1233, Section 12 item 1, its first sentence | Sitting A (the exposure of `devos_api`, the `devos_kurulum` token, the `devos_ci` key), steps 2, 3 and 5, with S4 (d), S4 (e) (N-125; R3 G2, G4) |
| 5 | B:35, section 2's `devos_kurulum` row | Its keeps (the transfer's copies of verdicts; opening a Mission until C06) and "Cannot" (EV4 §8 item 2) |
| 6 | B:46, section 2's paragraph on issuing tokens | No migration or job runs the two functions in `devos`; tests in `devos-test` only inside the migration job's run; F08 (c) by a revocation |
| 7 | B:358 and B:360, 3.27's fields and rule (B:365 and B:367 after PC-42) | `authority_epoch` removed; verified tokens, the derivation, the reason codes and RejectedAttempt, validity, the issuing project, the format (point 14) |
| 8 | B:370, section 4's Session group (B:377 after PC-42) | `token_role_class()`, built on the derivation |
| 9 | C:121, N04 | The `devos_kurulum` cases (EV4 §8 item 11) |
| 10 | C:125, N08 | The `devos_kurulum` and `devos_ci` tokens; C02 added to its stage (EV4 §8 item 11) |
| 11 | C:134, N17 | Any call that takes a claim token, used with another role class's token (EV4 §8 item 11; EV-C02-004 X-16) |
| 12 | KI rows 18 to 22 and 29 | The chosen forms and places, with no value or derivative |
| 13 | B:379, section 4's row "Review" (B:386 after PC-42) | The transfer's copies as the one exception to "Only `devos_denetim`" (§4.2) |
| 14 | P:235, the PC-08 note's clause PC-40 left | Where the facts are first observed (§3) |
| 15 | P:723, 6.7's database row, the clause PC-40 left | The same |
| 16 | P:734, 6.7's network row, the clause PC-40 left | The same |
| After PC-42 | PC-42's row "How the environment token reaches the database" in B section 8's table "Choices made in C02" | The choice and its state (EV-C02-004 P-2) |

**Not changed on purpose.**
- The activation table: registration is not built earlier (§4.4).
- B:446, which stays as PC-40 left it; the choice is written into PC-42's table (EV-C02-004 P-2).
- B:45 and B:387, which PC-41 words for `deployment_drift`'s branch (EV-C02-004 Y-02).
- B:237, which holds as written (§4.2).
- B:40, within which §5.2's rule falls.
- P:646 ("Key arrangement"), which stays consistent.

### 9.2 Each other item of EV4 section 8 that bears on C02

| EV4 §8 item | Bears on C02? | Whose plan change makes it |
|---|---|---|
| 1 (6.3's "How is the token generated?", Section 12 item 1, KI rows 18 to 20) | Yes | PC-43 places 2, 4, 12 |
| 2 (`devos_kurulum`'s "Cannot" in 6.3 and B:35) | Yes | PC-43 places 1, 5 |
| 3 (6.3's exam row, 7.3, B:271, N08's `devos-evals` part → S1) | No: C05's exam setup | C05, under N-138 |
| 4 (B:273 and N08: the exam fact → S2) | C02 builds EvalRun's access rule; the exam fact's form is C05's | C05, under N-138 |
| 5 (Ek A section 6 → S3) | No | C05 |
| 6 (6.4: no GitHub trigger; DevOS's environments only for DevOS's sessions) | The S4 (d) part reaches Batu in C02 through Section 12 item 1 (PC-43 place 4); 6.4's routine text is C06's | C06, under N-139 |
| 7 (6.7's control-surface row: S9's layer and bridge) | Yes | W-C02-11's plan change |
| 8 (C03 test 3: every environment as the actor) | No | C03, under N-137 |
| 9 (5.6 and C03 test 5: S7's option) | No | C03, only if it adopts it |
| 10 (B 3.24 and PC-21 item 5: X1's fields) | Through T-77 | N-092's plan text (W-C02-04), with T-77's parts at their stages |
| 11 (Appendix C N04, N08, N17) | Yes | PC-43 places 9 to 11 |
| 12 (K-9 item 9 and 6.7's interactive-sessions row: the read-only connector and the exam schema) | No | C05, under N-138 |

### 9.3 The text that calls row 3's facts observed

Plan line 235 ("observed in C01 row 3"), 6.7's "C01 #3" cells (lines 723 and 734) and B:446 ("C01 #3 observation") are N-209 item (2). PC-40 (W-C02-16) corrected them, and merged at `eba94b1` before PC-43; this record names it (point 17).

PC-40's text says at each of the four places that where the fact is observed "is for C02's identity-chain design (W-C02-05) to decide". This design decides it (§3.2, §3.3), so PC-43 places 14 to 16 replace that clause at P:235, P:723 and P:734 with where it is first observed. The network secret stays the PC-08 note's reading, and the credentials, layers and format stop of P:723 and P:734 stay true. B:446 is not changed: its third column says what the choice would rest on, and the choice goes into PC-42's new table of C02's choices, with where the path is first observed in its state cell (PC-43's entry "To apply after PC-42"; EV-C02-004 P-2). (Revised: the first version, written before PC-40's text was known, changed B:446's second and third cells after PC-40 and said P:235, P:723 and P:734 needed nothing further.)

No text labelled [Batu's decision] changes. Criterion 26 (P:233) is untouched.

## 10. Parameters that set when dependent work can next start (point 10)

| Parameter | What it sets | Time it adds on the critical path | Source of its reason, with the date | Against Batu's later decisions |
|---|---|---|---|---|
| S5's form before task 3 | This record and PC-43 merge before W-C02-07 and W-C02-08 (already their `depends_on`) | None beyond this item | P:947 (row 3's fail path: "before C02 builds the identity chain"); PC-21 item 4 (2026-10-10); N-136 (2026-10-11) | D-019 and D-020 (2026-10-11) leave it as it is; D-020 asks for a mechanical structure, which S5 is |
| The header path observed before W-C02-09 builds beyond the first part (§3.3) | Sitting A sits between the first part's merge and the rest of W-C02-09 | Batu's wait for sitting A, less the part W-C02-08's schema work overlaps. His C01 steps were done within a day of being asked: `plan/work/C01.md`, "Batu's steps", rows 1 and 1a (asked 2026-10-10, done 2026-10-11) and row 2 (asked 2026-10-11T12:29Z, done 13:37Z) **[Obs: those rows]**; so hours at most **[Inf]** | Plan Section 9's ordering principle (PC-08, 2026-10-05) | D-017 (2026-10-10) prefers a session observing itself, which this is; D-020 (2026-10-11): one read call and one scan, no build-out. Sooner at the same quality: ask sitting A in the message that reports the first part's merge; nothing sooner, since the function must exist first |
| The bridge and the guard's tests before task 7 | B1 waits for W-C02-11 | Not set by this design (W-C02-11's) | N-136, N-174, N-181 (2026-10-11, 2026-10-12) | As W-C02-11 records |
| Batching of Batu's steps (A; B1; B2) | When steps 2 to 5 can be done | B1's and B2's waits lie on the path to W-C02-12 and W-C02-13, each within a day by C01's record; splitting B1 from B2 saves B1's wait when W-C02-11 finishes before W-C02-09 and W-C02-10; when both are ready they form one sitting. Batu's time: about 25 minutes for A (53 short steps), 40 to 50 for B1 (102), 15 for B2 (31) besides the sessions' own run time **[Inf]**. The work is the same as before CHK-C02-010; writing it out as single actions added copy, reload and Enter steps (§7) | Working order sections 7 and 8 (D-010, 2026-10-05; PC-23) | D-020 (2026-10-11): no more sittings than the order needs; Batu's principle 8 (step by step, together) |
| The session-opening hand-off (step 5) | When W-C02-12's real-token runs exist | Batu's B2 wait plus three short sessions, minutes to tens of minutes each **[Inf]** | P:878 item 1 (PC-06, 2026-10-05): a separate session "comes to Batu as a single, narrow question" | D-008 (the sessions' settings); D-017 and D-020 (2026-10-10, 2026-10-11): the first message is minimal and plainly defensive |
| N-208's re-reading points | Each named work in §8's table waits for its re-reading only if a trigger fired | Under an hour each time it fires **[Inf]** | PC-21 item 9 (2026-10-10); plan 0.3 item 12 | D-017 (documentation readings preferred), D-020 |
| `devos_ci`'s timing | Step 4, inside sitting A (§5.2) | One SQL line and one repository secret inside a sitting Batu makes anyway, minutes **[Inf]** | EV-C02-004 Y-03 (2026-10-12); B:98 ("in C02, for C03"), last set by PC-08 (commit `96220c7`, 2026-10-05; `git log -L98,98:plan/Ek_B_Veri_Modeli.md` at `560bcab`, run 2026-10-12) | None of the decision records after 2026-10-05, D-013 to D-030 (Batu's answers from 2026-10-06 to 2026-10-12), names the CI role, its key or the pull-request checks (their texts searched 2026-10-12 for "devos_ci", "CI key", "CI role" and "pull-request check": no match). None changes B:98's "in C02, for C03", which step 4 meets; and issuing the key in sitting A adds no sitting |
| The exposure of `devos_api` in sitting A | Sitting A waits until the first part is in both projects (Y-01: `devos-test` first, `devos` only if its tests pass) | A few minutes inside sitting A **[Inf]**; none, if EV-C02-001's build moves it into row 1's sitting | EV-C02-004 Y-06 (2026-10-12); R5 S11 (2026-10-12) | D-020 (2026-10-11): no more sittings than the order needs |
| `devos_kurulum`'s checker-verdict right ends at C03's hand-over | C03's start | None | P:872 ("Closing each stage": reviewed "until C03 by a fresh-context Checker subagent"), 2026-10-05: its content set by the D-010 transition bundle (commit `dbb24b5`, citing PC-06), its English text by W-C00-06's translation (commit `5cf796e`). P:1013 (C03's tasks: the audit environment re-reviews C00 to C02's acceptances by sample), 2026-10-05: added by PC-10 (commit `6d1ebbd`). Neither line changed after that day (`git log -L` at `560bcab`, run 2026-10-12); the plan's header date (version 2.1, 29 September 2026) is older than both | D-003 (2026-10-02) comes before both. Of the later decisions, D-019 and D-020 (2026-10-11) and D-029 (2026-10-12) tie their residuals to D-003's re-assessment at C03 and so keep the hand-over at C03. None of D-013 to D-030 moves it (searched 2026-10-12 for "C03", "binding review" and "checker") |

## 11. Notes closed or carried (point 11)

| Note | Disposition |
|---|---|
| N-125 (`plan/work/C02.md`) | Closed by a dated line: §5.1, §5.2, §5.4, §5.5; Section 12's text by PC-43 place 4 |
| N-131 (`plan/work/C02.md`) | Closed by a dated line: items (1) to (3) and the line of 2026-10-12 by §1 to §3; the observations themselves are carried by N-221 on `plan/work/C02.md` (step 4 and the self-check, before W-C02-09 builds beyond the first part) |
| N-208 (`plan/work/C02.md`) | Closed by a dated line: §8; its rule is N-220 on `plan/work/C02.md` |
| N-136 (`plan/work/C02.md`) | Its design parts recorded by a dated line (S5; S8 lines 1 to 3 with line 3 moved to C04; N04, N08 and N17; Batu's step text); it stays open for its build parts: W-C02-08 (task 4's lines), W-C02-11 (the bridge, the hook, the tool list), W-C02-12 (the steps) |
| N-137 (`plan/work/C03.md`) | Nothing it relies on changes. N08's database part also runs in C02 (§4.5); N-137's C03 run stays |
| N-140 (`plan/work/C12.md`) | Nothing changes: the database calls of §1 use no session tool |
| N-181 (`plan/work/C02.md`) | Nothing changes. Each step-5 session records its own tool list at its start and its end (§6.2), which W-C02-11 may use as a confirming list |
| N-203 (`plan/work/C03.md`) | Nothing it relies on changes. The role class the database records per state-changing call and per refusal (F06; EV-C02-002 DM-19; EV-C02-004 X-19) is a read of DevOS's own sessions' activity that needs no session tool, which C03's criterion by purpose may weigh |
| New: N-220 (`plan/work/C02.md`) | N-208's rule (§8) |
| New: N-221 (`plan/work/C02.md`) | The identity chain's first part, step 4 and the self-check (§3.3, §6.1) |
| New: N-222 (`plan/work/C03.md`) | `devos_kurulum`'s verdict right (the transfer's copies) ends at C03's hand-over; test 8 and N26 with synthetic tokens inside the migration job's run and the secret-scope part at C09; the format scan in test 3; `devos_ci` readable by every session; the CI key exists from C02's step 4. At merge it sits beside N-211 (EV-C02-004 P-7) |
| New: N-223 (`plan/work/C04.md`) | S8 line 3, with `register_session` |

## 12. Batu's matters (point 12)

| Choice | Kind | Why |
|---|---|---|
| The token's form (network secret) | The builder's | No departure from criterion 26 as the PC-08 note reads it (§1.1) |
| A fallback that lets a session read its own token (§2.1 (1a), §2.2) | Batu's decision, conditional: Q-A, prepared now and filed only if the observation shows it; nothing relies on it before his answer | It departs from criterion 26 as the PC-08 note reads it (EV2 §4 (a)) |
| Separate accounts again, or a second machine account (§2.3; N-063 B4) | Batu's decision, conditional: Q-B (D-020 reopened), only on §2.3's path | Money and his accounts (D-020) |
| Paid features | None | Network secrets: "available on Pro and Max plans", no charge named **[Doc: CE; R5 §5]**; nothing else here costs |
| Steps A, B1 and B2 | Steps (Appendix E §7) | What they ask of his accounts is covered: environments in his account (D-020 (a)), network secrets (named in D-020 (d)), tokens in his Supabase projects (plan Section 12 item 1; B:46), exposing `devos_api` in his projects' API settings ("Batu's steps" row 1a; R5 S11), a repository secret of `devos` (6.7: "Batu (the secrets)"), and keeping his own sessions off DevOS's environments (S4 (d), part of W-C01-42's structure for D-020 (a)). Nothing goes beyond D-003, D-019 and D-020 |
| Every other choice here | The builder's (working order section 8) | — |

**Q-A** (Appendix E §3; filed only if §2.1 (1a) or §2.2 is observed): "DevOS ortamlarının veritabanı anahtarlarını oturumun göremeyeceği 'ağ sırrı' olarak saklama yolu denemede çalışmadı; anahtarı, oturumun okuyabileceği bir ortam değişkenine koymayı kabul eder misin — (a) evet, oturum kendi ortamının anahtarını görebilir, dışarı sızan anahtar biçiminden yakalanır, iptal edilip yenilenir ve bu, ölçüt 26'nın okunuşundan bir sapma olarak kaydedilir; (b) hayır, ortamlar ve gerçek anahtar denemeleri, oturumun göremeyeceği bir yol bulunana kadar bekler — önerim (a)." English: the network-secret form failed in the trial; does he accept putting the token in an environment variable the session can read, (a) yes, recorded as a departure from criterion 26's reading, with format stops and revoke-and-renew, or (b) no, the environments and real-token tests wait; recommended (a), because separation still rests on each token's role class and the outbound stops, while (b) stops C02's real-token work. The recommendation is weighed again with the evidence when the question is filed, and its decision record then holds the six parts of Appendix E §3.

**Q-B** (only if §2.3 is observed): D-020 is put to him again with the new evidence, its options (b) to (e) as written there.

## 13. No fact upgraded (point 13)

Every platform or Supabase fact above carries **[Doc: …, read …]** with its page and reading date, or **[Inf]**. Only three kinds of fact are called observed, each with its record: C01's records cited as such (for example L-119), the dates of Batu's C01 steps in §10, and, in §14, the executor's observation of this working session's tool list on 2026-10-12 (a tool named `query_logs` on the read-only Supabase connection, not called), recorded in the executor's log entry `plan/ledger/C02-log.md` L-289. What that tool reads is an inference. The joined header path (F-d) and G14 (F-h) are inferences. Plan line 235's "observed in C01 row 3" is corrected by PC-40, not repeated here.

## 14. No token, and nothing derived from one (point 14)

- No value, hash, prefix, length or marker of any token or key is written in this record, in PC-43, in the step text or in the key inventory. The format's literal marker is deliberately left unwritten (§1.3). The format's strength (§1.3) is a requirement on the generator, fixed before any token exists, not a property read from a token. Hosts, the header name and the secrets' names are names, not values. The SQL lines carry no value.
- **The design keeps the token out of every table, record and log the database writes (B 3.27).** `env_tokens` holds only the hash. A refusal is recorded as RejectedAttempt with its reason code only (§15), never the presented value or its hash, because an unknown value may be a mistyped real token or another system's secret. The derivation reads only the token header from `request.headers`. The Data API's own handling of the header, which no DevOS function controls, is kept out of the logs by the log check below.
- **The claim token likewise** (§1.7): Assignment holds only its hash; only `claim`'s result carries it; its marker, like the environment token's, is left unwritten here.
- **No `devos_api` function returns the header's value or puts it in an error** (R5 R4), nor in a notice or a raised message. Postgres logs can keep statement text and error details **[Doc: SL]**, and the gateway's log omits custom headers **[Doc: SL]**, but the rule does not rely on that.
- **The Data API's own handling of the header (CHK-C02-010 C3).** The Data API puts every request header, the token's header among them, into `request.headers` ("JSON object of the request's headers" **[Doc: SA, read 2026-10-12]**). That it does so through a statement in the request's transaction, which Postgres logging could record with the header's value, is **[Inf]** (CHK-C02-010 point 14). Whether it does depends on the project's statement-logging settings, which were not read; nor was Supabase's "Configure statement logging" page, which SL's logs page points to. No DevOS function writes this, so the rule above does not cover it; if the statement is logged, the token sits in `devos`'s Postgres logs (F-g).
  - **Its state: a check that keeps it out** (the log check), made by the executor, its owner, on `devos` only, since no real token reaches `devos-test` (§1.5).
    1. *Settings, before sitting A is asked.* Through the builder's read-only connection, the executor reads `devos`'s statement-logging settings, their names and values only (none is secret). Sitting A is asked only if they do not record the Data API's statements **[Inf: that these settings decide it]**. If they would, changing them comes first, by the path the "Configure statement logging" page gives when it is read then, and sitting A waits for it. First observed: there, before sitting A.
    2. *Logs, after a token has passed.* The executor searches `devos`'s logs, each source the tool reads, for strings of the token format's marker (§1.3), and records a count per source, never a line. When: right after §3.3's self-check, before W-C02-09 builds beyond the first part; and again after B2's sessions, before W-C02-12's record is judged. Its positive control comes first: a synthetic string of the format, made up and labelled synthetic, is put into the same logs by a read-only statement through the same connection that fails on it, so that the error, which Postgres logs, carries it **[Inf]**. The control must be counted, or the result is "could not check". Any count beyond the control is a finding. Every token that has called `devos` since the last zero count (the CI key among them, which also travels in the header, §5.2) is then revoked and renewed (P:648), and the settings are corrected before a new token is stored.
  - **Does the builder's read-only connection read those logs?** **[Obs: the executor, this working session's tool list, 2026-10-12; recorded in `plan/ledger/C02-log.md` L-289]** The read-only Supabase connection offers a tool named `query_logs`. It was not called. That it reads the projects' Postgres logs is **[Inf]** from its name; its parameters and scope were not read. So a token in those logs could reach the builder, against "The builder never sees the value" (P:648, which PC-43 place 2 keeps). Hence part 2's count-only form, and one rule: until part 2's count after B2 is zero beyond its control, the executor reads `devos`'s logs only in that form.
  - **If the check cannot be made.** A part cannot be made if the settings cannot be read through the read-only connection, or if `query_logs` cannot return a count without returning log lines (read from the tool's own description, without calling it, before sitting A is asked). That part is then "could not check" (plan Section 8 item 14), and the path is a documented, untested residual. Its owner is the executor, who records it in its log entry (`plan/ledger/C02-log.md`) before sitting A is asked. While it stands, the executor does not read `devos`'s logs through that tool at all.
  - **What part 1 leaves.** Logging that the statement-logging settings do not govern, for example an error raised in the statement that sets `request.headers` **[Inf]**, stays a documented, untested residual after part 1. Its owner is the executor, and part 2 is what would show it.
- The client path never prints request headers, and a session's scan prints counts only.
- **Tests:** W-C02-09 point 3 (looked for by value, right after issuing); W-C02-07 point 7 (the format scan of the test files, with its planted control); W-C02-12 point 9 (the format scan of the repository, branches, issue #6 and the records).

## 15. No cross-environment opening left (point 15)

| Operation needing another's authority | The rule that refuses it | The test that shows it |
|---|---|---|
| A binding verdict or acceptance with the working token | B:237; B:379's role list | N04 (C02, W-C02-07); real token: W-C02-12 point 5 |
| The same with the exam token | B:38 | W-C02-07's matrix (§4.1); W-C02-12 point 5 |
| The same with the `devos_kurulum` token, outside the ledger transfer's path | S8 line 1 (PC-43 places 5 and 13) | N04 as PC-43 place 9 extends it; W-C02-12 point 5 |
| The same with the `devos_ci` or `devos_backup` token | B:40; B:41 | W-C02-07's matrix; C03 test 1; N26 |
| An exam record read with the working, audit, `devos_kurulum` or `devos_ci` token | B:273; S8 line 1 | N08's database part in C02 (PC-43 place 10); W-C02-12 point 5; N08 at C03 (N-137) |
| A product written with the audit or the exam token | B:37; B:38 | W-C02-07's matrix; N28 (in the same transaction); W-C02-12 point 5 |
| Approving a rule change, an effort reduction or a standing policy with the working or `devos_kurulum` token | B:37; B 3.18; S8 line 1 | N03; W-C02-07's matrix |
| A claim token used with another role class's token: an effect, `heartbeat` or `release` | S8 line 2 (§4.3; EV-C02-004 X-16) | N17 as PC-43 place 11 extends it, a case for each kind of call; W-C02-12 point 6 |
| Revoking another's claim with any token but the audit environment's | `revoke_claim` only `devos_denetim` (EV-C02-002 DM-29) | W-C02-07's matrix (§4.1) |
| Opening or revising a Mission with any token but `devos_kurulum`'s, or without a `batu`-class decision answered or accepted | §4.1's row (EV-C02-004 X-17); EV-C02-002 DM-23 | W-C02-07's matrix; N29 |
| Reading RejectedAttempt with any token but the audit environment's | EV-C02-002 DM-19; EV-C02-004 X-13 | W-C02-07's matrix |
| Another session's claim | B 3.5 | N17; W-C02-12 point 6 |
| A fake role name or session ID with a verified token | B principle 8 (declared; no authority rests on it) | N04; N17; W-C02-09 point 3 |
| Issuing or revoking a token with any token | B:35; B:46 (no API role has EXECUTE) | W-C02-09 point 3; W-C02-07 |
| `deployment_drift` or `mark_exported` with another role class | B:387; B:386 | W-C02-07's matrix; N26 (C03) |
| A call whose token is missing, empty, malformed, unknown or revoked, or whose header cannot be read (for example through Realtime or Storage, which never set `request.headers`) | The token is not verified: the derivation gives no role class (RejectedAttempt records `none`, a value meaning no role class, never a default role class); the call is refused before any other check, with its reason code: `missing`, `empty`, `malformed`, `unknown`, `revoked` or `header_unreadable` (EV-C02-004 X-04, X-06, T-8; plan 6.2; Section 8 item 14; PC-43 place 7) | W-C02-09 points 3 and 7; W-C02-07 point 6, one case per reason code |
| Calls with no verified token from outside, since the publishable key is public (P:630) | Refused; counted as RejectedAttempt counts calls without a verified token, one row per function, reason code and hour with a count increased in place (EV-C02-002 DM-19; EV-C02-004 X-04, X-05), so an outside caller cannot grow the database; PC-43 place 7 refers to that count and does not set its key | A test W-C02-07 writes: a burst of such calls adds no rows beyond the count |
| Acting on another environment's sessions, routines or settings | Not the database's: S9 and S10, with R1 accepted under D-020 (a) | C03 test 3 (N-137) |
| A commit pushed by the audit or the exam environment under the shared GitHub identity | No layer here beyond S8 (EV4 §4) | C03 test 5 with T-81 (N-137) |

## 16. No choice passes silently (point 16)

Section 0's table lists every choice with its state.

## 17. N-209 (point 17)

N-209's corrections (1) to (3), item (2)'s four places included, were carried by PC-40 (W-C02-16), merged at `main` `eba94b1` before PC-43; this change carries none of them. PC-40's text at P:235, P:723 and P:734 leaves where the facts are observed to this design, so PC-43 places 14 to 16 answer that pointer, and the token row of PC-42's table of choices takes the choice; B:446 stays as PC-40 left it (§9.3).

## Interfaces assumed

What this design assumes of the items designed beside it, and what changes if an assumption fails. EV-C02-004 settled I-1 to I-7 and I-9 (revised; the first version's text of each is in its "If not" or the Revision section).

- **I-1 (W-C02-03). Settled by EV-C02-004 Y-01.** The migration job applies to `devos-test` first, compares and runs its tests there, and applies to `devos` only if all three succeed. §3.3 and §6.3 rely on it.
- **I-2 (W-C02-03). Settled by Y-02.** The migration job calls `deployment_drift` through its direct login with the migration credential, with no environment token; `deployment_drift` is the one function with that branch (§1.6), and PC-41 words B:45 and B:387 so.
- **I-3 (W-C02-03). Settled by Y-03.** `devos_ci` is this design's, issued at step 4 (§5.2). Until it exists, the pull-request checks read the migration job's run record; what a difference or "could not check" stops is EV-C02-001's (its point 1 (c)).
- **I-4 (W-C02-03). Settled by Y-04.** EV-C02-001 states, as a rule of the job and of the migrations' review, that no migration and no job calls `issue_env_token` or `revoke_env_token` in `devos` (§6.3, route 2).
- **I-5 (W-C02-03, W-C02-07). Settled by Y-05.** The owner-level path in `devos-test` is the migration job's `devos-test` step (EV-C02-001's probe P10 settles as which role); no other route reaches `devos-test` (§6.3). *If EV-C02-001's build shows the job cannot issue and revoke synthetic tokens there:* "Batu's steps" row 1a's owner-only lines stand as a one-time step, F08 (c)'s revocation needs a path that is not recurring for him (criterion 21), and the executor reopens §6.3.
- **I-6 (W-C02-03). Settled by Y-06.** The exposure of `devos_api` is in sitting A (§7), or in row 1's sitting if EV-C02-001's build shows it can be made before the schema exists.
- **I-7 (W-C02-03). Settled by Y-07.** PC-41 changes Section 12 item 1's migration sentence, PC-43 its first sentence; merge order PC-41, PC-42, PC-43; each later change quotes its old text from the `main` commit it is written against, and the executor re-quotes at merge.
- **I-8 (W-C02-06).** The ledger transfer writes with the `devos_kurulum` token through a path of its own, so that the database tells its copies of verdicts and acceptances from a direct verdict (§4.2); the copies keep role class `devos_kurulum` and count as no audit verdict; verdicts given after the transfer's first run and before C03's hand-over enter only by that path; dry runs of the transfer in `devos-test`, if W-C02-14 wants them, run inside the migration job (Y-05). *If W-C02-06 needs them as `devos_denetim`, or cannot give the transfer a path of its own:* that conflicts with S8 line 1, B:237 and criterion 30, and is settled by origin; the executor reconciles the two records before either is judged; any rewording of B:237 is W-C02-06's plan change.
- **I-9 (W-C02-16). Settled.** PC-40 merged at `eba94b1` with N-209 (1) to (3) (§17).
- **I-10 (W-C02-04).** EV-C02-002, revised under EV-C02-004: states the global authority epoch's row and its lock order as its decision DM-01 (X-02); defines "verified" in DM-19 and gives the count's key and form (X-04, X-05); drops the old-epoch token and the epoch as a token's validity (X-03); names the decision of Batu's that the real-token tests' Mission rests on, and its label (X-10); cites §1.6's derivation (X-01), §4.3 for `heartbeat` and `release` (X-16) and §4.1 for `open_mission` (X-17); chooses F06's list by "changes a table other than RejectedAttempt", so that read functions, which record refusals, are not declared `STABLE` (X-14); and cites this record for B section 8's token row, through PC-42's table (P-2). *If any of these differs:* the executor reconciles the two records before either is judged.
- **I-11 (W-C02-04).** PC-42's place 36 row for the token stands as PC-43's entry "To apply after PC-42" quotes it; the executor re-quotes it at merge. *If PC-42 drops the row:* entry A adds it instead.
- **I-12 (W-C02-03).** *If PC-41's migration sentence also names the exposure of `devos_api`:* one of the two drops it at merge (PC-43 place 4).

## What this record cannot show

- It is a design. Nothing in it is observed on the platform, and every documentation fact stays untested after any verdict on it. Its independence level is same-session, fresh-context.
- The screen names in §7 rest on CE (read 2026-10-12) and on the C01 step text; the Supabase and GitHub labels were not re-read, so each step tells Batu to stop if the screen differs.
- G14 and the header path are provisional until §3.3's self-check.
- Whether the Data API's handling of the header reaches `devos`'s Postgres logs is an inference; §14's log check observes it, or records it as a residual.
- The literal format markers (the environment token's and the claim token's) are fixed by W-C02-07, not here.
- The C02 file's "Batu's steps" table (rows 1a and 4, whose timing and content this design changes) is the executor's (EV-C02-004 Y-12) and was not changed here; N-221 says how to read it.
- EV-C02-001 and EV-C02-002 are being revised beside this record. This revision follows EV-C02-004's decisions, not those records' final texts, which it has not seen; "Interfaces assumed" names what it takes from each.

## Revision after EV-C02-004 (2026-10-12)

Revised by a second producer subagent, against `main` `eba94b1`, to the executor's reconciliation decisions in `evidence/C02/EV-C02-004_reconciliation_decisions.md` (part 1 for this record and PC-43; part 2's Y-01 to Y-07 as they touch it). Every Old text of PC-43 places 1 to 12 was re-checked at `eba94b1` and found unchanged by PC-40; only Section 12 item 1 moved (line 1230 to 1233). Each change, with its decision and where it is:

| Decision | Change | Where |
|---|---|---|
| X-01, T-6 | The derivation named `devos_private.caller_role_class(function_name)`; `token_role_class()` is a read built on it, refused with its reason code when there is no verified token | Names line; §1.1; §1.6; §0 row 44; PC-43 places 7 and 8; N-221 item 1 |
| X-02 | EV-C02-002 DM-01 cited for the global authority epoch's row and its lock order | §1.4 |
| X-03 | The reading kept (a token is verified until revoked; an epoch increment ends claims); `EnvToken.authority_epoch` removed, the informational option weighed and not chosen | §1.4; §0 row 46; PC-43 place 7 (fields line) and alternative (I) |
| X-04, T-5 | "Verified" means "valid"; a revoked, unknown, malformed, empty or missing token is not verified and is counted; the count's key is EV-C02-002's, and place 7 refers to it | Terms; §1.4; §15; PC-43 place 7 |
| X-06, T-2 | "Reason code" throughout; the six values fixed | §2.1; §6.2; §14; §15; PC-43 places 7 and 8 |
| X-07 | F08 (c)'s epoch change made by revoking a synthetic token; no third owner-only function | §6.3; PC-43 place 6 |
| X-08 | The claim token's form decided: source and strength, its own marker, hash, returned once, stopped by the guard | New §1.7; §1.3; §1.6; §14; §0 row 45 |
| X-10, T-10 | The real-token tests' fixtures in `devos` written with the `devos_kurulum` token, labelled synthetic, no synthetic `batu`-class record; the Mission's base and label are EV-C02-002's | §6.2; §1.5; §3.1; §0 row 50; I-10 |
| X-11 | Rows for `revoke_claim` (`devos_denetim` only) and `heartbeat` (as `claim`) | §4.1; §15; §0 row 47 |
| X-13 | The `devos_kurulum` route to RejectedAttempt dropped: the read-only connection in `devos`, the migration job's step in `devos-test` | §6.2; §4.1; §4.2 ("Cannot"); §15; §0 row 48; PC-43 place 5 and place 12 row 21 |
| X-15, T-11 | Event (with `origin`) and the global authority epoch's row added to the identity chain's first part | Names line; §3.3; N-221 item 1 |
| X-16 | S8 line 2 covers every call that takes a claim token (effects, `heartbeat`, `release`), with an N17 case for each | §4.3; §4.1; §15; §0 row 14; PC-43 place 11; N-136's dated line |
| X-17 | `open_mission` and `revise_mission` permitted to `devos_kurulum` until C06 builds `answer_decision`'s path; the authority stays DM-23's | §4.1; §4.2; §15; PC-43 place 5 |
| X-18 | Every "—" cell filled from B sections 2 and 4 and B 3.23; rows added for fingerprint matches, a check's result, reading RejectedAttempt and `ingest_source` | §4.1; §0 row 12 |
| X-19 | "Per state-changing call and per refusal" | §2.3; §6.2; §7 B2's system check (Turkish and English); §11 (N-203) |
| P-2 | The entry "to apply after PC-40" replaced by "To apply after PC-42": the choice goes into PC-42's row; B:446 left as PC-40 left it; the first version's third-cell text moved into that row's state cell | PC-43's entry A; §9.1; §9.3; §17; §0 row 11; N-131's dated line; I-11 |
| P-6 | Appendix B places given by quoted text, with lines at `eba94b1` and after PC-42 | PC-43's Authority, places 5 to 8 and 13, and "Not changed on purpose" |
| P-7 | N-222 and N-223 noted to sit beside N-211 and N-212 at merge (N-212 item 7 is EV-C02-002's) | PC-43's notes; §11 |
| "Outside the pair" | Of the two options, **limited** (reason in §4.2): `devos_kurulum` writes verdicts and acceptances only as the ledger transfer's copies, through its path; B:379 says so | §4.1; §4.2; §15; §0 row 13; PC-43 places 1, 5, 9 and 13 (new), place 12 row 21, alternative (H); N-222 item 1 |
| T-1, T-3, T-4, T-7, T-8, T-9 | RejectedAttempt; `env_tokens` as EnvToken's table; "the global authority epoch"; "owner-level path" (the first version's "owner-level connection" and "test path" replaced); `none`; "test database" not used for `devos-test` | Terms; §1.4 to §1.6; §5.4; §6.3; §15; PC-43 place 7 |
| Y-01 | The migration job's order: `devos-test`, its comparison and tests, then `devos` | §3.3; §6.3; N-221 item 2; I-1 |
| Y-02 | `deployment_drift` named as the one function with the direct-login branch | §1.6; §4.1; §5.3; §0 row 21; PC-43 place 7; I-2 |
| Y-03 | `devos_ci`: issued at step 4, one key from `devos`, reaching `devos` only, a repository secret; until then the checks read the run record | §5.2; §1.5; §5.5; §7 A steps 41 to 51 (33 to 42 before CHK-C02-010; no longer conditional; the `devos-test` key dropped); §10; §0 row 20; PC-43 places 2 and 4, place 12 row 22; N-125's dated line; N-222 item 5; I-3 |
| Y-04 | The rule of the job and of the migrations' review cited | §5.3; §6.3 route 2; I-4 |
| Y-05 | The owner-level path in `devos-test` is the migration job's step; no other route reaches `devos-test`; row 1a's owner-only lines not needed. Following from it: the `devos-test` `devos_kurulum` token is dropped (a choice that changed; its alternative and the new reason in §1.5 and §5.1), and the header path is first observed on `devos` | §1.5; §3.1; §3.3; §4.1; §5.1; §5.4; §6.3; §7 (batches, A); §0 rows 27 and 42; PC-43 places 2, 4, 6 and 7, place 12 rows 21 and 29, alternative (J); N-221; N-222 item 2; N-125's dated line; I-5 |
| Y-06 | The exposure of `devos_api` in both projects joins sitting A, before the self-check | §7 (batches; A steps 1 to 12, 1 to 7 before CHK-C02-010, and its system check, Turkish and English); §5.5; §10; §12; §0 row 39; PC-43 place 4; N-221; I-6 |
| Y-07 | Merge order PC-41, PC-42, PC-43; place 4 changes only the first sentence and is re-quoted at merge | PC-43's Authority and place 4; I-7 |

**Beyond EV-C02-004's list, to keep the record consistent with it and with `main` at `eba94b1`:**
- PC-43 places 14 to 16 (P:235, P:723, P:734). PC-40's merged text says at each that where the fact is observed "is for C02's identity-chain design (W-C02-05) to decide"; the first version's statement that these lines needed nothing further was written before that text existed. The places replace only that clause (§9.3).
- `devos_kurulum`'s "Cannot" in PC-43 place 5 and KI row 21 names RejectedAttempt (X-13); place 2 names where the CI key is kept (Y-03).
- §1.7's hash rule is stated for the environment token too, so that both kinds have one rule (X-08).
- The abbreviations' note on line numbers at `eba94b1`, the envelope's revised commit and the sources' new item.
- §7's Turkish and English sitting A renumbered (44 steps then; 53 after CHK-C02-010); B1's steps 21 and 22 re-pointed to A's new numbers (written out as single steps after CHK-C02-010, now B1's steps 45 to 57).

**Not applied, and why.** None of the decisions assigned to this record was left unapplied. Part 1's X-05, X-09, X-12, X-14, X-20 and P-7's N-212 item, and part 2's Y-08 to Y-12, are other records' (EV-C02-001, EV-C02-002, the executor's); this record cites them where it relies on them (I-10, I-12, N-221).

## Changes after CHK-C02-010 (2026-10-12)

Made by a producer subagent in a scratch clone at `094bba1` (the design commit `819287c` with the verdict filed), to the conditions of `evidence/C02/checks/CHK-C02-010.md` (PASS-WITH-CONDITIONS). PC-43 is not changed (C3 below).

| Condition | What changed | Where |
|---|---|---|
| C1 | Every numbered step is one action with its own see-line, and no step repeats others by number. **Written out:** A 7 as A 7 to 12 (`devos`'s exposure); A 29 as A 35, one step that returns to the dialog, since CE documents that it stays open after **Connect** (§7, "Single actions"); B1 15 and 16 as B1 17 to 27 and 28 to 38; B1 17 to 23 as 39 to 58, with B1 21 and 22 written out as 45 to 57; B1 24 and 25 as 59 to 78 and 79 to 98; B2 1 to 8 as 1 to 10; B2 9 and 10 as 11 to 20 and 21 to 30. **Split:** A 31 as A 38 (type the name) and 39 (paste the value), with A 30's "click and open a line" as 36 and 37; B1 13 as 13 (Enter), 14 (type) and 15 (paste), and the same in each environment's part; B1 26 as 99 (type `/remote-env`), 100 (Enter) and 101 (choose **Default**), with the skip condition stated before them. **Added:** before each paste of a line given on #6, a step that copies it from its box there: B2's first message (B2 8, 18 and 28), and for the same reason the SQL lines (A 14 and 43; B1 41, 61 and 81). Where a written-out step's see-line would otherwise not hold, a step makes it hold: a reload of the claude.ai/code tab (B1 17, 28, 45, 65 and 85), "delete any line in the box" (B1 40, 60 and 80, as A 42), and a new tab per session (B2 1, 11 and 21). A 47 opens GitHub in a new tab, so that #6 stays open. **Counts:** A 53 steps (was 44), B1 102 (was 27), B2 31 (was 11). **References updated:** the batches paragraph (the steps that drop out if the exposure moves to row 1's sitting: A 1 to 6 and 9 to 12); B1's former pointers to A's numbers (now written out); the system checks (none named a step number; B1's and B2's were rewritten for C2); §10's counts and times; the Revision section's rows Y-03 and Y-06 and its last bullet | §7 (batches; "Single actions"; 7.1; 7.2); §10; Revision section |
| C2 | §6.2's first message records the non-secret `DEVOS_ENVIRONMENT` value beside `token_role_class()`'s answer (item 3) and the result of one plain request to a host outside the Trusted list (item 4), both in the result file (item 6). A new bullet says how a token stored in the wrong environment, and an environment created at the wrong network level, are caught and what follows. Another names what stays unchecked, with its reason: the environment's name against its variable; a token in an environment outside the three; a level stricter than Trusted; a request the guard refuses; his own sessions. B1's system check (Turkish and English) says the same; B2's records the two values; §0 row 26 | §6.2; §7.1 and §7.2 (B1's and B2's system checks); §0 row 26 |
| C3 | F-g's row names the Data API's own handling of request headers (it puts them into `request.headers`, the token's header among them) as a path into `devos`'s Postgres logs, with its labels. §14 gives the path one state: a check that keeps it out, made by the executor. Part 1 reads the statement-logging settings before sitting A is asked. Part 2 is a count-only search of the logs with a positive control on a synthetic string, after the self-check (before W-C02-09 builds beyond the first part) and after B2 (before W-C02-12's record is judged). If the check cannot be made, the path is a documented, untested residual owned by the executor and recorded before sitting A. §14 records as the executor's observation of 2026-10-12 that the read-only Supabase connection offers `query_logs` (not called). It says that the connection can therefore read those logs **[Inf]**, and limits the executor's reads of them to the count-only form. A's system check (Turkish and English) names the count. Also: §0 row 51 (new); §13 (a third kind of observed fact); the envelope; "What this record cannot show". **PC-43 does not change.** Place 2's "The builder never sees the value" (P:648), place 3's text on `request.headers` and place 7's rule ("No function returns the header's value or puts it in an error or a log message") all stay true; the log check is the executor's, made before and after sitting A, and needs no plan text | §3.1; §14; §7 (A's system check); §0; §13; envelope; "What this record cannot show" |
| C4 | Row "`devos_ci`'s timing": B:98's date (last set by PC-08, `96220c7`, 2026-10-05), and in place of "—" a check against the later decision records D-013 to D-030. Row "`devos_kurulum`'s checker-verdict right ends at C03's hand-over": P:872's date (2026-10-05; content by the D-010 transition bundle `dbb24b5`, English text by `5cf796e`) and P:1013's date (2026-10-05; PC-10, `6d1ebbd`), found with `git log -L` at `560bcab`. Its check against later decisions now names D-019, D-020 and D-029, since D-003 is older than both lines | §10 |

**The verdict's non-blocking findings.**
- *Quotation in §1.1:* taken. The CE sentence is now quoted verbatim ("Whichever level you pick, sessions can still reach these").
- *§6.2's two-claims case:* taken. It now reads as W-C02-12 point 7 reads it: a case within one session, labelled so and not counted as the real-session case. It also says why no second session is asked for.
- *Point 8, "an item of its own" read as a carrier note (N-220):* not taken here. The verdict leaves the reading to the executor's word, and nothing in this record changes under either reading.
- *B:446 and B section 8 carrying the topic in two rows:* not taken. It follows EV-C02-004 P-2, the executor's decision.
- *Merge-time steps (entry A; place 4 re-quoted after PC-41):* not taken. They are the executor's, at merge.
- *The checker's scratch file:* not this record's.

**Beyond the conditions, to keep the record consistent:** the front matter's source line for this change, and §10's batching row, which says why the step counts grew.
