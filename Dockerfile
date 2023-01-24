# syntax=docker/dockerfile:1.4

FROM alpine:3.16 as build-environment

ARG TARGETARCH
ARG BUILDPLATFORM
WORKDIR /opt

RUN apk add clang lld curl build-base linux-headers git \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh \
    && chmod +x ./rustup.sh \
    && ./rustup.sh -y

# Works around an arm-specific rust bug, see: https://github.com/cross-rs/cross/issues/598
RUN set -ex; [[ "$TARGETARCH" = "arm64" || $(uname -m) = "aarch64" ]] && echo "export CFLAGS=-mno-outline-atomics" >> $HOME/.profile || true

WORKDIR /opt/foundry
COPY . .

# BuildKit seems to provide no official way to detect its presence, so we use BUILDPLATFORM
# as a reasonable proxy: skip BuildKit cache mount directives when not running under BuildKit
RUN if [[ -z "$BUILDPLATFORM" ]] ; then echo Skipping BuildKit directives ; else \
    --mount=type=cache,target=/root/.cargo/registry \
    --mount=type=cache,target=/root/.cargo/git \
    --mount=type=cache,target=/opt/foundry/target; fi  \
    && source $HOME/.profile && cargo build --release \
    && mkdir out \
    && mv target/release/forge out/forge \
    && mv target/release/cast out/cast \
    && mv target/release/anvil out/anvil \
    && strip out/forge \
    && strip out/cast \
    && strip out/anvil;

FROM docker.io/frolvlad/alpine-glibc:alpine-3.16_glibc-2.34 as foundry-client

RUN apk add --no-cache linux-headers git

COPY --from=build-environment /opt/foundry/out/forge /usr/local/bin/forge
COPY --from=build-environment /opt/foundry/out/cast /usr/local/bin/cast
COPY --from=build-environment /opt/foundry/out/anvil /usr/local/bin/anvil

RUN adduser -Du 1000 foundry

ENTRYPOINT ["/bin/sh", "-c"]


LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Foundry" \
      org.label-schema.description="Foundry" \
      org.label-schema.url="https://getfoundry.sh" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/foundry-rs/foundry.git" \
      org.label-schema.vendor="Foundry-rs" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"
