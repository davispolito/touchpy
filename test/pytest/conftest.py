#conftest.py

import json
from pathlib import Path
import pytest
import sys

try:
	import keyboard
	_keyboard_available = True
except Exception:
	_keyboard_available = False

localImportPath = Path(__file__).parents[2] / 'build'
if str(localImportPath) not in sys.path:
	sys.path.insert(0,str(localImportPath))

import touchpy as tp

def on_frame(comp):
	if _keyboard_available:
		try:
			if keyboard.is_pressed('q'):
				print("pressed q key")
				comp.stop()
				return
		except Exception:
			pass  # no keyboard access (headless / macOS without root)
	if comp.start_next_frame():
		comp.stop()


@pytest.fixture(scope="session")
def ref():
	referenceFile = Path(__file__).parents[1] / 'tox/parvalues.json'
	referenceValues = json.loads(referenceFile.read_text(encoding='utf-8'))
	return referenceValues

@pytest.fixture(scope="session")
def comp():
	comp = tp.Comp(str(Path(__file__).parents[1] / 'tox' / 'test.tox'))
	comp.set_on_frame_callback(on_frame, comp)
	comp.start()
	yield comp
	print("comp fixture teardown after all tests are complete")
	comp.stop()
	return comp

@pytest.fixture(scope="session")
def stopcomp(comp):
	comp.stop()