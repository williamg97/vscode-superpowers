---
name: requesting-code-review
description: "Use when completing tasks, implementing major features, or before merging to verify work meets requirements"
---

# Requesting Code Review

## Overview

Review early, review often. Catch issues before they cascade.

## When to Request Review

**Mandatory:**
- After completing a major feature
- Before merge to main
- After fixing a complex bug

**Optional but valuable:**
- When stuck (fresh perspective)
- Before refactoring (baseline check)

## How to Request

1. **Summarize what was implemented** — what you just built and why
2. **Reference the plan or requirements** — what it should do
3. **Show the diff** — `git diff <base>..HEAD`
4. **Run tests** — include test output as evidence

## Acting on Feedback

- Fix **Critical** issues immediately
- Fix **Important** issues before proceeding
- Note **Minor** issues for later
- Push back if reviewer is wrong (with technical reasoning)

## Integration

- During `/executing-plans`: review after each batch (3 tasks)
- Ad-hoc development: review before merge
