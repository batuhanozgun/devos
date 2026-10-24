# U01-M2 — prospective diagnostic specification

Written after full source inspection and source-identity verification, before the first experiment run. Exploratory same-researcher work, not a holdout, independent replication or product conformance test. Pin: `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.

## Scope

Execute five complete, Git-blob-verified modules: MemoryStore, memory_tool, write_approval, write_approval_commands, skill_provenance. Synthetic boundaries: fixture-only home/config/registry/terminal callback, strict boolean config parser, sentinel scanner, and a standard-library temp-file/replace writer. That writer can raise OSError *before* changing the target. No real user home, provider, account, network, production config, actual threat scanner, full AIAgent, CLI or gateway entrypoint.

Memory/file operations are real only within disposable fixture directories. MemoryStore's Linux fcntl branch is not stubbed. A stale-two-store case is deliberately ordered, not a concurrent race test. The shared pending command is real; the caller supplying its store is synthetic.

## Fixed questions and expected distinguishing observations

| ID | Case | Observations required |
|---|---|---|
| N01 | Ordinary replacement and explicit reload | Disk/live entries change; load-time snapshot stays old until `load_from_disk`. |
| N02 | Pre-commit write failure and retry | Tool raises RuntimeError; disk stays old, live entries contain proposal, snapshot old. Explicit reload repairs live state; successful retry writes. |
| N03 | Batch semantics and final budget | Add-then-remove may fit final budget; a later unmatched operation commits nothing. |
| N04 | Removing last entry | Batch refuses complete emptying; explicit single remove succeeds. |
| N05 | Invalid UTF-8 already on disk | Even append-only add refuses without overwriting bytes. |
| N06 | Two preloaded store instances | Second mutation reloads first instance's durable write and preserves both; its snapshot remains its own original load. Ordered test, not all concurrency. |
| N07 | Harmless sentinel, three parameter forms | Single new_text and batch content call the rejecting scanner; batch new_text can persist without that pre-scan. Explicit reload invokes the scanner and masks the sentinel in snapshot, while raw/live retain it. No malicious payload. |
| N08 | Stage → command → replay → store | Staging changes no memory file. Approve writes and deletes pending record; snapshot remains old. Record origin is background_review; actual write observes caller's foreground origin. Not an authorization verdict. |
| N09 | Pending apply write failure | Shared command reports zero approved/failed and retains pending. Disk/live divergence remains. Successful retry commits and clears pending. |
| N10 | Target disabled between stage and apply | Replay refuses and retains pending, without a write. |
| N11 | Pending cleanup failure after successful apply | Command reports approved though pending remains. Re-approval of add is idempotent and, once unlink works, clears record. Not exactly-once assurance for other ops. |
| N12 | Semantically invalid batch staged | List-shaped unknown op can stage; actual approval rejects and leaves pending, without memory writes. |

Each case records file bytes, live entries, frozen snapshot, returned JSON/text or exception and relevant callback/writer/scanner trace. A matched diagnostic expectation is not a product PASS. Unexpected results remain in the output; no threshold or case exclusion will be changed to manufacture a pass.

Negative identity check invokes the actual pre-import guard on a modified source copy and must reject it before module execution. Fresh outputs must not overwrite prior evidence. This experiment does not close D2's full-source AST check or full review/worker integration.
