---
name: writing-plans
description: "Use when you have a spec, design, or requirements for a multi-step task, before touching code"
---

# Writing Plans

## Overview

Write comprehensive implementation plans assuming the engineer has zero context and questionable taste. Document everything they need to know: which files to touch, complete code, testing approach, exact commands. Break work into bite-sized tasks. DRY. YAGNI. TDD. Frequent commits.

**Save plans to:** `docs/plans/YYYY-MM-DD-<feature-name>.md`

## Bite-Sized Task Granularity

Each step is one action:
- "Write the failing test" — step
- "Run it to make sure it fails" — step
- "Implement the minimal code to make the test pass" — step
- "Run the tests and make sure they pass" — step
- "Commit" — step

## Plan Document Header

Every plan MUST start with:

```markdown
# [Feature Name] Implementation Plan

> **For Copilot:** REQUIRED: Use `/executing-plans` to implement this plan task-by-task.

**Goal:** [One sentence describing what this builds]
**Architecture:** [2-3 sentences about approach]
**Tech Stack:** [Key technologies/libraries]

---
```

## Task Structure

Each task follows this format:

```
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.ext`
- Modify: `exact/path/to/existing.ext`
- Test: `tests/exact/path/to/test.ext`

**Step 1: Write the failing test**
[Complete test code]

**Step 2: Run test to verify it fails**
Run: [exact command]
Expected: FAIL with "[reason]"

**Step 3: Write minimal implementation**
[Complete implementation code]

**Step 4: Run test to verify it passes**
Run: [exact command]
Expected: PASS

**Step 5: Commit**
[exact git commands]
```

## Rules

- Exact file paths always
- Complete code in plan (not "add validation" — show the code)
- Exact commands with expected output
- DRY, YAGNI, TDD, frequent commits
- Each task should be completable independently

## After Writing the Plan

Save the plan to `docs/plans/YYYY-MM-DD-<feature-name>.md` and commit it. Then offer:

```
Plan written to docs/plans/<filename>. Ready to execute?

1. Execute now with `/executing-plans`
2. Review the plan first, then execute
```

The plan file's header already contains the instruction to use `/executing-plans` — so a future Copilot session loading the plan will know how to proceed.
