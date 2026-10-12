# T-W07-N01 · A need without a justification is not accepted; a filled but meaningless one reaches sample review

Synthetic test data (plan Section 8 item 13): every need, decision, Mission and review the test writes is made up, labelled `SYNTHETIC W-C02-07` or `w07_fixture`, and rolled back; the Mission's scope is `synthetic.w07_fixture`. Tokens are issued at run time inside the rolled-back transaction and never written down (README section 6).

**Serves.** W-C02-10 points 2, 3 and 7 (N01, the sample review, the sample share, the refusal of an agent-written sample). C02 Acceptance lines "✘ The format gates reject empty fields; "filled but meaningless" examples fall to the sample review." and "✔ Complete records are accepted." Appendix C N01 (`Ek_C:118`), verbatim in the clause table. Design: B principle 12, B 3.2, B 3.11 (sample reviews "created by the database, never by an agent"); EV-C02-002 DM-08 (one in every block of 10, at a hidden random position; "the test needs no tolerance"), DM-31 (a rule-made record belongs to its call).
**Command.** `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_n01_need_justification.sql`, run as `postgres` by the migration job's `devos-test` step after the merge's migrations (README 5.1 (a)), and by the break harness (`tests/C02/W-C02-07/harness/`, Group B) on its throwaway database with the patches below.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit. It makes about 90 calls inside one transaction (seconds).
**Interface assumed** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. (README section 8; revised before a first result if the build differs):
- `devos_api.record_need(jsonb)`, `open_decision(jsonb)`, `open_mission(jsonb)`, `open_review(jsonb)`; each returns jsonb. An acceptance carries `id`; a refusal is returned as `{"status": "refused", "reason_code": …, "field": …}` (B 3.13: the function rolls back its own partial work, records the refusal and returns it); a raised error is not interface v1's answer and makes the case "could not check" (README section 8.1); a format-gate refusal names its field (`why_needed`).
- `devos_private.issue_env_token(text)` returns the token once (text, or jsonb with `token`); calls run as `anon` with the header `x-devos-env-token` (EV-C02-003 §1.6).
- Sample reviews are rows of `devos_private.review` with `kind = 'sample'`; the row names the target record's `id`, and one of its fields holds `devos_denetim` (the audit environment's queue).
- `devos_private.sample_stream` has one row per stream (`stream`, `block_size`, `block_seen` = records counted in the open block, `block_position` = the hidden position); the need stream is `need`.
- Fixtures: a `batu` decision opened with the working token and answered at owner level (C02 builds no answering function, B:390), and a Mission on it opened with the `devos_kurulum` token (DM-23; EV-C02-003 §4.1).


**Phase C4a (EV-C02-008 section 2, merged and accepted; PC-46).** The sample Review this test expects is created by the database in the same transaction as the need. The design now states that DM-41's trigger does not count it as a review record (EV-C02-008 2.2's four conditions; B 3.11 and C N28 as PC-46 writes them), in place of the earlier assumption; `T-W07-N28` part A2 tests the exemption and its bounds. An agent-written sample is stopped by two layers (2.2 condition 2): `open_review`'s own refusal of kind `sample`, and the Review table's check of the sampling path's marker. `N01-tok-*` judge the first layer (CHK-C02-026 C2): the function's refusal, returned and recorded.

## Cases
- `N01-pos`: a complete need, working token → accepted, one `need` row more.
- `N01-neg1`: `why_needed` = `""` → refused naming `why_needed`; no row.
- `N01-neg2`: `why_needed` absent → refused naming `why_needed`; no row.
- `N01-neg3`: `why_needed` whitespace only → refused naming `why_needed`; no row.
- `N01-share`: the `need` stream's `block_size` is 10 (W-C02-04's recorded share, DM-08).
- `N01-fbm1`: from a block boundary, one complete block (10) of needs whose `why_needed` is `-` → all accepted; exactly one sample review queued for `devos_denetim` in the block, on one of them.
- `N01-fbm2`: the same with a circular justification ("it is needed because it is needed").
- `N01-rate`: three complete blocks (30) of complete needs → exactly one sample review per block, 3 of 30; tolerance 0.
- `N01-writer`: two blocks whose every need carries writer-chosen keys (`sample: false`, `skip_sample: true`, `sample_position: 1`) → still exactly one sample per block; or the keys are refused (then the writer cannot steer either).
- `N01-tok-devos_calisma`, `-devos_denetim`, `-devos_sinav`, `-devos_kurulum`: `open_review` with `kind = sample` on an accepted need, with each class's token → refused by the function, returned, and recorded once under the caller's class in RejectedAttempt (DM-19 (a)); the count of reviews of kind `sample` unchanged. A raised error is `bad` (the function did not refuse the call; a later layer stopped it), except SQLSTATE class 42 (the call could not be formed), which is `could_not_check`.

