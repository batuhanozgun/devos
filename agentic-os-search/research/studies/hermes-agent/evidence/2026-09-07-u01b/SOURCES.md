# U01B — Kaynak ve yürütme defteri

**Tarih:** 2026-09-07. **Birincil pin:** `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.

Bu dosyanın S-ID'leri yalnız U01B içindir. Eski SOURCE-LEDGER.md'nin H-ID'lerini yeniden numaralandırmaz. FULL = dosya tamamı gerçekten okundu; çalıştırıldı anlamına gelmez. Re-fetch edilen H07/H08 eski tur ve bu tur için iki ayrı yeni kaynak gibi sayılmaz.

| ID | Pinned kaynak | Blob SHA | Okuma / yürütme |
|---|---|---|---|
| S01 | [tools/skill_manager_tool.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/skill_manager_tool.py) | `81d64b909b6b482654060b38b63802460b63314b` | FULL: 1–210, 211–425, 426–640, 641–870, 871–EOF. Çalıştırılmadı. |
| S02 | [tools/skill_manager_batch.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/skill_manager_batch.py) | `9f38adff284eede4234948f67e99a43752c0926e` | FULL; tam dosya kopyasının Git blob'u doğrulandı; sentetik bağımlılıklarla dar bileşen deneyi. |
| S03 | [tests/tools/test_skill_manage_batch.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tests/tools/test_skill_manage_batch.py) | `7e1c105339c347c950e0cf764d0043f106c9d239` | FULL: 1–220, 221–EOF. TEST SOURCE INSPECTED; upstream suite çalıştırılmadı. |
| S04 / önceki H07 | [tools/write_approval.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/tools/write_approval.py) | `f1e99b46e934595c002c2bc659143fcbc1f9fe8d` | FULL tekrar okuma: 1–210, 211–EOF. Tam dosya kopyasının Git blob'u doğrulandı; preview/stage için dar bileşen deneyi. |
| S05 / önceki H08 | [hermes_cli/write_approval_commands.py](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/hermes_cli/write_approval_commands.py) | `150b72dfd17696ab7a64f97057b7405128f5b352` | FULL tekrar okuma; çalıştırılmadı. |
| S06 | [LICENSE](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/LICENSE) | `75410e73319c72cd3e991a501c5455eb78f38375` | FULL; kopya Git blob'u doğrulandı; kaynak kopyalarına eklendi. |

## Bileşen deneyi

`component-probe/component_probe.py` araştırma asistanınca yazıldı. `upstream/skill_manager_batch.py` ve `upstream/write_approval.py` tam dosya kopyalarıdır. Script her koşuda içeriklerini beklenen Git blob SHA ile eşleştirmeden yüklemez. Bağımlılık taklitleri scriptte açıkça tanımlıdır; tam ürün davranışı olarak sunulamaz.

Koşu: `python component_probe.py`. İki hedef modül ve stdlib dışında upstream paket kurulmadı. Fixture'lar geçici dizinde; gerçek profil/secret/sağlayıcı/ağ/terminal aracı kullanılmadı. Test scripti, stdout/stderr, RESULT.json ve lisans beraber saklandı. JSON'daki zaman, araştırma ortamının ölçülen UTC saatidir. Rapor Python 3.13.5/Linux koşusudur.

B01–B05 batch yolları; D01–D05 önizlem/pending yollarıdır. 10 beklenen tanılayıcı sonuç gözlendi. Bu sayı upstream suite PASS'i, ürün başarı oranı veya bağımsız araştırma doğrulaması değildir. Negatif sonuçların assertion'ı geçmesi, ürünün daha güçlü iddiayı karşıladığı anlamına gelmez.

## Dar freshness kontrolü

Kaynak main kapanışa yakın `7874ef9f62b9b533f8d3da6107eb2a52f4be252f` olarak GET ile alındı. S01/S02/S04 dosyalarının bu commit'teki metadata/blob kimlikleri yukarıdaki pin ile aynıydı. Bu ikinci okuma tam metni tekrar okumak değil, daha önce tam okunmuş içeriğin kimliğini kontrol etmekti. S03/S05 veya tüm uygulama için current-head closure yapılmış sayılmaz.

GitHub code search `apply_skill_pending` için daha yeni bir ref üzerinden navigation sonuçları verdi; bu parçalar teknik kanıt olarak kullanılmadı, ilgili dosyalar birincil pin'den açıldı.

## Değişebilir web keşfi

Resmî sitenin memory, skills, configuration ve documentation girişleri arandı:

- https://hermes-agent.nousresearch.com/docs/user-guide/features/memory
- https://hermes-agent.nousresearch.com/docs/user-guide/features/skills
- https://hermes-agent.nousresearch.com/docs/user-guide/configuration
- https://hermes-agent.nousresearch.com/docs/

Bu tur web yüzeyleri keşif ve güncellik bağlamıdır; tam canonical kod yerine geçmedi. Arama sonucunda çıkan ikincil yorumlar veya ilgisiz HERMES adlı çalışmalar araştırma kanıtına katılmadı. Bir memory-injection makalesi arama sonucunda görüldü, açılıp incelenmedi; bu çalışma onun sonuçlarını kullanmıyor.

## Research-side preflight

Başlangıç ve son main gözlemi: `e6bc6cd98e31922c4cfd1c3b46e88c04aec2ca00`.

Tam okunan package yüzeyleri: META, STATE, INDEX, METHOD, RESEARCH-PLAN, SOURCE-LEDGER, OPEN-QUESTIONS, notes/02-BACKGROUND-LEARNING. Gstack METHOD ve değişmiş soul-context STATE de tam okundu. Önceki turda yüklenmiş, karşılaştırmada değişmediği görülen entry/control yüzeyleri güncel bağlamda korundu; AGENT yeniden, R06 ilk kez tam okundu. Agent-control dosyaları araştırma kanıtı değildir.

Bulk GitHub tree erişimi container'da DNS hatası verdi. GitHub bağlantısı dosya okumalarını sağladı. Bu yüzden recursive tam envanter veya tam clone iddiası yoktur. GitHub araç listesinde mutation/commit eylemi sunulmadı; ilgili plugin araması yalnız mevcut GitHub bağlantısını döndürdü; container'da gh yoktu. Kullanıcı token'ı/credential aranmadı; yayın yapılmadı.
