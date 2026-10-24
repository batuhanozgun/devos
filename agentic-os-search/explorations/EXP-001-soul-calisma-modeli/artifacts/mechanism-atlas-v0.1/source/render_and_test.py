"""Document/UI checks; not a SOUL-agent efficacy evaluation."""
from pathlib import Path
from playwright.sync_api import sync_playwright
import json,xml.etree.ElementTree as ET,hashlib,collections,os,shutil
ROOT=Path(__file__).resolve().parent;W=ROOT;PKG=ROOT;QA=W/'verification_output';QA.mkdir(exist_ok=True)
m=json.loads((PKG/'model.json').read_text());doc=(ROOT/'SOUL_Mekanizma_Atlasi_v0_1.html').read_text()
results=[]
def ok(name,detail=''):results.append({'check':name,'result':'PASS','detail':detail})
ids=[o['id'] for name in ('nodes','edges','gaps','records','sources','principles','demo') for o in m[name]]
assert len(ids)==len(set(ids));N={n['id']:n for n in m['nodes']};E={e['id']:e for e in m['edges']}
assert all(e['source'] in N and e['target'] in N for e in m['edges']);ok('Benzersiz kimlikler ve ilişki uçları',f'{len(ids)} kimlik; {len(E)} ilişki')
for v in m['views']:
 assert all(n in N for n in v['nodes'])
 assert all(e in E and E[e]['source'] in v['nodes'] and E[e]['target'] in v['nodes'] for e in v['edges'])
 ET.parse(PKG/'gorseller'/f'{v["id"]}.svg')
