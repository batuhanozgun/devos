# AI Knowledge Strategies — Okuma ve kalıcı çıkarım durumu

2026-09-20, **B6-T11 / SOURCE-READ-COMPLETE / DURABLE-EXTRACTION-COMPLETE / PACKAGE-COMPLETE**.

Bu dosya `research/studies/ai-knowledge-strategies/` paketinin concepts programı açısından gerçek kaynak/okuma hesabını taşır. Kaynak araştırmanın kendi `STATE.md` durumu ile concepts çıkarım durumu ayrıdır. Kaynak araştırma kendi bounded teknik araştırmasını tamamlamıştır; bu dosya yalnız o araştırmadaki terim/kullanım ve ilişki düzeninin kalıcı aktarımını kaydeder.

## 1. Kaynak kimliği ve kapsam

- Repository: `batuhanozgun/agentic-os-search`
- B6-T11 başlangıç main: **cfa377639183804cc1fe119591bdd9692681a26a**
- Kaynak yolu: `research/studies/ai-knowledge-strategies/`
- Concepts girişi: [TERMS.md](TERMS.md)
- Paket türü: `focused-topic`
- Kaynak araştırma current status: original six-file technical scope complete; Context/Memory/Harness follow-up linked.
- Architecture / implementation authority: yok.
- Foundation-tree mutation: yok.

Concepts açısından paket **9 metin dosyasından** oluşur: özgün altı araştırma dosyası + `META.md` + `STATE.md` + `INDEX.md`. Rationale içindeki “files 1–5 not yet researched” satırı initiation-time historical metadata'dır; current package status değildir.

## 2. Dosya envanteri ve gerçek okuma

| Kaynak | Blob SHA | B6 okuma |
|---|---|---|
| `00-WHY-THIS-RESEARCH.md` | `19045d973ceeee97f7163fa38b8d14050e037a67` | FULL; 1–220, 221–500, 501–EOF |
| `01-RAG.md` | `557021706a28d3d93be4d7fbff6c0268a2d0d267` | FULL; 1–220, 221–440, 441–660, 661–900, 901–1120, 1121–EOF |
| `02-KNOWLEDGE-GRAPH.md` | `b9b9b160a26656d082e321d35870d78d2f1881cf` | FULL; 1–230, 231–460, 461–690, 691–930, 931–1160, 1161–1400, 1401–EOF |
| `03-FINE-TUNING.md` | `946b4356cec3014942f7c98320f53f07e81788ef` | FULL; 1–230, 231–460, 461–690, 691–920, 921–EOF |
| `04-CAG.md` | `d820e843d05772b3b4aef2d57da2c269b433ce4a` | FULL; 1–240, 241–480, 481–720, 721–960, 961–1200, 1201–1440, 1441–EOF |
| `05-LONG-CONTEXT.md` | `e55e69e3941904fc1f35029f21a9c31de1be4d2b` | FULL; 1–240, 241–480, 481–720, 721–960, 961–1200, 1201–1440, 1441–EOF |
| `INDEX.md` | `a8e54be319710c53db0dc95636d8336ae3aaa06d` | FULL |
| `META.md` | `40f19071d323e0de3fa23ccbe2b96407037dbbb0` | FULL |
| `STATE.md` | `f826d76d5433088fbf780e9cc8017ab212579a68` | FULL |

EOF görülen aralık gerçek içerik sonudur; istek üst sınırı gerçek satır sayısı değildir. Dış makaleler, provider belgeleri ve sibling study atıfları bu concepts turunda yeniden araştırılmadı. Bu paket onları nasıl kullandığını anlatan kaynak olarak ele alındı.

## 3. Kaynak statüsü ve yorum sınırı

Kaynak içinde birkaç farklı ifade katmanı bulunur:

- dış literatüre dayalı teknik tanım/claim;
- araştırmacının bounded synthesis'i;
- SOUL/Development OS için project-specific interpretation;
- başlangıç working hypothesis;
- current package-level summary/decision boundary;
- historical handoff/status text.

Bunlar aynı epistemik statüde değildir. Özellikle `Use when / Avoid / Needs evidence / Does not prove` bölümleri araştırmacının karar-sınırı sentezidir; ürün veya alan standardı değildir.

Current `STATE.md` şu beş kısa mekanizma rolünü package-level synthesis olarak verir:

