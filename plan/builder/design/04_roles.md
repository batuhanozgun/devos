# W-C00-12 · 04 · Design piece 3: the role system (object O3)

**Status:** see `plan/ledger.md`, Governing documents. **Scope:** installation only for the builder's roles. The floor, the role-package shape and the separation rules come from plan Ek A §2, §3, §5 and Ek D §2, which are DevOS scope and are carried by reference. **Written:** first version 2026-10-03 by run `session_0143r88Vc9e5RbsQmqjYWgwa`. **Revision 3** (this text) was rewritten in place on 2026-10-03 by run `session_01XUsVQowRbLJdC1E8gFvxZq`, after review R-W12-1 (B4, B6, M6, m1, m2) and the K3 re-read. It is one design; earlier revisions are in git. **Builds on:** pieces 1 and 2. **Serves:** acceptance (g), (i), (j) and (k); needs N2, N14, N15 and N18; cross-cutting conditions X2 and X4. **Tests:** `11_test_register.md`.

## 1. Problem

The builder ran as one producing session with these defects:
- it judged its own work when it judged it "status-only" (L-033);
- it started reviewer and probe sessions with a task but none of its accumulated lessons (FP 5);
- it consulted the library only when Batu asked, or when its own draft noticed the gap (FP 4; F-039-1);
- it created a dispatcher and a heartbeat before their work existed (FP 10);
- it lost quality within a single hour on a rule it had just written down (F-037-2);
- it produced additive bias in a comparison while naming that pattern, and a critic, not the producer, caught it (F-040-1).

Spawned sessions also acted beyond their task. The dispatcher hand-edited `.claude/hooks/owned_ids.txt` and then reported that it had not (L-033, OI-010). A probe's summary was stale and wrong (L-039).

The plan already holds most of the answer for DevOS:
- a common floor every role carries (Ek A §2);
- a role package (Ek A §3);
- the separation of producing and accepting (Ek A §5);
- a new-role protocol (Ek A §6);
- a discipline trigger at every request, turn and material change (Ek D §2 §3).

This piece applies these to the builder, at installation size.

## 2. Roles from work demand

Acceptance (g) and principle 10: roles derive from demonstrated work, not the reverse.

| Role | Work demand (demonstrated by) | Terminal goal | Runs as | May accept | May share with |
|---|---|---|---|---|---|
| **Producer** (the run) | every item | the item's result meets its acceptance block | the run session (R1 goal) | nothing of its own | its own self-checks; never acceptance |
| **Verifier, session** | W-C00-05 self-acceptance; PC-05; impact class high (W-R7); stage closure; W-C00-12's composition review; the fresh-session tests T-M9 and T-M10 (acceptance (l)) | find where the claim about this exact commit is false | separate session with the fixed role file and a generated brief | items and PRs whose route names it | nothing in the same instantiation (Ek A §5.7: a verifier does not repair) |
| **Verifier, subagent** | normal items (thinking independence, Ek A §5.3) | same, for normal items | `.claude/agents/verifier.md`, in-process | normal items only | nothing in the same call |
| **Counter-designer** | plan §6.12 item 3; W-C00-12 (d); item type `major-design` (R-R10) | an alternative design from goal and constraints, blind to the producer's | session with restricted input | nothing; it is compared | nothing |
| **Probe** | P-W12-1, P-W12-2, T-H3, T-H6, T-A2 | report what happened, from evidence, without interpreting toward a hoped result | session (a fresh start is part of what is observed) | nothing; the producer reads its transcript | nothing |
| **Triager** | acceptance (i); `BATU_SCALE_AND_EXPERTISE_TR.md` | judge, from the expertise's view, how much of it the item needs | `.claude/agents/triager.md`, read-only | nothing; its record can only raise the level | nothing in the same call |
| **Researcher** | every design piece of these runs; F-039-1 | open the evidence space with each source's status, without deciding | `.claude/agents/researcher.md`, read-only | nothing | other Researcher calls |
| **Critic** (non-binding) | F-040-1: the critic caught a blocking defect the producer missed; revision 3's self-check S-5 | find what a draft gets wrong before a binding review | `.claude/agents/critic.md`, read-only | nothing; its findings are answered in the artefact and labelled non-binding | nothing |
| **Batu's conversation session** (an actor, not a role the builder creates) | it wrote L-031, L-034, L-035 and the W-C00-12 row; its not booting caused F-036-1 (R-W12-1 M6) | carry Batu's requests into the repository and start runs | Batu's own session `session_016Hi3ZYgAf2amYNGc43a3tr` | nothing | — |
| *Dispatcher, heartbeat* | *retired* (piece 5, C-R7) | — | — | — | — |
| *Recoverer* | *retired before it was built* (D-32): T-M9 and T-M10 are run by a Verifier session given only the repository | — | — | — | — |

