# Copilot Superpowers Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Create a complete set of VS Code Copilot skills, instructions, and agents that adapt the Superpowers workflow system.

**Architecture:** Skills-First — each workflow is a SKILL.md folder under `.github/skills/`, with always-on `copilot-instructions.md` for skill routing and core principles, scoped `.instructions.md` files for TDD and verification, and one read-only planner agent.

**Tech Stack:** Markdown (YAML frontmatter), Bash (install script)

**Design doc:** `docs/plans/2026-02-17-copilot-superpowers-design.md`

---

**Progress:** Done: 0/13 | Left: 13

### Task 1: Project scaffolding

**Files:**
- Create: `.github/skills/` (directory)
- Create: `.github/instructions/` (directory)
- Create: `.github/agents/` (directory)
- Create: `.gitignore`

**Step 1: Create directory structure**

```bash
mkdir -p .github/skills .github/instructions .github/agents
```

**Step 2: Create .gitignore**

Create `.gitignore` with:
```
.DS_Store
*.swp
*~
```

**Step 3: Commit**

```bash
git add .gitignore
git commit -m "scaffold: create project directory structure"
```

---

### Task 2: Always-on instructions (`copilot-instructions.md`)

**Files:**
- Create: `.github/copilot-instructions.md`

**Step 1: Write the instructions file**

Create `.github/copilot-instructions.md` with this content:

```markdown
# Superpowers

You have access to specialized skills in `.github/skills/`. Check if a skill applies before responding to any task.

## Skill Routing

| Situation | Skill |
|-----------|-------|
| Building something new | `/brainstorming` first — design before code |
| Have a design, need a plan | `/writing-plans` — break into bite-sized tasks |
| Have a plan, need to implement | `/executing-plans` — sequential with checkpoints |
| Implementing a feature or bugfix | `/test-driven-development` — test first, always |
| Debugging any issue | `/systematic-debugging` — root cause before fixes |
| About to commit, merge, or claim done | `/verification-before-completion` — evidence before claims |
| Requesting feedback on work | `/requesting-code-review` — review checklist |
| Receiving review feedback | `/receiving-code-review` — verify before implementing |
| Implementation complete | `/finishing-work` — verify tests, present options |

## Core Principles (always active)

- **Evidence before claims:** Don't say "tests pass" without running them. Don't say "done" without verification.
- **TDD:** Write the test first. Watch it fail. Write minimal code to pass. No exceptions.
- **YAGNI:** Only build what's requested. No speculative features, no premature abstraction.
- **Run the program:** Tests passing is necessary but not sufficient. Run the actual program and verify output.
- **Design before code:** Don't write implementation code until a design has been discussed and approved.
- **One thing at a time:** When debugging, change one variable. When implementing, one task. When reviewing, one item.
```

**Step 2: Verify the file renders correctly**

Open the file and confirm the markdown table renders properly and content is concise.

**Step 3: Commit**

```bash
git add .github/copilot-instructions.md
git commit -m "feat: add always-on copilot instructions with skill routing"
```

---

### Task 3: TDD scoped instructions

**Files:**
- Create: `.github/instructions/tdd.instructions.md`

**Step 1: Write the scoped instructions**

Create `.github/instructions/tdd.instructions.md`:

```markdown
---
applyTo: "**/*.{ts,tsx,js,jsx,py,go,rs,java,rb,cs,swift,kt}"
---

# Test-Driven Development

When writing or modifying code in this file:

1. **Write the failing test first** — before any implementation code
2. **Run it and watch it fail** — confirm it fails because the feature is missing, not due to syntax errors
3. **Write the minimal code to pass** — no extras, no refactoring, no "while I'm here" improvements
4. **Run tests and confirm green** — all tests pass, not just the new one
5. **Refactor if needed** — clean up while keeping tests green

If you wrote implementation code before a test: stop, delete it, write the test first.

Thinking "skip TDD just this once"? That's rationalization. Write the test.
```

**Step 2: Commit**

```bash
git add .github/instructions/tdd.instructions.md
git commit -m "feat: add TDD scoped instructions for code files"
```

---

### Task 4: Verification scoped instructions

**Files:**
- Create: `.github/instructions/verification.instructions.md`

**Step 1: Write the scoped instructions**

Create `.github/instructions/verification.instructions.md`:

