---
name: requesting-code-review
description: "Use when completing tasks, implementing major features, or before merging to verify work meets requirements"
---

# Requesting Code Review

Review early, review often. Catch issues before they cascade.

**Core principle:** Self-review catches what you can't see when you're too close to the code.

## When to Request Review

**Mandatory:**
- After each task during `/executing-plans` or `/subagent-driven-development`
- After completing a major feature
- Before merge to main
- After fixing a complex bug

**Optional but valuable:**
- When stuck (fresh perspective)
- Before refactoring (baseline check)

## How to Review

### 1. Get context

```bash
# See what changed
git diff <base-branch>..HEAD

# See commit history
git log <base-branch>..HEAD --oneline

# Get the exact SHA for reference
git rev-parse HEAD
```

Use the SHA when dispatching review to a subagent — it ensures they review the exact state you intended.

### 2. Spec compliance check

Compare implementation against the plan or requirements:

- [ ] Every requirement in the plan is implemented
- [ ] Nothing extra was added that wasn't asked for (YAGNI)
- [ ] File changes match what the plan specified
- [ ] No placeholder / TODO left unresolved

### 3. Code quality check

- [ ] Tests exist for every new function or behavior
- [ ] Tests are real (not testing mocks or obvious stubs)
- [ ] No magic numbers or unexplained constants
- [ ] No unused parameters, dead code, or commented-out blocks
- [ ] Error paths are handled (not silently swallowed)
- [ ] No hardcoded paths, credentials, or environment-specific values

### 4. Test verification

```bash
# Run full test suite — not just the new tests
<your test command>
```

- [ ] All tests pass
- [ ] No new test warnings introduced

### 5. Report

Present findings as:

```
Spec compliance: PASS / FAIL [list gaps]
Code quality: PASS / FAIL [list issues]
Tests: PASS / FAIL [N passing, M failing]
Assessment: Ready to proceed / Needs fixes
```

## SHA-Based Review Dispatch

When dispatching a review to a subagent or separate session:

```
Review the implementation at commit <SHA>.

Compare against the plan in <plan-location>.

Check:
1. Spec compliance — does it match the plan?
2. Code quality — tests, clean code, no dead code?
3. Test results — all passing?

Report findings using the standard format.
```

Using the SHA ensures the reviewer sees exactly what you intended, even if more commits are added later.

## Example Workflow

```
1. Complete task 3 of 5
2. git log main..HEAD --oneline → see 3 commits for task 3
3. git rev-parse HEAD → abc1234
4. Self-review against plan:
   - Spec: ✓ all 4 requirements implemented
   - Quality: ✓ tests real, no dead code
   - Tests: ✓ 47/47 pass
5. Report: "Task 3 complete. Spec ✓, Quality ✓, Tests 47/47. Ready for task 4."
```

## Acting on Findings

- Fix **missing requirements** before proceeding — spec compliance is not optional
- Fix **Critical/Important** quality issues before proceeding
- Note **Minor** issues for later
- Push back if the plan was wrong (with reasoning) — but verify first

## Red Flags

**Never:**
- Skip review because "it's simple"
- Ignore missing requirements
- Proceed with failing tests
- Approve your own work without running the checklist
- Review without checking the actual diff (reading code > assumptions)

**If review reveals plan gaps:**
- Flag to user before implementing workarounds
- Document the gap; don't silently over-build

## Integration with Workflows

**`/executing-plans`:** Review after each batch (3 tasks). Get feedback, apply, continue.

**`/subagent-driven-development`:** Review after each task before moving to next. Use SHA-based dispatch to ensure clean review boundaries.

**Ad-hoc development:** Review before merge to main.

**`/finishing-a-development-branch`:** Final review before presenting merge/PR options.
