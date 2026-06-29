# API Contract

Public Python API surface for the `touchpy` module. All items here are exposed via nanobind in `source/pybindings/`.

## Module-Level

```python
import touchpy as tp

tp.init_logging(level=tp.LogLevel.DEBUG, console=True, file=False)
tp.set_log_level(level=tp.LogLevel.WARN)
tp.get_dlpack_capsule_info(array)   # → dict with device_type, dtype, shape, stride, etc.
```

### LogLevel

`tp.LogLevel` is an enum with values: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, `CRITICAL`, `OFF`.

### CompFlags

`tp.CompFlags` is a flag enum (bitmaskable):

| Flag | Value | Meaning |
|------|-------|---------|
| `INTERNAL_TIME` | bit 0 | TouchEngine manages its own clock |
| `EXTERNAL_TIME` | bit 1 | Caller supplies time via `start_next_frame(seconds)` |
| `AUTO_UPDATE` | bit 2 | Internal thread calls `start_next_frame` automatically |
| `ASYNC_UPDATE` | bit 3 | Free-running async thread |
| `INTERNAL_TIME_AUTO` | 0\|2 | Convenience: internal clock + auto thread (default) |
| `INTERNAL_TIME_ASYNC` | 0\|3 | Convenience: internal clock + async thread |
| `CUDA_STREAM_DEFAULT` | bit 5 | Use default CUDA stream (Windows) |
| `CUDA_STREAM_INTERNAL` | bit 6 | Use internal CUDA stream (Windows) |
| `CUDA_DISABLE` | bit 7 | Disable CUDA (Windows) |

---

## Comp

```python
# Constructors
comp = tp.Comp()
comp = tp.Comp(flags, fps=60, device=0, td_path="")
comp = tp.Comp(tox_path, flags=tp.CompFlags.INTERNAL_TIME_AUTO, fps=60, device=0, td_path="")
```

### Lifecycle Methods

| Method | Returns | Notes |
|--------|---------|-------|
| `load(tox_path, fps=60)` | `None` | Load or reload a `.tox` file |
| `unload()` | `None` | Suspend the instance |
| `loaded()` | `bool` | True once `onEventInstanceDidLoad` has fired |
| `start()` | `None` | Begin frame loop |
| `stop()` | `None` | Halt frame loop |

### Frame Control

| Method | Notes |
|--------|-------|
| `start_next_frame()` | Advance by one internal-time frame |
| `start_next_frame(seconds: float)` | Advance to absolute time in seconds (external time mode) |
| `start_next_frame(time_value: int, time_scale: int)` | Advance to `value/scale` seconds |
| `frame_did_finish()` | `bool` — poll after `start_next_frame`; True when frame is ready |
| `apply_value_changes()` | Flush pending output value reads from the TE thread |

### Properties (read-only)

| Property | Type | Notes |
|----------|------|-------|
| `file_path` | `str` | Path to loaded `.tox` |
| `td_path` | `str` | Path to TouchDesigner engine binary |
| `flags` | `int` | Raw flag bitmask |
| `rate` | `float` | Configured frame rate |
| `cuda_device` | `int` | CUDA device index (Windows only) |

### Time

`comp.time()` returns a `Comp.Time` object:

| Field | Type |
|-------|------|
| `seconds` | `float` |
| `value` | `int` |
| `scale` | `int` |
| `frame` | `int` |
| `rate` | `float` |

### Link Accessors

| Property | Type | macOS |
|----------|------|-------|
| `in_chops` | `InChopLinks` | ✓ |
| `out_chops` | `OutChopLinks` | ✓ |
| `in_dats` | `InDatLinks` | ✓ |
| `out_dats` | `OutDatLinks` | ✓ |
| `par` | `ParLinkCollection` | ✓ |
| `in_tops` | `InTops` (macOS) / `InTopLinks` (Windows) | ✓ |
| `out_tops` | `OutTops` (macOS) / `OutTopLinks` (Windows) | ✓ |

Links are indexed by name (string) or integer index: `comp.in_chops["myChannel"]` or `comp.in_chops[0]`.

### Callbacks

Each callback setter has two overloads — with and without user data (`info`):

```python
comp.set_on_loaded_callback(callback)
comp.set_on_loaded_callback(callback, info)

comp.set_on_unloaded_callback(callback[, info])
comp.set_on_start_callback(callback[, info])
comp.set_on_stop_callback(callback[, info])
comp.set_on_frame_callback(callback[, info])
comp.set_on_layout_change_callback(callback[, info])

comp.clear_on_frame_callback()
comp.clear_on_layout_change_callback()
```

