# W-C00-12 · 02 · Design piece 1: memory and records (object O4)

**Status:** candidate (W-C00-12 work product, not binding; changes nothing until the independent review passes and the migration is merged). **Scope:** installation only, unless a line says otherwise. At C02 the live part moves to the database (§10); the file part stays. **Written:** 2026-10-03 by run `session_0143r88Vc9e5RbsQmqjYWgwa`. **Serves:** needs N1, N4, N9 and cross-cutting condition X1 of `01_goal_down.md`; acceptance (l) in full; parts of (a2) and (m).

## 1. The problem, from what actually failed

Memory here means: the right actor notices a fact, recovers it with its status and conditions, and uses it (principle 15; "stored ≠ retrievable ≠ retrieved ≠ used"). The builder's records failed at each of those links:

| Failure (source) | Link that broke |
|---|---|
| The operating model's header said "Binding" while the state file said "not independently accepted" (OI-011 item 22) | One fact, two homes; no check compared them |
| The Next action row was stale after a merge (L-027) | A restatement updated by instruction only |
| Batu's answers on issue #6 were unrecorded for 35 hours (F-036-1) | An external source of truth read by an instructed boot step that the sessions writing records did not run |
| OI-011 grew into one table cell of 24 items mixing observations, proposals and later-stage notes | No home for open notes on the branch they concern (acceptance (a2)) |
| The W-C00-12 acceptance cell grew to several thousand words in one table row | A table used as a record store |
| Log corrections are buried in later entries (L-030 correcting L-029) | Change kinds not typed; a reader of L-029 cannot see that it was corrected |
| Four estimated values in one hour (F-037-2) | A measurable value typed instead of measured |
| `owned_ids.txt` conflicted on a branch switch (F-037-1); `send_later` IDs never recorded (OI-011 item 24) | A recorder-written file versioned like a hand-written one; one creation path not covered |

The common cause: **records were designed as documents for a reader, not as a store with homes, kinds and checks.** Every fix so far added a sentence of instruction. This piece replaces instructions with structure where the structure is cheap, and with a deterministic check where it is not.

## 2. What is reused, not invented

Plan Ek B already designs DevOS's record store. The builder's file records are a **file-form subset of Ek B's families**, with the same IDs, axes and relation types, so that the C02 ledger transfer (plan §9 introduction: no duplication on re-run, resumable, links and versions match) is a mapping, not an interpretation (U-7). Adopted from Ek B §1, scope DevOS, applied here to the builder:
- **Separate status axes** (Ek B §1 item 5, §3.3): a work item's execution, qualification, acceptance and effect are separate fields; there is no single "done".
- **Revision, not overwrite** (Ek B §1 item 3): a meaningful change produces a new revision with a reason; references name what they rest on.
- **Typed relations** (Ek B §3.4): `depends_on` (hard), `supersedes`, `derived_from`, `about`, plus `discovered_from` (from the beads study: provenance of emergent work that does not imply order).
- **Decision fields** (Ek B §3.17): `answer_original_tr`, `answer_interpretation_en`, `answered_by`, `answer_channel_ref`, `reopen_triggers`, `status`, `supersedes`.

## 3. Record families and their one home

Each fact kind has exactly one authoritative home. Everything else points to it or is generated from it (§6).

