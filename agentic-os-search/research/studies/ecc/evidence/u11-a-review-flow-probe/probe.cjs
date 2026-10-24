'use strict';
// E08: deterministic adapter for one pinned workflow; no native host or provider.
const fs = require('node:fs');
const crypto = require('node:crypto');
const assert = require('node:assert/strict');
const os = require('node:os');
const expected = '3fd502da40d77c46c28e0ed8b6845bb0072393ef';
const sourcePath = process.argv[2];
if (!sourcePath) throw new Error('Usage: node probe.cjs <pinned-orch-review.workflow.js>');
const bytes = fs.readFileSync(sourcePath);
const gitBlob = crypto.createHash('sha1').update(Buffer.concat([Buffer.from(`blob ${bytes.length}\0`), bytes])).digest('hex');
assert.equal(gitBlob, expected, 'Do not run an unverified source body');
const source = bytes.toString('utf8');
assert.ok(source.startsWith('export const meta = '));
const adapted = source.replace(/^export const meta = /, 'const meta = ');
const AsyncFunction = Object.getPrototypeOf(async function() {}).constructor;
const execute = new AsyncFunction('args', 'agent', 'parallel', 'log', adapted);
const clone = x => JSON.parse(JSON.stringify(x));
const baseInput = {diff: 'diff --git a/src/format.ts b/src/format.ts\n--- a/src/format.ts\n+++ b/src/format.ts\n@@ -1 +1 @@\n-format(value);\n+format(value, width);', language: 'typescript', changedFiles: ['src/format.ts']};
const medium = {title: 'Style concern', severity: 'MEDIUM', file: 'src/format.ts', line: 10, evidence: 'format(value, width);'};
const critical = {...medium, title: 'Distinct critical failure', severity: 'CRITICAL', proof: 'STRONG_PROOF: supplied trigger-state-outcome evidence', fix: 'preserve the validated width'};
const clean = {verdict: 'APPROVE', findings: []};
const review = findings => ({verdict: 'CHANGES_REQUESTED', findings});
const trueHigh = {isReal: true, confidence: 0.95, reasoning: 'stipulated confirmation'};
const falseHigh = {isReal: false, confidence: 0.95, reasoning: 'stipulated refutation'};
const results = [];
async function run(name, config = {}) {
  const calls = []; const logs = [];
  const input = clone(config.input ?? baseInput);
  const replies = config.reviews ?? {quality: clean, 'lang:typescript': clean};
  const agent = (prompt, opts) => {
    const record = {prompt, options: opts}; calls.push(record);
    let response;
    if (opts.phase === 'Review') {
      response = replies[opts.label.slice('review:'.length)] ?? clean;
      // Null is a deliberate distinct supplied terminal failure.
      if (Object.hasOwn(replies, opts.label.slice(7))) response = replies[opts.label.slice(7)];
    } else response = typeof config.verifier === 'function' ? config.verifier(prompt) : (config.verifier === undefined ? trueHigh : config.verifier);
    if (response && response.__reject) {
      record.supplied_error = response.__reject;
      return Promise.reject(new Error(response.__reject));
    }
    record.supplied_response = clone(response);
    return Promise.resolve(clone(response));
  };
  const parallel = thunks => Promise.all(thunks.map(fn => fn()));
  let outcome, error;
  try {outcome = await execute(input, agent, parallel, message => logs.push(message));}
  catch (e) {error = {name: e.name, message: e.message};}
  const entry = {name, input, calls, logs, outcome: outcome ?? null, error: error ?? null};
  results.push(entry); return entry;
}
(async () => {
  let r = await run('clean_selected_dimensions');
  assert.equal(r.outcome.verdict, 'APPROVE');
  r = await run('reviewer_null', {reviews: {quality: null}});
  assert.equal(r.outcome.incomplete, true); assert.equal(r.outcome.verdict, 'CHANGES_REQUESTED');
  r = await run('reviewer_rejection', {reviews: {quality: {__reject: 'fixture reviewer failure'}}});
  assert.equal(r.outcome.failedDimensions.length, 1);
  for (const [name, verifier, field] of [
    ['verifier_null', null, 'unverified'],
    ['verifier_error', {__reject: 'fixture verifier failure'}, 'unverified'],
    ['verifier_low_false', {isReal: false, confidence: 0.2, reasoning: 'stipulated uncertainty'}, 'uncertain'],
    ['verifier_low_true', {isReal: true, confidence: 0.2, reasoning: 'stipulated uncertainty'}, 'confirmed'],
  ]) {
    r = await run(name, {reviews: {quality: review([critical])}, verifier});
    assert.equal(r.outcome.verdict, 'CHANGES_REQUESTED'); assert.equal(r.outcome.stats[field], 1);
  }
  r = await run('verifier_confident_false', {reviews: {quality: review([critical])}, verifier: falseHigh});
  assert.equal(r.outcome.verdict, 'APPROVE'); assert.equal(r.outcome.stats.refuted, 1);
  const byProof = prompt => prompt.includes(critical.proof) ? trueHigh : falseHigh;
  r = await run('medium_then_critical_same_evidence', {reviews: {quality: review([medium]), 'lang:typescript': review([critical])}, verifier: byProof});
  assert.equal(r.outcome.stats.unique, 1);
  assert.equal(r.outcome.advisory[0].severity, 'CRITICAL');
  assert.equal(r.outcome.advisory[0].title, medium.title);
  assert.equal(Object.hasOwn(r.outcome.advisory[0], 'proof'), false);
  assert.equal(r.outcome.verdict, 'APPROVE');
  r = await run('critical_then_medium_same_evidence', {reviews: {quality: review([critical]), 'lang:typescript': review([medium])}, verifier: byProof});
  assert.equal(r.outcome.blocking[0].proof, critical.proof); assert.equal(r.outcome.verdict, 'CHANGES_REQUESTED');
  r = await run('distinct_evidence_preserved', {reviews: {quality: review([medium]), 'lang:typescript': review([{...critical, evidence: 'format(other, width);'}])}, verifier: byProof});
  assert.equal(r.outcome.stats.unique, 2); assert.equal(r.outcome.verdict, 'CHANGES_REQUESTED');
  r = await run('different_file_preserved', {reviews: {quality: review([medium]), 'lang:typescript': review([{...critical, file: 'src/other.ts'}])}, verifier: byProof});
  assert.equal(r.outcome.stats.unique, 2);
  r = await run('same_snippet_different_locations', {reviews: {quality: review([critical, {...critical, line: 70, title: 'Another site'}])}});
  assert.equal(r.outcome.stats.raw, 2); assert.equal(r.outcome.stats.unique, 1);
  r = await run('reviewer_negative_verdict_empty_findings', {reviews: {quality: review([])}});
  assert.equal(r.outcome.verdict, 'APPROVE');
  r = await run('nonempty_not_a_diff', {input: {diff: 'plain non-diff fixture', changedFiles: ['src/format.ts']}});
  assert.equal(r.outcome.verdict, 'APPROVE'); assert.equal(r.outcome.stats.dimensions, 1);
  r = await run('security_path_selects_extra_dimension', {input: {...baseInput, changedFiles: ['src/auth.ts']}});
  assert.equal(r.outcome.stats.dimensions, 3);
  for (const [name, input] of [['empty_diff', {...baseInput, diff: ''}], ['malformed_paths', {...baseInput, changedFiles: [{path: 'src/a.ts'}]}]]) {
    r = await run(name, {input}); assert.ok(r.error); assert.equal(r.calls.length, 0);
  }
  const report = {experiment: 'E08', precheck_commit: '6f248ca8b42914a1c3a0a50904a72736bd5373d8', source: {repository: 'affaan-m/ECC', ref: '8321021c54d670126ce3b2969d5deb880b4b0c2a', path: 'workflows/orch-review.workflow.js', git_blob: gitBlob, bytes: bytes.length, sha256: crypto.createHash('sha256').update(bytes).digest('hex')}, environment: {node: process.version, platform: process.platform, arch: process.arch, os_release: os.release()}, adapter: 'export-to-const + AsyncFunction; Promise.all thunks; supplied agent replies only; no native host', scenario_count: results.length, assertions_completed: true, scenarios: results};
  process.stdout.write(JSON.stringify(report, null, 2) + '\n');
})().catch(error => {
  process.stdout.write(JSON.stringify({experiment: 'E08', assertions_completed: false, error: {name:error.name, message:error.message}, scenarios:results}, null, 2) + '\n');
  process.exitCode = 1;
});
