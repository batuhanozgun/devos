# T-W07-N04 · No environment but the audit environment can give a binding verdict or acceptance, whatever it declares

Synthetic test data (plan Section 8 item 13): three synthetic tokens (working, audit, installation) are issued at run time in the rolled-back transaction. A review row and a work row are planted as owner, with text `w07_fixture SYNTHETIC W-C02-07`. The fake role names (`devos_denetim`) and the fake session ID (`w07_fixture_fake_session SYNTHETIC W-C02-07`) are made up.

**Serves.** W-C02-10 point 5, first bullet: "✘ N04's C02 part, all its negatives … and the same with the `devos_kurulum` token (N-136; EV-C01-004 S8 line 1), except a right W-C02-05's record keeps for it before C03, until that right's stated end. ✔ N04's positive: the audit environment's record is accepted." Also W-C02-07 point 2's N04 line, and C02 Acceptance "✘ An operation with another session's claim, and with a fake session ID, is rejected" for verdicts (R2 section 5 (b): "N04 covers it only for verdicts").

Design and plan text relied on:
- Appendix C N04 (C:121) as PC-43 place 9 writes it;
- Appendix B 3.11 (B:237) and section 4's Review row (PC-43 place 13);
- EV-C02-003 §4.2 (S8 line 1, the transfer's copies) and §4.5;
- B principle 8 (declared names carry no authority);
- the executor's decision 5 for part T.

**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-10 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. (statement timeout 120 s, README 5.1 (a)) `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_n04_self_approval.sql`, in `devos-test` by the job's test step as `postgres`, and on the throwaway database by the harness.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. As `T-W07-IDC`. Beyond it:
- `devos_api.record_verdict` and `devos_api.accept` exist (B section 4);
- the review fixture's table is `devos_private.review` and the work fixture's is `devos_private.work` (`w07_cfg`);
- the full positives fill an argument whose name matches `review` with the planted review's key, and one whose name matches `target` or `work` with the planted work's key. Every other required argument gets a neutral value by type.

If the audit environment's call on those arguments is not accepted, `N04-p3` and `N04-p4` give COULD NOT CHECK, never PASS. The arguments are then revised before the first result (README section 8).

## Cases

- **(C02) the working token.**
  - `N04-a1`: `record_verdict` with the working token, neutral arguments: refused as a role refusal under `devos_calisma`, nothing changed.
  - `N04-b1`: `accept`, the same.
  - `N04-a2` and `N04-b2`: the same two calls on the planted review and target, the arguments of the positives.
- **A fake role name with the same token, at each place a caller controls.** Each is refused under `devos_calisma`, never under the name declared.
  - `N04-c1`: the headers `x-devos-role`, `x-devos-role-class` and `role` set to `devos_denetim`.
  - `N04-c2`: the settings `request.jwt.claims` and `request.jwt.claim.role` naming `devos_denetim`.
  - `N04-c3-<function>`: an argument whose name holds `role`, set to `devos_denetim`, if the function has one.
  - `N04-c4`: acting as a database role named `devos_denetim`, if the build creates one.
- **A fake session ID with the same token.**
  - `N04-e1-<function>`: an argument whose name holds `session`, set to a fake ID, with a fake `x-devos-session-id` header, if the function has such an argument.
  - `N04-e2`: `accept` with fake session and role headers.
- **(C02) the installation token outside the ledger transfer's path.**
  - `N04-k1` and `N04-k1b`: `record_verdict`, neutral and on the planted review.
  - `N04-k2`: `accept`.
  - `N04-k6`: `record_verdict` with fake role and session headers.
  - `N04-k-<function>`: every approval or binding act a rule counts as the audit environment's that exists in `devos_api` as a whole function, each refused under `devos_kurulum` by its role list. These are `open_review`, `activate_release`, `begin_recovery`, `advance_recovery_stage`, and any function whose name starts with `approve` or holds `approval`.
  - `set_effort_policy` is no longer among them (phase C4a; EV-C02-008 1.7.4): its gate admits `devos_kurulum` for kind (a), an item's own policy, and the approval it carries, a reduction or a standing policy, is refused to `devos_kurulum` after the gate. Those refusals are `T-W07-N03`'s `N03-neg-own-approval-kurulum` and `N03-neg-standing-kurulum` (B:35, "effort-reduction approval"), and this clause maps to them.
- **Positive.**
  - `N04-p1` and `N04-p2`: the audit token passes both functions' role gate.
  - `N04-p3`: on the planted review, the audit environment's `record_verdict` is accepted, with an event under `devos_denetim`.
  - `N04-p4`: on the planted target, its `accept` is accepted, with an event under `devos_denetim`.
  - Each differs from `N04-a2`, `N04-b2` and `N04-k1b` in the token only.
- **Part T** (phase C5, CHK-C02-030 C5; Ek_C:121's C02 clause "the ledger transfer's copy of an installation checker verdict is written under role class `devos_kurulum` and counts nowhere a rule needs the audit environment's"). W-C02-06's design has been accepted since CHK-C02-024 (PC-44), so part T is now cases inside this file's result, replacing the fixed notice it printed before. They are counted by **W-C02-10 point 7** ("N04 (its C02 part)"), not W-C02-14 (whose point 13 takes N18 and the transfer's own checks). The design: the copy is written through `transfer_review` with `devos_kurulum` (EV-C02-005 2.4; B:397), and "the copies keep `devos_kurulum` and count nowhere a rule needs `devos_denetim`" (EV-C02-005 section 12). The payload keys are **chosen** by README 8.1's rule (EV-C02-005 section 12 names the functions only): B 3.11's Review fields with `use` `installation_acceptance`; a `verdict` object with B 3.11's Verdict fields; `run_id` and `transfer_source` (EV-C02-005 section 15 S1's keys). They are revised before the first result if W-C02-09 names other keys (README section 8).
  - (a) The transfer's functions refuse every token but `devos_kurulum`: `T-W07-5B`'s row R19 ("Only `devos_kurulum`", B:397), not repeated here.
  - `N04-T1` (b): after `begin_transfer_run`, `transfer_review` with the `devos_kurulum` token writes the Review copy of a planted work item's verdict. Wanted: accepted; the copy's `reviewer_role_class` and its events' `role_class` are `devos_kurulum`. Its negative pair is (a), R19's other tokens refused. Not accepted with the chosen keys: `could_not_check`.
  - `N04-T2` (c): `accept`, the rule C02 builds that needs the audit environment's verdict (B:244; EV-C02-005 2.4), with the `devos_denetim` token on a Verdict whose Review is a `devos_kurulum` copy with a `transferred` creation event. Wanted: refused, the target's acceptance unchanged. Its pair `N04-T2-pos`: the same call on a Verdict whose Review is `devos_denetim`'s → accepted, the target `accepted`. The two differ only in the role class. Both Review and Verdict rows are planted at owner level, result `pass`, with their tables' triggers off for that insert only (README 5.1 (a); DM-41 (a) would refuse a Review of a target planted in the file's one transaction). If the pair is not accepted, both are `could_not_check`.
  - The other approvals that count as the audit environment's in C02 are not Verdicts, so no copy can be named in them: an effort reduction's approval and a standing policy are `set_effort_policy` calls whose approving class is the token's (EV-C02-008 1.7.4 kinds (b) and (c)), refused to `devos_kurulum` by `N03-neg-own-approval-kurulum` and `N03-neg-standing-kurulum`.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W07-N04. Appendix C's claim: "The ban on approving one's own output is at environment level". |
| **Failure class rule** | **[Designer's addition: Appendix C's C2 rows give none (R2 section 5 (c)).]** Any binding verdict, acceptance or audit-counted approval that is written with a token other than the audit environment's. This includes a token that declares the audit environment's name or another session by any field the caller controls, and the installation token outside the transfer's path. |
| **Examples** | **[Designer's addition, as above.]** (1) The original finding (C:121): the working token writes a verdict or an acceptance (`N04-a1`, `N04-b1`). (2) Another manifestation: the same token declares itself the audit environment (`N04-c1` to `N04-c4`) or another session (`N04-e*`). (3) Another: the installation token writes a verdict directly, outside the transfer (`N04-k1`, `N04-k2`; EV-C02-003 §4.2: "a verdict written directly with the `devos_kurulum` token, outside the transfer, which any installation session could write"). |
| **Negative control** | Every `N04-a*`, `-b*`, `-c*`, `-e*` and `-k*` case: refused as a role refusal under the token's own class, recorded once per call, no event, no table changed. |
| **Positive control** | `N04-p1` to `N04-p4`: the audit environment's record is accepted (C:121's positive). |
| **Break attempt** | **[Designer's addition, as above.]** Each patch is applied by the harness on the throwaway database (README 5.2).<br>**B-5B-1** (`breaks/B-5B-1_verdict_admits_working.sql`). Removed: the working class's exclusion from `record_verdict`'s role list. Red: `N04-a1`, `N04-a2`, `N04-c1`, `N04-c2`, `N04-e1-record_verdict` and `5B-R07-record_verdict-cal`. `N04-c3-record_verdict` and `N04-c4` also turn red where they exist.<br>**B-N04-1** (`breaks/B-N04-1_kurulum_accepts.sql`). Removed: S8 line 1 for `accept`, which now admits `devos_kurulum`. Red: `N04-k2` and `5B-R07-accept-kur`.<br>**B-N04-2** (`breaks/B-N04-2_transfer_copy_as_audit.sql`; phase C5). Removed: the copy's role class. `transfer_review` is wrapped so that the copy it wrote, its Verdicts and their events are relabelled `devos_denetim`. Red: `N04-T1`.<br>**B-N04-3** (`breaks/B-N04-3_accept_counts_transfer_copy.sql`; phase C5). Removed: `accept`'s refusal of a copy. `accept` is wrapped so that, for the call, the Verdict it names and its Review show `devos_denetim`. Red: `N04-T2`. |
| **Stage and environment** | C02, in `devos-test` (the job's test step) and on the throwaway database, with synthetic tokens. The real-token run of the same cases is W-C02-12 points 4 to 6 (`T-W07-RT`, cases RT-cal-n1, RT-cal-n2, RT-cal-n5, RT-kur-n2, RT-kur-n5 and RT-den-p2): N04 with the working and `devos_kurulum` tokens, and N04's positive with the audit environment's real token. The migration job runs a file of this test only once W-C02-10 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | As `T-W07-IDC`: written by the test designer (fresh-context `test-designer` subagent, phase B, Group D; part T's cases and B-N04-2 and -3, phase C5; agent IDs in W-C02-07's Record); run by the job, W-C02-10's producer and W-C02-13's prober; judged by a fresh-context checker. Shared: model lineage, the design records and the README. |
| **Evidence layer** | Structural, at the database (`sql-set-role`). It does not show the separation in `devos` with real tokens (`T-W07-RT`), C05's version activation, or C10's method changes. |
| **Evidence envelope** | README section 4.<br>Fixed before the run: every case `ok`. On the stand-in, the file had 18 cases: 2 + 2 working, 2 fake role, 1 + 1 fake session, 4 + 2 installation (with `open_review` and `set_effort_policy` present; phase C4a drops `set_effort_policy` from the list, so the same stand-in now gives 4 + 1), and 4 positives. A function with role or session arguments, or a database role `devos_denetim`, adds its case. The red cases of each break are as above. Phase C5 adds part T's three cases, each wanted `ok`.<br>`transport`: `sql-set-role` or `throwaway`. `observations_ref` and `raw_evidence_ref` as `T-W07-IDC`. |

## Clause table

Appendix C N04, C:121 as PC-43 place 9 writes it.

| Clause (verbatim) | Case IDs | Or: moved to |
|---|---|---|
| "The ban on approving one's own output is at environment level" (claim) | the whole test | |
| "A binding verdict or an acceptance with the working environment's token is rejected (C02)" | `N04-a1`, `N04-a2`, `N04-b1`, `N04-b2` | |
| "and so is a version activation from C05, in the form C05 gives release activation (Appendix B 3.14)" | | C05 (Appendix C's stage column; C02 builds no release activation) |
| "**a fake role name and a fake session ID with the same token** are also rejected" | `N04-c1` to `N04-c4`, `N04-e1-*`, `N04-e2`, `N04-k6` | |
| "with the installation environment's token (`devos_kurulum`), a verdict or an acceptance written other than through the ledger transfer's path" | `N04-k1`, `N04-k1b`, `N04-k2`, `N04-k6` | |
| "and any approval that a rule counts as the audit environment's, is rejected too (C02; EV-C02-003 section 4.2)" | `N04-k-<function>`; with `T-W07-5B` rows R07, R10r, R15 and R25 for `kur`; and, for R08's operations after the gate (EV-C02-008 1.7.4), `T-W07-N03`'s `N03-neg-own-approval-kurulum` and `N03-neg-standing-kurulum` | |
| "The audit environment's record is accepted" | `N04-p1` to `N04-p4` | |
| "the ledger transfer's copy of an installation checker verdict is written under role class `devos_kurulum` and counts nowhere a rule needs the audit environment's (C02, until C03 …)" | Part T, inside the file's result since phase C5: `N04-T1` (the copy written under `devos_kurulum`), `N04-T2` with `N04-T2-pos` (`accept` does not count it); the other tokens refused: `T-W07-5B` R19. Counted by W-C02-10 point 7 ("N04 (its C02 part)") | — |
| Stage "C02, C05, C10" | C02: this test | C05 and C10: theirs (W-C02-07 point 2) |
| N-136's extension: N04 with the `devos_kurulum` token | `N04-k*` | |

## Format gate

Not a format-gate test.

## Could not check

- Before the build, or if `record_verdict` or `accept` is absent (`N04-pre`).
- `N04-p3` and `N04-p4`, when the fixture cannot be planted or the audit call on it is not accepted. The arguments are then revised.
- Part T (`N04-T1`, `N04-T2`, `N04-T2-pos`), while the transfer's functions or `accept` are absent, `begin_transfer_run` or a positive pair is not accepted with the chosen keys (revised before the first result when W-C02-09 names them), or a fixture cannot be planted.

## Self-check (not a result)

On 2026-10-12, on PostgreSQL 16.15, with the scratch stand-in:
- without the build: COULD NOT CHECK;
- with the stand-in: PASS (18/18), and part T's line printed (part T then had a line of its own; since phase C5 it is inside the file's result, and no file prints a separate part line: CHK-C02-046 C5 (b));
- B-5B-1 and B-N04-1 turned exactly their listed cases red.

## Not covered

- Version activation (C05) and C10's method changes.
- A fake declared session ID on a claim-bearing operation that is not a verdict (`T-W07-5C`, Group A).
- Real tokens (`T-W07-RT`).
- Whether a declared field is stored as declared and marked so (B principle 8): the test shows only that it changes no outcome.
