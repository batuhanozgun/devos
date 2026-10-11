# EV-C01-013 · W-C01-22: row 15, library transfer, moved to C04 (2026-10-11)

**What this is.** The record W-C01-22 asks for: plan C01 row 15's result in C01, which is "moved". Row 15 is not observed in C01, because its job and its key do not exist before C04. This record states the move, the stage it goes to, and the work its fail path comes before, point by point against W-C01-22's acceptance block. Sources are cited as `file:line` at `main` `f957519`, read on 2026-10-11. "plan" is `plan/DevOS_Kurulum_Plani.md`.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `f957519e4afc5fc11241f7ea1b7b2dd350503527`, the commit this record's branch starts from; `plan/DevOS_Kurulum_Plani.md` blob `eb1ffa59fbde91808da635b2a4739549eac90614`. Row 15's text (plan:958) was last set by `0dc0d9d` (PC-11 place 33, 2026-10-05: "job records" became "job logs"), on the text PC-09 place 21 gave it (`b17899c`, 2026-10-05). C04 task 0 (plan:1018) was set by PC-09 (`b17899c`) and is unchanged since |
| Deployment configuration | Not applicable. Nothing was deployed or run for row 15 in C01: the job in `devos-backup` and the read-only key exist only from C04 (plan:958; plan:1222, Section 12 item 2) |
| Criterion version | W-C01-22's acceptance block (`plan/work/W-C01-22.md`:24-36, blob `627190ced9581dcc3a65d185c62bea96159005c7` at `f957519`). The block's text dates from `3becfca` (2026-10-06, W-C01-01) and is the same at `62f9e46` and `44cef4e`; the re-plan (W-C01-31, `44cef4e`) changed only `depends_on` and added its note. Read with plan C01 row 15 (plan:958), the rule for moved rows (plan:940), C04 task 0 (plan:1018) and the PC-21 note (plan:963-972) |
| Input | Not applicable: no probe, run or job |
| Actual observation | Not applicable: row 15 is not observed in C01. This record holds a reading of the plan text named above |
| Raw evidence ID | Not applicable: there is no raw evidence. The sources are the plan files at `f957519` |
| Independence level | The plan text was read by the executor's producer subagent, in the same session (the session's own reading). Judged by a fresh-context checker that did not produce it (same session, fresh-context subagent; declared, Ek A 5.3; PC-06). The checker shares with the producer the criterion (the block), the sources (the plan text) and the framing (row 15 as moved) (plan Section 8 item 7). No other rung is planned for this item |

## How the criterion is read

- The PC-21 note governs where it and a row differ (plan:963). Its items name rows 1, 2, 3, 4, 5, 9, 12, 13 and 17, and N-109 (plan:964-971). They do not name row 15, and row 15 never used the probe setup. So row 15 stands as written.
- The rule for moved rows: "A row whose components cannot be stood in for moves to the stage where they exist, and its fail path applies before the work that depends on it. The rows say so where it applies." (plan:940). Row 15 says so in its success cell (plan:958).
- C04 task 0 words the row's second part as "with no content in its records (C01 #15)" (plan:1018). The row says "no content ends up in the job logs" (plan:958); PC-11 place 33 chose "job logs" there for the Turkish "iş kayıtları" (TP-106), and left task 0's wording as PC-09 wrote it. Task 0 names the row, so the row's text is what C04 observes. Reading "its records" more widely than the logs would add to the row, never take from it. K-6 item 1 gives the condition's reason: "job logs in public repositories are visible to everyone" (plan:360).

## Point 1. Row 15's result is recorded under `evidence/C01/` as moved, with the envelope

This file. Row 15's result in C01: **moved**, as a whole, to C04 task 0. The envelope above fills the three fields the block names (the source commit, the criterion version, the independence level) and marks the other four not applicable.

## Point 2. The success condition and the fail path, verbatim

Success condition (plan:958, third cell; the same text as `plan/work/W-C01-22.md`:29):

> The job in `devos-backup` can read the library repositories with a read-only key; no content ends up in the job logs (moves to C04, where the key and the job exist, Section 12 item 2; observed before the ingestion jobs are built, C04 task 0)

Fail path (plan:958, fourth cell; the same text as `plan/work/W-C01-22.md`:33):

> The transfer method is redesigned

Both were compared with the plan's row, cell by cell, at `f957519`: equal.

## Point 3. The stage, C04, and the work the fail path comes before

