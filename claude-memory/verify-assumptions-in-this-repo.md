---
name: verify-assumptions-in-this-repo
description: "Read the actual validator, constraint or gate before asserting behaviour — several confident claims were wrong"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: af143b28-e6cc-4891-a320-e9f4137a07af
  modified: 2026-08-20T17:19:06.716Z
---

Do not describe repo behaviour from a plausible reading. Open the validator, the
DB constraint, or the render condition and confirm it.

**Why:** On 2026-08-20 I stated several things confidently and wrongly:
- Called `validateCampaignAllocationBalance` a ceiling check (`used > available`)
  when it requires exact equality — this shaped a whole design discussion.
- Said the allocations file upload could serve as the removal path; it was hidden
  during ongoing edits by `!isOngoingConsultationEdit` on the render gate.
- Missed a DB check constraint tying `late_payment_interests_override_amount` to
  `is_late_payment_interests`, which meant turning interest off returned a 500.
  Only the integration test surfaced it.

**How to apply:** Before claiming a rule exists (or does not), grep for it and read
it. For anything touching money or state transitions, check the DB constraints too
(`pg_get_constraintdef`), not only the TypeScript. Integration tests are worth
writing precisely because they catch what reading misses — write them earlier.
See [[understand-model-before-building]].
