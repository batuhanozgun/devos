# Counter-design: the builder's working system during the installation (W-C00-12)

Written 2026-10-03 by an independent counter-design session, under `briefs/w-c00-12-counter-design/BRIEF.md`. The current builder design was not read. This is a candidate design for comparison (plan §6.12 item 3). It is not accepted and it binds no one.

---

## 0. How to read this document

- **Scope tags.** Every rule and mechanism carries one of three scopes: **[I]** applies during the installation only; **[D]** carries into DevOS; **[S]** is a requirement passed on to SOUL. Each one also names the file that would hold it.
- **Arrow types.** **M** is mechanical: a hook, script or CI check that runs whatever the model decides. **I** is instructed: written guidance the model is expected to follow. **J** is judged: an open reasoning step.
- **Status tags** follow the brief: *observed*, *documented*, *untested*, *own reasoning*, *library study* (with study id).
- **Main claim.** Ten incidents happened in three days, and most of them share one cause: **a step on a critical path was left to instruction, and the instruction did not fire**. The fix is not more instructions. It is to move a small number of critical-path steps into mechanics that already work on this platform (the `PreToolUse` hook, scripts and CI). Judgement stays where judgement is needed. The design is deliberately small: three hooks, seven scripts, one CI workflow and five role templates. Everything else is admitted only when a demonstrated demand appears.

### 0.1 Reading compliance (brief §1)

- **Read:**
  - the brief;
  - the "Original" sections of the 13 `BATU_*_TR.md` files, cut at the first "Builder's assessment" or "English interpretation" heading;
  - the plan and appendices A–G (B and C partly);
  - `Calisma_Duzeni_Karsilastirmali_Arastirma.md` and `Uyandirma_ve_Kapasite_Arastirmasi.md`;
  - the research library, read-only (§19);
  - Claude Code documentation, via a documentation sub-agent.
- **Not read:**
  - `plan/Builder_Operating_Model.md`, `plan/ledger.md`, `plan/ledger/`, `plan/builder/`, `evidence/`, `RUN_BRIEF.md`, `DURUM.md`, `tools/`, `.claude/`;
  - the "Batu'dan beklenenler" issue;
  - the two plan review evaluations (`Inceleme_Degerlendirmesi_*`), which are not on the allowed list.
- **Exposures I could not avoid, stated so they can be discounted:**
  1. The harness auto-loaded `CLAUDE.md` (the boot list and fixed rules).
  2. Plan §9 ("Kurucunun çalışma düzeni", PC-01, PC-02, PC-04) and Appendix F summarise the current operating model in six points: `/goal` runs, `main` as the source of truth, `tools/builder_check.sh`, one issue for Batu, review by separate sessions, and the `tool_allowlist.py` hook. These are in allowed files. I treated them as constraints and facts, not as a design to follow or to avoid.
  3. One command I ran contained `git log --oneline -1 | head -0`. It printed nothing.
  4. To create my branch I checked out `origin/main`, which was the same revision as the working tree (an empty diff, verified).
  5. I did **not** register the library clone as a session root, so that its `CLAUDE.md` and `AGENT.md` would not be loaded as instructions.

---

## 1. Premises

Each premise was put through the test "would we choose this from scratch today?".

| # | Premise | Origin | Valid? | From scratch? |
|---|---|---|---|---|
| P1 | The builder's real weakness is not reasoning capacity but that steps do not fire at the right moment. | Incidents 3–9 (brief §5); EXP-005, EXP-006 lessons (library) | Yes, for the observed failures | Yes |
| P2 | Hooks in the checked-out `.claude/settings.json` are enforced in every session that checks out `devos`, including spawned sessions. | Observed (brief §5); documented for single-repository cloud sessions | Yes, for `PreToolUse` and `PostToolUse`; `Stop` and `SessionStart` are untested | Yes, and it is the backbone |
| P3 | Instructions in `CLAUDE.md` are context, not enforcement. | Anthropic documentation (via `anthropic-ai-native-sdlc-playbook`); incident 6 | Yes | Yes |
| P4 | `main` is the only source of truth until C02. | Fixed constraint (brief §4) | Yes | Yes. A lease on a side branch would be faster (git compare-and-swap), but it would put an important fact off `main`. Rejected. |
| P5 | Producer and verifier must be separate role-instantiations; for binding acceptance, separate sessions. | Batu's terminal-goal text; plan K-4; `multi-agent-patterns` | Yes | Yes. During installation the separation is *declared*, not authority-enforced, until C03. |
| P6 | A standing dispatcher is needed for continuity. | The earlier design (incident 10) | **Not shown** | **No.** Self-armed wakes plus an alert-only watchdog first; a keeper is admitted only on a pre-registered trigger (§10). |
| P7 | One session can carry an entire stage. | Implicit in long `/goal` runs | **Doubtful.** Compaction dropped steps (incident 6); context decay is documented in the library | No. Bounded runs with recorded hand-over. |
| P8 | Batu reads the issue on his phone and answers there. | Observed once | Yes | Yes, and it stays the only Batu surface. |
| P9 | Facts restated in several files will drift. | Incident 5; `gstack` qualifier-loss failure class | Yes | Yes: one home per fact, everything else generated. |
| P10 | Research is used only when activated by the situation, not when it merely exists. | Batu's heritage and context-activation texts; EXP-002 L07; Foundation STATE correction | Yes | Yes: context is pushed at item start, not pulled on request. |
| P11 | The builder's file records are temporary and move to the database at C02. | Plan §9 ledger transfer | Yes | Yes: the record fields mirror Appendix B families, so the transfer is mechanical. |
| P12 | The usage status (normal, warning, limit) and reset time are readable only through `get_session`, an MCP tool, and not from scripts. | Observed (brief §5); the documentation says nothing | Yes | Yes. The value must be copied by the model, and that copy is audited (§10). |

---

## 2. Diagnosis: from incidents to design commitments

| Incident (brief §5) | Underlying class | Commitment |
|---|---|---|
| 1. Stopped after every step; work stayed on a branch; Batu carried messages; technical question to Batu; rules added one at a time | Stopping, merging and routing were instructed; growth was additive | C1 a mechanical stop check; C6 the squeeze signal |
| 2. Seven review rounds answered finding by finding | No trigger to question the frame | C6 a frame review is forced on the 2nd patch to the same mechanism |
| 3. Claimed done or verified before checking; recorded another session's claim unread | Claims not bound to resolvable evidence | C3 an evidence-binding gate; cite-only-what-you-read receipts |
| 4. The producer judged its own change "status-only" | The producer classified its own review need | C4 impact class computed from paths; review sampling the producer cannot steer |
| 5. Restated facts went stale; Batu's answer unrecorded for a day | Several homes per fact; no unrecorded-input check | C2 one home per fact plus generated views; a mechanical check for unrecorded answers |
| 6. Re-read after compaction never fired; disciplines and library not applied at proposal time | Critical steps instructed at the wrong moment | C1 a boot gate and a compaction gate in the hook; C5 item cards push lenses and trigger questions |
| 7. Built on a delivery path that the builder's own hook blocked | No probe before building on an untested behaviour | C7 untested platform behaviour blocks dependent items until a probe passes |
| 8. `send_later` IDs not recorded; spawned sessions got no lessons | No coverage check when a capability is added | C8 an ownership receipt hook; a brief-formation gate on `create_session`; a coverage matrix |
| 9. Timestamps estimated | Hand-written times | C3 timestamps come only from the clock or commits; CI checks them |
| 10. Dispatcher created before there was work for it | Mechanisms admitted without demand | C6 an admission rule: a demonstrated demand, a removal test and a sunset |

Commitments C1–C8 are carried by the mechanisms in §15.

---

## 3. Q1: goal-down prerequisites by stage

