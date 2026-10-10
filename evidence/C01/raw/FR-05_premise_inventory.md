*Filed verbatim from the researcher's final report (premise inventory for FR-05; fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH, 2026-10-10; read only; taken with tools/subagent_audit.py last; DISCIPLINES OK).*

# Premise inventory for FR-05: is each part of DevOS's security scope required, or more than the need?

## Disciplines (D1–D9)
D1: yes: I listed each part's premises and set up the strongest alternative framing, which is to close a channel rather than guard it, and I note which premises the conclusion depends on.
D2: yes: I treated Batu's working hypothesis (L-178) and the cost of the host's content review (D-017) as pressures, not evidence, and weighed each premise only against the criteria and decisions.
D3: yes: I stayed at the level of need, aimed at the decision FR-05 serves, which is the scope of W-C01-03.
D4: yes: I kept "verified by dated documentation" (0.3 item 12) apart from "observed", and I flag where a documented guarantee is undated or contradicted.
D5: yes: I read the plan text, the decision front matter and the notes directly, not the task's summary of them, and I list below what I did not read.
D6: no
D7: no
D8: yes: before reading I confirmed that the working tree equals `origin/main` (`3e5a4d8`).
D9: uncertain: the task forbids the library, so I only point to where it could bear (the "know your environment" research named in D-017 item 1, ingested from C04) without reading it.

**Question.** Is each of the three parts required by plan criteria or Batu's decisions, or is it more than the need? This feeds FR-05, which sets W-C01-03's scope (`plan/ledger/C01-log.md` L-178).

Labels: [S] the source states it, [I] my interpretation, [Inf] my inference. Unless a file is named, references are to `plan/DevOS_Kurulum_Plani.md`.

## Part A: active verification of platform separation

| # | Premise | Origin | Valid today? | From scratch? |
|---|---|---|---|---|
| A1 | Platform facts must be *observed* in Batu's real account before the costly build | C01 Purpose; 0.3 item 8 (Batu) | Yes [S] | Uncertain: 0.3 item 12 (also Batu's) already counts current, dated official documentation as "verified", so observation is needed only where such documentation is missing or contradicted [I] |
| A2 | Separation between environments is what makes independent audit and hidden exams enforceable | 6.7 bullet 3 (PC-05, a Batu decision); row 3's fail path names criteria 8 and 30; row 17's fail path: otherwise separation "rests on the guard hook alone", and the frame is reviewed | Yes | Yes for the property itself; how it is shown is the open point |
| A3 | The session cannot read its own environment token (row 3) | K-9 item 2; criterion 26 as PC-08 reads it | Unverified | Uncertain: row 3's own fail path already accepts this visibility as a recorded residual, as long as no session can reach another environment's token. So only the cross-environment part decides anything [I] |
| A4 | The credentials the platform places in each session stay inside it (N-109) | PC-18 (technical) under C00's sixth condition; that residual was accepted under D-003 | Not shown. PC-18 calls the platform documentation undated and says internal texts point the other way | Yes: for this item, the 2(c) route has no clean, dated guarantee to cite [I] |
| A5 | Which credential the session's git path uses (row 12) | 6.7 rows; B3 (a) safeguard 3; D-014's reopen_if | Unverified | Yes: D-014 and the C04 removal step depend on it [S] |
| A6 | Routines have no connectors (row 2) | K-9 item 4 | Unverified | Uncertain: probably settled by documentation plus ordinary self-observation, D-017 2(a) [Inf] |
| A7 | A documented guarantee may stand in for a trial | D-017 2(c) (technical) | Valid, but D-017 item 3 says replacing a row's required observation is a scope change, made per row through a plan-change record with its own checker | — |

**Classification.** The probe setup P1–P3 is installation scaffolding by design: it is removed when C01 ends (probe setup; C01 Acceptance). The property it checks, separation between environments, is a DevOS product requirement (criteria 8 and 30; PC-05). Active trials of rows where dated official documentation states the guarantee go beyond criterion 17 and 0.3 item 12 [I]. Active checks where documentation is missing or contradicted (N-109, row 12, the cross-environment part of row 17) settle premises of Batu's decisions [I].

