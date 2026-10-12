# T-W07-RT · Each environment's real token is refused another environment's authority on live state, and does its own

Synthetic test data (plan Section 8 item 13): every record these runs touch is written beforehand with the `devos_kurulum` token, through `devos_api`, under DM-23's test Mission. Its scope is `synthetic.real_token_tests`, and its purpose begins "Synthetic test fixture …". Every input reads `w07_fixture SYNTHETIC W-C02-07`. No synthetic record of class `batu` is written into `devos` (EV-C02-004 X-10). No token is seen, sent or written by a session: the proxy adds it (EV-C02-003 §1.1).

**Serves.** W-C02-12 points 4 to 7, and the real-token runs of N04's C02 part and of N17. C02 Acceptance, word for word: "✘ With each environment's real token, an operation that requires another environment's authority is rejected." and "✘ An operation with another session's claim, and with a fake session ID, is rejected." Design relied on:
- EV-C02-003 §1.5, §4.1, §4.2, §4.4, §6.2 and §15;
- EV-C02-002 §5 and DM-23;
- EV-C02-004 X-10 and X-13;
- README 5.3.

**Command.** A specification only: no file of this directory runs it. The cases are made by:
- one session in each of `devos-calisma`, `devos-denetim` and `devos-sinav`, from the one first message W-C02-12 writes (EV-C02-003 §6.2), each with `POST https://<devos host>/rest/v1/rpc/<function>` through W-C02-09's client path, the publishable key in `apikey`, and the proxy adding the header;
- the installation environment, with the `devos_kurulum` token;
- one step of the pull-request checks with the `devos_ci` key, which W-C02-12 adds for the run.

Each session writes its result file to its own `claude/` branch: role classes, outcomes and reason codes only.
**Time added to W-C02-13's run.** None to W-C02-13's own run: it counts these runs only if their envelope shows the same deployed migrations and function versions (W-C02-13 point 2). The runs themselves wait on Batu's steps 2 to 5. W-C02-12 point 3 states the time that adds on the critical path, with its source and date (PC-23).
**Interface assumed.**
- The same functions and refusal form as `T-W07-IDC`, `T-W07-5B`, `T-W07-N04` and `T-W07-N08`.
- The fixtures in `devos`: DM-23's test Mission, work items `W1` to `W4` under it, and the fixture IDs listed in W-C02-12's record.
- A role refusal's code (`role_class_not_permitted`, as assumed in `T-W07-5B`), told apart from a transport or missing-function failure.

## Rules every case follows (W-C02-12 point 7; README 5.3)

