# Working order, wake-up and capacity (A1) — version 2

**Date:** 29 September 2026 · **Status:** Decided (technical decision). It went into installation plan 2.1.

**Why does this version exist?** The first version accepted, without questioning it, the premise "every role is a separate session and every hand-over requires the system to wake itself up again". This premise was carried over from the design in P4 and P5 (separate processes run by a manager). When the limit of 15 routines a day blocked this premise, the plan started adding new mechanisms. The right move was not to add mechanisms but to question the premise. This version does that.

---

## 1. Premise audit

| Premise | Its source | Does it still hold? | Would we choose it from scratch? |
|---|---|---|---|
| DevOS must work without Batu starting it and while the computer is off | Batu's criteria 21, 22 | Yes | Yes |
| Every role works in a separate session | The process design of P4/P5 | **No.** A role is a responsibility and a package; a session is a place of work. A role can also be carried in a subagent | No |
| Every hand-over between roles requires starting a new session | Consequence of the previous premise | **No.** A hand-over between subagents in the same session needs no bell | No |
| Independence requires a separate identity | Criterion 30 | **Partly.** There are two kinds of independence. *Thinking independence* (clean context, a different information view, different instructions, a different model family if needed) can be provided with subagents. *Authority independence* (not being able to approve one's own change, not being able to see exam answers, not being able to change check rules) needs a separate identity that the database can verify | Only for authority independence |
| The volume of work needs many parallel sessions | Assumption | **No.** The real limit is the usage allowance (tokens), not the number of sessions. Parallelism is also achieved within a session, with subagents | No |
| Sessions can run for hours | Assumption | **Unknown.** How long a cloud session can last will be measured in C01 | Depends on measurement |

---

## 2. Decision: the "team in the office, checker apart" working order

**Three environments** (instead of the previous five):

| Environment | What does it do? | Its authority |
|---|---|---|
| `devos-calisma` | Coordination, discovery, research, design, production, knowledge organisation, diagnosis. Most roles work inside this session as subagents | Opening and claiming work items, writing contributions and candidate products, pushing to `claude/` branches, opening PRs. **Cannot:** give binding review verdicts, give acceptance, activate versions, change check rules, access exam answers |
| `devos-denetim` | Independent review verdicts (DR13-G, DR13-Y), acceptance proposals, review of check and rule changes, the authority check for high-impact merges, advancing the recovery stages | Writing verdicts and acceptances; approving what the working environment produced. **Cannot:** produce products, access exam answers |
| `devos-sinav` | Holds and scores the hidden exam sets | Access only to the `devos-evals` repository and the exam records |

**How do exams run?** The exam environment puts the exam task into the database as an ordinary work item. The working environment carries out this work item like normal work; it does not need to know that the task is an exam. The exam environment scores the result against the answer key. So the role under test has no way at all to reach the answer key, and the risk of "behaving for the exam" is reduced.

**Within the session:** The main agent of the working session is the coordinator (DR06-G and DR06-Y). It starts the roles the work requires as subagents with their own role packages; it runs mutually independent work items in parallel. Each subagent's contribution is written to the database as a contribution, and the consuming side writes the use receipt. So even if the session is interrupted, the next session continues where it left off (Appendix D, D7).

**Where is thinking independence enough?** Non-binding reviews such as research review, design critique and frame review can be done in the working session by a subagent with a clean context and a different information view. Binding verdicts (acceptance, authority to merge, rule change) are given only in the audit environment.

---

## 3. Wake-up

Routines only make sessions start; they are not used for hand-overs between roles.

| Environment | Daily runs (initial) | Timing |
|---|---|---|
| Working | 3 long sessions | Night, early morning, evening (outside Batu's busy hours) |
| Audit | 3 | After each working session |
| Exam | 1 | Night, only when an exam is needed |
| Reserve | Up to 8 | An extra working session if sessions stay short, an urgent decision or recovery |

It starts with 7 runs in total; about half of the limit of 15 (up to 8 runs) stays in reserve. The real length of sessions is measured in C01; if it turns out short, the number of working sessions is increased from the reserve.

**Expectation:** Hand-overs between roles take minutes inside the working session. A binding verdict waits until the next audit session (a few hours). Decisions that belong to Batu are processed in the first session after Batu answers.

---

## 4. Other security and continuity decisions

- **Connectors:** Removed from every routine; in addition, the permission rules in the repository block calls to connector tools. The two layers are tested in C01 and C03.
- **Identity chain:** The environment token gives the role class; the claim token proves that this session did this work item. Subagents within a session share the same identity; so no work that requires separation of authority is done within a session.
- **Writing to the public repository:** The hooks in the repository and git's pre-push hook run the leak check before every push.
- **Session record:** Every session records itself at opening (environment, start, which routine). For urgent API triggers, the intent and the returned session ID are recorded; if the response is lost, the existence of the session is checked first.
- **Projects:** No longer required. If it is enabled on the account and verified in C01, it can be used to speed up the work of the working environment; the security model does not change, because authority comes from the key, not from the way the session was opened.
- **Usage sharing:** Heavy working sessions are placed outside Batu's working hours; their effect is measured; if Batu's work slows down seriously, this comes to Batu as a decision.

---

## 5. The cost of this decision and what is tested first in C01

**Cost:** If a working session goes down, all the roles running at that moment stop together; because the work continues from the database, there is no data loss, only delay. Subagents take a share of the session's usage allowance and context; very large work items are split across more than one session.

**The first lines of C01:**
1. How long a cloud working session can run while processing the queue; whether it carries on the work correctly after context compaction.
2. That subagents are started correctly with their role packages; that built-in helpers that skip `CLAUDE.md` are not used for role work.
3. That the connector blocks really work.
4. That the keys of the three environments cannot use each other's authority.
5. The usage share over one week of observation.

---

## 6. The lasting lesson from this incident

Frame blindness is the greatest danger for DevOS and for SOUL (Batu, 29 September 2026) (original: TR-A1). The sign this incident taught: **when a design runs into a limit and starts producing new mechanisms as the solution, the frame itself must be questioned first.** The mechanism for this goes into installation plan 2.1: a premise inventory, a mandatory frame review on a squeeze signal, and an independent session that sees only the purpose and the constraints working out its own design and comparing it with the current design.

*Translation note: English translation of the Turkish original at devos commit 3de3a17 (W-C00-06, plan C00 step 0). Since the fidelity review passed, this English text is binding (plan 0.6 item 1).*

---

## Turkish originals of Batu's decisions

**TR-A1** · Section 6 "The lasting lesson from this incident", first sentence · Çerçeve körlüğü DevOS'un ve SOUL'un en büyük tehlikesidir (Batu, 29 Eylül 2026).
