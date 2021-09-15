ARG UBI_IMAGE=registry.access.redhat.com/ubi7/ubi-minimal:latest
ARG GO_IMAGE=rancher/hardened-build-base:v1.16.7b7

FROM ${GO_IMAGE} as builder
ARG TAG=""
ARG PKG="github.com/rancher/image-build-rke2-cloud-provider"
RUN set -x \
 && apk --no-cache add \
    file \
    gcc \
    tar \
    git \
    make
COPY . /$GOPATH/src/${PKG}
WORKDIR $GOPATH/src/${PKG}
RUN GO_LDFLAGS="-linkmode=external -X github.com/rancher/k3s/pkg/version.Program=rke2" \
    go-build-static.sh -o bin/rke2-cloud-provider
RUN go-assert-static.sh bin/*
RUN go-assert-boring.sh bin/*
# install (with strip) to /usr/local/bin
RUN install -s bin/* /usr/local/bin
RUN ln -s /usr/local/bin/rke2-cloud-provider /usr/local/bin/cloud-controller-manager

FROM ${UBI_IMAGE} as ubi
RUN microdnf update -y && \ 
    rm -rf /var/cache/yum

COPY --from=builder /usr/local/bin /usr/local/bin
