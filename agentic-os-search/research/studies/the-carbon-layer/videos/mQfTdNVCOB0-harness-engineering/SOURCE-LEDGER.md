# Source ledger — identity, coverage and recovery

**Observation date:** 2026-09-12. Source IDs are local to this package. Reading a source is not endorsement. Where the source reports execution, it remains the authors' result unless independently rerun.

## Trigger and primary sources

### V01 — original video

- Supplied URL: https://www.youtube.com/watch?v=mQfTdNVCOB0&list=PPSV
- Stable video ID: `mQfTdNVCOB0`.
- Title: *Harness Engineering Masterclass: Technical Deep Dive on how to build Agentic Systems*.
- User-uploaded MP4/video and WebM/audio are distinct files. Exact names, bytes, SHA-256, probe durations and sampled times: [MEDIA-MANIFEST](evidence/MEDIA-MANIFEST.json).
- Direct YouTube page access failed in the available web surface. Native caption track and publication date were not verified. Do not turn a search index date into the video's upload date.
- Actual visual reading: 14 frames, listed in the manifest. They show the opening qualification, ten numbered primitives and the separate harness-evolution loop. Frames support the chapter identities and visual structure, not every spoken or product-specific assertion.
- Audio file was identified/probed/hashed, not fully listened to or transcribed locally. The original binary files are not committed to the repository. Recover the video by ID or the user-supplied media when fidelity is material; the local `/mnt/data` copy is not a guaranteed future-session resource.

### V02 — derivative transcript representation

- https://iamtypist.dev/tools/youtube-transcript/mQfTdNVCOB0
- Timestamped transcript read from the opening through the 28:00 music cue. Derivative source, not verified native YouTube captions.
- Obvious transcription noise occurs in product names and some sentence boundaries. Use timestamps and V01 for contested wording; do not silently repair a name and then present it as an exact quotation.
- Full video audio/transcript alignment is OPEN. The original-source frame checks are limited, not independent verification of the whole transcript. This package stores our map and findings, not a wholesale transcript republication.

### P01 — paper, fixed v1

- Yoonho Lee, Roshen Nair, Qizheng Zhang, Kangwook Lee, Omar Khattab and Chelsea Finn. *Meta-Harness: End-to-End Optimization of Model Harnesses*.
- https://arxiv.org/abs/2603.28052v1 ; https://arxiv.org/pdf/2603.28052v1
- arXiv submission history observed: v1, 2026-03-30 05:33:50 UTC. The unversioned PDF supplied by the user served this v1, 26 pages. No local PDF byte hash is claimed.
- First-pass substantive coverage: main text §§1–5 and appendices A–E. Bibliographic entries were used selectively to identify dependencies; their publications were not thereby read or verified. Do not claim an exhaustive literature review or byte-by-byte reading of every reference entry.
- Visual checks of paper pages 1, 2, 6, 7, 8, 9, 15, 18, 19, 20, 21, 22 and 24 cover Figures 1–9 and Tables 1–11. Page numbers are one-based printed PDF pages; screenshot indices were zero-based.
- arXiv's license link resolves to CC BY 4.0: https://creativecommons.org/licenses/by/4.0/ . Notes in this package are our paraphrase/analysis, not an endorsed or unchanged version of the paper.
- No experiment, raw-run audit or independent replication was executed. Paper caveats and internal reporting ambiguities are preserved in Note02.

### P02 — first-party project page

- https://yoonholee.com/meta-harness/
- Read as a presentation and source-discovery surface on 2026-09-12; no immutable webpage snapshot/hash.
- Its classification context quantities use characters, whereas the main paper table reports tokens. Keep each unit with its source; do not infer conflicting performance merely from differently scaled quantities.
- Links to code, project presentation and comparisons are discovery routes. Current leaderboard ranking, current model availability and eventual venue status were not independently established.

### C01 — public framework/reference experiments

