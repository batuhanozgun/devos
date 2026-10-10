*Filed verbatim from the researcher's final report (independent need-level counter-assessment for FR-05, plan 6.12 item 3; told not to read the devos repository beyond Appendix D; fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH, 2026-10-10; taken with tools/subagent_audit.py last; DISCIPLINES OK). The harness marked the report as containing configuration-shaped text; it holds no instruction to the executor.*

**Question.** What is the minimal scope that meets N1–N5 at the required quality, and which mechanism carries each element? This is the counter-assessment for FR-05, written without seeing the current design. Tags: [S] the source states it, [I] my interpretation, [Inf] my inference. I read every source on 2026-10-10. No page showed a last-updated date.

## Disciplines (D1–D9)
D1: yes: I set the frame "enforce inside the session" against "enforce at the external systems (database, GitHub)", and I stated undocumented facts as conditions.
D2: yes: the task leans toward "minimal", so I looked for places where minimal fails the need and report three of them (N1-3, N2 timing, multi-repository sessions).
D3: yes: for each element I checked the whole chain from configured to applied to in effect during unattended routine runs.
D4: yes: the project CLAUDE.md was loaded into my context automatically and mentions a guard on every tool call; I disclose that, judged only from the documentation, and limit my claims to "documented, not verified".
D5: yes: I read the raw page text for the decisive Claude Code statements and mark where I relied only on summaries (GitHub pages, and the hooks page, of which I read only the first ~38%).
D6: no
D7: no
D8: no
D9: uncertain: the task forbids reading the library, so I did not consult it; this answer is new research and should be treated as a candidate.

## N1 Separation of authority
- [S] Each cloud session runs in an isolated VM, and GitHub credentials never enter it.
- [S] An environment holds its own network level, variables, setup script and network secrets. "Anyone who uses the environment can read" its variables.
- [S] **GitHub identity belongs to the claude.ai account, not to the environment.** Routine commits carry "your GitHub user". Also: "a rule that access can bypass doesn't block a run's push".
- [S] Server-managed settings exist only on Team and Enterprise plans. Repository rules and hooks load only in **single-repository** sessions; a session with several repositories reads neither.
- [S] `/schedule` is unavailable inside a cloud session.
- [S] The GitHub proxy serves API requests only for repositories attached to the session. Whether git cloning is limited the same way is not stated.

**Minimal scope:**
1. **Configuration.** Three environments, each holding only its own database token. Each routine is pinned to one environment and one repository. Hygiene rule: never start a DevOS session with several repositories.
2. **Custom code, already in the system.** The database derives the role from the token and refuses cross-role functions; this needs negative tests. Keep exam answers behind exam-role database functions, not in a repository, because GitHub reach is shared by all environments [Inf].
3. **Configuration plus small code.** GitHub approving reviews cannot express "the audit approved" when every environment acts as the same GitHub user [Inf]. So: a ruleset on `main` that requires a pull request, allows no bypass (administrators included), and requires a status check that passes only if the database holds an accepted audit verdict for that head commit. The check's definition and credential must come from the protected branch, not from the change it judges.
4. **Configuration.** The identity sessions act as is a collaborator, never the owner, on every DevOS repository. On personal-account repositories only the owner can change visibility and security settings [S]; editing rules is owner/admin-only [I]. Control files therefore change only through `main`.

## N2 Public stays public; library text stays out
- Visibility is covered by N1 item 4.
- No platform feature recognises private-library text, so K6's code-based pre-check is required (see Q3).
- [Inf] A branch pushed to a public repository is visible as soon as it is pushed. A check that runs only on the pull request finds problems after exposure. The check must also run **before push** inside the session; the pull-request check is the backstop for `main`.

## N3 Secrets
- [S] Network secrets (Pro and Max only) are attached by Anthropic's proxy to requests for hosts you list, and the key "doesn't appear in the session's environment variables or in any file".
- [S] On public repositories, secret scanning runs automatically and free, but for known secret types only. Push protection for users is on by default. Custom patterns are described for organizations.
- [S] A Supabase secret key bypasses row-level security and must never be in source control. The publishable key is safe to expose.

**Minimal scope:**
1. **Configuration, conditional.** Store each environment token as a network secret for the Supabase host. Then the token cannot leak through the session at all, which is stronger and simpler than any scanner. This works only if the database can read the token from a request header; I have not verified that.
2. **Hygiene.** No Supabase secret or service-role key in any environment.
3. **Configuration (N7).** Secret scanning and push protection on.
4. **If the token stays an environment variable:** give it a distinctive prefix and catch it in the Q3 check. GitHub will not recognise a format DevOS invents.

## N4 Connectors and other repositories
- [S] Routines include every connected connector by default, and Claude may use their tools, "including writes, without asking".
- [S] Connector traffic does not pass through the network allowlist.
- [S] A deny rule naming a bare tool or server (`mcp__<server>`) removes those tools. Permission rules are enforced by Claude Code, not by the model.

**Minimal scope:**
- **Configuration:** remove connectors from every routine.
- **Configuration:** bare-name deny rules for connectors in the repository settings (effective in single-repository sessions only).
- **Configuration:** install the Claude GitHub App, and grant the machine account access, only on DevOS repositories.
- **Recommended:** a Custom network allowlist.
- I found no documented way for a session to reach the owner's other sessions; it is not stated either way.

## N5 Written reasons
- [S] A PreToolUse hook can deny with `permissionDecisionReason`, which Claude sees.
- [S] Hook errors and timeouts **do not block** unless `onFailure: "block"` is set.
- [S] Deny rules are applied whatever a hook returns.
- Not stated: whether a plain deny-rule denial carries a written reason.

