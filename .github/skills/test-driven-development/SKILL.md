---
name: test-driven-development
description: "Use when implementing any feature or bugfix, before writing implementation code"
---

# Test-Driven Development (TDD)

## Overview

Write the test first. Watch it fail. Write minimal code to pass.

**Core principle:** If you didn't watch the test fail, you don't know if it tests the right thing.

**Violating the letter of the rules is violating the spirit of the rules.**

## When to Use

**Always:**
- New features
- Bug fixes
- Refactoring
- Behavior changes

**Exceptions (ask user):**
- Throwaway prototypes
- Generated code
- Configuration files

Thinking "skip TDD just this once"? Stop. That's rationalization.

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

Implement fresh from tests. Period.

## Red-Green-Refactor

```dot
digraph TDD {
  rankdir=LR;
  node [shape=box, style=rounded];

  RED [label="RED\nWrite Failing Test", color=red, fontcolor=red];
  GREEN [label="GREEN\nMinimal Code to Pass", color=green, fontcolor=green];
  REFACTOR [label="REFACTOR\nClean Up", color=blue, fontcolor=blue];

  RED -> GREEN [label="test fails ✓"];
  GREEN -> REFACTOR [label="test passes ✓"];
  REFACTOR -> RED [label="next behavior"];
}
```

### RED — Write Failing Test

Write one minimal test showing what should happen.

**Good:**
```typescript
test('retries failed operations 3 times', async () => {
  let attempts = 0;
  const operation = () => {
    attempts++;
    if (attempts < 3) throw new Error('fail');
    return 'success';
  };
  const result = await retryOperation(operation);
  expect(result).toBe('success');
  expect(attempts).toBe(3);
});
```
Clear name, tests real behavior, one thing.

**Bad:**
```typescript
test('retry works', async () => {
  const mock = jest.fn()
    .mockRejectedValueOnce(new Error())
    .mockRejectedValueOnce(new Error())
    .mockResolvedValueOnce('success');
  await retryOperation(mock);
  expect(mock).toHaveBeenCalledTimes(3);
});
```
Vague name, tests mock not code.

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
Test errors? Fix the error, re-run until it fails correctly.

### GREEN — Minimal Code

Write the simplest code that passes the test.

**Good:**
```typescript
// Test says: "returns empty array when no items match"
function filterItems(items: Item[], predicate: (i: Item) => boolean): Item[] {
  return items.filter(predicate);
}
```
Minimal. Does exactly what the test requires.

**Bad:**
```typescript
// Test says: "returns empty array when no items match"
function filterItems(items: Item[], predicate: (i: Item) => boolean): Item[] {
  const results = items.filter(predicate);
  this.cache.set(predicate.toString(), results); // not tested
  this.emit('filter', { count: results.length }); // not tested
  return results;
}
```
Added caching and events that no test requires.

Don't add features, refactor other code, or "improve" beyond what the test requires.

### Verify GREEN — Watch It Pass

**MANDATORY.**

Confirm:
- New test passes
- All other tests still pass
- No errors or warnings in output

Test fails? Fix code, not test. Other tests fail? Fix now.

### REFACTOR — Clean Up

After green only:
- Remove duplication
- Improve names
- Extract helpers

Keep tests green. Don't add behavior.

## Good Tests

| Property | Example | Anti-Pattern |
|----------|---------|-------------|
| Tests behavior, not implementation | `expect(result).toBe('success')` | `expect(mock).toHaveBeenCalledWith(...)` |
| One assertion per concept | Test retry count AND result together | 10 unrelated assertions in one test |
| Descriptive name | `'retries 3 times then succeeds'` | `'test1'`, `'it works'` |
| No conditional logic | Straight-line test code | `if/else` in test body |
| Independent | Each test sets up its own state | Tests depend on run order |
| Fast | Milliseconds | Seconds (unless integration test) |

## Why Order Matters

**"I'll write tests after to verify it works"**

Tests written after code pass immediately. Passing immediately proves nothing:
- Might test wrong thing
- Might test implementation, not behavior
- Might miss edge cases you forgot
- You never saw it catch the bug

Test-first forces you to see the test fail, proving it actually tests something.

**"I already manually tested all the edge cases"**

Manual testing is ad-hoc. You think you tested everything but:
- No record of what you tested
- Can't re-run when code changes
- Easy to forget cases under pressure

Automated tests are systematic. They run the same way every time.

**"Tests after achieve the same goals — it's spirit not ritual"**

No. Tests-after answer "What does this do?" Tests-first answer "What should this do?"

Tests-after are biased by your implementation. You test what you built, not what's required. Tests-first force edge case discovery before implementing.

**"TDD is dogmatic, being pragmatic means adapting"**

TDD IS pragmatic:
- Finds bugs before commit (faster than debugging after)
- Prevents regressions (tests catch breaks immediately)
- Documents behavior (tests show how to use code)

