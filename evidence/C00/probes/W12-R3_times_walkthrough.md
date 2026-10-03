# W-C00-12 revision 3: typed-time walk-through over the log (K2)

**What:** a prototype of M-R14 run over `plan/ledger/C00-log.md` on `main` (`d69d7c6`), using `git blame` author times, by run `session_01XUsVQowRbLJdC1E8gFvxZq` on 2026-10-03. It lists every time later than the commit that introduced its line and whether a keyword vocabulary for scheduled times would accept it. **Use:** the basis of M-R14 in `plan/builder/w-c00-12/02_memory.md` §7 and of T-M7c. The script is reproduced below; its output follows unedited.

```python
import re, subprocess, datetime as dt, collections
# blame log on main: author time per line
out=subprocess.run(["git","blame","--line-porcelain","origin/main","--","plan/ledger/C00-log.md"],capture_output=True,text=True).stdout
lines=[];cur={}
for l in out.splitlines():
    if l.startswith("author-time "): cur["t"]=int(l.split()[1])
    elif l.startswith("\t"): lines.append((cur.get("t"),l[1:]))
SCHED=re.compile(r"(expires?|expiry|resets?|reset at|wake(?:-up)? at|until|due|scheduled|fires? at|delay)\W{0,3}(?:\S+\W+){0,3}$",re.I)
T=re.compile(r"(?:(\d{4}-\d{2}-\d{2})T)?(\d{2}):(\d{2})(?::(\d{2}))?Z")
stats=collections.Counter(); fails=[]
entry=None
for t,l in lines:
    m=re.match(r"### (L-\d+)",l)
    if m: entry=m.group(1)
    if not entry or t is None: continue
    ct=dt.datetime.fromtimestamp(t,dt.timezone.utc)
    for mm in T.finditer(l):
        d=mm.group(1) or ct.strftime("%Y-%m-%d")
        x=dt.datetime.fromisoformat(f"{d}T{mm.group(2)}:{mm.group(3)}:{mm.group(4) or '00'}+00:00")
        stats[entry]+=1
        if x>ct:
            pre=l[:mm.start()]
            sched=bool(SCHED.search(pre[-40:]))
            fails.append((entry,"sched-ok" if sched else "FUTURE",ct.strftime("%H:%M"),mm.group(0),pre[-45:].replace("\n"," ")))
print("times per entry (L-040,L-041):",stats["L-040"],stats["L-041"], "total",sum(stats.values()), "entries",len(stats))
for f in fails: print(f)
```

