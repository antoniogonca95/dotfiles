---
name: dont-recite-code-back-to-its-author
description: "When analysing existing code as context for new work, report only deltas and constraints — never re-explain the feature to the person who built it"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: b32d701b-7bd5-4c08-94fd-2f81b201bb2f
  modified: 2026-08-27T08:32:43.282Z
---

When asked to analyse an existing feature so I understand a *new* feature that resembles it, the deliverable is only what constrains or differs from the new work: gaps, gotchas, decisions the new work must make. Not a walkthrough of how the existing feature works.

**Why:** Antonio typically wrote the reference feature himself. Reciting its logic back is pure noise and reads as if I think he doesn't know his own code. The analysis request means "get yourself up to speed", not "produce a report on it".

**How to apply:** After exploring a reference implementation, ask "does he already know this?" before writing a line. Ship the touchpoint list, the corrections, the forks in the road. Skip enum values, code quotes and control flow he authored. This extends [[prefer-concise-responses]] — that one is about length, this one is about audience.
