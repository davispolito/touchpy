---
id: 0002
title: Bump spdlog to fix bundled fmtlib consteval on AppleClang 21
status: todo
priority: low
area: macos-port
created: 2026-06-16
mirror:
---

## Goal

Replace the `FetchContent` pin of spdlog v1.15.0 with a newer tag whose bundled
fmtlib compiles cleanly under C++20 on AppleClang 21 (Xcode 26). Currently the
global `CMAKE_CXX_STANDARD` is kept at 17 to avoid the issue (C++20 is set
per-target on `touchpy` only). A spdlog bump would unblock setting C++20 globally
if that becomes desirable.

## Acceptance criteria

- [ ] spdlog builds without errors under `-std=c++20` on AppleClang 21
- [ ] `cmake -B build && cmake --build build` succeeds with global `CMAKE_CXX_STANDARD 20`
- [ ] No regression in logging behavior on macOS or Windows

## Notes

Root cause documented in `docs/NOTES.md` under "Known Issues".

Current workaround: per-target `CXX_STANDARD 20` on `touchpy`, global stays at 17.
Check spdlog releases after v1.15.0 or the upstream fmtlib changelog for the fix.
