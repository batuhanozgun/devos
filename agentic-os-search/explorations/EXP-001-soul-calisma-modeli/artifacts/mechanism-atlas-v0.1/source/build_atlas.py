from pathlib import Path
import json,html,re,subprocess,textwrap,base64,hashlib,shutil
ROOT=Path(__file__).resolve().parent; WORK=ROOT; PKG=ROOT; GFX=PKG/'gorseller'; GFX.mkdir(exist_ok=True)
M=json.loads((PKG/'model.json').read_text()); N={n['id']:n for n in M['nodes']}; E={e['id']:e for e in M['edges']}
esc=html.escape
TYPES={'control':('İşleyiş / koşul','#354b6b','solid'),'data':('Bilgi / çıktı','#287c74','solid'),'feedback':('Yeniden değerlendirme','#516ca2','dashed'),'exception':('Engel / toparlanma','#a34b37','dashed'),'context':('Dayanak / bağlam','#80608b','dotted')}
ranks={
'overview':[['G01','G08'],['G02','G07'],['G03','G06'],['G04','G05']],
'intake':[['M01','M02'],['M03','M04'],['M05','M06','M07']],
'readiness':[['M05'],['M07','M08','M09'],['M10'],['M06','M11']],
'actor':[['I05','I06','I07'],['M08'],['I02','I03','I08','I09']],
'execution':[['M11'],['M12','M13'],['M18','M14'],['M15','M21','M22']],
'change':[['M15','M18'],['M16','M20'],['M17','M02'],['M19']],
'information':[['I01','M03','I02'],['M05','I03','M11'],['I10','M14','I04']]}

