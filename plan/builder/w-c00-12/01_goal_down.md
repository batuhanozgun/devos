# W-C00-12 · 01 · Goal-down look at the installation (acceptance (a), object O1)

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only. **Written:** 2026-10-03 by run `session_0143r88Vc9e5RbsQmqjYWgwa`, before any change to a mechanism (acceptance (a) requires this order; git order on `main` is the proof). **Method:** goal-down prerequisite discovery in the sense of the RPD study: from the outcome each stage must produce, ask what must be true of the builder's environment for that work to be possible, separate needs from methods, and mark what is only a method choice (decision-and-basis record at the end).

## 1. The chain this serves

SOUL (plan §1.1) ← DevOS builds it (plan §1.2) ← the installation C00–C12 builds DevOS (plan §9) ← **the builder's working system carries the installation**. The builder's system is therefore not a product. It is the environment that makes thirteen stages of mostly non-routine work possible, and it is handed over piece by piece to DevOS as DevOS's own components pass their tests. Two consequences follow, and they pull in opposite directions:

- It must be **robust**: every stage rests on it, and a weak builder system weakens every stage (W-C00-05 showed this).
- It must be **small and replaceable**: from C02 the database is live state, from C03 the audit environment gives binding verdicts, from C05 `CLAUDE.md` becomes DevOS's common rules, from C06 DevOS's own working order exists. Builder mechanisms that duplicate those components would become a second authority (principle 18; plan §6.12 item 4, the removal test).

The design answer to that tension is **explicit hand-over points**: each builder mechanism names the DevOS component that replaces it and the test that triggers the hand-over. This is not a temporary fix: a scaffold with a designed removal is part of the structure, while a scaffold nobody plans to remove is the temporary fix principle 1 forbids.

## 2. What each stage needs from the builder's environment

"Needs" are conditions, not mechanisms (RPD: need ≠ method). Columns: the work type the stage brings; the conditions the builder's environment must satisfy; what the stage hands over to DevOS, which shrinks the builder's system afterwards.

| Stage | Work type it brings | Conditions the builder's environment must satisfy | Hands over afterwards |
|---|---|---|---|
| **C00** plan check | Long document work (translation of about 347 KB of Turkish plan text, measured with `wc -c` over the twelve Turkish files in `plan/`), independent reviews with restricted input, a counter-design, decisions on findings | N1 work that spans many sessions without losing state; N2 producer and verifier separated, with input restriction that holds; N3 heavy work scheduled under the shared usage limit; N4 every finding gets a disposition that is findable later; N5 Batu's own decisions reach him batched, and nothing else does | — |
| **C01** platform facts | Probes of the real account (session length, connectors, tokens, subagents, routines, notifications, identity) | N6 probes are pre-registered and read from transcripts, not summaries; N7 a failed row changes the plan through a recorded candidate change; N8 the builder can create and inspect sessions and routines it owns, and nothing else | Facts that today live in the operating model's premise table move to C01 evidence |
| **C02** data model | SQL schema, `devos_api` functions, tests in PostgreSQL, identity chain, **ledger transfer** | N9 the builder's records are structured enough to transfer: typed records, stable IDs, statuses, supersession links (C02 acceptance: no duplication on re-run, resumable, links and versions match, `ledger.md` stops being writable) ; N10 migrations are versioned files reviewed before applying | **Live state** (work list, decisions, evidence index) moves to the database; the repository keeps files |
| **C03** trust boundaries | Negative tests per effect channel; an attack task; leak checks before public writes | N11 an inventory of every effect channel the builder itself uses (the builder is the first subject of C03); N12 the audit environment's credentials are not reachable from the work environment | **Binding review** moves from builder-started review sessions to the audit environment; the D-003 residual risk is re-assessed |
| **C04** knowledge | Library ingestion, search measurement with held-out questions, context packages | N13 the builder already uses the library the way C04 will formalise (pyramid routers, source status), so that C04 measures a known practice; N14 a separate session prepares the measurement questions (independence) | **Library access and context packages** move to DevOS search; the builder's ad-hoc consultation records become inputs |
| **C05** rules, roles, methods | `CLAUDE.md` and protocols, `.claude/agents/` role set, `methods/`, exams | N15 the builder's own role definitions, heritage and floor are written in the form C05 will use (P-W12-1: agents and skills load in cloud sessions), so C05 adapts rather than rewrites; N16 builder-only rules and DevOS rules are separable by scope label | **Common rules and roles**: the builder's `CLAUDE.md` is replaced by DevOS's; builder role definitions retire or become DevOS roles |
| **C06** working order | Routines, request-contribution-use flow, single writer, loop limits, decision channel | N17 the builder's continuity mechanism (runs, lease, any dispatcher) is understood well enough to be replaced, not merged with DevOS's | **Continuity and decision channel** move to DevOS |
| **C07** cognitive gate | The first real loop; criteria fixed before results | N18 criteria written before results, by a role that does not run the loop | — |
| **C08–C11** | Release chain, backup and recovery, learning, 7-day unattended run | N19 the builder does not run anything DevOS now owns; it observes and records | Remaining builder mechanisms |
| **C12** hand-over | Acceptance file with evidence per criterion | N20 every claim of the installation is traceable to evidence with its independence level | The builder's system ends |

