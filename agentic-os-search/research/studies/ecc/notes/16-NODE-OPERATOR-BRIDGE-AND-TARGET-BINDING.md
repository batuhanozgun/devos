# Note16 — Node operator bridge and target binding

**2026-09-18 · U09-B / Q04g2 · bounded source inquiry.** Pin: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact source coverage](../evidence/U09-B-SOURCES.md), [MR17](../ROUND-U09-B.md), [STATE](../STATE.md). This extends the separate Rust lifecycle explanation in Notes13–15 without importing its conclusions into every Node path.

Evidence is SOURCE OBSERVATION and explicitly bounded INFERENCE, plus inspected-but-unexecuted target tests. No ECC installation, Rust build, provider/model, live user server, new fixture or E08 occurred. E07 retains its previous SQL/Git scope; historical E06 remains excluded. No corrective implementation or SOUL architecture is adopted.

## 1. Question and answer

What does the Node control-pane actually observe and command, and how do its actions relate to Rust ECC2, the separate work-item store and message delivery?

It is an implemented operator bridge, but not one homogeneous controller. The examined routes combine two independently shaped data stores, a local snapshot/recall implementation, allowlisted Rust subprocess shortcuts, direct card mutations, advisory views and a separate proximity-message CLI. Each route has a different target-selection and success contract.

The decisive result is not merely that two database files exist. A displayed target is not automatically the target of a subsequently launched command. Likewise a rendered advisory is not a delivered instruction, a successful sender call is not recipient uptake, and a card moved to running is not a started worker. A concrete producer/consumer mismatch makes the message distinction testable at source level: steer/hold messages are generated as conflict messages without a file argument that the pinned Rust consumer requires.

## 2. Native route map

| User-visible operation | Actual route | What the result establishes |
|---|---|---|
| Sessions, connectors, page Recall | Node imports the selected ECC2 database file through sql.js, queries and scores locally | A derived view of imported bytes and bounded rows, not a live Rust API response |
| Work Items / claim / lane move | Node reads or opens the selected ECC state.db, calls shared mutation/query helpers and persists its image | A changed card record; no Rust process launch in this path |
| Sync Knowledge / Recall Knowledge / Backfill Graph | Fixed Cargo argv executed from repoRoot/ecc2 | Subprocess outcome against Rust's independently resolved configuration |
| Open TUI | Displayed command only; server rejects execution of this copy-only action | A suggested command, not a launched terminal |
| Proximity / control-plane GET views | Snapshot → proximity adapter → projection/inventory view | Advisories and declarations; the HTTP paths do not invoke the message sink |
| proximity-tick CLI | Snapshot → triggers → dispatcher → ecc-tui messages send | An attempted message command; failure can be skipped, and success is not recipient action |

Sources: S12, S206–S215 and re-entered S53/S58/S59/S69/S181/S186/S195. The ordinary browser client has no session start/stop/resume buttons in the reviewed script. This does not make every shortcut harmless: Backfill Graph has transitive runtime-policy effects described below.

## 3. Observed database versus commanded database

The panel resolves its snapshot database from explicit options, ECC2_DB_PATH or Node configuration. Its work-item store has a separate stateDbPath. However, the action route calls buildControlPaneAction with repoRoot, query and limit only. The builder emits cargo run arguments and sets cwd to repoRoot/ecc2; it does not pass the resolved snapshot database or configuration path. runAction inherits process.env rather than converting the panel's resolved configuration into a Rust target binding.

Rust main independently executes Config::load and opens cfg.db_path before dispatch. The inspected loader does not consume the panel's explicit --db selection. Its global/nearest-project configuration rules also differ from Node's: Node accumulates candidate files from its starting directory through ancestors, with later files overriding earlier ones; Rust uses global layers and the nearest directory containing project files. The server usually resolves from repoRoot, while its Cargo command starts in repoRoot/ecc2. Server-resolved settings are retained, whereas a new Rust process reloads its settings.

**Conditional counterexample:** the operator selects database A in the panel, while Rust configuration resolves database B. A shortcut can successfully execute against B, and the subsequent browser refresh can still read A. The command's zero exit code does not establish that A changed. The same category of mismatch applies to a separately selected configuration file, project precedence or a configuration edit between startup and action. This is not a measured incident and does not imply all ordinary installations mismatch.

**Positive counterpart:** with aligned paths/configuration and available dependencies, the shortcuts really invoke Rust commands, rather than merely rendering a command description. The distinction is between working delegation and verified target correspondence. The current code provides the former route, not a universal proof of the latter.

The proximity CLI repeats this seam: it uses --db/--state-db to build its snapshot, but constructs createEccMessageSink({}) without supplying that target. The sink chooses an executable through override/environment/built-path/PATH and leaves its working directory/configuration implicit. Source pin, chosen executable and observed database are therefore three different identities.

