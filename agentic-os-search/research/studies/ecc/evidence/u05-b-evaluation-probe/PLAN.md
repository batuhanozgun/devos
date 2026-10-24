# E04 — Skill amendment evaluator boundary probe

Prepared before execution on 2026-09-17 for U05-B. Target: ECC pin `8321021c54d670126ce3b2969d5deb880b4b0c2a`.

## Question and oracle

Does the original improvement evaluator distinguish a positive recorded-rate difference from valid evidence of a better amendment? Do its minimum count and amendment selector actually restrict recommendations? Does the proposal require repeated failures?

Run three exact source modules (health, amendify, evaluate), reconstituted from complete GitHub connector content and verified against canonical Git blob IDs. No rewritten target logic or mocked target dependencies: amendify imports original health; all other dependencies are Node built-ins. The fixtures are synthetic schema-shaped records, not actual task executions or observations validated by an external judge.

Predeclared cases and expected outputs:

- C00: empty input -> insufficient-data evaluation and insufficient-evidence proposal.
- C01: one baseline and one amended record -> insufficient-data at default count two.
- C02: two distinct paired tasks, baseline one of two successful, amended two of two -> promote-amendment.
- C03: reversing recorded improvement -> keep-baseline.
- C04: equal recorded rates -> keep-baseline.
- C05: duplicate the very same baseline and amended observation IDs -> counts two per variant and promote-amendment despite only two unique observation IDs overall.
- C06: keep C02 outcomes, change amended tasks to unrelated/easier labelled tasks -> same promote-amendment; no comparability qualification in output. Labels do not measure actual task difficulty.
- C07: two amended records belonging to different amendments -> unfiltered promote-amendment; selecting just one amendment -> insufficient-data. The explicit selector is a real control, not an authenticated/version-bound experiment.
- C08: one failure -> proposed, including when minFailureCount is ten; returned rationale still says repeated failed runs. A no-failure control in C00 must reject.

A matched expectation is evidence of deterministic behavior, NOT a product-quality PASS. C05/C06 challenge the stronger interpretation of the output, not an upstream promise that the scaffold performs causal evaluation. Preserve all fixtures, outputs and any unexpected results. No post-result threshold/fixture changes to obtain a pass. No native host, model, hooks, user files, installation, network, upstream test suite, automatic skill patch, or E01–E03 rerun. This fixture does not exercise the observation writer/reader, automatic tracker, dashboard or versioning; those remain source-only.
