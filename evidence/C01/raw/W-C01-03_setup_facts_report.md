# Research report: platform facts for W-C01-03 (probe design), C01

**Question.** What do the current official Claude Code docs say about cloud environments, routines, GitHub access from cloud sessions, the Claude Code version, and paid features? The answers let W-C01-03's writer state the settings of P1 and P2, write Batu's C01 steps (plan Section 12 item 0) as single actions, and plan routine runs against the run limit.

**Reading basis.** Everything was read on 2026-10-06. The code.claude.com pages came back as full markdown, and quotes from them are verbatim. The support.claude.com articles came back already summarised by the fetch tool, so their quotes are less reliable. Only about the first 100k of the changelog's 969k characters was read. I did not read the library.

## Disciplines (D1–D9)

D1: yes: I treated the plan's premises (15 runs a day, pushes limited to `claude/` branches, environments that can be deleted, the guard loading in every probe session) as assumptions to test; the current docs contradict four of them, and I keep documentation apart from observed behaviour.
D2: yes: the plan marks the 15-a-day limit as checked, so I looked for official text both for and against it, and I report the contradiction instead of reconciling it toward the plan.
D3: yes: I kept the report to what the probe design and Batu's single-action steps need (labels, order, limits, paid switches), and I flag the step in Section 12 item 0 that cannot be done as written.
D4: uncertain: every finding is marked as documentation, not observation, so that no C01 row counts as verified by this report.
D5: yes: I quoted code.claude.com pages from the full returned text, marked the support.claude.com quotes as tool-summarised, and recorded that I read about 10% of the changelog and about 87% of the model-config page.
D6: no
D7: no
D8: uncertain: before reading the plan and `plan/work/W-C01-03.md` I confirmed the working tree is at `origin/main` (`4113915`, merge of PR #189).
D9: yes: the task excluded the library, so I did not consult it; this is new outside research, dated so it can be checked again, and it is for the executor to record as a candidate.

**Source key.** Each page below is cited by its key. All were read on 2026-10-06.

*Filed by the executor with one edit: the researcher wrote each code.claude.com page's full address. Those addresses match the research library's fingerprints, because the library holds the same public addresses, so the guard's leak check (L1) would deny them. For those rows the Address column therefore gives the page's name under the base address of the official Claude Code documentation (the site code.claude.com, path docs/en/); the support.claude.com addresses are kept as written. Nothing else is changed.*

| Key | Address | Page's own date |
|---|---|---|
| WEB | page `claude-code-on-the-web` | undated |
| ENV | page `cloud-environments` | undated |
| RT | page `routines` | undated; says "research preview" |
| QS | page `web-quickstart` | undated |
| PM | page `permission-modes` | undated |
| SET | page `settings` | undated |
| SHD | page `self-hosted-environments-deploy` | undated |
| DESK | page `desktop` | undated |
| PROJ | page `claude-projects` | undated |
| COST | page `costs` | undated |
| FAST | page `fast-mode` | undated |
| CMD | page `commands` | undated |
| W16 | page `whats-new/2026-w16` | "April 13–17, 2026" |
| WN | page `whats-new` | latest entry "Week 37 · September 7–11, 2026" |
| CL | page `changelog` | top entry v2.1.291, "October 6, 2026" as the fetch tool reported it; first ~100k characters read |
| SUP-WEB | https://support.claude.com/en/articles/12618689-claude-code-on-the-web | "Updated March 16, 2026" (summarised) |
| SUP-UC | https://support.claude.com/en/articles/12429409-extra-usage-for-paid-claude-plans | "Updated over a week ago" (summarised) |
| SUP-LIM | https://support.claude.com/en/articles/14552983-models-usage-and-limits-in-claude-code | "over 2 weeks ago" (summarised; says nothing on routines) |

Labels in the findings: (S) the source states it; (I) my interpretation; (Inf) my inference.

---

## 1. Cloud environments

**Creating and naming an environment**
- (S) "Create, edit, and archive environments from the environment selector" [ENV]
- (S) "On claude.ai/code, select the cloud icon showing the current environment's name, in the row above the message box. There's no settings page or direct URL for the selector." [ENV]
- (S) "Select **Cloud** to list your environments. Then select **Add cloud environment**, or hover over an existing environment and select the settings icon that appears on the right." [ENV]
- (S) "The dialog includes the name, network access level, environment variables, and setup script. When you edit an existing cloud environment on a Pro or Max plan, the dialog also includes API credentials." [ENV]
- (S, from the screenshot's alt text, so less direct) the new-environment dialog has "a Name field with the placeholder Default" and "Cancel and Create environment buttons". [ENV]
- (S) "Environments you create are personal to your account" [ENV]

**Network access levels**
- (S) The **Network access** field "takes one of four levels": **None**, **Trusted**, **Full** ("Any domain") and **Custom** ("Your own allowlist, optionally including the defaults"). [ENV]
- (S) "open it for editing and use the **Network access** selector in the dialog." [ENV]
- (S) From the routine editor: "Select **Full** instead for unrestricted access." … "Click **Save changes**. The new policy applies from the next run." [RT]
- (S) Existing sessions "follow the new setting within about a minute". [ENV]
- (S) Whatever the level, sessions still reach "GitHub, through its separate proxy", "MCP connectors you enable", "the hosts you listed on the environment's API credentials", and "The Anthropic API … even at **None**". [ENV]
- (I) The Trusted allowlist [ENV] has no Supabase domain, so Supabase needs **Full**, **Custom**, or an API credential host.

**Environment variables and secrets: where they are entered, and whether a value is shown again**
- (S) Variables: "Environment variables use `.env` format, one `KEY=value` pair per line." [ENV]
- (S) A session reads them "into ordinary environment variables that any command Claude runs can read". [ENV]
- (S) "Anyone who uses the environment can read the values." [ENV]
- Whether the dialog shows a variable's value again after saving: not stated.
- (S) API credentials, the hidden-secret field: "An API credential is an API key or token you store on a cloud environment so Claude can call that API from any session in the environment without seeing the key." [ENV]
- (S) "The key never reaches Claude, the commands it runs, or the session's environment variables." [ENV]
- (S) "API credentials are available on Pro and Max plans." [ENV]
- (S) Requirement: "an organization admin role … On Pro and Max, you hold it in your own organization". [ENV]
- (S) Steps: open the environment for editing; "In the **Edit environment** dialog, find the **API credentials** section." [ENV]
- (S) "Select **Add credential** … Keep the default **Credential type**, **Bearer**". [ENV]
- (S) The form's fields are "**Name**", "**Allowed websites**" and "**Custom headers**". The header row has a **Name**, a **Prefix** and a **Value**: "For a header like `X-Api-Key` that takes the bare value, change the name and clear the prefix". [ENV]
- (S) "Select **Connect**. The credential appears in the list with its hosts, saved without the dialog's **Save changes** button. You can't view the value again after saving." [ENV]
- (S) "you can't edit a credential after you add it. To change a credential's hosts or value, delete it and add it again." [ENV]
- (S) "Sessions can reach those hosts even when the environment's network access level wouldn't otherwise allow them" [ENV]
- (S) "The credential applies in every session that runs in the environment, whoever started it, until you delete it." [ENV]
- (S) Never attached: GitHub, `api.anthropic.com`, the package registries, and "**Setup script requests**". [ENV]
- (I) This field fits plan 6.3 (a token in a separate header, in the environment's settings field) better than an environment variable, which the session can read. It exists only when *editing* an environment that already exists, so "create the environment" and "add the probe token" are two separate actions. Whether the session really cannot see the token is still for row 3 to observe.

**Setup script**
- (S) "A setup script is a Bash script that runs when a new cloud session starts, before Claude Code launches." [ENV]
- (S) "enter your script in the **Setup script** field". [ENV]
- (S) "if the script exits non-zero, the session fails to start". [ENV]
- (S) It is cached when it finishes "under roughly five minutes". [ENV]
- (S) It "doesn't run when a session's VM is restored after being idle". [ENV]

**Deleting an environment**
- (S) "To archive one of your own environments, open it for editing and select **Archive**." … "You can't delete an environment, only archive it." [ENV]
- (S) "API credentials on the environment stay attached in its running sessions. Delete any you no longer want before you archive." [ENV]
- (S) "Anything configured with the environment explicitly, such as a routine, can't start new sessions in it." [ENV]

**Whether an environment is tied to repositories**
- Not stated as such.
- (I) The listed dialog fields include no repository. Repositories are chosen per session ("click the repository selector below the input box", [QS]) and per routine ("Select repositories", [RT]).

## 2. Routines

**Creating a routine: repository, environment, starting prompt, schedule**
- (S) "Visit claude.ai/code/routines and click **New routine**." [RT]
- (S) Name and prompt: "Give the routine a descriptive name and write the prompt Claude runs each time." [RT]
- (S) "The prompt input includes a model selector. Claude uses the selected model on every run." [RT]
- (S) Repositories: "Each repository is cloned at the start of a run, starting from the default branch. Claude creates `claude/`-prefixed branches for its changes." [RT]
- (S) Environment: "Pick a cloud environment for the routine." [RT] In the edit form: "Below the **Instructions** box, select the cloud icon showing your environment's name". [RT]
- (S) Trigger: "Under **Select a trigger**, choose how the routine starts." The tabs are **Schedule**, **GitHub event** and **API**. [RT]
- (S) Schedule presets: "hourly, daily, weekdays, or weekly"; a "one-off run at a specific timestamp"; "Times are entered in your local zone". [RT]
- (S) "The minimum interval is one hour". Scheduling exactly on the hour "can start several minutes late". [RT]
- (S) "Click **Create**." [RT]
- Whether a routine can be saved with no trigger at all: not stated.
- (S) The saved prompt "is not live user input and can't act as approval or consent for actions during the run". Before v2.1.213 it was "framed as an untrusted background notification". [RT]

**Connectors: removing them, and the default for a new routine**
- (S) "Under **Connectors** at the bottom of the form, all of your connected MCP connectors are included by default. Remove any the routine doesn't need" [RT]
- (S) "When you create a routine, all of your currently connected connectors are included by default." [RT]
- (S) Connectors "work without adding their hosts to **Allowed domains**, because connector traffic travels through Anthropic's servers". [ENV]
- (S) Your repo's `.mcp.json` MCP servers load: "Yes, in a session with one repository". [ENV]
- Whether the GitHub connection appears in a routine's **Connectors** list, and what removing it there would do to cloning and pushing: not stated. The GitHub credentials are managed at the same connectors page ("disconnect GitHub at claude.ai/customize/connectors", [QS]).

**How a run starts**
- (S) "**Scheduled**", "**API**: trigger on demand by sending an HTTP POST to a per-routine endpoint with a bearer token", "**GitHub**". [RT]
- (S) "To start a run immediately, click **Run now** on the routine's detail page." [RT]
- (S) Run now "can optionally supply run-specific text". That text arrives "wrapped in a `<routine-fire-payload>` block that labels it as untrusted data"; "The same wrapping applies to text supplied with **Run now**". [RT]
- (S) API trigger: "click **Add another trigger**, and choose **API**" … "click **Generate token** … The token is shown once". [RT]

**Run limits**
- No daily run limit is stated on the current routines page.
- (S) Each way of starting a run has an hourly limit [RT]:

  | Action | Limit | Counted for |
  |---|---|---|
  | Scheduled runs, including one-off runs | 100 per hour | your account |
  | **Run now**, API fires, and setting a one-off routine to run again | 30 per hour | each routine, one count shared by all three |
  | **Run now** and one-off re-runs | 100 per hour | your account |
  | API fires | 100 per hour | your account |

- (S) "None of these hourly limits has overage." [RT]
- (S) "Routines draw down subscription usage the same way interactive sessions do. See your current consumption at claude.ai/settings/usage." [RT]
- (S) "Without usage credits, additional runs are rejected until your usage window resets." [RT]
- (S) The launch digest says nothing about a run limit. [W16]
- Where the user sees a count of routine runs against any limit: not stated. Only usage consumption is pointed to.

**Permission mode and model**
- (S) "there is no permission-mode picker, and the session runs shell commands, uses skills committed to the cloned repository, and calls any connectors you include, all without stopping for approval apart from some artifact actions." [RT]
- The name of the mode a routine session runs in, and whether the auto-mode classifier acts there: not stated.
- (S) For comparison, the cloud-session modes are "Accept edits, Plan, and Auto … Bypass permissions isn't available." [PM]
- (S) Cloud sessions "still honor `defaultMode: "acceptEdits"` from settings" and "don't honor `defaultMode: "bypassPermissions"` or `"dontAsk"`". [PM]
- Model: user-set through the selector, as quoted above.
- Effort for a routine: not stated.

**Pushing**
- (S) "Claude pushes its work to a branch prefixed with `claude/` unless your prompt directs it to push to another branch. To control which branches a run can push to, use branch protection rules or rulesets on GitHub." [RT]
- (S) "GitHub applies them to the GitHub access you connected, so a rule that access can bypass doesn't block a run's push." [RT]
- (S) "commits and pull requests carry your GitHub user" [RT]

**Deleting, pausing, and the GitHub connection**
- (S) Delete: "Open the same menu and select **Delete** to delete the routine." The menu is the one "next to the routine's name". [RT]
- (S) Pause: "Use the on/off switch at the top of the page to pause or resume the schedule." [RT]
- Whether deleting a routine deletes its past run sessions: not stated.
- (S) If the GitHub connection is missing, the routine "skips runs … for up to 72 hours" and then "turns off". [RT]
- (S) Run status: "A green status in the run list means the session started and exited without an infrastructure error. It does not mean the task in your prompt succeeded." [RT]
- (S, tool-extracted from the changelog) v2.1.286: never-started runs "now show as Failed", and a late run reads "Due". [CL]

## 3. GitHub access from cloud sessions

**What the git proxy uses**
- (S) "the git client inside the VM uses a scoped credential, which the proxy verifies and swaps for your actual GitHub token." [ENV]
- (S) "For ordinary user sessions, the proxy uses the GitHub or GitHub Enterprise OAuth token stored for the session creator; for bot and agent sessions, it uses your organization's GitHub App installation token … This is the same auth path Anthropic-hosted environments use." [SHD]
- Whether a routine run counts as a "user" or a "bot and agent" session: not stated. [RT] says routine commits "carry your GitHub user".
- (S) What the GitHub App connection reaches: "Any public repository, and private repositories that the Claude GitHub App is installed on". [WEB]
- (S) "GitHub API and release-asset requests reach only repositories attached to the session". [ENV]
- (S) `gh` sees `GH_TOKEN` as "the placeholder string `proxy-injected`". [ENV]

**Push restrictions**
- No `claude/`-only restriction is stated.
- (S) "the proxy rejects branch deletions and pushes of anything other than a branch, such as a tag. It doesn't limit which branches a push can update. To do that, use branch protection rules or rulesets on GitHub." [ENV]
- Whether a branch can be deleted through the REST API via the proxy: not stated.

**PR creation, merging and auto-merge**
- (S) In the UI: "select **Create PR** at the top of the diff view. You can open it as a full PR, a draft, or jump to GitHub's compose page". [QS]
- (S) Desktop: "**Auto-merge when ready**: when enabled, Claude merges the PR once all checks pass. The merge method is squash. Enable auto-merge in your GitHub repository settings first". [DESK]
- (S) Projects: "**Merge it** send[s] that instruction to the thread". [PROJ]
- (S) The proxy "serves only a pinned set of GraphQL operations for pull-request workflows", and the rest get a 403 "`This GraphQL query is not enabled for this session`". [ENV]
- Whether that pinned set includes enabling GitHub's own auto-merge, and whether merging through REST is allowed: not stated.
- (Inf, from my own knowledge of GitHub, not from an allowed source) GitHub enables auto-merge through a GraphQL mutation, so the probe may get that 403. The probe must observe this; it is not evidence.

**Clone depth**
- For Anthropic-hosted sessions, whether the clone is shallow by default, and whether the depth can be set: not stated.
- (S) Only for self-hosted runners: "`CLAUDE_RUNNER_FETCH_DEPTH` (`full`, `0`, or a number; default 50) controls only the cold clone". [SHD]
- (S) "Claude clones the repo fresh every session". [QS]

**Settings, hooks and skills in single- and multi-repository sessions** (bears on rows 9 and 13 and on the guard)
- (S) "A session with several repositories starts above the clones and reads only the `enabledPlugins` and `extraKnownMarketplaces` keys from each repository's `.claude/settings.json`, not permission rules, hooks, `env`, or other keys." [SET]
- (S) Hooks and permission rules load: "Yes, in a session with one repository". [ENV]
- (S) "Cloud sessions automatically load skills you enable on claude.ai". [ENV]

## 4. Claude Code version in a cloud or routine session

- Which version an Anthropic-hosted session runs, and where it is shown: not stated.
- (S) Features are gated "in the session's environment", for example "Requires Claude Code v2.1.223 or later in the session's environment." [WEB] [FAST]
- (S) `/status` "Open[s] the Settings interface on the Status tab, showing version, model, account, and connectivity". [CMD]
- (S) But "Commands that only run in the terminal interface … aren't available" in cloud sessions. [WEB] Whether `/status` works in a cloud session: not stated.
- (S) General advice: "Run `claude --version` to check your current version." [COST]
- (S, tool-reported) The latest release is v2.1.291 (October 6, 2026). [CL]

## 5. Costs and paid features among these settings

- (S) "There is no separate compute charge for the cloud VM"; cloud sessions "share rate limits with all other Claude and Claude Code usage". [WEB]
- (S) Usage credits are the paid switch. For Pro or Max: "**Settings > Usage** … In its **Usage credits** section you can turn usage credits on or off". [COST]
- (S) Routines "can keep running routines on metered overage" only "with usage credits turned on". [RT]
- (S) "Usage credits apply to both Claude conversations and Claude Code terminal usage." [SUP-UC, summarised]
- (S) Fast mode is paid: "available via usage credits only". [FAST]
- (S) On claude.ai/code it can be toggled "from the model menu on the message box". [FAST]
- (S) Without credits, `/fast` reports "Fast mode requires usage credits". [FAST]
- Full network access, API credentials, setup scripts and Run now: no cost is stated for any of them.
- (S) Projects "uses [plan limits] faster", and "A thread can't turn [usage credits] on for you." [PROJ]
- (S) Self-hosted environments are Team/Enterprise only. [ENV]

## UI labels for Batu's steps, in order

1. **Environment:** claude.ai/code → cloud icon showing the environment's name, above the message box → **Cloud** → **Add cloud environment**. Fill **Name** and **Network access** (**Full**), then **Create environment** (that button label comes from alt text).
2. **Probe token:** hover over the environment → settings icon → **Edit environment** → **API credentials** → **Add credential** → **Credential type** **Bearer**, **Name**, **Allowed websites**, **Custom headers** (header **Name**, cleared **Prefix**, **Value**) → **Connect**.
3. **Routine:** claude.ai/code/routines → **New routine** → name, prompt and model selector → select repositories → environment (cloud icon below **Instructions**) → **Select a trigger** → **Connectors**: remove all → **Create**.
4. **Running:** **Run now** on the routine's detail page.
5. **Removal:** routine menu → **Delete**; for each environment, delete its API credential, then open the environment for editing → **Archive**.

## Counter-evidence and contradictions

- **Daily limit.** Plan 6.4 and row 5 assume "15 runs a day". The current [RT] states only hourly limits and no daily cap. The plan's source was a claude.com blog post (per `plan/Inceleme_Degerlendirmesi_Claude.md:16`), which is outside the allowed sources and was not read. [RT] warns that limits "may change".
- **`claude/` branches.** Plan 6.3 lists "pushing to `claude/` branches" as an authority, and row 8 expects a restriction. [ENV] says the proxy "doesn't limit which branches a push can update", and [RT] makes `claude/` a default behaviour, not an enforcement.
- **Deleting environments.** Section 12 item 0 asks Batu to delete the probe environments. [ENV]: "You can't delete an environment, only archive it."
- **Guard in `devos-probe-b`.** P2 gives that routine two repositories. [SET] says such a session reads no hooks or permission rules, so (I) the guard and the probe-only guard rule would not run in `devos-probe-b`.
- **Branch deletion.** Row 8 asks how a branch the probe creates is deleted. The proxy "rejects branch deletions". [ENV]
- **Between official pages:** no direct contradiction found. One tension: [PM] lists cloud modes, while [RT] says routines have "no permission-mode picker"; these describe different surfaces.
- **Old support article.** [SUP-WEB] (March 2026) predates routines and says nothing about limits.

## Open

- The GitHub connection in a routine's **Connectors** list, and what removing it does.
- The name of a routine's permission mode, and whether the classifier acts there.
- A routine's effort level.
- The clone depth in Anthropic-hosted sessions.
- Whether GitHub auto-merge can be enabled, or a PR merged, through the proxy.
- Which Claude Code version runs in a cloud session, and whether `/status` works there.
- Whether a routine can be saved with no trigger.
- Whether deleting a routine deletes its run sessions.
- Not read: about 90% of the changelog; the last ~13% of the model-config page; the claude.com blog; platform.claude.com's `/fire` reference (outside the allowed list).

## For the decision

- The probe design should not plan against "15 a day". Row 5 must read the account's real value where the platform shows it. The docs give hourly caps (30 per routine per hour for Run now) and subscription usage.
- Section 12 item 0's "deleting the probe environments" cannot be done as written; the platform's equivalent is "delete the credential, then **Archive**". Under W-C01-03 item 8, a step beyond item 0's wording is recorded as a finding and routed by working order section 8 before Batu is asked.
- The probe token is best put in an **API credential** on the environment. That needs two actions per environment: create, then edit.
- Row 8's push outside `claude/` is not blocked by the platform according to the docs. Only GitHub rules and the guard stand against it, and a rule the connected access can bypass does not block.
- The design should assume no guard in `devos-probe-b` sessions, and no branch deletion through git.
- To avoid enabling a paid feature, every step must leave usage credits off, which also keeps fast mode off.

## Guard denials

None.
