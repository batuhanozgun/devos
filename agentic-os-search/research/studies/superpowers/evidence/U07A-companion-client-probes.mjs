/** Source-informed exploration of the exact pinned helper.js.
 * No browser, live socket, server, model or external service is invoked.
 * Usage: node U07A-companion-client-probes.mjs /path/to/helper.js [output.json]
 */
import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { readFileSync, writeFileSync } from 'node:fs';
import vm from 'node:vm';

const EXPECTED = 'e11d26489ce248f37af3e4dd01ddec6a4e88287f';
const sourcePath = process.argv[2];
if (!sourcePath) throw new Error('Usage: node probes.mjs /path/to/pinned/helper.js [output.json]');
const bytes = readFileSync(sourcePath);
const actual = createHash('sha1').update(`blob ${bytes.length}\0`).update(bytes).digest('hex');
assert.equal(actual, EXPECTED, 'Source must match the pinned Git blob before execution');
const source = bytes.toString('utf8');

function environment({ key = 'synthetic-session-key', multi = false } = {}) {
  const state = { now: 1000, timers: [], trace: [], appended: [], click: null };
  const sockets = [];
  const options = [];
  const status = { textContent: '', style: { setProperty() {} } };
  const parent = { dataset: multi ? { multiselect: '' } : {}, querySelectorAll: () => options };
  class WS {
    static OPEN = 1;
    constructor(url) { this.url = url; this.readyState = 0; this.sent = []; sockets.push(this); }
    open() { this.readyState = 1; this.onopen?.(); }
    close() { this.readyState = 3; this.onclose?.(); }
    send(text) {
      assert.equal(this.readyState, 1, 'fixture transport must be open');
      const event = JSON.parse(text);
      this.sent.push(event); state.trace.push({ kind: 'send', event });
    }
  }
  const window = {
    location: { host: 'localhost:7777', reload() { state.trace.push({ kind: 'reload' }); },
      replace(url) { state.trace.push({ kind: 'replace', url }); } },
    sessionStorage: { getItem: name => name === 'brainstorm-session-key' ? key : null }
  };
  const env = {
    window, WebSocket: WS, module: { exports: {} }, Date: { now: () => state.now }, console,
    document: {
      querySelector: s => s === '.status' ? status : null,
      addEventListener: (name, fn) => { if (name === 'click') state.click = fn; },
      createElement: () => ({ style: {}, id: '', innerHTML: '' }),
      body: { appendChild: element => state.appended.push(element) }
    },
    setTimeout(fn, ms) { const t = { fn, ms, fired: false, cleared: false }; state.timers.push(t); return t; },
    clearTimeout(t) { if (t) t.cleared = true; }
  };
  vm.runInNewContext(source, env, { filename: 'pinned/helper.js', timeout: 1000 });
  function option(choice = 'a', text = 'Layout A') {
    const classes = new Set();
    const element = {
      dataset: { choice }, textContent: text, id: '',
      classList: { add: c => classes.add(c), remove: c => classes.delete(c),
        toggle(c) { if (classes.has(c)) classes.delete(c); else classes.add(c); } },
      closest(s) { return s === '[data-choice]' ? element : s === '.options' ? parent : null; },
      isSelected: () => classes.has('selected')
    };
    options.push(element); return element;
  }
  return { state, sockets, status, window, pure: env.module.exports, option,
    last: () => sockets.at(-1),
    click(element) { window.toggleSelect(element); state.click({ target: element }); },
    reconnect() {
      const timer = state.timers.findLast(t => !t.fired && !t.cleared);
      assert.ok(timer, 'a reconnect must have been scheduled'); timer.fired = true; timer.fn();
    }
  };
}

const cases = [];
function observe(id, name, fn) {
  try { cases.push({ id, name, observation_verified: true, ...fn() }); }
  catch (error) { cases.push({ id, name, observation_verified: false, error: String(error.stack ?? error) }); }
}
const withoutTimestamp = ({ timestamp, ...rest }) => rest;

