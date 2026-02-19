---
name: finishing-work
description: "Use when implementation is complete and you need to verify and decide how to integrate the work"
---

# Finishing Work

## Overview

Guide completion of development work: verify tests, present options, execute choice.

## The Process

### Step 1: Verify Tests

Run the project's test suite. If tests fail, stop — fix before proceeding.

### Step 2: Determine Base Branch

Check what branch this work branched from (usually `main` or `master`).

### Step 3: Present Options

Present exactly these options:

```
Implementation complete. What would you like to do?

1. Merge back to <base-branch> locally
2. Push and create a Pull Request
3. Keep the branch as-is (I'll handle it later)
4. Discard this work
```

### Step 4: Execute Choice

**Option 1 — Merge locally:**
- Switch to base branch, pull latest, merge, verify tests on merged result, delete feature branch

**Option 2 — Push and create PR:**
- Push branch, create PR with summary and test plan using `gh pr create`

**Option 3 — Keep as-is:**
- Report branch name, done

**Option 4 — Discard:**
- Confirm with user first (show what will be deleted), then delete branch

## Rules

- Never proceed with failing tests
- Never merge without verifying tests on the result
- Never delete work without explicit confirmation
- Always present exactly 4 options — don't add explanation
