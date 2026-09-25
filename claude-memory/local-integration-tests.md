---
name: local-integration-tests
description: "How to run backend integration tests in this workspace without killing the user's dev servers"
metadata:
  node_type: memory
  type: reference
  originSessionId: c74b7058-a9cf-4974-bb7b-d5f6a3966012
  modified: 2026-09-25T18:54:36.293Z
---

The user keeps a dev stack running (API :3010, tests server :3018, mock server :3019, effect worker :34431, all ts-node-dev). Run integration tests against it with `pnpm jest:int --runTestsByPath <file> [-t <name>]` from projects/backend.

Never use `pnpm test` / `scripts/test.sh`: it kills port 3010 (the user's API) and its pm2 workers clash on 34431.

- Local Postgres is on port **5439** (db `shares_db`, user `gitpod`, password in the pgweb container's `--url`), not 5432.
- Logs and errors, including "Async flow error" from flow side effects, are in local OpenSearch at :9200 and can be searched by requestId. Flow side effects run in the tests server process.
- ts-node-dev sometimes reloads mid-edit and keeps half-applied code. If a stack trace doesn't match the file, touch the file or ask the user to restart the servers.
- `completePendingOrders({ producePdf: false })` avoids the pyshares portfolio lambda failing on unusual data.

Related: [[verify-assumptions-in-this-repo]]
