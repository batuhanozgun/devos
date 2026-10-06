# EV-C00-022 · C00 closure, conditions 1 and 2 of CHK-C00-067: the session's credential variables and the library's commit identities

**What this is.** The evidence for conditions 1 and 2 of CHK-C00-067, the closure verdict of W-C00-11 (`evidence/C00/checks/CHK-C00-067.md`). They bear on C00's two ✘ acceptance conditions (`plan/work/C00.md`): the fifth, "The builder wrote nothing to the library repositories", and the sixth, "No secret is visible in a repository, an environment variable or the chat". Labels, counts, lengths, dates and commit IDs only: no variable's value, no library text, no e-mail address, and no identifier of Batu's other work. A fresh checker judges both against the conditions (CHK-C00-067 condition 5).

## 1. Condition 1: `GH_TOKEN` and `GITHUB_TOKEN` (note N-027)

**Routes.** CHK-C00-067 condition 1 names two: the platform's dated official documentation, or a probe made through a checked change that reports only set or unset, length and token-prefix class. The documentation was read first; it could not decide the case for this session, so the probe was made.

**(a) The documentation** (a researcher subagent, agent `acda86100f374dab8`, 2026-10-06 about 09:45Z to 09:50Z; it read Anthropic's and GitHub's public documentation and no variable. Its report is not filed: its lines of source addresses match the library's fingerprints, which hold the same addresses, so the guard's leak check (L1) would stop the push; it stays in the session's transcript, taken verbatim with `tools/subagent_audit.py last`, and this section states what it found). The Claude Code documentation (code.claude.com, the page on cloud environments, its section on GitHub; no date shown; read 2026-10-06) describes two cases for Anthropic-hosted sessions. When the environment's owner set neither variable, both read as the placeholder string `proxy-injected`, and the GitHub proxy attaches the real credential on outbound GitHub requests: "a script that reads `GITHUB_TOKEN` directly gets the placeholder, not a usable token". When the owner set one, it reaches the session unchanged. The pages on security and on Claude Code on the web say that GitHub credentials never enter the session's VM, which holds a short-lived credential scoped to the session; Anthropic's dated engineering post on sandboxing (20 October 2025) says the same of the sandbox without naming the variables. The documentation's only way to tell the two cases apart is to print the value. Level: stated in undated official documentation, for the design; not shown for this session.

**(b) The probe.** `tools/credential_class.py` (PR #184, merged at `a29d1d568869c885fc241580f62c5479fb30babd`), judged before it ran by CHK-C00-068 (PASS-WITH-CONDITIONS). Its condition 1, met: after the merge and `tools/sync_worktree.sh`, in `/home/user/devos` at HEAD `a29d1d568869c885fc241580f62c5479fb30babd`, `git rev-parse HEAD:tools/credential_class.py` printed `2b1484450ff853ad6cb58f6596ae786899f99a53` (the reviewed blob) and `git status --porcelain` printed nothing; then `python3 -I tools/credential_class.py` ran from there at 10:05Z (guard record #6692), exit 0. It ran a second time at 10:06Z (#6698), piped into a comparison with the saved copy; the output was identical. The output, verbatim (also `evidence/C00/closure/C1_probe_output.txt`):

```
The guard's credential variables:
  GH_TOKEN: set, length 14, class: the documented placeholder
  GITHUB_TOKEN: set, length 14, class: the documented placeholder
  CLOUDSDK_AUTH_ACCESS_TOKEN: set, length 14, class: the documented placeholder
  CLAUDE_CODE_MESSAGING_TOKEN: set, length 32, class: other
  CLAUDE_CODE_MESSAGING_SOCKET: set, length 22, class: an absolute path
  CLAUDE_SESSION_INGRESS_TOKEN_FILE: set, length 50, class: an absolute path
  SESSION_INGRESS_URL: set, length 25, class: a URL
  ANTHROPIC_API_KEY: unset
  ANTHROPIC_AUTH_TOKEN: unset
  CLAUDE_CODE_OAUTH_TOKEN: unset
Other variables whose name looks like a credential's:
  AWS_ACCESS_KEY_ID: set, length 14, class: the documented placeholder
  AWS_SECRET_ACCESS_KEY: set, length 14, class: the documented placeholder
  MAX_THINKING_TOKENS: set, length 5, class: other
GH_TOKEN and GITHUB_TOKEN equal: yes
```

**Reading**, by CHK-C00-068 condition 2's rule (a variable holds no usable secret only if it reads "unset", "set, empty" or "set, length 14, class: the documented placeholder"; any other class counts as "cannot be shown"):
- **`GH_TOKEN` and `GITHUB_TOKEN`: no usable secret.** Each is "set, length 14, class: the documented placeholder", and they are equal. Level: observed in this session's container by a checked probe that compares each value with the documented placeholder exactly; what the placeholder is (not a usable token; the proxy attaches the credential outside the session) rests on the undated documentation in (a). Scope: this session, at the time of the run. The documented second case (a token set in the environment's settings reaches its sessions unchanged) stays possible for a later environment or setting; the key inventory carries the two variables as its first entries with this result (N-105 on `plan/work/C01.md`).
- `CLOUDSDK_AUTH_ACCESS_TOKEN`, `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` hold the same placeholder.
- **The platform's own session credentials.** `CLAUDE_CODE_MESSAGING_TOKEN` is set, 32 characters, class "other": under the rule it is not shown to be free of a usable secret, so it is taken as a usable credential of the session's platform channel. `CLAUDE_SESSION_INGRESS_TOKEN_FILE` holds a path, to what the guard treats as the session's token file (B8); `CLAUDE_CODE_MESSAGING_SOCKET` holds a path and `SESSION_INGRESS_URL` a URL. The guard denies every plain read of all of them (B8, `CREDENTIAL_VARS`), and the probe showed no value. CHK-C00-067 finding 7 left open whether platform-issued session credentials fall under C00's sixth condition ("No secret is visible in a repository, an environment variable or the chat"); these facts bear on that reading, and the fresh checker judges it. The executor does not choose it.
- `ANTHROPIC_API_KEY`, `ANTHROPIC_AUTH_TOKEN` and `CLAUDE_CODE_OAUTH_TOKEN` are unset.
- `MAX_THINKING_TOKENS` (5 characters, "other") is listed only because its name matches the heuristic; by its name it is a setting, not a credential (an assumption).
- The second list comes from a name heuristic. It is not evidence that the environment holds no other secret (CHK-C00-068 condition 2).

## 2. Condition 2: the library's full history by commit identity

**How it ran** (2026-10-06, about 09:50Z, the executor):
- `git -C /home/user/agentic-os-search fetch --unshallow origin '+refs/heads/*:refs/remotes/origin/*'`: a read. The clone is no longer shallow (`rev-parse --is-shallow-repository`: `false`); it now holds 15 remote branches and no tags. Its HEAD is unchanged at `941f027d3a15497b90e60d752303c0463a9feab5`, so the leak check's store, built from that HEAD, is still current (working order section 10).
- `git log --all` (every commit any ref reaches) was read by a scratchpad script that prints counts and class labels only. Classes, from each commit's author and committer name and e-mail: the machine account (name `batuhanozgun-devos`, or its no-reply address); the session identity (name `Claude` with `noreply@anthropic.com`); Batu's account (name `batuhanozgun`, or its no-reply address); GitHub's web-flow committer; other. Also counted: an Anthropic no-reply address under another name, the name `Claude` with another address, and messages carrying a Claude Code trailer (`Co-Authored-By: Claude`, `Claude-Session:`).

**Result.**

| Measure | Count |
|---|---|
| Commits on all refs | 4,454 (committer dates 2026-08-29 to 2026-10-03) |
| Authored by Batu's account / the session identity | 4,392 / 62 |
| Committed by Batu's account / the session identity / GitHub's web-flow | 4,357 / 62 / 35 |
| Any other identity | 0 |
| **The machine account `batuhanozgun-devos` as author or committer** | **0** |
| **The session identity `Claude <noreply@anthropic.com>` as author or committer** | **62** |
| An Anthropic no-reply address under another name; the name `Claude` with another address | 0; 0 |
| Messages with a Claude Code trailer | 62 (the same commits) |

**So condition 2's test, as written, finds commits with the session identity: 62.** Condition 2 says: "If any such commit exists, condition 5 is not met." Under its own words, condition 5 is not met on CHK-C00-067. The executor does not reinterpret that. The facts below bear on whose commits they are; the fresh checker judges C00's fifth condition with them, and whether using them is a loosening after the result was seen (Appendix G, G8 item 3).

**Facts on the 62** (counts and dates only):
- Committer dates: 2026-09-27, from 08:29Z to 16:01Z.
- All 62 name one and the same Claude Code session in their `Claude-Session` trailer. That session's ID appears nowhere in `devos`: neither in any commit message on any ref nor in the tree at `1893ab5` (109 session IDs are named there; none matches). It is not recorded here, being an identifier of Batu's other work.
- None is reachable from the library's `main`; all 62 are on one other branch.
- `devos`'s root commit is `333d1b2`, 2026-09-29T16:51Z, by Batu's account; plan 2.1, which fixed C00's conditions, is dated 29 September 2026 (`plan/work/C00.md`, acceptance block). The builder's first commit in `devos` is dated 2026-10-01T15:54Z.
- The builder's identities, seen in `devos`: its commits carry the session identity `Claude` (417 commits, all with the `noreply@anthropic.com` address), and its writes through GitHub are made by the machine account (177 commits: 171 pull-request merges and 6 others). So a builder write to the library would show as the session identity (a git push) or as the machine account (a write with the GitHub tools).
- Since `devos`'s root commit the library has 55 commits, all by Batu's account (54 authored and committed by it; 1 authored by it and committed by GitHub's web-flow). None has the session identity or the machine account.
- The plan's term: "the builder is whoever carries out the installation" (plan 0.7, Terms, "Builder and executor").

**Unseen by the session** (CHK-C00-067 condition 2): the library's issues, pull requests and comments, and GitHub's Activity view; commits that no ref reaches any more (for example ones a force push removed from every branch; GitHub may still serve them by ID, and nothing lists them); the old experiment repositories, which are not attached. Batu's push e-mails since about 2026-10-06T06:29Z are his channel (D-014); the session cannot read them. The guard's own record of this session (L-161) shows no push to the library and no GitHub write aimed at it (CHK-C00-067 finding 6); sessions before 2026-10-05T20:22Z have only their own records.
