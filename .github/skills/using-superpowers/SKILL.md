---
name: using-superpowers
description: Use when starting any conversation - establishes how to find and use skills, requiring skill invocation before ANY response including clarifying questions
---

# Using Skills

## The Rule

**Invoke relevant or requested skills BEFORE any response or action.** Even a 1% chance a skill might apply means you should check. If an invoked skill turns out to be wrong for the situation, you don't need to follow it.

## How to Access Skills

Skills live in `.github/skills/`. Invoke them using `/skill-name` in Copilot.

When a skill applies:
1. Invoke it with `/skill-name`
2. Announce: "Using [skill] to [purpose]"
3. Follow the skill exactly

## Skill Routing

| Situation | Skill |
|-----------|-------|
| Building something new | `/brainstorming` first — design before code |
| Have a design, need a plan | `/writing-plans` — break into bite-sized tasks |
| Have a plan, need to implement | `/executing-plans` — sequential with checkpoints |
| Implementing a feature or bugfix | `/test-driven-development` — test first, always |
| Debugging any issue | `/systematic-debugging` — root cause before fixes |
| About to claim done or commit | `/verification-before-completion` — evidence before claims |
| Requesting feedback on work | `/requesting-code-review` — review checklist |
| Receiving review feedback | `/receiving-code-review` — verify before implementing |
| Implementation complete | `/finishing-a-development-branch` — verify tests, present options |
| 2+ independent tasks | `/dispatching-parallel-agents` — parallelize work |
| Executing a plan task-by-task | `/subagent-driven-development` — fresh context per task |
| Creating or editing skills | `/writing-skills` — TDD for documentation |

## Skill Priority

When multiple skills could apply:
1. **Process skills first** (brainstorming, debugging) — these determine HOW to approach the task
2. **Implementation skills second** — these guide execution

"Let's build X" → brainstorming first, then implementation skills.
"Fix this bug" → systematic-debugging first, then domain-specific skills.

## Red Flags — You're Rationalizing

| Thought | Reality |
|---------|---------|
| "This is just a simple question" | Questions are tasks. Check for skills. |
| "I need more context first" | Skill check comes BEFORE clarifying questions. |
| "Let me explore the codebase first" | Skills tell you HOW to explore. Check first. |
| "This doesn't need a formal skill" | If a skill exists, use it. |
| "I remember this skill" | Skills evolve. Read current version. |
| "The skill is overkill" | Simple things become complex. Use it. |
| "I'll just do this one thing first" | Check BEFORE doing anything. |

## Skill Types

**Rigid** (TDD, debugging): Follow exactly. Don't adapt away the discipline.

**Flexible** (patterns): Adapt principles to context.

The skill itself tells you which it is.
