#!/usr/bin/env python3
"""test_merge_gate.py: planted cases for the merge gate of the guard (W-C00-12.6 acceptance (e); D-008).

Run from the repository root (full history, as tools/test_check_records.py requires). Every fixture is a
scratch repository with a bare remote, built with the fixture class of tools/test_check_records.py; the gate
is run as the guard runs it (`check_records.py gate --pr N --head SHA`, fetching from the remote), with the
working tree's tools/check_records.py and tools/records.py copied in. Prints one line per case and
`MERGE_GATE_TEST PASS` only if every case behaves as written.
"""
import sys
from pathlib import Path

sys.dont_write_bytecode = True
sys.path.insert(0, str(Path(__file__).resolve().parent))
import test_check_records as T  # noqa: E402

RESULTS = []


def case(label, ok, detail=""):
    print(f"{'ok  ' if ok else 'BAD '} {label}" + ("" if ok else f": {detail[-600:]}"))
    RESULTS.append(ok)


def gate(s, pr, head):
    rc, out = s.cr("gate", "--pr", str(pr), "--head", head)
    return rc, out


def main():
    s = T.Scratch(remote=True, overlay_tools=True)
    s.commit("fixture: the working tree's checker", session=T.RUN)
    s.push()
    # (1) a class-high head without any verdict
    s.git("checkout", "-q", "-b", "pr1")
    s.append("tools/records.py", "# fixture: a class-high change")
    h1 = s.commit("a class-high change")
    s.git("push", "-q", "origin", "pr1:refs/pull/1/head")
    rc, out = gate(s, 1, h1)
    case("(1) a class-high head without a covering verdict is refused", rc == 1 and "GATE FAIL" in out, out)
    # (2) a verdict on its review branch names h1; the reviewer's recorder line reaches main first; main is
    # merged into the branch and the verdict is copied in, so it covers the new head
    s.git("checkout", "-q", "main")
    s.git("checkout", "-q", "-b", "claude/review-R-GATE1")
    s.write("evidence/C00/reviews/R-GATE1.md", T.verdict_text(h1, "PASS"))
    s.commit("R-GATE1", session=T.REVIEWER)
    s.git("push", "-q", "origin", "claude/review-R-GATE1")
    s.git("checkout", "-q", "main")
    s.append(".claude/hooks/owned_ids.txt", T.REVIEWER)
    s.commit("recorder line for the reviewer", session=T.RUN)
    s.push()
    s.git("checkout", "-q", "pr1")
    rc_m, out_m = s.git("merge", "-q", "--no-ff", "main", "-m", "Merge main into pr1")
    assert rc_m == 0, out_m
    s.git("checkout", "-q", "claude/review-R-GATE1", "--", "evidence/C00/reviews/R-GATE1.md")
    h2 = s.commit("copy R-GATE1")
    s.git("push", "-q", "origin", "pr1:refs/pull/1/head")
    rc, out = gate(s, 1, h2)
    case("(2) the same change with a covering verdict copied in passes", rc == 0 and "GATE PASS" in out and
         "covered by evidence/C00/reviews/R-GATE1.md" in out, out)
    # (3) the old head after the PR moved: the head is not what the remote holds
    rc, out = gate(s, 1, h1)
    case("(3) a SHA that is no longer the pull request's head is refused", rc == 1 and "head moved" in out, out)
    # (4) a verdict by a session of the change itself does not cover (D-07)
    s.git("checkout", "-q", "main")
    s.git("checkout", "-q", "-b", "pr3")
    s.append("tools/records.py", "# fixture: another class-high change")
    h3 = s.commit("another class-high change")
    s.git("checkout", "-q", "main")
    s.git("checkout", "-q", "-b", "claude/review-R-GATE3")
    s.write("evidence/C00/reviews/R-GATE3.md", T.verdict_text(h3, "PASS"))
    s.commit("R-GATE3 by the producer", session=T.PRODUCER)
    s.git("push", "-q", "origin", "claude/review-R-GATE3")
    s.git("checkout", "-q", "pr3")
    s.git("checkout", "-q", "claude/review-R-GATE3", "--", "evidence/C00/reviews/R-GATE3.md")
    h4 = s.commit("copy R-GATE3")
    s.git("push", "-q", "origin", "pr3:refs/pull/3/head")
    rc, out = gate(s, 3, h4)
    case("(4) a verdict committed by the producer's own session does not cover", rc == 1 and "GATE FAIL" in out, out)
    # (5) a FAIL verdict does not cover
    s.git("checkout", "-q", "main")
    s.git("checkout", "-q", "-b", "pr5")
    s.append("tools/records.py", "# fixture: a third class-high change")
    h5 = s.commit("a third class-high change")
    s.git("checkout", "-q", "main")
    s.git("checkout", "-q", "-b", "claude/review-R-GATE5")
    s.write("evidence/C00/reviews/R-GATE5.md", T.verdict_text(h5, "FAIL"))
    s.commit("R-GATE5", session=T.REVIEWER)
    s.git("push", "-q", "origin", "claude/review-R-GATE5")
    s.git("checkout", "-q", "pr5")
    s.git("checkout", "-q", "claude/review-R-GATE5", "--", "evidence/C00/reviews/R-GATE5.md")
    h6 = s.commit("copy R-GATE5")
    s.git("push", "-q", "origin", "pr5:refs/pull/5/head")
    rc, out = gate(s, 5, h6)
    case("(5) a FAIL verdict does not cover", rc == 1 and "GATE FAIL" in out, out)
    # (6) a class-normal head passes without a verdict
    s.git("checkout", "-q", "main")
    s.git("checkout", "-q", "-b", "pr6")
    s.records("lease", "--session", T.RUN)
    h7 = s.commit("a lease renewal (class normal)", session=T.RUN)
    s.git("push", "-q", "origin", "pr6:refs/pull/6/head")
    rc, out = gate(s, 6, h7)
    case("(6) a class-normal head passes without a verdict", rc == 0 and "class normal" in out, out)
    # (7) a pull request the remote does not have is refused
    rc, out = gate(s, 9, h7)
    case("(7) a pull request number the remote does not hold is refused", rc == 1 and "cannot fetch" in out, out)
    # mutation: with the coverage test disabled in the fixture's checker, case (5) must change its result
    src = s.read("tools/check_records.py")
    needle = "    cov = covered(h, h) or covered(h, m)\n"
    case("(m) the mutation point exists in the checker", needle in src)
    s.write("tools/check_records.py", src.replace(needle, "    cov = ('mutant', h)\n"))
    rc, out = gate(s, 5, h6)
    case("(m) with coverage disabled, case (5) passes, so the test detects the disabled check", rc == 0, out)
    s.write("tools/check_records.py", src)
    ok = bool(RESULTS) and all(RESULTS)
    print(f"MERGE_GATE_TEST {'PASS' if ok else 'FAIL'} ({sum(RESULTS)}/{len(RESULTS)})")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
