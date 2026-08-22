FROM ghcr.io/securo-finance/securo-frontend:0.14.3@sha256:a00e391f3360d3ad25144daf5f91be24298ca557e8ed879354556aebcaf0d3c4

LABEL org.opencontainers.image.source="https://github.com/monotykamary/railway-template-securo"
LABEL org.opencontainers.image.version="0.14.3-securo.1"
LABEL org.opencontainers.image.licenses="AGPL-3.0"

# Railway adapter: the upstream image ships Docker's 127.0.0.11 resolver in
# its nginx template, which does not exist on Railway. Replace only the
# template; the official entrypoint renders it with envsubst at boot using
# BACKEND_URL.
COPY frontend/default.conf.template /etc/nginx/templates/default.conf.template
