# Executor package (DevOS installation): each role's lines for the executor, copied unchanged from EV-C02-028 part 9
`plan/Installation_Working_Order.md` and `CLAUDE.md` bind the executor, which has no file under `.claude/agents/`; this package informs and never overrides them.
**Producer**
- A producer writing task is in T5's writer form (from W-C02-24's merge and sync): its `Writer or reader:` line says writer, it has one `Item:` line, and it carries the item's approach block pasted by tool, byte for byte from `git show HEAD:<item file>`; a triage task is in the reader form, with its `Item:` line. It has no method field: the method is the producer's, within the purpose and the acceptance.
- Ask the producer in triage for need, reuse, method, interfaces, writes, lock-out, cost and split; the test designer pins the interfaces the producer stated.
- Never write a product path yourself, and never retype agreed text: copy it by tool (L-421).
- A producer return (`ANOTHER_METHOD`, `WRONGLY_FRAMED`, `NOT_NEEDED`) gets a recorded disposition before the task goes out again.
- Two items that write the same file are sequenced in their approaches (one writer at a time, PC-24).
- An over-blocking guard or gate is recovered by a revert by you, with a checker's verdict `item: revert <sha>` (from W-C02-24's merge and sync); never patched in the live tree.
**Test designer**
- Ask the test designer at an item's start (triage) and again after the approach is agreed. Give it the checker's triage path and the producer's stated interfaces (rule IDs, grammars, which copy runs); never the cases or the breaks.
- Never write or edit an acceptance block or a test. A condition that looks wrong after a result is reported, never edited; a loosening voids the result; replacing a check by a stronger one before its result is your call with a checker (L-425; L-426 departure (6)).
- A green script is not acceptance: live rows hold it, and the item stays "execution finished, not accepted" until they are recorded (CHK-C02-127 C1).
- A live observation of a merge-gate or guard change counts only from the first natural occurrence after its sync: both run the working tree's copy, so the change's own merge runs the old one.
- Negative cases are synthetic only; a live denial is never planted (D-020, D-017).
- Your failure classes in this field: methods dictated in tasks (L-426 departure (4); L-421); the library banned (L-426 departure (3)); every checker condition treated as an order (L-426 departure (5)); a passive window kept after it was judged weak (N-314).
- Good example: W-C02-22's triage, approach and condition (EV-C02-026). Bad example: L-421's dictated transcription. Why it is bad: the work went to a helper with no role file under a task that fixed its method, so no role could return it or show the method wrong.
**Checker**
**Checker**
- Before launching a binding check, compare the checker's agent ID with every `asked:` line, every triage record and every draft of the item, and with earlier verdicts on it; write the result in the log entry and in the task, so that the verdict's independence line can cite it. Case: EV-C02-028 part 5, where the round-1 checker drafted its own package and is therefore out of PR-A2's verdict.
- Size a binding task's budget to the floor: own breaks for each floor path, every cited ID resolved, the counted environment. A floor that does not fit comes back with the unmet floor item named, and the check is given again. Good example: CHK-C02-127's task, which gave its breaks as a constraint with the reason.
- Give a method in a binding task only as a constraint with its reason; without the reason the checker treats it as steering and returns the task. Case: EV-C02-026:1502, where breaks under the old checker file needed a constraint with its reason.
- When a condition creates a wait, ask whether a stronger check exists now, and who decides a replacement. Bad example: L-421 to L-425 ("sooner: none"), corrected by L-426 (6).
- Why it is bad: each entry carried the wait forward without asking whether a discriminating check was available, so the item waited on a proxy that could not tell a working mechanism from a broken one.
**Researcher**
- E1. Knowledge first (D-039): before a technical decision in a role's map area, ask the researcher, naming the decision and its consumer. The task's library line gives map paths. Never ban a source except as a reading order for independence, with its reason (SB-COR 2.4).
- E2. When roles read a source differently, the researcher settles what it states by re-reading it with path and line (SB-COR 2.5 (c)). Do not settle it by majority or by your own reading.
- E3. Every [V] fact carries page, heading or line, reading date and version. A changed version at opening triggers a version tie before rows are relied on (SB-COR 1.2; EV-C02-023 section 3).
- E4. "Could not consult the library" is a state of its own, with the held steps named (working order section 3). Your own cases: N-310 (the library unused from C01 on, about 240 entries) and L-427 line 1494 (L-285's refused `add_repo` was not taken to Batu).
- E5. A researcher's "not stated" covers only what it read. Never turn it into "the platform does not do X".
- E6. Library text never goes into records. Cite path and section; reports filed verbatim pass the leak check, which misses paraphrase.
- E7. A returned task is not sent again unchanged; record a disposition first (superpowers U03 F22: a blocked or context-short return calls for a changed response).
- E8. A researcher stopped at its turn limit cannot be resumed. Give a fresh one its saved scope as a hint, never as evidence (L-286 precedent).
**Prober**
- Methods:
  - At every opening, and after a worker restart or a source attach, read the version with `get_session` and check the guard is live with `tools/guard_report.py` (the last record number moves, the newest `cwd` is the checkout; L-439). A new session makes earlier rows "does not count" until they are re-observed (EV-C02-023 section 1).
  - Ask the prober before a condition rests on a platform fact. Give it the claim and the environment whose result counts, not the method.
  - Schema reads that need a tool only you hold are yours, filed raw with no call: `SendMessage` via `ToolSearch`, and your Workflow tool's own description for `agent()`'s options.
  - Observations happen once, at the first natural occurrence. A red result selects the fallback decided in advance.
- Failure classes:
  - Rows from another session counted as current (EV-C02-023 against L-439).
  - `last` returning a later short message instead of the report (EV-C02-023 R-03): file from the notification and say so.
  - A guard silent after a restart (L-430).
  - A here-document read by the guard as a command (L-439 #103: write records with Edit).
  - An unstable mode value (EV-C02-023 section 1; L-118 CR-1).
- Good example: L-439's opening check. It read the version from the tool, checked the guard with `guard_report.py`, fixed the shallow checkout, stated "could not consult the library", and did not retry the held call.
- Bad example (as a pattern, caught in time): EV-C02-023 section 3. Relying on `subagent_audit.py last` would have filed the researcher's later short message as its report. Bad because the report that counts is the one the platform delivered; a later message from the same agent is not it, and nothing in the filed text would have shown the swap.
