#!/usr/bin/env node
'use strict';
// E02: exact upstream helper, synthetic in-memory store; never invokes a provider.
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const EXPECTED_BLOB = 'c82a26196432b1cc0a95aee023354fe285c9bbdd';
const PIN = '8321021c54d670126ce3b2969d5deb880b4b0c2a';
function gitBlob(bytes) {
  return crypto.createHash('sha1').update(`blob ${bytes.length}\0`).update(bytes).digest('hex');
}
function clone(value) { return structuredClone(value); }
function card(id, overrides = {}) {
  return { id, source: 'manual', title: id, status: 'open', priority: 'normal',
    owner: null, sessionId: null, metadata: {}, ...overrides };
}
function fakeStore(input) {
  const rows = clone(input), calls = [], writes = [];
  return {
    calls, writes,
    // Input order represents newest-first rows; this double does not implement SQL.
    listWorkItems({limit}) {
      calls.push({method:'listWorkItems', limit});
      return {items:clone(rows.slice(0,limit)), totalCount:rows.length};
    },
    getWorkItemById(id) {
      calls.push({method:'getWorkItemById',id});
      return clone(rows.find(row => row.id === id) || null);
    },
    upsertWorkItem(item) {
      const index = rows.findIndex(row => row.id === item.id);
      if (index < 0) rows.push(clone(item)); else rows[index] = clone(item);
      writes.push(clone(item)); return clone(item);
    }
  };
}
function main() {
  const sourcePath = process.argv[2];
  if (!sourcePath) throw new Error('Usage: node run-probe.js <exact upstream work-item-mutations.js> [results.json]');
  const absoluteSource = path.resolve(sourcePath), bytes = fs.readFileSync(absoluteSource);
  const actualBlob = gitBlob(bytes);
  assert.equal(actualBlob, EXPECTED_BLOB, 'Refusing to execute source bytes that differ from the pinned Git blob.');
  const helper = require(absoluteSource), cases = [];
  function run(id, execute, check) {
    let observation;
    try {
      observation = execute(); check(observation);
      cases.push({id, criterionMatched:true, observation});
    } catch (error) {
      cases.push({id, criterionMatched:false, observation:observation ?? null,
        error:{name:error.name,message:error.message}});
    }
  }
  function claim(input, options) {
    const store = fakeStore(input);
    const result = helper.claimWorkItem(store, options);
    return {result,calls:store.calls,writes:store.writes};
  }
  run('C0', () => claim([card('open-card')], {owner:'worker-a',assigneeKind:'agent'}), o => {
    assert.equal(o.result.item.owner,'worker-a'); assert.equal(o.result.item.status,'running');
    assert.equal(o.writes.length,1);
  });
  run('C1', () => claim([
    card('ready-card'),
    card('blocked-card',{status:'blocked',priority:'high',metadata:{blockedBy:['unfinished-prerequisite']}})
  ], {owner:'worker-a'}), o => {
    assert.equal(o.result.item.id,'blocked-card'); assert.equal(o.result.item.status,'running');
    assert.deepEqual(o.result.item.metadata.blockedBy,['unfinished-prerequisite']);
  });
  run('C2', () => claim([card('assigned-card',{owner:'alice',status:'running',sessionId:'prior-session'})],
    {id:'assigned-card',owner:'bob'}), o => {
    assert.equal(o.result.item.owner,'bob'); assert.equal(o.result.item.sessionId,'prior-session');
    assert.equal(o.writes.length,1);
  });
  run('C3', () => {
    const store = fakeStore([card('done-card',{status:'done'})]); let error = null;
    try {helper.claimWorkItem(store,{id:'done-card',owner:'bob'});} catch(e) {error=e.message;}
    return {error,calls:store.calls,writes:store.writes};
  }, o => { assert.match(o.error,/already done/); assert.equal(o.writes.length,0); });
  run('C4', () => {
    const store = fakeStore([card('done-card',{status:'done',owner:'alice',sessionId:'prior-session'})]);
    const result=helper.moveWorkItem(store,{id:'done-card',lane:'ready'});
    return {result,calls:store.calls,writes:store.writes};
  }, o => {
    assert.equal(o.result.item.status,'open'); assert.equal(o.result.item.owner,'alice');
    assert.equal(o.result.item.sessionId,'prior-session');
  });
  run('C5', () => claim([
    ...Array.from({length:100},(_,i) => card(`recent-${i}`,{priority:'low'})),
    card('older-critical',{priority:'critical'})
  ],{owner:'worker-a'}), o => {
    assert.equal(o.calls.find(c => c.method==='listWorkItems').limit,100);
    assert.notEqual(o.result.item.id,'older-critical'); assert.equal(o.result.item.priority,'low');
  });
  const result = {
    id:'E02', target:`affaan-m/ECC@${PIN}`, sourcePath:'scripts/lib/control-pane/work-item-mutations.js',
    sourceBlob:actualBlob, sourceBytes:bytes.length,
    generatedAt:new Date().toISOString(),
    environment:{node:process.version,platform:process.platform,arch:process.arch,osRelease:os.release()},
    executionClass:'LOCAL EXECUTION: unchanged helper plus in-memory store double',
    criteriaMatched:cases.filter(c => c.criterionMatched).length,
    cases,
    limits:'Not a CLI/SQLite/provider/host run; not a concurrent claim or authentication test. Criteria matches describe observed semantics, not overall safety or efficacy.'
  };
  const output=JSON.stringify(result,null,2)+'\n';
  if(process.argv[3]) fs.writeFileSync(path.resolve(process.argv[3]),output);
  process.stdout.write(output);
  process.exitCode=cases.some(c => !c.criterionMatched) ? 1 : 0;
}
try {main();} catch(error) {console.error(error.stack || error.message); process.exitCode=1;}
