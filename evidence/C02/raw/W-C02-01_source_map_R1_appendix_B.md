# C02 source map R1: Appendix B

## Disciplines (D1–D9)

D1: yes: what counts as "C03's start" and "needed earlier" decides how a part is classified, so for every deferred part I give the dependency, the evidence against it, and what fails without it, and I leave the classification to the work list.
D2: uncertain: a source map can lean toward flagging everything to look thorough, or toward flagging little to keep the list short, so each item in section 2 carries its counter-evidence and I mark every inference.
D3: yes: I read W-C02-01's acceptance condition (`plan/work/W-C02-01.md`, items 2 and 3) and shaped all five sections to its item 2, including the section 8 choices assigned elsewhere.
D4: yes: this report is evidence for the work list's checker, so every count and claim comes from a direct read or grep of the live tree at `796c427`, not from summaries, and inferences are labelled.
D5: yes: PC-08 is 2839 lines and I read only the places that bear on C02 and C03; I read Appendix B, plan Section 9, 6.2, 6.3 and Appendix C directly rather than PC-08's copies, and "Open" lists what I did not read.
D6: no
D7: no
D8: yes: the map depends on the current `main`, so I checked HEAD (`796c427`, L-280), the ledger state (C02 running, W-C02-01 planned) and the open notes on `plan/work/C02.md` and `C03.md`.
D9: no

**Sources and abbreviations.** All paths are under `/home/user/devos/`, read on `main` at `796c427`.
- **B** = `plan/Ek_B_Veri_Modeli.md`
- **P** = `plan/DevOS_Kurulum_Plani.md`
- **C** = `plan/Ek_C_Testler.md`
- **PC08** = `plan/decisions/PC-08.md`
- **N2** = `plan/work/C02.md`
- **N3** = `plan/work/C03.md`
- **WO** = `plan/Installation_Working_Order.md`
- **KI** = `plan/key_inventory.md`
- **LG** = `plan/ledger.md`

---

## 1. Built in C02

**The rule.** B:55 says "C02 builds the families marked C02 and those C03 needs at its start." P:998 (task 1) and PC08:24 say the same. B:98 says "Functions (section 4) and jobs (section 5) follow their families, with the exceptions stated there."

**C02-stage tests (C).** The C02 tests are F01, F04, F05, F06, F07 (C02 and C08, C:95), F08 and Concurrency (C:30 "(C02)", C:106). In the C2 table they are N01, N02, N03, N04 (its C02 part), N09 (C02, C04), N17, N18, N25 (C02, C08), N28 and N29 (C02; the Constraint case from C05) (C:118–146), plus K05 (C:160). F02 moved to C04 (C:50; P:1007) and F03 is C09 (C:59).

### 1a. Record families activated in C02

| Family | Activation text | Serves (C02 task / acceptance / test) |
|---|---|---|
| Mission 3.1 | B:59 "C02 \| Work's parent (`mission_ref`); its own rule is first tested in C10" | Task 1; F05 scope; N29's Mission case (C:146) |
| Need 3.2 | B:60 "C02 \| N01" | Task 5 (K-1 format gate); acceptance "format gates reject empty fields"; N01 |
| Work and WorkStanding 3.3 | B:62 "C02 \| F05, F08, N17, the concurrency test" | Tasks 1, 2 and 5 (impact-class rule, B:134); N29, F05, F08, N17, Concurrency |
| Relation 3.4 | B:63 "C02 \| F04, K05, F08 (a)". The `informed_of` fields are built in C06 (B:140) | Task 2; F04, K05, F08(a), Concurrency (no cycle, C:108) |
| Assignment 3.5 | B:64 "C02; the liveness signal's sender and form in C06"; B:154 "built in C02 with the claim" | Task 3 (claim token); acceptance "✘ An operation with another session's claim…"; N17, F01(c), F08(c), Concurrency |
| Finding 3.8 | B:70 "C02 \| N09" | N09 (C02 part); format gate on `counter_evidence_searched` (B:191, inference: principle 12 applies) |
| Artifact 3.10 | B:72 "C02 \| N28; F05" | N28, F05; the high-impact path trigger (B:134) |
| Review, Verdict, Acceptance 3.11 | B:74 "C02 \| N04, N25, N28; the sample of N01" | Tasks 4 and 5 (sample reviews, B:240); acceptance "'filled but meaningless' examples fall to the sample review"; N04, N25, N28, N01; task 8 (verdicts) |
| Operation and Observation 3.12 | B:75 "C02 \| F01, F07, F08" | F01, F07, F08; N29 (irreversible `effect_class`, B:134) |
| Event 3.13 | B:76 "C02 \| F06" (with `exported_at`, B:255) | Task 2 ("every transition produces an event", P:999); F06; task 8 (log entries); `mark_exported` |
| EvalRun 3.15 | B:78 "C02, for C03 (its access rule) \| N08" | C03's N08 (C:125); C03 test 1 |
| Decision 3.17 | B:83 "C02; `answer_decision` with answer identity in C06 \| N02; N05" | Task 5 (K-3 gate, class rule B:293); N02, N29; task 8 |
| EffortPolicy 3.18 | B:84 "C02 \| N03" | Task 5 (effort-policy gate); N03 |
| LeakFingerprint 3.23 | B:89 "C02, for C03 (test 6, N06); the library's fingerprints in C04 (task 5)" | C03 test 6 (P:1015) and N06 (C:123) |
| EnvToken 3.27 | B:96 "C02 \| C02 tasks 3 and 7; N04" | Tasks 3 and 7; acceptance "✘ With each environment's real token…"; N04 |

