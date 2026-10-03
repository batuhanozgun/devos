# W-C00-12 · 02 · Design piece 1: memory and records (object O4)

**Status:** candidate (W-C00-12 work product, not binding). Nothing here changes until the narrow re-review passes and the matching tranche is merged (`12_tranche_plan.md`). **Scope:** installation only, unless a row says otherwise. At C02 the live part moves to the database (§9); the file part stays. **Written:** first version 2026-10-03 by run `session_0143r88Vc9e5RbsQmqjYWgwa`. **Revision 3** (this text) was rewritten in place on 2026-10-03 by run `session_01XUsVQowRbLJdC1E8gFvxZq`, after review R-W12-1 (`10_r-w12-1_dispositions.md`, causes K1 and K2). The text is one design; earlier revisions are in git (`b1284c0` holds revision 1, `fe5e909` holds revision 2). **Serves:** needs N1, N4, N9 and cross-cutting condition X1 of `01_goal_down.md`; acceptance (l) in full; parts of (a2) and (m). **Tests:** `11_test_register.md`.

## 1. The problem, from what actually failed

Memory here means: the right actor notices a fact, recovers it with its status and conditions, and uses it (principle 15: stored ≠ retrievable ≠ retrieved ≠ used). The builder's records failed at each of those links:

| Failure (source) | Link that broke |
|---|---|
| The operating model's header said "Binding" while the state file said "not independently accepted" (OI-011 item 22) | One fact, two homes; no check compared them |
| The Next action row was stale after a merge (L-027) | A restatement updated by instruction only |
| Batu's answers on issue #6 were unrecorded for 35 hours (F-036-1) | An external source read by an instructed boot step that the sessions writing records did not run |
| OI-011 grew into one table cell of 24 items mixing observations, proposals and later-stage notes | No home for open notes on the branch they concern (acceptance (a2)) |
| The W-C00-12 acceptance cell grew to several thousand words in one table row | A table used as a record store |
| Log corrections are buried in later entries (L-030 correcting L-029) | Change kinds not typed; a reader of L-029 cannot see that it was corrected |
| Stamps written 6 minutes in the future (L-028); four estimated values in one hour (F-037-2) | A measurable value typed instead of measured |
| L-019 and L-021 named verdict files that never reached `main` (F-041-1, R-W12-1 M5) | A cited evidence path was never resolved against the tree |
| `owned_ids.txt` conflicted on branch switches (F-037-1, three times); `send_later` IDs never recorded (OI-011 item 24) | A recorder-written file versioned like a hand-written one; one creation path not covered |

The common cause: **records were designed as documents for a reader, not as a store with homes, kinds and checks.** Every fix so far added a sentence of instruction. This piece replaces instructions with structure where the structure is cheap, and with a deterministic check where it is not.

## 2. What is reused, not invented

Plan Ek B already designs DevOS's record store. The builder's file records are a **file-form subset of Ek B's families**, with the same IDs, axes and relation types, so that the C02 ledger transfer (plan §9 introduction: no duplication on re-run, resumable, links and versions match) is a mapping, not an interpretation (U-7). Adopted from Ek B, which is DevOS scope, and applied here to the builder:
- **Separate status axes** (Ek B §1 item 5, §3.3): a work item's execution, qualification and acceptance are separate fields; there is no single "done" (piece 2).
- **Revision, not overwrite** (Ek B §1 item 3): a meaningful change produces a new revision with a reason.
- **Typed relations** (Ek B §3.4): `depends_on`, `supersedes`, `derived_from`, `about`, plus `discovered_from` (beads study: provenance that does not imply order).
- **Decision fields** (Ek B §3.17): `answer_original_tr`, `answer_interpretation_en`, `answered_by`, `answer_channel_ref`, `reopen_triggers`, `status`, `supersedes`.

## 3. Record families and their one home

Each fact kind has exactly one authoritative home. Everything else points to it or is generated from it (§6).

