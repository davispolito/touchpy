# TouchPy — Agent Briefing

## Skills

Load these skills at the start of every session:

```
/cpp-pro
/metal-gpu-debug
```

## Graphify

`graphify-out/` exists at the project root — the knowledge graph has been generated.
Before investigating any dependency, architecture, or "what uses X" question, query
the graph first via `/graphify`. Do not read source files cold when the graph can
answer the question faster and with broader context.

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

There are two build paths: **direct CMake** (faster iteration, no wheel) and
**scikit-build-core** (builds a wheel via `uv`/`pip`). Use CMake directly for
C++ development; use scikit-build-core when you need the installable Python package.

### Direct CMake (preferred for C++ iteration)

nanobind is a build-time dependency, not runtime. For a direct cmake build it must
be importable by the Python cmake picks up. Install it into the project venv first —
do NOT use `uv add nanobind` (that adds it as a runtime dep to `pyproject.toml` and
triggers a full scikit-build-core compile as a side effect):

```bash
# First time / fresh venv setup
uv pip install nanobind

# Configure (macOS — no preset needed, CMakePresets.json only has Windows targets)
# -DPython_EXECUTABLE: point cmake at the venv python so nanobind is found
# -DSKBUILD=ON: skip GoogleTest FetchContent (gtest 1.15.2 doesn't support AppleClang 21)
cmake -B build -S . -DCMAKE_BUILD_TYPE=Release \
    -DPython_EXECUTABLE=.venv/bin/python \
    -DSKBUILD=ON

# Build
cmake --build build

# Run C++ unit tests (Windows only — skip on macOS until gtest is bumped)
./build/touchpygtest
```

Submodules must be initialised before the first configure:
```bash
git submodule update --init
```

### scikit-build-core / wheel (Python package)

Uses the build system declared in `pyproject.toml`. nanobind is listed under
`[build-system].requires` and is fetched automatically — do not add it to
`[project].dependencies`.

```bash
uv pip install -e ".[dev]"   # editable install, rebuilds C++ on each pip install
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
