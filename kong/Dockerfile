FROM kong:2.3.2-alpine

USER root

ENV KONG_PLUGINS=bundled,strip-prefix,security-headers,oidc

# Plugins para auth
RUN luarocks install kong-oidc
RUN luarocks install kong-plugin-jwt-keycloak

RUN mkdir -p /kong-protos

RUN ls /kong-protos

COPY /kong-protos/ /kong-protos/

RUN ls /kong-protos

USER kong
