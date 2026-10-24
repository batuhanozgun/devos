#!/usr/bin/env node
/** Source-informed exploratory U01-B probes, not a live OpenCode/model evaluation.
 * Usage: node U01B-opencode-probes.mjs /path/to/pinned/superpowers.js
 * Only temporary fixtures are written; no installation, network or credentials.
 * Criteria below are fixed before execution. A recorded health FAIL is not
 * product success; exit 0 only means the probe run completed as specified.
 */
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { pathToFileURL } from 'node:url';
import { createHash } from 'node:crypto';

const PIN = 'b36e0829c6d0140e93cfef2ca599b1b07d4a7797';
const BLOB = '423e5ed513261485c657ba166b0372a5293639c7';
const V1 = 'U01B_BODY_V1_7A6219';
const V2 = 'U01B_BODY_V2_D53B80';
const sourcePath = process.argv[2];
if (!sourcePath) throw new Error('Expected pinned source file path');
const bytes = fs.readFileSync(sourcePath);
const hash = createHash('sha1').update(`blob ${bytes.length}\0`).update(bytes).digest('hex');
if (hash !== BLOB) throw new Error(`Source identity mismatch: ${hash}`);
const root = fs.mkdtempSync(path.join(os.tmpdir(), 'superpowers-u01b-'));
const cases = [];
const record = (id, kind, criterion, met, observed) => cases.push({id, kind, criterion, result: met ? 'PASS' : 'FAIL', observed});
const message = (text = 'Explain the next step') => ({messages: [{info: {role: 'user'}, parts: [{type: 'text', text}]}]});
const text = output => output.messages.flatMap(m => m.parts ?? []).filter(p => p.type === 'text').map(p => p.text).join('\n');
const hasBody = (output, token = V1) => text(output).includes(token);
const body = token => `---\nname: using-superpowers\ndescription: fixture\n---\n${token}\n`;
const transformOf = plugin => plugin['experimental.chat.messages.transform'];

async function fixture(name, skillContent) {
  const dir = path.join(root, name);
  const modulePath = path.join(dir, '.opencode/plugins/superpowers.js');
  const skillPath = path.join(dir, 'skills/using-superpowers/SKILL.md');
  fs.mkdirSync(path.dirname(modulePath), {recursive: true});
  fs.mkdirSync(path.dirname(skillPath), {recursive: true});
  fs.writeFileSync(path.join(dir, 'package.json'), '{"type":"module"}\n');
  fs.writeFileSync(modulePath, bytes);
  if (skillContent !== undefined) fs.writeFileSync(skillPath, skillContent);
  const url = pathToFileURL(modulePath).href;
  const mod = await import(url);
  const plugin = await mod.SuperpowersPlugin({client: {}, directory: dir});
  return {dir, skillPath, url, mod, plugin, transform: transformOf(plugin)};
}

