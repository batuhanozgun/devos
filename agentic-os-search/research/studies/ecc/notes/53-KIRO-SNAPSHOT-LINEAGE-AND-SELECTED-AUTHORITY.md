# Note53 — Kiro snapshot lineage and selected authority

**2026-09-24 · U19-E / G6 / O2 / Q01a2e / MR54 · BOUNDED SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U19-E-SOURCES.md), [round](../ROUND-U19-E.md), [STATE](../STATE.md). Historical/source observations, authored claims, current interface documentation and conditional deductions remain distinct. No target generation, installation, test, host/model/MCP operation or E11.

## 1. Result: an older parallel representation, not demonstrated conversion loss

Note40 established that the primary optimizer is more detailed than the Kiro Markdown and embedded JSON. It deliberately left production and selection unresolved. This unit tests the tempting explanation that a converter removed the primary's stronger requirements.

The historical discriminator changes that explanation. At the merged Kiro-agent addition `bf4a22f082ef70dde295d993c80958f80a23df92` on 2026-03-23, the primary optimizer already has the same short workflow body as the Kiro versions. The Kiro Markdown and JSON fetched at that commit have exactly the same respective Git blobs as at the fixed research pin. The primary at the research pin is different and contains the later detailed evaluation, snapshot, regression and human-review requirements. Metadata differs across formats; this is body correspondence, not whole-file equality between primary and Markdown. [PRIMARY-OLD, KMD-OLD, KJSON-OLD, PRIMARY, KMD, KJSON]

Thus the observed current divergence is compatible with a formerly aligned copy remaining unchanged while the primary develops. It is not evidence that a converter discarded requirements already present in its source. The addition PR identifies dual-format assets, and its complete changed-path list contains those assets, not a maintained generator. This does not establish whether a contributor used an uncommitted script, manual editing or another production tool. No author intent, complete historical pipeline or absence of every possible generator is claimed. [PR810]

For the actual documented installation path, this production uncertainty does not hide an active generator: INSTALL is fully read and copies the already committed `.kiro` assets. It neither reads the current primary optimizer nor regenerates JSON from Markdown. The relevant deployed object is consequently a preserved local variant, not automatically the latest primary agent. A source-history question and a current deployment mechanism are different responsibilities.

## 2. The recovered deployment and selection chain

| Stage | Concrete producer or consumer | Supported boundary |
|---|---|---|
| Primary procedure | `agents/harness-optimizer.md` | Stronger authored evaluation and approval text; not a general automatically enforced optimizer |
| Kiro representation | `.kiro/agents/harness-optimizer.md` and `.json` | Short body and separately encoded metadata; JSON prompt is inline, not a file reference to its sibling |
| Documented entry | `.kiro/README.md` → `.kiro/install.sh` | Source-directory-to-project/global copy route, not the shared manifest installer or an automatic source synchronizer |
| Materialization | INSTALL copies missing agent JSON/Markdown into target `.kiro/agents` | Existing target files are retained independently; no content/version comparison or pair reconciliation |
| Host discovery and selection | D-AGENTS / D-CONFIG | Dated format/location/prompt contract, not observed installed loading or model compliance |
| Repository validation | PACKAGE test entry → VALIDATOR | Actual root-agent metadata validator; not a Kiro/primary equivalence check |

The README's division of JSON for CLI and Markdown for IDE is an authored compatibility description. Current official documentation describes both formats for IDE1/CLI3, local/global locations and local precedence. It does not establish which of two same-directory, same-name representations wins in every installed version. No such precedence is invented here. Workspace trust, selected profile and host version remain conditions. [README, D-AGENTS]

Conditional example: when the JSON profile is selected, changing only the sibling Markdown does not change the JSON's embedded prompt. INSTALL does not reconcile the pair, and the JSON contains no sibling-file URI. An explicit host configuration that selects the edited Markdown is a different case; it does not prove synchronization of the JSON. [KJSON, INSTALL, D-CONFIG]

The same distinction applies across scopes. A newer global profile does not by itself establish selection when a same-name local profile takes precedence under the documented host contract. Updating the primary ECC file, updating a Kiro source copy, copying it to a target and selecting it are four different changes.

## 3. Preservation protects customization but does not maintain freshness or recovery

INSTALL derives its source from its own `.kiro` directory. It creates target agents/skills/steering/hooks/scripts/settings directories and copies selected existing source entries. `nullglob` avoids treating an unmatched glob as a literal filename. Ordinary existing agent files are not overwritten. These are useful behaviors and support the stated customization-preservation purpose. They are not an update protocol.

**Existing-copy counterpart:** after a target optimizer has been installed, a later source JSON change is skipped on reinstall while that target file exists. A missing Markdown sibling may be copied independently, producing two representations from different source states. There is no version receipt, freshness comparison or pair-level acceptance predicate in this script. It does not distinguish user customization from an old unchanged vendor copy. This is a consequence of the actual keep-existing policy, not evidence that every installed profile is stale.

