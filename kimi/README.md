# Kimi Code CLI Config

Personal configuration files for [Kimi Code CLI](https://kimi.com/code).

These files live in `~/.kimi/` and control global behavior, MCP servers, and custom skills.

---

## Files

### `config.toml`

Main configuration file. Key settings:

| Setting | Value | Purpose |
|---------|-------|---------|
| `default_model` | `kimi-code/kimi-for-coding` | Uses Kimi k2.6 |
| `default_thinking` | `true` | Thinking mode enabled by default |
| `default_yolo` | `false` | Requires approval for destructive actions |
| `theme` | `dark` | Terminal theme |
| `show_thinking_stream` | `true` | Streams thinking tokens in real time |
| `telemetry` | `true` | Usage telemetry |

**Model config** (`models."kimi-code/kimi-for-coding"`):
- Provider: `managed:kimi-code`
- Max context: 262,144 tokens
- Capabilities: thinking, image input, video input

**Loop control** (`loop_control`):
- Max steps per turn: 1000
- Max retries per step: 3
- Compaction trigger: 85% context usage

**Background tasks** (`background`):
- Max running tasks: 4
- Agent task timeout: 900s

**Services** (`services`):
- `moonshot_search` — Kimi web search API
- `moonshot_fetch` — Kimi web fetch API

### `mcp.json`

Configured MCP servers:

| MCP | Transport | Purpose |
|-----|-----------|---------|
| `engram` | stdio (`engram mcp --tools=agent`) | Persistent memory across sessions |
| `context7` | HTTP (`https://mcp.context7.com/mcp`) | Official library documentation |
| `rovo` | stdio (`npx -y mcp-remote@latest`) | Atlassian Jira/Confluence integration |

### `kimi.json`

Work directory registry. Tracks recently opened projects and their last session IDs.

---

## Skills (`skills/`)

Kimi Code CLI loads skills from `~/.kimi/skills/` automatically.

| Skill | Purpose |
|-------|---------|
| `functional-code-expert` | Global functional programming and clean code standards. Enforces immutability, pure functions, self-documenting code, and SOLID principles. |
| `sc-commit` | Ticket-aware git operations for ClickUp and Jira/Bitbucket. Creates branches, commits, and PRs with automatic ticket code integration. |

---

## Installation

To apply this configuration on a new machine:

```bash
# Ensure ~/.kimi exists
mkdir -p ~/.kimi

# Copy config files
cp config.toml ~/.kimi/
cp mcp.json ~/.kimi/
cp kimi.json ~/.kimi/

# Copy skills
for dir in skills/*/; do
  skill_name=$(basename "$dir")
  mkdir -p ~/.kimi/skills/"$skill_name"
  cp "$dir"SKILL.md ~/.kimi/skills/"$skill_name"/
done
```

> **Note:** `config.toml` uses OAuth for API authentication. The first run will prompt for login. No API keys are stored in these files.

---

## Updating

After changing any file in this folder, copy it back to `~/.kimi/` and restart Kimi Code CLI:

```bash
cp config.toml ~/.kimi/
# or
scp skills/*/SKILL.md ~/.kimi/skills/*/
```