observe('C01', 'Configured-key and cookie-only URL controls', () => {
  const keyed = environment(); const noKey = environment({ key: null });
  assert.equal(keyed.last().url, 'ws://localhost:7777/?key=synthetic-session-key');
  assert.equal(noKey.last().url, 'ws://localhost:7777');
  return { classification: 'positive_control', keyed_url: keyed.last().url, cookie_only_url: noKey.last().url,
    limit: 'URL construction only; no cookie, authentication or server handshake tested.' };
});
observe('C02', 'Normal click captures choice, id, text and synthetic timestamp', () => {
  const e = environment(); e.last().open(); e.click(e.option());
  const event = e.last().sent[0];
  assert.deepEqual(event, { type: 'click', text: 'Layout A', choice: 'a', id: null, timestamp: 1000 });
  return { classification: 'positive_control', event };
});
observe('C03', 'Explicit choice API lacks the server persistence field by default', () => {
  const e = environment(); e.last().open(); e.window.brainstorm.choice('a');
  const event = e.last().sent[0];
  assert.equal(event.type, 'choice'); assert.equal(event.value, 'a'); assert.equal(Object.hasOwn(event, 'choice'), false);
  e.window.brainstorm.choice('a', { choice: 'a' });
  assert.equal(e.last().sent[1].choice, 'a');
  return { classification: 'cross_surface_criterion', event,
    criterion: 'Default explicit choice output supplies the truthy choice field required by inspected server handleMessage.',
    criterion_met: false, metadata_control: e.last().sent[1],
    limit: 'Client output executed; server append predicate inspected as source, not executed.' };
});
observe('C04', 'Multiselect deselection still emits the same last choice', () => {
  const e = environment({ multi: true }); e.last().open(); const a = e.option();
  e.click(a); assert.equal(a.isSelected(), true);
  e.state.now = 1100; e.click(a); assert.equal(a.isSelected(), false);
  assert.deepEqual(withoutTimestamp(e.last().sent[0]), withoutTimestamp(e.last().sent[1]));
  assert.equal(e.window.selectedChoice, 'a');
  return { classification: 'overstrong_inference_challenge', events: e.last().sent, selected_after: a.isSelected(),
    selectedChoice_after: e.window.selectedChoice,
    criterion: 'The latest click/selectedChoice alone determines the final selected set for multiselect.',
    criterion_met: false, limit: 'The guide makes terminal feedback primary; this is not an upstream universal approval promise.' };
});
observe('C05', 'Queued old-screen event flushes before recovery reload without a screen binding', () => {
  const e = environment(); e.last().open(); e.last().close();
  e.state.now = 2000; e.click(e.option('a', 'Old layout A'));
  assert.equal(e.last().sent.length, 0);
  e.state.now = 22000; e.reconnect(); e.last().close(); assert.equal(e.state.appended.length, 1);
  e.reconnect(); e.last().open();
  assert.deepEqual(e.state.trace.map(x => x.kind), ['send', 'replace']);
  const event = e.last().sent[0]; assert.equal(event.timestamp, 2000);
  assert.equal(Object.hasOwn(event, 'screen'), false); assert.equal(Object.hasOwn(event, 'session'), false);
  return { classification: 'scope_observation', trace: e.state.trace,
    limit: 'Mock transport reconnection, not a real cross-session server replay or wrong approval incident.' };
});
observe('C06', 'Brief reconnect does not force a content reload', () => {
  const e = environment(); e.last().open(); e.last().close();
  e.state.now += 500; e.reconnect(); e.last().open();
  assert.deepEqual(e.state.trace, []); assert.equal(e.status.textContent, 'Connected');
  return { classification: 'scope_observation', trace: e.state.trace, status: e.status.textContent,
    limit: 'No server reload message injected; this does not test fs.watch delivery in a real runtime.' };
});
observe('C07', 'Unsent queue is memory-local, not restored into a new client', () => {
  const oldClient = environment(); oldClient.click(oldClient.option());
  const newClient = environment(); newClient.last().open(); assert.equal(newClient.last().sent.length, 0);
  oldClient.last().open(); assert.equal(oldClient.last().sent.length, 1);
  return { classification: 'scope_observation', old_client_pending_sends: oldClient.last().sent.length,
    new_client_sends: newClient.last().sent.length, limit: 'Fresh VM models a new helper instance, not a browser storage durability test.' };
});
observe('C08', 'Reconnect backoff reaches its cap', () => {
  const e = environment(); const values = [e.pure.MIN_RECONNECT_MS];
  for (let i = 0; i < 8; i++) values.push(e.pure.nextReconnectDelay(values.at(-1), e.pure.MAX_RECONNECT_MS));
  assert.deepEqual(values, [500, 1000, 2000, 4000, 8000, 16000, 30000, 30000, 30000]);
  return { classification: 'positive_control', delay_sequence_ms: values };
});
observe('C09', 'Control rejects an invented selected set inferred from last click', () => {
  const e = environment({ multi: true }); e.last().open(); const a = e.option();
  e.click(a); e.click(a);
  assert.throws(() => assert.equal(a.isSelected(), Boolean(e.window.selectedChoice)), assert.AssertionError);
  return { classification: 'negative_control', incorrect_last_click_oracle_rejected: true };
});

const result = {
  experiment: 'U07A / E13 runner / E14 output', evidence_class: 'source-informed exploratory mocked-client execution',
  primary_commit: 'b36e0829c6d0140e93cfef2ca599b1b07d4a7797',
  source: { path: 'skills/brainstorming/scripts/helper.js', git_blob: actual, bytes: bytes.length },
  environment: { node: process.version, platform: process.platform, arch: process.arch,
    clock: 'synthetic milliseconds', transport: 'in-memory fake WebSocket', dom: 'minimal fake DOM' },
  limitations: ['No browser or real WebSocket/HTTP server', 'No host/model, filesystem watcher, security or efficacy test',
    'No external requests, credentials, installation or upstream test suite', 'Prior E01-E12 not rerun',
    'Criteria selected after source reading and before this execution; not preregistered independent replication'],
  counts: { scenarios: cases.length, unexpected_observation_failures: cases.filter(c => !c.observation_verified).length,
    unmet_explicit_criteria: cases.filter(c => c.criterion_met === false).length },
  cases
};
const output = JSON.stringify(result, null, 2) + '\n';
if (process.argv[3]) writeFileSync(process.argv[3], output);
process.stdout.write(output);
if (result.counts.unexpected_observation_failures) process.exitCode = 1;
