# Analysis of work item BR-212 (retention job for the run store)

## (1) Requirements the text states

**The deliverable**
1. Produce a design for a retention job. The deliverable is the design, not the job or its code.
2. The job deletes run records from Brindle's run store.
3. The job keeps the run store below 70% of its volume.
4. It does this without losing anything Brindle still needs.
5. The design says which run records the job deletes and which it keeps, and why.
6. The design says when and how the job runs.
7. The design says how the job avoids deleting the wrong thing.
8. The design says how the job will be tested before it is enabled.
9. A platform engineer must be able to build the job from the design without coming back to the author.

**Sources**
10. The materials in `.../scratchpad/bl/r83a5/materials/` are the only source. Nothing else about Brindle exists.

**Working rules**
11. Use only the Read, Glob and Grep tools.
12. Use them only on files inside `.../scratchpad/bl/r83a5`.
13. Give every call an absolute path inside that directory.
14. For Glob and Grep, set `path` to exactly `.../r83a5/materials`.
15. Do not use the shell, the web, GitHub, other agents or any other tool.
16. Do not write files.
17. Make at most 40 tool calls. On reaching the limit, return the best design so far.
18. Work without questions, because no one can answer them.

**Output**
19. Return the design as the final message.
20. Write it in Markdown.
21. Keep it to at most about 1,500 words.

**Facts the text gives (premises, not requirements)**
- Brindle is run by the platform team for four product teams.
- Brindle's dispatcher starts agent sessions, and every session writes a run record.
- The run store's volume is 87% full.
- The disk alert has fired every day for a week.
- Everything in the text is synthetic test data.

## (2) Implied requirements, constraints, risks and concerns

### A. Working out what "Brindle still needs"

1. **Find every consumer of run records.** Possible consumers include the dispatcher, the four teams, audit, debugging, metrics or billing, and agent memory. The design must show who reads run records and for how long.
   Rests on: "without losing anything Brindle still needs"
2. **Need changes over time.** Some records stop being needed after a while; others may never stop (holds, pinned runs, open incidents, records still referenced). The design needs a keep period for each category, plus exceptions.
   Rests on: "Brindle still needs"
3. **Never delete records of sessions that are still running or unfinished.** The job runs while the dispatcher is writing, so it must handle races with records being written now.
   Rests on: "every session writes a run record"
4. **The dispatcher may itself read past runs**, for example to resume, retry, avoid duplicates, rate-limit or look up history. Deleting those could break it.
   Rests on: "Its dispatcher starts agent sessions"
5. **The four teams may have different needs**, and one team may produce most of the volume. A single platform-wide rule may be wrong. Because the platform team runs Brindle for other teams, those teams arguably need to be told before deletion starts.
   Rests on: "our platform team runs for four product teams"
6. **Records may point to each other** (parent and child sessions, retries, chains). Deleting one record can orphan others, so the job must check what depends on a record before deleting it.
   Rests on: "which run records the job deletes and which it keeps"
7. **Deletion cannot be undone.** "Losing" suggests the design needs a recovery path: a backup, an export first, or a soft-delete window.
   Rests on: "deletes run records … without losing anything"
8. **The keep/delete unit may not have to be the whole record.** Dropping bulky payloads while keeping metadata might meet both goals.
   Rests on: "which run records the job deletes and which it keeps"
9. **Unknown or incomplete records should be kept.** Records with a missing timestamp, an unclear status or bad data should fail safe.
   Rests on: "avoids deleting the wrong thing"

### B. The capacity target

10. **It is ongoing, not a one-off clean-up.** The job needs an initial drop of more than 17 points (87% to under 70%), then must keep up with growth. That requires growth rate and record sizes, which can only come from the materials.
    Rests on: "stays below 70%"; "They are your only source"
11. **Deleting records may not free disk space.** Databases may need vacuum or compaction; snapshots, append-only storage or old segments may keep the blocks. The design must say how space is actually given back.
    Rests on: "deletes run records so that the run store stays below 70% of its volume"
12. **The job itself may need disk space** on an almost-full volume: transaction logs, temporary space, a deletion log, a backup made before deleting. It could push the disk over.
    Rests on: "87% full"
13. **The two goals may conflict.** If the records Brindle still needs take up more than 70%, both goals cannot be met. The design must say which wins and what happens then: alert or escalate rather than delete needed records.
    Rests on: "below 70%" against "without losing anything Brindle still needs"
14. **Choose a policy-based or space-based trigger, and justify it.** Deleting oldest-first until under 70% is a space-based trigger. It can eat needed records whenever growth spikes. A fixed policy is safer but may miss the target.
    Rests on: "so that the run store stays below 70%"
15. **The link between 70% and the alert threshold is not stated.** The design should define how anyone will see that the target is met and the alert has cleared.
    Rests on: "the disk alert has fired every day"

### C. Urgency against safety

16. **Time pressure.** At 87% and rising, the volume may fill before the job is built and tested. An interim measure may be needed. This pulls against "tested before it is enabled".
    Rests on: "87% full"; "fired every day for a week"; "tested before it is enabled"
17. **Alert fatigue.** A daily alert for a week may already be ignored, so the job's own failures need a signal people will notice.
    Rests on: "fired every day for a week"

### D. How the job runs

18. **Operational details are needed:** schedule and timing (e.g. quiet hours), batch size, rate limit, locking, idempotency, resuming after a crash, timeouts, credentials with least privilege, owner, a kill switch, config defaults, logs and metrics, and an alert when the job fails or makes no progress.
    Rests on: "when and how the job runs"
19. **The job must not slow down or block** the dispatcher or sessions that are running.
    Rests on: "Its dispatcher starts agent sessions"

