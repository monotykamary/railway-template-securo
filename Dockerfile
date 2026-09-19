FROM ghcr.io/securo-finance/securo-frontend:0.16.0@sha256:16836a8714e32cf8880969ccee5c865b569e923ee2b96fc8c994f1b2597e4bd7

LABEL org.opencontainers.image.source="https://github.com/monotykamary/railway-template-securo"
LABEL org.opencontainers.image.version="0.16.0-securo.1"
LABEL org.opencontainers.image.licenses="AGPL-3.0"

# Railway adapter: the upstream image ships Docker's 127.0.0.11 resolver in
# its nginx template, which does not exist on Railway. Replace only the
# template; the official entrypoint renders it with envsubst at boot using
# BACKEND_URL.
COPY frontend/default.conf.template /etc/nginx/templates/default.conf.template
