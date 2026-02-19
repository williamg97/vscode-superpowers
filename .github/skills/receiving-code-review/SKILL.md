---
name: receiving-code-review
description: "Use when receiving code review feedback — requires technical evaluation, not performative agreement or blind implementation"
---

# Receiving Code Review

## Overview

Code review requires technical evaluation, not emotional performance.

**Core principle:** Verify before implementing. Ask before assuming. Technical correctness over social comfort.

## The Response Pattern

1. **READ** — Complete feedback without reacting
2. **UNDERSTAND** — Restate requirement in own words (or ask)
3. **VERIFY** — Check against codebase reality
4. **EVALUATE** — Technically sound for THIS codebase?
5. **RESPOND** — Technical acknowledgment or reasoned pushback
6. **IMPLEMENT** — One item at a time, test each

## Forbidden Responses

**Never:** "You're absolutely right!", "Great point!", "Let me implement that now" (before verification)

**Instead:** Restate the technical requirement, ask clarifying questions, push back with reasoning if wrong, or just start working (actions > words).

## Handling Unclear Feedback

If any item is unclear: STOP. Do not implement anything yet. Ask for clarification on unclear items.

Items may be related. Partial understanding leads to wrong implementation.

## When to Push Back

Push back when:
- Suggestion breaks existing functionality
- Reviewer lacks full context
- Violates YAGNI (unused feature)
- Technically incorrect for this stack
- Conflicts with prior architectural decisions

**How:** Use technical reasoning, not defensiveness. Reference working tests/code. Ask specific questions.

## Acknowledging Correct Feedback

```
GOOD: "Fixed. [Brief description of what changed]"
GOOD: "Good catch — [specific issue]. Fixed in [location]."
GOOD: [Just fix it and show in the code]

BAD:  "You're absolutely right!"
BAD:  "Thanks for catching that!"
```

Actions speak. Just fix it. The code itself shows you heard the feedback.

## Implementation Order

For multi-item feedback:
1. Clarify anything unclear FIRST
2. Then implement: blocking issues → simple fixes → complex fixes
3. Test each fix individually
4. Verify no regressions
