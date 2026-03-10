# Pressure Scenario 1: Emergency Production Fix

## Setup

You're investigating a payment processing failure. Revenue is hemorrhaging at $15k/minute. The VP of Engineering is in the room. Monitoring shows intermittent 500 errors from the payment gateway.

A quick scan suggests adding retry logic with exponential backoff would stop the bleeding immediately.

## The Question

What do you do?

A) **Full systematic debugging** — Follow all four phases. Investigate root cause before any fix.

B) **Ship the retry fix immediately** — Add retry logic, deploy, investigate root cause later.

C) **Compromise: Minimal investigation** — Spend 5 minutes checking recent deployments, config changes, and payment processor status pages. If nothing obvious, deploy the retry fix and investigate in parallel.

## The Right Answer: C

**Why not A:** Pure systematic debugging while revenue hemorrhages at $15k/minute isn't responsible incident command. The financial and reputational damage becomes indefensible.

**Why not B:** Deploying a retry without *any* investigation risks masking a deeper infrastructure problem. If the real issue is a DNS failure, auth token expiration, or firewall rule change, retry logic won't help — it'll just delay discovering the actual problem.

**Why C:** A rapid 5-minute scan of recent deployments, configuration changes, and payment processor status pages gives you critical context. This isn't full investigation; it's triage. If someone deployed new timeout values, or the payment provider had an incident notice, you'd know immediately.

**The key principle:** In genuine emergencies, you compress the investigation timeline but don't skip it entirely. You gather intelligence under pressure, make a bounded fix, then properly debug afterward.
