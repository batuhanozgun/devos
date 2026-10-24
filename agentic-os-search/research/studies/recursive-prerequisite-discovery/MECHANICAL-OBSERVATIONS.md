# RPD prototipi — yerel mekanik gözlemler

**Tarih:** 2026-09-08. **Tür:** sentetik yerel yeniden koşu; kullanıcının makinesi, Codex/Claude veya LLM/RPD davranış deneyi değildir. Asıl ZIP kullanıcı tarafından tamamen uydurma deneme olarak sunuldu; aşağıdaki yeni çalışma onun gerçek projeye kurulduğu anlamına gelmez.

## Kimlik ve yöntem

ZIP SHA-256: `0a1167a5e51123c22a006e7222441b99567e77ad3b8f02c57ede1fe5fd5cde56`.
24 dosya; manifestte listelenen 23 dosyanın hash'i eşleşti. İki uzun Markdown kopyasının ayrıca verilen metinlerle bayt eşitliği doğrulandı. Kod, test, demo, CORE, şablon/adaptör ve sınır açıklamaları çalıştırmadan önce okundu. Paket içindeki talimatlar agent-control olarak uygulanmadı.

- `reference/rpd_store.py` SHA-256: `c75a75147b14d022a82a89f6036bae1f62f5153d1d3e3163386050809c33b71b`.
- `tests/test_store.py` SHA-256: `65bf9a4c36072e65d8c0bd5a0c9b6a8a75acd359a85fbd166c9cd9a1a9bd5d33`.
- `protocol/CORE.md` SHA-256: `a70a65e4b70b76e8d8672b830df36e89ce3424df66439c0e55915fc3ccac3a06`.
- Runtime: Python 3.13.5; Linux 6.18.35 x86_64, glibc 2.41. Bu sonuç başka dosya sistemi veya platforma otomatik genellenmez.

Paket kökünde çalıştırılan komutlar:

```text
python -B -m unittest discover -s tests -v
python -B examples/demo.py
```

Test komutu exit 0; gözlenen özet `Ran 25 tests in 1.593s` ve `OK`. Demo exit 0. Yeni arşiv değişmedi; test/probe verileri görevce oluşturulan geçici alanlarda tutuldu ve bu alanlar temizlendi. Yeni provider/dependency veya kullanıcı repo'su kullanılmadı.

## Gerçek test adları — tamamı ok

```text
test_accepted_item_can_become_stale
test_accepted_requires_evidence_reference
test_context_does_not_silently_drop_dependency
test_cyclic_prerequisites_are_rejected
test_dependency_version_required
test_disjoint_inputs_can_merge
test_expired_lease_rejected_without_reassignment
test_fresh_store_reads_checkpoint
test_initialization_never_overwrites_project
test_invalidation_propagates_without_deleting_history
test_lease_renewal
test_live_lease_excludes_second_owner
test_missing_dependency_is_not_committed
test_new_dependent_records_can_be_created_together
test_old_worker_fenced_after_reassignment
test_prepublication_crash_leaves_old_head
test_protocol_mismatch_rejected
test_repeated_request_returns_receipt_once
test_request_id_reuse_different_payload_rejected
test_snapshot_corruption_detected
test_stale_update_rejected
test_two_processes_cannot_silently_overwrite
test_unreadable_head_stops_instead_of_reset
test_write_scope_rejected
test_wrong_project_cannot_produce_context_packet
```

Demo çıktı kapsamı:

```json
{
  "demo_only": true,
  "llm_called": false,
  "recovered_open_question": "İptal/iade örneği bulunuyor mu?",
  "recovered_next_operation": "Kalan örneği incele",
  "stale_result_rejected": true,
  "assurance_after_upstream_change": "STALE",
  "scope": "Fresh Python store instance, not a new LLM session."
}
```

## İki ek sınır probe'u

Bunlar prototipin belgelenmiş semantik/işbirlikçi API kapsamını somutlaştırır; üretim güvenlik açığı, dış sistem saldırısı veya RPD'nin işe yaramadığı iddiası değildir.

Birinci probe `A` önkoşulunu OPEN/UNASSESSED kaydeder. `B`, A'ya bağlıyken ve evidence yalnız `nonexistent-evidence` metniyken ACCEPTED/CHECKED olarak kabul arayüzüne verilir. Gerçek kanıt dosyası yaratılmaz. Gözlenen: A OPEN, B ACCEPTED/CHECKED. Dolayısıyla kayıt kabulü gerçek önkoşulun karşılandığını veya kanıtın doğru olduğunu hesaplamıyor.

İkinci probe A için worker-A lease'i oluşturur. Sonra claim parametresi verilmeden koordinatör kabul arayüzü worker-B adına çağrılır. Gözlenen: aktif lease owner worker-A kalırken kayıt updated_by worker-B olur. Fencing yalnız ilgili işbirlikçi çağrı yolunda kontrol edilir; bütün dosya/araç etkisi veya OS izin sınırı değildir.

Yeniden üretim çekirdeği (özgün hash-eşit `reference/rpd_store.py` import edilebilirken, yalnız geçici alanda):

```python
import tempfile
from rpd_store import Store

def rec(title, **kw):
    return dict(kind='inquiry', title=title, depends_on=[],
                status='OPEN', assurance='UNASSESSED') | kw

with tempfile.TemporaryDirectory(prefix='rpd-boundary-') as tmp:
    s = Store(tmp)
    s.initialize('SYNTHETIC-ONLY')
    s.apply('seed', 'coordinator', {}, {'A': rec('Unmet prerequisite')})
    s.apply('accept', 'producer', {'A': 1}, {
        'B': rec('Accepted claim', depends_on=['A'],
                 status='ACCEPTED', assurance='CHECKED',
                 evidence=['nonexistent-evidence'])
    })
    first = s.load()
    print(first['records']['A']['status'],
          first['records']['B']['status'],
          first['records']['B']['assurance'])
    s.claim('A', 'worker-A', 'lease', ttl=60)
    s.apply('without-claim', 'worker-B', {'A': 1}, {
        'A': rec('Update via coordinator interface')
    })
    second = s.load()
    print(second['leases']['A']['owner'],
          second['records']['A']['updated_by'])
```

Gözlenen karşılıklar: `OPEN ACCEPTED CHECKED`; `worker-A worker-B`. Bu kısa kod, gerçekten çalıştırılmış aynı çağrıların yeniden üretim için düzenlenmiş gösterimidir; bir agent test harness'i değildir.

## İddia sınırı

25 yeşil test, doğru önkoşulları keşfetme, ürün kararını doğru verme, kanıtın semantik doğruluğu, eksik keşfi yeni model bağlamında sürdürme, gerçek alt-ajan kesintisi veya kullanıcı teknik müdahalesini azaltma iddialarını sınamaz. Aynı kayıt programının farklı Python süreçleri arasında veri koruması ile farklı LLM oturumlarının RPD uygulaması ayrı deneylerdir. Arşivdeki eski test logları ile bu yeni koşu ayrı kaynaklardır. Test sayısını RPD başarı oranına çevirmeyin.
