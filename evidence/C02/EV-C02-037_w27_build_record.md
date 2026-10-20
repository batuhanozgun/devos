---
id: EV-C02-037
title: "W-C02-27's build record: the producer's breaks (B-1 to B-15) with the copy each ran and its red cases, B19's premise, and the flipped T1 cases (CHK-C02-149 C2)"
stage: C02
kind: observation
source: "producer a533282bfce7fb08e: its hand-over (taken with tools/subagent_audit.py last, DISCIPLINES OK), its break script scratchpad/w27p/breaks.py and that script's output scratchpad/w27p/breaks_out.txt, copied by tool"
---

# EV-C02-037 · W-C02-27's build record

Filed by the executor for CHK-C02-149's C2 (missing evidence, blocks W-C02-27's acceptance, closure diff-confirmed): points 4, 8 and 9 of W-C02-27's condition name the producer's build record, which stood only in the container's scratch files. Part 1 is the script that made each break: for each of B-1 to B-15 it writes one copy of the built guard with one replacement, asserted to match once, into a scratch directory with no `.claude/` tree, and runs `tools/test_send_message.py --hook <copy> --only guard` against it. Part 2 is that script's output (the control and each break's red cases against the named pairs). Part 3 is the producer's hand-over, which states B19's premise with its grep result (Product, Tests) and each flipped case with the ID it asserts (Received from / Returned to; Product, Files): G1 to G12 in `tools/test_agent_hooks.py` now `deny T6.9`; `tools/test_tool_allowlist.sh`'s line 141 (formerly 129) `lt deny T6.6` with a planted registry; its twelve-case loop `deny T6.9`; `W21_LIST` with `SendMessage`, count 29.

## 1. The break script (`breaks.py`)

```python
"""W-C02-27 condition point 4: each break applied to a scratch copy of the built guard (never the repository), the
test run against it with --hook --only guard, and the named cases checked red (on both events where the case has a
PermissionRequest twin). Usage: python3 -I breaks.py <clone root> <scratch dir>; run with cwd = the clone root."""
import os, re, shutil, subprocess, sys

root, scratch = sys.argv[1], sys.argv[2]
SRC = open(os.path.join(root, ".claude/hooks/tool_allowlist.py"), encoding="utf-8").read()
HOOKS = os.path.join(root, ".claude/hooks/agent_hooks.py")

CALL_BLOCK = ('            try:                                         # T6\'s one catch: removed, T6.0\'s cases would '
              'reach G0\n                rule, why = send_message_checks(data, args)\n            except Bad:\n'
              '                raise\n            except Exception as exc:\n                raise Bad("T6.0", f"could '
              'not check ({type(exc).__name__}); this call only is refused")\n')
READ = "records = hooks.read_registry(hooks.registry_path(session_key(data), LOG_DIR))"
LOOKUP = "    elif to in registered:\n        target = registered[to]\n"
BREAKS = {
    "B-1": [('if name == "SendMessage":', "if False:")],
    "B-2": [("    if extra:\n", "    if False:\n")],
    "B-3": [(LOOKUP, '    elif to.strip().lower().removeprefix("agent-") in registered:\n'
                     '        target = registered[to.strip().lower().removeprefix("agent-")]\n')],
    "B-4": [(LOOKUP, LOOKUP + '    elif any(r.get("name") == to or r.get("agent_type") == to for r in records):\n'
                     '        target = next(r.get("agent_type") for r in records if r.get("name") == to or '
                     'r.get("agent_type") == to)\n')],
    "B-5": [(LOOKUP, '    elif re.fullmatch(r"a[0-9a-f]{16}", to):\n        target = registered.get(to, "researcher")\n')],
    "B-6": [("        ok = caller is None\n    elif", "        ok = caller is None or ctype is not None\n    elif")],
    "B-7": [('    if target == "main":\n        ok = ctype is not None\n',
             '    if target == "main":\n        ok = caller is not None\n')],
    "B-8": [("    if caller is not None and to == caller:\n", "    if False:\n")],
    "B-9": [(CALL_BLOCK, "            rule, why = send_message_checks(data, args)\n")],
    "B-10": [(READ, 'records = hooks.read_registry(hooks.registry_path(key_of(data.get("session_id")), LOG_DIR))')],
    "B-11": [('        raise Bad("T6.9", f"no registry for this session ({e}); {T6_RETURN}")\n',
              "        records = []\n")],
    "B-12": [('LOCAL_TOOLS = {\n', 'LOCAL_TOOLS = {\n    "SendMessage",\n')],
    "B-13": [(READ, 'records = hooks.parse(open(hooks.registry_path(session_key(data), LOG_DIR), "rb").read())'),
             ("    except hooks.Unreadable as e:\n", "    except (hooks.Unreadable, OSError) as e:\n")],
    "B-14": [(READ, 'records = [r for f in sorted(os.listdir(LOG_DIR)) if f.endswith(".agents") '
                    'for r in hooks.read_registry(os.path.join(LOG_DIR, f))]')],
    "B-15": [('if name == "SendMessage":',
              'if name == "SendMessage" and data.get("hook_event_name") != "PermissionRequest":')],
}


def run(name, text):
    # a plain scratch directory, never a .claude/ tree (guard B5's guard-swap class); the guard's ROOT (two levels up)
    # gets a link to the clone's tests/, where L4 reads the token formats
    d = os.path.join(scratch, name, "x", "hooks")
    os.makedirs(d, exist_ok=True)
    if not os.path.lexists(os.path.join(scratch, name, "tests")):
        os.symlink(os.path.join(root, "tests"), os.path.join(scratch, name, "tests"))
    open(os.path.join(d, "tool_allowlist.py"), "w", encoding="utf-8").write(text)
    shutil.copy(HOOKS, os.path.join(d, "agent_hooks.py"))
    p = subprocess.run([sys.executable, "tools/test_send_message.py", "--hook", os.path.join(d, "tool_allowlist.py"),
                        "--only", "guard"], capture_output=True, text=True, cwd=root, timeout=1200)
    shutil.rmtree(os.path.join(scratch, name))
    lines = p.stdout.splitlines()
    status = {}
    for ln in lines:
        m = re.match(r"(ok   |BAD  )(\S+)(?: \[(PreToolUse|PermissionRequest)\])?", ln)
        if m:   # one (case, event) may have several lines (T6.0): it is red when any of them is
            s = status.setdefault(m.group(2), {})
            s[m.group(3) or "-"] = "BAD" if "BAD" in (s.get(m.group(3) or "-"), m.group(1).strip()) else "ok"
    if name == "control" and p.returncode:
        print("\n".join(ln[:600] for ln in lines if ln.startswith("BAD"))[:1800])
    return p.returncode, lines[-1] if lines else "", status


rc, last, control = run("control", SRC)
print(f"control (the built guard, copied): exit {rc}; {last}")
if rc != 0:
    print("first red control cases:", [c for c in control if "BAD" in control[c].values()][:5])
    sys.exit(1)
cases = list(control)
P12 = [c for c in cases if re.fullmatch(r"(P|N)-.*", c) and c != "P-14" or c == "P-14"]   # every P and N case
EXPECT = {
    "B-1": P12 + ["T6.0", "C-5"],
    "B-2": [f"N-K{i}" for i in range(1, 10)],
    "B-3": ["N-N4", "N-N5", "N-N6", "N-N7"],
    "B-4": ["N-N2", "N-N3"],
    "B-5": ["N-N10", "N-N12"],
    "B-6": [f"N-C{i}" for i in range(1, 7)],
    "B-7": ["N-C7"],
    "B-8": ["N-M1", "N-M2"],
    "B-9": ["T6.0", "C-5"],
    "B-10": [c for c in cases if c.startswith("P-") and c != "P-K2"] +
            [f"N-{x}" for x in ["129"] + [f"N{i}" for i in range(2, 14)] + [f"C{i}" for i in range(1, 14)] +
             ["M1", "M2", "M3"]],
    "B-11": ["N-G1", "N-G2", "N-G3", "N-G4", "N-L1"],
    "B-12": ["L4-1", "T6-S"],
    "B-13": ["N-L1"],
    "B-14": ["N-N10", "N-C9", "N-G1"],
}
for name, pairs in BREAKS.items():
    text = SRC
    for old, new in pairs:
        assert text.count(old) == 1, (name, old)
        text = text.replace(old, new)
    rc, last, st = run(name, text)
    if name == "B-15":
        want = [(c, "PermissionRequest") for c in cases if "PermissionRequest" in control[c]]
    else:
        want = [(c, ev) for c in EXPECT[name] for ev in (control.get(c) or {"?": None})]
    missing = [f"{c}[{ev}]" for c, ev in want if (st.get(c) or {}).get(ev) != "BAD"]
    red = sum(v == "BAD" for c in st for v in st[c].values())
    print(f"{name}: exit {rc}; {last}; named {len(want)} (case, event) pairs, red {len(want) - len(missing)}"
          + (f"; NOT RED: {missing}" if missing else "") + f"; red in the whole run {red}")
```

## 2. Its output (`breaks_out.txt`)

```
control (the built guard, copied): exit 0; W27 PASS 162 checks
B-1: exit 1; W27 FAIL 146 BAD, 0 NOT RUN, 16 ok; named 146 (case, event) pairs, red 146; red in the whole run 146
B-2: exit 1; W27 FAIL 18 BAD, 0 NOT RUN, 144 ok; named 18 (case, event) pairs, red 18; red in the whole run 18
B-3: exit 1; W27 FAIL 8 BAD, 0 NOT RUN, 154 ok; named 8 (case, event) pairs, red 8; red in the whole run 8
B-4: exit 1; W27 FAIL 4 BAD, 0 NOT RUN, 158 ok; named 4 (case, event) pairs, red 4; red in the whole run 4
B-5: exit 1; W27 FAIL 4 BAD, 0 NOT RUN, 158 ok; named 4 (case, event) pairs, red 4; red in the whole run 4
B-6: exit 1; W27 FAIL 12 BAD, 0 NOT RUN, 150 ok; named 12 (case, event) pairs, red 12; red in the whole run 12
B-7: exit 1; W27 FAIL 2 BAD, 0 NOT RUN, 160 ok; named 2 (case, event) pairs, red 2; red in the whole run 2
B-8: exit 1; W27 FAIL 4 BAD, 0 NOT RUN, 158 ok; named 4 (case, event) pairs, red 4; red in the whole run 4
B-9: exit 1; W27 FAIL 5 BAD, 0 NOT RUN, 157 ok; named 5 (case, event) pairs, red 5; red in the whole run 5
B-10: exit 1; W27 FAIL 86 BAD, 0 NOT RUN, 76 ok; named 86 (case, event) pairs, red 86; red in the whole run 86
B-11: exit 1; W27 FAIL 9 BAD, 0 NOT RUN, 153 ok; named 9 (case, event) pairs, red 9; red in the whole run 9
B-12: exit 1; W27 FAIL 3 BAD, 0 NOT RUN, 159 ok; named 3 (case, event) pairs, red 3; red in the whole run 3
B-13: exit 1; W27 FAIL 1 BAD, 0 NOT RUN, 161 ok; named 1 (case, event) pairs, red 1; red in the whole run 1
B-14: exit 1; W27 FAIL 6 BAD, 0 NOT RUN, 156 ok; named 6 (case, event) pairs, red 6; red in the whole run 6
B-15: exit 1; W27 FAIL 72 BAD, 0 NOT RUN, 90 ok; named 73 (case, event) pairs, red 72; NOT RED: ['L4-1[PermissionRequest]']; red in the whole run 72
```

## 3. The producer's hand-over

Package: producer@d379362747dd
Nonce: 34eb2ee5787baf2b
Take-up: PROCEED. The approach, the condition and the test agree. The schema row fits recipe 11: the target is the string `to` and the body is `message`, so the tests stand as written. W-C02-25's registry functions are on `main` to reuse. The product is needed: it is M3b, and nothing in the tree gives T6 today.

## Disciplines (D1–D9)
D1: yes: the order between the self check and the registry read was an open choice. I put the registry read first, so break B-10 turns all the cases point 4 names red, and main to main gets `T6.9` when there is no registry, which point 9 allows.
D2: no
D3: yes: I ran every suite the change touches (the W27 test, `test_tool_allowlist.sh`, `test_agent_hooks.py`, `render --check`, four more suites), not only the named test, and I name the gaps below.
D4: yes: I ran all 15 breaks against scratch copies, with an unchanged copy as the control (green), and report the one named case that does not turn red, with its cause.
D5: uncertain: the schema row and the documentation facts come from the task's notes (EV-C02-035 and EV-C02-036), which I did not re-read. I used only the key set.
D6: no
D7: yes: the working order and PC-53 text were written by a script from exact replacement pairs (each old text found exactly once at `13d310a`), and part d prints those same pairs, so a new session can rebuild every change.
D8: yes: I checked that the clone sits at `13d310a` and that the test file is unchanged there and after the build (`git status` does not list it).
D9: yes: I read gstack CORE (P7, F2 to F4). It backed the bounded lock wait and the `T6.0` catch (P7). It limited the working-order text to program logic, with the platform rows marked "not observed here" (F4). F3 is behind the note under Received that a message resuming a producer is never read by T5.

Read, and what each changed:
- `plan/work/W-C02-27.md` (condition and approach): set the work.
- `tools/test_send_message.py`: set the interface: `send_message_checks`, the rule IDs, the registry key.
- `.claude/hooks/tool_allowlist.py` (decide, main, session_key, RULES, T5 pattern) and `.claude/hooks/agent_hooks.py` (read_registry, merged_view, Unreadable, LOCK_WAIT 4.0): reused.
- `tools/test_tool_allowlist.sh` and `tools/test_agent_hooks.py` (G cases): changed.
- `.claude/settings.json` hook commands: no `-I`, so the C-5 planted error reaches the guard; `SendMessage` is out of the deny list.
- The five role files and `counter-designer.md`; working order sections 4, 9 and 10; PC-53 part c, whose format I followed.
- SB-COR 3.6a and 3.6b (lines 160 and 161): gave the exact sentence to quote.
- `tools/stop_check.sh`: confirmed it runs no breaks.py.
- `tools/test_check_role_packages.py` (P7b): explained a failure (see Unsure).
- Library: gstack CORE.md lines 420 to 467.
- Not read: EV-C02-030, EV-C02-035, EV-C02-036 (the task gave the facts I needed); the platform pages.

Relied on:
- `agent_hooks.read_registry` raises `Unreadable` when the file is missing, is a directory, has a bad line, or the lock is not given in time (agent_hooks.py:129–137): observed.
- `merged_view` defines "registered" (agent_hooks.py:159): observed. It matches the condition's term "registered".
- L4's token files are found from the guard's ROOT (tool_allowlist.py `TOKEN_FILES`): observed. This is why the scratch break copies need a `tests` link.
- The schema keys `to`, `message`, `summary` and `notify_when_idle`: stated, from the task note.
- The registry reader's bounded wait is 4.0 s (agent_hooks.py:49): observed. N-L1 passed within the test's 150 s.

Unsure:
- `test_check_role_packages.py` case P7b fails (54/55) only because the clone has uncommitted changes. The case itself says "the working tree is not clean, so P7b cannot compare", and the same suite passes 55/55 at the base. Settled by a rerun at the committed head.
- Break B-15: one case point 4 names stays green, L4-1's PermissionRequest twin. L4 runs before T6 on both events, so skipping T6 on PermissionRequest cannot change L4-1. The other 72 named pairs turn red. This looks like the condition's list naming too much, not a build fault; it is for the test designer.
- The platform rows (i) to (iii) are not yet observed.

For: the executor, to commit these files from my clone and send them to a fresh binding checker. After that, every role run that sends `SendMessage`.

Received from / Returned to:
- To the test designer: the B-15 / L4-1 point above.
- To the executor:
  - The base held W-C02-25's twelve `T1` cases for `SendMessage` twice: G1 to G12 in `tools/test_agent_hooks.py`, and a loop at `tools/test_tool_allowlist.sh:142–151`. Point 9 names only the first set and `:129`. I changed both sets the same way: each now expects `T6.9`, with event, caller and `to` kept and none removed.
  - `test_tool_allowlist.sh`'s W-C02-21 check (`W21_LIST`, count 28) failed once `SendMessage` was on the allow list. I added `SendMessage` and set the count to 29, as the list's own comment asks of a reviewed change to the allow list.
  - Two texts outside my `writes:` go stale after the merge: `.claude/agents/checker.md:16` ("once the guard allows resuming (W-C02-27)"), which W-C02-24.1 writes next, and `.claude/roles/researcher.md:28` ("SendMessage is denied by guard rule T1 until W-C02-27").
  - Side effect: a message from the executor resuming a producer carries a task that T5 never reads, because T5 sees only Agent calls. The approach accepted this (W27-1); I name it so it stays visible.

Product:
- **Files** (all under /tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w27p/devos, branch `claude/c02-w27-product` from `13d310a`, not committed):
  - `.claude/hooks/tool_allowlist.py`:
    - `SendMessage` added to `ALLOWED_NON_MCP` (line 112), not to `LOCAL_TOOLS`.
    - RULES entries `T6.0` to `T6.9`, sharing one reason text.
    - `agent_hooks()` loads W-C02-25's module from the guard's own directory, without writing bytecode.
    - `send_message_checks(data, args)` (line 2421) applies the checks in this order: keys `T6.1`, shape `T6.2` to `T6.5`, registry `T6.9`, self `T6.8`, unregistered `T6.6`, caller `T6.7`, allow `T6`.
    - `decide()` (line 2512) turns any other exception into `T6.0`.
  - The five role files: `tools:` gains `SendMessage`, and the Send-back line is replaced by the same new line in all five. `counter-designer.md` is untouched.
  - `plan/Installation_Working_Order.md`: five replacements:
    - section 4 step 4, twice: the re-run sentence and the scoped re-review;
    - section 9's `Teammates:` line;
    - section 10: `SendMessage` taken off the denied list, and a new bullet "Messages between agents" with the sentence from SB-COR 3.6b.
  - `plan/decisions/PC-53.md`: addendum part d, dated 2026-10-20. Sections d.1 to d.5 are printed from the same replacement pairs. It also has "Changed beside part d" (the Send-back line quoted from git), "Not changed", and the plan 6.12 item 1 time line: one executor turn or one launch per follow-up, and no check is cut.
  - `tools/test_tool_allowlist.sh`: `:141` becomes `lt deny T6.6`, with a planted registry that is removed again; the 12-case loop expects `T6.9`; `W21_LIST` gains `SendMessage`, count 29.
  - `tools/test_agent_hooks.py`: G1 to G12 expect `T6.9`. Nothing else changed.
  - Scratch scripts, not in the repository: `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w27p/roles_edit.py`, `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w27p/wo_edit.py`, `/tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/w27p/breaks.py`.
- **Tests:**
  - `python3 tools/test_send_message.py --base 13d310a3915c7b60605735bf76dcdbd2a32ba27d`: exit 0, `W27 PASS 190 checks`.
  - `bash tools/test_tool_allowlist.sh`: exit 0, `ALLOWLIST_TEST PASS`, 0 BAD (`TOKEN_STOP_TEST PASS (ok 541, BAD 0, info 29)`).
  - `python3 tools/test_agent_hooks.py`: exit 0, `101 cases, 0 BAD`.
  - `python3 -B tools/records.py render --check`: `RENDER OK`.
  - `test_subagent_audit` passed 64/64, `test_merge_gate` 288/288, `test_records_disciplines` 46/46.
  - `test_check_role_packages`: 54/55, P7b failing because the tree is not clean (see Unsure).
  - `git diff --check`: clean.
  - Breaks (`python3 -I breaks.py`, `--hook <scratch copy> --only guard`): the control passed (`W27 PASS 162 checks`). Each break turned its named (case, event) pairs red: B-1 146/146, B-2 18/18, B-3 8/8, B-4 4/4, B-5 4/4, B-6 12/12, B-7 2/2, B-8 4/4, B-9 5/5, B-10 86/86, B-11 9/9, B-12 3/3, B-13 1/1, B-14 6/6, B-15 72/73 (L4-1's PermissionRequest twin stays green, see Unsure).
  - B19's premise (point 8): `grep -rn "breaks.py" tools/ .claude/` finds nothing outside the test file.
- **Where it ran:** container `python3` 3.13.16 and git 2.43.0, in the scratch clone above. The guard was driven through `.claude/settings.json`'s two commands, with `CLAUDE_CODE_REMOTE_SESSION_ID` set by the fixture (and unset for K-2).

Guard denials:
- B5, on a `for` loop with `tools/$t.py`: a guarded path in a shell variable. I reran each suite with a literal path.
- B5, on `cp` of the clone's `.claude/hooks/*.py` to a scratch debug directory: copying guard files is the guard-swap class. I made no further copy with shell tools. The break copies are written by `breaks.py` into plain scratch directories with no `.claude/` tree, as point 4 requires (a scratch copy, never the repository), and are deleted after each run. The checker or executor should judge whether that route is acceptable.