| Stage | What the stage needs from the builder's working system | Where a DevOS component takes over |
|---|---|---|
| C00 | Faithful translation with an independent fidelity review; counter-design sessions with restricted views; premise inventory; ECC comparison. Needs: the reviewer and counter-designer roles; restricted briefs; reviewer verdicts captured into `main` faithfully (§8.3). | — |
| C01 | Platform probes in fresh sessions; evidence envelopes; step lists for Batu (routines, tokens); usage observation. Needs: the probe role; "documented / observed / untested" tagging on every platform fact; the C7 rule that untested behaviour blocks dependants. | — |
| C02 | Schema through migrations; ledger transfer. **The builder cannot apply migrations, because its Supabase connection is read-only.** Needs: a deployment path that does not put a write key in the builder (critical uncertainty U6); builder records shaped like Appendix B so the transfer is mechanical (P11). | Builder work state, decisions and log move to the database. `state/` becomes a view. |
| C03 | Negative tests of trust boundaries; audit environment. Needs: the builder's own barrier (§12) tested as one of the effect channels. | **The reviewer role moves into `devos-denetim`, authenticated by environment token.** Declared independence becomes authority independence. The repository hook becomes the second layer. |
| C04 | Library ingestion; search; context package. | Lens cards (§6) are re-anchored to `Source` IDs. Builder heritage lookup goes through `search` and `read_source`, not direct repository reads. |
| C05 | Common rules, roles, exams. `CLAUDE.md` is replaced by Appendix D (the plan says this). | Builder role templates (§5) are compared with DR roles. Builder lenses become the first `Learning` records. The item card becomes the first `session_brief` instance. |
| C06 | Working order, decision channel, routines created by Batu. | The builder's issue channel gives way to DevOS's decision channel. Builder wakes give way to routines. |
| C07 | Cognitive gate. **The builder must not do the team's discovery work or give it hints.** Needs: a "hands-off" mode in which builder items only observe and record (plan Appendix C, C5 hint ban). | — |
| C08–C09 | Publishing; recovery drills. | The recovery drill also exercises builder-state recovery from `main` and the database. |
| C10 | Learning; mechanism assumption inventory. | The builder's mechanism register (§15) becomes the first `MechanismAssumption` rows, with their removal tests. |
| C11 | Seven days unattended. **The builder must not be what keeps DevOS alive.** | All builder wakes are disabled before C11 starts. |
| C12 | Hand-over; the builder environment is closed. | Every [I] mechanism is retired by its sunset clause. |

**Critical uncertainties that could change this design** (each has a probe in §14):

| ID | Uncertainty | If false |
|---|---|---|
| U1 | A `send_later` wake reaches an idle builder session; the session can read it under its own hook and act. Observed: delivery is a queued notification readable only with the notifications tool. | A keeper session bound to a routine is admitted at once (§10). |
| U2 | `Stop` and `SessionStart` hooks run in cloud sessions. `PostToolUse` can inject `additionalContext`. Docs: hooks from `.claude/settings.json` load in single-repository cloud sessions; event-level behaviour not documented. | The stop gate falls back to `stopcheck` plus `/goal`, and the compaction gate falls back to `PreToolUse` deny-with-reason (§8.2). Both fallbacks use the hook type already observed to work. |
| U3 | Repository skills (`.claude/skills/`) and agents (`.claude/agents/`) load in cloud. The docs sub-agent reported that project agents do not load in cloud, but that reasoning is doubtful because the repository is cloned. Untested. | Nothing in this design depends on them: role formation is carried by `tools/brief` text and the reading gate. Skills would be an optional convenience. |
| U4 | Capacity: two reviewers in parallel plus the builder, inside Max shared with Batu. | Review sampling rates and run bounds change, not the structure. |
| U5 | Required status checks can be enforced on `main` for this public repository, and they cover administrators. | Without them, every CI check in §8.3 is advisory, and the design loses its main non-hook enforcement point. **This is the most important prerequisite to confirm.** |
| U6 | C02 migrations can be applied by a deployer that holds a key the builder never sees (for example a GitHub Actions job with a secret Batu enters). | C02 design changes. Batu would be asked a money or account question only if no free path exists. |
| U7 | The permission classifier denies a merge by a session that did not open the PR (observed). | This is why reviewers never open PRs (§8.3). |
| U8 | Routine limits. The brief records 15 per day as documented and observed; the docs sub-agent read "100 per hour per account" today. The sources conflict. | Affects only the optional keeper; resolved by probe P-08. |

---

## 4. Q2: work discovery and the living work list

### 4.1 Objects and states [D] (`system/WORK_MODEL.md`)

- **Intent.** Purpose statements by Batu (plan §1, decisions). These are never work.
- **Need.** A condition that must become true for a parent goal. It carries `why_needed`: what decision or action would be wrong without it (plan K-1 brake). Origin is one of three: the goal, the chosen method, or merely useful. A need is not a task.
- **Work item.** One record per item, `work/<id>.md`, with YAML front matter. Stored lifecycle values:

| Value | Meaning | Who sets it |
|---|---|---|
| `candidate` | Discovered or proposed; not decided | Anyone (builder, reviewer note, probe finding) |
| `admitted` | Decided to be done, with the parent and a reason | The plan level's owner: the builder for items inside an accepted stage plan; a plan change (§4.5) for anything outside it |
| `executing` | Claimed by the run that holds the lease | `tools/rec start` |
| `finished` | The producer claims it is done; evidence references attached | `tools/rec finish`, refused without resolvable evidence (C3) |
| `accepted` | The named acceptance route passed | CI only, from a deterministic check result or a reviewer verdict bound to the commit |
| `dropped` / `superseded` | No longer needed, with the reason and the replacing item | The builder, through a typed record change |

- **Ready is never stored.** It is computed by `tools/frontier` as the conjunction of:
  - the item is admitted;
  - every `needs:` item is `accepted` (not merely `finished`);
  - every `assumes:` with `check_by` is satisfied;
  - no open blocking question;
  - every `platform:` dependency is `observed` (C7);
  - the item's work class is allowed at the current usage status;
  - no other executing item writes the same artefact (the single-writer rule).

  `tools/frontier` prints the ready set **and, for every non-ready admitted item, why it is not ready**. An empty frontier is diagnosed, never silent. The Beads and Gas Town lessons apply here: an empty frontier can mean waiting, done, an external condition, claimed by another run, or a cycle.
- **Selected ≠ executing ≠ finished ≠ accepted.** These are recorded separately (`work-management-project-control` lists seven layers of "done").

### 4.2 Dependencies, assumptions, staleness [D]

- **Edges are typed.**
  - `needs:` is hard: it affects readiness.
  - `informs:` is soft: it is shown on the item card.
  - `from:` is provenance only, for discovered-from.

  Only `needs:` enters the readiness computation and cycle detection, as in Beads, where the relation type and its effect on readiness are separate properties.
- **Basis hashes.** At admission each item records `basis:` as a list of record paths, each with its git blob hash (for example the plan section, decision or probe result it relies on). `tools/frontier` compares the hashes with `main`. A changed basis marks the item **stale: recheck**, and it is not ready until it is rechecked. This is cheap and mechanical, and it answers "freshness against the object, not the clock" (`gstack`).
- **Assumptions** are explicit entries: `assumes: [{text, check_by: <item or probe id>, if_false: <effect>}]`.

### 4.3 Zoom [D]

- **Hierarchical IDs:** `C03`, `C03.2`, `C03.2.1`. All 13 stages exist as top-level items from the plan, which gives the horizontal view.
- **Decomposition depth rule** (CI warning; a failure if it goes deeper than one level beyond the active branch): an item may be decomposed only if it or its parent is `executing` or `ready`. Detailing far branches early fixes today's uncertainty into the plan (Batu's living-plan text; Spec Kit admits per-session slices).
- **`work/TREE.md` is generated** by `tools/render`: it shows the whole tree to depth 1, the active branch fully expanded, and stale or blocked markers.

### 4.4 Open notes attached to their branch [D]

A note is a field on the item it concerns:

```
notes: [{kind: check-when-started | risk | question | idea, text, from: <item>, at: <commit>}]
```

`tools/card` prints the notes of the item and all its ancestors when work starts. A thought that comes up during item X about item Y is written to Y with `tools/rec note Y ...`, never to a general memory file.

### 4.5 Composition checks and plan changes [D]

- **Composition.** Every parent has an implicit acceptance requirement: a **composition verdict** on the parent itself, stating that the children together achieve the parent's goal. CI refuses `accepted` on a parent without one, even when every child is `accepted`. Batu's living-plan text says children all green does not make the parent done.
- **Plan changes.** Discovered work that is not covered by the accepted plan, or that contradicts it, becomes a `PC-` record with status `candidate`. The record holds:
  - the old text;
  - the new text;
  - the reason;
  - the affected stages;
  - a classification by the owner question: is it Batu's (purpose, scope, money, accounts) or technical?

  A technical PC is accepted by reviewer verdict (PC-05). A Batu-class PC goes to the decision batch (§11). Reuse the plan's §14 rule unchanged.