### 1b. Database roles

B:98 says: "`devos_calisma`, `devos_denetim` and `devos_sinav` in C02; `devos_backup` and `devos_ci` in C02, for C03; `devos_ingest` in C04; `devos_kurulum` for the installation only."
- These serve task 4 (P:1001), acceptance "✘ No role can write directly to the tables", and the acceptance line on each environment's real token.
- `devos_ci` is for C03 test 5. P:1213 says a high-impact PR merges only when a required check "finds the audit environment's approving verdict … in the database".
- `devos_backup` is for C03 test 8 and N26 (C:143).
- `devos_kurulum` has no stated stage. P:639 says "Installation operations after C02". KI:41 (row 21) says "Section 12 names no step of Batu's for this token" (N-125, N2:65).

### 1c. Functions

The rule is B:390: "each function is built with its family". I list each group in C02 below.
- **Mission and need** (B:371): `open_mission`, `revise_mission`, `record_need`, `resolve_need`.
- **Work** (B:372): `admit_work`, `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review`.
- **Readiness and claim** (B:373): `ready_works()`, `claim`, `heartbeat`, `release`. B:373 also says "`heartbeat`'s sender and form are decided in C06". Whether `heartbeat` itself is built in C02 is not stated; see 5.11.
- **Relation** (B:374): `relate`, `retract_relation`, `affected_entities`, `explain_paths`.
- **Knowledge, C02 part** (B:376): `record_finding`, `review_finding`. Inference: `search`, `read_source` and `ingest_source` follow Source and Chunk (C04, B:69; P:1029 task 4).
- **Product, C02 part** (B:378): `register_artifact`. `update_assembly` and `snapshot_assembly` follow Assembly (C08, B:73).
- **Review** (B:379): `open_review`, `record_verdict`, `accept`.
- **External effect** (B:380): `prepare_operation`, `record_attempt`, `record_observation`.
- **Decision** (B:381): `open_decision`, `link_prior_decisions`. B:390 makes the exception "`answer_decision` with answer identity in C06".
- **Learning and exam**: `record_eval_run` with EvalRun (inference from B:390 and B:78; B:273 "`EvalRun` … written only with the `devos_sinav` role").
- **User and policy**: `set_effort_policy` (B:384).
- **Backup**: `mark_exported`. B:390 says "`mark_exported` in C02, for C03's test (8)".
- **Deployment**: `deployment_drift(expected)`. B:390 says "`deployment_drift` in C02, with the migration path (plan C02 task 0)". B:387 adds "'no difference' only when the comparison ran in full, otherwise 'could not check'".
- **Outside `devos_api`** (B:46): `devos_private.issue_env_token(role_class)` and `revoke_env_token`. These serve task 3 (P:1000) and P:648 ("The builder writes a database function that generates tokens but cannot run it").

### 1d. Scheduled jobs

