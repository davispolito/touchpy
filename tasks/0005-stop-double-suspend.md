---
id: 0005
title: Fix stop() double-suspend crash
status: done
priority: high
area: comp
created: 2026-06-24
mirror:
---

## Goal

`stop()` raises "Failed to suspend TEInstance: API client usage error" when called on an instance that was never started or is already stopped. Guard `TEInstanceSuspend` with a state check so calling `stop()` is safe in any state.

## Acceptance criteria

- [x] `test_stop` passes
- [x] Calling `comp.stop()` twice does not throw
- [x] Calling `comp.stop()` before `comp.start()` does not throw

## Notes

Pre-existing bug, affects macOS and Windows. The fix is a state guard in `Comp::stop()` — only call `TEInstanceSuspend` when the instance is actually running. The shared state `ssLoaded_` / `ssReady_` flags or a dedicated `ssStarted_` bool can gate the call.
