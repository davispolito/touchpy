---
id: 0009
title: Build output ABI (cpython-314) mismatches downstream project venvs (3.11)
status: todo
priority: medium
area: build
created: 2026-07-12
mirror:
---

## Goal

`build/touchpy.cpython-314-darwin.so` is compiled for Python 3.14, but downstream project test scaffolds (`metal-volume`, `gd_art_v1.1`, and the `/start-td-project` touchpy wiring generally) create `uv` venvs pinned to `requires-python = ">=3.11"`. `import touchpy` fails with `ModuleNotFoundError` at collection time — before tests can even reach their `.tox`-missing skip logic — because Python's import machinery won't load a `.so` built for a different interpreter ABI.

## Acceptance criteria

- [ ] Decide the fix direction: rebuild touchpy for 3.11 (matching downstream `requires-python`), or bump downstream `pyproject.toml` files to require 3.14 to match the current build
- [ ] Whichever direction is chosen, document the required Python version for touchpy consumers somewhere discoverable (README or docs/)
- [ ] Verify `./scripts/test.sh` runs (even if all tests skip on empty `exports/`) in at least one downstream project after the fix

## Notes

Found while wiring `gd_art_v1.1` via `/start-td-project`. Same `touchpy` sourcing pattern in `metal-volume/pyproject.toml` has the identical gap, so this isn't project-specific — it's a standing mismatch between the touchpy build output and the scaffold template's default Python constraint.
