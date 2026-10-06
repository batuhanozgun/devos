# FR-04 premise inventory: the W-C01-03 probe design at 6cf4e5d (researcher, read only)

**Question.** Which premises shape the design's run orchestration and safety? Which of them cause CHK-C01-013's blocking findings 3 to 7 and CHK-C01-014's conditions, and is each premise needed? This feeds FR-04 (plan 6.12 items 1 and 2): whether a third round stays in the current frame or changes it.

**Sources.**
- PLAN = /home/user/devos/plan/DevOS_Kurulum_Plani.md
- The scratch clone CL = /tmp/claude-0/-home-user-devos/1ffeb509-6a85-5fdc-9f2f-cbf44d117c09/scratchpad/w23. In it: EV = evidence/C01/EV-C01-002_probe_design.md; rA and rB = evidence/C01/probe/routine_a_instruction.md and routine_b_instruction.md; R1 and R2 = evidence/C01/raw/W-C01-03_setup_facts_report.md and W-C01-03_setup_facts_report_2.md.
- The verdicts are in /home/user/devos/evidence/C01/checks/.

**Labels.** (S) the source states it; (I) my interpretation; (Inf) my inference.

## Disciplines (D1–D9)
D1: yes: I set the strongest alternative frame (a short, stable routine prompt that reads its step from a checked file on main) against each finding, and I report which findings change under it and which do not.
D2: yes: the framing in L-173 and in CHK-C01-013 finding 19 pulls toward "the frame is wrong", so I also report what the alternative keeps and the safety checker's opposite judgment.
D3: yes: I tested each premise against the plan text it serves, quoted with its line, not against the design's own goals.
D4: uncertain: I treated the verdicts as claims, and checked the lines their key findings cite (rA:80-83 and 266, EV:113-116, 180-213 and 221, the guard's session checks) before relying on them.
D5: yes: I read EV, rA, rB, R1 and R2 in full at the clone head. That showed the design's "cannot be edited later" claims more than the reports support.
D6: yes: for each finding I separated the immediate cause from the premise that made it possible, and stopped where going deeper would not change the frame choice.
D7: no
D8: yes: I confirmed that the clone is at 6cf4e5d with a clean tree; that is the head both round-2 verdicts reviewed.
D9: uncertain: the task forbids the library, so I did not consult it; this is stated under Open as a limit.

## 1. Premise inventory

**Q1. The whole run sequence is fixed in one routine prompt that Batu pastes once ("it cannot be edited later", EV:113-116).**
- **Where it came from:** an executor design choice, built on Section 12 item 0 ("the probe routines the builder prepares", PLAN:1205) and on Appendix E section 8's batching.
- **Still valid:**
  - Only in part. (S) A routine can be edited (R2:104; R2:119).
  - (I) Only Batu can edit it, because Claude cannot act on routines it did not create (R2:158).
  - So a fixed *prompt* holds, but a fixed *sequence* does not follow from it.
- **Choose it again:** no. For DevOS's own routines, PLAN:668 says the starting instruction uses the trigger text "only as a work ID and reads the actual information from the database".

**Q2. "The builder does not open or steer probe sessions; it reads their branches" (PLAN:934).**
- **Where it came from:** PC-09's reason (/home/user/devos/plan/decisions/PC-09.md:236). A session in Accept edits cannot start sessions (L-119), so routines that Batu creates start the probe sessions.
- **What "steer" means:** in the plan's own usage (the 6.7 row at PLAN:730; row 17 at PLAN:958), steering is acting on a running session through the control surface: messages, interrupts, remote subagents.
- (Inf) A checked file on main, read when the run clones main (R1:107), is not steering in that sense. It is the "starting instruction the builder prepares", delivered another way. It must not decide row 1's continuation (PLAN:942).
- **"Open":** decision A makes the executor the cause of every run. That still needs to be argued both ways (CHK-C01-013 finding 16).
- **Still valid:** yes. **Choose it again:** yes, with "steer" defined as above.

**Q3. One routine per environment.**
- **Where it came from:** plan text, PLAN:934.
- **Still valid:** yes. But under it, reach (a) needs two runs of routine A at the same time, and whether one routine's runs can overlap is not stated (R2:113).
- **Choose it again:** the plan text, yes; the dependence on overlapping runs, no.

**Q4. Runs are started by GitHub `pull_request.opened` triggers on go-branches.**
- **Where it came from:** executor decision A (L-172; EV:180-213), which replaced Batu's Run now presses after CHK-C01-010 finding 3.
- **Platform facts:**
  - (S) Only pull-request and release events exist (R2:49-53).
  - (S) Not stated: whether a pull request opened by the machine account fires the trigger, the delay before the run, and what the run receives (R2:68-83).
- **What the plan says:**
  - Section 12 item 0 names no way to start a run.
  - Plan 6.4 uses schedules and the API trigger (PLAN:667).
  - The API trigger key may never sit in an agent environment (PLAN:732).
- **Still valid:** (Inf) yes, in the sense that it is the only on-demand start the executor can cause without holding a secret.
- **Choose it again:** uncertain.
  - It opens a start route that anyone with a pull request on public `devos` can use.
  - (Inf) It is itself a way for a session in one environment to trigger another environment's routine, the very act row 17 tests. Neither 6.7 nor row 17's reading accounts for it.

**Q5. A run learns which step it is only from its own hand-over (rA:80-83).**
- **Where it came from:** the round-1 design, generalised from row 1 ("the second continuing from the first one's hand-over record", PLAN:942).
- **Still valid:** only for the run pairs step-1 → step-2 and combined-1 → combined-2.
- **Choose it again:** no, for every other run.

**Q6. probe-b has two repositories and no guard.**
- **Where it came from:** PLAN:934 and row 9 / N-048 (PLAN:950). (S) A session with several repositories loads no hooks (R1:196).
- **Still valid:** for row 9, yes. The design adds two things the plan does not ask for: this unguarded session is also the live target for row 17 and N-109, and a pull request can start it.
- **Choose it again:** the two-repository run, yes; that combination, no.

**Q7. Live targets wait up to 60 minutes, and success is read only from the target's own record inside that window (EV:221, 399-400).**
- **Where it came from:** executor decision E, answering CHK-C01-010 finding 12.
- **Hidden assumption:** a message reaches only a session that is still running. Nothing documents that. (S) The changelog mentions routines that resume sessions (R2:166), and CHK-C01-014 finding 11 considers a message resuming a session.
- **Choose it again:** uncertain until that is known.

**Q8. Every row is probed by the two routines, packed into at most 12 runs (EV:206-213).**
- **Where it came from:**
  - Each row's "(probe: P2)" text: required by the plan.
  - The packing: the plan's "15 runs a day" (PLAN:392, 658), which the documentation contradicts (hourly caps, no daily cap, R1:130-140); and row 5's "not used up on purpose" (PLAN:946).
- **Choose it again:** P2 for each row, yes; the packing, no.

**Q9. Order: rows 1 to 4 and 17 first (PLAN:929; plan/work/C01.md:42).**
- **Where it came from:** plan text.
- **Still valid:** yes. The design inverts it: step-1 and step-2 already carry rows 7, 8, 9, 12 and 13.
- **Choose it again:** yes, keep the order.

**Further premises that bear on the findings:**
- **Q10. Target IDs reach the guard only through a checked change on main** (EV:550-561; CHK-C01-011 condition 3). Valid for safety. The merge happening during a run comes from Q7.
- **Q11. Batu's steps are only those of Section 12 item 0, in one batch.** W-C01-03 item 8 itself allows an extra step if it is "recorded as a finding and routed". The design treats such a step as a cost to avoid; for example, Batu is not asked for routine B's trigger ID (EV:230-235).
- **Q12. probe-a runs main's guard with a probe-only rule keyed on an environment variable** (PLAN:936; EV:522-548). Plan text, and valid.
- **Q13. The builder cannot start or fire probe runs through session tools.** (S) Observed for `create_session` and `send_later` (L-119, L-125). (I) For `fire_trigger`, read from R2:158, not observed.

## 2. Which premises cause which findings

**CHK-C01-013, finding by finding:**
- **Finding 3 (row 13 runs before its skill exists; the order is inverted).**
  - Cause: Q1 together with Q8. Rows were packed into the first two runs written in advance, against Q9.
  - Design work under any frame: a missing skill reads "could not check", never "does not load"; and when the skill merges, with W-C01-20.
- **Finding 4 (row 4's re-observation has no run).**
  - Cause: Q1 together with Q5. No run can be conditional, because the executor can cause "a next run" but cannot choose which one.
  - Design work under any frame: the version-comparison rule, and a route for a version change seen only in `get_session`.
- **Finding 5.**
  - (a) The remote-subagent and SendMessage attempts are missing. No premise causes this; it is design work under any frame, including W-C01-04 allowances against the guard's T1/T2 denials.
  - (b) Two "could not check" parts state no consequence. The cause is Q11. Stating the consequences is design work under any frame.
- **Finding 6 (a reach outside the target's window reads "not reached").**
  - Cause: Q7; Q3 (overlap); Q10's merge during the run; Q4 (undocumented delay, the 15-minute fallback).
  - Design work under any frame: a UTC time for each attempt; an attempt outside the window reads "could not check"; the N-109 reaches go before row 17's messaging.
- **Finding 7 (stray, duplicate and non-firing runs).**
  - Cause: Q5 with Q1 (one stray run corrupts the sequence) and Q4 (triggers that never fire).
  - Design work under any frame: runs must be idempotent, because the platform itself makes retry, catch_up and duplicate fires (R2:115-119).

**CHK-C01-014 conditions:**
- **Conditions 1 and 2 (Author filter; closed write list).** Cause: Q4 on a public repository. A closed write list is good practice anyway; the go-branch negative controls exist only because of Q4.
- **Conditions 3 and 4 (marker failure; withdrawal list and server names).** Cause: Q12. Design work under any frame.
- **Condition 5 (N-109 requests and readings).** The request constraints are design work under any frame. The reading after the target has ended comes from Q7.
- **Condition 6.** The fixed parameters are design work under any frame. The stray routine-B runs come from Q5 together with Q6.
- **Condition 7 (probe-b's worst case).** Cause: Q6, with Q4 making the session startable from outside. The statement is still owed as long as Q6 stands.
- **Conditions 8 and 9 (token scan; row-4 package).** Plain defects, fixed under any frame.

## 3. Plan requirement versus what the design added
- **Q1:**
  - The plan requires "a starting instruction the builder prepares" (PLAN:934).
  - For DevOS's own routines it says "the starting instruction uses it only as a work ID and reads the actual information from the database" (PLAN:668).
  - Fixing the whole sequence in the prompt is a design addition. Not needed.
- **Q5:** PLAN:942 requires a hand-over continuation for "two runs in a row". Extending that to every run is a design addition.
- **Q4:**
  - The plan names no start mechanism. 6.4 lists a schedule among what the builder prepares (PLAN:667).
  - PR triggers are needed only if starts must happen on demand. The alternatives:
    - an hourly schedule, where runs with nothing to do end at once (R1:110-111; cost not worked out);
    - Batu's presses, which working order section 2 foresaw: "it goes to Batu as one narrow question (the first time in C01)" (/home/user/devos/plan/Installation_Working_Order.md:28).
- **Q7:** The plan asks for reaches to "another session in the same environment; a session in the other probe environment" (W-C01-03.md:27), and row 17 asks for "steer or message a session there". A live window is a design addition.
- **Q8:** P2 for each row is required. The packing rests on the outdated "15 runs a day".
- **Q3 and Q6:** Both are required by the plan (PLAN:934, 950). The design added only giving probe-b the target role. Changing Q3 or Q6 needs a Section 14 plan change and a Batu step.
- **Q9:** Required by the plan; the design departed from it.
- **Q11:** Item 8 allows routed extra steps; avoiding them is a design addition.
- **Q2:** Required by the plan. Read with the plan's own meaning of "steer", it does not forbid a dispatch file on main. "Open" needs a both-ways statement under either frame.

## 4. Squeeze signal
Yes. (S) The mechanical trigger has fired: the same item failed a second time (L-173). (I) The fixes form chains of new mechanisms:
- **Run start and dispatch:**
  - Run now presses (round 1)
  - → PR triggers with go-branches and pull requests closed unmerged (decision A)
  - → a 15-minute Run now fallback (F-6)
  - → per-run start markers and a stray rule (finding 7)
  - → an Author filter and an event-author check (condition 1)
  - → a closed write list with go-branch negative controls (condition 2)
  - → routine B writing "next: done" at its start (condition 6).
- **Live targets:**
  - two live-target runs with 60-minute waits (decision E)
  - → a target-list merge during the run
  - → per-attempt timestamps, window sizing and re-fires within the run maxima (finding 6).
- **Others:** a version-comparison run (finding 4); a probe-only SessionStart logging hook (finding 9).

Each fix answers the failure mode of the one before it. Four of them (start markers, Author filter, write-scope controls, "next: done") handle one failure class: a run starts that should not, or runs the wrong step. (Inf) Under a dispatch frame, one idempotent claim covers all four.

Not squeeze: the queue split, the fault switches, the planted fingerprint, the count-only scan, the `agent_type` log field and the marker self-check. These are normal details that the rows and the guard frame need.

## Counter-evidence and alternatives
- The safety checker (CHK-C01-014, line 25) judged every safety fix to be "a concrete text change inside the existing frame". It did not see a frame problem.
- A dispatch frame adds its own mechanism (a checked dispatch file and a claim). If PR triggers stay, conditions 1 and 2 stay too. It must also keep row 1's continuation free of builder input.
- Schedule triggers remove conditions 1 and 2 and would test the mechanism 6.4 actually plans. They cost idle runs drawn from Batu's shared usage, and up to an hour's delay.
- If runs do not overlap and an idle session cannot be resumed by a message, reach (a) needs a second probe-a routine under any frame. That is a plan change and a Batu step.

## Open
- Nothing here is observed; it is documentation or inference. Open in particular: whether a machine-account pull request fires a trigger; whether one routine's runs overlap; whether a message resumes an idle routine session; whether the builder can fire a routine it did not create.
- Not read: the library (task rule), EV-C00-004, and the row items beyond those the findings cite.

## For the decision
- Q1, Q5 and the packing of Q8 are design additions. They cause findings 3 and 4 and most of finding 7. Q4 causes conditions 1 and 2 and the non-firing half of finding 7. Q7, with Q3 and Q10, causes most of finding 6.
- (Inf) Replacing Q1 and Q5 would remove the structural cause of findings 3 and 4 without a plan change, provided "steer" is read as in PLAN:730 and 958. The replacement: a short prompt; each run reads its step from a checked file on main; the hand-over is used only for row 1's run pairs; the plan's order is restored.
- Design work under any frame: finding 5(a); idempotence against the platform's own extra fires; timestamps and out-of-window readings; CHK-C01-014 conditions 3 to 6, 8 and 9.
- Plan-level choices (Section 14): the kind of trigger (Q4); probe-b's roles (Q3 and Q6); and whether 6.7 lists GitHub triggers as a route from one environment to another.

## Guard denials
none
