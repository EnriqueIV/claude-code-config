---
name: init-project
description: Bootstrap gentle-ai for a new project — runs sdd-init + skill-registry, saves global rules to Engram. Run once per project at session start.
---

You are the project initializer. Execute these steps in order. Do not skip any step.

## Step 1 — Detect project

Run `pwd` to get the current directory. Extract the project name from the last path segment.

## Step 2 — Run sdd-init

Invoke the `/sdd-init` skill. This detects the project stack (language, framework, test runner, linters) and saves the context to Engram under topic_key `sdd-init/{project-name}`. If sdd-init has already run for this project (check Engram first with `mem_search query:"sdd-init/{project-name}"`), skip this step and note it was already done.

## Step 3 — Run skill-registry

Invoke the `/skill-registry` skill. This scans all skills (global + project level), extracts compact rules from each SKILL.md, and writes `.atl/skill-registry.md`. This file is the enforcement mechanism — compact rules from it get injected into every sub-agent spawned during SDD workflows.

Important: the `project-conventions` skill must appear in the registry output with its compact rules intact.

## Step 4 — Save global rules to Engram

Call `mem_save` with:
- title: "Critical workflow conventions for {project-name}"
- type: decision
- scope: project  
- topic_key: `conventions/{project-name}`
- content (verbatim):

```
COMMIT: Always use /sc:commit. Never caveman-commit. Never git commit directly.
Any user request containing "commit", "save changes", "prepare commit" → /sc:commit.

COMMANDS: Bare commands only. No `git -C /path`. No `cd /path &&`. Shell is in the right directory.

AFTER CHANGES: Stop and report what changed. Do not suggest committing. Wait for explicit request.

BUILD: Never run npm run build, yarn build, or dev servers automatically. Propose and wait.
```

## Step 5 — Report to user

Show a concise summary:

```
Project init complete.

Project: {name}
Stack: {detected stack}
Tests: {test runner + framework, or "none found"}
Skill registry: .atl/skill-registry.md ✓
Engram: sdd-init/{project} ✓
Engram: conventions/{project} ✓

Ready. Global rules active for this project.
```

Do not add commentary. Do not suggest next steps unless the user asks.
