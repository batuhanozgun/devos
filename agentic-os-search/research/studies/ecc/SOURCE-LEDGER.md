# ECC — Source and Read Ledger

**Observation date:** 2026-09-17. Bu ledger okuma/kimlik kapsamını gösterir; araştırma sonucu veya bütün repo coverage iddiası değildir.

## Primary binding

Repository https://github.com/affaan-m/ECC ; main ref doğrudan GitHub API `git/ref/heads/main` üzerinden `8321021c54d670126ce3b2969d5deb880b4b0c2a` olarak doğrulandı. Bundan sonraki ana corpus bu commit'e bağlıdır. Ön turdaki search-commit sonucu tek başına HEAD kanıtı değildi; U00 direct-ref kontrolü bunu tamamladı.

| ID | Pinned source | Coverage | Identity / observed scope |
|---|---|---|---|
| S01 | git/ref/heads/main | FULL API RESPONSE | 2026-09-17 gözlemi; yukarıdaki commit. Mutable ref gelecekte farklı olabilir. |
| S02 | [docs/architecture/cross-harness.md](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/docs/architecture/cross-harness.md) | FULL READ | blob `768414b72432115fe885fecdd9ef72751a6b9742`; ortak layer/adapters/memory/session/Hermes sınırları yazarın belgelenmiş açıklamasıdır; implementation henüz takip edilmedi. |
| S03 | [package.json](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/package.json) | SELECTED READ — lines 1–45 | blob `87487a914c0fd739ea62107e7bf9e56b127207a5`; name/version/license alanları görüldü. Önceki tam çağrı truncated olduğundan full-read sayılmaz. Version 2.2.1 distributed package verification değildir. |

## Earlier screening — preserved but not promoted

Aşağıdaki dosyalar aynı conversation'ın ön taramasında main üzerinden okundu. O turda bütün okumalara exact commit bağlanmadı; yük taşıyan araştırma için pinned ref'te yeniden açılacaklar. Blob kimlikleri mevcut olduğunda korunur. Aynı görüşmede okunmuş olmak independent evidence değildir.

| Seed | Source path | Gerçek kapsam ve sınırlama |
|---|---|---|
| D01 | README.md; root directory listing | TRUNCATED / discovery; tam README veya recursive tree okuması değil |
| D02 | docs/architecture/harness-adapter-compliance.md | FULL READ; blob `09061190d5a30d0ea50aa2ae36a6818f26fb2a50`; support etiketleri target claim, actual host parity değil |
| D03 | docs/architecture/platform-value-loop.md | FULL READ; blob `0a61716ea99ba274e0d450cbcd2ec40d3bd949a7`; roadmap/release lane tarihsel olabilir, güncel bütün ürün statüsü değildir |
| D04 | docs/SKILL-PLACEMENT-POLICY.md | FULL READ; blob `7f11f74bc25629d109e3004273ae542dc923e7d3`; policy ile write path enforcement ayrı |
| D05 | docs/continuous-learning-v2-spec.md | FULL READ; blob `a27be00b2351b6e5097dfa8d33b31eb6a89362ee`; kısa yönlendirme, uygulamanın tam incelemesi değil |
| D06 | skills/continuous-learning-v2/SKILL.md | SELECTED/PARTIAL; blob `397b3d334dd1fdf5d7648dd619b6a744cd4734a5`; dosya yapısı başlığında kesilen görünüm, kalan bölüm okunmadı |
| D07 | docs/architecture/session-adapter-contract.md | SELECTED/PARTIAL; blob `49401ff93ea946a7c0f9497442a34cc5166d0580`; claude-history mapping başlığından sonrası önceki görünümde yok |
| D08 | docs/ECC-PRO-SECURITY-ROADMAP.md | TRUNCATED; 2026-06-21 draft tarihi görüldü; belirtilen issue'ların bugün açık olması veya bug'ın devamı doğrulanmadı |

Search snippets (skill tracker, install ownership, architecture/eval paths) yalnız discovery ipucudur; kod/test full-read veya sonuç değildir. Test SOURCE INSPECTED/EXECUTED statüsünde yeni ECC kaydı yok. Gerçek host/model/effectiveness verisi yok.

