# Research report: platform facts for W-C01-03 (probe design revision), C01, second round

**Question.** Seven sets of platform facts that the revised probe design needs: GitHub triggers for routines, schedule and manual runs, session tools inside a routine session, how a session reads its Claude Code version, Supabase REST behaviour, API-credential headers, and two embedding models for row 7. The findings feed the revision of W-C01-03; they do not decide it.

**Reading basis.** All reading was on 2026-10-06. The Claude Code pages were read as raw markdown with curl, so quotes from them are verbatim. Where I searched the site's full-text corpus, I name the page each hit came from. The Supabase docs pages were also read as raw markdown and are verbatim. One Supabase GitHub discussion came back summarised by WebFetch and is marked as such. The PostgREST docs could not be read. Every code.claude.com page is undated, so the changelog entries carry their own dates. I did not read the research library, and I did not repeat the earlier report (`/tmp/claude-0/-home-user-devos/1ffeb509-6a85-5fdc-9f2f-cbf44d117c09/scratchpad/w23/evidence/C01/raw/W-C01-03_setup_facts_report.md`) except where my reading adds to it or corrects it.

**Budget.** I used about 42 tool calls and about 52 HTTP requests, against a budget of about 30. The main cause: I may not write files, so each search of a large corpus downloaded it again.

## Disciplines (D1–D9)

D1: yes: several premises in the questions were decision-critical (a push trigger exists, one credential can carry two headers, new functions get `anon` EXECUTE), so I checked each one and wrote conditional conclusions where the documentation is silent or depends on dates.
D2: uncertain: the questions name events (push, issue, comment) and tool names (create_session and others) that may be assumed to exist, so I searched for each one explicitly and report what is absent instead of fitting the nearest match.
D3: yes: I kept to the seven questions that the W-C01-03 revision needs and flagged only the facts that change the probe design.
D4: uncertain: everything here is documentation or registry metadata, not observed behaviour, and I label it that way so that no C01 row counts as verified by this report.
D5: yes: I read raw markdown instead of summaries, marked the one WebFetch-summarised source, limited every "not stated" to the passages and patterns I actually searched, and recorded that PostgREST could not be read.
D6: no
D7: no
D8: uncertain: I read the earlier researcher's report first, treated it as another agent's view, and corrected or extended it only where my own reading overlapped.
D9: yes: the task excluded the library, so this is new outside research with dates attached, for the executor to record as a candidate.

**Labels:** (S) the source states it; (I) my interpretation; (Inf) my inference. Unless a date is given, every code.claude.com page is undated.

**Source key.** Claude Code pages are named by their path under the official docs base (site code.claude.com, path docs/en/), not by full address.

| Key | Page | Page date |
|---|---|---|
| RT | `routines` | undated; "research preview" |
| XSM | `cross-session-messaging` | undated |
| TR | `tools-reference` | undated |
| TS | `agent-sdk/typescript` | undated |
| SHC | `self-hosted-environments-configuration` | undated |
| WEB | `claude-code-on-the-web` | undated |
| ENV | `cloud-environments` | undated |
| PROJ | `claude-projects` | undated |
| CMD | `commands` | undated |
| EV | `env-vars` | undated |
| CL | `changelog` | each entry dated (latest read: 2.1.290, October 5, 2026) |
| SB-KEYS | https://supabase.com/docs/guides/api/api-keys | undated |
| SB-SEC | https://supabase.com/docs/guides/api/securing-your-api | undated |
| SB-API | https://supabase.com/docs/guides/api | undated |
| SB-DISC | https://github.com/orgs/supabase/discussions/45329 | "April 28, 2026" (WebFetch summary) |
| HF-E5 / HF-M3 | https://huggingface.co/api/models/intfloat/multilingual-e5-small and https://huggingface.co/api/models/BAAI/bge-m3 (both with `?blobs=true`), plus each README at the commit below | registry `lastModified` given below |

---

## 1. Routine triggers: GitHub events

**Which events can start a routine**
- (S) Only two categories: "GitHub triggers can subscribe to either of the following event categories." [RT, "Supported events"]
  - **Pull request:** "A PR is opened, closed, assigned, labeled, synchronized, or otherwise updated".
  - **Release:** "A release is created, published, edited, or deleted".
  - You can pick one action, such as `pull_request.opened`, or all actions in the category.