```markdown
---
applyTo: "**"
---

# Verification

Before claiming any work is complete, fixed, or passing:

1. **Identify** — What command proves this claim?
2. **Run** — Execute the command (fresh, not cached)
3. **Read output** — Check exit code, count failures, read errors
4. **Report with evidence** — State the claim WITH the output that proves it

| Claim | Required Evidence |
|-------|-------------------|
| "Tests pass" | Fresh test run showing 0 failures |
| "Build succeeds" | Build command with exit 0 |
| "Bug fixed" | Reproduction test passes |
| "Done" | All of the above |

If you haven't run the command in this message, you cannot claim the result.
```

**Step 2: Commit**

```bash
git add .github/instructions/verification.instructions.md
git commit -m "feat: add verification scoped instructions"
```

---

### Task 5: Brainstorming skill

**Files:**
- Create: `.github/skills/brainstorming/SKILL.md`

**Step 1: Write the skill**

Create `.github/skills/brainstorming/SKILL.md`:

```markdown
---
name: brainstorming
description: "Use before any creative work — creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements, and design before implementation."
---

# Brainstorming Ideas Into Designs

## Overview

Help turn ideas into fully formed designs through collaborative dialogue.

Start by understanding the current project context, then ask questions one at a time to refine the idea. Once you understand what's being built, present the design and get user approval.

**Do NOT write any code, scaffold any project, or take any implementation action until you have presented a design and the user has approved it.** This applies to every project regardless of perceived simplicity.

## Anti-Pattern: "This Is Too Simple To Need A Design"

Every project goes through this process. A todo list, a single-function utility, a config change — all of them. "Simple" projects are where unexamined assumptions cause the most wasted work. The design can be short (a few sentences for truly simple projects), but you MUST present it and get approval.

## Process

1. **Explore project context** — check files, docs, recent commits
2. **Ask clarifying questions** — one at a time, understand purpose/constraints/success criteria
3. **Propose 2-3 approaches** — with trade-offs and your recommendation
4. **Present design** — in sections scaled to complexity, get user approval after each section
5. **Write design doc** — save to `docs/plans/YYYY-MM-DD-<topic>-design.md` and commit
6. **Transition to implementation** — use `/writing-plans` to create the implementation plan

## Understanding the Idea

- Check out the current project state first (files, docs, recent commits)
- Ask questions one at a time to refine the idea
- Prefer multiple choice questions when possible, but open-ended is fine too
- Only one question per message — if a topic needs more exploration, break it into multiple questions
- Focus on understanding: purpose, constraints, success criteria

## Exploring Approaches

- Propose 2-3 different approaches with trade-offs
- Present options conversationally with your recommendation and reasoning
- Lead with your recommended option and explain why

## Presenting the Design

- Scale each section to its complexity: a few sentences if straightforward, up to 200-300 words if nuanced
- Ask after each section whether it looks right so far
- Cover: architecture, components, data flow, error handling, testing
- Be ready to go back and clarify if something doesn't make sense

## After the Design

- Write the validated design to `docs/plans/YYYY-MM-DD-<topic>-design.md`
- Commit the design document to git
- Use `/writing-plans` to create a detailed implementation plan. That is the ONLY next step.

## Key Principles

- **One question at a time** — don't overwhelm with multiple questions
- **Multiple choice preferred** — easier to answer than open-ended when possible
- **YAGNI ruthlessly** — remove unnecessary features from all designs
- **Explore alternatives** — always propose 2-3 approaches before settling
- **Incremental validation** — present design section by section, get approval before moving on
```

**Step 2: Commit**

```bash
git add .github/skills/brainstorming/SKILL.md
git commit -m "feat: add brainstorming skill"
```

---

### Task 6: Writing-plans skill

**Files:**
- Create: `.github/skills/writing-plans/SKILL.md`

**Step 1: Write the skill**

Create `.github/skills/writing-plans/SKILL.md`:

```markdown
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

```
# [Feature Name] Implementation Plan

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

Save the plan and offer to proceed with `/executing-plans`.
```

**Step 2: Commit**

```bash
git add .github/skills/writing-plans/SKILL.md
git commit -m "feat: add writing-plans skill"
```

---

### Task 7: Executing-plans skill

**Files:**
- Create: `.github/skills/executing-plans/SKILL.md`

**Step 1: Write the skill**

Create `.github/skills/executing-plans/SKILL.md`:

```markdown
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
- Use `/finishing-work` to verify and present completion options

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
```

**Step 2: Commit**

```bash
git add .github/skills/executing-plans/SKILL.md
git commit -m "feat: add executing-plans skill"
```

---

### Task 8: Test-driven-development skill

**Files:**
- Create: `.github/skills/test-driven-development/SKILL.md`

**Step 1: Write the skill**

Create `.github/skills/test-driven-development/SKILL.md`:

```markdown
---
name: test-driven-development
description: "Use when implementing any feature or bugfix, before writing implementation code"
---

