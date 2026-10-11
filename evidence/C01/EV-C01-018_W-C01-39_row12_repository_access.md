# EV-C01-018 · W-C01-39: row 12, the repository access limit and the git credential, from the documentation (PC-21 item 6)

**What this is.** The record W-C01-39 asks for. Under PC-21 item 6 (plan line 969), row 12 is established from the documentation where it states the facts, with its reading date. A fact it does not state is recorded as not stated, and row 12's fail path is taken as the design. Three facts are read: which identity a session acts as on GitHub; which repositories a session's GitHub access serves; who can change a personal-account repository's rules. No trial was made on the platform. Nothing was attempted on `devos-evals`, `devos-backup`, the library or Batu's other repositories, and no session, routine, trigger or GitHub tool was called (FR-05 A; D-017). Section 1(d) records four readings of DevOS's own records and configuration. They are not documentation, and the result does not rest on them; they are inputs to the carried work (N-133, N-175).

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `f957519e4afc5fc11241f7ea1b7b2dd350503527` (PR #221). Plan blob `eb1ffa59fbde91808da635b2a4739549eac90614` (last changed in `4ce4fd9`). The remote `main` moved on to `204211f` while this record was written; those commits change none of the files cited or changed here |
| Deployment configuration | A documentation reading, made from the working session `session_01XyxvJd3RayQk4HCrjurbVH` (cloud, environment `devos-kurulum`) by a producer subagent. Claude Code version: not read here (no `get_session`); the working session's last recorded value is 2.1.296 (EV-C01-004:29; L-202). The readings are tied to their date, 2026-10-11, not to a version. Section 1(d)'s readings went through this session's GitHub proxy |
| Criterion version | W-C01-39's acceptance block, blob `dca5ff438d57fd0bbc965a41997435d43bc3d97f`, as merged with the C01 re-plan (W-C01-31, `44cef4e`), unchanged since. Read with plan C01 row 12 (line 955) and the PC-21 note, items 6 and 9 (lines 969, 972) |
| Input | Claude Code documentation, raw pages at `https://code.claude.com/docs/en/<page>.md`: `routines`, `cloud-environments`, `claude-code-on-the-web`, `security`, `web-quickstart`, `self-hosted-environments-deploy`, `self-hosted-environments-configuration`, `github-actions`. GitHub documentation, through `https://docs.github.com/api/article/body?pathname=…`: "Permission levels for a personal account repository", "About protected branches", "Managing a branch protection rule", "About rulesets", "Creating rulesets for a repository", "REST API endpoints for protected branches", "REST API endpoints for rules", "Authenticating with a GitHub App on behalf of a user". All read 2026-10-11 between 13:02Z and 13:12Z. No page showed a last-updated date |
| Actual observation | Sections 1 to 3: what each page states and does not state, quoted by page and section; section 1(d): four readings of DevOS's own records and configuration |
| Raw evidence ID | The pages themselves (public, undated); the quoted passages here are the record. Section 1(d): `git log` of `origin/main` at `f957519`; GitHub's public event record of `batuhanozgun/devos` (`/repos/batuhanozgun/devos/events`, read 13:05:38Z); `/repos/batuhanozgun/devos/branches/main`, `/rulesets`, `/rulesets/24194116` and `/rules/branches/main` (read 13:08Z) |
| Independence level | Same session, fresh-context subagent (declared, Ek A 5.3): documentation read directly at its source. Section 1(d) items 3 and 4 are this session observing itself (D-017 item 2(a)); items 1 and 2 are git's and GitHub's own records. Judged by a fresh-context checker (declared, Ek A 5.3) |

## How the block is read

PC-21's note governs where it and the row differ (plan line 963). The block's point 1 asks for the three facts with their reading date. Point 2 asks, for each fact not stated, that row 12's fail path be recorded as the design "as PC-21 item 6 gives it", in four clauses. Point 3 asks for each served note's disposition. "Stated" below means a page says it. A conclusion that needs two stated facts joined, or a fact about Batu's account, is marked as an inference [I] or a configuration fact, and is not counted as stated (PC-21 item 6: "a fact it does not state is recorded as not stated").

Abbreviations: C1 to C9 are the Claude Code pages and G1 to G6 the GitHub pages, as listed under "Facts taken from the documentation" below.

## 1. The documentation (point 1)

### 1(a) Which identity a session acts as on GitHub

Stated:
- A routine's GitHub actions carry the connected GitHub user: "Anything a routine does through your connected GitHub identity or connectors appears as you: commits and pull requests carry your GitHub user" (C1, "Create a routine"). DevOS's own records conflict with this for commits (CHK-C01-063 C1). Pushes and pull requests act as the connected user, `batuhanozgun-devos` (1(d) items 1 and 2). But the commits a session makes itself carry its local git identity, `Claude <noreply@anthropic.com>`, as author and committer: 363 non-merge commits at `f957519` (1(d) item 1), the working session's among them, and every commit on the routine's run branches (R1a, R1b, P1 and P2). That is row 11's matter (N-029; W-C01-18). Recorded 2026-10-11: from 13:56Z the executor's own non-merge commits carry the machine account as git author, with the platform's identity as committer (first such commit `c6f1204`); its local merge commits keep `Claude <noreply@anthropic.com>` as both, and one test commit on W-C01-18's branch, `d787325`, carries the machine account as both (N-156; W-C01-18, in progress).
- The credential stays outside the session: "your GitHub credentials stay encrypted on Anthropic's servers and never enter a session's VM" (C4, "GitHub authentication options"); "The VM holds a short-lived credential scoped to that session" (C5, "Cloud execution security").
- Git and the GitHub tools act with the connected user's token: "the git client inside the VM uses a scoped credential, which the proxy verifies and swaps for your actual GitHub token"; API requests "go out with your real credentials substituted" (C3, "GitHub proxy").
- One connection per Claude account, made one of two ways: authorizing the Claude GitHub App in the browser, or `/web-setup`, which sends the local `gh` token (C4; C6, "Connect GitHub", "Connect from your terminal"). "Disconnecting deletes the GitHub credentials your cloud sessions use, whether they came from the browser or from `/web-setup`" (C6).
- For the same proxy on self-hosted runners (C3 calls it "this same proxy"): "User sessions: Anthropic uses the GitHub OAuth token stored for the session's creator." "Bot and agent sessions: Anthropic uses your organization's GitHub App installation token." (C7, "How Anthropic serves git for a session").
- GitHub: requests an app makes on behalf of a user "will be attributed to that user" (G5).

Not stated:
- Which GitHub account is connected to Batu's Claude account, and by which method. That is account configuration. Plan 0.5 (B3 (a)) names the machine account `batuhanozgun-devos` as the system's GitHub identity; section 1(d) items 1 and 2 show it acting.
- Which token the proxy holds for DevOS's sessions: the Claude GitHub App's token on the user's behalf, or a `gh` token. Nor whether a routine's session counts as a user session or as a "bot and agent" session in C7's sense, which would use an App installation token. C7 is written for self-hosted runners; that it holds for Anthropic-hosted sessions rests on C3's "this same proxy" [I].

### 1(b) Which repositories a session's GitHub access serves

Stated:
- API requests: "the proxy serves GitHub API requests for the repositories attached to the session. An API request for another repository gets a 403" (C3, "GitHub proxy").
- A session can attach repositories itself: the platform's session-tools server's tools "schedule routines, start and steer other cloud sessions, attach more repositories, and follow pull request activity" (C8, "Turn off built-in session tools"). Plan 7.3 records the same from L-002 (1 October 2026).
- What the connection can reach: with the browser connection, "Any public repository, and private repositories that the Claude GitHub App is installed on"; with `/web-setup`, "Any repository your `gh` token can access, whether or not the Claude GitHub App is installed" (C4). "a private repository appears only when the Claude GitHub App is installed on the account or organization that owns it and the installation's repository access includes it" (C6, "No repositories appear after connecting GitHub").
- A user's token is bounded by the user: "The app can only access resources that the user has access to"; "The app can only access resources that it has permission to access"; "The app can only access resources in an account where it is installed"; "A token cannot grant additional access capabilities to a user" (G5).
- For the same proxy on self-hosted runners: "Anthropic supplies git credentials for the repositories that are part of the session, not for other repositories on the same git host" (C7, "Use the Anthropic git proxy").

Not stated:
- For Anthropic-hosted sessions, whether git (clone, fetch, push) is limited to the attached repositories as API requests are. C7 states it for the same proxy on self-hosted runners only; carrying it over is an inference [I]. Either way, a session can attach more repositories (C8), so "the session's repositories" is not a fixed boundary.
- Whether, for DevOS's sessions, git access stops at the repositories the machine account can access (`devos-backup` is one where it is not a collaborator, plan 6.7). It would if every git operation used the machine account's user token (G5) [I]; that no other credential serves any git operation is not stated (1(a)).

### 1(c) Who can change a personal-account repository's rules

Stated:
- "A repository owned by a personal account has two permission levels: the repository owner and collaborators." The owner "has full control of the repository". "Collaborators on a personal repository can pull (read) the contents of the repository and push (write) changes to the repository." (G1). Neither of G1's two lists names branch protection rules or rulesets; the owner's list names "Merge a pull request on a protected branch, even if there are no approving reviews".
- "Protecting a branch requires admin or owner permissions to the repository"; "Updating required status checks requires admin or owner permissions to the repository and branch protection to be enabled" (G2, "Update branch protection", "Update status check protection").
- Bypass: "Actors may only be added to bypass lists when the repository belongs to an organization" (G3, branch protection rules). For a ruleset, the roles eligible for its bypass list include "Repository admins", "The maintain or write role" and "GitHub Apps" (G4, "Granting bypass permissions for your branch or tag ruleset"). "a rule that access can bypass doesn't block a run's push" (C2, "Repositories and branch permissions"; also C5).
- The Claude GitHub App's permission set includes "Administration | Read", "Contents | Read and write" and "Workflows | Read and write"; "When the app requests a permission it didn't have before, GitHub prompts the account owner to approve it … and the installation keeps its old permissions until they do" (C9, "GitHub App permissions").

Not stated:
- As one fact, that a collaborator (the machine account) cannot change the rule of `main`. It follows from G1 and G2 joined [I] for branch protection rules. For rulesets, who can create or edit one is not stated in the text read (G4 and the "About rulesets" page name who may view and who may bypass, not who may edit).
- That the Claude GitHub App cannot change it. It follows from C9 ("Administration | Read") joined with G2 [I].
- Whether either is on the bypass list of the rule that protects `main`. That is configuration; the write role and GitHub Apps are eligible (G4).

So who can change, or bypass, the rule of `main` is not settled by the documentation. Section 1(d) item 4 points to "neither", for one credential at one time.

### 1(d) Readings of DevOS's own records and configuration (not documentation)

These are inputs to the carried work, not the basis of the result.

1. **Git history** (`git log origin/main` at `f957519`, read 2026-10-11). 209 merge commits are authored by `batuhanozgun-devos` and committed by `GitHub <noreply@github.com>`: pull requests merged through the GitHub API act as the machine account. The session's own commits carry its local git identity, `Claude <noreply@anthropic.com>` (363); that is row 11's matter (N-029; W-C01-18).
2. **GitHub's event record of `devos`** (the 100 newest public events, 2026-10-11T06:03:56Z to 12:53:25Z, read 13:05:38Z). All 29 push events have the actor `batuhanozgun-devos`. Eighteen are pushes to `claude/` branches, among them the routine's two run branches, `claude/probe-c01-r1a-20261011T0808Z` and `claude/probe-c01-r1b-20261011T0913Z`; eleven are to `main`. All 37 pull-request events have the same actor. The only other actor is `batuhanozgun` (one issue comment). So the git proxy's pushes, from the working session and from the routine's sessions, were authenticated as the user `batuhanozgun-devos`. A push made with an App installation token would show the App's bot as the actor [I]. Clones and fetches leave no event, so they are not covered.
3. **The proxy's answers to two paths outside `devos`** (13:04Z, this session). `https://api.github.com/apps/claude`: 403, "This GitHub API path is not available: sessions are bound to their configured repositories. Use repository-scoped endpoints (repos/{owner}/{repo}/...)." `https://github.com/apps/claude`: 403, "GitHub access to this repository is not enabled for this session. Use add_repo to request access. If add_repo answers that read access is already available and you need GitHub API or write access, call add_repo again with access:"push" to attach the repository with credentials." So the proxy also stands in front of `github.com` web paths, and it tells a session to attach a repository itself. Whether a git clone of an unattached repository is refused the same way was not tried.
4. **The rule on `main`** (13:08Z). `/branches/main` shows `protected: true` with classic protection not enabled. One ruleset applies: `main-korumasi` (id 24194116), active, created 2026-09-29 and last updated 2026-10-01, on the default branch and `refs/heads/main`, with the rules `deletion`, `non_fast_forward` and `pull_request` (0 approvals; merge methods merge, squash and rebase). The response gave `current_user_can_bypass: never` and no `bypass_actors`. These were plain GET requests with no token of the producer's; the response headers (`X-Ratelimit-Limit: 15000`, where an unauthenticated limit is 60 [I]) show that the GitHub proxy attached the session's credential. GitHub's reference says "the bypass_actors property is only returned if the user making the API request has write access to the ruleset" (G6). So the credential the proxy attached to this session's API requests could not bypass the ruleset and had no write access to it. Limits: one self-observation (D-017 item 2(a)); the authentication is inferred from a header; it covers that credential, in this session, at that time, not the machine account's role as such, the App installation's granted permissions, or other kinds of session.

## 2. The fail path as the design (point 2)

Row 12's success condition, part by part:

| Part (plan line 955) | Documentation | Result | Design clause |
|---|---|---|---|
| Working and audit sessions cannot read or attach `devos-evals` by any route (git, the GitHub tools, attaching it) | API scope stated; attaching is a documented session tool (C8); the machine account is a collaborator on `devos-evals` (plan 0.5); git scope not stated for these sessions (1(b)) | not stated; could not check (no trial, FR-05) | (a) |
| Whether a session can reach a repository of Batu's other projects | Not stated (1(b)) | not stated; could not check | (c) |
| Which credential the git proxy uses, the machine account or the Claude GitHub App | "your actual GitHub token" (C3); C7 names two kinds for the same proxy; which serves DevOS's sessions is not stated (1(a)) | not stated; 1(d) item 2 points to the machine account's user token for pushes | (b) |
| For example, whether it reaches `devos-backup`, where the machine account is not a collaborator | Not stated (1(b)) | not stated; could not check | (b), and plan Section 13 (PC-32 place 9; N-176) |
| What permission each of them has on `devos` | The machine account: collaborator, so read and write (plan 0.5, "Write access: `devos`"; G1). The App: its documented permission set (C9) | met at the documentation level | — |
| Whether either can change the rule that protects `main` | Not stated as such (1(c)) | not stated; 1(d) item 4 points to "neither" | (d) |

Each "could not check" is handled by the fail path below, never as met (plan Section 8 item 14). The design clauses, as PC-21 item 6 gives them:

- **(a) Exam answers behind the exam role in the database** (7.3; N-134). Plan 7.3's sentence that turned on C01 #12 now records that #12 did not show it, so `devos-evals` holds no answer key (PC-32 place 8). The build is C05's: N-138 on `plan/work/C05.md` (nothing exam-secret in any repository, `devos-evals` included), deadline C05's start, before task 4 builds the exam setup. That meets the row's deadline, "before C05's exam setup". The rest of 7.3's exam text, the 6.3 exam row, Appendix B 271 and Appendix C N08's `devos-evals` part change with N-138's plan change (EV-C01-004 section 8 item 3).
- **(b) The library's closing step before C04's ingestion, and the organization route offered to Batu if needed** (N-133). The documentation does not show that removing the machine account closes the sessions' git path: C3 says "your actual GitHub token", and C7 names an App installation token for bot and agent sessions, while the Claude GitHub App is installed on all of Batu's repositories (plan 6.7). Plan 6.7's library row now says so (PC-32 place 6). N-133 gets this record's inputs by a dated line (section 3).
- **(c) Batu's other repositories treated as reachable, with the guard as their only layer**, recorded in 6.7 (PC-32 place 7) and tested in C03 test 3. The record of the layer is limited: the installation guard denies attaching them (rule S5), GitHub-tool writes to them (M2) and pushes to them (B3), but no rule denies a `git clone` or `git fetch` of them by URL. `library_git_checks` limits only the library's clone (rule L3), and `tools/test_tool_allowlist.sh` has no case that clones another GitHub repository (it allows a clone of `devos`, line 269). Test 3 requires that "a DevOS session cannot read or write a repository of Batu's other projects" (plan line 1008). N-177 on `plan/work/C03.md` carries it. The same holds for `devos-evals`, `devos-backup` and `soul-system` (PC-32 place 5).
- **(d) The rule of `main` not counted as a layer against sessions until it is settled who can change it, and the account step before C03 test 5 to Batu if needed.** Plan 6.7 now says so once, above its table, and points to it from the `devos` row (PC-32 places 1 to 4). The documentation names a qualifier the row did not: "a rule that access can bypass doesn't block a run's push" (C2). So the condition reads "change or bypass". N-175 on `plan/work/C03.md` settles it before test 5 from the repository's configuration, read without changing it. If either can, removing the permission goes to Batu then; it is not a C01 step. The conditional line in "Batu's steps" in `plan/work/C01.md` (the last row) is therefore not asked in C01.

## 3. The notes (point 3)

| Note | Disposition | Reason and place |
|---|---|---|
| N-028 (does the session enforce read access to the library?) | carried with a named place; closed on `C01.md` | Re-assessed with this reading: whether git, or an attachment made with `access: "read"`, is held to reading is not stated (1(b); 1(d) item 3 shows only the platform's wording about "read" and "push" attachments). Its position stands: the library is treated as writable; the guard denies pushes and GitHub writes to it; D-014's e-mails report a push. No write test (plan 0.5). The closing step goes to C04: N-133(2) |
| N-030 (which credential the git proxy uses) | carried with a named place; closed on `C01.md` | Not stated (1(a)); 1(d) item 2 shows pushes authenticated as `batuhanozgun-devos`. Row 12's fail path is the design: N-133(2) redesigns the closing step before C04's ingestion (PC-32 place 6) |
| N-073 T-09 | met | Its rule's branch applies: a session can attach repositories itself (C8; L-002), so the answer keys go to the Supabase schema only the exam token reads (7.3 as PC-32 changes it; N-134(3); N-138), not to a second GitHub identity. Its library part is N-133(2). A second identity is not needed: the database route stands |
| N-073 T-02, `devos-evals` | not applicable | The tie "`devos-evals` is tied only to the exam routine" does not hold at the GitHub level (section 2, first row). But under N-138 nothing exam-secret goes into it and no routine attaches it, so its history needs no protection against sessions for exam isolation, and no GitHub Pro cost arises. If C05 keeps anything there whose history must hold against sessions, T-02's rule applies there (dated line on N-138) |
| N-073 T-02, `devos-backup` | carried with a named place | Not shown either way (1(b)). Plan 5.7 item 1 backs up "review and exam records", and Section 13 now treats `devos-backup` as reachable (PC-32 place 9). C09's backup design keeps exam material out of reach and does not rely on the history being out of reach, or the Pro cost goes to Batu: N-176 on `plan/work/C09.md` |
| N-063 P3 (row 12's part) | met at the documentation level, for W-C01-27 | The GitHub connection is one per Claude account and shared by every environment (C1; C6), so no GitHub-level separation between environments is counted. The separations rest on the database (N-131, N-136 on `plan/work/C02.md`); exam answers are in the database (N-138). Row 3's part: EV-C01-002 |
| N-063 U1 (row 12's part) | met at the documentation level, for W-C01-27 | The GitHub credential never enters a session (C4; C5), so no session reads it; but it is the same for every environment. Row 3's part: N-131 |
| N-063 U6 (row 12's part) | recorded, for W-C01-27 | "Unattached repositories unreachable": stated for API requests (C3), not for git; and a session can attach more (C8). So they are treated as reachable (PC-32 places 5 and 7). Branches, pull requests and auto-merge are W-C01-15's |
| N-063 Q1 (row 12's part, as EV-C01-002 section 4 assigns it here) | not applicable | Row 12 needs no fallback beyond its own fail path; no second GitHub identity (7.3) |
| N-133 (2) | input recorded; stays open on C04 | Dated line: what the documentation does and does not show, the push observation, and the options the redesign weighs |
| N-134 (3) | met in the plan text | 7.3's answer-key sentence records it (PC-32 place 8); C05 builds it (N-138). N-134 stays open for its items (1) and (2) |

N-063 stays open for W-C01-27, and N-073 for T-13 (W-C01-20). Each served note on `plan/work/C01.md` has a dated line.

## 4. Plan text: where 6.7, 7.3 and Section 13 change

`plan/decisions/PC-32.md` applies the design to the plan text the fail path names. Places 1 to 7 are plan 6.7: the paragraph above the effect channel inventory, and the rows `devos`; `devos-evals`, `devos-backup`, `soul-system`; the library; Batu's other repositories. Place 8 is 7.3, the answer-key sentence. Place 9 is Section 13, the risk row on the private repositories. They dispose of the C01 marks that the table "Plan marks and labels that name C01" in `plan/work/C01.md` gives to row 12: plan 724 (two marks), 725 and 1237 (now line 1252), and the reference to C01 #12 in 7.3. Appendix C N08's C01 part is answered by clause (a); its text changes with N-138. K-9's status mark (plan line 435) names row 12 among other rows; this record is row 12's part of it, and the stage close judges the mark (W-C01-30 point 5). No acceptance condition changes, and no text labelled as Batu's decision changes.

## Facts taken from the documentation (PC-21 item 9)

Each is: guaranteed by platform (documented in the page named, read 2026-10-11); not independently tested.
- C1, routines, "Create a routine": a routine's commits and pull requests "carry your GitHub user". For commits this conflicts with DevOS's records: the commits a session makes itself carry its local git identity, `Claude <noreply@anthropic.com>`, as author and committer, in the routine's runs and in the working session until 2026-10-11T13:56Z; from then the executor's own non-merge commits carry the machine account as git author, with the platform's identity as committer apart from one test commit (section 1(a); row 11; N-029; N-156; W-C01-18, in progress).
- C2, routines, "Repositories and branch permissions": GitHub applies branch protection rules and rulesets "to the GitHub access you connected, so a rule that access can bypass doesn't block a run's push".
- C3, cloud-environments, "GitHub proxy": the git credential is swapped "for your actual GitHub token"; API requests are served only for attached repositories; the proxy rejects branch deletions and non-branch pushes and "doesn't limit which branches a push can update"; self-hosted sessions can opt in to "this same proxy".
- C4, claude-code-on-the-web, "GitHub authentication options": the two connection methods and what each reaches; credentials "never enter a session's VM".
- C5, security, "Cloud execution security": a short-lived credential scoped to the session; a rule the connected access can bypass does not block a session's push.
- C6, web-quickstart, "Connect GitHub", "Connect from your terminal", "No repositories appear after connecting GitHub": one connection per account; private repositories only where the App is installed and its repository access includes them (browser connection).
- C7, self-hosted-environments-deploy, "Use the Anthropic git proxy", "How Anthropic serves git for a session": git credentials only for the session's repositories; the creator's GitHub OAuth token for user sessions; an App installation token for bot and agent sessions. Stated for self-hosted runners.
- C8, self-hosted-environments-configuration, "Turn off built-in session tools": the session-tools server can "attach more repositories".
- C9, github-actions, "GitHub App permissions": the Claude GitHub App's permission set (Administration: Read); a new permission needs the owner's approval.
- G1, "Permission levels for a personal account repository": one owner with full control; collaborators read and write.
- G2, "REST API endpoints for protected branches": protecting a branch, and updating required status checks, need "admin or owner permissions".
- G3, "About protected branches": bypass lists for branch protection only in organizations; admins bypass by default.
- G4, "Creating rulesets for a repository": who is eligible for a ruleset's bypass list.
- G5, "Authenticating with a GitHub App on behalf of a user": a user token is bounded by the user's access, the app's permissions and its installation.
- G6, "REST API endpoints for rules", "Get a repository ruleset": `bypass_actors` is returned only to a user with write access to the ruleset.
- Qualifiers:
  - Per environment, only the variables, secrets and network setting are separate.
  - The GitHub identity and the account's connectors are shared across the account.
  - An environment's variables are readable inside its own sessions.
  - The channel to the model's own service stays open whatever the network setting.
  - Routines are a research preview, so these readings are repeated when the platform changes (plan 0.3 item 12).
  - No page showed a last-updated date. C7 and C8 are written for self-hosted environments; their use here for Anthropic-hosted sessions is marked [I].

## What this record cannot show

- No platform behaviour of row 12 was observed, apart from section 1(d). No reach of `devos-evals`, `devos-backup`, the library or Batu's other repositories was tried (FR-05 A).
- Which connection method Batu's account uses is not visible to a session; `plan/key_inventory.md` row 10 still reads "which one the git proxy uses is not known (N-030; C01 #12)".
- 1(d) item 2 covers pushes in one 7-hour window; clones and fetches leave no event. 1(d) item 4 rests on a header to show that the read was authenticated.
- The GitHub pages were read through GitHub's article endpoint, which drops some boxes (for example the permission lists of REST endpoints); a statement found missing there may be on the rendered page.
- The producer's plain GET requests in 1(d) went out with the session's credential, which the proxy attached without being asked. Every one was a read of `devos`'s public data.

## Result

Row 12's success condition is not met as written. One part is met at the documentation level (each one's permission on `devos`). The other five are not stated by the documentation, and under FR-05 they could not be checked. As PC-21 item 6 gives it, the fail path is the design for each of them: clause (a) through 7.3 and N-138 (C05), clause (b) through N-133 (C04), clause (c) through 6.7, C03 test 3 and N-177, and clause (d) through 6.7 and N-175 (C03), with Section 13's risk row and N-176 (C09) for `devos-backup`. PC-32 records the design in the plan text. C01's condition "For every failed row, a plan change decision has been taken" is met for row 12 by PC-21 item 6 and PC-32, once PC-32 is accepted.