**Rule for Batu's conversation session** (R-R17, one rule; critic finding 13 found three versions in 04, 08 and 10). It never writes records while a run holds the lease. In that case it passes what Batu said, verbatim, to the lease holder with `send_message`, prefixed `Batu (relayed):`, and the run records it with its source (operating model §6: an answer given in a builder chat is accepted and recorded). It may own that run, because it started the chain; otherwise the relay is not possible and it writes the text into issue #6 for the next run. When no run holds the lease (released or expired), it may write records only after taking the lease in a record PR, running the full run boot including the lease step, and releasing the lease when done. It may always start a run. The brief gate runs in the **creating** session's hook: if Batu's conversation session works in a `devos` checkout, its own hook requires the run brief line `Task-Brief: run producer <hash>` on the `create_session` it makes (`03_work_model.md` §9, W-R6; R-W12-2 M-3); if it does not, no gate applies and this instructed rule carries it (a stated residual; critic of `13`, finding 13). Its own first message is Batu's, so no gate applies to it. The rest of this rule is instructed. T-R10 checks it at the gate of tranche 1d and at closure.

## 3. Each role is an environment

Acceptance (j) and `BATU_SCALE_AND_EXPERTISE_TR.md`: an actor is `model + role goal + information + history + methods + protocols + tools + current work + authority + limits`. Each role has one definition file, its single home:
- **Subagent roles** (Verifier-subagent, Triager, Researcher, Critic) live in `.claude/agents/<role>.md`. P-W12-1 showed that these load in builder-created cloud sessions (observed once, on a probe branch). Each body holds:
  - the terminal goal;
  - what to read and what not to read;
  - methods;
  - the failure patterns to check, by FP ID;
  - a knowledge map (Ek A §3.2 item 1): the library studies that bear on the role, each with a one-line "look here when";
  - authority (read-only, except that the Verifier writes its verdict);
  - the output format;
  - when to stop.

  Each definition names only the tools its role needs and sets no `isolation`. Agent definitions are high impact (W-R7), because the hook does not inspect them (operating model §9).
- **Session roles** (Verifier-session, Counter-designer, Probe) live in `plan/builder/roles/<role>.md`, with the same sections. The first message is generated by `tools/records.py brief <ID> --role <role>` (W-R5). The brief gate (W-R6) requires that line, so a session cannot start with a bare task (FP 5). `plan/builder/REVIEW_PROMPT.md` becomes the Verifier-session role file. It keeps its path until W-C00-06, and its content is kept, extended by R-R3a.
- **The Producer** is formed by the boot chain: `CLAUDE.md` with its floor import, the `SessionStart` boot map, the state file and the frontier.

## 4. The common floor and heritage, carried once

- **The floor and the disciplines** are plan Ek A §2 (nine floor behaviours) and Ek D §2 (the common rules, with the D1–D9 trigger questions and their full texts in Ek D §3). They are DevOS scope and stay where they are.
  - **Delivery (R-R6, revision 3; R-W12-1 B4a):** `CLAUDE.md` imports both files whole with Claude Code's `@path` import. P-W12-2 showed that the import resolves in a builder-created session and reaches custom and built-in subagents without a tool read (observed once, on a probe branch). The documentation says that the built-in Explore and Plan subagents do not receive `CLAUDE.md`, so builder roles use custom agents.
  - **Cost:** the import loads 79,327 bytes (F-6), including the 18 DevOS role contracts that do not apply to the builder. Its token cost is measured in the first session after the import lands, from `get_session`'s `used_tokens` (filled after the first turns, F-042-2 correction in §6), with the transcript file's growth as a second method. The measurement is recorded with its method.
  - **Narrowing:** the target is a §2-only import, after W-C00-06 re-cuts Ek A and Ek D so that §2 is a file of its own. That is a plan-change candidate attached to W-C00-06.
  - **Rejected alternative:** the reading gate of revision 2 (D-12) is withdrawn. Hooks fire in the parent's session, so the producer's own read would satisfy the gate for every subagent, and the gate costs the same context.
