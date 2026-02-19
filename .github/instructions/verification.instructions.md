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
