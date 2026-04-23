# Engram Persistent Memory

**Purpose**: Persistent memory across sessions. Save decisions, bugs, discoveries, conventions, and project context so future sessions have full history.

## MANDATORY BEHAVIOR — Always Active

### Save proactively after ANY of:
- Architecture or design decision made
- Bug fixed (include root cause)
- Convention or pattern established
- User preference or constraint learned
- Non-obvious discovery or gotcha found
- User confirms recommendation ("dale", "go with that", "sounds good")
- User rejects approach or expresses preference ("no, better X", "siempre hacé X")
- Feature implemented with non-obvious approach
- Discussion concludes with clear direction

### Search memory when:
- User's FIRST message references a project, feature, or problem → search before responding
- User asks to recall anything ("remember", "what did we do", "acordate")
- Starting work that might have been done before
- User mentions topic with no current context

### Session end — call `mem_session_summary` with:
Goal, Discoveries, Accomplished, Next Steps, Relevant Files

## Core Tools (no ToolSearch needed)
| Tool | Use |
|------|-----|
| `mem_save` | Save decision, bug, discovery, convention |
| `mem_search` | Find past context by keywords |
| `mem_context` | Get recent session history |
| `mem_session_summary` | End-of-session summary (mandatory) |
| `mem_get_observation` | Get full content of a search result |
| `mem_save_prompt` | Save user prompt for context |

## Memory Types
- **user** — user role, preferences, expertise level
- **feedback** — what to do/avoid (corrections AND confirmations)
- **project** — ongoing work, decisions, deadlines
- **reference** — where to find things (Linear, Slack, Grafana, etc.)
