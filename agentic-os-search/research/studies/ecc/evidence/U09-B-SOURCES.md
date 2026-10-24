# U09-B — Node operator bridge source ledger

**2026-09-18 · Q04g2.** Unchanged target: [affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Analytical product: [Note16](../notes/16-NODE-OPERATOR-BRIDGE-AND-TARGET-BINDING.md); method: [MR17](../ROUND-U09-B.md). STATE owns publication/current work. No target execution, new fixture/E08, provider, model or live server occurred. Tests below were inspected, NOT RUN.

## Acquisition and coverage

All target bodies below came through connected GitHub at the pin. FULL means through EOF, not all imported dependencies, runtime validation or installed-version correspondence. SELECTED lists inclusive source lines, including incidental material; it is not a whole-file read. Searches returned a different default-branch ref, `dd6ee538aee0f548d4a6b520118f875431fd749e`, used for path discovery only. No repin or current-main audit occurred.

| ID | Pinned path | Git blob/tree | Actual reading |
|---|---|---|---|
| S12 re-entry | scripts/control-pane.js | c5b7215f4dbd50d324768b1bcc5196cd5d0d1b91 | FULL CLI/start/close/browser dispatch |
| S160 re-entry | scripts/lib/control-pane tree | b1aa05b67fc57ae209dab53abeaa75a8700b22ab | FULL recursive metadata, truncated:false, ten files; not ten body reads |
| S206 | scripts/lib/control-pane/server.js | 8391ac7961ee0b00cbac7ab6aa351f4bf89fe62e | FULL: routes, read-only/host gates, runAction and selected-store mutation |
| S207 | scripts/lib/control-pane/actions.js | af70e542f16a3ad1223063639d53361a520efd82 | FULL: three executable Cargo shortcuts and copy-only dashboard |
| S208 | scripts/lib/control-pane/state.js | 9827443c5031f6ecd4bccfe16eb7f811f4fe1b5e | FULL, 1–290/291–590/591–880 through EOF: config, sql.js byte import, bounded reads, local recall, normalization and snapshot |
| S209 | scripts/lib/control-pane/message-sink.js | e03c856e189e565983f3c538eee727a96f40f1ac | FULL: binary lookup, argv, synchronous command boundary |
| S210 | scripts/lib/control-pane/proximity.js | a958ef36f3d1e46342328047d6bd608dbbd62e2d | FULL: working-set source, scan adapter, triggers, dispatcher/cooldown/tick. Imported proximity algorithms NOT closed |
| S211 | scripts/proximity-tick.js | f50a492b1d4ca4721a79cea8ff8d7d5a18b9016c | FULL: actual message-sink caller, distinct snapshot options, one-shot/watch/dry-run |
| S212 | scripts/lib/control-pane/ui.js | f7b0e069dac93565a16dce65810ef51fdf6881c6 | SELECTED 220–520/521–790 through EOF: complete embedded client script and body; earlier CSS/head not read |
| S213 | scripts/lib/control-pane/control-plane-view.js | 32f6a57eefeff0a785e1a187c5f03b7fb57fd6ca | FULL combined initial response and overlapping 310–380/340–470 through EOF; initial response alone truncated. Adapter, inventory declarations, events and cached source, not full imported inventory/projection algorithms |
| S214 | ecc2/src/comms tree | f5594c29ed491cc68e594e6e52b22c6609a41d01 | FULL recursive metadata, truncated:false; one mod.rs |
| S215 | ecc2/src/comms/mod.rs | f7838f29b1b722373480872b56e809f62321ccb8 | FULL: structured types, serialization/send, parse/preview; no live receipt |
| S216 | tests/scripts/control-pane.test.js | 5503bcf958f7cbf920fc90fee2ff63843473418d | FULL 1–300/301–650/651–850 through EOF, TEST SOURCE ONLY |
| S217 | tests/lib/control-pane-message-sink.test.js | 719f329b355b3dca696d787065e7a30d3f1765f8 | FULL, TEST SOURCE ONLY; injected runner and clock |

### Existing IDs re-entered, not renumbered

| ID | Path / Git blob | Additional read |
|---|---|---|
| S53 | scripts/lib/state-store/index.js / 49b6204d635330401ede6fd734c72f9588466f78 | FULL again: file import/export, atomic replacement, per-instance transaction, factory/close |
| S58 | scripts/lib/state-store/queries.js / 0225f476182ab68c77285d1e2f398637b7c20bbc | SELECTED 580–940: complete work-item upsert SQL/method and lookup/list; normalization/schema closure remains at prior recorded scope |
| S59 | scripts/lib/control-pane/work-item-mutations.js / c82a26196432b1cc0a95aee023354fe285c9bbdd | FULL again; explicit-id claim and lane move; E02 NOT repeated |
| S69 | scripts/lib/state-store/migrations.js / 7716c992589341e4db89a403139a2fd7db040894 | FULL again; state.db session/work-item schema and local foreign keys |
| S181 | scripts/lib/loopback-guard.js / c56366ea35131d8afd3ab5362ec1c6eb5d7f5ec0 | FULL again; hostname predicates, not person authentication |
| S186 | ecc2/src/main.rs / 7c516684c178d050bc36d96d0481f812e9c48c07 | SELECTED 430–555, 660–870, 1240–1360, 1380–1465, 1490–1620, 1720–2090, 2180–3100, 3740–3960, 4070–4350, 5500–5710, 7080–7350, 7800–9020. Includes incidental helper/format/test searches, not all mechanism closure. Complete relevant functions/arms listed below |
| S190 | ecc2/src/session/store.rs / f71bb3640991f9d471e2ab98dad54dff4d346721 | SELECTED 160–250 re-entry: open and schema beginning. Prior send_message, graph-history, state/output/board methods retained at U09-A/A2/A3 scope |
| S195 | ecc2/src/config/mod.rs / d48bd9a67ee47a5c0d85f6d079ab40736efe61b9 | SELECTED 495–640 joined to prior load/default/path coverage; global and nearest-project precedence |
| S156 | ecc2/src tree / 6e722551d08805adce0760184f5835e7e4de4ef8 | FULL direct metadata re-entry, truncated:false; resolved comms tree and future evaluation lead |

The five-entry state-store contents response supplied exact filenames/identities; redundant wrapper metadata was display-truncated. It is not another recursive inventory. Existing ID recovery used the full U03-A and U08-A ledgers; U07-A family map was fully reread. Those research records establish prior scope and questions, not independent behavior evidence.

## Complete load-bearing chains

**HTTP observation/action:** S12 → S206 → S208 snapshot and S212 client, or S207 action → S206 runAction → S186 main/Graph command. S186 main loads Config and opens cfg.db_path; S195 supplies actual selection. The server passes repoRoot/query/limit to actions, not its selected db/config. Graph Sync calls sync_runtime_session_metrics before sync_context_graph_history; that helper invokes heartbeat/budget enforcement already traced in U09-A. This is a real transitive policy effect, not a new live pause experiment. Full connector parsers, Rust recall algorithm and history semantics beyond prior scopes remain separate.

**Cards:** S212 POST → S206 withStateStore(resolvedConfig.stateDbPath) → S59 claim/move → S58 upsert → S53 export/persistence → S208 fresh byte import → S212 render. S69 binds work_items.session_id to the sessions table in the SAME state store, whose shape differs from Rust sessions. A record mutation does not start a Rust worker. Factory/close and whole-file persistence are actual dependencies, not inferred from SQLite labels.

**Messages:** S211 builds snapshot using its DB flags but constructs createEccMessageSink({}); S210 dispatcher → S209 argv → S186 MessageCommands::Send / resolve_session_id / build_message → S215 comms::send → retained S190 send_message. The full build_message body is in 3740–3960; Send argument declaration in 430–555. Conflict requires at least one --file, while S209's steer/hold argv omits it. Under the pinned Rust consumer, with ordinary arguments and ids resolved, that branch fails BEFORE comms::send. Query does not have that requirement. A different ECC_TUI_BIN implementation could have a different contract; no installed binary was observed.

**View versus delivery:** S206 proximity and control-plane GET paths build snapshots/views; neither invokes the message sink. S213 emits advisory action descriptions and declared-only inventory, not acquired locks. Its own cache shares a refresh and retains a sample for five seconds by default. S211 is the actual separate delivering caller. Imported distance/projection/inventory correctness and runtime effects are not certified by reading their adapter.

## Test-oracle boundaries

S216 inspects temporary exported sql.js databases, HTTP responses, host/origin/read-only gates, copy-only rejection, ordinary Node subprocess output/failure/timeout and a real helper-store/HTTP board readback path in the test source. It does not run a real Cargo graph command against an independently selected panel DB. Its timeout case is a cooperative Node process, not all signal handlers/descendants. Tests were NOT executed by this research.

S217 checks exact steer argv WITHOUT --file, uses an injected function recording calls as its successful command, and injects errors/clocks for failure/cooldown. That assertion can succeed without presenting the generated arguments to the pinned Rust builder. It therefore does not contradict the producer/consumer mismatch. The research's narrow contract challenge is source comparison, not E08, a full suite result or proof that every installed version fails.

The exploratory possibility that Rust supplied a default conflict file was checked against the actual Vec argument and builder; no default was present. The earlier possibility of a default-WAL snapshot failure was NOT established: S190 open enables foreign keys and a busy timeout but does not select WAL. Journal-specific concerns stay conditional. Counterevidence and unresolved conditions are preserved rather than omitted to simplify the finding.

## Separate primary contract checks

- [SQLite WAL documentation](https://www.sqlite.org/wal.html), selected WAL/checkpoint/database-file identity passages, observed 2026-09-18. A main-file-only copy cannot generally stand for the latest committed WAL database. This is conditional context, not evidence that ECC's inspected default is WAL or that a panel incident occurred.
- [Node child_process documentation](https://nodejs.org/api/child_process.html), selected close/kill/timeout behavior, observed 2026-09-18. Signal requests and process/stdio completion are distinct; current manual is not installed-version verification. The primary support for the timer/output findings is S206 itself.

An auxiliary raw-source attempt failed at DNS; a later direct web raw open was also unavailable. Connected source reads worked. No local target checkout, dependency installation, live DB/server, process signal, test run or new experiment was produced. Existing E02/E07 results are not pooled or rerun; E06 stays excluded.

## Bounded disposition and remaining scope

The basic operator bridge has a coherent source answer: two stores, independent command configuration, actual card persistence, transitive graph-sync controls, distinct projection/delivery and a concrete message-contract failure plus query counterpart. Stronger live target equality, multiwriter durability/journal behavior, recipient uptake, all platform/timeout cases and full proximity/inventory/projection efficacy remain open. Detailed connector/recall algorithms and the other UI bodies are not silently completed. Source size/location costs do not become a claim of full Rust main coverage. STATE may close this source unit only after actual note/entry/publication readbacks.