- B:410 says the expiry of claims is built in C02 with the claim. "Whether it is applied by the expired-claims job or computed when `claim` and `ready_works()` run is chosen in C02 with the tests (section 8)."
- No other section 5 job is activated in C02 (B:410). The ready-marking job is removed (B:410; PC08:1888).
- The sample reviews are created by the database at write time, not by a job (B:26, B:240). They serve task 5 (P:1002).

### 1e. Comparison function and migration path (6.2)

- P:631 says "The database records the migrations it has applied and the version of each deployed function. A comparison function, built with the migration path in C02's first task, compares that record with `main`".
- P:997 (task 0) adds "the migration job runs it after every apply, and the checks of every later pull request run it".
- These serve the acceptance lines "✔ A migration merged into `main` is applied by the CI job…", "✘ A migration merged into `main` but not applied is detected by the comparison of 6.2" and "✘ The migration credential cannot be read by an agent session…" (P:1007).
- The applied-migrations and function-version record is a database object that no Appendix B family describes (see 5.6).

### 1f. Other database objects C02 builds

- **Schemas** `devos_private` (tables) and `devos_api` (functions only), with direct writes revoked (B:15; P:622). They serve task 4 and acceptance "✘ No role can write directly to the tables".
- **The global `authority_epoch` counter** (B:23). Stated users: Assignment (B:150), Operation (B:244), EnvToken (B:358). `revoke_env_token` "increments the authority epoch" (B:46). It serves F08(c)'s "authority epoch change after the claim" (C:101).
- **The one-active-claim uniqueness constraint** (B:153). It serves Concurrency and N17.
- **The sample share** (B:26): "The share is set in C02 and recorded". The share also applies to routine work items (B:134) and routine decisions (B:293). It serves N01 ("at the set share, the share of sampled needs matches the rate", C:118) and N29.
- **The `format_gate` labelling of rules** (B:26), for task 5.
- **The high-impact path list in a form the database can read** (inference). B:134 enforces "an `Artifact` or `Operation` whose target is on the high-impact path list" under a routine work item; the list itself is at P:711. See 2.7.
- **The rejected-attempt record.** B:366 says "the rejected attempt is recorded" and P:623 says "A rejected transition is recorded with its reason". No family is named (5.5).
- **Removal of the C01 probe schema** ("The first migration also removes C01's probe schema", P:997). But P:965 says P3 was not built, and KI:15 records the probe tokens as "never created" (5.14).

---

## 2. Deferred, but possibly needed earlier

The scope of "C03's start" is P:1013–1015: the audit environment's re-review of C00 to C02, the identity chain in full, and tests (1) to (8). For each part I give the dependency, what goes wrong without it, and the evidence the other way. I do not decide.

**2.1 `register_session` / SessionRecord (C04).**
- Stage: B:90 "SessionRecord (3.24) | C04"; B:390 "`session_brief(role)` and `register_session` in C04".
- Dependency: N2:87 (N-136, task 4) says "a claim needs a registration of the same role class (S8) … a claim without registration is refused". N-136's T-77 part X1 also has each registration record its repositories and hooks.
- Without it: S8's rule cannot be built in C02, and N17's extended case (N2:87) cannot run.
- Other way: N-136 says "The plan text … changes through a plan change (Section 14) before this stage relies on it" (N2:87). S8 is not in Appendix B yet, and C04's first need for SessionRecord is C04's acceptance (B:90).

**2.2 A writer for LeakFingerprint before `devos_ingest` (C04).**
- Stage: B:327 "Only `devos_ingest` writes; `devos_ci` reads"; B:98 "`devos_ingest` in C04"; B:89 "C02, for C03 (test 6, N06); the library's fingerprints in C04".
- Dependency: C03 test 6 (P:1015) and N06 (C:123) need fingerprints of "a fake 'secret' text planted in the library".
- Without it: in C03 the only permitted writer does not exist. Writing test fingerprints another way breaks B:327's rule. `LeakFingerprint.source_ref` (B:327) also has no target until Source exists (C04, B:69).
- Other way: B:89 separates "C02, for C03" from "the library's fingerprints in C04", which implies C03's fingerprints come by another path (inference). N3:93 (N-171) shows the installation guard's store is local, not in the database, so test 6's store may not be the database table.

