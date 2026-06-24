---
id: 0001
title: Source-level TOUCHPY_MACOS guards for CHOP/DAT/Par compile path
status: done
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

- [x] `comp.h` compiles on macOS without CUDA or Vulkan headers in the include path
- [x] `comp.cpp` compiles on macOS (GPU blocks guarded)
- [x] `cmake --build build` succeeds on Apple Silicon with no errors (verified 2026-06-24)
- [x] `import touchpy; comp = tp.Comp()` works in Python (CHOP/DAT/Par path only, verified 2026-06-24)
- [x] TOPs deliberately not in scope — `initTopLinkBindings()` stubbed out on macOS

## Implementation (2026-06-16)

Guard macro: `#ifndef TOUCHPY_MACOS` / `#endif`. The `TOUCHPY_MACOS` compile definition
is set by CMakeLists.txt on Darwin. Do not use `#ifdef __APPLE__` directly — use
`TOUCHPY_MACOS` so it is explicit and CMake-controlled.

### source/comp.h

- Guarded `renderer.h`, `texture.h`, `common/cuda_helpers.h`, `toplink.h` includes
- Guarded `inputTopLinks()` / `outputTopLinks()` accessors
- Guarded `LARGE_INTEGER startTime` / `LARGE_INTEGER performanceCounterFrequency` in `Time` struct
- Guarded `cudaStream_t cudaStream() const` accessor
- Guarded `uint8_t cudaDeviceIndex() const` accessor
- Guarded private GPU members (`renderer_`, all `VkXxx` handles, `cudaStream_`, `cudaDevice_`)
- Guarded `inTopLinks_` / `outTopLinks_` unique_ptr members
- Guarded `createRenderer()`, `cudaInit()`, `setCudaDevice()` private method declarations

### source/comp.cpp

- `initComp()`: guarded `createRenderer()` and `cudaInit()` calls
- Destructor: guarded `cudaStreamDestroy` and `vkDestroyFence`
- `createRenderer()` and `cudaInit()` / `setCudaDevice()` entire bodies wrapped in `#ifndef TOUCHPY_MACOS`
- `initInstance()`: guarded `TEInstanceAssociateGraphicsContext` block
- `load(filePath, fps)`: replaced `if (!renderer_) initComp()` with platform conditional:
  ```cpp
  #ifndef TOUCHPY_MACOS
      if (!renderer_) initComp();
  #else
      if (!instance_) initComp();   // renderer_ doesn't exist; instance_ serves as init sentinel
  #endif
  ```
- `unload()`: guarded `cudaStreamSynchronize`
- `asyncUpdate()`: guarded `cudaSetDevice(cudaDevice_)`
- `applyOutputTextureChange()`: guarded entire body (uses `outTopLinks_`)
- `applyLayoutChange()`: guarded `inTopLinks_`/`outTopLinks_` construction; guarded `TELinkTypeTexture` block

### source/teutils.h  (extra file not in original plan)

- Guarded `<TouchEngine/TEVulkan.h>` include — unconditionally included Vulkan SDK headers
  not available on macOS

### source/pybindings/touchpy.cpp

- Guarded `extern void initTopLinkBindings(nb::module_& m)` declaration
- Guarded `initTopLinkBindings(m)` call in `NB_MODULE`

### source/pybindings/toplinkpy.cpp

- Wrapped entire CUDA/Vulkan content in `#ifndef TOUCHPY_MACOS`
- Added macOS no-op stub:
  ```cpp
  #else
  #include <nanobind/nanobind.h>
  namespace nb = nanobind;
  void initTopLinkBindings(nb::module_& m) {}
  #endif
  ```

### source/utils/utils.h

- Replaced C++20 template lambda in `forEach` with C++17-compatible helper:
  ```cpp
  namespace detail {
  template <class Tuple, class F, std::size_t... I>
  constexpr F forEach_impl(Tuple&&, F&&, std::index_sequence<I...>);
  }
  ```

## Notes

### Why `!instance_` not `!renderer_` in load()

On macOS, `renderer_` (a `std::shared_ptr<Renderer>`) is guarded away entirely.
`instance_` is a `TouchObject<TEInstance>` which has `operator T*() const` — so
`!instance_` evaluates to `true` when the underlying pointer is null, exactly like
`!renderer_` did on Windows. This is the correct lazy-init sentinel.

### Build command (macOS, 2026-06-16)

```bash
# GoogleTest 1.15.2 doesn't support AppleClang 21 — skip it with -DSKBUILD=ON
cmake -B build -S . -DCMAKE_BUILD_TYPE=Release \
    -DPython_EXECUTABLE=.venv/bin/python \
    -DSKBUILD=ON

cmake --build build
```

## Build verification (2026-06-24)

Three additional fixes were needed during the first full build pass:

### `source/pybindings/choplinkpy.cpp` — variable name shadowing

`fromNumpyToChopLink` declared `std::vector<const float*> channels`, then tried to
construct `ChopChannelsView channels(std::move(channels), ...)` in the same scope.
The compiler resolved `channels` in the initializer as the `ChopChannelsView` being
declared, not the vector, causing a type mismatch error. Fixed by renaming the vector
to `channelPtrs`.

### `source/pybindings/comppy.cpp` — CUDA/TOP bindings not guarded

`cuda_device`, `in_tops`, `out_tops`, and `cuda_stream` bindings referenced
`Comp::cudaDeviceIndex`, `Comp::inputTopLinks`, `Comp::outputTopLinks`, and
`Comp::cudaStream` — all of which are guarded away in `comp.h` on macOS. Fixed with
`#ifndef TOUCHPY_MACOS` guards around those four `.def`/`.def_prop_ro` calls.

### `source/utils/utils.h` — missing `<iostream>` and `<iomanip>`

`printTypeInfo<T>()` uses `std::cout`, `std::setw`, `std::endl` but the header did
not include `<iostream>` or `<iomanip>`. On Windows these were pulled in transitively
through other headers. Fixed by adding explicit includes (plus `<cstring>` for
`std::memcpy` used in `safeMemCpy`).

### TouchEngine.framework code signature

The framework in `external/TouchEngine-macOS/` has no valid code signature, so macOS
rejects it at `dlopen` time ("not valid for use in process: Trying to load an unsigned
library"). Fixed at development time with an ad-hoc signature:

```bash
codesign --force --deep --sign - external/TouchEngine-macOS/TouchEngine.framework
```

This must be re-run after `git submodule update` refreshes the framework. It is a
local-only workaround — the signature is not committed. Distribution will require a
proper Apple Developer signing identity.

### Verified output

```
import ok
Comp() ok: <touchpy.Comp object at 0x71b1a9000>
loaded: False
[info]: Comp destroyed
```

## Blocked

Not blocked.
