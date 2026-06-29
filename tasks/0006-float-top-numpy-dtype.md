---
id: 0006
title: Return correct numpy dtype for float TOPs
status: todo
priority: medium
area: metaltoplink
created: 2026-06-24
mirror:
---

## Goal

`OutTop.numpy()` always returns `uint8 [H, W, 4]` regardless of pixel format. `RGBA16Float` and `RGBA32Float` textures should return `float16` or `float32` arrays respectively so callers don't have to reinterpret raw bytes manually.

## Acceptance criteria

- [ ] `numpy()` on a `BGRA8Unorm`/`RGBA8Unorm` texture returns `uint8 [H, W, 4]`
- [ ] `numpy()` on an `RGBA16Float` texture returns `float16 [H, W, 4]`
- [ ] `numpy()` on an `RGBA32Float` texture returns `float32 [H, W, 4]`
- [ ] `test_out_top_readback` covers at least one float format

## Notes

Change is in the `numpy()` lambda in `source/pybindings/toplinkpy.cpp` (`#else` / macOS branch). Dispatch on `self.pixelFormat()` to select the ndarray dtype. `readback()` already returns the correct raw bytes — just change the nanobind ndarray wrapper type. Use `nb::ndarray<nb::numpy, uint16_t, ...>` for float16 (reinterpret) or `nb::ndarray<nb::numpy, float, ...>` for float32.
