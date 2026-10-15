# counter-safety-study

Adapted from [qritwik/thesis-formalization](https://github.com/qritwik/thesis-formalization).
Original commit history is preserved. This repository is a downstream edition
of the same project.

Demonstration thesis: safety of a bounded counter under arbitrarily many transitions.

## Run

Install [elan](https://github.com/leanprover/elan), then from this directory:

```sh
lake build
python3 scripts/check_proofs.py
```

The toolchain is pinned in `lean-toolchain`; `lake build` checks both the library
and the regression proof module. CI uses the same commands with warnings treated
as errors. No compiled artifacts belong in Git.

## Scope

This is a new, small formalization project, with its guarantees limited to the
precise Lean theorem statements. It does not establish facts about external
software or physical systems. See the source docstrings and `docs/design.md`.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). No license has been selected; no additional
redistribution permissions are granted by this repository.

Compiler baseline: Lean 4.33.0-rc1 (a pinned release candidate). Upgrade the
compiler deliberately and rerun verification before adopting a stable release.
