# Superpowers Cheatsheet

Quick reference for all skills and workflows.

## Skill Quick Reference

| Skill | One-Liner | When to Use |
|-------|-----------|-------------|
| `/brainstorming` | Design before code | Starting any new feature or change |
| `/writing-plans` | Spec → bite-sized tasks | Have an approved design |
| `/executing-plans` | Work through tasks sequentially | Have a written plan |
| `/test-driven-development` | Red-green-refactor | Writing any code |
| `/systematic-debugging` | Root cause before fixes | Any bug or unexpected behavior |
| `/verification-before-completion` | Evidence before claims | About to say "done" or commit |
| `/using-git-worktrees` | Isolated workspace | Feature work needing branch isolation |
| `/requesting-code-review` | Structured review checklist | Ready for feedback |
| `/receiving-code-review` | Verify before implementing | Got review feedback |
| `/finishing-a-development-branch` | Merge/PR/keep/discard | Implementation complete |
| `/dispatching-parallel-agents` | Parallelize independent work | 2+ tasks with no shared state |
| `/subagent-driven-development` | Fresh context per task | Executing plan tasks |
| `/writing-skills` | TDD for documentation | Creating or editing skills |

## The Workflow

```
Brainstorm → Plan → Worktree → Execute (TDD loop) → Review → Finish
```

### 1. Brainstorm (`/brainstorming`)
- Explore context, ask one question at a time
- Propose 2-3 approaches with trade-offs
- Present design section by section, get approval
- Save spec to `docs/plans/YYYY-MM-DD-<topic>-design.md`

### 2. Plan (`/writing-plans`)
- Break spec into chunks (max 1000 lines each)
- Each task: exact files, code snippets, commands
- Checkbox syntax (`- [ ]`) for tracking
- Review each chunk before moving on

### 3. Worktree (`/using-git-worktrees`)
- Priority: existing dir → project instructions → ask user
- Verify `.worktrees/` is in `.gitignore`
- Auto-detect project setup (npm/cargo/pip/go)
- Run baseline tests before starting work

### 4. Execute (`/executing-plans` + `/test-driven-development`)
- Work through plan tasks sequentially
- For each task: write test → watch fail → implement → pass → refactor
- Commit after each passing task
- Review checkpoint every 3-5 tasks

### 5. Review (`/requesting-code-review` + `/receiving-code-review`)
- Run full test suite, check coverage
- Review against spec: nothing missing, nothing extra
- Evaluate feedback technically, don't blindly agree

### 6. Finish (`/finishing-a-development-branch`)
- Verify all tests pass
- Present options: merge, PR, keep branch, discard
- Clean up worktree if used

## Decision Tree

```
Got a task?
├── Bug or unexpected behavior?
│   └── /systematic-debugging
├── New feature or change?
│   ├── Have a design? No → /brainstorming
│   ├── Have a plan? No → /writing-plans
│   ├── Need isolation? → /using-git-worktrees
│   └── Ready to code? → /executing-plans + /test-driven-development
├── Multiple independent tasks?
│   └── /dispatching-parallel-agents
├── About to say "done"?
│   └── /verification-before-completion
└── Implementation complete?
    └── /finishing-a-development-branch
```

## Iron Laws

1. **No code without a failing test** — Write the test first. Watch it fail. Then implement.
2. **No claims without evidence** — Run the command. Show the output. Then report.
3. **No fixes without investigation** — Understand the root cause. Then fix at the source.
4. **No implementation without design** — Brainstorm. Get approval. Then build.

## TDD Cycle

```
RED:    Write test → Run → Confirm it FAILS (not syntax error — missing feature)
GREEN:  Write minimum code → Run → All tests pass
REFACTOR: Clean up → Run → Still green
COMMIT: One logical change per commit
```

## Debugging Phases

| Phase | Action | Output |
|-------|--------|--------|
| 1. Observe | Gather data, reproduce, read errors | Exact reproduction steps |
| 2. Hypothesize | Form testable theory from evidence | "If X, then Y" statement |
| 3. Test | Design experiment to confirm/deny | Evidence for/against theory |
| 4. Fix | Fix at root cause, add regression test | Failing test → passing test |

## Supporting References

Each skill includes reference docs for deeper guidance:

| Skill | Reference | Purpose |
|-------|-----------|---------|
| test-driven-development | `testing-anti-patterns.md` | 5 common testing mistakes |
| systematic-debugging | `root-cause-tracing.md` | Trace bugs to their origin |
| systematic-debugging | `condition-based-waiting.md` | Fix flaky async tests |
| systematic-debugging | `defense-in-depth.md` | Multi-layer validation |
| systematic-debugging | `find-polluter.sh` | Find test pollution source |
| systematic-debugging | `test-pressure-{1,2,3}.md` | Practice under pressure |
| brainstorming | `spec-document-reviewer-prompt.md` | Spec review template |
| writing-plans | `plan-document-reviewer-prompt.md` | Plan review template |
| requesting-code-review | `code-reviewer.md` | Review agent template |
| subagent-driven-development | `implementer-prompt.md` | Implementer dispatch |
| subagent-driven-development | `spec-reviewer-prompt.md` | Spec compliance check |
| subagent-driven-development | `code-quality-reviewer-prompt.md` | Quality review template |

## Common Rationalizations (Don't Fall For These)

| Thought | Reality |
|---------|---------|
| "This is too simple for TDD" | Simple things are where TDD is fastest |
| "I'll add tests after" | You won't. And they'll test implementation, not behavior |
| "I know what the bug is" | You have a theory. Test it before fixing |
| "Let me just try this quick fix" | Quick fixes become permanent. Investigate first |
| "The tests pass, so it works" | Run the actual program. Tests are necessary, not sufficient |
| "I'll clean this up later" | Later never comes. Refactor now while tests are green |
| "This doesn't need a design" | Every project needs a design. It can be short, but it must exist |
