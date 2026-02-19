---
name: test-driven-development
description: "Use when implementing any feature or bugfix, before writing implementation code"
---

# Test-Driven Development (TDD)

## Overview

Write the test first. Watch it fail. Write minimal code to pass.

**Core principle:** If you didn't watch the test fail, you don't know if it tests the right thing.

## The Iron Law

```
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST
```

Write code before the test? Delete it. Start over.

**No exceptions:**
- Don't keep it as "reference"
- Don't "adapt" it while writing tests
- Don't look at it
- Delete means delete

## When to Use

**Always:** New features, bug fixes, refactoring, behavior changes.

**Exceptions (ask your human partner):** Throwaway prototypes, generated code, configuration files.

Thinking "skip TDD just this once"? Stop. That's rationalization.

## Red-Green-Refactor

### RED — Write Failing Test

Write one minimal test showing what should happen.

**Requirements:**
- One behavior per test
- Clear name describing behavior
- Real code, not mocks (unless unavoidable)

### Verify RED — Watch It Fail

**MANDATORY. Never skip.**

Run the test. Confirm:
- Test fails (not errors)
- Failure message is expected
- Fails because feature is missing (not typos)

Test passes? You're testing existing behavior. Rewrite the test.

### GREEN — Minimal Code

Write the simplest code that passes the test.

Don't add features, refactor other code, or "improve" beyond what the test requires.

### Verify GREEN — Watch It Pass

**MANDATORY.**

Confirm:
- New test passes
- All other tests still pass
- No errors or warnings in output

### REFACTOR — Clean Up

After green only:
- Remove duplication
- Improve names
- Extract helpers

Keep tests green. Don't add behavior.

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Too simple to test" | Simple code breaks. Test takes 30 seconds. |
| "I'll test after" | Tests passing immediately prove nothing. |
| "Need to explore first" | Fine. Throw away exploration, start with TDD. |
| "TDD will slow me down" | TDD is faster than debugging. |
| "Already manually tested" | Manual testing is ad-hoc. No record, can't re-run. |
| "Existing code has no tests" | You're improving it. Add tests for what you touch. |

## Red Flags — STOP and Start Over

- Code before test
- Test passes immediately
- Can't explain why test failed
- Rationalizing "just this once"
- "Keep as reference"
- "Already spent X hours, deleting is wasteful"

**All of these mean: Delete code. Start over with TDD.**

## Bug Fix Flow

1. Write a test that reproduces the bug
2. Watch it fail (confirms bug exists)
3. Fix the bug with minimal code
4. Watch test pass (confirms fix works)
5. Commit

Never fix bugs without a test.

## Verification Checklist

Before marking work complete:

- [ ] Every new function has a test
- [ ] Watched each test fail before implementing
- [ ] Each test failed for expected reason
- [ ] Wrote minimal code to pass each test
- [ ] All tests pass
- [ ] No errors or warnings in output
- [ ] Edge cases covered