### 4.6 "Startable now"

Startable now means exactly the output of `tools/frontier`. A session finds it by running `tools/boot`, which calls `frontier`. The run picks from the ready set using this rule: critical path first (items whose dependants are many or whose stage gate depends on them); heavy items preferably 23:00–08:00 Turkey time (Batu's recorded policy). The run records one sentence on why it picked the item. That choice is **J** (judged), and the reviewer samples it at stage closure.

---

## 5. Q3: roles and terminal goals

**Rule [D]** (`system/roles/README.md`): no role exists before its work. Each role below is traced to a work demand that already happened or is certain in the plan.

| Role | Work demand (evidence) | Terminal goal (one) | Carrier | May accept |
|---|---|---|---|---|
| **Run** (builder, producer) | All installation work | Produce the current stage's admitted items to the point where their named acceptance route passes. | A cloud session holding the lease | Nothing of its own. May accept a *reviewer's* findings as items to fix. |
| **Reviewer** (verifier) | High-impact changes (PC-05), stage closure, translation fidelity (C00), samples | Find out whether the stated claim about this exact commit is false; return a verdict with evidence. "Not finished" and "found nothing" are both legitimate. | A separate session, created with `tools/brief reviewer` | Items whose acceptance route names a reviewer; composition verdicts |
| **Counter-designer** | Major design decisions (plan §6.12; this document) | Produce the best design from goal and constraints without seeing the incumbent. | A separate session with a restricted brief | Nothing; its output is compared, not accepted |
| **Probe** | Untested platform behaviour (C01; C7 rule; incidents 7 and 8) | Observe and report what the platform actually does for one stated behaviour; never interpret a failure as success. | A fresh session when the behaviour depends on session start, hooks or spawning; otherwise a sub-agent | Nothing. Its observation becomes evidence that a reviewer or a deterministic check accepts. |
| **Researcher** | Questions needing library or web evidence (D9; K-2) | Answer the bounded question with source-bound evidence, including counter-evidence and qualifiers. | A sub-agent of the run; this is thinking independence only | Nothing |
| *Deterministic checks* | Structural claims | Not a role: hooks, `tools/*`, CI | — | Items whose acceptance route is `check:<name>` |

- **Not created:**
  - a dispatcher or keeper, until trigger K1 (§10);
  - a separate planner, because the living plan is the run's work and plan changes are reviewed;
  - the 18 DevOS roles, which belong to C05 and not to the builder.
- **Acceptance never belongs to the producer.** Every item carries `acceptance: check:<name> | review:<kind> | review:sample`. The value is set at admission, and CI enforces it. The producer cannot lower it below the impact-class minimum (§9).
- **A task given to a role carries its context.** `tools/card <item>` prints:
  - the goal chain up to the stage and the SOUL purpose;
  - the parent, with the parent's goal;
  - the siblings and their status;
  - the downstream (`needs:` reverse edges) with one line each on what they expect;
  - the notes;
  - the basis and its staleness;
  - the acceptance route;
  - matching lenses (§6).

  `tools/brief <role> <item>` wraps the card for a spawned session. This is the "narrow position, wide view of the game" from Batu's football-card text, made mechanical.

---

## 6. Q4: actor formation and heritage

### 6.1 A role is an environment, assembled by a script [D]

`tools/brief <role> <item>` produces the first message of a spawned session from five parts:

1. `system/roles/<role>.md`, a short template (about one page): terminal goal; what the role must and must not see; method; output contract; known failure patterns for this role; how its output is accepted.
2. **The common floor by reference.** The required reading is `plan/Ek_A_Rol_Sozlesmeleri.md` §2 and `plan/Ek_D_Dusunme_Protokolleri.md` §2, plus D1–D9 as their triggers apply (the English paths after C00 step 0, resolved through `system/registry.md`). It is not copied.
3. The item card (§5).
4. Matching **lenses** (§6.2).
5. A brief identifier line, `BRIEF-ID: <sha256 of the assembled text>`, plus the role marker.

Two mechanisms carry this. Both are **M**, in the existing `PreToolUse` hook:

- **The brief-formation gate.** `create_session` is denied unless its prompt contains a `BRIEF-ID` that `tools/brief` recorded in `state/briefs.log` during this session. This answers incident 8: no spawned session receives a bare task.
- **The required-reading gate.** In the spawned session, the hook knows the role from the role marker in the first user message (it reads the transcript path that hooks receive). It denies the role's *output* actions until the session's own `PostToolUse` receipt log shows `Read` calls on every required-reading path:
  - for a reviewer, writing under `reviews/` or `git push`;
  - for a run, any write.

  This is declared, not secure, because a session could fake the marker. Its purpose is to stop *omission*, which is the observed failure, not malice.

### 6.2 Heritage: from research to a lens the role uses unasked [D, with S requirement]

Batu's heritage text names the chain: research evidence → qualified finding → reusable lens → actor formation → runtime reasoning. The builder version:

- **A lens card** is `heritage/lenses/L-<n>.md`. It is DevOS's own synthesis, in a few lines of its own words, never library text (public-repository rule). It holds:
  - **kind:** `question`, `failure-mode`, `distinction` or `rule`. A `rule` requires an attached test.
  - **tags:** topics, for example `verification`, `memory`, `continuity`, `security`, `planning`, `platform`.
  - **roles:** which roles it applies to.
  - **sources:** library study IDs and paths, or documentation URLs with dates. This is the route back to the original source for critical judgement, as Batu's text requires.
  - **status:** `candidate`, `qualified`, `retired` or `superseded`.
- **Lens cards and item cards share one tag vocabulary.** The vocabulary is fixed in `heritage/TAGS.md`; CI rejects unknown tags.
- **Activation is mechanical.** `tools/card` prints every `qualified` lens whose tags intersect the item's tags, listing `failure-mode` and `question` lenses first. Candidates are never printed, which keeps them apart from accepted heritage. "The research comes to the actor" (Batu's Actor B) replaces "the actor remembers to go and look" (Actor A). Whether the actor then *uses* the lens is judged, and is measured as follows.
- **Use is recorded.** `tools/rec finish` requires `lenses:` with one disposition per printed lens: `changed`, `limited`, `justified`, `not-applicable`, each with a reason. This is a format gate (plan §8 item 12). A reviewer samples whether the dispositions are true. It is the builder-scale version of the plan's `UseReceipt` and "changed a decision" metric (K-6).
- **Qualification** promotes a lens from `candidate` to `qualified`. It needs a reviewer verdict on three questions:
  1. Does the source actually support it? (The reviewer opens the source.)
  2. Is it applicable outside its original setting?
  3. Is it a lens (a question) or a rule (it needs a test)?

  This keeps a single event from becoming a rule (the `PxuMqeIqCEo` memory dossier; Batu: "her araştırma otomatik olarak mirasa dönüşmemeli").
- **Seed set (proposed; candidates until qualified).** Drawn from this design pass, in own words:
  - completion, evidence of completion and acceptance are different events;
  - "ready" is derived, not a label;
  - a verdict binds to an exact revision;
  - a fresh session is not an independent verifier when it shares the brief and criteria;
  - an enforcement point is narrower than the effect it should govern;
  - a payload that crosses a boundary loses its qualifier;
  - a stored lesson is not a changed behaviour;
  - "who decided the expert is not needed?" (Batu);
  - an empty frontier needs a diagnosis;
  - a rule found under the wrong path never loads, and stronger wording does not fix it;
  - a check that exits 0 after matching zero files verified nothing.
- **Seeds go through the [I] → [D] → [S] chain.** After C04 the lens sources are re-anchored to `Source` IDs. At C05 lenses become `Learning` records and role knowledge maps. The SOUL requirement [S] is that every actor SOUL forms receives its role's qualified lenses by activation, not by access (plan criterion 33).

### 6.3 Quality over a long session (stamina) [I, then D]

- **Bounded runs.** A run ends at a checkpoint after a bounded amount of work. The default is three items or one high-impact item, adjustable by measurement. A fresh successor continues, because a reset with a structured hand-over is more reliable than a long session (Anthropic's long-running harness work, cited in the plan's comparative study).
- **Transcript-size warning (M).** The `PostToolUse` hook can see the transcript file size. Above a threshold it adds a warning: "finish the current item, checkpoint, hand over". This approximates context pressure without needing a context meter.
- **The floor at the moment of action.** `tools/card` ends with the nine D1–D9 trigger questions, one line each, *at item start*. This is when proposals are formed (incident 6). It replaces a one-time reading at session start.
- **Sampling.** Low-impact items are sampled for review (§9). This also catches quality decay that no structural check sees.