# Test-Driven Development (TDD)

## Overview

Write the test first. Watch it fail. Write minimal code to pass.

**Core principle:** If you didn't watch the test fail, you don't know if it tests the right thing.

## The Iron Law

```
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST
```

Write code before the test? Delete it. Start over.

**No exceptions:**
- Don't keep it as "reference"
- Don't "adapt" it while writing tests
- Don't look at it
- Delete means delete

## When to Use

**Always:** New features, bug fixes, refactoring, behavior changes.

**Exceptions (ask your human partner):** Throwaway prototypes, generated code, configuration files.

Thinking "skip TDD just this once"? Stop. That's rationalization.

## Red-Green-Refactor

### RED — Write Failing Test

Write one minimal test showing what should happen.

**Requirements:**
- One behavior per test
- Clear name describing behavior
- Real code, not mocks (unless unavoidable)

### Verify RED — Watch It Fail

**MANDATORY. Never skip.**

Run the test. Confirm:
- Test fails (not errors)
- Failure message is expected
- Fails because feature is missing (not typos)

Test passes? You're testing existing behavior. Rewrite the test.

### GREEN — Minimal Code

Write the simplest code that passes the test.

Don't add features, refactor other code, or "improve" beyond what the test requires.

### Verify GREEN — Watch It Pass

**MANDATORY.**

Confirm:
- New test passes
- All other tests still pass
- No errors or warnings in output

### REFACTOR — Clean Up

After green only:
- Remove duplication
- Improve names
- Extract helpers

Keep tests green. Don't add behavior.

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Too simple to test" | Simple code breaks. Test takes 30 seconds. |
| "I'll test after" | Tests passing immediately prove nothing. |
| "Need to explore first" | Fine. Throw away exploration, start with TDD. |
| "TDD will slow me down" | TDD is faster than debugging. |
| "Already manually tested" | Manual testing is ad-hoc. No record, can't re-run. |
| "Existing code has no tests" | You're improving it. Add tests for what you touch. |

## Red Flags — STOP and Start Over

- Code before test
- Test passes immediately
- Can't explain why test failed
- Rationalizing "just this once"
- "Keep as reference"
- "Already spent X hours, deleting is wasteful"

**All of these mean: Delete code. Start over with TDD.**

## Bug Fix Flow

1. Write a test that reproduces the bug
2. Watch it fail (confirms bug exists)
3. Fix the bug with minimal code
4. Watch test pass (confirms fix works)
5. Commit

Never fix bugs without a test.

## Verification Checklist

Before marking work complete:

- [ ] Every new function has a test
- [ ] Watched each test fail before implementing
- [ ] Each test failed for expected reason
- [ ] Wrote minimal code to pass each test
- [ ] All tests pass
- [ ] No errors or warnings in output
- [ ] Edge cases covered
```

**Step 2: Commit**

```bash
git add .github/skills/test-driven-development/SKILL.md
git commit -m "feat: add test-driven-development skill"
```

---

### Task 9: Systematic-debugging skill

**Files:**
- Create: `.github/skills/systematic-debugging/SKILL.md`
- Create: `.github/skills/systematic-debugging/root-cause-tracing.md`
- Create: `.github/skills/systematic-debugging/defense-in-depth.md`
- Create: `.github/skills/systematic-debugging/condition-based-waiting.md`

**Step 1: Write the main SKILL.md**

Create `.github/skills/systematic-debugging/SKILL.md`:

```markdown
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
```

**Step 2: Write root-cause-tracing.md**

Create `.github/skills/systematic-debugging/root-cause-tracing.md` — adapted from Superpowers version. Same content with Claude-specific tooling references removed. Keep: the tracing process (observe symptom → find immediate cause → ask what called this → keep tracing up → find original trigger), stack trace instrumentation examples, the real-world example, and the key principle diagram description.

**Step 3: Write defense-in-depth.md**

Create `.github/skills/systematic-debugging/defense-in-depth.md` — adapted from Superpowers version. Same content: four-layer validation pattern (entry point, business logic, environment guards, debug instrumentation) with code examples.

**Step 4: Write condition-based-waiting.md**

Create `.github/skills/systematic-debugging/condition-based-waiting.md` — adapted from Superpowers version. Same content: replace arbitrary timeouts with condition polling, generic `waitFor` implementation, quick patterns table.

**Step 5: Commit**

```bash
git add .github/skills/systematic-debugging/
git commit -m "feat: add systematic-debugging skill with supporting techniques"
```

---

### Task 10: Verification-before-completion skill

**Files:**
- Create: `.github/skills/verification-before-completion/SKILL.md`

**Step 1: Write the skill**

Create `.github/skills/verification-before-completion/SKILL.md`:

```markdown
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
```

**Step 2: Commit**

```bash
git add .github/skills/verification-before-completion/SKILL.md
git commit -m "feat: add verification-before-completion skill"
```

---

### Task 11: Requesting-code-review and receiving-code-review skills

**Files:**
- Create: `.github/skills/requesting-code-review/SKILL.md`
- Create: `.github/skills/receiving-code-review/SKILL.md`

**Step 1: Write requesting-code-review**

Create `.github/skills/requesting-code-review/SKILL.md`:

```markdown
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
```

**Step 2: Write receiving-code-review**

Create `.github/skills/receiving-code-review/SKILL.md`:

```markdown
---
name: receiving-code-review
description: "Use when receiving code review feedback — requires technical evaluation, not performative agreement or blind implementation"
---

