# U15-B — Worktree integration source ledger

**2026-09-22 · Q04i / MR35.** Fixed target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. Research input: `batuhanozgun/agentic-os-search@6cb345a8692cf73ace2bec184f6bb70aa2e4a2ad`. [Note34](../notes/34-WORKTREE-INTEGRATION-AND-RETENTION-BOUNDARIES.md), [round](../ROUND-U15-B.md), [STATE](../STATE.md).

Evidence classes are selected original source reading, inspected target test definitions, retained original study results, primary command-contract comparison and conditional inference. No Rust build, target test/script, live Git operation, actual worktree deletion, model/provider, installation or E10 ran. Directory/file counts are not coverage or quality scores.

## 1. Load-bearing source handles

All upstream paths below resolve at the fixed target. Ranges are inclusive source-file lines, not connector JSON line numbers. SELECTED does not mean the entire file or every dependency was audited.

| Handle | Exact upstream path | Git blob | Actual load-bearing scope |
|---|---|---|---|
| M-Q | ecc2/src/session/manager.rs | 515235760adb242fe3b4bd1e8481c8b78aee5cc4 | 1738–2440: full cleanup_session_worktree, merge_session_worktree, rebase_session_worktree, merge_ready_worktrees, process_merge_queue, one-pass merge, prune, queue structures/build, auto-rebase eligibility and result classification. Adjacent delete/resolve/cron/runtime material is incidental. Exact merge_queue_priority body was not recovered; no conclusion depends on its specific rank values |
| M-TEST | ecc2/src/session/manager.rs | same | 6060–6780: full stopped-only prune, positive-retention, stopped-session merge/cleanup, bulk active/dirty skipping, successful rebase/merge queue, failed-rebase retention and pair-conflict ordering tests; opening previous cleanup-test tail and later status tests incidental. No test executed |
| M-VIEW | ecc2/src/session/manager.rs | same | 4020–4195: team/coordination formatter and complete relevant auto-merge/auto-prune count-rendering branches; not the complete surrounding Display implementation |
| W-REMOVE | ecc2/src/worktree/mod.rs | aea51b4ddc52a7c331f045a2905ca52a772db930 | 1–310 includes types, worktree creation/branch naming, full remove with Git and filesystem fallbacks, initial preview/status helpers |
| W-GIT | ecc2/src/worktree/mod.rs | same | 630–970: full merge_readiness/merge_readiness_for_branches, branch_conflict_preview, health, dirty/staged helpers, merge_into_base, rebase_onto_base and public branch_head_oid; initial URL/helper material incidental |
| W-HELPERS | ecc2/src/worktree/mod.rs | same | 971–1300 and1420–1690: selected diff helpers and patch machinery, full git_status_short, branch_head_oid_in_repo, parse_merge_conflict_path, get_current_branch and base_checkout_path; dependency sharing and beginning of tests incidental |
| W-TEST | ecc2/src/worktree/mod.rs | same | 1820–2420, overlapping2070–2075 recovered: full ready/conflicted preview tests, successful/aborted rebase tests, pair-conflict preview test; selected surrounding patch/staging/commit tests. Draft-PR test is only an opening fragment, not complete coverage |
| D-LOOP | ecc2/src/session/daemon.rs | e62ea0ae88d71027b1627d916b3d8e6d32b37cf4 | 1–65 fresh: full run loop with separately caught errors and auto-merge→auto-prune→activation sequence, plus startup wrapper |
| D-WRAPPERS | ecc2/src/session/daemon.rs | same | 358–520: complete auto-merge flag/recorder and ungated auto-prune wrappers, then PID helper/test introduction. Actual wrapper bodies, not a substituted test closure execution |
| CFG | ecc2/src/config/mod.rs | d48bd9a67ee47a5c0d85f6d079ab40736efe61b9 | 1–555 selected, including complete Config::default: auto_merge_ready_worktrees=false, worktree_retention_secs=0, auto_terminate_stale_sessions=false. Later config/profile bodies are not a new full configuration audit |
| S-CLEAR | ecc2/src/session/store.rs | f71bb3640991f9d471e2ab98dad54dff4d346721 | 1280–1438: state/PID writers, clear_worktree and clear_worktree_to_dir, attach. Full called clearing path; no transaction claimed around external Git/deletion |
| S-BOARD | ecc2/src/session/store.rs | same | 2200–2730: list_sessions/worktree/timestamp mapping, board refresh, lookup and nearby message/deletion methods. Detailed board derivation remains the prior Note14 result |
| S-ACTIVITY | ecc2/src/session/store.rs | same | 3560–3914: full daemon_activity reader and dispatch/recovery/rebalance/auto-merge/auto-prune current-row writers; preceding graph-compaction functions incidental |
| C-MERGE | ecc2/src/main.rs | 7c516684c178d050bc36d96d0481f812e9c48c07 | 1300–1670 includes actual Config/StateStore initialization. 1940–2123 includes full WorktreeStatus/Resolution, MergeWorktree, MergeQueue and PruneWorktrees command arms. JSON result and individual/bulk argument routing followed; human formatter internals and whole main not audited |

