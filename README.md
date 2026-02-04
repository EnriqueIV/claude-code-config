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
└── mcp-docs/          # MCP server integration guides
```

## Installation

### Quick Setup

Copy all files to your Claude Code configuration directory:

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/claude-code-config.git
cd claude-code-config

# Copy to Claude Code config directory
cp -r standards/* ~/.claude/
cp -r modes/* ~/.claude/
cp -r mcp-docs/* ~/.claude/
```

### Custom Agent Setup

Custom agents need to be registered with Claude Code. See the `agents/` directory for documentation on each agent's purpose and capabilities.

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
