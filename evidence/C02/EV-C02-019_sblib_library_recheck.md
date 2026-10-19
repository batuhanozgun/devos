---
id: EV-C02-019
title: "SB-LIB part (5): C02's claim, expiry and identity decisions re-checked against the research library"
stage: C02
kind: research-report
source: "researcher agent a57782d9267ed9cd1 (2026-10-19), its final message, taken with tools/subagent_audit.py last; DISCIPLINES OK"
---

# EV-C02-019 · SB-LIB part (5): the re-check against the studies

Filed by the executor (L-422). The researcher's report follows verbatim, except three "Sources read" lines (in DM-01,
in the readiness finding and in the identity chain finding), where the report gave library file paths with line ranges;
the leak check's fingerprints matched those paths, so they are given here as identifiers naming the same studies and
sections (the original paths are in the researcher's message in the session). Its "proposed notes" PN-1 to PN-4 are
recorded as N-312, an annotation of N-214, annotations of N-279 and N-214, and N-313 (L-422). Within SB-LIB this part
produces records only; nothing here reopens a decision (L-420 C2).

**Question.** Do the studies change, limit or justify C02's decisions on claims, expiry and identity, which were made without the library? I tested each against the built functions as well as the design text. This serves SB-LIB part (5) (L-420 C2): the output is records only. Anything that would reopen a decision is a proposed note, taken through plan Section 14 after SB-LIB closes. W-C02-09's acceptance neither waits on this nor relies on it.

## Disciplines (D1–D9)
D1: yes: the studies' systems use named assignees in multi-agent swarms, while DevOS uses one bearer token per environment and few sessions, so I tested whether each finding applies before carrying it over; Beads' idempotent re-claim does not carry over as it stands.
D2: yes: the library-map hint expected "most likely justified", so I fixed the four test points before reading the code and kept the limits I found against that expectation.
D3: yes: the purpose is records, not reopening, so every finding that bears on a choice is a proposed note with an owner, a deadline and a route.
D4: yes: this is one reader's review with no test run and no independent check, so confidence is limited and stated per finding; facts come from the latest migration text, not the design records.
D5: yes: I treated the hint and the design records as views and went back to the migrations (the latest replacement of `claim` and `ready_value`, the acceptance write, `check_claim`, `caller_role_class`); records I read only in part are listed under Open.
D6: no
D7: no
D8: yes: I confirmed the clone at `941f027`, and that the live versions of `claim`, `ready_value` and `reopen_for_review` are the replacements in `20261019080001_w09_rule_corrections.sql`, not the M09-04/05 originals.
D9: yes: this whole task is library use; for each decision below I record whether a source justifies it, limits it or bears on nothing.

## Facts in DevOS used below (all [S], read from the files)
- **`claim`** (`supabase/migrations/20261019080001_w09_rule_corrections.sql:1358-1565`). It locks the work item, then its claims, then reads the epoch for share. A live claim is refused `already_claimed` whoever calls (:1492-1495). It then re-checks readiness (:1497-1508), marks lapsed or earlier-epoch claims `expired` (:1526-1534), and sets a 30-minute lease (:1536).
- **No repeat for `claim`.** `claim` has no exact repeat (`EV-C02-013_w09_interface.md:59`, :117; `20261018235501_w09_claims.sql:123-124`). The claim token is returned once and only its hash is kept (`20261018235501_w09_claims.sql:25-31`).
- **`ready_value`** (`rule_corrections.sql:77-190`). Execution `planned`, `ready` or `waiting` counts as claimable (:108-110). A hard dependency on a Work is true when `work.acceptance = 'accepted'`, which is a field of the Work's identity row, plus a check that the named revision exists (:141-146). It does not read the prerequisite's `qualification` or which revision was accepted. Readiness is computed on every read, never stored.
- **`reopen_for_review` and `mark_stale`** set only `qualification` on the item named (:1331; `20261018230001_w09_work_effort.sql:848`). `revise_work` does not touch `acceptance` (`rule_corrections.sql:520-927`).
- **Acceptance.** `record_acceptance` stores `target_revision` in the Acceptance row but sets `work.acceptance = 'accepted'` with no revision tie (`20261019030001_w09_knowledge_product_review.sql:1364-1378`). No function outside the transfer ever sets acceptance to `proposed` or `rejected` (grep of all migrations).
- **The effect re-check** (`prepare_operation`) re-checks readiness at the effect (`20261019180001_w09_transfer_corrections.sql:315-326`).
- **`check_claim`** checks status, lease, generation, epoch and `claim_class` (`20261018203001_w09_private_helpers.sql:153-200`). `caller_role_class` maps a token hash to a role class only (`20261017230001_w09_identity_chain_first_part.sql:84-170`).
- **Appendix B:** 3.3 says reopening sends work into a candidate review set and does not cancel it (`plan/Ek_B_Veri_Modeli.md:132-135`). 3.11 says a changed basis makes a verdict stale and a new acceptance is needed (:245). The deadlock scan's output is "a decision record for wait cycles" (:417).

## Findings per decision

**DM-01 Concurrency** (`EV-C02-002_data_model_choices.md:105-110`). Outcome: **justifies**. Confidence: medium-high.
- Sources read (library identifiers; filing note below): the beads study's findings §6; the flowable study's findings §2; the work-management-project-control study's cross-unit synthesis §8.
- [S] Beads claims inside one transaction: it re-reads, checks the item can be claimed, and does a compare-and-swap on a row version. A losing claimer gets a conflict, not a silent steal. Flowable's task claim is exclusive in the same way.
- [I] DevOS gets the same guarantee: a row lock, a re-check under the lock, a unique index as backstop, and `already_claimed` for the loser.
- [S] Beads can also pick a ready item and claim it in one step; DevOS cannot (`ready_works` and `claim` are separate calls). [Inf] At DevOS's write rate, a race costs one refused call, never a double claim, so this changes nothing.
- The confirming CONC test passes in the job runs (`EV-C02-014_w09_build.md:2982`).

**Point 1 of the task: is a same-actor re-claim idempotent, and does a loser get a conflict?**
- A loser gets a conflict: **yes** (`already_claimed`).
- A same-actor re-claim is idempotent: **no**, and on purpose. The database cannot tell one session of a class from another, because the session ID is only declared (B principle 8). A re-claim made idempotent per role class would hand one session's claim to another session, against B 3.5:160. So Beads' rule does not carry over as it stands [I].
- What is left is a **limit on DM-07**, below.

**DM-06 Expiry computed, no job** (`EV-C02-002:129-134`). Outcome: **justifies**; its one limit is already carried. Confidence: medium-high.
- Sources read: `beads/FINDINGS.md` §7 (:150-162) and META's "what should not be inferred" (:79-86); `gastown/FINDINGS.md` §2 (:18-37).
- [S] Beads separates the ownership record from a live holder, and warns that a lapsed lease shows nothing about whether the dead worker's effects happened.
- [I] DevOS treats a lapsed claim as no claim at every check, and refuses late effects by generation and epoch. This is stricter than Beads' explicit reclaim step.
- The warning about effects maps to the `effect` axis, which no function writes yet. That is already carried: N-298 (1) to C03 with N-279 (1). No new note.

**DM-07 Lease length and `heartbeat`** (`EV-C02-002:136-141`). Outcome: **limits**. Confidence: high on the facts, medium on how much it matters.
- Sources read: `beads/FINDINGS.md` §6-7; `gastown/FINDINGS.md` §2 and §10 (:163-173), where actor identity outlives one runtime session.
- [S] The plan handles lost answers for launches and merges (`plan/Ek_C_Testler.md:141` N24, :162 K07) but not for claims.
- [Inf] Suppose a claim commits but its answer (the token) is lost, through a timeout or a session cut off. Then no session can heartbeat it, release it or act under it, and the work item stays blocked until the lease lapses (up to 30 minutes) or `devos_denetim` revokes it. The same happens when a session dies holding its token. It fails safe; the cost is time.
- **Proposed note PN-2:** "`claim` has no exact repeat. A claim whose answer was lost after commit, or whose session ended, blocks its work item until its 30-minute lease lapses or `devos_denetim` revokes it, and the plan has no reconciliation rule for it as it has for launches (N24) and merges (K07). Decide, with a checker: a stated residual (bounded by the lease, fails safe), or a claim request key known only to the caller, so that a retry carrying that key is an exact repeat without opening the claim to other sessions of the class. Owner: the executor. Deadline: with N-214 item 2, before C06 fixes the liveness signal; the residual sentence added to EV-C02-002 DM-07 now, as a record. Route: an annotation on N-214; plan Section 14 only if B 3.5 changes."

**DM-08 Sample share** (`EV-C02-002:143-148`). Outcome: **bears on nothing** among the sources read. Confidence: medium. A term search of the studies found no audit-sampling-rate source; I did not read further.

**Readiness after a reopen** (EV-C02-013 2.4's readiness definition, the inputs DM-01 locks, and the transfer). Outcome: **limits**, possibly **changes**. Confidence: high on the facts, medium on whether it is a defect or intended.
- Sources read (identifiers): the beads study's findings §8; the openproject study's findings on reopen; the work-management-project-control study's cross-unit synthesis §7; the records-artifacts vertical's key file, on binding standing to an exact version.
- [S] Beads recomputes downstream blocked standing when a prerequisite reopens. [I] DevOS needs no recomputation, since readiness is computed on every read; that part is better than Beads.
- **Point 3 of the task: does a reopen recompute dependents' readiness? In effect, no.** The inputs `ready_value` reads never change on a reopen. `mark_stale`, `reopen_for_review` and `revise_work` on an accepted prerequisite leave its dependents ready and claimable. The readiness check at the effect behaves the same way.
- Two extra facts feed this. Transferred acceptances also make dependents ready (`transfer_corrections.sql:5156`). And if C03's sample re-review finds a transferred acceptance wrong, the database has no path to reverse it.
- [I] This sits uneasily with B:245 (a new acceptance is needed when the basis changes). The readiness definition was "chosen" without weighing qualification or revision (`EV-C02-013:110`).
- **Proposed note PN-1:** "A hard dependency on a Work counts as true when the Work's `acceptance` is `accepted`. Readiness reads neither the prerequisite's `qualification` nor whether an Acceptance names the revision the dependency names, and no function moves `acceptance` off `accepted`. So a stale, reopened or revised prerequisite leaves its dependents ready, against B 3.11 (B:245). Decide, with alternatives and a checker: (a) keep it, with its reason from B 3.3:134-135 and G section 1 item 1; (b) a dependency is true only when an Acceptance names the dependency's revision and `qualification` is `current`; (c) as (b) for dependents not yet claimed, with existing claims left to the candidate review set; and say how a reversed acceptance (for example after C03's re-review) is recorded. Owner: the executor. Deadline: before the ledger's hand-over (W-C02-14) if it is to govern the installation's own items, and at the latest C02's stage close (W-C02-18). Route: plan Section 14 (Appendix B 3.3 and 3.4, EV-C02-013 2.4), as its own plan step after SB-LIB closes; a migration of `ready_value` if (b) or (c)."

**Telling waiting apart from a stuck frontier** (DM-06, B section 5, N-279 (1)). Outcome: **limits**. Confidence: high on the facts.
- Sources read: `beads/FINDINGS.md` §10-11 (:206-228); `gastown/FINDINGS.md` §13 (:201-218); WMPC 08 §5 (:186-199).
- [S] Beads lists several meanings of "nothing ready" and says a system should tell them apart. Gas Town treats stranded work as its own liveness state. Beads' defer-until gates readiness.
- **Point 2 of the task: no diagnosis tells waiting apart from a stuck frontier.** `ready_works` returns only ready items, with no reason. Three cases look alike: an item waiting on an open prerequisite, an item whose prerequisite is in a terminal state that never satisfies it (a cancelled or rejected Work, a dropped or superseded Need, a declined Decision; `rule_corrections.sql:141-156`), and an item whose readiness is unknown (NULL). All three are simply absent.
- [S] `waiting` counts as claimable (:108-110), and no function writes `waiting` yet (N-279 (1)). [I] The deadlock scan targets wait cycles, which hard-dependency writes already refuse, so as written it would miss these cases.
- **Proposed note PN-3:** "(1) Decide with N-279 (1) what execution `waiting` means for readiness: claimable as now, or not ready until its condition holds. (2) Decide with the deadlock scan's activation whether its output covers dead dependencies (a prerequisite in a terminal, unsatisfying state), unknown readiness and ready work no one claims, or record why not. Owner: the executor. Deadline: (1) before C03's work list; (2) before C06 activates the deadlock scan (N-214). Route: annotations on N-279 and N-214; plan Section 14 if B section 5's row changes."

**Identity chain** (`EV-C02-003_identity_chain_and_environments.md`). Outcome: **justifies** on authority that depends on the relation; **limits** on transitive authority. Confidence: medium.
- Sources read (identifiers): the AI-native SDLC playbook study's DevOS assessment, DP-02 and DP-04; its falsifiers file, F8; its playbook research 13.3; the Actors ground's key file and its audit synthesis; the Work ground's key file; the composite-standing S1 signature.
- **Point 4, authority that depends on the relation: justifies.** [I] DevOS authority is not one level. It combines the role class, the target's Mission (Rule O), another class's claim (Rule C), a claim token per work item, the generation, the epoch, `claim_class` and the impact class (`EV-C02-003:272-294`, :324-326; `check_claim` above). The Actors anti-collapse rules (a token is information, not standing; authority is not effect power) match the decision to keep authority off declared session IDs.
- Watch-point, no note: `revoke_claim` lets `devos_denetim` revoke any claim regardless of relation (DM-29). This is a deliberate one-level grant.
- **Point 4, transitive authority: limits.** [S] Effective authority can run through a reachable actor (DP-02, F8). [S] The plan already covers session-to-session reach (`plan/DevOS_Kurulum_Plani.md:731`: S9's bridge denies messaging between sessions; C03 test 3, :1018), outside issues (test 4, N14) and agent-addressed text in sources (T-37). [I] But EV-C02-003 §15 (:1293-1315) lists only direct calls. One path is named nowhere: a record written by one class whose text asks a session of another class to act.
- **Proposed note PN-4:** "At C03's work list, decide whether test 3 or T-37's negative test covers a record written by one DevOS environment whose text asks a session of another environment (audit, exam) to act; if neither does, add that path to the effect channel inventory (plan 6.7) with its negative test. Owner: the executor. Deadline: C03's work list, before test 3 is written. Route: C03's work list; plan Section 14 only if 6.7's inventory gains a row."

**Transfer design** (`EV-C02-005_ledger_transfer.md`). Outcome: **justifies**. Confidence: medium.
- Sources read: `beads/FINDINGS.md` §7; `gastown/FINDINGS.md` §12 (:185-199); the Actors rules on attribution versus authority; records-artifacts KEY.
- [I] Three of its choices match the studies' distinctions:
  - It writes no Assignment from `claimed_by` (`EV-C02-005:110`): the ownership record is not taken for a live holder.
  - Copies keep their `devos_kurulum` origin and count as no audit verdict (`EV-C02-003:314-320`): recorded attribution is kept apart from the authority to accept.
  - It uses a source key and re-runnable runs: missed events can be repaired by re-deriving from durable state.
- Its one limit is PN-1: transferred acceptances drive readiness with no revision binding.

## Counter-evidence and alternatives
- Beads' persisted blocked flag needs recomputation precisely because it is stored. DevOS computes readiness on read, which is the stronger design; PN-1 is about which inputs it reads, not about staleness.
- B 3.3:134-135 and G section 1 item 1 can be read as intending that a changed prerequisite does not block its dependents. PN-1's option (a) keeps that, with a stated reason.
- The studies are pinned at 2026-09-17 and Beads' freshness risk is high. I used them as design pressure, not as current product behaviour, so I did not re-check upstream.

## Open (not read, and why)
- Read only in part, because of the turn budget: EV-C02-002 (sections 2.3 to 2.5 except DM-28/29, and section 15), EV-C02-003 (sections 2, 3, 5 to 14), EV-C02-005 (beyond the rows cited), EV-C02-013 (sections 3 to 28 except those cited), EV-C02-017 and EV-C02-018.
- Not run or read: the tests (T-W07-CONC and the others).
- Not opened in the library: the recursive-prerequisite-discovery, multi-agent-patterns and mattpocock-skills studies; the Work ground's FINDINGS-MAP; the Information ground nodes beyond the records-artifacts KEY; the old experiment repositories (N-212 item 8 names them).

## For the decision
Nothing here reopens DM-01, DM-06, DM-07, DM-08 or the identity chain inside SB-LIB. The findings justify DM-01, DM-06, the relational part of the identity chain and the transfer design. They limit DM-07 (PN-2), the readiness definition (PN-1), the stuck-frontier diagnosis (PN-3) and §15's coverage of transitive paths (PN-4). The four notes go through Section 14 after SB-LIB closes. PN-1 is the one that could change built behaviour. These results also answer, for these topics, the re-check that EV-C02-002 section 9 and N-212 item 8 carry; the remaining scope of N-212 item 8 (revision models, interface contracts, mutation testing, the old experiment repositories) is not covered here.

## Guard denials
None.
