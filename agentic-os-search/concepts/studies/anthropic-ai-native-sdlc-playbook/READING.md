# Anthropic AI-Native SDLC Playbook — Okuma ve kalıcı çıkarım durumu

2026-09-20, **B6-T13 / SOURCE-READ-COMPLETE / DURABLE-EXTRACTION-COMPLETE / PACKAGE-COMPLETE**.

Bu dosya `research/studies/anthropic-ai-native-sdlc-playbook/` paketinin concepts programı açısından gerçek kaynak/okuma hesabını taşır. Kaynak araştırmanın kendi bounded-complete durumu ile concepts çıkarımının tamamlanması ayrı statülerdir.

## 1. Kaynak kimliği ve kapsam

- Repository: `batuhanozgun/agentic-os-search`
- B6-T13 başlangıç main: **c5f69f165c50f9bc36dd9b665a8236deba3c6784**
- Kaynak yolu: `research/studies/anthropic-ai-native-sdlc-playbook/`
- Study type: `external-target`
- Kaynak araştırma status: **BOUNDED COMPLETE / CANDIDATE STUDY**
- Architecture / Foundation adoption: authorised değil
- Concepts girişi: [TERMS.md](TERMS.md)

Bu package current main'de sekiz metin dosyasından oluşur:

1. `META.md`
2. `STATE.md`
3. `INDEX.md`
4. `00-WHY-THIS-RESEARCH.md`
5. `01-PLAYBOOK-RESEARCH.md`
6. `02-SOURCE-LINK-LEDGER.md`
7. `03-SOUL-DEVELOPMENT-OS-ASSESSMENT.md`
8. `04-FALSIFIERS-LIMITATIONS-OPEN-QUESTIONS.md`

## 2. Dosya envanteri ve gerçek okuma

| Kaynak | Blob SHA | B6 okuma |
|---|---|---|
| `00-WHY-THIS-RESEARCH.md` | `2661792891b95e095114339e66e0f44a3f69959a` | FULL; 1–220, 221–EOF |
| `01-PLAYBOOK-RESEARCH.md` | `693428e8c1c79124148a7c59ae99ae253e876e2d` | FULL; 1–240, 241–480, 481–760, 761–EOF |
| `02-SOURCE-LINK-LEDGER.md` | `cc7428eaae2b81439ceb7cc323e0ac2cba615124` | FULL; 1–240, 241–EOF |
| `03-SOUL-DEVELOPMENT-OS-ASSESSMENT.md` | `2e4a60e2b2b0edf05f2249d420e8703632c10e3f` | FULL; 1–240, 241–480, 481–EOF |
| `04-FALSIFIERS-LIMITATIONS-OPEN-QUESTIONS.md` | `ac545344c5dcfb762929556542e9c0128a495b4f` | FULL; 1–240, 241–500, 501–EOF |
| `INDEX.md` | `2de090d0b406af201639476031e2064c1cfd78e0` | FULL |
| `META.md` | `7e89a64f594c989453195931388d57657ee9d0f7` | FULL |
| `STATE.md` | `522d1d874e3a194849885182b33666c7117e03d1` | FULL |

EOF görülen aralık gerçek içerik sonudur; istek üst sınırı gerçek satır sayısı değildir.

## 3. Dış kaynakların bu turdaki statüsü

Bu package çok sayıda canlı Anthropic/Claude dokümanına, first-party operational deep-dive'a, iki bounded vendor critique'e ve SOUL/Development OS/Foundation kaynaklarına atıf yapar.

Concepts B6-T13'te:

- bu dış kaynakların current içerikleri **yeniden araştırılmadı**;
- package'in onlar hakkında kurduğu kullanım, ayrım ve qualifier'lar çıkarıldı;
- 2026-09-04 tarihli product/settings/API/telemetry semantiği current product truth olarak promote edilmedi;
- Anthropic-reported productivity/security observations independent efficacy evidence sayılmadı;
- Atlas/Port problem counterexample'ları product remedy adoption'a çevrilmedi.

Exact later adoption/comparison için package'in kendi revalidation map'i geçerlidir.

## 4. Kaynak rolü ve statement nature

Sekiz dosyanın rolleri farklıdır:

- `META.md`: package classification, strongest reusable findings, reuse/revalidation boundary.
- `STATE.md`: current bounded-completion surface; reopen conditions; central result.
- `INDEX.md`: retrieval router; package map ve progressive retrieval discipline.
- `00-WHY-THIS-RESEARCH.md`: preservation rationale ve neden vendor source'un yine de değerli olduğu.
- `01-PLAYBOOK-RESEARCH.md`: primary playbook + linked official docs + operational/counterexample kaynaklarından mekanizma araştırması.
- `02-SOURCE-LINK-LEDGER.md`: 31 article-provided destination, source roles, direct notes ve freshness caveat ledger'ı.
- `03-SOUL-DEVELOPMENT-OS-ASSESSMENT.md`: SOUL/DevOS ile project-facing comparison; design pressures.
- `04-FALSIFIERS-LIMITATIONS-OPEN-QUESTIONS.md`: overclaim/challenge/open-question yüzeyi.

