# touchpy

## Running Python Against the Direct CMake Build

Always use these exact env vars and interpreter when running Python against the direct CMake build (not the wheel install):

```bash
DYLD_FRAMEWORK_PATH=/Users/davispolito/dev/touchpy/external/TouchEngine-macOS \
PYTHONPATH=/Users/davispolito/dev/touchpy/build \
/Users/davispolito/dev/touchpy/.venv/bin/python
```

**Why:** The `.so` lands in `build/` (not on the venv path), and `TouchEngine.framework` must be found at dlopen time. The editable install (`uv pip install -e`) uses a different path and doesn't need PYTHONPATH, but the direct CMake build always does.

**How to apply:** Any time a Python script or pytest run is invoked against the CMake build, use the above. If using pytest: prefix the `pytest` command with the same env vars and point at `.venv/bin/python -m pytest`.

## Metal Trace Output Path

Always pass an explicit absolute `output` path when calling `metal_trace`.

**Why:** `TRACES_DIR` defaults to `./traces/` relative to the MCP server's cwd at startup. Since `metal-tools` is registered in vault project scope, traces land in `~/Vault/traces/` by default — wrong location.

**How to apply:** Any time `metal_trace` is called without an explicit output, flag it and suggest `/Users/davispolito/dev/touchpy/traces/<name>.trace` before proceeding.