- **Stage:** C04, "where the key and the job exist, Section 12 item 2" (plan:958). Section 12 item 2 is Batu's C04 step: "Creating a read-only GitHub key for the library transfer and entering it into the secret settings of `devos-backup`." (plan:1222).
- **Where the row is carried:** C04 task 0: "**Moved from C01** (rows 7 and 15; W-C00-10, T-15): before the ingestion jobs are built, [...] the library transfer job's read-only access with no content in its records (C01 #15) are observed, with the job in `devos-backup` and the read-only key (Section 12 item 2). A failed row changes the plan (Section 14) before task 1." (plan:1018).
- **The work the fail path comes before:** the ingestion jobs, C04 task 1: "Ingestion jobs: `agentic-os-search` continuously, the old experiment repositories once; [...]" (plan:1019). If row 15 fails at task 0, the transfer method is redesigned through plan Section 14 before task 1.
- **How C04 reaches it:** C04's work list reads the stage's plan text in full (`plan/Installation_Working_Order.md`:51), so task 0 carries the row without a note. C01's work list records the same move (`plan/work/C01.md`:117).

**Not needed earlier** (the question `plan/work/C01.md`:112 asks of every move). Nothing before C04 task 1 uses the job, the key or the transfer:
- the library read key is created at C04 (plan:1222); `plan/key_inventory.md`:44 lists it as "planned (created at C04; Section 12 item 2; C04 task 0)";
- the transfer job's database role, `devos_ingest`, comes in C04 (`plan/Ek_B_Veri_Modeli.md`:39, 98);
- until C04 the builder reads the library directly (plan:93; D-014);
- the machine account leaves the library only "After the ingestion has been verified" (plan:1222).

So task 0, before task 1, comes before every piece of work that depends on row 15.

## Point 4. The checker

Not this file's to give. The block asks a fresh-context checker that did not produce this record to judge it against the block and plan C01 row 15, at the head that records it, and to state its independence level.

## What is not observed, and how the block handles it

- **Both parts of the success condition** (the job reads the library repositories with a read-only key; no content ends up in the job logs): not observed in C01. Here they are "could not check", because the job and the key do not exist. The block records the row as moved, not as met, and C01 does not count it as passed (plan Section 8 item 14). Both parts are owed at C04 task 0, before task 1. The fail path does not apply in C01; it applies at C04 task 0 if the observation fails there.
- **The state of `devos-backup` now** (whether a job or a key is already there): could not check. The repository is private, and the machine account is not a collaborator by design. C00 recorded it as "not visible" (`evidence/C00/EV-C00-002_preparation_verification.md`:26); that it exists rests on Batu's "Evet." (same file:57). What stands in: the key inventory lists the key as planned (`plan/key_inventory.md`:44), and none of Batu's C01 steps creates it (`plan/work/C01.md`, "Batu's steps"). The move does not rest on this: task 0 observes the row with the read-only key of Section 12 item 2, which is Batu's C04 step.

## Facts taken from the documentation (PC-21 item 9)

None. Row 15 is not established from the platform's documentation: it moves as a whole, and C04 task 0 observes it directly. PC-21 item 9's claim form and its qualifiers have nothing to apply to in this record.

## Related records C04 will meet (pointers only)

- Row 7's Actions part shares C04 task 0 (W-C01-14).
- N-133 item (2) on `plan/work/C04.md`: row 12's design path is in place before the ingestion jobs.
- N-126 on `plan/work/C04.md`: who creates the ingestion role's key (a different key from row 15's).
- `plan/key_inventory.md`:44, the library read key: "which GitHub account issues it is not stated", and its revocation steps "are not stated in the plan".

## Result

| Part | Result | Where |
|---|---|---|
| Row 15 as a whole | moved to C04 task 0, before the ingestion jobs (task 1); not observed in C01 | Points 1 and 3 |
| The job in `devos-backup` reads the library repositories with a read-only key | not observed in C01 (could not check here); owed at C04 task 0 | "What is not observed" |
| No content ends up in the job logs | not observed in C01 (could not check here); owed at C04 task 0 | "What is not observed" |
| Fail path ("The transfer method is redesigned") | does not apply in C01; at C04 task 0 a failed row changes the plan through Section 14 before task 1 | Point 3 |

No plan change follows: C01's second condition asks for one only for a failed row (`plan/work/C01.md`:28), and row 15 has not failed. For C01's fifth condition (`plan/work/C01.md`:31), row 15 names its stage, C04, and the work its fail path comes before, the ingestion jobs (Point 3).
