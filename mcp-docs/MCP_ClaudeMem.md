# claude-mem Plugin

**Purpose**: Persistent cross-session memory + token-efficient codebase exploration using AST parsing.

The plugin's hooks run automatically (PostToolUse captures observations, Stop summarizes, PreToolUse on Read injects file context). These skills must be invoked explicitly.

---

## AUTO-USE RULES — trigger without being asked

### `claude-mem:smart-explore`
Use INSTEAD of reading multiple files when:
- Need to understand how a feature/module works (would require reading 3+ files)
- User asks "how does X work?" or "where is Y implemented?"
- Exploring an unfamiliar part of the codebase before making changes
- Need to find all usages of a function/component
- Checking what a file exports before importing

**Don't read 5 files to answer something smart-explore can answer in 1 call.**

### `claude-mem:mem-search`
Use BEFORE starting work when:
- Starting work on a feature/bug that might have been touched before
- User mentions a topic with no current conversation context
- About to implement something — check if a convention was established

### `claude-mem:make-plan`
Use when:
- Task has 5+ steps and would benefit from phased breakdown
- User asks to plan before implementing

### `claude-mem:do`
Use when:
- Executing a plan that was created with `make-plan`
- Task is complex enough to benefit from subagent delegation

---

## Skills Reference
| Skill | Trigger |
|-------|---------|
| `claude-mem:smart-explore` | Exploring codebase structure, finding implementations |
| `claude-mem:mem-search` | Recall past decisions/conventions for current project |
| `claude-mem:make-plan` | Plan complex multi-phase implementations |
| `claude-mem:do` | Execute a plan with subagents |
| `claude-mem:knowledge-agent` | Build/query knowledge base from observations |
| `claude-mem:timeline-report` | Project history narrative |

## Installation

```bash
/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem
```