def make_graph(v):
 direction='LR' if v['id'] in ['overview','change'] else 'TB'
 rr=ranks[v['id']]; ridx={n:i for i,row in enumerate(rr) for n in row}
 dot=['digraph atlas {', f'graph [rankdir={direction}, bgcolor="transparent", pad="0.2", nodesep="0.40", ranksep="0.60", splines=polyline, overlap=false, outputorder=edgesfirst, fontname="DejaVu Sans"];', 'node [shape=box, style="rounded,filled", color="#bac8d6", fillcolor="#ffffff", penwidth=1.4, fontname="DejaVu Sans", margin="0.20,0.13"];','edge [fontname="DejaVu Sans", fontsize=10.5, arrowsize=0.65, penwidth=1.2];']
 for nodeid in v['nodes']:
  n=N[nodeid]; k=n['kind']; fill='#edf5f3' if k=='information' else '#ffffff'; border='#8db6ae' if k=='information' else '#aebccd'
  if k=='group':fill='#f5f8fc';border='#9dacc0'
  label=f'<TABLE BORDER="0" CELLBORDER="0" CELLPADDING="1"><TR><TD ALIGN="LEFT"><FONT POINT-SIZE="10" COLOR="#64748b">{nodeid} · '+('BİLGİ' if k=='information' else 'ÜST GÖRÜNÜM' if k=='group' else 'İŞLEM')+'</FONT></TD></TR>'
  for line in textwrap.wrap(n['short'],width=24,break_long_words=False):label+=f'<TR><TD ALIGN="LEFT"><FONT POINT-SIZE="14" COLOR="#16324f"><B>{esc(line)}</B></FONT></TD></TR>'
  if n.get('gaps'):label+='<TR><TD ALIGN="LEFT"><FONT POINT-SIZE="9" COLOR="#985323">Açık: '+', '.join(n['gaps'])+'</FONT></TD></TR>'
  elif k=='group':label+='<TR><TD ALIGN="LEFT"><FONT POINT-SIZE="9" COLOR="#65748a">İç görünümü aç</FONT></TD></TR>'
  label+='</TABLE>'
  dot.append(f'{nodeid} [id="{nodeid}", label=<{label}>, fillcolor="{fill}", color="{border}"];')
 for row in rr:dot.append('{rank=same; '+';'.join(row)+';}')
 # invisible ordering preserves source order but does not represent a semantic relation
 for row in rr:
  for a,b in zip(row,row[1:]):
   if not any((e['source']==a and e['target']==b) or (e['source']==b and e['target']==a) for e in M['edges'] if e['id'] in v['edges']): dot.append(f'{a} -> {b} [style=invis, weight=50, constraint=false];')
 for i in range(len(rr)-1):
  a,b=rr[i][0],rr[i+1][0]
  if not any(e['source']==a and e['target']==b for e in M['edges'] if e['id'] in v['edges']):dot.append(f'{a} -> {b} [style=invis, weight=80];')
 for eid in v['edges']:
  e=E[eid]; typ,col,style=TYPES[e['type']]; lbl=e['label']
  label='\\n'.join(textwrap.wrap(lbl,22,break_long_words=False))
  constraint='true' if ridx[e['target']]>ridx[e['source']] else 'false'
  dot.append(f'{e["source"]} -> {e["target"]} [id="{eid}", label="{label}", color="{col}", fontcolor="{col}", style="{style}", constraint={constraint}, tooltip="{eid}: {esc(e["condition"])}"];')
 dot.append('}'); source='\n'.join(dot)
 (GFX/(v['id']+'.dot')).write_text(source)
 p=subprocess.run(['dot','-Tsvg'],input=source,text=True,capture_output=True)
 if p.returncode: raise RuntimeError(v['id']+' '+p.stderr)
 s=p.stdout[slice(p.stdout.index('<svg'),None)]
 s=re.sub(r'<title>.*?</title>','',s,flags=re.S)
 s=re.sub(r'<svg\s','<svg role="img" aria-label="'+esc(v['title'])+'" ',s,count=1)
 s=s.replace('xmlns:xlink="http://www.w3.org/1999/xlink"','')
 # Replace generated IDs with namespaced IDs; data identifiers remain stable across views.
 for nodeid in v['nodes']:
  n=N[nodeid]
  s=s.replace(f'id="{nodeid}" class="node"',f'id="svg-{v["id"]}-{nodeid}" class="node k-{n["kind"]}" data-node="{nodeid}" tabindex="0" role="button" aria-label="{esc(nodeid+" "+n["title"])}"')
 for eid in v['edges']:
  e=E[eid]
  s=s.replace(f'id="{eid}" class="edge"',f'id="svg-{v["id"]}-{eid}" class="edge t-{e["type"]}" data-edge="{eid}" tabindex="0" role="button" aria-label="{esc(eid+" "+e["source"]+" → "+e["target"]+": "+e["label"])}"')
 # Graphviz puts edge titles inside xlink anchors when tooltip is set; remove links, retain shapes/text.
 s=re.sub(r'</?a\b[^>]*>','',s)
 (GFX/(v['id']+'.svg')).write_text(s,encoding='utf-8')
 return s
SVG={v['id']:make_graph(v) for v in M['views']}

# Print view: landscape pages, exact IDs and full operation contracts. One source model, distinct reading layout.
def link(id,label=None):return f'<a href="#p-{id}">{esc(label or id)}</a>'
def badge(s,cl=''):return f'<span class="badge {cl}">{esc(s)}</span>'
def paragraph(s):return '<p>'+esc(s)+'</p>'
def refs(ids):return ' · '.join(link(i) for i in ids)
def field(t,v):
 if isinstance(v,list):v=' / '.join(v)
 return '<div class="field"><h4>'+esc(t)+'</h4><p>'+esc(v)+'</p></div>'
pages=[]
def page(title,subtitle,body,cls='',id=''):
 pages.append(f'<section class="sheet {cls}" '+(f'id="p-{id}"' if id else '')+f'><div class="pagehead"><span>SOUL / Mekanizma Atlası</span><span>v0.1 · 10 Eylül 2026</span></div><h2>{esc(title)}</h2><p class="deck">{esc(subtitle)}</p>{body}<div class="pagefoot"><span>Aday işleyiş modeli · gerçek SOUL yürütmesi değildir</span><span>{len(pages)+1:02d}</span></div></section>')

