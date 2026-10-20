# Producer package (DevOS installation; Ek A 3.2, 3.3, 3.5; DR05)

id: producer-package. Scope: the installation's helper role; C05 replaces or hands it over. `.claude/agents/producer.md` and `CLAUDE.md` bind; this package informs and never overrides them, and a difference between them is a finding for the executor. It adds methods, failure classes, examples and limits; it restates no rule of theirs.

**1. Methods**

**M1. Your triage note** (an item's team triage; working order section 4 step 1a). Answer from the method's field, as numbered points, each `PROCEED` or a typed `DEFECT`, `MISSING_EVIDENCE`, `PREFERENCE` or `SCOPE_CONFLICT`. Round 1, before an approach exists, holds:
1. Need: does the product have to exist; the smallest deliverable that meets the acceptance and its named consumer; what can be left out.
2. Reuse: the existing functions, tests, fixtures and tools, by path and line.
3. Method: the one you choose, the alternatives you rejected, and why; any known failure class (section 2) it avoids.
4. Interfaces the test designer can pin before the build: commands, arguments, exit codes, output lines, rule IDs, function names, file formats and markers.
5. Writes: the literal repository paths (the `writes:` candidates), and any file another item also writes (one writer at a time).
6. Liveness and lock-out: how each new gate fails closed, what it can block, and the recovery route that does not depend on the gate itself.
7. Cost: lines of code and tests, helper runs, verdicts, time on the critical path; labelled estimate or measure.
8. Split or join, with the reason.
9. What the binding check will need to see, in which counted environment, and when that environment first exists (a gate changed by a pull request does not run at that pull request's own merge).
Round 2 answers the approach block clause by clause: each objection names the clause or disposition it answers, and a defect gives the observation that would show it fixed. Where you can, test the clause on the real inputs in a scratch copy (run the copy, the parser or the resolver on them) rather than reasoning about them.

**M2. Build** (after the approach and the acceptance are merged and synced). A method the approach agreed is yours to apply, not to redesign. Work in a scratch clone with literal paths. Keep every existing behaviour the condition does not name.

**M3. Copy by tool.** Agreed text (a role's draft, a merged block) is copied by a script that reads `git show <sha>:<path>` between named markers or a pinned line range and writes the bytes; compare the SHA-256 of the source block and of the copy. A transformation, if one is agreed, is a listed table applied in a fixed order, and the hash is compared against the transformed source. Each joining sentence you add is listed with its source line. Never retype agreed text.

**M4. Where a fault goes.** In the approach: to the executor and the field's owner, as a blocking return. In a source record: to its owner. In a role's draft you copy: back to its author, with the byte count or the line.

**M5. Fail closed and say so.** A check that cannot run prints "could not check" and exits non-zero, never green; every external call has a timeout inside the guard's budget; a negative test asserts its own rule ID, not "some refusal". A file read from a pull request's head is parsed, never imported or run.

**2. Known failure classes (this installation's records)**

- **FP1 Hand transcription where a byte copy fits.** A helper was told to copy 4,515 and 1,788 log lines by hand and failed; a byte copy and a 20-line decoder did it (L-421; EV-C02-020 part 6, section 3). Answer: M3, and `ANOTHER_METHOD` to a task that dictates the hand route.
- **FP2 Scale set by a table, not by the acceptance.** W-C02-09 built 14 of 26 migrations and 55 functions over 46 verdicts (CHK-C02-075 to CHK-C02-120), with no step asking what C02's acceptance and C03's start need (EV-C02-020 part 6, section 4 items 1 and 2). Answer: M1 point 1.
- **FP3 A dictated method accepted silently.** No producer objected at the level of frame or method (EV-C02-020 part 6, section 3; L-426 departure (4)). Answer: the take-up returns.
- **FP4 Tests that pin the code's text, not its behaviour** (break patches over function text; EV-C02-013 section 10; EV-C02-020 part 6, section 4 item 5). Answer: interfaces by behaviour (M1 point 4).
- **FP5 Records grown by duplication** (EV-C02-014, six subsections repeated for 15 parts; EV-C02-020 part 6, section 4 item 6). Answer: one record, cited.
- **FP6 A parser that passes an unexpected form.** A pull-request gate passed silently on quoted file names (CHK-C02-029, CHK-C02-035); the leak check's parser was bypassed with control bytes (CHK-C00-033 F3). Answer: parse strictly, deny what does not parse, test the odd forms.
- **FP7 An oracle that accepts any error as the refusal, or could never pass a correct build** (CHK-C02-030, CHK-C02-088, CHK-C02-089, CHK-C02-094, CHK-C02-095). Answer: M5, the specific rule ID or message.
- **FP8 Guard denials from the route, not the goal.** A path in a shell variable was denied (B5; CHK-C02-127 R2-14); a here-document the guard could not parse was denied (G0; L-422). Use literal paths and plain commands; write a scratch script with the Write tool; never run or write a live `.claude/` or `tools/` file.

**3. Examples from this installation**

- **Good.** PR-A1 (W-C02-22): the producer copied the agreed shared block into five role files by tool and listed its 45 joining sentences; the binding checker read all 45 and found none that added a rule (CHK-C02-127 R2-11). Producers also sent test faults back instead of editing tests (N-283, N-285, N-293, N-297; EV-C02-020 part 6, section 3).
- **Bad.** L-421: the method was dictated and wrong, the helper followed it, and the run ended on a platform error; the executor later recorded the approach itself as the cause.
- Why it is bad: the dictated route was a known class (FP1) and was taken up without a return, so the fault showed only as a platform error after the run's cost was spent, and the record had to name the approach afterwards instead of the take-up naming it before any work.

**4. Tools and limits**

- Tools: Read, Grep, Glob, Edit, Write, Bash.
- The live `.claude/`, `tools/` and `.git/` are not writable (guard F1, B5): edit in a scratch clone (`git clone https://github.com/batuhanozgun/devos <literal dir>`).
- Untrusted input is read with `python3 -I`; scripts live outside the data's directory.
- From W-C02-24's merge (not in force before it is merged and synced): a writing task reaches you in T5's writer form only (its `Writer or reader:` line says writer, one `Item:` line, and the item's approach block byte for byte as `HEAD` holds it); a triage task is in the reader form and carries only its `Item:` line. Your agent ID in a writer-form task becomes the verdict's `producer_run`, and the merge gate refuses a change to an open item's `writes:` paths without a covering verdict that names that item.
- Returns, by class: `WRONGLY_FRAMED` when the acceptance tests only the form of the claim; `ANOTHER_METHOD` when the given method falls in a class above; `NOT_NEEDED` when existing code already meets the need.
