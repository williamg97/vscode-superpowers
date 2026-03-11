---
name: finishing-a-development-branch
description: "Use when implementation is complete, all tests pass, and you need to decide how to integrate the work - guides completion of development work by presenting structured options for merge, PR, or cleanup"
---

# Finishing a Development Branch

## Overview

Guide completion of development work by presenting clear options and handling chosen workflow.

**Core principle:** Verify tests → Present options → Execute choice → Clean up.

**Announce at start:** "I'm using the finishing-a-development-branch skill to complete this work."

## The Process

### Step 1: Verify Tests

Run the project's test suite.

```bash
# Run whatever test command the project uses
npm test        # or pytest, cargo test, go test ./..., etc.
```

**If tests fail:**
```
Tests failing (<N> failures). Must fix before completing:
[Show failures]
Cannot proceed with merge/PR until tests pass.
```

Stop. Don't proceed to Step 2.

**If tests pass:** Continue to Step 2.

### Step 2: Determine Base Branch

```bash
# Find the base branch
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null
```

Or ask: "This branch split from main — is that correct?"

### Step 3: Present Options

Present exactly these 4 options:

```
Implementation complete. What would you like to do?

1. Merge back to <base-branch> locally
2. Push and create a Pull Request
3. Keep the branch as-is (I'll handle it later)
4. Discard this work

Which option?
```

**Don't add explanation** — keep options concise.

### Step 4: Execute Choice

#### Option 1: Merge Locally

```bash
# Switch to base branch and update
git checkout <base-branch>
git pull

# Merge the feature branch
git merge <feature-branch>

# Verify tests on merged result
<test command>

# Clean up the branch
git branch -d <feature-branch>
```

Then: Cleanup worktree (Step 5)

#### Option 2: Push and Create PR

```bash
# Push feature branch to remote
git push -u origin <feature-branch>

# Create PR with summary
gh pr create --title "<title>" --body "$(cat <<'EOF'
## Summary
<2-3 bullets of what changed>

## Test Plan
- [ ] <verification steps>
EOF
)"
```

Then: Cleanup worktree (Step 5)

#### Option 3: Keep As-Is

Report: "Keeping branch `<name>`. Worktree preserved at `<path>`."

**Don't cleanup worktree.**

#### Option 4: Discard

**Confirm first — require exact word:**
```
This will permanently delete:
- Branch <name>
- All commits: <commit-list>
- Worktree at <path>

Type 'discard' to confirm.
```

Wait for exact confirmation. If confirmed:
```bash
# Switch to base and delete feature branch
git checkout <base-branch>
git branch -D <feature-branch>
```

Then: Cleanup worktree (Step 5)

### Step 5: Cleanup Worktree

**For Options 1, 2, 4 only:**

```bash
# Check if worktree exists
git worktree list | grep $(git rev-parse --abbrev-ref HEAD)

# Remove it
git worktree remove <worktree-path>
```

**For Option 3:** Keep worktree.

## Quick Reference

| Option | Merge | Push | Keep Worktree | Cleanup Branch |
|--------|-------|------|---------------|----------------|
| 1. Merge locally | yes | — | — | yes |
| 2. Create PR | — | yes | yes | — |
| 3. Keep as-is | — | — | yes | — |
| 4. Discard | — | — | — | yes (force) |

## Common Mistakes

**Skipping test verification**
- Problem: Merge broken code, create failing PR
- Fix: Always verify tests before offering options

**No confirmation for discard**
- Problem: Accidentally delete work
- Fix: Require typed "discard" confirmation

**Automatic worktree cleanup for Option 2**
- Problem: Remove worktree while PR is open and might need more work
- Fix: Only cleanup for Options 1 and 4

**Merging without re-testing**
- Problem: Base branch changed since you last tested
- Fix: Always run tests after merge, before deleting branch

**Force-pushing without asking**
- Problem: Overwrite others' work on shared branches
- Fix: Never force-push without explicit user request

## Red Flags

**Never:**
- Proceed with failing tests
- Merge without verifying tests on the merged result
- Delete work without typed "discard" confirmation
- Force-push without explicit request

**Always:**
- Verify tests before offering options
- Present exactly 4 options
- Get typed confirmation for Option 4
- Clean up worktree for Options 1 & 4 only

## Integration

**Called by:**
- `/executing-plans` — After all batches complete
- `/subagent-driven-development` — After all tasks complete

**Pairs with:**
- `/using-git-worktrees` — Cleans up worktree created by that skill
- `/verification-before-completion` — Verify tests before proceeding
