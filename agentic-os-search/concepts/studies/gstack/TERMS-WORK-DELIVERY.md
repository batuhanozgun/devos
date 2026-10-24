# gstack — Work, admission, qualification and delivery terms

2026-09-20, **B6-T14**. TERMS.md'nin bağlı parçasıdır. Bu dosya gstack araştırmasındaki planning/specification/work-admission, review/QA/ship ve deploy/canary/retro kullanımlarını taşır. Terimler gstack bağlamındadır; genel Work sözlüğü değildir.

## 1. Candidate work, discovery and admission

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-W01 — candidate intent / candidate pursuit | Henüz admitted/executing Work olmayan fikir, request veya problem yönü. | planning synthesis; four-ground Work projection. |
| GST-W02 — /office-hours | Implementation yapmadan problem framing, premise challenge, alternatives ve user-selected direction üreten discovery workflow. | planning synthesis. |
| GST-W03 — Startup posture | Demand/current workaround/specific affected human/narrow wedge/usage evidence gibi sorularla discovery'yi sıkılaştıran office-hours mode. | planning synthesis. |
| GST-W04 — Builder posture | Delight/shareability/exploration/fast-real-thing yönelimli generative discovery mode. | planning synthesis. |
| GST-W05 — premise challenge | Initial framing veya planı doğru kabul etmeden underlying premise'i sorgulama. | planning synthesis. |
| GST-W06 — alternative generation | Bir direction commit edilmeden önce en az iki alternative ortaya koyma. | planning synthesis. |
| GST-W07 — solution selection | Model recommendation'ından ayrı, user authority taşıyan direction-selection transition. | planning synthesis. |
| GST-W08 — design decision record | Approved direction, settled decisions/rejection reasons ve lineage taşıyan durable handoff artifact. | planning synthesis. Transcript değil. |
| GST-W09 — DRAFT / APPROVED | Design artifact'in user approval öncesi/sonrası yerel standing'i. | planning synthesis. |
| GST-W10 — Supersedes lineage | Yeni design record'un önceki design revision'ı aşması/yerine geçmesi ilişkisi. | planning synthesis. |
| GST-W11 — /plan-ceo-review | Product scope/ambition/failure/trajectory açısından planı pressure-test eden role/workflow. | planning synthesis. |
| GST-W12 — scope posture | expansion / selective expansion / hold / reduction gibi explicit product-scope stance. | planning synthesis. |
| GST-W13 — /plan-eng-review | Exact review target'ı önce çözüp architecture/tests/performance/execution adequacy açısından planı harden eden workflow. | planning synthesis. |
| GST-W14 — review-target authority | Hangi plan/target'ın incelendiğinin user/host-resolved olması; target çözülmeden repository inspection'a başlamama kuralı. | planning synthesis. |
| GST-W15 — /autoplan | Intermediate decision classes'i declared principles'e delegate eden, phases'i yürütüp final user gate'e dönen parent workflow. | planning synthesis. Human governance silinmez. |
| GST-W16 — Mechanical decision | Autoplan'da modelin auto-decide edebildiği bounded class. | planning synthesis. |
| GST-W17 — Taste decision | Auto-decide edilip audit trail'e kaydedilen ve final gate'te surfaced edilen judgment class. | planning synthesis. |
| GST-W18 — User Challenge | Modeller user-stated direction'ı değiştirmek istiyorsa default user direction'ı koruyan, final approval gerektiren class. | planning synthesis. |
| GST-W19 — /spec | Agreed intent'i code-grounded questioning + completion/scope/failure criteria üzerinden backlog/execution-ready work'e dönüştüren admission workflow. | planning synthesis. |
| GST-W20 — work admission | Ambiguity'nin implementer'a devredilmesi yerine sufficient intent/scope/evidence/criteria sonrası Work'ün execution'a alınması. | planning synthesis; four-ground projection. |
| GST-W21 — observable completion criterion | Spec'in “done”ı gözlenebilir/testable biçimde ifade etme gereksinimi. | planning synthesis. |
| GST-W22 — code-first interrogation | Teknik questions user'a sorulmadan source/codebase'den cevaplanabilecek olanların araştırılması. | planning synthesis. |
| GST-W23 — gate-and-file | Confirmed spec sonrası privacy/redaction/quality/archive/issue/spawn gibi mechanical tail. | planning synthesis. |
| GST-W24 — sink gate | Artifact external issue/archive/PR/memory gibi sink'e çıkmadan exact bytes üzerinde uygulanabilen control/scan. | planning synthesis / cross-system. |
| GST-W25 — worktree spawn / execution handoff | Filed work'ü exact SHA + unique branch/worktree metadata ile execution agent'a devretme. | planning synthesis. |
| GST-W26 — plan/intended Work vs actual Work state | Plan artifact'taki amaçlanan execution ile fiilen gerçekleşmiş Work'ün ayrımı. | planning + ship; four-ground Work. |