# Receiving Code Review

## Overview

Code review requires technical evaluation, not emotional performance.

**Core principle:** Verify before implementing. Ask before assuming. Technical correctness over social comfort.

## The Response Pattern

1. **READ** — Complete feedback without reacting
2. **UNDERSTAND** — Restate requirement in own words (or ask)
3. **VERIFY** — Check against codebase reality
4. **EVALUATE** — Technically sound for THIS codebase?
5. **RESPOND** — Technical acknowledgment or reasoned pushback
6. **IMPLEMENT** — One item at a time, test each

## Forbidden Responses

**Never:** "You're absolutely right!", "Great point!", "Let me implement that now" (before verification)

**Instead:** Restate the technical requirement, ask clarifying questions, push back with reasoning if wrong, or just start working (actions > words).

## Handling Unclear Feedback

If any item is unclear: STOP. Do not implement anything yet. Ask for clarification on unclear items.

Items may be related. Partial understanding leads to wrong implementation.

## When to Push Back

Push back when:
- Suggestion breaks existing functionality
- Reviewer lacks full context
- Violates YAGNI (unused feature)
- Technically incorrect for this stack
- Conflicts with prior architectural decisions

**How:** Use technical reasoning, not defensiveness. Reference working tests/code. Ask specific questions.

## Acknowledging Correct Feedback

```
GOOD: "Fixed. [Brief description of what changed]"
GOOD: "Good catch — [specific issue]. Fixed in [location]."
GOOD: [Just fix it and show in the code]

BAD:  "You're absolutely right!"
BAD:  "Thanks for catching that!"
```

Actions speak. Just fix it. The code itself shows you heard the feedback.

## Implementation Order

For multi-item feedback:
1. Clarify anything unclear FIRST
2. Then implement: blocking issues → simple fixes → complex fixes
3. Test each fix individually
4. Verify no regressions
```

**Step 3: Commit**

```bash
git add .github/skills/requesting-code-review/ .github/skills/receiving-code-review/
git commit -m "feat: add code review skills (requesting and receiving)"
```

---

### Task 12: Finishing-work skill and planner agent

**Files:**
- Create: `.github/skills/finishing-work/SKILL.md`
- Create: `.github/agents/planner.agent.md`

**Step 1: Write finishing-work skill**

Create `.github/skills/finishing-work/SKILL.md`:

```markdown
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
```

**Step 2: Write planner agent**

Create `.github/agents/planner.agent.md`:

```markdown
---
name: planner
description: "Read-only planning agent for brainstorming and design — cannot modify files"
tools:
  - search
  - githubRepo
  - fetch
---

# Planner Agent

You are a read-only planning agent. Your job is to explore the codebase, understand requirements, and help design solutions WITHOUT writing any code.

You have access to search, repository browsing, and web fetching — but NO file editing tools.

## When to Use

Switch to `@planner` when:
- Brainstorming a new feature
- Exploring the codebase to understand architecture
- Designing a solution before implementation
- Reviewing existing code for patterns