- (S) Push, issue and comment events are not in the list. (I) So **no push, issue or comment trigger exists** per the current page.
- (S, CL 2.1.281, September 23, 2026) A pull request "being converted to draft" now fires a run (bug fix).

**Filters**
- (S) Pull-request filter fields: Author, Title, Body, Base branch, Head branch, Labels, Is draft, Is merged. [RT, "Filter pull requests"]
- (S) Operators: "equals, contains, starts with, is one of, is not one of, or matches regex". "All filter conditions must match". `matches regex` "tests the entire field value". [RT]
- No path filter is stated.
- Filters for release events: not stated.

**Per repository**
- (S) "Select the repository, choose an event … and optionally add filters." [RT] (I) Each trigger names one repository.
- (S) "The Claude GitHub App must be installed on the repository you want to subscribe to". [RT]
- (S) `/web-setup` "does not install the Claude GitHub App and does not enable webhook delivery". [RT]
- (S, CL 2.1.274, September 17, 2026) A save can fail on "a per-repository trigger limit". Its value is not stated.

**Does a push or PR made by the same GitHub user, or through the git proxy, fire it?**
- Not stated.
- (S) Routine commits and PRs "carry your GitHub user". [RT]
- (Inf) An Author filter therefore cannot tell a run's PR from Batu's own. A Head-branch filter such as "starts with `claude/`" could tell them apart, but only if runs keep that prefix, which is a default and not enforced.
- (I) A push alone is not a trigger event. A push that updates an open PR could arrive as "synchronized", and whether a self-caused event fires is not stated.

**Limits and delays**
- (S) "GitHub webhook events are subject to per-routine and per-account hourly caps. Events beyond the limit are dropped until the window resets." [RT] The values are not stated.
- In the limits table the GitHub row only refers back to that note. [RT]
- Delay from event to run: not stated.

**What the run receives about the event**
- Not stated on [RT].
- (S) [TS, "Task-notification subkinds"]: a routine's stored prompt arrives with subkind `scheduled-trigger` "because one of the routine's triggers fired: its schedule, its API trigger, its GitHub trigger, or **Run now**".
- (S) `fireReason` is "a short lowercase token such as `scheduled`, `manual`, `retry`, `catch_up`, or `api`".
- Whether the event body (PR number, branch) is passed, and in what form: not stated.

**Loop protection**
- (S) "Claude Code doesn't reuse sessions across events, so two PR updates produce two independent sessions." [RT]
- No routine-specific loop guard is stated. The only stated brake is the hourly cap that drops events.
- (S) The "Message loops are throttled" rule [XSM, "Limitations"] covers cross-session messages, not routine triggers.

## 2. Routine triggers: schedule and manual runs

**Several triggers on one routine**
- (S) "Each routine can have one or more triggers attached to it". [RT]
- (S) "You can attach any combination of schedule, API, and GitHub triggers to the same routine". [RT]
- Whether two one-off times can coexist: not stated.
- (S) "After the routine fires, it auto-disables and the web UI marks it as **Ran**." [RT] (I) This reads as one one-off per routine at a time.
- Whether that auto-disable also stops the routine's other triggers (API, **Run now**): not stated.

**Saving with no trigger**
- Not stated.
- (S) The page covers only "A routine with no schedule trigger, such as one started only by API calls or GitHub events". [RT] That is not the same as having zero triggers.

**Re-running a one-off**
- (S) "To run it again, edit the routine and set a new one-off time." [RT]
- (S) The limits table counts "setting a one-off routine to run again" with **Run now** and API fires. [RT]

**Pressing Run now several times; overlap**
- (S) Limits [RT]:
  - 30 per hour per routine, "one count shared by all three" (**Run now**, API fires, one-off re-runs).
  - 100 per hour per account for **Run now** and one-off re-runs.
- (S) Over the limit: scheduled runs: "The run waits until the limit resets". **Run now**, API and re-runs: "The action fails until the limit resets". [RT] *(The earlier report left out this column.)*
- (S) "Each run creates a new session alongside your other sessions". [RT]
- Whether runs of one routine may overlap or are serialised: not stated.