| Family | ID pattern | Authoritative home | Form | Ek B family at C02 |
|---|---|---|---|---|
| Work item | `W-<stage>-nn` (children `W-<stage>-nn.m`) | `plan/work/<ID>.md` | front matter + body: acceptance text (verbatim, with dated changes), open notes, history | Work, WorkStanding, Relation |
| Need / open note | `N-nnn` | the body of the work item it concerns, or `plan/work/<ID>.md` of a later stage's item; unattached only in `plan/work/INBOX.md` with an owner and a date by which it must be attached | front matter block inside the item, or inbox row | Need, Inquiry |
| Decision | `D-nnn`, `PC-nn`, `K<n>`, `B<n>` | `plan/decisions/<ID>.md` | front matter + Batu's words verbatim + interpretation + conditions and reopen triggers | Decision |
| Evidence and test result | `EV-…`, `T-…`, `P-…` | `evidence/<stage>/…` (unchanged) | one file per claim, pre-registration before result | Review, Verdict, Observation |
| Log entry | `L-nnn` | `plan/ledger/<stage>-log.md` (unchanged, append-only) | entry + a **Record changes** block (§5) | Event |
| Failure pattern (heritage) | `FP-nn` | `plan/builder/heritage/FAILURE_PATTERNS.md` | lens, question to ask, source entries, status (candidate / qualified) | Learning |
| Premise | `BP-nn` | the premise table of the governing builder document | origin, status, from-scratch test | Premise |
| Governing document status | — | `plan/ledger.md` §"Governing documents" only | one row per document: path, version, status, accepted by | Release |
| Owned session and routine IDs | session/trigger IDs | `.claude/hooks/owned_ids.txt`, written only by the recorder hook | append-only lines | SessionRecord, LaunchRecord |
| Current state | — | `plan/ledger.md` §1 (stage, run lock, usage, waiting for Batu, channel read stamp) | short table | (live state in the database from C02) |

Rules, scope installation:
- **M-R1 One home.** A fact is written only in its home. Another file may name its ID or path, never restate its value, except in a generated view (§6) or in `DURUM.md` under its sync check (§6).
- **M-R2 Status of governing documents lives only in the state file.** A governing document's header says `Status: see plan/ledger.md, Governing documents`, and carries no status word of its own. This removes the OI-011 item 22 class by structure.
- **M-R3 Open notes attach to the branch they concern.** A discovery about later work is written into that work item's file (creating a `planned` item for a later stage if none exists), with `discovered_from` the item where it was found. The inbox exists for notes whose branch is not yet known; each carries an owner and an attach-by date, and the check fails on an overdue inbox row. OI-011 dissolves into attached notes when this piece is migrated; its items get dispositions there (acceptance (b)).

## 4. The root chain: from always-loaded to every record

Principle 15's extension: the path to knowledge must itself be remembered, from a root that is in context without any decision by the actor. P-W12-1 showed that a `SessionStart` hook's output reaches the model before its first tool call (observed once).

1. **Root, mechanical:** a `SessionStart` hook prints a **boot map** generated at that moment from the files: the home table of §3 (from `plan/builder/MEMORY_MAP.md`, the one file that holds it), the current UTC and Turkey time from the clock, the `main` SHA, and the qualified failure patterns (FP lenses, one line each). It prints no work state, because reviewers and counter-designers must not see it (their input restriction). Role routing stays in the first message.
2. **Root, always loaded:** `CLAUDE.md` points to `plan/builder/MEMORY_MAP.md` and to the boot order. Two roots, one table: both name the same file; neither copies it.
3. **From the map:** each family's home, and for each home its index or view. A run then reads the state file and the startable frontier (piece 2).

**M-R4 Chain check** (deterministic, `tools/check_records.py chain`): every family in the map has an existing home; every file under a home directory appears in its generated index; every authoritative file named anywhere in `CLAUDE.md` exists; no authoritative file exists outside a home in the map. A record that no chain reaches fails the check.

## 5. Change kinds

A single write can hide different semantic events (principle 15). Every pull request that changes an authoritative record carries, in its log entry, a **Record changes** block with one line per change:

`<record ID or path> · addition | correction | supersession | retirement · [supersedes <ID or revision>] · <reason>`

- *addition*: new content; nothing earlier loses validity.
- *correction*: earlier content was wrong; the earlier revision stays readable in git and the corrected record names it.
- *supersession*: earlier content was right when written and is now replaced (a decision, a plan change, a status).
- *retirement*: the record stops governing; it stays as history and leaves every generated active view.

Front matter carries `revision` and, where relevant, `supersedes` and `superseded_by`. A superseded or retired record stays in its home with its status, so that history and current basis stay apart (agent-memory dossier lens: keep the history, remove it from active selection).