page('SOUL Mekanizma Atlası','Talep, muhakeme, iş ve uzmanlık sürekliliğini bağlantılarıyla incelemek',f'''
<div class="cover-grid"><div><p class="cover-thesis">İlkeleri, girdileri ve çıktıları belli <strong>çalışma ilişkilerine</strong> dönüştürmek.</p><p>Bir kutu: sorumluluk ve işlem sözleşmesi.<br>Bir ok: koşul, taşınan bilgi ve sınır.<br>Bir açık nokta: çizildiği için çözülmüş olmayan mekanizma.</p><p class="meta-line">22 işlem sözleşmesi · 7 harita · 10 demo adımı<br>21 hayali dosya · 12 açık mekanizma</p></div><div class="cover-graphic">{SVG['overview']}</div></div>
<div class="notice"><strong>Bu dosya ne değildir?</strong> Çalışan SOUL uygulaması, kabul edilmiş mimari, ajan kontrol talimatı veya bağımsız doğrulama değildir. HTML atlası, PDF ve model.json aynı aday modelin farklı temsilleridir.</div><p class="small">Ana kaynak: SOUL’un Çalışma Anlayışı konsolidasyonu v0.1 ve onu izleyen mekanizma/atlas konuşması. Araştırma dayanakları kaynak bölümünde ayrı statüyle korunur.</p>
''','cover','cover')

contents=[('guide','Okuma anahtarı'),('principles','Korunan çalışma ilkeleri'),*[(v['id'],v['title']) for v in M['views']],('axes','Bir durum, birden fazla eksen'),('demo','Uygulama demosu'),('contracts','22 işlem sözleşmesi'),('records','Hayali dosya envanteri'),('questions','Açık mekanizmalar'),('discoveries','Görünür hale gelen ilişkiler'),('sources','Kaynaklar ve sınırlar')]
nav='<div class="contents">'+''.join(link(i,t) for i,t in contents)+'</div>'
legend=''.join(f'<div class="legend-item"><i style="border-top:2px {st} {c}"></i><span>{esc(t)}</span></div>' for t,c,st in TYPES.values())
page('Okuma anahtarı','İdeal işleyişi tarif ediyoruz; fiilî gerçekleşmişliği varsaymıyoruz.',f'''<div class="two-col"><div><h3>Atlasın bölümleri</h3>{nav}</div><div><h3>Öğeler ve bağlantılar</h3><p><b>G</b> üst görünüm grubudur. <b>M</b> işlem sorumluluğudur. <b>I</b> bilgi nesnesidir. <b>E/B</b> ilişkidir; <b>R</b> hayali dosya, <b>Q</b> açık mekanizma, <b>P</b> konuşma ilkesidir.</p>{legend}<p class="small">Çizgi biçimi ilişkinin türünü belirtir; kesinlik veya doğruluk derecesi değildir. Haritalar seçici görünümlerdir; çizilmeyen ilişki “yok” sayılmaz.</p><h3>Statü ayrımı</h3><p><b>Konuşma ilkesi:</b> birlikte geliştirdiğimiz yönelim.<br><b>Modelleme önerisi:</b> bu atlasın kutu ve ilişki seçimi.<br><b>Açık mekanizma:</b> henüz uygulaması veya karar yolu seçilmedi.</p><p>Bir M kutusu ayrı bir ajan, dosya veya servis gerektirmez. Döngü içinde aynı sorumluluğa yeniden dönülebilir; çizim tek ve zorunlu bir yaşam döngüsü değildir.</p></div></div>''',id='guide')

