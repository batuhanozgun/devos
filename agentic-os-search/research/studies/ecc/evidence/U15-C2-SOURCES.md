# U15-C2 — Node recall and proximity source ledger

**2026-09-22 · Q05d2 / MR37.** Fixed source `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`; research input `b6ac4fcaad7e552d9b42ab299837c5ae2851d3ff`. [Note36](../notes/36-NODE-RECALL-PROXIMITY-AND-ADVISORY-CONSUMERS.md), [round](../ROUND-U15-C2.md), [STATE](../STATE.md).

SOURCE OBSERVATION, TEST SOURCE INSPECTED and explicitly bounded INFERENCE only. No target tests/build, Node/Git probe, server/model, user-data import, installation, benchmark or E10. Full read refers to the returned file body through EOF, not all dependencies, platforms, repository descendants or successful execution.

## 1. Pinned files and actual coverage

All paths below are relative to the fixed ECC repository. Inclusive ranges are source lines, not the connector JSON's content line. Each path can be recovered at the fixed ref with its blob identity.

| Handle | Path | Blob | Actual read |
|---|---|---|---|
| N-STATE | `scripts/lib/control-pane/state.js` | `9827443c5031f6ecd4bccfe16eb7f811f4fe1b5e` | FULL:1–285,286–590,591–850/EOF |
| P-ADAPTER | `scripts/lib/control-pane/proximity.js` | `a958ef36f3d1e46342328047d6bd608dbbd62e2d` | FULL body through exports/EOF |
| P-SCAN | `scripts/lib/agent-proximity/index.js` | `429c2e17d239f799baba1dbad858151bf9c7a5e0` | FULL body through exports/EOF |
| P-GRAPH | `scripts/lib/agent-proximity/graph.js` | `3d4c42ad6d6f03c9a2607ba0a114008f13e03937` | FULL physical and in-memory builders/resolvers |
| P-DIST | `scripts/lib/agent-proximity/distance.js` | `8042d3e5ea35877662adb582d1255c8e05feebc2` | FULL:1–215,216–470/EOF |
| P-PROJECT | `scripts/lib/agent-proximity/projection.js` | `08a62a685679ece676f5c65a752ae11623952c2b` | FULL:1–220,221–430/EOF |
| N-VIEW | `scripts/lib/control-pane/control-plane-view.js` | `32f6a57eefeff0a785e1a187c5f03b7fb57fd6ca` | FULL:1–230,231–470/EOF |
| N-SERVER | `scripts/lib/control-pane/server.js` | `8391ac7961ee0b00cbac7ab6aa351f4bf89fe62e` | FULL:1–260,261–550/EOF |
| N-TICK | `scripts/proximity-tick.js` | `f50a492b1d4ca4721a79cea8ff8d7d5a18b9016c` | FULL CLI, config/sink/snapshot binding, one-shot/watch and reporting |
| N-UI | `scripts/lib/control-pane/ui.js` | `f7b0e069dac93565a16dce65810ef51fdf6881c6` | SELECTED250–510,511–790/EOF; complete embedded client including knowledge rendering and query/action/poll consumers, preceding CSS partly incidental |
| T-PROX | `tests/lib/control-pane-proximity.test.js` | `c91603f468e15e082a3786059b35f5824088206a` | FULL1–250/EOF; test definitions only |
| T-STATE | `tests/lib/control-pane-state.test.js` | `df86b7ba68d2dadcbfc763c52ff98189b1200083` | FULL1–280,281–590,591–920/EOF; test definitions only |
| DOC-PROX | `docs/design/agent-proximity.md` | `c9d3e2b967828d8c01251c3857fb374e32a6d2db` | FULL current/future mechanism claims and roadmap at the pin |

Immutable example entries: [state](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/scripts/lib/control-pane/state.js), [proximity adapter](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/scripts/lib/control-pane/proximity.js), [distance](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/scripts/lib/agent-proximity/distance.js), [knowledge renderer](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/scripts/lib/control-pane/ui.js).

