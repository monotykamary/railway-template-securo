FROM ghcr.io/securo-finance/securo-frontend:0.16.5@sha256:f219eb542db83ffd49c9d1a322c5401c52eb81b274fe31243c2bd2b38f714353

LABEL org.opencontainers.image.source="https://github.com/monotykamary/railway-template-securo"
LABEL org.opencontainers.image.version="0.16.5-securo.1"
LABEL org.opencontainers.image.licenses="AGPL-3.0"

# Railway adapter: the upstream image ships Docker's 127.0.0.11 resolver in
# its nginx template, which does not exist on Railway. Replace only the
# template; the official entrypoint renders it with envsubst at boot using
# BACKEND_URL.
COPY frontend/default.conf.template /etc/nginx/templates/default.conf.template