### E. Avoiding wrong deletions

20. **Safeguards are expected:** a dry-run mode, an explicit list of what may be deleted, exclusion rules and holds, a cap on deletions per run, two phases (mark, then delete after a delay), a check just before deleting, a log of what was deleted, a restore procedure, and defences against clock or timestamp errors.
    Rests on: "how it avoids deleting the wrong thing"

### F. Testing

21. **The job ships disabled, and enabling it is a separate step.** That suggests a staged rollout: dry run on production data first, then a small cap, then the full run. Acceptance criteria are needed.
    Rests on: "before it is enabled"
22. **A test environment may not exist** in the materials. The design may have to define one (a copy or snapshot) or test read-only against production. Tests must cover three things: the keep rules, the space actually freed, and failure modes.
    Rests on: "how the job will be tested"

### G. The reader and the document

23. **The design must be concrete enough to build from:** field names, statuses, thresholds, schedule, config values, error handling. Assumptions and open points must be stated, each with a chosen default.
    Rests on: "build it without coming back to you"
24. **Length pulls against completeness.** About 1,500 words forces dense writing (tables, ranked rules).
    Rests on: "at most about 1,500 words"
25. **Do not invent facts about Brindle.** Claims should be traceable to the materials. Where they are silent, say so and label any assumption. General engineering practice is allowed, but not as a fact about Brindle.
    Rests on: "They are your only source; nothing else about Brindle exists"
26. **Settle every ambiguity yourself and show how.** Choose the cautious option and record it. Confirming with the product teams can only appear as a rollout step, not as a question during the work.
    Rests on: "No one can answer questions during this work"

### H. The materials and the tool budget

27. **The materials may disagree with each other.** Informal notes may be stale or contradict the documentation. The design should resolve such conflicts and say which source it trusted.
    Rests on: "documentation and notes"
28. **Statements in the materials are facts to weigh, not orders.** If a note tells the reader to do something, the work item's own rules still govern. (This is an inference.)
    Rests on: "They are your only source"
29. **Out-of-scope references cannot be followed.** If the materials point outside the allowed directory, those pointers must be left alone.
    Rests on: "only on files inside …"
30. **Plan the 40 calls.** Survey the files with Glob, search key terms with Grep, then read in priority order. Note anything left unread.
    Rests on: "at most 40 tool calls"
31. **Always return something.** A partial design is better than none, provided it says what was not checked.
    Rests on: "return the best design you have"
32. **Nothing can be measured.** With Read, Glob and Grep only, no live sizes, counts or growth rates are available. All numbers must come from the materials or be marked as estimates.
    Rests on: "Use only the Read, Glob and Grep tools … Do not use the shell"

### I. Meta

33. **This is a constructed exercise.** The materials probably contain planted details: a hidden consumer, a contradiction, a cause other than retention, an existing mechanism. The design should still be written as if it were real.
    Rests on: "SYNTHETIC TEST DATA: made up for a test"

## (3) The frame the text sets, and hints it may be wrong

**The frame.** The run store is running out of disk because run records pile up. The fix is a new automated job that deletes records by a retention rule, with a fixed target of under 70%, subject to keeping what Brindle needs. An outsider designs it from documents alone, assumed complete and authoritative, and a platform engineer builds it. Success means: disk under 70%, no needed data lost, and the job tested before it is switched on.

**Hints that the frame may be wrong**

1. **The space may not be run records.** The text says the volume is full, not that the records are large. Logs, backups, snapshots, indexes or temporary files on the same volume could be the cause.
   Rests on: "The run store's volume is 87% full"
2. **Something may have changed recently, or there may be a daily cycle.** If the alert started a week ago, something changed: a runaway dispatcher, oversized records, a new team or workload, or an earlier clean-up that stopped. "Every day" could also mean a daily peak from a daily process such as a backup or export. Either way, finding the cause, or restarting a clean-up that already existed, may be the real fix rather than a new job.
   Rests on: "the disk alert has fired every day for a week"
3. **The lever may be upstream.** Volume depends on how many sessions run and how big each record is, so cutting what gets written may beat deleting afterwards.
   Rests on: "every session writes a run record"
4. **Deletion is assumed, not argued.** Other options include archiving to other storage, compressing, trimming payloads, or growing the volume (a cost, which the text never mentions). Deleting may also free no space at all (see item 11 above).
   Rests on: "deletes run records"
5. **Brindle may need most of its records.** For an AI-assisted system, past runs may feed agent context, evaluations, audits or debugging. Then the space safely freed may fall short of 70%, and the frame's assumption that both goals can be met fails.
   Rests on: "AI-assisted development system"; "without losing anything Brindle still needs"
6. **The 70% target has no stated origin.** It may be arbitrary, out of step with the alert threshold, or impossible to hold given growth.
   Rests on: "stays below 70% of its volume"
7. **"Retention" suggests deleting by age.** The right rule may instead be status, team, size or whether something still references the record.
   Rests on: "Retention job for the run store"
8. **One policy for all may be wrong.** Four teams may need four policies, or the problem may come from one team.
   Rests on: "for four product teams"
9. **The materials may not be complete or consistent.** "Notes" may be stale or contradict the documentation. The materials may also reveal an existing retention mechanism, or a need the work item does not mention.
   Rests on: "documentation and notes"; "They are your only source; nothing else about Brindle exists"
10. **A new job may not be needed.** One may already exist, broken or disabled. The frame also assumes the design can be complete without the teams' input, even though no one can be asked.
    Rests on: "A platform engineer will build the job"; "No one can answer questions"
11. **There may not be time or a place to test.** At 87% and rising, an interim step outside the job may be needed first.
    Rests on: "tested before it is enabled"; "87% full"