**2.3 `answer_decision` with answer identity (C06), for opening a Mission.**
- Stage: B:83 and B:390.
- Dependency: B:104 "A mission is opened or widened only by a decision that belongs to Batu"; B:371 "Mission only by Batu's decision"; B:102 `owner_authority` is a "reference to Batu's decision record". B:291 says the answer "is processed only after the decision channel's intake has verified" Batu's account (plan 6.9, C06). Every Work needs `mission_ref` (B:59, B:117). The ledger transfer has answered Batu decisions (task 8).
- Without it: if a Mission needs an answered `batu` decision, no Mission can be opened in C02, so no Work can be admitted for any C02 test or for the transfer (inference).
- Other way: B:83 can be read as "`answer_decision` exists in C02; its answer-identity check comes in C06". N29's Mission case (C:146) checks only the class ("one below `batu` that opens or widens a Mission"), not that the decision is answered. The text does not settle either reading.

**2.4 Credentials for `devos_backup`, `devos_ci` and `devos_kurulum`.** These are role activation, not families.
- `devos_backup`: B:98 puts it in C02 for C03 test 8, but KI:49 (row 29) says "entered at C09, Section 12 item 4" (P:1233). So C03 test 8 and N26 (C:143, stage C03) have no credential step.
- `devos_ci`: KI:42 (row 22) says "Section 12 names no step for it".
- `devos_kurulum`: KI:41 (row 21) says the same. N-125 (N2:65) carries both to this work list.
- Without them: C03 tests 1, 5 and 8 lack a caller of those roles. Inference: the ledger transfer (task 8) also has no stated caller.

**2.5 EvidenceEnvelope as database fields, or a raw-evidence store (C04/C05).**
- Stage: B:80 "As a form in git from C01; as database fields from C04 (benchmark) and C05 (exams)".
- Dependency: N-031 (N2:29) says "Re-observe and store the raw output when the raw-evidence store exists (C02)". P:837 (item 8) puts raw evidence "in the database and in the private file storage". C:24 gives every test an envelope with a "raw evidence ID".
- Without it: EV-C00-001 stays "context only" (N2:29), and C02 test records would have no raw-evidence home other than git.
- Other way: inference: C02's database tests run on synthetic data with no private content, so the git form (B:80) may be enough for them.

**2.6 Source and Chunk (C04), for N09 and F08(b).**
- Dependency: N09 (C:126, stage C02) rejects a finding "with only secondary sources", and B:194 states the same rule. Finding has no primary/secondary field (B:191). Source has `kind` (original / derived, B:187). F08(b) is "a change to a source in the read set" (C:101). Principle 10 says "Every knowledge record carries the class `public` or `private`" (B:24).
- Without it: the database cannot tell secondary from primary sources in C02 (inference).
- Other way: F08(b)'s "source" may be any record in the read set (inference). A field on `Finding.source_spans` could carry primary/secondary without Source.

**2.7 Where the high-impact path list lives: Release `config` (C05) or something else.**
- Dependency: B:134 enforces the list in the database, and N29 (C02) depends on it. Release has `kind` "config" (B:261) but is "not built in C02" (B:265).
- Without it: there is no database copy of the list for the B:134 refusals (inference).
- Other way: a migration can carry the list as data. `supabase/migrations/` is itself on the list (P:711), so changing it is already high-impact. Release need not come earlier.

**2.8 Record homes after the ledger transfer, at C03's start.**
- The ledger moves to the database "at the end of C02" (P:870). Plan text only on this: "after the transfer, `ledger.md` is not an authoritative write surface" (P:870). WO:29 says the disciplines' and G's records "go to the ledger files until DevOS's database exists". WO:39 rebuilds "where it left off" from `ledger.md`, `DURUM.md` and the log.
- In C03 these have no stage-appropriate home:
  - discipline answers: ProtocolAudit is C05 (B:92);
  - frame reviews (WO:65): FrameReview is C10, usable from C07 (B:94);
  - usage readings: Budget and Usage is C04 (B:87);
  - helper task texts: TaskDefinition is C04 (B:66);
  - the session's hand-over: SessionRecord and `session_brief` are C04 (B:90, B:390);
  - Batu's constraints: Constraint is C05 (B:82).
- Inference: either these stay in git after the transfer, or they need a home in C02 or C03. P:1005 says "no new family".

