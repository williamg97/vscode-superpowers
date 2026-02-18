# Copilot Superpowers — Design Document

**Date:** 2026-02-17
**Status:** APPROVED
**Approach:** Skills-First (Approach A)

## Problem

The [Superpowers](https://github.com/obra/superpowers) plugin for Claude Code provides a structured development workflow: brainstorming, planning, TDD, systematic debugging, code review, and verification. It enforces discipline through hooks, skills, and sub-agent orchestration.

VS Code Copilot has its own extensibility system (skills, agents, custom instructions) but no equivalent of Superpowers exists for it. This project adapts the Superpowers philosophy for Copilot's capabilities.

## Target Users

A team already familiar with VS Code Copilot, looking for structured workflows that prevent sloppy AI-assisted development.

## Architecture

### Skills-First

The primary vehicle is Copilot's native `SKILL.md` standard. Each workflow becomes a skill folder under `.github/skills/`. An always-on `copilot-instructions.md` tells Copilot to check for and invoke relevant skills before acting.

### Why Not Agents-First or Hybrid

- **Agents-First** requires explicit user invocation — no auto-triggering. Agent handoffs are brittle.
- **Hybrid** (skills + agents) adds two mental models and more files to maintain.
- **Skills-First** is the cleanest mapping. Copilot's `SKILL.md` format is nearly identical to Superpowers'. We add one targeted agent (planner) where tool restriction adds real value.

## Project Structure

```
copilot-superpowers/
├── .github/
│   ├── copilot-instructions.md          # Always-on skill routing + core principles
│   ├── instructions/
│   │   ├── tdd.instructions.md          # applyTo: code files
│   │   └── verification.instructions.md # applyTo: **
│   ├── skills/
│   │   ├── brainstorming/
│   │   │   └── SKILL.md
│   │   ├── writing-plans/
│   │   │   └── SKILL.md
│   │   ├── executing-plans/
│   │   │   └── SKILL.md
│   │   ├── test-driven-development/
│   │   │   └── SKILL.md
│   │   ├── systematic-debugging/
│   │   │   ├── SKILL.md
│   │   │   ├── root-cause-tracing.md
│   │   │   └── defense-in-depth.md
│   │   ├── requesting-code-review/
│   │   │   └── SKILL.md
│   │   ├── receiving-code-review/
│   │   │   └── SKILL.md
│   │   ├── verification-before-completion/
│   │   │   └── SKILL.md
│   │   └── finishing-work/
│   │       └── SKILL.md
│   └── agents/
│       └── planner.agent.md             # Read-only planning agent
├── README.md
├── LICENSE
└── install.sh
```

## Always-On Instructions (`copilot-instructions.md`)

Concise file that loads on every request. Contains:

1. **Skill routing** — Short rules telling Copilot to check skills before acting (building something → /brainstorming, debugging → /systematic-debugging, implementing → /executing-plans)
2. **Core principles** — Universal rules too short for their own skill: evidence before claims, YAGNI, run the actual program not just tests

Does NOT contain detailed workflows — those live in skills.

## Scoped Instructions (`.instructions.md`)

| File | `applyTo` | Content |
|------|-----------|---------|
| `tdd.instructions.md` | `**/*.{ts,tsx,js,jsx,py,go,rs,java}` | Write tests first. Red-green-refactor. No implementation without a failing test. |
| `verification.instructions.md` | `**` | Don't claim success without evidence. Run commands, check output, report with proof. |

## Skill Adaptations

### Direct ports (minor rewrites)

| Skill | Changes |
|-------|---------|
| **brainstorming** | Remove `Skill()` tool calls, replace with `/writing-plans` references. Keep one-question-at-a-time, design-before-code gate, YAGNI. |
| **writing-plans** | Remove sub-agent/worktree references. Keep bite-sized tasks, plan file format, TDD emphasis. |
| **test-driven-development** | Remove Claude-specific tooling. Keep red-green-refactor cycle, anti-rationalization rules. |
| **systematic-debugging** | Port SKILL.md + supporting .md files. Keep 4-phase process. Include shell scripts as reference resources. |
| **requesting-code-review** | Remove sub-agent dispatch. Reframe as review checklist before committing. |
| **receiving-code-review** | Tool-agnostic already. Minimal changes. |
| **verification-before-completion** | Evidence-before-claims table is universal. Minimal changes. |

### Significantly adapted

| Skill | Changes |
|-------|---------|
| **executing-plans** | No sub-agent dispatch in Copilot. Rewrite as: work through tasks sequentially, commit after each, pause for user checkpoint every N tasks. |
| **finishing-work** | Replaces `finishing-a-development-branch`. Remove worktree cleanup. Keep: verify tests, present merge/PR/keep options, final verification. |

### Dropped (no Copilot equivalent)

| Skill | Reason |
|-------|--------|
| `dispatching-parallel-agents` | Copilot has no parallel sub-agent dispatch |
| `subagent-driven-development` | No `Task` tool equivalent |
| `using-git-worktrees` | Copilot can't orchestrate worktree lifecycle |
| `using-superpowers` | Becomes `copilot-instructions.md` |
| `writing-skills` | Meta-skill for Superpowers itself |

## Planner Agent (`planner.agent.md`)

```yaml
---
name: planner
description: Read-only planning agent for brainstorming and design phases
tools: ['search', 'githubRepo', 'fetch']
---
```

Restricts Copilot to read-only tools during brainstorming and planning. Users switch to `@planner` when exploring ideas, preventing premature code generation.

## Installation

`install.sh` copies `.github/` contents into a target project:

- Copies `skills/`, `agents/`, `instructions/` into target `.github/`
- If `copilot-instructions.md` exists, finds and replaces the `<!-- copilot-superpowers-start -->` / `<!-- copilot-superpowers-end -->` marker section (or appends if not present)
- Idempotent — safe to re-run on updates
- Prints summary of installed files

## Philosophy Preserved

- **Test-Driven Development** — write tests first, always
- **Systematic over ad-hoc** — process over guessing
- **Complexity reduction** — simplicity as primary goal
- **Evidence over claims** — verify before declaring success
- **Design before code** — brainstorm and plan before implementing
- **YAGNI** — only build what's requested
