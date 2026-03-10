# Testing Anti-Patterns Reference

"Test what the code does, not what the mocks do."

## 1. Testing Mock Behavior

**Problem:** Asserting on mock return values instead of real component behavior.

```typescript
// BAD: Testing what the mock returns
const mockDb = { getUser: jest.fn().mockReturnValue({ name: 'Alice' }) };
const result = mockDb.getUser(1);
expect(result.name).toBe('Alice'); // You're testing the mock, not your code

// GOOD: Testing actual behavior using the mock as isolation
const mockDb = { getUser: jest.fn().mockReturnValue({ name: 'Alice' }) };
const greeting = greetUser(mockDb, 1);
expect(greeting).toBe('Hello, Alice!'); // Testing YOUR function's logic
```

**Fix:** Mocks isolate dependencies. Test the code that uses them, not the mocks themselves.

## 2. Test-Only Methods in Production

**Problem:** Adding methods to production classes solely for test cleanup or inspection.

```typescript
// BAD: Production code polluted with test concerns
class UserService {
  resetForTesting() { this.cache.clear(); }  // Only used in tests
  _getInternalState() { return this.state; }  // Exposes internals for tests
}

// GOOD: Test helpers live in test files
// test/helpers/user-service.ts
function clearUserCache(service: UserService) {
  // Use public API or test-specific setup
}
```

**Fix:** Keep test utilities in test helper files. Production code serves production needs.

## 3. Mocking Without Understanding Dependencies

**Problem:** Over-mocking to "be safe" eliminates side effects the test depends on.

```typescript
// BAD: Mocking everything without understanding what matters
jest.mock('./database');
jest.mock('./logger');
jest.mock('./cache');
jest.mock('./events');  // Oops — events trigger the state change we're testing

// GOOD: Mock only what you need to isolate
jest.mock('./database');  // External dependency — mock it
// logger, cache, events — let them run, they're part of the behavior
```

**Fix:** Understand the complete dependency chain before deciding what to mock.

## 4. Incomplete Mocks

**Problem:** Mock objects missing fields that downstream code depends on.

```typescript
// BAD: Partial mock creates false confidence
const mockUser = { id: 1, name: 'Alice' };
// Real user also has: email, role, createdAt, preferences
// Downstream code: user.preferences.theme ?? 'light'  // TypeError in production

// GOOD: Mock the full shape or use a factory
const mockUser = createMockUser({ id: 1, name: 'Alice' });
// Factory fills in all required fields with sensible defaults
```

**Fix:** Mock the complete interface. Use factories for complex objects.

## 5. Tests as Afterthought

**Problem:** Writing implementation first, then bolting on tests that mirror the code.

Tests written after implementation tend to test implementation details rather than behavior. They pass but don't catch regressions because they're coupled to how the code works, not what it does.

**Fix:** Write the test first (TDD). The test defines the behavior; the implementation satisfies it.

## Key Takeaway

Mocks are tools to isolate, not things to test. Following TDD prevents most of these anti-patterns naturally — you can't test mock behavior if you write the test before the mock exists.