ok('Yedi görünümün model bütünlüğü ve SVG XML geçerliliği')
original=ROOT/'dayanak'/m['meta']['source_document'];assert hashlib.sha256(original.read_bytes()).hexdigest()==m['meta']['source_sha256'];ok('Konsolidasyon kaynak SHA-256 bağı')
rows=[['H1','H2','H3'],['H1','H2','H4'],['H1','H3','H4'],['H2','H4','H5']]
c=collections.Counter(x for r in rows for x in r);assert c=={'H1':3,'H2':3,'H3':2,'H4':3,'H5':1};assert c['H1']/12==.25 and c['H1']/4==.75
c2=collections.Counter(x for r in rows+[rows[0]] for x in r);assert c2['H3']/5==.6;ok('Sentetik sayım ve tekrar gönderim aritmetiği','H1 25% / 75%; H3 50% → 60%. Örnek doğruluğu, ürün veya ajan doğruluğu değildir.')
with sync_playwright() as p:
 browser_path=os.environ.get('CHROMIUM_EXECUTABLE') or shutil.which('chromium') or shutil.which('google-chrome'); launch={'headless':True}; launch.update({'executable_path':browser_path} if browser_path else {}); b=p.chromium.launch(**launch);ctx=b.new_context(viewport={'width':1440,'height':1000},accept_downloads=True);pg=ctx.new_page();errors=[];requests=[]
 pg.on('pageerror',lambda e:errors.append(str(e)));pg.on('request',lambda r:requests.append(r.url));pg.set_content(doc,wait_until='load');pg.wait_for_timeout(100)
 def jump(h):pg.evaluate('(h)=>location.hash=h',h);pg.wait_for_timeout(60)
 for v in m['views']:
  jump('view='+v['id']);assert pg.locator('#svg-stage svg').count()==1
  assert pg.locator('#svg-stage [data-node]').count()==len(v['nodes'])
  assert pg.locator('#svg-stage [data-edge]').count()==len(v['edges'])
  pg.locator('#list-btn').click();pg.wait_for_timeout(30);assert pg.locator('#content-section .object-row').count()==len(v['nodes'])+len(v['edges'])
  pg.locator('#map-btn').click();pg.wait_for_timeout(30)
 ok('7 harita ve eşdeğer liste görünümleri')
 jump('view=overview');pg.locator('#svg-stage [data-node="G03"]').click();pg.wait_for_timeout(70);assert 'İş ve aktörün hazırlığı' in pg.locator('#inspector-content').inner_text()
 pg.locator('#inspector-content button[data-go="readiness"]').first.click();pg.wait_for_timeout(50);assert pg.locator('#view-title').inner_text()=='İş ve aktör hazırlığı';ok('Üst görünümden iç görünüme geçiş')
 pg.locator('#svg-stage [data-node="M07"]').focus();pg.keyboard.press('Enter');pg.wait_for_timeout(70);assert N['M07']['title']==pg.locator('#inspector-content h2').inner_text();ok('Düğüm seçimi ve Enter ile klavye erişimi')
 jump('view=readiness');eid=next(e for e in m['views'][2]['edges']);pg.locator(f'#svg-stage [data-edge="{eid}"] text').first.click();pg.wait_for_timeout(50);assert E[eid]['label']==pg.locator('#inspector-content h2').inner_text();ok('Ok seçimi ve koşul/taşıdığı bilgi/sınır ayrıntısı')
 pg.locator('#close-inspector').click();pg.wait_for_timeout(50);assert not pg.locator('#inspector').is_visible()
 initial=pg.locator('#zoom-value').inner_text();pg.locator('#plus-btn').click();assert initial!=pg.locator('#zoom-value').inner_text();pg.locator('#fit-btn').click();ok('Yakınlaştırma, sığdırma, seçim kapama')
 pg.locator('#search').fill('M16');pg.locator('[data-search-item="M16"]').click();pg.wait_for_timeout(60);assert N['M16']['title']==pg.locator('#inspector-content h2').inner_text();ok('Arama → nesne → güncel seçim')
 pg.locator('#search').fill('ZZZ bulunmayan');assert 'Eşleşme yok' in pg.locator('#search-results').inner_text();pg.locator('#search').fill('');ok('Boş arama sonucu ve arama temizleme')
 jump('view=demo&step=0');assert pg.locator('#demo-prev').is_disabled()
 for i in range(10):
  assert pg.locator('.demo-scene h2').inner_text()==m['demo'][i]['title']
  if i<9:pg.locator('#demo-next').click();pg.wait_for_timeout(70)
 assert pg.locator('#demo-next').is_disabled();assert 'aday' in pg.locator('.demo-scene').inner_text().lower();pg.locator('#demo-reset').click();pg.wait_for_timeout(40);assert 'step=0' in pg.url;ok('10 demo adımı, uç sınırlar, başa dönüş ve aday D09 ayrımı')
 jump('view=records');assert pg.locator('.data-table tbody tr').count()==21;pg.locator('[data-filter="first"]').click();assert pg.locator('.data-table tbody tr').count()==6;pg.locator('[data-filter="later"]').click();assert pg.locator('.data-table tbody tr').count()==15;ok('Dosya envanteri 6 / 15 / 21 filtreleri')
 jump('view=catalog');pg.locator('[data-filter="edges"]').click();assert pg.locator('.edge-row').count()==71;ok('Bütün 71 ilişkinin harita dışında da bulunabilirliği')
 jump('view=questions');assert pg.locator('.reading-item').count()==12
 jump('view=principles');assert pg.locator('.reading-item').count()==12
 jump('view=axes');assert pg.locator('.data-table tbody tr').count()==len(m['state_axes'])
 jump('view=sources');assert pg.locator('.reading-item').count()==len(m['sources']);ok('Açık mekanizmalar, ilkeler, durum eksenleri ve kaynak görünümleri')
 jump('view=overview')
 with pg.expect_download() as dl:pg.locator('#svg-btn').click()
 download=dl.value;download.save_as(str(QA/'export.svg'));ET.parse(QA/'export.svg')
 with pg.expect_download() as dl:pg.locator('#json-btn').click()
 dl.value.save_as(str(QA/'export.json'));assert json.loads((QA/'export.json').read_text())==m;ok('SVG ve JSON dışa aktarma, içerik eşliği')
 pg.locator('#help-btn').click();assert pg.locator('#help-dialog').is_visible();pg.keyboard.press('Escape');assert not pg.locator('#help-dialog').is_visible();ok('Kılavuz diyaloğu ve Escape')
 jump('view=intake&item=M03');pg.evaluate('location.hash="view=actor&item=M08"');pg.wait_for_timeout(70);pg.evaluate('history.back()');pg.wait_for_timeout(100);assert pg.locator('#inspector-content h2').inner_text()==N['M03']['title'];ok('URL hash durumuyla görünüm/seçim ve tarayıcı geri')
 # Inspect all printable internal link targets, not only DOM identifiers in main UI.
 links=pg.evaluate('''()=>[...document.querySelectorAll('#printDoc a[href^="#p-"]')].map(a=>a.getAttribute('href').slice(1)).filter(id=>!document.getElementById(id))''');assert not links,links;ok('PDF okuma görünümü iç bağlantı hedefleri')
 pg.emulate_media(media='print');pg.wait_for_timeout(50)
 overflow=pg.evaluate('''()=>[...document.querySelectorAll('.sheet')].map((s,i)=>{const f=s.querySelector('.pagefoot').getBoundingClientRect();let mx=0;for(const x of s.querySelectorAll('*')){if(x.closest('.pagefoot')||x.closest('svg'))continue;mx=Math.max(mx,x.getBoundingClientRect().bottom);}return {page:i+1,over:mx-f.top};}).filter(x=>x.over>0)''');assert not overflow,overflow;ok('PDF sayfaları: içerik ile altbilgi çakışması yok')
 pg.pdf(path=str(ROOT/'SOUL_Mekanizma_Atlasi_v0_1.pdf'),prefer_css_page_size=True,print_background=True,tagged=True,outline=True);pg.emulate_media(media='screen')
 # Test exact delivered HTML without network access; managed browser blocks file and localhost navigation.
 ctx.set_offline(True);offline=ctx.new_page();offline.on('pageerror',lambda e:errors.append(str(e)));offline.set_content(doc,wait_until='load');offline.locator('#svg-stage [data-node="G02"]').click();offline.wait_for_timeout(60);assert offline.locator('#inspector').is_visible();ok('Ağ kapalıyken gömülü belgenin başlangıcı ve etkileşim','Yönetilen Chromium file:// ve localhost navigasyonunu engellediği için tam HTML set_content ile yüklendi; tarayıcı politikası değiştirilmedi.')
 mobile=b.new_page(viewport={'width':390,'height':844},is_mobile=True,has_touch=True);mobile.set_content(doc);mobile.locator('#menu-btn').click();assert mobile.locator('#sidebar').evaluate('(e)=>e.classList.contains("open")')
 mobile.locator('#navigation a[href="#view=intake"]').click();mobile.wait_for_timeout(70);mobile.locator('#list-btn').click();mobile.wait_for_timeout(60);mobile.locator('#content-section [data-item="M03"]').first.click();mobile.wait_for_timeout(60);assert mobile.locator('#inspector').is_visible();mobile.screenshot(path=str(QA/'mobile-inspector-final.png'),full_page=True)
 mobile.locator('#close-inspector').click();mobile.wait_for_timeout(30);w=mobile.evaluate('({w:innerWidth,s:document.documentElement.scrollWidth})');assert w['s']<=w['w']+1,w
 mobile.screenshot(path=str(QA/'mobile-list-final.png'),full_page=True);ok('390×844 mobil menü, liste, ayrıntı ve sayfa taşması')
 for name,frag in [('overview-final','view=overview'),('readiness-final','view=readiness&item=M07'),('demo-final','view=demo&step=4'),('change-final','view=change')]:
  jump(frag);pg.screenshot(path=str(QA/(name+'.png')),full_page=True)
 assert not errors,errors;assert not requests,requests;ok('JavaScript çalışma hatası ve ağ isteği yok',f'{len(errors)} hata, {len(requests)} ağ isteği')
 b.close()
