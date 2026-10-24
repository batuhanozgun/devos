# 2026-09-08 — Resmî belge okuması ve erişim sınırı

## Kimlik ve kanıt statüsü

Research başlangıç main ref'i: `de51ef60f1afbc1aab265727146c1e8d236ff4ec`; root tree: `ed9aa5d34640bbaf46685511197d77068d7f3b0f`. HERMES primary kod pin'i: `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`; değiştirilmedi.

Bu turun W01–W08 kayıtları **resmî doküman metni gözlemi**dir. Pinned kod okuması, kod diff'i, kurulmuş sürüm, release/HEAD revalidation'ı veya runtime deneyi değildir. URL'ler değişebilir; erişim tarihi 2026-09-08'dir. Web aracının “crawled” etiketi yayın tarihi veya ortak commit kimliği olarak kullanılmadı. Sayfa metinleri bütünüyle arşivlenmedi; bölüm ve sınırlı okuma kapsamı aşağıda. Exact güncel iddia tekrar kaynak okuması ister.

## W-kaynakları

| ID | Resmî kaynak | Bu tur gerçekten görülen ilgili kapsam | Kanıt türü |
|---|---|---|---|
| W01 | [Tools Runtime](https://hermes-agent.nousresearch.com/docs/developer-guide/tools-runtime) | Registration/discovery; check_fn/toolset filtering; Dispatch; Error wrapping; Agent-loop tools; Async bridging. Web görünümünde yaklaşık 35–238. | DOC TEXT / SELECTED; Python kaynağı değil. |
| W02 | [Agent Loop Internals](https://hermes-agent.nousresearch.com/docs/developer-guide/agent-loop/) | Sayfanın dönen gövdesi 36–291: entrypoints, turn lifecycle, interruptible requests, sequential/concurrent tool execution, agent-level tools, callback/budget/persistence anlatımları. | DOC TEXT; açıklama düzeyinde, kod/test değil. |
| W03 | [Event Hooks](https://hermes-agent.nousresearch.com/docs/user-guide/features/hooks/) | Sistem ayrımı 42–54; plugin kuralları/katalog ve pre/post tool 532–661; approval observer 1353–1454; shell config/exit/failure 1663–1780; ordering 1956–1958. Örnek/önceki/sonraki bazı bağlamlar da görüldü. Sayfanın 2122 satırının tamamı okunmadı. | DOC TEXT / SELECTED. Search özeti ile açılmış sayfa farklı ayrıntılar sunduğunda açık sayfa ve kapsamı esas alındı. |
| W04 | [Persistent Memory](https://hermes-agent.nousresearch.com/docs/user-guide/features/memory/) | Frozen/live state, memory tool ve kullanım açıklamaları 46–244; approval/notification kısmı 278–315. Başka görünür bölümler ana iddiaya taşınmadı. | DOC TEXT / SELECTED. Tüm memory implementation'ı değil. |
| W05 | [Prompt Assembly](https://hermes-agent.nousresearch.com/docs/developer-guide/prompt-assembly) | Cached/ephemeral ayrımı ve tier özeti 36–69; API-call-time layers, Memory snapshots, context/skills ve customization 312–380. | DOC TEXT / SELECTED; rebuild callsite'ı görülmedi. |
| W06 | [Profiles](https://hermes-agent.nousresearch.com/docs/user-guide/profiles) | Profile/home tanımı ve ortak home uyarısı 39–47; profiles/workspaces/sandboxing 178–204; aradaki kullanım/clone metni de görüntülendi. | DOC TEXT / SELECTED; izolasyon testi değil. |
| W07 | [Session Storage](https://hermes-agent.nousresearch.com/docs/developer-guide/session-storage) | Overview 36–79; message fields/api_content 152–221; contention/retrieval 248–345; search/lineage 367–419. Schema'nın tam kodu okunmadı. | DOC TEXT / SELECTED; DB çalıştırılmadı. |
| W08 | [Context Compression and Caching](https://hermes-agent.nousresearch.com/docs/developer-guide/context-compression-and-caching) | Engine/dual-layer giriş 36–106; in-place/rotating bölüm 169–176; algorithm, failure warning ve summary/assembly 249–355. Diğer provider/model varyantları bu notta doğrulanmadı. | DOC TEXT / SELECTED; compressor veya özetleyici çalıştırılmadı. |

Satır numaraları bu tur web aracının metin görünümündeki konumdur; Git blob satırı veya kalıcı URL sürümlemesi değildir. Bölüm adları sonraki retrieval için daha kararlı yönlendirmedir. Arama sırasında Skills, Configuration, Which File Does What ve Plugin tutorial sonuçları da görüldü; bunlar ek FULL okumalar veya bu notun bağımsız dokuzuncu kaynağı olarak sayılmadı.

## Erişim olayları

1. Container içinden primary pin için kaynak arşivi isteği `Temporary failure in name resolution` ile başarısız oldu. Tam arşiv, local clone veya recursive tree envanteri elde edilmedi.
2. GitHub `fetch_file`, `NousResearch/hermes-agent`, `run_agent.py`, primary pin, 1–190: HTTP 429, `gitmon refuses to schedule us: too-many-processes`; içerik gelmedi.
3. Resmî site belgeleri ayrı, erişilebilir kaynak olarak okundu. Bunlar engellenen kodun yerine geçirilmedi.
4. Ara belge çalışmasından sonra aynı dosya/ref/aralığı bir kez daha aynı GitHub eylemiyle istendi; aynı 429 döndü. Bu tur upstream kod hattına devam edilmedi.
5. SOUL Research repository okuma ve yayın yolu upstream okuma sonucundan ayrı değerlendirildi. Primary caller boşluğu kapanmış sayılmadı.

## Yürütme ve doğrulama sınırı

Yeni HERMES testi, agent/provider çağrısı, kurulum, credential kullanımı, gerçek profil yazısı, upstream issue/patch veya Codex işi yapılmadı. K01–K09 araştırma kontrolleridir: **NOT RUN**. Önceki U01B kanıtı korunur; bu tur tekrar koşulduğu veya bağımsız doğrulandığı iddia edilmez.

Yayın dosyalarının varlığı, link tutarlılığı ve commit kapsamını kontrol etmek araştırma paketinin aktarım/continuity kontrolüdür; HERMES davranışı doğrulaması değildir. Erişim hataları sonraki oturum için kalıcı kabiliyet yasağı olarak okunmamalı; gerekli kaynak yeniden erişilebilir olduğunda current authorization altında araştırma sürebilir.
