# Deploy and Host Securo on Railway

## About Hosting Securo

Securo is an open-source, self-hosted personal finance manager focused on privacy and ownership of financial data. This template deploys the stable release `0.14.3` with durable PostgreSQL (including pgvector), Redis-backed task queues, and persistent attachment storage.

## Common Use Cases

- Track income, expenses, budgets, goals, and net worth across accounts
- Sync bank transactions via Pluggy, Enable Banking, or SimpleFIN bridges
- Manage portfolios and market assets with daily price refresh
- Automate recurring transactions and FX-rate restamping
- Use passkeys (WebAuthn) and optional TOTP two-factor authentication

## Dependencies for Securo Hosting

### Deployment Dependencies

The template creates six Railway resources: the public `frontend` service, private `backend`, `celery-worker`, and `celery-beat` services, a Redis service, and a PostgreSQL service with a persistent volume. The backend owns a volume for transaction attachments.

### Implementation Details

The `frontend` service owns the public HTTPS domain and serves the React SPA, proxying `/api/*` to `backend` over Railway private networking. The backend runs `alembic upgrade head` in the background while Uvicorn binds its port immediately, so first-boot database migrations never delay startup and the schema is always current. `celery-beat` dispatches recurring jobs (bank syncs, recurring transactions, asset prices, FX rates) to `celery-worker`; both use the same backend image and Redis broker.

Redis runs with `--requirepass` driven by a generated `REDIS_PASSWORD` (its start command is shell-wrapped so the variable expands reliably), and `REDIS_URL` references that same secret across the backend, worker, and beat services.

Generated service variables: `SECRET_KEY`, the Postgres password (`POSTGRES_PASSWORD`), and the Redis password (`REDIS_PASSWORD`). The first administrator is created through the in-app setup flow ("Create admin account") at the public URL.

Do not change cross-service references independently — `DATABASE_URL`, `REDIS_URL`, and `BACKEND_URL` are wired to private service names and generated secrets.

### Why Deploy Securo on Railway?

Railway provides a public HTTPS endpoint, private service networking, durable database volumes, managed Redis, backup schedules, and deliberate source/image versioning in one deployable topology.

## Limitations

- The agents/LLM feature (knowledge base, embeddings, built-in MCP server) requires `AGENTS_ENABLED=true`, per-feature volumes, and LLM provider credentials; it is off by default.
- Object storage (S3) is not implemented upstream; attachment storage uses a Railway volume attached to the backend only.
- Bank sync providers (Pluggy, Enable Banking, SimpleFIN) and OIDC require external credentials supplied in service variables.
- This is the self-hosted community edition of Securo; consult upstream documentation for feature boundaries.