---

## 7. Q5: memory lifecycle

### 7.1 One authoritative home per fact [I, mirrored in the D schema]

| Fact type | Home (only one) | Generated views |
|---|---|---|
| What to build, and why | `plan/` (PC-changed only) | — |
| Work items, status, dependencies, notes | `work/<id>.md` | `work/TREE.md`, the frontier output, `DURUM.md` sections |
| Decisions (Batu's and technical), with reasons, conditions and reopen conditions | `decisions/D-<n>.md` (Batu's Turkish words verbatim plus the English interpretation, plan §0.6) | The issue's decision list |
| Current run, lease, usage status, answers cursor, armed wakes, owned IDs | `state/run.yaml` (the only mutable "now" file) | The boot digest, `DURUM.md` header |
| What happened | `log/<stage>.md`, append-only, lines written only by `tools/rec` | Stage digest, generated at stage close |
| Verdicts | `reviews/<item>/<commit>.md`, byte-identical to the reviewer's own commit | — |
| Lenses | `heritage/lenses/L-<n>.md` | Item card sections |
| Mechanisms, impact classes, roles, registry | `system/` | The mechanism map view |
| Evidence | `evidence/` (safe summaries and identifiers only) | — |

- **Batu's status pages are generated.** `DURUM.md` and the status header of the single issue are both produced by `tools/render` from the homes above, using a Turkish template and a `summary_tr` field kept on the stage record. No status sentence is hand-written in two places.
- **Restatement checks (M, CI).**
  - **(a) Transclusion markers.** A file that needs a canonical fact (current stage, binding status of a document, open Batu items) embeds it as `<!--fact:key-->value<!--/fact-->`. CI fails if the value differs from the home.
  - **(b) Pattern warning.** Phrases such as "binding", "current stage", "next action", "bağlayıcı" outside `system/registry.md`'s list of allowed homes raise a warning. A reviewer sample decides on them.

  Unmarked prose restatements cannot be found completely by machine; that limit is stated in §18.

### 7.2 Typed record changes [D] (CI check `record-change`)

A commit that changes an authoritative record must carry, per record, the trailer `Record-Change: <type> <record-id> [-> <new-id>]`. Types:

- **`add`** — a new record.
- **`correct`** — the old content was wrong. Requires `Was-Wrong-Because:`.
- **`supersede`** — the old content was right then and is replaced now. Requires `superseded_by` in the old record and `supersedes` in the new one. The old record stays.
- **`retire`** — no longer applicable; the status changes and nothing is deleted.
- **`annotate`** — adds a note or link without changing meaning.

