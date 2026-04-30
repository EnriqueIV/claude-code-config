---
name: functional-code-expert
description: Global functional programming and clean code standards. Apply to ALL code writing, review, and refactoring tasks. Enforces immutability, pure functions, self-documenting code, and SOLID principles.
triggers:
  - write code
  - refactor
  - review code
  - code style
  - implement
  - function
  - typescript
  - javascript
  - react
---

# Functional Programming & Clean Code Standards

Apply these rules to ALL code you write or review. No exceptions.

## 1. Immutability — NON-NEGOTIABLE

- Use **ONLY `const`** for variable declarations. `let` and `var` are forbidden.
- If reassignment seems necessary, refactor to functional patterns (map, filter, reduce, recursion).
- Treat all data structures as immutable. Use spread operators, `Object.assign`, or immutable update patterns.
- When reviewing code, flag any `let` or `var` as a critical issue and provide `const`-based alternatives.

## 2. Functional Programming Principles

- Write **pure functions**: same input → same output, no side effects.
- Prefer **higher-order functions**: `map`, `filter`, `reduce`, `compose`, `pipe`.
- Use **function composition** over inheritance.
- Apply **currying** and partial application when it improves clarity.
- Use **declarative patterns** over imperative loops. Replace `for`/`while` with `map`/`filter`/`reduce`.
- Leverage closures for encapsulation.
- Use recursion for iterative problems when appropriate (with tail-call optimization awareness).

## 3. Design Patterns & Architecture

- Apply **SOLID** principles rigorously.
- Favor **composition over inheritance**.
- Use appropriate design patterns: Factory, Strategy, Observer, Command, etc.
- Design for **testability** with dependency injection.
- Create modular, loosely-coupled components.
- Apply **separation of concerns** systematically.

## 4. Self-Documenting Code

- Write code so clear that **comments are unnecessary**.
- Use descriptive, **intention-revealing names** for functions and variables.
- Keep functions small and focused on **single responsibilities**.
- Structure code to tell a story that reads naturally.
- **NEVER add code comments** — if code needs explanation, refactor for clarity.
- Provide architectural explanations in your **response text**, not in code.

## 5. Hard Constraints

- **NEVER** create git commits. If committing is needed, tell the user to run `/skill:sc-commit` or ask them to commit explicitly.
- **NEVER** run build commands (`npm run build`, `vite build`, etc.) unless the user explicitly requests it in that message.
- **NEVER** start dev servers or any long-running processes.
- **NEVER** install packages or modify `package.json` / lock files without explicit instruction.
- When you need a command to be run, always propose it clearly and stop — do not execute it.

## 6. Code Review Checklist

When reviewing code:
1. Flag any use of `var` or `let` as critical issues.
2. Identify mutations and suggest immutable alternatives.
3. Replace imperative patterns with functional equivalents.
4. Suggest design patterns where appropriate.
5. Recommend refactoring for self-documentation.

## Quality Standards

- Every variable must use `const` — zero exceptions.
- Code must be readable without any comments.
- Functions should be pure unless explicitly handling side effects at boundaries.
- Data structures must be treated as immutable.
- Names must be descriptive enough to eliminate the need for comments.
- Architectural decisions must be explained in response text separate from the code.
