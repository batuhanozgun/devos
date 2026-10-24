# EXP-005 — Köken, kaynak kapsamı ve ekler

## 1. Kaynak kesimi

22 Eylül 2026 tarihli bu SOUL Research konuşmasının modelin görebildiği kullanıcı/assistant mesajları: U001–U048 ve A001–A047, toplam **95 mesaj**. U001 görselle karşılaştırma sorusudur; U045 çalışma iptalidir; U047/A047 protokol yönelimli öz değerlendirmedir; U048 yalnız EXP-005 arşivleme yetkisidir. Arşivleme işlemleri yeni kaynak diyalog sayılmaz.

Bu bir platform export'u değildir. Konuşmacı, sıra, görünür mesaj gövdeleri, sorular, geri çekilen görüşler ve aktarılan Codex sonuçları korunur. Önceki projedeki başka konuşmalar bu kesime katılmaz. Erken araç geçmişinde “Skipped … messages” olarak sunulan kesimler ve kesilmiş toplu araç yanıtları tam kaynak olarak mevcut değildir; yeniden kurulmadı. Tam Codex Cloud/CLI çalışma transkriptleri elimizde değildir. Kullanıcının aktardığı raporlar, doğrudan native gözlem olarak etiketlenmez.

## 2. Aktarım işlemleri

- Metin gövdeleri on sıralı dosyaya aktarıldı; kaynak kimlikleri sonradan bu arşiv için verildi.
- Başlık düzeyleri, boşluklar ve kod çitlerinin arayüz kimlikleri normalize edildi. Routing blokları aynı LOAD/SKIP kararlarıyla tek satıra dönüştürüldü; görünür blok olmayan A001/A009/A014/A043 için yokluk işaretlendi, sonradan routing uydurulmadı.
- Terminal kutu/animasyon boşlukları ile yapıştırmadaki Markdown kaçışları temizlendi. Cihaz hostname'i `[host]` ile maskelendi; çalışma yolunun devir anlamı korundu.
- Kullanıcı tarafından kopyalanmış `svg` kalıntıları ve dosya kartlarının yinelenen başlıkları temizlendi. Test/sonuç metni ve dosya yolu/değişim sayıları korundu.
- Konuşma-içi `filecite` kimlikleri tarihsel referans işaretleri olarak düz metinle korundu; bunlar bu Git arşivinde çözülmüş/yeniden doğrulanmış bibliyografya değildir. Kullanılan dış bağlantılar da tarihsel atıflardır, güncel ürün doğrulaması değildir.
- Görev dosyasına ait geçici sandbox bağlantıları, arşivdeki değişmemiş esere yönlendirildi.
- Sistem/developer mesajları, gizli muhakeme, token içeren araç yanıtları ve ilgisiz proje geçmişi aktarılmadı.

Bu işlemler nedeniyle “byte-perfect konuşma export'u” iddiası yoktur. İçerik/sıra karşılaştırması aynı assistant'ın self-review'üdür; bağımsız transkripsiyon doğrulaması yapılmadı. Özet ve dersler kaynak gövdelerinin yerine geçirilmez.

## 3. Özgün görev eseri

[DEVOS02-NEED-DISCOVERY-20260922.md](../artifacts/DEVOS02-NEED-DISCOVERY-20260922.md), A006'da sunulmuş ve U007'de kullanıcı tarafından Cloud'a metin olarak gönderildiği bildirilmiş sürüm 1.0 belgesidir. Yerel konuşma eki gerçekten açıldı ve tam okundu. Boyut **20.369 byte**, SHA-256 **`1053219053176484e79633c16322cabb9c89a46a4cef0f3f8322a10615d964e6`**. Git blob karşılığı **`e66bd561bd48219a6de5141c21fa08b3b9f2fda4`**.

Eser değişmeden saklanır. Görev daha sonra U045'te iptal edilmiştir; dosyanın emir kipleri bugün etkin yetki değildir. Belge, planlama/kaynak erişimi/başlangıç davranışı/alternatif neden/bağımsız değerlendirme/iptal sınırlarının metinde zaten bulunduğunu göstermek için de önemlidir. “Hiç plan veya ölçüt yazılmadı” anlatısı bu eserle bağdaşmaz; yazılması ile uygulanması ayrılır.

