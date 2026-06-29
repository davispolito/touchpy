Run offline touchpy tests against exported .tox files in the current project.

1. Verify `scripts/test.sh` exists in the project root. If it doesn't, this project hasn't had touchpy testing wired up — stop and tell Davis.
2. Verify `~/dev/touchpy/external/TouchEngine-macOS/TouchEngine.framework` exists. If not, stop and tell Davis the touchpy Mac build is missing.
3. Check `exports/` for any `.tox` files. If the directory is empty (only `.gitkeep`), warn Davis that no exports are present — tests will all skip.
4. Run the tests:

```bash
./scripts/test.sh $ARGUMENTS
```

Pass any arguments the user gave after `/test-with-touchpy` directly to the script (e.g. `-v`, `-k audio`).

5. Report results: how many passed, skipped, failed. For any failures, show the full pytest output for that test.
