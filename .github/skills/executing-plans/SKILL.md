---
name: executing-plans
description: "Use when you have a written implementation plan to execute in a separate session with review checkpoints"
---

# Executing Plans

## Overview

Load plan, review critically, execute all tasks, report when complete.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

**Note:** Superpowers works much better with access to subagents. If subagents are available, use `/subagent-driven-development` instead of this skill for higher quality output.

## The Process

### Step 1: Set Up Workspace

- **REQUIRED:** Use `/using-git-worktrees` to create an isolated workspace before starting
- Never start implementation on main/master branch without explicit user consent

### Step 2: Load and Review Plan

1. Read plan file
2. Review critically — identify any questions or concerns about the plan
3. If concerns: Raise them with your human partner before starting
4. If no concerns: Proceed to execution

### Step 3: Execute Tasks

For each task:
1. Follow each step exactly (plan has bite-sized steps)
2. Run verifications as specified
3. Commit as specified

### Step 4: Report and Checkpoint

When batch is complete (default: 3 tasks):
- Show what was implemented
- Show verification output
- Say: "Ready for feedback on tasks N-M."

Wait for user feedback before continuing.

### Step 5: Continue

Based on feedback:
- Apply changes if needed
- Execute next batch
- Repeat until all tasks complete

### Step 6: Complete Development

After all tasks complete and verified:
- **REQUIRED:** Use `/finishing-a-development-branch`
- Follow that skill to verify tests, present options, execute choice

## When to Stop and Ask

**STOP executing immediately when:**
- Hit a blocker (missing dependency, test fails, instruction unclear)
- Plan has critical gaps preventing progress
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## Rules

- Follow plan steps exactly
- Don't skip verifications
- Pause between batches — don't run all tasks without checkpoints
- Stop when blocked, don't guess

## Integration

**Required workflow skills:**
- `/using-git-worktrees` — Set up isolated workspace before starting
- `/writing-plans` — Creates the plan this skill executes
- `/finishing-a-development-branch` — Complete development after all tasks