## 2. Review, QA and delivery qualification

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-W27 — /review | Source/diff reasoning ile structural/data/concurrency/security/quality defects arayan review workflow. | review/ship synthesis. |
| GST-W28 — /qa-only | User-observable browser/runtime evidence üretip reportlayan, source mutation yapmaması beklenen workflow. | review/ship synthesis. |
| GST-W29 — /qa | Observe → classify → minimal fix → commit → re-observe/reverify loop'u. | review/ship synthesis. |
| GST-W30 — /ship | Tests, coverage, plan completion, current review, browser verification, adversarial challenge ve release artifacts'ı birleştiren delivery-qualification orchestrator. | review/ship synthesis. PR command değil. |
| GST-W31 — delivery qualification | Implementation'ın release/progression için yeterli current evidence/standing'e sahip olup olmadığını hesaplama. | review/ship + CORE. |
| GST-W32 — qualification type vs workflow provenance | “Current Eng Review var” ile “önceden standalone plan-eng-review çalıştı”nın aynı şey olmaması. | review/ship synthesis. |
| GST-W33 — current Eng Review | Ship öncesi required-by-default engineering review standing; historical ceremony yerine ship içinde fresh recompute edilebilir. | review/ship synthesis. |
| GST-W34 — review freshness | Review'ün represented object ile hâlâ aynı/uygulanabilir olması. | review/ship. Content fingerprint/plan hash ile object-relative. |
| GST-W35 — working-tree fingerprint | Diff-scoped review/evidence'i current content'e bağlamak için kullanılan content identity. | review/ship / deploy. |
| GST-W36 — plan-completion audit | Discovered plan items'i implementation evidence ile reconcile eden classification pass. | review/ship synthesis. |
| GST-W37 — DONE | Plan item'in deliverable'ının gerçekten mevcut/karşılanmış olarak sınıflandırılması. | review/ship. |
| GST-W38 — PARTIAL | Plan item'in yalnız bir bölümünün gerçekleşmesi. | review/ship. |
| GST-W39 — NOT DONE | Gerekli deliverable/work'ün gerçekleşmemiş olması. | review/ship. |
| GST-W40 — CHANGED | Planlanan obligation'ın execution sırasında material olarak farklılaşması. | review/ship. |
| GST-W41 — UNVERIFIABLE | Available evidence/oracle ile item'in standing'inin doğrulanamaması. | review/ship. Failure ile aynı değil. |
| GST-W42 — DIFF-VERIFIABLE | Plan item'in current diff/source üzerinden doğrulanabilmesi. | review/ship. |
| GST-W43 — CROSS-REPO | Verification'ın bu repository dışındaki state/source'a bağlı olması. | review/ship. |
| GST-W44 — EXTERNAL-STATE | Verification'ın runtime/service/other external reality'ye bağlı olması. | review/ship. |
| GST-W45 — CONTENT-SHAPE | Deliverable'ın file/content/form requirement'ına göre doğrulanması. | review/ship. |
| GST-W46 — conditional gate | Plan bulunursa active delivery-control input olabilen; plan yoksa o gate'in skip edildiği semantics. | review/ship. |
| GST-W47 — override | User'ın residual risk/missing item/coverage durumuna rağmen progression'a authority vermesi. | review/ship. Evidence standing'i iyileştirmez. |
| GST-W48 — test ownership | Failing test'in candidate branch tarafından mı, pre-existing state tarafından mı, yoksa ambiguous biçimde mi üretildiğinin standing'i. | review/ship. |
| GST-W49 — changed-path coverage | Agent'ın changed files/control/data/user paths ile tests arasındaki coverage'ı semantic olarak değerlendirmesi. | review/ship. Instrumented line coverage değil. |
| GST-W50 — Fix-First | Mechanical/low-judgment findings'in auto-fix ile kapatılması; judgment-bearing findings user decision'a gitmesi. | review/ship. |
| GST-W51 — review closure loop | review → fix → tests → review → zero-fix pass; bounded non-convergence blocker. | review/ship. |
| GST-W52 — adversarial review | Claude fresh-context + optional Codex dış-model challenge gibi heterogeneous challenge layer. | review/ship / multi-agent. Independent verification garantisi değil. |
| GST-W53 — delivery evidence aggregation | Tests/reviews/plan/QA/challenge gibi heterogeneous evidence'ın PR/release standing'e dönüştürülmesi. | review/ship / cross-system. |
| GST-W54 — PR body as evidence aggregation artifact | Current run'ın test/review/plan/eval/docs evidence'ını public release summary'de taşıyan artifact. | review/ship. |

