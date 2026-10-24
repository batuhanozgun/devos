# U01-M3 — Pending caller, scope ve görünürlük

2026-09-10; `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` pin'i. Source-backed actual caller trace ve tek exact slash-policy modülüyle sekiz tanılayıcı durum.

Önce [RESEARCH](RESEARCH.md) ve [SOURCES](SOURCES.md); sonra [SPEC](SPEC.md), [POLICY-RESULT](POLICY-RESULT.json), [policy_probe.py](policy_probe.py). `upstream/slash_access.py` tam kaynak, `upstream/LICENSE` aynı primary MIT lisansıdır.

Tekrar: `python policy_probe.py`. Script yerel POLICY-RESULT.json'u değiştirir; tarihsel kanıtı korumak için ayrı bir kopyada koşulmalıdır. Stdlib yeterlidir. Tam source hash doğrulanmadan modül import edilmez. Config/source nesneleri sentetiktir. Gerçek gateway, CLI, kullanıcı kimliği, profile/secret resolver, pending mutation, model/provider veya network çalıştırılmaz.

Büyük caller kaynakları yalnız ilgili sembol/aralıklarla okundu; burada tam kaynak diye saklanmıyor. Eski M2/N ve diğer worker/middleware deneyleri bu tur tekrar edilmedi. Current upstream HEAD veya kurulu release doğrulaması yok. Yayın/continuity durumu teslimin PUBLICATION-HANDOFF dosyasında ayrıca belirtilir; bu dosyanın yerelde bulunması GitHub yayını değildir.
