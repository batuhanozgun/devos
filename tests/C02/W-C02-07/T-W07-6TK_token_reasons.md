# T-W07-6TK · A call without a verified token is refused first, with its own reason code, and never let through

Synthetic test data (plan Section 8 item 13): the tokens are synthetic tokens issued at run time. Part A issues them in its rolled-back transaction; part B gets them from the job for this run. Every malformed or unknown value is made from them in memory, at run time. Inputs read `w07_fixture SYNTHETIC W-C02-07`.

**Serves.** W-C02-09 point 3 ("✘ A call with no token, an empty or malformed one, one whose hash matches no row, a revoked one … is each refused before any other check, and the attempt is recorded with its reason") and point 7 ("the token header absent"), and W-C02-07 point 6 for the derivation (GROUPS.md section 3, its first row). Design relied on:
- EV-C02-003 §15, the row "A call whose token is missing, empty, malformed, unknown or revoked, or whose header cannot be read";
- Appendix B 3.27 as PC-43 place 7 writes it;
- EV-C02-002 DM-19 (counted rows, `role_class = none`);
- EV-C02-004 X-04 and X-06;
- `shared/token_format.md` section 4 (what each code means).

**Command.**
- Part A: (statement timeout 120 s, README 5.1 (a)) `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_6tk_token_reasons.sql` in `devos-test`, by the job's test step as `postgres`, and on the throwaway database by the harness.
- Part B: `python3 -I tests/C02/W-C02-07/bin/6tk_http_reasons.py < <JSON from the job>`. The job must run it in its `devos-test` step, giving it one `devos_denetim` token and one revoked token (the executor's decision 3).

**Time added to W-C02-13's run.** None: it waits on no schedule or limit.
**Interface assumed.** As `T-W07-IDC` ("Interface assumed"). Beyond it:
- the six reason codes are spelled as EV-C02-003 §15 spells them;
- the derivation's own input is `env_tokens`' columns `token_hash`, `revoked_at` and `role_class`;
- the second function of the `-b` cases is the first that exists of `revoke_claim`, `record_verdict`, `accept`, `open_review`, `set_effort_policy`, `record_eval_run`, `mark_exported` and `open_mission`. Each refuses `devos_calisma` by its role list (EV-C02-003 §4.1).

## Cases

Part A. Every token case is judged by one rule: refused with exactly its code; counted once in the row (function, code, `none`); no other RejectedAttempt row; no event; no table changed; no presented value echoed; not raised. A raise would roll the record back.
- **Header unreadable.**
  - `6TK-hu0-a`, run first, before anything in the transaction sets `request.headers`: the setting never set, as through Realtime or Storage.
  - `6TK-hu1-a` and `-b`: the empty string.
  - `6TK-hu2-a`: not JSON.
  - `6TK-hu3-a`: a JSON array.
  - `6TK-hu4-a`: a JSON string.
- **Missing.**
  - `6TK-mi1-a` and `-b`: the empty object.
  - `6TK-mi2-a`: the key with JSON `null`.
  - `6TK-mi3-a`: a valid token under another header name.
  - `6TK-mi4-a`: under the header name in another case. PostgREST gives names in lower case.
- **Empty.** `6TK-em1-a` and `-b`.
- **Malformed.**
  - `6TK-ma1-a` and `-b`: cut by one character.
  - `-ma2`: one character added.
  - `-ma3`: the marker's first character changed.
  - `-ma4`: `=` padding.
  - `-ma5`: a leading space.
  - `-ma6`: the marker in upper case.
  - `-ma7`: a space inside.
- **Unknown.**
  - `6TK-un1-a` and `-b`: one character of the random part changed.
  - `6TK-un2-a`: the last character changed.
- **Revoked.** `6TK-rv1-a` and `-b`.

`-a` is `token_role_class()`. `-b` is the second function with neutral arguments. Its role list and its arguments would each refuse the call for another reason, so a token code there shows the token is checked first.

**Kept apart.**
- `6TK-ka1`: a verified working token on the second function gets a role refusal, recorded once per call under `devos_calisma`, with a code that is not a token code.
- `6TK-ka2`: a verified audit token is accepted as `devos_denetim`.

**The derivation's own input, missing, unreadable or partial.** `6TK-h1`: `env_tokens` renamed. `6TK-h2`: `token_hash` renamed. `6TK-h3`: `revoked_at` renamed. `6TK-h4`: `role_class` renamed. Each is planted as owner inside the case's undone subtransaction. A valid audit token must not be let through: there is no role class, no event and no change, whether the function refuses or errors.

At the end, a notice gives the counts of the derivation's answers: clean (accepted), fail (`unknown`, `revoked`, role) and "could not check" (`missing`, `empty`, `malformed`, `header_unreadable`, stored input), with the denominator (README section 3).

Part B, over the Data API:
- `6TK-http-missing`, `-empty`, `-malformed`, `-unknown` and `-revoked`: each is refused with its code as the function's answer, HTTP 200.
- `6TK-http-ok` (the positive): the audit token is accepted.
- `6TK-http-get1`: a GET with no header, which the Data API runs read-only (N-244 item (2)). Its named result: never accepted, as either a refusal or an error.
- `header_unreadable` is not made over the Data API. The Data API always sets `request.headers`, so that code arises only on paths that do not (EV-C02-003 §15's example); part A plants it.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W07-6TK. **[Designer's addition: no Appendix C entry; W-C02-07 point 6 and EV-C02-003 §15 ask for it.]** Every input that does not give a verified token is refused before any other check, with its own reason code, and counted under `none`. Each such answer differs from a wrong-role-class refusal and from acceptance. When the derivation's own stored input is missing, unreadable or partial, no call is let through. |
| **Failure class rule** | Any input that is not a verified token yielding a role class, a default class, a pass, a refusal under the wrong code, a refusal that is not recorded (or is rolled back), or a refusal decided after another check. |
| **Examples** | (1) The original finding: a missing token (`6TK-mi*`; EV-C02-003 §15; B 3.27, "never a default role class"). (2) Unreadable headers (`6TK-hu*`). (3) Partial or altered tokens (`6TK-ma*`, `6TK-un*`). (4) A revoked token (`6TK-rv1-*`). (5) Unreadable stored input (`6TK-h*`). |
| **Negative control** | Every case of the examples above. What must be observed is the judging rule under "Cases", which includes "nothing changed": no event, no table count changed, and no row beyond the one counted row. |
| **Positive control** | `6TK-ka2` and `6TK-http-ok`: the same function and route with a verified token is accepted. `6TK-ka1`: a verified but wrong class is refused under its class, not under `none`. Each differs from a negative in the token only. |
| **Break attempt** | Each patch is applied by the harness on the throwaway database (README 5.2). The red cases are fixed here.<br>**B-6TK-1** (`breaks/B-6TK-1_revoked_token_verified.sql`). Removed: the revocation test inside `devos_private.caller_role_class`'s own text (`revoked_at is not null` becomes false). Red: `6TK-rv1-a`, `6TK-rv1-b`, `6TK-h3` and `IDC-r2`.<br>**B-6TK-2** (`breaks/B-6TK-2_token_refusals_not_counted.sql`). Removed: DM-19's count of calls without a verified token; a trigger drops RejectedAttempt rows under `none`. Red: every token case, from `6TK-hu0-a` to `6TK-rv1-b` (26 cases), and `IDC-r2`.<br>**B-5B-2** also turns `6TK-ka1` red: `revoke_claim` admits the working token.<br>If the build's derivation tests revocation in another form, B-6TK-1 refuses to apply ("not a break shown"). The prober then writes the same one-test change for that form, keeping the red list. |
| **Stage and environment** | C02. Part A: `devos-test`, by the job's test step, and the throwaway database. Part B: `devos-test`'s Data API, from the same step. No real token is used. Relies on EV-C02-003 §1.1 and §1.6. |
| **Independence level** | As `T-W07-IDC`: written by the test designer (fresh-context `test-designer` subagent, phase B, Group D; agent ID in W-C02-07's Record); run by the job, W-C02-09's producer and W-C02-13's prober; judged by a fresh-context checker that wrote none of the tests. Shared: model lineage, the design records and the README. |
| **Evidence layer** | Structural and behavioural, at the database. Part A's header is simulated (`sql-set-role`). It does not show what an unlisted transport (Realtime, Storage) actually sets, or anything in `devos`. |
| **Evidence envelope** | README section 4.<br>Fixed before the run: every case `ok`. Part A has 32 cases where every function exists (1 + 19 `-a` cases, 6 `-b` cases, 2 kept apart, 4 stored input). Part B has 7. Each break's red list is as above. The notice counts the `-a`, kept-apart and stored-input answers (not the `-b` repeats). Expected: clean 1, fail 4, could not check 21, of 26. These are `ka2`; `un1-a`, `un2-a`, `rv1-a` and `ka1`; and `hu0` to `hu4`, `mi1` to `mi4`, `em1`, `ma1` to `ma7` and `h1` to `h4`.<br>`transport`: part A `sql-set-role` or `throwaway`; part B `data-api-synthetic`.<br>`observations_ref` and `raw_evidence_ref` as `T-W07-IDC`. |

## Clause table

Not an Appendix C test. EV-C02-003 §15's row maps as follows:

| Clause | Case IDs |
|---|---|
| missing | `6TK-mi*`, `6TK-http-missing` |
| empty | `6TK-em1-*`, `6TK-http-empty` |
| malformed | `6TK-ma*`, `6TK-http-malformed` |
| unknown | `6TK-un*`, `6TK-http-unknown` |
| revoked | `6TK-rv1-*`, `6TK-http-revoked` |
| header unreadable | `6TK-hu*` |
| "refused before any other check" | every `-b` case |
| "`none`, never a default role class" | every `-a` and `-b` case's counted row |
| point 6's "kept apart from clean and fail" | `6TK-ka1`, `6TK-ka2`, and the notice's counts |

The burst count belongs to `T-W07-DM19B`, Group B.

## Format gate

Not a format-gate test.

## Could not check

The whole test gives COULD NOT CHECK before the build (`6TK-pre`), or when its tokens cannot be issued (`6TK-tokens`). Individual cases give it as follows:
- `-b` and `ka1`, while no function that refuses `devos_calisma` exists. At the identity chain's first part only `token_role_class()` exists, so those cases wait for W-C02-09's later functions; the first part's acceptance takes `T-W07-IDC`.
- `rv1-a`, when the revocation cannot be called;
- `h*`, when the state cannot be planted;
- part B, while the job gives no input, or when the route turns an empty header into none (`6TK-http-empty`).

## Self-check (not a result)

On 2026-10-12, on PostgreSQL 16.15, against the scratch stub described in `T-W07-IDC`:
- without the build: COULD NOT CHECK;
- with the stub: PASS (32/32);
- B-6TK-1 and B-6TK-2: their red cases were exactly their `expect-red` lists, in both files.

Part B gave COULD NOT CHECK (exit 3) without input. During the self-check, a first stub raised its refusal instead of returning it; `IDC-r2` turned `bad`, which shows the rule "a raised refusal loses its record" is enforced.

## Not covered

- `devos` and real tokens (`T-W07-RT`).
- The burst bound (`T-W07-DM19B`).
- Whether Realtime or Storage reach `devos_api` at all.
- A header value that PostgREST itself rejects before the database: that is a transport refusal, and nothing reaches the derivation.
