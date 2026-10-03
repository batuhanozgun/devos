# W-C00-12 · 00 · Consolidation of the acceptance conditions

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only; it concerns how the W-C00-12 acceptance is organised, not DevOS. **Written:** 2026-10-03 by run `session_0143r88Vc9e5RbsQmqjYWgwa`. **Authoritative acceptance text:** the W-C00-12 row of `plan/ledger.md` §2. This file does not restate it; it groups it.

**Why.** Conditions (a) to (m) grew one input at a time, always by addition (RUN_BRIEF §2 step 2; principle 18; failure pattern 9). Read item by item, they invite the W-C00-05 failure: each condition met on its own and the whole still weak. This file groups them by the design object they constrain, so that the design is built around a few objects and every condition is checked inside the object it belongs to.

**Rule kept.** Nothing is dropped or weakened (ledger rule 3). Every clause of the row maps to exactly one home below; the mapping table at the end is the check. A merge only changes where a clause is satisfied, never what it requires. Proposals that would loosen anything are listed separately for the independent review and are not applied.

## The six design objects

| Object | What it is | Conditions it carries |
|---|---|---|
| **O1 · Goal-down analysis** | What each stage C00 to C12 needs from the builder's environment; critical uncertainties; the order of design pieces | (a) first sentence and its revision (piece by piece, foundational first, re-plan on new information) |
| **O2 · Work model** | How the builder's work is represented and moved: states, dependencies, assumptions, staleness, zoom, open notes, composition, plan-change candidates, task context, the startable frontier | (a2) in full, with both 2026-10-03 extensions |
| **O3 · Role system** | Which roles exist, why (work demand), their terminal goals, who accepts what, how each role is formed as an environment, how depth scales | (g) role-and-goal map, demand trace, no self-acceptance; (i) proportionality and triage; (j) role environments and failure patterns at boot; (k) common floor by reference, purpose chain, planted out-of-specialty test, stamina mechanism and test, heritage, discipline triggers beyond work items, heritage for started sessions, Actor A versus B test |
| **O4 · Memory** | Where each fact lives, how changes are typed, how restatements stay true, how a fresh actor reaches and uses what matters | (l) in full, with its tightening (use, not only retrieval; root chain with a check) |
| **O5 · Mechanism map** | The working system as a program: components, base steps, helpers and triggers, typed arrows, coverage by cross-cutting mechanisms, failures located on it | (m) in full, with its extension (coverage rows) |
| **O6 · Assurance and hand-back** | How the design is checked and accepted, and what reaches Batu | (b) OI-011 dispositions; (c) scope of every rule; (d) counter-design and independent review; (e) pre-registered tests; (f) Turkish briefing; (h) decision-and-basis records |

## Proposed merges (no requirement lost)

1. **The role map of (g) is a layer of the mechanism map of (m).** Roles are components on the map; their terminal goals and acceptance edges are typed arrows. One artefact, two views. Every (g) clause is still checked, on the map.
2. **The root chain of (l) is a set of arrows on the map of (m).** "Every authoritative record reachable from the always-loaded root through a stated chain" becomes: every authoritative record is a node with an inbound path from the root node, and the chain check is a check of those arrows. The (l) check remains its own deterministic test.
3. **"Sessions see the known failure patterns at boot" (j) and "heritage" (k) are one mechanism.** Failure patterns are one kind of heritage (lenses, failure modes, questions). One formation mechanism carries both; each clause keeps its own test.
4. **(h) context-discovery records and OI-011 item 14 ("decision and basis") are one record format.** Every major design decision gets one decision-and-basis record: what was consulted, with status; what was deliberately left out; why it fits; how it is tested.
5. **All tests named across (e), (k), (l) and (m) go into one pre-registered test register** with one row per claim, so that no mechanism is accepted on a test that another condition required to be separate. The distinct tests (planted out-of-specialty problem; stamina; status-contradiction catch; fresh-session use test; Actor A versus B; root-chain check) each stay their own row.
6. **(c) scope labels are a column on every rule and every map component**, not a separate document.

## Not proposed