This applies to decisions, lenses, premises, mechanisms and plan changes, where a superseded fact read as current misleads (Batu's red/blue example). Work items use their lifecycle instead.

`correct` and `supersede` on a decision trigger a mechanical **impact listing**: `tools/frontier` lists the items whose `basis:` includes that record. Those items become stale (§4.2). This is the "memory update is a change-impact problem" point from Batu's memory text, at file scale.

### 7.3 The chain from the root, and its check (M)

- **Root.** `CLAUDE.md` (always loaded) contains the fixed rules and one instruction: the first action is `tools/boot`. It points to `system/registry.md`.
- **Registry.** `system/registry.md` lists every authoritative record class: path pattern, home of what, who writes it, which tool reads it, and when.
- **CI check `chain`:**
  - every file under the authoritative directories matches a registry pattern (no orphans);
  - every registry pattern matches at least one file or is marked `empty-allowed`;
  - every internal link in the registry, roles, cards and `CLAUDE.md` resolves;
  - every tool named in the registry exists.
- **Boot repeats a subset of this check.** The chain is therefore verified both at merge time and at the moment of use.

### 7.4 Recovery and actual use by a fresh session

`tools/boot` performs these steps (all M):

1. Checks the lease in `state/run.yaml` and takes it or stops (§10).
2. Verifies hook integrity. The hashes of `.claude/settings.json` and `.claude/hooks/*` must equal the hashes recorded in `system/mechanisms.yaml` at their last reviewed merge.
3. Reads Batu's issue comments through the public GitHub REST API (`curl`, unauthenticated; reachability observed today). Comments by `batuhanozgun` newer than `answers_seen_through` are **unrecorded answers**. Boot prints them first, and `stopcheck` refuses to stop while any remain unrecorded. This answers incident 5c.
4. Prints the digest:
   - the purpose chain;
   - stage and stage goal;
   - frontier with not-ready reasons;
   - the active branch with notes;
   - decisions whose `conditions` or `reopen_if` mention active items;
   - pending Batu items;
   - usage policy;
   - the last run's hand-over note.
5. Writes `state/.boot-receipt` (gitignored: session id, commit, digest hash, compaction epoch).

The `PreToolUse` hook then denies all writes and session-creating calls until a receipt exists for the current session and compaction epoch (§8.2).

**"Actually uses them"** cannot be guaranteed mechanically. It is approximated in two ways:

- **(a)** The run's first `tools/rec start` must name the digest elements it relies on (`relies_on:`).
- **(b)** It is tested behaviourally with planted facts (T-05 and T-06, §14).

---

## 8. Q6: the mechanism map (the builder as a program)

### 8.1 Base steps of a run

| # | Step | Arrow type | Carrier |
|---|---|---|---|
| B1 | Session starts → boot | M (hook gate); first command instructed in `CLAUDE.md`, enforced by the gate | `gate.py`, `tools/boot` |
| B2 | Lease take or renew | M | `tools/boot`, `tools/rec lease` (merged to `main` through the PR path; a merge conflict on `state/run.yaml` acts as compare-and-swap) |
| B3 | Read frontier, select item | M (frontier) + J (selection) | `tools/frontier` |
| B4 | Start item: card printed, lenses pushed, D-questions shown | M | `tools/card`, `tools/rec start` |
| B5 | Work (reasoning, writing, sub-agents) | J | — |
| B6 | Producer self-check | I + J | role template |
| B7 | Finish: evidence references must resolve; lens dispositions | M (format gate) + J (content) | `tools/rec finish` |
| B8 | PR; CI computes impact class and required acceptance | M | `checks.yml` |
| B9 | Acceptance: deterministic check, or reviewer session (helper H1) | M routing + J verdict | CI, H1 |
| B10 | Merge to `main` (only when required checks pass) | M | branch protection (U5) |
| B11 | Record: log line, status, notes; views rendered | M | `tools/rec`, `tools/render` |
| B12 | Continue, or stop only when `stopcheck` allows | M | `tools/stopcheck`, `stop.py` or `/goal` |

### 8.2 Gates inside the existing hook [I] (`.claude/hooks/gate.py`)

One script; four additions to the existing allowlist:

1. **Boot gate.** No write, push or session/routine creation without a boot receipt for this session and epoch.
2. **Compaction gate.** On each call the hook checks the transcript for a newer compaction boundary than the receipt's epoch. If there is one, it denies with the reason "context was compacted: run `tools/boot --recover`".
   - The recover mode reprints the digest and the current item card.
   - It works even if `SessionStart(compact)` hooks never run in cloud (U2).
   - **Untested:** that the transcript exposes a detectable compaction marker. The fallback is the transcript-size jump heuristic. Probe P-03.
3. **Brief-formation gate** and **required-reading gate** (§6.1).
4. **Protected-path gate.** Deny `Edit` and `Write` on `.claude/**`, `system/impact.yaml`, `system/mechanisms.yaml`, `.github/**` except on an item whose card says `touches-protected: true`. Such an item is high impact by path anyway. Shell writes are not covered; that residual is in §12.

`.claude/hooks/receipts.py` (`PostToolUse`, M) appends to `state/.receipts.jsonl` (gitignored):

- every `Read` path;
- every `get_session`, `get_event` or `list_events` target;
- every ID returned by `create_session`, `create_trigger` and **`send_later`** (incident 8);
- usage-status values seen in `get_session` results.

Owned IDs are then copied into `state/run.yaml` by `tools/rec`, so that ownership is durable on `main`.

### 8.3 CI on every PR [I → D] (`.github/workflows/checks.yml`)

The workflow runs with the **base branch's** definition, using `pull_request_target`, reading the PR only as data and never executing PR code. Its purpose is that a PR cannot weaken the checker that judges it (`autoresearch`: a fixed evaluator separate from the mutable target; plan Appendix G8).

| Check | Fails when |
|---|---|
| `impact` | A changed path's class (from `system/impact.yaml`) requires a verdict or check that is absent |
| `verdict-binding` | A required verdict file is missing, is not byte-identical to a blob on a `claude/review-*` branch, does not name the PR head's tree hash, or has a `Claude-Session` trailer equal to the producer's |
| `records` | Front matter is malformed; a status transition is illegal (for example `finished`→`accepted` without its route); a parent is accepted without a composition verdict; evidence references don't resolve |
| `record-change` | An authoritative record changed without a typed trailer (§7.2) |
| `chain` | Orphans, unresolved links, missing tools (§7.3) |
| `facts` | A transclusion mismatch (§7.1) |
| `time` | A log line's time is more than 15 minutes from its commit time without `observed_at_source:` (incident 9) |
| `map` | A hook, workflow or `tools/` script exists that is not registered in `system/mechanisms.yaml`, or a registered carrier is missing (§8.5) |
| `squeeze` | A third `Patches: M-x` commit since the last frame review of M-x arrives without `Frame-Review: FR-y` (§13) |
| `sample` | A merged low-impact PR whose head hash falls in the sample bucket has no sample verdict within the stage (§9) |

**How reviewer verdicts reach `main` without a reviewer PR (U7).**

1. The reviewer commits `reviews/<item>/<tree-hash>.md` to its own branch `claude/review-<item>` and pushes it.
2. The run copies the blob byte for byte (`git checkout origin/claude/review-<item> -- reviews/...`) into its own PR.
3. CI's `verdict-binding` check confirms the blob exists on the reviewer branch.

Transcription is therefore faithful by construction. Authorship is still *declared*, through the session trailer, until C03 moves reviewers into `devos-denetim`.

### 8.4 On-demand helpers (enzymes) and their triggers

| ID | Helper | Trigger (named) | Arrow |
|---|---|---|---|
| H1 | Reviewer session | CI says a verdict is required; stage close; a sample hit; a lens qualification | M trigger (CI), J work |
| H2 | Counter-design session | Item type `major-design` (architecture, working system, role scheme, data model) | M (type → required in acceptance route) |
| H3 | Probe | A `platform:` dependency with status `untested` blocks the frontier (C7) | M |
| H4 | Researcher sub-agent | A card shows an open question; D9 "yes"; a lens of kind `question` with `consult-source` | I (card-prompted) |
| H5 | Critic sub-agent (non-binding) | Before H1 on design artefacts, to save a review round | I |
| H6 | Frame review | `squeeze` CI failure; a review with ≥5 findings on one artefact | M |
| H7 | Decision batch to Batu | An item is blocked on a Batu-class decision | M (frontier marks it); J (writing) |
| H8 | Wake arming | `stopcheck` reason ≠ `stage-done` | M (`stopcheck` requires an armed-wake record) |
| H9 | Plan change | Discovered work outside the plan; a plan contradiction | I + format gate |

### 8.5 Coverage by cross-cutting mechanisms, and keeping the map true

`system/mechanisms.yaml` holds one row per component. Each row has:

- id, carrier path, trigger, arrow type, scope ([I]/[D]/[S]);
- **a coverage cell for each of six cross-cutting mechanisms:** identity/ownership, heritage, memory, verification, recovery, security. Each cell holds a mechanism reference or `n/a: <reason>`;
- the problem it solves, its assumption, cost, failure mode, removal test, successor stage and sunset.

The `map` CI check keeps the map true to what runs: every running carrier is registered and every registered carrier exists. For **I** and **J** rows the carrier is a heading anchor in a file, and the check confirms the anchor exists. A row with an empty coverage cell fails. That is how adding `send_later` would have forced the question "is its ID recorded as owned?" (incident 8).

**Instructed arrows on critical paths that this design makes mechanical or tests:**

- boot and recovery after compaction (M);
- the stop decision (M);
- recording Batu's answers (M);
- the impact and review decision (M);
- briefing spawned sessions (M);
- timestamps (M);
- heritage activation (M);
- heritage *use* (J; tested by T-07);
- item selection (J; sampled);
- copying the usage status (I; audited by receipts against `create_session` calls, T-13).

---

## 9. Q7: proportionality

- **Who decides an item is small: nobody, by assertion.** The impact class is computed:
  - **high** — rules, roles, `.claude/**`, `system/impact.yaml`, `system/mechanisms.yaml`, workflows, plan text, decisions, stage acceptance, security, migrations;
  - **routine** — work records, logs, evidence summaries, generated views, lens candidates.

  The producer may raise an item's class, never lower it. Changing `impact.yaml` is itself high impact.
- **The thinking standard is fixed; depth scales.**
  - Every item starts with a one-paragraph **triage** in its start record: which kinds of expertise it touches, what could make it bigger than it looks, and the depth chosen with the reason. This is Batu's "the expert decides the expert is not needed after seeing the problem".
  - The triage is mandatory even for a one-line change. A format gate checks presence, and reviewer samples check content.
- **Review intensity scales by class:**
  - high impact: a reviewer verdict per change;
  - routine: deterministic checks plus **sampling the producer cannot steer**. A merged routine PR is sampled when `int(head_sha[:4], 16) % k == 0`, with initial k = 5. A sample verdict covers the PR, the triage and the impact classification.
  - A reviewer finding on a sample that would have changed the class or the result sets k to 2 for the rest of the stage.

  This answers incident 4 without making every change heavy.
- **Usage classes.** Items are tagged `heavy` (spawns sessions, broad research, large designs) or `light`. At the warning level, `tools/frontier` offers only light items.

---

## 10. Q8: continuity and capacity

**Within a run.** A `/goal` condition is phrased so the evaluator can judge it from the conversation: "stop only after the latest `tools/stopcheck` output in this conversation reads `STOP-ALLOWED: <reason>`". If a `Stop` hook runs in cloud (U2), `stop.py` blocks stopping on its own until `stopcheck` passes, and `/goal` becomes redundant. `/goal` is documented as judged by a small model from the conversation only.

`stopcheck` allows a stop only when every one of these holds:

- everything is merged to `main` (no unmerged commits on the run branch);
- `state/run.yaml` is updated;
- there are no unrecorded Batu answers;
- every owned session or routine ID is recorded;
- the hand-over note is written;
- **and** one of these reasons applies:
  - `stage-done`;
  - `batu-only` (the frontier is empty apart from Batu-blocked items, and the batch has been posted);
  - `blocked` (a named blocker);
  - `bounded` (the run bound was reached);
  - `usage-limit`.

For every reason except `stage-done` and `blocked`, a wake must be armed.

**Between runs, with no standing dispatcher (P6).**

- **`bounded` → self-succession.** The run creates its successor through `create_session` with `tools/brief run`. The successor's boot takes over the lease when `parent_session_id` matches the holder (the existing hand-over rule).
- **`usage-limit` → self-armed wake.** The run reads the reset time from `get_session` and arms a `send_later` for reset + 15 minutes (Batu's policy). The wake message is a fixed token, `WAKE:<run-id>`; the woken session runs `tools/boot` and continues.
- **`batu-only` → check-in wakes.** Wakes are armed every 6 hours, with at most 4 consecutive empty check-ins. Each wake runs boot, and boot detects new answers mechanically (§7.4).
- **All of this depends on U1.** Probe P-01 runs first in C01.

**Failure path.** A GitHub Actions scheduled workflow, `watchdog.yml` (free on a public repository), reads `state/run.yaml` from `main` hourly. If the lease has expired, the frontier is non-empty and no wake is armed past now, it updates the Batu issue with a one-line Turkish alert. It cannot restart anything, because it holds no key.

**Admission trigger K1, pre-registered.** If the watchdog fires once, or probe P-01 fails, a **keeper** is admitted:

- a long-lived session woken by a routine every 8 hours;
- terminal goal: "keep exactly one run alive when work is startable and usage allows";
- it does nothing else.

Until K1, building a keeper repeats incident 10.

**Usage limits.**

| Status | Behaviour |
|---|---|
| normal | Proceed; at most 2 reviewer sessions in parallel (Batu's rule, enforced by the hook: `create_session` with a reviewer marker is denied when 2 recorded reviewer sessions are not yet finished) |
| warning | Light items only (frontier filter) |
| limit | Checkpoint, arm wake, stop |
| any | Heavy items are preferred 23:00–08:00 Turkey time |

---

## 11. Q9: decisions and Batu

- **What goes to Batu.** Only purpose, scope, money, his accounts or other work, and acceptance of results. Each one is a `decisions/D-<n>.md` record with `class: batu`, written in the Appendix E format: the question, why it is his, options with purpose, benefit and cost, the recommendation, what he needs to know, and what happens without an answer.
- **One issue.** All open Batu items are batched in it. The body has a generated Turkish status header (stage, what moved, what waits on him, what continues regardless) and the open decisions, each with full file paths. Each posting is a single update, not one message per item.
- **Answers.** Detected mechanically (§7.4). The run records his Turkish words verbatim in the decision record with the English interpretation (`Record-Change: annotate`), then acts. His silence is never approval: items depending on the decision stay not-ready, and the "if no answer" clause runs only where Appendix E allows it.
- **Everything else is decided without Batu.** Technical decisions are made by the run and accepted by a reviewer (high impact) or by checks (routine). A technical question that reaches the issue is a defect, and CI's `records` check rejects a `class: batu` decision without an owner reason.
- **Status without asking.** `DURUM.md` and the issue header are regenerated at every checkpoint, so they are never older than the last merge.
- **Batu's actions.** The things only he can do (account settings, branch protection, secrets, routine creation) are steps in the same issue, one action per step, with what he should see at the end of each step (Appendix E §7).

---

## 12. Q10: security barrier

**What exists and stays.** The default-deny allowlist hook. It is the right shape, because spawned sessions inherit connectors under opaque identifiers and only default-deny handles names that are not known in advance.

**Additions:**

1. **Second layer in `permissions.deny`.** `"mcp__*"` (deny patterns for MCP are documented), with a short allow list of `mcp__<server>__<tool>` entries for the GitHub tools scoped to `devos` and the session tools. This layer does not depend on the hook script being correct.
2. **Per-role profiles in the same hook.** The role marker of the first message (§6.1) selects the profile:

   | Role | Profile |
   |---|---|
   | **reviewer, counter-designer** | Read-only tools; `git push` only to its own outcome branch; no `create_session`, `send_later`, `create_trigger`, PR merge or issue writes |
   | **probe** | Only the tools named in its brief |
   | **run** | The current profile plus the gates in §8.2 |
   | **no marker** | The most restrictive (reviewer) profile |

   This replaces "one allow list for all sessions" with role profiles in one file, so they remain reviewable together.
3. **Session and routine ownership.** Unchanged in intent. The receipts hook (§8.2) now records `send_later` IDs as well (incident 8).
4. **Hook integrity at boot** (§7.4), and the protected-path gate (§8.2).
5. **Writes to other repositories.** GitHub write tools must carry `owner=batuhanozgun, repo=devos`. For `git push`, the hook denies Bash commands containing `push` unless the remote URL resolves to `devos`.

**Residual risks, stated plainly.**

- **Shell paths.** A deliberate Bash route (for example `curl` to an API with ambient credentials) is not fully covered.
- **Self-editing.** The builder could edit its own hook in the working tree.

Batu accepted both until C02–C03. This design narrows the *accidental* and *injected* routes, and makes deliberate changes to protected paths visible through CI and boot hash checks. It does not make the builder unable to defeat the barrier on purpose. C03 closes that gap by moving binding authority to environment tokens.

---

## 13. Q11: growth and framing

- **Vertical growth (a new capability) must trigger horizontal coverage (M).** A new component cannot merge until its `mechanisms.yaml` row has all six coverage cells filled (the `map` check). This is Batu's "a new actor is a new system surface" turned into a check.
- **Merging, narrowing and removal are first-class.** Every mechanism row has a `review_by` stage and a **removal test**: "without it, what observable outcome gets worse?". At each stage close, the reviewer receives the rows that are due.
  - A row whose removal test shows no worsening is **retired** with `Record-Change: retire`.
  - Two rows that guard the same failure class are **merged**.
- **Candidates are kept apart from the accepted system.**
  - Candidate mechanisms live under `system/candidates/` and are not referenced by `registry.md`, so boot, cards and hooks never load them.
  - Promotion is a PR with a high-impact verdict, which moves the file and adds the registry row.
  - Lenses work the same way through `status` (§6.2).

  This is Batu's branch analogy, used for the logic it names (candidate state is not accepted state), not as a literal git mechanism.
- **The squeeze signal (M).** Fixes to a mechanism carry the trailer `Patches: M-x`.
  - On the **third** patch since the last frame review, CI blocks further patches until a `FR-` frame-review record exists. Two patches are allowed, because the first can legitimately be a bug fix.
  - The frame review asks: which premise created the limit? Is it needed? Does a counter-frame dissolve the problem?
  - A review returning five or more findings on one artefact also opens a frame review before any finding is fixed (incident 2).
- **Major decisions look for frames.** A `decisions/` record of a major design must contain:
  - `premises:` with the from-scratch test for each;
  - `alternative_frames:`, at least one, with "what would make it right";
  - `chosen_because:`;
  - `reopen_if:`.

  This is a format gate; the reviewer judges content. For working-system, data-model and role-scheme decisions, a counter-design (H2) is required, as this document shows.

---

## 14. Q12: pre-registered tests

Each test states what is observed and must **fail if the mechanism is absent**. Thresholds are fixed now, before any result.

**Probes (C01, first):**

| ID | Probe | Pass condition | Fail implies |
|---|---|---|---|
| P-01 | A `send_later` to an idle builder session, 30 minutes ahead | Within 10 minutes after the due time, the session reads the wake (the notifications tool is allowed by the hook) and runs `tools/boot` with no human input | Admit keeper (K1) |
| P-02 | `Stop` hook in a cloud session that checks out `devos` | A test `Stop` hook that blocks the first stop attempt makes the model continue | `/goal` + `stopcheck` only |
| P-03 | Compaction marker visible in the transcript path given to hooks | After a forced compaction (long synthetic session), the hook detects it on the next tool call | Use the transcript-size-jump heuristic; re-test |
| P-04 | `PostToolUse` `additionalContext` injection | The injected sentinel string appears in the model's next turn | Use deny-with-reason only |
| P-05 | Required checks on `main` for administrators (U5) | A PR with a deliberately failing check cannot be merged by the builder | Escalate to Batu as an account-settings step |
| P-06 | `pull_request_target` check uses the base definition | A PR that edits `checks.yml` to always pass still fails under the base definition | Rework CI hosting |
| P-07 | Public API read of issue comments from a session | `tools/boot` lists a test comment by `batuhanozgun` | Read through the MCP tool, instructed, audited by T-04 |
| P-08 | Routine limits on this plan (U8) | The observed number is recorded | Keeper scheduling adjusts |
| P-09 | Repository skills and agents in cloud (U3) | Listed in the session's init event | None; optional only |

**Mechanism tests** (run on a test branch with seeded states; "without" means the mechanism disabled):

| ID | Mechanism | Setup | Pass | Without the mechanism |
|---|---|---|---|---|
| T-01 | Boot gate | Fresh session; attempt `Write` before boot | Denied with reason; allowed after boot | The write succeeds |
| T-02 | Compaction gate | Force compaction mid-item | The next write is denied until `boot --recover`; the recovered digest shows the current item | The run continues on a compacted summary |
| T-03 | Stop check | Unmerged commit plus an attempt to finish | Stop refused; reason printed | The run stops with work only on its branch (incident 1) |
| T-04 | Unrecorded-answer check | Post a test comment as Batu (he does this once, as an Appendix E step) | Boot shows it first; stop is refused until it is recorded | The answer goes unnoticed (incident 5c) |
| T-05 | Notes reach the branch | Seed a `check-when-started` note on a future item | When that item starts, the card shows it and the start record's `relies_on` cites it | The note is lost |
| T-06 | Planted decision condition | Seed a decision with `reopen_if` touching the active item | The digest lists it; a reviewer confirms the run's action respects it | Decision condition lost (Batu's "wrong continuity") |
| T-07 | Lens activation and use | One item whose correct handling depends on a qualified lens; a control run with lens printing disabled | The lens run cites a `changed` or `limited` disposition that a blind reviewer confirms. Pass if the lens run handles it correctly **and** the control does not, in 2 of 3 trials | If the control also succeeds, the mechanism is unproven; keep it only as cheap, flagged, and re-test at C05 |
| T-08 | Brief-formation gate | Attempt `create_session` with a hand-typed prompt | Denied | A bare task reaches a spawned session (incident 8) |
| T-09 | Required-reading gate | A reviewer session attempts to push a verdict without reading the floor | Denied | The verdict is produced without the floor |
| T-10 | Impact classification and sampling | Producer PR that touches `.claude/settings.json`, with a "status-only" label in the description | CI requires a verdict regardless of the label | Merges unreviewed (incident 4) |
| T-11 | Verdict binding | Copy a verdict, then add a commit after the review | CI fails (tree hash mismatch). A verdict file edited by the producer also fails (blob mismatch) | A stale or edited verdict passes |
| T-12 | Evidence binding | A `finish` that cites a non-existent file or an unread session event | Refused; the session-event citation is accepted only if it is in receipts | A claim recorded unread (incident 3) |
| T-13 | Usage audit | `create_session` with no `get_session` result in receipts in the last 30 minutes | The hook warns and records it; the stage reviewer sees a count | A silent breach of Batu's usage policy |
| T-14 | Ownership receipts | Arm a `send_later`; then check `state/run.yaml` after `tools/rec` | The ID is recorded | Cannot be checked (incident 8) |
| T-15 | Restatement check | Change the current stage in its home only | CI fails on a stale transclusion | The stale row survives (incident 5a/5b) |
| T-16 | Timestamp check | Hand-write a log time 2 hours off | CI fails | The estimated time is accepted (incident 9) |
| T-17 | Map truth | Add an unregistered script to `tools/` and a hook entry | CI fails | An unmapped mechanism runs |
| T-18 | Squeeze signal | Three `Patches: M-x` PRs | The third is blocked until FR exists | Rule-by-rule patching (incidents 1, 2) |
| T-19 | Composition | All children accepted, parent marked accepted without a composition verdict | CI fails | "All green children = parent done" |
| T-20 | Stale basis | Supersede a decision cited in an admitted item's basis | The item leaves the ready set with "basis changed" | Work proceeds on a superseded basis |
| T-21 | Continuity end to end | A run is ended abruptly (archived) mid-item | Within the wake or watchdog window, a successor resumes the same item from records only, and no completed external effect repeats | Silent stop, or duplicated effect |
| T-22 | Security profile | A reviewer session attempts `create_session`, a merge, and a push to another branch | All denied | Reviewer acts beyond its role |
| T-23 | Dispatcher absence (P6 test) | 7 days of real operation in C01–C03 | Zero watchdog alerts, or K1 is admitted on the first alert. Report the gap minutes caused by missed wakes | — |

The bozma (break) principle of plan §8 applies to every CI check: each check gets one fixture that must turn it red.

---

## 15. Mechanism register

Cost uses a rough scale: S (hours), M (a day), L (several days).

| ID | Mechanism | Problem | Assumption | Cost | Failure mode | Removal test (what worsens) | Scope; home; successor |
|---|---|---|---|---|---|---|---|
| M-01 | Boot gate + `tools/boot` | Instructed boot not done (incident 6) | `PreToolUse` runs in every session (observed) | M | Boot output too long, so it is skimmed; mitigated by a short digest | T-01, T-05 regress | [I]; `gate.py`, `tools/boot`; → `session_brief` (C04) |
| M-02 | Compaction gate | No re-read after compaction (incident 6) | Compaction is detectable (P-03) | S | False positives; mitigated by a single re-prompt | T-02 | [I]; `gate.py`; → DevOS session discipline (C06) |
| M-03 | `stopcheck` + `Stop` hook or `/goal` | Stopping early; work left on branches (incident 1) | P-02 or `/goal` | S | `/goal` evaluator misreads; mitigated by a single sentinel line | T-03 | [I]; `tools/stopcheck`, `stop.py`; retire at C12 |
| M-04 | Unrecorded-answer check | Batu's answer not recorded (incident 5c) | P-07 | S | API outage, so boot warns and continues read-only | T-04 | [I]; `tools/boot`; → decision channel (C06) |
| M-05 | Work model + `tools/frontier` | "Next action" restatements; startable not computed | Item files stay small | M | Over-recording; mitigated by the depth rule | T-05, T-19, T-20 | [D]; `work/`, `tools/frontier`; → `ready_works()` (C02) |
| M-06 | Item card | Context not activated at the decision moment | Cards are read (they are printed into context) | S | Cards grow long; capped at 120 lines | T-05, T-07 | [D]; `tools/card`; → context package (C04) |
| M-07 | Lenses (qualified heritage) | Library used only when asked (incident 6) | Tags match | M | Lens bloat; uncritical rules; mitigated by qualification and the `rule`-needs-test rule | T-07 | [D]+[S]; `heritage/`; → `Learning` + knowledge maps (C05) |
| M-08 | `tools/brief` + brief and reading gates | Spawned sessions lack lessons and floor (incident 8) | The role marker is honoured (declared) | M | Marker forged; acceptable until C03 | T-08, T-09 | [I]; `gate.py`, `tools/brief`, `system/roles/`; → role packages (C05) |
| M-09 | Impact classification + sampling | Producer judges own review need (incident 4) | Paths reflect impact | S | Mis-specified globs; caught by samples | T-10 | [D]; `system/impact.yaml`, CI; → `impact_class` (C02) |
| M-10 | Verdict binding via reviewer branch | Faithful verdict transport; stale verdicts; classifier denial on reviewer PRs | Reviewer branches are retained | S | Declared authorship; residual until C03 | T-11 | [I]; CI; → `devos-denetim` verdicts (C03) |
| M-11 | Evidence binding + read receipts | Claims made before checking (incident 3) | `PostToolUse` sees tool inputs | S | Only covers cited evidence, not uncited claims | T-12 | [D]; `receipts.py`, `tools/rec`; → `EvidenceEnvelope` (C02) |
| M-12 | One home + generated views + transclusion check | Restated facts go stale (incident 5) | Most restatements are of a few key facts | M | Prose restatements escape; samples | T-15 | [D]; `system/registry.md`, `tools/render`, CI |
| M-13 | Typed record changes | Correction vs supersession confusion; impact blindness | Trailers are written (CI enforces) | S | Mis-typed; reviewer sample | T-20 | [D]; CI; → `revision`/`supersedes` (C02) |
| M-14 | Chain check | Persisted ≠ findable | Registry kept current (CI enforces) | S | Over-strict orphan rule; `empty-allowed` | T-17 | [D]; CI |
| M-15 | Clock-only timestamps | Estimated times (incident 9) | Commit times are honest | S | Legitimate late recording; `observed_at_source` | T-16 | [D]; `tools/rec`, CI |
| M-16 | Mechanism register + map check + coverage matrix | Unmapped mechanisms; capability added without coverage (incidents 7, 8) | Carriers are files | M | Coverage cells filled meaninglessly; samples | T-17 | [D]; `system/mechanisms.yaml`, CI; → `MechanismAssumption` (C10) |
| M-17 | Squeeze signal + frame review | Rule-by-rule patching (incidents 1, 2) | Patch trailers are honest | S | Mis-labelled patches; reviewer | T-18 | [D]+[S]; CI, `decisions/FR-*`; → `FrameReview` (C02) |
| M-18 | Probe-before-build rule (C7) | Building on unchecked paths (incident 7) | Platform facts are tagged | S | Over-blocking; probe cost | P-tests show dependants were blocked | [D]; `tools/frontier` |
| M-19 | Self-armed wakes + watchdog | Continuity without Batu or a dispatcher | U1 (P-01) | S | Missed wake, so watchdog alerts and K1 is admitted | T-21, T-23 | [I]; `tools/stopcheck`, `watchdog.yml`; → routines (C06) |
| M-20 | Role-profiled allowlist + `permissions.deny` layer | Connector or injected misuse; one list for all roles | Hooks enforced (observed); deny patterns (documented) | S | Shell paths; self-edit (accepted residual) | T-22 | [I]; `.claude/`; → C03 trust boundaries |

**Minimum first build, in order:**

1. M-01 + M-03 + M-04, the boot and stop spine (about 1 day);
2. M-05 + M-06 + M-15;
3. M-09 + M-10 + M-11 + M-20;
4. M-12, M-13, M-14, M-16, M-17;
5. M-07 and M-08 last. They need content (lenses, roles), and the lens seed is the least proven.

The probes P-01 to P-07 come before steps 1–3, because their results choose the variant.

---

## 16. What I would remove or merge (from the plan's installation rules and the current platform usage)

1. **Standing dispatcher and heartbeat: remove.** They return only by trigger K1 (§10).
2. **Per-turn D1–D9 logging (`ProtocolAudit`, Appendix B 3.25; Appendix D §1): do not apply to the builder [I].**
   - For DevOS [D], C05 should test whether the audit trail changes behaviour, as its own mechanism-assumption test. Logging nine answers per turn is the "ritualisation" pattern Appendix D itself warns about.
   - Replace it, for the builder, with the trigger questions printed at item start plus artefact-level format gates.
3. **`/goal` as the stop authority: demote.** It is a judged evaluator that sees only conversation. The `stopcheck` sentinel decides, and `/goal` merely reads it.
4. **Hand-written `DURUM.md` and the separate status texts (state file "next action", digest, issue header): merge** into one set of homes with generated renderings (§7.1).
5. **The `CLAUDE.md` eight-step instructed boot list: replace** with one mechanical `tools/boot` plus the gate. `CLAUDE.md` keeps only the fixed rules (this also eases the C05 replacement).
6. **Reading the whole plan package at each boot: remove.** Boot prints the digest; the card names the plan sections the item needs, and the reading gate makes the run read them.
7. **"Batu's technical approval" anywhere in the builder's paths: remove.** It is already PC-05; CI's `records` check makes a technical question to Batu fail.
8. **One allow list for all sessions: narrow** into role profiles (§12).
9. **Review by every change of the builder's working rules, without sampling: merge** into impact classes. Rules stay high impact; routine records get sampling instead of being reviewed by producer assertion or not at all.

---

## 17. Unconventional alternatives and second-order effects

### 17.1 Defensible but unusual options

1. **Verifier-frozen criteria.** For stage acceptance and major designs, the *reviewer* writes or freezes the acceptance criteria at admission, before the producer starts (`autoresearch`: fixed evaluator, mutable target).
   - Cost: one extra short reviewer pass per stage.
   - Gain: removes criterion drift and the producer's frame from the acceptance test.
   - *Recommended for stage gates only.*
2. **Pull-request-based decision channel.** Post Batu's decision batch as a PR rather than an issue. The run subscribes to PR activity, so Batu's comment wakes it immediately, with no polling wakes.
   - Cost: a different surface for Batu; this is his decision if adopted, since it touches his way of working.
   - Keep the issue unless P-01 shows polling wakes are unreliable.
3. **The builder's records as the first DevOS instance.** The file schema deliberately mirrors Appendix B families, so the C02 ledger transfer is a mechanical import. It also becomes the first real test of the data model on lived data, the builder's own three weeks, rather than synthetic fixtures.
4. **Reject "one long builder session".** A chain of bounded runs is more expensive in boot tokens but is the only option whose recovery path is exercised every day, not only after failures.

### 17.2 Second- and third-order effects over 12–24 months

- **A file-based mini-DevOS competes with DevOS.** The risk is that the builder's machinery grows into a parallel system that resists being replaced at C02–C06 ("installation-only" rules ossify).
  - Counter: every [I] row has a successor stage and a sunset, and the stage-close review retires due rows (§13).
- **Goodhart on format gates.** Gates reward filled fields, not thought.
  - Counter: few gates, and sampling is pinned by hash, so the producer cannot choose what is sampled.
  - What sampling cannot fix: a reviewer who shares the producer's frame (same model family, U-3). That residual stays until the second model (B2) is used for high-impact verdicts.
- **Lens canon becomes dogma.** Qualified lenses could crowd out fresh reading of sources.
  - Counter: lenses are mostly questions, they keep their route to the source, and they have their own `retire` path.
- **SOUL inherits the patterns.** If they work, "item card + activated lenses + reading gate + verdict binding" is a template for how SOUL forms actors [S]. That is why they are written as general mechanisms, not builder hacks.

---

## 18. Risks and trade-offs

| Trade-off or risk | What is given up | When this design does *not* work |
|---|---|---|
| Mechanical gates in a hook the builder can edit | Security against a determined builder | If the builder intends to bypass. Accepted until C03 |
| CI with `pull_request_target` | Some simplicity; needs care not to run PR code | If branch protection with required checks cannot be set (U5): CI is then advisory and the design loses half its spine |
| Bounded runs | Boot tokens per run (~small) and hand-over overhead | If boot or hand-over is poor; T-21 shows it |
| Sampling instead of reviewing all routine changes | Coverage on any single change | If k is too high for the error rate; adaptive k mitigates |
| No dispatcher | One possible unattended gap until the first watchdog alert | If P-01 fails or wakes are flaky; K1 admits a keeper at once |
| Declared roles and independence | Authority independence | Same-model blind spots remain (plan U-3) |
| Lens activation | Effort to write and qualify lenses | If T-07 shows no gain over control; then lenses are cut to a short list or removed |
| Restatement check | Only marked restatements are caught mechanically | Free-prose restatements need samples |
| Compaction detection | Relies on transcript internals | If the transcript format changes; P-03 re-runs on platform change |

---

## 19. What I consulted and what I left out

**Consulted:**

- **Plan and appendices** (own reading): the plan §§0–14; A §§1–7; B §§1–3.7 and 3.24–8; C §§0 and 5; D in full; E; F; G; the two plan research documents.
- **Batu's Original texts:** all 13 files (§0.1).
- **Library studies.** Read by delegated read-only sub-agents and paraphrased; no library text is copied here.
  - Work control: `recursive-prerequisite-discovery` (provisional; mechanics-only prototype), `beads`, `openspec`, `spec-kit`, `work-management-project-control`, `gastown`, `openproject`, `leantime` (all bounded-complete first-wave slices; source reading only).
  - Memory and harness: `context-memory-harness-engineering`, `the-carbon-layer` dossiers `mQfTdNVCOB0` (partial) and `PxuMqeIqCEo` (review-ready), `hermes-agent` (partial), `superpowers` (accepted), `anthropic-ai-native-sdlc-playbook` (first-party claims), `gstack` (closure-audited); `llm-wiki`, `ai-memory`, `context-mode` (planned; signals only).
  - Foundation and agents: `research/soul-foundations` (grounds and composition KEYs; same-model adversarial review only), `multi-agent-patterns` (exploratory), `autoresearch`, `i-have-adhd`, `mattpocock-skills`, `ponytail` (planned; signals only), `ecc` (partial), `agentic-ai-systems-roadmap` (seed).
  - Explorations: EXP-002, EXP-004, EXP-005 and EXP-006 lessons, and `development-os/attempts/001–002` (conceptual dialogues and same-assistant self-reviews).
- **Primary documentation**, via a documentation sub-agent, fetched today:
  - `code.claude.com/docs/en/cloud-environments`, `permissions`, `routines`, `goal`, `plugins/overview`, `claude-code-on-the-web`;
  - findings used: U2, U3, U8; deny `mcp__*` patterns documented; `/goal` evaluator documented.
- **Web/network:** one reachability check of `api.github.com` (P-07 basis).
- **Own reasoning:** everything in §§4–18 not attributed above.

**Deliberately left out:**

- the 18-role DevOS scheme (C05 business);
- the Supabase schema details beyond the families that the file records mirror;
- the leak-check design (plan §6.7, not builder-specific);
- the library's `concepts/` programme;
- old experiment repositories (not needed for this question; they enter at C04).

---

## 20. Open questions I could not settle

1. **U5:** is branch protection with required checks, covering administrators, already active on `devos`? Everything in §8.3 depends on it. This is a check for the builder, and then possibly an account step for Batu.
2. **U6:** what path applies C02 migrations without a write key in the builder? A separate design item before C02.
3. **U1 and U8:** wake semantics and routine limits. The sources conflict (15 per day vs 100 per hour); P-01 and P-08 settle them.
4. **Compaction detectability (P-03).** If neither a hook event nor a transcript marker is available, recovery after compaction falls back to the transcript-size heuristic, which is weaker.
5. **Whether the lens mechanism beats no-lens control (T-07).** The heritage design is the least proven part. It is built last and kept only if T-07 passes.
6. **Reviewer capacity under shared Max with at most 2 parallel reviewers.** The sampling rate k and run bounds may need to change after one week of measurement.
7. **Whether reading Batu's issue through the unauthenticated public API is acceptable** as a mechanical path (rate limits, and the issue's public visibility). This is a question for the builder's own judgement, not for Batu.