- RAG → external evidence access;
- Knowledge Graph → relation-centric representation;
- Fine-Tuning → parametric behavior/capability adaptation;
- CAG → repeated stable context reuse;
- Long Context → whole-package working context.

Bu beşli eş düzey, mutually-exclusive architecture taxonomy'si olarak kaydedilmez.

## 4. Kaynak-bölüm → kalıcı kullanım kapsamı

[TERMS.md](TERMS.md) aşağıdaki source families'i kapsar:

- **Rationale / package framing:** classification-axis, mechanism-vs-problem, governance lens, working hypotheses, package boundaries.
- **RAG:** RAG family/pipeline, corpus eligibility, sparse/dense/hybrid retrieval, chunking, query formation, iterative/adaptive/corrective retrieval, reranking/context construction, four failure layers, freshness, provenance, citation/grounding, agentic downstream evaluation, security, governed adaptive retrieval.
- **Knowledge Graph:** KG minimum meaning, graph database/ontology/schema/RDF/property graph separation, entity identity/alignment, relation extraction, n-ary/contextual relation modeling, provenance, temporal validity, open-world/completeness, graph completion, graph quality, reasoning/path semantics, GraphRAG, evolution, access control, derived relation index.
- **Fine-Tuning:** full FT, SFT, instruction tuning, preference optimization, RLHF/RLxF, PEFT/LoRA/QLoRA, continued/domain-adaptive pretraining, behavior-vs-knowledge, data quality/diversity, forgetting/regression, knowledge update conflict, training provenance/attribution, safety/backdoor, adapter/base binding, task capability vs core governance.
- **CAG:** narrow Cache-Augmented Generation, acronym collision, Long Context substrate, KV state, prompt/prefix cache, cache-accelerated RAG, semantic response cache, effective context, stable-context dimensions, invalidation, cache identity/manifest, cache security, stable-prefix/dynamic-suffix, cache-vs-canonical recovery.
- **Long Context:** advertised/trained/benchmark-effective/workload-effective/economic/governed context, utilization, position effect, non-literal retrieval, long-distance reasoning, length-conditioned degradation, benchmark families, context construction, distractor/conflict/instruction contamination, citation/provenance, compute/prefill, RAG-vs-LC hybrid, bounded-package reasoning.

Kaynakların section/list/example/source-ledger taraflarından bu kayıt kümelerine geri dönülerek coverage kontrolü yapıldı. Bütün doğal dil kelimeleri terimleştirilmedi; teknik ayrım veya araştırmanın anlam düzeni taşıyan kullanımlar kaydedildi.

## 5. Maddi interpretation sınırları

1. **Mechanism family ≠ architecture choice.** Beş başlık farklı katman/problem eksenlerinde olabilir ve birlikte kullanılabilir.
2. **Governance ≠ altıncı mekanizma.** Authority, provenance, freshness, epistemic status, access ve verification beş mekanizmanın üzerinde/çaprazında kalan problem alanlarıdır.
3. **External evidence/context/representation/adaptation** ayrımları current package synthesis'idir; evrensel AI ontology değildir.
4. **Current sibling CMH framing** bu paketi yeniden konumlandırır fakat teknik bulgularını iptal etmez. Context/Memory/Harness üç yeni peer strategy gibi bu beşliye eklenmez.
5. **Project-specific SOUL/Dev OS çıkarımları** kaynak teknik bulgularından ayrı tutulur; architecture authority üretmez.
6. Provider/model/version/cost gibi zaman duyarlı dış olgular adoption aşamasında yeniden doğrulanmalıdır.

## 6. Kapanış

Bu pakette concepts açısından:

- 9/9 source file accounted;
- 9/9 full-read;
- contextual uses source-linked;
- source-study current/historical status ayrımı korunmuş;
- relation view mevcut;
- unread/unresolved source file yok;
- somut aktarım eksiği bulunmadı.

Kapanış **source-bounded contextual extraction** içindir. Sıfır atlama garantisi, bağımsız verification, current product certification veya ortak terminology kararı değildir. Sonradan somut omission/anlam bozulması bulunursa ilgili kayıt yeniden açılır.

## 7. Devralma

Normal seri devam bir sonraki SCOPE birimi olan `research/studies/multi-agent-patterns/` paketidir. Yeni oturum bu paket için önce current main + gerçek package tree + META/STATE/INDEX preflight yapmalıdır. AI Knowledge Strategies yeniden current work yapılmaz; gerektiğinde bu READING ve TERMS durable-complete kaynak olarak geri çağrılır.
