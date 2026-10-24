#!/usr/bin/env node
'use strict';
// Isolated decision-chain probe; never applies an agent's proposed edit.
const fs = require('fs');
const os = require('os');
const path = require('path');
const crypto = require('crypto');
const {spawnSync} = require('child_process');
const root = path.resolve(process.argv[2] || '');
const expectedBlobs = {
  'scripts/hooks/config-protection.js': '2da5358c2f2e7711194580df96241cf9d55d1979',
  'scripts/hooks/run-with-flags.js': '9f6de372212d5c3ba20502b5e05711431f1a0053',
  'scripts/lib/hook-flags.js': '69d3f25d6ba5d49acdebed943352674f87caa5c3',
  'scripts/hooks/pretooluse-visible-output.js': 'dc48119099f6206e6011174a62ad9912d7af9a25'
};
const hash = data => crypto.createHash('sha256').update(data).digest('hex');
function verifySources() {
  return Object.entries(expectedBlobs).map(([name, expected]) => {
    const data = fs.readFileSync(path.join(root,name));
    const blob = crypto.createHash('sha1').update(`blob ${data.length}\0`).update(data).digest('hex');
    if (blob !== expected) throw new Error(`source mismatch: ${name}: ${blob}`);
    return {name, blob, sha256: hash(data), bytes:data.length};
  });
}
const sourceBefore = verifySources();
const planBytes = fs.readFileSync(path.join(__dirname,'PLAN.md'));
const startedAt = new Date().toISOString();
const tmp = fs.mkdtempSync(path.join(os.tmpdir(),'ecc-u06a-'));
let report;
try {
  const home=path.join(tmp,'home');fs.mkdirSync(home);
  const protectedPath=path.join(tmp,'.eslintrc.js');
  const initial='module.exports = { rules: { "no-console": "warn" } };\n';
  fs.writeFileSync(protectedPath,initial);
  const alias=path.join(tmp,'ordinary-alias.js');fs.symlinkSync(protectedPath,alias);
  const dangling=path.join(tmp,'.prettierrc');fs.symlinkSync(path.join(tmp,'missing-target'),dangling);
  const regularParent=path.join(tmp,'not-a-directory');fs.writeFileSync(regularParent,'fixture\n');
  const managed=path.join(tmp,'managed.json');fs.writeFileSync(managed,JSON.stringify({hooks:{enabled:true,profile:'minimal'}}));
  const aliasIdentity={sameRealpath:fs.realpathSync(alias)===fs.realpathSync(protectedPath),sameInode:fs.statSync(alias).ino===fs.statSync(protectedPath).ino};
  const baseEnv={PATH:process.env.PATH || '/usr/bin:/bin',HOME:home,USERPROFILE:home,CLAUDE_PLUGIN_ROOT:root,ECC_HOOK_PROFILE:'standard',ECC_HOOKS_ENABLED:'true',ECC_HOOK_CONFIG:path.join(tmp,'no-config.json')};
  const payload=(file,content='fixture proposed content')=>JSON.stringify({hook_event_name:'PreToolUse',tool_name:'Write',tool_input:{file_path:file,content}});
  const cases=[
    ['C00',payload(path.join(tmp,'src.js')),0,{}],
    ['C01',payload(protectedPath,initial),2,{}],
    ['C02',payload(protectedPath,'module.exports = { rules: { "no-console": "error" } };\n'),2,{}],
    ['C03',payload(path.join(tmp,'eslint.config.mjs')),0,{}],
    ['C04',payload(dangling),2,{}],
    ['C05',payload(alias),0,{}],
    ['C06',payload(path.join(regularParent,'biome.json')),2,{}],
    ['C07','{"tool_input":',0,{}],
    ['C08',JSON.stringify({tool_name:'Write',tool_input:{file_path:7}}),0,{}],
    ['C09',payload(protectedPath,'x'.repeat(1024*1024+2048)),2,{}],
    ['C10',payload(protectedPath),0,{ECC_HOOK_PROFILE:'minimal'}],
    ['C11',payload(protectedPath),0,{ECC_HOOKS_ENABLED:'false'}],
    ['C12',payload(protectedPath),0,{ECC_DRY_RUN:'1'}],
    ['C13',payload(protectedPath),0,{ECC_HOOK_PROFILE:null,ECC_HOOKS_ENABLED:null,ECC_HOOK_CONFIG:managed}],
    ['C14',payload(protectedPath),2,{ECC_HOOK_PROFILE:'standard',ECC_HOOKS_ENABLED:null,ECC_HOOK_CONFIG:managed}]
  ];
  const outputs=cases.map(([id,input,expectedExit,overrides])=>{
    const env={...baseEnv};for(const [key,value] of Object.entries(overrides)){if(value===null)delete env[key];else env[key]=value;}
    const args=[path.join(root,'scripts/hooks/run-with-flags.js'),'pre:config-protection','scripts/hooks/config-protection.js','standard,strict'];
    const result=spawnSync(process.execPath,args,{cwd:tmp,env,input,encoding:'utf8',timeout:5000,maxBuffer:4*1024*1024});
    const diagnosticsExpected=id==='C08'?'run() error':id==='C09'?'truncated payload':id==='C12'?'[DryRun]':null;
    const matched=!result.error && result.status===expectedExit && (expectedExit!==2 || result.stdout==='') && (!diagnosticsExpected || result.stderr.includes(diagnosticsExpected));
    return {id,input,expectedExit,environmentOverrides:overrides,args,exitCode:result.status,signal:result.signal,error:result.error?result.error.message:null,stdout:result.stdout,stderr:result.stderr,matched};
  });
  const unchanged=fs.readFileSync(protectedPath,'utf8')===initial;
  const noCreation=!fs.existsSync(path.join(tmp,'eslint.config.mjs'))&&!fs.existsSync(path.join(tmp,'src.js'));
  const sourceAfter=verifySources();
  report={pin:'8321021c54d670126ce3b2969d5deb880b4b0c2a',startedAt,finishedAt:new Date().toISOString(),node:process.version,platform:process.platform,planSha256:hash(planBytes),runnerSha256:hash(fs.readFileSync(__filename)),sourceBefore,sourceAfter,baseEnvironment:baseEnv,aliasIdentity,protectedContentUnchanged:unchanged,noProposedFilesCreated:noCreation,cases:outputs,expectationsMatched:outputs.filter(c=>c.matched).length};
  process.exitCode=outputs.every(c=>c.matched)&&unchanged&&noCreation&&aliasIdentity.sameRealpath&&aliasIdentity.sameInode?0:1;
} catch(e) {
  report={startedAt,error:e.stack,sourceBefore};process.exitCode=1;
} finally {
  fs.rmSync(tmp,{recursive:true,force:true});
}
process.stdout.write(JSON.stringify(report,null,2)+'\n');
