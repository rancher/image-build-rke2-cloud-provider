#!/bin/bash

set -euo pipefail

fail() {
  echo "modsync: $*" >&2
  exit 1
}

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
for tool in go jq tar; do
  command -v "${tool}" >/dev/null || fail "required tool not found: ${tool}; use the hardened build base"
done

SELECTION=$(bash "${ROOT}/scripts/source.sh" "${1:-}")
read -r MINOR COMMIT <<<"${SELECTION}"
[[ "${2:-${COMMIT}}" == "${COMMIT}" ]] ||
  fail "K3S_COMMIT does not match the ${MINOR} entry in k3s-sources.json"

export GOWORK=off
WORKSPACE_ROOT="${ROOT}/.cache/modsync"
mkdir -p "${WORKSPACE_ROOT}" ||
  fail "cannot create ${WORKSPACE_ROOT}; if it contains Docker-generated files, run 'sudo make clean' first"
WORKSPACE=$(mktemp -d "${WORKSPACE_ROOT}/${MINOR}.XXXXXX")
tar -C "${ROOT}" \
  --exclude='./.git' --exclude='./.cache' --exclude='./bin' --exclude='./dist' \
  -cf - . | tar -C "${WORKSPACE}" -xf -
cd "${WORKSPACE}"

echo "modsync: resolving ${MINOR} from k3s commit ${COMMIT}" >&2
go mod download -json "github.com/k3s-io/k3s@${COMMIT}" > k3s-module.json
VERSION=$(jq -er '.Version' k3s-module.json)
UPSTREAM_MOD=$(jq -er '.GoMod' k3s-module.json)
go mod edit -json "${UPSTREAM_MOD}" > k3s-go-mod.json
BOOTSTRAP_GO=$(go mod edit -json "${ROOT}/go.mod" | jq -er '.Go')

jq -e --arg minor "${MINOR}" '
  any(.Replace[];
    .Old.Path == "k8s.io/kubernetes" and
    (.New.Version | startswith($minor + ".") or startswith($minor + "-")))
' k3s-go-mod.json >/dev/null ||
  fail "k3s ${COMMIT} does not replace Kubernetes with ${MINOR}"
jq -e '
  all(.Replace[];
    .Old.Path == "github.com/k3s-io/kine" or
    (.New.Version != null and .New.Version != ""))
' k3s-go-mod.json >/dev/null ||
  fail "upstream go.mod contains unsupported local replacements"

cp "${UPSTREAM_MOD}" go.mod
go mod edit -module=github.com/rancher/image-build-rke2-cloud-provider
go mod edit "-go=${BOOTSTRAP_GO}"
go mod edit "-require=github.com/k3s-io/k3s@${VERSION}"
while IFS= read -r replacement; do
  [[ -n "${replacement}" ]] || continue
  go mod edit "-replace=${replacement}"
done < <(jq -r '
  .Replace[] | select(.Old.Path != "github.com/k3s-io/kine") |
  .Old.Path + (if (.Old.Version // "") == "" then "" else "@" + .Old.Version end) +
  "=" + .New.Path + "@" + .New.Version
' k3s-go-mod.json)
go mod edit -dropreplace=github.com/k3s-io/kine
go mod edit -replace=github.com/k3s-io/kine=./third_party/kine
if command -v go-mod-replacer >/dev/null; then
  go-mod-replacer -local ./go-mod-overrides >&2
else
  echo "modsync: warning: go-mod-replacer is unavailable; skipping go-mod-overrides" >&2
fi

go mod edit -json > resolved-go-mod.json
jq -e --arg version "${VERSION}" '
  any(.Require[]; .Path == "github.com/k3s-io/k3s" and .Version == $version) and
  all(.Replace[]; .Old.Path != "github.com/k3s-io/k3s") and
  any(.Replace[];
    .Old.Path == "github.com/k3s-io/kine" and (.Old.Version // "") == "" and
    .New.Path == "./third_party/kine" and (.New.Version // "") == "")
' resolved-go-mod.json >/dev/null ||
  fail "dependency overrides changed the selected k3s source or local kine stub"
jq -e --arg minor "${MINOR}" '
  any(.Replace[];
    .Old.Path == "k8s.io/kubernetes" and
    (.New.Version | startswith($minor + ".") or startswith($minor + "-")))
' resolved-go-mod.json >/dev/null ||
  fail "dependency overrides changed the Kubernetes minor from ${MINOR}"

echo "${WORKSPACE}"
