---
name: systematic-debugging
description: "Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes"
---

# Systematic Debugging

## Overview

Random fixes waste time and create new bugs. Quick patches mask underlying issues.

**Core principle:** ALWAYS find root cause before attempting fixes. Symptom fixes are failure.

**Violating the letter of this process is violating the spirit of debugging.**

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
- You don't fully understand the issue

**Don't skip when:**
- Issue seems simple (simple bugs have root causes too)
- You're in a hurry (rushing guarantees rework)

## The Four Phases

Complete each phase before proceeding to the next.

### Phase 1: Root Cause Investigation

**BEFORE attempting ANY fix:**

1. **Read error messages carefully** — don't skip past errors. Read stack traces completely. Note line numbers, file paths, error codes. The error message is evidence — treat it as such.

2. **Reproduce consistently** — can you trigger it reliably? What are the exact steps? If not reproducible, gather more data — don't guess.

3. **Check recent changes** — git diff, recent commits, new dependencies, config changes, environmental differences. What changed between "working" and "broken"?

4. **Gather evidence in multi-component systems** — before proposing fixes, add diagnostic logging at each component boundary. Run once to see WHERE it breaks. Then investigate that specific component.

   **Example: API → Queue → Worker → Database**
   ```
   Add logging at:
   - API: Log request payload and response
   - Queue: Log message enqueue and dequeue
   - Worker: Log message received and processing start/end
   - Database: Log query and result

   Run once. Output shows:
   - API: ✓ sent correct payload
   - Queue: ✓ message enqueued
   - Worker: ✓ message received, ✗ processing failed at step 3
   - Database: (never reached)

   → Root cause is in Worker step 3, not API or Queue
   ```

5. **Trace data flow** — where does the bad value originate? What called this with the bad value? Keep tracing up until you find the source. Fix at source, not at symptom.

   **Technique:**
   - Start at the error
   - Ask: "What value is wrong?"
   - Ask: "Where did that value come from?"
   - Ask: "What produced that value?"
   - Repeat until you find the original source
   - Fix at the source, not at any intermediate point

   See `root-cause-tracing.md` for the complete technique.

### Phase 2: Pattern Analysis

1. **Find working examples** — locate similar working code in the same codebase
2. **Compare against references** — read reference implementations completely, don't skim
3. **Identify differences** — list every difference between working and broken, however small
4. **Understand dependencies** — what components, settings, config, environment does this need?

### Phase 3: Hypothesis and Testing

1. **Form single hypothesis** — "I think X is the root cause because Y." Be specific.
2. **Test minimally** — make the SMALLEST possible change to test hypothesis. One variable at a time.
3. **Verify** — did it work? Yes → Phase 4. No → form NEW hypothesis. Don't stack fixes.
4. **When you don't know** — say "I don't understand X." Don't pretend to know. Ask for help.

### Phase 4: Implementation

1. **Create failing test case** — simplest possible reproduction. MUST have before fixing.
2. **Implement single fix** — address the root cause. ONE change at a time. No "while I'm here" improvements.
3. **Verify fix** — test passes? No other tests broken? Issue actually resolved?
4. **Remove diagnostic code** — clean up any logging/instrumentation added during investigation.
5. **If 3+ fixes failed** — STOP. This is an architectural problem, not a bug. Question the pattern, don't try fix #4. Discuss with user before continuing.

**Pattern indicating architectural problem:**
- Each fix reveals new shared state / coupling / problem in different place
- Fixes require "massive refactoring" to implement
- Each fix creates new symptoms elsewhere
- You're fixing the same kind of bug for the third time

## Red Flags — STOP and Return to Phase 1

- "Quick fix for now, investigate later"
- "Just try changing X and see if it works"
- "Add multiple changes, run tests"
- "Skip the test, I'll manually verify"
- "It's probably X, let me fix that"
- Proposing solutions before tracing data flow
- "One more fix attempt" when already tried 2+
- Each fix reveals new problem in different place

**ALL of these mean: STOP. Return to Phase 1.**

## User Signals You're Doing It Wrong

Watch for these redirections:
- "Is that not happening?" — You assumed without verifying
- "Will it show us...?" — You should have added evidence gathering
- "Stop guessing" — You're proposing fixes without understanding
- "Ultrathink this" — Question fundamentals, not just symptoms
- "Did you actually check?" — You claimed without evidence
- "What does the error say?" — You didn't read the error message

**When you see these:** STOP. Return to Phase 1.

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Issue is simple, don't need process" | Simple issues have root causes too. Process is fast for simple bugs. |
| "Emergency, no time for process" | Systematic debugging is FASTER than guess-and-check thrashing. |
| "Just try this first, then investigate" | First fix sets the pattern. Do it right from the start. |
| "I'll write test after confirming fix works" | Untested fixes don't stick. Test first proves it. |
| "Multiple fixes at once saves time" | Can't isolate what worked. Causes new bugs. |
| "Reference too long, I'll adapt the pattern" | Partial understanding guarantees bugs. Read it completely. |
| "I see the problem, let me fix it" | Seeing symptoms ≠ understanding root cause. |
| "One more fix attempt" (after 2+ failures) | 3+ failures = architectural problem. Question pattern, don't fix again. |
| "I know this codebase well" | Familiarity breeds assumptions. Follow the process anyway. |
| "The fix is obvious" | Obvious fixes that skip investigation cause regressions. |

## Quick Reference

| Phase | Key Activities | Success Criteria |
|-------|----------------|------------------|
| **1. Root Cause** | Read errors, reproduce, check changes, add diagnostics, trace data flow | Understand WHAT and WHY at the source |
| **2. Pattern** | Find working examples, compare, identify differences | Know what's different between working and broken |
| **3. Hypothesis** | Form theory, test minimally, one variable at a time | Confirmed root cause or new hypothesis |
| **4. Implementation** | Create failing test, single fix, verify, clean up diagnostics | Bug resolved, tests pass, no regressions |

## When Process Reveals "No Root Cause"

If systematic investigation reveals issue is truly environmental, timing-dependent, or external:

1. You've completed the process
2. Document what you investigated
3. Implement appropriate handling (retry, timeout, error message)
4. Add logging for future investigation
5. Consider: is this a symptom of a deeper design issue?

**But:** 95% of "no root cause" cases are incomplete investigation. Before concluding "no root cause":
- Did you trace data flow end-to-end?
- Did you add diagnostic logging at every boundary?
- Did you check environmental differences?
- Did you reproduce it consistently?

## Supporting Techniques

Available in this skill's directory:
- **`root-cause-tracing.md`** — Trace bugs backward through call stack to find original trigger
- **`defense-in-depth.md`** — Add validation at multiple layers after finding root cause
- **`condition-based-waiting.md`** — Replace arbitrary timeouts with condition polling
