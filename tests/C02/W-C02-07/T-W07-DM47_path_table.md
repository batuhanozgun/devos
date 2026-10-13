# T-W07-DM47 · The database's high-impact path table equals plan 6.7's list, path by path

Synthetic test data (plan Section 8 item 13): the program's self-test uses a made-up plan text and rows (`w07_fixture/`), written to a temporary directory and removed; the real run reads only the repository's plan file, `tools/merge_gate.py` and the table's rows. The patches write only `docs/` or delete a listed row, on the throwaway database. No key, token or password is read or printed.

**Serves.** W-C02-10 point 4 ("✔ The database's copy of the high-impact path list holds exactly the paths of plan 6.7's list at this item's head, compared path by path"). GROUPS section 4 (EV-C02-002 section 6: "the path table equals the merge gate's list (DM-47)"). GROUPS section 3: the comparison is a check with its own "could not check" cases (point 6). Design: EV-C02-002 DM-47 (content: plan 6.7's list; a table filled by migration and changed only with 6.7's list; "A C02 test (W-C02-07) checks that it equals the list the merge gate reads (W-C02-19)"); B 3.3 (PC-42 place 12); plan 6.7; W-C02-19 point 2 (the gate follows 6.7's bullet).
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-10 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. Two parts, both run in the migration job's `devos-test` step after the merge's migrations:
- `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_dm47_path_table.sql` (the database part, as `postgres`);
- `python3 -I supabase/migrations/tests/w07_dm47_merge_gate_list.py < <the job's JSON object>` from the repository root, with no arguments (`--psql` is the same), in the step's libpq environment (the comparison). Its input is N-255's one JSON object with exactly the keys `endpoint`, `apikey`, `tokens` and `revoked_token`; it uses none of them, but no input or another form gives COULD NOT CHECK. Its first line declares `# w07-needs-database: yes`, so the job gives it the step's own connection settings rather than `env -i` (N-255); without them it gives COULD NOT CHECK. **Interface on W-C02-03's job:** run this program in the same step and environment as the SQL files; until it does, the comparison has no result in `devos-test` (COULD NOT CHECK, which keeps W-C02-10 point 4's line unmet), and on the throwaway database the harness runs it as the job does, with the four keys null and the throwaway database's socket as its only libpq environment. `--rows-file` takes rows already read, one path per line, for a runner that reads them itself.
- The program's own could-not-check cases: `python3 -I supabase/migrations/tests/w07_dm47_merge_gate_list.py --self-test` (no database).
**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. (README section 8): `devos_private.high_impact_path` with one row per entry in a column `path`, holding plan 6.7's backticked spans as written (`CLAUDE.md`, `.claude/`, `methods/`, `supabase/migrations/`, `supabase/functions/`, `pipelines/`, `.github/workflows/`, `.github/CODEOWNERS`): a directory entry ends with `/`.


**Phase C, the executor's decision (Group C's open 1).** The copy equals plan 6.7's list, path by path; every path in it must be class high in the merge gate; the gate's high paths beyond 6.7's list are printed as a note, never a failure. The comparison runs as `supabase/migrations/tests/w07_dm47_merge_gate_list.py`, a program the migration job runs (README 5.1 (b)).

## Cases
SQL part (`w07_dm47_path_table.sql`):
- `DM47-a`: the table is readable and not empty (lists its rows).
- `DM47-b`: no null, blank, padded, absolute, `..`, `//` or backslash entry; no duplicate.
- `DM47-c`: no `devos_api` function's source writes the table (a static look at `pg_proc.prosrc`).
- `DM47-d`: `anon`, `authenticated` and every `devos_*` role hold no INSERT, UPDATE, DELETE or TRUNCATE privilege on it. The owner (`postgres`, the migration job's role) is outside the line: it is the path by which migrations fill the copy (DM-47).
Program (`supabase/migrations/tests/w07_dm47_merge_gate_list.py`):
- `DM47-plan`: plan 6.7's "High-impact path list" bullet is read at the head, as W-C02-19's case (28) reads it; each path counts once (the bullet names `.github/CODEOWNERS` twice); the phrase that names no path ("the code of the decision channel once C06 writes it") is skipped.
- `DM47-cmp`: the table's rows equal the bullet's paths: none missing, none extra, none duplicated.
- `DM47-gate`: every path of the bullet and of the table is class high under `tools/merge_gate.py`'s own predicate (its `HIGH_PREFIXES`, `HIGH_FILES`, `HIGH_DIR_PATHS`). The gate's paths beyond 6.7's list (`tools/`, `.gitattributes`, three plan files) are printed as a note, not a failure.
Self-test (point 6), each with its wanted answer: `DM47-st-control` clean; `DM47-st-plan-missing`, `-plan-unreadable` (a directory in the file's place), `-plan-partial-no-bullet`, `-plan-partial-no-path`, `-rows-unreadable`, `-rows-partial` (a row without a path) could not check; `-rows-extra`, `-rows-missing`, `-rows-empty` fail. It prints the counts of clean, fail and could-not-check answers with the denominator.

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-DM47`: the database's copy of the high-impact path list holds exactly the paths of plan 6.7's list, each of which the merge gate classes high, and no application role or function writes it. |
| **Failure class rule** | **[Designer's addition.]** Any difference between the list the database enforces (B 3.3) and the list the plan and the merge gate use: a path missing (a routine item could then write it), a path added, a copy changed outside a migration, or a comparison that reads a partial input as equal. |
| **Examples** | Original finding (R1 2.7, via DM-47: "B:134's refusals need a copy the database can read"): a listed path missing from the copy (`B-DM47-1` → `DM47-cmp`). Other manifestations: a path that is not on the list (`B-DM47-2` → `DM47-cmp`, `DM47-gate`); the copy writable by an application role (`B-DM47-3` → `DM47-d`); an unreadable or partial input taken as equal (`DM47-st-*`). |
| **Negative control** | The patched copies and the self-test's planted inputs: each must turn the named case red or give "could not check", never PASS. |
| **Positive control** | The unpatched copy: `DM47-a` to `-d` and `DM47-plan`, `-cmp`, `-gate` ok; `DM47-st-control` clean. |
| **Break attempt** | (1) `breaks/B-DM47-1_path_removed.sql` (deletes `pipelines/`): red `DM47-cmp` (program). (2) `breaks/B-DM47-2_path_added.sql` (adds `docs/`): red `DM47-cmp`, `DM47-gate` (program). (3) `breaks/B-DM47-3_copy_writable.sql` (grants INSERT to `anon`): red `DM47-d` (SQL part). The harness runs the program with `--psql` against its throwaway database for (1) and (2) (README 5.2, "Executables against the harness"). |
| **Stage and environment** | C02. `devos-test` (the job's step; both parts) and the throwaway database. The migration job runs a file of this test only once W-C02-10 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group C); its agent ID and type are in W-C02-07's "Record" (point 1). Run by the migration job, by W-C02-10's producer at its head, and by W-C02-13's prober with the breaks. Judged by a fresh-context checker that wrote none of the tests. Shared: model lineage and the design records (plan Section 8 item 7). |
| **Evidence layer** | Structural. `DM47-c` is a static look: a write by dynamic SQL is not seen (point 5 (a)'s `T-W07-5A` and the privileges of `DM47-d` cover the roles). It does not show that 6.7's list is the right list. |
| **Evidence envelope** | README section 4. Fixed before the run: the eight paths of 6.7 at `main` `db2ebd9` (read again at the head), each case's outcome, each patch's red cases. Observation and raw evidence: the job's output of both parts under `evidence/C02/raw/`, after the hygiene checks; transport `sql-set-role` (owner-level reads) or `throwaway`. |

## Clause table (DM-47; W-C02-10 point 4)
| Clause | Case ID(s) | Or: moved to |
|---|---|---|
| "holds exactly the paths of plan 6.7's list at this item's head, compared path by path" | `DM47-plan`, `DM47-cmp` | — |
| "checks that it equals the list the merge gate reads (W-C02-19)" | `DM47-gate`: **read in the design's form**: the gate reads 6.7's list (W-C02-19 point 2) and classes more (the installation's own paths), so the test asks that every listed path be class high in the gate and names the gate's extras | the extras' place in 6.7's list: a plan question, reported (Open) |
| "a table filled by migration and changed only together with 6.7's list" | `DM47-c`, `DM47-d` | — |
| "the decision channel's code once C06 writes it" | — | C06 (W-C02-19 point 6; N-241) |
| Point 6: the comparison with missing, unreadable and partial input | `DM47-st-*` | — |

## Could not check
COULD NOT CHECK when the table is absent (`DM47-pre`), the plan file or its bullet cannot be read, the rows cannot be read (`psql` absent or failing, no rows source given), a row has no path, or `tools/merge_gate.py` cannot be loaded. An empty table is a readable difference: FAIL, not "could not check".

## Not covered
Whether 6.7's list is the right list (a plan question); `.github/CODEOWNERS`' content (C03); `devos` (its copy is compared when the job's `devos` step runs the same program, which W-C02-03's job does not do: README 5.1 "What it cannot show").
