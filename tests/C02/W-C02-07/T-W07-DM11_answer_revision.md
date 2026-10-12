# T-W07-DM11 · An answer is recorded only to the current revision, and no revision follows an answer

Synthetic test data (plan Section 8 item 13): every decision, revision, answer text (`w07_fixture SYNTHETIC W-C02-07 …`), relation and Mission is made up and rolled back; no answer of Batu's is used or imitated beyond a labelled placeholder. Tokens are issued at run time and never written down (README section 6).

**Serves.** W-C02-10 (Decision's rules, B 3.17), or the stage that builds `answer_decision` for the channel's cases (C06, N-096). GROUPS section 4 (EV-C02-002 section 6: "an answer's revision equals the current one, and no revision follows an answer (DM-11)"; plan Section 8 item 3 asks a break test for every database rule). Design: B 3.17 (PC-42 places 21, 22, 29); EV-C02-002 DM-11 ("C02 builds the field and the two database rules … The two rules' structural test is W-C02-07's"), DM-02 (immutable revisions).
**Command.** `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_dm11_answer_revision.sql` (the migration job's `devos-test` step, as `postgres`); the break harness with the patches below.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed** (README section 8):
- `devos_private.decision` holds the state (`status`, `answered_revision`, and where present `answered_at`, `answered_by`, `answer_channel_ref`, `answer`, `answer_original_tr`, `answer_interpretation_en`); `devos_private.decision_revision` holds the revisions (`decision_id`, `revision`).
- **The two rules are held on the tables** (a trigger or constraint), so that every writer meets them: in C02 the ledger transfer's answered decisions (DM-11; W-C02-06), from C06 `answer_decision`. The test therefore records answers and writes revisions at owner level inside the rolled-back transaction. A build that holds the rules only inside one function fails `DM11-a` to `-e` and is reconciled with the executor before a first result.
- Decisions opened with `devos_api.open_decision(jsonb)` (working token); `devos_api.relate(jsonb)` with `type = supersedes`; calls run as `anon` with the header `x-devos-env-token` from `devos_private.issue_env_token(text)`; fixtures: a Mission on an answered `batu` decision, opened with the `devos_kurulum` token.

## Cases
- `DM11-a` (original finding, ECC-80: an answer to text that changed): a `batu` decision with revisions 1 and 2; an answer recorded to revision 1 → refused; status stays `open`, `answered_revision` null.
- `DM11-b`: an answer recorded to revision 3, which does not exist → refused.
- `DM11-c`: an answer recorded with no revision → refused.
- `DM11-pos-answer`: an answer recorded to revision 2, the current one → accepted.
- `DM11-d`: after that answer, a new revision → refused; the revision count unchanged.
- `DM11-e`: a `high_impact` decision answered, then accepted; a new revision → refused.
- `DM11-pos-revision`: a new revision of a decision still open → accepted.
- `DM11-pos-supersede`: a new decision related `supersedes` to an answered one → accepted (the change after an answer).
- `DM11-channel`: present only if the build has `devos_api.answer_decision`; then COULD NOT CHECK until its cases are written.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-DM11`: an answer is recorded only to the decision's current revision, and once a decision is answered no revision of it is written. |
| **Failure class rule** | **[Designer's addition: a rule a design record adds.]** Any state in which a recorded answer and the text it answers can differ: an answer bound to another revision or to none; a revision written after the answer. |
| **Examples** | Original finding (EV-C00-011 row ECC-80, via DM-11): an answer to an earlier revision (`DM11-a`). Other manifestations: a revision that does not exist (`DM11-b`), none (`DM11-c`), a revision after the answer (`DM11-d`, `DM11-e`). |
| **Negative control** | `DM11-a` to `-c`: refused, the decision's state unchanged. `DM11-d`, `-e`: refused, no revision added. |
| **Positive control** | `DM11-pos-answer` differs from `DM11-a` only in the revision answered; `DM11-pos-revision` from `DM11-d` only in the decision's state; `DM11-pos-supersede` shows the path after an answer. |
| **Break attempt** | **[Designer's addition.]** (1) `breaks/B-DM11-1_answer_equals_current.sql` (the trigger or check on `devos_private.decision` whose source names `answered_revision`, and not `open_exploration`, disabled): red `DM11-a`, `DM11-b`, `DM11-c` (if the build checks the missing revision elsewhere, `DM11-c` stays green and the list is revised before a first result). (2) `breaks/B-DM11-2_no_revision_after_answer.sql` (the trigger or check on `devos_private.decision_revision` whose source names the answer, disabled): red `DM11-d`, `DM11-e`. If the build holds both rules in one function, each patch is revised to remove one. |
| **Stage and environment** | C02. `devos-test` (migration job step) and the throwaway database. |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group C); its agent ID and type are in W-C02-07's "Record" (point 1). Run by the migration job, by W-C02-10's producer at its head, and by W-C02-13's prober with the breaks. Judged by a fresh-context checker that wrote none of the tests. Shared: model lineage and the design records (plan Section 8 item 7). |
| **Evidence layer** | Structural. It does not show the answer's identity (C06, B3 = (a)), nor the channel's cases ("an answer to edited text, an answer drained but not applied, an answer after the decision closed", N-096), nor that an answer to another revision is recorded as an event (C06's `answer_decision`). |
| **Evidence envelope** | README section 4. Fixed before the run: each case's outcome. Observation and raw evidence: the job's run and unedited output under `evidence/C02/raw/`, after the hygiene checks; transport `sql-set-role` or `throwaway`. |

## Clause table (the design's rules; no Appendix C entry)
| Clause (B 3.17, PC-42 place 22) | Case ID(s) | Or: moved to |
|---|---|---|
| "`answered_revision` is set with the answer and must equal the decision's current revision when the answer is recorded" | `DM11-a`, `DM11-b`, `DM11-c`, `DM11-pos-answer` | — |
| "an answer to another revision is recorded as an event, with its channel reference, and not applied, and the decision stays open" | `DM11-a` (not applied, stays open) | the event and channel reference: C06 (`answer_decision`, N-096) |
| "Once a decision is answered, no new revision of it is written" | `DM11-d`, `DM11-e`, `DM11-pos-revision` | — |
| "a change after the answer is a new decision that `supersedes` it" | `DM11-pos-supersede` | — |

## Could not check
COULD NOT CHECK when an object is absent (`DM11-pre`), a second revision cannot be planted (`DM11-eq`), an answered decision cannot be marked accepted (`DM11-e`), or `answer_decision` exists without its cases (`DM11-channel`).

## Not covered
`answer_decision` and its intake (C06); Batu's identity on answers (C06); `devos`.