The actual manager1738–2050/2040–2440 and worktree630–970/1420–1690 reads overlap intentionally to recover complete named bodies. Manager test6421–6780 had its full primary content visible while trailing connector metadata was clipped; no missing substantive tail was invented. W-TEST's initial patch test is partial, and the final PR test remains partial.

Immutable source entry links: [manager](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/manager.rs), [worktree](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/worktree/mod.rs), [daemon](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/daemon.rs), [config](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/config/mod.rs), [store](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/store.rs), [CLI](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/main.rs).

## 2. Additional acquired/read ranges without new mechanism-closure claims

These record the cost and incidental exposure of locating functions in large files. They must not be promoted to fully researched new families.

- Manager1450–1740,3820–3930 and4280–4530: retained lifecycle/delegate context, formatting/coordination and command-builder test material; no new profile/assignment outcome.
- Store900–1200,1420–1770,2800–2990 and3915–4230: schema/registration, scheduling/remote, messages, output/tool activity material; these are not new full migrations, security or graph studies.
- Main2110–2490 and3000–3370: adjacent migration/graph commands and connector implementations. They supply concrete next-entry leads but do not constitute the joined knowledge/connector inquiry.
- Worktree971–1300 and1820–2420 contain patch/dependency/staging/PR material beyond the selected integration question. Complete bodies visible in a range are not automatically dependency-complete feature audits.

A search for build_merge_queue and clear_worktree returned the mutable index revision `bf70150eb2df8070024e5bdf08e4aa08959e2735`. Those hits were discovery only; all load-bearing bodies above were fetched at8321021. No silent repin. Auxiliary raw-source acquisition failed at DNS and produced no original source file. No reconstructed source was executed.

## 3. Primary Git contracts checked on2026-09-22

These are documentation comparisons, not a fingerprint of an installed Git build or a performed ECC operation.

