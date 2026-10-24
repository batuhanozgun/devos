# U03-A — Work/session records, pickup policy and actual control boundaries

**Date:** 2026-09-17. **Pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. **Questions:** Q04, Q08, Q01 and Q10. **Evidence:** pinned source/test-source reading and E02, a local unchanged-helper experiment with an in-memory store double. No real ECC installation, SQLite instance, provider, agent or remote work mutation was executed. [Exact coverage](../evidence/U03-A-SOURCES.md).

## 1. Bounded result

ECC has several related but non-identical work surfaces: local work-item records, normalized session observations, a SQLite session/query model, and status/coordination views. The inspected work-item path does perform real local record mutations; it is not merely documentation. However, a `running` card, a claimed owner, a persisted snapshot and an `ok` readiness summary do not establish a running or safely resumable agent.

The default adapter recording contract and the SQLite session query contract are also not connected merely by both using the term state store. At this pin, the adapter persistence helper recognizes snapshot-writer methods; the imported state-store module instead exposes a factory. The helper explicitly falls back to JSON recording for that factory shape. The `sessions` CLI reads SQLite, not those fallback JSON recordings. This is a specific default-path seam, not a repository-wide claim that no integration can exist.

A separate external-sync boundary is source-derived: a bounded list of open GitHub items is used as the active set for locally closing previously imported items absent from that list. Absence from that limited list is not reliable evidence of remote closure. This path was not executed in U03-A.

## 2. What a work item represents and changes

S57 accepts manual/source-labelled upserts, local close, claim and GitHub import. A `linear` source label is accepted as data; it does not demonstrate a Linear API integration. The actual GitHub sync invokes `gh ... list`, then writes local records. The local close command changes a local status through `upsertWorkItem`; it does not invoke remote issue/PR closure.

The source-to-consumer chain established in this slice is:

`CLI input or imported GitHub result → work-item payload → schema validation → SQLite upsert → list/status consumers`

and, for pickup:

`explicit id or bounded candidate query → claim helper → owner/status/session metadata update → same local store`.

S58's upsert replaces mutable fields on id conflict while retaining the database row's original `created_at`. S66 permits a nonempty status string rather than a closed workflow transition graph. S69 declares an optional foreign key from work_items.session_id to sessions.id, with ON DELETE SET NULL; the store factory enables foreign keys. That is structural linkage to an existing session record, not proof of session liveness, authority, accepted work or execution causality. No SQL or foreign-key runtime test was performed here.

The model does not collapse every relation into that one field: skill runs and decisions are separate tables, and session workers are taken from the stored snapshot by `getSessionDetail`. Querying a session detail returns its workers, skill runs and decisions; the work-item reference does not by itself cause dispatch or resume.

## 3. Claiming is a concrete record policy, not an exclusive execution lease

S59 is a small shared helper used directly by the CLI. Without an explicit id it requests 100 recent work items, filters out owned and terminal cards, and sorts the returned candidates by priority. The actual S58 list query orders by updated time before imposing the limit. Thus priority is evaluated within that returned window, not necessarily over all recorded work.

Its open-status predicate means not in `done/closed/resolved/merged/cancelled`. It does not exclude `blocked`, require a prerequisite graph to be satisfied, authenticate an owner string or allocate an agent. Explicit-id selection does not use the automatic unassigned filter: an already-owned nonterminal card can receive another owner. Claim defaults status to `running`; move validates the destination lane and changes the status, without imposing a source-state transition graph.

[E02](../evidence/u03-a-work-item-probe/README.md) executed the unmodified S59 blob against a new in-memory store double:

| Case | Actual observation |
|---|---|
| C0: unassigned open baseline | Claim wrote owner `worker-a` and status `running`. |
| C1: higher-priority blocked card versus normal open card | Automatic pickup chose the blocked card and set it to `running`. Synthetic prerequisite metadata remained untouched. |
| C2: explicit claim of an already-owned running card | Owner changed from `alice` to `bob`; the old session link remained. |
| C3: explicit claim of a done card | The helper threw its already-done error and wrote nothing. |
| C4: move a done card to ready | Status became `open`; owner and session link were retained. |
| C5: critical card outside the latest-100 window | The helper asked for 100 rows and chose a lower-priority card inside the returned window. |

