---
id: 0004
title: Fix conftest.py on_frame callback signature regression from PR #79
status: done
priority: medium
area: testing
created: 2026-06-24
mirror:
---

## Goal

Fix `test/pytest/conftest.py` so `on_frame` matches the current callback API
and `test_pars.py` can actually run.

## Root cause

`conftest.py` was added in upstream PR #57 (May 2024) when the frame callback
was called as `callback(comp, data)` — two args, comp first.

Upstream PR #79 (Aug 2024, "Time and callback updates") refactored all callback
bindings. `setOnFrameCallback` now calls `doCallback(self, callback, data)`,
which invokes `pythonCallback(dataPyObj)` — one arg, the data object only. The
comp reference was dropped from the Python-facing call.

`conftest.py` was never updated. `on_frame(comp, notused)` expects two args;
the binding delivers one. The suite has been silently broken since PR #79 on
all platforms.

## Fix (2026-06-24)

- `on_frame(comp, notused)` → `on_frame(comp)` — drop unused second param
- `comp.set_on_frame_callback(on_frame, fluffdata)` → `comp.set_on_frame_callback(on_frame, comp)` — pass comp as data so the callback can call comp.stop() / comp.start_next_frame()
- `fluffdata = {}` removed — never used

## Acceptance criteria

- [x] `test/pytest/test_pars.py` fixture setup no longer raises TypeError
- [x] All 12 `test_pars` tests reach the assertion stage

## Notes

Candidate for upstream PR against IntentDev/touchpy. The fix is two lines and
unambiguously correct — the old signature cannot work with the current binding.
