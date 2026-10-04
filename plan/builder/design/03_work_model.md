# W-C00-12 · 03 · Design piece 2: the work model (object O2)

**Status:** see `plan/ledger.md`, Governing documents. **Scope:** installation only. It is the file-form subset of plan K-1, K-5 and Ek B §3.2–3.4, which are DevOS scope. **Written:** first version 2026-10-03 by run `session_0143r88Vc9e5RbsQmqjYWgwa`. **Revision 3** (this text) was rewritten in place on 2026-10-03 by run `session_01XUsVQowRbLJdC1E8gFvxZq`, after review R-W12-1 (B2, M3 and m2). It is one design; earlier revisions are in git. **Builds on:** `02_memory.md` (work items are records in `plan/work/`). **Serves:** acceptance (a2) in full; needs N1 and N7; principles 10 and 17; Batu's work-discovery chain. **Tests:** `11_test_register.md`.

## 1. Problem

The builder's work list was a table of items with a free-text status and an acceptance cell. That caused these failures:
- "done by the producer's own judgement" sat in the same field as "done" (W-C00-05, L-033);
- the Next action row was a sentence a person rewrote, and it went stale (L-027);
- a discovery about later stages had nowhere to go but OI-011;
- a run could not tell which items were startable without reading every row;
- nothing marked an item as resting on a premise that later changed (BP-04, withdrawn in L-016);
- acceptance conditions changed after work started, by the producer: T-A1c was replaced (L-018, reviewed); a loop budget was set and then departed from (L-021 to L-023); a negative-control condition was declined for cost (L-030); a retired test was counted (L-033). These came from the K3 re-read of the log.

Batu's texts name the distinctions the list lacked: intent ≠ need ≠ discovered ≠ admitted ≠ ready ≠ selected ≠ executing ≠ finished ≠ accepted. They also ask that the whole stay visible while the active branch deepens, that composition be its own step, and that plan changes be candidates decided by the plan's owner.

## 2. The states, as separate fields

Batu's chain is not one sequence of values in one field: some links are a status, some are derived, some are separate axes. A work item's front matter carries:

| Field | Values | Who sets it | Meaning |
|---|---|---|---|
| `admission` | `candidate`, `admitted`, `declined` | the owner for that kind of item (§5) | discovered work is a `candidate`; only `admitted` work can become ready |
| `execution` | `planned`, `running`, `waiting`, `finished`, `cancelled` (Ek B §3.3) | the producer | `finished` is the producer's claim, nothing more |
| `qualification` | `current`, `stale` | **derived** by the render (§4) | stale when something it rests on changed status |
| `acceptance` | `proposed`, `accepted`, `rejected` | written by the run **only** from a verifier record or a deterministic check's evidence file, named in `accepted_by`; validated by the work check (W-R1) | the only field that means "done" |
| `impact` | `normal`, `high` | **derived** (W-R7) and raisable by the Triager | which verifier level acceptance needs |
| `targets` | paths the item expects to change | the producer, at admission | before a diff exists, the item's class is computed from these paths as W-R7 computes a PR's; an empty list is high (R-W12-2 m-2). The class of each PR still governs that PR |
| `ready` | true / false / unknown | **derived** (§3); never written by hand | startable now |
| `claimed_by` | a session ID or empty | the run that holds the lease | "selected and assigned" |
| `platform` | list of platform facts with status `observed` or `untested` | the producer, at admission | probe before build (W-R11) |
| `triage` | the Triager's record path | the Triager (piece 3) | depth and expertise |

**Who writes `accepted`** (R-W12-1 m2; the counter-design has only CI write it, and CI is not admitted as a gate). The run writes the field, and the work check refuses the value unless `accepted_by` resolves to one of two things: a verdict file whose verifier is not the producer (bound by M-R16), or a deterministic check's evidence file. The check runs at every stop (C-R1). The main-definition check workflow (C-R9), which would also run it from `main`'s definition on every PR, is deferred (R-W12-2 M-2). Until it is re-admitted, a producer who weakens the checker in its own branch is caught by the class-high review that every script change needs (W-R7).