import fitz
pdf=fitz.open(ROOT/'SOUL_Mekanizma_Atlasi_v0_1.pdf');assert len(pdf)==51
assert all(len(p.get_text().strip())>100 for p in pdf);assert sum(len(p.get_links()) for p in pdf)>400
text='\n'.join(p.get_text() for p in pdf)
for nid in N:assert nid in text,nid
for eid in E:assert eid in text,eid
ok('PDF: 51 sayfa, metin, model kimlikleri ve bağlantılar',f'{sum(len(p.get_links()) for p in pdf)} bağlantı')
report={'version':'0.1','date':'2026-09-10','scope':'Belge/model/arayüz doğrulaması; SOUL çalışma etkinliği deneyi değil.','method':'Playwright + sistem Chromium; tam HTML ağsız set_content; PyMuPDF; Graphviz.','checks':results,'limits':['Tarayıcı file:// navigasyonu ortam politikası nedeniyle doğrudan denenemedi; HTML baytları aynı motorun sayfasına doğrudan yüklendi.','Gerçek ajan, dış araç yürütmesi, bağımsız ikinci model veya ürün uygulaması test edilmedi.','Görsel sayfa incelemesi ve Türkçe metin kontrolü aynı üretici tarafından yapıldı.']}
(QA/'verification.json').write_text(json.dumps(report,ensure_ascii=False,indent=2));print('PASS',len(results),'checks')