Callbacks fire on the TouchEngine thread. The binding acquires the GIL before calling Python. `on_loaded` and `on_unloaded` always use `gil_scoped_acquire`; `on_frame` and `on_layout_change` are GIL-guarded only in async mode.

---

## Link Types

### CHOP Links

**Input (`InChopLink`):** set float channel data before `start_next_frame`.

**Output (`OutChopLink`):** read after `frame_did_finish`.

```python
channels = comp.out_chops["tx"]
values = channels.valuesArray()       # raw float array
names  = channels.channelNames()      # list of channel name strings
```

### DAT Links

**Input (`InDatLink`):** set table (2D) or string data.

**Output (`OutDatLink`):**

```python
dat = comp.out_dats["mydat"]
table  = dat.asTable()   # DatTable
string = dat.asString()  # str
```

### Parameter Links (`par`)

`comp.par` is a `ParLinkCollection` keyed by parameter name.

```python
comp.par["Speed"].set(2.5)
val = comp.par["Speed"].get()         # returns ParLinkValue variant
comp.par["MyMenu"].set(1)             # MenuParLink: set by index
names = comp.par["MyMenu"].getNames() # list of menu choice strings
```

**ParLinkValue** is a variant of: `bool`, `str`, `int`, `Int2/3/4`, `float`, `Double2/3/4`, `Color`

Concrete ParLink subtypes (dispatched automatically by type + intent + count):

| Subtype | TD type | set/get value type |
|---------|---------|-------------------|
| `BoolParLink` | Toggle | `bool` |
| `PulseParLink` | Pulse | any (fires pulse) |
| `MomentaryParLink` | Momentary | `bool` |
| `StringParLink` | String/File/Folder | `str` |
| `IntParLink` | Int (count=1) | `int` |
| `Int2/3/4ParLink` | Int (count=2/3/4) | `Int2/3/4` |
| `DoubleParLink` | Float (count=1) | `float` |
| `Double2/3/4ParLink` | Float (count=2/3/4) | `Double2/3/4` |
| `ColorParLink` | RGBA (intent=ColorRGBA) | `Color` |
| `MenuParLink` | Int with choices | `int` (index) |

### TOP Links

#### macOS — Metal path

`in_tops` returns `InTops`, `out_tops` returns `OutTops`. Textures travel as `id<MTLTexture>` handles (zero-copy GPU path) or as raw bytes via CPU readback.

**Output TOP (`OutTop`)**

```python
comp.apply_value_changes()          # flush before reading
out = comp.out_tops["myrender"]

# GPU path — zero copy, valid until next apply_value_changes()
handle = out.metal_texture_handle   # uintptr_t of id<MTLTexture>
event  = out.shared_event_handle    # uintptr_t of MTLSharedEventHandle* (0 if none)
val    = out.wait_value             # uint64_t semaphore wait value

shape  = out.shape                  # (height, width, 4)
fmt    = out.pixel_format           # MTLPixelFormat enum int

# CPU readback — blocks until GPU work completes
arr = out.numpy()                   # numpy uint8 array [H, W, 4]
```

GPU sync contract: if `shared_event_handle != 0`, your Metal command buffer must wait on that event at `wait_value` before sampling the texture. If you only access the texture after `frame_did_finish()` on the CPU (via `numpy()`), no explicit sync is needed — `getBytes` serializes automatically.

**Input TOP (`InTop`)**

```python
comp.in_tops["mytop"].set_texture(
    tex,            # uintptr_t of id<MTLTexture>
    event=0,        # uintptr_t of MTLSharedEventHandle* (optional)
    val=0,          # semaphore signal value (optional)
)
```

**Container API (both `InTops` and `OutTops`)**

```python
tops.count            # int
tops.names            # list[str]
tops["name"]          # lookup by name
tops[0]               # lookup by index
```

**Pixel format notes:** `numpy()` supports `BGRA8Unorm`, `RGBA8Unorm`, `BGRA8Unorm_sRGB`, `RGBA8Unorm_sRGB` (→ `uint8 [H,W,4]`). Float formats (`RGBA16Float`, `RGBA32Float`) return the raw bytes cast to `uint8` — reinterpret as `float16`/`float32` after slicing. Unsupported formats raise `RuntimeError`.

#### Windows — CUDA/Vulkan path

`in_tops` / `out_tops` use CUDA + Vulkan interop via `toplink.cpp`.

---

## Threading Contract

- All link reads/writes are safe to call from the main Python thread between frames.
- Callback functions may be called from the TouchEngine thread — avoid long-running work inside them.
- In `AUTO_UPDATE` / `ASYNC_UPDATE` mode, `start_next_frame` is called internally; do not call it manually.
- `cuda_stream()` (Windows) returns a `uintptr_t` cast of the CUDA stream handle for interop with other CUDA libraries.
