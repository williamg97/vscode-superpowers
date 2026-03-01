---
name: writing-skills
description: Use when creating new skills, editing existing skills, or verifying skills work before deployment
---

# Writing Skills

## Overview

Writing skills IS Test-Driven Development applied to process documentation.

**Core principle:** If you didn't watch an agent fail without the skill, you don't know if the skill teaches the right thing.

**The Iron Law:** No skill without a failing test first. Same as TDD — no exceptions.

## What is a Skill?

A **skill** is a reference guide for proven techniques, patterns, or workflows. Skills help future AI instances find and apply effective approaches.

**Skills are:** Reusable techniques, patterns, tools, reference guides

**Skills are NOT:** Narratives about how you solved a problem once

## TDD Applied to Skills

| TDD Concept | Skill Creation |
|-------------|----------------|
| Test case | Pressure scenario (test WITHOUT skill) |
| Production code | Skill document (SKILL.md) |
| RED | Agent violates rule without skill (baseline) |
| GREEN | Agent complies with skill present |
| Refactor | Close loopholes while maintaining compliance |

Follow RED-GREEN-REFACTOR. Write baseline scenario BEFORE writing the skill.

## SKILL.md Structure

**Frontmatter (YAML):**
- Only two fields: `name` and `description`
- `name`: letters, numbers, hyphens only
- `description`: "Use when..." — triggering conditions ONLY, never workflow summary

```markdown
---
name: skill-name
description: Use when [specific triggering conditions and symptoms]
---

# Skill Name

## Overview
What is this? Core principle in 1-2 sentences.

## When to Use
Bullet list with symptoms and use cases.
When NOT to use.

## Core Pattern
Steps or approach.

## Common Mistakes
What goes wrong + fixes.

## Red Flags
When to stop and re-examine.
```

## Critical: Description Field

**NEVER summarize the skill's workflow in the description.** Only triggering conditions.

```yaml
# BAD: Summarizes workflow — AI may follow description instead of reading skill
description: Use when executing plans - dispatches agent per task with code review between tasks

# GOOD: Just triggering conditions
description: Use when executing implementation plans with independent tasks in the current session
```

When the description summarizes workflow, AI may follow the description shortcut instead of reading the full skill. The skill body becomes documentation that gets skipped.

## Anti-Rationalization Hardening

For discipline-enforcing skills (TDD, verification, debugging):

**1. Add the spirit clause early:**
```
Violating the letter of the rules is violating the spirit of the rules.
```

**2. Close every loophole explicitly:**
```markdown
# BAD
Write code before test? Delete it.

# GOOD
Write code before test? Delete it. Start over.
No exceptions:
- Don't keep it as "reference"
- Don't "adapt" it while writing tests
- Delete means delete
```

**3. Build a rationalization table** from baseline testing. Every excuse agents make goes in the table.

**4. Create a red flags list** — make it easy for agents to self-check when rationalizing.

## Deployment Checklist

Before deploying a new or edited skill:

**RED — Run baseline scenario WITHOUT skill:**
- [ ] Document exact behavior and rationalizations verbatim

**GREEN — Write minimal skill addressing those failures:**
- [ ] `name` uses only letters, numbers, hyphens
- [ ] `description` starts with "Use when..." (triggering conditions only)
- [ ] Addresses specific baseline failures
- [ ] Run scenario WITH skill — agent now complies

**REFACTOR — Close loopholes:**
- [ ] Identify new rationalizations from testing
- [ ] Add explicit counters
- [ ] Re-test until bulletproof

**Quality:**
- [ ] No narrative storytelling
- [ ] Common mistakes section
- [ ] Red flags list (for discipline skills)

## Directory Structure

```
.github/skills/
  skill-name/
    SKILL.md           # Main reference (required)
    supporting-file.*  # Only for heavy reference or reusable tools
```

All skills in a flat namespace — no subdirectories.

## When to Create vs. Document in CLAUDE.md

**Create a skill when:**
- Technique wasn't intuitively obvious
- You'd reference this across projects
- Pattern applies broadly (not project-specific)

**Put in CLAUDE.md instead:**
- Project-specific conventions
- Standard practices well-documented elsewhere
- One-off solutions
