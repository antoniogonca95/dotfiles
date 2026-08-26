---
name: prefer-concise-responses
description: "User wants concise responses, including plans — avoid verbosity"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: b5d3a4d7-8f85-463d-819c-a417667aab5c
  modified: 2026-08-26T09:07:26.410Z
---

Keep responses concise. This applies to plans too, not just answers.

**Why:** The user finds default response length too verbose.

**How to apply:** No preamble or recap. Plans as short bullet lists, not prose sections. State the conclusion first; add detail only if it changes a decision. See [[keep-comments-minimal]].

**Never describe back what existing files contain.** Antonio knows his own codebase — when he points at files, it is so I can understand the change, not so I can summarise them. No file tours, no tables of current behaviour, no quoting existing code. Deliver only the diff-level plan: which lines change and why. Exploration output stays internal; report just its conclusions that alter the plan.

Naming files is context for the task, not a request to explain them. When he does want a file explained he says so explicitly — answer that request as asked.