## 4. A graph shortcut can also invoke runtime controls

Backfill Graph maps to graph sync --all. The Rust GraphCommands::Sync arm calls sync_runtime_session_metrics before graph-history backfill. That helper refreshes duration and cost/tool metrics and invokes heartbeat and hard-budget enforcement. The earlier Rust study traced applicable branches that change session state or request process termination.

Thus the shortcut's description as graph backfill is narrower than its full call path. This is not a new claim that clicking it always stops workers: the actual effect depends on selected database, configuration and session/metric conditions. It is nevertheless a real control dependency, not a UI-only label or imagined link.

Connector-sync and recall have their own command arms. The page's Recall form is different again: it requests a Node snapshot and uses Node's local recallKnowledgeEntries. The separate Recall Knowledge action invokes Rust recall and prints its subprocess result; after success the page reloads its Node-scored view. Similar names and query text do not establish algorithmic or result equivalence. Full connector/parser/recall quality remains outside this bridge slice.

## 5. Two stores do not share session authority merely through an id

Rust ECC2 sessions contain task, pid, worktree, state, heartbeat and process metrics. The separate state.db sessions table contains adapter/harness state and a JSON snapshot. Its work_items.session_id foreign key refers to that same state.db sessions table, not across files to the Rust process record.

The HTTP card mutation does preserve one useful target binding: withStateStore receives resolvedConfig.stateDbPath, which is also used by the work-item snapshot reader. Claim/move calls the shared helper and upsert API; on successful response the client reloads the snapshot. The target test source includes this temporary-store HTTP write/readback route.

That does not turn a claim into exclusive execution ownership. Explicit-id claim can replace an existing owner; the browser's choice to hide Claim on assigned cards is not the API's invariant. Lane movement can reopen or close a card without verifying a goal-specific acceptance predicate. No worker is started by the reviewed mutation chain. Those are flexible card semantics, not automatically a defective process scheduler; the process-scheduler interpretation would itself be wrong.

S53 imports a whole database into sql.js and persists exports through a private temporary file, fsync and atomic rename, with symlink/regular-file checks and per-instance transaction handling. These are real persistence protections. They do not constitute merging or locking between independent imported images. Two separately opened writers can start from different images; a later whole-image save or close need not incorporate the other writer's changes. This is a conditional source-level concurrency boundary, not a reproduced lost update or a claim that a rename itself is non-atomic.

## 6. Snapshot, freshness and error meaning

The snapshot reader opens file bytes, not a live query connection to Rust's StateStore. It reads the two databases separately, and generatedAt describes snapshot construction, not a verified shared commit/revision. On the inspected paths, sessions and work items are limited to 100, entities to 500 and observations to 1,000. Session/card summary counts are calculated from those selected rows. The main card UI then displays at most eight cards. These nested limits matter when interpreting totals, absent work or recall coverage.

Missing database files can produce an empty base snapshot. Work-item read errors are caught and converted to an empty work summary, whereas ECC2 database/open/query errors can propagate to an HTTP error. An existing-file flag does not validate contents. The health endpoint can report ok with database paths without opening the databases or validating Cargo, a built binary or a functioning worker.

Journal behavior must stay qualified. SQLite's WAL documentation explains why main-file-only bytes can omit committed state stored in an uncheckpointed WAL. But the re-entered Rust open function does not enable WAL, and no actual journal mode was observed. Therefore this research does NOT diagnose a default ECC WAL failure. A WAL-bearing or concurrently copied environment is a reopening condition; source acquisition alone is not a consistent-backup certification.

The normal page polls every 15 seconds while visible. Background polling errors are swallowed, so previously rendered content can remain without a new error display; explicit initial/manual refresh errors follow a visible error path. The advanced control-plane adapter separately caches a sample for five seconds and shares an in-flight refresh. A browser poll, a new sample and a fresh underlying record are distinct events.

## 7. Command result, termination and refreshed evidence

The server has useful concrete controls: read-only rejects action and card POST routes before body processing; only named actions are built; the dashboard action is copy-only; actual child execution uses argv rather than a shell command string. Host/Origin hostname checks run before routing, and the main client escapes text and work-item attributes.

Those controls have bounded meanings. A configured host may be added to the hostname allowlist, and an absent Origin is accepted; this is not authenticated operator identity or a guarantee that every configuration binds only loopback. The read-only setting controls this server's mutation routes, not the separate proximity-tick process or every possible external writer.

runAction reports success from exit code zero. Its timeout sends SIGTERM but does not itself produce a verified process-tree termination or a guaranteed hard deadline; completion is resolved through error/close handlers. Its 20,000-character display bound is applied after output accumulation, so it is not a cap on accumulated memory. The inspected timeout test uses a cooperative Node child, not Cargo descendants or a process that ignores termination.

