---
id: 0007
title: Add output-TOP test tox for readback testing
status: done
priority: medium
area: testing
created: 2026-06-24
mirror:
---

## Goal

`test_tops.py::test_out_top_readback` is permanently skipped because no `.tox` in `test/tox/` exports texture links. A minimal tox with at least one output TOP is needed so the readback path runs in CI without requiring `TOP_TOX` env var.

## Acceptance criteria

- [x] `test/tox/test_top.tox` committed — minimal Noise or Constant TOP wired to an output select
- [x] TOP readback tests run without setting `TOP_TOX`
- [x] Test asserts correct shape, dtype, and non-zero pixel values

## Notes

Create the tox in TouchDesigner. A single Noise TOP → Out TOP is sufficient. The test already handles the readback assertion logic — just needs the tox path wired in as the default.

## Progress

### 2026-06-28 13:22

- `test/pytest/test_tops.py` now defaults `test_out_top_readback` to `test/tox/test_top.tox` while preserving the `TOP_TOX` override.
- The readback test now skips with an explicit missing-fixture reason when `test_top.tox` is absent.
- Added a non-zero pixel assertion for the readback array.
- Still open: create/export `test/tox/test_top.tox` from TouchDesigner and run the real TouchEngine readback test.

### 2026-06-28 14:30

- Added a limited `test-template/` TouchDesigner harness following the `td-tools` pattern.
- The harness is intended for authoring/exporting pytest `.tox` fixtures, especially `test/tox/test_top.tox`.
- Still open: open the harness in TouchDesigner, build the Constant TOP -> Out TOP fixture, export `test_top.tox`, and run the real readback test.

### 2026-06-28 14:58

- Used Envoy on port 9875 to create `/project1/test_top_fixture`.
- Fixture network is `constant1` TOP -> `out1` TOP.
- `constant1` is configured as a 64x64 custom-resolution TOP with non-black RGBA color.
- Verified live TD network has no errors or warnings.
- Captured `/project1/test_top_fixture/out1` successfully as a 64x64 PNG through Envoy.
- Externalized the COMP with Embody as `test-template/project1/test_top_fixture.tox`.
- Saved the pytest fixture copy to `test/tox/test_top.tox`.
- Added `numpy` to the dev optional dependency because `test_out_top_readback` imports numpy.
- Still open: `test_out_top_readback` reaches `tp.Comp(test_top.tox)` but fails in this shell because TouchEngine cannot configure the instance / Metal default device (`MTLCreateSystemDefaultDevice returned nil`, then `TouchEngine could not be found to open the file`; explicit `td_path` gets farther but hangs after TouchEngine reports the process crashed or stopped responding).

### 2026-06-28 16:08

- Investigated `MTLCreateSystemDefaultDevice returned nil`; confirmed the Mac has an Apple M5 Pro Metal device and the nil device only occurs under the command sandbox. Unsandboxed TouchEngine runs associate the Metal context successfully.
- Split the previous broad TOP readback test into smaller pytest checks for fixture link discovery, frame-start resume precondition, resumed texture production, and numpy readback.
- Updated the readback path to use `CompFlags.INTERNAL_TIME`, drain the initial layout, call `start()`, then assert `start_next_frame()` succeeds before polling.
- Verified `test/pytest/test_tops.py` passes without `TOP_TOX`: `8 passed in 39.56s` with `DYLD_FRAMEWORK_PATH` and `PYTHONPATH` set for the local build.

### 2026-06-28 16:20

- Added `scripts/test-macos-runtime.sh` as the repeatable local macOS pytest runner.
- The script sets `DYLD_FRAMEWORK_PATH`, `PYTHONPATH`, validates the local Python/build/TouchEngine paths, and passes arguments through to pytest.
- Documented that Metal/TouchEngine tests must run from a normal local shell or unsandboxed automation context because sandboxed execution can make `MTLCreateSystemDefaultDevice()` return nil.
- Verified the runner with `scripts/test-macos-runtime.sh test/pytest/test_tops.py -q -rs`: `8 passed in 39.26s`.

### 2026-06-29

- Committed the TOP readback fixture, runtime runner, and split pytest coverage in `acf1053`.
