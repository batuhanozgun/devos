*Filed verbatim: the final report of a researcher subagent of the working session `session_01XyxvJd3RayQk4HCrjurbVH` for PC-35's reopening (the account's synced skills; W-C01-46, EV-C01-026, CHK-C01-099), written 2026-10-11 between 20:07:54Z and 20:13:26Z (the decision log); every page in it was read on 2026-10-11. Its guard denial (#10839, G0) is recorded in the log. It is a documentation report: it observes nothing about the account, and its findings are "Guaranteed by platform where stated; not independently tested".*

# Synced skills: documentation report (PC-35 reopened)

## Disciplines (D1–D9)
D1: yes: I treated "only the repository can act" as a frame choice, so I also checked the environment-level routes (environment variables, setup script) and the account route, and gave conditional conclusions where an assumption is unresolved.
D2: uncertain: the builder hopes for a repository route because it avoids asking Batu, so I reported the documented "a repository can't" statements as fully as the one route that might work, and marked that route untested.
D3: yes: the purpose is to inform whether the repository can keep synced skills out before an account step goes to Batu, so I answered Q1 to Q5, kept "removed from the list" apart from "only refused when called", and decided nothing.
D4: uncertain: documentation is not a test, so each mechanism is marked as documented or not stated and "not independently tested", and I flag that no page says `skillOverrides` applies to synced skills.
D5: yes: one source came through a small-model WebFetch summary and the doc searches were grep-based, so I checked the support article's quotes against its raw HTML, read the doc sections in full around each hit, and kept every absence claim limited to the pages read.
D6: no
D7: no
D8: yes: this continues PC-35 and EV-C01-026, so I read PC-35 in full and the relevant lines of EV-C01-023 and EV-C01-026, and checked that the observed Claude Code version (2.1.296) is the changelog's current head, so the docs read match that version.
D9: uncertain: this is a question about current platform behaviour, where freshness needs current primary docs, so I did not consult the library and say so under Open.

## Question
Can the DevOS repository keep the account's synced claude.ai skills (25: 24 in `~/.claude/skills/synced/`, 1 at top level; EV-C01-026:46) out of its cloud and routine sessions, so that they are removed from the session's list and not only refused by guard rule T4? This serves PC-35's reopened `reopen_if`, before any account-level step is put to Batu.

All code.claude.com pages were read on 2026-10-11 at about 20:08Z, as the raw `.md` form (`https://code.claude.com/docs/en/<page>.md`). Line numbers refer to those files. All findings are "Guaranteed by platform where stated; not independently tested."

## Q1. How account skills reach cloud and routine sessions, where they land, what controls them

- **They load in cloud sessions, routines included.** Documented. https://code.claude.com/docs/en/skills (skills.md:218): "Cowork sessions and cloud sessions, including routines, don't read `~/.claude/skills/` on your machine." The same paragraph says Cowork sessions load the skills enabled for the claude.ai account. cloud-environments.md:287: "Cloud sessions automatically load skills you enable on claude.ai". EV-C01-026:46-47 observed this in a routine session.
- **What counts as an account skill.** Documented (skills.md:231). It covers skills the owner creates or turns on in claude.ai settings, skills an organization provides, and some of Anthropic's built-in skills. skills.md:263: some of Anthropic's skills "always sync", and the rest follow the per-skill toggle on claude.ai.
- **Where they land.** Documented. https://code.claude.com/docs/en/settings-reference (settings-reference.md:4269, `syncClaudeAiSkills`): Claude Code downloads them "into `~/.claude/skills/synced/`" in terminal sessions signed in with claude.ai, "and in Cowork and cloud sessions". This matches EV-C01-026:46.
- **Their names in cloud sessions.** Documented in the changelog (https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md, 2.1.269): "Changed skills synced from claude.ai in cloud sessions to be named `anthropic-skills:<name>`". skills.md:454 and 271 add that the short name works when nothing else uses it.
  - Interpretation: EV-C01-026:47's "one shared `<prefix>:`" is probably this reserved namespace. Not verified: the prefix was never recorded.
- **What controls them:**
  - The account owner's per-skill toggle on claude.ai. Documented (skills.md:263, 332; support article below).
  - An organization turning Skills off on claude.ai. Documented (skills.md:265, 267).
  - The `syncClaudeAiSkills: false` setting in user, local or managed settings. Documented (settings-reference.md:4271-4275).
  - Plugin or connector settings: not stated as a control for synced skills. They are not a plugin, which is why the `enabledPlugins` entry does not reach them (EV-C01-026:116).
- **The 1 top-level skill.** Not stated. No page says where a skill at the top level of a cloud container's `~/.claude/skills/` comes from. Inference: the container or platform puts it there, since cloud sessions do not read the owner's machine.

## Q2. Settings a repository could carry, and what each does to the list

| Candidate | What it does | Removes from the list? | Applies to synced skills in cloud or routine sessions? |
|---|---|---|---|
| `syncClaudeAiSkills: false` | Stops the download and stops loading skills already synced | Yes, they stop loading | **Documented as not settable by a repository.** settings-reference.md:4271: "A repository can't turn it off for you." Its scope is user, local or managed. In cloud sessions, user and local settings are "not read" (https://code.claude.com/docs/en/settings, settings.md:755). A committed `.claude/settings.local.json` is "treated as repository-supplied" (settings-reference.md:1643). Managed (server-managed) settings need a Team or Enterprise plan (server-managed-settings.md:12, 19): a cost, so it is Batu's decision. |
| `skillOverrides` in `.claude/settings.json`, value `"off"` (or `"user-invocable-only"`) | settings-reference.md:4242: "Claude Code applies the value under each skill's name to the skill list Claude sees and to your `/` autocomplete." skills.md:892 adds that calling a hidden skill returns an error. | **Yes, documented** ("off": hidden from Claude and from the `/` menu; skills.md:883-888) | **Not stated.** The scope is "Any file" (settings-reference.md:787). A one-repository cloud session reads `.claude/settings.json` (settings.md:754). The only exclusion stated is plugin skills (settings-reference.md:4264; skills.md:909). No page says it covers synced skills, and none says which key matches one (short name or `anthropic-skills:<name>`); skills.md:907 says only "skill names". No wildcard is documented, so each skill would need its own entry in the public repository. For the top-level (personal) skill, entries by name are documented to apply. |
| Permission `deny` `Skill(anthropic-skills:<name>)`, or the prefix form | Blocks the call (skills.md:853-861) | **Not stated** (see Q3) | The deny syntax for a synced skill is documented (skills.md:859). The prefix form `Skill(anthropic-skills *)` is documented only as an *allow* rule (skills.md:868). The guard's T4 already refuses these calls. |
| `deny` on the whole `Skill` tool | "Disable all skills" (skills.md:833) | Inference: yes, the whole Skill tool and its listing go (Q3) | Also removes the repository's own skills, which C05 needs (PC-35 P1). |
| `enabledPlugins` | Turns plugins on or off, keyed `plugin@marketplace` | Plugins only | No: synced skills are not a plugin (EV-C01-026:116). |
| `disableBundledSkills` / `CLAUDE_CODE_DISABLE_BUNDLED_SKILLS` | Turns off the skills that ship with Claude Code | Bundled skills only | Not stated for synced skills. https://code.claude.com/docs/en/env-vars (env-vars.md:251) lists plugin, `.claude/skills/` and `.claude/commands/` as unaffected and does not mention synced skills. Inference: no effect. |
| `strictPluginOnlyCustomization: ["skills"]` | Stops loading synced skills and also the repository's `.claude/skills/` (settings-reference.md:4577) | Yes | Managed settings only. It would also drop DevOS's own skills. |
| `CLAUDE_CODE_SYNC_SKILLS` | Turns syncing *on* for `-p` runs | n/a | Project and local `env` can't set it (settings-reference.md:2931). |
| `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC`, `DISABLE_GROWTHBOOK`, `DISABLE_TELEMETRY`, `DO_NOT_TRACK` | Stop feature-flag fetching, which **terminal** sync needs (skills.md:248, 251; env-vars.md:581) | In terminal sessions, yes | **Not stated for cloud sessions.** Side effects are documented (Remote Control and other features stop; env-vars.md:568-586). The "sync" variable group that project `env` ignores is an open list ("such as", settings-reference.md:2931). Already-synced skills still load offline (skills.md:257). |
| `--safe-mode`, `--bare`, `CLAUDE_CODE_SAFE_MODE`, `CLAUDE_CODE_SIMPLE` | Turn off skills, hooks, CLAUDE.md and more (env-vars.md:377, 385) | Yes | Not a candidate: they would also drop the guard's hooks and `CLAUDE.md`. |
| `CLAUDE.md` | Instructions only | Not stated; no loading mechanism is documented | Inference: guides behaviour only and enforces nothing. |
| Environment level (not the repository): environment variables, or a setup script writing `~/.claude/settings.json` | Env vars reach the session (settings.md:757). cloud-environments.md:300 documents a setup script writing `~/.claude/CLAUDE.md`, which loads. | Not stated | **Contradictory or not stated.** settings.md:755 says user settings are "not read" in cloud sessions, giving the reason that they stay on the owner's machine. Whether a `settings.json` written by a setup script is read is not stated. |
| Self-hosted environment | A routine run there "doesn't get its owner's skills" (self-hosted-environments-configuration.md:638) | Yes | Team and Enterprise public beta (self-hosted-environments.md:10, 43): plan and cost, so Batu's decision. |

## Q3. Does a `deny` rule on the Skill tool remove the skill from the list, or only refuse the call?

- **A rule naming one skill or a prefix: only refusing the call is documented.** skills.md:853: "The table shows what a `deny` rule blocks beyond the name you write". The page and the changelog speak only of blocking. Removal from the list is not stated anywhere I read.
- **Counter-indication.** skills.md:1190: "The listing always contains every skill name, but if you have many skills, Claude Code drops some descriptions to fit the listing's character budget." Interpretation: this sentence is about the size budget, not deny rules, so it is weak evidence either way.
- **A deny on the whole tool removes it from context.** Documented in general (https://code.claude.com/docs/en/permissions, permissions.md:109): "As a deny rule, both forms remove the tool from Claude's context." Inference: the skill listing is the Skill tool's metadata (env-vars.md:510), so it goes with the tool, and the repository's skills go with it.
- **Documented ways to *hide* a skill:**
  - `skillOverrides` set to "off" or "user-invocable-only" (above).
  - `disable-model-invocation: true` in the skill's frontmatter (skills.md:871). A synced skill's frontmatter comes from claude.ai, and claude.ai uploads accept only six fields, `disable-model-invocation` not among them (skills.md:428, 438). Inference: the owner can't set this field on a synced skill.

## Q4. The account side: how the owner turns synced skills off, and per account or per surface

- **Per skill.** Documented. https://support.claude.com/en/articles/12512180-use-skills-in-claude (read 2026-10-11; the page shows only "Updated over 2 weeks ago"): go to Customize > Skills, then "Toggle individual skills on or off as needed."
  - skills.md:332 says the same for Claude Code: turn the skill off for the claude.ai account where it was enabled, and the next sync removes it from `~/.claude/skills/synced/`.
  - Organization-provisioned skills can be toggled per user (support article).
  - Some of Anthropic's skills "always sync" (skills.md:263). Inference: the toggle can't remove those.
- **All at once.**
  - For an account, no single "all skills off" switch is stated.
  - The support article makes skills depend on Settings > Capabilities > "Code execution and file creation" on individual plans. Inference: turning that off disables skills, and it also changes other chat features.
  - An organization can turn Skills off for everyone (skills.md:265).
  - `syncClaudeAiSkills: false` is per machine and not read in cloud sessions (Q2).
- **Per account or per surface.** A per-surface switch is not stated anywhere. Inference: it is per account, so turning a skill off also removes it from his claude.ai chats and from his other Claude Code and Cowork sessions. The basis:
  - skills.md:231 and the support article tie the Claude Code load to the same account setting.
  - Support article: "Skills you've enabled in your Claude settings also load in Claude Code in your terminal when you sign in with the same Claude account."
  - Support article: "Disabled skills won't be available to Claude."
- **When it takes effect.** In terminal sessions it is checked about every 10 minutes (skills.md:243). In Cowork, skills are "synced at session start" (skills.md:218). For a running cloud or routine session it is not stated.

## Q5. Other documented points that could change the answer

- **The list puts only names and descriptions in context; a body loads when the skill is invoked.** skills.md:1190 covers the listing. Descriptions are sanitized (skills.md:305) and capped at 1,536 characters (skills.md:401).
  - Interpretation: with T4 refusing every Skill call, what reaches the model from the 25 is their listing text, not their bodies.
  - EV-C01-026 counted requests in the full skill texts. Whether the conflicting requests sit in descriptions or in bodies was not separated.
- **In a cloud session, a synced skill's body behaves like a local skill** (skills.md:311), including its `!` shell lines. Inference: this matters only if a call gets past T4.
- **No skill-loading switch is documented in a cloud environment's settings.** The environment dialog holds name, network, environment variables, setup script and network secrets (cloud-environments.md:13, 57). https://code.claude.com/docs/en/claude-code-on-the-web does not mention skills.
- **The sync doesn't delay startup; a skill downloads when it is invoked** (skills.md:246). This is stated for terminal sessions. For cloud sessions, the timing between the list and the download is not stated.
- **The docs match the observed version.** The changelog head is 2.1.296, the version EV-C01-021:18 and EV-C01-026:16 record.

## Counter-evidence and open points
- **The routines page is silent on account skills.** https://code.claude.com/docs/en/routines (routines.md:51) mentions only "skills committed to the cloned repository". skills.md:218 and P4's observation say account skills also reach routine sessions. The observation outweighs the silent page.
- **Plugins: documentation and observation disagree.** plugins/loading.md:99 says synced plugins load in Cowork and terminal sessions, not cloud ones. PC-35 P3 observed them in the working (cloud) session; EV-C01-026:48 saw none in the routine session.
- **Whether `skillOverrides` works on synced skills is the one open documentation question that bears on the decision.** It is untested. Its key form is unknown. It needs one named entry per skill in a public repository: the same naming problem PC-35 option (H) rejected, and `tools/check_service_names.sh` applies. It would not cover skills enabled later, and no wildcard is documented. A routine or fresh session would have to observe it before anyone relies on it.
- **Setup-script-written user settings:** the docs are contradictory or silent (Q2, last rows).
- **Changelog search limits.** I grepped the changelog; I did not read it in full. A search miss shows only that I did not find a "deny hides a skill" entry, not that none exists.
- **Not read:** the library (not consulted; freshness needs current docs); the Desktop app's Customize documentation; the claude.com plugin platform-support page; the managed-settings page in full; GitHub issue 43928 (a feature request for per-skill on/off in `settings.json`, marked closed; I did not read what shipped); the claude.ai settings UI itself.

## For the decision
1. **The documentation names no repository-carried setting that stops synced skills from syncing or loading in cloud or routine sessions.** The direct switch, `syncClaudeAiSkills`, is documented as one "a repository can't turn off".
2. **One repository-level setting is documented to remove named skills from the model's list: `skillOverrides: "off"` in `.claude/settings.json`.** Whether it covers synced skills is not stated, it needs per-name entries, and it would miss skills enabled later. Inference: it is at most a candidate to try and observe, not a documented route.
3. **Permission `deny` rules for skills are documented only to refuse calls.** That adds nothing beyond T4.
4. **The documented account route is the per-skill toggle on claude.ai.** By inference it is per account, so it also changes his claude.ai chats, and some of Anthropic's skills always sync whatever the toggle says.

This report decides nothing.

## Sources
- https://code.claude.com/docs/en/skills.md: 2026-10-11
- https://code.claude.com/docs/en/settings-reference.md: 2026-10-11
- https://code.claude.com/docs/en/settings.md: 2026-10-11
- https://code.claude.com/docs/en/permissions.md: 2026-10-11
- https://code.claude.com/docs/en/env-vars.md: 2026-10-11
- https://code.claude.com/docs/en/cloud-environments.md: 2026-10-11
- https://code.claude.com/docs/en/claude-code-on-the-web.md: 2026-10-11 (no mention of skills)
- https://code.claude.com/docs/en/routines.md: 2026-10-11
- https://code.claude.com/docs/en/plugins/loading.md: 2026-10-11
- https://code.claude.com/docs/en/iam.md: 2026-10-11 (no mention of skills)
- https://code.claude.com/docs/en/server-managed-settings.md: 2026-10-11
- https://code.claude.com/docs/en/self-hosted-environments.md: 2026-10-11
- https://code.claude.com/docs/en/self-hosted-environments-configuration.md: 2026-10-11
- https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md (head 2.1.296): 2026-10-11
- https://support.claude.com/en/articles/12512180-use-skills-in-claude: 2026-10-11 (WebFetch summary, with its quotes checked against the raw HTML)
- Repository, read only: `/home/user/devos/plan/decisions/PC-35.md`, `/home/user/devos/evidence/C01/EV-C01-026_W-C01-46_row13_P4.md`, `/home/user/devos/evidence/C01/EV-C01-023_W-C01-45_keep_out.md`, `/home/user/devos/evidence/C01/EV-C01-021_W-C01-20_row13_plugins_skills.md` (version lines only)
- Scratch copies of the pages: `/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/r39/docs/`

## Guard denials
- #10839, rule G0 (readable call): a Bash grep of mine contained an unbalanced backtick. I repeated the read as a well-formed Grep call. For the executor to record with `tools/guard_report.py`.
