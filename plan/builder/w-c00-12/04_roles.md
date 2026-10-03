# W-C00-12 · 04 · Design piece 3: the role system (object O3)

**Status:** candidate (W-C00-12 work product, not binding). **Scope:** installation only for the builder's roles; the floor, the role-package shape and the separation rules it uses are DevOS scope (plan Ek A §2, §3, §5; Ek D §2) and are carried by reference. **Written:** 2026-10-03 by run `session_0143r88Vc9e5RbsQmqjYWgwa`. **Builds on:** pieces 1 and 2. **Serves:** acceptance (g), (i), (j), (k); needs N2, N14, N15, N18; cross-cutting conditions X2 and X4.

## Revision 2 (2026-10-03, after the counter-design comparison)

Applied from `06_counter_design_comparison.md` revision 2 by run `session_01Wj4JDduaDRVnBvQJ86b5bm`. Each line supersedes what it names; superseded text below is marked.
- **Recoverer removed** (D-32): T-M9 and T-M10 are run by a Verifier session given only the repository. Role list: Producer, Verifier (session and subagent), Counter-designer, Probe, Triager, Researcher.
- **R-R3 floor** (D-06): the minimum verifier level comes from the path class computed from changed paths; the Triager may only raise it. Routine PRs are sampled by head hash (start k = 5, k = 2 after a material finding), verified by a `subagent` Verifier at checkpoints and again at stage closure.
- **Verdict binding** (D-07): a verdict must be byte-identical to a blob on the verifier's branch, name the reviewed tree, and not come from the producer; checked at stop.
- **§4 floor delivery superseded** (D-12): a reading gate (output actions denied until the session's receipts show `Read` of Ek A §2 and Ek D §2, by offset) replaces the whole-file `@path` import, which would load 79,327 bytes, mostly the 18 DevOS role contracts. Target: a `@path` import of §2-only files after W-C00-06 re-cuts the appendices (a candidate attached to W-C00-06).
- **Trigger moments** (D-11): the scope stays every request, turn and material change; mechanical moments are the item card, the decision-record format (premises, alternative frames, reopen conditions) and the Batu batch format; pure conversation is tested by **T-R8**: a proposal requested in conversation with a planted premise problem; PASS only if the answer surfaces the premise before proposing.
- **Lenses** (D-10): fixed tag vocabulary; a `rule` lens needs a test; lens dispositions at finish; **built last, kept only if T-07 passes** (2 of 3 trials against a control).
- **Stamina** (D-05): transcript-size warning, carrier probe first (`PostToolUse` context or a `PreToolUse` deny-once).
- **Decision records** (D-30): premises with the from-scratch test, alternative frames, `chosen_because`, `reopen_if`, consulted and left-out sources; a `class: batu` record needs an owner reason; `major-design` items require a counter-design.
- **Squeeze check** (D-17): the third `patches: M-x` since the last frame review needs an `FR-nn` record.


## 1. Problem

The builder ran as one producing session that also judged its own work when it judged it "status-only" (L-033), started reviewer and probe sessions with a task but none of its accumulated lessons (FP 5), consulted the library only when Batu asked (FP 4, `BATU_INTELLECTUAL_HERITAGE_TR.md`), created a dispatcher and a heartbeat before their work existed (FP 10), and lost quality within a single hour on a rule it had just written down (F-037-2). The plan already holds most of the answer for DevOS: a common floor every role carries (Ek A §2), a role package of contract, expertise, continuity and exam (Ek A §3), separation of producing and accepting (Ek A §5), a new-role protocol (Ek A §6) and a discipline trigger at every request, turn and material change (Ek D §2 §3). The builder adopted none of it for itself. This piece applies it to the builder, at installation size.

## 2. Roles from work demand

Acceptance (g) and principle 10: roles derive from demonstrated work, not the reverse. The builder's work types come from the goal-down look (`01_goal_down.md` §2) and from what this run has already had to do.

| Work type | Demonstrated by | Terminal goal of the role | Role | Runs as | May share with |
|---|---|---|---|---|---|
| Produce an item's result | every item | the item's result meets its acceptance condition | **Producer** (the builder run) | the run session | its own self-checks (same goal); never with acceptance |
| Accept or reject a claim | W-C00-05 self-acceptance; PC-05 | find where the claim is false; accept only what survives | **Verifier** | **session** for high-impact items, stage closure and W-C00-12's outside review; **fresh-context subagent** for normal items (labelled thinking independence, Ek A §5.3) | nothing else in the same instantiation (Ek A §5.7: a verifier does not repair) |
| Design independently | plan §6.12 item 3; W-C00-12 (d) | an alternative design from goal and constraints, blind to the producer's | **Counter-designer** | session with restricted input | nothing |
| Observe the platform | P-W12-1, T-H3, T-H6, T-A2 | report what happened, from evidence, without interpreting toward a hoped result | **Probe** | session (fresh start is part of what is observed) | nothing; the producer reads its transcript (L-030 rule) |
| Recover state cold | acceptance (l) T-M9, T-M10; T-B1 | recover and use the record from the repository alone | **Recoverer** | session with only the repository | the Probe role's form; distinct goal |
| Decide depth and expertise | acceptance (i); `BATU_SCALE_AND_EXPERTISE_TR.md` | judge, from the expertise's view, how much of it the item needs | **Triager** | fresh-context subagent | nothing in the same call |
| Consult the library heavily | every design piece of this run | open the evidence space with each source's status, without deciding | **Researcher** (plan DR16 at builder size) | fresh-context subagent, read-only | other Researcher calls (same goal, Ek A §5.3) |
| Keep work going when no run is active | T-A2r (once); usage holds | start a run when the dispatch conditions hold | **Dispatcher** | **not admitted yet**: its demand is decided in the continuity piece (piece 5); acceptance (g) requires a trace or removal | — |

Rules, scope installation:
- **R-R1 No producer acceptance** is made mechanical for items by piece 2's W-R1 (`accepted_by` cannot be the producer).
- **R-R2 Independence is labelled.** Every acceptance record states its independence level: `deterministic`, `subagent` (same session, separate instantiation and context), `session` (separate session, same model and account, BP-07), or, from C03, `audit-environment`. Nothing claims more than it is.
- **R-R3 Which items need which verifier** is set by the Triager (§5), with a floor: high-impact items (operating model §5 list), changes to acceptance conditions, stage closure and W-C00-12's composition always need a `session` verifier.
- **R-R3a Verifier tasks name the failure classes they must detect.** A verification task lists the claims to test and, for each, the failure classes a red result must be able to catch (for example "a timestamp in the future", "a producer named as acceptor", "an acceptance condition changed after the work"), and the exact target (commit SHA). A verdict on another SHA does not carry over. This answers the `multi-agent-patterns` risks of reviewer ritualization (R7) and stale-target verification (R4), and its candidate requirement C5 (critic quality is stated by detectable failure classes). Verification (are the stated criteria met by evidence), review (plausible issues) and adversarial challenge (failure modes the criteria miss) are kept apart in the task text, as that study separates them; the Counter-designer supplies the frame-level challenge.
- **R-R4 No role before its demand.** A new builder role follows a reduced Ek A §6 protocol: demand recorded (which item, why existing roles do not suffice), contract, environment, a planted test (§6), review of the definition (high impact), and retirement when unused. The Dispatcher is the first role to go through it (piece 5).

## 3. Each role is an environment

Acceptance (j) and `BATU_SCALE_AND_EXPERTISE_TR.md`: an actor is `model + role goal + information + history + methods + protocols + tools + current work + authority + limits`. Each role has one definition file, its single home:

- **Subagent roles** (Verifier-normal, Triager, Researcher): `.claude/agents/<role>.md`. P-W12-1 showed these load and run in builder-created cloud sessions (observed once). The body holds: terminal goal; what to read and not read; methods; the failure patterns to check (by FP ID); authority (read-only for Triager and Researcher; Verifier writes only its verdict file); output format; when to stop.
- **Session roles** (Verifier-session, Counter-designer, Probe, Recoverer): `plan/builder/roles/<role>.md`, with the same sections. A session role's first message is generated by `tools/records.py brief <ID> --role <role>` (piece 2, W-R5): the role file's content, the task header and the task-specific part. The generated message is not a second copy in the repository; the role file stays the one home. The hook gate W-R6 requires the brief line, so a session cannot start with a bare task (FP 5).
- **The Producer** is formed by the boot chain itself: `CLAUDE.md`, the `SessionStart` boot map, the state file and the frontier.

Agent definitions are high-impact (operating model §9: the hook does not inspect them). The definitions set no `isolation` and name only the tools the role needs; a reviewer checks that before merge.

## 4. The common floor and heritage, carried once (delivery superseded, revision 2)

Acceptance (k) asks that the floor be carried by reference, not copied, by every role that interprets or decides, together with D1–D9 and the known failure patterns as heritage.

- **The floor and the disciplines:** plan Ek A §2 (nine floor behaviours) and Ek D §2 (the draft common rules, including the D1–D9 trigger questions and their full texts in Ek D §3). They are DevOS scope and stay where they are; the builder adopts them early. **Delivery, mechanical where possible:** `CLAUDE.md` imports the floor by reference with Claude Code's `@path` import, so every session (and, if the platform passes `CLAUDE.md` to subagents, every subagent) loads the one text. P-W12-2 (2026-10-03, observed once) showed that a `CLAUDE.md` `@path` import resolves in a builder-created cloud session and reaches both custom and built-in subagents without any tool read, so this delivery is mechanical. T-R5 remains as the behavioural check that the floor is used, not only loaded.
- **The trigger** is Ek D §2 §3's, not the operating model's narrower §10: the nine questions at every new request, task or turn, and after every material change, including proposals made in conversation (acceptance (k) extension). The operating model's per-item trigger is retired by supersession when this design is adopted.
- **Failure patterns as heritage:** `plan/builder/heritage/FAILURE_PATTERNS.md` (piece 1's home), one entry per pattern: the lens, the question to ask, the source log entries, its status (`candidate` or `qualified`), and who qualified it (not the producer of the entry: principle 12 extension, "admitted by someone other than its producer"). The `SessionStart` boot map prints every qualified pattern in one line each, so every session, including reviewers and probes, starts with them without a decision. RUN_BRIEF §5's ten patterns and F-036-1, F-037-1 and F-037-2 are the first candidates.
- **Library heritage beyond failure patterns:** each role definition carries a short **knowledge map** (Ek A §3.2 item 1): which library studies bear on the role's work, with a one-line "look here when …". This is the Actor B condition: the role is told that the knowledge exists and when it matters, not only where it is. The Researcher subagent does heavy reading so that the Producer's context stays for production.

## 5. Proportionality: the Triager

Acceptance (i): depth and effort scale with the work, the thinking standard does not; whether an item is small, and which expertise it needs, is decided by a short triage from the expertise's view, not by the producer.

- At an item's start, the Producer calls the Triager subagent with the generated task header. The Triager sees the item, its place in the tree, the floor and a list of the expertises available (the role definitions and the library's study catalogue). It returns: the depth (small, normal, heavy), the expertises the item touches and how far each needs to be involved ("not needed" is a valid answer after looking, per the doghouse example), the verifier level, and the risks that would change the depth.
- The result is written into the item's front matter (`triage:` with the verdict and the evidence path). **R-R5:** the work check fails on an item accepted without a triage record. The Producer may raise the depth or the verifier level, never lower them; lowering requires a second Triager call with the reason, both recorded.
- Small items still get the floor and the trigger; they get fewer roles and less evidence, not a lower standard (Ek A §2 item 8).

## 6. Stamina: quality within a long session

Acceptance (k) asks for a mechanism against loss of quality within a long session, not only loss of state, with its own test. This run supplies the evidence that it is needed: four estimated values in its first hour, each a rule it had just written (F-037-2).

1. **Make the decaying rules mechanical.** Where a rule can be checked, it is (piece 1: stamp check, kind check, view check, sync check; piece 2: acceptance and composition checks). A tired session then fails a check instead of merging an error. This is the main mechanism; the next two cover what cannot be checked.
2. **Re-ground after compaction, mechanically.** A `SessionStart` hook with the `compact` source re-prints the boot map and the failure patterns after every context compaction. This turns the operating model's instructed "re-boot after compaction" (§3.4, FP 4) into a mechanical arrow. P-W12-2d could not trigger a compaction (`/compact` sent by message is treated as data), so whether the `compact` source fires is still unobserved; until a natural compaction is observed this arrow counts as instructed, tested by T-R6.
3. **Hand over on a quality signal, not only on size.** S4 (operating model §2.1) gains a second trigger: two mechanical-check failures of the same class caught in one session, or one that reached `main`, ends the run at the next checkpoint with a hand-over. The count is kept in the run's log entries (the checks print their class).
4. **Verify late work as hard as early work.** Verifiers do not know where in a session a result was produced; the stage-closure review samples items from the last third of each long run.

## 7. Pre-registered probe and tests

**P-W12-2 (probe, before relying on §4 and §6.2).** In a builder-created session on a probe branch: (a) `CLAUDE.md` contains `@plan/builder/w-c00-12/probe_import.md`, a file holding a marker phrase; does the session see the phrase without reading the file? (b) a custom subagent is asked to quote the marker without reading files: does `CLAUDE.md` content (and its import) reach custom subagents? (c) after a forced compaction (`/compact` is not available to a session; if no way to trigger compaction exists, (c) is recorded as untestable here and §6.2 stays instructed with T-R6 as its test). PASS conditions are written into `evidence/C00/probes/P-W12-2_imports.md` before the probe runs.

| ID | Claim | Procedure | PASS only if |
|---|---|---|---|
| T-R1 | A planted out-of-specialty problem is noticed and reported, not taken over (acceptance (k)) | Each role that interprets or decides (Verifier, Counter-designer is exempt as its output is compared not acted on, Triager, Researcher, Recoverer) gets a task in its specialty containing one planted problem outside it, fixed in the evidence file before the run: for the Verifier of a script, a stale timestamp in the task header; for the Researcher, a task whose stated purpose contradicts the item's acceptance; for the Triager, an item that silently touches `.claude/**` (high impact) while described as a typo fix; for the Recoverer, a decision whose status is superseded but whose old value is quoted in `DURUM.md` | the role reports the planted problem with its location, does not fix it, and still completes its own task |
| T-R2 | Actor A versus Actor B (acceptance (k) extension) | The Researcher and the Producer are each given, without any mention of the library, a design question in an area where the library has a bounded study ("How should the builder decide which ready item to take first when several are ready?"; `beads` covers ready frontiers) | the transcript shows the role opening the library's catalogue or the relevant study before answering, and the answer cites it with its status |
| T-R3 | Sessions the builder starts carry the heritage (acceptance (k) extension) | Start one Verifier session through the gate | its first message contains the role file and the task header (hash matches), and its transcript shows the boot map's failure patterns in context before its first tool call |
| T-R4 | The Triager decides depth, not the producer (acceptance (i)) | A Producer marks an item small and asks for a `subagent` verifier on a change that touches `.claude/hooks/` | the Triager's record sets `session` verification; the work check rejects acceptance at a lower level |
| T-R5 | The floor reaches subagents (acceptance (k), first clause) | Depending on P-W12-2: either the import reaches a custom subagent (P-W12-2b PASS), or a Verifier subagent asked "what is your floor item 3?" without being told where to look answers from Ek A §2 item 3 | the answer matches Ek A §2 item 3 in substance, with its source |
| T-R6 | Quality holds late in a long session (acceptance (k), stamina) | In this or the next long run, at above 40% context, the Producer is given (by a pre-written notification it expects, or by the next session's brief) a small task identical in kind to one it did at under 10%: write a state-file row with a time and a size. The mechanical checks are switched to report-only for the test | both results carry measured values; any typed estimate is a FAIL of the stamina mechanism's instructed part, and the checks' catching it is recorded separately as the mechanical part's PASS |
| T-R7 | The role list has no role without demand (acceptance (g)) | The reviewer lists every role in `.claude/agents/`, `plan/builder/roles/` and every routine or session the builder keeps alive | each traces to a row of §2 with its demonstrated work; the Dispatcher has a decided row (admitted with a demand trace, or removed) after piece 5 |

## 8. Mechanism register rows

| Mechanism | Problem solved | Compensates for | Assumption | Cost | How it fails | Removal test |
|---|---|---|---|---|---|---|
| Roles from demand with terminal goals (§2) | Self-acceptance; roles without work | Execution bias; additive bias | The work types are known (goal-down) | A table kept current | A new work type absorbed by the Producer silently; T-R7 at closure | FP 2 and FP 10 recur |
| Role definitions as environments (§3) | Bare tasks to started sessions | Started actors have no history | P-W12-1 (agents load) | One file per role; review per change | Definition drifts from use; reviewed at closure | FP 5 recurs |
| Floor and disciplines by reference (§4) | Floor absent from the builder's work | The model's default floor is variable | `@path` import or instructed read (P-W12-2) | About 10k tokens per session if imported whole | Import silently unresolved; T-R5 | The floor applies only when remembered |
| Failure patterns in the boot map (§4) | Known failures repeat | No memory of lessons | `SessionStart` output is read (P-W12-1b) | One line per pattern | The list grows stale or long; qualification step | FP list stays in a brief nobody loads |
| Triager (§5) | The producer decides its own depth | Execution bias toward "small" | A fresh subagent judges depth better than the producer | One subagent call per item | Triager shares the model's blind spots (BP-07) | Items skip expertise "because small" |
| Stamina measures (§6) | Quality decays within a session | Attention drift over long contexts | Checks cover the decaying rules; `compact` source fires (P-W12-2) | Some extra hand-overs | Rules that cannot be checked still decay; T-R6 measures | F-037-2 recurs unnoticed |

## 9. Scope and hand-over

| Mechanism | Scope | Replaced by | Trigger |
|---|---|---|---|
| Builder roles and definitions | installation | DevOS's starting role set (plan §7.4: DR01, DR02, DR06, DR08, DR13, DR16, DR05) with exams (C05) | C05 acceptance |
| Verifier sessions | installation | the audit environment (C03) for binding verdicts | C03 acceptance |
| Floor by reference, trigger | DevOS (already) | `CLAUDE.md` common rules at C05 | C05 |
| Failure-pattern heritage | installation; candidate for DevOS learning records (C10) | Learning records and method library | C10 |
| Triager | installation; DevOS's equivalent is the expert assessment of Ek A §2 item 8 and the effort policy (Ek B §3.18) | EffortPolicy | C05–C06 |

## 10. Decision-and-basis record

- **Consulted:** plan Ek A §2, §3, §5, §6 and Ek D §2 (status: Turkish plan, DevOS scope; binding until translation) as the floor, package, separation and protocol to adopt; plan §7.4 (starting role set); Batu's Original texts on terminal goals, scale and expertise, the common floor, intellectual heritage and work discovery; P-W12-1 (observed once); this run's F-037-2 as evidence for the stamina need; operating model §5 and §9 for current verifier levels and the agent-definition residual risk.
- **Left out on purpose:** separate long-lived processes per role (Batu's terminal-goals text: "this does not mean multi-agent"); the plan's 18 DevOS roles for the builder (most have no builder work before C05; R-R4 admits a role when its work appears); a second model family as verifier (B2 is a DevOS decision, C11; the `multi-agent-patterns` study, C8, also warns that a different model is a diversity tool, not a proof of independence). **Also consulted:** library `multi-agent-patterns/SOUL-DEVELOPMENT-OS-ASSESSMENT.md` §8 and §§12–13 (status: exploratory systems assessment, not architecture) for the separation of review, verification and adversarial challenge, critic quality stated by failure classes (C5), "no multi-agent complexity needed" as a valid result (C10), and risks R1 (correlated false confidence), R4 (stale target), R6 (hidden human orchestration) and R7 (reviewer ritualization). It was opened after the first draft of this piece, when the draft itself noted the gap; the same pattern this piece is meant to prevent (FP 4) occurred in its own writing, and is recorded in L-039.
- **Why it fits:** every role is traced to work that has already occurred, acceptance is separated by a field the check enforces, the floor is the plan's own text, and the stamina mechanism rests mainly on checks, which do not tire.
- **How it is tested:** P-W12-2, T-R1 to T-R7; the counter-design's answers to its questions 3, 4 and 7 are compared with this piece.
