# Architecture Overview

## What TouchPy Is

TouchPy is a C++17 nanobind Python extension that wraps the TouchEngine SDK, allowing Python code to load, drive, and query TouchDesigner components (`.tox` files). It exposes the `touchpy` module with a `Comp` class as the primary entry point.

## Layer Stack

```
Python user code
       │
       │  import touchpy
       ▼
touchpy (nanobind module)          ← source/pybindings/touchpy.cpp
  ├─ Comp                          ← source/pybindings/comppy.cpp
  ├─ ChopLink / DatLink / ParLink  ← source/pybindings/{chop,dat,par}linkpy.cpp
  └─ TopLink (Windows only)        ← source/pybindings/toplinkpy.cpp
       │
       ▼
C++ core (source/)
  ├─ Comp        (comp.cpp/h)      — lifecycle, threading, callback routing
  ├─ Link        (link.h)          — CRTP base for all link types
  ├─ Links<T>    (links.h)         — typed collection: name/identifier/index lookup
  ├─ ChopLink    (choplink.h)      — float buffer I/O via TEFloatBuffer
  ├─ DatLink     (datlink.h)       — table/string I/O via TEObject
  ├─ ParLink     (parlink.h)       — parameter set/get, full type hierarchy
  └─ TopLink     (toplink.h)       — texture I/O (Windows/CUDA only)
       │
       ▼
TouchEngine SDK
  ├─ macOS: external/TouchEngine-macOS/TouchEngine.framework
  └─ Windows: external/TouchEngine-Windows/
       │
       ▼
GPU layer
  ├─ macOS:   Metal + Foundation frameworks
  └─ Windows: CUDA + Vulkan (source/vri/, source/renderer.cpp, source/texture.cpp)
```

## Comp Lifecycle

1. **Construct** — `Comp(tox_path, flags, fps, device, td_path)` or default then `load()`
2. **Load** — `TEInstanceCreate` → `TEInstanceConfigure` → async `onEventInstanceReady` → `onEventInstanceDidLoad`; link layout built from `TELinkInfo` callbacks
3. **Run frames** — caller drives via `start_next_frame()` (manual) or `CompFlags::AUTO_UPDATE` / `ASYNC_UPDATE` (internal thread)
4. **I/O** — set inputs before frame start; read outputs after `frame_did_finish()`
5. **Unload/Stop** — `stop()` → `unload()` → `TEInstanceSuspend` / `TEInstanceRelease`

## Threading Model

`Comp` runs on two threads simultaneously:

- **Main thread** — Python caller; owns link collections and frame pacing
- **TouchEngine thread** — fires `eventCallback` and `linkEventCallback` (static C callbacks registered with the SDK)

Shared state (`ssLoaded_`, `ssReady_`, `ssInFrame_`, pending output queues) is protected by `mutex_` + `condition_variable`. A second async thread (`asyncThread_`) handles `ASYNC_UPDATE` mode; it acquires the Python GIL via `nb::gil_scoped_acquire` before invoking Python callbacks.

## Frame Modes

| Flag | Behavior |
|------|----------|
| `INTERNAL_TIME_AUTO` | Internal clock + auto-update thread; caller just reacts to `on_frame` callback |
| `INTERNAL_TIME_ASYNC` | Internal clock + free-running async thread |
| `EXTERNAL_TIME` | Caller drives time explicitly via `start_next_frame(seconds)` or `start_next_frame(value, scale)` |

## Build System

Two paths:

| Path | Command | When to use |
|------|---------|-------------|
| Direct CMake | `cmake -B build -S . -DPython_EXECUTABLE=.venv/bin/python -DSKBUILD=ON` | C++ iteration — no wheel |
| scikit-build-core | `uv pip install -e ".[dev]"` | Python package / wheel |

`SKBUILD=ON` skips GoogleTest `FetchContent` (gtest 1.15.2 incompatible with AppleClang 21).

## macOS Port

The `dev-macos` branch ports from Windows (CUDA + Vulkan) to macOS (Metal + Foundation). All CUDA/Vulkan translation units are excluded at the CMake level and guarded by `#ifndef TOUCHPY_MACOS` in shared headers.

**Excluded on macOS:**
- `source/vri/` — Vulkan renderer
- `source/renderer.cpp/.h`, `texture.cpp/.h`, `cudamemory.cpp/.h`
- `source/toplink.cpp/.h`, `copykernels.cu/.cuh`
- `source/cudadatatypes.h`, `cudaflags.h`, `deviceinfo.h`, `common/cuda_helpers.h`
- `initTopLinkBindings()` — TOP link Python bindings

**macOS link line:** `TouchEngine.framework`, `Metal`, `Foundation`, `spdlog`

**Active task:** spdlog bundles fmtlib with `consteval` calls that AppleClang 21 rejects under C++20. The global standard is held at C++17; per-target C++20 is also blocked because `logging.h` propagates spdlog headers into all TUs. See `NOTES.md` — Known Issues for details and tasks 0002/0003.

## Key Header Dependencies

- `logging.h` — sole spdlog include point; all other files include this, not spdlog directly
- `teutils.h` — TouchEngine utility helpers; `TEVulkan.h` include is guarded by `#ifndef TOUCHPY_MACOS`
- `link.h` / `links.h` — CRTP + SFINAE-based collection (C++17; no concepts)
- `compflags.h` / `common/flags.h` — bitmask flag type via `ENABLE_BITMASK_OPERATORS`
