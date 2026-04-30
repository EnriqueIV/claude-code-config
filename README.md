# AI Pair Programming Config

Personal configuration for [Claude Code](https://claude.ai/code) and [Kimi Code CLI](https://kimi.com/code).

Enforces functional programming standards, ticket-aware git workflows, and professional commit conventions across both assistants. The Claude Code side is designed to work on top of the [SuperClaude](https://github.com/NickAltmann/SuperClaude) framework.

> **Why both?** Claude Code excels at deep reasoning and agentic workflows. Kimi k2.6 brings a 262K context window and fast thinking-mode streaming. This repo keeps both tools configured with the same standards so you get consistent behavior regardless of which one you open.

---

## What's included

| Assistant | Folder | Entry point |
|-----------|--------|-------------|
| **Claude Code** | `standards/`, `modes/`, `agents/`, `commands/`, `skills/` | `~/.claude/CLAUDE.md` |
| **Kimi Code CLI** | `kimi/` | `~/.kimi/config.toml` + `~/.kimi/mcp.json` |

Shared standards (functional programming, git conventions, MCPs) are applied to both. Claude-specific extras (agents, slash commands, gentle-ai plugins) live in the root folders. Kimi-specific config lives under `kimi/`.

---

## Prerequisites

**Required:**
- [Claude Code](https://claude.ai/code) installed and authenticated (`claude --version`)
- [Kimi Code CLI](https://kimi.com/code) installed and authenticated (`kimi --version`)
- [Node.js](https://nodejs.org/) 18+ (dependency for both)

**Optional but recommended:**
- [GitHub CLI](https://cli.github.com/) (`gh`) — required for `/sc:commit --pr` to create pull requests
  ```bash
  brew install gh    # macOS
  gh auth login      # authenticate
  ```

---

## Installation

### Claude Code setup

#### Step 1 — Install SuperClaude (framework dependency)

```bash
git clone https://github.com/NickAltmann/SuperClaude.git /tmp/superclaude
cd /tmp/superclaude
./install.sh
```

> If you prefer not to use SuperClaude, skip this step — the custom agents and `/sc:commit` command will still work. You will just need to create `~/.claude/CLAUDE.md` manually (see below).

#### Step 2 — Copy files

```bash
# Standards and behavioral overrides
cp standards/* ~/.claude/

# Behavioral modes
cp modes/* ~/.claude/

# MCP integration guides
cp mcp-docs/* ~/.claude/

# Custom agents
mkdir -p ~/.claude/agents
cp agents/* ~/.claude/agents/

# Slash commands
mkdir -p ~/.claude/commands/sc
cp commands/sc/* ~/.claude/commands/sc/
cp commands/*.md ~/.claude/commands/ 2>/dev/null || true

# Skills
for dir in skills/*/; do
  skill_name=$(basename "$dir")
  mkdir -p ~/.claude/skills/"$skill_name"
  cp "$dir"* ~/.claude/skills/"$skill_name"/
done

# Statusline script
cp scripts/statusline-command.sh ~/.claude/
chmod +x ~/.claude/statusline-command.sh
```

#### Step 3 — Register files in CLAUDE.md

Open `~/.claude/CLAUDE.md` and add imports for the files copied above:

```markdown
# Development Standards
@DEVELOPMENT_STANDARDS.md
@OVERRIDES.md
@PRINCIPLES.md
@RULES.md
@FLAGS.md

# Behavioral Modes
@MODE_Brainstorming.md
@MODE_Business_Panel.md
@MODE_DeepResearch.md
@MODE_Introspection.md
@MODE_Orchestration.md
@MODE_Task_Management.md
@MODE_Token_Efficiency.md

# MCP Documentation
@MCP_Caveman.md
@MCP_ClaudeMem.md
@MCP_Context7.md
@MCP_Engram.md
@MCP_Playwright.md
@MCP_Sequential.md
@MCP_Serena.md
@MCP_TokenSavior.md
```

> Files in `agents/` and `commands/` do **not** need to be imported in CLAUDE.md. They are picked up automatically.

Then add to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "bash ~/.claude/statusline-command.sh"
  }
}
```

#### Step 4 — Install gentle-ai plugins (optional but recommended)

```bash
# engram — persistent memory across sessions
claude plugin install engram@engram

# claude-mem — token-efficient codebase exploration
claude plugin marketplace add thedotmack/claude-mem
claude plugin install claude-mem@thedotmack

# caveman — ultra-compressed communication mode
claude plugin marketplace add JuliusBrussee/caveman
claude plugin install caveman@caveman
```

#### Step 5 — Verify

```
/sc:help      # should list /sc:commit
/sc:agent     # should show functional-code-expert and git-ticket-agent
```

---

### Kimi Code CLI setup

```bash
mkdir -p ~/.kimi

# Copy config files
cp kimi/config.toml ~/.kimi/
cp kimi/mcp.json ~/.kimi/
cp kimi/kimi.json ~/.kimi/

# Copy skills
for dir in kimi/skills/*/; do
  skill_name=$(basename "$dir")
  mkdir -p ~/.kimi/skills/"$skill_name"
  cp "$dir"SKILL.md ~/.kimi/skills/"$skill_name"/
done
```

> **Note:** `config.toml` uses OAuth for API authentication. The first run will prompt for login. No API keys are stored in these files.

See [`kimi/README.md`](kimi/README.md) for full Kimi configuration details.

---

### Bootstrap a new project (both assistants)

At the start of each new project, run in a Claude Code session:

```
/init-project
```

This initializes gentle-ai for that project: detects the stack, builds the skill registry (so rules are injected into sub-agents), and persists critical workflow rules to Engram memory. Run it once per project.

---

## Repository structure

### Standards (`standards/`)

| File | Purpose |
|------|---------|
| `DEVELOPMENT_STANDARDS.md` | Functional programming rules, git commit standards, security rules |
| `OVERRIDES.md` | Highest-priority rules that override default assistant behavior |
| `PRINCIPLES.md` | Core software engineering philosophy (SOLID, DRY, YAGNI) |
| `RULES.md` | Actionable behavioral rules with priority levels |
| `FLAGS.md` | Mode activation flags (`--think`, `--brainstorm`, etc.) |

### Kimi (`kimi/`)

Configuration files for Kimi Code CLI — the same ecosystem of rules, MCPs, and skills applied to the Kimi agent.

| File | Purpose |
|------|---------|
| `config.toml` | Global settings: model (k2.6), thinking mode, loop control, background tasks, services |
| `mcp.json` | MCP servers: engram, context7, rovo |
| `kimi.json` | Work directory registry |

See [`kimi/README.md`](kimi/README.md) for full details.

### Skills (`skills/`)

Skills are picked up by `/skill-registry` (Claude) or injected into context (Kimi) so their compact rules apply to every sub-agent.

| Skill | Purpose |
|-------|---------|
| `project-conventions` | Enforces commit flow (`/sc:commit` only), bare commands (no absolute paths), and post-change behavior (no proactive commit suggestions) |

### Agents (`agents/`)

Agents run as isolated subprocesses to keep the main context window clean.

| Agent | Invoked by | Purpose |
|-------|-----------|---------|
| `functional-code-expert` | Claude automatically | Code review and refactoring with functional programming principles |
| `git-ticket-agent` | `/sc:commit` | Ticket-aware branch/commit/PR creation for ClickUp and Jira |

### Scripts (`scripts/`)

| File | Purpose |
|------|---------|
| `statusline-command.sh` | Two-line status bar: model + git branch + 5h rate limit + token count on line 1; context window bar + cost + duration on line 2 |

### Slash commands

**`commands/sc/`** (invoked as `/sc:<name>`):

| Command | Usage |
|---------|-------|
| `/sc:commit` | Create ticket-prefixed commits, branches, and PRs |

**`commands/`** (invoked as `/<name>`):

| Command | Usage |
|---------|-------|
| `/init-project` | Bootstrap gentle-ai for a new project — run once per project |

---

## Key behaviors enforced

### No auto-execution without approval

These assistants **never** run destructive actions automatically — they always propose and wait for approval:

- Git commits and pushes
- Build commands (`npm run build`, `yarn build`, etc.)
- Dev servers (`npm run dev`, `uvicorn`, etc.)
- Package installs or migrations

After completing changes, the assistant stops and reports what changed. It does **not** suggest committing. You request it explicitly.

### Bare commands — no absolute paths

When working inside a project directory, commands run bare:

```bash
# ✅ Correct
git diff --stat
git status

# ❌ Wrong
git -C /Users/roger/git/my-project diff --stat
cd /Users/roger/git/my-project && git status
```

The shell is already in the right directory — no path repetition needed.

### Clean git commits

No AI references, no Co-Authored-By lines, no markdown in PR descriptions:

```
✅ Correct commit:
feat: implement user authentication system

✅ Correct PR description:
Adds JWT-based authentication with role-based access control, allowing
users to securely log in and access protected resources based on their role.

❌ Wrong:
## Summary
- ✅ Added JWT support in src/auth/jwt.ts
🤖 Generated with Claude Code
```

### Ticket-aware git workflow (`/sc:commit`)

Automatically formats branches, commits, and PRs with your ticket code.

**ClickUp** (format: `868guc790`):
```
Branch:  868guc790-implement-video-start-time
Commit:  868guc790: implement video start time playback
PR title: 868guc790: implement video start time playback

PR body:
Adds the ability for videos to begin playback at a specific timestamp,
allowing content editors to configure where viewers start watching.

Ticket: https://app.clickup.com/t/868guc790
```

**Jira/Bitbucket** (format: `PROJ-123`):
```
Branch:  PROJ-123-fix-auth-session-expiry
Commit:  PROJ-123: fix auth session expiry handling
PR title: PROJ-123: fix auth session expiry handling

PR body:
Resolves an issue where user sessions expired earlier than expected,
causing users to be logged out during active use.

Ticket: https://company.atlassian.net/browse/PROJ-123
```

The agent detects the ticket code from the current branch name automatically. If not found, it asks. Always shows a preview before executing.

**Usage:**
```bash
/sc:commit              # commit with ticket prefix
/sc:commit --branch     # create a new ticket-prefixed branch
/sc:commit --pr         # create a PR with ticket in title and plain description
/sc:commit --branch --pr  # full flow: branch + commit + PR
```

### Functional programming

All code written or reviewed follows these rules:

```javascript
// ✅ Correct
const activeUsers = users.filter(user => user.active);
const updateUser = (user, changes) => ({ ...user, ...changes });

// ❌ Wrong
let result = [];
for (let i = 0; i < users.length; i++) {
  if (users[i].active) result.push(users[i]);
}
```

- `const` only — `let` and `var` are flagged as critical issues
- No mutations — always return new values
- Pure functions — no side effects
- Self-documenting names — no comments needed

---

## MCPs & Plugins

### MCP servers — Claude Code

Configure via `claude mcp add -s user` or editing `~/.claude.json`.

| MCP | Command | Purpose |
|-----|---------|---------|
| `token-savior` | `uvx --from "token-savior-recall[mcp]" token-savior` | Codebase analysis, semantic memory, token reduction |
| `context7` | `npx -y @upstash/context7-mcp` | Official library documentation |
| `sequential-thinking` | `npx -y @modelcontextprotocol/server-sequential-thinking` | Structured multi-step reasoning |
| `playwright` | `npx -y @playwright/mcp@latest` | Browser automation and E2E testing |
| `chrome-devtools` | `npx -y chrome-devtools-mcp@latest` | Chrome DevTools automation |
| `serena` | see [serena docs](https://github.com/oraios/serena) | Semantic code navigation, symbol operations, session persistence |

```bash
claude mcp add token-savior -s user -- uvx --from "token-savior-recall[mcp]" token-savior
```

#### Disable Google MCPs

Claude Code ships with Gmail, Google Calendar, and Google Drive MCPs pre-configured. Disable them in `~/.claude.json` to avoid constant auth prompts:

```json
"disabledMcpServers": [
  "claude.ai Gmail",
  "claude.ai Google Calendar",
  "claude.ai Google Drive"
]
```

### MCP servers — Kimi Code CLI

Configure via `kimi mcp add` or editing `~/.kimi/mcp.json`.

| MCP | Transport | Command / URL | Purpose |
|-----|-----------|---------------|---------|
| `engram` | stdio | `engram mcp --tools=agent` | Persistent memory across sessions |
| `context7` | HTTP | `https://mcp.context7.com/mcp` | Official library documentation |
| `rovo` | stdio | `npx -y mcp-remote@latest https://mcp.atlassian.com/v1/mcp` | Atlassian Jira/Confluence integration |

```bash
kimi mcp add engram --stdio -- engram mcp --tools=agent
kimi mcp add context7 --url https://mcp.context7.com/mcp
kimi mcp add rovo --stdio -- npx -y mcp-remote@latest https://mcp.atlassian.com/v1/mcp
```

### Plugins (Claude Code only)

| Plugin | Source | Purpose |
|--------|--------|---------|
| `engram@engram` | official marketplace | Persistent memory across sessions — saves decisions, bugs, conventions |
| `claude-mem@thedotmack` | [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) | Codebase exploration via AST + planning skills (`smart-explore`, `make-plan`, `do`) |
| `caveman@caveman` | [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) | Ultra-compressed communication mode (~75% token reduction) |

> **engram vs claude-mem**: engram stores facts (memory), claude-mem navigates code (exploration). They complement each other.

```bash
# engram
claude plugin install engram@engram

# claude-mem
claude plugin marketplace add thedotmack/claude-mem
claude plugin install claude-mem@thedotmack

# caveman
claude plugin marketplace add JuliusBrussee/caveman
claude plugin install caveman@caveman
```

Caveman activates automatically each session. Switch modes with `/caveman lite`, `/caveman ultra`, or `stop caveman`.

---

## Global vs per-project configuration

**Global** (`~/.claude/` and `~/.kimi/`): Rules that apply to every project — coding standards, git conventions, agents, slash commands, MCPs.

**Per-project** (`.claude/CLAUDE.md` in the project root): Project-specific overrides — tech stack, local file conventions, specific patterns for that codebase. Run `/init-project` at the start of each new project to bootstrap Engram memory and the skill registry for that specific codebase. Example:

```markdown
# .claude/CLAUDE.md (in your project root)
This is a Next.js 14 app using App Router and Tailwind.
Database: PostgreSQL via Prisma. All queries go in src/lib/db/.
Run tests with: npm test
```

Per-project files take precedence over global ones when there's a conflict.

---

## Customization

- **Add your own agents**: create a `.md` file in `~/.claude/agents/` with a YAML frontmatter block (`name`, `description`, `model`, `color`) followed by the agent's instructions.
- **Add your own commands**: create a `.md` file in `~/.claude/commands/sc/` — it becomes available as `/sc:<filename>`.
- **Adjust standards**: edit `~/.claude/DEVELOPMENT_STANDARDS.md` directly. Changes take effect in the next Claude Code session.
- **Adjust Kimi settings**: edit `~/.kimi/config.toml` or `~/.kimi/mcp.json` directly.

---

## License

MIT — fork and adapt freely.