The alignment: before each block run the stream is brought to a block boundary with complete needs (read from `block_size` and `block_seen` at owner level), so each block counted is a complete block of the planted kind. If the stream cannot be aligned, the case is `could_not_check`.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-N01`: a need with an empty justification is refused; a filled but meaningless one is accepted and reaches the audit environment's queue as a `sample` Review; at the set share the sampled share matches the rate; a `sample` Review written with any environment token is refused. |
| **Failure class rule** | **[Designer's addition: Appendix C's C2 rows give no class rule (R2 section 5 (c)).]** Any path by which a need enters the database without a justification in substance, or escapes the sample that is the only check of its content: an empty field in any form; a share other than the recorded one; a sample a writer can steer, skip or forge. |
| **Examples** | **[Designer's addition, same reason.]** Original finding (C:118's first negative): an empty `why_needed` (`N01-neg1`). Other manifestations: absent and whitespace-only (`N01-neg2`, `N01-neg3`); a meaningless justification that only the sample can catch (`N01-fbm1`, `N01-fbm2`); a sample review an agent writes itself (`N01-tok-*`); a writer's attempt to steer the sample (`N01-writer`). |
| **Negative control** | `N01-neg1` to `-neg3`: refused, naming `why_needed`, with no `need` row added. `N01-tok-*`: refused by `open_review` itself, returned and recorded under the caller's class, with no review of kind `sample` added. |
| **Positive control** | `N01-pos`: the same need with a justification is accepted (it differs from `N01-neg1` only in `why_needed`). `N01-fbm*` and `N01-rate`: complete and meaningless needs are accepted and sampled at the share. |
| **Break attempt** | **[Designer's addition, same reason.]** (1) Removed: the database's creation of sample reviews; by `breaks/B-N01-1_sample_skipped.sql` (a trigger drops every Review of kind `sample`); red: `N01-fbm1`, `N01-fbm2`, `N01-rate`, `N01-writer` (if the build refuses the steering keys, `N01-writer` stays green and the list is revised before a first result). (2) Removed: the refusal of an agent-written sample, its first layer (`open_review`'s own refusal of kind `sample`, EV-C02-008 2.2 condition 2); by `breaks/B-N01-2_sample_written_by_agent.sql` (`open_review` wrapped to write the row itself); red: `N01-tok-devos_calisma`, `-devos_denetim`, `-devos_sinav`, `-devos_kurulum`. Phase C4a (CHK-C02-026 C2, before any result): the build's second layer, the Review table's check, still refuses the row the patch writes, by an error, so the cases want the function's own returned and recorded refusal and count the error as `bad`; they turn red under the patch whether the table's check raises or, in a build without one, the row is written. The second layer has its own break: `breaks/B-N28-3_review_table_check_removed.sql`, red `S-neg-direct` (`T-W07-N28` part A2). One break per layer, each with the case that turns red. If the build's table check raised with a SQLSTATE of class 42, the cases would give `could_not_check` under B-N01-2 rather than `bad`, and the patch would not show; the test designer then revises the case before the first result. (3) Removed: Need's gate; by `breaks/B-N01-3_why_needed_gate.sql` (a blank `why_needed` is filled before the build's function sees it); red: `N01-neg1`, `N01-neg2`, `N01-neg3`. Each run by the harness (README 5.2). |
| **Stage and environment** | C02. `devos-test`, in the migration job's step (owner-level path, EV-C02-003 §6.3; EV-C02-004 Y-05); the throwaway database for breaks. No Claude environment's real token: the role classes are synthetic tokens (`sql-set-role`); their real-token line is Group D's `T-W07-RT`. |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group C); its agent ID and type are in W-C02-07's "Record" (point 1). Run by the migration job, by W-C02-10's producer at its head, and by W-C02-13's prober with the breaks. Judged by a fresh-context checker that wrote none of the tests. Shared: model lineage and the design records (EV-C02-002, -003, -004; plan Section 8 item 7). |
| **Evidence layer** | Structural: the database refuses, accepts and samples. It does not show that a meaningless justification is recognised as such (the audit environment's sample review, from C03; plan Section 8 item 12), nor that the Data API passes the header (the header is simulated), nor anything about `devos`. |
| **Evidence envelope** | README section 4. Fixed before the run: every case's expected outcome above; block size 10; one sample per complete block; 3 samples of 30 needs in `N01-rate`, tolerance 0; 4 token classes refused. Observation: the job's run (URL, run ID, step) with the file's result rows and its final notice or exception; raw evidence ID: the job's unedited output filed under `evidence/C02/raw/`, after the hygiene checks. Transport `sql-set-role` (job) or `throwaway` (harness). |

## Clause table (Appendix C N01)
| Clause of the Appendix C entry (verbatim) | Case ID(s) | Or: moved to |
|---|---|---|
| "A prerequisite without a justification is not accepted (format gate)" (claim) | `N01-neg1`, `N01-neg2`, `N01-neg3` | — |
| "A need with an empty `why_needed` is rejected" | `N01-neg1` (and the forms `N01-neg2`, `N01-neg3`) | — |
| "a "filled but meaningless" justification is accepted by the database and lands in sample review" | `N01-fbm1`, `N01-fbm2` | — |
| "with the share set to take it, it reaches the audit environment's queue as a `Review` of kind `sample` (Appendix B 3.11)" | `N01-fbm1`, `N01-fbm2` (a complete block of meaningless needs: the share takes one of them whatever the hidden position) | — |
| "at the set share, the share of sampled needs matches the rate" | `N01-share`, `N01-rate` (tolerance 0: DM-08's one sample per complete block makes the count exact) | — |
| "a sample review written with the working environment's token is rejected" | `N01-tok-devos_calisma` (and the other classes, W-C02-10 point 3); with `T-W07-N28`'s `S-neg-open-*` (all six classes and `transfer_review`) and `S-neg-direct` (the table's check) | — |
| "A need with a justification is accepted" (positive) | `N01-pos` | — |
| Break (C0: "When the rule is deliberately removed, does the test fail?") | `B-N01-1`, `B-N01-2`, `B-N01-3` | — |

## Format gate (point 4)
"Filled but meaningless": `why_needed` = `-` (`N01-fbm1`) and a circular justification (`N01-fbm2`). The database must accept them; each block of ten lands one of them in sample review, as a `Review` of kind `sample` queued for `devos_denetim`. What the audit environment then judges is outside C02 (W-C02-10 "Not covered" (a)).

## Could not check
The test's own result is COULD NOT CHECK when an object above is absent (`N01-pre`, the case before the build exists), when the fixture Mission cannot be made, when the stream cannot be read or aligned to a block boundary, or when a token cannot be issued. Never PASS.

## Self-check (not a result; README 10)

Phase C4a, 2026-10-12, PostgreSQL 16.15, on a scratch stub of README 8.1 and EV-C02-008 sections 1.2, 1.7 and 2.2 (outside the repository, not delivered; the test designer's reading of the design, not the build: a pass on it is no evidence about the build): PASS (13/13); B-N01-1, B-N01-2 (revised) and B-N01-3 each turned exactly its `expect-red` list red; the break harness, with the stub as its migrations and the delivered file, showed B-N01-2 (`counts: no`). Under B-N01-2 the stub's table check refused the patch's row by raising, and N01-tok-* turned red as `bad`, as the layer rule says. On an empty database: COULD NOT CHECK.

## Not covered
The content judgement of a sampled need (C03 onward); the exemption of the database's own sample from DM-41 and its bounds (`T-W07-N28` parts A2 and B2); the sample's position after the draw (N-263, phase C4b); that the hidden position is random and unseen by agents (shown only in part: `N01-writer` shows a writer's keys do not steer it; W-C02-10 point 3's record states the mechanism); the event of a sample review and its `role_class` (Group B's `T-W07-F06`); the Data API path and `session_user`-keyed rules (README 5.1 (a)); `devos`.