## Method precedent and project orientation

Aşağıdakiler SOUL Research main üzerinden U00'da FULL READ edildi. Bunlar ECC davranışına kanıt değil, yöntem/current project bağlamıdır.

| Source | Blob / role |
|---|---|
| [gstack METHOD](../gstack/METHOD.md) | `dc003b3f74115667a05787a847eadb10876784c8`; mechanism units, provenance graph, native-before-projection, closure challenge |
| [Hermes METHOD](../hermes-agent/METHOD.md) | `f4b3b25183e7402bf2921f9ca0818e7c5c5aee19`; entrypoint/consumer closure, variation, interruption/publication discipline |
| [Superpowers METHOD](../superpowers/METHOD.md) | `95f684306f92373dbb51f4ceedaff885394e950b`; instruction→implementation→host→effectiveness distinctions |
| [Foundation STATE](../../soul-foundations/STATE.md) | `6d1c3db664bb154546cb6c0bf5edc6da5275dcf8`; 2026-09-17 sufficient-stop/reuse direction, no target design activation |
| [Foundation discussion handoff](../../soul-foundations/08_foundation-sufficiency-reuse-review/DISCUSSION-HANDOFF.md) | `e95cf01635d328ae4d5db414ba5a9c4d70a42fb7`; production-perspective omission and later correction; analytical, not live experiment |
| [Foundation REUSE](../../soul-foundations/08_foundation-sufficiency-reuse-review/REUSE.md) | `b92c29d85055c70536392c0804a7a621efc9caff`; question-first retrieval; historical pending language is superseded by current STATE |

Research root INDEX, studies INDEX/CATALOG/PACKAGE-CONTRACT were recovered in this conversation; current studies INDEX/CATALOG were freshly re-read before publication planning, including Superpowers entries. Agent-control bootstrap/readings are not included as substantive research evidence.

## Ledger growth rule

For each later source: stable ID; exact repo/ref/path/blob when available; date; full/selected/truncated and exact range; related Q/unit/note; target-claim versus implementation versus execution class; dependency/revalidation condition. Directory coverage and reading coverage stay separate. Upstream diff adds a separately labelled revalidation record and affected-claim links.

## U01-A — 2026-09-17 current update

The sections above preserve U00's pass-time reading state. Current additions and completed reads are in [U01-A-SOURCES](evidence/U01-A-SOURCES.md); do not interpret the earlier 'no execution' statement as today's state.

S03 package.json was now fully read in three contiguous ranges with the same blob identity. S04–S25 add root/selected direct-child discovery and source/provider/wrapper/checker reads. Root non-recursive discovery is complete; the full recursive tree is not. [STRUCTURE](inventory/STRUCTURE.md) and [TREE-FRONTIER](inventory/TREE-FRONTIER.tsv) preserve that limit. The root README remains selected-read only, lines 180–360 in this unit.

S16 native-hook test was inspected in full, NOT RUN. E01 is a separate, newly executed offline three-case cache-checker probe using exact S13/S25 source bytes. C0/C1/C2 exited 0/0/1; the missing-hook case is a false-green under the broad all-reference claim, not three successful product validations. [Raw probe evidence and reproducer](evidence/u01-a-cache-probe/README.md).

No live host/model, installation, registry tarball, upstream full-suite or effectiveness execution was performed. The inspected source supports an event-specific Codex hook projection but not full parity or host admission/consumption. No repin occurred; later use must still check dependency freshness as appropriate.

## U01-B — 2026-09-17 current update

[U01-B-SOURCES](evidence/U01-B-SOURCES.md) adds S26–S44 and separately dated W01/W02 official host-contract checks. Both install manifests, actual native/managed/legacy routing and the common apply path were read; the executor facade is selected-only and imported helpers remain explicit dependencies. [Note 02](notes/02-INSTALLATION-CHANNELS-AND-MATERIALIZATION.md) binds each conclusion to these sources.

