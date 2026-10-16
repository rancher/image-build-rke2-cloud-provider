# rancher/image-build-rke2-cloud-provider

This repo is for building the rke2 cloud provider image. It uses a stub go.mod as the entry point for Go modules, with full dependency resolution hanled during the build process.

The resulting image is published to [rancher/rke2-cloud-provider](https://hub.docker.com/r/rancher/rke2-cloud-provider).

## Build v2.0

Image tags select an explicit minor-and-revision pin from [`k3s-sources.json`](./k3s-sources.json). New release tags use the `v1.MINOR-rREVISION-buildYYYYMMDD` form, for example:

```sh
TAG=v1.36-r1-build20261016 make image-build
```

The minor identifies the supported Kubernetes release line. The image revision starts at `r1` and increases for every published image within that minor, including k3s source, dependency, toolchain, or packaging changes. Local builds use the minor's pinned revision and today's build date; set `TAG` explicitly when publishing.

The manifest keeps one object per supported minor with separate `revision` and `commit` fields. UpdateCLI increments the revision and updates the commit together only when the upstream commit changes. The selected source SHA is passed to Docker as `K3S_COMMIT`; **do not** embed a k3s pseudo-version in the image tag. Unknown minors or revisions, malformed tags, and mismatched source SHAs fail before the build.

For local dependency resolution/building, use the same generator as the Docker build:

```sh
make modsync K3S_MINOR=1.36
```

The command produces a generated workspace path under `.cache/modsync/`. Run Go tools from that directory, for example `go test ./...`. Use `sudo make clean` to remove all generated workspace directories; Docker-generated files are owned by root. The tracked root `go.mod` is only bootstrap metadata; do not run `go mod tidy` at the repository root or commit generated module files.

### Updating k3s sources

Whenever a source commit changes, increment the minor's `revision` and replace its `commit` together; never reuse an image tag for a different k3s commit. For dependency, toolchain, or packaging-only releases, increment the revision while retaining the SHA. 

An UpdateCLI workflow runs weekly and updates k3s sources to the latest commit in each `release-<MINOR>` branch automatically.

New minors require new entires in `k3s-sources.json` and in the UpdateCLI `values.yaml`.

## Build (Legacy)

Legacy releases used `v1.MINOR.PATCH-buildYYYYMMDD` to select the matching k3s `v1.MINOR.PATCH+k3s1` tag, or embedded a Go pseudo-version, e.g. `v1.35.9-0.20260915234130-a341ba01f9eb-build20260916`, with the build used that to select k3s source and synchronize dependencies.
