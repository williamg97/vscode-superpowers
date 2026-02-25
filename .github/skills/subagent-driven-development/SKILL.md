---
name: subagent-driven-development
description: Use when executing implementation plans with independent tasks in the current session
---

# Subagent-Driven Development

Execute a plan by giving each task fresh context, with a two-stage review after each: spec compliance first, then code quality.

**Core principle:** Fresh context per task + two-stage review (spec then quality) = high quality, fast iteration.

## When to Use

**Use when:**
- You have an implementation plan with mostly independent tasks
- You want review checkpoints after each task (not just end)
- You want to catch spec gaps before building the next task on top

**vs. `/executing-plans`:**
- Subagent-driven: review after EACH task, fresh context per task
- Executing-plans: review after each batch of 3, same context throughout

## The Process

### 1. Set Up

```bash
# Ensure you're on a feature branch, not main
git checkout -b feature/<name>
```

Read the plan once. Extract all tasks and their full text. Note any shared context that tasks depend on.

### 2. For Each Task

**a. Implement with fresh context**

Start a new Copilot chat (or use `/new`). Provide:
- The task description and steps (from the plan)
- The relevant surrounding context (don't make it read the whole plan)
- Constraints: "Follow TDD, commit after each step"

**b. Spec compliance review**

Before moving on, check: does the implementation match what the plan specified?

Use `/requesting-code-review` and check specifically:
- [ ] All requirements from the task are implemented
- [ ] Nothing extra was added (YAGNI)
- [ ] No placeholders or TODOs left unresolved

If spec gaps found → fix them before continuing.

**c. Code quality review**

After spec compliance passes:
- [ ] Tests exist and are real (not testing mocks)
- [ ] No magic numbers, dead code, swallowed errors
- [ ] Implementation is clean and minimal

If quality issues found → fix them, re-review, then continue.

**d. Mark complete and move on**

Only when both reviews pass → move to next task.

### 3. Final Review and Finish

After all tasks complete:
- Run the full test suite
- Do a final review of the entire implementation
- Use `/finishing-a-development-branch` to merge, create PR, or clean up

## Red Flags

**Never:**
- Start implementation on main/master without explicit user consent
- Skip spec compliance review (even if code looks clean)
- Run code quality review before spec compliance passes (wrong order)
- Accept "close enough" on spec compliance — it either matches or it doesn't
- Move to next task while either review has open issues

**If implementation fails:**
- Start fresh with a new Copilot chat with specific fix instructions
- Don't try to fix in the same context (pollution)

**If task reveals the plan is wrong:**
- Stop, discuss with human partner
- Update the plan, then continue

## Integration

**Requires:**
- `/writing-plans` — Creates the plan this skill executes
- `/requesting-code-review` — Review checklist after each task
- `/finishing-a-development-branch` — Complete development after all tasks

**Implementer tasks should use:**
- `/test-driven-development` — TDD for each task
- `/verification-before-completion` — Evidence before claims