**Extra runs the platform may start (relevant to counting runs)**
- (S) `fireReason` includes `retry` and `catch_up`. [TS]
- (S, CL 2.1.269, September 11, 2026) A bug "could skip the retry after a real failure or start a duplicate run".
- (S, same entry) "one-off scheduled routines occasionally running a second time" was fixed.
- (S, CL 2.1.274) "editing a routine occasionally making it fire twice" was fixed.

**Cancelling a run**
- No routine-specific cancel is stated.
- (S) "Each run session works like any other session: use the dropdown menu … to rename, archive, or delete it." [RT]
- (S) Pausing: "Use the on/off switch … to pause or resume the schedule." [RT]
- (S) For cloud sessions in general: "Fixed SDK and cloud sessions ignoring a Stop or interrupt sent just after the first prompt" (CL 2.1.261). [PROJ] also says "Interrupt the thread with **Stop** … or by pressing Esc."
- (I) A running routine session can be stopped like any cloud session. Whether **Run now** works on a paused routine: not stated.

## 3. Session tools inside a routine (cloud) session

**The control plane's MCP server "Claude Code Remote"**
- (S) "Anthropic's control plane attaches its own MCP server, named Claude Code Remote, to cloud sessions. Claude uses the server's tools to schedule routines, start and steer other cloud sessions, attach more repositories, and follow pull request activity." [SHC, "Turn off built-in session tools"]
- (I) The section sits on a self-hosted page, but the sentence speaks of cloud sessions in general.
- (S) It registers under one of three names "depending on how the session was created": `mcp__Claude_Code_Remote`, `mcp__claude-code-remote`, `mcp__bf7c680d-5fdc-5ef4-b4a0-abadb619bf0a`. Deny rules match "exactly, including case". The one tool named as an example is `add_repo` (`mcp__Claude_Code_Remote__add_repo`). [SHC]
- (S) "A rule that names the whole server covers tools the server gains later too." [SHC]
- (I) In a session with one repository, a deny rule in the repo's `.claude/settings.json` could remove these tools. Per the earlier report, a session with several repositories reads no permission rules from the repos.

**Server-side `send_message`**
- (S) A message "that another of your sessions sent with the server-side `send_message` tool that cloud sessions use to message each other". It gets subkind `peer-send-message` only when "Anthropic servers verified that both sessions belong to the same private group of sessions". [TS]
- What "private group" means is not defined.

**The names create_session, send_message, get_session, list_sessions, create_trigger, fire_trigger**
- Apart from `send_message` (above) and `add_repo`, none of these names appears in the docs as a Claude Code Remote tool. I searched the whole full-text corpus for each name.
- The only hits for `list_sessions` and `get_session_info` are Agent SDK functions for local transcripts [TS], which are unrelated.
- Their exact names, inputs and limits: not stated.

**RemoteTrigger (the CLI tool behind `/schedule`)**
- (S) "Creates, updates, runs, and lists Routines on claude.ai." [TR]
- (S) Actions: `list`, `get`, `create`, `update`, `run`, `create_webhook_trigger`, `list_runs`, `get_run_log`. It is "available only when the session is authenticated with a claude.ai account on a plan with Routines enabled". [TS]
- (S) In a cloud session, `/schedule` "answers that the command isn't available in that environment". [RT, Troubleshooting]
- Whether the RemoteTrigger tool itself is present in a cloud session: not stated.

**ListAgents / SendMessage (cross-session messaging)**
- (S) Cloud sessions are reachable "while this session is connected to Remote Control". [XSM, TR]
- Whether a cloud or routine session can itself list or message other sessions with these tools: not stated.

**Authority limits that are stated**
- (S) A message from another session "can't approve anything", "can't change configuration", "Commands don't run", and "Permission prompts still fire". [XSM, "How a session treats an incoming message"]
- (S, CL 2.1.275, September 17, 2026) "Improved what Claude tells you when asked to edit, delete or run a routine it didn't create: it now links to the routine's page so you can do it yourself". (I) Claude cannot act on routines it did not create.
- (S) Routines "belong to your individual claude.ai account". [RT]
- (S) In projects, "Claude can only add repositories from a GitHub owner the project already uses". [PROJ]

