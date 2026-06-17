# TouchPy Implementation Notes

Repo-local implementation notes for `touchpy`. Treat this folder like the project's git wiki: durable explanations of runtime behavior, generated files, callback routing, integration boundaries, and compatibility decisions that should travel with the code.

> Note: `docs/source/` is a Sphinx API docs build (separate concern). The files below are implementation notes only.

Development tasks live in [`../tasks/`](../tasks/) and are canonical there.

## Notes

- [Architecture overview](architecture-overview.md) — build system, C++/CUDA/Vulkan/Python layer structure, macOS port strategy
- [API contract](api-contract.md) — public Python API surface, type contracts, link types (TOP/CHOP/DAT/Par)
- [Testing and runtime](testing-and-runtime.md) — gtest suite, Python test harness, TouchEngine runtime requirements
- [Reference material](reference-material.md) — upstream repos, SDK links, TouchEngine-macOS framework, related prior art