- https://github.com/stanford-iris-lab/meta-harness
- Pin: `0cbc31e97c9e6d24232d1dc754827c02e1ec415c` (observed main, commit 2026-09-11).
- Root tree: `37d52e49bb7d8e945d4d9dafc240833184f0a8e7`, untruncated nonrecursive listing.
- Fully read root `README.md`, blob `66cb63258372c1e403ec104f7f31d3799de382d4`; its identity was checked in the pinned tree.
- README distinguishes reusable framework, text-classification and TerminalBench reference experiments, and a separate selected-output repository. Its release note says the code was cleaned up and testing was limited to checking that it runs. This is a source qualification, not proof that the implementation is defective.
- Tree-discovered but not read: `ONBOARDING.md` (blob `287c0953cfa2715d6298e604182b8e464fcf5106`), `reference_examples/`, `experimental/`, remaining root files. No transitive implementation was read or executed in U00.

### C02 — selected TerminalBench harness artifact

- https://github.com/stanford-iris-lab/meta-harness-tbench2-artifact
- Pin: `57fefdb2ff84af3fd81b69d67814acbe69bd0743` (observed main, commit 2026-03-26).
- Root tree: `ef22c53d1962f44242eb8414e516ee2427218d0a`, untruncated nonrecursive listing.
- Fully read `README.md`, blob `00e631ed58c8d7d1ab5c7e7f9e4ea283a388f893`; identity checked in the pinned tree.
- Discovered, NOT read: `agent.py` (`8b460a3e9e41d77b757b2e651d9d7cb8d129d82b`, 52,915 bytes), `anthropic_caching.py`, `pyproject.toml`, `prompt-templates/`.
- README reports 89 tasks × 5 trials and 76.4% for Opus 4.6, describes environment bootstrapping and supplies a run command. These are author claims; neither the command nor benchmark was run by this study. This is an output agent, not the whole search procedure.

## Canonical local-library orientation

Initial ref: `batuhanozgun/agentic-os-search@e562de82ab4ea33872e55d501c8b59f26b441fa8`.

- Root AGENT and all triggered protocols R01–R09 fully loaded before substantive work; truncated protocol responses were completed via additional ranges.
- `research/INDEX.md`, studies `INDEX.md`, `CATALOG.md`, `PACKAGE-CONTRACT.md` read.
- Foundation `STATE.md` / `INDEX.md` read for authority and stage. At this initial snapshot Re-expression/Semantic Transfer awaited user evaluation; this study did not resume that work or adopt its proposed leaf.
- soul-context `STATE.md` / `INDEX.md` read. Normal DevOS implementation coordination belongs to Codex under its existing grant; live implementation success was not established by this study.
- context–memory–harness `META.md`, `STATE.md`, `INDEX.md` fully read; `04-CROSS-LAYER-SYNTHESIS.md` lines 1–800 read (through the beginning of §22; tail not read). Its relevant §§1–21 support the nonduplication assessment. Component deep-dive files and their primary sources were not reread.
- HERMES `META.md` and `METHOD.md` fully read; GSTACK `META.md` fully read. Other listed packages were discovery candidates from the catalog, not fresh substantive evidence. GSTACK METHOD/CORE and HERMES code were not reread here.

Shared-router refresh: main advanced to `6a9a8c48204102d592780971a212b363ec97bc98`. Compare showed two commits affecting HERMES and the catalog only. Studies INDEX and CATALOG reread at this ref; the fresh U11 catalog row was retained. The older U10 HERMES metadata remains only an intake observation.

Final publication refresh: main advanced again to `793959079cb404d7a31a68f7f47dda77d9a73bec`. Compare showed one Foundation-only commit; current Foundation STATE was reread and its subtree identity recovered directly from the repository directory listing: `a762bc966e35ae838c7e01d1856f8a293749d894`. Re-expression is now accepted; Claim Warrant W0–W7 is proposed and awaiting evaluation, with no successor active. No Warrant deep-dive was read by this study. The entire new Foundation subtree is preserved, not edited or reverted. Studies/router/control/context content is unchanged by that last concurrent commit.

## Access and recovery notes

Local HTTP attempts to YouTube/arXiv/transcript hosts failed with DNS errors; web reading and GitHub connector access succeeded. No local PDF download or full raw-transcript file is claimed. Public transcript-service discovery was a fallback after native page access failed; no additional plugin was installed, no external transcription job was submitted, and no media was uploaded to another service.

For continuation, use source IDs plus exact ref/page/time, not this ledger as a substitute for the underlying claim. Revalidate current external behaviour when needed; keep historical pins unless a deliberate repin/delta decision is recorded.
