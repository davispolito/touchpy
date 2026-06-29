---
id: 0008
title: Run init-docs scaffold
status: todo
priority: low
area: docs
created: 2026-06-24
mirror:
---

## Goal

Complete the `/init-docs` scaffold that was started but not finished. `docs/` and `tasks/` already exist; what's missing is the implementation-notes index and the roadmap stub.

## Acceptance criteria

- [ ] Replace `docs/README.md` (currently upstream Sphinx build instructions) with implementation-notes index linking all existing doc files
- [ ] Create `docs/roadmap.md` stub
- [ ] Update vault briefing `~/Vault/dev/touchpy.md` with `## Docs` section (requires Davis confirmation before writing)

## Notes

Run `/init-docs` in the touchpy project. Confirm the `docs/README.md` replacement before writing — it currently contains the upstream Sphinx instructions which should be preserved somewhere or discarded.
