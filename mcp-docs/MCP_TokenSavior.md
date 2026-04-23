# Token Savior MCP Server

**Purpose**: Semantic codebase analysis, symbol navigation, context compression, and intelligent code search.

## Triggers
- Searching for a function, class, or symbol across a large codebase
- Understanding call chains, dependencies, or impact of a change
- Finding dead code, duplicate classes, or import cycles
- Getting full context around a specific symbol before editing
- Context window pressure — use `pack_context` or `corpus_query` to compress
- Need semantic search (not just grep) across multiple files
- Finding which tests are affected by a change (`find_impacted_test_files`)
- Analyzing env var usage across the project (`get_env_usage`)

## Choose When
- **Over grep/find**: When you need semantic understanding, not just text matching
- **Over reading many files**: Use `get_function_source`, `get_class_source`, or `get_edit_context` to get only what matters
- **For impact analysis**: `get_change_impact` before refactoring
- **For context compression**: `pack_context` when approaching token limits

## Key Tools
| Tool | Use for |
|------|---------|
| `find_symbol` | Locate any function/class/variable by name |
| `get_function_source` | Get source of a specific function |
| `get_edit_context` | Get surrounding context before editing |
| `get_call_chain` | Trace call paths between symbols |
| `get_change_impact` | Understand blast radius of a change |
| `find_impacted_test_files` | Find tests affected by changed symbols |
| `search_codebase` | Semantic search across project |
| `pack_context` | Compress codebase context to save tokens |
| `get_env_usage` | Find all env var references in codebase |
| `find_dead_code` | Identify unused code |
| `get_routes` | List all API routes |
| `corpus_query` | Query indexed codebase knowledge |

## Setup Required
Call `set_project_root` or `switch_project` first if working in a new repo. Use `reindex` after large changes.

## Works Best With
- **Sequential**: Token Savior finds symbols → Sequential reasons about architecture
- **Context7**: Token Savior locates usage → Context7 provides official API docs
