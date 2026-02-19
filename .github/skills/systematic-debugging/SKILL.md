---
name: systematic-debugging
description: "Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes"
---

# Systematic Debugging

## Overview

Random fixes waste time and create new bugs. Quick patches mask underlying issues.

**Core principle:** ALWAYS find root cause before attempting fixes. Symptom fixes are failure.

## The Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

If you haven't completed Phase 1, you cannot propose fixes.

## When to Use

Use for ANY technical issue: test failures, bugs, unexpected behavior, performance problems, build failures, integration issues.

**Use this ESPECIALLY when:**
- Under time pressure (emergencies make guessing tempting)
- "Just one quick fix" seems obvious
- You've already tried multiple fixes
- Previous fix didn't work

## The Four Phases

Complete each phase before proceeding to the next.

### Phase 1: Root Cause Investigation

**BEFORE attempting ANY fix:**

1. **Read error messages carefully** — don't skip past errors. Read stack traces completely. Note line numbers, file paths, error codes.

2. **Reproduce consistently** — can you trigger it reliably? What are the exact steps? If not reproducible, gather more data — don't guess.

3. **Check recent changes** — git diff, recent commits, new dependencies, config changes, environmental differences.

4. **Gather evidence in multi-component systems** — before proposing fixes, add diagnostic logging at each component boundary. Run once to see WHERE it breaks. Then investigate that specific component.

5. **Trace data flow** — where does the bad value originate? What called this with the bad value? Keep tracing up until you find the source. Fix at source, not at symptom. See `root-cause-tracing.md` for the complete technique.

### Phase 2: Pattern Analysis

1. **Find working examples** — locate similar working code in the same codebase
2. **Compare against references** — read reference implementations completely, don't skim
3. **Identify differences** — list every difference between working and broken, however small
4. **Understand dependencies** — what components, settings, config, environment does this need?

### Phase 3: Hypothesis and Testing

1. **Form single hypothesis** — "I think X is the root cause because Y." Be specific.
2. **Test minimally** — make the SMALLEST possible change to test hypothesis. One variable at a time.
3. **Verify** — did it work? Yes → Phase 4. No → form NEW hypothesis. Don't stack fixes.

### Phase 4: Implementation

1. **Create failing test case** — simplest possible reproduction. MUST have before fixing.
2. **Implement single fix** — address the root cause. ONE change at a time. No "while I'm here" improvements.
3. **Verify fix** — test passes? No other tests broken? Issue actually resolved?
4. **If 3+ fixes failed** — STOP. This is an architectural problem, not a bug. Question the pattern, don't try fix #4. Discuss with your human partner before continuing.

## Red Flags — STOP and Return to Phase 1

- "Quick fix for now, investigate later"
- "Just try changing X and see if it works"
- "Add multiple changes, run tests"
- Proposing solutions before tracing data flow
- "One more fix attempt" when already tried 2+
- Each fix reveals new problem in different place

## Supporting Techniques

Available in this skill's directory:
- **`root-cause-tracing.md`** — Trace bugs backward through call stack to find original trigger
- **`defense-in-depth.md`** — Add validation at multiple layers after finding root cause
- **`condition-based-waiting.md`** — Replace arbitrary timeouts with condition polling
