# TouchPy — Agent Briefing

## Skills

Load these skills at the start of every session:

```
/cpp-pro
/metal-gpu-debug
```

## What This Is

TouchPy is a C++17/nanobind Python extension that wraps the TouchEngine SDK, letting Python code drive TouchDesigner components. The `dev-macos` branch is an active port from Windows (CUDA + Vulkan) to macOS (Metal + Obj-C++).

- Codebase root: `/Users/davispolito/dev/touchpy/`
- Vault note: `~/Vault/dev/touchpy.md` (if it exists)
- Upstream: `https://github.com/IntentDev/touchpy`

## Tech Stack

- **Language**: C++17, Obj-C++ (`OBJCXX`) on macOS
- **Python binding**: nanobind
- **Build**: CMake + scikit-build-core (`pyproject.toml`)
- **TouchEngine SDK**: `external/TouchEngine-macOS/TouchEngine.framework` (macOS), `external/TouchEngine-Windows/` (Windows)
- **GPU**: Metal + Foundation frameworks (macOS); CUDA + Vulkan (Windows)
- **Logging**: spdlog
- **Tests**: GoogleTest (`test/gtest/`)

## Directory Layout

```
source/          C++ source — main library code
  common/        Shared utilities
  pybindings/    nanobind Python binding layer
  vri/           Vulkan renderer (Windows-only, excluded on macOS)
src/touchpy/     Python package stub
test/gtest/      C++ unit tests
external/        Submodules: TouchEngine-macOS, TouchEngine-Windows
docs/            Architecture notes, API contract, testing guide
examples/        Python usage examples
```

## Build & Run

```bash
# Configure (macOS)
cmake -B build --preset default   # or: cmake -B build -DCMAKE_BUILD_TYPE=Release

# Build
cmake --build build

# Run C++ tests
./build/touchpygtest

# Build Python wheel (scikit-build-core)
pip install -e ".[dev]"
```

## macOS Port Status (`dev-macos` branch)

The port excludes these translation units via CMake (CUDA/Vulkan dependencies, no macOS headers yet):
- `vri/` — Vulkan renderer
- `renderer.cpp/h`, `texture.cpp/h`, `cudamemory.cpp/h`
- `toplink.cpp/h`, `copykernels.cu/cuh`
- `cudadatatypes.h`, `cudaflags.h`, `deviceinfo.h`, `common/cuda_helpers.h`

The macOS build links: `TouchEngine.framework`, `Metal`, `Foundation`, `spdlog`.

## Constraints

- C++ standard is 17 (not 20/23) — cpp-pro patterns are fine, but concepts require C++20; use SFINAE/type traits instead
- Never commit directly to `main`; work on `dev-macos` or feature branches
- `external/` submodules must be init'd before building: `git submodule update --init`
- Do not add CUDA or Vulkan dependencies to the macOS build path