Source instruction/documentation, Anthropic first-party operational report, third-party vendor critique, researcher synthesis ve project-specific design pressure aynı epistemik statüde tutulmaz.

## 5. Kaynak-bölüm → kalıcı kullanım kapsamı

[TERMS.md](TERMS.md) aşağıdaki source families'i kapsar:

### Operating model / artifacts
- AI-native SDLC playbook;
- Plan / Design / Build / Test / Deploy / Maintain;
- play dependency graph;
- `intent.md`, `spec.md`, `plan.md`, code/tests, PR/review, deployment/incident;
- committed artifact chain;
- source of truth, working copy/mirror, transition state;
- ex-ante plan, revised plan, as-built state;
- derivation/provenance and target/version binding.

### Context / knowledge / configuration
- `CLAUDE.md`, memory, rules, Skills;
- always-loaded vs conditionally-loaded context;
- institutional/project knowledge;
- advisory guidance vs enforced configuration;
- agent configuration as versioned/evaluated target.

### Enforcement / authority
- Hooks, permissions, sandbox, settings, managed settings, MCP/tool admission, identity/credential, network restrictions, branch protection, human gates;
- alternate-path closure;
- effective/transitive authority;
- environment-tiered autonomy;
- control-state separation.

### Actors / execution / orchestration
- session, parallel sessions, worktrees, subagents;
- product owner, engineer, policy owner, verifier, reviewer, code owner, release manager, service owner;
- hidden human orchestration;
- action/actor/environment/risk/gate relation.

### Verification / evals
- producer self-feedback;
- fresh verifier;
- failing-test-before-fix;
- protected oracle;
- exact target / stale verdict;
- PR review vs verification vs human approval;
- configuration regression eval;
- challenge-set aging/freshness;
- shadow mode and sampled audit.

### Observability / evolution
- Git/PR history;
- tool/action/permission/Hook/MCP/Skill/subagent telemetry;
- OpenTelemetry/SIEM/compliance activity;
- incident → diagnosis → intent → fix → incident-to-eval;
- production signal as governed work generator.

### Falsifiers
- six-stage domain frame vs general Work semantics;
- artifact existence vs semantic fidelity;
- repo/deployed-reality gap;
- rollback vs compensation;
- observability vs assurance;
- metric/proxy risk;
- vendor first-party claims vs independent evidence;
- platform/system-formation assumptions.

## 6. Maddi interpretation sınırları

1. **Six-stage SDLC ≠ universal Work ontology.** Software-domain prior art olarak kalır.
2. **Committed artifact chain ≠ semantic correctness.** Versioned representation, faithful/authorised transformation'ı kanıtlamaz.
3. **Context/guidance ≠ hard enforcement.** `CLAUDE.md`/memory/Skills ile Hooks/permissions/sandbox/identity/gates farklı control strengths taşır.
4. **Hook ≠ complete hard boundary.** Alternate effect paths control surface'i bypass edebilir.
5. **Self-feedback ≠ independent verification.** Fresh verifier context de tek başına independence değildir.
6. **Protected red→green test ≠ universal proof.** Oracle validity/coverage/environment sınırı korunur.
7. **Human approval ≠ technical verification.** Governance act, technical evidence standing'den ayrıdır.
8. **Direct permission ≠ effective authority.** Reachable agents/tools/channels transitive action path yaratabilir.
9. **Repo state ≠ operating reality.** Live target state/preconditions bazı actions için ayrıca doğrulanmalıdır.
10. **Telemetry/observability ≠ assurance.** Evidence infrastructure semantic correctness değildir.
11. **Configuration exists ≠ configuration validated.** Agent-steering config ayrı regression/eval target olabilir.
12. **Autonomy ≠ scalar agent property.** Actor/action/environment/risk/evidence/gate ilişkisi olarak kullanılır.
13. **Incident→eval ≠ automatic improvement.** Eval coverage/freshness/oracle validity ayrıca gerekir.
14. **Vendor results ≠ independent efficacy proof.** Attribution korunur.

## 7. Source-side coverage ve kapanış

Concepts açısından:

- 8/8 source file accounted;
- 8/8 full-read;
- source roles/statements separated;
- external/current-product freshness boundary recorded;
- all major playbook/control/verification/authority/observability/falsifier uses source-linked in TERMS;
- unread source file yok;
- somut aktarım eksiği bulunmadı.

Kapanış **source-bounded contextual extraction** içindir. Independent verification, Anthropic product certification, architecture adoption veya Foundation mutation değildir.

## 8. Devralma

Normal seri devam SCOPE sırasındaki `research/studies/gstack/` paketidir. Yeni tur current main + gerçek package tree + META/STATE/INDEX preflight ile başlamalıdır.

Anthropic AI-Native SDLC Playbook yeniden current work yapılmaz; gerektiğinde bu READING ve TERMS durable-complete source olarak geri çağrılır.
