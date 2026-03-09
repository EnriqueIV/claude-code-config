---
name: commit
description: "Ticket-aware git operations: creates branches, commits, and PRs using ClickUp or Jira ticket codes. Delegates to git-ticket-agent to keep context clean."
category: utility
complexity: basic
mcp-servers: []
personas: []
---

# /sc:commit - Ticket-Aware Git Operations

## Purpose
Handles commits, branch creation, and PRs with automatic ticket code integration.
Delegates all git work to `git-ticket-agent` to keep the main context window clean.

## Usage
```
/sc:commit                    → commit staged/tracked changes with ticket prefix
/sc:commit --branch           → create a new ticket-prefixed branch
/sc:commit --pr               → create a PR with ticket in title and plain description
/sc:commit --branch --pr      → full flow: branch + commit + PR
```

## Ticket Systems Supported
- **ClickUp**: codes like `868guc790` → auto-generates `https://app.clickup.com/t/{code}`
- **Jira/Bitbucket**: codes like `PROJ-123` → asks for workspace base URL if unknown

## Ticket Detection Priority
1. Current branch name (extracts ticket code automatically)
2. Provided in your message: `/sc:commit 868guc790`
3. Asks you if neither is available

## Output Formats

### Branch names
`{ticket}-{verb}-{description}` — e.g., `868guc790-implement-export-csv`

### Commit titles
`{ticket}: {imperative description}` — e.g., `868guc790: implement export CSV endpoint`

### PR descriptions
Single plain-text paragraph + `Ticket: {url}` — no sections, no bullets, no emojis

## Behavioral Flow
1. **Delegate**: Launch `git-ticket-agent` with the user's request and current repo context
2. **Detect**: Agent finds ticket from branch or asks user
3. **Propose**: Agent shows branch name / commit message / PR description for approval
4. **Execute**: Only after user approves each step

## What this skill does NOT do
- Will NOT auto-commit without showing you the message first
- Will NOT push or create PRs without your approval
- Will NOT add AI references or Co-Authored-By to anything
- Will NOT use markdown/bullets/sections in PR descriptions

## Examples

```
/sc:commit
→ Detects ticket from current branch 868guc790-implement-...
→ Shows: git diff --stat
→ Proposes: "868guc790: implement video start time playback"
→ Waits for your OK → commits

/sc:commit --branch
→ Asks what you're building
→ Proposes: "868guc790-add-export-button"
→ Waits for your OK → creates branch

/sc:commit --pr
→ Composes PR title: "868guc790: add export functionality"
→ Composes plain paragraph description
→ Appends: "Ticket: https://app.clickup.com/t/868guc790"
→ Waits for your OK → creates PR via gh
```
