# Pressure Scenario 3: Authority + Social Pressure

## Setup

You're debugging an authentication issue where users occasionally get logged out mid-session. You've started systematic debugging — you're in Phase 1 (Observe), gathering data on when logouts happen.

The tech lead walks over: "Oh, I've seen this before. The middleware is invalidating tokens when it shouldn't. Just add a token refresh in the auth handler. Trust me, I fixed this exact thing at my last company."

Two other team members are watching. The tech lead is respected and senior.

## The Question

What do you do?

A) **Push back and investigate** — Continue systematic debugging. Trace the actual token invalidation path before implementing any fix.

B) **Follow the tech lead's advice** — They're experienced, they've seen this before. Add the token refresh.

C) **Compromise** — Implement the token refresh but also add logging to verify the theory.

## The Right Answer: A

**The systematic debugging skill explicitly requires:** understanding dependencies and middleware implementation fully before proposing fixes. This isn't optional guidance — it's the methodology.

**The core issue:** A bandage fix (token refresh) masks why middleware invalidates tokens in the first place. In 6 months, someone will debug similar symptoms and discover you never solved the actual problem.

**What actually happens in real teams:** Senior engineers appreciate pushback when it's principled. Frame it as "I want to implement this right" not "you're wrong." Something like: "I respect your experience, but I'd like to trace the middleware path first. This takes 30 minutes now or becomes a mystery bug later."

**Why not C:** Logging without investigation is surveillance without action. You'll collect data but have already implemented a fix that masks the signal.

**The social cost is real but acceptable** because:
- A wrong auth fix breaks production for users
- "Trust me" without verification is how security bugs happen
- Tech lead's time pressure doesn't override correctness
- Being "the person who checks things" is actually valuable
