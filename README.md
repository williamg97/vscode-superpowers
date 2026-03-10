# Copilot Superpowers

A structured development workflow for VS Code Copilot, adapted from [Superpowers for Claude Code](https://github.com/obra/superpowers).

Superpowers teaches your AI coding assistant discipline: design before code, test before implementation, evidence before claims.

## Installation

```bash
git clone https://github.com/your-org/copilot-superpowers.git
cd copilot-superpowers
./install.sh /path/to/your/project
```

This copies skills, instructions, and agents into your project's `.github/` directory. Re-run to update.

## What's Inside

### Always-On Instructions (`.github/copilot-instructions.md`)

Loaded on every Copilot request. Routes to skills and enforces core principles: evidence before claims, TDD, YAGNI, design before code.

### Scoped Instructions (`.github/instructions/`)

- **tdd.instructions.md** — Applied to code files. Enforces test-first workflow.
- **verification.instructions.md** — Applied to all files. Requires evidence before completion claims.

### Skills (`.github/skills/`)

| Skill | Purpose |
|-------|---------|
| **brainstorming** | Design before code. One question at a time, propose approaches, get approval. |
| **writing-plans** | Break work into bite-sized tasks with exact files, code, and commands. |
| **executing-plans** | Work through plan tasks sequentially with review checkpoints. |
| **test-driven-development** | Red-green-refactor. No production code without a failing test. |
| **systematic-debugging** | Four-phase root cause process. No fixes without investigation. |
| **verification-before-completion** | Evidence before claims. Run the command, then report. |
| **requesting-code-review** | Review checklist before merging. |
| **receiving-code-review** | Technical evaluation of feedback, not performative agreement. |
| **using-git-worktrees** | Create isolated workspaces for feature work. |
| **finishing-work** | Verify tests, present merge/PR/keep/discard options. |

### Agent (`.github/agents/`)

- **planner** — Read-only agent for brainstorming and design. Cannot modify files.

See [docs/CHEATSHEET.md](docs/CHEATSHEET.md) for a quick reference of all skills, workflows, and decision trees.

## The Workflow

1. **Brainstorm** — Copilot asks questions, explores approaches, presents design for approval
2. **Plan** — Design becomes a detailed implementation plan with bite-sized tasks
3. **Execute** — Work through tasks with TDD, committing after each
4. **Review** — Check work against plan between batches
5. **Finish** — Verify tests, merge or create PR

## Philosophy

- **Test-Driven Development** — Write tests first, always
- **Systematic over ad-hoc** — Process over guessing
- **Complexity reduction** — Simplicity as primary goal
- **Evidence over claims** — Verify before declaring success
- **Design before code** — Think, then build

## Updating

Re-run `./install.sh /path/to/your/project` to update skills in place. The install script uses marker comments to replace the Superpowers section in `copilot-instructions.md` without touching your custom instructions.

## Credits

Adapted from [Superpowers](https://github.com/obra/superpowers) by Jesse Vincent. The original is built for Claude Code — this version adapts the same philosophy for VS Code Copilot's native extensibility (skills, agents, custom instructions).

## License

MIT
