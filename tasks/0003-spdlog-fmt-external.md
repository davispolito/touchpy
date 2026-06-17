---
id: 0003
title: Evaluate SPDLOG_FMT_EXTERNAL to decouple spdlog from bundled fmtlib
status: todo
priority: low
area: macos-port
created: 2026-06-16
mirror:
---

## Goal

Evaluate switching spdlog to use the system or separately-managed fmtlib via
`SPDLOG_FMT_EXTERNAL=ON` instead of its bundled copy. This would eliminate the
consteval compatibility issue entirely regardless of spdlog version, at the cost
of adding a fmtlib dependency to the build environment.

## Acceptance criteria

- [ ] Assess whether fmtlib is available or easily fetchable on both macOS and Windows build environments
- [ ] Confirm wheel distribution is not complicated by an external fmtlib (static link or bundle strategy)
- [ ] If viable: add fmtlib FetchContent and set `SPDLOG_FMT_EXTERNAL` in CMakeLists.txt
- [ ] Build and test on macOS; confirm no regression on Windows

## Notes

Root cause documented in `docs/NOTES.md` under "Known Issues".

The main risk is wheel distribution — if fmtlib must be statically linked or
bundled into the wheel, it adds complexity. If it can be fetched at build time
(same pattern as spdlog), the overhead is low.

Not the preferred path vs. a spdlog version bump (task 0002) unless 0002 proves
the newer spdlog still has the issue.
