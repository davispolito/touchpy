# TouchPy Implementation Notes

Repo-local implementation notes for `touchpy`. Treat this folder like the project's git wiki: durable explanations of runtime behavior, generated files, callback routing, integration boundaries, and compatibility decisions that should travel with the code.

> Note: `docs/source/` is a Sphinx API docs build (separate concern). The files below are implementation notes only.

Development tasks live in [`../tasks/`](../tasks/) and are canonical there.

## Known Issues

### spdlog bundled fmtlib consteval failure (AppleClang 21 / C++20)

**Symptom:** Build fails in `spdlog-src/src/bundled_fmtlib_format.cpp` with:
```
error: call to consteval function '...' is not a constant expression
```

**Root cause:** `CMAKE_CXX_STANDARD 20` set globally propagates to FetchContent
targets, including spdlog's bundled fmtlib. Spdlog v1.15.0 bundles a fmtlib
version that uses `FMT_STRING` macros generating `consteval` calls that
AppleClang 21 (Xcode 26) rejects under its stricter consteval evaluation rules.

**Fix:** Set C++20 per-target on `touchpy` only (after `nanobind_add_module`),
keeping the global standard at 17 so spdlog compiles unaffected:
```cmake
if(TOUCHPY_MACOS)
    set_target_properties(touchpy PROPERTIES CXX_STANDARD 20 CXX_STANDARD_REQUIRED ON)
endif()
```

**Alternatives not taken:**
- Bump spdlog to a newer tag with fixed fmtlib — deferred, requires validation
- `SPDLOG_FMT_EXTERNAL` — adds a system fmtlib dependency, undesirable for a distributable wheel

**Why per-target C++20 doesn't work either:** `logging.h` includes `<spdlog/spdlog.h>`
directly. Every translation unit in the `touchpy` target that includes `logging.h`
pulls in the fmtlib headers. Setting `CXX_STANDARD 20` on the target compiles all
those TUs at C++20, so the consteval issue surfaces in the consumer files
(`choplink.cpp`, `comp.cpp`, etc.), not just `spdlog-src/`. The fix must happen
at the spdlog/fmtlib level (tasks 0002, 0003).

### spdlog dependency surface (audited 2026-06-16)

All spdlog usage is funnelled through `source/logging.h` — the only file that
includes spdlog headers directly. Every other file includes `logging.h`.

Files that `#include "logging.h"` and their call patterns:

| File | Calls | macOS port status |
|------|-------|-------------------|
| `logging.cpp` | `initLogging()`, `setLogLevel()`, sink setup | compiles |
| `comp.cpp` | `info/warn/error` — ~40 call sites | guarded (task 0001) |
| `chopchannels.cpp` | include only, no direct calls | compiles |
| `choplink.cpp` | `error` — 1 site | compiles |
| `datlink.cpp` | `error` — 2 sites | compiles |
| `dattable.cpp` | include only | compiles |
| `toplink.cpp` | `error` — 3 sites | excluded (cuda) |
| `texture.cpp` | `error` — 1 site | excluded (cuda) |
| `renderer.cpp` | `error/debug` — 6 sites | excluded (vulkan) |
| `deviceinfo.h` | `debug` — 1 site | excluded (cuda) |
| `pybindings/touchpy.cpp` | exposes `LogLevel` enum + `init_logging`/`set_log_level` to Python | compiles |
| `vri/vri.cpp` | `debug/error` — heavily used | excluded (vulkan) |
| `vri/vri_macros.h` | `error` in `VK_CHECK` macro | excluded (vulkan) |

The macOS-compilable files that use logging (`choplink.cpp`, `datlink.cpp`,
`dattable.cpp`, `chopchannels.cpp`, `pybindings/touchpy.cpp`) are all low-call-site
consumers. The heavy logging is in `comp.cpp` and `vri/` — both blocked by
platform guards anyway.

### teutils.h — TEVulkan.h hidden dependency (fixed 2026-06-16)

`teutils.h` unconditionally included `<TouchEngine/TEVulkan.h>`, which pulls in
`vulkan/vulkan.h`. That header is not available on macOS (no Vulkan SDK). Fixed
with `#ifndef TOUCHPY_MACOS` guard around the include. This was not in the original
task 0001 plan — discovered during the build iteration.

### choplinkpy.cpp — variable shadowing in `fromNumpyToChopLink` (fixed 2026-06-24)

`std::vector<const float*> channels` was declared, then `ChopChannelsView channels(...)`
was constructed in the same scope using `std::move(channels)`. The compiler resolved
`channels` in the initializer as the `ChopChannelsView` being declared rather than the
vector, causing a type mismatch. Fixed by renaming the vector to `channelPtrs`.

### comppy.cpp — CUDA/TOP bindings not guarded (fixed 2026-06-24)

`cuda_device`, `in_tops`, `out_tops`, and `cuda_stream` nanobind bindings referenced
`Comp` members that are guarded away on macOS (`cudaDeviceIndex`, `inputTopLinks`,
`outputTopLinks`, `cudaStream`). Fixed with `#ifndef TOUCHPY_MACOS` guards around
those four `.def`/`.def_prop_ro` calls in `initCompBindings`.

### utils/utils.h — missing iostream/iomanip (fixed 2026-06-24)

`printTypeInfo<T>()` uses `std::cout`, `std::setw`, `std::endl` but the header only
included `<cstdio>`. On Windows these were transitively available through other
Windows SDK headers. Fixed by adding explicit `<iostream>`, `<iomanip>`, and
`<cstring>` includes.

### TouchEngine.framework — unsigned library rejected at dlopen (runtime, 2026-06-24)

The framework bundled in `external/TouchEngine-macOS/` carries no valid code signature.
macOS rejects it at `dlopen` time with "not valid for use in process: Trying to load
an unsigned library".

**Development workaround:** ad-hoc codesign after each `git submodule update`:

```bash
codesign --force --deep --sign - external/TouchEngine-macOS/TouchEngine.framework
```

This is not committed — it only affects the local working tree. Re-run whenever the
submodule is refreshed. Distribution builds will require a proper Apple Developer
signing identity.

## Notes

- [Architecture overview](architecture-overview.md) — build system, C++/CUDA/Vulkan/Python layer structure, macOS port strategy
- [API contract](api-contract.md) — public Python API surface, type contracts, link types (TOP/CHOP/DAT/Par)
- [Testing and runtime](testing-and-runtime.md) — gtest suite, Python test harness, TouchEngine runtime requirements
- [Reference material](reference-material.md) — upstream repos, SDK links, TouchEngine-macOS framework, related prior art
