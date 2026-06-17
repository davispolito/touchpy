---
id: 0001
title: Source-level #ifdef __APPLE__ guards for CHOP/DAT/Par compile path
status: todo
priority: high
area: macos-port
created: 2026-06-16
mirror:
---

## Goal

Make the CHOP/DAT/Par Python API compile on macOS without CUDA or Vulkan headers.
CMakeLists.txt already excludes the GPU translation units (vri/, renderer, texture,
cudamemory, toplink, copykernels). The remaining blocker is that `comp.h` transitively
pulls in those excluded headers through unconditional #includes.

## Acceptance criteria

- [ ] `comp.h` compiles on macOS without CUDA or Vulkan headers in the include path
- [ ] `comppy.cpp` compiles on macOS (depends on comp.h)
- [ ] `choplinkpy.cpp`, `datlinkpy.cpp`, `parlinkpy.cpp` compile on macOS
- [ ] `cmake -B build -DCMAKE_BUILD_TYPE=Release` succeeds on Apple Silicon with no errors
- [ ] `import touchpy; comp = tp.Comp()` works in Python (CHOP/DAT/Par path only)
- [ ] TOPs deliberately not in scope — `initTopLinkBindings()` can be stubbed or ifdef'd out

## Notes

### What needs guarding

`comp.h` includes:
```cpp
#include "renderer.h"        // Vulkan-only — guard with #ifndef TOUCHPY_MACOS
#include "texture.h"         // CUDA+Vulkan — guard with #ifndef TOUCHPY_MACOS
#include "common/cuda_helpers.h"  // CUDA — guard with #ifndef TOUCHPY_MACOS
#include "toplink.h"         // CUDA+Vulkan — guard with #ifndef TOUCHPY_MACOS
```

`comp.cpp` uses Renderer singleton, cudaStream_t, and TopLink — all of those blocks
need `#ifndef TOUCHPY_MACOS` guards or empty macOS stubs.

`touchpy.cpp` calls `initTopLinkBindings()` via NB_MODULE — guard that call or
provide a no-op macOS stub in `toplinkpy.cpp`.

### Strategy

Add `#ifndef TOUCHPY_MACOS` / `#endif` around GPU-specific blocks. The `TOUCHPY_MACOS`
compile definition is already set by CMakeLists.txt on Darwin. Do not use `#ifdef __APPLE__`
directly — use `TOUCHPY_MACOS` so the definition is explicit and CMake-controlled.

### Files to edit

1. `source/comp.h` — guard four #include lines
2. `source/comp.cpp` — guard Renderer construction, cudaStream_t, TopLink usage
3. `source/pybindings/touchpy.cpp` — guard `initTopLinkBindings()` call in NB_MODULE
4. `source/pybindings/toplinkpy.cpp` — provide empty macOS stub for `initTopLinkBindings()`

## Blocked

Not blocked. CMakeLists.txt and submodule swap (task prereq) are complete as of 2026-06-16.
