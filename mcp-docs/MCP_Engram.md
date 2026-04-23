# Engram Persistent Memory

**Purpose**: Persistent memory across sessions. Save decisions, bugs, discoveries, conventions, and project context so future sessions have full history.

---

## ⚠️ POST-COMPACTION PROTOCOL — NON-NEGOTIABLE

When a session is compacted (summary injected into context), execute IN ORDER before doing ANYTHING else:

1. `mem_session_summary` — save the compacted summary to preserve what was accomplished
2. `mem_context` — retrieve recent session history to restore context
3. If needed: `mem_search` on specific topics
4. ONLY THEN respond to the user

**This is not optional. Skipping it means working blind.**

---

## PROACTIVE SAVE — no exceptions

Call `mem_save` IMMEDIATELY after ANY of:
- Architecture or design decision made
- Bug fixed (include root cause + file + line)
- Convention or pattern established
- User preference or constraint learned ("no X", "siempre Y", "nunca Z")
- Non-obvious discovery or gotcha found
- User confirms approach ("dale", "perfecto", "go with that")
- User rejects approach ("no, mejor X", "no hagas eso")
- Feature implemented with non-obvious approach
- Discussion concludes with clear direction

**Self-check after EVERY task**: "Did I just make a decision, fix a bug, establish a pattern, or learn a constraint? → mem_save NOW, not later."

---

## SESSION START — mandatory

On every session start (including post-compaction):
1. Call `mem_context` with the current project to load recent history
2. If user's first message references past work → `mem_search` first, then respond

---

## SESSION END — mandatory

Before saying "done", "listo", "all set", or similar:
1. Call `mem_session_summary` with: Goal, Discoveries, Accomplished, Next Steps, Relevant Files

---

## Core Tools (no ToolSearch needed)
| Tool | Use |
|------|-----|
| `mem_save` | Save decision, bug, discovery, convention — call immediately |
| `mem_search` | Find past context by keywords |
| `mem_context` | Get recent session history — call at session start |
| `mem_session_summary` | End-of-session summary — mandatory before finishing |
| `mem_get_observation` | Get full content of a search result |
| `mem_save_prompt` | Save user prompt for context |

## Memory Types
- **user** — user role, preferences, expertise level
- **feedback** — what to do/avoid (corrections AND confirmations)
- **project** — ongoing work, decisions, deadlines
- **reference** — where to find things (Linear, Slack, Grafana, etc.)
