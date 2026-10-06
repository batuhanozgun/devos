#!/usr/bin/env python3
"""Count-only probe-token scan for C01 row 3 (EV-C01-002 item 4, decision L).

It answers one question without ever revealing a value: how many places readable
from this probe session hold a string in the probe-token format
``^dvs_probe_[0-9a-f]{32}$``. It prints ONLY counts, never a token, a fragment,
a hash, a length, a prefix or any other derivative of a value, and never the
contents of any variable or file.

Why this exists. A plain read of the environment or a credential file (``env``,
``cat`` of a token file, ``curl -v``) stays denied by the guard (B8, F4) and
would put a value into the transcript. Row 3 still needs to show that the probe
token is NOT visible to the session by these routes. This scanner is the
value-free way to check, run with the fixed argv
``python3 -I evidence/C01/probe/probe_token_scan.py`` (EV-C01-002, the probe-only
guard rule's allowance 2), and nothing it prints is a value. Run with ``-I``
(isolated) so no module in the working directory can shadow the standard library.

It is a probe artefact for C01 only. It is NOT part of DevOS and is never run
outside a C01 probe session.
"""
import os
import re
import sys

TOKEN = re.compile(r"^dvs_probe_[0-9a-f]{32}$")
# The credential files the guard names in the home directory (CREDENTIAL_PATHS and
# CRED_BASENAMES); /proc/self/environ is counted by scan_proc_environ. The probe
# passes no path of its own.
CRED_FILES = (
    os.path.expanduser("~/.git-credentials"),
    os.path.expanduser("~/.netrc"),
    os.path.expanduser("~/.config/gh/hosts.yml"),
)


def count_matches(values):
    """Number of whole values that match the token format. Values are never kept."""
    n = 0
    for v in values:
        if TOKEN.fullmatch(v.strip()):
            n += 1
    return n


def scan_environ():
    """os.environ values. The NAMES are not a value; count matches only."""
    return count_matches(os.environ.values())


def scan_proc_environ():
    """/proc/self/environ: NUL-separated KEY=VALUE pairs."""
    total = 0
    for path in ("/proc/self/environ",):
        try:
            with open(path, "rb") as f:
                raw = f.read()
        except OSError:
            continue
        pairs = raw.split(b"\x00")
        vals = []
        for p in pairs:
            if b"=" in p:
                try:
                    vals.append(p.split(b"=", 1)[1].decode("utf-8", "replace"))
                except Exception:
                    pass
        total += count_matches(vals)
    return total


def scan_files():
    """Known credential files: count LINES that are a whole token; never show one."""
    total = 0
    for path in CRED_FILES:
        try:
            with open(path, "r", encoding="utf-8", errors="replace") as f:
                lines = f.read().splitlines()
        except OSError:
            continue
        total += count_matches(lines)
    return total


def main():
    # Guard the invocation: refuse any argument, so the allowed argv is exactly
    # `python3 -I evidence/C01/probe/probe_token_scan.py` and nothing is passed
    # that could widen the scan or exfiltrate a value.
    if len(sys.argv) != 1:
        print("probe_token_scan takes no arguments", file=sys.stderr)
        return 2
    env_hits = scan_environ()
    proc_hits = scan_proc_environ()
    file_hits = scan_files()
    # Counts only. Expected result for a correctly isolated token: all zero,
    # because the token rides in the X-Probe-Token request header attached by the
    # environment's API credential OUTSIDE the session (plan 6.3; EV-C01-002).
    print("env_values_matching_token_format=%d" % env_hits)
    print("proc_self_environ_values_matching_token_format=%d" % proc_hits)
    print("credential_file_lines_matching_token_format=%d" % file_hits)
    return 0


if __name__ == "__main__":
    sys.exit(main())
