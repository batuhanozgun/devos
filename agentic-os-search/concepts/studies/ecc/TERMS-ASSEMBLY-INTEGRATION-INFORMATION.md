# ECC — Provisional assembly, integration and information-use uses

2026-09-23 · **C6 post-U12 transfer / U15-A–C2 extraction.** Bu dosya ECC'nin provisional native-system assembly, worktree integration/retention ve Rust/Node information-use source packages'ındaki bağlamlı kullanımları taşır. AI kimlikleri product architecture veya ortak SOUL primitives değildir.

Source packages:
- U15-A Note33 + U15-A sources + U15-A coverage reconciliation + MR34 + publication.
- U15-B Note34 + U15-B sources + MR35 + publication.
- U15-C1 Note35 + sources + MR36 + publication.
- U15-C2 Note36 + sources + MR37 + publication.
Fixed upstream target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`.
Tests inspected, not run; conditional counterparts are not incidents.

## 0. Source locator and role map

| Usage range | Exact research sources | Source role / evidence class |
|---|---|---|
| ECC-AI01–AI18 | [Note33](../../../research/studies/ecc/notes/33-NATIVE-SYSTEM-ASSEMBLY-AND-RESEARCH-FRONTIER.md) §§1–9 → [U15-A ledger](../../../research/studies/ecc/evidence/U15-A-SOURCES.md) → [coverage reconciliation](../../../research/studies/ecc/inventory/U15-A-COVERAGE-RECONCILIATION.md) → [MR34](../../../research/studies/ecc/ROUND-U15-A.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U15-A.md) | PROVISIONAL research synthesis over prior note evidence plus selected new source; not fresh execution or CORE. |
| ECC-AI19–AI49 | [Note34](../../../research/studies/ecc/notes/34-WORKTREE-INTEGRATION-AND-RETENTION-BOUNDARIES.md) §§1–9 → [U15-B ledger](../../../research/studies/ecc/evidence/U15-B-SOURCES.md) → [MR35](../../../research/studies/ecc/ROUND-U15-B.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U15-B.md) | Fixed-pin source observation, inspected tests and conditional Git/lifecycle inference; no merge/rebase/delete run. |
| ECC-AI50–AI71 | [Note35](../../../research/studies/ecc/notes/35-CONNECTOR-GRAPH-RECALL-AND-RECIPIENT-USE.md) §§1–8 → [U15-C1 ledger](../../../research/studies/ecc/evidence/U15-C1-SOURCES.md) → [MR36](../../../research/studies/ecc/ROUND-U15-C.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U15-C1.md) | Fixed-pin Rust source/test observation plus conditional inference; no SQLite/import/retrieval run. |
| ECC-AI72–AI92 | [Note36](../../../research/studies/ecc/notes/36-NODE-RECALL-PROXIMITY-AND-ADVISORY-CONSUMERS.md) §§1–9 → [U15-C2 ledger](../../../research/studies/ecc/evidence/U15-C2-SOURCES.md) → [MR37](../../../research/studies/ecc/ROUND-U15-C2.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U15-C2.md) | Node/Git source observation, inspected tests and explicitly derived examples; no proximity/runtime run. |

Note33's assembly does not upgrade the evidence classes of the original notes it cites. Later Note34–36 usage ranges retain their own source/conditional standing.

## 1. Assembly and relationship language

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-AI01 — provisional native-system assembly | Notes01–32 bounded findings'i responsibility/relationship account'ta birleştiren U15-A synthesis. | Final CORE, independent replication veya adopted architecture değil. |
| ECC-AI02 — selectively connected operating mechanisms | Installation, work, execution, information, review, evaluation, observation/control gibi bazı gerçek implementation edges'in birlikte varlığı. | Tek universal controller/task/session/authority/acceptance contract değil. |
| ECC-AI03 — shared source/package convention | Common repository/assets/configuration/distribution conventions üzerinden reuse. | Every mechanism simultaneously selected/active/integrated değil. |
| ECC-AI04 — responsibility map | Overlapping source-grounded responsibilities ve concrete mechanisms görünümü. | Fixed repository taxonomy veya SOUL component model değil. |
| ECC-AI05 — implemented connection | Producer/transformation/consumer source path'inin actual caller/data/control relationship ile izlenmesi. | Useful/accepted outcome guarantee değil. |
| ECC-AI06 — interpreted obligation | Host/user/procedure tarafından izlenmesi gereken textual/procedural responsibility. | Executable enforcement veya automatic completion değil. |
| ECC-AI07 — unestablished traced bridge | Producer ve consumer surfaces bulunmasına rağmen aradaki actual ingestion/use path'in source inquiry'de kurulmamış olması. | Repository-wide absence theorem'i değil. |
| ECC-AI08 — semantic mismatch at a connection | Edge implemented fakat producer quantity/identity ile consumer interpretation'ın uyuşmaması; cumulative-cost örneği. | No connection veya universally broken subsystem değil. |
| ECC-AI09 — narrower correct responsibility | Mechanism'in observer'ın daha geniş varsayımından dar fakat kaynakça doğru görev üstlenmesi. | Failed promise sayılmaz. |
| ECC-AI10 — plural persistence | Node work/session, Rust sessions, Canvas queue, Vault, instincts, metrics, capsules gibi separate stores/contracts. | Multiple stores inherently bad veya one database required demek değil. |
| ECC-AI11 — plural decision owner | Host agent/runtime, local controller, user/maintainer ve procedure actor'larının distinct decisions/effects taşıması. | Label similarity ile single authority oluşmaz. |
| ECC-AI12 — ECC-maintenance object | ECC package/release/readiness/scanner lifecycle'ının ECC'nin kendi artifact'ı üzerindeki object. | User application deliverable acceptance/publish pipeline'ı değil. |
| ECC-AI13 — user-deliverable object | User-requested task/change/result whose review/integration/acceptance semantics separate. | ECC package release controls'ı otomatik inherit etmez. |
| ECC-AI14 — task-journey analytical assembly | Available mechanisms'i preparation→work→execution→review→integration→reuse şeklinde ilişkisel açıklama. | One default command'un bütün adımları otomatik yaptığı claim değil. |
| ECC-AI15 — genuine source gap | Whole-system explanation'ı materially değiştirebilecek unread implementation/caller/variant. | Yalnız live/unrun empirical claim ile aynı değil. |
| ECC-AI16 — stronger empirical residual | Source explanation sonrası installed/live/frequency/effectiveness/accepted-outcome evidence gerektiren claim. | Source mechanism “unexplained” demek değil. |
| ECC-AI17 — consequence-based next selection | Remaining source groups'i novelty/helper count yerine whole-system answer'a etkisine göre sıralama. | Selected next'in success/defect bulacağı guarantee değil. |
| ECC-AI18 — integration gap | Produced work'in candidate/base/readiness→Git effect→outcome/cleanup zincirinin prior process-completion explanation'ından ayrı source responsibility olması. | “ECC has no delivery mechanism” değil; U15-B bunu source scope'ta açıklar. |

## 2. Worktree qualification, Git effect and retention

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-AI19 — merge queue | Attached sessions/worktrees'i priority/project/group/time/id ve blockers üzerinden ready/blocked queue'ya dönüştüren manager representation. | Semantic acceptance queue veya immutable review receipt değil. |
| ECC-AI20 — merge candidate | Attached worktree/session whose state/Git health participates in integration selection. | Task accepted/completed-correctly proof değil. |
| ECC-AI21 — active-state merge blocker | Pending/Running/Idle/Stale state'in integration için blocked standing'i. | Process liveness veya universal unsafe-to-merge theorem değil. |
| ECC-AI22 — mechanically mergeable | Preview/dirty/earlier-candidate conflict blocker'ı olmayan candidate. | Tests passed, reviewed, human-approved veya deployable demek değil. |
| ECC-AI23 — stopped/failed eligibility | Merge state predicate'in Stopped/Failed'i otomatik exclude etmemesi. | Always wrong; stopped-session integration test intentional operator flexibility countercase'idir. |
| ECC-AI24 — WorktreeHealth::InProgress | Branch change presence/preview-derived worktree health state. | Session Running lifecycle state ile aynı değil. |
| ECC-AI25 — merge preview | `git merge-tree --write-tree base candidate` mechanical tree/conflict check'i. | Effect-free pure read, behavior test veya approved revision binding değil. |
| ECC-AI26 — preview tree object | merge-tree'nin working tree/index değiştirmeden Git object üretebilme effect'i. | Base branch integration değil. |
| ECC-AI27 — merge_into_base | Base checkout/branch/dirty rechecks sonrası `git merge --no-edit candidate` local Git effect. | Remote push/PR/release veya semantic acceptance değil. |
| ECC-AI28 — repeated pre-effect check | Actual merge öncesi preview/dirty/base branch revalidation. | Exact immutable ref/OID binding veya race elimination değil. |
| ECC-AI29 — branch-name identity | Stored candidate/base branch names and worktree path used across preview/effect. | Approved commit identity veya immutable revision değil. |
| ECC-AI30 — rebase target ambiguity | Stored candidate OID measured while `git rebase base` acts current worktree HEAD; switched checkout can diverge. | Observed wrong-branch incident değil; normal unchanged checkout countercase'i vardır. |
| ECC-AI31 — iterative merge controller | cleanup=true bulk path'in queue rebuild, ready merges, optional rebase and retry passes. | Durable cross-invocation attempt history veya eventual-progress guarantee değil. |
| ECC-AI32 — one-pass keep controller | cleanup=false / keep-worktree bulk path'in separate non-iterative algorithm'i. | Same controller minus deletion flag değil. |
| ECC-AI33 — per-invocation retry map | Session + base-head OID attempts'i same invocation içinde bound eden local discriminator. | Persistent lease/attempt history veya restart recovery değil. |
| ECC-AI34 — rebase abort recovery | Rebase failure sonrası `git rebase --abort` attempt and warning path. | Merge failure has same abort guarantee değil. |
| ECC-AI35 — merge failure without explicit abort | Actual merge error'ın helper'da merge-abort invocation olmadan propagate edebilmesi. | Every failed merge leaves conflicted state demek değil. |
| ECC-AI36 — auto-merge flag | Daemon auto_merge_ready_worktrees predicate'i. | Auto-prune enable/disable selector ile aynı değil. |
| ECC-AI37 — auto-prune | Daemon merge step'ten sonra inactive attached worktrees için prune wrapper. | Git administrative `worktree prune` command'i değil; cleanup/remove path'i. |
| ECC-AI38 — retention_secs | Inactive cleanup için heartbeat-age delay; default0 delay bypass. | Zero = retain forever/disable cleanup değil. |
| ECC-AI39 — merge/prune state mismatch | Merge Stale'i active-blocked sayarken prune Stale'i protected active set'e almaması. | Observed live-worker deletion değil; source composition condition. |
| ECC-AI40 — retained-failure lifecycle | Merge/rebase path'in attached candidate bırakmasının subsequent prune tarafından preserve edileceği guarantee olmaması. | Every retained failure deleted demek değil; retention/caller conditions matter. |
| ECC-AI41 — force worktree removal | Cleanup'ın `git worktree remove --force` ve fallback directory removal kullanabilmesi. | Useful work valueless/accepted/integrated proof değil. |
| ECC-AI42 — force branch deletion | Cleanup'ın `git branch -D` attempt'i. | Branch merged/accepted guarantee değil. |
| ECC-AI43 — operation/result non-atomicity | Git effect, optional resource removal, DB clear/board update ve returned result ayrı failure points. | Every error means effect happened veya every success means all resources gone değil. |
| ECC-AI44 — warning-success cleanup | Removal helper'ın some branch/filesystem failures'ı warning ile successful return içinde taşıyabilmesi. | Every cleanup error swallowed değil. |
| ECC-AI45 — clear_worktree | Attached worktree fields'i nulling/refresh while retaining working_dir. | Work accepted, directory base checkout'a rebound veya artifact preserved guarantee değil. |
| ECC-AI46 — per-call merge result | session/branch/base names + outcome booleans. | Before/after commit receipt, reviewer authority veya immutable acceptance record değil. |
| ECC-AI47 — daemon last-pass summary | Auto-merge/prune last-run counts/time current activity record. | Per-candidate history/receipt veya accepted-deliverable ledger değil. |
| ECC-AI48 — normal bulk return with failures | Bulk object blockers/failures taşıyabilirken command normal completion ile render edilebilir. | All candidates integrated proof değil; caller result'i inspect etmeli. |
| ECC-AI49 — unknown-to-clean collapse | git_status_short nonzero Git exit'i warning+empty list olarak döndürüp has_uncommitted_changes false yapabilmesi. | Every unreadable workspace gets merged değil; other checks/Git can fail. |

## 3. Rust connector, graph and recipient use

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-AI50 — connector sync | JSONL/Markdown/dotenv local sources'tan graph entity + observation import path. | Fact validation, Vault-governed memory import veya model context delivery değil. |
| ECC-AI51 — connector record attempt count | Nonempty input records attempted including skipped/malformed records. | Accepted/unique facts count değil. |
| ECC-AI52 — connector success count | Entity upsert + observation append succeeded after record validation. | New unique entity veya independent corroboration count değil. |
| ECC-AI53 — source signature | File length + mtime based connector signature. | Content hash, parser/config/session dependency identity değil. |
| ECC-AI54 — connector checkpoint | Connector-name + displayed path → signature shortcut after normal bounded import. | Offset cursor, complete validity receipt veya retry queue değil. |
| ECC-AI55 — limit-filled no-checkpoint | records_read >= limit halinde checkpoint'in yazılmaması. | Next run tail'dan devam eder demek değil; run source başından yeniden okunur. |
| ECC-AI56 — prefix replay | Fixed positive limit'in same early records'i repeat edip tail'i omit edebilmesi. | Unavoidable starvation değil; higher limit/change can finish. |
| ECC-AI57 — skipped-dependency checkpoint | Record-level missing session gibi skip varken small source signature'ın checkpoint edilmesi. | Skipped record future dependency appears olduğunda automatically reconsidered değil. |
| ECC-AI58 — Markdown projection | Heading/path/slug + first nonempty summary + bounded body/details. | Lossless semantic source representation değil. |
| ECC-AI59 — dotenv secret-name heuristic | Secret-like key names redact; optional safe-value inclusion. | Every retained value non-sensitive proof değil. |
| ECC-AI60 — context graph entity key | lowercased type+name+trimmed path identity. | Session/project/connector/revision part of identity değil. |
| ECC-AI61 — shared entity reassociation | Same global key later import with nonnull session can replace entity session_id/summary/metadata. | ACL breach or observed misrouting değil; shared identity can be intentional. |
| ECC-AI62 — observation/entity session divergence | Entity current session attribution vs historical observation session values. | Persistence alone current truth veya actor authority değil. |
| ECC-AI63 — Rust recall candidate preselection | Recent entities count `clamp(limit*12,24,512)` before lexical ranking. | Whole corpus relevance search değil. |
| ECC-AI64 — Rust recall searchable fields | entity type/name/path/summary/metadata + latest four observation summaries. | Full observation details/older stored observations searched değil. |
| ECC-AI65 — Rust recall score | matched-term count + bounded relation/observation/priority/pinned/recency bonuses. | Truth, authority or expertise probability değil. |
| ECC-AI66 — delegate graph match | At most48 recent entities/session, narrower entity-only terms for eligible delegate ranking. | Same algorithm/evidence as Rust recall değil. |
| ECC-AI67 — information-to-recipient edge | Stored graph entity can influence which eligible delegate receives task handoff. | Matched source passages delivered to worker veya worker accepts/uses information değil. |
| ECC-AI68 — graph-read empty fallback in selector | Entity read error can become empty match list. | “No matching knowledge” ile “graph unavailable” distinguish edilir guarantee değil. |
| ECC-AI69 — observation compaction | Duplicate/overflow retention with pinned preference and unpinned cap12. | Lossless history veya recall inclusion guarantee değil. |
| ECC-AI70 — pinned duplicate append identity mismatch | Insert new row → compaction keeps older pinned duplicate/deletes new → caller queries deleted new id and errors. | Pin mechanism wrong in isolation değil; joined caller/survivor identity mismatch. |
| ECC-AI71 — partial connector effect | Entity upsert can persist before observation/compaction error prevents success/checkpoint. | Whole-file transaction/rollback guarantee değil. |

## 4. Node knowledge, code proximity and advice

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-AI72 — Node knowledge population | sql.js snapshot'ta up to500 entities +1000 observations independently selected. | Whole graph population/top relevance results değil. |
| ECC-AI73 — Node knowledge scorer | ASCII-ish token substring field weights + relation/priority/pin/recency bonuses. | Rust recall equivalent veya semantic confidence değil. |
| ECC-AI74 — operator-wide recall | Node panel recall path'inde no session filter. | Per-session isolation/authenticated access boundary değil. |
| ECC-AI75 — any-pinned qualifier | Selected entity observations'dan herhangi biri pinned ise result boolean. | Latest displayed observation pinned demek değil. |
| ECC-AI76 — latestObservation | Newest selected observation object shown separately. | Query match'in evidence passage'i veya pin source'u olmak zorunda değil. |
| ECC-AI77 — qualifier/display attribution mismatch | any-pinned boolean ile newer unpinned latest summary card'da “Pinned” prefix oluşturabilir. | Underlying pin changed veya user acted demek değil. |
| ECC-AI78 — match/display evidence mismatch | Older observation query match sağlarken card unrelated latest summary gösterebilir. | Data universally inaccessible değil; other graph commands exist. |
| ECC-AI79 — proximity working set | Per-session `git diff --unified=0 base...HEAD` parsed changed file/new-side ranges. | Staged/unstaged/untracked current edits veya whole Git state değil. |
| ECC-AI80 — missing-base fallback | Base absent olduğunda HEAD fallback → HEAD...HEAD empty set. | Conflict-free work proof değil. |
| ECC-AI81 — quiet degradation | Git/read/database errors'ın empty working set/graph/advisory fallback'e dönüşebilmesi. | Observed no conflict veya complete participant set değil. |
| ECC-AI82 — new-side coordinate range | Per-branch diff's output-side line coordinates. | Shared base coordinate system değil. |
| ECC-AI83 — cross-branch range mismatch | Same original edit, earlier inserted lines nedeniyle non-overlapping new-side coordinates gösterebilir. | Measured false-negative rate değil; source-derived arithmetic condition. |
| ECC-AI84 — touched-file dependency graph | Selected JS/TS touched-file union üzerinden relative-import graph. | Recursive semantic dependency closure/call graph/all-language graph değil. |
| ECC-AI85 — shared-repo revision assumption | Dependency graph's repoRoot source may differ from agent worktree revision. | Same path string same content/revision guarantee değil. |
| ECC-AI86 — proximity risk score | overlap/dependency/directory channels'i configured formula ile combine eden scalar. | Calibrated probability of future conflict değil. |
| ECC-AI87 — right-of-way heuristic | File-weight sum/start/id tiebreak ile hold/steer role assignment. | Lock, accepted progress, task priority veya edit authority değil. |
| ECC-AI88 — display projection | 2D/3D coordinates from paths/channels for UI. | Decision score/authority veya complete working-set evidence değil. |
| ECC-AI89 — read-only proximity view | GET/control-plane UI advice display without message sink action. | Steering/hold occurred demek değil. |
| ECC-AI90 — proximity tick delivery attempt | Separate CLI/tick invokes dispatcher/message sink for non-clear pairs. | Reciprocal acknowledgment/effective retargeting/transactional pair delivery değil. |
| ECC-AI91 — pre-ack hold wording | Hold text other party asked-to-steer diyebilir before counterpart send success. | Pinned default path successfully delivers any message demek değil; Note16 consumer mismatch remains. |
| ECC-AI92 — declared-only inventory | Control-plane view'daki inventory/lease-like declarations. | Acquired lock/resource ownership/process control değil. |

## 5. U15 relation view

- source package ≠ one controller;
- responsibility map ≠ architecture taxonomy;
- implemented edge ≠ accepted result;
- process exit ≠ integration qualification;
- mergeable ≠ reviewed/accepted;
- preview identity ≠ applied immutable revision;
- merge keep ≠ same controller without cleanup;
- rebase abort protection ≠ merge abort protection;
- merge retention ≠ daemon retention;
- resource cleanup ≠ useful-work disposal authorization;
- operation failure ≠ effect-free failure;
- current-pass summary ≠ durable per-candidate history;
- import checkpoint ≠ cursor or validity completion;
- stored information ≠ current/accepted information;
- retained observation ≠ searchable/ranked observation;
- recall score ≠ truth/expertise;
- information-influenced recipient ≠ information delivered to recipient;
- Rust recall ≠ Node knowledge recall;
- persisted knowledge graph ≠ source-code proximity graph;
- changed-file path ≠ common revision coordinate;
- risk percentage ≠ calibrated conflict probability;
- display location ≠ advisory authority;
- advice generated ≠ advice delivered ≠ advice followed.

U15 source packages are bounded source answers. No Git merge, connector import, proximity run or target test was executed by Concepts. Q04i2/Q05d3 and broader residuals remain source-study obligations, not automatic Concepts experiments.