**Minimal scope:**
- Tools that must never be used are removed by bare-name deny. Then nothing is blocked at runtime, so no reason is owed.
- Every remaining block comes from one small hook. It returns its reason from a committed table (category, reason, what to do instead) and is fail-closed for those categories.
- An "ask" rule cannot serve unattended runs: routines run "without stopping for approval" [S].

## Q1 Relying on documented platform guarantees
Yes, it is reasonable. Relying on the provider's documented isolation is ordinary shared-responsibility practice. Anthropic points to SOC 2 Type 2 and ISO 27001 reports through its Trust Center [S; I did not read the reports]. Testing the provider's isolation is outside DevOS's authority.

DevOS should verify its own side, by reading configuration rather than exercising it:
- which environment each routine uses;
- each environment's variable and secret list;
- which repositories each routine attaches;
- the GitHub rules as configured;
- the database's role refusals (DevOS's own code), with negative controls.

**Claim limitation to record:** "Session and environment isolation is a platform guarantee per the cited pages (read 2026-10-10), not independently verified. Per environment, only variables, secrets and network are separate. GitHub identity and connectors are shared across one account. Variables are readable inside the session. The Anthropic API channel stays open even with network access set to None. Routines are a research preview: re-read the pages when the platform changes."

## Q2 Platform permission model or a custom interceptor
**The platform model meets N4** (tool removal, environment configuration, GitHub configuration) at almost no code cost.

Its documented limits:
- Bash pattern rules "isn't a security boundary".
- Repository rules load only in single-repository sessions.
- Managed settings are "a client-side control, not a security boundary"; repository settings are no stronger [Inf].

**A custom interceptor of every tool call** runs in the same client, so it adds no authority boundary [Inf]. Its costs:
- code and tests to write and maintain;
- it must be configured fail-closed, because the default is fail-open;
- every new platform tool is blocked until listed, which stops unattended runs;
- latency on every call;
- it is itself a control file that needs the audit gate.

Its real value is N5 reasons and preventing accidents.

**Verdict:** platform rules plus a small hook that gives reasons for named categories. A default-deny interceptor justified as enforcement is not needed.

## Q3 Minimal pre-check for N2 and N3
**Minimal, honouring K6** (risk "reduced", not "eliminated"): one script with two tests.
1. The DevOS token format and Supabase secret prefixes.
2. Long word sequences in added text that match the library verbatim, plus library path names.

It runs before push in the session and as a required pull-request check. To avoid giving the public repository's CI a library credential, the audit environment can run the overlap test as part of its binding review, and the merge check reads that verdict.

**Over-built:**
- paraphrase, semantic or model-judged similarity (it would block synthesis, which is allowed);
- runtime scanning of chat or of tool output;
- rebuilding GitHub's secret patterns;
- entropy scans across the whole history.

## Required / optional / over-scope
**Required**
- One environment per role, single-repository routines: the only way repository rules load and tokens stay separate.
- Database role refusals with negative tests: this is where authority really lives.
- Sessions' GitHub identity is not an administrator; ruleset with no bypass, a required audit-verdict check, scanning and push protection: GitHub enforces this, not the agent.
- Connectors removed per routine and denied by name: otherwise writes go through without asking.
- The pre-push and pull-request check: this is K6's "code-based pre-check".
- The reason-giving hook for named categories: N5.
- The recorded claim limitation: N6.

**Optional**
- Network-secret token: strongest for N3, but depends on the header condition.
- Custom network allowlist: narrows reach cheaply.
- Database rejecting token-shaped text in records: cheap extra layer.
- ConfigChange logging.

**Likely over-scope**
- An every-call default-deny interceptor presented as enforcement: it is client-side.
- Actively testing platform isolation: outside DevOS's authority and of little value.
- Semantic or LLM-judged library gate: it would block permitted synthesis.
- Duplicating GitHub's secret scanning.

## Second-order effects (12–24 months)
- Fewer custom parts mean less upkeep and fewer false blocks halting unattended runs.
- More of the control state lives in web interfaces (environments, routines, GitHub settings) outside git. Configuration drift becomes invisible unless a periodic read-only inventory is recorded.
- Platform drift: routines are a research preview, and network secrets are Max/Pro-only, so a plan change would undo N3 item 1. The documentation-based claims go stale and need to be re-read.
- The single account couples identities. If separation later needs distinct GitHub identities, the fix is account structure, not code.
- A deny list by category stays stable; an allow list would grow with every new platform tool.

## Open
- Whether the database can read the token from a header.
- Whether git cloning of unattached repositories is limited.
- Whether a deny-rule denial carries a reason.
- Whether mid-session edits to `.claude/settings.json` apply.
- The ruleset availability line for Free personal public repositories: my fetch tool did not capture it.
- I read only about 38% of the hooks page.

Guard denials: none.

## Sources (all read 2026-10-10)
- https://code.claude.com/docs/en/claude-code-on-the-web
- https://code.claude.com/docs/en/cloud-environments
- https://code.claude.com/docs/en/routines
- https://code.claude.com/docs/en/permissions
- https://code.claude.com/docs/en/permission-modes
- https://code.claude.com/docs/en/hooks (partial)
- https://code.claude.com/docs/en/settings
- https://code.claude.com/docs/en/server-managed-settings
- https://code.claude.com/docs/en/security
- https://docs.github.com/en/code-security/secret-scanning/introduction/about-push-protection
- https://docs.github.com/en/code-security/secret-scanning/introduction/about-secret-scanning
- https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets
- https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets
- https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/creating-rulesets-for-a-repository
- https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches
- https://docs.github.com/en/account-and-profile/reference/permission-levels-for-a-personal-account-repository
- https://supabase.com/docs/guides/api/api-keys
- Local file: /home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md (sections 2.3 and 3)
