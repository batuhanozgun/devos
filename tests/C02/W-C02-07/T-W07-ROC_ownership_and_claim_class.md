# T-W07-ROC · A class the gate admits changes only the work items Rule O gives it, and not while another class holds the claim

Synthetic test data (plan Section 8 item 13): the Mission (on a `batu` decision answered at owner level), the work items, relations, the exam run, the claims and the artifact are made up for the test, labelled `SYNTHETIC W-C02-07` or `w07_fixture`, and rolled back. Tokens are issued at run time inside the rolled-back transaction and never written down (README section 6).

**Serves.** W-C02-09 point 8 (the authorization test: "each function refuses a token of every role class not on its list", with the checks after the gate that EV-C02-008 1.7.1 adds to the rows it decides) and W-C02-10 point 5 ("in every direction, an operation that only one class may do, made with another's token, is refused"). C02 Acceptance: "✘ With each environment's real token, an operation that requires another environment's authority is rejected." (here with `devos-test`'s synthetic tokens). Design: EV-C02-008 section 1.7.1, Rules O and C, merged and accepted (PR #300; CHK-C02-025); its "Tests this asks for" paragraph; B:35, B:36, B:38, B:134 to B:136, B:138, B:268, B:284 to B:286; EV-C02-002 DM-29 (`revoke_claim`, `devos_denetim` only), DM-24 (the exam link in EvalRun). Not EV-C02-003 §4.1's role gate, which is `T-W07-5B`'s (EV-C02-008 1.7.1: "These are not T-W07-5B's role-gate cases").
**Command.** `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_roc_ownership_and_claim_class.sql`, run as `postgres` by the migration job's `devos-test` step after the merge's migrations (README 5.1 (a)), and by the break harness on its throwaway database with the patches below. Statement timeout 120 s.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit. It makes about 90 calls inside one transaction (seconds).
**Interface assumed.** README section 8.1 (the assumed interface, version 1) holds; where anything here differs from it, section 8.1 holds. Beyond it:
- `revise_work(p jsonb)` with `id`, `base_revision`, `scope`, `purpose` and `reason` (as `T-W07-F06`'s recipe); `mark_stale`, `cancel_work`, `reopen_for_review(work_id uuid, reason text)`; `retract_relation(relation_id uuid, reason text)`; `relate(p jsonb)` with B 3.4's fields (`type` `depends_on` and `hard` true for a hard relation, `about` and `hard` false for a descriptive one).
- Group C's fixtures (`T-W07-N03`'s helpers, copied): a Mission opened with the `devos_kurulum` token on a `batu` decision answered at owner level, and work items through `admit_work(p jsonb)` under it. Until C06 every Mission is opened with the `devos_kurulum` token (CHK-C02-025 F5), so the Mission the test opens is an ordinary one, not the installation's.
- **The exam link** is an `eval_run` row naming the task in `work_ref` (DM-24), planted at owner level, since `record_eval_run`'s payload is not fixed. The task itself is opened with the `devos_sinav` token (B:38, "as ordinary work"); if the build refuses that before any exam link exists, it is opened with the `devos_calisma` token and the leak cases' detail says so.
- **Two hooks the build's record names** (README section 8), `pg_temp.roc_hook`: `installation_mission`, an owner-level statement returning a Mission the build treats as the installation's (the Mission `transfer_mission` writes, with its `transferred` creation event; B:138, B:268; CHK-C02-025 F5: "W-C02-09's record should name this marker"); and `transferred_relation`, an owner-level statement that plants a relation whose creation event is `transferred`. Both are empty until W-C02-09's record names their form; the cases that need them give `could_not_check` with that reason, never a pass. The test designer fills them before the first result.
- A refusal is returned (interface v1); a raised error makes the case `could_not_check`. A token refusal makes it `could_not_check` too, since it means the test's own token failed.
- `devos_private.work.execution` and `.acceptance` (B 3.3's axes); `reopen_for_review`'s items are planted `finished` and `accepted` first, as `T-W07-F06`'s recipe plants them, inside the undone subtransaction.

## Cases

Each case's call runs in a subtransaction that is undone after its answer and a snapshot of every `devos_private` table (but `env_tokens`, `event` and `rejected_attempt`) are taken, so every case starts from the same fixtures. ✔ is accepted (`status` `ok`); ✘ is refused, returned, with every table unchanged.

**Rule O** (`ROC-o-<function>-<class>-<kind>`). Functions: `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review`, `relate` (a hard `depends_on` from the item) and `retract_relation` (the hard relation from the item, made at fixture time with a class Rule O admits on it). Kinds: `cal` (an item opened with `devos_calisma` under the ordinary Mission), `inst` (an item under the installation's Mission, through the hook), `exam` (the exam task).

| Class | `cal` | `inst` | `exam` |
|---|---|---|---|
| `devos_calisma` (`cal`) | ✔ | ✘ | ✔ |
| `devos_sinav` (`sin`) | ✘ | ✘ | ✔ |
| `devos_kurulum` (`kur`) | ✘ | ✔ | ✘ |
| `devos_denetim` (`den`), `reopen_for_review` only (the one of these functions whose gate admits it, R24) | ✔ | ✔ | ✔ |

- `ROC-leak-<function>`: `devos_calisma`'s answer on the exam task equals its answer on the ordinary item, status and reason code, for each function (the exam fact not leaked by Rules O and C; EV-C02-008 1.7.1, limited by CHK-C02-025 C1 to these rules' answers).
- `ROC-o-retract_relation-<class>-transferred`: a relation whose creation event is `transferred`, from an ordinary item: `kur` ✔, `cal` ✘, `sin` ✘ (1.7.1's last bullet). Through the hook.

**Rule C** (an ordinary item `wc`, a hard relation from it made before the claim, then a `devos_denetim` claim on it):
- `ROC-c-revise_work`, `ROC-c-cancel_work`, `ROC-c-relate` (hard), `ROC-c-retract_relation` (the hard relation from `wc`): with the `devos_calisma` token → ✘.
- `ROC-c-mark_stale-pos`: `mark_stale` with the `devos_calisma` token → ✔ (Rule C is not checked there: B:134).
- `ROC-c-relate-soft-pos`: a descriptive relation (`about`, not hard) from `wc` → ✔ (Rule C covers hard relations only).

**Rule C within one class** (an ordinary item `ws`, claimed with the `devos_calisma` token by the declared session `w07_fixture_session`, which registers a candidate artifact under its claim):
- `ROC-c-same-class-cancel`: `cancel_work` on `ws` with the `devos_calisma` token, no claim token (another working session) → ✔, and `ws`'s `execution` is `cancelled` (B:136; principle 8).
- `ROC-c-late`: the claimant's artifact is still there after the cancellation, unchanged, with status `candidate` (B:136: "The late result of a cancelled claim is kept as candidate evidence").

**Coverage.** `ROC-pre` (an object absent, or the fixtures could not be made); a case whose kind's fixture is absent gives `could_not_check` with the reason.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | `T-W07-ROC`. **[Designer's addition: no Appendix C entry. EV-C02-008 1.7.1 asks for these cases ("Tests this asks for"), outside the role gate; W-C02-09 point 8 and W-C02-10 point 5 take them.]** A class the role gate admits to a Work or Relation write changes a work item only where Rule O gives it the item, answers a working session the same on an exam task as on an ordinary item, and is refused a revision, cancellation or hard relation while another class's claim is on the item. |
| **Failure class rule** | **[Designer's addition.]** Any change of a work item by an environment that does not own it, under Rule O's reading of what the families record (the installation's Mission, the exam link), and any change that ends another environment's claim's effects without `revoke_claim` (DM-29). Also any answer of these rules that tells a working session an item is an exam task. |
| **Examples** | **[Designer's addition.]** The finding the rules answer (EV-C02-008 section 4 item 1): a working session cancelling or revising a work item another environment holds (`ROC-c-cancel_work`, `ROC-c-revise_work`). Other manifestations: the installation's items changed by the working environment (`ROC-o-*-cal-inst`); an exam environment changing working items (`ROC-o-*-sin-cal`); the installation changing working items (`ROC-o-*-kur-cal`); a rule that refuses a working session on exam tasks and so tells it which they are (`ROC-leak-*`); a transferred relation retracted outside the installation (`ROC-o-retract_relation-cal-transferred`). |
| **Negative control** | Every ✘ case: refused, returned, with every `devos_private` table but `env_tokens`, `event` and `rejected_attempt` unchanged. |
| **Positive control** | Every ✔ case. Each ✘ case differs from a ✔ case in one thing: the class (`ROC-o-revise_work-sin-cal` from `-cal-cal`), the kind (`ROC-o-revise_work-cal-inst` from `-cal-cal`), the claim's class (`ROC-c-cancel_work` from `ROC-c-same-class-cancel`), or the relation's hardness (`ROC-c-relate` from `ROC-c-relate-soft-pos`). `ROC-c-mark_stale-pos` shows Rule C is not a refusal of every change while claimed. |
| **Break attempt** | **[Designer's addition.]** (1) **B-ROC-1** (`breaks/B-ROC-1_rule_o_reads_exam_link.sql`). Changed: Rule O's reading for `devos_calisma`. `cancel_work` is wrapped so that it reads the exam link and refuses `devos_calisma` on an item an exam run names. Red: `ROC-o-cancel_work-cal-exam` and `ROC-leak-cancel_work` (EV-C02-008 1.7.1: "Rule O reading the exam link for `cal` (the leak case turns red)"). (2) **B-ROC-2** (`breaks/B-ROC-2_rule_c_removed.sql`). Removed: Rule C. `revise_work`, `cancel_work`, `relate` and `retract_relation` are wrapped so that every claim on the item shows the caller's class during the call. Red: `ROC-c-revise_work`, `ROC-c-cancel_work`, `ROC-c-relate`, `ROC-c-retract_relation` (1.7.1: "Rule C removed (the `den`-claim cases turn red)"). Each is run by the harness (README 5.2). Rule O's other cells: W-C02-13's prober may copy B-ROC-1 with the function, class and kind changed; the red case is that cell's case ID. |
| **Stage and environment** | C02. `devos-test` (the migration job's step, synthetic tokens, `sql-set-role`) and the throwaway database for the breaks. No Claude environment's real token. |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase C4a); its agent ID and type are in W-C02-07's "Record" (point 1). Run by the migration job, by W-C02-09's producer at its head, and by W-C02-13's prober with the breaks. Judged by a fresh-context checker that wrote none of the tests. Shared: model lineage and the design records (EV-C02-008; plan Section 8 item 7). The checker should read 1.7.1 itself, not this table. |
| **Evidence layer** | Structural: the database's answers and its tables. It does not show who opened a real exam task (C05's form, N-138), what the audit environment's review work items are (C03, EV-C02-008 1.7.5 (a)), or that DM-35's reads do not tell the exam fact (N-262; phase C4b). The header is simulated. |
| **Evidence envelope** | README section 4. Fixed before the run: the table above, case by case (57 Rule O cases, 6 leak cases, 3 transferred-relation cases, 8 Rule C cases), and each break's red cases. Observation: the job's run (URL, run ID, step) with the file's result rows and its final notice or exception; raw evidence ID: the job's unedited output under `evidence/C02/raw/`, after the hygiene checks. Transport `sql-set-role` (job) or `throwaway` (harness). |

## Clause table

Not an Appendix C test. EV-C02-008 1.7.1's "Tests this asks for", clause by clause:

| Clause (verbatim) | Case ID(s) |
|---|---|
| "Rule O: each function with each class's token on a work item of each kind (opened with `cal`, under the installation's Mission, an exam task opened with `sin`), ✔ or ✘ as above" | `ROC-o-<function>-<class>-<kind>`, 57 cases; the transferred relation: `ROC-o-retract_relation-*-transferred` |
| "for `cal`, the answers that Rules O and C give on an exam task equal those on a `cal`-opened item (the exam fact not leaked by these rules; section 4 item 11 for the reads)" | `ROC-leak-<function>`, six cases. Section 4 item 11 (N-262, DM-35's reads): phase C4b, `T-W07-F04` |
| "Rule C: with a `den` claim on a `cal`-opened item, `cal`'s `revise_work`, `cancel_work` and hard `relate` refused and `mark_stale` accepted" | `ROC-c-revise_work`, `ROC-c-cancel_work`, `ROC-c-relate`, `ROC-c-mark_stale-pos`; and `ROC-c-retract_relation` for 1.7.1's "in `relate` and `retract_relation` for a hard relation" |
| "with another working session's claim, `cal`'s `cancel_work` accepted and the late result kept as a candidate (B:136)" | `ROC-c-same-class-cancel`, `ROC-c-late` |
| "Breaks: Rule O reading the exam link for `cal` (the leak case turns red); Rule C removed (the `den`-claim cases turn red)" | B-ROC-1, B-ROC-2 |

## Format gate

Not a format-gate test.

## Could not check

`ROC-pre` before the build exists, or when a fixture cannot be made. The `inst` kind's cases and `ROC-o-retract_relation-*-transferred` until W-C02-09's record names the installation's Mission's marker and the transferred relation's form, and the hooks are filled (before the first result). The Rule C cases with a `devos_denetim` claim when the build does not let `devos_denetim` claim a working item (its claim row's "its review work" is C03's design; EV-C02-008 1.7.5 (a)): the record then says Rule C's cross-class cases rest on no run in C02. Never PASS while any of these remains.

## Self-check (not a result; README 10)

2026-10-12, PostgreSQL 16.15, on a scratch stub of README 8.1 and EV-C02-008 sections 1.2, 1.7 and 2.2 (outside the repository, not delivered; the test designer's reading of the design, not the build: a pass on it is no evidence about the build). With the two hooks filled with the stub's forms in a scratch copy: PASS (74/74); B-ROC-1 turned exactly `ROC-o-cancel_work-cal-exam` and `ROC-leak-cancel_work` red, B-ROC-2 exactly `ROC-c-cancel_work`, `-relate`, `-retract_relation` and `-revise_work`; the restore passed; the break harness, run on that copy with the stub as its migrations, showed both (`counts: no`). The delivered file on the same stub: COULD NOT CHECK (22 of 74, the hooks' cases). On an empty database: COULD NOT CHECK. One fault of the stub, not of the test, was found: wrapping by rename fails on a function whose body names its parameters by the function's own name (`cancel_work.work_id`); a build written so makes every rename-and-wrap patch fail to apply, which the harness reports as not shown, never as shown.

## Not covered

- The role gate of these functions (`T-W07-5B`'s rows R21, R23 and R24).
- `set_effort_policy`'s kind (a) under Rule O: `T-W07-N03` (`N03-neg-rule-o-kurulum`, `N03-neg-rule-o-sinav`, CHK-C02-025 C2 (c)).
- Rule O on relations whose `from_ref` is not a work item, beyond the transferred relation: EV-C02-008 leaves the qualifiers for them as unspecified as EV-C02-003 §4.1's row 2 (CHK-C02-025 F6); W-C02-09's record states what it checks.
- Whether a Rule C refusal names the claimant's class (CHK-C02-025 F7 recommends it does not): not decided by the design, so not tested.
- The exam fact through DM-35's reads (`affected_entities`, `explain_paths`): N-262, phase C4b.
- Real tokens (`T-W07-RT`); `devos`.
