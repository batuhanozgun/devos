# T-W07-5D · Every format gate refuses its field empty in every form, accepts complete records, and sends meaningless ones to sample review

Synthetic test data (plan Section 8 item 13): every need, decision, policy, finding, work item and Mission is made up, labelled `SYNTHETIC W-C02-07` or `w07_fixture`, and rolled back. Tokens are issued at run time and never written down (README section 6).

**Serves.** W-C02-07 point 5 (d) and point 4; W-C02-10 points 2 ("✘ Each refuses its field empty, in each of these forms: absent, the empty string, whitespace only, and, for a list field, an empty list; and where the rule says a field "cannot be emptied" (B 3.18), the field emptied by a later revision. ✔ Complete records of each gated family are accepted."), 3 ("at least two kinds for each gate") and 7. C02 Acceptance lines "✘ The format gates reject empty fields; "filled but meaningless" examples fall to the sample review." and "✔ Complete records are accepted." Design: B principle 12, 3.2, 3.8, 3.17, 3.18; EV-C02-002 DM-08, DM-30 (Finding's gate kept in C02), section 3 row 2.12 (N-032's structural part moved to C03).
**Command.** `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_5d_format_gates_empty.sql` (the migration job's `devos-test` step, as `postgres`); the break harness with the patches below.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit (about 230 calls in one transaction).
**Interface assumed** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. (README section 8): `devos_api.record_need`, `open_decision`, `set_effort_policy` (a call with the policy's `id` writes its next revision), `record_finding`, `admit_work`, `open_mission`, jsonb in and out; a gate's refusal names its field (for the alternatives: `options`, `alternatives…` or `single_viable_path…`), returned or raised; calls run as `anon` with the header `x-devos-env-token` from `devos_private.issue_env_token(text)`; owner-level reads of `devos_private.effort_policy`; `devos_private.sample_stream` (`stream`, `block_size`, `block_seen`, `block_position`); sample reviews in `devos_private.review` (`kind = sample`, the target's `id`, one field holding `devos_denetim`); fixtures: a Mission on a `batu` decision answered at owner level, opened with the `devos_kurulum` token.


**Phase C4a (EV-C02-008 section 2, merged and accepted; PC-46).** The sample Reviews this test expects are created by the database in the same transaction as each gated record. The design now states that DM-41's trigger does not count such a sample as a review record (EV-C02-008 2.2; B 3.11 and C N28 as PC-46 writes them), in place of the earlier assumption; `T-W07-N28` part A2 tests the exemption and its bounds.

## The gates C02 builds, and the forms tried
| Gate (field) | Source | Forms (case suffix) |
|---|---|---|
| Need `why_needed` (text) | B 3.2 | `-absent`, `-null`, `-empty`, `-whitespace` |
| Decision of class `high_impact` (`-hi`) and `batu` (`-batu`) at `open`: `criteria`, `evidence_refs`, `assumptions`, `premises`, `reopen_triggers` (lists) | B 3.17 | the four, and `-emptylist` |
| the same: `reversibility` (text) | B 3.17 | the four |
| the same: the alternatives result (`options`, `single_viable_path_reason`, with no `alternatives_state`) | B 3.17 | `-absent`, `-null`, `-empty`, `-whitespace`, `-emptylist` |
| EffortPolicy `expert_assessment_ref` (text) | B 3.18 | the four; and emptied by a later revision (`-rev-…-empty`, `-whitespace`) |
| EffortPolicy `non_removable_steps` (list) | B 3.18 | the four, `-emptylist`; and emptied by a later revision (`-rev-…-emptylist`) |
| Finding `counter_evidence_searched` (text) | B 3.8; DM-30 | the four |
| Finding `changeable` (mandatory; a boolean) | B 3.8; DM-26; DM-30 | the four |
| N-032's structural gate | — | moved to C03 (EV-C02-002 section 3 row 2.12; N-211): no case |

## Cases
- `5D-need-why_needed-<form>`, `5D-dec-<hi|batu>-<field>-<form>`, `5D-dec-<hi|batu>-alternatives-<form>`, `5D-eff-expert_assessment_ref-<form>`, `5D-eff-non_removable_steps-<form>`, `5D-find-counter_evidence_searched-<form>`, `5D-find-changeable-<form>`: working token; the complete record with that one field in that form → refused naming the field; no row added.
- `5D-need-pos`, `5D-dec-hi-pos`, `5D-dec-batu-pos`, `5D-eff-pos`, `5D-find-pos`: the complete record → accepted (every gate's positive control).
- `5D-eff-rev-expert_assessment_ref-empty`, `-whitespace`, `5D-eff-rev-non_removable_steps-emptylist`: a revision of the accepted policy emptying the field → refused; `5D-eff-rev-unchanged`: the stored fields are unchanged after them; `5D-eff-rev-pos`: a revision with a new, filled assessment → accepted.
- `5D-fbm-need-1`, `-2`, `5D-fbm-dec-1`, `-2` (class `batu`), `5D-fbm-eff-1`, `-2`, `5D-fbm-find-1`, `-2`: from a block boundary, one complete block of 10 filled-but-meaningless records of that kind → all accepted; exactly one sample review queued for `devos_denetim`.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-5D`: every format gate C02 builds refuses its field empty in each form W-C02-10 point 2 lists, accepts its complete record, and lets two kinds of filled-but-meaningless records through to sample review. |
| **Failure class rule** | **[Designer's addition: an Acceptance line, no Appendix C entry (R2 section 5 (b)).]** A gated field that is empty in substance (missing, null, empty, blank, an empty list, or emptied later) yet stored; or a gate so strict that a complete record is refused; or a filled field that never reaches the sample. |
| **Examples** | Original finding (R2 section 5 (b): "the format gates' "filled but meaningless" examples"; C0's last paragraph): `5D-fbm-*`. Other manifestations: each empty form of each field; a list emptied by a later revision (`5D-eff-rev-*`). |
| **Negative control** | Every `-absent`/`-null`/`-empty`/`-whitespace`/`-emptylist` and `-rev-` case: refused, naming the field, nothing written. |
| **Positive control** | The `-pos` cases, which differ from each negative only in the one field; `5D-eff-rev-pos`. |
| **Break attempt** | **[Designer's addition.]** (1) `breaks/B-5D-1_need_gate.sql`: red `5D-need-why_needed-absent`, `-null`, `-empty`, `-whitespace`. (2) `breaks/B-5D-2_premises_gate.sql`: red `5D-dec-hi-premises-<the five forms>`, `5D-dec-batu-premises-<the five forms>`. (3) `breaks/B-5D-3_expert_assessment_gate.sql`: red `5D-eff-expert_assessment_ref-<the four forms>`, `5D-eff-rev-expert_assessment_ref-empty`, `-whitespace`, `5D-eff-rev-unchanged`. (4) `breaks/B-5D-4_finding_gate.sql`: red `5D-find-counter_evidence_searched-<the four forms>`. (5) `breaks/B-5D-5_steps_emptied_by_revision.sql` (an emptying revision written directly): red `5D-eff-rev-non_removable_steps-emptylist`, `5D-eff-rev-unchanged`. (6) `breaks/B-5D-6_sample_skipped.sql`: red the eight `5D-fbm-*`. The other fields' gates are broken by the patches of `T-W07-N01`, `T-W07-N02`, `T-W07-N03` and `T-W07-FGFIND`, whose cases cover the same fields. |
| **Stage and environment** | C02. `devos-test` (migration job step) and the throwaway database; synthetic tokens (`sql-set-role`). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group C); its agent ID and type are in W-C02-07's "Record" (point 1). Run by the migration job, by W-C02-10's producer at its head, and by W-C02-13's prober with the breaks. Judged by a fresh-context checker that wrote none of the tests. Shared: model lineage and the design records (plan Section 8 item 7). |
| **Evidence layer** | Structural; a format gate's pass says nothing of content (plan Section 8 item 12). It does not show the `format_gate` label's form (below). |
| **Evidence envelope** | README section 4. Fixed before the run: every case's outcome; one sample per complete block of 10. Observation and raw evidence: the job's run and unedited output under `evidence/C02/raw/`, after the hygiene checks; transport `sql-set-role` or `throwaway`. |

## Clause table (the Acceptance line, W-C02-07 point 5 (d))
| Clause | Case ID(s) | Or: moved to |
|---|---|---|
| "✘ the format gates reject empty fields" | every `-absent`, `-null`, `-empty`, `-whitespace`, `-emptylist`, `-rev-` case | N-032's gate: C03 (N-211) |
| "and their "filled but meaningless" examples fall to the sample review (point 4)" | `5D-fbm-*` (two kinds per gate) | — |
| "✔ complete records are accepted (every gate's positive control)" | `5D-need-pos`, `5D-dec-hi-pos`, `5D-dec-batu-pos`, `5D-eff-pos`, `5D-find-pos`, `5D-eff-rev-pos` | — |

## Format gate (point 4)
Two kinds per gate: Need `-` and a circular reason; Decision every list `x` and a circular single-path reason; EffortPolicy `n/a` and an unrelated assessment; Finding `-` and `changeable = false` on a time-bound claim. Each must be accepted and land in sample review as a `Review` of kind `sample` queued for `devos_denetim`.

## Could not check
COULD NOT CHECK when an object is absent (`5D-pre`), a fixture cannot be made, no policy can be written to revise (`5D-eff-rev`), or a stream cannot be aligned.

## Not covered
The `format_gate` label's form (W-C02-10 point 2): W-C02-04's record gives no form to test against, so its checker judges it from the migrations; the content of records (sample review); N-032 (C03); `devos`.