Needs and open notes (`N-nnn`, Ek B §3.2: `condition`, `origin` = goal / method / merely useful, `why_needed`, `return_to`, `status`) sit before admission. A need becomes work only when an admitted item is created for it.

## 3. Ready is derived: the startable frontier

`tools/records.py render` computes `ready` with Ek B's three-valued rule (Ek B §1 item 6). An item is ready only when all of these hold:
- `admission = admitted`, `execution` is `planned` or `waiting`, and `qualification = current`;
- every `depends_on` target has `acceptance = accepted`. The one exception is an edge marked `on: finished` with a stated reason, for work that may proceed on a producer's draft (comparing with the counter-design proceeded on drafts by design; the drafts are accepted later through composition);
- every `platform` entry is `observed`;
- there is no attached need that blocks and is open, and no open decision owned by Batu named in `waits_for`.

Any `unknown` makes the item not ready, and an empty group is never ready.

**The C00 hold is an edge, not a sentence** (R-W12-2 B-1 b). The migration writes `depends_on: W-C00-12` into W-C00-06 to W-C00-11, and the stage record of C00 carries `hold_until: W-C00-12`, which the render applies to every item of the stage except W-C00-12 and its children, including items created later (critic of 13, finding 7: a new admitted item would otherwise bypass the six edges). Lifting the hold any other way is class high (W-R7): deleting or changing an edge or the `hold_until` field, adding `on: finished`, or changing the Stage row (T-W15, T-W9).

**Disposition of the counter-design's "readiness on `accepted` only"** (R-W12-1 m2 item 1): kept as the default, with `on: finished` as a marked exception that must carry its reason. A reviewer sees every exception in the frontier view, and adding one is class high (W-R7).

**Parent-child edges do not affect readiness.** Only `depends_on` does. A stage's own `depends_on` (C01 on C00, and so on) applies to every item in that stage: it is an edge on the stage, not a hierarchy edge, so an item under C01 is not ready until C00 is accepted (R-W12-3 F-10; added in tranche 1b-ii, where `tools/records.py` already does this since 1b-i). The beads study found that letting a hierarchy edge propagate blocking produces livelocks in mixed chains. A parent's own readiness concerns its composition step only (§6).

