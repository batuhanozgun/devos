# usage: python3 -I run_state.py <state label> <mode> [<mode> ...]
# For each mode: build the step script (make_step.py), run it with bash, keep its stdout/stderr/exit code, check the
# listing.sql the step wrote against the extraction from migrate.yml at 421f6e7, and evaluate. Then the derived file
# run as one statement, compared with the as-is step listing.
import sys, subprocess, filecmp, os
B = "/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/prb10"
state, modes = sys.argv[1], sys.argv[2:]
for mode in modes:
    wd = f"{B}/p2/{state}_{mode}"
    sh = f"{B}/p2/{state}_{mode}_step.sh"
    subprocess.run(["python3", "-I", f"{B}/scripts/make_step.py", f"{B}/migrate_421f6e7.yml", "devos-test", wd, sh, mode], check=True)
    p = subprocess.run(["bash", sh], capture_output=True, text=True)
    open(f"{wd}.stdout", "w").write(p.stdout); open(f"{wd}.stderr", "w").write(p.stderr)
    print(f"=== {state} {mode}: step exit={p.returncode}; stdout {wd}.stdout")
    print(p.stdout, end=""); print("stderr:", repr(p.stderr))
    print("github_output:", repr(open(f"{wd}/github_output").read()) if os.path.exists(f"{wd}/github_output") else None)
    print("listing.sql written by the step == extraction at 421f6e7:", filecmp.cmp(f"{wd}/listing.sql", f"{B}/p1/m421_devos-test_listing.sql", shallow=False))
    args = ["python3", "-I", f"{B}/scripts/evaluate.py", wd]
    if mode == "asis":
        d = subprocess.run(["python3", "-I", f"{B}/scripts/run_derived.py", f"{B}/p1/derived_at_421f6e7.sql", f"{B}/p2/{state}_derived.out"], capture_output=True, text=True)
        print(d.stdout, end=""); args.append(f"{B}/p2/{state}_derived.out")
    e = subprocess.run(args, capture_output=True, text=True)
    open(f"{wd}.eval", "w").write(e.stdout + e.stderr)
    print(e.stdout, end=""); print(e.stderr, end="")
