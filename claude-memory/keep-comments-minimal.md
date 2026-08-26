---
name: keep-comments-minimal
description: "Match this repo's near-zero comment density; only comment the non-obvious why, never restate the code"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 75215008-fff8-4644-8d35-4a328274fcdc
  modified: 2026-08-26T13:21:38.757Z
---

Antonio has asked three times across sessions for fewer and shorter comments.
Match the surrounding files, which are almost bare: `lambda/bo_bulk_create/utils/pending_orders_correction.ts`
is 1 comment line in 202, and `routes_b2c/routes_bo/review_requests/change_wealth_manager/handlers.ts`
has none in 103.

**Why:** On 2026-08-24 (collective arbitrage ops action) I wrote JSDoc blocks on
every new service plus inline notes restating what the next line did — a
`LINK` to the script, an explanation that validation runs before insert, a note
that the lambda runs long work. All of it was readable from the code, the file
name, or the function name. He asked again mid-implementation. The 2026-08-20
session had the same correction twice, recorded only as a sub-bullet of
[[prefer-existing-primitives]], which is why it kept recurring.

**How to apply:** Default to no comment. Write one only for a fact the reader
cannot recover from the code: a non-obvious invariant, a deliberate omission and
its reason, or a cross-module constraint (e.g. "the lambda tsconfig cannot
reference scripts/, so the logic lives here"). Never add a JSDoc header that just
restates the signature, and never narrate control flow. If a comment explains
*what*, delete it; if it explains *why not*, keep it short.
See [[record-repeated-corrections]].

**No redundancy across comments.** On 2026-08-26 (filled order corrections for
campaign/VP) I explained the same funding rule — campaign raises one request, a
standalone voluntary payment none, a non-campaign matching contribution the
per-company sweep — in the dispatch function and again in two test headers, plus
comments in e2e specs and a BO column list that only restated the assertion or
column name on the next line. State a shared rule once, at the code that
implements it; each other site gets only what is unique to it, or nothing.

**Never write a comment from the diff's point of view.** "used to call X
unconditionally", "now also handles Y" — the reader has no before-state. Describe
the invariant that holds, not the change being made.