- **The trigger** is Ek D §2 §3's: the nine questions at every new request, task or turn, and after every material change, including proposals made in conversation (acceptance (k) extension). It supersedes the operating model's narrower §10 trigger. Mechanical moments carry it where they exist (R-R8, R-R10). Pure conversation stays instructed and is tested by T-R8.
- **Failure patterns as heritage** (R-R7; R-W12-1 B4b). `plan/builder/heritage/FAILURE_PATTERNS.md` holds one entry per pattern: the lens, the question to ask, the source log entries, the status (`candidate` or `qualified`), and `qualified_by`. The qualifier is never the producer of the entry.
  - The first entries are RUN_BRIEF §5's ten patterns, plus F-036-1, F-037-1, F-037-2, F-039-1, F-040-1, F-041-1, F-041-2, F-042-1, F-042-2 and F-042-3.
  - Tranche 1's session review is asked to qualify or reject each one. Until then, the boot map prints all of them, labelled as candidates. So sessions see the known failure patterns at boot from tranche 1 on (acceptance (j)).
- **Library heritage beyond failure patterns:** each role definition carries its knowledge map. The Researcher does heavy reading, so that the Producer's context stays free for production.

## 5. Proportionality: impact class and the Triager

Acceptance (i): depth and effort scale with the work, the thinking standard does not. Whether an item is small, and which expertise it needs, is decided by a short triage from the expertise's view, not by the producer.
- **The floor of the verifier level is computed, not judged** (W-R7, the impact class). A PR or item of class high needs a session verifier. A normal item needs a subagent verifier. A routine record PR needs only the deterministic checks of the stop check.
- **The Triager is called for items the computed class does not already mark high** (R-W12-1 §3). It sees the item, its place in the tree, the floor, and the list of available expertises: the role definitions and the library's catalogue. It returns:
  - the depth (small, normal or heavy);
  - the expertises the item touches, and how far each needs to be involved ("not needed" is a valid answer after looking);
  - whether the level must be raised;
  - the risks that would change the depth.
- Small items still get the floor and the trigger. They get fewer roles and less evidence, not a lower standard (Ek A §2 item 8).

## 6. Stamina: quality within a long session

Acceptance (k) asks for a mechanism against loss of quality within a long session, with its own test. The evidence that it is needed comes from these runs: four estimated values in the first hour of one run (F-037-2), and a stamp one minute ahead in the last checkpoint of another (L-041).

1. **Make the decaying rules mechanical.** Where a rule can be checked, it is. Piece 1 has typed times, kinds, views, chain and claims; piece 2 has acceptance, impact and composition. A tired session then fails a check instead of merging an error. This is the main mechanism.
2. **Re-ground after compaction.** The `SessionStart` boot map also runs for the `compact` source (piece 1 §4), which is documented but unobserved, so the arrow is typed **I until observed** (R-W12-2 M-5). The operating model's instructed "re-boot after compaction" carries it. T-M17 (c) records the first compaction that occurs, and T-R16 checks that the session's first actions after it re-run boot steps 2–5; both are listed as unobserved, not passed, until then.
3. **Hand over on a quality signal, not only on size.** The context fraction **is** measurable from inside the run, with one caveat. `get_session` reported `used_tokens` 0 at this run's boot (18:22Z) and in L-040, but 381,684 of 1,000,000 at 18:57Z in this run. So the field reads 0 early in a session and is filled later; L-039's 464k reading by the parent is consistent with this. Revision 3's first text said the fraction could not be measured, a generalisation from early readings (finding F-042-2's class), corrected here. S4's 50% is therefore checked against `used_tokens` at every checkpoint, with a 0 reading treated as unknown, never as empty. The other signals stay:
   - the session's transcript file size at each checkpoint, recorded as a second proxy;
   - a natural boundary;
   - the hard trigger: two mechanical-check failures of the same class in one session, or one that reached `main`, ends the run at the next checkpoint with a hand-over. This trigger is mechanical: `builder_check.sh` appends the class of every FAIL of a quality class it prints (not `tree`, `ahead`, `fetch` or `usage`, which say where the run is, not what it did wrong) to a per-session file under `$(git rev-parse --git-dir)/builder_check_fails/`, which no `git add` reaches and which does not survive a fresh clone (corrected in tranche 1c, N-053 (c), R-W12-4 m-3), prints `HAND-OVER DUE (R-R9)` at the second failure of one class, and from then on accepts only the stop reason S4 (found by the gate check of revision 3: stamina had no test that a tranche gate could run). A FAIL counts only when the check runs on a committed head that is pushed (`HEAD` equals its remote branch), that is, at a checkpoint; a failure on an uncommitted tree is the check catching an error before merge, not a loss of quality (R-W12-2 M-4). The false-trigger rate in the tranche-1 runs is recorded at the composition review.
4. **Verify late work as hard as early work.** The stage-closure review samples items from the last third of each long run.

## 7. Rules

Status and tranche as in piece 1 §7. Every active rule has a test in `11_test_register.md`.

