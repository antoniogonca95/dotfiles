---
name: record-repeated-corrections
description: "Write a memory when Antonio corrects the same thing twice or says to avoid something, and mirror it into the dotfiles repo"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: af143b28-e6cc-4891-a320-e9f4137a07af
  modified: 2026-08-20T17:29:36.096Z
---

Antonio wants corrections captured as they happen, not just at the end of a
session. Write or update a memory when he:
- corrects the same kind of mistake more than once,
- says to avoid or stop using something (a pattern, a library, a file location),
- states a preference about how the work should be done.

**Why:** In the 2026-08-20 session he had to repeat several points — trim the
comments (twice), reuse what exists rather than building new services (four
times), don't put logic in `common/types`. Nothing was recorded until he asked at
the end, so the same corrections would have recurred next session.

**How to apply:** Write the memory in the moment, with the concrete example that
prompted it — the specific file or API, not a general principle. Prefer updating
an existing memory over adding a near-duplicate.

**Persisting it:** this workspace is ephemeral, so a memory written here is lost
unless it is also copied to `claude-memory/` in
`~/.config/coderv2/dotfiles` (github.com/antoniogonca95/dotfiles) and committed —
`setup.sh` seeds the memory directory on each new workspace. Always do both, and
add the pointer line to `MEMORY.md`. See [[understand-model-before-building]].