try {
  const normal = await fixture('normal', body(V1));
  const config = {skills: {paths: ['/existing/skills']}};
  await normal.plugin.config(config);
  await normal.plugin.config(config);
  record('config_idempotence', 'mechanism', 'Preserve existing path and register fixture skills exactly once',
    config.skills.paths.length === 2 && config.skills.paths[0] === '/existing/skills' && config.skills.paths[1] === path.join(normal.dir, 'skills'),
    {path_count: config.skills.paths.length, existing_preserved: config.skills.paths[0] === '/existing/skills'});

  const first = message();
  const originalPart = first.messages[0].parts[0];
  await normal.transform({}, first);
  record('first_delivery', 'mechanism', 'Deliver unique fixture body before original user content',
    hasBody(first) && first.messages[0].parts.length === 2 && first.messages[0].parts[1] === originalPart,
    {has_fixture_body: hasBody(first), parts: first.messages[0].parts.length});
  await normal.transform({}, first);
  record('repeat_dedup', 'mechanism', 'Repeated transform of already transformed array does not duplicate bootstrap',
    first.messages[0].parts.length === 2, {parts: first.messages[0].parts.length});

  const fresh = message();
  await normal.transform({}, fresh);
  record('fresh_array_delivery', 'mechanism', 'New eligible message array receives cached body', hasBody(fresh), {has_fixture_body: hasBody(fresh)});

  const collision = message('Explain the token EXTREMELY_IMPORTANT in this document.');
  await normal.transform({}, collision);
  record('marker_collision', 'health-challenge', 'Mere mention of generic marker must not substitute for a delivered bootstrap body',
    hasBody(collision), {has_fixture_body: hasBody(collision), parts: collision.messages[0].parts.length});

  fs.writeFileSync(normal.skillPath, body(V2));
  const edited = message();
  await normal.transform({}, edited);
  record('cached_old_content', 'mechanism', 'Same loaded module retains V1 after file changes to V2',
    hasBody(edited, V1) && !hasBody(edited, V2), {v1_present: hasBody(edited, V1), v2_present: hasBody(edited, V2)});
  const freshMod = await import(normal.url + '?fresh-generation=1');
  const freshPlugin = await freshMod.SuperpowersPlugin({client: {}, directory: normal.dir});
  const reloaded = message();
  await transformOf(freshPlugin)({}, reloaded);
  record('fresh_module_reads_update', 'mechanism', 'Fresh ES module identity reads current V2; not a claim about host session restart',
    hasBody(reloaded, V2) && !hasBody(reloaded, V1), {v1_present: hasBody(reloaded, V1), v2_present: hasBody(reloaded, V2)});

  const missing = await fixture('missing', undefined);
  const before = message();
  await missing.transform({}, before);
  fs.writeFileSync(missing.skillPath, body(V1));
  const secondPlugin = await missing.mod.SuperpowersPlugin({client: {}, directory: missing.dir});
  const restored = message();
  await transformOf(secondPlugin)({}, restored);
  record('missing_result_shared_by_factories', 'mechanism', 'Absent-file result persists after repair and new factory call in the same module',
    !hasBody(before) && !hasBody(restored), {before_has_body: hasBody(before), after_repair_new_factory_has_body: hasBody(restored)});
  const repairedMod = await import(missing.url + '?fresh-generation=1');
  const repairedPlugin = await repairedMod.SuperpowersPlugin({client: {}, directory: missing.dir});
  const repaired = message();
  await transformOf(repairedPlugin)({}, repaired);
  record('fresh_module_reads_repaired_file', 'mechanism', 'Fresh module identity observes repaired file', hasBody(repaired), {has_fixture_body: hasBody(repaired)});

  const empty = await fixture('empty', '');
  const emptyOutput = message();
  await empty.transform({}, emptyOutput);
  record('empty_skill_claims_loaded', 'health-challenge', 'Empty source must not produce a claim that its usable skill body is already loaded',
    !text(emptyOutput).includes('ALREADY LOADED'), {claims_already_loaded: text(emptyOutput).includes('ALREADY LOADED'), parts: emptyOutput.messages[0].parts.length});

  const tagOnly = message('<EXTREMELY_IMPORTANT>unrelated wrapper</EXTREMELY_IMPORTANT>');
  record('oracle_rejects_tag_only', 'oracle-negative-control', 'Body oracle rejects a marker-only output', !hasBody(tagOnly), {oracle_accepts_tag_only: hasBody(tagOnly)});

  const mechanismFailures = cases.filter(c => c.kind === 'mechanism' && c.result === 'FAIL').length;
  const result = {
    study_date: '2026-09-17', upstream_commit: PIN, upstream_blob_sha1: hash,
    source_identity_verified: true, source_bytes: bytes.length,
    environment: {os: os.platform(), arch: os.arch(), node: process.version},
    scope: 'Exact adapter module with temporary synthetic filesystem and manually invoked callbacks; no real host, model, installed package or upstream suite',
    criteria_status: 'Source-informed exploratory, fixed in runner before this run; health criteria are study-defined, not upstream promises',
    cases,
    summary: {
      mechanism_checks_passed: cases.filter(c => c.kind === 'mechanism' && c.result === 'PASS').length,
      mechanism_checks_failed: mechanismFailures,
      health_challenges_failed: cases.filter(c => c.kind === 'health-challenge' && c.result === 'FAIL').length,
      oracle_negative_controls_passed: cases.filter(c => c.kind === 'oracle-negative-control' && c.result === 'PASS').length,
    },
  };
  console.log(JSON.stringify(result, null, 2));
  if (mechanismFailures) process.exitCode = 1;
} finally {
  fs.rmSync(root, {recursive: true, force: true});
}