| Handle | Primary source | Narrow use |
|---|---|---|
| G-MERGETREE | [git merge-tree](https://git-scm.com/docs/git-merge-tree), description/output/exit-status and mistakes-to-avoid | --write-tree computes a tree without working-tree/index updates; status/error distinctions; human informational output is not a stable parsing interface |
| G-MERGE | [git merge](https://git-scm.com/docs/git-merge), description/options/recovery | Local current-branch integration; --no-edit concerns the message; actual conflicts and abort/continue are separate from a preview |
| G-WORKTREE | [git worktree](https://git-scm.com/docs/git-worktree), remove/prune/force | Force permits unclean removal; administrative prune is not the same operation as removal |
| G-BRANCH | [git branch](https://git-scm.com/docs/git-branch), -d/-D/force | Forced deletion does not require merged standing |
| G-REBASE | [git rebase](https://git-scm.com/docs/git-rebase), description/default branch/abort | Without explicit branch, current HEAD is acted on; abort seeks original branch/state |

These references do not establish current ECC maintenance/security status, a registry package's contents or failure prevalence. No PDF/image was required. No live remote GitHub, npm or provider action was used as target evidence.

## 4. Claim-to-source and countercontrol map

| Finding | Producers/consumers that carry it | Countercontrol / limitation |
|---|---|---|
| Real local integration beyond process completion | C-MERGE→M-Q→W-GIT→S-CLEAR, D-LOOP/D-WRAPPERS | Actual Git operation and repeated checks; no semantic acceptance or remote delivery inferred |
| Inactive is not accepted | M-Q state predicate, M-TEST stopped-session baseline | Failed/Stopped can be eligible; this can be legitimate operator flexibility, not automatically a defect |
| Preview/rebase identity differs from immutable reviewed candidate | W-GIT/W-HELPERS and candidate fields in W-REMOVE/S-BOARD | Base branch/dirty rechecks are real; changed refs/checkout are conditional and not executed |
| Keep option chooses a different bulk controller | C-MERGE→M-Q | One-pass still has guards; no equivalence with iterative rebase asserted |
| Merge/refused rebase retention can be undone by daemon cleanup | M-TEST/W-TEST→M-Q, D-LOOP→D-WRAPPERS→M-Q→W-REMOVE, CFG | Requires reached daemon/prune and successful deletion; positive retention/active states differ; no test executed or actual loss asserted |
| Stale differs across merge and prune | M-Q and CFG, prior Notes13/15 lifecycle | Stale need not imply dead; this is retained source plus new composition, not a live process witness |
| Reported failure or cleanup does not uniquely identify effect | M-Q/W-REMOVE/S-CLEAR/S-BOARD/C-MERGE | Some errors propagate, some warn; Git history and other logs can still preserve evidence |
| Last-pass summary is not per-candidate acceptance history | D-WRAPPERS→S-ACTIVITY→M-VIEW | Actual count reader exists; detailed per-call outcomes remain available through JSON |
| Unknown status can become empty/clean | W-HELPERS git_status_short versus W-REMOVE detailed status | Spawn errors and other checks can still fail; not proof that every unreadable candidate is merged |

## 5. Prior study recovery and evidence inheritance

At research input6cb345, `evidence/U09-A2-SOURCES.md` was freshly read in full as `9ed1a070181e890f08310651b97f13a2f30bdb4d`. It recovered prior source ranges and the previously partial retention test; it is not itself new primary evidence. Original Notes13–15 remain the source-grounded session/attempt/resource explanation. Note33 and the twelve-family reconciliation supplied the authorized G1 question, not its answer.

WHY was freshly read as1c9fc08bdc990dd5151c2590a58d7173aa91e26f and METHOD as7a6537b4a3d953c05c3671895a718ab41fd973ff, including recovered82–109 tail after an empty out-of-range request. Canonical controls and work-state recovery are recorded in MR35, not treated as ECC evidence.

No original note, ledger or experiment was rerun or revised. E06 remains excluded; both E05 histories, E07 SQL/Git, E08 adapted review and E09 original Python/scripted provider retain their actual scopes. The new scenarios are **source-derived conditional counterparts**, not measured product incidents, failures of an executed upstream suite or independent verification.

## 6. Completion and unclosed claims

The bounded qualification→Git effect→retention/result question is answered through actual CLI and daemon consumers. Detailed TUI gestures/renderers, exact priority ranking, draft-PR/remote delivery, all tests, arbitrary multi-repository/migrated/corrupt environments and actual installed Git behavior are not claimed complete. Re-enter only when a stronger or changed claim makes them material.

Q04i2 retains exact candidate/base/repository/actor binding; actual semantic acceptance, concurrent ref changes/controllers, cleanup/crash/retry/durability and useful-output recovery. Source closure is not a deployment recommendation or adopted SOUL requirement.

Next U15-C/Q05d follows G2: connector/checkpoint/import→graph/knowledge→recall and actual recipient/context use. Main3000–3370 is an already exposed entry, not completion. Source findings and this ledger precede final entry/receipt/STATE alignment; publication claims require actual readback.
