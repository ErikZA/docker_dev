FROM kong:2.3.2-alpine

USER root

ENV KONG_PLUGINS=bundled,strip-prefix,security-headers,oidc

# Plugins para auth
RUN luarocks install kong-oidc
RUN luarocks install kong-plugin-jwt-keycloak

USER kong
