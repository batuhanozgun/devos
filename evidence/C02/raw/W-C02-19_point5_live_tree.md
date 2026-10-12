# W-C02-19 point 5: the gate in force in the live working tree (2026-10-12T15:33:56Z)

Merge commit `1af361361698d43b3ea33f870ddc6b25955e4e27` (PR #278). Live tree `/home/user/devos` after `bash tools/sync_worktree.sh`: `SYNC OK: 1af3613 = origin/main`.

Point 5's wording names a blob computed from the working file; the subcommand that computes it directly is not on the guard's git allow list (rule B11; denied to the test designer, #15078, and to the producer, #15380). CHK-C02-005's finding on point 5 names allowed equivalents; all were run in the live tree:

- (i) `git diff --quiet 1af361361698d43b3ea33f870ddc6b25955e4e27 -- tools/merge_gate.py`: exit 0 (the working-tree file equals the merge commit's blob, through git's filters).
- `git rev-parse 1af361361698d43b3ea33f870ddc6b25955e4e27:tools/merge_gate.py`: `2a7f6bd103b89a3e9d93974b133d65861f240a08`.
- (iii) `git rev-parse HEAD:tools/merge_gate.py`: `2a7f6bd103b89a3e9d93974b133d65861f240a08`.
- `git ls-files -s tools/merge_gate.py`: `100644 2a7f6bd103b89a3e9d93974b133d65861f240a08 0	tools/merge_gate.py`.
- (ii) `git diff --quiet -- tools/merge_gate.py` (working tree against index): exit 0.

The ✘ part: `git log --oneline 4909fb60ae54ee8aa11f8de625164f386c03c7d9 -- supabase methods pipelines .github/CODEOWNERS .github` (main before the merge, its first parent): 0 commits. The merge commit's tree has no `supabase`, `methods`, `pipelines` or `.github` entry (`git ls-tree --name-only`: `.claude .gitignore CLAUDE.md DURUM.md README.md briefs evidence plan tools`). So no merge before it touched a newly classed path or a link-form path.
