*Filed verbatim: the final report of a researcher subagent of the working session `session_01XyxvJd3RayQk4HCrjurbVH` for W-C01-17 (row 10's documentation part), written 2026-10-11 between about 18:07Z and 18:12Z; every source in it was read on 2026-10-11. Its guard denial (#10194, G0, 18:07:53Z) is recorded in the log. It is a documentation report: it observes nothing about the account.*

# Row 10 documentation report (W-C01-17)

## Disciplines (D1–D9)
D1: yes: `get_session` itself is not documented, so I give each field's meaning from the documented Agent SDK or status-line field that matches it, and state the readings conditionally instead of picking one.
D2: yes: I did not let C00's own reading or the earlier row 5 report steer the weighing, and I looked for statements against them (the help center naming `/status`; the TypeScript and Python SDK references differing).
D3: yes: I stayed within the six documentation questions, called no session tool, and left the observed parts (readings before and after a known piece of work) to the executor.
D4: yes: documentation is marked as documentation, not observation, and I note that a documented matching field cannot confirm what `get_session` actually reports.
D5: yes: I read raw `.md` pages and the help articles' own text instead of fetch summaries, and searched the full documentation text (`llms-full.txt`) before saying any field name is absent.
D6: uncertain: for the identical 17:58Z and 18:06Z readings I list the documented mechanisms and the competing explanations without choosing a cause.
D7: no
D8: yes: I read the acceptance block, C00's Usage section and EV-C01-022a first, then re-read their cited pages myself instead of relying on them.
D9: uncertain: I did not consult the library, because these are fast-changing platform facts that need a current primary source and the weekly window is at warning; the result is a new dated platform finding.

Everything below was read on 2026-10-11. For code.claude.com, line numbers are from the raw `.md` file, which carries no modified date. Each help-center article's own modified date is given in Sources.

## Q1. What the `get_session` fields mean

**Main finding: not stated.** I searched the full documentation text for each name:
- `get_session`: 12 hits, all for the SDK's local-disk functions `get_session_info()` and `get_session_messages()`. None is the cloud session tool.
- `isUsingOverage`, `rateLimitType` and `used_tokens`: 0 hits.

So every meaning below is **documented only for a matching field** (Agent SDK, status line, OpenTelemetry). That `get_session` reports the same quantities is **not stated**.

- **`usage.input_tokens`, `output_tokens`, `cache_read_tokens`** — documented (matching fields).
  - OpenTelemetry `input_tokens` excludes "tokens read from or written to the prompt cache, which are reported in `cache_read_tokens` and `cache_creation_tokens`" (monitoring-usage).
  - `cache_read_tokens` is "Tokens read from prompt cache".
- **`usage.cache_write_tokens`** — documented (matching field). The status line's `prompt_cache.cache_write_tokens` is "All tokens written to the cache this session, the first request's initial write included" (statusline.md:405). That object does not count subagent requests (statusline, Prompt cache fields).
- **`usage.cost_usd`** — documented for every matching cost field, not for `get_session` itself. Every documented cost figure is a **list-price estimate computed locally, not an amount charged**:
  - "Claude Code computes `session.total_cost_usd` locally from token counts, so it is an estimate and not what your plan bills." (agent-sdk/typescript.md:2145)
  - The status line's `cost.total_cost_usd` is "computed client-side at list price" (statusline.md:182).
  - For subscribers: "Claude Max and Pro subscribers have usage included in their subscription, so the session cost figure isn't relevant for billing purposes." (costs.md:20)
- **`context_usage.used_tokens` / `max_tokens`** — not stated under these names. The closest documented field is `SDKContextUsage`:
  - `total_tokens` is "Claude Code's estimate of the tokens in use".
  - `raw_max_tokens` is the context window, or the lower auto-compact window.
  - Both are for "the main loop's model … not a subagent's" (typescript.md:2055–2057).
- **`rate_limit_info`** — documented for the Python SDK's `RateLimitInfo` (agent-sdk/python, section RateLimitInfo):
  - `status`: "`allowed_warning` means approaching the limit; `rejected` means the limit was hit".
  - `rate_limit_type` values are `five_hour`, `seven_day`, `seven_day_opus`, `seven_day_sonnet` and `overage`.
  - `resets_at` is a Unix timestamp.
  - `utilization` is the "Fraction of the rate limit consumed (0.0 to 1.0)".
  - Overage is described by `overage_status`, `overage_resets_at` and `overage_disabled_reason`.
  - `isUsingOverage` is not documented. The Python type passes unmodelled fields through in `raw`.
  - **Contradictory:** the TypeScript `SDKRateLimitEvent` lists only `status`, `resetsAt`, `utilization` and the credits fields. It has no type and no overage fields (typescript.md:5569–5580).
- **What fraction `allowed_warning` marks** — not stated.
  - The help center says only "you'll see warning messages as you approach any limit" (11145838).
  - The errors page shows "a message such as `You've used 85% of your session limit`" (errors.md:723). That is an example, not a stated threshold.
  - The `/usage` rows carry a `severity` (`normal`, `warning`, `critical`), described as "the server's reading" (typescript.md:2161).

## Q2. Subagents and workflows

**How they draw on the limits: documented.**
- A subagent "sends its own requests, which count toward the same usage limits as your main conversation" (sub-agents.md:11).
- Workflows: "Runs count toward your plan's usage and rate limits." (workflows.md:436)
- **Relevant to DevOS, since it runs at ultracode (D-008):** "a session with ultracode on reaches a session or weekly limit sooner than the same work with it off" (workflows.md:156).
- Parallel cloud tasks consume "more rate limits proportionately" (claude-code-on-the-web.md:434).
- Projects draw on "the same plan limits" (claude-projects.md:403).

**Whether `get_session`'s figures include them: not stated.** The matching documented fields disagree, so the answer depends on which one `get_session` mirrors:
- SDK `usage`: "main agent loop only. Excludes subagent and auxiliary model calls" (typescript.md:1660).
- SDK `modelUsage` and `total_cost_usd` include "subagents, and internal calls such as compaction and Workflow agents" (typescript.md:1661–1662; cost-tracking.md:94–98).
- The prompt-cache statistics in `/usage` cover "the main conversation only, not subagents" (costs.md:52).

## Q3. When the figures update

**For `get_session`: not stated.** For the matching fields, documented:
- **Per API call:** each step's assistant message carries its own `usage` (cost-tracking.md:39, :50).
- **Per turn:** the running totals are on the result message, and in streaming input mode "each turn emits its own result message" (cost-tracking.md:64–67).
- **Rate-limit state:** the Python `RateLimitEvent` is "Emitted when rate limit status changes". The TypeScript reference says "when the session encounters a rate limit" (typescript.md:5566).
- **Status line:** its script reruns when "A new assistant message arrives" (statusline.md:145).
- **`/usage`:** it can show "last-known usage" up to 60 minutes old when the usage request fails (costs.md:79).

**The 17:58Z and 18:06Z readings: the documentation does not explain them.** These explanations remain open, and the documentation does not choose between them:
- (a) the metadata holds per-turn result totals;
- (b) a refresh delay in the session service;
- (c) the forty tool calls belonged to the subagent and the figures exclude subagents.

A reading taken just after a turn ends, compared with one taken inside the next turn, would tell (a) from (b).

## Q4. Sharing between Claude Code and the Claude apps

**One shared allowance: documented.**
- "These limits are shared across Claude and Claude Code, meaning all activity in both tools counts against the same limits." (11145838)
- Usage of "claude.ai, Claude Code, Claude Desktop" counts "towards the same usage limit" (11647753).
- Cloud sessions: claude-code-on-the-web.md:13 and :434.
- Routine runs: "Routines draw down subscription usage the same way interactive sessions do." (routines.md:378)

**The windows: documented.**
- "a session limit that resets every five hours, and weekly limits that reset once every week" (11647753).
- The Max weekly reset is "a fixed time each week that is assigned to your account" (11049741).
- "Usage counts against the session and weekly allowances at the same time." (errors.md:712)
- Max also has "a separate weekly limit for Fable" (11145838). There are also per-model Opus and Sonnet limits (errors.md:704–708).

**Partly separate:**
- The hourly routine start limits are "Separately from subscription usage" (routines.md:380).
- The monthly API credits included with Max "can't be used in Claude Code or the Claude apps" (11145838).
- Whether the five-hour window starts at first use or on a fixed clock is not stated. The errors page calls it "a rolling usage allowance" (errors.md:699).

## Q5. Where the fraction used is shown

**For the account owner: documented.**
- Settings > Usage shows "progress bars showing how much of your five-hour session and weekly usage limits you've consumed" (9797557).
- `/usage` shows "plan usage bars" to subscribers (costs.md:20).
- The Desktop usage ring shows plan usage "shared across all your Claude Code surfaces" (desktop, Check usage).
- The status line has `rate_limits.five_hour/seven_day.used_percentage` for Pro and Max subscribers (statusline.md:190, :345).

**Inside a session:**
- Not stated for any cloud-session tool, and `get_session` has no fraction in the repository's readings.
- The documented fraction fields (`utilization`; `SDKUsageReport.rate_limits.limits[].percent`, typescript.md:2112–2156) belong to SDK hosts and the CLI.
- Cloud sessions support built-in commands "that produce text output" (claude-code-on-the-web.md:267). The page does not name `/usage`.

## Q6. Capacity estimates and extra usage

**Capacity: no figure of sessions, runs or messages per window is documented.**
- "The number of messages you can send will vary based on your Claude plan." (9797557)
- Max is described as "five times" or "20 times the Pro plan's per-session usage allowance" (11049741). Pro's own allowance is not given in any unit.
- Anthropic may limit usage further "at our discretion" (11049741).
- Workflows: run "on a small slice first" to gauge spend. A "Large workflow" warning appears above 25 agents or 1.5 million projected tokens (workflows.md:438–440).

**Extra usage (now called "usage credits"): documented.**
- The old `extra-usage-for-paid-claude-plans` URL redirects (301) to `manage-usage-credits-for-paid-claude-plans`.
- It is turned on at Settings > Usage > Usage credits: prepaid, with a monthly spend limit and optional auto-reload.
- "Usage credits are billed at standard API rates" (12429409).
- `/usage-credits` opens that settings page (costs.md:104–108).
- Without credits, routine runs "are rejected until your usage window resets" (routines.md:392).
- Free limit resets exist: "Limit resets are given occasionally to eligible plans" (17007452).

## Counter-evidence and open points
- **The main gap.** `get_session`, `isUsingOverage` and `rateLimitType` appear in no documentation I could find (full-text search of `llms-full.txt`). Every Q1–Q3 meaning is conditional on `get_session` mirroring the documented field. EV-C01-022a section 2 found the same gap.
- **Two reference pages disagree.** The TypeScript and Python SDK references give different shapes for the rate-limit info (Q1).
- **Help center versus Claude Code docs.** Help 11145838 says to monitor the allocation with "the /status command"; the code docs name `/usage`.
- **Two wordings of the Max allowance.** Help 11049741 says both "5x or 20x the Pro plan's usage allowance" and "per-session usage allowance".
- **C00's reading against the documentation:**
  - "cost_usd … not an amount charged" matches every cost field documented.
  - "cumulative since the session opened" matches the matching fields, which reset only on `/clear`.
  - "isUsingOverage false means no usage beyond the allowance" rests on an undocumented field. Its closest documented counterpart is `overage_status`.
- **Terminology.** The documentation's "extra usage" is now "usage credits"; records that cite the old wording should use the current name.
- **Not read:** claude.com/pricing; the full `commands` page (whether `/usage` works in cloud sessions); signed-in claude.ai pages; Wayback copies; the research library.

## Guard denials
- **G0** (#10194, `/tmp/devos-guard/session_01XyxvJd3RayQk4HCrjurbVH.jsonl`): unbalanced backticks in a Bash `grep` pattern. I repeated it in a well-formed way with the Grep tool. I did not run `tools/guard_report.py` because my role writes nothing, so please record it.
- The downloaded pages are only in my scratch directory, `/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/r17/`.

## Sources
- https://code.claude.com/docs/en/agent-sdk/typescript (raw .md), read 2026-10-11
- https://code.claude.com/docs/en/agent-sdk/python, section RateLimitInfo (read in https://code.claude.com/docs/llms-full.txt), read 2026-10-11
- https://code.claude.com/docs/en/agent-sdk/cost-tracking, read 2026-10-11
- https://code.claude.com/docs/en/costs, read 2026-10-11
- https://code.claude.com/docs/en/statusline, read 2026-10-11
- https://code.claude.com/docs/en/errors, read 2026-10-11
- https://code.claude.com/docs/en/claude-code-on-the-web, read 2026-10-11
- https://code.claude.com/docs/en/sub-agents, read 2026-10-11
- https://code.claude.com/docs/en/workflows, read 2026-10-11
- https://code.claude.com/docs/en/claude-projects, read 2026-10-11
- https://code.claude.com/docs/en/routines, read 2026-10-11
- https://code.claude.com/docs/en/monitoring-usage and /desktop (in llms-full.txt), read 2026-10-11
- https://support.claude.com/en/articles/11145838-use-claude-code-with-your-pro-or-max-plan (modified 2026-10-08), read 2026-10-11
- https://support.claude.com/en/articles/11647753-how-do-usage-and-length-limits-work (modified 2026-10-08), read 2026-10-11
- https://support.claude.com/en/articles/11049741-what-is-the-max-plan (modified 2026-10-07), read 2026-10-11
- https://support.claude.com/en/articles/12429409-manage-usage-credits-for-paid-claude-plans (modified 2026-10-08), read 2026-10-11
- https://support.claude.com/en/articles/9797557-usage-limit-best-practices (modified 2026-09-22), read 2026-10-11
- https://support.claude.com/en/articles/17007452-what-is-a-limit-reset (modified 2026-09-22), read 2026-10-11
- https://support.claude.com/en/articles/14552983-models-usage-and-limits-in-claude-code (modified 2026-09-22; written for Enterprise and API-key sign-ins), read 2026-10-11
- Repository (read-only): /home/user/devos/plan/work/W-C01-17.md, /home/user/devos/plan/work/C00.md:80–89, /home/user/devos/evidence/C01/EV-C01-022a_W-C01-12_row5_documentation_report.md, /home/user/devos/evidence/C01/EV-C01-022_W-C01-12_row5_routine_limit.md
