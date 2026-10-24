# ECC — Scorecard, reputation gate and consult recommendation uses

2026-09-23 · **C6 post-U12 transfer / U18-A–C extraction.** Bu dosya harness scorecard/optimizer, AURA reputation gate ve consult recommendation→installer kullanımlarını kendi ECC araştırma bağlamlarında taşır. IX kimlikleri ortak “evaluation/gate/recommendation” tanımı veya SOUL/Development OS kararı değildir.

Source packages:
- U18-A Note40 + U18-A sources + MR41 + publication.
- U18-B Note41 + U18-B sources + MR42 + publication.
- U18-C Note42 + U18-C sources + MR43 + original publication + alignment closure.
Fixed target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`.
Tests inspected, not run; no target execution/E11/live service/installation/model trial.

## 0. Source locator and role map

| Usage range | Exact research sources | Source role / evidence class |
|---|---|---|
| ECC-IX01–IX23 | [Note40](../../../research/studies/ecc/notes/40-HARNESS-SCORECARD-AND-OPTIMIZATION-CONSUMERS.md) §§1–8 → [U18-A ledger](../../../research/studies/ecc/evidence/U18-A-SOURCES.md) → [MR41](../../../research/studies/ecc/ROUND-U18-A.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U18-A.md) | SOURCE OBSERVATION + TARGET INSTRUCTION + TEST SOURCE INSPECTED + conditional inference; no optimizer/model run. |
| ECC-IX24–IX43 | [Note41](../../../research/studies/ecc/notes/41-AURA-REPUTATION-GATE-AND-CALLER-BOUNDARIES.md) §§1–8 → [U18-B ledger](../../../research/studies/ecc/evidence/U18-B-SOURCES.md) → [MR42](../../../research/studies/ecc/ROUND-U18-B.md) → [receipt](../../../research/studies/ecc/PUBLICATION-U18-B.md) | AURA adapter/source observation, caller documentation, injected test definitions and stipulated counter-responses; no live service query. |
| ECC-IX44–IX66 | [Note42](../../../research/studies/ecc/notes/42-CONSULT-RECOMMENDATIONS-AND-INSTALLATION-BINDING.md) §§1–8 → [U18-C ledger](../../../research/studies/ecc/evidence/U18-C-SOURCES.md) → [MR43](../../../research/studies/ecc/ROUND-U18-C.md) → [original receipt](../../../research/studies/ecc/PUBLICATION-U18-C.md) → [alignment](../../../research/studies/ecc/PUBLICATION-U18-C-ALIGNMENT.md) | Source observation/test inspection and conditional installer composition; catalogue alignment is publication correspondence, not stronger evidence. |

A score, gate and recommendation are kept separate because their producer, consumer and authority objects differ.

## 1. Harness scorecard and interpreted optimization

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-IX01 — harness audit | Local files/config markers üzerinden weighted configuration rubric/report. | Outcome evaluator, latency benchmark, deployment or configuration mutation değil. |
| ECC-IX02 — audit target mode | Repository-vs-consumer rubric selection based on package/structural markers. | Installed runtime identity veya deployment mode guarantee değil. |
| ECC-IX03 — audit scope | repo/agents/skills/commands gibi selected report population. | Named scope bütün o surface’in inventory/behavior coverage’i değil. |
| ECC-IX04 — audit check | Presence/count/string/config predicate. | Named capability works/useful/outcome-positive proof değil. |
| ECC-IX05 — audit point | Predicate'e configured weight. | Confidence, risk reduction, benefit or effort estimate değil. |
| ECC-IX06 — audit score | Earned/max weighted sum over applicable checks. | Reliability/quality/cost/effectiveness measurement değil. |
| ECC-IX07 — variable denominator | Provider markers/mode/scope ile applicable max değişebilmesi. | Higher normalized score automatically improvement değil. |
| ECC-IX08 — top action | Failed checks içinden highest point-weight first-three suggestion. | Expected leverage/risk reduction/repair cost ranking değil. |
| ECC-IX09 — cross-surface override predicate | Consumer scoped report’in local agent/skill/command veya settings/hooks presence ile shared check kazanabilmesi. | Scope-labeled surface gerçekten populated/working demek değil. |
| ECC-IX10 — presence-full fixture | Empty hooks/eval/placeholder tests/name-only workflow ile predicate set’in score alabilmesi. | Nominal hook/eval/test/workflow execution proof değil. |
| ECC-IX11 — evaluation-location mismatch | Eval-harness authored storage under `.claude/evals` while audit checks root `evals/` or test count. | Useful eval absent veya invalid demek değil; producer/consumer location mismatch. |
| ECC-IX12 — audit process exit | Built report negative olsa da normal CLI return zero. | Checks passed veya optimizer accepts result demek değil. |
| ECC-IX13 — test-runner exit | Separate tests/run-all.js process/report failures’i nonzero’ya taşır. | Audit findings same failure signal’e dönüşür demek değil. |
| ECC-IX14 — optimizer consumer | Audit baseline + allowlisted reversible config edits + eval/test/review/trials authored procedure. | Executed autonomous optimizer veya accepted beneficial change değil. |
| ECC-IX15 — audit/optimizer exit mismatch | Optimizer audit leg’i exit code olarak yorumlarsa score decline normal zero kalabilir. | Full optimizer always accepts regression değil; independent criteria/human review countercontrols vardır. |
| ECC-IX16 — audit input identity | root/files/home/plugin-layout/provider markers/uncommitted state dahil actual input set. | Same Git commit = same report guarantee değil. |
| ECC-IX17 — plugin discovery point | Existing plugin.json/cache/installed_plugins marker selected by audit. | Active/loaded/correct plugin version proof değil. |
| ECC-IX18 — provider applicability | Provider marker category’sinin denominator’a girmesi/çıkması. | Provider operational or beneficial deployment demek değil. |
| ECC-IX19 — unsupported latency example | Optimizer example audit’in >200ms PreToolUse baseline verdiğini varsayar; audit engine böyle duration üretmez. | Latency impossible/irrelevant değil; separate measurement gerekir. |
| ECC-IX20 — primary optimizer safeguards | Before-image/reversible changes, capability/regression criteria, repeated trials, human approval text. | Host enforces or trials ran demek değil. |
| ECC-IX21 — command mirror identity | Primary/OpenCode harness-audit command files exact same blob. | Installed host behavior/discovery equivalence değil. |
| ECC-IX22 — same-name optimizer divergence | Kiro optimizer prompt primary optimizer’dan materially shorter/different. | Kiro host actually selects it veya permissions semantics verified değil. |
| ECC-IX23 — arithmetic correction | Consumer maximum initially 37 then source weights recomputed 39. | Target execution/result change değil; research-derived arithmetic correction. |

## 2. AURA reputation report/gate and caller boundary

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-IX24 — `aura_verdict` | Caller DID → external lookup → local verdict object report API. | Action authorization or global hook değil. |
| ECC-IX25 — `before_settle` / `require_trust` | Verdict class + caller allow/fail-open policy → return or AuraUntrusted. | Payment/delegation implementation, identity authentication or transaction execution değil. |
| ECC-IX26 — caller-owned integration | Package export edilir fakat caller explicit import/call/wrap action sağlar. | Every ECC runtime guarded veya production caller exists proof değil. |
| ECC-IX27 — DID prefix check | Nonempty `did:` prefix admission. | DID-method validity, registration or key control proof değil. |
| ECC-IX28 — selected gateway | Configured base_url/check request path. | Immutable/pinned authenticated origin guarantee değil. |
| ECC-IX29 — verdict class | trusted/caution/high_risk/new/unknown recognized local classification. | Local independent composite-score computation or service truth validation değil. |
| ECC-IX30 — reachable | Adapter transport/error-path standing. | Fresh/complete/current reputation proof değil. |
| ECC-IX31 — default fail-closed policy | trusted/caution return; high_risk/new/unknown raise. | Every malformed/transport result same policy branch değil. |
| ECC-IX32 — transport fail-open exception | `fail_open=True` can return unreachable unknown under default allow. | Reachable invalid/HTTP error automatically allowed değil. |
| ECC-IX33 — explicit allow override | Caller can include new/unknown classes in allow-list. | Default policy silently permissive değil; this is caller policy. |
| ECC-IX34 — HTTPError/URLError distinction | HTTP errors handled as reachable unknown before broader transport catch. | Live network behavior or all status semantics tested değil. |
| ECC-IX35 — requested/returned DID binding gap | Payload DID, if present, can replace requested DID without equality check. | Real gateway emits mismatch or attacker can exploit it proof değil. |
| ECC-IX36 — verdict coherence gap | Allowed class can coexist with missing/odd score/history/dimensions because gate uses class. | Real service incoherent or verdict false proof değil. |
| ECC-IX37 — live actor identity | THREAT_MODEL assigns proof that counterparty controls DID to caller. | Matching reputation response solves live authentication değil. |
| ECC-IX38 — current action risk | Reputation is backward-looking; caller separately evaluates action/amount/context. | Good reputation authorizes current effect değil. |
| ECC-IX39 — `ok` display property | Fixed trusted/caution display status. | Caller-specific allow/fail-open policy decision receipt değil. |
| ECC-IX40 — compact verdict projection | as_dict retains DID/class/reason/score/ok subset. | Reachability/history/dimensions/raw/policy/audit-complete receipt değil. |
| ECC-IX41 — configurable endpoint | Default HTTPS plus caller-set base_url. | Certificate pinning/host allow-list/redirect immutability enforced locally değil. |
| ECC-IX42 — no local cache | Adapter repeats lookup rather than indefinite local verdict reuse. | Gateway data fresh/chain-current/age-bound proof değil. |
| ECC-IX43 — injected-fetch tests | Offline fixtures validate local classes/error branches. | Actual HTTP/TLS/service identity/freshness/protected effect test değil. |

## 3. Consult catalogue recommendation and installer handoff

| ID / ifade | ECC araştırmasındaki kullanım | Sınır |
|---|---|---|
| ECC-IX44 — consult | Query+target → local install catalog lexical ranking → components/profiles/command strings. | Requirements discovery, project inspection, installation or accepted capability değil. |
| ECC-IX45 — query tokenization | ASCII-ish normalization/aliases/stop words/suffix expansion. | Semantic/multilingual understanding or negation handling değil. |
| ECC-IX46 — recommendation score | IDs/descriptions/modules/aliases/preferences weighted lexical match. | Confidence, installability, quality, cost or needs satisfaction değil. |
| ECC-IX47 — match reason | Exact/fuzzy token explanations. | Every ranking bonus/causal factor complete explanation değil. |
| ECC-IX48 — direct target filter | Component’s directly named modules’ target arrays intersection. | Dependency closure/adapter validation/actual installability değil. |
| ECC-IX49 — synthetic skill component | Skill directory presence → generated catalog component. | Complete SKILL semantics/host compatibility or installed skill proof değil. |
| ECC-IX50 — profile recommendation | Profile list ranked and target inserted into suggested command. | Profile’s dependency closure supports target guarantee değil. |
| ECC-IX51 — resolver closure | IDs/components/exclusions/dependencies/cycles/target support/adapter support → selected/skipped plan. | Consult score itself performs these checks değil. |
| ECC-IX52 — recommendation→skip counterpart | Directly target-compatible recommended module can be skipped by unsupported required dependency downstream. | Executed install failure/frequency değil; exact source deduction. |
| ECC-IX53 — component/module granularity | Multiple labels (e.g. framework variants) can map to same broad module. | Recommendations are disjoint capabilities/packages değil. |
| ECC-IX54 — exclusion by module identity | Excluding one component can remove shared module selected by another. | Semantic subtraction of only named component değil. |
| ECC-IX55 — late project config | ecc-install.json/CLI selections enter plan/install after consult. | Consult report already incorporates caller config değil. |
| ECC-IX56 — consult planCommand | Text for a later `ecc plan` invocation. | Frozen materialization plan or approval artifact değil. |
| ECC-IX57 — standalone plan | Resolver-generated scaffold-level module/adapter operations. | Byte-for-byte actual install preview değil. |
| ECC-IX58 — install dry-run | Runtime plan + ownership/migration/settings/consent warning preview. | Immutable approved artifact automatically bound to later install değil. |
| ECC-IX59 — install apply | Fresh runtime plan + hook-consent assertion + guarded effects/state. | Recommendation or earlier preview itself authorizes effects değil. |
| ECC-IX60 — preview destination identity | standalone plan projectRoot may default to ECC source root. | Actual apply destination in caller cwd same guarantee değil. |
| ECC-IX61 — apply destination identity | install CLI supplies caller current project root/home. | Preview report’s destination equals effect target automatically değil. |
| ECC-IX62 — hook consent boundary | Selected profile/modules can require separate explicit hook decision before apply. | Recommendation = consent veya refusal = recommendation failure değil. |
| ECC-IX63 — recommendation source identity | Report has schema/query/target/time but no catalog digest/ECC commit/frozen plan. | Later invocation same catalog/source package guarantee değil. |
| ECC-IX64 — unversioned `npx ecc-universal` handoff | Suggested command delegates package resolution to later environment. | Always latest/downloaded mismatch occurs demek değil; separate identity check required. |
| ECC-IX65 — source discovery / materialization / capability | Catalog candidate, resolved operations and useful loaded host behavior are distinct states. | One successful stage certifies the next değil. |
| ECC-IX66 — catalogue-alignment closure | U18-C source result existed before shared CATALOG row was later aligned via checked single-row publication. | Alignment research rerun/stronger evidence değil. |

## 4. U18-A/B/C non-collapse

- score ≠ capability outcome;
- point weight ≠ risk/benefit;
- full score ≠ working hooks/tests/evals;
- audit process success ≠ audit checks pass;
- audit report ≠ optimizer acceptance;
- same command blob ≠ same optimizer procedure;
- reputation report ≠ gate decision;
- gate return ≠ live identity authentication;
- reputation class ≠ current action authorization;
- requested DID ≠ returned DID ≠ authenticated actor;
- `ok` ≠ caller policy;
- consult match ≠ installability;
- direct target membership ≠ dependency closure;
- recommendation ≠ consent;
- suggested plan command ≠ resolved plan ≠ dry-run ≠ effect;
- preview target ≠ apply target;
- catalogue/source identity ≠ later package resolution;
- discovery row alignment ≠ scientific validation.

U18-A/B/C are bounded source answers. Their stronger installed/live/semantic/authority/outcome residuals remain source-study questions, not automatic Concepts tests.