- No clause is proposed for removal. In particular the counter-design (d), the stamina test (k) and the fresh-session use test (l) are expensive, and stay: each guards against a failure already observed (patterns 1, 2 and 4 of RUN_BRIEF §5).

## Mapping check

Every clause of the W-C00-12 row, in its order, with its home. A reviewer can tick this table against the row.

| Clause (row order) | Home |
|---|---|
| (a) goal-down look C00 to C12, needs per stage, critical uncertainties, recorded before any design change | O1 |
| (a) revision: not a complete plan first; piece by piece, foundational and least volatile first; re-plan on new information | O1 (order of pieces), O2 (re-planning is a work-model operation) |
| (a2) living work list: dependencies, assumptions, staleness | O2 |
| (a2) zoom; open notes on branches; OI-011 later-stage items moved or linked | O2 |
| (a2) parent done only after explicit composition check | O2 |
| (a2) plan changes as candidates with reason, decided by the plan's owner | O2 |
| (a2) every task to a builder role carries goal, parent, siblings, downstream effect | O2 (task format), O3 (role intake) |
| (a2) separates finished from accepted, discovered from admitted; Next action row becomes the startable list | O2 |
| (b) every OI-011 input addressed inside the one design, each with a disposition | O6 |
| (c) scope of every rule stated, and its file | O6 (column on rules and components) |
| (d) independent review from outside (purpose and robustness) PASSES | O6 |
| (d) before it, an independent counter-design by a clean session; every difference closed with a reason | O6 |
| (e) every changed mechanism has a pre-registered test that passes | O6 (test register) |
| (f) one short Turkish briefing; decisions only where they are Batu's | O6 |
| (g) role-and-goal map: per work type, terminal goals and which may share a role | O3, drawn on O5 |
| (g) no item accepted by its own producer; acceptance by a separate role or a deterministic check | O3 |
| (g) every builder role, including dispatcher and heartbeat, traced to demonstrated work demand, or removed | O3 |
| (h) context-discovery step and record of consulted and left-out sources, with status, per major decision | O6 (decision-and-basis records) |
| (i) proportionality; small-or-not and expertise needed decided by a short triage from the expertise's view, not by the producer | O3 |
| (j) each builder role defined with its environment (purpose, sources, methods, known failure patterns); sessions see failure patterns at boot | O3 |
| (k) common floor of Ek A §2 and Ek D §2 by reference, not copied | O3 |
| (k) every task to such a role carries the purpose chain | O3 with O2 task format |
| (k) each such role has a pre-registered planted out-of-specialty test: notice and report without taking over | O3, test in O6 register |
| (k) a mechanism against quality loss within a long session, with its own pre-registered test | O3, test in O6 register |
| (k) extension: D1 to D9 and failure patterns carried as heritage | O3 |
| (k) extension: discipline trigger covers proposals and conversation, not only work items | O3, trigger drawn on O5 |
| (k) extension: sessions the builder starts are formed with the same heritage | O3, coverage row on O5 |
| (k) extension: Actor A versus B test passes | O3, test in O6 register |
| (l) one authoritative home per fact; others point to it | O4 |
| (l) kept restatements (`DURUM.md`) compared mechanically with their source | O4 |
| (l) changes to authoritative records state their kind and what they supersede | O4 |
| (l) a pre-registered check that would have caught the operating-model status contradiction of 2026-10-02 | O4, test in O6 register |
| (l) a fresh session run by a separate role recovers state, open items, reasons with status | O4, test in O6 register |
| (l) tightening: the fresh-session test checks use, including a decision whose condition matters for the task | O4, test in O6 register |
| (l) tightening: every authoritative record reachable from the always-loaded root, with a chain check | O4, arrows on O5 |
| (m) mechanism map: base steps and helpers, typed arrows, every helper's trigger | O5 |
| (m) every failure L-016 to L-034 and OI-011 items 22 and 24 located as a missing arrow or trigger | O5 |
| (m) every instructed arrow on a critical path tested or made mechanical | O5, tests in O6 register |
| (m) the map authoritative or mechanically checked against what runs | O5 |
| (m) extension: every component shows coverage by cross-cutting mechanisms; an uncovered row blocks acceptance | O5 |
