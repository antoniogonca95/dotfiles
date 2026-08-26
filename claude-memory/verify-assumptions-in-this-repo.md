---
name: verify-assumptions-in-this-repo
description: "Read the actual validator, constraint or gate before asserting behaviour — several confident claims were wrong"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: af143b28-e6cc-4891-a320-e9f4137a07af
  modified: 2026-08-26T14:42:02.455Z
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

**Running one integration test in `projects/backend`** — Antonio's command, use
this shape:

```
pnpm start:wait && pnpm start:test:wait && pnpm jest:int <path/to/file.integration.test.ts> -t '<full test name>'
```

`start:wait` / `start:test:wait` block until the API and tests server are actually
up (`scripts/wait_for_backend.sh`, `wait_for_test_server.sh`), which removes the
staleness guesswork. `jest:int` is the bare integration runner with no baked-in
pattern, so a file path plus `-t` narrows to a single case. The full-lifecycle
option is `pnpm test` (`scripts/test.sh` kills ports 3019/3020/PORT and re-inits).

Do NOT use `pnpm test:integration <pattern>`: its script already ends in
`.*/*.integration.test.ts`, so an extra argument is a *second* pattern and jest
runs every integration suite in the repo — on 2026-08-26 that ran past a 10-minute
timeout for a suite that takes ~10s. And do not hand-roll
`env DOTENV_FLOW_SILENT=true ENVIRONMENT=test TZ=utc pnpm test:runner ...`, which
skips the integration jest config entirely. Read `package.json` before inventing
an invocation.

**Report a failing new test immediately, with its cause.** When a test I just
wrote fails, say so in that turn — concisely: which test, the actual vs expected
result, and my current read of why. Never present a green summary while a new
test is red, and never silently keep retrying.

**If servers look stale, ask Antonio to restart them.** Do not kill, respawn, or
probe processes myself. On 2026-08-26 killing the tests-server worker took down
the API (3010) and the mock server (3019) with it, and I then burned a long
stretch restarting them, recreating `projects/backend/logs/`, and misreading
`/health` responses. Stale servers are a recurring false signal here — the tests
server does not pick up a newly registered `createTestRouter` route without a
restart, and the API can serve an old query after an edit, producing misleading
404s and 200s. Say which server I think is stale and why, then wait.

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
