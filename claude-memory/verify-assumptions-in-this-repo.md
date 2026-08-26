---
name: verify-assumptions-in-this-repo
description: "Read the actual validator, constraint or gate before asserting behaviour — several confident claims were wrong"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: af143b28-e6cc-4891-a320-e9f4137a07af
  modified: 2026-08-26T14:19:46.421Z
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

**Two attempts, then ask.** When a fix does not work, try at most twice. If the
second attempt fails, stop and ask for feedback and context — do not keep
iterating, and do not go hunting for evidence that the requirement is impossible.
Say what I tried, what happened, and what I think is blocking.

**Report a failing new test immediately, with its cause.** When a test I just
wrote fails, say so in that turn — concisely: which test, the actual vs expected
result, and my current read of why. State explicitly whether a local server needs
restarting, because stale dev servers are a recurring false signal here: the
tests server (3018) does not pick up a newly registered `createTestRouter` route
without a restart, and the API (3010) can serve an old query after an edit. Both
produced misleading 404s and 200s on 2026-08-26. Never present a green summary
while a new test is red, and never silently keep retrying.

**A failing test I wrote is a signal to stop, not a puzzle to theorise about.**
On 2026-08-26 my new guard test returned 200 instead of 400. Instead of rechecking
my own query I probed the DB, concluded from the data that "no filter can tell
these apart", and proposed reverting the guard and deleting the test. Antonio
pointed out the request supplies the order ids — the discriminator I had removed
from my own `EXISTS` a few edits earlier. The bug was in my code, not the domain.
Suspect my newest change first. Never conclude "this is impossible" from a query
I just wrote.

**Never grep `.env`.** On the same day a broad pattern match over
`projects/backend/.env` dumped SFTP private keys and API tokens into context. Get
config values from the code that reads them, or query through the app's own db
layer (a throwaway script under `src/scripts/`, which is where path aliases
resolve).
