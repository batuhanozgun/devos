*Filed verbatim: the final report of a researcher subagent of the working session `session_01XyxvJd3RayQk4HCrjurbVH` for W-C01-12 (row 5's documentation part), written 2026-10-11; every URL in it was read on 2026-10-11; its task named Batu's plan "Pro" by mistake, as the report says, and the plan records Max (criterion 25, "Max $200 plan").*

I found what the documentation says, but it no longer supports the plan's "15 runs a day". The live routines page has no daily cap at all. It now lists only hourly limits on starting runs, plus the ordinary subscription usage. The daily cap was removed from the page between 2026-09-29 and 2026-09-30. A second problem: the task says the account is on Pro, but the plan records it as Max.

All reads were on 2026-10-11. Live pages were read as raw text: the routines page was fetched at about 14:02Z and the `/fire` API reference the same day; the archived copies are at web.archive.org. In the findings, [S] means the source states it, [I] is my interpretation, and [Inf] is my inference.

**Question.** What does Anthropic's documentation say about the daily routine run limit (value by plan, unit, what counts, reset, what happens at the limit)? Where is the account's own value shown? Do routine runs share usage with ordinary use? This serves W-C01-12 (C01 row 5) and whether plan 6.4's "within the limit of 15 runs a day" stands.

## Disciplines (D1–D9)
D1: yes: "a daily cap exists" vs "none exists", and Pro vs Max, could each change the conclusion, so I traced the documentation's history to tell them apart and state the result conditionally on Batu's own page.
D2: yes: I did not let the plan's "[Verified]" tag, the task's "Pro" or a wish to keep 6.4 unchanged steer the weighing, and I looked for evidence on both sides.
D3: yes: I stayed within the documentation part and where the value is read, called no session or routine tool, and leave the fail-path decision to you.
D4: yes: I treat the plan's September "Verified" verdict as stale because its source changed on 2026-09-30, and I limit my confidence because documentation is not the account's observed value.
D5: yes: I read raw page text and archived copies instead of summaries, traced a claim first seen in a search summary to its primary source, and give the scope of every "silent" claim.
D6: no
D7: no
D8: yes: I read the acceptance block and the repository's earlier reads first, and I flag the task's "Pro" against the plan's "Max" instead of choosing one.
D9: uncertain: I did not consult the library (the task says it is not needed, and platform limits need a current primary source); the result is a new dated platform finding for your evidence record, not for the library.

## Findings

### 1. What the documentation says about run limits

**Plan name (conflict to settle first).**
- The task says Pro.
- The plan says "**Claude:** Max $200 plan" as Batu's decision (`/home/user/devos/plan/DevOS_Kurulum_Plani.md:232`, criterion 25).
- D-020 says "your Max account" (`/home/user/devos/plan/decisions/D-020.md:32`).
- EV-C01-002 says "Batu's plan is Max" (`/home/user/devos/evidence/C01/EV-C01-002_row3_environment_token.md:44`).
- I found no record of a change to Pro. This matters because the launch figures differ by plan (below).

**Current documentation** (https://code.claude.com/docs/en/routines; raw `.md`, line numbers from that file):
- [S] :10 "Routines are in research preview. Behavior, limits, and the API surface may change."
- [S] :65 "their runs count against your account's usage and limits".
- [S] :378 "Routines draw down subscription usage the same way interactive sessions do. See your current consumption at claude.ai/settings/usage."
- [S] :380–387 "Separately from subscription usage, each way of starting a run has an hourly limit":

| Way of starting | Limit | Counted for | Over the limit |
|---|---|---|---|
| Scheduled runs, including one-off runs | 100 per hour | the account | "The run waits until the limit resets" |
| Run now, API fires and re-arming a one-off routine | 30 per hour | each routine, one shared count | "The action fails until the limit resets" |
| Run now and re-arming a one-off | 100 per hour | the account | same |
| API fires | 100 per hour | the account, "counted separately from **Run now**" | same |

- [S] :390 "None of these hourly limits has overage."
- [S] :163 "One-off runs count against the same hourly limit as other scheduled runs."
- [S] :237 GitHub events: "subject to per-routine and per-account hourly caps. Events beyond the limit are dropped until the window resets." No figures are given.
- [S] :392 At the subscription usage limit: "Without usage credits, additional runs are rejected until your usage window resets."
- [S] The current API reference (https://platform.claude.com/docs/en/api/claude-code/routines-fire.md) agrees:
  - "each routine accepts up to 30 fires per hour (shared across API fires, the **Run now** button in the web UI, and one-shot re-arms), and each account can make up to 100 API fires per hour across all routines".
  - Over the limit it returns `429 rate_limit_error` with a `Retry-After` header.
- **Silent today:** any daily limit; any value per plan; whether the hourly windows are rolling or clock hours; the GitHub cap values; whether a failed or idle run counts.
  - [I] Every limit counts runs *started* (scheduled, Run now, fire), so an idle or failed run that started would count.
  - [S] :306 A green status in the run list only means the session started and exited without an infrastructure error.

**Earlier documentation** (Wayback copies of the same URL):
- The daily-cap wording is in every copy I read from 2026-04-14 to 2026-09-29 10:03Z: 20260414172740, 20260416200827, 20260512143518, 20260616160008, 20260716184456, 20260804221412, 20260910154716, 20260929100325.
- It is gone from 2026-09-30 09:33Z on: all 11 copies through 20261010004518 have the hourly table instead.
- [S] The old text said:
  - "they count against your account's daily run allowance";
  - "routines have a daily cap on how many runs can start per account. See your current consumption and remaining daily routine runs at claude.ai/code/routines or claude.ai/settings/usage";
  - "When a routine hits the daily cap or your subscription usage limit, organizations with usage credits turned on can keep running routines on metered overage. Without usage credits, additional runs are rejected until the window resets";
  - "One-off runs do not count against the daily routine cap."
- [S] No copy I checked gives a number per plan, a reset time or a time zone for the daily cap.
- [S] Old API reference (archived copy 20260615175806):
  - "Routine runs count against a per-account daily allowance that varies by plan";
  - "Your remaining daily runs are shown at claude.ai/code/routines";
  - a 429 meant "The account's routine run limit or usage limit has been reached."
  - The 20260830 copy still has the daily allowance; the 20261004 copy has the hourly wording.
  - [I] On that page, runs started through the API counted against the daily allowance.

**The figures themselves.**
- [S] The announcement (https://claude.com/blog/introducing-routines-in-claude-code, now at claude.com/resources/articles/…; published 2026-04-14, no modified date): "Pro users can run up to 5 routines per day, Max users can run up to 15 routines per day, and Team and Enterprise users can run up to 25 routines per day. You can run extra routines beyond these limits with extra usage."
  - It does not tell Max 5x from Max 20x, and it gives no reset time.
- [S] The Claude apps changelog (https://claude.com/docs/cowork/changelog, entry v1.14271.0 dated 2026-06-18, under "Code"): "Changed routines to count against your regular usage limits instead of a separate daily included-run limit, and removed the included-runs indicator."
- [S] The Claude Code CLI changelog has no entry about a routine run limit.

**Help center.**
- [S] I scanned all 361 English articles in support.claude.com/sitemap.xml for routine-feature wording. None states a routine run limit.

### 2. Where the account's own value is shown
- **claude.ai/settings/usage (Settings > Usage)**
  - [S] routines.md:378 "your current consumption" (subscription usage).
  - [S] Max help article 11049741 (modified 2026-10-07): "You can see your next reset time in Settings > Usage."
  - [S] Until 2026-09-29 the docs said remaining daily routine runs also showed here. The docs no longer say so.
- **claude.ai/code/routines and each routine's detail page**
  - [S] routines.md:299 says the detail page shows "a list of past runs". Batu can count runs per day there.
  - [S] Earlier docs and the old API reference put "remaining daily runs" here, and the old GitHub note said "See your current limits at claude.ai/code/routines".
  - [S] The 2026-06-18 changelog says the "included-runs indicator" was removed (Desktop app).
- **Tools a cloud session can use** (none called):
  - [S] The status line's `rate_limits` has only `five_hour`, `seven_day` and `spend_limit` (code.claude.com/docs/en/statusline :195–198, :345). No routine window.
  - [S] `/usage` is built from local session history and has no routine row (costs.md:58–64).
  - [S] `RemoteTrigger` `list_runs` "lists a routine's recent runs", per routine. Its output is opaque JSON, and the docs name no limit field (agent-sdk/typescript.md, RemoteTrigger).
  - [S] An API fire over the limit returns `Retry-After`.
  - `get_session`/`rate_limit_info` is not documented on the pages I searched. The repository's own records show window type, state, `resetsAt` and an overage flag, with "the fraction used is not shown" (`/home/user/devos/plan/work/C00.md:84`, `/home/user/devos/briefs/builder-operating-model/BRIEF.md:64`). That comes from records, not my reading. No routine field has been recorded.

### 3. Shared budget with ordinary use (for W-C01-17)
- [S] Routines "draw down subscription usage the same way interactive sessions do" (routines.md:378).
- [S] A cloud session "counts toward your plan's usage limits alongside the rest of your Claude and Claude Code usage" (claude-code-on-the-web.md:13).
- [S] Help center 11145838 (modified 2026-10-08): "These limits are shared across Claude and Claude Code, meaning all activity in both tools counts against the same limits."
- [S] Help center 11647753 (modified 2026-10-08): paid plans have "a session limit that resets every five hours, and weekly limits that reset once every week."
- [S] errors.md:712: "Usage counts against the session and weekly allowances at the same time."
- [S] Max help 11049741: the weekly reset is "a fixed time each week that is assigned to your account". Max also has a separate weekly limit for Fable.
- [S] The hourly start limits are "Separately from subscription usage".
- [Inf] Every probe run reduces the same five-hour and weekly windows Batu uses himself. With extra usage off (criterion 25), a run at that limit is rejected.

### 4. Counter-evidence to "15 runs a day"
**Against:**
- The live docs state no daily cap (read 2026-10-11).
- The docs (and the API reference, between 08-30 and 10-04) replaced the daily cap with hourly limits on 2026-09-29/30.
- The apps changelog dated 2026-06-18 says the separate daily limit was replaced by regular usage limits.

**For:**
- The 2026-04-14 announcement: 15 a day on Max, 5 on Pro.
- The docs up to 2026-09-29: a daily cap, with no number.
- A secondary source (claude-monitor.com guide, an independent project, "Last updated: October 6, 2026") says routines have their own daily allowance "shown on the usage page next to the other limits". I could not check its basis (guard denial below).

**Neither:**
- Max help 11049741 reserves "model and feature usage" limits "at our discretion".
- The page warns that limits may change during the research preview.

**Freshness of the plan's tag.**
- Plan :392's "[Verified: code.claude.com/docs/en/routines and the Anthropic announcement, September 2026]" matched the docs only until 2026-09-29.
- The figure "15" only ever came from the announcement.

[Inf] Most likely there is no longer a separate daily cap. But the docs ran three months behind the changelog, and one source says a daily row is still shown. So the documentation alone cannot settle the account's real state.

## Open: "could not check" unless Batu reads his page
1. Is there a routine-runs or daily-allowance line on **claude.ai/settings/usage** (Settings > Usage)? If so, the record needs its used/limit figure, reset time and time zone, read with the date. Next to it he can also read the five-hour and weekly reset times.
2. Is there a "remaining" or "included runs" indicator on **claude.ai/code/routines**? On `devos-c01-rutin`'s detail page, the runs listed for each day.
3. Do API-started runs count against a daily figure? If no daily figure exists, this falls away: the docs now say API fires count hourly, separately from Run now. If one does exist, it cannot be seen, because DevOS's routine has no API trigger (`/home/user/devos/evidence/C01/routine/ROUTINE_DESIGN.md:17`).
4. The account's plan and tier (Max 5x/20x or Pro), as shown in his account settings. I did not read where claude.ai shows it.
5. Not documented anywhere I read: the account's own hourly counts, the GitHub cap values, and whether Cowork's cloud scheduled tasks (help article 13854387, since 2026-10-06) share routine limits.

**Not read:** claude.ai's signed-in pages; the claude-monitor extension source (denied); archived copies other than the ones listed; X posts and the third-party guides in search results (verdent, mindstudio) beyond their summaries.

## For the decision
- "15 a day, verified" cannot stand. The current documented constraints are hourly start limits, far above DevOS's use, and the shared five-hour and weekly usage. That may change the unit of plan 6.4's budget table from runs to usage. That is your call through the fail path; I am not deciding it.
- Asking Batu for items 1, 2 and 4 is the only way to record the real value. Nothing needs to be used up to answer them.

## Guard denials
- **B7:** `gh api` read of the secondary tool's public repository. Dropped, not tried by another route.
- **G0:** unbalanced backticks in a grep pattern. Repeated in a well-formed shape, as the denial directed.

Both are in `/tmp/devos-guard/session_01XyxvJd3RayQk4HCrjurbVH.jsonl` (#6393, #6471). I did not run `tools/guard_report.py` because my role writes nothing, so please record them.

Sources:
- [Automate work with routines](https://code.claude.com/docs/en/routines) and its [Wayback history](https://web.archive.org/web/2026*/code.claude.com/docs/en/routines)
- [Introducing routines in Claude Code](https://claude.com/blog/introducing-routines-in-claude-code)
- [Trigger a routine via API](https://platform.claude.com/docs/en/api/claude-code/routines-fire)
- [Claude apps changelog](https://claude.com/docs/cowork/changelog)
- [What is the Max plan](https://support.claude.com/en/articles/11049741-what-is-the-max-plan)
- [Use Claude Code with your Pro or Max plan](https://support.claude.com/en/articles/11145838-use-claude-code-with-your-pro-or-max-plan)
- [How do usage and length limits work](https://support.claude.com/en/articles/11647753-how-do-usage-and-length-limits-work)
- [Schedule recurring tasks in Claude Cowork](https://support.claude.com/en/articles/13854387-schedule-recurring-tasks-in-claude-cowork)
- Code docs: [costs](https://code.claude.com/docs/en/costs), [status line](https://code.claude.com/docs/en/statusline), [errors](https://code.claude.com/docs/en/errors), [Claude Code on the web](https://code.claude.com/docs/en/claude-code-on-the-web), [Agent SDK TypeScript reference](https://code.claude.com/docs/en/agent-sdk/typescript)
- Secondary: [claude-monitor guide](https://claude-monitor.com/claude-code-usage-limits); search-result leads not read in full: [verdent](https://www.verdent.ai/guides/claude-code-limits-doubled-may-2026), [mindstudio](https://www.mindstudio.ai/blog/run-claude-code-automations-without-burning-session-limits)
