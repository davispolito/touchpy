# Testing and Runtime

## Test Suite Structure

TouchPy has three test layers:

```
test/
  gtest/         C++ unit tests (GoogleTest) — Windows-runnable, macOS blocked
  pytest/        Python integration tests (pytest) — require live TouchEngine runtime
  tox/           TouchDesigner test component + reference values
```

---

## C++ Unit Tests (GoogleTest)

**Location:** `test/gtest/`

**Build target:** `touchpygtest` executable (added via `add_executable` in `CMakeLists.txt`)

**Test files:**

| File | What it covers |
|------|----------------|
| `compflags_gtest.cpp` | `CompFlags` bitmask construction, `flags()`, `setFlags()` |
| `chopchannels_gtest.cpp` | `ChopChannels` data layout and access |
| `color_gtest.cpp` | `Color` struct layout and standard-layout assertions |
| `cudaflags_gtest.cpp` | CUDA flag bitmask (Windows; excluded on macOS) |
| `logging_gtest.cpp` | `initLogging` / `setLogLevel` |
| `comp_gtest.cpp` | `Comp` construction and basic lifecycle |

**GoogleTest version:** v1.15.2, fetched via `FetchContent`.

### macOS Status: Blocked

`-DSKBUILD=ON` skips the GoogleTest `FetchContent` block entirely. gtest 1.15.2 does not compile under AppleClang 21 (Xcode 26). Do not run `./build/touchpygtest` on macOS — the binary is not built.

**To re-enable:** Bump gtest to a version that supports AppleClang 21 and remove the `SKBUILD` guard around the FetchContent block. Track in tasks/README.md.

### Running (Windows)

```bash
cmake -B build -S .
cmake --build build
./build/touchpygtest
```

---

## Python Integration Tests (pytest)

**Location:** `test/pytest/`

**Files:**
- `conftest.py` — session-scoped fixtures: `comp`, `ref`, `stopcomp`
- `test_pars.py` — parameter read/write assertions against `ref` fixture
- `test_comp_construct.py` — `Comp()` constructor overload smoke tests (added 2026-06-24)

### Fixtures

| Fixture | Scope | What it does |
|---------|-------|-------------|
| `comp` | session | Loads `test/tox/test.tox`, registers `on_frame` callback, calls `start()` |
| `ref` | session | Reads `test/tox/parvalues.json` as expected-value reference dict |
| `stopcomp` | session | Calls `comp.stop()` after test session |

The `on_frame` callback advances one frame via `start_next_frame()` and stops. When `keyboard` is available and has OS-level access, pressing `q` also stops the loop (interactive use). In headless/CI contexts the `keyboard` check is skipped silently.

### Runtime Requirement

**A live TouchEngine runtime must be present.** The pytest suite loads an actual `.tox` file via `tp.Comp` and drives real frames. There is no mock — a missing or mismatched TouchEngine will cause the `comp` fixture to hang or raise.

**macOS:** `TouchEngine.framework` is bundled at `external/TouchEngine-macOS/`. It must be linked and accessible at runtime (handled by CMake on the macOS build path). TouchDesigner must be installed — TouchEngine auto-discovers it at `/Applications/TouchDesigner *.app`. Do **not** pass `td_path` pointing to the binary inside the bundle; pass the `.app` path or leave it empty for auto-discovery.

**macOS codesign note:** After `git submodule update`, re-sign the framework before running:
```bash
codesign --force --deep --sign - external/TouchEngine-macOS/TouchEngine.framework
```

**Windows:** TouchDesigner must be installed. `preferredEnginePath` on `Comp` can override the default search path.

### Running (macOS)

```bash
# From repo root, after building touchpy
scripts/test-macos-runtime.sh -v
```

The script exports `DYLD_FRAMEWORK_PATH=external/TouchEngine-macOS` and `PYTHONPATH=build` before invoking `.venv/bin/python -m pytest`. Override `PYTHON_BIN`, `BUILD_DIR`, or `TOUCHENGINE_DIR` when testing a different build.

Metal/TouchEngine runtime tests need direct access to the local GPU and framework resources. Sandboxed command runners can make `MTLCreateSystemDefaultDevice()` return nil even when the machine has a valid Metal device; run this script from a normal local shell or an unsandboxed automation context.

### macOS test status (verified 2026-06-24)

| Suite | Result |
|-------|--------|
| `test_comp_construct.py` | 6/6 pass |
| `test_pars.py` | 11/12 pass — `test_stop` fails (pre-existing upstream double-stop bug, not a port regression) |
| `test_tops.py` | 8/8 pass — requires Metal/TouchEngine runtime access |

---

## TouchDesigner Test Component

**Location:** `test/tox/`

| File | Purpose |
|------|---------|
| `test.tox` | TouchDesigner component loaded by the pytest suite |
| `test_top.tox` | Minimal Constant TOP -> Out TOP fixture for TOP readback tests |
| `parvalues.json` | Expected parameter values used as `ref` fixture in assertions |
| `modules/TestExt.py` | TouchDesigner Python extension wired into `test.tox` |

The `.tox` is the ground truth for integration tests — parameter names and expected values in `parvalues.json` must stay in sync with whatever is defined in `test.tox`.

---

## TouchDesigner Test Harness

**Location:** `test-template/`

`test-template/td-template.toe` is a minimal TouchDesigner authoring harness, copied from the same td-template pattern used by `td-tools`. Use it when creating or maintaining `.tox` fixtures for the pytest suite, including `test/tox/test_top.tox`.

Tracked harness files:

| File | Purpose |
|------|---------|
| `test-template/td-template.toe` | TouchDesigner project for authoring test fixtures |
| `test-template/Embody-v6.0.57.tox` | Embody component used by the harness |
| `test-template/TDPyEnvManagerContext.yaml` | TD Python environment context; includes `../td-tools/src` for helper imports |
| `.embody/project.json` | Embody project metadata for this repo |

Generated files such as `test-template/.venv/`, `test-template/logs/`, `test-template/TDImportCache/`, and `.mcp.json` are intentionally ignored.

---

## Runtime Requirements Summary

| Platform | Requirement |
|----------|-------------|
| macOS | `TouchEngine.framework` at `external/TouchEngine-macOS/` (submodule, init with `git submodule update --init`) |
| Windows | TouchDesigner installation discoverable on PATH, or `td_path` passed to `Comp()` |
| Both | Python venv with `touchpy` built and importable |
| pytest only | `numpy` for TOP ndarray assertions; `keyboard` is optional interactive escape and silently skipped if unavailable or no OS access |
