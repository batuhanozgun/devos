#!/usr/bin/env python3
"""U05 source-informed lifecycle probes, not execution of an agent skill.
Usage: python3 U05-lifecycle-probes.py /path/to/pinned/sdd-workspace
Only temporary synthetic Git repos are changed. The sole remote is a local
bare repo under the same temporary root: no network, credentials or forge PR.
S32 is executed byte-exact. Git primitives selected from S55 are called with
fixture values; no interpreter of the prose, human approval or live host is
simulated. Criteria are fixed below before execution. A retention FAIL stays
FAIL; runner exit 0 means collection completed, not product qualification.
"""
from __future__ import annotations
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import sys
import tempfile

PIN = "b36e0829c6d0140e93cfef2ca599b1b07d4a7797"
HELPER_BLOB = "4e2d16802ecaa23eb9a682663e4c356c4aa5a656"
FINISH_BLOB = "fa8aecaf8813f1b19d19996f7957d1b0121f2d9c"
TEST = "from pathlib import Path; assert sum(int(Path(f).read_text()) for f in ('a.txt','b.txt')) <= 1, 'combined invariant violated'"


def blob(data: bytes) -> str:
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit(__doc__)
    helper = Path(sys.argv[1]).resolve()
    data = helper.read_bytes()
    if blob(data) != HELPER_BLOB:
        raise SystemExit("Source identity mismatch; nothing executed")
    cases: list[dict] = []
    with tempfile.TemporaryDirectory(prefix="superpowers-u05-") as temp:
        root = Path(temp).resolve()
        home = root / "home"
        home.mkdir()
        env = {k: v for k, v in os.environ.items() if not k.startswith("GIT_")}
        env.update(HOME=str(home), GIT_CONFIG_NOSYSTEM="1",
                   GIT_CONFIG_GLOBAL=os.devnull, GIT_TERMINAL_PROMPT="0",
                   GIT_EDITOR="true", GIT_MERGE_AUTOEDIT="no", LC_ALL="C")
        trace: list[dict] = []

        def norm(text: str) -> str:
            return text.replace(str(root), "<TMP>").replace(str(helper), "<PINNED_S32>")

        def run(cwd: Path, *args: str, check: bool = True, record: bool = False):
            p = subprocess.run(args, cwd=cwd, env=env, text=True,
                               capture_output=True, timeout=20)
            if record:
                trace.append({"cwd": norm(str(cwd)), "argv": [norm(s) for s in args],
                              "exit": p.returncode, "stdout": norm(p.stdout),
                              "stderr": norm(p.stderr)})
            if check and p.returncode:
                raise RuntimeError(f"Unexpected fixture failure: {args}: {p.stderr}")
            return p

        def git(cwd: Path, *args: str, **kw):
            return run(cwd, "git", *args, **kw)

        def repo(name: str) -> Path:
            r = root / name
            r.mkdir()
            git(r, "init", "-q", "-b", "main")
            git(r, "config", "user.name", "U05 synthetic fixture")
            git(r, "config", "user.email", "fixture@example.invalid")
            git(r, "config", "commit.gpgsign", "false")
            (r / ".gitignore").write_text(".worktrees/\nworktrees/\n")
            (r / "plan.md").write_text("# Synthetic plan\n\n## Task 1\nChange a value.\n")
            (r / "a.txt").write_text("0\n")
            (r / "b.txt").write_text("0\n")
            commit(r, "initial")
            return r

        def commit(r: Path, message: str) -> str:
            git(r, "add", "-A")
            git(r, "commit", "-qm", message)
            return git(r, "rev-parse", "HEAD").stdout.strip()

        def worktree(r: Path, external: bool = False, detached: bool = False) -> Path:
            w = (root / (r.name + "-host-owned")) if external else r / ".worktrees" / "feature"
            args = ("--detach",) if detached else ("-b", "feature")
            git(r, "worktree", "add", "-q", *args, str(w), "HEAD")
            return w

        def result(cid: str, kind: str, criterion: str, ok: bool, observed: dict):
            cases.append({"id": cid, "kind": kind, "criterion": criterion,
                          "result": "PASS" if ok else "FAIL", "observed": observed,
                          "trace": trace.copy()})
            trace.clear()

        # 1. Positive integration/removal ordering: no network pull is performed.
        r = repo("clean-merge")
        w = worktree(r)
        (w / "a.txt").write_text("1\n")
        h = commit(w, "feature change")
        pre = run(w, sys.executable, "-c", TEST, record=True)
        git(r, "merge", "feature", record=True)
        post = run(r, sys.executable, "-c", TEST, record=True)
        git(r, "worktree", "remove", str(w), record=True)
        git(r, "branch", "-d", "feature", record=True)
        reachable = git(r, "merge-base", "--is-ancestor", h, "main", check=False).returncode == 0
        absent = git(r, "show-ref", "--verify", "--quiet", "refs/heads/feature", check=False).returncode != 0
        result("green_merge_then_cleanup", "mechanism",
               "Green merged fixture retains feature commit after worktree then branch removal",
               pre.returncode == post.returncode == 0 and reachable and absent and not w.exists(),
               {"feature_commit_in_main": reachable, "branch_absent": absent, "worktree_absent": not w.exists()})

        # 2. A textually conflict-free merge can fail the integrated invariant.
        r = repo("combined-test")
        w = worktree(r)
        (w / "a.txt").write_text("1\n")
        commit(w, "feature changes a")
        pf = run(w, sys.executable, "-c", TEST, record=True)
        (r / "b.txt").write_text("1\n")
        commit(r, "base changes b")
        pb = run(r, sys.executable, "-c", TEST, record=True)
        m = git(r, "merge", "--no-edit", "feature", record=True)
        pm = run(r, sys.executable, "-c", TEST, check=False, record=True)
        result("green_inputs_red_merged_result", "integration-observation",
               "Both inputs pass but clean merge fails the synthetic combined-behavior test",
               pf.returncode == pb.returncode == m.returncode == 0 and pm.returncode != 0,
               {"feature_test_exit": pf.returncode, "base_test_exit": pb.returncode,
                "merge_exit": m.returncode, "merged_test_exit": pm.returncode,
                "worktree_retained_by_fixture": w.exists(), "cleanup_attempted": False})

        # 3. Normal untracked notes trigger the non-force removal refusal.
        r = repo("untracked-note")
        w = worktree(r)
        note = w / "only-copy-note.txt"
        note.write_text("UNTRACKED_ONLY_COPY\n")
        status = git(w, "status", "--porcelain", "-uall", record=True).stdout
        rm = git(r, "worktree", "remove", str(w), check=False, record=True)
        result("untracked_note_blocks_removal", "mechanism",
               "Non-ignored untracked evidence is visible and blocks ordinary removal",
               "only-copy-note.txt" in status and rm.returncode != 0 and note.exists(),
               {"visible_in_status": "only-copy-note.txt" in status, "remove_exit": rm.returncode,
                "note_preserved": note.exists()})

        # 4. Stronger retention claim; exact S32 creates genuinely ignored scratch.
        r = repo("ignored-evidence")
        w = worktree(r)
        folder = Path(run(w, "bash", str(helper), "plan.md", record=True).stdout.strip())
        note = folder / "progress.md"
        note.write_text("# SDD ledger — plan: plan.md\nRuling: UNIQUE_ONLY_COPY — fixture — rework\n")
        exists_before = note.exists()
        ignored = git(w, "check-ignore", "-q", str(note), check=False, record=True).returncode == 0
        status = git(w, "status", "--porcelain", "-uall", record=True).stdout
        history = git(w, "log", "--all", "--format=%H", "--", str(note.relative_to(w))).stdout
        rm = git(r, "worktree", "remove", str(w), check=False, record=True)
        preserved = note.exists()
        result("ignored_sdd_evidence_retention", "retention-challenge",
               "Refusal-based removal protection also preserves only-copy ignored SDD evidence",
               preserved,
               {"existed_before": exists_before, "ignored": ignored,
                "ordinary_status_empty": not status.strip(), "tracked_history_exists": bool(history.strip()),
                "remove_exit": rm.returncode, "note_preserved": preserved,
                "force_used": False, "explicit_sdd_rm_used": False})

        # 5. A preserved, named external worktree still pins its branch in Git.
        r = repo("external-owner")
        w = worktree(r, external=True)
        (w / "a.txt").write_text("1\n")
        commit(w, "feature")
        git(r, "merge", "feature", record=True)
        d = git(r, "branch", "-d", "feature", check=False, record=True)
        present = git(r, "show-ref", "--verify", "--quiet", "refs/heads/feature", check=False).returncode == 0
        result("preserved_worktree_blocks_branch_delete", "lifecycle-observation",
               "Without a host-exit/detach step, merged branch deletion is refused while checked out",
               d.returncode != 0 and present and w.exists(),
               {"branch_delete_exit": d.returncode, "branch_preserved": present,
                "worktree_preserved": w.exists(), "host_exit_invoked": False})

        # 6. Detached is a Git state, not an intrinsic prohibition on remote refs.
        r = repo("detached")
        w = worktree(r, external=True, detached=True)
        (w / "a.txt").write_text("1\n")
        h = commit(w, "detached feature")
        remote = root / "local-origin.git"
        git(root, "init", "--bare", "-q", str(remote))
        git(r, "remote", "add", "origin", str(remote))
        p = git(w, "push", "origin", "HEAD:refs/heads/review-fixture", record=True)
        actual = git(root, "--git-dir=" + str(remote), "rev-parse", "refs/heads/review-fixture", record=True).stdout.strip()
        detached = not git(w, "branch", "--show-current").stdout.strip()
        result("detached_push_to_local_only_remote", "capability-observation",
               "Explicit HEAD refspec creates local-remote branch while local HEAD remains detached",
               p.returncode == 0 and actual == h and detached and w.exists(),
               {"remote_ref_matches_commit": actual == h, "still_detached": detached,
                "worktree_preserved": w.exists(), "remote_transport": "local filesystem only",
                "forge_pr_created": False})

        # 7. Conflicts preserve explicit unfinished Git state, not automatic rollback.
        r = repo("merge-conflict")
        w = worktree(r)
        (w / "a.txt").write_text("feature\n")
        commit(w, "feature conflicts")
        (r / "a.txt").write_text("base\n")
        commit(r, "base conflicts")
        m = git(r, "merge", "--no-edit", "feature", check=False, record=True)
        unmerged = git(r, "diff", "--name-only", "--diff-filter=U", record=True).stdout.strip()
        pending = git(r, "rev-parse", "--verify", "--quiet", "MERGE_HEAD", check=False).returncode == 0
        result("conflict_is_pending_state", "failure-observation",
               "Conflicting merge fails with unmerged file and MERGE_HEAD, leaving feature worktree intact",
               m.returncode != 0 and unmerged == "a.txt" and pending and w.exists(),
               {"merge_exit": m.returncode, "unmerged_file": unmerged,
                "merge_head_present": pending, "feature_worktree_preserved": w.exists(),
                "cleanup_attempted": False, "rollback_performed": False})

        output = {"study_date": "2026-09-17", "upstream_commit": PIN,
                  "source_identity": {"sdd_workspace_blob": HELPER_BLOB, "bytes": len(data), "verified": True,
                                      "finishing_skill_blob_observed_through_connector": FINISH_BLOB},
                  "environment": {"os": platform.system(), "python": platform.python_version(),
                                  "git": git(root, "--version").stdout.strip(),
                                  "bash": run(root, "bash", "--version").stdout.splitlines()[0]},
                  "scope": "Exact S32 plus selected Git primitives in synthetic repos. Not full S55 execution, actual human choice, live host, remote service, forge PR or upstream suite.",
                  "criteria": "Fixed before this run after source inspection. Retention challenge tests a stronger inference, not an asserted upstream archival guarantee.",
                  "cases": cases,
                  "summary": {"total": len(cases), "observations_matched": sum(c["result"] == "PASS" for c in cases),
                              "retention_challenges_failed": sum(c["kind"] == "retention-challenge" and c["result"] == "FAIL" for c in cases),
                              "unexpected_observation_failures": sum(c["kind"] != "retention-challenge" and c["result"] == "FAIL" for c in cases)}}
    print(json.dumps(output, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
