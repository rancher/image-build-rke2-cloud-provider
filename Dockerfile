ARG GO_IMAGE=rancher/hardened-build-base:v1.26.9b3

# Image that provides cross compilation tooling.
FROM --platform=$BUILDPLATFORM rancher/mirrored-tonistiigi-xx:1.6.1 AS xx

FROM --platform=$BUILDPLATFORM ${GO_IMAGE} AS base-builder
# copy xx scripts to your build stage
COPY --from=xx / /
RUN set -x && \
    apk --no-cache add \
    gawk \
    jq \
    file \
    gcc \
    tar \
    git \
    make \
    clang \
    lld
ARG TARGETPLATFORM
# setup required packages
RUN set -x && \
    xx-apk --no-cache add musl-dev gcc

FROM base-builder AS builder
ARG TAG
ARG K3S_COMMIT
ARG PKG="github.com/rancher/image-build-rke2-cloud-provider"
COPY . /$GOPATH/src/${PKG}
WORKDIR $GOPATH/src/${PKG}
ENV GONOSUMDB=github.com/k3s-io/k3s GONOPROXY=github.com/k3s-io/k3s
ENV GOMODCACHE=/go/pkg/mod GOCACHE=/root/.cache/go-build
# cross-compilation setup
ARG TARGETARCH
RUN --mount=type=cache,id=rke2-cloud-provider-gomod,target=/go/pkg/mod \
    --mount=type=cache,id=rke2-cloud-provider-gobuild-${TARGETARCH},target=/root/.cache/go-build \
    set -e; \
    WORKSPACE="$(./scripts/modsync.sh "${TAG}" "${K3S_COMMIT}")"; \
    cd "${WORKSPACE}"; \
    xx-go --wrap && \
    GO_LDFLAGS="-linkmode=external -X github.com/k3s-io/k3s/pkg/version.Program=rke2 -X github.com/k3s-io/k3s/pkg/version.Version=$(go list -f '{{.Version}}' -m github.com/k3s-io/k3s)" \
      go-build-static.sh -trimpath -o bin/rke2-cloud-provider && \
    go-assert-static.sh bin/rke2-cloud-provider && \
    if [ "${TARGETARCH}" = "amd64" ]; then \
      go-assert-boring.sh bin/rke2-cloud-provider; \
    fi && \
    install bin/rke2-cloud-provider /usr/local/bin

FROM ${GO_IMAGE} AS strip_binary
#strip needs to run on TARGETPLATFORM, not BUILDPLATFORM
COPY --from=builder /usr/local/bin/rke2-cloud-provider /usr/local/bin/rke2-cloud-provider
RUN strip /usr/local/bin/rke2-cloud-provider
RUN ln -s /usr/local/bin/rke2-cloud-provider /usr/local/bin/cloud-controller-manager

FROM scratch
COPY --from=strip_binary /usr/local/bin /usr/local/bin
CMD ["/usr/local/bin/cloud-controller-manager"]