```text
times per entry (L-040,L-041): 9 8 total 67 entries 17
('L-027', 'FUTURE', '20:17', '23:05Z', 'after this entry is merged. Lease renewed to ')
('L-031', 'FUTURE', '20:48', '2026-10-03T17:15Z', ' wake-up.** `trig_01PPvVV1VzS8o5fBWWRtvFZj` (')
('L-031', 'FUTURE', '20:48', '2026-10-01T20:57Z', 'successor `trig_01W2ujJKa95rUkY5MVF1FS7X` at ')
('L-032', 'sched-ok', '20:59', '2026-10-03T17:00Z', ' Usage `seven_day` `allowed_warning`, resets ')
('L-032', 'sched-ok', '20:59', '23:59Z', '** taken in this record PR at 20:59Z, expiry ')
('L-033', 'sched-ok', '21:05', '2026-10-03T17:00Z', 'seven_day` `allowed_warning` (21:03Z), reset ')
('L-033', 'FUTURE', '21:05', '2026-10-03T17:15Z', '6LPhKPWX9oYmaACVsyBx` into the dispatcher at ')
('L-033', 'sched-ok', '00:49', '2026-10-03T17:00Z', 'warning` holds heavy work until the reset at ')
('L-033', 'sched-ok', '06:49', '2026-10-03T17:00Z', 'lowed_warning` holds them until the reset at ')
('L-036', 'sched-ok', '17:23', '20:19Z', ' #49 (state file only, L-032 lesson), expiry ')
('L-037', 'sched-ok', '17:31', '22:10Z', 'lan package) and one unconverted reset time (')
('L-037', 'FUTURE', '17:31', '20:10Z', 'ne unconverted reset time (22:10Z instead of ')
('L-039', 'FUTURE', '17:50', '20:37Z', 'ain` `77bad79`, lease naming this session to ')
('L-039', 'sched-ok', '17:50', '20:10Z', 'get_session`): `five_hour` `allowed`, resets ')
('L-040', 'FUTURE', '18:09', '20:50Z', 'n` `483ca01`: the lease naming its parent to ')
('L-040', 'sched-ok', '18:09', '20:10Z', '2Z and 18:08Z: `five_hour` `allowed`, resets ')
('L-040', 'sched-ok', '18:09', '20:53Z', 'Z in record PR #55 (state file only), expiry ')
('L-041', 'sched-ok', '18:21', '20:10Z', 'e** at 18:08Z: `five_hour` `allowed`, resets ')
```

## Re-run pinned at `d69d7c6` (W-C00-12 tranche 1b-ii; R-W12-2 m-7)

**Written:** 2026-10-03T20:37Z by run `session_01CmCKBkyHynQ27CwqkiviC6`, in a clone with full history (`git fetch --unshallow` first; `git rev-parse --is-shallow-repository` printed `false`). The script above was run unchanged except that `"origin/main"` was replaced by `"d69d7c6"`, as m-7 asks. Output:

```text
times per entry (L-040,L-041): 9 8 total 67 entries 17
('L-027', 'FUTURE', '19:58', '23:05Z', 'after this entry is merged. Lease renewed to ')
('L-028', 'FUTURE', '20:01', '20:05Z', 'nutes in the future. The builder had written ')
('L-031', 'FUTURE', '20:48', '2026-10-03T17:15Z', ' wake-up.** `trig_01PPvVV1VzS8o5fBWWRtvFZj` (')
('L-031', 'FUTURE', '20:48', '2026-10-01T20:57Z', 'successor `trig_01W2ujJKa95rUkY5MVF1FS7X` at ')
('L-032', 'sched-ok', '20:59', '2026-10-03T17:00Z', ' Usage `seven_day` `allowed_warning`, resets ')
('L-032', 'sched-ok', '20:59', '23:59Z', '** taken in this record PR at 20:59Z, expiry ')
('L-033', 'sched-ok', '21:05', '2026-10-03T17:00Z', 'seven_day` `allowed_warning` (21:03Z), reset ')
('L-033', 'FUTURE', '21:05', '2026-10-03T17:15Z', '6LPhKPWX9oYmaACVsyBx` into the dispatcher at ')
('L-033', 'sched-ok', '00:49', '2026-10-03T17:00Z', 'warning` holds heavy work until the reset at ')
('L-033', 'sched-ok', '06:49', '2026-10-03T17:00Z', 'lowed_warning` holds them until the reset at ')
('L-036', 'sched-ok', '17:23', '20:19Z', ' #49 (state file only, L-032 lesson), expiry ')
('L-037', 'sched-ok', '17:31', '22:10Z', 'lan package) and one unconverted reset time (')
('L-037', 'FUTURE', '17:31', '20:10Z', 'ne unconverted reset time (22:10Z instead of ')
('L-039', 'FUTURE', '17:50', '20:37Z', 'ain` `77bad79`, lease naming this session to ')
('L-039', 'sched-ok', '17:50', '20:10Z', 'get_session`): `five_hour` `allowed`, resets ')
('L-040', 'FUTURE', '18:09', '20:50Z', 'n` `483ca01`: the lease naming its parent to ')
('L-040', 'sched-ok', '18:09', '20:10Z', '2Z and 18:08Z: `five_hour` `allowed`, resets ')
('L-040', 'sched-ok', '18:09', '20:53Z', 'Z in record PR #55 (state file only), expiry ')
('L-041', 'sched-ok', '18:21', '20:10Z', 'e** at 18:08Z: `five_hour` `allowed`, resets ')
```

**Correction** (supersedes the output block above for use by T-M7c): two rows differ from the first run. (1) L-027's commit time is 19:58, not 20:17 (R-W12-2 m-7 reported 20:48 at `d69d7c6`). (2) A nineteenth row appears: L-028's quoted `20:05Z` against its 20:01 commit; it quotes the future stamp of the L-028 incident itself, a quoted time later than its commit, which M-R14 rejects without a date or `sched:` mark. Likely cause, not verified: the first run and the reviewer's ran in shallow clones, where `git blame` attributes lines older than the shallow boundary to the boundary commit. The counts line is unchanged (67 times in 17 entries; 9 and 8). T-M7c (a) uses these 19 rows as its expected set, and the gate script refuses to run it in a shallow clone.
