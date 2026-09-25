# <PROJECT>

<SUMMARY>

## What is already here

This repository was created from `project-skeleton`, which supplies the process
layer and nothing else — no application code, no stack, no dependencies:

| Path | Holds |
| --- | --- |
| `.claude/CLAUDE.md` | the working agreement, and the headings the `shipyard` skills read |
| `specs/tasks/` | the task stack — one file per task, `active/` then `done/` |
| `scripts/check-pr-title.sh` | the Conventional Commits gate, runnable locally |
| `.github/workflows/pr-title.yml` | that gate in CI |
| `docs/adr/` | architecture decision records |

## First steps in a new project

1. Fill the placeholders. `grep -rn '<[A-Z_]\+>' .` finds every one.
2. Install the process plugin:

   ```sh
   /plugin marketplace add <OWNER>/shipyard
   /plugin install shipyard
   ```

3. Choose a stack. A layer-2 stack plugin writes its section between the
   `<!-- STACK:BEGIN -->` and `<!-- STACK:END -->` markers in
   `.claude/CLAUDE.md` and leaves the rest of the file alone.
4. Set branch protection to require the check named
   `PR title (conventional commit)`, and add any further required checks to
   `## Quality gates` in `.claude/CLAUDE.md` using the exact names branch
   protection uses.
5. Write ADR 0002 for the first decision this project makes that would
   otherwise be re-argued.

## What this skeleton deliberately omits

A package manager, a lockfile, a linter and a formatter. All four presume a
stack. They arrive with the stack plugin, which knows which ones apply.