- The first call in each session is `token_role_class()`, that session's positive control (W-C02-12 point 4). Its answer is recorded beside the session's `DEVOS_ENVIRONMENT` value.
- Each ✘ case differs from an accepted ✔ case in the token, and so in the environment.
  - Where a ✘ case must name a record that only the ✔ session can create, it names that record when it exists, and otherwise an absent ID. The role gate refuses before any check of the target (B:47; shown in `devos-test` by `T-W07-6TK`'s `-b` cases). W-C02-12's record states which ID each case named.
  - The verdict cases name the audit session's review `R1` when they run after it (`RT-den-p2`). W-C02-12 orders the sessions so, where it can.
- A refusal for another reason (no network, no header, a missing function, or a Data API error of its own) is "could not check", never a pass.
- A case made within one session by declaration only is labelled so, and not counted as the real-session case.
- Each ✘ case names the `devos-test` test of the same rule, whose break stands for it (W-C02-12 point 8). No rule is broken in `devos`.

## Cases

| Case | Session (token) | Call | Expected | The `devos-test` test and break |
|---|---|---|---|---|
| `RT-cal-p1` | `devos-calisma` | `token_role_class()` | `devos_calisma` | `IDC-h-devos_calisma`; B-6TK-2 |
| `RT-cal-p2` | `devos-calisma` | `claim(W1)`, then an effect on `W1` with its claim token | accepted; the Event's `role_class` is `devos_calisma` (F06) | `T-W07-N17` positive |
| `RT-cal-n1` | `devos-calisma` | `record_verdict` naming `R1` | refused, role code | `N04-a1`, `5B-R07-record_verdict-cal`; B-5B-1 |
| `RT-cal-n2` | `devos-calisma` | `accept` naming `W1` | refused, role code | `N04-b1`, `5B-R07-accept-cal` |
| `RT-cal-n3` | `devos-calisma` | `record_eval_run`, and the EvalRun read (R10r) | refused | `N08-w-devos_calisma`, `N08-r-*`; B-N08-1 |
| `RT-cal-n4` | `devos-calisma` | `set_effort_policy` | refused | `5B-R08-set_effort_policy-cal`; `T-W07-N03` |
| `RT-cal-n5` | `devos-calisma` | `record_verdict` with a fake role name (`devos_denetim`) and a fake declared session ID | refused under `devos_calisma` | `N04-c1`, `N04-e1-*` |
| `RT-cal-n6` | `devos-calisma` | an effect on `W1` with no claim token | refused | `T-W07-N17` |
| `RT-cal-n7` | `devos-calisma` | an effect on `W2` with a fake declared session ID and `W1`'s claim token, after the same session claimed `W2` | refused | `T-W07-5C`, `T-W07-N17`. **Labelled: within one session, by declaration only** |
| `RT-cal-n8` | `devos-calisma` | "another session's claim": the same session holds `W1` and `W2` and uses `W1`'s token on `W2` | refused | `T-W07-N17`. **Labelled: within one session** (EV-C02-003 §6.2, last item) |
| `RT-den-p1` | `devos-denetim` | `token_role_class()` | `devos_denetim` | `IDC-h-devos_denetim` |
| `RT-den-p2` | `devos-denetim` | `open_review` on `W1` (`R1`), `record_verdict` on `R1`, `accept` on `W1` | each accepted; Events under `devos_denetim` (N04's positive) | `N04-p3`, `N04-p4` |
| `RT-den-n1` | `devos-denetim` | `register_artifact` (a product) and `record_finding` (a candidate) | refused | `5B-R06-*-den`; B-5B-1's method |
| `RT-den-n2` | `devos-denetim` | `record_eval_run`, and the EvalRun read | refused | `N08-w-devos_denetim`, `N08-r-*` |
| `RT-sin-p1` | `devos-sinav` | `token_role_class()` | `devos_sinav` | `IDC-h-devos_sinav` |
| `RT-sin-p2` | `devos-sinav` | `admit_work` (an exam task as ordinary work) under the test Mission | accepted; Event under `devos_sinav` | `5B-R02-admit_work-sin` |
| `RT-sin-n1` | `devos-sinav` | `register_artifact` (a product) | refused | `5B-R06-register_artifact-sin` |
| `RT-sin-n2` | `devos-sinav` | `record_verdict` naming `R1` (a verdict) | refused | `5B-R07-record_verdict-sin` |
| `RT-kur-p1` | installation (`devos_kurulum`) | `token_role_class()` (EV-C02-003 §3.3's self-check) | `devos_kurulum` | `IDC-h-devos_kurulum` |
| `RT-kur-p2` | installation | writing the fixtures: `open_mission` (on D-010's record), `admit_work` for `W1` to `W4` | accepted; Events under `devos_kurulum` | `5B-R03-open_mission-kur`, `5B-R02-admit_work-kur` |
| `RT-kur-n1` | installation | `issue_env_token` | refused, by `devos_private` not exposed (PGRST106) or no EXECUTE (42501): the designed closures of B:46 and EV-C02-003 §6.3 route 4, not a "missing function" | `IDC-n-issue-token-devos_kurulum`; B-IDC-1 |
| `RT-kur-n2` | installation | `record_verdict` naming `R1`, and `accept` naming `W1`, outside the transfer | refused | `N04-k1`, `N04-k2`; B-N04-1 |
| `RT-kur-n3` | installation | `record_eval_run`, and the EvalRun read | refused | `N08-w-devos_kurulum`, `N08-r-*` |
| `RT-kur-n4` | installation | the RejectedAttempt read (R15) | refused (EV-C02-004 X-13) | `5B-R15-*-kur` |
| `RT-kur-n5` | installation | `record_verdict` with a fake role name and session ID | refused under `devos_kurulum` | `N04-k6` |
| `RT-ci-p1` | PR check (`devos_ci`) | `deployment_drift` | answers a comparison status, not a refusal (W-C02-12 point 4) | `IDC-dd-devos_ci` |
| `RT-ci-n1` | PR check | `record_verdict` and `open_decision` | refused (B section 2: "Writing verdicts or decisions") | `5B-R07-record_verdict-ci`, `5B-R02-open_decision-ci` |
| `RT-s8l2` | none | a claim token used with another role class's token (S8 line 2; W-C02-12 point 6) | **not made with real tokens.** It would carry a claim token from one environment's session to another's, and the only channels between them are public (issue #6, the repository) or Batu (CLAUDE.md, "Secrets"). Labelled so, as W-C02-12 point 7 provides. | `T-W07-N17` (PC-43 place 11) in `devos-test`, and its break |
| `RT-reg` | none | a claim without a registration of the same role class (S8 line 3) | moved to C04 (EV-C02-003 §4.4; N-223) | none in C02 |

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W07-RT. **[Designer's addition: the real-token runs have no Appendix C entry of their own; C02 Acceptance, R2 section 5 (b) and W-C02-12 points 4 to 7 ask for them.]** In `devos`, each environment's real token, reaching the database by the route W-C02-05 designs, gets its own role class. It does its own operation, and is refused every operation reserved to another class that the runs try. |
| **Failure class rule** | A real token that derives a class other than its environment's. Or one that does another environment's reserved operation on live state. Or a refusal that rests on something other than the role class (so the separation is not shown). |
| **Examples** | (1) The original finding (R2 section 5 (b)): only working→audit was ever tried (`RT-cal-n1`, `RT-cal-n2`). (2) Another manifestation: audit→product (`RT-den-n1`), exam→verdict (`RT-sin-n2`), installation→exam records (`RT-kur-n3`). (3) Another: a token in the wrong environment, seen by `RT-*-p1` against `DEVOS_ENVIRONMENT` (EV-C02-003 §6.2). |
| **Negative control** | Every `RT-*-n*` case: refused with a role code, recorded by the database (the executor reads RejectedAttempt in `devos` through the read-only connection, EV-C02-004 X-13), and nothing changed. |
| **Positive control** | `RT-*-p*`: the first call in each session, and each class's own operation, accepted, with the Event's `role_class` equal to the environment's class. |
| **Break attempt** | No rule is broken in `devos` (EV-C02-002 §5; W-C02-12 point 8). Each ✘ case's break is that of the `devos-test` test named in its row, shown on the throwaway database: B-5B-1, B-5B-2, B-N04-1, B-N08-1, B-N08-2, B-IDC-1 and B-6TK-1/2, with their `expect-red` lists. W-C02-13 point 3 records that the throwaway target carries the same rule version. |
| **Stage and environment** | C02. `devos` only, live state (EV-C02-003 §1.5). Claude environments: `devos-calisma`, `devos-denetim` and `devos-sinav` (Batu's step 5), the installation environment `devos-kurulum` (`devos_kurulum` token), and the pull-request checks (`devos_ci` repository secret). Relies on EV-C02-003 §3.3's observation of the header path in `devos`, and on the fixtures of DM-23. |
| **Independence level** | Written by the test designer (fresh-context `test-designer` subagent, phase B, Group D; agent ID in W-C02-07's Record). Run by the session in each environment (W-C02-12), from W-C02-12's first message, which none of those sessions wrote. Judged by W-C02-12 point 12's fresh-context checker, from the sessions' raw result files on their branches and the database's records, not the executor's account. Shared: model lineage, and the design records. |
| **Evidence layer** | Behavioural, of the configuration: each token is stored in its environment, the proxy adds the header, and the database derives the class and refuses across environments. It does not show breaks, a second real session in one environment, that a session cannot read its token beyond the places scanned (EV-C02-003 §3.2), `devos_backup` (no credential before C09), or the control surface between environments (C03 test 3). |
| **Evidence envelope** | README section 4.<br>Fixed before the run: the expected column above, per case.<br>`target_commit`: `main`'s head deployed in `devos`. `deployment_config_ref`: `devos` with its reported version, `deployment_drift`'s answer and the function versions.<br>`transport`: `real-token`.<br>`observations_ref`: each session's branch and result file, the PR check's run ID, and the executor's read-only query of Event and RejectedAttempt by fixture ID. `raw_evidence_ref`: under `evidence/C02/raw/`, after README section 4's hygiene checks. |

## Clause table

No Appendix C entry of its own. It carries the real-token runs of N04's C02 part and of N17:

| Clause | Case IDs |
|---|---|
| N04 "A binding verdict or an acceptance with the working environment's token is rejected" | `RT-cal-n1`, `RT-cal-n2` |
| N04 "a fake role name and a fake session ID with the same token" | `RT-cal-n5` |
| N04, the `devos_kurulum` token outside the transfer | `RT-kur-n2`, `RT-kur-n5` |
| N04's positive | `RT-den-p2` |
| N17 "An effect attempt with another session's claim or without a token is rejected" | `RT-cal-n8` (labelled within one session), `RT-cal-n6` |
| N17 "a claim token … when the caller's environment token gives a role class other than the claim's" | `RT-s8l2`: not made with real tokens, reason stated; `T-W07-N17` |
| N17's positive | `RT-cal-p2` |

## Format gate

Not a format-gate test.

## Could not check

- A session whose first call does not answer its own class; then its other cases are not counted.
- A refusal for another reason (no network, no header, a missing function, a Data API error).
- A fixture absent in `devos`.

## Not covered

- Breaks.
- A second real session in one environment (the within-one-session cases are labelled).
- `devos_backup` (C09).
- The control surface between environments (C03 test 3).
- The network level and the guard's presence in each session: W-C02-12 points 4 and 10, not database cases.
- The format scan (`T-W07-6SC`; W-C02-12 point 9).
