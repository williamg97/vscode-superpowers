---
name: verification-before-completion
description: "Use when about to claim work is complete, fixed, or passing — requires running verification commands and confirming output before making any success claims"
---

# Verification Before Completion

## Overview

Claiming work is complete without verification is dishonesty, not efficiency.

**Core principle:** Evidence before claims, always.

## The Iron Law

```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```

If you haven't run the verification command in this message, you cannot claim it passes.

## The Gate

Before claiming any status or expressing satisfaction:

1. **IDENTIFY** — What command proves this claim?
2. **RUN** — Execute the full command (fresh, complete)
3. **READ** — Full output, check exit code, count failures
4. **VERIFY** — Does output confirm the claim?
5. **REPORT** — State claim WITH evidence

Skip any step = lying, not verifying.

## Evidence Requirements

| Claim | Required Evidence | Not Sufficient |
|-------|-------------------|----------------|
| "Tests pass" | Test command output: 0 failures | Previous run, "should pass" |
| "Build succeeds" | Build command: exit 0 | "Linter passed" |
| "Bug fixed" | Reproduction test passes | "Code changed" |
| "Done" | All verification passing | "Looks correct" |

## Red Flags — STOP and Verify

- Using "should", "probably", "seems to"
- Expressing satisfaction before verification ("Done!", "Perfect!")
- About to commit or create PR without fresh test run
- Relying on a previous run instead of current one
- Any wording implying success without having run verification

## Rationalizations

| Excuse | Reality |
|--------|---------|
| "Should work now" | RUN the verification |
| "I'm confident" | Confidence is not evidence |
| "Just this once" | No exceptions |
| "Partial check is enough" | Partial proves nothing |

## The Pattern

```
CORRECT:  [Run tests] → [See: 34/34 pass] → "All 34 tests pass"
WRONG:    "Should pass now" / "Looks correct" / "Done!"
```

Run the command. Read the output. THEN claim the result.

This is non-negotiable.
