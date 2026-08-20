---
name: prefer-existing-primitives
description: "Search for an existing service, model method or predicate before writing a new one; Antonio consistently pushes back on new abstractions"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: af143b28-e6cc-4891-a320-e9f4137a07af
  modified: 2026-08-20T17:19:18.516Z
---

Antonio repeatedly redirected new code toward existing primitives. Search first,
and keep new services small and few.

**Why:** On 2026-08-20 he pointed out, each time correctly, that:
- `allocateEmployees` (the creation path) could be reused instead of a bespoke
  diff/apply service — the delete-and-reinsert was safe because only
  `company_collected_choices` has an FK to allocations, and that table is only
  populated for company-collected campaigns.
- `oddoOrdersModel.updateRecomputedAmounts` already existed, so my
  `setCampaignOrderAmount` was redundant — and since the order row was already
  being queried, fetching `created_at_price` cost nothing.
- Generic operations should be used over raw `connection.query`.
- `common/types` must hold types only; shared logic belongs in `common/bo/`.
- He also asked for fewer and shorter comments, twice.

**How to apply:** Grep `src/models`, `src/services/b2b/campaigns` and `common/bo`
before adding anything. Prefer widening an existing helper's union or params over
a parallel implementation. Keep comments to the non-obvious "why".
See [[shares-backend-constraints]].
