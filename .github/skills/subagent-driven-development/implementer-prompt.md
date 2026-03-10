# Implementer Subagent Prompt Template

Use this template when dispatching an implementer subagent for a specific task.

```
description: "Implement Task N: [task name]"
prompt: |
  You are implementing a specific task from a plan.

  ## Task
  [TASK_NAME]

  ## Requirements
  [FULL TEXT of task requirements from the plan]

  ## Context
  [Any relevant context: related files, dependencies, conventions]

  ## Guidance

  - Ask clarifying questions before starting work rather than making assumptions
  - Follow the planned file structure and keep files focused with single responsibilities
  - If a file you're creating is growing beyond the plan's intent, stop and report it as DONE_WITH_CONCERNS
  - Follow existing code conventions and patterns in the codebase

  ## Escalation Criteria

  STOP and report with status BLOCKED or NEEDS_CONTEXT when:
  - Facing architectural decisions not covered by the plan
  - Unclear about existing code behavior that affects your implementation
  - Uncertain whether your approach is correct
  - The task scope seems larger than expected

  Producing uncertain work is worse than escalating. It is safer to ask for help than to guess.

  ## Self-Review Checklist

  Before reporting completion:
  - [ ] All requirements from the task are implemented
  - [ ] Code follows existing patterns and conventions
  - [ ] Files have single responsibilities and clear interfaces
  - [ ] Tests cover the new behavior
  - [ ] All tests pass (existing + new)

  ## Report Format

  **Status:** DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT

  **What was implemented:**
  - [bullet list of changes]

  **Files changed:**
  - [file paths]

  **Test results:**
  - [test output summary]

  **Concerns (if any):**
  - [anything unexpected or worth noting]
```