**Selection** (the counter-design's §4.6, adopted for R-W12-1 m2 item 3). The run takes from the frontier:
1. critical-path items first: items with many dependants, or that a stage gate or Batu's batch depends on;
2. heavy items at any hour (D-002 as amended on 2026-10-04; it removed the night preference).

It logs a one-sentence reason. The choice is a judgement, and the closure review samples it.

## 4. Dependencies, assumptions, staleness

- `depends_on`: hard prerequisites (Ek B §3.4).
- `assumes`: the premises (`BP-nn`), decisions (`D-nnn`, `PC-nn`), probe and test results (`P-…`, `T-…`) and governing documents the item rests on.
- **Staleness is derived from status changes, including corrections** (W-R9, revision 3). An item becomes `qualification: stale` in the next render when a record named in `assumes` changes in any of these ways:
  - it is superseded, retired or reopened;
  - its test result FAILs on re-run;
  - it receives a **correction** (the case the critic found, C-7). This is read from the Record changes blocks of the log (M-R5), so no file hash is needed.

  A stale item cannot be accepted until a recheck note says why it still holds or what changes.
- **Basis hashes are deferred** (W-R10, R-W12-1 M3). Per-file hashes would mark nearly every item stale at once at W-C00-06, when every plan file is rewritten. They are re-admitted only at W-C00-06, at section-anchor level, with a Turkish-to-English anchor mapping recorded once.
- `discovered_from`: provenance of emergent work (beads). It never implies order. If the discovered item truly blocks its origin, a separate `depends_on` is added.

## 5. Who admits, and plan changes as candidates

| Kind of change | Owner who decides | Record |
|---|---|---|
| A new item inside an admitted stage's purpose and scope (technical work) | the builder, with a log entry (technical, normal) | item with `admission: admitted`, `admitted_in: L-…` |
| A change to an existing item's acceptance block; a new high-impact mechanism | independent review (PC-05; ledger rule 3) | the change is impact class high by field (W-R7), so it cannot merge without a session verdict |
| A change of purpose, scope, money, Batu's accounts or acceptance of results | Batu (Appendix E) | candidate item plus a `D-nnn` decision record in Batu's batch |
| Retiring an item no longer needed | the same owner as its admission; for an item already admitted, the change is class high (W-R7), because dropping admitted work removes an acceptance it carried | `admission: declined` or `execution: cancelled`, with a retirement line |

## 6. Composition

All children accepted does not make the parent done (`BATU_LIVING_PLAN_TR.md`; K-5's design, working and delivered states). A parent item carries its own `composition` acceptance condition, written before its children start, saying what the composed result must show beyond the children's results. It sits inside the item's acceptance block, so changing it is class high (W-R7; R-W12-2 m-3). For W-C00-12 itself, the composition condition is acceptance (d)'s outside review "of purpose and robustness, not only the diff".

## 7. Zoom

The generated work view in the state file shows (`BATU_LIVING_PLAN_TR.md`, horizontal and vertical views):
- **horizontal:** every stage from C00 to C12 as one line (purpose, state, and a count of items by state), so the whole installation is always visible;
- **vertical:** the active branch expanded to its leaves, with each item's state, readiness reason and open notes; siblings of the active path one line each; everything else collapsed with counts.

An item is split into children only when work on it starts.

## 8. Open notes on branches

A discovery about other work is written where it will be needed (M-R3). **Migration:** each OI-011 item becomes one of three things (`08_oi011_dispositions.md`, acceptance (b)):
- a note on a W-C00-12 child;
- a note on a later stage's item;
- a closed note carrying its disposition.

## 9. Task context: every task carries its place

Acceptance (a2) and (k) require that every task given to a builder role carries its goal, parent, siblings, downstream effect and purpose chain. `tools/records.py brief <ID> --role <role>` generates the header of every such task:
- the purpose chain (SOUL → DevOS → installation → stage → parent → item);
- the item's acceptance block and scope;
- its siblings with their states;
- its downstream items;
- its `assumes` list with statuses;
- the role file (piece 3).

The builder writes only the task-specific part below the header.

**Run brief** (R-W12-2 M-3). A run is not item-scoped: it selects its item after boot. `tools/records.py brief run --role producer` prints the purpose chain down to the active stage, that stage's acceptance block, the generated frontier's ready and running lists with the not-ready items counted, not copied (their first unmet conditions stay in the state file's section 2, which the run reads at boot step 2; FR-02 item 2, so that the R1 goal plus this brief fits `/goal`'s 4,000 characters), and the producer's boot order (the producer has no separate role file, `04_roles.md` §3); its gate line is `Task-Brief: run producer <hash>`. Every run start uses it: the S4 successor (C-R10) and a run that Batu's conversation session starts (R-R17).

**Verifier brief** (R-R3a; R-W12-2 M-6). `brief <ID> --role verifier` refuses to generate without a `target_sha` and a non-empty `failure_classes` list, and prints the claims to test, the failure classes and the SHA in the header.

## 10. Discovery is work

Finding the work is itself admitted work (`BATU_WORK_DISCOVERY_TR.md`; plan K-1). Each stage's first item is a discovery item whose output is the stage's children, needs and candidates. It follows K-1's stop rule: proceed when the remaining uncertainty does not materially change the current authorised action. Budget or context running out is not readiness.

## 11. Rules

Status and tranche as in piece 1 §7. Every active rule has a test in `11_test_register.md`.

| ID | Rule | Status | Tranche | Scope | Test |
|---|---|---|---|---|---|
| W-R1 | **No producer acceptance.** `check_records.py work` fails if `acceptance: accepted` and any of these holds: `accepted_by` names the producer session or is empty; it names neither a verdict file bound by M-R16 nor a deterministic evidence file; it cites a test whose register status is `retired` (the L-033 case of T-H1); or the acceptance record lacks its independence label (the item's `acceptance_label` field: `deterministic`, `subagent`, `session`, or `audit-environment` from C03; BP-07; formerly R-R2, retired and merged into this rule). A **deterministic evidence file** must name the command (a script under `tools/` or `plan/builder/w-c00-12/`) and the commit it ran on, and the work check re-runs that command on that commit and compares the result line; a file the producer wrote by hand cannot pass (critic finding 8). The command's file at that commit must also either have been merged before the item's `execution` became `running` (pre-registered), or have its **last change** in a PR whose bound session verdict covers that PR's head, so a later unrelated verdict cannot launder it (R-W12-2 B-1 c; critic of 13, finding 8); otherwise the producer could write the check and the acceptance together. **Binding (tranche 1b-ii, after its Critic, finding 1):** a verdict accepts only its own item. It must name the item's ID and a reviewed commit at or after the commit where the item became `running`, and that commit must be an ancestor of `HEAD`. The item must be `finished`, and one verdict file accepts one item, except a parent's composition verdict. A deterministic command is `python3` or `bash`, then a script, then its arguments, with no shell metacharacters. In tranche 1 a `subagent` label cannot accept, because nothing binds a subagent's verdict. | active | 1 | installation | T-W1, T-R11 |
| W-R2 | **The Next action row is the generated frontier.** The row becomes a generated block listing the ready items, the running items with their claimant, and, for the rest, the first unmet condition. Selection follows §3. | active | 1 | installation | T-W2 |
| W-R3 | **Candidates stay apart.** A candidate appears in the zoom view marked as a candidate and never in the frontier. | active | 1 | installation | T-W5 |
| W-R4 | **Composition check.** The work check fails if a parent is accepted without a `composition` evidence record (the item's `composition_by` field, a verdict file; the composition condition itself is read only from the acceptance block, R-W12-3 F-5), or while any child is not accepted, cancelled or declined. | active | 1 | installation | T-W4 |
| W-R5 | **Generated task brief** (§9), including the run brief and the verifier brief's required fields. | active | 1 | installation; DevOS's `ContextPackage` at C04 | T-W6, T-R3, T-R22 |
| W-R6 | **Brief gate on `create_session`** (hook rule H-BRF). The allow-list hook requires the first message to contain a line `Task-Brief: <ID> <role> <hash>`, where `<ID>` is a work item ID or `run` (§9); a `run` brief is allowed only from the session the Run lock row on `main` names while that lease is live, or from any session once the lease is released or expired (since tranche 1c, N-057: no fixed session ID; the state is read as `records.py` `lease_state()` reads it; T-H4 N-057 (n1) to (n7)), so a run brief is not a universal pass for other roles while a run holds the lease (critic of 13, finding 9); whose hash matches `records.py brief <ID> --role <role>` on the source revision, which is fetched as for the existing revision check. In-process subagents are not gated, because the hook sees only the `Agent` input; for them the brief is instructed and T-R5 tests it. This is a hook change: high impact, with its own session review in tranche 1c. | active | 1 | installation | T-W6 |
| W-R7 | **Impact class by path and by record field** (R-W12-1 B2). `check_records.py impact` computes a PR's class from its diff. The class is **high** if the diff touches any of: `.claude/**`, except a diff to `.claude/hooks/owned_ids.txt` that only appends lines of the recorder's ID form (the recorder's own output; otherwise every S4 successor and every armed wake would need a session verdict, and the verdict for a Verifier's creation would need another Verifier; critic of 13, finding 2); `.gitattributes`; `CLAUDE.md`; `.github/workflows/**`; `tools/**` and `plan/builder/**/*.py` (every script, so a check the producer writes or edits is reviewed before it can accept anything, R-W12-2 B-1 c); the **governing builder documents**, defined as `plan/Builder_Operating_Model.md`, `plan/builder/REVIEW_PROMPT.md`, `plan/builder/mechanisms.md` and the pieces it promotes (`12_tranche_plan.md` §2, 1c), `plan/builder/MEMORY_MAP.md`, `plan/builder/heritage/FAILURE_PATTERNS.md` and `plan/builder/roles/*`; the floor files imported into every session, `plan/Ek_A_Rol_Sozlesmeleri.md` and `plan/Ek_D_Dusunme_Protokolleri.md`; a Governing-documents row or the Stage row of `plan/ledger.md`; in an existing item's front matter, a modified or deleted `depends_on` or `waits_for` entry, an added `on: finished`, a stage record's `hold_until`, a changed `parent` or `kind` (they decide which children W-R4 checks and which stage hold applies; added in 1b-ii after R-W12-5, planted case T-W9 (y)); or a change of `admission` other than `candidate` → `admitted` or `candidate` → `declined` on a technical candidate whose file has never carried a `waits_for` entry (checked in its git history; R-W12-2 B-1 b and critic of 13, finding 7: these lift readiness gates, and a candidate that once waited on Batu is his to admit, with the admitted state matching his decision record); or an **existing** acceptance block, meaning a modified or deleted line between `<!-- acceptance -->` and `<!-- /acceptance -->` in `plan/work/<ID>.md`; or, in an existing item that is the target of a `hold_until` or of any `depends_on` edge, a change of `acceptance`, `accepted_by` or `composition_by`, unless, at the PR head, the item is `accepted` with a session label, the work check (W-R1, W-R4, R-R3, W-R9; `tools/check_records.py` `item_work_problems()`) passes on the head's tree for the item **and for every descendant at any depth** (since tranche 1c, R-W12-6 B-1 and 1c Critic finding 5), and every verdict the item names is bound by M-R16 (b) to a review session outside the PR (N-049; R-W12-4 B-1, R-W12-5 B-1, R-W12-6 B-1; planted cases T-W9 (t) to (z3), control (w), and T-M15 (b3), (e3), (e4)). This is the path's one invariant, under the threat model of `plan/decisions/FR-01.md` (honest error, not forgery): a hole reachable by honest error is fixed in that one work check, not beside it. W-R4's composition verdict carries the line `**Composition of:** <ID>` (since tranche 1c). Residual, stated: a producer can write a commit whose trailer names any owned session, and can append an invented session ID to `owned_ids.txt` in an earlier record PR, which is class normal; only the audit environment's credential closes this (C03, D-003). Adding the acceptance block of a newly admitted item is class normal, since admitting technical work is the builder's (§5); changing it afterwards is high. Otherwise the class is **normal**. **Exception, for break-glass:** a PR whose diff is exactly the inverse of the **executable-carrier part** of one named merge commit on `main` (that merge's changes to `.claude/**`, `.gitattributes`, `CLAUDE.md`, `tools/**` and `plan/builder/**/*.py`, with the base still holding the merge's result, so no later merge is rolled back; checked against `git revert --no-commit` of that commit in a scratch clone with hooks disabled, restricted to those paths) and touches nothing else is class normal, so a broken hook, checker or brief generator can be reverted without the session Verifier that it may be blocking (critic finding 9). Two kinds of path never qualify: `.github/workflows/**` (the detector's arrow rests on every workflow change being reviewed, M-1 b) and `tools/builder_check.sh` (it enforces the verdict after the fact; critic of 13, finding 4). The `break-glass: <merge SHA>` log line goes into a **separate record PR** merged right after the revert, so the revert itself stays an exact inverse (critic of 13, finding 3); the stop check fails at every stop after the revert until a session verdict on it exists (R-W12-2 B-1 a: verification after the fact, not none). A revert that also touches anything else is classified like any other diff. A high PR needs a session verdict bound to its head (M-R16) before it merges; the stop check fails on a merged high PR without one. | active | 1 | installation | T-W9, T-W10, T-W15, T-MAP5 |
| W-R8 | *Brake on prerequisites: a `depends_on` edge needs K-1's "which action would be wrong without it" answer.* | deferred | 2 | installation | T-W8 (trigger: an unnecessary prerequisite delays an item once) |
| W-R9 | **Staleness from status changes, including corrections** (§4). | active | 1 | installation | T-W3r |
| W-R10 | *Basis hashes at section-anchor level (D-18).* | deferred | W-C00-06 | installation | T-W11 (written when re-admitted) |
| W-R11 | **Probe before build** (D-27). An item with an `untested` platform entry is not ready, and the frontier names the probe to run. | active | 1 | installation | T-W12 |
| W-R12 | *Usage filter: at `allowed_warning` the frontier offers only light items (D-16).* | deferred | 2 | installation | T-W13 (trigger: the first `allowed_warning` reading) |
| W-R13 | *Decomposition depth check (D-41).* | deferred | 2 | installation | — (trigger: an item split far ahead of its work is found at closure) |
| W-R14 | *`relies_on:` in the start record, and the counter-design's T-05 and T-06 (D-40).* | deferred | 3 | installation | T-05, T-06 (adopted by ID when re-admitted) |
| W-R15 | **Zoom view** (§7), generated by the render. | active | 1 | installation | T-W7 |
| W-R16 | **Migration keeps acceptance text byte-identical** (R-W12-1 B2). Moving the work list from `plan/ledger.md` §2 into `plan/work/<ID>.md` must change no acceptance text. A test compares each moved acceptance block with its source cell, after normalising only the table-cell escaping, and the comparison is pasted into the migration PR. | active | 1 (one-off) | installation | T-W10 |

## 12. Scope and hand-over

| Mechanism | Scope | Replaced by | Trigger |
|---|---|---|---|
| Work item files, derived readiness, frontier, zoom (W-R1–W-R4, W-R9, W-R11, W-R15) | installation | Ek B Work, WorkStanding, Relation and the `ready` query (C02) | C02 ledger transfer |
| Task brief and brief gate (W-R5, W-R6) | installation; the pattern is DevOS's context package (K-6, C04) | `ContextPackage` and `DispatchReceipt` (Ek B §3.9) | C04 |
| Impact class (W-R7) | installation | the audit environment's routing of binding verdicts (C03) | C03 |
| Admission owners, candidates (§5) | DevOS (plan §14 and §6 already define plan-change ownership) | decision records in the database | C02 |

## 13. Decision-and-basis record

- **Consulted:** plan K-1 and K-5 (status: Turkish plan, DevOS scope) for the need record, the prerequisite brake, the stop rule and the assembly states; Ek B §1 item 6 and §3.2–3.4 for the axes, three-valued readiness and relation types; Batu's Original texts `BATU_LIVING_PLAN_TR.md`, `BATU_WORK_DISCOVERY_TR.md` and `BATU_NOVEL_ANALOGY_TR.md`; library `beads/FINDINGS.md` §§2–5 (status: bounded-complete) for derived readiness, `discovered-from`, the parent-child livelock, and defer-until as a hard gate on readiness, which is the model for `platform: untested`; `recursive-prerequisite-discovery/ASSESSMENT.md` §2 (status: bounded assessment) for ready versus completed; the counter-design §4.1 and §4.6 (R-W12-1 m2); for revision 3, R-W12-1 B2 and M3, and the K3 re-read of L-016 to L-041 (acceptance changes by the producer, §1).
- **Left out on purpose:** beads' atomic claim and lease (one writer at a time under the run lease; revisit if parallel runs are allowed); a separate planning tool or connector (OI-011 item 18: its fields are adopted as ideas; a second store would be a second source of truth); priority scoring formulas (the selection stays a recorded judgement).
- **Premises, from scratch:** an acceptance change is detectable from the diff (yes, once acceptance blocks are delimited in the item files; no, while they sit in one table cell of a file that every lease PR edits, which is why B2 failed and why the migration comes first in tranche 1b); readiness can be derived (yes, from fields that already exist).
- **Alternative frames:** (a) the counter-design's "CI writes `accepted`": not available until required checks exist (F-1), so the run writes and a check validates; (b) staleness by basis hashes (D-18): correct in kind, but premature before W-C00-06 (M3).
- **Reopen if:** a high-impact change merges with class normal (the field list is incomplete); an item is accepted while stale; an `on: finished` edge hides a defect that its upstream acceptance later finds.
