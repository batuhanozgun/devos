'use strict';
// Local, data-only probe. Usage: node probe.cjs <exact-ECC-source-root>
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const root = process.argv[2];
if (!root) throw new Error('Provide the exact ECC source root; no automatic acquisition occurs.');
const expected = {
  'health.js': '8aba59861e9bfc4c1e4263f103808c7999632663',
  'amendify.js': 'c95f0e91481b4a20d13107923f502258e7375391',
  'evaluate.js': 'f45023d549b0fc5ad0ac96ac1fef3eb5306bd5d9',
};
function identity() {
  return Object.fromEntries(Object.entries(expected).map(([name, blob]) => {
    const bytes = fs.readFileSync(path.join(root, 'scripts/lib/skill-improvement', name));
    const actual = crypto.createHash('sha1').update(`blob ${bytes.length}\0`).update(bytes).digest('hex');
    assert.equal(actual, blob, `Source identity mismatch: ${name}`);
    return [name, { gitBlob: actual, sha256: crypto.createHash('sha256').update(bytes).digest('hex') }];
  }));
}
const sourceBefore = identity();
const { buildSkillEvaluationScaffold: evaluate } = require(path.resolve(root, 'scripts/lib/skill-improvement/evaluate.js'));
const { proposeSkillAmendment: propose } = require(path.resolve(root, 'scripts/lib/skill-improvement/amendify.js'));
const skill = 'synthetic-review';
function record(id, variant, success, task, amendmentId = null) {
  return {
    schemaVersion: 'ecc.skill-observation.v1', observationId: id,
    timestamp: '2026-09-17T00:00:00.000Z', task,
    skill: { id: skill, path: 'skills/synthetic-review/SKILL.md' },
    outcome: { success, status: success ? 'success' : 'failure', error: success ? null : 'synthetic failure', feedback: null },
    run: { variant, amendmentId, sessionId: 'synthetic-session', source: 'synthetic-E04' },
  };
}
const base = [record('b1', 'baseline', false, 'task-1'), record('b2', 'baseline', true, 'task-2')];
const amended = [record('a1', 'amended', true, 'task-1', 'amend-A'), record('a2', 'amended', true, 'task-2', 'amend-A')];
const results = [];
function check(id, meaning, fn) {
  try { results.push({ id, meaning, expectationMatched: true, ...fn() }); }
  catch (error) { results.push({ id, meaning, expectationMatched: false, error: error.message }); }
}
check('C00', 'No evidence is rejected', () => {
  const evaluation = evaluate(skill, []); const proposal = propose(skill, []);
  assert.equal(evaluation.recommendation, 'insufficient-data');
  assert.equal(proposal.status, 'insufficient-evidence');
  return { input: [], evaluation, proposal };
});
check('C01', 'Actual minimum-count gate', () => {
  const input = [base[0], amended[0]]; const evaluation = evaluate(skill, input);
  assert.equal(evaluation.recommendation, 'insufficient-data');
  return { input, evaluation };
});
check('C02', 'Paired synthetic positive-rate baseline', () => {
  const input = [...base, ...amended]; const evaluation = evaluate(skill, input, { amendmentId: 'amend-A' });
  assert.equal(evaluation.recommendation, 'promote-amendment'); assert.equal(evaluation.delta.successRate, 0.5);
  return { input, evaluation };
});
check('C03', 'Recorded regression is not promoted', () => {
  const input = [record('b1', 'baseline', true, 'task-1'), record('b2', 'baseline', true, 'task-2'),
    record('a1', 'amended', false, 'task-1'), record('a2', 'amended', false, 'task-2')];
  const evaluation = evaluate(skill, input); assert.equal(evaluation.recommendation, 'keep-baseline');
  return { input, evaluation };
});
check('C04', 'Recorded tie keeps baseline', () => {
  const input = [...base, record('a1', 'amended', false, 'task-1'), record('a2', 'amended', true, 'task-2')];
  const evaluation = evaluate(skill, input); assert.equal(evaluation.recommendation, 'keep-baseline');
  return { input, evaluation };
});
check('C05', 'Duplicate observation IDs satisfy count gate', () => {
  const input = [base[0], base[0], amended[0], amended[0]];
  const evaluation = evaluate(skill, input); const uniqueObservationIds = new Set(input.map(r => r.observationId)).size;
  assert.equal(evaluation.baseline.runs, 2); assert.equal(evaluation.amended.runs, 2);
  assert.equal(uniqueObservationIds, 2); assert.equal(evaluation.recommendation, 'promote-amendment');
  return { input, uniqueObservationIds, evaluation };
});
check('C06', 'Unmatched task sets retain positive recommendation', () => {
  const input = [...base, ...amended.map((r, i) => ({ ...r, task: `different-task-labelled-easy-${i}` }))];
  const evaluation = evaluate(skill, input, { amendmentId: 'amend-A' });
  assert.equal(evaluation.recommendation, 'promote-amendment'); assert.equal(evaluation.delta.successRate, 0.5);
  return { input, evaluation, taskDifficultyWasMeasured: false };
});
check('C07', 'Explicit amendment filter is effective but optional', () => {
  const input = [...base, amended[0], { ...amended[1], run: { ...amended[1].run, amendmentId: 'amend-B' } }];
  const unfiltered = evaluate(skill, input); const selected = evaluate(skill, input, { amendmentId: 'amend-A' });
  assert.equal(unfiltered.recommendation, 'promote-amendment'); assert.equal(selected.recommendation, 'insufficient-data');
  return { input, unfiltered, selected };
});
check('C08', 'One failed record produces repeated-failures rationale', () => {
  const input = [base[0]]; const proposal = propose(skill, input); const highThreshold = propose(skill, input, { minFailureCount: 10 });
  assert.equal(proposal.status, 'proposed'); assert.equal(highThreshold.status, 'proposed');
  assert.equal(proposal.evidence.failures, 1); assert.match(proposal.rationale[0], /repeated failed runs/);
  return { input, proposal, highThreshold };
});
assert.deepEqual(identity(), sourceBefore);
const receipt = {
  schemaVersion: 'soul.ecc.e04.receipt.v1', recordedAt: new Date().toISOString(),
  targetPin: '8321021c54d670126ce3b2969d5deb880b4b0c2a', node: process.version, platform: process.platform,
  sourceFiles: sourceBefore, sourcesUnchanged: true,
  planSha256: crypto.createHash('sha256').update(fs.readFileSync(path.join(__dirname, 'PLAN.md'))).digest('hex'),
  probeSha256: crypto.createHash('sha256').update(fs.readFileSync(__filename)).digest('hex'),
  interpretation: 'Synthetic original-helper execution; matches characterize predicates, not validated improvement, causal benefit or host integration.',
  executionScope: 'evaluate, amendify, transitive health only; no upstream tests, tracker, host, model, install or user-state writes',
  expectationsMatched: results.filter(r => r.expectationMatched).length, caseCount: results.length, results,
};
process.stdout.write(JSON.stringify(receipt, null, 2) + '\n');
process.exitCode = results.some(r => !r.expectationMatched) ? 1 : 0;
