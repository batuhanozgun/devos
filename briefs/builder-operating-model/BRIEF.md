# Brief: design the builder's operating model for the DevOS installation period

You are an independent designer. Another session (the builder) is designing the same thing in parallel. You do not see its design, and it does not see yours until both are done. Your design will be compared with the builder's. Differences will be resolved with reasons. Design from first principles; do not try to guess the other design.

**Read only this directory (`briefs/builder-operating-model/`).** Do not open `plan/`, `evidence/` or other directories, and do not inspect git history. They contain material that would contaminate an independent design.

## 1. Purpose

DevOS is an AI working system that will develop SOUL, an agent system that fills the expertise a user lacks for a job. DevOS runs on Claude Code cloud (web sessions, routines, subagents), uses a Supabase database for live state, and uses GitHub for everything it produces. An installation plan (stages C00–C12) says what to build: stage C00 checks the plan, C01 checks platform facts, C02 builds the database, and so on.

**The builder** is a single Claude Code cloud session (plus whatever helpers it starts) that carries out the installation. The installation plan designs DevOS's own working structure in detail, but not the builder's. Your task: **design the builder's operating model for the installation period**: how it keeps working, remembers, tracks work, routes decisions, gets independent review, applies its thinking discipline, manages capacity, stays safe, and handles failures.

## 2. Batu's expectations (the owner; his words, translated)

Batu's message, in English (the Turkish original is in `BATU_ORIGINAL_TR.md` in this directory):

Situation. The plan treated the builder as "a session that executes the plan", but the builder is itself a working system and needs its own operating model. The lack of one caused, in the first days: (1) the builder stopped after every step and waited for Batu; (2) the ledger and work stayed on the builder's branch instead of reaching `main`; (3) the builder could not reach the preparation list, and Batu had to carry messages between chats; (4) the builder brought Batu a technical approval question; (5) working rules were added piecemeal as needs arose, not designed as a whole.

Firm expectations:

1. Batu is not a message carrier. He must never have to carry information between chats or sessions. Results of independent review sessions reach the builder through the repository (a file, a PR or a record), not through Batu.
2. Only Batu's own decisions go to Batu: purpose, scope, cost, choices that affect his accounts and his other work, and acceptance. Technical decisions are the builder's. Technical approval of high-impact changes (rules, roles, database schema, security settings) is given by independent review, not by Batu.
3. The builder does not wait for Batu at every step. It collects the things Batu has to do and asks for them once, step by step.
4. "Done" depends on evidence. Batu's approval is not evidence of technical correctness.
5. Batu must not need to ask anyone to see the status. There is a short Turkish status page, always current: which stage, what was done last, what comes next, what is expected from Batu.

Questions the design must answer:

- **A. Continuity:** how does the builder keep going without Batu typing? `/goal` is one tool, but the builder must not depend on Batu typing a command at every stage. Consider self-started goals, scheduled routines, Claude Code Projects, and what happens when the usage limit is reached. State the rationale, cost and limits of the chosen route.
- **B. Memory and a single source of truth:** which file a new session starts from, and in what order; how the gap between `main` and the working branch is closed; how the ledger is kept from sprawling as it grows; what protects against loss in context compaction; how to compensate for the `/goal` evaluator seeing only the conversation.
- **C. Work tracking:** how stages become a work list; how priority is set; what "done" means. Acceptance conditions are written before results are seen; every item closes with evidence.
- **D. Decision routing:** which kind of decision is made by the builder, by independent review, or by Batu. Decisions for Batu follow a fixed format: question, why it is his, options with purpose, benefit and cost, recommendation, what he needs to know, what happens if he does not answer.
- **E. Independence and quality:** who reviews the builder's work, when and how; how review sessions start and how their results reach the builder without Batu; every stage closure is checked by a session that did not do the work.
- **F. Thinking discipline:** how the builder applies nine thinking disciplines to itself during installation (decision-critical assumptions; reasoning free of non-evidential pressure; goal alignment and end-to-end verification; validity and independence of verification; source vs. view; causal depth; work continuity; pre-work state check; use of the research library). Apply a frame review to the operating model itself.
- **G. Usage and capacity:** the builder shares Batu's Max-plan usage allowance with Batu's own use. How does it schedule heavy work, track usage, and when does it inform Batu?
- **H. Security:** the builder session may have the account's connectors loaded (mail, calendar, files). An instruction alone is not enough. What technical barrier is used during installation?
- **I. Failure modes:** the session dies; branches diverge; a conflict in the ledger; a wrong "goal met" verdict; Batu does not answer for a long time; the usage limit is reached.
- **J. Numbering:** Batu's decisions are numbered K1–K9. The builder's own plan changes need a separate prefix.