## 4. U001 görselleri

İki özgün PNG konuşma eklerinde mevcut ve arşivleme sırasında doğrudan görüntülendi; OCR kullanılmadı. Bu Git paketinde **PNG byte'ları değil aşağıdaki metin aktarımı ve kimlik bilgisi** tutulur. Özgün PNG'ler ayrıca konuşma teslimindeki ek paketinde korunur; bu ek paket kalıcı Git kopyası veya otomatik erişim yolu sayılmaz.

| Ek | Runtime dosya adı | Boyut | Piksel | SHA-256 |
|---|---|---:|---|---|
| IMG01, strateji yazısı | a7022655-9437-45fc-95fb-6e2145e854b1.png | 306565 | 876 × 1058 | c781ecda84887046de1a47ec22a3eac944713e1e4077310348b15387e4be9cad |
| IMG02, ekosistem şeması | 3729796c-bde7-40d3-90e3-7c257e785f39.png | 1458394 | 876 × 1058 | b5eecb6d35df257ba03d6a35d9851b1c88b564451b7cb598ffc6859b567810ac |

### IMG01 — Görünür yazı

> AI Strategy Has Shifted From "Tool Selection" to Enterprise Architecture
>
> The Old Problem vs. Today's Reality: Picking a single model (ChatGPT vs. Copilot) is an outdated approach. Modern AI is a multi-layered ecosystem, not a standalone tool.
>
> The 7 Core Layers of the Modern AI Stack:
>
> Raw Intelligence: Foundation LLMs (OpenAI, Claude, Gemini, Llama).
> Action & Agents: Orchestration frameworks (LangGraph, CrewAI, AutoGen).
> Context & Retrieval: RAG and embeddings to ground models in proprietary company data.
> Tool Protocols: MCP (Model Context Protocol) to standardize tool and system integrations.
> Security & Observability: Guardrails, monitoring, and PII masking (LangSmith, Presidio).
> Memory: Vector databases ensuring continuity across interactions.
> Workflow Automation: Pipelines connecting outputs to core business systems (n8n, Airflow).
>
> The Real Enterprise Challenge: Success depends on determining which layers you actually need, sequencing their deployment, and maintaining governance across them.
>
> The Business Opportunity: This complexity shifts AI from a "software procurement" task to an architecture and change management initiative where transformation leaders add the most value.
>
> #AIWorkflows #AgenticAI #Automation #TechStrategy #ChangeManagement #B2BTech

Bu, görseldeki yazının aktarımıdır; “model”, “katman” ve “memory = vector database” eşitlemeleri bu arşivce benimsenmez.

### IMG02 — Şemanın okunabilir metin envanteri

Başlık: **THE MODERN AI ECOSYSTEM - TOOLS**. Katmanlar daireler ve ürün logoları/adlarıyla gösterilir. Yerleşim/renk/logo geometrisi bu metin envanterine aktarılmaz.

