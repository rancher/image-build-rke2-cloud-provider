ARG BCI_IMAGE=registry.suse.com/bci/bci-base
ARG GO_IMAGE=rancher/hardened-build-base:v1.21.9b1

FROM ${GO_IMAGE} as builder
ARG TAG=""
ARG ARCH="amd64"
ARG PKG="github.com/rancher/image-build-rke2-cloud-provider"
RUN set -x && \
    apk --no-cache add \
    file \
    gcc \
    tar \
    git \
    make
COPY . /$GOPATH/src/${PKG}
WORKDIR $GOPATH/src/${PKG}
RUN GO_LDFLAGS="-linkmode=external -X github.com/k3s-io/k3s/pkg/version.Program=rke2" \
    go-build-static.sh -o bin/rke2-cloud-provider
RUN go-assert-static.sh bin/*
RUN if [ "${ARCH}" = "amd64" ]; then \
	    go-assert-boring.sh bin/*; \
    fi
# install (with strip) to /usr/local/bin
RUN install -s bin/* /usr/local/bin
RUN ln -s /usr/local/bin/rke2-cloud-provider /usr/local/bin/cloud-controller-manager

FROM ${BCI_IMAGE} as bci
COPY --from=builder /usr/local/bin /usr/local/bin
