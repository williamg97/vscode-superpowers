# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A structured development workflow for VS Code Copilot, adapted from [Superpowers for Claude Code](https://github.com/obra/superpowers). This repo contains skills, instructions, and agents that get installed into target projects via `install.sh`. There is no build system, no tests, no compiled code — it's pure markdown and shell.

## Key Commands

```bash
# Install skills into a target project
./install.sh /path/to/your/project
```

The installer copies `.github/skills/`, `.github/instructions/`, `.github/agents/`, and `.github/prompts/` into the target project's `.github/` directory. It merges `copilot-instructions.md` using marker comments (`<!-- copilot-superpowers-start/end -->`) to allow re-running without clobbering custom instructions.

## Architecture

```
.github/
├── copilot-instructions.md     # Always-on instructions (skill routing table + core principles)
├── instructions/               # Scoped instructions auto-applied by file glob
│   ├── tdd.instructions.md     # Applied to code files (*.ts, *.py, etc.)
│   └── verification.instructions.md  # Applied to all files
├── skills/                     # Discrete workflow skills (each in its own dir with SKILL.md)
│   ├── brainstorming/
│   ├── writing-plans/
│   ├── executing-plans/
│   ├── test-driven-development/
│   ├── systematic-debugging/
│   ├── verification-before-completion/
│   ├── requesting-code-review/
│   ├── receiving-code-review/
│   ├── finishing-a-development-branch/
│   ├── dispatching-parallel-agents/
│   ├── subagent-driven-development/
│   ├── using-git-worktrees/
│   ├── using-superpowers/
│   └── writing-skills/
├── prompts/                    # Native VS Code /slash-commands (one per skill)
│   ├── brainstorming.prompt.md
│   ├── writing-plans.prompt.md
│   └── ... (14 total)
└── agents/
    └── planner.agent.md        # Read-only agent for brainstorming (no file editing)
```

- **Prompts** (`.github/prompts/*.prompt.md`) are native VS Code Copilot slash commands. Each references a corresponding skill's `SKILL.md`. This is how skills get `/slash-command` invocation in VS Code Chat.
- **Skills** are self-contained markdown files (`SKILL.md`) that define a workflow, plus optional supporting reference docs (prompt templates, anti-patterns, examples).
- **Instructions** use YAML frontmatter `applyTo` globs to scope when they activate.
- **`copilot-instructions.md`** is the routing layer — it maps situations to skills and declares core principles (TDD, evidence before claims, YAGNI, design before code).
- The `tools.yaml` at repo root is an unrelated Portainer MCP server tool definition file.

## Upstream

This is a fork/adaptation of [obra/superpowers](https://github.com/obra/superpowers). When syncing with upstream, the main concern is keeping skills aligned — see `docs/plans/` for design docs on the original adaptation.
