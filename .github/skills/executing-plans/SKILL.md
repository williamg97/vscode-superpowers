---
name: executing-plans
description: "Use when you have a written implementation plan to execute — works through tasks sequentially with review checkpoints"
---

# Executing Plans

## Overview

Load plan, review critically, execute tasks sequentially, pause for review between batches.

## The Process

### Step 1: Load and Review Plan

1. Read the plan file
2. Review critically — identify any questions or concerns
3. If concerns: raise them before starting
4. If no concerns: proceed to execution

### Step 2: Execute Batch

**Default batch size: 3 tasks**

For each task:
1. Follow each step exactly as written in the plan
2. Run all verification commands specified
3. Commit as specified

### Step 3: Report and Checkpoint

When batch is complete:
- Show what was implemented
- Show verification output
- Say: "Ready for feedback on tasks N-M."

Wait for user feedback before continuing.

### Step 4: Continue

Based on feedback:
- Apply changes if needed
- Execute next batch
- Repeat until all tasks complete

### Step 5: Complete

After all tasks are done:
- Use `/finishing-a-development-branch` to verify and present completion options

## When to Stop and Ask

**Stop executing immediately when:**
- Hit a blocker (missing dependency, unclear instruction, repeated test failure)
- Plan has gaps that prevent progress
- You don't understand an instruction

Ask for clarification rather than guessing.

## Rules

- Follow plan steps exactly
- Don't skip verification commands
- Pause between batches — don't run all tasks without checkpoints
- Stop when blocked, don't guess
- Never start implementation on main/master branch without explicit consent