**2.9 `heartbeat` (form decided in C06), for leases from C03.**
- Stage: B:154 says "If the time runs out, the claim becomes `expired`", and the extender's sender and form are decided in C06.
- Dependency: from C03 the audit environment works in its own sessions (P:1013). B:22 says "Every effect concerning a work item requires the claim token".
- Without it: a fixed lease must outlast the longest piece of work, or claims expire mid-work (inference).
- Other way: whether an audit review is an "effect concerning a work item" that needs a claim is not stated.

**2.10 Assembly snapshot (C08) and the reviewed-content fingerprint, for C03 test 5.**
- Dependency: B:221 "Every review carries the ID of the snapshot it reviewed". Snapshots are Assembly's (C08, B:73), while `Review.target_ref` allows "(+revision or snapshot)" (B:225). N3:43 (T-81) binds the audit verdict "to a fingerprint of the reviewed content on the high-impact paths", read from the database by the required check. No Review field holds such a fingerprint (B:225).
- Without it: C03 test 5's verdict binding has no field.
- Other way: N3:43 says "C03's start writes all places", so C03 can add the field by migration.

**2.11 The outside check of due job occurrences (T-77).**
- N2:55 says "the expired-claims job in C02, if C02 applies expiry through it", and its deadline is "before any section 5 job is activated". So the B:410 choice of job versus computed expiry decides whether T-77's first part is a C02 build.

**2.12 Effect-channel inventory records (no family at any stage).**
- N2:37 (N-032) gives the "structural part (a format gate on effect-channel inventory records): C02/C03". Appendix B has no such family; plan 6.7 keeps the inventory as text.
- Without it: N-032's structural negative ("an access statement without an enforcement layer and verification status is rejected", N2:35) has no table to gate.

**2.13 Search over DevOS's own knowledge (C04).**
- B:430: Finding and Decision are reachable by search; "a family is covered from the stage that activates it". Both families are C02, while the search view is "chosen in C04".
- Inference: coverage can start only at C04. No C02 or C03 test needs it. `link_prior_decisions` "queried" (B:292) has no search in C02 and must use relations.

**Checked, no C02 or C03-start need found.** I checked these against C:30–168 and P:1013–1017:
- Grant: F01 and F08 name it only "once Grant is activated" (C:35, C:100).
- Request and Contribution: K03 is C06 (C:158).
- ContextPackage: F02 is C04 (C:44, C:50).
- Inquiry: it is a `Need` in state `investigating` (B:61).
- UseReceipt: C06 (B:67).
- Competence: N08 at C03 reads only exam records, and Competence's first need is C05 (B:79).
- UserModel (C06), DeadEnd (C10), Learning (C07), Recovery (C09; F03 is C09), LaunchRecord (C06; N24 is C06), Premise (deferred; `Decision.premises` stands in, B:93) and MechanismAssumption (C05).
- The deadlock scan, limit tracking, constraint scan and the C10 jobs (B:410).

---

## 3. Appendix B section 8: details to be chosen with evidence in C02

B:438 says "the choice is made in C02, with the tests in Appendix C and with its reasons."

| Topic | Initial proposal | Evidence it asks for |
|---|---|---|
| Concurrency control (B:442) | Row lock and uniqueness constraint on claiming; stricter isolation on critical transitions | "Concurrency tests and failure frequency" (the Concurrency test, C:106–110) |
| Revision storage form (B:443) | Current table plus an appended history table | "Query simplicity and size" |
| Vector index (B:444) | An approximate nearest-neighbour index for the chosen model's dimension | "C04 search benchmark and size" (cannot be met in C02; see 5.2) |
| Chunk size (B:445) | One or two paragraphs, respecting headings | "C04 search benchmark" (same) |
| How the environment token reaches the database (B:446) | A separate header through the environment's API credential feature; functions compare its hash with `env_tokens` | "C01 #3 observation; C02 negative tests". Fallback: "an Edge Function gate". C01 #3 was taken from documentation, not observed: P:968 (PC-21 item 4); N-131 (N2:82); N-209 (N2:126) |