The complete directory listing of scripts/lib/agent-proximity contained four files, all subsequently read. That is direct-family coverage, not a new recursive inventory of ECC. Searches for parseDiffRanges and recallKnowledgeEntries returned default-branch hits at `bf70150eb2df8070024e5bdf08e4aa08959e2735`; those were locators only. Every load-bearing body and test was fetched at8321021; no silent repin.

## 2. Actual source-to-consumer chains

**Knowledge:** N-SERVER /api/snapshot → N-STATE byte import/row selection/recall → N-UI load/renderKnowledge. Entities and observations have separate global preselection limits; the scorer preserves any-pin and newest-observation as different properties. The renderer combines them. The result can match an older summary while showing a different latest summary. This is an actual consuming formatter, not a hypothetical UI.

**Proximity:** N-STATE includeProximity → P-ADAPTER per-session Git ranges + touched-file union → P-GRAPH physical selected-source reads → P-SCAN pair iteration → P-DIST risk/right-of-way → triggers or visualization. The persisted knowledge graph is not an input to this path. P-GRAPH's source set and repoRoot differ from a complete graph or every agent's worktree revision.

**Display:** N-SERVER /api/proximity returns the scan or an empty fallback. /api/control-plane and /events consume N-VIEW's cache, P-PROJECT and declared inventory adapter. Raw risk is separate from 2D/3D positions. The view explicitly does not steer/pause/lock; inventory status/coverage and source-database missingness have different projection paths. Alternative renderer bodies and coordination-inventory internals were not fully audited; no stronger algorithm/security/lock claim is made about them.

**Attempted delivery:** N-TICK → N-STATE snapshot with proximity → P-ADAPTER runProximityTick/dispatcher → the prior Note16 message sink/Rust command boundary. The prior missing-conflict-file and independently configured target findings are retained at their original evidence scope, not rerun. Advice is generated before a sink acknowledges a send; per-message catches do not make a reciprocal pair transactional. Partial compatible-sink delivery is a conditional scenario, not the default pinned result or an executed incident.

## 3. Claim and counterpart map

| Claim | Sources | Positive counterpart / limit |
|---|---|---|
| Node recall differs from Rust and from proximity | N-STATE/P-ADAPTER; original Note35 | Real selected-row search and distinct code-dependency input, not one mislabeled unused graph |
| Pinned qualifier can refer to another observation than displayed | N-STATE recallKnowledgeEntries → N-UI renderKnowledge | JSON latestObservation.pinned remains accurate; one-observation cases align |
| Stored/selected/searched/displayed are different | N-STATE readEntities/readObservations/scoreEntity/recall; N-UI | Matching rows can be found; full details/old omitted pins require other reads; not universal inaccessibility |
| New-side line positions can mismatch a common source edit | P-ADAPTER parseDiffRanges → P-DIST overlapRisk/collisionRisk/advise | Shared aligned coordinates can work; no-range whole-file fallback is conservative; no measured false-negative rate |
| Missing/deleted working sets and dependency reads affect quiet results | P-ADAPTER, P-GRAPH, N-SERVER; D-GIT | Errors can preserve snapshot availability; direct edges/shared overlaps work; no all-mode safety claim |
| Shared repo/touched-file graph is not branch-aware dependency closure | P-ADAPTER → P-GRAPH → P-DIST | Caller-supplied complete graph is possible; lightweight JS/TS intent is explicit |
| Heuristic percent, display point and right-of-way differ | P-DIST/P-SCAN/P-PROJECT/N-VIEW/DOC-PROX | Raw channels/risk retained, view limitations explicit, future closure-rate wiring not falsely treated as current |
| Hold wording can outrun counterpart delivery | P-SCAN buildProximityTriggers → P-ADAPTER dispatcher | Conditional compatible sink; prior default conflict-command mismatch preserved; no delivery experiment |