| Görsel başlığı | Görseldeki araç/ad örnekleri |
|---|---|
| LLM | OpenAI GPT; Anthropic Claude; Google Gemini; Meta Llama; Mistral AI; Cohere; Hugging Face; Ollama; vLLM |
| Agentic AI | LangGraph; CrewAI; Microsoft AutoGen; Microsoft Agent Framework; LlamaIndex Workflows; AWS Strands Agents; CAMEL; Agno |
| RAG | LangChain; LlamaIndex; Haystack; DSPy; RAGFlow; GraphRAG; Unstructured; EmbedChain |
| Embedding | OpenAI Embeddings; Cohere Embed; Voyage AI; Sentence Transformers; BGE; Google Vertex AI Embeddings; Azure OpenAI Embeddings |
| MCP | MCP SDK; FastMCP; MCP Registry; GitHub MCP Server; Slack MCP Server; PostgreSQL MCP Server; Google Drive MCP Server; Filesystem MCP Server |
| AI Security | NVIDIA NeMo Guardrails; Guardrails AI; Microsoft Presidio; Lakera Guard; Prompt Security; Protect AI; Azure AI Content Safety; AWS Bedrock Guardrails |
| Observability | LangSmith; Langfuse; Arize Phoenix; Weights & Biases Weave; TruLens; Ragas; Promptfoo; Helicone |
| Memory | Mem0; Zep; Letta; LangGraph Memory; Redis; PostgreSQL; Neo4j; Chroma |
| AI Agent | OpenAI Agents SDK; LangChain Agents; PydanticAI; Semantic Kernel; Google ADK; AWS Bedrock Agents; Azure AI Foundry Agent Service |
| Automation | n8n; Zapier; Make; Microsoft Power Automate; Temporal; Apache Airflow; Prefect; Kestra; Pipedream |
| Vector Database | Pinecone; Weaviate; Qdrant; Milvus; Chroma; pgvector; Elasticsearch; Redis; MongoDB Atlas Vector Search |

Ürünlerin bugün mevcut olduğu, tam bu işlevde sınıflandığı veya SOUL için gerektiği araştırılmadı. Şema konuşmayı başlatan bir sorgulama aracıdır, evrensel küme veya tam mimari değildir.

## 5. Dış çalışma kanıtına dönüş yolları

- Kullanıcının verdiği Cloud task bağlantısı: https://chatgpt.com/codex/cloud/tasks/task_e_6ab27a2da63c8325b7222c7b790bcf7d . Konuşmada assistant bu içeriğe erişemediğini bildirdi. Arşiv, tam task transkriptine sahip değildir.
- Kullanıcının verdiği paylaşım: https://chatgpt.com/s/cd_6ab285f56d9c81919299c3990174a6aa . İçeriği bu arşivde yeniden okunmuş sayılmaz.
- DevOS PR #1: https://github.com/batuhanozgun/soul-development-os_02/pull/1 . Konuşma içinde önce `c4ca2b8d13f41c9924dab70b063decf5b844bfe6`, sonra `be61b6e82d3107d7e25a7c5c5d3d1dad265ad161` head'i gözlendi. Bunlar tarihli gözlemler, bugünkü canlı PR statüsü değildir.
- Son görülen kanıt yolu: https://github.com/batuhanozgun/soul-development-os_02/tree/be61b6e82d3107d7e25a7c5c5d3d1dad265ad161/work/DEVOS02-NEED-DISCOVERY-20260922 . STATE/WORK/EVIDENCE ve native-v1/native-v2 ORACLE/RUNS/GRADE burada konuşma sırasında görünür oldu. Arşiv bu dosyaları tekrar üretilmiş deney kanıtı gibi çoğaltmaz.
- `9144e310…`, `cb45e220…`, `155a4ef…` kullanıcı tarafından aktarılan yerel commit kimlikleridir. Uzak hash'in aynı olacağı, hepsinin hangi Git geçmişine bağlı olduğu veya tam raw trace'lerin Git'te bulunduğu bu konuşmadan çıkarılmaz.

## 6. Önceki explorations ile bağ

EXP-001: çalışma modeli, aktör hazırlığı ve yaşayan plan; EXP-002: baz SOUL ve ortak entelektüel taban; EXP-003: bilgi/erişim/kullanım ve ek hafıza; EXP-004: büyük iş, genişleme ve MS01/G01–G07. EXP-005 bu zinciri **bu kabiliyetleri kurmaya çalışan gerçek çalışma akışının kendi hataları** üzerinden sorgular; önceki sonuçların yerine geçmez.

Bu arşivleme turunda kütüphane INDEX/CATALOG/PACKAGE-CONTRACT ve EXP-004 STATE'i okundu. Önceki dört paketin bütün kaynakları yeniden okunmadı; ilişki kaydı böyle bir tam okuma iddiası taşımaz. Ayrıntılı dönüş yolu retrieval/CUMULATIVE-READING.md'dedir.