for start in (0,6):
 body='<div class="principle-grid">'+''.join('<article>'+badge(p['id'])+'<h3>'+esc(p['title'])+'</h3>'+paragraph(p['body'])+'<p class="small">S00 '+esc(p['source'])+' · '+refs(p['nodes'])+'</p></article>' for p in M['principles'][start:start+6])+'</div>'
 page('Korunan çalışma ilkeleri'+(' / 2' if start else ''),'Ürün kapsamı değişebilir; gerekli uzmanlık değerlendirmesi ve mesleki ciddiyet boyuta göre kaldırılmaz.',body,id='principles' if not start else 'principles2')

for v in M['views']:
 ops=[N[x] for x in v['nodes']]
 pills=' '.join(link(x['id'],x['id']+' '+x['short']) for x in ops)
 body=f'<div class="print-graph">{SVG[v["id"]]}</div><div class="graph-bottom"><div>{legend}</div><p>{esc(v["description"])}</p></div><div class="node-index">{pills}</div>'
 page(v['title'],v['question'],body,'map-sheet',v['id'])

body='<table><thead><tr><th>İnceleme ekseni</th><th>Örnek durumlar</th><th>Korunan ayrım</th></tr></thead><tbody>'+''.join('<tr>'+''.join('<td>'+esc(c)+'</td>' for c in row)+'</tr>' for row in M['state_axes'])+'</tbody></table><div class="notice"><strong>Birbirini dışlayan tek durum makinesi değil.</strong> Bir talep aynı anda kaydedilmiş, üstlenilmemiş ve planlanmamış olabilir. W-01 taslağı üretilmişken kişi bazlı yorumunun geçerliliği hâlâ koşullu olabilir.</div><p>Bu eksenler SOUL veri şeması değildir. Atlas, farklı gerçekleri tek bir “yapılacak / yapılıyor / bitti” alanına sıkıştırmamak için onları yan yana gösterir. [S00 §6–7; K01–K04]</p>'
page('Bir durum, birden fazla eksen','“Kayıt var” ile “iş başladı” veya “çıktı kullanılabilir” aynı olay değildir.',body,id='axes')