| Family | ID pattern | Authoritative home | Form | Ek B family at C02 |
|---|---|---|---|---|
| Work item | `W-<stage>-nn` (children `W-<stage>-nn.m`) | `plan/work/<ID>.md` | front matter + body: the acceptance block (verbatim, with dated changes), open notes, history | Work, WorkStanding, Relation |
| Open note | `N-nnn` | the file of the work item it concerns (§3, M-R3) | a block inside the item | Need, Inquiry |
| Decision | `D-nnn`, `PC-nn`, `K<n>`, `B<n>`, frame reviews `FR-nn` | `plan/decisions/<ID>.md` | front matter + Batu's words verbatim + interpretation + conditions and reopen triggers | Decision |
| Evidence and test result | `EV-…`, `T-…`, `P-…`, `R-…` | `evidence/<stage>/…` (unchanged) | one file per claim; pre-registration before the result | Review, Verdict, Observation |
| Log entry | `L-nnn` | `plan/ledger/<stage>-log.md` (unchanged, append-only) | an entry + a **Record changes** block (§5) | Event |
| Failure pattern (heritage) | `FP-nn` | `plan/builder/heritage/FAILURE_PATTERNS.md` | lens, question to ask, source entries, status `candidate` or `qualified`, `qualified_by` | Learning |
| Premise | `BP-nn` | the premise table of the governing builder document | origin, status, from-scratch test | Premise |
| Governing document status | — | `plan/ledger.md`, section "Governing documents", only | one row per document: path, version, status, accepted by | Release |
| Owned session and routine IDs | session, trigger and reminder IDs | `.claude/hooks/owned_ids.txt`, written only by the recorder hook | append-only lines | SessionRecord, LaunchRecord |
| Current state | — | `plan/ledger.md` §1: stage, run lock, usage, waiting for Batu, the issue cursor (`answers seen through`), `summary_tr` | short table | live state in the database from C02 |

**Where builder files live (revision 3).** Records stay where they are under `plan/` and `evidence/`; the plan places the installation ledger there (plan §9). The builder's mechanism files (operating model, register, roles, heritage) also stay under `plan/` (`plan/Builder_Operating_Model.md`, `plan/builder/…`) until W-C00-06. At W-C00-06 every plan file is rewritten anyway, and plan §9 and Ek F, which name `plan/Builder_Operating_Model.md` as authoritative (R-W12-1 M7), change in the same step. The move to a separate `builder/` directory (OI-011 items 12 and 13; comparison D-21) is a plan-change candidate attached to W-C00-06, not a tranche 1 step. **Reason:** moving the files in tranche 1 would leave the binding Turkish plan pointing to a missing file (M7), and the scope label (M-R12) already marks the boundary in every record.

## 4. The root chain: from always-loaded to every record

Principle 15's extension: the path to knowledge must itself be remembered, from a root that is in context without any decision by the actor. P-W12-1 showed that a `SessionStart` hook's output reaches the model before its first tool call (observed once).

1. **Root, mechanical:** a `SessionStart` hook runs `tools/boot_map` and prints a **boot map**, generated at that moment from the files. It prints:
   - the home table of §3, from `plan/builder/MEMORY_MAP.md`, the one file that holds it;
   - the UTC and Turkey times from the clock, and the `main` SHA;
   - the failure patterns, one line each, qualified ones first, then candidates **labelled as candidates** (R-W12-1 B4b);
   - nothing about work state. Reviewers and counter-designers must not see work state, because of their input restriction. Role routing stays in the first message.

   The hook runs for every `SessionStart` source, including `compact`. So if the `compact` source fires after a compaction, the session is re-grounded mechanically. Whether it fires is unobserved (P-W12-3), and until it is, the re-ground arrow counts as instructed (piece 3, R-R9).
