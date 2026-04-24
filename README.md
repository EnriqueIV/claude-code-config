# Claude Code Config

Personal configuration files, custom agents, and slash commands for [Claude Code](https://claude.ai/code).

Enforces functional programming standards, ticket-aware git workflows, and professional commit conventions. Designed to work on top of the [SuperClaude](https://github.com/NickAltmann/SuperClaude) framework.

---

## Prerequisites

Before installing, make sure you have the following:

**Required:**
- [Claude Code](https://claude.ai/code) installed and authenticated (`claude --version`)
- [Node.js](https://nodejs.org/) 18+ (Claude Code dependency)

**Optional but recommended:**
- [GitHub CLI](https://cli.github.com/) (`gh`) — required for `/sc:commit --pr` to create pull requests
  ```bash
  brew install gh    # macOS
  gh auth login      # authenticate
  ```

---

## How Claude Code loads configuration

Claude Code looks for a `~/.claude/CLAUDE.md` file at startup. This file is the entry point for all global configuration. It can import other files using the `@filename` syntax:

```markdown
# CLAUDE.md
@DEVELOPMENT_STANDARDS.md
@RULES.md
@MODE_Brainstorming.md
```

Each `@import` injects the referenced file's content into every session. This is how standards, modes, and behavioral overrides are applied globally across all projects.

**Agents** (`~/.claude/agents/`) and **slash commands** (`~/.claude/commands/`) are loaded automatically by Claude Code — no imports needed in CLAUDE.md.

---

## Installation

### Step 1 — Install SuperClaude (framework dependency)

This config is designed to extend SuperClaude. Install it first:

```bash
git clone https://github.com/NickAltmann/SuperClaude.git /tmp/superclaude
cd /tmp/superclaude
./install.sh
```

This creates `~/.claude/CLAUDE.md` with the base framework imports and populates `~/.claude/commands/sc/` with the built-in skills.

> If you prefer not to use SuperClaude, skip this step — the custom agents and `/sc:commit` command will still work. You will just need to create `~/.claude/CLAUDE.md` manually (see below).

### Step 2 — Clone this repository

```bash
git clone https://github.com/rogercastaneda/claude-code-config.git
cd claude-code-config
```

### Step 3 — Copy files to `~/.claude/`

```bash
# Standards and behavioral overrides → go directly in ~/.claude/
cp standards/* ~/.claude/

# Behavioral modes → go directly in ~/.claude/
cp modes/* ~/.claude/

# MCP integration guides (engram, claude-mem, caveman, token-savior, serena, etc.) → go directly in ~/.claude/
cp mcp-docs/* ~/.claude/

# Custom agents → ~/.claude/agents/
mkdir -p ~/.claude/agents
cp agents/* ~/.claude/agents/

# Custom slash commands → ~/.claude/commands/sc/
mkdir -p ~/.claude/commands/sc
cp commands/sc/* ~/.claude/commands/sc/
```

### Step 4 — Register files in CLAUDE.md

Open `~/.claude/CLAUDE.md` and add imports for the files copied in Step 3. Add them in the appropriate section (or append at the end):

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

### Step 5 — Verify the installation

Start a new Claude Code session and run:

```
/sc:help
```

You should see `/sc:commit` listed among the available commands. To verify agents are loaded:

```
/sc:agent
```

The `functional-code-expert` and `git-ticket-agent` should appear in the list.

---

## What's included

### Standards (`standards/`)

| File | Purpose |
|------|---------|
| `DEVELOPMENT_STANDARDS.md` | Functional programming rules, git commit standards, security rules |
| `OVERRIDES.md` | Highest-priority rules that override Claude Code defaults |
| `PRINCIPLES.md` | Core software engineering philosophy (SOLID, DRY, YAGNI) |
| `RULES.md` | Actionable behavioral rules with priority levels |
| `FLAGS.md` | Mode activation flags (`--think`, `--brainstorm`, etc.) |

### Agents (`agents/`)

Agents run as isolated subprocesses to keep the main context window clean.

| Agent | Invoked by | Purpose |
|-------|-----------|---------|
| `functional-code-expert` | Claude automatically | Code review and refactoring with functional programming principles |
| `git-ticket-agent` | `/sc:commit` | Ticket-aware branch/commit/PR creation for ClickUp and Jira |

### Slash commands (`commands/sc/`)

| Command | Usage |
|---------|-------|
| `/sc:commit` | Create ticket-prefixed commits, branches, and PRs |

---

## Key behaviors enforced

### No auto-execution without approval

Claude Code will **never** run these automatically — it will always propose and wait:

- Git commits and pushes
- Build commands (`npm run build`, `yarn build`, etc.)
- Dev servers (`npm run dev`, `uvicorn`, etc.)
- Package installs or migrations

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

### MCP servers

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

### Plugins

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

**Global** (`~/.claude/`): Rules that apply to every project — coding standards, git conventions, agents, slash commands. This is where everything in this repo goes.

**Per-project** (`.claude/CLAUDE.md` in the project root): Project-specific overrides — tech stack, local file conventions, specific patterns for that codebase. Example:

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

---

## License

MIT — fork and adapt freely.