# Five 2-step narrative pages, preserving the actual example arithmetic.
for i in range(0,len(M['demo']),2):
 cards=[]
 for d in M['demo'][i:i+2]:
  cells=badge(d['id'],'teal')+'<h3>'+esc(d['title'])+'</h3>'+paragraph(d['event'])+field('C — mevcut anlayış',d['understanding'])+field('W — işte ne değişti?',d['work'])+'<p class="small"><b>İlgili mekanizmalar:</b> '+refs(d['nodes'])+'<br><b>Kayıtlar:</b> '+refs(d['records'])+'</p><div class="notice small">'+esc(d['note'])+'</div>'
  cards.append('<article class="demo-card" id="p-'+d['id']+'">'+cells+'</article>')
 page('Uygulama demosu / '+str(i//2+1),'Anlatılmış senaryo; otomatik ajan çalıştırması veya uygulama testi değil. Adımlar bir açıklama dizisidir.', '<div class="two-col">'+''.join(cards)+'</div>',id='demo' if i==0 else 'demo'+str(i//2+1))

body='''<div class="two-col"><div><h3>Kaynak: dört sentetik kişi</h3><table><tr><th>Kişi</th><th>Üç seçim</th></tr><tr><td>K1</td><td>H1 · H2 · H3</td></tr><tr><td>K2</td><td>H1 · H2 · H4</td></tr><tr><td>K3</td><td>H1 · H3 · H4</td></tr><tr><td>K4</td><td>H2 · H4 · H5</td></tr></table><p><b>H1 seçim payı:</b> 3 / 12 = %25<br><b>H1 yanıtlayan oranı:</b> 3 / 4 = %75</p><p>İki doğru hesap, iki farklı soruya cevap verir. Üç seçim nedeniyle hareket bazlı katılımcı yüzdelerinin toplamı %100 değildir.</p></div><div><h3>Karşı örnek: K1’i tekrar say</h3><p>Yeni insan eklenmez. Beş kayıt oluşur. H3’ü içeren kayıtlar 2’den 3’e çıkar.</p><p class="formula">2 / 4 = %50<br><span>→</span> 3 / 5 = %60</p><p>“Çoğunluk seçti” yorumu değişir; fakat yeni bir katılımcı yoktur. D-02 aritmetik hatasını değil, sayım biriminin eksik tanımını ortaya çıkarır.</p><div class="notice">W-01’in hesabı korunur. W-03 sayılma politikasını araştıracak aday iştir. W-02’nin bağımsız giriş kuralları devam edebilir.</div></div></div>'''
page('Demo merceği: doğru hesap, yanlış yorum','Sayılar sentetiktir. Orijinal demo S00 §8.3–8.5; bu sayfa yeni bir ürün testi değildir.',body,id='arithmetic')

# Each pair of operation contracts: fields are concise, printed in readable blocks.
ops=[n for n in M['nodes'] if n['kind']=='operation']
for i in range(0,len(ops),2):
 cards=[]
 for n in ops[i:i+2]:
  body=badge(n['id'])+'<h3>'+esc(n['title'])+'</h3>'+paragraph(n['summary'])
  for t,key in [('Sorumluluk','actor'),('Tetikleyici','trigger'),('Girdiler','inputs'),('Çalışma ilkesi','rules'),('Çıktı ve kayıt etkisi','outputs')]:body+=field(t,n[key])
  body+=field('Güncellenen / önerilen kayıt',n['updates'])+field('Sınır',n['guard'])+field('Engel / hata yolu',n['failure'])
  body+='<p class="example"><b>Demo:</b> '+esc(n['example'])+'</p>'
  body+='<p class="small"><b>Kaynak:</b> S00 '+esc(n['section'])+' · '+refs(n['sources'])+'<br><b>Açık:</b> '+refs(n['gaps'])+'</p>'
  outgoing=[e for e in M['edges'] if e['source']==n['id']]
  body+='<p class="small"><b>Çıkış ilişkileri:</b> '+(' · '.join(link(e['id'],e['id']+' → '+e['target']) for e in outgoing) or 'Bu görünümde ek çıkış tanımlı değil.')+'</p>'
  cards.append('<article class="contract" id="p-'+n['id']+'">'+body+'</article>')
 page('İşlem sözleşmeleri / '+str(i//2+1),'Her işlem, aday bir sorumluluk tanımıdır; ayrı ajan veya servis seçimi değildir.','<div class="two-col contracts">'+''.join(cards)+'</div>',id='contracts' if i==0 else 'contracts'+str(i//2+1))

# Full relation register in compact tables across pages. Four fields preserve branch meaning.
rels=M['edges']
for i in range(0,len(rels),8):
 rows=[]
 for e in rels[i:i+8]:rows.append('<tr id="p-'+e['id']+'"><td>'+esc(e['id'])+'<br>'+link(e['source'])+' → '+link(e['target'])+'</td><td>'+esc(TYPES[e['type']][0])+'<br><b>'+esc(e['label'])+'</b></td><td>'+esc(e['condition'])+'</td><td>'+esc(e['payload'])+'<br><span class="muted">'+esc(e['notMeans'])+'</span></td></tr>')
 body='<table class="edge-table"><thead><tr><th style="width:15%">Kimlik / uçlar</th><th style="width:17%">İlişki</th><th style="width:31%">Geçiş koşulu</th><th>Taşıdığı ve kanıtlamadığı</th></tr></thead><tbody>'+''.join(rows)+'</tbody></table>'
 page('İlişki sözleşmeleri / '+str(i//8+1),'Okun anlamı: koşul + taşınan içerik + korunacak sınır. Üst görünüm B ilişkileri yalnız gruplanmış harita bağlantılarıdır.',body,'relations-sheet',id='relations' if i==0 else 'relations'+str(i//8+1))

infos=[n for n in M['nodes'] if n['kind']=='information']
for i in range(0,len(infos),6):
 body='<div class="principle-grid">'
 for n in infos[i:i+6]:body+='<article id="p-'+n['id']+'">'+badge(n['id'],'teal')+'<h3>'+esc(n['title'])+'</h3>'+paragraph(n['summary'])+'<p class="small">'+esc(' / '.join(n['updates']))+'<br>S00 '+esc(n['section'])+'</p></article>'
 body+='</div>'
 page('Bilgi nesneleri / '+str(i//6+1),'Dosyalar aktörlerin okuduğu ve ürettiği temsillerdir; kendileri iş veya yetki değildir.',body,id='objects' if i==0 else 'objects2')

for i in range(0,len(M['records']),7):
 rows=''.join('<tr id="p-'+r['id']+'"><td style="width:32%"><b>'+esc(r['id'])+'</b> · <code>'+esc(r['path'])+'</code><br><span class="muted">'+esc(r['status'])+'</span></td><td>'+esc(r['content'])+'</td><td style="width:23%"><b>Üreten:</b> '+esc(r['writer'])+'<br><b>Kullanan:</b> '+esc(r['reader'])+'<br>'+link(r['node'])+'</td></tr>' for r in M['records'][i:i+7])
 page('Hayali dosya envanteri / '+str(i//7+1),'İlk altı dosya demoda adlandırıldı; diğerleri sonraki konuşmanın önerileridir. Gerçek proje dosyaları oluşturulmadı.','<table class="record-table"><tr><th>Dosya / statü</th><th>İçerik ve rol</th><th>Çalışma ilişkisi</th></tr>'+rows+'</table>',id='records' if i==0 else 'records'+str(i//7+1))

for i in range(0,len(M['gaps']),4):
 body='<div class="gap-grid">'+''.join('<article id="p-'+q['id']+'">'+badge(q['id'],'amber')+'<h3>'+esc(q['title'])+'</h3>'+paragraph(q['why'])+'<p><b>Gerekli açıklık:</b> '+esc(q['needed'])+'</p><p class="small">'+refs(q['nodes'])+'</p></article>' for q in M['gaps'][i:i+4])+'</div>'
 page('Açık mekanizmalar / '+str(i//4+1),'Bir kutu veya bağlantı çizmek, içindeki kararı vermek ya da gerçek işletimi kurmak değildir.',body,id='questions' if i==0 else 'questions'+str(i//4+1))

body='<div class="principle-grid">'+''.join('<article><h3>'+esc(f['title'])+'</h3>'+paragraph(f['body'])+'<p class="small">'+refs(f['refs'])+'</p></article>' for f in M['findings'])+'</div>'
page('Modeli kurarken görünür olan ilişkiler','Bunlar yapıyı nesneleştirmenin ürettiği inceleme konularıdır; doğrulanmış mimari sonuçlar değildir.',body,id='discoveries')

for i in range(0,len(M['sources']),4):
 body='<div class="source-grid">'
 for s in M['sources'][i:i+4]:
  title=f'<a href="{esc(s["url"])}">{esc(s["title"])}</a>' if s['url'] else esc(s['title'])
  body+='<article id="p-'+s['id']+'">'+badge(s['id'])+'<h3>'+title+'</h3><p class="path">'+esc(s['path'])+'</p>'+paragraph(s['role'])+('<p class="hash">'+esc(s['sha'])+'</p>' if s['sha'] else '')+'</article>'
 body+='</div>'
 page('Kaynak ve statü izi / '+str(i//4+1),'S00 ana metindir. K01–K10 kimlikleri onun Ek D’sinden aktarılmıştır; kaynaklar aday atlas mimarisini doğrulamaz.',body,id='sources' if i==0 else 'sources'+str(i//4+1))

# Reader notes make the document usable independently from the original chat.
page('Sınırlar ve dosya kullanımı','Bu atlası mevcut konsolidasyonun yerine geçen özet değil, ona bağlı bir mekanizma görünümü olarak okuyun.',f'''<div class="two-col"><div><h3>Gerçek çıktılar</h3><p>HTML atlası; bu PDF; model.json; düzenlenebilir üretim kaynakları ve yedi SVG/DOT şema. Atlasın içindeki form projesi dosyaları hâlâ hayalidir.</p><h3>Gerçek olmayan işlemler</h3><p>Canlı SOUL ajanları, kullanıcı verisi, uygulama kodu, gerçek yetkilendirme veya araç etkisi çalıştırılmadı. Demo düğmeleri önceden tanımlanmış anlatım adımlarını gösterir.</p><h3>Yapısal kapsam</h3><p>İşlemler ve ilişkiler seçici bir temsil modelidir. Yeni kanıt veya farklı bir iş, bu ayrıştırmayı değiştirebilir. Tüm düğümlerin tek oturumda veya her işte sırayla çalışması gerekmez.</p></div><div><h3>HTML’de kullanım</h3><p>Sol menüden harita seçin. Kutular işlem ayrıntısını, oklar koşullu ilişkiyi açar. Arama tüm kimlik ve başlıklarda çalışır. Yakınlaştırma, kaydırma, liste görünümü ve bağlantı paneli küçük ekranı destekler.</p><h3>Kaynakla yeniden üretim</h3><p>model.json atlasın temsil kaynağıdır. build_atlas.py HTML/SVG görünümünü üretir. render_and_test.py PDF’yi üretir ve yerel tarayıcı denetimleri için başlangıç noktasıdır. Bu dosyalar SOUL’un çalışma kontrolü değildir.</p><h3>Repository sınırı</h3><p>Bu turda araştırma veya SOUL repository’sine yazılmadı; Foundation kabul ve yetki durumları değiştirilmedi. Kaynak görünümü 10 Eylül 2026 tarihli okuma sınırını taşır.</p></div></div><div class="notice">Profesyonel standardı korumak, her kutuyu ayrı ajan veya her ilkeyi ayrı kontrol turu yapmak değildir. Gerekli katılımı belirleme sorumluluğu da modelin parçasıdır.</div>''',id='limits')
PRINT='\n'.join(pages)

# Append B relationships and G descriptions as print anchors on overview page. IDs are accessible via index links.
# Mapping macro targets to overview avoids broken internal links without new duplicate contracts.
for g in [n for n in M['nodes'] if n['kind']=='group']:
 PRINT=PRINT.replace('id="p-overview"','id="p-overview"',1)
# Set macro node SVG links to detail pages, also add invisible destination anchors in overview index.
PRINT=PRINT.replace('<section class="sheet map-sheet" id="p-overview">','<section class="sheet map-sheet" id="p-overview">'+''.join('<span id="p-'+n['id']+'"></span>' for n in M['nodes'] if n['kind']=='group'))

(PKG/'print_pages.html').write_text(PRINT)

# HTML UI template + generated print view and model below.
CSS=(WORK/'style.css').read_text() if (WORK/'style.css').exists() else ''
JS=(WORK/'app.js').read_text() if (WORK/'app.js').exists() else ''
TEMPLATE=(WORK/'template.html').read_text() if (WORK/'template.html').exists() else ''
if TEMPLATE:
 svgjson=json.dumps(SVG,ensure_ascii=False).replace('</','<\\/')
 out=TEMPLATE.replace('/*__STYLE__*/',CSS).replace('/*__APP__*/',JS).replace('__MODEL__',json.dumps(M,ensure_ascii=False).replace('</','<\\/')).replace('__SVGS__',svgjson).replace('__PRINT__',PRINT)
 (ROOT/'SOUL_Mekanizma_Atlasi_v0_1.html').write_text(out,encoding='utf-8')
 (PKG/'SOUL_Mekanizma_Atlasi_v0_1.html').write_text(out,encoding='utf-8')
print('Built SVGs, print pages:',len(pages))
for v,s in SVG.items():print(v,re.search(r'viewBox="([^"]+)"',s).group(1))