**Acting on another environment's sessions or routines (plan C01 row 17)**
- Not stated anywhere I read.

**Tension**
- (S, CL 2.1.280, September 22, 2026) "a routine that resumes an existing session", and (CL 2.1.268) "when a routine resumes a session".
- Against [RT]: "Each run creates a new session". (I) Some routines, probably those created from a conversation, resume a session. Which ones is not stated.

## 4. Claude Code version in a cloud or routine session

- How a cloud or routine session reads its own version: **not stated.**
- (S) Features are gated "in the session's environment", for example "Requires Claude Code v2.1.271 or later in the session's environment" (for `/fast`). [WEB]
- (S) `/status`: "Open the Settings interface on the Status tab, showing version, model, account, and connectivity". [CMD]
- (S) But "Commands that only run in the terminal interface … aren't available" in cloud sessions, and the list of picker or panel commands that behave differently there leaves `/status` out. [WEB] So whether `/status` works in a cloud session is not stated.
- (S) `check-tools` reports versions of the preinstalled tools. Claude Code is not in the installed-tools table. [ENV]
- (S) General advice, not specific to the cloud: "starting with `claude --version` for the version requirement". [XSM]
- (S) Neither [EV] nor any page I read lists an environment variable that carries the version. [EV] lists only `OTEL_METRICS_INCLUDE_VERSION`.
- (S) Version appears elsewhere, but none of these is stated for cloud sessions:
  - status-line input JSON has a `"version"` field (page `statusline`);
  - a settings helper gets `CLAUDE_CODE_VERSION` in its environment (page `settings-reference`);
  - the SDK init message has `claude_code_version` [TS].
- (S) Cloud markers that do exist:
  - `CLAUDE_CODE_REMOTE` is "Set automatically to `true` when Claude Code is running as a cloud session" [EV];
  - `CLAUDE_CODE_REMOTE_SESSION_ID` holds "the current session's ID" [EV, ENV].

## 5. Supabase REST calls

**The `apikey` header**
- (S) "**Required Supabase key:** The `apikey` header is mandatory and not configurable." [SB-SEC, "Use additional API keys"]
- (S) The Data API is "provisioned behind an API gateway with key-auth enabled". [SB-API]
- (S) "Send publishable and secret keys on the `apikey` header, not on `Authorization: Bearer`." [SB-KEYS]

**Is the publishable key meant to be public?**
- (S) Yes: "Safe to expose online: web page, mobile or desktop app, GitHub actions, CLIs, source code." [SB-KEYS, keys table]
- (S) "Anyone can read it, so it only reaches what Row Level Security allows". [SB-KEYS]
- (S) "Supabase is deprecating the `anon` and `service_role` keys by the end of 2026." [SB-KEYS]

**Reading a custom request header in a Postgres function**
- (S) `current_setting('request.headers', true)::json` returns a "JSON object of the request's headers". One header is read with `->>'user-agent'`. [SB-SEC, "Request information"]
- (S) The guide's own pre-request example reads a custom header: `current_setting('request.headers', true)::json->>'x-app-api-key'`. It blocks `anon` requests with 403 "if the `x-app-api-key` header is not registered". [SB-SEC]
- (I) A custom header passes the gateway and can be read in SQL. The examples use lower-case names.
- PostgREST's own statement on header-name case: **not read**. docs.postgrest.org returned HTTP 429 twice, and postgrest.org failed TLS host verification, which I did not bypass.

**Does a new function in `public` get EXECUTE for `anon` by default?**
- (S) "On existing projects, tables created in `public` receive `SELECT`, `INSERT`, `UPDATE`, and `DELETE` privileges for `anon`, `authenticated`, and `service_role` by default. Functions receive `EXECUTE`." [SB-SEC, "Default privileges"]
- (S) "Supabase is changing the platform default to revoke these automatic grants so that exposure becomes opt-in." [SB-SEC]
- (S, WebFetch summary) [SB-DISC], posted April 28, 2026, titled "Breaking Change: Tables not exposed to Data and GraphQL API automatically":
  - the new behaviour is the default "for all **new** projects" after May 30, 2026;
  - it "is enforced on **all existing projects**" after October 30, 2026, which is 24 days from today;
  - existing tables "keep their current grants".
  - How functions are treated comes through only vaguely in the summary.