**Affected if Part A shrank to documentation only.**
- Criteria 8 and 30 stay as they are, but their evidence drops to "not independently tested". That is never counted as met (D-017 item 3; plan 8 item 14).
- N-109's "neither" result is not green, so C00's sixth condition stays unsettled (`plan/work/C01.md` N-109).
- Batu's decisions touched: PC-05, D-003 (its accepted residual assumes the credentials stay confined, per PC-18), D-014 (reopen_if names row 12), B3 (a) safeguard 3, and 0.3 item 8.
- C01 itself lists only criteria 17, 22, 23 and 25–27, not 8 or 30.
- **Net:** shrinking lowers the level of evidence, not the requirement. For N-109, row 12 and row 17 it would leave premises of Batu's decisions open.

## Part B: the installation's tool-call guard

| # | Premise | Origin | Valid today? | From scratch? |
|---|---|---|---|---|
| B1 | No auto mode; written rules decide every call, with a detailed reason that can be audited, and a log | D-008 (Batu), answers (1) and (3) | Yes (the L-178 opening check enforced it) | Yes: it is his requirement |
| B2 | In Accept edits no classifier runs, and an unattended session cannot answer a prompt | D-008 P4 (documentation read 2026-10-04); K-9 item 4 ("never asks"); criteria 21 and 22 | Yes, unless the platform has changed (due for re-reading, 0.3 item 12) | Yes |
| B3 | How the rules are built is technical work | D-008, "What it does not decide" | Yes | Means a different technical form could still meet D-008 [I] |
| B4 | Only dangers written as rules are stopped | D-008's stated cost (1) | Yes | Uncertain: this is what keeps the rule set growing (6.12 item 2) |
| B5 | The hook is the connector barrier, and the builder can edit it | D-003 (Batu), accepted until the audit environment exists (C02–C03) | Yes until C03 | Yes for phase A |
| B6 | Phase B carries a guard; authority comes from tokens and the database, not the hook | K-9 item 4, which is marked [Proposal] | Unverified (C01 #9, C03 test 3) | Uncertain: required where the guard is the only layer (Batu's other repositories under B3 (a), outbound URLs, connectors); elsewhere it is defence in depth [I] |
| B7 | A mechanism that does not make results worse when removed is removed | 6.12 item 4 | Yes | Yes: this is the test to apply to each rule family |

**Classification.** Mixed:
1. A decider that never asks, writes reasons and keeps a log is Batu's requirement in phase A (D-008). It is also a phase-B need for unattended sessions (criteria 21 and 22) [I].
2. The rules specific to the builder are scaffolding. D-008's reopen_if expects the audit environment to replace the hook as the barrier.
3. Rules that exist only because B3 (a) leaves a channel open are required for as long as B3 (a) stands [I].
4. Any rule that traces to neither a 6.7 channel row nor a Batu decision is candidate over-scope, to be tested under 6.12 item 4.

**Affected if Part B shrank to the platform's normal permission model.**
- D-008 directly: that model would undo his answer unless it gives detailed reasons and a log. Auto mode is an alternative he rejected.
- D-003 and D-009.
- Criterion 8, and criteria 3 and 20 (connectors and his other repositories).
- In phase A also K6 and D-014, because the interim leak check runs inside the guard. D-014's reopen_if says that if W-C00-14 is removed, "the attach waits".
- **Net:** removing the builder-specific rule families after C03 removes scaffolding; removing the decider lowers a Batu requirement.

## Part C: leak and credential checks

| # | Premise | Origin | Valid today? | From scratch? |
|---|---|---|---|---|
| C1 | `devos` is public, with the risk accepted "as reduced by code-based pre-checks" | K6 (Batu, 11.1) | Yes | Yes: the checks are the condition of his acceptance |
| C2 | No private library content goes into public repositories | Criterion 31; 0.5 item (1); K-9 item 6 (from K6 and K8) | Yes | Yes |
| C3 | The system, not the agent, enforces the rules | Criterion 8 | Yes | Yes: hygiene alone is a rule the agent enforces on itself [I] |
| C4 | An interim verbatim check runs until C04 | PC-07; W-C00-14 (accepted); D-014's reopen_if | Yes; it ends at C04 | Yes while the library is attached |
| C5 | Phase-B check with a verbatim and a semantic layer | K-9 item 5 and 6.7 ([Proposal]); C03 test 6; C04 task 5 | Not built | Verbatim layer: yes. Semantic layer: uncertain (U-6 is open), but Batu was told both layers exist (0.5, PC-07 note) |
| C6 | GitHub secret scanning is on | Criterion 27 (Batu) | Yes | Yes. It covers secrets, not library prose [Inf] |
| C7 | `credential_class.py` (C00 probe that classifies the session's own credential without its value) and `credential_value_scan.py` (finds where the session's credential values occur, never the values) | C00's sixth condition; PC-18 (purposes stated in the C00 records) | Built and used in C00 | Uncertain: one-off scaffolding [I] |
| C8 | `check_service_names.sh` | OI-012; D-013 (technical, declined) | Still an input to the guard | Uncertain: scaffolding tied to one past exposure |
| C9 | Key inventory: names, owner, location, permissions, revocation path; never values | Plan Section 12; N-105; C03's N-107 reads it | Yes | Yes: phase B has many keys, and revoking or restoring them (6.3, C09) needs the list [I] |

**Classification.** K6 together with criteria 8 and 31 makes a code-based check before public writes a DevOS product requirement (C03 criteria 8, 27, 30, 31; C04 criterion 31). The interim check is scaffolding that ends at C04. The credential tools and the service-name check are scaffolding whose main use is already behind it. The key inventory is a cheap, ordinary operational need.

**Affected if Part C shrank to hygiene plus platform features.** K6's stated condition would fall, and reopening K6 is Batu's call. Criteria 31 and 8 would be lowered, so this is not merely removing over-scope. D-014 would reopen. Criterion 27 is unaffected. Dropping the credential tools removes only scaffolding.

## Cross-cutting
- **Shared premise, criterion 8.** All three parts assume that a written rule the agent follows is not enough. Shrinking any part to hygiene alone conflicts with it.
- **Shared premise, B3 (a).** The machine account has write access to the library and access to Batu's other repositories. Part A row 12, Part B (the guard as the only layer) and Part C each guard those channels. The strongest alternative framing is to close the channel at account level, for example the organization option in 0.5's PC-07 note and D-014's reopen_if. That is Batu's decision [Inf].
- **Sunsets.** Scaffolding with a stated end (the probe setup at C01's end, D-003 at C02–C03, the interim check at C04) should not be counted as permanent scope. K-9 and the 6.7 inventory are [Proposal], so their phase-B detail is not Batu-required in itself.
- **0.3 items 12 and 13 are Batu's** (11.1; PC-11 note). Item 12 supports verifying by documentation. Item 13 requires a negative test for every channel, which limits how far C03 can shrink.
- **No wholesale substitution.** Under D-017 item 3, FR-05 cannot replace observations across the board; each row needs its own plan-change record and checker.
- **Cost is not evidence.** The host review makes this work expensive, but that does not show it is unneeded (D2).
- **The squeeze itself.** The added mechanisms (W-C00-14, PC-18, N-109, D-017) are the very signal 6.12 item 2 describes. The likeliest premises behind them are B3 (a) and D-008's cost (1) [Inf].

**For the decision.** The parts that look like over-scope are the active trials of rows that dated documentation can settle, the builder-specific guard rules after C03, and the spent credential tools. The core of each part traces to K6, D-008, D-003, PC-05 and criteria 8, 30 and 31. Shrinking that core lowers a requirement and goes to Batu.

## Open
- **Not read:** the guard's code and tests, the contents of `tools/*.py`, the L-019 entry behind D-003, the text of the C03 tests, and the platform documentation (no web).
- **Unverified as a result:** whether the platform's permission settings can give D-008's detailed reasons and log, and whether dated documentation exists for rows 2, 3, 12 and 17.
- **Stopped early:** I stopped reading working order section 10 once its bullets turned into rule detail.
- **D-003's scope:** D-003's own reopen_if flags its wording for confirmation with Batu.

## Guard denials
None.