**Choices assigned to C02 elsewhere, but missing from the section 8 table:**
- **Claim expiry, job or computed.** B:410 says "chosen in C02 with the tests (section 8)". The evidence named is "the tests".
- **The sample share.** B:26 says "set in C02 and recorded". No evidence basis is named. B:134 and B:293 use the same "set share".
- **R17 and R23.** N-064 (N2:41) calls them "two data-model choices under Appendix B section 8 (one-to-one families as fields of Work; SessionRecord as an event type)". The evidence is in EV-C00-012 sections 3 to 5.
- **T-36.** Bind a Decision answer to the revision answered. N2:53 says "nothing binds an answer to the revision answered … C02 confirms and builds it".
- **T-37.** Whether Finding needs a field flagging agent-addressed text (N2:54).
- **N-128's three questions.** EvalRun "has no grader identity or version"; whether `Review.basis_refs` is typed by kind; whether `Verdict.result` needs `not_applicable` (N2:74–75).
- **The migration credential's form.** P:997 says "[Awaiting verification: read from the current GitHub and Supabase documentation, with its date, and probed here]".
- **The token's form**, network secret or variable (N-131, N2:81; P:652).
- **PC-08's design details the executor did not decide** (PC08:2358). These are where `mandatory_needs` lives, the structural impact-class cases, what a "failed attempt" is, the seal's database form, and others.

---

## 4. The ledger transfer

**Stated mapping** (P:1005): "work items into Work, decisions into Decision, log entries into Event, checker verdicts into Review and Verdict, findings into Finding, notes into Event or Finding by kind; no new family".

**Acceptance** (P:870 and N18, C:135):
- no duplication on rerun;
- it resumes after an interruption;
- links and versions match;
- an explicit hand-over mark in `ledger.md`, with later writes rejected by the checks.

Counts below are at `796c427`, from the front matter, markers and files.

| Record kind (home, count) | Stated target | Appendix B family (stage) | Fit issues (stated, or inference) |
|---|---|---|---|
| Work items `plan/work/W-*.md` (71 `kind: item`) | Work | Work and WorkStanding 3.3 (C02, B:62) | `execution` and `acceptance` values (WO:101) fit B:123 and B:125. `admission` has no field (only `admit_work`, B:372). `depends_on` maps to Relation `depends_on` (B:140), but often names a stage. `accepted_by` has no named target. Each item needs `mission_ref` (B:117), a non-empty `expert_assessment_ref` (B:299, "cannot be empty for any work item") and a rule-derived `impact_class` (B:134). Inference: the transfer needs a Mission and an EffortPolicy, or a standing policy written with `devos_denetim` |
| Stages C00 to C12 (13 `kind: stage`) and root `INSTALL` (1 `kind: root`) | **none stated** | Inference: Work with `part_of` (B:140), or Mission (B:102) | — |
| Decision records `D-*` (23 files) | Decision | Decision 3.17 (C02) | `class: batu \| technical` (WO:103) does not match `routine / high_impact / batu` (B:287), which follows rules (B:293). Status `declined` (`plan/decisions/D-013.md:8`) is not among B:287's statuses. **None of the 64 decision records has a `reversibility` or `criteria` field.** B:290 requires both before a `high_impact` or `batu` decision can be `open`. Answers are "processed only after the decision channel's intake has verified" (B:291, C06) |
| Plan changes `PC-*` (36 `kind: plan-change`) | Decision, by WO:103 ("A plan change is `PC-<nn>`" under "Decision record") | Decision (C02) | As for D records. Their old and new text stays in git |
| Frame reviews `FR-02` to `FR-06` (5) | **none stated** | FrameReview 3.26 is C10 (record from C07, B:94), so not built. Decision fits FR-05's front matter (class, status `accepted`, premises, alternatives, `reopen_if`) | Inference: either Decision, or a reason why FrameReview comes earlier |
| Log entries `plan/ledger/C0x-log.md` (149 + 112 + 1 `### L-` headings) | Event | Event 3.13 (C02) | `role_class` is "from the caller's token, never declared" (B:255), so the transfer caller's role, not the original actor. `created_at` would be the transfer time, not the entry's date. One event per entry or per "Record changes" item (WO:96) is not defined. The Disciplines line (WO:93) has no family until ProtocolAudit (C05, B:92) |
| Checker verdicts `evidence/*/checks/CHK-*` (187: 43 PASS, 135 PASS-WITH-CONDITIONS, 9 FAIL) | Review and Verdict | Review, Verdict, Acceptance 3.11 (C02) | PASS-WITH-CONDITIONS maps to `conditional` (B:227), by inference. Conditions and whether they were met have no field. Independence fits `fresh_context_subagent` (B:225). `reviewer_role_class` is "from the token" (B:225). **B:237: "Binding verdicts and acceptance are written only with the `devos_denetim` role"**, but the installation's verdicts and C02's own stage-close verdict come from the builder (P:872). Item acceptances (`accepted_by`) map to Acceptance (B:229), which task 8 does not name |
| Findings | Finding | Finding 3.8 (C02) | "Findings" in `plan/` are not one kind: FND-… (LG:11), the "## Findings" section of verdicts (WO:123), and the register in EV-C00-013. Finding requires `counter_evidence_searched` (B:191), `source_spans` and three status fields (B:183), which checker findings do not carry as fields (inference) |
| Notes `N-*` on stage files (194: 122 open, 53 closed, 19 answered) | "Event or Finding by kind" | Event and Finding (C02) | Note markers carry `status` and `origin`, with **no `kind`** (e.g. N2:24). Their statuses (open, closed, answered), owners and deadlines have no counterpart in Event or Finding (B:191, B:255). WO:51 treats an open note as an obligation ("each becomes an item, joins one, or stays a note with its deadline"); inference: that is closer to Work or Need |
| Evidence files `evidence/*/EV-*` (55), with `raw/`, `routine/`, `baseline/` and the like | **none stated** | Candidates: Artifact (`path`, `commit`, `kind`, B:217; C02), or EvidenceEnvelope (database fields from C04/C05, B:80) | — |
| Gaps `G-…`, open items `OI-…`, tests `T-…` (LG:11) | **none stated** | — | OI items were moved into notes (N2:25). T-… rows live inside evidence files |
| Batu's constraints, kept verbatim (LG:7; `plan/decisions/D-029.md:70`; D-017's "standing environment constraint", `plan/ledger/C01-log.md:112`) | **none stated** | Constraint 3.16 is C05 (B:82), so not built | Inference: they stay inside their Decision records |
| Usage readings (LG:23), Batu's-steps sections (N-201, N2:103), key inventory rows (KI) | **none stated** | Budget and Usage is C04 (B:87). EnvToken (B:358) holds only tokens from `issue_env_token`, not the other keys | — |
| Subagent task texts (`briefs/`) | **none stated** | TaskDefinition is C04 (B:66) | — |
| `DURUM.md` and the ledger's generated blocks | — | Generated views (LG:3), not records (inference) | — |

