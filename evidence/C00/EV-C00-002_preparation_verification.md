# EV-C00-002 · Preparation verification (C00 step 1), first pass

A safe summary in the common evidence envelope (plan Section 8.9). It contains no library content and no key or token values.

| Field | Value |
|---|---|
| Claim tested | "The preparation listed in plan Section 9, C00 step 1, and Section 12 ('Hazırlıkta') is complete." |
| Result | **Partly verified.** Nothing observed is missing. Several items cannot be seen from the builder session and need Batu's confirmation (OI-008). |
| Target | Batu's GitHub account (as seen by `batuhanozgun-devos`), the Supabase live project, the builder session |
| Builder repository state | `devos` at `c5e34ee`, branch `claude/epic-hamilton-9tisc4` |
| Criterion version | Plan 2.1 + K10, Section 9 C00 step 1 and Section 12 (Turkish text binding) |
| Independence level | `same_session` |
| Evidence layer | structural |
| Raw evidence | Not stored (no raw-evidence store before C02; OI-006 applies) |
| Observed at | 2026-10-01, 16:50Z–17:05Z |

## Items

Legend for "Status": **observed** = seen in the system; **documented only** = stated by a tool or document, not seen working; **not visible** = cannot be seen from this session; needs Batu.

| # | Preparation item (plan) | Status | Observation |
|---|---|---|---|
| 1 | Repository `devos` exists, public (K6) | observed | GitHub search as `batuhanozgun-devos`: public |
| 2 | Repository `soul-system` exists, public | observed | public; created 2026-09-29 |
| 3 | Repository `devos-evals` exists, private | observed | private; visible to the machine account (plan Section 0.5 gives it write access) |
| 4 | Repository `devos-backup` exists, private | **not visible** | Not in the machine account's search results. Expected: the machine account is not a collaborator by design (plan Section 13). Existence needs Batu's confirmation. |
| 5 | Supabase live project `devos` (ref `zyqgltzfzkdvrmvxlamz`) exists | observed | Builder connector reports this project URL; REST endpoint answers HTTP 401 without a key |
| 6 | Supabase test project `devos-test` (ref `cqbzxexxwrrbrlszoseg`) exists | observed (endpoint only) | REST endpoint answers HTTP 401 without a key. That the project is named `devos-test`, on the free plan, in us-east-1, is not visible. |
| 7 | Builder's Supabase connection limited to read-only mode | **observed (database layer)** | `execute_sql` runs as `supabase_read_only_user` with `transaction_read_only = on`. No write was attempted. |
| 8 | Builder's Supabase connection limited to a single project | documented only | The connector exposes no project list or project selector, and returns the live project's URL. Not tested further. |
| 9 | B3 = (a): machine account exists and Claude's GitHub connection uses it | observed | GitHub tools authenticate as `batuhanozgun-devos` (created 2026-09-29) |
| 10 | Claude GitHub App installed on the needed repositories | partly observed | Works for `devos` (clone, push to `claude/` branch) and `agentic-os-search` (attach, clone). Not exercised for `soul-system` and `devos-evals`. |
| 11 | Builder environment `devos-kurulum` opened | observed | This session runs in environment `devos-kurulum` (`env_01AMBDuHjjTsXMeXFyYgk1zR`) |
| 12 | `agentic-os-search` has decision D030 and no longer shows the old direction as current | observed | D030 present in the EXP-006 decision record, dated 2026-09-29; the root README names `devos/plan/` (version 2.1) as the only current plan and states that old "current"/"next" statements are not instructions for Claude Code. Only the root README and D030 were read; other files were not checked for leftover "current" claims. |
| 13 | Extra usage is off | **not visible** | Account setting; needs Batu |
| 14 | Phone apps (Claude, GitHub) | **not visible** | needs Batu |
| 15 | ChatGPT correction task given | observed (outcome) | Item 12 shows the correction landed; library head `dc91f6b` dated 2026-10-01 |
| 16 | The GitHub access key deleted | **not visible** | Needs Batu. Related: environment variables named `GH_TOKEN` and `GITHUB_TOKEN` exist in the builder session (OI-003); whether they are that key, a platform credential or a placeholder is unknown. |
| 17 | Machine account added as collaborator to Batu's other Claude Code projects (B3 side effect) | not checked | Concerns Batu's other work, not DevOS; outside C00 scope unless Batu wants it checked |

## Additional observation: usage limit

The session record reports the account's **seven-day** rate limit with status `allowed_warning`, resetting at about 2026-10-03 17:00Z (Unix 1791046800). The fraction used is not shown. This limit is shared with Batu's own Claude use (plan U-5; Section 13). See L-007.

## What this evidence does not show

- That `devos-backup` exists, that extra usage is off, or that the GitHub access key was deleted.
- That other library files are free of leftover "current" or "next" statements (C04 import will tag authority status).
- How much of the weekly limit remains.
