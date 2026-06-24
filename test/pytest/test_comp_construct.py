"""
Constructor overload smoke tests for tp.Comp.

Overloads (as registered in comppy.cpp):
  1. Comp()
  2. Comp(flags, fps, device, td_path)
  3. Comp(tox_path, flags, fps, device, td_path)

Run from repo root:
  DYLD_FRAMEWORK_PATH=external/TouchEngine-macOS .venv/bin/python -m pytest test/pytest/test_comp_construct.py -v
"""
import pytest
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parents[2] / "build"))

import touchpy as tp

TOX_PATH = str(Path(__file__).parents[1] / "tox" / "test.tox")
# td_path must be the .app bundle, not the binary inside it.
# Leave empty to let TouchEngine auto-discover from /Applications.
TD_PATH = "/Applications/TouchDesigner 2025.32820.app"


def test_default_construct():
    """Overload 1: Comp() — no arguments."""
    comp = tp.Comp()
    assert not comp.loaded()


def test_flags_only():
    """Overload 2: Comp(flags=...) — flags-only path, no tox."""
    comp = tp.Comp(tp.CompFlags.INTERNAL_TIME_AUTO)
    assert not comp.loaded()


def test_flags_kwargs():
    """Overload 2: Comp with keyword args."""
    comp = tp.Comp(flags=tp.CompFlags.INTERNAL_TIME_AUTO, fps=30)
    assert not comp.loaded()


def test_tox_positional():
    """Overload 3: Comp(tox_path) — positional string, auto-discover TD."""
    comp = tp.Comp(TOX_PATH)
    assert comp.loaded()


def test_tox_keyword():
    """Overload 3: Comp(tox_path=...) — keyword string, auto-discover TD."""
    comp = tp.Comp(tox_path=TOX_PATH)
    assert comp.loaded()


def test_load_method():
    """Alternative path: Comp() then load(tox_path)."""
    comp = tp.Comp()
    comp.load(TOX_PATH)
    assert comp.loaded()
