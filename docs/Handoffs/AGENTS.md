# TouchPy — Handoff Conventions

Handoffs are exception-based inter-session records: what an agent believed, changed,
verified, or left behind when meaningful continuity state remains. They are historical
evidence, not present-state authority. Verify claims against current source, Git state,
the CMake build, and the loaded `.so` before acting.

Do not write a handoff after every completed task. Completed verified changes belong in
[changelog](../changelog.md). Write a handoff for unfinished changes, a dirty worktree, a
half-ported translation unit, an in-progress submodule bump, unresolved verification (e.g.
a build that only compiled but was never run), recovery paths, or other continuity that
would otherwise be rediscovered.

## Naming

- Use `YYYY-MM-DD-NN.md`; increment the zero-padded sequence within the day.
- Do not put agent tags in filenames; author identity belongs inside the file.
- The first file of a day is `-01`, never a bare date.

## Authorship

Open with an `**Author:**` line naming the model and provider, e.g.
`**Author:** Opus 4.8 (Anthropic)`. Say unknown rather than guessing.

## Required contents

- **Scope** and date.
- **Current state** — repo/worktree, branch, dirty state, commit/push state, submodule
  state, and applicable source/built(`.so`)/installed/live identities.
- **What changed** — grouped by area, including change-impact surfaces checked (binding,
  `.pyi`, `api-contract.md`, tests).
- **Verification** — exact commands (CMake configure/build, `pytest`, gtest), results,
  failures, skips (e.g. gtest skipped on macOS), and unverified layers.
- **Next actions** — ordered and limited to unfinished scope.
- **Gotchas** and links to relevant openloops/changelog entries.

## Reading handoffs

- Read the latest relevant highest-sequence handoff, then re-check Git, source, the build,
  and each applicable state layer.
- Do not execute historical next actions without current authorization.
