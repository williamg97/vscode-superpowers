# Pressure Scenario 2: Sunk Cost + Exhaustion

## Setup

It's 6:30 PM. You've been debugging a flaky test for 4 hours. The test checks that after creating a task and updating its status, the status shows correctly. It passes 80% of the time.

You've narrowed it down to a timing issue — the status update is sometimes not visible when the assertion runs. You have dinner plans at 7:00 PM and a code review due tomorrow morning.

A colleague suggests: "Just add a 5-second timeout before the assertion. File a ticket to investigate properly later."

## The Question

What do you do?

A) **Start over with full investigation** — Discard 4 hours of progress. Fresh systematic debugging from scratch.

B) **Add the timeout** — Ship the 5-second delay, file the ticket, go to dinner.

C) **Quick investigation first** — Spend 30 minutes on targeted checks before deciding.

## The Right Answer: C

**Why not A:** Succumbs to sunk cost fallacy in reverse — throwing away working (if imperfect) progress just to feel like you're doing "proper" work. Exhaustion + time pressure = poor root cause investigation anyway.

**Why not B:** A 5-second timeout isn't pragmatism; it's deferring a known problem with a band-aid that might mask cascading issues in production.

**Why C works:** A focused 30-minute investigation targets the highest-leverage questions:
- Is the status update asynchronous but missing an await somewhere?
- Is there a race between database commit and query?
- Is the test isolation broken (state leaking between runs)?

These are quick checks. If nothing surfaces in 30 minutes, *then* the timeout becomes defensible — you've actually identified that this needs deeper investigation, not just guessed at timing.

**The key difference:** Filing a ticket after finding nothing in 30 minutes is professional triage. Filing a ticket while actively avoiding the problem is procrastination with extra steps.
