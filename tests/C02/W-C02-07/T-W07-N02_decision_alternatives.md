# T-W07-N02 · A high-impact decision cannot be opened without alternatives research, nor answered from open exploration

Synthetic test data (plan Section 8 item 13): every decision, revision, Mission and option is made up, labelled `SYNTHETIC W-C02-07` or `w07_fixture` (the options are "w07_fixture form A/B"), and rolled back. Tokens are issued at run time and never written down (README section 6).

**Serves.** W-C02-10 points 6 and 7 (Decision's gate; the open-exploration rule; N02's "filled but meaningless" examples, point 3). C02 Acceptance lines on the format gates and complete records. Appendix C N02 (`Ek_C:119`). W-C02-07 point 4 (the `open_exploration` case for each transition C02 builds that answers or accepts a decision). Design: B 3.17 (gate at `open`; the open-exploration rule, PC-08; CHK-C00-035 item 3); EV-C02-002 DM-27 (no "major design" marker: tested as a `high_impact` decision without `premises`), DM-46 (`alternatives_state`), DM-11 (the transfer's answered decisions), DM-08 (the `decision` stream).
**Command.** `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_n02_decision_alternatives.sql` (the migration job's `devos-test` step, as `postgres`; README 5.1 (a)); the break harness with the patches below.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed** (README section 8):
- `devos_api.open_decision(jsonb)` with B 3.17's fields as keys (`class`, `options`, `alternatives_considered`, `alternatives_state`, `single_viable_path_reason`, `criteria`, `evidence_refs`, `assumptions`, `premises`, `reversibility`, `reopen_triggers`, `status`); a refusal is returned or raised and names the field (`options`, `alternatives…` or `single_viable_path…`; `premises`). Each call runs as `anon` with the header `x-devos-env-token` holding a token from `devos_private.issue_env_token(text)` (text, or jsonb with `token`), issued inside the rolled-back transaction (EV-C02-003 §1.6, §6.3).
- Revisions in `devos_private.decision_revision` (`decision_id`, `revision`, the revisable fields as columns, among them `alternatives_state`, `options`, `single_viable_path_reason`); state in `devos_private.decision` (`status`, `answered_revision`).
- **The open-exploration rule is held on the decision's state change** (a trigger or constraint on `devos_private.decision`), so that every path that answers or accepts meets it: the ledger transfer's in C02 (DM-11), `answer_decision` from C06. A build that holds it only inside one function fails `N02-oe-*` and is revised with the executor before a first result.
- Sample reviews: rows of `devos_private.review` with `kind = sample`, naming the target's `id`, with one field holding `devos_denetim` (the queue). Streams: `devos_private.sample_stream` (`stream`, `block_size`, `block_seen`, `block_position`), here `decision`.
- Fixtures: a `batu` decision answered at owner level and a Mission on it opened with the `devos_kurulum` token (DM-23; EV-C02-003 §4.1).

## Cases
For each class `high_impact` (`-hi`) and `batu` (`-batu`), with the working token:
- `N02-pos-compared-*`: compared options and every gated field → accepted.
- `N02-neg-none-*`: no options, no `alternatives_considered`, no `single_viable_path_reason`, no `alternatives_state` → refused, naming the alternatives; no row.
- `N02-neg-compared-empty-*`: `alternatives_state = compared` with an empty `options` list → refused.
- `N02-neg-single-blank-*`: `alternatives_state = single_viable_path` with a whitespace reason → refused.
- `N02-neg-premises-empty-*`, `N02-neg-premises-absent-*`: `premises` empty or absent (the "major design decision without premises", DM-27) → refused naming `premises`.
- `N02-pos-single-*`: a single feasible path with its justification, no options → accepted.
- `N02-pos-single-one-option-*`: the same with exactly one option → accepted (no invented second option needed).
- `N02-pos-open-exploration-*`: `alternatives_state = open_exploration`, no options → accepted at `open`.
- `N02-oe-answer-*`, `N02-oe-accept-*`: a decision opened in `open_exploration` with no options and no reason, then answered (to its current revision) or accepted at owner level → refused; status stays `open`.
- `N02-oe-pos-reason-*`: after a new revision that enters `single_viable_path_reason`, the answer → accepted. `N02-oe-pos-options`: after a revision that enters compared options, the acceptance → accepted.
- `N02-oe-transfer`: COULD NOT CHECK until W-C02-06's design is accepted (below).
- `N02-oe-answer-decision`: present only if the build has `devos_api.answer_decision`; then COULD NOT CHECK until the case is written for it.
- `N02-fbm1`, `N02-fbm2`: one complete block each of `high_impact` decisions filled but meaningless → all accepted; one sample per block.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-N02`: a `high_impact` or `batu` decision cannot be opened without the result of the alternatives research (compared options, a single-path justification or an open exploration state) or without premises; a single feasible path with its justification is accepted; a decision in open exploration cannot be answered or accepted until options or a justification are entered. |
| **Failure class rule** | **[Designer's addition: C2 rows give none (R2 section 5 (c)).]** Any path by which a decision that binds the schema, rules, roles, methods or Batu's matters reaches `open`, `answered` or `accepted` without a recorded result of its alternatives research or its premises; and the over-correction that demands an invented option. |
| **Examples** | **[Designer's addition.]** Original finding (C:119's first negative): neither options, nor single path, nor open exploration (`N02-neg-none-*`). Other manifestations: a state that claims comparison with no options (`N02-neg-compared-empty-*`); a single path with a blank reason (`N02-neg-single-blank-*`); no premises (`N02-neg-premises-*`); an answer or acceptance out of open exploration (`N02-oe-answer-*`, `N02-oe-accept-*`). |
| **Negative control** | The `N02-neg-*` and `N02-oe-answer/accept-*` cases: refused, with no `decision` row (open) or with the status unchanged (`open`) and no answer recorded. |
| **Positive control** | `N02-pos-compared-*`, `N02-pos-single-*`, `N02-pos-single-one-option-*`, `N02-pos-open-exploration-*`, `N02-oe-pos-reason-*`, `N02-oe-pos-options`: each differs from its negative only in the field the rule tests. |
| **Break attempt** | **[Designer's addition; plan Section 8 item 3.]** (1) The alternatives part of the gate, `breaks/B-N02-1_alternatives_gate.sql` (a blank result gets a filled reason before the build's function): red `N02-neg-none-hi`, `-batu`, `N02-neg-compared-empty-hi`, `-batu`, `N02-neg-single-blank-hi`, `-batu`. (2) The premises part, `breaks/B-N02-2_premises_gate.sql`: red `N02-neg-premises-empty-hi`, `-batu`, `N02-neg-premises-absent-hi`, `-batu`. (3) The open-exploration rule, `breaks/B-N02-3_open_exploration_rule.sql` (its trigger or check on `devos_private.decision`, found by its source, disabled): red `N02-oe-answer-hi`, `N02-oe-accept-hi`, `N02-oe-answer-batu`, `N02-oe-accept-batu`. (4) The decision stream's sample, `breaks/B-N02-4_sample_skipped.sql`: red `N02-fbm1`, `N02-fbm2`. |
| **Stage and environment** | C02. `devos-test` (migration job step) and the throwaway database; synthetic tokens (`sql-set-role`), no real token. |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group C); its agent ID and type are in W-C02-07's "Record" (point 1). Run by the migration job, by W-C02-10's producer at its head, and by W-C02-13's prober with the breaks. Judged by a fresh-context checker that wrote none of the tests. Shared: model lineage and the design records (EV-C02-002, -003, -004; plan Section 8 item 7). |
| **Evidence layer** | Structural. It does not show that the options compared are real alternatives or the premises true (sample review, C03 onward; plan Section 8 item 12), nor the decision channel's answer path (C06). |
| **Evidence envelope** | README section 4. Fixed before the run: each case's outcome above; one sample per complete block of 10. Observation: the job's run (URL, run ID, step) with the result rows and the final notice or exception; raw evidence ID: the job's unedited output filed under `evidence/C02/raw/`, after the hygiene checks; transport `sql-set-role` (job) or `throwaway` (harness). |

## Clause table (Appendix C N02)
| Clause (verbatim) | Case ID(s) | Or: moved to |
|---|---|---|
| "A high-impact decision cannot be opened without alternatives research" (claim) | `N02-neg-none-*`, `N02-neg-compared-empty-*`, `N02-neg-single-blank-*` | — |
| "A decision with neither compared options, nor a single-path justification, nor an open exploration state is rejected" | `N02-neg-none-hi`, `N02-neg-none-batu` | — |
| "a major design decision without premises is rejected" | `N02-neg-premises-empty-*`, `N02-neg-premises-absent-*`: **tested in the design's form** (EV-C02-002 DM-27: no marker; a `high_impact` decision without `premises`) | — |
| "A decision that writes down the single feasible path with its justification is accepted" | `N02-pos-single-hi`, `N02-pos-single-batu` | — |
| "an invented second option is not required" | `N02-pos-single-one-option-*` (and `N02-pos-single-*`, with none) | — |
| W-C02-07 point 4: open exploration "cannot be answered or accepted … for each transition C02 builds" | `N02-oe-*` (the rule on the decision's state); `N02-oe-transfer` (the ledger transfer's path) | `answer_decision`: C06 (B:390); the carrier note on `plan/work/C06.md` is the executor's (GROUPS section 5) |
| Break | `B-N02-1` to `B-N02-4` | — |

## Format gate (point 4)
Kind 1 (`N02-fbm1`): every gated list filled with `x` and `reversibility` = `x`. Kind 2 (`N02-fbm2`): a single path whose reason is circular. The database accepts both; each complete block of ten lands one of them as a `sample` Review queued for `devos_denetim`.

## Could not check
The test's own result stays COULD NOT CHECK while `N02-oe-transfer` is: the ledger transfer writes answered decisions in C02 (DM-11), and its path is W-C02-06's, not yet designed. The case is written against `devos_kurulum`'s transfer path (EV-C02-003 §4.2; PC-43) once that design names its function: the interface W-C02-06 must fix is the function or step that writes a decision's answered state and the revision it answers. Executor decision 5 applies: the test may be revised then, before any result is seen. Also COULD NOT CHECK when an object is absent (`N02-pre`), a fixture cannot be made, or a revision cannot be planted.

## Not covered
The decision channel's cases (C06, N-096); FrameReview's `major_design` marker (C10, DM-27); the meaning of options and premises (sample review); `devos`.
