ARG GO_IMAGE=rancher/hardened-build-base:v1.21.11b2

# Image that provides cross compilation tooling.
FROM --platform=$BUILDPLATFORM rancher/mirrored-tonistiigi-xx:1.3.0 as xx

FROM --platform=$BUILDPLATFORM ${GO_IMAGE} as base-builder
# copy xx scripts to your build stage
COPY --from=xx / /
RUN set -x && \
    apk --no-cache add \
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

FROM base-builder as builder
ARG TAG=""
ARG PKG="github.com/rancher/image-build-rke2-cloud-provider"
COPY . /$GOPATH/src/${PKG}
WORKDIR $GOPATH/src/${PKG}
RUN go mod download
# cross-compilation setup
ARG TARGETARCH
RUN xx-go --wrap && \
    GO_LDFLAGS="-linkmode=external -X github.com/k3s-io/k3s/pkg/version.Program=rke2" \
    go-build-static.sh -o bin/rke2-cloud-provider
RUN go-assert-static.sh bin/*
RUN if [ "${TARGETARCH}" = "amd64" ]; then \
	    go-assert-boring.sh bin/*; \
    fi
RUN install bin/* /usr/local/bin

FROM ${GO_IMAGE} as strip_binary
#strip needs to run on TARGETPLATFORM, not BUILDPLATFORM
COPY --from=builder /usr/local/bin/rke2-cloud-provider /usr/local/bin/rke2-cloud-provider
RUN strip /usr/local/bin/rke2-cloud-provider
RUN ln -s /usr/local/bin/rke2-cloud-provider /usr/local/bin/cloud-controller-manager



FROM scratch
COPY --from=strip_binary /usr/local/bin /usr/local/bin