- (S) The guide's revoke recipe has a separate line `revoke execute on functions from public;`. [SB-SEC]
- (Inf, from general Postgres knowledge; I did not read postgresql.org) Postgres grants EXECUTE on new functions to PUBLIC, which includes `anon`. So a function can stay callable by `anon` even after Supabase's own default grants are removed, unless PUBLIC is revoked.
- (S) "RLS doesn't apply to functions, so grant `EXECUTE` only to the roles that need to call them." [SB-SEC]
- (I) The answer depends on when the DevOS project was created and on the October 30 cutover. The design should grant and revoke explicitly and not rely on the default.

## 6. The cloud environment's API credential

**Two custom headers on one credential**
- (S) "**Custom headers**: one row for the header that carries the key." [ENV, "Add a credential"]
- Whether a second header row can be added: not stated. (I) The wording describes a single header per credential.

**Several credentials, and two on the same host**
- (S) "You add credentials one at a time". The section lists "the credentials already on the environment, each with the hosts it applies to". [ENV] (I) An environment can hold several credentials.
- (S) "Two credentials whose hosts overlap without matching exactly get no marker, and the agent proxy sends only one of them." [ENV]
- (S) "If the list marks a credential **Not sent** instead, the note under it says why". [ENV]
- What happens with two credentials on exactly the same host: not stated. (Inf) Probably a **Not sent** marker on one of them. Either way, **two credentials do not deliver two headers to one host**, per the stated overlap rule.
- (S) Other credential types exist: the "**Credential type**" list "is the same one Claude Tag … offers for connections". [ENV] I did not read that list.
- (I) Because the publishable key is public by design (question 5), it need not travel in a hidden credential. That leaves the one credential slot for the probe token. This is an option for the executor, not a recommendation.

## 7. Embedding models for row 7 (read from the registry API and the README at the main commit)

