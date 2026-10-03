# W-C00-12 · 03 · Design piece 2: the work model (object O2)

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only; it is the file-form subset of plan K-1, K-5 and Ek B §3.2–3.4, which are DevOS scope. **Written:** 2026-10-03 by run `session_0143r88Vc9e5RbsQmqjYWgwa`. **Builds on:** `02_memory.md` (work items are records in `plan/work/`). **Serves:** acceptance (a2) in full; needs N1, N7; principles 10 and 17; Batu's work-discovery chain.

## Revision 2 (2026-10-03, after the counter-design comparison)

Applied from `06_counter_design_comparison.md` revision 2 by run `session_01Wj4JDduaDRVnBvQJ86b5bm`. Each line supersedes the rule it names; superseded text below is marked.
- **§4 staleness superseded** by D-18: each item records `basis:` as a list of record paths with their git blob hashes at admission. The render compares them with `main`; a changed hash marks the item `stale: recheck`, and a recheck note clears it. This one detector covers supersessions, corrections and content edits of plan sections alike. `assumes` stays as the human-readable list of premises.
- **Probe before build** (D-27): an item may name `platform:` dependencies; one whose status is `untested` keeps the item out of the frontier and names the probe to run.
- **Usage filter** (D-16): items carry `class: heavy | light`; at `allowed_warning` the frontier offers only light items.
- **Decomposition depth** (D-41): the record check fails if an item has children while neither it nor its parent is running or ready.
- **Use** (D-40): the start record names the card elements it relies on (`relies_on:`); tests T-05 and T-06 of the counter-design are adopted as work-model tests (D-32).
- **Card length** stays short by construction (about 120 lines); a design constraint, not a check (D-36).


## 1. Problem

The builder's work list was a table of items with a free-text status and an acceptance cell. Observed consequences: "done by the producer's own judgement" sat in the same field as "done" (W-C00-05); the Next action row was a sentence a person rewrote, and went stale (L-027); a discovery about later stages had nowhere to go but OI-011; a run could not tell which items were startable without reading every row; and nothing marked an item as resting on a premise that later changed. Batu's texts name the distinctions the list lacked: intent ≠ need ≠ discovered ≠ admitted ≠ ready ≠ selected ≠ executing ≠ finished ≠ accepted; the whole visible while the active branch deepens; composition is its own step; plan changes are candidates decided by the plan's owner.

## 2. The states, as separate fields

Batu's chain is not one sequence of values in one field: some links are a status, some are derived, some are separate axes. The work item's front matter therefore carries:

| Field | Values | Who sets it | Meaning |
|---|---|---|---|
| `admission` | `candidate`, `admitted`, `declined` | the plan's owner for that kind of item (§5) | discovered work is a `candidate`; only `admitted` work can become ready |
| `execution` | `planned`, `running`, `waiting`, `finished`, `cancelled` (Ek B §3.3) | the producer | `finished` is the producer's claim, nothing more |
| `qualification` | `current`, `stale`, `needs_review` (Ek B §3.3) | **derived** by the render script from the item's `assumes` and `depends_on` records (§4) | stale when something it rests on was superseded, retired or reopened |
| `acceptance` | `proposed`, `accepted`, `rejected` (Ek B §3.3) | a role other than the producer, or a deterministic check, named in `accepted_by` | the only field that means "done" |
| `ready` | true / false / unknown | **derived** (§3); never written by hand | startable now |
| `claimed_by` | a session ID or empty | the run that holds the lease | "selected and assigned" |

Needs and open notes (`N-nnn`, Ek B §3.2: `condition`, `origin` = goal / method / merely useful, `why_needed`, `return_to`, `status`) sit before admission: a need becomes work only when an admitted item is created for it.

**Rule W-R1 No producer acceptance.** The check (`tools/check_records.py work`) fails if `acceptance: accepted` and `accepted_by` names the producer session, is empty, or names neither a review record nor a deterministic check's evidence file. This makes acceptance (g)'s "no item is accepted by its own producer" mechanical for the builder's own items.

## 3. Ready is derived: the startable frontier

`ready` is computed by `tools/records.py render`, never typed, using Ek B's three-valued rule (Ek B §1 item 6):
- `admission = admitted`, `execution` is `planned` or `waiting`, `qualification = current`;
- every `depends_on` target has `acceptance = accepted` (or `execution = finished` where the edge says `on: finished`, for work that may proceed on a producer's draft, such as comparing with the counter-design);
- no attached need with `origin` blocking and `status` open, and no open decision owned by Batu that the item names in `waits_for`;
- any `unknown` makes the item not ready (an empty group is never ready).

**Parent-child edges do not affect readiness.** Only `depends_on` does. The beads study found that letting a hierarchy edge propagate blocking produces livelocks in mixed chains; the builder avoids the class by construction. A parent's own readiness is about its composition step only (§6).

**W-R2 The Next action row is the generated frontier.** The state file's Next action row is replaced by a generated block listing the ready items, the items running with their claimant, and for the rest the first unmet condition. Nobody writes "what is next" by hand again (L-027). A run takes the highest-priority ready item by the existing priority rule (operating model §4.2); the ordering rule stays a judgement, recorded in the log when it overrides plain dependency order.

## 4. Dependencies, assumptions, staleness (staleness rule superseded, revision 2)

- `depends_on`: hard prerequisites (Ek B §3.4), each answering K-1's brake: "which decision or action would be wrong without this?" An edge without that answer fails the check (the K-1 format gate, applied to the builder's own work).
- `assumes`: the premises (`BP-nn`), decisions (`D-nnn`, `PC-nn`), probe results (`P-…`, `T-…`) and governing documents the item rests on.
- **Staleness is derived.** When a record named in `assumes` changes status (superseded, retired, reopened, or a test result FAILs on re-run), every item assuming it becomes `qualification: stale` in the next render. A stale item cannot be accepted until a re-qualification note says why it still holds or what changes (Ek B §3.3: an input change makes work stale; the old output is not deleted).
- `discovered_from`: provenance of emergent work (beads). It never implies order; if the discovered item truly blocks the origin, a separate `depends_on` is added with its brake answer.

