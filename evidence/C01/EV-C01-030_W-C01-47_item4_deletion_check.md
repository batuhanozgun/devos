# EV-C01-030 · W-C01-47 item 4: the check of the deletion, as the item reads since #269 (2026-10-12)

**What this is.** The record of W-C01-47 item 4 ("Check of the deletion"), in the text that pull request #269 merged (L-275, L-276; judged by CHK-C01-110). Written by the executor of the working session `session_01XyxvJd3RayQk4HCrjurbVH` (L-277). The system cannot list the account's routines or sessions (guard rule S1), so this record rests on Batu's report and on the repository's branches.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `b7897d54082c9640bde2d7cefb38eb0713ea14c3` when listed |
| Deployment configuration | The working session's live tree and its git remote `origin` (`batuhanozgun/devos`); the GitHub tools of the working session for issue #6 |
| Criterion version | W-C01-47's acceptance block at `b7897d5` (SHA-256 `536f1ba955d2d7828a6bdad189b6392d6f2ebce6be221e3edeef93740321c3d7` of the text from `<!-- acceptance -->` to `<!-- /acceptance -->`), item 4 |
| Input | `git ls-remote --heads origin` at 2026-10-12T11:48:48Z (174 branches; raw: `evidence/C01/raw/W-C01-47_item4_branch_listing_20261012T1148Z.txt`); the same heads fetched into the scratch clone at about 11:48Z, with each head's commit date (`git for-each-ref`); issue #6's comments read at about 11:46Z (the last one `6120677086`); the guard's decision log of the working session; the container's process start time (`ps -o lstart= -p 1`) |
| Actual observation | Sections 1 to 5 |
| Raw evidence ID | The raw listing above; issue #6 comments `6120564296` and `6120677086`; the nine probe branches' heads in section 2 |
| Independence level | The executor's own reading, same session; a fresh-context checker judges it with W-C01-47's accepting check (declared, Ek A 5.3) |

## 1. Batu's report (reported by Batu, not observed)

- **When and what.** Issue #6 comment `6120677086`, 2026-10-12T08:35:04Z, by `batuhanozgun`: "rutin ve satır silindi" ("the routine and the line are deleted"); he said the same in the working session at about 08:36Z (L-269). It answers comment `6120564296` (08:27:11Z), which gave him steps 25 to 37 of `evidence/C01/routine/ROUTINE_DESIGN.md`. Both deletions, the routine `devos-c01-rutin` and the line `DEVOS_ENVIRONMENT=devos-kurulum` of `devos-kurulum`, rest on this one report; each is "reported by Batu, not observed" (plan Section 8 item 14).
- **His own look.** Step 5 of those steps has him confirm on the routines page that the routine is no longer in the list, and step 11 that the line is no longer in the box. His report says he did the steps, so it carries his look at the platform's own screens: a first-hand observation by the account's owner, recorded as reported by him. It is the primary evidence of the deletion; the branch listing below is further, indirect evidence (W-C01-47, "Change of item 4", L-276).
- No later comment by him on issue #6 (read at about 11:46Z), and nothing in the working session, says otherwise.

## 2. The routine's last branch before his report