2. **Root, always loaded:** `CLAUDE.md` points to `plan/builder/MEMORY_MAP.md` and to the boot order, and imports the common floor (piece 3, R-R6). Both roots name the same map file; neither copies it.
3. **From the map:** each family's home, and for each home its index or view. A run then reads the state file and the startable frontier (piece 2).

## 5. Change kinds

Every pull request that changes an authoritative record carries, in its log entry, a **Record changes** block with one line per change:

`<record ID or path> · addition | correction | supersession | retirement | annotate · [supersedes <ID or revision>] · <reason>`

- *addition*: new content; nothing earlier loses validity.
- *correction*: earlier content was wrong; the reason is required; the corrected record names the earlier revision, which stays readable in git.
- *supersession*: earlier content was right when written and is now replaced (a decision, a plan change, a status).
- *retirement*: the record stops governing; it stays as history and leaves every generated active view.
- *annotate*: meaning unchanged (for example Batu's answer appended to a decision record, or a later note on an evidence file).

Front matter carries `revision` and, where relevant, `supersedes` and `superseded_by`. A superseded or retired record stays in its home with its status, so history and current basis stay apart.

## 6. Restatements: generated, or checked

- **Generated views.** `tools/records.py render` generates these into marked blocks of `plan/ledger.md` (`<!-- generated:<name> -->` … `<!-- /generated -->`):
  - the work index;
  - the startable frontier (piece 2);
  - the decisions index;
  - the open-notes view.
- **`DURUM.md`** is generated by `tools/records.py durum` from the homes and a Turkish template (comparison D-22). The template's first line is "Senden beklenen". Its fact lines come from the homes: stage, active run, last update from the clock, what is expected from Batu, usage, frontier and the armed wakes. The prose summary is one `summary_tr` row of the state file, written by the run at each checkpoint. The template also states the continuity residual (piece 5, C-R4): after four empty check-ins, an answer from Batu waits for the next session.
- **Prose restatements of a few facts.** These are facts that must appear in prose, for example a document's status in a briefing. They carry a marker, `<!--fact:key-->value<!--/fact-->`, checked against the home (D-24). There is no phrase warning.
- **Batu's channel.** Issue #6 is the authoritative source of Batu's answers until a decision record holds them. The stop check reads it (§7, M-R13).
- **Measured values.** Sizes, counts and conversions are produced by commands whose output is pasted, and the decision-and-basis record names the command. Times are typed (M-R14).

## 7. Rules

Status: **active** (built in the tranche named), **deferred** (built only when its trigger fires; `12_tranche_plan.md` lists the triggers), **retired** (kept as a row so that references resolve; superseded by the rule named). Every active rule has a test in `11_test_register.md`.

| ID | Rule | Status | Tranche | Scope | Test |
|---|---|---|---|---|---|
| M-R1 | **One home.** A fact is written only in its home. Another file may name its ID or path, never restate its value, except in a generated view, in `DURUM.md` (generated) or under a fact marker. | active | 1 | installation | T-M4, T-M1 |
| M-R2 | **Governing-document status lives only in the state file.** A governing document's header says `Status: see plan/ledger.md, Governing documents` and carries no status word of its own. `check_records.py docstatus` fails on a status word in a governing document's header, or on a fact marker whose value differs from its home. A change to a Governing-documents row is impact class high (piece 2, W-R7). | active | 1 | installation | T-M1, T-W9 |
| M-R3 | **Open notes attach to the branch they concern.** A discovery about other work is written into that item's file, with `discovered_from` the item where it arose. If the item does not exist, a `planned` candidate item is created under the right stage. A note whose branch is unclear attaches to the nearest known ancestor, at worst the stage item. There is no inbox (D-43). | active | 1 | installation | T-M11 |
| M-R4 | **Chain check.** `check_records.py chain` fails if any of these holds: a family in the map has no existing home; a file under a home directory is missing from its generated index; an authoritative file named in `CLAUDE.md` or the map does not exist; an authoritative file lies outside every home. It runs at stop, and again at boot through `tools/boot_map` (the counter-design's boot-time repeat; a failure prints at the top of the map and does not block). | active | 1 | installation | T-M4 |
| M-R5 | **Kind check.** `check_records.py kinds` reads the PR diff against `main`. A deleted or modified line in an authoritative record requires a Record changes line naming that record with a kind other than addition. A correction line must give a reason. A pure append requires an addition or annotate line. The log is append-only: a modified log line fails, and a correction of a log entry is a new entry that names it. | active | 1 | installation; DevOS at C02 (Ek B §1 item 3) | T-M3 |
| M-R6 | **View check.** `check_records.py views` re-renders every generated block and `DURUM.md`'s fact lines, and fails on any difference from the committed text. | active | 1 | installation | T-M2 |
| M-R7 | *Sync line in a hand-written `DURUM.md`.* | retired | — | — | superseded by M-R15 (generated `DURUM.md`); T-M5 retired |
| M-R8 | *Channel stamp.* | retired | — | — | superseded by M-R13; T-M6 retired |
| M-R9 | *Stamp check: no future times; "As of" within 30 minutes.* | retired | — | — | superseded by M-R14 |
| M-R10 | **Union merge.** `.gitattributes` gives `.claude/hooks/owned_ids.txt` git's built-in `merge=union` driver, so two branches' recorder lines merge without conflict. | active | 1 | installation | T-M8 |
| M-R11 | **Recorder covers `send_later`.** The recorder's matcher adds `send_later`. Its response shape is taken from one live call before the recorder changes; the parsing rule (one ID from a named field, otherwise nothing) stays. The existing reminder `trig_015TYQ5f5QowWGLJTRJqQ4HJ` belongs to Batu's conversation session and is not added by hand. | active | 1 | installation | T-M12 |
| M-R12 | **Scope label.** Every builder record's front matter and every register row carries a `scope:` field with one of the values `installation`, `devos` or `soul`. The record check fails on a missing value. | active | 1 | installation | T-M13 |
| M-R13 | **Batu's answers are read at stop.** `builder_check.sh` reads the issue's comments through the GitHub REST API with `curl`, which in this environment goes through the agent proxy. The proxy authenticates the request (R-W12-1 M4: rate limit 15,000), so the dependency is the proxy's credential and availability, not the public API. The check **fails** in two cases. First, a comment by `batuhanozgun` is newer than the state file's `answers seen through` cursor and is not quoted in a decision record. Second, the read itself fails; this failure is named `ISSUE_READ_FAILED` and is never only a warning. A run that hits `ISSUE_READ_FAILED` reads the issue with the GitHub MCP tool, records what it saw in the log, and stops at S3 for that reason if the script still cannot read it. | active | 1 | installation; replaced by DevOS's decision channel (C06) | T-M6r |
| M-R14 | **Typed times** (R-W12-1 B3). A time written in a changed line of the state file, `DURUM.md` or a new log entry is of one of three types, recognised by its field: (1) **scheduled**: the lease expiry (`Expires …`), wake times (`wake at …`), reset times (`resets …`). It must be in the future at commit time and bounded: a lease expiry at most 3h15m ahead, a wake at most 25 hours ahead, a reset at most 7 days ahead. (2) **stamp**: an "As of" cell, the log header time and `DURUM.md`'s update line. It must lie between 15 minutes before the commit time and the commit time. (3) **quoted**: any other time in prose. It must not be later than the commit time. A time prefixed `about` is a stated estimate and is accepted only as quoted. The commit time is the author time of the commit that introduced the line (`git blame`). | active | 1 | installation | T-M7a, T-M7b, T-M7c |
| M-R15 | **Generated `DURUM.md`** (§6, D-22): fact lines generated; prose only in `summary_tr`; the template states the continuity residual. | active | 1 | installation; replaced at C06 | T-M5r |
| M-R16 | **Claims resolve** (R-W12-1 M2 and M5, one check). `check_records.py claims` fails if any of these holds: (a) an `evidence/…` path named in a log entry, a work item or a decision record does not exist on the tree at the PR head; (b) a verdict file under `evidence/*/reviews/` is not byte-identical to a blob on its review branch `claude/review-<ID>`, or the verdict does not name the reviewed commit, or its commit author session is the producer's (D-07). Claims about another session's actions are **not** checked mechanically in tranche 1 (part c, deferred, trigger in `12_tranche_plan.md`). Until then the rule is instructed: read the transcript (`list_events`) and cite the event, as L-030 required. | active (a, b); deferred (c) | 1 (a, b); 2 (c) | installation | T-M14, T-M15 |
| M-R17 | **Log header written by a script** (`tools/records.py log`: ID, clock time, session, Record-changes skeleton; D-34). | deferred | 2 | installation | T-M16 |
| M-R18 | **Boot map via `SessionStart`** (§4). A `SessionStart` hook in `.claude/settings.json` runs `tools/boot_map` for every source. It prints the home table, both clocks, the `main` SHA, the chain check's result and the failure patterns, with candidates labelled. It never prints work state. A failure of the script prints an error line and does not block (the session can still boot by `CLAUDE.md`). | active | 1 | installation; candidate for DevOS common rules (C05) | T-M17 |

**K2 walk-through: the rules against ordinary records** (R-W12-1 cause K2). The current `main` records were run through each check on paper before the rule was accepted. Tranche 1's tests repeat this on the migrated tree.

| Ordinary record | M-R5 kinds | M-R14 times | M-R16 claims |
|---|---|---|---|
| A lease renewal (Run lock row modified) | the state file is an authoritative record, so the PR needs a supersession line. **Cost:** one line per lease PR; `tools/records.py lease` writes the row and the line together. | "Expires 21:23Z" is scheduled and must be at most 3h15m ahead, which passes; "As of 18:23Z" is a stamp and passes | none |
| The Usage row | supersession | "at 18:08Z (`get_session`)" is quoted (not an As-of cell), so it passes even when more than 15 minutes old; "resets 20:10Z" is scheduled, at most 7 days ahead, and passes | none |
| L-040, quoting Batu's 2026-10-02T06:27Z answer and own-session times hours old | addition | all quoted and none in the future, so it passes. Requiring a source reference on each quoted time (R-W12-1's suggestion) was walked through L-040 and L-041: about 30 times per entry, which is the marker noise the review warns against. **Deviation, with reason:** the observed incidents (L-028 future stamps; F-037-2 stamps and an unconverted reset time) are caught by the scheduled and stamp types. A past estimate in prose is not caught; that residual is stated in the register row. | its `evidence/…` paths exist, so it passes |
| A verdict copied with `git show` (R-W12-1) | addition | the reviewer's "about 18:00–18:40Z" is prose in an evidence file, outside the checked files | byte-identical to `09a5470:evidence/C00/reviews/R-W12-1.md`, so it passes |
| L-019 and L-021 at their commits | — | — | **would fail** (a): the two verdict paths were missing. This is the M5 case, now caught. |
| The W-C00-06 translation rewriting every plan file | each plan file changes, so the PR needs a supersession line per file (one generated block) | — | none |
| Batu's answer appended to D-002 | annotate | "2026-10-02T06:27Z" is quoted and passes | `answer_channel_ref` is the comment URL; not an evidence path |

## 8. What a fresh session recovers, and uses

The rules above make recovery possible. Acceptance (l) requires that it is shown, for use and not only retrieval. Decision records therefore carry their **conditions** and **reopen triggers** as fields, because continuity that carries the decision without its condition is the "false continuity" Batu named (`BATU_STORED_IS_NOT_USED_TR.md`). Example: D-003's acceptance holds "until the audit environment exists (C02–C03); re-assessed at C03". A task that assumes C03 is done must surface that D-003 no longer covers it. Tests T-M9 and T-M10 show this. They are run by a Verifier session given only the repository (piece 3), not by the records' writer.

## 9. Scope and hand-over

| Mechanism | Scope | Replaced by | Hand-over trigger |
|---|---|---|---|
| File record families, views, checks (M-R1–M-R6, M-R12, M-R16) | installation | DevOS database families (Ek B) and `devos_api` | C02 ledger transfer accepted (plan §9 introduction) |
| Boot map via `SessionStart` (§4) | installation; the pattern is a candidate for DevOS's common rules (C05) | DevOS `session_brief()` (C04) | C04 acceptance |
| Change kinds (M-R5) | DevOS (Ek B §1 item 3 already requires revision with reason) | database revisions and events | C02 |
| Generated `DURUM.md` (M-R15), issue read (M-R13) | installation | DevOS status page and decision channel with identity check (C06; plan C01 row 11) | C06 |
| Union merge and recorder coverage (M-R10, M-R11) | installation | environment tokens and launch records (Ek B §3.24) | C02–C03 |
| Typed times (M-R14) | installation; candidate for Ek B's Observation fields | database timestamps written by the server | C02 |

## 10. Transfer to the database (C02)

The front-matter fields are named as Ek B names them, so the transfer is field-to-field:
- work items → Work + WorkStanding (status axes) + Relation rows;
- open notes → Need, with `return_to` set to the item;
- decisions → Decision, with `answer_original_tr`;
- the log's Record changes blocks → Events with revision links;
- failure patterns → Learning.

Re-running the transfer must create nothing new, because IDs are stable. After it, `plan/ledger.md` carries the hand-over mark of plan §9. This piece does not design the database; it makes the files transferable.

## 11. Decision-and-basis record

- **Consulted:** plan Ek B §1, §3.2, §3.3, §3.4, §3.17 (status: Turkish plan, binding until translation; DevOS scope) as the record model to reuse; plan §9 introduction (ledger transfer acceptance); Batu's Original texts `BATU_MEMORY_LIFECYCLE_TR.md` and `BATU_STORED_IS_NOT_USED_TR.md`; library `beads/FINDINGS.md` (status: bounded-complete external-target study) for derived readiness, `discovered_from` and generated views; `the-carbon-layer/videos/PxuMqeIqCEo-agent-memory/SOUL-DEVOS-ASSESSMENT.md` (status: review-ready source investigation, no adopted design) for history versus current basis; `context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md` §11 and AP-08 (written rule ≠ enforcement); P-W12-1 (observed once); R-W12-1 (B3, B4b, M2, M4, M5, M7) for revision 3; the records on `main` at `d69d7c6` for the K2 walk-through. The revision-3 library consultation on temporal record fields is recorded in `12_tranche_plan.md` §6.
- **Left out on purpose:** the external memory products (`ai-memory`, `agentmemory`, `agent-memory-providers`, `openviking`; "planned, research not started" in the catalogue, and a third store would be a second source of truth); semantic search over the builder's own records (a few hundred records are navigable by IDs and views; it belongs to C04); one file per log entry (rejected in operating model v1.1 for readability).
- **Premises, from scratch:** records are a store, not documents (yes: every failure of §1 is a store failure); a check catches a failure only for the files it reads (yes; hence the stated residuals of M-R14 and M-R16(c)).
- **Alternatives weighed:** (a) keep tables and add more instructions: rejected, it is the pattern that failed (FP 3, FP 4); (b) move to the database now: impossible before C02 (no schema, read-only connection); (c) one big JSON or YAML store: machine-friendly but unreadable for reviewers and Batu, and merges conflict worse than per-record files; (d) a source reference on every quoted time: rejected by the K2 walk-through above.
- **Reopen if:** a past estimated time in a log entry misleads a decision (the M-R14 residual); a claim about another session is found wrong again (re-admits M-R16(c)); the C02 transfer finds a field without an Ek B home.
