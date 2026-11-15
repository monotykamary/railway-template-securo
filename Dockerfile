FROM ghcr.io/securo-finance/securo-frontend:0.18.0@sha256:6a0d726085cf6b67898c3dbb2b53e7949dfeeb8479ec8d45046a5cc0169ead01

LABEL org.opencontainers.image.source="https://github.com/monotykamary/railway-template-securo"
LABEL org.opencontainers.image.version="0.18.0-securo.2"
LABEL org.opencontainers.image.licenses="AGPL-3.0"

# Upstream 0.18 includes 19-resolver.envsh and derives NGINX_RESOLVER from
# the platform's /etc/resolv.conf. Retain its native template and entrypoint.
# The legacy wrapper's hard-coded Railway-only resolver is no longer needed.