## 3. Merge, deploy and production standing

| ID / ifade | Bu araştırmadaki kullanım | Kaynak / sınır |
|---|---|---|
| GST-W55 — /land-and-deploy | Qualified PR'dan merge/deploy/live verification/revert/report yoluna geçen post-ship release workflow. | deploy synthesis. |
| GST-W56 — pre-merge readiness | Current review/tests/version/config gibi evidence + authority conditions'in merge öncesi standing'i. | deploy synthesis. |
| GST-W57 — one-way merge authority | Merge decision'ının learned “never ask” preference ile otomatik bastırılamaması. | deploy + guarded action. |
| GST-W58 — merge request / command | gh pr merge gibi effect attempt. | deploy. Remote merge truth değil. |
| GST-W59 — authoritative merge state | GitHub PR state / mergeCommit gibi remote readback ile merge'in gerçekten gerçekleştiğinin standing'i. | deploy. |
| GST-W60 — merge queue | Merge requested/accepted ama henüz completed olmayan intermediate standing. | deploy. |
| GST-W61 — deploy strategy | Platform/workflow/CLI/URL path'ine göre deployment standing üretme yöntemi. | deploy. Evidence strength provider-specific. |
| GST-W62 — deployment completion | Deployment workflow/provider'ın tamamlanmış görünmesi. | deploy. Live health ile aynı değil. |
| GST-W63 — release identity binding | Observed deploy/live state'in exact merge SHA/release/deployment identity'ye ne kadar güçlü bağlandığı. | deploy. |
| GST-W64 — live verification | Deployment sonrası actual service/browser surface'i üzerinden immediate health/behavior readback. | deploy. |
| GST-W65 — /canary | Bounded longitudinal production observation/relative-change monitoring workflow. | deploy synthesis. |
| GST-W66 — pre-deploy baseline | New release öncesi genuine before-state evidence. | deploy. |
| GST-W67 — canary health check | True pre-deploy baseline yoksa post-deploy t0 reference ile yalnız ongoing health/degradation izleme. | deploy. Regression attribution değil. |
| GST-W68 — control band | Stable metric/threshold'dan response tier veya anomaly standing çıkarma. | deploy/retro. |
| GST-W69 — rollback / revert action | Merge SHA'yı revert edip push/PR ile reverse mutation başlatma. | deploy. |
| GST-W70 — REVERTED | Revert mutation'ın accepted/pushed olduğuna dair workflow standing. | deploy negative finding. Production restored demek değil. |
| GST-W71 — production restored | Rollback deployment'ın tamamlandığı ve prior healthy target condition'ın readback ile yeniden established olması. | deploy. Current workflow mandatory closure sağlamıyor. |
| GST-W72 — deploy report | Merge/CI/deploy/staging/verification dimensions'ını ayrı taşıyan historical evidence artifact. | deploy. Current production truth değil. |
| GST-W73 — /health | Code-quality dashboard (typecheck/lint/tests/dead-code/etc.) ve weighted quality score. | deploy synthesis. Production service health ile aynı değil. |
| GST-W74 — /retro | Time-bounded engineering history/trends/wins/debt/habits/learnings üreten retrospective workflow. | deploy synthesis. |
| GST-W75 — retrospective feedback | Past work/evidence'tan trend/recommendation/learning üretme. | deploy/cross-system. |
| GST-W76 — recommendation ≠ work admission | Retro/learning/security suggestion'ın yeni Work/obligation'a otomatik dönüşmemesi. | deploy + cross-system. |
| GST-W77 — continuing / recurring Work | Canary, periodic eval, update check, sync, retro gibi one-shot delivery dışındaki devam eden Work family. | four-ground Work projection. |
| GST-W78 — repair / recovery Work | Investigation, QA fix/revert, ship remediation, rollback, migration/update recovery gibi failure-generated Work. | four-ground Work projection. |

## 4. Work-state relation view

gstack source içinde güçlü bir relation chain:

**candidate intent → user-selected direction → durable approved representation → reviewed plan/spec → admitted Work → implementation → current qualification evidence → authorized progression → merge/deploy effects → realized-state readback → production observation → feedback/candidate future Work.**

Bu lineer zorunlu lifecycle değildir. Router direct specialist paths açabilir; prior ceremony current standing ile recompute edilebilir; feedback ayrıca admission ister.

Özellikle korunması gereken non-collapse'lar:

- Work performed ≠ target condition achieved.
- Target condition achieved ≠ evidence supports it.
- Evidence supports it ≠ authorized acceptance/progression.
- Override authorizes progression ≠ missing item complete oldu.
- Review Work tamamlandı ≠ reviewed object passed.
- Revert Work tamamlandı ≠ production restored.