The API returns code, signal and captured output, but the client first rejects non-success HTTP responses. When the error payload has no error field, the normal child-failure diagnostics can collapse into a generic status in the UI. The client reloads after success, not immediately after this failure path. No rollback couples an earlier target effect to HTTP success or to the later snapshot read. A command can have partially acted before failing, and a refresh can read an independently selected target. These are separate evidence boundaries, not a demonstrated failure rate.

## 8. Proximity: the producer/consumer mismatch

The default proximity working-set source runs git diff against base...HEAD. It therefore describes committed branch changes on that command path, not all unstaged, staged or untracked edits. Failures return an empty working set, and the adapter does not filter supplied sessions by lifecycle state before attempting collection. Lack of participating agents is consequently not a general absence-of-collision result. Imported scoring/projection/dependency-graph efficacy is not validated here.

HTTP proximity and control-plane views only compute and describe. The actual sending caller is scripts/proximity-tick.js. Its dispatcher passes messages to a synchronous sink that invokes ecc-tui messages send. The Node mapping turns proximity_steer and proximity_hold into kind=conflict, and proximity_transmit into kind=query.

**Concrete contract contradiction:** buildSendArgs includes --from, --to, --kind and --text, but never --file. Rust MessageCommands::Send has a file vector with no supplied default. Its build_message Conflict branch requires the first file and returns an error when the vector is empty. The error is: `Conflict messages require at least one --file`.

For a binary implementing the pinned Rust source, after the supplied session ids resolve, the generated steer/hold conflict command therefore fails before comms::send inserts its intended message. If ids do not resolve, the call can fail even earlier. Query does not require a file and is not rejected by this particular predicate; its successful path still depends on configuration, ids and store operations. A different override binary may implement another contract. No installed binary or live delivery was run here.

The failure is deliberately absorbed at another boundary: the synchronous command throws, the dispatcher increments skipped, and no successful-send cooldown entry is set. A persistent failing trigger may be attempted again on later ticks. The five-minute cooldown applies only to successful synchronous return, is held in memory and keys on sender/recipient/type rather than content or revision. It does not clear simply because a trigger disappears, and a fresh process starts with a fresh map.

Even a successful query only crosses a narrower boundary. Rust serializes a message and calls the store writer; it does not in this route wait for a recipient's model/tool behavior. The store may also update graph/board projection after insertion. A sent count is neither complete transactional receipt nor proof of steering, pause or resolved conflict. The advanced view explicitly keeps inventory observations declared-only and lease descriptions distinct from acquired locks; that useful restraint should survive later comparison.

## 9. Why the inspected tests do not close these gaps

The server tests describe real temporary-store HTTP readback, gates, response shapes and ordinary Node subprocess behavior. They are useful tests of those paths, not a Cargo-to-selected-database conformance test. The message-sink test asserts the very steer argv that omits --file, then substitutes a function that records calls for the external executable. That test can satisfy its assertion without ever reaching Rust's build_message.

The source challenge changed the question from 'was a command constructed?' to 'does its actual consumer admit this command?'. It identified the mismatch without manufacturing another helper fixture. Neither test suite was run by this research; their pass counters are not research results. No claim is made that every upstream test was searched or that no integration test exists elsewhere.

Positive controls remain part of the explanation: correct configured targeting can align observation and effects; a valid query differs from the rejected conflict command; read-only blocks relevant writes; the card route passes its selected target; atomic export protects a different failure class than concurrent merging; and advisory-only labels avoid claiming actuator authority. The result is not 'ECC is broken' but a source-grounded map of which guarantees are actually joined.

## 10. Bounded closure and next work

U09-B's source return condition is met by the joined CLI/server/client, selected-store mutation and persistence, actual Rust configuration/graph/message consumers, separate view/sender, and a concrete failure/retry contrast. This is a bounded bridge explanation, not complete control-pane algorithm coverage or live system certification.

Preserve an open residual for actual binary/config/database correspondence, recipient uptake, multiwriter/journal durability, concurrent HTTP behavior, all timeout/platform paths, full proximity/inventory/projection quality and complete connector/recall semantics. The two unexamined visualization bodies and deeper imported algorithms remain in the omission frontier. A new caller or a stronger use claim can reopen them; their existence does not erase the answered bridge question.

Next selected research is the separate evaluation family: begin the Rust candidate/evaluation/activation registry at ecc2/src/harness_eval.rs and its actual CLI/store consumers, then distinguish the Node capsule/replay framework. Do not transplant E04's helper findings or assume an active registry row governs a live worker. Publication and entry alignment for this unit must close first. ECC-native synthesis, later project-facing comparison and comprehensive joint evaluation remain unfinished; no architecture or remediation is adopted.