The criteria were recorded before execution, after reading source. Six criteria matched; that is six observations of the predicted semantics, not six successful product-safety tests. C3 establishes that this probe can observe a real refusal and a zero-write outcome. C1's `blockedBy` key is synthetic illustrative metadata, not a claim that ECC defines or enforces that dependency field.

These are not automatically defects. A human-operated board may intentionally permit reassignment, reopening and overriding a blocked label. The invalid inference would be to reuse these helpers as if they guaranteed dependency-ready selection, exclusive ownership or live execution. The inspected helper/query composition performs selection followed by upsert; it does not establish a multi-process claim lock or lease. Concurrent execution and any surrounding server authentication remain untested and outside this slice.

## 4. Imported authorship and local assignment can share a field without sharing meaning

S57 builds imported PR/issue `owner` from the GitHub author's login, not from an assignee field. Draft or DIRTY PRs become blocked; other open PRs and open issues become needs-review. These are ECC's import classifications, not complete remote workflow semantics.

A later sync upserts the same stable local id and replaces owner, status, sessionId and metadata with the newly built payload. Therefore a local claim/close and a subsequent source refresh can disagree: source code permits the import to replace a local execution owner with the author again, or a locally closed card with an open-source classification. No independent mutation history or field-by-field authority merge is implemented in this inspected upsert path. This is a source observation, not an executed remote sync incident.

The broader design question is not whether source refresh is inherently wrong. It is which fields represent source facts, local assignment and local progress, and which producer is entitled to overwrite each field. A shared column name is not enough to answer that.

## 5. Bounded retrieval must not silently become evidence of closure

`syncGithubWorkItems` fetches open PRs and issues using an explicit `--limit`; the CLI default is 20 for each call. It collects only those returned ids. `closeStaleGithubItems` then examines a separately bounded local list, restricts it to this repo and this sync producer, and sets absent non-done/non-closed records to `closed`, adding a locally generated `sourceClosedAt` timestamp.

The current official GitHub CLI manuals describe `--limit` as a maximum fetched count (W03/W04), corroborating the intended option semantics without validating any particular installed CLI build.

A counter-path follows directly: an issue imported in an earlier run can still be open remotely while falling outside a later limited result. If it is inside the scanned local window, this code can classify it as closed. The helper performs no item-specific remote state read or completeness check in that path. The timestamp is generated locally; it is not the remote issue's authoritative closed-at event.

The remote-list commands are both read before the upsert loops; an immediate command/JSON failure is not silently converted into an empty successful list. Also, the stale sweep is producer/repository-scoped and itself limited; it neither closes every missing item in the database nor targets manual records indiscriminately. These protections do not remove the partial-list inference problem.

This result remains **SOURCE-DERIVED / NOT EXECUTED**. It does not establish an observed production incident, its prevalence, or the behavior of a newer ECC version. Reopen Q04c before relying on sync-derived closure for scheduling, deletion, acceptance or completion.

## 6. Normalized session snapshots are not automatically SQLite session rows

S60 → S61 → S62 opens the selected adapter and requests a snapshot. The dmux adapter calls `collectSessionSnapshot`, normalizes its result and invokes persistence by default unless disabled through adapter/context options. The raw collector and actual worktree launcher are next-unit dependencies, not implicitly read here.

S63 carries session identity/state, worker runtime observations, intent, outputs, artifact paths and aggregate counts. It keeps worker health separate from state: running/active workers can be stale or degraded; completed labels can produce healthy classification without reperforming output validation. A live tmux session takes precedence in the session-state derivation. These are mapping rules, not independently verified task outcomes.

Persistence has its own contract:

- `persist: false` skips recording.
- Recognized top-level or nested snapshot-writer methods receive the canonical snapshot.
- The default imported S53 module exposes `createStateStore` and other helpers, not those recognized writer names. When dependencies load normally, that factory object takes the explicit no-writer JSON fallback branch. Even an `upsertSession` name is not among the recognized writer names.
- Fallback records contain `latest` and changed-snapshot `history`, with the default recording directory under `os.tmpdir()` unless configured otherwise. An inspection can therefore write a recording even without `--write` on the CLI.
- Other load/write failures are not all converted into fallback success; for example, non-missing-module bootstrap errors propagate.

