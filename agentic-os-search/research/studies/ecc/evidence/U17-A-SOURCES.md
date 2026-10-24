# U17-A — Guidance, procedure and E10 source ledger

**2026-09-22 / MR40.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`; recovery input research main `8e6f6547e0b600dba6015046097c459dbc2af16d`. [Note39](../notes/39-GUIDANCE-ADAPTATION-AND-PROCEDURAL-HANDOFFS.md), [round](../ROUND-U17-A.md), [STATE](../STATE.md).

SOURCE OBSERVATION and TARGET INSTRUCTION are separate from conditional INFERENCE. TEST SOURCE INSPECTED does not mean tests passed. E10 is a recovered original LOCAL EXECUTION; this continuation performed ARCHIVE RECOVERY CHECKS, not another target campaign or model test. Full means reading through EOF, not complete dependency/runtime certification.

## Fixed-pin source bodies recovered in this continuation

All paths are relative to [the fixed target](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a).

| Handle | Path | Git blob | Coverage and role |
|---|---|---|---|
| ADAPT | scripts/gemini-adapt-agents.js | bea91cb10f5e3cf078f171e9c3ba4d69d172d37c | FULL; actual CLI/regex/tool mapping/write/counter consumer;4026 bytes also bound to E10 original |
| TOOLS | scripts/lib/agent-tools.js | 8b810c8855676da906c9be2e0c07bdf677dba584 | FULL; scalar/flow/array normalizer, quoted/nested comma handling;2211 bytes also in E10 |
| GEMINI | .gemini/GEMINI.md | 7b9b2d670faee557f955bf522936d6ac9abce1c2 | FULL; declared project-local baseline and guidance references; catalogue counts remain target claims |
| G-ADAPTER | scripts/lib/install-targets/gemini-project.js | f87f8539d19f3b15fb8983de9cf2c9f835780d1e | FULL; actual generic project adapter configuration |
| HELPERS | scripts/lib/install-targets/helpers.js | f69d75e86bab0276eee66359366096d1c38f2441 | FULL1–300/301–600 through EOF; generic mapping/scaffold and foreign-platform filtering. Prior lifecycle coverage is not rerun |
| MODULES | manifests/install-modules.json | 884c7d39d867dd882ba097bcaab9dd2696ed1a5e | SELECTED1–220; complete first five core/platform entries and partial next catalogue. Gemini inclusion/exclusion claim is limited to those complete entries |
| PLUGIN | .claude-plugin/plugin.json | 5f1e9a391ae0e0f096f9f65d7b1f119b549bc6b5 | FULL; skills/commands declarations, not proof of installed auto-discovery or absence of other discovery conventions |
| PATTERN | docs/PLAN-PRD-PATTERN.md | ed9b0c97a921e7f16817293a36e3e3d5971ff8a8 | FULL; author's staged/resumable/programmatic claims and optionality |
| PRD | commands/plan-prd.md | 192295785c8fe05f9524c61158872661d587b728 | FULL; requirements/assumption/hypothesis/user gates and milestone artifact producer |
| PLAN | commands/plan.md | 7397529577199ad2666b65f21ddb9bfbc27b24af | FULL; actual interpreted modes, inline default, optional specialist, file/status/approval and handoff |
| TDD | skills/tdd-workflow/SKILL.md | e7d5b2c303368573a20580b972f8ebc072939ef0 | FULL recovered: initial large view through testing patterns,400–760/EOF plus overlapping340–410 closes clipped E2E boundary. Plan-as-data, real RED/GREEN intent, task/branch/checkpoint and report |
| PR | commands/pr.md | 264ec3fff0147be0254166ba42c3df0a74ff8fb2 | FULL; interpreted branch/template/artifact/push/rebase/PR/check reporting and later review/merge boundaries |
| PLANNER | agents/planner.md | e9e282f54d5ea8dbecae31d00c8647960c089f05 | FULL; concrete tools/model and specialist procedure; embedded worked example not an executed project |
| TEAM | skills/dev-team/SKILL.md | a6a7340dbde4f58713811fe945ae86f6cca5f074 | FULL; four-role dispatch, bounded untrusted summary, parent synthesis and optional persistence |
| T-ADAPT | tests/scripts/gemini-adapt-agents.test.js | d8db764a985ea1c35557b576a110660b47a1d2a2 | FULL, NOT RUN; four real tmp/subprocess transformation/help/default-directory tests |
| T-TEAM | tests/docs/dev-team-skill.test.js | a53dd622c5307d086148f6f153695b5f97e6ca6f | FULL, NOT RUN; text/trust-label/reference/registration checks, not persona execution |

GEMINI-TREE: complete recursive API response for historical `.gemini` tree97fa17f429d92f33680d820efca8a78660c971b1, truncated=false, contains only GEMINI.md. The install-targets directory listing was clipped; selected exact paths were recovered but it is not a full reviewed inventory. Default-branch searches for generator, dev-team and PRD returned newer bf70150e paths; they are discovery only. Every load-bearing body above was fetched at the unchanged fixed pin.

## Claim-to-chain correspondence

1. Baseline versus conversion: GEMINI-TREE/GEMINI→MODULES first five entries→G-ADAPTER/HELPERS contrasts with ADAPT's separately invoked directory mutation. Neither an optional converter's presence nor a scoped target declaration certifies an all-agent installation. Other callers remain outside this narrow no-call claim.
2. Local conversion: ADAPT→TOOLS→changed/unchanged count and file output. E10 uses exact originals and preserves all seven cases. LF regex, block-list rewriting, retained unknown/model/body and no-frontmatter counts are bound to those bytes. T-ADAPT's producer-oriented tests do not run the host.
3. Durable procedure: PATTERN→PRD artifact→PLAN pending selection/file/status→confirmation→TDD input normalization/evidence→PR references/push/create/check reporting. Source prose describes what the actor should do, not independently observed obedience or a hidden programmatic parser.
4. Continuation counterpart: PLAN's in-progress write precedes coding confirmation; next-pending reentry lacks an explicit in-progress reconciliation in the selected contract. Source path/milestone references do not pin a PRD revision. TDD and PR have different admission/output purposes; no complete-status writer is specified in these selected documents. This is not whole-repository absence or observed skipped work.
5. Procedure variation: TEAM's parallel personas receive one derived summary and explicit untrusted labels, parent synthesis and no default saving. That differs from PLAN's inline default. A shared summary can carry shared omissions; role separation is not independent evidence. D-GEMINI-AGENT's no-nesting contract makes execution location consequential, without claiming the converter actually installs TEAM as a subagent.

## E10 chronology and recovered bytes

[PRECHECK](u17-a-guidance-adapter-probe/PRECHECK.md), blob97c30c980cc74e87a015773a31e75ed696cbde6e, commit7217bce94845a71f07de8d98e066fffe91566def, fixes seven discriminators before the archived run. The original report records2026-09-22T13:49:06.272742+00:00, Nodev22.16.0, Python3.13.5, PyYAML6.0.3. One campaign, seven cases; C5 is an explicit second-call control. No host/model/network/credentials/installation/upstream suite or procedural-obedience run. The source-informed criteria matching is not a product-safety verdict.

The current continuation opened the original mounted archive, read its complete harness/report and source identities, and checked all member CRCs. Original ZIP8821 bytes/SHA256d16d24c6b04a17f98d8a62513342170921e05930b883470f123e6d3d4e16888d. Both source Git blobs were checked against fresh connected-GitHub fixed-pin reads. This is evidence recovery/source correspondence, not independent reperformance.

The full repository base64 text was recovered beyond the truncated view, transferred locally and recomputed as its exact remote blob3b92e3eb9111b10416de99fd88591607e6dea582. It is corrupt and not directly admissible as decoded ZIP evidence. [README](u17-a-guidance-adapter-probe/README.md) documents the precise difference and original member hashes. [restore_e10.py](u17-a-guidance-adapter-probe/restore_e10.py), blob1fd66733c7c1a0e0c3feb5ee243f28e5232cbdac, was read back, matched locally and executed on that exact bad file. It produced an archive byte-for-byte equal to the original; altered input was refused. [Recovery check](u17-a-guidance-adapter-probe/recovery-check.json) records that execution separately. Bad input remains unchanged for traceability; its deterministic guarded repair supplies a repository-only recovery route. No user upload is necessary.

The defect is a confirmed publication-transfer mismatch. It does not establish why ChatGPT reported thinking failed. No original result, criterion or experiment exclusion was changed. No new target campaign ran during this recovery turn. No selective deletion of unsuccessful cases occurred.

## Dated primary host references

Checked2026-09-22 via official Gemini documentation, not an installed version or proof of fixed-pin historical conformance:

- D-GEMINI-AGENT: https://geminicli.com/docs/core/subagents/ — definition locations/format/schema and isolation/recursion protection. Markdown frontmatter/body, tools array, model field and no nested subagents support the bounded contrasts; broad efficacy claims on that page are not adopted.
- D-GEMINI-COMMAND: https://geminicli.com/docs/cli/custom-commands/ — native TOML commands and required prompt, not generic Markdown conversion.
- D-GEMINI-CONTEXT: https://geminicli.com/docs/cli/gemini-md/ — hierarchical context and configurable context.fileName; file presence alone is not a verified active prompt.

No nonprimary article or search snippet supports a technical conclusion. No PDF/media analysis was required. Auxiliary raw-network acquisition was unavailable; connected-GitHub source reads remained available. Existing local E10 archive supplies execution evidence, not a reconstructed target run.

## Project recovery and scope

Fresh AGENT unchanged; all nine full canonical protocol bodies from this conversation remained applicable. Controls govern the assistant and are not research evidence. Fresh STATE4ccc7e9 and MR40 opening33c4b7a recovered interruption; compare aebd7b10→8e6f6547 showed only four ECC-local paths, no new finding/ledger/publication. Fresh WHY1c9fc08 and full METHOD7a6537b4(1–95/96–180 EOF), full historical TREE-FRONTIER3e4f52ae, full U07 mapd43b08b6 and SOURCE-LEDGER1–110/583eed11 restored purpose and source selection. Full U15-A reconciliation and PLAN0.40/META/INDEX remain available from prior same-conversation canonical reads; these are not independent evidence or new experiments.

Note39's coherent representative G4 answer does not close Q01a2's recursive/mirror and G6 omission challenge. Other procedural/host/translated variants keep material re-entry. Next existing G5/U18-A is harness-audit and its actual optimizer/command consumer, NOT STARTED. Other optional interfaces, CORE and joint evaluation remain. Original Notes01–38, earlier experiment identities/corrections and E06 exclusion are preserved; no architecture or upstream change follows. Verified publication belongs to subsequent entry/receipt/STATE checks.