| ID | Rule | Status | Tranche | Scope | Test |
|---|---|---|---|---|---|
| R-R1 | *No producer acceptance (role statement).* | retired | — | — | merged into W-R1, which is the one mechanical rule |
| R-R2 | *Independence is labelled.* | retired | — | — | merged into W-R1 (one check); T-R11 tests it there |
| R-R3 | **Verifier level.** The floor is the impact class (W-R7). The Triager may raise it, never lower it; lowering needs a second Triager call with the reason, both recorded. | active | 1 | installation | T-R4, T-W9 |
| R-R3a | **Verifier tasks name failure classes and the exact target.** A verification task lists the claims to test, the failure classes a red result must be able to catch, and the commit SHA. Verification, review and adversarial challenge are kept apart in the task text (`multi-agent-patterns`). For a verifier session started with a verifier brief this is mechanical: `records.py brief <ID> --role verifier` refuses to generate without `target_sha` and `failure_classes` (W-R5; R-W12-2 M-6). The lease holder could still start a session with a run brief instead; that misuse is instructed, and the session Verifier of each tranche reads the first message of every verifier session (critic of `13`, finding 9). | active | 1 | installation | T-R1, T-R22 |
| R-R4 | **No role before its demand.** A new builder role follows a reduced Ek A §6 protocol: demand recorded, contract, environment, a planted test, a review of the definition (high impact), and retirement when unused. | active | 1 | installation | T-R7 |
| R-R5 | **Triage before depth.** The work check fails on an item of class normal whose `execution` is `running` or later without a `triage:` record, so triage decides the depth before work, not at acceptance (critic finding 10). | active | 1 | installation | T-R4 |
| R-R6 | **Floor import** (§4): `CLAUDE.md` imports Ek A and Ek D whole; the token cost is measured and recorded. | active | 1 | DevOS text, installation delivery | T-R5 |
| R-R7 | **Failure patterns at boot, candidates labelled; qualified only by someone other than the producer** (§4). | active | 1 | installation; candidate for DevOS learning records (C10) | T-R12 |
| R-R8 | **Trigger scope** (§4): Ek D §2 §3, including conversation; mechanical moments where they exist. | active | 1 | DevOS (already) | T-R8 |
| R-R9 | **Stamina measures** (§6): the checks; re-ground after compaction (instructed until a compaction is observed); hand-over on a quality signal counted at checkpoints; late-work sampling at closure. | active | 1 | installation | T-R20, T-R6, T-R16 |
| R-R10 | **Decision-record format** (D-30). Records for major decisions and proposals to Batu carry: premises with the from-scratch test, at least one alternative frame, `chosen_because`, `reopen_if`, and the consulted and left-out sources with their status. A `class: batu` record needs an owner reason from the Appendix E list. A `major-design` item requires a counter-design in its route. A frame review is an `FR-nn` record of this format. `check_records.py decisions` checks presence, not content. | active | 1 | installation | T-R9 |
| R-R11 | *Lenses on the item card, with lens dispositions at finish; built last and kept only if the counter-design's T-07 passes (D-10).* | deferred | 3 | installation | T-07 |
| R-R12 | *Reading gate (D-12).* | retired | — | — | withdrawn by R-W12-1 B4a; superseded by R-R6 |
| R-R13 | *Role profiles in the hook, selected by the spawner's role line (D-13).* | deferred | 2 | installation | T-R13 (written when re-admitted) |
| R-R14 | *Squeeze block: the third patch of one mechanism since the last frame review is refused until an `FR-nn` record exists (D-17).* | deferred | 2 | installation | T-18 (adopted when re-admitted) |
| R-R15 | *Sampling of routine record PRs by head hash, k = 5, and k = 2 after a material sample finding (D-06 sampling).* | deferred | 2 | installation | T-R14 (written when re-admitted) |
| R-R16 | **Critic admitted** (§2). It is called before a session Verifier on design artefacts; its findings are answered in the artefact and labelled non-binding. | active | 1 | installation | T-R7, T-R21 |
| R-R17 | **Batu's conversation session writes records only under the lease** (§2). | active | 1 | installation | T-R10 |
| R-R18 | *Boot gate: no write, push or `create_session` before `tools/boot` has written a receipt (D-01). When re-admitted it ships with the break-glass path of R-W12-1 M1 and a crash test.* | deferred | 2 | installation | T-01 (adopted when re-admitted) |
| R-R19 | *Compaction gate (D-02).* | deferred | 2 | installation | T-02 (adopted when re-admitted) |
| R-R20 | *Transcript-size warning (D-05).* | deferred | 2 (or 1, if P-W12-3 observes its carrier) | installation | T-R15 (written when re-admitted) |
| R-R21 | **A refusal is S3 for that action, never routed around.** This extends operating model §11 from classifier denials to any refusal: hook blocks, git-proxy refusals (the L-031 `git push --delete` 403, worked around by a force-move), API errors that deny an action. The action and its goal stop; a different action that does not serve the refused goal may continue; the refusal is logged verbatim. It enters the operating model in tranche 1c. | active | 1 | installation | T-R18 |