"Pragmatic" shortcuts = debugging in production = slower.

**"I need to explore first to understand the problem"**

Fine. Spike and explore. Then:
1. Delete the spike code
2. Start fresh with TDD
3. Do NOT keep the spike as "reference"

Exploration is valid. Keeping exploration code is not.

**"The test is hard to write, so I'll write the code first"**

Hard to test = hard to use. The test is telling you the design needs work.
- Simplify the interface
- Break the dependency
- Inject instead of hardcode

Listen to the test. It's your first user.

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Too simple to test" | Simple code breaks. Test takes 30 seconds. |
| "I'll test after" | Tests passing immediately prove nothing. |
| "Tests after achieve same goals" | Tests-after = "what does this do?" Tests-first = "what should this do?" |
| "Already manually tested" | Ad-hoc ≠ systematic. No record, can't re-run. |
| "Deleting X hours is wasteful" | Sunk cost fallacy. Keeping unverified code is technical debt. |
| "Keep as reference, write tests first" | You'll adapt it. That's testing after. Delete means delete. |
| "Need to explore first" | Fine. Throw away exploration, start with TDD. |
| "Test hard = design unclear" | Listen to the test. Hard to test = hard to use. |
| "TDD will slow me down" | TDD is faster than debugging. Pragmatic = test-first. |
| "Manual test faster" | Manual doesn't prove edge cases. You'll re-test every change. |
| "Existing code has no tests" | You're improving it. Add tests for what you touch. |
| "Just this once won't matter" | Every exception becomes the rule. No exceptions. |
| "It's a prototype" | Did user say prototype? If not, it's production code. Use TDD. |
| "The framework makes TDD hard" | Then mock the framework boundary. Test YOUR code. |

## Red Flags — STOP and Start Over

- Code before test
- Test after implementation
- Test passes immediately
- Can't explain why test failed
- Rationalizing "just this once"
- "I already manually tested it"
- "Tests after achieve the same purpose"
- "It's about spirit not ritual"
- "Keep as reference" or "adapt existing code"
- "Already spent X hours, deleting is wasteful"
- "TDD is dogmatic, I'm being pragmatic"
- "This is different because..."
- Multiple behaviors in one test
- Test names that don't describe behavior
- Mocking the thing you're testing

**All of these mean: Delete code. Start over with TDD.**

## Bug Fix Flow

1. Write a test that reproduces the bug
2. Watch it fail (confirms bug exists)
3. Fix the bug with minimal code
4. Watch test pass (confirms fix works)
5. Run full suite (no regressions)
6. Commit

Never fix bugs without a test.

**Example:**
```
User: "Retry logic fails when first attempt succeeds"

1. Write test: retryOperation with immediately-succeeding operation
2. Run: FAIL — retryOperation always retries at least once ← bug confirmed
3. Fix: Check success before retry loop
4. Run: PASS ← fix confirmed
5. Full suite: All pass ← no regressions
6. Commit
```

## Verification Checklist

Before marking work complete:

- [ ] Every new function has a test
- [ ] Watched each test fail before implementing
- [ ] Each test failed for expected reason (feature missing, not typo)
- [ ] Wrote minimal code to pass each test
- [ ] All tests pass
- [ ] No errors or warnings in output
- [ ] Tests use real code (mocks only if unavoidable)
- [ ] Edge cases and errors covered
- [ ] No test contains conditional logic
- [ ] Each test is independent (no shared mutable state)

Can't check all boxes? You skipped TDD. Start over.

## When Stuck

| Problem | Solution |
|---------|----------|
| Don't know how to test | Write wished-for API. Write assertion first. Ask user. |
| Test too complicated | Design too complicated. Simplify interface. |
| Must mock everything | Code too coupled. Use dependency injection. |
| Test setup huge | Extract helpers. Still complex? Simplify design. |
| Don't know what to test next | Pick the simplest untested behavior. |
| Test intermittently fails | Non-determinism. Fix timing, random data, or shared state. |
| Existing code untestable | Refactor to testable interface first. Add tests for new interface. |

## Debugging Integration

When a test fails unexpectedly during GREEN:
1. Don't guess — use `/systematic-debugging`
2. Read the actual error message completely
3. Trace the failure to root cause
4. Fix the root cause, not the symptom

When a previously passing test breaks:
1. What changed? (`git diff`)
2. Is it your change or a flaky test?
3. Fix immediately — don't proceed with broken tests

## Testing Anti-Patterns

See `docs/testing-anti-patterns.md` for detailed examples of:
- Testing implementation instead of behavior
- Over-mocking (testing mocks, not code)
- Assertion-free tests ("tests" that just run code)
- Flaky tests (timing, ordering, shared state)
- Testing private methods directly

## The Final Rule

When in doubt: **Write the test first.**

Not sometimes. Not usually. Not when convenient.

Always.
