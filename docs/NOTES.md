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
| `comp.cpp` | `info/warn/error` — ~40 call sites | blocked (vulkan/cuda headers) |
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

## Notes

- [Architecture overview](architecture-overview.md) — build system, C++/CUDA/Vulkan/Python layer structure, macOS port strategy
- [API contract](api-contract.md) — public Python API surface, type contracts, link types (TOP/CHOP/DAT/Par)
- [Testing and runtime](testing-and-runtime.md) — gtest suite, Python test harness, TouchEngine runtime requirements
- [Reference material](reference-material.md) — upstream repos, SDK links, TouchEngine-macOS framework, related prior art