S67 explicitly tests a fake nested writer, a factory-shaped no-writer fallback and missing-module/error distinctions. Those test sources were fully read, NOT RUN.

By contrast, S56 opens a SQLite store and reads `listRecentSessions` or `getSessionDetail`. S58/S66 require a flat row input including `id`, `adapterId`, `harness`, `state` and a nested snapshot field. The adapter's `ecc.session.v1` object is a different shape. S56 does not ingest fallback files or construct the missing bridge. Thus writing a fallback snapshot does not, by this inspected chain alone, populate the sessions CLI.

This does not mean all ECC session persistence is broken or that an explicitly supplied writer cannot integrate it. It means the default recording path and this reader have distinct interfaces/storage. A search miss for other producers is not evidence of their global absence. Actual database ingestion elsewhere, live consumers and Rust ecc2 state remain open in Q04b/Q04d.

## 7. Readiness is a summary with an optional machine signal

S58's active-session query uses stored state in active/running/idle and ended_at IS NULL. It performs no process probe or age-based liveness check. `generatedAt` dates generation of the report, not a fresh observation of every session. A stale stored running row can remain active under this predicate until another producer updates it.

The work-item aggregate counts all rows, then narrows only the displayed item list; it would be wrong to call every count a latest-N sample. Skill outcomes, by contrast, are summarized over a recent window. Readiness aggregates attention from failed runs, installation warnings, unresolved governance events and attention-labelled work items. It does not establish that a particular task's prerequisites, resources, permissions or owner are valid.

S65 rechecks installation projections/health separately and incorporates warning changes. Its optional `--exit-code` emits code 2 for attention. That is a real machine-consumable signal, not just prose. The command does not itself stop/start/resume workers, and no downstream enforcement consumer was audited here. Do not turn 'can be used by a gate' into 'is enforced everywhere'.

## 8. Evidence and competing readings

The overly positive reading is that canonical schema, owner and running labels form one integrated execution control system. The distinct interfaces, pickup predicates and default fallback contradict that shortcut. The overly negative reading is that these are useless labels. They are concrete record-writing, query, normalization, history and operator-follow-up mechanisms, with real validation and refusal branches. Their operational value must be scoped, not denied.

E02 is the only new local execution. It exercises one unchanged helper and a store double, not SQLite constraints, adapters, imports, a real queue, a provider or concurrent agents. The external-sync and default-recording conclusions remain source-bound. S67's test harness uses injected snapshots/writers and temporary files; it cannot be promoted to a passing live-host integration test.

The source search index returned a different default-branch ref during discovery. Every load-bearing new body was fetched at the original research pin; no silent repin occurred. P1 remains partial. Installation Q03b/Q03c and original E01 remain preserved rather than repeated or closed.

## 9. Disposition and continuation

Q04a is bounded-answered for local card production/mutation/query and status signalling. Q04b tracks adapter-recording to SQLite ingestion/consumer integration. Q04c tracks imported field authority and limited-list closure. Q04d continues actual worktree/session dispatch, handoff and recovery. Q08 now distinguishes stored activity, snapshot health, attention counts and enforcement.

Next **U03-B** starts with the already-discovered `scripts/orchestrate-worktrees.js`, `scripts/lib/orchestration-session.js` and `scripts/orchestration-status.js`. Follow the real plan/worker/task/status/handoff producers to process actions and acceptance/recovery. Control-pane server and GitHub-epic coordination are separate possible consumers, not assumed equivalent to local card claiming; Rust ecc2 remains distinct.

MR04 evaluates the actual transition away from installation: different session contracts were recovered instead of importing JSON/projection assumptions from U02-A. A small exact-helper probe checked consequential pickup assumptions without a product-install campaign. Final subsystem/CORE/project-facing synthesis remains later; no Foundation or architecture adoption follows.
