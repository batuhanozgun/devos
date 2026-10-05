# Evaluation of the independent Claude review

**Date:** 29 September 2026 · **Reviewed:** Installation plan 2.0 and Appendices A–G · **Reviewer:** A separate Claude chat that had not seen this conversation · **Evaluator:** The session that wrote the plan

**Evaluation method:** Each finding was weighed with the warning "since I am the one who wrote the plan, I may tend to defend it" (Appendix D, D2). High-impact factual claims were checked again against the primary source. Decision types: **Accept**, **Partial accept** (the finding is correct, the proposed fix was changed), **Reject**.

**Summary:** 29 findings and a heading note. 25 accepts, 4 partial accepts, 0 rejects. All three of the three critical findings turned out to be correct.

---

## Factual claims verified again

| Claim | Result | Source |
|---|---|---|
| All the connectors on the account are added to routines by default; the session can use them, including for writing, without permission | **Correct** | Claude Code routines documentation (code.claude.com/docs/en/routines) |
| At most 15 routine runs a day on the Max plan | **Correct.** In the plan I had said "not written in the official documentation"; it is written in Anthropic's official announcement. My mistake | claude.com/blog/introducing-routines-in-claude-code |
| Claude Code Projects came out in beta on 17 September 2026: a coordinator conversation distributes the work to parallel cloud sessions | **Correct.** There are also new features the plan never evaluated, such as messaging between sessions (August 2026) and projects being able to create routines | Several independent news sources; Anthropic announcement |
| GitHub Free has no branch protection on private repositories | **Correct.** Protection on a private repository requires GitHub Pro | docs.github.com, protected branches |

---

## Finding-by-finding evaluation

