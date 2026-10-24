(() => {
'use strict';
const $ = id => document.getElementById(id);
const model = JSON.parse($('atlas-model').textContent);
const svgs = JSON.parse($('atlas-svgs').textContent);
const index = a => Object.fromEntries(a.map(x => [x.id,x]));
const N=index(model.nodes), E=index(model.edges), R=index(model.records), Q=index(model.gaps), S=index(model.sources), P=index(model.principles), V=index(model.views);
const types={control:['İşleyiş / koşul','#354b6b','solid'],data:['Bilgi / çıktı','#287c74','solid'],feedback:['Yeniden değerlendirme','#516ca2','dashed'],exception:['Engel / toparlanma','#a34b37','dashed'],context:['Dayanak / bağlam','#80608b','dotted']};
const state={view:'overview',item:null,mode:'map',step:0,scale:1,filter:'all',query:''};
const esc = value => String(value??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const text = a => Array.isArray(a)?a.join(' / '):a;
const titleOf = id => N[id]?.title || E[id]?.label || R[id]?.path || Q[id]?.title || S[id]?.title || P[id]?.title || id;
const tag = (id,label) => `<button class="tag-link" data-item="${esc(id)}">${esc(label||id)}</button>`;
const tags = ids => `<div class="tag-links">${ids.map(id=>tag(id)).join('')}</div>`;
const badge = (str,cls='') => `<span class="badge ${cls}">${esc(str)}</span>`;
const notice = str => `<div class="notice">${esc(str)}</div>`;
const field = (label,value) => !value || (Array.isArray(value)&&!value.length)?'':`<section class="detail-field"><h3>${esc(label)}</h3><p>${esc(text(value))}</p></section>`;
const allObjects=[...model.nodes,...model.edges,...model.records,...model.gaps,...model.principles,...model.sources];
const extraViews=[
 ['demo','Uygulama demosu','Hazırlanmış örneği adım adım izle. Canlı ajan, gerçek ürün testi veya otomatik karar üretimi yok.'],
 ['catalog','İşlemler ve ilişkiler','22 işlem, 11 bilgi nesnesi ve bütün ilişkiler. Haritalar seçicidir; tam kayıt burada.'],
 ['records','Dosya envanteri','İlk demodaki altı dosya ve sonraki konuşmada önerilen çalışma donanımı. Bunlar gerçek SOUL dosyaları değildir.'],
 ['axes','Durum eksenleri','Kaydedildi, üstlenildi, hazır, üretildi ve kabul edildi aynı durum değildir.'],
 ['principles','Çalışma ilkeleri','İşin ölçeği değişebilir; mesleki ciddiyet ve gerekli uzmanlık değerlendirmesi ortadan kalkmaz.'],
 ['questions','Açık mekanizmalar','Şemada yer alan ama iç işleyişi henüz seçilmemiş sorumluluklar. Çizilmiş olmaları çözülmüş oldukları anlamına gelmez.'],
 ['discoveries','Görünür olan ilişkiler','Metni mekanizmaya dönüştürürken ayrıştırmak zorunda kaldığımız noktalar. Bunlar modelleme gözlemleridir.'],
 ['sources','Kaynaklar ve sınırlar','Konsolidasyon, sonraki konuşma ve araştırma dayanakları ayrı statüyle korunur.']
];
const EX=Object.fromEntries(extraViews.map(v=>[v[0],{title:v[1],description:v[2]}]));
let activeGraph=null, toastTimer=null;
function toast(s){$('toast').textContent=s;$('toast').classList.add('show');clearTimeout(toastTimer);toastTimer=setTimeout(()=>$('toast').classList.remove('show'),2600);}
function sidebar(open){$('sidebar').classList.toggle('open',open);$('menu-btn').setAttribute('aria-expanded',String(open));}
function href(view,item=null,step=null){let p=new URLSearchParams({view});if(item)p.set('item',item);if(view==='demo')p.set('step',step??state.step);if(state.mode==='list'&&V[view])p.set('mode','list');return '#'+p.toString();}
function go(view,item=null,step=null){const h=href(view,item,step);if(location.hash===h)readHash();else location.hash=h;sidebar(false);}
function readHash(){
 const p=new URLSearchParams(location.hash.slice(1));let view=p.get('view')||'overview';if(!V[view]&&!EX[view])view='overview';
 const old=state.view;state.view=view;state.step=Math.max(0,Math.min(model.demo.length-1,Number(p.get('step'))||0));
 const item=p.get('item');state.item=allObjects.some(o=>o.id===item)?item:null;state.mode=p.get('mode')==='list'?'list':'map';
 if(old!==view){state.filter='all';state.scale=1;}render();
}
function nav(){
 $('navigation').innerHTML='<div class="nav-label">HARİTALAR</div>'+model.views.map((v,i)=>`<a href="${href(v.id)}" class="nav-link ${state.view===v.id?'active':''}" ${state.view===v.id?'aria-current="page"':''}><span class="nav-num">0${i+1}</span><span>${esc(v.title)}</span></a>`).join('')+'<div class="nav-label">İNCELEME</div>'+extraViews.map((v,i)=>`<a href="${href(v[0])}" class="nav-link ${state.view===v[0]?'active':''}" ${state.view===v[0]?'aria-current="page"':''}><span class="nav-num">${String(i+8).padStart(2,'0')}</span><span>${esc(v[1])}</span></a>`).join('');
}
function render(){
 nav();const cfg=V[state.view]||EX[state.view];$('view-title').textContent=cfg.title;$('view-description').textContent=cfg.description;
 $('view-number').textContent=V[state.view]?'HARİTA '+String(model.views.findIndex(v=>v.id===state.view)+1).padStart(2,'0')+' / 07':'ATLAS / İNCELEME';
 const graph=Boolean(V[state.view]);$('toolbar').hidden=!graph;$('graph-section').hidden=!graph||state.mode==='list';$('content-section').hidden=graph&&state.mode==='map';
 $('map-btn').setAttribute('aria-pressed',String(state.mode==='map'));$('list-btn').setAttribute('aria-pressed',String(state.mode==='list'));
 $('workspace').classList.toggle('has-selection',Boolean(state.item));$('inspector').hidden=!state.item;$('clear-btn').hidden=!state.item;
 if(graph){if(state.mode==='map'){showGraph(state.view,$('svg-stage'));renderLegend();}else{$('content-section').innerHTML=viewList(V[state.view]);activeGraph=null;}}
 else renderExtra();
 if(state.item)renderInspector(state.item);highlight();
 $('status-text').textContent=state.item?`${state.item} seçili · Kutular ve ilişkiler aday modeldir; gerçekleşme kanıtı değildir.`:'Aday işleyiş modeli. Harita, uygulanmış mimari veya başarı kanıtı değildir.';
}
function showGraph(view,container){
 container.innerHTML=svgs[view];const svg=container.querySelector('svg');activeGraph={view,container,svg};
 // Wide transparent paths make edges selectable without pixel-perfect clicks.
 svg.querySelectorAll('[data-edge]').forEach(g=>{const p=g.querySelector('path');if(p){const hit=p.cloneNode();hit.removeAttribute('style');hit.setAttribute('class','edge-hit');hit.setAttribute('fill','none');hit.setAttribute('stroke','transparent');hit.setAttribute('stroke-width','18');hit.setAttribute('pointer-events','stroke');g.insertBefore(hit,g.firstChild);}});
 fitGraph(true);
}
function fitGraph(legible=false){if(!activeGraph)return;const {svg,container}=activeGraph;const vb=svg.viewBox.baseVal;const vp=container.parentElement;const aw=Math.max(280,vp.clientWidth-54),ah=Math.max(260,vp.clientHeight-45);
 const fit=Math.min(1.15,aw/vb.width,ah/vb.height);state.scale=legible?Math.max(window.innerWidth<700?.82:.64,fit):fit;scaleGraph();vp.scrollTop=0;vp.scrollLeft=0;}
function scaleGraph(){if(!activeGraph)return;const vb=activeGraph.svg.viewBox.baseVal;activeGraph.svg.style.width=(vb.width*state.scale)+'px';activeGraph.svg.style.height=(vb.height*state.scale)+'px';$('zoom-value').textContent=Math.round(state.scale*100)+'%';}
function renderLegend(){ $('legend').innerHTML=Object.values(types).map(([t,c,s])=>`<span class="legend-item"><i style="border-top:2px ${s} ${c}"></i>${esc(t)}</span>`).join('');}
function objectRow(o){const summary=o.summary||o.content||o.why||o.body||o.condition||o.role||'';return `<article class="object-row"><span class="object-id">${esc(o.id)}</span><div><h3>${esc(o.title||o.path||o.label)}</h3><p>${esc(summary)}</p></div><button class="row-open" data-item="${o.id}">İncele</button></article>`;}
function edgeRow(e){return `<article class="object-row edge-row"><span class="object-id">${e.id}</span><div><h3>${esc(e.source)} → ${esc(e.target)} · ${esc(e.label)}</h3><p>${esc(types[e.type][0])} · ${esc(e.condition)}</p></div><button class="row-open" data-item="${e.id}">Oku aç</button></article>`;}
function viewList(v){return `<div class="section-intro">${notice('Bu liste, haritadaki aynı nesne ve ilişkilerin klavye ve küçük ekran için alternatif görünümüdür.')}<h2>${v.nodes.length} öğe</h2>${v.nodes.map(id=>objectRow(N[id])).join('')}<h2>${v.edges.length} bağlantı</h2>${v.edges.map(id=>edgeRow(E[id])).join('')}</div>`;}
function relatedLinks(id){const incoming=model.edges.filter(e=>e.target===id),outgoing=model.edges.filter(e=>e.source===id);let s='';if(incoming.length)s+='<h3>Gelen bağlantılar</h3>'+incoming.map(e=>`<button class="relation-link" data-item="${e.id}"><b>${e.id} · ${e.source} → ${e.target}</b><span>${esc(e.label)}</span></button>`).join('');if(outgoing.length)s+='<h3>Giden bağlantılar</h3>'+outgoing.map(e=>`<button class="relation-link" data-item="${e.id}"><b>${e.id} · ${e.source} → ${e.target}</b><span>${esc(e.label)}</span></button>`).join('');return s;}
function renderInspector(id){
 let h='';const n=N[id],e=E[id],r=R[id],q=Q[id],s=S[id],p=P[id];
 if(n){h=badge(n.id)+' '+badge(n.kind==='operation'?'İşlem':n.kind==='information'?'Bilgi':'Üst görünüm')+`<h2>${esc(n.title)}</h2><p class="inspector-summary">${esc(n.summary)}</p><p class="small">${esc(n.status)}</p>`;
 if(n.kind==='group')h+=`<button class="primary-btn" data-go="${n.targetView}">İç görünümü aç</button><h3>İçerdiği sorumluluklar</h3>`+n.children.map(x=>`<button class="relation-link" data-item="${x}"><b>${x}</b><span>${esc(titleOf(x))}</span></button>`).join('');
 else h+=field('Sorumluluk',n.actor)+field('Tetikleyici',n.trigger)+field('Girdiler',n.inputs)+field('Çalışma bilgisi / ilke',n.rules)+field('Çıktılar',n.outputs)+field('Durum / kayıt etkisi',n.updates)+field('Geçiş sınırı',n.guard)+field('Eksik / hata yolu',n.failure)+field('Demodaki karşılığı',n.example);
 h+=n.gaps.length?'<h3>Açık mekanizmalar</h3>'+tags(n.gaps):'';
 const views=model.views.filter(v=>v.nodes.includes(id));if(views.length)h+='<h3>Haritalarda bul</h3><div class="tag-links">'+views.map(v=>`<button class="tag-link" data-go="${v.id}" data-go-item="${id}">${esc(v.title)}</button>`).join('')+'</div>';
 const records=model.records.filter(r=>r.node===id||r.reader.includes(id)||r.writer.includes(id));if(records.length)h+='<h3>İlgili hayali dosyalar</h3>'+tags(records.map(r=>r.id));
 h+=relatedLinks(id)+`<h3>Dayanak</h3><p class="small">Konsolidasyon ${esc(n.section)}</p>`+tags(n.sources);
 }else if(e){h=badge(e.id)+' '+badge(types[e.type][0])+`<h2>${esc(e.label)}</h2><p>${tag(e.source,e.source+' '+titleOf(e.source))} → ${tag(e.target,e.target+' '+titleOf(e.target))}</p>`+field('Geçiş / ilişkinin koşulu',e.condition)+field('Taşınan bilgi / sonuç',e.payload)+field('Bu ok neyi kanıtlamaz?',e.notMeans)+field('Statü',e.status);const views=model.views.filter(v=>v.edges.includes(id));if(views.length)h+='<h3>Haritada bul</h3><div class="tag-links">'+views.map(v=>`<button class="tag-link" data-go="${v.id}" data-go-item="${id}">${esc(v.title)}</button>`).join('')+'</div>';}
 else if(r){h=badge(r.id)+`<h2>${esc(r.role)}</h2><p class="path">${esc(r.path)}</p>`+field('Statü',r.status)+field('İçerik',r.content)+field('Üretim / yazma sorumluluğu',r.writer)+field('Kullanım / okuma sorumluluğu',r.reader)+'<h3>Bilgi nesnesi</h3>'+tags([r.node])+notice('Bu dosya hayalidir. Tekil fiziksel dosya zorunluluğu veya var olan SOUL yapısı anlamına gelmez.');}
 else if(q){h=badge(q.id,'open')+`<h2>${esc(q.title)}</h2>`+field('Neden açık?',q.why)+field('Ne belirlenmeli?',q.needed)+'<h3>Etkilediği işlemler</h3>'+tags(q.nodes)+notice(q.status);}
 else if(s){h=badge(s.id)+`<h2>${esc(s.title)}</h2>`+field('Kaynağın rolü',s.role)+`<p class="path">${esc(s.path||'Konuşma kaynağı')}</p><p class="hash">${esc(s.sha||'')}</p>`+(s.url?`<a class="primary-btn" href="${esc(s.url)}" target="_blank" rel="noopener noreferrer">Kaynağı aç ↗</a>`:notice('Yerel konsolidasyon veya konuşma kaynağı. Bu atlas, özgün kaynak metnin yerine geçmez.'));}
 else if(p){h=badge(p.id)+`<h2>${esc(p.title)}</h2><p>${esc(p.body)}</p><p class="small">S00 ${esc(p.source)}</p>`+tags(p.nodes);}
 $('inspector-content').innerHTML=h;$('inspector-content').scrollTop=0;$('inspector').scrollTop=0;
}
function select(id){if(!allObjects.some(o=>o.id===id))return;state.item=id;go(state.view,id,state.step);}
function highlight(){if(!activeGraph)return;const svg=activeGraph.svg;let selected=state.item;const nodes=new Set(),edges=new Set();if(N[selected]){nodes.add(selected);model.edges.filter(e=>e.source===selected||e.target===selected).forEach(e=>{nodes.add(e.source);nodes.add(e.target);edges.add(e.id)});}else if(E[selected]){nodes.add(E[selected].source);nodes.add(E[selected].target);edges.add(selected);}else if(state.view==='demo')model.demo[state.step].nodes.forEach(x=>nodes.add(x));
 svg.querySelectorAll('[data-node]').forEach(g=>{g.classList.toggle('selected',g.dataset.node===selected||state.view==='demo'&&nodes.has(g.dataset.node));g.classList.toggle('dimmed',nodes.size>0&&!nodes.has(g.dataset.node));});
 svg.querySelectorAll('[data-edge]').forEach(g=>{g.classList.toggle('selected',g.dataset.edge===selected);g.classList.toggle('dimmed',edges.size>0&&!edges.has(g.dataset.edge));});
}
function renderExtra(){
 const c=$('content-section');activeGraph=null;
 if(state.view==='demo'){renderDemo();return;}
 if(state.view==='catalog'){
 const filters=[['all','Tümü'],['operation','İşlemler'],['information','Bilgi nesneleri'],['edges','Bütün oklar']];
 c.innerHTML='<div class="filter-bar">'+filters.map(([id,t])=>`<button data-filter="${id}" aria-pressed="${state.filter===id}">${t}</button>`).join('')+'</div>'+(state.filter==='all'||state.filter==='operation'?'<h2>İşlem sözleşmeleri</h2>'+model.nodes.filter(n=>n.kind==='operation').map(objectRow).join(''):'')+(state.filter==='all'||state.filter==='information'?'<h2>Bilgi nesneleri</h2>'+model.nodes.filter(n=>n.kind==='information').map(objectRow).join(''):'')+(state.filter==='all'||state.filter==='edges'?'<h2>Bütün ilişkiler</h2>'+model.edges.map(edgeRow).join(''):'');
 }else if(state.view==='records'){
 const rows=model.records.filter(r=>state.filter==='all'||state.filter==='first'&&r.id<'R07'||state.filter==='later'&&r.id>='R07');
 c.innerHTML=notice('Altı proje dosyası ilk demoda adlandırıldı. Diğer adlar sonraki konuşmada önerildi. Fiziksel dosya yapısı, rol sayısı ve gerçek çalıştırıcı seçilmiş değildir.')+'<div class="filter-bar">'+[['all','Tümü · 21'],['first','İlk demo · 6'],['later','Sonraki öneriler · 15']].map(([id,t])=>`<button data-filter="${id}" aria-pressed="${state.filter===id}">${t}</button>`).join('')+'</div><div class="table-scroll"><table class="data-table"><thead><tr><th>Dosya</th><th>İşlev ve statü</th><th>Kullanan / üreten</th></tr></thead><tbody>'+rows.map(r=>`<tr><td>${tag(r.id)}<p class="path">${esc(r.path)}</p></td><td><b>${esc(r.role)}</b><p>${esc(r.content)}</p><span class="small">${esc(r.status)}</span></td><td>Yazan: ${esc(r.writer)}<br>Okuyan: ${esc(r.reader)}<br>${tag(r.node)}</td></tr>`).join('')+'</tbody></table></div>';
 }else if(state.view==='questions')c.innerHTML='<div class="reading-grid">'+model.gaps.map(q=>`<article class="reading-item">${badge(q.id,'open')}<h2>${esc(q.title)}</h2><p>${esc(q.why)}</p><h3>Belirlenmesi gereken</h3><p>${esc(q.needed)}</p>${tags(q.nodes)}</article>`).join('')+'</div>';
 else if(state.view==='principles')c.innerHTML='<div class="reading-grid">'+model.principles.map(p=>`<article class="reading-item">${badge(p.id)}<h2>${esc(p.title)}</h2><p>${esc(p.body)}</p><p class="small">S00 ${esc(p.source)} · ${esc(p.status)}</p>${tags(p.nodes)}</article>`).join('')+'</div>';
 else if(state.view==='axes')c.innerHTML=notice('Birbirini dışlayan tek yaşam döngüsü değil. Örneğin kayıt varlığı, işin üstlenilmesi ve planlanması birlikte ayrı durumlar taşıyabilir.')+'<div class="table-scroll"><table class="data-table"><thead><tr><th>İnceleme ekseni</th><th>Örnek durumlar</th><th>Korunan ayrım</th></tr></thead><tbody>'+model.state_axes.map(row=>'<tr>'+row.map(x=>'<td>'+esc(x)+'</td>').join('')+'</tr>').join('')+'</tbody></table></div>'+notice('Bu eksenler aday modelin okuma lensleridir; SOUL için kabul edilmiş veritabanı şeması değildir.');
 else if(state.view==='discoveries')c.innerHTML='<div class="reading-grid">'+model.findings.map((f,i)=>`<article class="reading-item">${badge('0'+(i+1))}<h2>${esc(f.title)}</h2><p>${esc(f.body)}</p>${tags(f.refs)}</article>`).join('')+'</div>';
 else if(state.view==='sources')c.innerHTML=notice('İlkeler konsolidasyona, yeni kutu ve ok seçimleri ise atlas konuşmasına ve bu sürümdeki modellemeye dayanır. Araştırma kaynağı davranış yetkisi değildir; eski kaynak kimliği güncel dış olgunun yeniden doğrulandığı anlamına gelmez.')+'<div class="reading-grid">'+model.sources.map(s=>`<article class="reading-item">${badge(s.id)}<h2>${esc(s.title)}</h2><p>${esc(s.role)}</p><p class="path">${esc(s.path||'')}</p><p class="hash">${esc(s.sha||'')}</p>${s.url?`<a href="${esc(s.url)}" target="_blank" rel="noopener noreferrer">Kaynağı aç ↗</a>`:''}</article>`).join('')+'</div><section class="readme-box"><h2>Yetki ve doğrulama sınırı</h2><p>Atlasın kontrolleri belge bütünlüğü, sayısal örnekler ve arayüz işlevleriyle sınırlıdır. Gerçek SOUL aktörleri veya canlı ajan etkinliği ölçülmemiştir. Ayrı roller, ayrı bağımsız modeller olarak çalıştırılmadı. Gösterilen aday sorumluluklar tek ajan, çoklu ajan, kod veya mevcut ortam içinde farklı biçimlerde karşılanabilir.</p><p>Repository veya agent-control dosyaları bu teslimatta değiştirilmedi. Bu belge çalışma kurallarını kendi başına yürürlüğe sokmaz.</p></section>';
}
const demoViews=['intake','intake','readiness','execution','change','change','execution','execution','change','actor'];
function renderDemo(){const d=model.demo[state.step];$('content-section').innerHTML=`<div class="demo-header"><button id="demo-prev" ${state.step===0?'disabled':''}>← Önceki adım</button><span class="demo-count">${state.step+1} / ${model.demo.length}</span><button id="demo-next" ${state.step===model.demo.length-1?'disabled':''}>Sonraki adım →</button><button id="demo-reset" class="quiet">Başa dön</button></div><div class="demo-rail" aria-label="Demo adımları">${model.demo.map((s,i)=>`<button class="demo-dot ${i===state.step?'current':''}" data-step="${i}" title="${esc(s.title)}" ${i===state.step?'aria-current="step"':''}>${s.id}</button>`).join('')}</div><article class="demo-scene">${badge(d.id)} ${badge(d.status,state.step===9?'open':'')}<h2>${esc(d.title)}</h2><p>${esc(d.event)}</p><div class="demo-state"><section><h3>Information / mevcut C</h3><p>${esc(d.understanding)}</p></section><section><h3>Work / mevcut iş</h3><p>${esc(d.work)}</p></section></div>${notice(d.note)}<p class="step-context">İşlem sözleşmeleri</p>${tags(d.nodes)}<p class="step-context">İlgili hayali kayıtlar</p>${tags(d.records)}</article><div class="demo-graph"><h2>Bu adımın mekanizma görünümü</h2><p class="small">Vurgular anlatım adımını gösterir; bir model koşusu veya gözlenen aktivasyon değildir.</p><div class="graph-viewport" tabindex="0" aria-label="Demo adımının ilgili haritası"><div id="demo-svg-stage" style="padding:18px;display:flex;align-items:center;justify-content:center;min-width:100%;min-height:100%;width:max-content"></div></div></div>`;showGraph(demoViews[state.step],$('demo-svg-stage'));}
function search(query){state.query=query;const box=$('search-results');if(!query.trim()){box.hidden=true;box.innerHTML='';return;}const norm=s=>String(s).toLocaleLowerCase('tr').normalize('NFD').replace(/[\u0300-\u036f]/g,'');const q=norm(query.trim());const res=allObjects.filter(o=>norm([o.id,o.title,o.short,o.path,o.label,o.summary,o.content,o.why,o.condition].filter(Boolean).join(' ')).includes(q)).slice(0,20);box.hidden=false;box.innerHTML=res.length?res.map(o=>`<button class="search-result" data-search-item="${o.id}"><b>${esc(o.id)}</b><span>${esc(o.title||o.path||o.label)}</span></button>`).join(''):'<p class="search-empty">Eşleşme yok. Bir kimlik (M07, Q02…) veya başka bir sözcük deneyin.</p>';}
function download(content,type,name){const url=URL.createObjectURL(new Blob([content],{type}));const a=document.createElement('a');a.href=url;a.download=name;document.body.appendChild(a);a.click();a.remove();setTimeout(()=>URL.revokeObjectURL(url),1000);}
function setMode(mode){state.mode=mode;go(state.view,state.item,state.step);}
// Event delegation keeps graph/list/inspector identities synchronized.
document.addEventListener('click',ev=>{
 const t=ev.target;
 const item=t.closest('[data-item]');if(item){select(item.dataset.item);return;}
 const searchItem=t.closest('[data-search-item]');if(searchItem){const id=searchItem.dataset.searchItem;$('search-results').hidden=true;$('search').value='';const v=R[id]?'records':Q[id]?'questions':S[id]?'sources':P[id]?'principles':model.views.find(v=>v.nodes.includes(id)||v.edges.includes(id))?.id||'catalog';go(v,id);return;}
 const goto=t.closest('[data-go]');if(goto){go(goto.dataset.go,goto.dataset.goItem||null);return;}
 const g=t.closest('#svg-stage [data-node],#demo-svg-stage [data-node],#svg-stage [data-edge],#demo-svg-stage [data-edge]');if(g){select(g.dataset.node||g.dataset.edge);return;}
 const step=t.closest('[data-step]');if(step){go('demo',null,Number(step.dataset.step));return;}
 const filter=t.closest('[data-filter]');if(filter){state.filter=filter.dataset.filter;renderExtra();return;}
 if(t.closest('#demo-prev'))go('demo',null,Math.max(0,state.step-1));
 if(t.closest('#demo-next'))go('demo',null,Math.min(model.demo.length-1,state.step+1));
 if(t.closest('#demo-reset'))go('demo',null,0);
 if(t.closest('#navigation a'))sidebar(false);
});
document.addEventListener('keydown',ev=>{
 if(ev.key==='/'&&!['INPUT','TEXTAREA'].includes(document.activeElement?.tagName)){ev.preventDefault();sidebar(true);$('search').focus();}
 if(ev.key==='Escape'){if($('help-dialog').open)$('help-dialog').close();else if(state.item)go(state.view,null,state.step);else sidebar(false);$('search-results').hidden=true;}
 if((ev.key==='Enter'||ev.key===' ')&&ev.target.matches('[data-node],[data-edge]')&&ev.target.closest('#svg-stage,#demo-svg-stage')){ev.preventDefault();select(ev.target.dataset.node||ev.target.dataset.edge);}
});
$('search').addEventListener('input',ev=>search(ev.target.value));
$('menu-btn').onclick=()=>sidebar(!$('sidebar').classList.contains('open'));
$('help-btn').onclick=()=>$('help-dialog').showModal();$('close-help').onclick=()=>$('help-dialog').close();
$('help-dialog').addEventListener('click',ev=>{if(ev.target===$('help-dialog')){const r=$('help-dialog').getBoundingClientRect();if(ev.clientX<r.left||ev.clientX>r.right||ev.clientY<r.top||ev.clientY>r.bottom)$('help-dialog').close();}});
$('print-btn').onclick=()=>window.print();
$('close-inspector').onclick=$('clear-btn').onclick=()=>go(state.view,null,state.step);
$('map-btn').onclick=()=>setMode('map');$('list-btn').onclick=()=>setMode('list');
$('plus-btn').onclick=()=>{state.scale=Math.min(2.4,state.scale+.15);scaleGraph();};$('minus-btn').onclick=()=>{state.scale=Math.max(.45,state.scale-.15);scaleGraph();};$('fit-btn').onclick=()=>fitGraph();
$('svg-btn').onclick=()=>{const v=activeGraph?.view||state.view;if(svgs[v]){download(svgs[v],'image/svg+xml','SOUL_Atlas_'+v+'_v0_1.svg');toast('Seçili harita SVG olarak hazırlandı.');}};
$('json-btn').onclick=()=>{download(JSON.stringify(model,null,2),'application/json','SOUL_Atlas_Model_v0_1.json');toast('Düzenlenebilir model JSON olarak hazırlandı.');};
$('questions-shortcut').onclick=()=>go('questions');
window.addEventListener('hashchange',readHash);
let resizeTimer;window.addEventListener('resize',()=>{clearTimeout(resizeTimer);resizeTimer=setTimeout(()=>{if(activeGraph)fitGraph();},180);});
window.ATLAS={model,state,version:'0.1'};
readHash();
})();
