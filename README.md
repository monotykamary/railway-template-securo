# Securo on Railway

A pinned Railway deployment for [Securo](https://github.com/securo-finance/securo), the open-source, self-hosted personal finance manager with bank sync, passkeys, portfolios, and AI agents.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/securo?referralCode=ZqgrJ0)

## What this deploys

- Securo `0.14.3` (pinned: [backend](https://github.com/securo-finance/securo/releases/tag/v0.14.3), [frontend](https://github.com/securo-finance/securo/releases/tag/v0.14.3))
- PostgreSQL 18 with pgvector (Railway's SSL-enabled Postgres image)
- Redis `8-alpine`
- A Railway volume for transaction attachments

The public `frontend` service serves the React SPA and proxies `/api/*` to the `backend` service over Railway private networking. `backend` runs Alembic migrations at startup, then Uvicorn. `celery-worker` and `celery-beat` handle bank-connection syncs, recurring transactions, asset prices, and FX rates.

## First login

Template setup generates a first-time setup flow. Open the public URL, click "Create admin account", and set your administrator credentials. The generated `SECRET_KEY`, database password, and Redis password are in the service variables — keep them safe.

## Important limits

- The agents/LLM feature (knowledge base, embeddings, MCP server) is **off by default**. Enabling `AGENTS_ENABLED=true` requires additional volumes for `/app/data/agent_knowledge` and `/app/data/embedding_models`, plus LLM provider credentials.
- Object storage (S3) is not implemented upstream; attachments live on the Railway volume attached only to `backend`.
- Bank sync (Pluggy, Enable Banking, SimpleFIN) and OIDC login require external provider credentials.
- This template runs the self-hosted community edition; see the upstream [install docs](https://github.com/securo-finance/securo) for details.
- Use Railway backups and the upstream migration procedure for upgrades.

## Version pins

See [`versions.env`](versions.env). Every production image is pinned by version and immutable registry digest; no service uses `latest`.

## Updating

1. Back up PostgreSQL and the attachments volume.
2. Review upstream release and migration notes.
3. Update the application image tags and digests deliberately.
4. Validate admin login, bank-sync, recurring jobs, migrations, persistence, and logs on a disposable Railway project.

## Upstream and license

- Source: https://github.com/securo-finance/securo
- Release: https://github.com/securo-finance/securo/releases/tag/v0.14.3
- License: AGPL-3.0; see [`LICENSE`](LICENSE) and [`NOTICE`](NOTICE)
