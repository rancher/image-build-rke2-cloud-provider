# rancher/image-build-rke2-cloud-provider

This repo is for building the rke2 cloud provider image. It uses a stub go.mod as the entry point for Go modules, with full dependency resolution hanled during the build process.

The resulting image is published to [rancher/rke2-cloud-provider](https://hub.docker.com/r/rancher/rke2-cloud-provider).

## Build v2.0

Image tags identify the image release; the k3s source commit is selected independently from [`k3s-sources.json`](./k3s-sources.json). New release tags use the `v1.MINOR-rREVISION-buildYYYYMMDD` form, for example:

```sh
TAG=v1.36-r1-build20261016 make image-build
```

The minor identifies the supported Kubernetes release line. The image revision starts at `r1` and increases for every published image within that minor, including k3s source, dependency, toolchain, or packaging changes. Local builds default to `r99` to distinguish them from published releases; set `TAG` explicitly when publishing.

Supported release minor to k3s mapings is defined in `k3s-sources.json`. The selected source SHA is passed to Docker as `K3S_COMMIT`; **do not** embed a k3s pseudo-version in the image tag. Unknown minors, malformed tags, and mismatched source SHAs fail before the build.

For local dependency resolution/building, use the same generator as the Docker build:

```sh
make modsync K3S_MINOR=1.36
```

The command produces a generated workspace path under `.cache/modsync/`. Run Go tools from that directory, for example `go test ./...`. Use `sudo make clean` to remove all generated workspace directories; Docker-generated files are owned by root. The tracked root `go.mod` is only bootstrap metadata; do not run `go mod tidy` at the repository root or commit generated module files.

### Updating k3s sources

Update the entry for a minor in `k3s-sources.json` to a full, immutable 40-character k3s commit SHA. When adding a new supported minor, update both `k3s-sources.json` and the `k3s_minor` matrices in `.github/workflows/build.yml`. 

## Build (Legacy)

Legacy releases used `v1.MINOR.PATCH-buildYYYYMMDD` to select the matching k3s `v1.MINOR.PATCH+k3s1` tag, or embedded a Go pseudo-version, e.g. `v1.35.9-0.20260915234130-a341ba01f9eb-build20260916`, with the build used that to select k3s source and synchronize dependencies.
