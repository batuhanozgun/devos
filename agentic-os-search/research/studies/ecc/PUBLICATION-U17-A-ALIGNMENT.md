# U17-A — Catalogue alignment closure

**2026-09-22.** Follow-up to [the original interrupted-publication receipt](PUBLICATION-U17-A.md). This records publication correspondence only; no target experiment, changed research conclusion or independent verification.

## Input and recovered authority

Batu asked to continue. Fresh canonical AGENT and all nine routed protocols were fully read, including clipped tails. Research main was directly read as `eb6651c1c4d21d063b78141cce86fe97b52a4c74`; fresh STATE blob `fa67cd611b1ef24512e627c14a9edf432d38c6ba` confirmed the only outstanding U17 publication operation was the CATALOG ECC row. The immediately preceding full same-conversation INDEX/META/PLAN0.41, WHY/METHOD, question register, Note39/ledger/MR40 and original receipt remain the recovery inputs at this unchanged head. Control files are not ECC evidence.

The current catalogue was freshly read through EOF in ranges 1–42 and 43–200, blob `9b0237d38d4f26eb394c1b6bc1f90b163616a842`. The original blocked payload was not reused as verified content. A new call through the same create_tree route was permitted this turn; no safety-bypass or alternate write route was used to overcome the earlier block.

## Candidate review and actual publication

Input commit's tree: `059587332b644615f622ccfd76ef04b71d27d9bb`.

First candidate `10f6333a8c88ad9c11518a5b080bb132f99d43fe`, tree `07fbf66fc370a1958bbdf4546cb9415832ef48ab`, contained unintended transcription changes to Leantime, Matt Pocock, OpenProject, OpenSpec and memory-provider guidance, plus a missing final newline. Its actual primary commit diff exposed them. It was rejected before main. This repeats a known manual whole-file transfer risk; review caught it, but that is not evidence that the production method is efficient or error-free.

Corrected candidate `2bc269d85b1163b5cb1d6c5492dad39a558ea74d`, tree `d3a0c8e0ae31338cd82e9a5b351919c3ca38b09c`, has the same input parent. Its complete diff changes only the ECC row (+1/-1), preserving unrelated text and terminal newline. Fresh input-to-main comparison was identical. A non-force update_ref moved main to that candidate. Fresh main row31 readback returned catalogue blob `8722389b9fc5876cc2b0cb569eb2785025211975` and the expected U17/Note39/E10/recovered-evidence/next-scorecard semantics.

## Disposition

The catalogue publication gap recorded in the old receipt and old STATE is now closed. Those previous statements remain truthful historical records, not current outstanding work. No original Note39, source ledger, E10 bytes/criterion, recovery recipe, prior experiments or other study result was changed. E10 was not rerun. No user upload/merge task, named branch, upstream action or force update occurred.

U18-A/G5/Q06e can now be activated under the existing PLAN0.41 criterion. This closure is not U18 research, whole-study completion or approval of a SOUL architecture. Final STATE owns current activation; its write/readback is a subsequent operation. The current turn should preserve a bounded research and publication unit rather than allow this repair to obscure the authorized next question.
