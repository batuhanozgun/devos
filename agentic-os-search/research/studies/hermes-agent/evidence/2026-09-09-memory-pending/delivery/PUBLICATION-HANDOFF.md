# U01-M2 — yayın ve devam devri

**Durum: NOT PUBLISHED.** Yeni teknik çalışma yapılmıştır; GitHub yayını bu tur tamamlanmadı. Son doğrudan main kontrolü `9a95b2cf1f8a0460ac6128e1409bf54aa3191022`. O commit önceki worker-policy yayınıdır, bu yeni bellek deneyini içermez.

## Korunacak teslim

ZIP içinde hedef repository yolları hazırdır:

- `research/studies/hermes-agent/evidence/2026-09-09-memory-pending/`: beş exact modül/lisans, prospective SPEC, deney kodu, kaynak kimlikleri, ham RESULT, stdout/stderr, kaynak/yorum/erişim defterleri ve manifest.
- `research/studies/hermes-agent/notes/10-MEMORY-STATE-AND-PENDING-LIFECYCLE.md`: yerleşim adayı; gerçek main'de numara çakışırsa yeni adı seç, özgün dosyayı kaybetme.

Deney yeni publication turunda yeniden yapılmış sayılmamalıdır. Kayıtlı UTC `2026-09-09T08:10:46.824877+00:00`; twelve matched diagnostic cases, not product conformance. D2 AST ve whole-worker integration yapılmadı. Yeni bir yayın çalışması geçmiş raw logs/SPEC/RESULT'ı değiştirmemelidir.

## Canonical uzlaştırma

Önce agent bootstrap ve güncel main; ardından current META/STATE/INDEX/METHOD/plan ve 09/E defteri. Mevcut 01–09 notları ve eski evidence klasörleri korunur. Yayın sırasında main ilerlemişse yalnız bu study ve katalog satırındaki ilgili değişiklikleri güncel tabana birleştir, force kullanma.

V0.7 hâlâ current ise v0.8 için aşağıdaki semantic delta hazırlanır; daha yeni bir plan varsa üzerine eski plan yazılmaz:

1. STATE: U01-M2'nin yeni full-module kanıtını ekle, D2-FIDELITY NOT RUN ve full-worker soru statüsünü koru. Bu turdaki açık sıra değişikliğini kaydet; ilk iş tamamlandı diye yazma.
2. RESEARCH-PLAN: memory M01/Q27 artık bounded write-failure/reload kanıtı; M02/Q28 synthetic scanner alias + load-time karşı-kontrol kanıtı. K04/K05 kısmen ilerledi; gerçek UI/kimlik/profile ve API-wire hâlâ açık. N10 supplied-store flag kontrolü, gerçek config refresh değil.
3. Sonraki kaynak işi: pinned gerçek CLI/gateway pending caller'ının supplied live/fresh store ve home/profile bağını doğrula. Search yalnız `gateway/slash_commands.py` / `hermes_cli/cli_commands_mixin.py` navigasyonu verdi; ilgili pinned callsite'lar okunmadı. Ardından compression/reload/prompt/wire görünümü. Aynı 12 fixture'ı artırarak bu boşluğu kapandı sayma.
4. D2 tam orijinalleri/AST ve full review→worker integration güçlü yetki/açık/adoption iddiası öncesinde mandatory revisit olarak açık tutulur. Mevcut araştırma yetkisinin full installation/provider/credential kullanımına dönüşmediği korunur.
5. META/INDEX/SOURCE-LEDGER/OPEN-QUESTIONS ve yalnız HERMES CATALOG satırını eşleştir. U01B/U01B2/transport/D2/M2 koşularını toplam ürün PASS sayısına çevirme.
6. Yeni publication kaydında manifest/byte/SHA-256 kontrolünü, commit kimliğini, gerçek main/readback'i ve eski NOT PUBLISHED ifadelerinin tarihsel olduğunu belirt. Hash integrity yeni davranış doğrulaması değildir.

## Bu turdaki yazma sınırı

Kapsamlı yeniden keşiften sonra gerçek `GitHub.create_blob` çağrısı `Resource not found` verdi. Yeniden keşif ve alternatif `GitHub.create_tree` çağrısı da aynı tür hata verdi. Hiçbir blob/tree/commit SHA dönmedi; main değiştirilmedi. Plugin kurulu/enabled görünüyordu, ayar değiştirilmedi. Teknik kök neden bilinmiyor; Codex'in başka repo kullandığı korunur ve hata ona bağlanmaz. Tam gözlem `ACCESS-LOG.json` içindedir.

Bu dosya bir kalıcı kabiliyet-yokluğu kuralı değildir. Yeni tur mevcut yazma araçlarını yeniden değerlendirebilir. Kullanıcıdan provider, credential veya yeni Codex işi istemek mevcut araştırma/yayın yetkisinin yerine geçmez.
