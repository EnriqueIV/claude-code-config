---
name: init-project
description: Save project workflow conventions to Engram. Run once per project at session start.
---

## Step 1 — Detect project

Run `pwd`. Extract project name from last path segment.

## Step 2 — Check if already initialized

Call `mem_search` with query `conventions/{project-name}`.
If found → skip to Step 4, note "already initialized".

## Step 3 — Save conventions to Engram

Call `mem_save`:
- title: "Workflow conventions for {project-name}"
- type: decision
- scope: project
- topic_key: `conventions/{project-name}`
- content:

```
COMMIT: Always use /sc:commit. Never git commit directly.
Any request containing "commit", "save changes", "prepare commit" → /sc:commit.

COMMANDS: Bare commands only. No `git -C /path`. No `cd /path &&`. Shell is already in the right directory.

AFTER CHANGES: Stop and report what changed. Do not suggest committing. Wait for explicit request.

BUILD: Never run build commands (npm run build, yarn build, etc.) or dev servers automatically. Propose and wait.
```

## Step 4 — Report

```
Project: {name}
Engram: conventions/{project} ✓ (new | already existed)
```
