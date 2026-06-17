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

## Notes

- [Architecture overview](architecture-overview.md) — build system, C++/CUDA/Vulkan/Python layer structure, macOS port strategy
- [API contract](api-contract.md) — public Python API surface, type contracts, link types (TOP/CHOP/DAT/Par)
- [Testing and runtime](testing-and-runtime.md) — gtest suite, Python test harness, TouchEngine runtime requirements
- [Reference material](reference-material.md) — upstream repos, SDK links, TouchEngine-macOS framework, related prior art
