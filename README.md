# Claude Code Configuration

Personal configuration files and custom agents for Claude Code CLI tool, emphasizing functional programming, clean code practices, and professional git workflows.

## Overview

This repository contains customized standards, behavioral modes, and specialized agents that override Claude Code's default behaviors to enforce:

- **Functional Programming**: Immutability, pure functions, const-only declarations
- **Professional Git Workflows**: Clean commits without AI references
- **Self-Documenting Code**: Clear naming over comments
- **Design Patterns**: SOLID principles and architectural best practices

## Repository Structure

```
claude-code-config/
├── standards/          # Core development standards
├── agents/             # Custom specialized agents
├── modes/              # Behavioral mode configurations
├── commands/sc/        # Custom slash commands / skills
└── mcp-docs/          # MCP server integration guides
```

## Installation

### Quick Setup

Copy all files to your Claude Code configuration directory:

```bash
# Clone the repository
git clone https://github.com/rogercastaneda/claude-code-config.git
cd claude-code-config

# Copy standards, modes, and MCP docs
cp -r standards/* ~/.claude/
cp -r modes/* ~/.claude/
cp -r mcp-docs/* ~/.claude/

# Copy custom agents
cp -r agents/* ~/.claude/agents/

# Copy custom slash commands
mkdir -p ~/.claude/commands/sc
cp -r commands/sc/* ~/.claude/commands/sc/
```

### Custom Agent Setup

Agents are placed in `~/.claude/agents/` and are automatically available to Claude Code. No additional registration needed.

### Slash Commands Setup

Commands in `~/.claude/commands/sc/` are available as `/sc:<name>` in any Claude Code session.

## Key Features

### 🔴 Critical Overrides

**Git Workflow Standards** (overrides Claude Code defaults):
- ❌ NO "Co-Authored-By: Claude" in commits
- ❌ NO "Generated with Claude Code" in PRs
- ❌ NO markdown formatting or emojis in PR descriptions
- ❌ NO technical file references in commit messages
- ✅ Clean, professional commit messages focused on business value

### 🟡 Functional Programming Standards

**Mandatory Practices**:
- `const`-only declarations (never `let` or `var`)
- Immutable data structures
- Pure functions and functional composition
- Higher-order functions (map, filter, reduce)
- Self-documenting code without comments

### 🟢 Code Quality Standards

- SOLID principles enforcement
- Design pattern application
- Separation of concerns
- Testability through dependency injection

## Files Overview

### Standards Directory

- **OVERRIDES.md**: System instruction overrides (highest priority)
- **DEVELOPMENT_STANDARDS.md**: Comprehensive coding standards
- **PRINCIPLES.md**: Core software engineering principles
- **RULES.md**: Actionable behavioral rules
- **FLAGS.md**: Mode activation triggers and flags

### Agents Directory

- **functional-code-expert.md**: Specialized agent for functional programming, code review, and architectural guidance
- **git-ticket-agent.md**: Ticket-aware git operations agent for ClickUp and Jira/Bitbucket workflows

### Commands Directory (`commands/sc/`)

Custom slash commands that extend Claude Code:

- **commit.md**: `/sc:commit` — ticket-aware commits, branches, and PRs with ClickUp/Jira integration

### Modes Directory

Behavioral modes that adapt Claude Code's approach to different tasks:
- Brainstorming Mode
- Deep Research Mode
- Introspection Mode
- Orchestration Mode
- Task Management Mode
- Token Efficiency Mode
- Business Panel Mode

### MCP Docs Directory

Integration guides for MCP servers:
- Context7 (documentation lookup)
- Playwright (browser automation)
- Sequential (structured reasoning)

## Usage Examples

### Enforcing Functional Patterns

When working on JavaScript/TypeScript projects, the configuration automatically:
- Flags `let` and `var` usage as critical errors
- Suggests immutable alternatives to mutations
- Recommends functional patterns over loops
- Enforces pure function design

### Professional Git Commits

All git commits and PRs will follow:
```
✅ CORRECT:
feat: implement user authentication system

Adds JWT-based authentication with role-based access control.
Users can now securely log in and access protected resources.

❌ WRONG:
## Summary
Implemented auth system

### Changes
- ✅ Added JWT support in src/auth/jwt.ts
- ✅ Updated User model

🤖 Generated with Claude Code
```

### Ticket-Aware Git Workflow (`/sc:commit`)

Use `/sc:commit` to create ticket-prefixed branches, commits, and PRs:

**ClickUp** (ticket format: `868guc790`):
```
Branch:  868guc790-implement-video-start-time
Commit:  868guc790: implement video start time playback
PR:      868guc790: implement video start time playback

        Adds the ability for videos to begin playback at a specific timestamp,
        allowing content editors to configure where viewers start watching.

        Ticket: https://app.clickup.com/t/868guc790
```

**Jira/Bitbucket** (ticket format: `PROJ-123`):
```
Branch:  PROJ-123-fix-auth-session-expiry
Commit:  PROJ-123: fix auth session expiry handling
PR:      PROJ-123: fix auth session expiry handling

        Resolves an issue where user sessions expired earlier than expected,
        causing users to be logged out unexpectedly during active use.

        Ticket: https://company.atlassian.net/browse/PROJ-123
```

The agent always shows a preview before executing any git operation.

### Explicit Approval Required

Claude Code will **never** auto-execute these without your instruction:
- Creating commits or pushing to remote
- Running build or dev server commands
- Installing packages or running migrations

### Self-Documenting Code

Code reviews automatically suggest:
```javascript
// ❌ BEFORE (imperative with comments)
let result = []; // stores filtered users
for (let i = 0; i < users.length; i++) {
  if (users[i].active) { // only active users
    result.push(users[i]);
  }
}

// ✅ AFTER (functional, self-documenting)
const activeUsers = users.filter(user => user.active);
```

## Customization

All files in this repository are meant to be customized to your workflow. Key areas to modify:

1. **DEVELOPMENT_STANDARDS.md**: Adjust functional programming rules to your preferences
2. **OVERRIDES.md**: Add project-specific overrides
3. **Agents**: Create new specialized agents for your domain
4. **Modes**: Add custom behavioral modes for your workflows

## Philosophy

This configuration enforces a philosophy of:

- **Evidence over assumptions**: All claims must be verifiable
- **Code over documentation**: Self-documenting code reduces documentation burden
- **Efficiency over verbosity**: Clear, concise communication
- **Quality over speed**: Maintain high standards even under pressure

## License

MIT License - Feel free to use and modify for your own projects.

## Contributing

This is a personal configuration repository, but feel free to fork and adapt to your needs. If you have suggestions for improvements, open an issue or PR.

## Acknowledgments

Built for use with [Claude Code](https://claude.ai/code) by Anthropic.
