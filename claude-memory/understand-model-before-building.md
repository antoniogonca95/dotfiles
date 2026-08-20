---
name: understand-model-before-building
description: Work out what the domain model implies before writing code; do not implement each answer as a local patch
metadata: 
  node_type: memory
  type: feedback
  originSessionId: af143b28-e6cc-4891-a320-e9f4137a07af
  modified: 2026-08-20T17:18:55.766Z
---

When Antonio answers a design question, derive the consequences across the whole
feature before implementing. Implementing each answer as an isolated patch
produced repeated contradictions he had to catch.

**Why:** On the LIMA campaign-edit feature (2026-08-20) I built and then deleted:
an allocation diff/apply service (unnecessary — the existing creation path was
safe), a delta reconciliation service plus a model method (unnecessary — nothing
is funded mid-campaign), a cancel-and-renotify service and a per-row lock (both
contradicted the proportional-recalculation model he had specified), and a guard
for a negative-amount case my own exemption logic created. His verdict:
"you have provided very poor solutions so far".

**How to apply:** Before coding, state what the model implies and check it against
the parts already built. When a new constraint appears, ask "does this contradict
something I already wrote?" — the answer was yes four times. Prefer deleting my
own scaffolding over adding a guard to protect it. See
[[verify-assumptions-in-this-repo]] and [[prefer-existing-primitives]].