## Behavior

- Explore thoroughly before recommending
- Propose 2-3 approaches with trade-offs
- Reference specific files and patterns found in the codebase
- Do NOT suggest code changes — suggest what to build, not how to type it
```

**Step 3: Commit**

```bash
git add .github/skills/finishing-work/ .github/agents/planner.agent.md
git commit -m "feat: add finishing-work skill and planner agent"
```

---

### Task 13: Install script and README

**Files:**
- Create: `install.sh`
- Create: `README.md`
- Create: `LICENSE`

**Step 1: Write install.sh**

Create `install.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

# Copilot Superpowers installer
# Usage: ./install.sh /path/to/your/project

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:?Usage: $0 /path/to/target/project}"

if [ ! -d "$TARGET" ]; then
    echo "Error: Target directory does not exist: $TARGET"
    exit 1
fi

TARGET_GITHUB="$TARGET/.github"

# Copy skills, instructions, agents
echo "Installing Copilot Superpowers to $TARGET..."

mkdir -p "$TARGET_GITHUB/skills" "$TARGET_GITHUB/instructions" "$TARGET_GITHUB/agents"

# Copy all skills
for skill_dir in "$SCRIPT_DIR/.github/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    rm -rf "$TARGET_GITHUB/skills/$skill_name"
    cp -r "$skill_dir" "$TARGET_GITHUB/skills/$skill_name"
    echo "  Installed skill: $skill_name"
done

# Copy all instructions
for instr_file in "$SCRIPT_DIR/.github/instructions"/*.instructions.md; do
    cp "$instr_file" "$TARGET_GITHUB/instructions/"
    echo "  Installed instructions: $(basename "$instr_file")"
done

# Copy all agents
for agent_file in "$SCRIPT_DIR/.github/agents"/*.agent.md; do
    cp "$agent_file" "$TARGET_GITHUB/agents/"
    echo "  Installed agent: $(basename "$agent_file")"
done

# Merge copilot-instructions.md
MARKER_START="<!-- copilot-superpowers-start -->"
MARKER_END="<!-- copilot-superpowers-end -->"
SOURCE_INSTRUCTIONS="$SCRIPT_DIR/.github/copilot-instructions.md"
TARGET_INSTRUCTIONS="$TARGET_GITHUB/copilot-instructions.md"

SUPERPOWERS_BLOCK="${MARKER_START}
$(cat "$SOURCE_INSTRUCTIONS")
${MARKER_END}"

if [ -f "$TARGET_INSTRUCTIONS" ]; then
    if grep -q "$MARKER_START" "$TARGET_INSTRUCTIONS"; then
        # Replace existing superpowers section
        # Use perl for reliable multiline replacement
        perl -0777 -i -pe "s/\Q${MARKER_START}\E.*?\Q${MARKER_END}\E/\Q${SUPERPOWERS_BLOCK}\E/s" "$TARGET_INSTRUCTIONS"
        echo "  Updated copilot-instructions.md (replaced existing section)"
    else
        # Append superpowers section
        printf '\n\n%s\n' "$SUPERPOWERS_BLOCK" >> "$TARGET_INSTRUCTIONS"
        echo "  Updated copilot-instructions.md (appended section)"
    fi
else
    echo "$SUPERPOWERS_BLOCK" > "$TARGET_INSTRUCTIONS"
    echo "  Created copilot-instructions.md"
fi

echo ""
echo "Done! Copilot Superpowers installed."
echo ""
echo "Skills installed:"
ls "$TARGET_GITHUB/skills/" | sed 's/^/  - /'
```

**Step 2: Make executable**

```bash
chmod +x install.sh
```

**Step 3: Write README.md**

Create `README.md` with: project description, what's included (list of skills, instructions, agent), installation instructions (clone + run install.sh), the basic workflow (brainstorming → planning → TDD → executing → review → finish), philosophy section, and link to the original Superpowers project.

**Step 4: Write LICENSE**

Create `LICENSE` with MIT license text.

**Step 5: Commit**

```bash
git add install.sh README.md LICENSE
git commit -m "feat: add install script, README, and LICENSE"
```

---

Plan complete and saved to `docs/plans/2026-02-18-copilot-superpowers-implementation.md`.

Two execution options:

1. **Subagent-Driven (this session)** — I dispatch fresh subagent per task, review between tasks, fast iteration
2. **Parallel Session (separate)** — Open new session, batch execution with checkpoints

Which approach?