New direct `.agents` and `.agents/plugins` discovery is in [U01-B-DISCOVERY](inventory/U01-B-DISCOVERY.md). The large recursive-tree response was not recovered as a completely reviewed inventory. It does not close P1 or mark unexpanded subtrees read.

**No new ECC execution in this unit:** no installer, upstream test, local probe, actual cache/host or model/effectiveness run. U01-A E01 is historical preserved evidence, not new corroboration. W01/W02 describe the current provider contract rather than validate ECC's pinned host-version claim. Current pin and candidate/adoption boundaries are unchanged.

## U02-A — 2026-09-17 current update

[U02-A-SOURCES](evidence/U02-A-SOURCES.md) adds S45–S55: ownership, canonical state, projection and bridge producer; actual Kimi adapter and store facade; two full test-source reads and selected lifecycle 1–480. [Note 03](notes/03-OWNERSHIP-CHECKPOINTS-AND-PROJECTION.md) binds the ordinary/guided distinction, non-Claude bridge correction, partial-record semantics and scoped health result.

S55 is a full five-file state-store directory listing. Index/projection bodies were read; queries/migrations/schema were only discovered. It is not the full recursive inventory. S51's remaining doctor/repair/uninstall implementation remains unread.

**No new ECC execution.** S48/S50 are inspected assertions, not passing tests. Q03b's two-file interrupted-guided-retry path is source-derived and unexecuted. E01 remains previous local evidence, not repeated. No installer, host, model, database or new probe was run. The pin and authority boundaries are unchanged; no supplementary failed/irrelevant web result supports a claim.

## U03-A — 2026-09-17 current update

[U03-A-SOURCES](evidence/U03-A-SOURCES.md) adds S56–S69 and separate current GitHub CLI contract checks W03/W04. [Note 04](notes/04-WORK-SESSION-RECORDS-AND-CONTROL.md) maps local card writes, claim/move policy, limited GitHub import, snapshot normalization/fallback, SQLite session/query/schema/migrations and status signalling. S67 session-adapter test source was fully read, NOT RUN; launcher/collector/server and other ingestion consumers remain open.

**New local execution E02:** exact S59 helper blob verified and exercised against an in-memory store double, with six source-informed criteria fixed before execution. [Plan/runner/raw results](evidence/u03-a-work-item-probe/README.md) preserve blocked pickup, reassignment, done refusal, reopening and bounded selection. Criteria matches are not product-safety passes. No SQL, real board, provider, concurrent claim, authentication, live agent or task-quality test. Sync/ingestion counter-paths remain source-bound. E01 was not rerun.

All five state-store file bodies are now read across U02-A/U03-A. A complete direct tests listing adds bounded topology metadata; its children are not recursively read. P1 remains partial. Search results at another default-branch ref were used only for path discovery; every load-bearing body was retrieved at the unchanged research pin. No silent repin or current-version generalization.

## U03-B — 2026-09-17 current update

[U03-B-SOURCES](evidence/U03-B-SOURCES.md) adds S70–S76 and selected current primary Git/tmux/OpenAI contracts W05–W07. Full reads connect launcher, worktree/tmux provision/rollback, worker wrapper, artifact collector and status consumer; documented workflow and upstream orchestrator-test source were inspected. [Note 05](notes/05-EXECUTION-HANDOFF-AND-RECOVERY.md) binds source claims and executed observations separately.

**New local execution E03:** exact S74 Bash wrapper and S72 Node collector, Git-blob verified, with a deterministic fake provider in a temporary Git repository. Five pre-execution criteria matched; raw output and plan identity are in [E03](evidence/u03-b-worker-probe/README.md). No real Codex/model/tmux, rollback, isolation, concurrency or efficacy run. S76 assertions were read, not run; E01/E02 were not rerun. Source-derived retention/locator/liveness paths are not newly executed incidents.

This unit extends runtime-family understanding, not whole-tree inventory. Mutable searches returned another ref; bodies remain pinned. Memory-family paths were discovered only and require pinned reads in U04-A. Prior P1 and Q03b/c/Q04b/c/e limits remain; external manuals do not validate the actual named profile or deployed environment.
