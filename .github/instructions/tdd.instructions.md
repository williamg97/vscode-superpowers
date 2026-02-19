---
applyTo: "**/*.{ts,tsx,js,jsx,py,go,rs,java,rb,cs,swift,kt}"
---

# Test-Driven Development

When writing or modifying code in this file:

1. **Write the failing test first** — before any implementation code
2. **Run it and watch it fail** — confirm it fails because the feature is missing, not due to syntax errors
3. **Write the minimal code to pass** — no extras, no refactoring, no "while I'm here" improvements
4. **Run tests and confirm green** — all tests pass, not just the new one
5. **Refactor if needed** — clean up while keeping tests green

If you wrote implementation code before a test: stop, delete it, write the test first.

Thinking "skip TDD just this once"? That's rationalization. Write the test.
