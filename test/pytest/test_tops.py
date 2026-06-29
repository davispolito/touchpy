import os
from pathlib import Path
import time

import pytest
import touchpy as tp


ROOT = Path(__file__).parents[2]
TOX = ROOT / "test" / "tox" / "test.tox"
DEFAULT_TOP_TOX = ROOT / "test" / "tox" / "test_top.tox"
TOP_TOX = Path(os.environ.get("TOP_TOX", DEFAULT_TOP_TOX))


def wait_loaded(comp, timeout=15):
    deadline = time.time() + timeout
    while not comp.loaded() and time.time() < deadline:
        time.sleep(0.05)
    assert comp.loaded(), "comp did not load within timeout"


def drain_layout(comp, timeout=2):
    deadline = time.time() + timeout
    while comp.out_tops.count == 0 and time.time() < deadline:
        comp.frame_did_finish()
        comp.apply_value_changes()
        time.sleep(0.01)
    assert comp.out_tops.count > 0, "TOP_TOX has no output TOPs"


def wait_frame_finished(comp, timeout=2):
    deadline = time.time() + timeout
    while not comp.frame_did_finish() and time.time() < deadline:
        time.sleep(0.01)
    assert comp.frame_did_finish(), "frame did not finish within timeout"
    comp.apply_value_changes()


# ---------------------------------------------------------------------------
# Collection API — works with any tox, even one with no TOPs
# ---------------------------------------------------------------------------

@pytest.fixture
def comp():
    c = tp.Comp(str(TOX))
    wait_loaded(c)
    c.apply_value_changes()
    yield c


def test_top_collections_exist(comp):
    assert hasattr(comp, "in_tops")
    assert hasattr(comp, "out_tops")


def test_top_count_is_int(comp):
    assert isinstance(comp.in_tops.count, int)
    assert isinstance(comp.out_tops.count, int)


def test_top_names_is_list(comp):
    assert isinstance(comp.in_tops.names, list)
    assert isinstance(comp.out_tops.names, list)


def test_top_names_consistent_with_count(comp):
    assert len(comp.in_tops.names) == comp.in_tops.count
    assert len(comp.out_tops.names) == comp.out_tops.count


# ---------------------------------------------------------------------------
# Readback — needs a tox with output TOPs.
# ---------------------------------------------------------------------------

@pytest.fixture
def top_comp():
    if not TOP_TOX.exists():
        pytest.skip(f"TOP tox not found: {TOP_TOX}")
    comp = tp.Comp(str(TOP_TOX), flags=tp.CompFlags.INTERNAL_TIME)
    wait_loaded(comp)
    drain_layout(comp)
    yield comp


@pytest.fixture
def rendered_top_comp(top_comp):
    top_comp.start()
    assert top_comp.start_next_frame(), "start_next_frame should succeed after start()"
    wait_frame_finished(top_comp)
    return top_comp


def test_top_fixture_discovers_output_link(top_comp):
    assert top_comp.out_tops.count > 0
    assert "out1" in top_comp.out_tops.names


def test_top_frame_start_requires_resume(top_comp):
    assert top_comp.start_next_frame() is False


def test_resumed_top_frame_produces_texture(rendered_top_comp):
    top = rendered_top_comp.out_tops["out1"]

    assert top.shape[2] == 4, "channel count should be 4"
    h, w, _ = top.shape
    assert (h, w) == (64, 64)
    assert top.metal_texture_handle


def test_out_top_numpy_readback(rendered_top_comp):
    import numpy as np

    top = rendered_top_comp.out_tops["out1"]
    h, w, _ = top.shape
    arr = top.numpy()

    assert arr.shape == (h, w, 4)
    assert arr.dtype == np.uint8
    assert np.any(arr)
