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

**Never say:**
- "You're absolutely right!"
- "Great point!"
- "Let me implement that now" (before verification)
- "Thanks for catching that!"
- "Good catch!"

**Instead:**
- Restate the technical requirement
- Ask clarifying questions
- Push back with reasoning if wrong
- Just start working (actions > words)

**Why:** Performative agreement replaces thinking. If you're agreeing before verifying, you're not evaluating — you're performing.

## Handling Unclear Feedback

If any item is unclear: STOP. Do not implement anything yet. Ask for clarification on unclear items.

Items may be related. Partial understanding leads to wrong implementation.

**Good:**
```
"Item 3 says 'handle the edge case' — which edge case specifically?
The timeout case from the bug report, or the empty-input case mentioned in item 1?"
```

**Bad:**
```
"Great feedback! Let me implement all of these right away."
[Proceeds to guess what unclear items mean]
```

**Bad:**
```
"I'll implement the clear items first and ask about the unclear ones later."
[Items were related — partial implementation is wrong]
```

## Source-Specific Handling

### Feedback from user

The user has full context. Their feedback is authoritative on requirements and intent.

Still verify technical claims against the codebase. The user knows WHAT they want; you verify HOW it maps to code.

### Feedback from external reviewer

External reviewers may lack context. Before implementing:
1. Check if feedback applies to THIS codebase (not a general best practice that doesn't fit)
2. Verify claims about how the code works (reviewers sometimes misread code)
3. Check if suggestion conflicts with existing architectural decisions

When external feedback conflicts with codebase reality, say so with evidence.

## YAGNI Check

Before implementing any suggestion, ask:

- Is this needed NOW or "might be useful later"?
- Does this solve a current problem or a hypothetical one?
- Is there a simpler approach that meets the actual requirement?

Reviewers sometimes suggest improvements beyond scope. It's correct to push back with "That's a good idea for a future PR — keeping this one focused on X."

## Implementation Order

For multi-item feedback:
1. Clarify anything unclear FIRST
2. Then implement: blocking issues → simple fixes → complex fixes
3. Test each fix individually
4. Verify no regressions
5. Report what was done (briefly)

## When To Push Back

Push back when:
- Suggestion breaks existing functionality
- Reviewer lacks full context on why code is this way
- Violates YAGNI (adding unused features)
- Technically incorrect for this stack/version
- Conflicts with prior architectural decisions
- Suggestion adds complexity without clear benefit

**How:**
- Use technical reasoning, not defensiveness
- Reference working tests/code as evidence
- Ask specific questions to understand intent
- Propose alternatives if you disagree with approach

**Example:**
```
"The current approach uses a Map instead of an object because we need
non-string keys (see line 42 where we key by Symbol). Switching to a
plain object would break that. Would a different approach to your
concern work — maybe adding a comment explaining the Map choice?"
```

## Acknowledging Correct Feedback

**Good:** "Fixed. Changed retry count from hardcoded 3 to configurable."
**Good:** "The null check was missing — added it with a test."
**Good:** [Just fix it and show the diff]

**Bad:** "You're absolutely right!"
**Bad:** "Thanks for catching that!"
**Bad:** "Great point, I should have thought of that!"

Actions speak. Just fix it. The code itself shows you heard the feedback.

## Gracefully Correcting Wrong Feedback

Sometimes reviewers are incorrect. Handle it professionally:

**Good:**
```
"Checked this — the function actually does handle null on line 34
(early return). The error the reviewer saw might be from the other
code path on line 56, which I've now fixed."
```

**Bad:**
```
"That's wrong. The code already handles null."
```

Show evidence, not just contradiction. Reference specific lines, tests, or docs.

## Common Mistakes

| Mistake | Problem | Fix |
|---------|---------|-----|
| Agree immediately | Skip verification, implement wrong thing | READ → VERIFY → then respond |
| Implement before clarifying | Items are related, partial implementation breaks | Clarify ALL unclear items first |
| Defensive pushback | Reviewer disengages | Use evidence and questions, not "you're wrong" |
| Implement everything | Some suggestions are out of scope | YAGNI check each item |
| Ignore feedback | Reviewer feels unheard | Respond to every item, even if declining |
| Batch all changes | Can't isolate regressions | One fix at a time, test each |

## Real Examples

**Reviewer:** "This should use async/await instead of .then() chains"

**Bad response:**
```
"Great point! Converting everything to async/await now."
[Converts 15 functions, introduces 3 bugs]
```

**Good response:**
```
"The .then() chain in processQueue is intentional — it builds a
sequential promise chain dynamically (line 23-31). The other two
uses in fetchData and saveResult can convert to async/await. Converting
those two now."
```

**Reviewer:** "Add error handling for the API call"

**Bad response:**
```
"You're right! Adding try/catch everywhere."
[Adds try/catch that silently swallows errors]
```

**Good response:**
```
"Added try/catch to the fetchUser call. On failure it now:
1. Logs the error with context (user ID, endpoint)
2. Returns a typed error result (not null)
3. Test added for the failure case"
```

## GitHub Thread Replies

When responding to review comments in a PR thread:

- Reply to the specific comment, not a general response
- Reference the exact change you made
- If declining a suggestion, explain why in the thread so there's a record
- Close resolved threads after implementing

```
Reviewer: "This retry logic should have a backoff"
You: "Added exponential backoff with jitter — starts at 100ms,
caps at 5s. Test added for the backoff timing. See commit abc123."
```

## Integration

**Pairs with:**
- `/requesting-code-review` — How to request reviews that get useful feedback
- `/verification-before-completion` — Verify fixes before claiming done
