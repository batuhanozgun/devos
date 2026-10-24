#!/usr/bin/env python3
"""E03: exact-source wrapper/collector probe; no real Codex or tmux invocation."""
from __future__ import annotations
import argparse, hashlib, json, os, pathlib, platform, shutil, subprocess, sys, tempfile
from datetime import datetime, timezone

PIN = "8321021c54d670126ce3b2969d5deb880b4b0c2a"
SOURCES = {
    "scripts/orchestrate-codex-worker.sh": "d73ad0cf26efb49cf5d177fadc651a7ba9ae182d",
    "scripts/lib/orchestration-session.js": "9449020fcf7b7233edb581e77ff4bde5d749cf49",
}

def git_blob(data: bytes) -> str:
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()

def run(args: list[str], cwd: pathlib.Path, env: dict[str,str], **kwargs) -> subprocess.CompletedProcess:
    return subprocess.run(args, cwd=cwd, env=env, text=True, capture_output=True, timeout=20, **kwargs)

def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-root", required=True, type=pathlib.Path)
    parser.add_argument("--output", required=True, type=pathlib.Path)
    options = parser.parse_args()
    root = options.source_root.resolve()
    source_meta = []
    for relative, expected in SOURCES.items():
        data = (root / relative).read_bytes()
        actual = git_blob(data)
        if actual != expected:
            raise ValueError(f"Source mismatch at {relative}: {actual} != {expected}")
        source_meta.append({"path":relative,"gitBlob":actual,"bytes":len(data)})
    plan_path = pathlib.Path(__file__).with_name("PROBE-PLAN.json")
    plan_bytes = plan_path.read_bytes()
    plan_sha = hashlib.sha256(plan_bytes).hexdigest()
    node, git, bash = (shutil.which(command) for command in ("node","git","bash"))
    if not all((node,git,bash)):
        raise RuntimeError("Node, Git and Bash must be available")
    structured_good = "## Summary\n- Synthetic task complete.\n\n## Files Changed\n- None.\n\n## Validation\n- Synthetic verification passed.\n\n## Remaining Risks\n- None reported.\n"
    structured_bad = "## Summary\n- Synthetic task incomplete.\n\n## Files Changed\n- None.\n\n## Validation\n- Verification failed.\n\n## Remaining Risks\n- Work remains blocked.\n"
    prose = "1. Summary\nThe synthetic task remains incomplete.\n2. Files Changed\nNone.\n3. Validation\nVerification failed.\n4. Remaining Risks\nWork remains blocked.\n"
    specifications = [("C0",0,structured_good,False),("C1",0,structured_bad,False),
                      ("C2",0,prose,False),("C3",7,"PARTIAL OUTPUT SENTINEL\n",False),
                      ("C4",0,structured_good,True)]
    observations = []
    with tempfile.TemporaryDirectory(prefix="ecc-e03-") as directory:
        fixture = pathlib.Path(directory)
        repo, home, temp, binaries = (fixture / name for name in ("repo","home","tmp","bin"))
        for path in (repo,home,temp,binaries): path.mkdir()
        fake = binaries / "codex"
        fake.write_text(f"#!{sys.executable}\n" + '''import json, os, pathlib, sys
args = sys.argv[1:]
prompt = sys.stdin.read()
pathlib.Path(os.environ["FAKE_LOG"]).write_text(json.dumps({"args":args,"prompt":prompt}))
output = args[args.index("-o")+1]
pathlib.Path(output).write_text(os.environ["FAKE_OUTPUT"])
if int(os.environ["FAKE_EXIT"]):
    print("SYNTHETIC PROVIDER DIAGNOSTIC", file=sys.stderr)
sys.exit(int(os.environ["FAKE_EXIT"]))
''')
        fake.chmod(0o700)
        env = {"PATH":f"{binaries}:/usr/bin:/bin","HOME":str(home),"USERPROFILE":str(home),
               "TMPDIR":str(temp),"LC_ALL":"C","GIT_CONFIG_NOSYSTEM":"1","GIT_CONFIG_GLOBAL":os.devnull}
        for args in ([git,"init","-q"], [git,"-c","user.name=Fixture","-c","user.email=fixture@example.invalid","commit","--allow-empty","-qm","fixture"]):
            result = run(args,repo,env)
            if result.returncode: raise RuntimeError(result.stderr)
        for case_id, exit_code, output, missing in specifications:
            coordination = fixture / case_id
            worker = coordination / "worker"
            worker.mkdir(parents=True)
            task, handoff, status, log = (worker / name for name in ("task.md","handoff.md","status.md","fake-log.json"))
            if not missing: task.write_text("# Synthetic Task\n\n## Objective\nDemonstrate wrapper boundaries.\n")
            case_env = {**env,"FAKE_EXIT":str(exit_code),"FAKE_OUTPUT":output,"FAKE_LOG":str(log)}
            command = [bash,str(root/"scripts/orchestrate-codex-worker.sh"),str(task),str(handoff),str(status)]
            process = run(command,repo,case_env)
            extraction = run([node,"-e","const c=require(process.argv[1]); process.stdout.write(JSON.stringify(c.loadWorkerSnapshots(process.argv[2])));",
                              str(root/"scripts/lib/orchestration-session.js"),str(coordination)],repo,env)
            if extraction.returncode: raise RuntimeError(extraction.stderr)
            snapshot = json.loads(extraction.stdout)[0]
            raw_handoff, raw_status = handoff.read_text(), status.read_text()
            parsed = snapshot["handoff"]
            invoked = log.exists()
            common = snapshot["status"]["state"] == ("failed" if case_id in ("C3","C4") else "completed")
            expected_exit = 1 if case_id in ("C3","C4") else 0
            if case_id == "C0": extra = parsed["validation"] == ["Synthetic verification passed."]
            elif case_id == "C1": extra = parsed["validation"] == ["Verification failed."] and parsed["remainingRisks"] == ["Work remains blocked."]
            elif case_id == "C2": extra = all(not value for value in parsed.values()) and prose in raw_handoff
            elif case_id == "C3": extra = "PARTIAL OUTPUT SENTINEL" not in raw_handoff and "SYNTHETIC PROVIDER DIAGNOSTIC" in process.stderr
            else: extra = not invoked and "missing or unreadable" in raw_handoff
            observations.append({"id":case_id,"criterionMatched":bool(common and process.returncode==expected_exit and extra),
              "input":{"fakeExit":exit_code,"fakeOutput":output,"missingTask":missing},
              "command":command,"wrapperExit":process.returncode,"stdout":process.stdout,"stderr":process.stderr,
              "fakeInvoked":invoked,"fakeCall":json.loads(log.read_text()) if invoked else None,
              "rawStatus":raw_status,"rawHandoff":raw_handoff,"parsedStatus":snapshot["status"],"parsedHandoff":parsed,
              "tempFilesAfterWrapper":sorted(p.name for p in temp.iterdir())})
        versions = {"python":platform.python_version(),"node":run([node,"--version"],repo,env).stdout.strip(),
                    "git":run([git,"--version"],repo,env).stdout.strip(),"bash":run([bash,"--version"],repo,env).stdout.splitlines()[0],
                    "platform":platform.platform()}
    result = {"id":"E03","target":f"affaan-m/ECC@{PIN}","generatedAt":datetime.now(timezone.utc).isoformat(),
              "sources":source_meta,"planSha256":plan_sha,"planUnchanged":plan_path.read_bytes()==plan_bytes,
              "environment":versions,"evidenceClass":"Unchanged Bash/Node local execution with fake provider, not model/host behavior",
              "criteriaMatched":sum(item["criterionMatched"] for item in observations),"cases":observations,
              "limits":"No real Codex/model/tmux, SQL, installed ECC, network, process-concurrency or task-quality evaluation. Temporary paths in raw results are historical, not reusable references."}
    options.output.write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({"criteriaMatched":result["criteriaMatched"],"caseCount":len(observations),"planUnchanged":result["planUnchanged"],"sources":source_meta}))
    if not result["planUnchanged"] or not all(item["criterionMatched"] for item in observations): sys.exit(1)
if __name__ == "__main__": main()
