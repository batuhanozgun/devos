# Note36 — Node recall, proximity and advisory consumers

**2026-09-22 · U15-C2 / Q05d2 · BOUNDED SOURCE ANSWER.** Fixed target `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U15-C2-SOURCES.md), [MR37](../ROUND-U15-C2.md), [STATE](../STATE.md). Evidence is original-source reading, inspected test definitions and explicitly conditional inference. No target execution, new E10, live server/model, retrieval benchmark or installed-system certification. The numerical countercase below is derived, not an executed Git/Node incident.

## 1. Three different information consumers, not one graph behind several labels

Note35 explained Rust graph recall and the narrower graph-based delegate selector. The Node control pane adds two genuinely different routes:

| Route | Actual producer, transformation and consumer | What is not implied |
|---|---|---|
| Knowledge panel | Selected ECC2 database bytes → bounded entity/observation rows → Node lexical ranking → snapshot JSON → browser knowledge cards | Rust recall equivalence, accepted knowledge, or automatic model-context delivery |
| Proximity scan | Session worktree diffs → changed file/range sets → a separate source-code dependency graph → pairwise risk/advice → API/display or tick dispatcher | Traversal of the persisted knowledge graph, authoritative work ownership, or prevented conflicts |
| Control-plane view | Snapshot/proximity links → projection and declared inventory → task/lane/event representation | Acquired leases, process control or a steering acknowledgement |

N-STATE, P-ADAPTER, P-SCAN, N-SERVER, N-VIEW establish these calls. The proximity builder receives sessions and repository source paths, not the context_graph_entities/observations/relations tables. Its graph means relative source imports; the persisted graph can represent notes, decisions and observations. Shared vocabulary does not make these the same representation.

There is useful implemented behavior: the knowledge page can rank matching records from the selected database; overlapping changed regions or a discovered direct import can produce proximity advisories; an explicitly run tick has a real message-sink path. The normal browser GET routes compute/display advice without invoking that sink. Note16 retains the actual sink-to-Rust command/target constraints. Reading the new algorithms does not erase those constraints or turn their intended action into an observed outcome.

## 2. Node recall's population and ranking contract

N-STATE imports an existing database file into sql.js and selects up to100 recent sessions,500 recently updated entities and1000 recent observations. Entity and observation limits are global and independently applied. These are preselected populations, not the top relevant results from an unbounded search. Returned entityCount and observationCount count those rows; they do not report a whole-corpus total or include an explicit truncation indicator.

Node tokenization keeps ASCII letters/digits, underscore, dot and hyphen, with a minimum of two characters. For each distinct query term, substring matches contribute separate field weights: name12, type5, path6, summary8, metadata5 and concatenated selected observation summaries10. Relation count contributes up to8, observation priority and any selected pinned observation add bonuses. Nonempty token queries still require at least one lexical match. A query with no usable tokens follows the same browse path as an empty query: pinned-associated entries first, then others, with updated time breaking ties. This is not semantic understanding or a confidence probability.

The caller returns at most50 results; zero or invalid limit values fall back rather than requesting no rows. Recall has no session filter on this panel path, although entity/session attribution is present in structured data. That can be appropriate for an operator-wide view; it must not be represented as per-session access isolation.

Unlike Rust's latest-four-observation summaries per candidate, Node matches all observations present in its global1000-row sample. It can therefore include an older fifth summary that Rust excludes, while excluding a pinned observation displaced by activity elsewhere. An entity outside the500-row window is not considered even when its observation remains in the separate sample. Full observation details, including a Markdown connector's longer body, are not searched. Preserved data, selected population, searchable fields and useful recall remain separate.

Malformed JSON fields fall back to empty objects/arrays without a field-validity diagnostic; existing tests explicitly exercise that behavior. Missing tables return empty lists. An unavailable optional work-item database can become empty work items, whereas errors opening/querying the main ECC2 file may propagate. The ordinary snapshot records database existence, so the entire system is not uniformly hiding missingness. N-STATE and T-STATE; prior Note16's snapshot/journal limitations remain scoped rather than repeated as a default-WAL allegation.

## 3. A pinned record's qualifier can be displayed beside a different record

The ranking result sets hasPinnedObservation from **any** selected observation for the entity, but latestObservation is simply the first, newest selected observation. These are valid, different facts in the JSON object. The browser's renderKnowledge prints the prefix Pinned from the first field and then prints the second field's summary. N-STATE→N-UI.

**Conditional example:** an entity has an older pinned review note and a newer unpinned recommendation. The result correctly contains hasPinnedObservation=true and latestObservation.pinned=false. The browser can nevertheless render the newer recommendation as Pinned. The qualifier belongs to another record. This does not mean pinned data is authenticated, that the underlying pin changed, or that a user/model actually acted on the display. It is a source-observed attribution mismatch at the renderer.

A related evidence boundary exists even without pins: an older observation can supply the matching query term, while the card shows the newest unrelated summary. The JSON contains matchedTerms but not the particular matching observation or passage for every hit. The card does not expose the full selected observation set. Other explicit graph/observation commands can still retrieve records; the finding is not universal inaccessibility.

The inspected no-query pin test has one observation per entity, so its pinned and latest objects coincide. The normal snapshot fixture likewise does not distinguish these identities. Its passing assertion, if run successfully, would not discriminate the mixed old-pinned/new-unpinned case. We inspected the tests, not their execution.

## 4. Working-set collection precedes all proximity arithmetic

The default working-set source runs git diff --unified=0 against base...HEAD in each session worktree. Git's documented three-dot form compares the merge base with the second commit. Thus this path describes committed branch changes, not current unstaged, staged or untracked edits. A missing base falls back to HEAD, making HEAD...HEAD empty. File weights are1 on the default adapter path; no timestamp-derived decay or future-intent set is supplied. N-STATE→P-ADAPTER; D-GIT.

Only sessions with nonempty returned file sets participate. No lifecycle-state filter is applied by sessionsToAgents, so a terminal session retaining an eligible worktree diff can participate. Conversely, an active session whose diff is empty or unreadable can disappear. Git failures are caught and become an empty working set. Fewer than two participants yields an enabled but empty advisory result. That is availability-preserving degradation, not evidence that all intended sessions were observed and found conflict-free.

The parser recognizes +++ b/path headers and positive new-side hunk ranges. Ordinary full-file deletion uses +++ /dev/null, which does not match that header expression, so a standalone deleted file is not included by this default parser. Binary-only/mode-only or pure-rename patches without a recognized new-file header are also outside this extraction route. The separately exported name-only helper has different inclusion behavior; it is not the default fallback after a parsing omission. These are source-format bounds, not a performed deletion test.

Missing database metadata can also be lost downstream. buildControlPaneSnapshot returns its empty base with database.exists=false when the file is absent. The dedicated /api/proximity endpoint then substitutes an enabled empty proximity object without carrying that database flag. An empty advisory response therefore has multiple possible causes. The normal complete snapshot still exposes the flag; no claim that every view hides the condition is made.

## 5. New-side line numbers are not a shared coordinate system

P-ADAPTER stores only each branch's new-side ranges. P-DIST compares those numeric ranges when normalized file paths match; it does not map them to a common base, bind them to commit identities, or reconcile shifts and renames first.

**Derived countercase, not run:** both branches start at the same base and change the original line100 of one file. A also inserts ten lines near the start. With ordinary separate hunks, A's new-side ranges can be [1,10] and[110,110], while B's are[100,100]. The common original location has different output coordinates. The numeric intersection is empty, so overlapRisk=0. For this one shared path dependency distance0 is skipped, and treeRisk=1. Default channel weights then yield risk0.25, below the advisory threshold0.35: clear on this scoped input.

The conclusion depends on these ordinary diff/range conditions and defaults; it is not a measured false-negative rate or proof that later Git merging will accept a conflict. Git or another reviewer may independently reject it. A baseline-aligned edit without preceding shifts can be detected; absent line ranges deliberately trigger conservative whole-file overlap. The issue is that parsing success does not establish cross-revision coordinate comparability.

The adapter tests supply already-comparable synthetic ranges or assert extraction of new-side ranges. They do not carry a real pair of version-shifted diffs from source through the advisory. A locally correct overlap coefficient can therefore be used on a representation that has lost the correspondence the decision needs. This adds a distinct composition explanation rather than declaring the coefficient itself wrong.

## 6. The dependency graph has its own population and source revision

P-GRAPH deliberately implements a lightweight relative-import scanner for selected JavaScript/TypeScript extensions. It uses regular expressions and extension/index resolution, not a compiler, call graph or all-language semantic analysis. The design explicitly leaves richer channels for later work. That limited purpose is preserved.

The physical builder reads only the supplied touched-file union, from the single repoRoot given by the panel/tick. It resolves imported paths but does not recursively scan every imported file. Consequently, for A→middle→B, if only A and B are touched, the middle→B edge may never be built. The distance function can traverse an adequately supplied graph, but the actual producer need not supply that closure. The in-memory builder over a complete source map is a different producer, not evidence that the physical path scans that complete map.

The selected repository copy can also differ from an agent's worktree revision. A new import present only on a worker branch may not exist in the shared repoRoot used for dependency scanning. Relative path equality does not itself bind a common repository or content version. The feature's stated use is agents in the same codebase; extending it across repositories requires further identity conditions rather than silently treating path text as global identity.

Unreadable files become empty adjacency lists; an outer builder error can become an entirely empty graph. In a no-overlap case, tree proximity alone contributes at most0.25 under defaults, below0.35. Therefore a missing dependency observation can change an advisory into clear, without a distinct graph-coverage error in that result. A successfully resolved direct import remains a useful positive detection path. Neither a quiet result nor a discovered import establishes that a change really breaks its dependent.

The helper comment describes undirected reachability, but the implementation walks outgoing edges and takes the shorter of A→B and B→A. That handles either directed orientation of a path, not every undirected connection such as two files sharing a dependency. No broader graph-distance theorem or compiler-equivalence claim is inferred.

## 7. Score, displayed position, priority and authority are different

P-DIST combines overlap, dependency and directory proximity with a noisy-OR-shaped formula. The source displays its scalar as a percentage, but the inputs contain no empirical collision outcomes or calibration procedure. In this study the number is a configured heuristic score, not a verified probability of a future merge conflict.

Right-of-way uses summed file weights, earlier start and an id tiebreak. With default weight1, the first quantity is changed-file count, not accepted progress, task importance or a granted right to edit. The result assigns advisory hold/steer roles; it does not acquire a lock or terminate a process. The exported closureRate utility is not called by the traced scan/dispatcher; the design roadmap explicitly places live closure-rate and intent wiring in v1, so this is a future boundary rather than a failed current guarantee.

Visualization is another representation. The 3D embedding uses path hashes, dependency smoothing and file centroids, not edited line ranges. Two agents editing disjoint ranges of one file can occupy exactly the same position while remaining below the advisory threshold. The 2D projection performs PCA on pair-channel vectors; with only one pair it returns zero coordinates, so two-agent separation on that display cannot encode their risk. The JSON separately retains risk, channels and normalization metadata. No rendered-user study or numerical PCA validation was performed.

N-VIEW positively states that projection is display-only, advisories use static thresholds, inventory is declared-only, leases are not locks and the view does not steer/pause/lock. Its cached source shares an in-flight refresh and avoids resampling the same cached snapshot for request overrides. This preserves a real distinction between visual projection and decision; it does not make the original observations complete or current truth.

## 8. Advice generation and successful coordination are not interchangeable

P-SCAN→P-ADAPTER→N-TICK turns non-clear pairs into proposed messages and passes them to a separately instantiated sink. Read-only GET views never perform that delivery. The dispatcher tracks successful synchronous returns for cooldown and catches individual send failures. This is an implemented attempt path with useful best-effort isolation, not an acknowledged joint maneuver.

Note16 already traced the pinned sink's steer/hold mapping to a Rust conflict command lacking its required --file argument, and the independent configuration/target issue. Those findings remain; this unit does not rerun them or assume a different installed binary. A transmit/query message follows a different contract. Model uptake and effective retargeting remain stronger claims.

There is also a conditional delivery-representation boundary even with a compatible custom sink: the hold message says the other party has been asked to steer, but that sentence is constructed before either send succeeds. If the steer send fails and the hold send succeeds, the delivered sentence can outrun delivery evidence. This is not asserted as the pinned default outcome, where the known conflict-command problem may reject both. No partial-delivery run occurred.

## 9. Evidence and bounded closure

All four direct agent-proximity implementation files were read fully, along with the complete state/proximity/view/server/tick producers and the relevant browser client through EOF. The native design document and two representative test files were fully inspected. This is not all repository/test/host coverage. Detailed alternative renderers and coordination-inventory internals are not certified; the latter is bounded here at its declared-output adapter and remains subject to the existing material-interface frontier.

T-STATE includes real temporary sql.js export/import in its test definitions and awaits its callbacks. T-PROX uses injected working sets/graphs/sinks, rather than the native Git acquisition path. Its synchronous test wrapper does not await its two async callbacks before printing/incrementing local PASS counts. A later unhandled rejection can still fail a Node process; we do not claim such failures are necessarily hidden from the whole runner. Neither file was executed.

U15-C2 meets the selected source-to-representation-to-consumer criterion. With Note35, parent U15-C/G2 now has a bounded Rust/Node information-use answer: record import and attribution, distinct recall/assignment, separate code-proximity extraction, advice and actual consuming interfaces. This does not establish universally accepted/current knowledge, installed compatibility, effective steering or comprehensive semantic retrieval. Q05d3/Q05b/c and prior residuals remain.

The next material source responsibility is G3 installation lifecycle, entered as U16-A/Q03c: actual update/doctor/repair/uninstall callers and install-lifecycle helpers, with Notes02–03 and26/28 as scoped prior evidence. Read the existing lifecycle rather than repeat completed OpenCode discovery. Final native CORE, reverse-inventory challenge and whole-study evaluation remain unfinished. Publication and activation are determined by the checked STATE, not this note's existence.