`claude/probe-c01-cs2-20261012T0808Z`, head `8d55d851bca0feb3c9533c9d88f2c4ea29e608ba`, committed 2026-10-12T08:13:15Z: CS2, started at 08:08:36Z by the schedule (inferred, not observed), closed at 08:12:58Z (EV-C01-028 section 2; EV-C01-022's addendum of 2026-10-12). No routine branch was created after it before his report: the listing of 08:15:03Z (EV-C01-022) and that of 08:46:10Z (N-191) show the same nine.

## 3. The branch listing for the record (2026-10-12T11:48:48Z)

**Probe branches.** The listing holds nine `claude/probe-c01-…` branches, the same nine names at the same heads as the listing of 08:15:03Z, before his report:

| Branch | Head | Head's commit date | Against 08:15:03Z |
|---|---|---|---|
| `claude/probe-c01-r1a-20261011T0808Z` | `67fcd98a8ec84f3a2269f4227cca6cdbbbc9b251` | 2026-10-11T08:13:55Z | same |
| `claude/probe-c01-r1b-20261011T0913Z` | `568cf6a1bf5ad96002bf41d0423ddd6edda7217f` | 2026-10-11T09:20:11Z | same |
| `claude/probe-c01-p1-20261011T1337Z` | `7fd90cae1c3cd8b3a27b4d85ebe681d369a34662` | 2026-10-11T13:45:35Z | same |
| `claude/probe-c01-p2-20261011T1354Z` | `be9bac74d8f30e7c0210ea974cad931572eee55d` | 2026-10-11T13:58:51Z | same |
| `claude/probe-c01-p3-20261011T1420Z` | `38733f3b46c88aa86466e6954581f434b4d39dcb` | 2026-10-11T14:23:49Z | same |
| `claude/probe-c01-p3-20261011T1448Z` | `e971713ba0c53c76058d5724b7e56699d261bf06` | 2026-10-11T14:53:27Z | same |
| `claude/probe-c01-p4-20261011T1914Z` | `b44f88145c24afe3d2608d4bcfd3fccf2c0ff1c7` | 2026-10-11T19:22:25Z | same |
| `claude/probe-c01-cs1-20261012T0604Z` | `c2240846ccea2cc9587cc3547ee388c05fd771f3` | 2026-10-12T06:09:12Z | same |
| `claude/probe-c01-cs2-20261012T0808Z` | `8d55d851bca0feb3c9533c9d88f2c4ea29e608ba` | 2026-10-12T08:13:15Z | same |

So no `claude/probe-c01-…` branch was created after his report (no new name) and none received a commit after it (every head unchanged, the newest committed at 08:13:15Z).

**Outside `claude/`.** One branch: `main`. No branch outside `claude/` that row 8's push attempt (W-C01-15) or any other run of the routine created remains.

**Every branch's newest commit.** Fetched with every head (pruned to the 174 listed) and sorted by commit date: after 08:13:15Z only `main` and the working session's branch `claude/affectionate-bardeen-8aw91a` moved, both to the executor's merge `b7897d5` of pull request #269. No other branch received a commit after his report.

**What this listing covers.** The routine runs once a day at about 08:07Z (EV-C01-022, "daily 08:07Z"; `plan/work/C01.md`, Batu's step 1b). His report came at 08:35:04Z, so no scheduled time falls between it and this listing; the next is 2026-10-13 at about 08:07Z. The listing therefore shows only that nothing ran by Run now or otherwise after his report; it is not, by itself, an observation of the deletion. Note N-202 on `plan/work/C02.md` lists the branches again at or after 2026-10-13T08:40Z, after one full period of the routine's schedule, and reopens this item and C01's acceptance if a probe branch was created or received a commit after his report (W-C01-47 item 4; CHK-C01-110).

## 4. `DEVOS_ENVIRONMENT` in a session started after his report

No session is known to have started in `devos-kurulum` after his report, so the observation is not made here; N-202 carries it (a session that starts in `devos-kurulum` before its listing records whether `DEVOS_ENVIRONMENT` is set).
- The working session's container started at 2026-10-12T05:39:26Z (`ps -o lstart= -p 1`), before his report, so its environment was set before the line was removed and says nothing about the removal.
- The executor started no session: the guard's decision log of the working session holds no `create_session`, `send_message` or `fire_trigger` call.
- No routine run started: section 3.
- Batu reported none.

## 5. What C01 did not build

- **No probe environment.** PC-21 item 1 (FR-05; `plan/decisions/PC-21.md`, "Probe setup") replaced the two probe environments of the probe design (`devos-probe-a`, `devos-probe-b`) and the probe schema with one ordinary routine in the installation's own environment `devos-kurulum`; W-C01-05 (the probe setup in place) was cancelled (W-C01-31). Batu's steps in `plan/work/C01.md` ask him to create no environment (creating the two probe environments is listed there as no longer asked), and the only change he made to an environment for C01 is the line `DEVOS_ENVIRONMENT=devos-kurulum` in `devos-kurulum`, now removed (section 1).
- **No probe routine other than `devos-c01-rutin`.** PC-21 item 1 names one routine; Batu's steps in `plan/work/C01.md` ask him to create and delete only `devos-c01-rutin`; every `claude/probe-c01-…` branch is a run of that routine, counted in EV-C01-022 (N-191). The account's routine list cannot be read by the system (guard rule S1), so "no other" rests on these records and on Batu's steps, not on a listing.
- **No probe-only guard rule.** W-C01-04 (the probe-only guard rule) was cancelled (W-C01-31); the guard's rules are all general, and `plan/Installation_Working_Order.md` section 10 names no probe-only rule as in force (EV-C01-028a section 1; CHK-C01-106 findings 3 and 4).

## 6. Result

Item 4's clauses, as the item reads since #269:

| Clause | Where |
|---|---|
| The time of Batu's report, each deletion "reported by Batu, not observed" | section 1 |
| The routine's last branch before it, with its date | section 2 |
| From a listing made for the record: no probe branch created or committed after his report; no branch outside `claude/` from a run remains | section 3 |
| A note on the next stage's file that lists again after one full period and reopens this item and C01's acceptance | N-202 on `plan/work/C02.md` (merged with #269) |
| `DEVOS_ENVIRONMENT` in a session started after his report, if one starts before this check | section 4: none started; carried by N-202 |
| What C01 did not build, with what each statement rests on | section 5 |

Under plan Section 8 item 14 the deletion is "reported by Batu, not observed" until N-202's listing, and is never counted as observed before it.