**M-R5 Kind check** (`tools/check_records.py kinds`, run on the PR diff against `main`): a deleted or modified line in an authoritative record requires a Record changes line naming that record with kind correction, supersession or retirement; a pure append requires an addition line. The log itself stays append-only; the check rejects a modified log line, and a correction of a log entry is a new entry whose Record changes block names the corrected entry.

## 6. Restatements: generated, or checked

- **Generated views.** The work index and startable frontier (piece 2), the decisions index, and the open-notes view are generated by `tools/records.py render` from the item and decision files into marked blocks of `plan/ledger.md` (`<!-- generated:work-index -->` … `<!-- /generated -->`). **M-R6 View check:** `tools/check_records.py views` re-renders and fails if any generated block differs from the committed one. A hand edit of a generated block is therefore caught, and a stale view cannot be merged.
- **`DURUM.md`** stays hand-written Turkish prose for Batu (a restatement kept by design). **M-R7 Sync check:** `DURUM.md` carries one machine line, `<!-- sync: stage=… run=… waiting=… frontier=… ledger=<sha of plan/ledger.md> -->`, written by `tools/records.py sync`. The check fails if the line's values differ from the state file, or if its `ledger` hash is not the current state file's. The writer therefore regenerates the line from the current state, and the prose next to it is reviewed against it at closure. The check cannot prove the prose is right; it proves the prose was written against the current state.
- **External sources.** Batu's channel (issue #6) is the authoritative source of his answers until a decision record holds them. **M-R8 Channel stamp:** the state file carries `Batu channel read: <UTC time> (last comment id …)`. For runs, `tools/builder_check.sh` fails if the stamp is older than the run's start. Writing the stamp without reading the issue would be deliberate, not an accident; the stamp turns a forgotten instructed step into a failed stop check.
- **Measured values.** **M-R9 Stamp check:** timestamps in changed lines of the state file, `DURUM.md` and new log entries must not be in the future relative to the check's clock, and the state file's "As of" cells on changed rows must be within 30 minutes of the check. Sizes, counts and conversions are produced by commands whose output is pasted, and the decision-and-basis record names the command. The SessionStart boot map prints both clocks, so the first value a session needs is already measured.

## 7. Owned IDs

- **M-R10 Union merge.** `.gitattributes` marks `.claude/hooks/owned_ids.txt` with git's built-in `merge=union` driver, so two branches' recorder lines merge without conflict (F-037-1; part of OI-010).
- **M-R11 Coverage.** The recorder's matcher adds `send_later`. Its response shape is checked on one live call before the recorder is changed; the recorder's parsing rules (one ID from a named field, otherwise nothing) stay. This closes OI-011 item 24 for future reminders; the existing unrecorded reminder `trig_015TYQ5f5QowWGLJTRJqQ4HJ` is listed in the migration as owned by Batu's conversation session, not added by hand.

## 8. What a fresh session recovers, and uses

The pieces above make recovery possible; acceptance (l) requires that it is shown, for use and not only retrieval. Decision records carry their **conditions** and **reopen triggers** as fields, because continuity that carries the decision without its condition is the "false continuity" Batu named (`BATU_STORED_IS_NOT_USED_TR.md`). Example: D-003's acceptance holds "until the audit environment exists (C02–C03); re-assessed at C03". A task that assumes C03 is done must surface that D-003 no longer covers it.

## 9. Scope and hand-over

| Mechanism | Scope | Replaced by | Hand-over trigger |
|---|---|---|---|
| File record families, views, checks | installation | DevOS database families (Ek B) and `devos_api` | C02 ledger transfer accepted (plan §9 introduction) |
| Boot map via `SessionStart` | installation; the pattern is a candidate for DevOS (C05 common rules) | DevOS `session_brief()` (C04) | C04 acceptance |
| Change kinds | DevOS (Ek B §1 item 3 already requires revision with reason) | database revisions and events | C02 |
| `DURUM.md` sync line | installation | DevOS status page or decision channel (C06) | C06 |
| Channel stamp | installation | DevOS decision channel with identity check (C06, plan C01 row 11) | C06 |
| Union merge and recorder coverage | installation | environment tokens and launch records (C02, Ek B §3.24) | C02–C03 |