**The four acceptance conditions against Appendix B.**
- **"No duplication."** B:16 and B:144 say an exact repeat makes no new event or relation, but no family gives transferred records an idempotency key; only Operation has one (B:244).
- **"Resumes."** No family holds transfer progress. Inference: Operation and Observation could.
- **"Links and versions match."** Revisions are integers (B:17), while the ledger's versions are git commits (`Artifact.commit`, B:217). The mapping is not defined.
- **The hand-over mark.** It is a check in git (PR checks or guard), not a database object.
- **Scope of the mark.** P:870 marks only `ledger.md`. LG:3 says all homes ("these files": work, decisions, log, evidence) are authoritative until the transfer.

---

## 5. Contradictions or gaps

1. **LeakFingerprint's writer.** B:327 "Only `devos_ingest` writes" conflicts with B:98 (`devos_ingest` in C04) and B:89 (built "C02, for C03 (test 6, N06)"). `source_ref` (B:327) points at Source (C04, B:69).
2. **Section 8 against itself.** B:438 says each choice is made in C02, but vector index and chunk size rest on "C04 search benchmark" (B:444–445), and Source and Chunk are C04 (B:69).
3. **Expiry choice not in section 8.** B:410 sends the job-versus-computed expiry choice to "section 8", whose table has no such row (B:442–446). P:626 already lists "detection of expired claims" among the scheduled jobs as if settled.
4. **"C01 #3 observation" (B:446).** Row 3 was established from documentation (P:968; N2:82), and N-209 (N2:126) lists this line for correction.
5. **Rejected attempts have no record family.** B:366 and P:623 require recording them. Principle 2 (B:16) rolls back state and event together, so an Event written in the failing transaction would be rolled back too (inference).
6. **Migration record and migration role are undefined in Appendix B.** The applied-migrations and function-version record (P:631; B:387) has no family in section 3. The migration credential's role (P:997, "for example a database role that can only apply migrations") is not in section 2's table (B:33–41).
7. **Roles without a defined credential or authentication form.** B:45 says "environments carry … an environment token" and every function "first verifies the token". For the job roles (`devos_ci`, `devos_backup`, `devos_ingest`) the plan speaks of a "key" or "connection details" (KI:42, KI:49), and whether they use `issue_env_token` tokens or database logins is not defined. `devos_backup`'s credential arrives at C09 (P:1233) while its role serves C03 test 8 (B:98).
8. **`devos_kurulum`'s limits.** B:35 lists only "Issuing tokens" under "Cannot". N-136 (N2:87) requires a "Cannot" row covering exam records and the audit's binding rights. With B:237, a `devos_kurulum` transfer cannot write binding Verdicts or Acceptances (see section 4).
9. **Mission's rule tested in C02.** B:59 says Mission's "own rule is first tested in C10", while N29 (C:146, stage C02) rejects a decision "below `batu` that opens or widens a Mission". Inference: N29 tests Decision's class rule (B:293), which overlaps Mission's rule (B:104). The Mission-opening path in C02 also depends on 2.3.
10. **Fields the rules or tests need but the field lists lack** (stated rule; the gap is my reading):
    - Work has no field for "the fact that the task is an exam" (B:273; N08); B:117 does not list one.
    - Finding has no `privacy_class`, though principle 10 (B:24) gives one to every knowledge record.
    - Finding has no primary/secondary-source marker for N09 (B:194).
    - Decision has no "major design" marker for N02's "a major design decision without premises is rejected" (C:119; B:354). B:290 already requires `premises` for `high_impact` and `batu` decisions.
    - Operation has no retention period for F01(d) (C:36; B:244).
    - Decision has no field binding an answer to the revision answered (T-36, N2:53).
