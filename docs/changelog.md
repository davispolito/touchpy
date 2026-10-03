# TouchPy — Changelog

Dated verified implementation and architecture history. Completed items arrive here from
[openloops](openloops.md) with their evidence. Newest entries are first. Entries may
describe verified uncommitted work; add commit identity only when one exists.

## 2026-07-15

- **Agent context established (`docs/` scaffold).** Created the canonical agent hub and
  its three companion files under `docs/` — `docs/AGENTS.md`, `docs/openloops.md`,
  `docs/changelog.md`, `docs/Handoffs/AGENTS.md` — via the Examine → Scaffold flow of the
  agent-context skill. The hub was placed in `docs/` (not repo root) because root
  `AGENTS.md` is an Embody/Envoy auto-generated file marked "do not edit manually" and is
  regenerated from the Embody COMP; overwriting it would be clobbered on the next regen
  (operator decision: `docs/AGENTS.md`). `.claude/rules/*` and root `AGENTS.md` were not
  modified; the checked-in `CLAUDE.md` received a single approved "Agent Hub" pointer
  section delegating to `docs/AGENTS.md` (thin pointer only — `docs/AGENTS.md` stays
  canonical; operator approval recorded). Provenance: repository examination of `CMakeLists.txt`,
  `pyproject.toml`, `source/`, `source/pybindings/`, `src/touchpy/`, `test/`, `tasks/`,
  and existing `docs/*.md`; branch `dev-macos` at `0a08358`. Verification: the scaffold
  validator (`scripts/validate_scaffold.py docs`) — see the run in the session report.
