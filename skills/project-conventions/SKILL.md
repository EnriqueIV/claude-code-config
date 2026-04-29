---
name: project-conventions
description: Non-negotiable workflow rules enforced globally in all projects — commit flow, command paths, and post-change behavior
triggers:
  - commit
  - git commit
  - prepare commit
  - save changes
  - bash command
  - shell command
  - changes made
  - after editing
  - after changes
version: 1.0.0
---

# Project Conventions

Global rules that override any other behavior. Apply in ALL projects, ALL sessions, ALL agents.

## Compact Rules

**COMMIT**: Use `/sc:commit` for ALL commit operations. NEVER use `caveman-commit`, NEVER call `git commit` directly, NEVER suggest committing without being explicitly asked. Any form of "commit", "prepare commit", "save changes" → invoke `/sc:commit` skill. No exceptions.

**COMMANDS**: Run bare commands in current working directory. NEVER `git -C /abs/path`, NEVER `cd /abs/path && command`. Shell cwd is already correct — trust it.

**AFTER CHANGES**: After completing changes, STOP. Report what changed (file, what, why). Do NOT suggest, propose, mention, or hint at committing. Wait for user to explicitly request it.

**BUILD**: NEVER run build or dev server commands automatically. Propose and wait for explicit user approval.

## Why These Exist

- `/sc:commit` handles ticket-aware branch/commit/PR correctly — caveman-commit does not
- Absolute paths in commands are wrong and verbose when shell is already in the right directory
- Users confirm changes look correct before committing — Claude never knows if changes are final