## 10. Transfer to the database (C02)

The front-matter fields are named as Ek B names them, so the transfer is field-to-field: work items → Work + WorkStanding (four axes) + Relation rows; open notes → Need with `return_to` = the item; decisions → Decision with `answer_original_tr`; log entries' Record changes blocks → Events with revision links; failure patterns → Learning. Re-running the transfer must create nothing new (IDs are stable), and after it `plan/ledger.md` carries the hand-over mark of plan §9. This piece does not design the database; it makes the files transferable.

## 11. Pre-registered tests (rows for the test register)

Each test is written before the mechanism exists; each must fail on the current `main` (or on the named historical commit) and pass after the migration.

| ID | Claim | Procedure | PASS only if |
|---|---|---|---|
| T-M1 | The status-location check would have caught the 2026-10-02 contradiction (acceptance (l)) | Run `check_records.py docstatus` on a scratch checkout of `b74ab11` (before this run; the operating model's header says "Binding" while the W-C00-05 row says "not independently accepted") | it FAILS there, naming `plan/Builder_Operating_Model.md`; and PASSES on the migrated tree |
| T-M2 | The view check catches a stale or hand-edited generated block | On a scratch copy: edit one generated line by hand; separately, change an item's state without re-rendering | both runs FAIL; the unmodified tree PASSES |
| T-M3 | The kind check catches an untyped modification | Scratch PR that modifies a decision record's line with no Record changes line; a second that modifies a log entry | both FAIL; the same changes with a correct block PASS (the log modification still FAILS) |
| T-M4 | The chain check catches an unreachable record | Add a decision file not in its index; separately, remove a home from the map | both FAIL |
| T-M5 | The sync check catches a stale `DURUM.md` | Change the state file's waiting-for-Batu value without touching `DURUM.md` | FAIL; PASS after `records.py sync` |
| T-M6 | The channel stamp turns the F-036-1 omission into a failed stop | With `BUILDER_RUN=1`, a stamp older than the run's start | `builder_check.sh` FAILS naming the stamp |
| T-M7 | The stamp check catches an estimated future time | A state-file row stamped 10 minutes ahead of the clock | FAIL |
| T-M8 | Union merge removes the recorder conflict | Reproduce F-037-1 on a scratch repository: two branches each append a line to `owned_ids.txt`, then merge | no conflict; both lines present |
| T-M9 | A fresh session recovers **and uses** a decision's condition (acceptance (l), tightened) | A separate session, run by a role that did not write the records, given only the repository and the task: "Assume stage C03 has just closed and the audit environment is running. The builder wants to keep relying on the repository hook as the only connector barrier for the rest of the installation. Is anything recorded that bears on this, and what follows?" Pre-registered expected element: it finds D-003, quotes its condition (accepted until the audit environment exists, re-assessed at C03) and concludes that the acceptance no longer covers the situation and must be re-assessed, without being told where to look. | all three elements present, each traceable to a file it read (transcript) |
| T-M10 | A fresh session recovers state, open items and the reasons for key decisions with status (acceptance (l)) | Same separate role, task: "What is the current state, what is open on the active branch, and why was the dispatcher disabled?" | names the startable frontier from the generated view, the open notes of W-C00-12, and L-034's reason with its status (disabled pending W-C00-12 review), each with its source path |

## 12. Mechanism register rows

| Mechanism | Problem solved | Compensates for | Assumption | Cost | How it fails | Removal test |
|---|---|---|---|---|---|---|
| One home per fact (M-R1, M-R2) | Contradictory restatements | The model restates what it read | Homes can be named for every fact kind | Discipline on every write; enforced only where a check exists | A new fact kind without a home; caught by the chain check only if it lands in a file | OI-011 item 22 recurs |
| Records as files with front matter | Tables used as stores; untransferable prose | No structured store before C02 | A few dozen files stay readable with generated views | One script, migration once | Front matter drifts from Ek B names; caught at C02 transfer | The C02 transfer becomes manual interpretation |
| Boot map via `SessionStart` (§4) | The path to records depends on the actor remembering it | No memory across sessions | P-W12-1 (observed once) | One hook, a few hundred tokens per session | Hook fails silently; the check of the hook's exit is in the map piece | Boot depends on reading `CLAUDE.md` correctly every time |
| Change kinds and kind check (§5) | Corrections indistinguishable from additions | Edits look the same in a file | A diff can be classified by line change | One block per record PR | Wrong kind chosen; reviewed at closure | Old and new values coexist without status |
| Generated views and sync line (§6) | Stale restatements | Instructed updates decay | Views can be computed from records | Re-render before every merge | Script bug; covered by T-M2 | L-027 recurs |
| Channel stamp (§6) | Unread external answers | Instructed boot step skipped | The stop check runs (R1) | One line per run | Stamp written without reading (deliberate); stated | F-036-1 recurs |
| Stamp check (§6) | Estimated values | The model estimates | Clock available to the check | One check | Values outside the checked files | F-037-2 recurs |
| Union merge, recorder coverage (§7) | Recorder conflicts; unrecorded reminders | Versioned machine-written file | git's union driver; `send_later` returns an ID | One attribute line; one matcher change | Union keeps a wrong line (cannot occur with append-only lines) | F-037-1 and OI-011 item 24 recur |

## 13. Decision-and-basis record

- **Consulted:** plan Ek B §1, §3.2, §3.3, §3.4, §3.17 (status: Turkish plan, binding until translation; DevOS scope) as the record model to reuse; plan §9 introduction (ledger transfer acceptance); Batu's Original texts `BATU_MEMORY_LIFECYCLE_TR.md` and `BATU_STORED_IS_NOT_USED_TR.md`; library `beads/FINDINGS.md` (status: bounded-complete external-target study) for derived readiness, `discovered_from` and JSONL-as-view; `the-carbon-layer/videos/PxuMqeIqCEo-agent-memory/SOUL-DEVOS-ASSESSMENT.md` (status: review-ready source investigation, no adopted design) for history versus current basis and selective forgetting; `context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md` §11 (persistence ≠ memory ≠ context) and AP-08 (written rule ≠ enforcement); P-W12-1 (observed once); this run's failures F-036-1, F-037-1, F-037-2.
- **Left out on purpose:** the external memory products (`ai-memory`, `agentmemory`, `agent-memory-providers`, `openviking`: all "planned, research not started" in the catalogue, so no findings to use; and a third store would be a second source of truth); vector or semantic search for the builder's own records (a few hundred records are navigable by IDs and views; semantic search belongs to C04); one file per log entry (rejected in v1.1 for readability; unchanged).
- **Why it fits:** it reuses DevOS's own record model, so the builder's memory is round 0 of DevOS's, and the C02 transfer is mechanical. Every rule that previously depended on instruction now has a structure or a check, and each check maps to a failure that occurred.
- **Alternatives weighed:** (a) keep tables and add more instructions: rejected, it is the pattern that failed (FP 3, 4); (b) move to the database now: impossible before C02 (no schema, read-only connection); (c) one big JSON or YAML store: machine-friendly but unreadable for reviewers and Batu, and merges conflict worse than per-record files.
- **How it is tested:** T-M1 to T-M10 above; the counter-design's memory answer is compared with this piece; the independent review judges whether the checks catch the failures they claim to.

## 14. Open questions for the comparison with the counter-design

1. Is per-record files the right grain, or would per-stage files with structured blocks suffice?
2. Should the boot map also carry the startable frontier for runs only, if the role can be known at `SessionStart` (it cannot today; the hook does not see the first message)?
3. Is the channel stamp worth its cost, or should the stop check read the issue itself (it cannot today: scripts have no GitHub MCP access, and the `GH_TOKEN` variable's scope is unknown, OI-003)?