## 5. Who admits, and plan changes as candidates

| Kind of change | Owner who decides | Record |
|---|---|---|
| A new item inside an admitted stage's purpose and scope (technical work) | the builder, with a log entry (operating model §6, technical normal) | item with `admission: admitted`, `admitted_in: L-…` |
| A change to an acceptance condition after work started; a new mechanism of high impact | independent review (PC-05; ledger rule 3) | candidate item with `admission: candidate` until the review record exists |
| A change of purpose, scope, money, Batu's accounts or acceptance of results | Batu (Appendix E) | candidate item plus a `D-nnn` decision record in Batu's batch |
| Retiring an item no longer needed (the novel's "distribution company") | the same owner as its admission | `admission: declined` or `execution: cancelled` with a Record changes line of kind retirement |

**W-R3 Candidates stay apart.** A candidate is visible in the zoom view under its branch, marked candidate, and never appears in the frontier. This is principle 18's candidate-versus-accepted line applied to the plan itself.

## 6. Composition

All children accepted does not make the parent done (`BATU_LIVING_PLAN_TR.md`; K-5's design / working / delivered states). A parent item carries its own `composition` acceptance condition, written before its children start: what the composed result must show, beyond the children's results.

**W-R4 Composition check.** The check fails if a parent has `acceptance: accepted` without a `composition` evidence record, or if any child is not accepted, cancelled or declined. The view shows "awaiting composition" for a parent whose children are all accepted. For W-C00-12 itself, the composition condition is acceptance (d)'s outside review "of purpose and robustness, not only the diff".

## 7. Zoom

The generated work view in the state file shows (`BATU_LIVING_PLAN_TR.md`, horizontal and vertical views):
- **Horizontal:** every stage C00 to C12 as one line (purpose, state, count of items by state), so the whole installation is always visible. Stages after C00 start as `planned` parent items holding only the notes attached to them (§8) and the needs N-ids from `01_goal_down.md` §2.
- **Vertical:** the active branch (the path from the stage to the claimed or ready items) expanded to its leaves, with each item's state, readiness reason and open notes; siblings of the active path shown one line each; everything else collapsed with counts.

Detail is uneven on purpose: an item is split into children only when work on it starts (operating model §4.1's "first item splits the stage" becomes "the first work on a branch splits that branch").

## 8. Open notes on branches

A discovery about other work is written where it will be needed (memory piece M-R3): a note `N-nnn` in that item's file, `discovered_from` the item where it arose, with `why_needed`. If the item does not exist yet, a `planned`, `candidate` item is created under the right stage. **Migration:** each OI-011 item becomes either a note on a W-C00-12 child, a note on a later stage's item (for example item 16, "ECC skills must be copied into the repository at a fixed version", attaches to W-C00-07, the ECC comparison; item 18, the connector-catalogue scan, attaches to C04 knowledge work as a candidate), or a closed note with its disposition (acceptance (b)). The migration table is part of the implementation PR.

## 9. Task context: every task carries its place

Acceptance (a2) and (k): every task given to a builder role carries its goal, parent, siblings, downstream effect and purpose chain.

**W-R5 Generated task header.** `tools/records.py brief <ID>` produces the header of every task the builder gives to a session or a subagent: the purpose chain (SOUL → DevOS → installation → stage → parent → item), the item's acceptance condition, its siblings with states, its downstream items (those whose `depends_on` names it), its `assumes` list with statuses, and the role scope (piece 3). The builder writes only the task-specific part below it.

**W-R6 Mechanical gate for sessions.** The allow-list hook's `create_session` rule additionally requires the first message to contain a line `Task-Brief: <ID> <hash>` whose hash matches `records.py brief <ID>` on the branch the session starts from. A session can therefore not be started without a generated brief for an existing item. In-process subagents are not gated (the hook sees only the `Agent` input; the instruction stands, and piece 3 tests it). This is a hook change: high impact, reviewed before merge.

## 10. Discovery is work

Finding the work is itself admitted work (`BATU_WORK_DISCOVERY_TR.md`; plan K-1): each stage's first item is a discovery item whose output is the stage's children, needs and candidates, with K-1's stop rule ("proceed when the remaining uncertainty does not materially change the current authorised action; budget or context running out is not readiness"). W-C00-12's own discovery items are `00_consolidation.md` and `01_goal_down.md`.

## 11. Scope and hand-over

| Mechanism | Scope | Replaced by | Trigger |
|---|---|---|---|
| Work item files, derived readiness, frontier, zoom view | installation | Ek B Work, WorkStanding, Relation and the `ready` query (C02) | C02 ledger transfer |
| Task header and session gate | installation; the pattern is DevOS's context package (K-6, C04) | `ContextPackage` and `DispatchReceipt` (Ek B §3.9) | C04 |
| Admission owners, candidates | DevOS (plan §14 and §6 already define plan-change ownership) | Decision records in the database | C02 |

## 12. Pre-registered tests

| ID | Claim | Procedure | PASS only if |
|---|---|---|---|
| T-W1 | Producer acceptance is rejected | Scratch item with `accepted_by` = its producer session; another with an empty `accepted_by` | both FAIL the check; an item accepted by a review record PASSES |
| T-W2 | The frontier is derived, not typed | Scratch tree: item B `depends_on` A; A finished but not accepted | B not in the frontier; after A is accepted by a review record, B appears without any hand edit to the state file |
| T-W3 | Staleness propagates | Supersede a decision named in an item's `assumes` | the item shows `stale` and leaves the frontier; T-W1's check also refuses its acceptance until a re-qualification note exists |
| T-W4 | Composition is required | Parent with all children accepted and no composition record, marked accepted | FAIL; with a composition evidence record, PASS |
| T-W5 | Candidates never reach the frontier | A `candidate` item with all dependencies met | absent from the frontier, present in the zoom view marked candidate |
| T-W6 | A session cannot start without a generated brief | `create_session` with no `Task-Brief` line; with a wrong hash; with a correct one | the first two are blocked by the hook; the third is allowed (unit test plus one live call) |
| T-W7 | The zoom view keeps the whole visible | Render with a claimed leaf three levels deep | all thirteen stages appear as one line each; the active path is expanded; unrelated branches are collapsed |
| T-W8 | The brake rejects a prerequisite with no reason | `depends_on` edge without its brake answer | FAIL |

## 13. Mechanism register rows

| Mechanism | Problem solved | Compensates for | Assumption | Cost | How it fails | Removal test |
|---|---|---|---|---|---|---|
| Separate state fields (§2) | "Done" by the producer's word | The model collapses claim and acceptance | Ek B axes fit the builder's work | A few fields per item | A field left stale; derived fields cannot be | W-C00-05's self-acceptance recurs |
| Derived readiness and generated frontier (§3) | Stale Next action row; unclear startability | Instructed rewrites decay | Dependencies can be written down | One render per merge | A missing edge makes an item look ready; the brake and review catch some | L-027 recurs |
| Derived staleness (§4) | Work resting on a changed premise continues | No impact tracking | `assumes` lists are complete | One field per item | An unlisted assumption; reviewed at acceptance | Work built on withdrawn premises (BP-04 history) |
| Admission owners and candidates (§5) | Scope drift; unreviewed acceptance changes | Execution bias | Owners per kind are stable | One field | Misclassified owner; the review checks | Silent widening of scope |
| Composition (§6) | Parent accepted from children's states | Decomposition bias | A composition condition can be written up front | One condition per parent | A vacuous condition; reviewed | W-C00-05's "each condition met, the whole weak" recurs |
| Task header and session gate (§9) | Sessions get a task without its place | The builder forgets context it has | Hook sees `create_session` input (T-H5, T-H6) | One script; one hook rule | Subagents not gated (stated) | Started sessions optimise locally (FP 5) |

## 14. Decision-and-basis record

- **Consulted:** plan K-1 and K-5 (status: Turkish plan, DevOS scope) for the need record, the unnecessary-prerequisite brake, the stop rule and the three assembly states; Ek B §1 item 6, §3.2–3.4 for the axes, three-valued readiness and relation types; Batu's Original texts `BATU_LIVING_PLAN_TR.md`, `BATU_WORK_DISCOVERY_TR.md`, `BATU_NOVEL_ANALOGY_TR.md`; library `beads/FINDINGS.md` §§2–5 (status: bounded-complete) for derived readiness, `discovered-from` and the parent-child livelock; `recursive-prerequisite-discovery/ASSESSMENT.md` §2 (status: bounded assessment) for AND/OR, ready versus completed, and return-to.
- **Left out on purpose:** beads' atomic claim and lease (one writer at a time under the run lease; revisit if parallel runs are allowed); a separate planning tool or connector (OI-011 item 18's Asana example: its dependency and owner fields are adopted as ideas; a second store would be a second source of truth); priority scoring formulas (the priority rule stays a recorded judgement).
- **Why it fits:** it turns each distinction Batu named into a field, a derivation or a check, reuses DevOS's own model, and removes the hand-written restatements that went stale.
- **How it is tested:** T-W1 to T-W8; the counter-design's answer to its question 2 is compared with this piece.