| # | Decision | Rationale and the change to be made |
|---|---|---|
| Heading | Accept | Plan Section 2 still says "31 items"; it was not corrected when 32 and 33 were added. It will be corrected. |
| 1 | **Accept (critical)** | My security design focused only on the database gate; it did not inventory through which other channels (connectors) the agent can produce effects. This is a failure class: **missing effect channel inventory**. Fix: removing the connectors for every routine and environment becomes an installation step; a connector inventory is added to C01, and the negative test "no connector tool is visible in a DevOS session" to C03; an inventory of "all the channels through which the agent can produce effects" goes into the plan as a principle. |
| 2 | **Accept (critical)** | In a public repository, content is published the moment it is pushed to a branch; the PR check comes too late. Because this concerns Batu's visibility decision, it goes to Batu as a decision (Decision K6). C03 #7 will be run with fake "secret" text. |
| 3 | **Accept (critical)** | The wake-up architecture does not fit into 15 runs a day. This is a fundamental design problem of the plan and cannot be left aside by saying "it is tested in C01". There are also new options the plan did not evaluate (the Projects coordinator, messaging between sessions, a long-lived session, one-shot scheduled runs that are reported not to count toward the limit, extra usage). The wake-up and capacity architecture will be researched and redesigned; the options will come to Batu with their costs. |
| 4 | **Accept** | Correct: Supabase's secret key bypasses the access rules; the old key scheme is being retired. Design: environments are given only the public (publishable) key + an environment token in a separate header; the token's hash is kept in the database and every `devos_api` function derives the role class from it. Batu generates the token by running a single ready-made SQL line in the Supabase dashboard; the value is shown once, Batu pastes it into the settings field of the Claude environment; the builder never sees the value. The secret key is explicitly forbidden in agent environments. |
| 5 | **Accept** | Correct: the database can verify only the environment; the session ID and the role name rest on declaration. Every pair that requires separation will be put in different environments; separation at session level will be labelled "declaration-based"; false-declaration examples will be added to N03 and N04. The increase in the number of environments will be designed together with #3. |
| 6 | **Accept** | The exam execution path was undefined. A separate exam environment and database role; the role under test receives the task in its own environment as normal work; the answer key only in the exam environment. The exam of the review roles is prepared by another environment. It will go into the capacity calculation together with #3. |
| 7 | **Accept** | The backup format and the Actions minutes budget had not been designed. Reproducible data (vectors) is left out of the backup, and the source and model version are recorded in its place; the dump size and the minutes budget are calculated before C04; storage location options come to Batu with their cost if needed. |
| 8 | **Accept** | Some items in Section 10.1 had not actually been solved. They will be moved to 10.2: capacity and wake-up, exam execution, key-role mapping, reconnection, backup format. (Most of them will be designed in this revision; what cannot be designed will stay open.) |
| 9 | **Accept** | The scope of the "only fake data" rule is unclear; the search benchmark uses the real library. The scope is Batu's decision (Decision K7). |
| 10 | **Accept** | The model access layer will be designed and built in C08; the minimum product scope of the C11 testing will be written in advance; the Claude leg will be run with a session within the subscription. |
| 11 | **Accept** | The "backup channel that surely gets through" will be made measurable: a decision not opened within a set time is repeated through the second channel. B3 (a), the machine account, also solves this problem: since the machine account will open the issues, Batu gets notifications. |
| 12 | **Partial accept** | Correct: Batu's technical approvals outside his expertise can turn into a pro forma signature. But in work that changes check and authority rules, a human gate is valuable against agents silently changing their own rules. Fix: technical correctness is determined by independent review; Batu gets only a plain acceptance question in terms of purpose and risk; the number of approvals is measured in C06–C07. |
| 13 | **Accept** | The database can enforce only that a field is filled, not that the step was really done. These rules will be called a "format gate"; the content will be tied to sample review; a "filled but meaningless" example will be added to the tests. |
| 14 | **Accept** | A `devos_backup` role with read-only authority for the backup job; the transfer marker only through a function. It will be tested in C03. |
| 15 | **Accept** | On restore, reconnecting the environments, routines and checks to the new project will be added to the steps and to Batu's work list; in the drill, at least one environment will really be reconnected. |
| 16 | **Accept** | The routine shutting itself down if the GitHub connection breaks, and the monitoring component depending on the things it monitors, will be added to G7 and to the risks; at least one monitoring path will be independent of DevOS. (The 72-hour period will be verified in C01.) |
| 17 | **Accept** | DevOS shares the same limits as Batu's own Claude usage. This mutual effect will go into U-5 and into the capacity decision. |
| 18 | **Accept** | The API table will be completed; "automatic" detection of constraint conflicts is a wrong wording — which role searches for them and when will be written down. |
| 19 | **Accept** | Every request going to the second model will pass through a single function, the leak check and a record; the low free quota will go into the capacity plan. |
| 20 | **Accept** | Claude Code Projects and messaging between sessions will be evaluated as material alternatives in the redesign of #3. Whether Projects is enabled on Batu's account will be checked before C01 (the beta was opened first to users with no existing projects; Batu has existing projects on claude.ai). |
| 21 | **Partial accept** | Correct: preparing exams for all 18 roles from the start can steal capacity from SOUL. But dropping down to role groups weakens criterion 32. Fix: the 18 role contracts are kept; roles are activated as they are needed (already "not all of them are active at all times"); the exam and the preparation are done as the role is activated; the initial active set is limited to the roles that C07 requires. |
| 22 | **Accept** | Criterion 3 will be explicitly handed over to the SOUL requirements record; a minimum product scope will be written for criterion 2. |
| 23 | **Accept** | Acceptance conditions will be added for retiring a role, the process limit and regular operation (for example, a few days of unattended operation). |
| 24 | **Accept** | Memory and latency will be added to the C04 measurement. |
| 25 | **Partial accept** | Two sources conflict: DEVOS-002 says the account plugins are loaded, the review says they are not. The label will be changed from "[Verified]" to "[Awaiting verification; sources conflict]"; it will be observed in C01. |
| 26 | **Accept** | The labels will be updated with the primary source and the date; `gte-small` is defined in the official documentation as English-only (my assumption was confirmed). |
| 27 | **Accept** | The wording "the checks must pass at that moment" is too strong; it will be corrected. Automatic merge will be tested separately in C01. |
| 28 | **Accept** | A single key inventory: key, owner, location, authority, revocation path. |
| 29 | **Partial accept** | The contradictions are real; the "open the file" wording in D9 and DR16 will be written for stage B as "search the library and fetch the source body through `devos_api`"; `.claude/protocols/` will be added to the tree; the `session_brief` signature will be made single. |

---

## What did this review teach?

The common cause of the three critical findings: the plan was built without reading the platform features deeply enough from current primary sources, and it thought about security only through one channel (the database). These two failure classes will be added as principles in the new revision:

1. **Current platform reading:** Every platform behaviour the plan relies on is read from the current version of the official documentation, with its date; a secondary source does not count as "[Verified]".
2. **Effect channel inventory:** Every channel through which the agent can produce effects in the world (database, GitHub, connectors, network, second model) is kept in a single list, and a limit and a negative test are written for each one.

---

## What comes to Batu for decision

- **K6 — The visibility of the `devos` repository** (#2).
- **K7 — The scope of the "only fake data" rule** (#9).
- The wake-up and capacity architecture (#3) will come with its options after research and redesign.

*Translation note: English translation of the Turkish original at devos commit 3de3a17 (W-C00-06, plan C00 step 0). Since the fidelity review passed, this English text is binding (plan 0.6 item 1).*