11. **No function revokes a single claim.** Assignment's status includes `revoked` (B:150), F08(c) (C:101) and the squeeze signal (B:352) use revocation, and section 4 lists only `release` (B:373). `heartbeat` is in a C02 group while its "sender and form are decided in C06" (B:373); whether it is built in C02 is not stated.
12. **Finding's format gate and task 5.** Task 5 lists "Format gates (K-1, K-3, effort policy)" (P:1002). Finding's mandatory `counter_evidence_searched` (B:191) is a format gate by principle 12's definition (B:26), and C02's acceptance covers "The format gates" in general (P:1007). Whether Finding's gate is in C02's scope is not stated.
13. **`role_class` of system-originated events.** Event's `role_class` must come "from the caller's token, never declared" (B:255; F06, C:84). For events the database makes itself (sample reviews, B:240; an expiry job, B:410) and for the transfer's events, no token is defined (inference).
14. **Plan side, outside Appendix B.** Task 0 ("The first migration also removes C01's probe schema", P:997) and the acceptance line "✔ The C01 probe schema and its tokens no longer exist" (P:1007) were written for P3. P:965 (PC-21 item 1) says P3 was not built, and KI:15 records the tokens as "never created". The condition is then shown by observing absence, not removal (inference).
15. **The own-knowledge coverage rule is ambiguous.** B:430 says "a family is covered from the stage that activates it", but search exists only from C04 (B:69; P:1029), while Finding and Decision are C02.

---

## Open

- **Not read:**
  - PC-08 places 1–26, 34–46, 48–75, 79–96 and 104–118. I read the principle, places 27–33, 47, 76–78, 97–103, the restated tests and the open points.
  - EV-C00-015 (the scope table behind B:55).
  - EV-C01-004 (S5, S8, S9, which N-136 cites).
  - EV-C00-012 rows R17 and R23.
  - Appendices A and G, and plan 6.5–6.9 beyond the lines cited.
  - No database, GitHub or web source was consulted, so I did not check whether a probe schema exists in `devos-test`.
- **Not settled by the texts:**
  - whether `answer_decision` exists in C02 without its identity check (2.3);
  - whether audit reviews in C03 need claims (2.9);
  - which role writes the transferred verdicts (section 4, item 8 of section 5);
  - how C03 test 6's fingerprints are written (2.2).
- **Counts** are of front matter, markers and files at `796c427`. That none of the 64 decision records has `reversibility` or `criteria` is a front-matter count; the bodies may state reversibility in prose. I did not check.
- **Inferences** are marked as such. None of them is a decision. Whether each deferred part comes earlier is the work list's answer, with its reason (W-C02-01 acceptance item 2).

**Guard denials:** none.