The line-shift fixture is an analytical construction: common base line100 changed by both, A prepends10 lines, A new ranges[1,10]/[110,110], B[100,100]. Derived overlap0/dependency0/tree1 gives risk0.25 with defaults, below0.35. No source file, Git branch or runtime was created to test it. Likewise the old-pinned/new-unpinned display case is derived from different fields, not an observed operator error.

## 4. Test-oracle boundaries

T-STATE genuinely prepares temporary sql.js files and calls the snapshot producer in its definitions. It tests ordinary recall, connector status/configuration, absent tables, missing databases, malformed-field fallbacks and ordering. Its pin examples use one observation per entity; they do not discriminate an older pinned row from a newer unpinned displayed row. The file's async helper awaits its callbacks. No test ran here.

T-PROX injects changed-file/range sets, graphs and message sinks. The parser assertion validates new-side extraction; the range tests assume comparable positions. They do not obtain two shifted real Git diffs or verify native dependency acquisition from separate worktrees. The synchronous helper invokes fn without awaiting returned promises, so local printed PASS counters for two async tick callbacks can precede assertions. An eventual unhandled rejection can still fail the process; no assertion that all such failures are swallowed by CI is made. No suite or mutation check was executed.

Reading all four implementation files does not independently validate numerical PCA, probability calibration, semantic dependency completeness or effective conflict prevention. Their code/docs plus test definitions support a bounded mechanism explanation only.

## 5. Narrow external contract checks and acquisition limits

D-GIT, checked2026-09-22: [official git-diff](https://git-scm.com/docs/git-diff), DESCRIPTION three-dot form and --unified; [official diff-format](https://git-scm.com/docs/diff-format), patch headers, creation/deletion and rename distinctions. Three-dot compares merge-base to the second commit; +++/--- headers and hunk coordinates are separate from the initial diff --git header. These are dated primary documentation checks, not the identity or behavior of an installed Git binary. The unified-header link's context includes combined-format comparison; no combined-format parsing support is claimed for this adapter.

A GNU unified-format page did not return usable content and was not evidence. Auxiliary local raw-source acquisition failed DNS. No original target source was obtained locally, no reconstructed snippet was run, and the empty local working directory is not an evidence artifact. GitHub connector reads remained sufficient for this source inquiry. No PDF, audio, screenshot, live endpoint or model trial was used.

## 6. Research recovery and next source responsibility

Canonical STATE was freshly read as9526089a4304496785d53877288d312f7df523c3; main compared identical tob6ac4fca. The full U09-B ledger was freshly reread as4ad5aefaa2a92ab1669fa98c429ff612270bc7a2. Note16/Note35 and current entry/WHY/METHOD/PLAN/QUESTIONS/MR36/receipt used their unchanged, available full same-conversation contents. Control protocols were refreshed separately; they are not ECC research evidence.

The U15-A reconciliation was fully reread as7ff883382314b6c7838cadec44ed432a5e6db4b9. Its historical G1/G2-next labels remain historical. Note34 answers G1; Notes35–36 provide the bounded G2 source-to-use answer. Installed/private/concurrent/full-context and efficacy questions remain under Q05d3 and original residuals, not automatic new source quotas.

G3 now becomes next selected U16-A/Q03c: `scripts/lib/install-lifecycle.js`, actual public update/doctor/repair/uninstall callers, install/install-targets helpers and the existing release lifecycle driver. These paths come from the prior inventory and notes; the new lifecycle inquiry has not begun. No all-renderer/external-product campaign or SOUL implementation follows.

Note36 was created atb4a79e692b4896732f4c8cc8863ae258b2d86b65. Its readback, this ledger's readback, entry alignment, catalogue and publication receipt/final STATE are later correspondence steps and are not preclaimed here. Prior evidence and E06 exclusion remain unchanged.
