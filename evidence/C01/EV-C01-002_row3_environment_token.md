# EV-C01-002 · C01 row 3 under PC-21 item 4: the environment token, from the platform's documentation (W-C01-35)

**What this is.** This is the evidence for W-C01-35 (`plan/work/W-C01-35.md`), which replaces W-C01-08 under FR-05 and PC-21. Item 4 of the PC-21 note under C01 says row 3 is established from the platform's current official documentation, read with its date. That documentation is read here for two questions: whose an environment's variables and secrets are (per environment or shared), and whether a session can read its own environment's variables and secrets. The record then hands the token's form to C02's token design (note N-131 on `plan/work/C02.md`), and with it the branch of row 3's fail path for a session that can see its own token. It also disposes of the N-063 rows this item serves (D07, P3, U1, U3, Q1, B4). Only documentation was read. Nothing here observes the platform's behaviour, and no trial was made (FR-05 A.2; D-017).

## Disciplines (D1–D9)
D1: yes: I kept "per environment" apart from "not readable across environments" and carried both documented token forms as alternatives instead of settling on one.
D2: yes: I did not let the counter-assessment's preferred form or PC-21's wording set the reading; the setup-script gap in PC-21 item 9 and the criterion 26 tension are recorded, not smoothed over.
D3: yes: each of the item's three acceptance conditions and the envelope maps to a section, and the choice of form and the fail-path decision are left to C02 (stage authority).
D4: yes: every fact taken from the documentation is labelled "not independently tested", and the independence level is declared as same-session, fresh-context only.
D5: yes: I checked that the fetched text was the raw page (S1 byte-identical with a read-only curl copy; every quote string-checked in S1 to S3), and read the N-063 rows at their source in EV-C00-012, not through the note's summary.
D6: no
D7: uncertain: the record is self-contained (sources, places, dates) so a new session can act on it; the write and the N-131 addition stay with the executor.
D8: yes: I confirmed the checkout is at `7d07ef7`, read the item's acceptance block and the PC-21 note at that commit, and treated the cancelled W-C01-08 as replaced by this item.
D9: uncertain: the question is about current platform behaviour, so it was read from the current primary source rather than the library (D9 item 4); the result is a dated documentation reading recorded at claim level, not adopted knowledge.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `7d07ef7d36efa2f6a9dbbbe7d2ace4eafa3e2389` (PR #201, W-C01-31's re-plan under FR-05 and PC-21), at which W-C01-35's acceptance condition is in force |
| Deployment configuration | Working session `session_01XyxvJd3RayQk4HCrjurbVH`, cloud. The Claude Code version is not recorded: the researcher's read of it was denied by guard rule B7 (decision #520), and `get_session` gives it. The pages describe the current platform, not this session's version |
| Criterion version | W-C01-35's acceptance block at `7d07ef7`; plan C01 row 3 and the PC-21 note under C01 (items 4 and 9) at the same commit |
| Input | The two questions above, given to a researcher subagent together with: W-C01-35's acceptance block; plan C01 row 3 and its fail path; PC-21 note items 4 and 9; plan 6.3 ("Key arrangement", "Network"); note N-131; the N-063 rows D07, P3, U1, U3, Q1 and B4 (`evidence/C00/EV-C00-012_counter_design_comparison.md` sections 3 to 5); and `evidence/C01/raw/FR-05_counter_assessment.md` sections N1 and N3 |
| Actual observation | Sections 1 and 2: what the documentation states, quoted, and what it does not state. Section 3: the recorded claim. Section 4: the dispositions. Documentation only |
| Raw evidence ID | this researcher report, working session above, 2026-10-10 |
| Independence level | same session, fresh-context researcher subagent (declared, Ek A 5.3) |

**The documentation read.** Official Claude Code documentation, all read on 2026-10-10 (fetches at about 22:30Z):
- S1 https://code.claude.com/docs/en/cloud-environments ("Configure cloud environments")
- S2 https://code.claude.com/docs/en/claude-code-on-the-web ("Use Claude Code in the cloud")
- S3 https://code.claude.com/docs/en/routines (linked from S1 and S2 for the environment a routine uses)
- S4 https://code.claude.com/docs/en/security (linked from S2). Its cloud section says nothing on an environment's variables or secrets beyond S2.
- S5 https://code.claude.com/docs/en/env-vars (linked from S2). Searched only for statements on a cloud environment's variables or secrets; see section 5.

**Page dates.** No page shows a last-updated date. The server's Last-Modified header equals the time of each request, so it is not a content date. The date recorded is the reading date.

**How read.** The fetch tool returned each page's raw text. S1's copy was byte-identical with a read-only `curl` of the page's markdown form, and every quote below was checked against the raw text of S1 to S3. No secondary source was used.

## 1. What is stated

### 1.1 Whose an environment's variables and secrets are

- **An environment belongs to the account.** "Environments you create are personal to your account" (S1, "Configure your environment"). A cloud environment is "the saved configuration that controls network access, environment variables, and setup scripts" (S2, "Cloud environments").
  - Organization-shared environments exist only on Team and Enterprise plans (S1). Batu's plan is Max (criterion 25), so they do not apply.
- **Variables are set on the environment**, "for the session" (S1, opening). A routine uses "a cloud environment that controls network access, environment variables, and setup scripts", and "The routine inherits the environment's network policy on every run" (S3, "Environments and network access").
- **A network secret is stored on the environment.** It is "an API key or token you store on a cloud environment so Claude can call that API from any session in the environment without seeing the key". It "applies in every session that runs in the environment, whoever started it, until you delete it" (S1, "Add network secrets").
- **The network setting is per environment.** "Each environment sets one network access level", and "Each environment has its own allowed-domains list" (S1, "Network access").
- **Some things are account-wide, not per environment** (S3):
  - "Routines belong to your individual claude.ai account."
  - "Anything a routine does through your connected GitHub identity or connectors appears as you: commits and pull requests carry your GitHub user."
  - "Connectors are the claude.ai integrations on your account."
- **Network secrets have plan and setup conditions** (S1, "Requirements"):
  - They are "available on Pro and Max plans. They aren't available on Team or Enterprise plans yet".
  - They exist only on an Anthropic-hosted environment that already exists.
  - The API they are sent to must accept connections from the internet.
  - On Pro and Max, "you hold" the role that adds them "in your own organization".
  - The page names no charge for them.

### 1.2 Whether a session can read its own environment's variables and secrets

- **Variables: yes.**
  - "A session reads the environment's values into ordinary environment variables that any command Claude runs can read, except `OTEL_*` variables" (S1, "Set environment variables").
  - "Anyone who uses the environment can read the values" (S1, same section).
  - "Anyone who uses the environment can read its environment variables and setup script" (S1, "What carries over from your setup").
  - For routines, variables are "visible to anyone who uses the environment" (S3).
- **Network secrets: no, in the documentation's words** (S1 unless marked):
  - Sessions use the key "without seeing the key".
  - The agent proxy "adds the key to requests for the hosts you list, after each request leaves the session's VM, so the key itself stays outside the VM".
  - "the key doesn't appear in the session's environment variables or in any file".
  - Network secrets "give sessions a key they can't read".
  - "You can't view the value again after saving."
  - S2 ("Security and isolation"): network secrets "stay outside the sandbox".
- **The documentation's own advice:** on Pro and Max, put a key the agent proxy can attach into a network secret, not a variable (S1, S3).

### 1.3 Points that bear on the token's design and on 6.3 "Network"

- **Header.** A secret's default type is Bearer, sent in `Authorization`. "For a header like `X-Api-Key` that takes the bare value, change the name and clear the prefix" (S1, "Add a secret").
- **Which requests get the secret** (S1):
  - Requests whose host matches a host listed on the secret. "Sessions can reach those hosts even when the environment's network access level wouldn't otherwise allow them."
  - Never: GitHub, the Anthropic API, public package registries, setup-script requests, or the telemetry export.
  - "Two secrets whose hosts overlap without matching exactly get no marker, and the agent proxy sends only one of them."
- **Network levels** (S1, "Access levels"):
  - The levels are None, Trusted, Full ("Any domain") and Custom.
  - At any level, sessions still reach GitHub through its proxy, enabled connectors, the network secrets' hosts, and "The Anthropic API, for Claude Code's own requests, even at None".
  - With network access disabled, Claude Code "can still communicate with the Anthropic API, which may allow data to exit the VM" (S2).
  - The Trusted default list on S1 names no Supabase domain (searched 2026-10-10).
- **Changes** (S1):
  - After a variable changes, an existing session "keeps the values it last read until its VM is next restored or rebuilt".
  - A secret cannot be edited; it is deleted and added again.
  - When an environment is archived, "Network secrets on the environment stay attached in its running sessions."
- **Routines:** "Routines are in research preview. Behavior, limits, and the API surface may change." (S3)

## 2. What is not stated

1. **Nothing across environments.** The pages do not say that a session in one environment cannot read another environment's variables or secrets, or whether it can read or change another environment's settings. They state what an environment holds and what its own sessions read, nothing more. This is row 17's cross-environment part. PC-21 item 7 takes its unfavourable case as the design, and N-131 item (1) carries it to C02.
2. **Nothing in row 3's words "by any route".** For a network secret the documentation says "without seeing the key", "stays outside the VM", "doesn't appear in the session's environment variables or in any file" and "can't read", and nothing broader. What a service sends back in its response is that service's behaviour, not the platform's; for DevOS that service is its own database (section 4 (a)).
3. **Whether the database can take the token from the header a network secret carries.** This is a Supabase fact, not a Claude Code one, and was not read here. It is C02's to show.
4. Whether two secrets with exactly the same host are both sent.
5. Any charge for network secrets (none is named).
6. A last-updated date for any page.

**A gap in PC-21 item 9's qualifier.** The qualifier says that per environment "only the variables, secrets and network setting are separate". The documentation also makes the setup script per environment (S1, S2), readable by anyone who uses the environment (S1). DevOS's design puts no credential in a setup script, so this does not change the claim. It is recorded so the qualifier is not read as a complete list.

## 3. The recorded claim (PC-21 item 9)

Each fact is recorded as: "guaranteed by platform (documented in <source>, read <date>); not independently tested".

| # | Fact | Recorded claim |
|---|---|---|
| F1 | Each environment's variables and network secrets are its own configuration and apply to the sessions that run in it, routine sessions included | guaranteed by platform (documented in S1 "Configure your environment", "Set environment variables" and "Add network secrets", S2 "Cloud environments", S3 "Environments and network access", read 2026-10-10); not independently tested |
| F2 | An environment's variables are readable inside its own sessions | guaranteed by platform (documented in S1 "Set environment variables" and "What carries over from your setup", and S3, read 2026-10-10); not independently tested |
| F3 | On Pro and Max plans, the agent proxy attaches a network secret outside the session's VM, in a header the environment names; the environment's sessions use it without being able to read it; its value cannot be viewed after saving | guaranteed by platform (documented in S1 "Add network secrets" and S2 "Security and isolation", read 2026-10-10); not independently tested |
| F4 | Each environment has its own network level and allowed-domains list; a network secret's hosts are reachable at every level; at Full any domain is reachable | guaranteed by platform (documented in S1 "Network access", "Access levels" and "Which requests get the secret", read 2026-10-10); not independently tested |

**Qualifiers** (PC-21 item 9, each with its source):
- Per environment, only the variables, secrets and network setting are separate (S1). The setup script is also per environment (section 2).
- The GitHub identity and the account's connectors are shared across the account (S3).
- An environment's variables are readable inside its own sessions (F2).
- The channel to the model's own service stays open whatever the network setting (S1 "Access levels", S2).
- Routines are a research preview, so these readings are repeated when the platform changes (S3; plan 0.3 item 12).

**Added from the documentation:**
- Network secrets exist only on Pro and Max plans, and only in Anthropic-hosted environments (S1).
- Whether one environment's sessions can read another environment's variables, secrets or settings is not stated (section 2 item 1). No claim here covers it.

## 4. Dispositions

### (a) Hand-over to C02's token design (note N-131)

**What row 3 now rests on.** PC-21 item 4 takes row 3 from the documentation: each environment's variables and secrets are its own (F1), and an environment's variables are readable inside its own sessions (F2). It hands the token's form, and so whether a session can see its own token, to C02's token design (N-131 item (2)). The fail path is unchanged and is decided there.

**The two forms the documentation offers, and the branch each meets:**
- **Environment variable (F2).** The session can see its own token, so row 3's second branch applies.
- **Network secret (F3).** Available on Batu's Max plan (criterion 25). In the documentation's words the session uses the token without reading it, so the second branch does not arise on that statement (not independently tested; section 2 item 2). The token travels in a header the environment names (section 1.3). If the database cannot take it from that header, the first branch applies.

The counter-assessment (N3) offered the second form, and FR-05's comparison item 4 carried it to C02 as a design option. This record adds only the documentation's terms for it.

**Row 3's fail path, as the plan gives it** (plan Section 9, C01, row 3, at `7d07ef7`):
1. "If the header cannot be added: an Edge Function gate that authenticates."
2. "If the session can see its own token, the threat model decides. The token is what lets the database tell the environments apart (criteria 8, 30); the threats are a session using another environment's token, and a token leaving its environment (a public write, a URL, a record). Separation of authority still holds while no session can read or set another environment's token or settings (C01 #17, C03 test 3), and while a token that leaves is caught: tokens get a recognisable format, every outbound check (the public-write leak check, the guard hook) stops strings of that format, and a token found outside its settings field is revoked and renewed. Visibility is then recorded as a residual risk before C02 builds the identity chain."
3. "If a session can read another environment's token, separation of authority fails, and the identity chain is redesigned before C02."

**What C02's token design weighs with it.** These are inferences from the named sources, for C02 to weigh; none is decided here.
- **The cross-environment condition.** Branch 3, and the first condition of branch 2 ("no session can read or set another environment's token or settings"), rest on the unstated cross-environment fact (section 2 item 1). Row 17's path carries that fact (PC-21 item 7; W-C01-36, W-C01-41), together with N-131 item (1), before C02 builds the environments.
  - With the network-secret form, the documentation says the value cannot be viewed after saving (F3). Reading another environment's token through its settings therefore does not arise on that statement.
  - With the variable form, the value is shown to "anyone who uses the environment", so this form depends on the unstated fact.
- **Criterion 26 and C00's sixth condition.** Both describe a token the session cannot read:
  - Criterion 26 as PC-08 reads it: the setting "carries that environment's token to the database in a separate header without the session being able to read it".
  - C00's sixth condition as PC-18 reads it: a secret "is visible in an environment variable when it is placed in a session's environment … where the session can read it" (plan Section 9, C00, PC-18 note).
  - The variable form does not meet those readings as worded. If C02 chooses it, the difference is recorded against criterion 26, which is Batu's, and is not decided by the threat model alone.
- **Timing, in the plan's own words.** Visibility is recorded "before C02 builds the identity chain", that is, before C02 task 3. The tokens are issued in C02 task 7 through 6.3's flow.
- **Documented operating terms:**
  - A renewed variable reaches a running session only when its VM restarts. Authority therefore ends by revocation on the database side (`revoke_env_token`; key inventory row 18), not by the new value.
  - A secret is changed by deleting it and adding it again.
  - A secret applies in every session in the environment "whoever started it". The environment carries the authority, not whoever started the session, so DevOS environments are used only by DevOS's sessions.
  - The Supabase host is not in the Trusted default list. The variable form needs Full, or Custom with that host; a secret's host is reachable at every level. This answers 6.3's "Network" mark at the documentation level. The mark's text changes only through plan Section 14.
- **The database never returns the header's value** or anything derived from it (row 3; Appendix B 3.27: "The token itself is kept in no table and no record").
- **Key inventory rows 18 to 21** name the token's place as "the settings field" of each environment. The chosen form says which field.

**Where "the database derives the role class correctly" is shown.** This is row 3's third success part; PC-21 item 4 says it is "shown by C02's own tests".
- **C02 tasks:**
  - task 3: the identity chain, the environment token, and the function that issues tokens
  - task 4: access rules and role classes
  - task 6: the Appendix C tests on real PostgreSQL
  - task 7: the three environments and their tokens
- **Appendix C:**
  - N04 (stage C02): a verdict or acceptance made with the working environment's token is rejected, and so are a fake role name and a fake session ID with the same token.
  - F06's negative: every event carries the caller's `role_class`, taken from its token.
- **Appendix B 3.27:** EnvToken, activated by C02 tasks 3 and 7 and N04.
- **C02's Acceptance:** "✘ With each environment's real token, an operation that requires another environment's authority is rejected", and "✔ The Appendix C tests whose stage is C02 pass …; when each rule is deliberately broken, the related test fails".
- **Row 3's first success part** ("The token is added to the Supabase request in a separate header") is shown by the same real-token line.
- **In C03:** Appendix C K06 and C03 test 3 follow.

### (b) The N-063 rows this item serves

| Row | Question (EV-C00-012 sections 3 to 5) | Disposition | Reason |
|---|---|---|---|
| D07 | How a role is identified: the token header or its fallback; the counter-design's per-role database users as a further fallback | Carried to C02: N-131 item (2); C02 tasks 3 and 4 | PC-21 item 4 moves the token's form and row 3's fail path to C02's token design. The per-role database users are read there from current Supabase documentation, beside the Edge Function gate |
| P3 | Separate environments and credentials per routine (rows 3 and 12) | Row 3's part met at the documentation level (F1, F3, section 3). The credentials are carried to C02 task 7 and its real-token Acceptance line. Row 12's part belongs to W-C01-39 | Per-environment variables and secrets are documented. The GitHub identity and connectors are account-wide (qualifier), which is row 12's matter |
| U1 | Secrets that one session cannot read from another | Carried to C02: N-131 items (1) and (2) | The documentation states per-environment secrets and that sessions cannot read network secrets, but says nothing across environments (section 2 item 1). That part is row 17's path, before C02 builds the environments; the form is C02's. Row 12's part belongs to W-C01-39 |
| U3 | Per-role database access over HTTPS under the current key system; reachability through the session's proxy | Reachability met at the documentation level (F4, section 1.3). The database mechanism is carried to C02 with D07: N-131 item (2), C02 tasks 3 and 4 | Full reaches any domain, and a secret's host is reachable at every level. How the database authenticates is C02's design |
| Q1 | If U1 fails, which fallback | Carried to C02: N-131 item (2) | Row 3's fail path is decided in C02's token design (PC-21 item 4). A second machine account would go to Batu as a decision about his accounts. Row 12's part belongs to W-C01-39 |
| B4 | Only if U1 fails: a second machine account, or his subscription token in a private repository | Carried to C02 with Q1: N-131 item (2) | It arises only if C02's token design or row 17's path reaches a fallback that needs his accounts. It then goes to him under Appendix E section 3 |

## 5. Counter-evidence, limits and open points

- **Counter-evidence looked for:** a statement that a session can read a network secret, or that variables or secrets are shared across environments. None was found in S1 to S5. The strongest point the other way is section 2 item 1: the per-environment statements are not statements across environments.
- **S5's opt-in.** S5 describes an opt-in (`CLAUDE_CODE_SUBPROCESS_ENV_SCRUB=1`) that removes credential-looking variables from the commands Claude Code starts, "as one layer". It is not about cloud environments and does not change either answer. It is also not a third form for a token that the session's own commands must send (inference).
- **The header question stays open.** The counter-assessment (FR-05 raw, N3) states it did not verify whether the database can read a token from a request header. This reading does not settle that either (section 2 item 3).
- **Not read:** the Supabase documentation; Claude Code's settings reference and data-usage pages; S5 beyond the search.
- **Guard denials:** one. Rule B7 (decision #520) denied a command-line read of the Claude Code version. It was not pursued.
- **Re-reading:** the pages are undated. A reading after a platform change reads them again (plan 0.3 item 12; routines are a research preview).