**Conditions that hold across all stages** (the cross-cutting needs; they become the coverage columns of the mechanism map, object O5):
- **X1 Recovery of state and reasons:** a fresh session reaches the current state, the open items and the conditions of past decisions, and uses them (N1, N4, N9).
- **X2 Separation of producing and accepting** (N2, N14, N18).
- **X3 Ownership and identity of what the builder creates** (sessions, routines, reminders, branches) (N8, N11).
- **X4 Formation of every actor the builder starts** with purpose, floor, heritage and known failure patterns (N2, N15).
- **X5 Verification of claims before they are stated** (N6, N20).
- **X6 Routing of decisions** (only Batu's to Batu) (N5).
- **X7 Effect boundaries** (connectors, other repositories, others' sessions) (N8, N11).

## 3. Critical uncertainties that could change the design

Each is rated by what it would change if it went the other way. "Status" says what is known now.

| ID | Uncertainty | Status | What changes if it goes the other way |
|---|---|---|---|
| U-1 | `SessionStart` hooks, repository skills and agent definitions load in builder-created cloud sessions | **Observed once, PASS** (P-W12-1, 2026-10-03) | Settled for now: the boot root can be mechanical, methods can be skills, roles can be agent definitions. Re-check on a Claude Code version change. |
| U-2 | Whether a role defined in `.claude/agents/` and formed with heritage actually behaves differently (Actor B, not Actor A) | Untested | If formation does not change behaviour, heritage must be injected per task by the caller or checked by a gate, not trusted to the definition |
| U-3 | Quality loss within a long session before the 50% hand-over threshold | Untested here; the builder's own errors in this run (two estimated timestamps in the first hour) show that instructed rules decay even early | If quality decays early, hand-over must be by work boundary and quality signal, not only by context size; critical rules must be mechanical |
| U-4 | Whether the permission classifier allows the unattended path (a run creating a successor; a dispatcher starting a run; a run merging) | Observed once for the dispatcher path (T-A2r); a run starting its own successor never observed; denials vary with context | If denied, unattended continuity needs another route or stays manual for that step; never routed around |
| U-5 | Usage cost of the heavy C00 items (translation, reviews) under the shared limit | Unknown; only the status level is visible | Order and size of runs; whether translation must be split across nights |
| U-6 | Independence of builder-started reviewers (same model, same account) | Known limit (BP-07) | Until C03, every acceptance states its independence level; nothing claims more |
| U-7 | Whether the repository-file memory transfers cleanly to the database at C02 | Depends on the record design chosen now | If records are prose, the transfer becomes manual interpretation; so records must be typed now (N9) |
| U-8 | Whether a single allow-list barrier for all sessions is right, or per-role tool lists (agent definitions carry `tools:`) | Open (OI-011 item 20); P-W12-1 shows agent definitions load | A per-role barrier could replace parts of the session-wide hook, but the hook does not inspect agent definitions (§9) |
| U-9 | How C02 migrations are applied without a write key in the builder (its Supabase connection is read-only) | Open; added 2026-10-03 from the counter-design comparison (D-33) | If no keyless path exists (for example a deploy job holding a secret Batu enters), C02's design changes and a Batu account action may be needed; a separate design item before C02 |

**Open notes for later stages** (added 2026-10-03, D-33): C07 needs a hands-off mode in which builder items only observe and record (plan Appendix C, C5 hint ban); before C11 starts, every builder wake is disabled so that the builder is not what keeps DevOS alive.

**Not critical now** (they do not change the current piece): connector-catalogue scans (OI-011 item 18) and external memory products (OI-011 item 20 list). They feed later DevOS stages as candidates, not the builder's design.

## 4. Order of the design pieces

From the most foundational and least volatile to the most platform-dependent (acceptance (a) revision). Each piece is detailed only when it is reached; the counter-design comparison may reorder them.

1. **Memory and records (O4).** Every other piece writes or reads records; the C02 transfer depends on them (U-7); they depend on no open platform question. First.
2. **Work model (O2).** Built on the record design: states, dependencies, startable frontier, open notes, composition.
3. **Role system (O3).** Built on the work model (roles derive from work demand) and on U-1 (settled). Its behavioural premise U-2 gets its test here.
4. **Mechanism map (O5).** Drawn as the pieces above become concrete; locates every past failure; decides which instructed arrows become mechanical.
5. **Continuity and capacity.** The most platform-dependent piece (U-4, U-5). Decided last, with the dispatcher's demand trace (acceptance (g)).
6. **Assurance and hand-back (O6).** Test register, counter-design comparison, independent review, Batu's briefing.

## 5. Decision-and-basis record for this piece

- **Consulted:** the W-C00-12 row and OI-011 (state file); plan §9 C00–C12 in full, §6.12, §7.2; RUN_BRIEF; Batu's thirteen Original texts in full; library `research/studies/recursive-prerequisite-discovery/` (META, ASSESSMENT; status: bounded source-informed assessment, method efficacy unvalidated) for the need/method/decision separation and the ready-versus-completed distinction; `research/studies/context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md` (status: bounded synthesis, no architecture decision) for persistence ≠ memory ≠ context, "written rule ≠ runtime enforcement" (AP-08) and "more scaffolding ≠ more reliability" (AP-09); probe P-W12-1 (observed once).
- **Left out on purpose:** the library's own agent-control files (not instructions here); the external memory products named in OI-011 item 20 (candidates for DevOS, not needed to decide the builder's piece order); a full per-stage task plan (the revised (a) forbids a complete plan first).
- **Why it fits:** it derives needs from stage outcomes before choosing mechanisms, and it turns the "robust versus replaceable" tension into a design rule (hand-over points) instead of leaving it implicit.
- **How it is tested:** the counter-design does its own goal-down look (brief question 1); differences are closed with reasons. The independent review checks that every later design piece traces to a need N1–N20 or X1–X7, and that no mechanism exists without one.
