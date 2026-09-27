FROM ghcr.io/securo-finance/securo-frontend:0.16.2@sha256:bf77cbbfc696b39d59ccf524ced75a927301eafe51cc5084abf570ee908b1685

LABEL org.opencontainers.image.source="https://github.com/monotykamary/railway-template-securo"
LABEL org.opencontainers.image.version="0.16.0-securo.1"
LABEL org.opencontainers.image.licenses="AGPL-3.0"

# Railway adapter: the upstream image ships Docker's 127.0.0.11 resolver in
# its nginx template, which does not exist on Railway. Replace only the
# template; the official entrypoint renders it with envsubst at boot using
# BACKEND_URL.
COPY frontend/default.conf.template /etc/nginx/templates/default.conf.template
