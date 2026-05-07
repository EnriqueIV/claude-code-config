# Current Setup State

Snapshot of the exact configuration running on the primary machine.
Use this as a reference when setting up or syncing another machine.

Last updated: 2026-05-07

---

## Active plugins

```bash
claude plugin install engram@engram
claude plugin marketplace add thedotmack/claude-mem && claude plugin install claude-mem@thedotmack
claude plugin marketplace add JuliusBrussee/caveman && claude plugin install caveman@caveman
claude plugin marketplace add warpdotdev/claude-code-warp && claude plugin install warp@claude-code-warp
```

| Plugin | Purpose |
|--------|---------|
| `engram@engram` | Persistent memory across sessions |
| `claude-mem@thedotmack` | AST-based codebase exploration (`smart-explore`, `make-plan`) |
| `caveman@caveman` | Compressed communication mode (active by default) |
| `warp@claude-code-warp` | Warp terminal integration |

---

## Active MCP servers

```bash
claude mcp add context7 -s user -- npx -y @upstash/context7-mcp
uv tool install code-review-graph
claude mcp add code-review-graph -s user -- uvx code-review-graph serve
```

| MCP | Purpose |
|-----|---------|
| `context7` | Official library docs |
| `code-review-graph` | Per-project AST graph, blast radius, impact analysis |
| `stitch` | Google design system (account-level, auto-connected) |

**Not installed** (intentionally removed — too many tools inflate startup context):
- `token-savior` (50 tools)
- `chrome-devtools` (30 tools)
- `playwright` (20 tools)
- `sequential-thinking`

---

## Google MCPs (account-level)

Gmail, Google Calendar, and Google Drive MCPs are managed via **claude.ai → Settings → Integrations**.
Disconnect them — they inject auth errors at session start and waste context.
There is no local config to edit for these.

---

## ~/.claude/CLAUDE.md imports

Active (always loaded at startup):
```
@PRINCIPLES.md           # ~60 lines — engineering philosophy
@RULES.md                # ~272 lines — behavioral rules with priorities
@DEVELOPMENT_STANDARDS.md  # ~236 lines — functional programming, git, security rules
```

Commented out (load on demand if needed):
```
# @FLAGS.md
# @MODE_Brainstorming.md
# @MODE_DeepResearch.md
# @MODE_Introspection.md
# @MODE_Orchestration.md
# @MODE_Task_Management.md
# @MODE_Token_Efficiency.md
# @MCP_Context7.md
# @MCP_Playwright.md
# @MCP_Sequential.md
# @MCP_TokenSavior.md
```

Total active import lines: ~568 (~9k tokens). Enabling all MODE + MCP files adds ~750 lines (~12k tokens).

---

## ~/.claude/settings.json hooks

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write|Bash",
        "hooks": [{ "command": "[ -d \".code-review-graph\" ] && code-review-graph update --skip-flows || true", "timeout": 30 }]
      }
    ],
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [{ "command": "[ -d \".code-review-graph\" ] && code-review-graph status || true", "timeout": 10 }]
      }
    ]
  }
}
```

Both hooks are conditional on `.code-review-graph/` existing in the project directory. No overhead in projects without a graph.

---

## Known token costs at startup

With this config, a new session in a project with no graph consumes ~25-30% of 200k context before any message. Breakdown:

| Source | Approx tokens |
|--------|--------------|
| Claude Code built-in system prompt | ~15k (not reducible) |
| CLAUDE.md inline content | ~3k |
| Active @imports (PRINCIPLES + RULES + STANDARDS) | ~9k |
| Plugin CLAUDE.md files (engram, caveman, claude-mem) | ~5k |
| MCP tool list + system-reminders | ~3-5k |
| claude-mem SessionStart context injection | ~3-5k |
| **Total** | **~38-42k / 200k (~20-21%)** |

The 29% observed in May 2026 included the Google MCPs (auth errors) and all MODE + MCP files still active. After cleanup, target is ~20-22%.

---

## Strapi MCP (project-specific)

The Strapi MCP is configured per-project in `~/.claude/settings.json` with a hardcoded token. Move this to the project's local `.claude/settings.json` instead of global config.

```json
{
  "mcpServers": {
    "strapi": {
      "command": "npx",
      "args": ["-y", "@wh1teee/strapi-mcp"],
      "env": {
        "STRAPI_API_TOKEN": "<token-from-strapi-admin>",
        "STRAPI_URL": "http://localhost:1337"
      }
    }
  }
}
```