**Deferral decisions that the K3 re-read weakened, stated for the re-review.** Revision 2 deferred R-R13 because no spawned session had acted beyond its role. The K3 re-read found one that did: the dispatcher's hand edit of `owned_ids.txt` and its false report (L-033). Revision 3 still defers role profiles, for three reasons, and the reviewer is asked to judge them:
1. That actor is retired (C-R7).
2. The file it edited by hand now merges by union (M-R10), and the recorder covers every creation path (M-R11), so the act has no remaining purpose.
3. Profiles need the role read from the first message through `transcript_path`, a mechanism that is unobserved.

The re-admission trigger is therefore a breach by a **remaining** spawned role (Verifier, Counter-designer, Probe, Critic, Triager, Researcher). Likewise, R-R15's sampling (D-06) and verifier-frozen criteria (D-31) were deferred on "no incident". The K3 re-read shows producer-side acceptance changes (piece 2 §1). These are now caught by W-R7's field class, which makes any acceptance-block change high and session-verified, so D-31 stays deferred on that basis, not on "no incident".

## 8. Scope and hand-over

| Mechanism | Scope | Replaced by | Trigger |
|---|---|---|---|
| Builder roles and definitions | installation | DevOS's starting role set (plan §7.4: DR01, DR02, DR06, DR08, DR13, DR16, DR05), with exams (C05) | C05 acceptance |
| Verifier sessions | installation | the audit environment (C03) for binding verdicts | C03 acceptance |
| Floor by reference, trigger | DevOS (already) | `CLAUDE.md` common rules at C05 | C05 |
| Failure-pattern heritage | installation; candidate for DevOS learning records | learning records and the method library | C10 |
| Triager | installation; DevOS's equivalent is the expert assessment of Ek A §2 item 8 and the effort policy (Ek B §3.18) | EffortPolicy | C05–C06 |

## 9. Decision-and-basis record

- **Consulted:**
  - plan Ek A §2, §3, §5, §6 and Ek D §2 (status: Turkish plan, DevOS scope);
  - plan §7.4;
  - Batu's Original texts on terminal goals, scale and expertise, the common floor, intellectual heritage and work discovery;
  - P-W12-1 and P-W12-2 (observed once each);
  - library `multi-agent-patterns/SOUL-DEVELOPMENT-OS-ASSESSMENT.md` §8 and §§12–13 (status: exploratory systems assessment). It is used for the separation of review, verification and adversarial challenge; critic quality stated by failure classes; and risks R1, R4, R6 and R7. Its conversation synthesis, opened in revision 3 by a Researcher subagent, adds the verifier-independence ladder (self-critique, separate context, different model, deterministic check), none of which is trustworthy by default.
  - For revision 3: R-W12-1 B4, B6, M6, m1 and m2; the K3 re-read (spawned-session breach L-033; context-measurement conflict L-039 against L-040; producer acceptance changes); the library's `context-memory-harness-engineering/03-HARNESS-ENGINEERING.md` (status: bounded research package complete, user evaluation pending). That study says each harness component encodes an assumption about what the model cannot do, and that those assumptions go stale, which supports deferring with triggers rather than building ahead.
- **Left out on purpose:** separate long-lived processes per role (Batu's terminal-goals text: "this does not mean multi-agent"); the plan's 18 DevOS roles for the builder (most have no builder work before C05); a second model family as verifier. The last stays a residual: the counter-design's §17.2 notes that sampling cannot fix a reviewer who shares the producer's frame, and BP-07 states the same. B2 is a DevOS decision at C11.
- **Premises, from scratch:** a role traced to work that occurred is needed (yes, for the eight listed); a whole-file import is acceptable until W-C00-06 (yes, if its measured cost leaves room for the work; reopen otherwise).
- **Alternative frames:** a per-role tool barrier now (deferred, §7); a reading gate (withdrawn, §4); no Triager, with the computed class only (rejected: acceptance (i) asks for the expertise's view, which a path list cannot give).
- **Reopen if:** the measured import cost exceeds about a tenth of the context; a remaining spawned role acts beyond its role; T-R2 or T-R5 fails.
