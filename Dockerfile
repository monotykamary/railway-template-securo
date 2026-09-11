FROM ghcr.io/securo-finance/securo-frontend:0.15.1@sha256:5a0d5a0147dfd74b7a81159cdcb5d5f8816832747335301b073f09454fae7bad

LABEL org.opencontainers.image.source="https://github.com/monotykamary/railway-template-securo"
LABEL org.opencontainers.image.version="0.15.1-securo.1"
LABEL org.opencontainers.image.licenses="AGPL-3.0"

# Railway adapter: the upstream image ships Docker's 127.0.0.11 resolver in
# its nginx template, which does not exist on Railway. Replace only the
# template; the official entrypoint renders it with envsubst at boot using
# BACKEND_URL.
COPY frontend/default.conf.template /etc/nginx/templates/default.conf.template