Quality rule from Batu: do not settle for too little, but add no needless complexity. Every mechanism states which problem it solves and which assumption it rests on.

## 3. Fixed constraints

- **Language:** everything inside DevOS (files, records, commits, agent-to-agent communication) is in English; everything addressed to Batu is in Turkish.
- **Repositories:** `devos` is public (anything pushed is world-visible at once); only safe summaries go there, never private research text or conversation transcripts. The research library repository is read-only for the builder (rule only; on GitHub the system account can write). Each repository has a single writer.
- **Secrets** are never written in chat, repositories or records, and never requested from Batu in chat.
- **No paid feature** is enabled. Plan: Claude Max (shared with Batu's own use), extra usage off, no Anthropic API key. Supabase free plan.
- **The builder's Supabase connection** is read-only at database level. Database changes are allowed only as versioned migration files.
- **The account's other connectors** (mail, calendar, files and similar) must never be used.
- **Batu's role:** purpose, decisions, acceptance. No message carrying, no technical maintenance. He works from his phone.
- Quality is not lowered to save cost; if capacity is short, speed drops, not quality.

## 4. Platform facts (observed by the builder on 2026-10-01 unless marked)

| Fact | Status |
|---|---|
| A session can create another cloud session (`create_session`) in the same environment, optionally with a repository checkout and a branch to push to, and read its record and transcript (`get_session`, `list_events`). | observed |
| If a session is created with a first message of the form `/goal <condition>`, the goal is set in that new session and evaluated after each turn. | observed (probe T-A1a: goal set and met) |
| `/goal`: a natural-language completion condition (up to 4,000 characters); after each turn a small fast model judges it from the conversation only (not met / met / impossible); `/goal clear` cancels it; it does not change the permission mode; evaluation is deferred while subagents or background shells run; an active goal is restored when a session is resumed. | documented (code.claude.com/docs/en/goal) |
| A session can schedule a one-shot message into itself at a future time (`send_later`), and can create scheduled routines (`create_trigger`) that start a fresh session on each firing. Recurring routines are limited to 15 runs per day on Max; one-shot runs are reported not to count. | observed (tools exist; a one-shot wake-up is scheduled); limits documented |
| A routine created through the session's tool carries no connectors (`mcp_connections` empty). | observed in the trigger configuration |
| Routines created through the claude.ai interface attach all of the account's connectors by default. | documented |
| Sessions run in "auto" permission mode. An automatic classifier can deny individual actions. | observed (one denial so far) |
| Each session's record shows the account's rate-limit status (for example `seven_day`, `allowed_warning`, reset time). The fraction used is not shown. | observed |
| A session's context window is about 1M tokens; long sessions are compacted. | observed (context size); compaction documented |
| A session can attach further repositories it has access to (`add_repo`). The system GitHub account can push to `devos`. `main` requires a pull request but no approval; the session can open and merge its own PRs. | observed |
| Project-level `.claude/settings.json` in the repository can hold permission rules (allow/deny by tool name pattern) and hooks; the harness enforces them, not the model. | documented (Claude Code settings); not yet tested here |
| Claude Code Projects (beta) exists; whether it is enabled on Batu's account is unknown. | documented; account state unknown |
| A session's sandbox can be paused between turns and may resume from a fresh copy; unsaved work can be lost. | documented |

## 5. What to deliver

Write **one file**: `briefs/builder-operating-model/COUNTER_DESIGN.md`, in English, with:

1. The premises your design rests on, each with its origin and the from-scratch test.
2. The design, answering A–J. For each mechanism: the problem it solves, the assumption it rests on, its cost, and how it fails.
3. What you would test first to show it works, and what "works" means for each test.
4. The open problems you could not solve.

Commit it to your branch and push. Do not open a pull request; the builder will read your branch. Keep it under about 2,500 words. Plain, precise English.
