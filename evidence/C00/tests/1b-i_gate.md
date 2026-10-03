# Gate 1b-i of W-C00-12: test results (T-W10, T-W15, T-W2, T-W5, T-W7, T-W12)

**What this file is.** The unedited output of the gate tests of tranche 1b-i (`plan/builder/w-c00-12/12_tranche_plan.md` §2.2), run by the deterministic script `tools/test_records.py` on commit `5724ff9` (clean tree), against the migration's base commit `7ed3fa3`. Procedures: `plan/builder/w-c00-12/11_test_register.md` §2.2, made concrete before the build in `plan/builder/w-c00-12/14_tranche_1b-i_intent.md` §3 (commit `de12635`). **Counting rule** (11, preamble): a deterministic script's pasted output counts; the script itself is new in this PR (class high, `tools/**`), so it counts only under the session Verifier's verdict on this PR (W-R1 as amended by R-W12-2 B-1 c). Written by run `session_01S1vPB2jo4bzk1w8XqWekj6` (the producer).

## 1. Gate tests

Command: `python3 tools/test_records.py --base 7ed3fa3` (exit 0)

```text
base 7ed3fa3; HEAD 5724ff9; working tree clean
      T-W10 W-C00-01: identical (44 characters)
      T-W10 W-C00-02: identical (49 characters)
      T-W10 W-C00-03: identical (76 characters)
      T-W10 W-C00-04: identical (71 characters)
      T-W10 W-C00-05: identical (952 characters)
      T-W10 W-C00-06: identical (201 characters)
      T-W10 W-C00-07: identical (88 characters)
      T-W10 W-C00-08: identical (133 characters)
      T-W10 W-C00-09: identical (137 characters)
      T-W10 W-C00-10: identical (105 characters)
      T-W10 W-C00-12: identical (6800 characters)
      T-W10 W-C00-11: identical (95 characters)
      T-W10 C00: identical (982 characters)
PASS  T-W10: 13 acceptance blocks byte-identical
PASS  T-W15: W-C00-06 to 11 carry the edge, are not ready, and show blocked by W-C00-12
PASS  T-W2: B in frontier before acceptance of A: False; after: True (the second state came from a re-render, with no hand edit of the generated block)
PASS  T-W5: candidate K in frontier: False; in zoom marked candidate: True
PASS  T-W7: 13 stages one line each: True; path C01 → W-X → W-X.1 → W-X.1.1 expanded: True; sibling W-X.2 one line with its child collapsed: True; stage C02's items collapsed to counts: True
PASS  T-W12: absent from ready: True; frontier names the probe: True (- `P`: platform fact 'x' untested: run P-TEST-1 first)
      M1 (T-W10 on a copy with one acceptance character changed) W-C00-01: identical (44 characters)
      M1 (T-W10 on a copy with one acceptance character changed) W-C00-02: identical (49 characters)
      M1 (T-W10 on a copy with one acceptance character changed) W-C00-03: identical (76 characters)
      M1 (T-W10 on a copy with one acceptance character changed) W-C00-04: identical (71 characters)
      M1 (T-W10 on a copy with one acceptance character changed) W-C00-05: identical (952 characters)
      M1 (T-W10 on a copy with one acceptance character changed) W-C00-06: identical (201 characters)
      M1 (T-W10 on a copy with one acceptance character changed) W-C00-07: identical (88 characters)
      M1 (T-W10 on a copy with one acceptance character changed) W-C00-09: identical (137 characters)
      M1 (T-W10 on a copy with one acceptance character changed) W-C00-10: identical (105 characters)
      M1 (T-W10 on a copy with one acceptance character changed) W-C00-12: identical (6800 characters)
      M1 (T-W10 on a copy with one acceptance character changed) W-C00-11: identical (95 characters)
      M1 (T-W10 on a copy with one acceptance character changed) C00: identical (982 characters)
FAIL  M1 (T-W10 on a copy with one acceptance character changed): W-C00-08 differs
FAIL  M2 (T-W15 on a copy with the W-C00-09 edge removed): W-C00-09 lacks depends_on W-C00-12
PASS  Mutations fail as they must: M1 failed: True; M2 failed: True; W-C00-09 without its edge is still not ready through the stage hold: (False, 'stage C00 on hold until W-C00-12 is accepted')
GATE 1b-i PASS
```

## 2. `check_ids.py` reads the register in its new home (C2 kept after the move)

Mutation checks in a detached scratch worktree of `5724ff9` (`git worktree add --detach`), each restored before the next:

```text
== unmodified
IDS OK
== C2-a: carrier table B2 cites R-R18 without 'deferred'
mechanisms.md:125: R-R18 is deferred but cited without saying so
IDS FAIL (1 problems)
== C2-b: register row M-R1 Tests cell cites deferred T-M13
mechanisms.md:17: test T-M13 is not active but is cited without saying so
IDS FAIL (1 problems)
== C2-c: register row for M-R3 deleted
12_tranche_plan.md:41: M-R3 does not resolve to a register row
12_tranche_plan.md:109: M-R3 does not resolve to a register row
IDS FAIL (13 problems)
== restored
IDS OK
```

## 3. Other self-checks (`14_tranche_1b-i_intent.md` §4)

- S-3 `python3 tools/records.py render --check` on `5724ff9`: `RENDER OK`.
- S-4 `tools/check_service_names.sh` on the staged tree before `5724ff9`: `SERVICE_NAMES CLEAN (pattern derived from 3cd686a; 12 terms)`.
- S-5 open-item text: every cell of OI-001 to OI-012 (OI-009 does not exist) is verbatim in exactly one note. OI-011's input list and its 24 items are 25 notes; walking the source cell, each note body occurs at the current position after skipping whitespace only, and the characters outside the bodies are 24 whitespace characters, one at each cut (`S-5 precise: True`). A first, looser version of this check compared the texts with all whitespace removed; it was replaced before this file was committed, because it would have supported a stronger claim than it tested.
- The migration script that produced `plan/work/` and `plan/decisions/` is kept unchanged as `evidence/C00/tests/1b-i_migrate.py` (run as `python3 <script> 7ed3fa3`); T-W10 does not reuse its parsing (it splits cells with its own escape-aware pattern).