| | `intfloat/multilingual-e5-small` | `BAAI/bge-m3` |
|---|---|---|
| Main revision sha | `614241f622f53c4eeff9890bdc4f31cfecc418b3` | `5617a9f61b028005a4858fdac845db406aefb181` |
| Registry `lastModified` | 2026-04-02T02:16:05Z | 2024-07-03T14:50:10Z |
| Licence | MIT (`cardData.license`; README front matter `license: mit`) | MIT (same two places) |
| Parameter count | 117,654,272 (registry `safetensors.total`: F32 117,653,760 + I64 512) | **Not stated** in the registry (no safetensors metadata) or the card. (Inf) About 568M if the .bin is fp32 (2,271,145,830 / 4) |
| Main weight file and size | `model.safetensors`, 470,641,600 bytes. Also `pytorch_model.bin` 470,681,649 and `onnx/model.onnx` 470,268,510 | `pytorch_model.bin`, 2,271,145,830 bytes. No root `model.safetensors`. `onnx/model.onnx` is 724,923 bytes ((I) a graph whose weights are in a separate data file I did not size) |
| Card facts | "This model has 12 layers and the embedding size is 384." | Dimension 1024, sequence length 8192 (card "Specs" table) |
| Loading the card documents | `transformers` `AutoTokenizer`/`AutoModel` with average pooling; and `SentenceTransformer('intfloat/multilingual-e5-small')` with `pip install sentence_transformers~=2.2.2`. Inputs need the prefixes `"query: "` / `"passage: "` | `pip install -U FlagEmbedding`; `from FlagEmbedding import BGEM3FlagModel`; `BGEM3FlagModel('BAAI/bge-m3', use_fp16=True)` |
| Registry `library_name` | `sentence-transformers` | `sentence-transformers` (but the card's usage section shows FlagEmbedding; my search of the card found no `sentence_transformers` usage) |

- (I) The sha comes from the models API that the task named, which reports the main revision's commit. I did not open the web commits view separately.
- (I) e5-small's main branch changed in April 2026, so the probe should pin the sha and not "main".

---

## Counter-evidence and contradictions

- **Push trigger.** If the design expected a push, issue or comment trigger, [RT] lists only pull request and release.
- **Fresh session per run.** [RT] says each run creates a new session. Changelog 2.1.268 and 2.1.280 speak of routines that "resume" an existing session.
- **One press, one run.** The platform has `retry` and `catch_up` fire reasons, and recent fixes for duplicate and second runs (2.1.269, 2.1.274). A run count may not equal the number of presses.
- **Routine management from a cloud session.** `/schedule` is unavailable in a cloud session [RT], yet the Claude Code Remote server lets cloud sessions "schedule routines" [SHC]. Both can be true (different paths), but which tool a routine session actually has must be observed.
- **Supabase grants.** [SB-SEC] says both "A table isn't reachable through the Data API unless you have granted a role privileges on it" and that existing projects grant automatically by default. The date-based rollout in [SB-DISC] reconciles the two. (I) Which side applies to DevOS's project depends on its creation date.
- **Agreement with the earlier report.** The hourly limits match. I add the "Over the limit" column. "Saved with no trigger" stays not stated.

## Open

- Release-event filters; the values of the GitHub event caps and of the per-repository trigger limit; delay from event to run; what event data the run receives.
- Whether self-caused PR events fire a routine.
- Two one-off times on one routine; a routine with zero triggers; whether **Run now** works on a paused routine or one that has auto-disabled; whether runs overlap.
- The full tool list of the Claude Code Remote server, with each tool's limits; whether RemoteTrigger, ListAgents and SendMessage exist inside a cloud or routine session; anything about other environments (row 17).
- How a cloud session reads its version; whether `/status` works there.
- Whether a credential can carry a second header row; what happens with exact-match duplicate hosts; the other credential types (Claude Tag connections list, not read).
- PostgREST's own docs (unreachable); the PostgreSQL docs on the default PUBLIC EXECUTE (not read); how the Supabase change treats functions (the summary was vague; the full discussion thread was not read verbatim).
- The DevOS Supabase project's actual default ACLs and creation date. I did not inspect them: this was outside the task's sources, and the read-only connector is not among my tools. The executor could observe them.

## For the decision

1. Any probe step or row that needs a routine to fire on push, issue or comment cannot work as written. The GitHub path available is a PR or release event, filtered by base or head branch, label and similar fields. A run that opens its own PR on a watched repository may re-fire the routine, and only the hourly cap that drops events is documented as a brake. A Head-branch filter is the stated tool to exclude the run's own `claude/` PRs.
2. Count runs by session and `fireReason`, not by button presses, because retries, catch-ups and past duplicates exist. Two one-offs on one routine is not a safe assumption. A re-run is "edit, set a new time" and counts against the 30-per-hour shared limit.
3. Row 17 and the session-tool rows can only be observed, not read: the documentation names a control-plane server that can "start and steer other cloud sessions" and "schedule routines", gives one tool name, and says nothing about environment boundaries. The documented switch to remove those tools is a deny rule on the three server names, which works only in a single-repository session.
4. The version row must be observed as well (for example by trying `claude --version` and `/status` in the session). No documented path exists.
5. Supabase calls need `apikey` with the publishable key, which is public by design, so it can travel openly while the probe token uses the single credential header. Do not plan for one credential with two headers, or for two credentials on the same host. Grant and revoke EXECUTE explicitly for each probe function, and include PUBLIC. Defaults change for existing projects after October 30, 2026.
6. For row 7, pin the shas above. e5-small is about 118M parameters with a 471 MB safetensors file, loadable with sentence-transformers, and needs the `query:`/`passage:` prefixes. bge-m3 is a 2.27 GB `.bin` with no safetensors, and its card documents FlagEmbedding. Its parameter count is not stated (about 568M by inference).

## Guard denials

- **#9161, rule G0 (readable call).** My grep pattern had backticks inside double quotes, which the guard could not parse. As the denial instructed, I repeated the call in well-formed form without backticks. Nothing else was changed, and no other route was tried.