**Partial-copy counterpart:** agent-copy errors are suppressed and the installed counter increments after the attempt. The final completion message does not inspect copied content or ask the host to load it. Earlier directory creation can still fail under the shell's error mode; not every failure is hidden. For a skill, the destination directory is created before a nonrecursive copy whose error is also suppressed. If that leaves an incomplete directory, a later run skips the existing directory rather than repairing its missing members. These are conditional filesystem paths, not installations or data-loss incidents observed in this research.

The installer copies only the selected `.kiro` bundle. It does not copy the root `scripts/harness-audit.js` or the root commands directory. The short optimizer's `/harness-audit` request therefore depends on whatever command/procedure capability the selected environment actually supplies. A separately installed capability could satisfy it; the presence of the optimizer text alone cannot. This unit does not infer that no user environment could provide that command or rerun Note40's scorecard inquiry.

## 4. Tool availability, preapproval and semantic review are not one boundary

KJSON declares `tools: ["@builtin"]` and `allowedTools: ["fs_read"]`. The current official contract distinguishes potential tools from tools usable without asking permission. Under that contract, this is not a read-only tool set: the preapproval list does not itself remove all other built-ins. Effective deny/ask/allow policies and legacy-name compatibility still depend on the actual host. No unrestricted-write or approval-bypass verdict follows. [KJSON, D-CONFIG, D-MIGRATION]

This qualifies the PR's generated summary about minimum tool access and the README's general read-only descriptions. Those texts are not independent permission verification. A permission prompt for a tool call is also not the primary optimizer's specific rule requiring human review of a security-sensitive change and a blocked final disposition. The latter is absent from the short prompt; another active instruction or policy might still impose it. The source-level finding is missing equivalence, not proof that the overall running agent has no safety constraints.

KJSON has empty resources, hooks and MCP declarations. Current documentation describes inherited default resources, so an empty explicit resources array is not evidence of an empty effective context. This limits, rather than strengthens, any claim that the shorter prompt determines all behavior. The installed project's instructions, steering, selected resources, permissions and actual final input were not observed. [D-CONFIG]

The primary optimizer still has meaningful no-product-code, reversible-change, evaluation and human-review instructions; the Kiro variant still preserves the mission, small-change and cross-platform conditions. Different completeness does not mean zero useful guidance. Neither source text nor the presence of a profile proves a completed or beneficial optimization.

## 5. What the actual validation supports

PACKAGE's test command invokes `scripts/ci/validate-agents.js`. VALIDATOR scans top-level Markdown files under the root `agents` directory, checks required model/tools metadata, duplicate keys, tools representation and recognized model values, and returns nonzero for detected errors. This is a genuine executable validator in the repository test entry, not merely an unused function.

That validator does not read the Kiro JSON/Markdown pair or compare its workflow with the primary body. Updating primary evaluation or approval prose without changing those metadata checks therefore does not cause this validator to signal stale Kiro content. A valid metadata result could coexist with the historical divergence above. This does not establish that every other test or external pipeline lacks a parity check.

PR810's statement that configs were schema-validated is recorded as a contributor claim, not a test run we observed. The complete PR file list contains no added test or generator, but it is not the whole repository or an external CI history. No target validator or test suite was executed. No new test-source suite was fully inspected in this unit; reading a validation implementation is a different evidence class.

## 6. Bounded disposition and next question

Q01a2e1 answers the consequential representation/deployment relationship: historical body correspondence rejects unsupported conversion-loss attribution; the actual install path deploys preserved independent copies; selected inline content and documented permission semantics qualify primary-agent guarantees. Useful preservation, local discovery, approval and metadata controls retain their distinct scopes.

Q01a2e2 preserves the unrecovered historical production tool or external generator, same-directory duplicate-format resolution, exact legacy/current host and tool-name compatibility, complete default-context and permission composition, source-to-installed update lineage, filesystem/concurrency/recovery behavior and accepted task outcomes. These are not quietly represented as observed facts. A new necessary active producer/consumer discovered later must reopen the source account; its hypothetical existence does not require an unlimited search now.

The specifically named Pi/Cursor/non-MCP-Codex/Kiro joins from the earlier frontier now have bounded accounts. This does not close every O2 variant or G6. **Next selected U19-F / G6 / O3: broad-document, mirror and example omission challenge, NOT STARTED.** Start from the original U19-A disposition and Note33/system extension routes; identify which README/security/shortform/troubleshooting/history/example claims could change the explanation, and follow their actual mechanism evidence. The historical inventory remains unchanged. Revised CORE and joint evaluation are later work; no upstream fix or SOUL/Development OS architecture is adopted.
