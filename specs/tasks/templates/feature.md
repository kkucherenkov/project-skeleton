# Feature task template

Copy this block into a new file at `specs/tasks/active/<id>.md` when starting a
task. Replace the placeholder values. The id is the creation date plus your
branch slug — `T-YYYY-MM-DD-<branch-slug>`, no counter to allocate; the format
and why it is not a number are in [`specs/tasks/README.md`](../README.md).

```md
## T-YYYY-MM-DD-{branch-slug} — {short title, verb-led}

- Created: YYYY-MM-DD
- Owner: claude | @handle
- Spec: [link to a design doc, ADR, or issue]
- Goal: one sentence on the outcome, not the steps.
- Acceptance:
  - observable behaviour 1
  - observable behaviour 2
- Tests: {unit / integration / e2e — what is covered}
- Sub-steps:
  - [ ] …
  - [ ] …
- Status: in-progress | blocked | paused
- Blockers: —
```

## Field rules

- **Goal** is the _why_. The sub-steps are the _how_. Keep them separate — the
  goal survives re-planning, the sub-steps do not.
- **Acceptance** is what a human can verify without reading code. "Users can
  cancel a booking from the detail page" — not "CancelBookingCommand is
  dispatched".
- **Status: blocked** requires a filled `Blockers:` line naming what is needed
  and from whom. A blocked task with an empty blocker is an abandoned task.
