# U11-A — Native review/caller/outer-decision sources

**2026-09-19 · Q04h.** Fixed target: [affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Result: [Note19](../notes/19-NATIVE-REVIEW-CALLER-AND-DECISION-BOUNDARIES.md). Method: [MR20](../ROUND-U11-A.md). [E08](u11-a-review-flow-probe/README.md) owns the new adapted local execution evidence; STATE owns current work/publication.

## Actual reading

All target bodies below came through connected GitHub at the unchanged pin. FULL means the named body through EOF, not its entire dependency tree, installed host behavior or completed research into every incidental section. Existing S23/S167 retain their identities. U11A identifiers are unit-local handles for the exact paths, not renumbering of the older master ledger.

| ID | Pinned path | Git blob | Actual coverage |
|---|---|---|---|
| S23 re-entry | workflows/README.md | db58b5a398f1f4ef651baa360af6d46034568ad4 | FULL; pilot/outer-gate/invocation and explicit integration follow-ups |
| S167 re-entry | workflows/orch-review.workflow.js | 3fd502da40d77c46c28e0ed8b6845bb0072393ef | FULL 1–200/201–420 through EOF at296; input, selection, schemas, prompts, fan-out, merge, verification and final return |
| U11A-01 | commands/orch-review.md | 5216c7df157a9099214c122bc096e9693730ac77 | FULL; interpreted gather/invoke/report/no-fallback contract |
| U11A-02 | skills/orch-pipeline/SKILL.md | 6cb421ddc550b29657b33dccc349542c9cbcb7f8 | FULL 1–200 through EOF; shared procedure, size/phase choices, traditional review, two human gates and planning-document handoff |
| U11A-03 | commands/orch-add-feature.md | 57db622c5a26ce6241cc42ff4cf013458e7f7281 | FULL representative operation command |
| U11A-04 | skills/orch-add-feature/SKILL.md | e26285093ce99cd6f6ba6dcbbd84b03b1e4236ed | FULL representative wrapper and shared-pipeline binding |
| U11A-05 | agents/code-reviewer.md | 884d94ec2d45a51ba091519dbee416c7d563e3d6 | FULL 1–220/221–410 through EOF; tool/model declaration, workspace context, proof/filtering and separate approval vocabulary |
| U11A-06 | .claude-plugin/plugin.json | 5f1e9a391ae0e0f096f9f65d7b1f119b549bc6b5 | FULL; plugin identity and commands/skills paths, not installed discovery proof |
| U11A-07 | package.json | 87487a914c0fd739ea62107e7bf9e56b127207a5 | FULL 1–240/241–550 through EOF; explicit files list and build/test scripts. No package was built or installed |

Pinned entry links: [workflow](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/workflows/orch-review.workflow.js), [command](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/commands/orch-review.md), [pipeline](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/skills/orch-pipeline/SKILL.md), [reviewer](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/agents/code-reviewer.md), [package](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/package.json).

Other operation wrappers, language/security reviewer bodies, full install/manifest behavior, all native workflow tests, actual GitHub CLI execution and native Workflow SDK implementation remain outside this unit's body/execution coverage. No search miss is an exhaustive absence claim.

## Producer/consumer closure

**Request and target:** U11A-01 describes local HEAD-relative diff/path collection and numeric PR-id extraction before gh calls. The URL's repository component is not propagated by the shown numeric-only commands. W-U11A-GH bounds actual CLI targeting; a wrong-repository result is conditional on the resolved gh target and no out-of-band correction. Safe argument restriction is not exact target binding. Input.diff is checked for nonempty string, not parsed as a unified diff.

**Host and selection:** S167 accepts args, chooses quality plus optional language/security dimensions, and passes schemas to agent. The security predicate is lexical. The selected-dimension failure flag does not independently certify that every necessary dimension was selected. U11A-05's workspace-reading procedure and S167's diff-only verifier instructions use different evidence scopes. Their actual host interpretation remains unmeasured.

**Finding composition:** S167's merge keys file plus normalized evidence, keeps the first finding's other fields, and updates only dimensions/severity. E08 demonstrates proof/title loss when a later stronger finding joins an earlier weaker one, even with all supplied responses individually schema-valid. The native parallel result order is not verified by this local adapter. Same-file equal snippets at distinct locations can merge; that is not proof of semantic bug identity.

**Verdict and failure:** S167 preserves null/error review dimensions, unverified blockers and low-confidence false verdicts. True at low confidence remains blocking but is counted confirmed. Individual reviewer verdicts are discarded; the final result is recomputed from aggregate blockers and failed dimensions. E08 tests these predicates with supplied responses, not actual task-quality judgments.

**Outer decision:** U11A-01 reports to the main conversation and prohibits a fallback approval after Workflow failure. U11A-02/03/04 describe plan and pre-commit human gates; their examined bodies contain instructions and handoff documents, not a Git admission controller or revision-bound approval token. S23 explicitly leaves native pipeline/installer integration as follow-up. The ordinary pipeline's Phase5 still names the traditional reviewer/command rather than the native pilot.

**Delivery/continuation:** U11A-06/07 and W-U11A-HOST constrain discovery claims. A missing explicit workflows manifest field is not sufficient negative evidence because the host documents a default plugin directory. The package's explicit file list omits root workflows; this is a declared-selection boundary, not an observed packed-artifact failure. Host resume is separate from an ECC durable consent/review record. No native run, relaunch or actual commit was performed.

## Dated primary external contracts

These are selected current official documentation checks on 2026-09-19, not a repin of ECC or an installed-version receipt.

- **W-U11A-HOST:** [Claude Code dynamic workflows](https://code.claude.com/docs/en/workflows), selected skills/script distinction, launch permission, plugin distribution, args/null behavior, runtime limits and resume sections. Used only to qualify host responsibility; no full SDK/API conformance claim. The linked SDK page could not be acquired because the response exceeded the fetch size limit; a markdown retry also failed.
- **W-U11A-GH-DIFF:** [gh pr diff](https://cli.github.com/manual/gh_pr_diff), command argument and inherited --repo contract.
- **W-U11A-GH-ENV:** [gh environment](https://cli.github.com/manual/gh_help_environment), GH_REPO target selection. No token value, credential or user environment was inspected.

## Local evidence: E08

PRECHECK was published before the one adapted run. The complete workflow's reconstructed bytes matched Git blob3fd502d and SHA-25683bdff29 before execution. The adapter changes only export-to-const and supplies host globals; Promise.all ordering and deterministic responses are explicit fixture assumptions. Node22.16.0/Linux x64 executed18 scenarios; all planned assertions completed. A separate jsonschema4.26.0 Draft7 check accepted all38 non-null supplied replies against the workflow's own schemas. Nulls/rejections remain explicit controls.

The proof-sensitive fake verifier was chosen to test information transmission, not to judge the source diff's correctness. Reversed-order and different-evidence/file cases discriminate merge loss from universal verifier failure. The observed source invariant breach and controlled final-verdict change do not establish a live missed vulnerability, actual native scheduling behavior, independent review efficacy or incident rate. Previous E04/E07 and excluded E06 remain separate.

Complete raw data is recoverable from the four encoded parts and decoder in E08 README. Their repository blobs and the executed probe blob matched local bytes. An earlier incomplete single-file payload and ineffective retry are publication errors, not target-experiment failures; the invalid path was removed after replacement correspondence checks. The README and receipt retain the correction history.

## Access, coverage and next responsibility

A guessed commands/orch-pipeline.md returned404; the real skill was located by default-branch search and then fully read at the pin. Search results at07756cee15788a54506031462794ad645719b028 served discovery only. Searches for workflow references returned limited results, not a complete test/caller inventory. Raw download DNS failure did not block connected acquisition or prove a GitHub outage.

U11-A answers the bounded native-review/caller/outer-decision source question with E08 at its limited execution scope. Stronger host/schema/permissions, exact repo/revision and consent binding, discovery/packing, semantic dedup, real reviewer calibration, live repair/review and cross-session continuation remain Q04h2. No remediation was adopted.

Next selected U11-B concerns the separate Rust scheduled-work admission path, starting with the already identified S189 ecc2/src/session/daemon.rs and actual manager/store callers. No new scheduler source inquiry began here. Other operation families, remote/delegation variants, host/provider, release/audit/observability, native synthesis and final omission work remain in PLAN.
