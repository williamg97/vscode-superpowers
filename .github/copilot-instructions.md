# Superpowers

You have access to specialized skills in `.github/skills/`. Check if a skill applies before responding to any task.

## Skill Routing

| Situation | Skill |
|-----------|-------|
| Building something new | `/brainstorming` first — design before code |
| Have a design, need a plan | `/writing-plans` — break into bite-sized tasks |
| Have a plan, need to implement | `/executing-plans` — sequential with checkpoints |
| Implementing a feature or bugfix | `/test-driven-development` — test first, always |
| Debugging any issue | `/systematic-debugging` — root cause before fixes |
| About to commit, merge, or claim done | `/verification-before-completion` — evidence before claims |
| Requesting feedback on work | `/requesting-code-review` — review checklist |
| Receiving review feedback | `/receiving-code-review` — verify before implementing |
| Need isolated workspace for feature work | `/using-git-worktrees` — create isolated worktree |
| Implementation complete | `/finishing-a-development-branch` — verify tests, present options |
| 2+ independent tasks | `/dispatching-parallel-agents` — parallelize work |
| Executing a plan task-by-task | `/subagent-driven-development` — fresh context per task |
| Creating or editing skills | `/writing-skills` — TDD for documentation |

## Core Principles (always active)

- **Evidence before claims:** Don't say "tests pass" without running them. Don't say "done" without verification.
- **TDD:** Write the test first. Watch it fail. Write minimal code to pass. No exceptions.
- **YAGNI:** Only build what's requested. No speculative features, no premature abstraction.
- **Run the program:** Tests passing is necessary but not sufficient. Run the actual program and verify output.
- **Design before code:** Don't write implementation code until a design has been discussed and approved.
- **One thing at a time:** When debugging, change one variable. When implementing, one task. When reviewing, one item.
